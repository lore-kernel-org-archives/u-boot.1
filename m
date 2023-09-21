Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11537E70717
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 11:33:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89C9B86457;
	Thu, 21 Sep 2023 13:33:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="E/ypNAlC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2610686459; Thu, 21 Sep 2023 13:33:48 +0200 (CEST)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE3FD8644E
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 13:33:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-27489f78e52so542170a91.1
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 04:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1695296024; x=1695900824; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:user-agent:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=QeHxrwsYW5qeHuguSxzlReYYihcYpl550F3r+e7dNeY=;
 b=E/ypNAlCVRnq+21ag2LblTtAh2CUDcRJEhE2Tsvm/cQ9AN2k43Q3pZD/sw1dE/+owE
 qtY43keNzChigv8hpn6Yrw7ODtoGfBRvoUU7onWy8Hljvx/ll+0+qpK4JxOF9wgukrGe
 IRV5TSzMMx33DGNRjLB+azAQjJJia/Qrx17FX1orjiECLaHGYjQkL5r6+WYgQUxaAfWW
 2z3AOnwqrLQ7uAkYBDd8dGacy5rMIscc0d7mqcxQ/VG8OMc7iQnz/XoT7FPQYas2Xlr0
 oVc6rarLvxpXBz+BgtTTbFk/GGwOsP03TSYU7A6/KaJpE2dVcQ+lPls0DhWV9DEmdFZO
 p+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695296024; x=1695900824;
 h=content-transfer-encoding:mime-version:user-agent:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QeHxrwsYW5qeHuguSxzlReYYihcYpl550F3r+e7dNeY=;
 b=lIpDtq28ARVJOCK580csYZgLcMisH17Kytnc93oVeDlO5iPWLHB67cyRcqGUJcKWA5
 lWSdQCjfv1nC+qhFaVU6aM1EZIwnqdtstTFdoy8tn2EdcWQqTQh2nUps6kx86a8EzKEc
 swErJ9pYsw9dkxX3IDQHHQHVfMSUqHqhcGxfkrZ00hTVeMPrKEX3EwVN5CXlrU4q2Ys4
 X/bc7eJCCNYW09yB4PshnSbO3QdhxRDj6UG4lrwxY5kICNxaTjn+8bmQpHQDgILcu2uB
 6m41p4g4xN8FrFfts7MBY6waXgv0x4YbdcxDL6S2vx1wodF2TgDJjG2gmUWwUqYEHV2z
 Qg5g==
X-Gm-Message-State: AOJu0YywQDOLNfangnr1L3FU+IV2O1cgYjMy1vjplqIyJNw+GL41Yrpc
 Hs96laWzC1+vrEENKD+qFV+Gwg==
X-Google-Smtp-Source: AGHT+IFc0r7TGk+MBznk5sqn1KJyaajweqKH5qq6A9GemVXXltKXiUZwoEDTws78z/RBSpDYKZmecA==
X-Received: by 2002:a17:90b:60f:b0:271:9237:a07f with SMTP id
 gb15-20020a17090b060f00b002719237a07fmr5446927pjb.32.1695296023985; 
 Thu, 21 Sep 2023 04:33:43 -0700 (PDT)
Received: from ThinkPad-T490 ([2401:4900:5603:8473:c4d2:90e3:b3d0:fe96])
 by smtp.gmail.com with ESMTPSA id
 s1-20020a17090a074100b00256799877ffsm1239252pje.47.2023.09.21.04.33.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 04:33:43 -0700 (PDT)
Message-ID: <06ea71aab661cf0535bcef98dad2aba61d1884f1.camel@ventanamicro.com>
Subject: Re: [PATCH v1 2/2] spl: Add support for booting from ESP
From: mchitale@ventanamicro.com
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>, Sean Anderson <sean.anderson@seco.com>
Date: Thu, 21 Sep 2023 17:03:37 +0530
In-Reply-To: <20230914162924.GA305624@bill-the-cat>
References: <20230914100821.755904-1-mchitale@ventanamicro.com>
 <20230914100821.755904-3-mchitale@ventanamicro.com>
 <20230914162924.GA305624@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
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

On Thu, 2023-09-14 at 12:29 -0400, Tom Rini wrote:
> On Thu, Sep 14, 2023 at 03:38:21PM +0530, Mayuresh Chitale wrote:
> 
> > Some platforms as described by EBBR specification may store images
> > in
> > the FIRMWARE directory of the UEFI system partition(ESP). Add
> > support
> > to boot from the EFI system partition if it is enabled for a
> > platform.
> > 
> > Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> [snip]
> > +config SPL_ESP_BOOT
> > +	bool "Load next stage boot image from the UEFI system
> > partition"
> > +	select SPL_PARTITION_TYPE_GUID
> > +	help
> > +	  When enabled, first try to boot from the UEFI system
> > partition as
> > +	  described in the Ch.4 of the EBBR specification.
> 
> We need to select this by perhaps BOOT_DEFAULTS or BOOTMETH_DISTRO,
> whatever is supposed to signify that yes, this is going to be a
> SystemReady IR (or higher) compliant build.
I am not sure about the SystemReady compliance but I think the config
option can be enabled for those platforms which require it.
> [snip]
> >  int spl_blk_load_image(struct spl_image_info *spl_image,
> >  		       struct spl_boot_device *bootdev,
> >  		       enum uclass_id uclass_id, int devnum, int
> > partnum)
> >  {
> >  	const char *filename = CONFIG_SPL_FS_LOAD_PAYLOAD_NAME;
> > -	struct legacy_img_hdr *header;
> [snip]
> > @@ -63,24 +88,26 @@ int spl_blk_load_image(struct spl_image_info
> > *spl_image,
> >  	}
> >  
> >  	blk_show_device(uclass_id, devnum);
> > -	header = spl_get_load_buffer(-sizeof(*header),
> > sizeof(*header));
> > -
> [snip]
> 
> Is this an artifact of Sean's patch series where "header" is no
> longer
> actually used?  As-is this won't compile on top of next (which is
> where
> given Sean's feedback, the series needs to be rebased upon anyhow).
Yes, I will rebase on the latest next without Sean's series and resend
the patch.
> > +	/*
> > +	 * First try to boot from EFI System partition. In case of
> > failure,
> > +	 * fall back to the configured partition.
> > +	 */
> 
> I don't know that this is the right behavior.  If we're configured to
> boot from partition X, we boot from partition X.  If we're configured
> to
> find the ESP and use that, we find and use that.

This is to maintain compatibility and make more attempts to boot. So
the same SPL binary can load images from devices with or without the
ESP.

