Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D61E74AC8
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 19:48:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A8C8896E8;
	Tue,  3 Dec 2024 20:47:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ODQcmFfz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A282E896CF; Tue,  3 Dec 2024 20:47:56 +0100 (CET)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B5A8896E8
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 20:47:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7ea9739647bso4253569a12.0
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 11:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733255271; x=1733860071; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3wh5OLqNsSOnIVgyL6JpmS9cDgsWvcLJYQjfqq+/erM=;
 b=ODQcmFfzQaEOUHNsAB4MCxpc9MiXokdLpqW9cWP8Mw3B3TDyyqDRWzOQxJGLHnQI7t
 kj8jagNDGLsNV15XeTvJTdk+QIdUKLpkUXvg/djbyD0KXhtvN98URKE86C02MPjJlQ2A
 VgdGb49tJbj61CsReXXPGj+w4F9KaUlc4QQGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733255271; x=1733860071;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3wh5OLqNsSOnIVgyL6JpmS9cDgsWvcLJYQjfqq+/erM=;
 b=OetC98VhoHGcJi0Qq7mb8VIxLdviNf9IGNadfhEFV7sQa37rH1gHHEE1LeuX6+gY7f
 RhXXIzLiDvG7u1dXn7Hhni5oJ42EhpQkWR6Krb7gQKxJq505+FMolBs1vlCRg+Oujmmd
 ztCvf0J/Z2MPJTOb1RfQvmJyzn2c2GyIwZkH7NTgjNkbRd2afoxKHp/0WweuunxqH73L
 KxWSuLu6CEgLbI/h+uMz6YHC2nOELpDJSJICot8+n7aFOIIaxuJr5xoirlelV24w+NKJ
 VCzRbT8KY2Ia1L2zvGRcCfqDvOPHjzMdxWSDhHrLXtZwpNqs/d5/xKMzLm5ch5rJS27z
 EYkw==
X-Gm-Message-State: AOJu0YybkscvxzqNqrbWJ8UGYBzxUsPLh5BNnjmNHDXQIM9SFPN5DSCD
 GW3lyaZGgQxfxg5BDPUuTtH08FH4dCu0tp3tY5gk299fb0uxNT34XlgfL8J5oy5T+pRIkKMX8Vi
 8xpHsd3AQlH1czZj9uHZIllwlMa8RdbrTSS1zyE5+Yn+zp8Q=
X-Gm-Gg: ASbGncspMCAzJpNhBvqiivdb+7SQMPJo92sDdieCgeZDSDeohYkX79OfwHxBfb/mJIO
 f2CAKgzcpKA3lXdUtlBhfGk0wAY6PnEbs
X-Google-Smtp-Source: AGHT+IFWqYgC1ru3Naylp0tim9DoTa8Vt9VnDx+v+ryZzgBaJko/JPn4inVIt713kbC41h3gkjqud0vbX7DiBh7fndQ=
X-Received: by 2002:a17:90b:380c:b0:2ee:ee5e:42fb with SMTP id
 98e67ed59e1d1-2ef011fba0emr4399392a91.13.1733255271462; Tue, 03 Dec 2024
 11:47:51 -0800 (PST)
MIME-Version: 1.0
References: <20241103003322.626036-1-sjg@chromium.org>
 <20241103003322.626036-2-sjg@chromium.org>
In-Reply-To: <20241103003322.626036-2-sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Dec 2024 12:47:28 -0700
Message-ID: <CAFLszTjhuCcWqK-zaFRA=-D+J4EKdPXCZ_QZ4LVTL7co+OY2dg@mail.gmail.com>
Subject: Re: [PATCH v3 01/25] eb_cpu5282: Drop status-LED code and enable LED
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Jens Scharsig <esw@bus-elektronik.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
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

On Sat, 2 Nov 2024 at 18:34, Simon Glass <sjg@chromium.org> wrote:
>
> Drop this old code. Swtich the LED options to use the new approach, in
> the same commit, to maintain build-bisectability.
>
> Both eb_cpu5282 and eb_cpu5282_internal are done together, since they
> share code.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v3:
> - Update commit message
>
> Changes in v2:
> - Combine code-removal and defconfig changes
>
>  board/BuS/eb_cpu5282/eb_cpu5282.c     | 20 --------------------
>  configs/eb_cpu5282_defconfig          |  8 ++------
>  configs/eb_cpu5282_internal_defconfig |  8 ++------
>  include/configs/eb_cpu5282.h          |  6 ------
>  4 files changed, 4 insertions(+), 38 deletions(-)
>

Applied to ci/master, thanks!
