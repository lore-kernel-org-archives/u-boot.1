Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E78C4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 18:33:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B7C5877A4;
	Sat,  2 Dec 2023 19:31:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oW517VTt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7993987786; Sat,  2 Dec 2023 19:31:57 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4B3B87796
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 19:31:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40bda47b7c1so9425455e9.1
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 10:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701541909; x=1702146709; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vCbkNIxpuGKpRXF8mBxoDOiuh8OTZfP2FgIs2yjR5kg=;
 b=oW517VTtQGnX7m/ou+rkuhZkQaJIkO1AUZoGwA0d7vb7uaSSQEBwNSzAQ0eMdY4IB2
 NNxZSulJu4MWWtjBSK6aFh2uA0Lxt6AhNorfl8pEepWV72O6YP4vyGeXqocMvqCpWwe1
 2qHUBTOA3FnwpHlIcktVQUC/YGWZIZc6fWJjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701541909; x=1702146709;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vCbkNIxpuGKpRXF8mBxoDOiuh8OTZfP2FgIs2yjR5kg=;
 b=ntTCzoupUB0P0Fco3NIpOjNLuKnQGAaaxPncKJgF34ccvlZdZ368aK+fO5jFQdhhEI
 zOCbcxwIcw4/vcBgPCfDnG8qcKXhmTrRk4DEOLNXtOIlZxus42Q6Vc1yXNWicw05RRif
 CE3VO3YthxB1kky6vr1wRM3wHHY+gUGJ6BoBRObMIVummqSM9LecoB7SXlMTKj653akY
 cN+U+JSbJ/nG77la6MVdqrk3n9k9cAZZC3ig/ot80GkMbEXtWpojv+XR+f0qaToTNvDD
 DWt+Ae183v+6OVWH2ljSFwhtdertYP8rLRYnsYuvVcAb3KZW3u8jaU/4nJyAGMZCR1qF
 Cl4g==
X-Gm-Message-State: AOJu0YyzXM/v10fbf2QjacsxYT+qjLzngC/xbC6lTnh41BilRKjkGCYU
 rtFOpbpeXnj1cLz6WcFMKou1lh5ZDBegLvons9GnBfBwl4tUuI9bEUCCKw==
X-Google-Smtp-Source: AGHT+IHpVMAP4c+K4ntJYNr8yfRWO51cZonNa7LE909Q2SZqnXd9uP+DHWRI8F6yzaUMr4ce8NppZ3X7ebCS7VEBTes=
X-Received: by 2002:a05:600c:1d23:b0:40b:5f03:b3a5 with SMTP id
 l35-20020a05600c1d2300b0040b5f03b3a5mr515773wms.199.1701541909072; Sat, 02
 Dec 2023 10:31:49 -0800 (PST)
MIME-Version: 1.0
References: <20231127195029.90951-1-raymond.mao@linaro.org>
 <20231127195029.90951-9-raymond.mao@linaro.org>
In-Reply-To: <20231127195029.90951-9-raymond.mao@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Dec 2023 11:31:31 -0700
Message-ID: <CAPnjgZ222oeg4m9_eQThZoJ-07sRSESmSK=GDM1t+iCWAEwuTQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/18] bloblist: Change the checksum algorithm
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, 
 Bin Meng <bmeng.cn@gmail.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Nikhil M Jain <n-jain1@ti.com>, Baruch Siach <baruch@tkos.co.il>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michal Simek <michal.simek@amd.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sean Anderson <seanga2@gmail.com>
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

On Mon, 27 Nov 2023 at 12:52, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> From: Simon Glass <sjg@chromium.org>
>
> Use a sinple 8-bit checksum for bloblist, as specified by the spec
> version 0.9
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>  common/bloblist.c  | 14 ++++++++------
>  include/bloblist.h |  5 ++---
>  2 files changed, 10 insertions(+), 9 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
