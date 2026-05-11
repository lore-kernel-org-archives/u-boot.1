Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA855CD37B2
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 15:29:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D97FD8341A;
	Mon, 11 May 2026 17:29:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YBBUsC2a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48CCD8394E; Mon, 11 May 2026 17:29:39 +0200 (CEST)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A2EB81E18
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 17:29:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-c70ea5e9e9dso1818120a12.1
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 08:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778513375; x=1779118175; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Cw3EbGbxvaoqUkEWPKAxVw2x3f6CvrSWZJuaKiYMdWY=;
 b=YBBUsC2aMeQfkYamGFBbz6mgbdVJygaHAfrKaNiQeEFl26xPlJJiqtpSQjpyi3Sih/
 qRRq7zPqYR0cpz55EB4EVJOUiw+iyruTh/bEIG68LFfd/umlW5ssYa1UYKtx44fg3NFG
 1/PKZ9CufN/PSoo+EbsKuUB9QRCV+CPPDEPGyPlKAm9wRMb+93Zil9eHursR8j+s2K3f
 dbSCMXo7n+hsQZiSqQ4PPRO4JrzSaSxh9mnXcRw1ZyUrdIGFWMwmfQph6h/2Cw1ErlAY
 HQaTqu4iV4lVF94kPZ9gC31bHW0/YcMqChdkoKFi1iT7AEC1zkKcuz++MQaC/wZBRY5R
 4KLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778513375; x=1779118175;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Cw3EbGbxvaoqUkEWPKAxVw2x3f6CvrSWZJuaKiYMdWY=;
 b=MgNMyam+FXr5YxW4HzJoUJoQ/ZGJTitds24bNsh0Q4Tdiia6FZmelRZcudt/OC8hLc
 OPK7XD1kzjHEvDNxUQGdzwDJ+iky0xs2uPKu5YN43LI7Jot0q5RXIeAMZ0pIhXD1/5r9
 cw+PMgRBKH+8U0RmDdsDBWdlQTLUt+k5GA1eK4JgO+mQPZRVazlQ1mgaREieKYC8PIdk
 A4QUTmc7Phdmb+3GaP8yeL/6vQSBxfhB9svjhO/osw5x5sfGZ9LRFnvZezBwsiOT4R+e
 a3cEUaFqSnjZqCKECzeAOj93C1V33e9e/EOa2qwLOoWy+oxrupm3TUWkn2pEnMx7rJut
 cGrg==
X-Gm-Message-State: AOJu0YyAkfwCwigylt1QsQ77PMrVn7LKfNMCXNFFMocBxRu+8fRGnPLL
 EOs9spGBwizqauOahettezN0dhl2xv1KriHsbifT9K5zbYvT6hmgEQ6h
X-Gm-Gg: Acq92OFS74kTj4nbE/aY0QHIkPp8s2UCU5XsD28USxf9H6AnM2DKXkF2H5tXAxcVynf
 YMCS3/7z0VCYOOI+F50ySV4bzKjLbDL0ITehh+YRtFl62Ve29wtw1MUrXas6mBEcmYsVmw50By7
 IAUldfXJH8s3hnIrkSVh97URPjeAQt2SfkXzxyLYr8GxiWTJC2213SCi9yzdMK5Rnf6k+PbRw86
 2mR/pYig6RVdMx5JCXNuXMijdFCEGTUMm0wAmVvI9X2Xnj2ERXQ5+pT0hcR3XtDMVp7IyAluY7U
 B+hbp6vtYBcoRjUVJdnAUTrn4JqdaGIILALUzsHasmhs3/g580Hw9yb451MnSrJBWChYKrkEdza
 T9fCorNqfiN83emWxZNe0JGj2GsNx6RekRFFcfHHAmUrY/IgnbvSWUlfb4M1qbax3TJkfryu64S
 kXdkMZkPcTwLCJVm1Dlgq5O1P0vV5DDJfGWA==
X-Received: by 2002:a17:903:182:b0:2ba:d97b:4b95 with SMTP id
 d9443c01a7336-2bad97b4d23mr199093235ad.12.1778513375357; 
 Mon, 11 May 2026 08:29:35 -0700 (PDT)
Received: from google.com ([118.150.148.19]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2baf1ec7d35sm110229185ad.83.2026.05.11.08.29.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 08:29:35 -0700 (PDT)
Date: Mon, 11 May 2026 23:29:32 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de,
 Christian =?iso-8859-1?Q?P=F6tzsch?= <christian.poetzsch@kernkonzept.com>,
 Adam Lackorzynski <adam@l4re.org>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] virtio: Staticize and constify driver ops
Message-ID: <agH13MG3dM49c7Uf@google.com>
References: <20260510171802.56897-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260510171802.56897-1-marek.vasut+renesas@mailbox.org>
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

On Sun, May 10, 2026 at 07:17:53PM +0200, Marek Vasut wrote:
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

FWIW

Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Regards,
Kuan-Wei

> ---
> Cc: "Christian Pötzsch" <christian.poetzsch@kernkonzept.com>
> Cc: Adam Lackorzynski <adam@l4re.org>
> Cc: Bin Meng <bmeng.cn@gmail.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  drivers/virtio/virtio-uclass.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio-uclass.c b/drivers/virtio/virtio-uclass.c
> index c36e9e9b3a7..6e4a3d7a7c1 100644
> --- a/drivers/virtio/virtio-uclass.c
> +++ b/drivers/virtio/virtio-uclass.c
> @@ -400,7 +400,7 @@ UCLASS_DRIVER(virtio) = {
>  	.per_device_auto	= sizeof(struct virtio_dev_priv),
>  };
>  
> -struct bootdev_ops virtio_bootdev_ops = {
> +static const struct bootdev_ops virtio_bootdev_ops = {
>  };
>  
>  static const struct udevice_id virtio_bootdev_ids[] = {
> -- 
> 2.53.0
> 
> 
