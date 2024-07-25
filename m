Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A129C3DA70
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 23:35:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8D1088718;
	Fri, 26 Jul 2024 01:33:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Z35Aq+hb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4B5086FB1; Fri, 26 Jul 2024 01:33:10 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F08088395
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 01:33:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6b796667348so936306d6.0
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 16:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721950386; x=1722555186; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lbni423lS5p0W7DENlciL3sUkcxDFWwv1L+I7Vs0WJU=;
 b=Z35Aq+hbICfTA0MHSKe1PhFeqrrrNtHabZnuD9wxDxM1l18LOkY2L4FfmIbGxjPr98
 actMBxjzWGeYRmfMJcQK9bxZfr3OF7Xn4KoMsPYJ0jjuZwld/fxt8/5TRaihWWeo9Gv3
 AyHDioQcknnRRTkFPRWHZN6wmRAEvbmiBChrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721950386; x=1722555186;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lbni423lS5p0W7DENlciL3sUkcxDFWwv1L+I7Vs0WJU=;
 b=NO60HrUfHpka6zubNAAJ3Oshm3GO0ToN7sdKtO1j4Wx9a7OD5uVe9X7KRWV9NZ9Fyf
 p4RGN49urnLgOQ8WeyWGIhikkFL3O8QXqh7JrXR0/Th/4K+Ek4ZDNTc/QxUwYMIdzMLL
 ZTFc71u3rKBc559zRbsNinttFtoSbu4wsV2jIBm/dZvQXOT8fG7EoCgAQ37ma//1I6gx
 VRIQvxrtXTrJy35QXZY5tZkHh12ximsetK5riOXjmGXZgKnpMlYBV4GOVmSqLAL9Wulk
 p0M15u1soXxTvvczJgQS5F7tMMnQ9SFbYYsIGA+jT7YQQ2xVrZt+RwseXbbcqcDW/v9H
 BOzw==
X-Gm-Message-State: AOJu0YzLxNQBsbZK4UXAU6xY3hOksZgCfTo4ffRtgJ9CkmV1vyeVcL3n
 8OUNlQkxD2wtFc1tT68BWbIwpJnwNZ67UnmdP6lkWfjCBs7K/JXzaguSHJgcAsB/ArojCrWDpu5
 xcTm4qt/l385OQqESM5QfDhdPCzvnRttGX19j
X-Google-Smtp-Source: AGHT+IGmiaXT7wwe4gBiusc0ZJQTrfC+W8pdyxrg3qaa0jkQBUqrQGIyqYsi0MKBmCyOXKxSjZyhxqtGxyXFBhf6ZMw=
X-Received: by 2002:a05:6214:300c:b0:6b5:2bfa:edd5 with SMTP id
 6a1803df08f44-6bb3c95bde7mr84386526d6.17.1721950386461; Thu, 25 Jul 2024
 16:33:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-36-sughosh.ganu@linaro.org>
In-Reply-To: <20240724060224.3071065-36-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jul 2024 17:32:55 -0600
Message-ID: <CAFLszTjwvfatW++1wN-dbNTZj3Us495viSfDzSrcfF1kD1Q3FA@mail.gmail.com>
Subject: Re: [PATCH 35/40] test: lmb: run lmb tests only manually
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, 
 Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Sughosh,

On Wed, 24 Jul 2024 at 00:05, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The LMB code has been changed so that the memory reservations and
> allocations are now persistent and global. With this change, the
> design of the LMB tests needs to be changed accordingly. Mark the LMB
> tests to be run only manually. The tests won't be run as part of the
> unit test suite, but would be invoked through a separate test, and
> thus would not interfere with the running of the rest of the tests.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since rfc: None
>
>  test/lib/lmb.c | 41 ++++++++++++++++++++---------------------
>  1 file changed, 20 insertions(+), 21 deletions(-)
>

If you put the lmb state in a struct it is pretty easy to have the
tests work without all of this.

Regards,
Simon
