Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9426ED16810
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 11:35:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23E8F8431C;
	Fri,  9 Jan 2026 12:35:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Wt7NI2lt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D13D84319; Fri,  9 Jan 2026 12:35:14 +0100 (CET)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DEBD83F56
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 12:35:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-bc17d39ccd2so1833638a12.3
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 03:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767958505; x=1768563305; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4Du2Klw3ZY3Jaw1I9ZymB/JJ0vsgmfbvZpU64EwCT6s=;
 b=Wt7NI2ltXCrvWAuzkiuWtIoFnwwVpSAQIOHpLwdGI/ILfR1PXJ29vhyfBF69/Ibqlk
 ys2n8hxGZocGd8U2my0jIAkxDJxbUCV3KT3XmHyDT6/uF96CTnxI9GiHbC6x/pODrrf2
 21O0eZg2dQ6UVuWOYVy7PE6wkBF6t4DPjsxNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767958505; x=1768563305;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Du2Klw3ZY3Jaw1I9ZymB/JJ0vsgmfbvZpU64EwCT6s=;
 b=tGds8iI5/qiQFXxWiSgMoYTFGjOvn1a+vBzfeqQowWheirYjK0KiHszT0swV4TZftC
 l1ME+0Cb8fFVF4lktG37m8ieAcTc9Ktc306Eqx4AEgeT6dCKeXkoJvXfm9M51Bvb3Wem
 oWVkA5huvW3OVMGoLIZJEveqKTCCw6h1TkV17Qa/R9d74S+lncDvA0+kutakU7niHQjw
 WSrahXGDrxaFNWkb+DBfgatJIcTiAOQSODf9KF3+IIL3lHSpwt8mHJTDD3XUEQn1vVsu
 hyrn+7a3EfQIMP554t7iTfm3+6SrJkay0EWtEyUX3otHBbsyiMin7F0+AKfLfueMwc5g
 zTRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFYjhR5y892uVvYDFwqHbp3PYGHuOqxotvCFkOD4FvdSIOm5jC9Msr7H4vD5EWTfiBdLGkiTY=@lists.denx.de
X-Gm-Message-State: AOJu0YxaYuxFK+/6ns7F1AkYR3DjNuiMdjW4LfEGwhIvRDFO+vgl6xDg
 t+nMWy98n/g3LV966Sk8jQCPO/NI0H6v3x43pKyxEgQGtNkZk8nJozdIDcSO4oDEPix+KtwVGR2
 xSvOddUhj7c+Qm4KgfuHAoyoXOi29gYwPLbMKHuJP
X-Gm-Gg: AY/fxX7haNoGgGIeBt8pU1J+e6x0kLJ+JgAzr0DKSZW5ukosEBBBTOowkJaJh6gS1LM
 nQ2ASCXd1UOKqmffmxooPyO05mEAGl6KkTPg9OlyGdyHVb9D+4q973t0Aaqx8vQ/aBQb5TYxFME
 lsogQ+j//NKXY/fqLmHC5J+XvIOBHB9NgkQXVKBeQelIJyPutjwISlSz9qrWyujxuEMjcxmIrZ7
 VQtJsTyHIazc7nKvCYCIH3QgKxhTBNxNdZ9ikgbU8QgpaOyn9ljRp+wC77yMRrFziU4hw==
X-Google-Smtp-Source: AGHT+IGbx8Cw5x5TqOIyFoZ1/1Xp536YoID1JKbPhMaweaXom1F8YgwNZteLMmmpt39OQMPxk2x+pM28RMwf7rI/pJQ=
X-Received: by 2002:a17:90b:3f50:b0:343:684c:f8ad with SMTP id
 98e67ed59e1d1-34f68b4c5aamr9387272a91.4.1767958505033; Fri, 09 Jan 2026
 03:35:05 -0800 (PST)
MIME-Version: 1.0
References: <20251203-fit-compat-v2-0-0fea56f23809@cherry.de>
 <20251203-fit-compat-v2-1-0fea56f23809@cherry.de>
In-Reply-To: <20251203-fit-compat-v2-1-0fea56f23809@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 9 Jan 2026 04:34:44 -0700
X-Gm-Features: AQt7F2rTWE8AQqH9BiJL9pT3A78CZDoYENjuoZqVu-O5JJCoW1Qe3qOvqjX6H_o
Message-ID: <CAFLszTgSmU=kyO3SBn+EqBfK0NsA1AkYCPYpRjjTLrVo3XWz9w@mail.gmail.com>
Subject: Re: [PATCH next v2 1/4] boot/fit: use constants for property strings
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, Jonas Karlman <jonas@kwiboo.se>,
 u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Shiji Yang <yangshiji66@outlook.com>, 
 Anton Moryakov <ant.v.moryakov@gmail.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

On Wed, 3 Dec 2025 at 09:19, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> Some properties have their string represented in include/image.h via
> constants, so let's use those constants instead of using a hardcoded
> string.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  boot/common_fit.c | 4 ++--
>  boot/image-fit.c  | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>

Reviewed-by: Simon Glass <simon.glass@canonical.com>
