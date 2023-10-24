Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A24EC00A8F
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 18:06:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A66BF879C3;
	Tue, 24 Oct 2023 20:04:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="Ey3+xigL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04152879B2; Tue, 24 Oct 2023 20:04:28 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48B74879AC
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 20:04:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5a7af20c488so48598947b3.1
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 11:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1698170659; x=1698775459; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Jphv2Hs5mT33hMLLYL04TgnukSKQEqaaw0xze9hUHek=;
 b=Ey3+xigLNIHEQTgoTWi1ZaXp6NnqoJZ7dVS9Rq3erTglDiHWdJaQHULc+NNFJ8/YXW
 cAB9G/mAViJIMKFK0NyPUEPdv1VgP7oVw9mquE0hmZIPXUnmp8bIEMafPaA/N37GSKD8
 vL1viFA5Da4pcobD6U5ohWfuMKmWzpzbbQGBIt4CKQNLA8OqKcr4DQdN/hQwqokjOdOe
 Aawlje2ZeFRFkWZ+LzpBzSi5CSrqUzff5KxXkRaNbcX/ND6pAHlOy9NbY/udNQnft+K3
 IG2IKsCKAhhA/DeDGigB8P+FX8jjf+wpzTMqkdCuSThgjvmo8T9eIj13eC1pBIml53nW
 Boxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698170659; x=1698775459;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jphv2Hs5mT33hMLLYL04TgnukSKQEqaaw0xze9hUHek=;
 b=RqoQPsZpg9jmmXxQYjWuMAXPA5wmDLudI+yynk6OyU0Liv80chxIkgxvRXUZ33YGVn
 caxP2t5vtmLDELR2bseuo1zMPFFJTcFCaW1A00Y0lmI4mkqkjtEsn4pUjMfsqVQl12xo
 CaPogkzF8dc7ibpRZs/kU29nR0Trc4Yzn9ZFqqpFTDtM53qCDU59uPwN+b4BWQ5Dec3w
 z2TsRQR6qh+CGYM7ULz9gaxij5ioBqxhWzbGy5Z9hfsmRJ2lpr7Laro5Rbh/ypCGAkka
 n2Gy6eaBNIVqscOig9rjo3cWnK11rur8mK1nPIIFmzgB1i+zlGV/x0MpRYVtYP7WOv46
 9rjw==
X-Gm-Message-State: AOJu0YwVmkMGtaVnZOzsTbSFp0l1nrxlVCV7kal/krZ5L535iSgBkekQ
 jesfHceLmKm23tYR6AWge5t1N7g7qLXc17YXffJmleiYehtaHq7z87UrciFi
X-Google-Smtp-Source: AGHT+IFgFesg1M0u0ID8EUygVtmrn1Hd//PFz+e3pyGcmX6med61rYihowGN2QuUStGg54tt7qmjtbBXgc7tQ2656J4=
X-Received: by 2002:a81:480c:0:b0:5a9:117d:ddbc with SMTP id
 v12-20020a81480c000000b005a9117dddbcmr10326389ywa.15.1698170659011; Tue, 24
 Oct 2023 11:04:19 -0700 (PDT)
MIME-Version: 1.0
References: <20231024072638.39798-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231024072638.39798-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@google.com>
Date: Tue, 24 Oct 2023 11:03:19 -0700
Message-ID: <CAPnjgZ0ZV_C73q1v6D9jEUCF-3aJMRRzvDhpOAoP-PuH7_X0Mg@mail.gmail.com>
Subject: Re: [PATCH 1/1] tools: mkimage: fix sfspl_image_extract_subimage()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Yanhong Wang <yanhong.wang@starfivetech.com>, u-boot@lists.denx.de
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

On Tue, 24 Oct 2023 at 00:26, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Do not leak file descriptor if writing fails.
> Correct the error text if opening a file fails.
>
> Addresses-Coverity-ID: 467054 Resource leaks
> Fixes: 64fd30d367a1 ("tools: mkimage: Add StarFive SPL image support")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  tools/sfspl.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
