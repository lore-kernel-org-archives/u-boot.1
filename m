Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65AC3EC144C
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 13:43:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80E4B83F59;
	Tue,  3 Mar 2026 14:43:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cByzcpat";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDE9A83F63; Tue,  3 Mar 2026 14:43:36 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA0B383E7F
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 14:43:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-480706554beso63156375e9.1
 for <u-boot@lists.denx.de>; Tue, 03 Mar 2026 05:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772545414; x=1773150214; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=TCoDyH10Egm3HR0jxZJTZ2OlK73kp0NJTUw4xgq7Wc8=;
 b=cByzcpatBn1ELnbB8FT1bADWRBmeAKNHPHm/+qEH5IfIAQZ5ipofBF3C/iNOLFtEvC
 fVuRijQJlP6esSMEQKH0rORM5QH5Uc2AODduhS6dIEDULLVRM4Ma6H2ZjTZf8M6uMMZZ
 GTI43PdI8GLU3i4L2Gf1MgePCM5BX1XNg4RjBTFAK3wK5khDrTtn58YW6C7p8gvO3uJA
 QPBAQlcjMOUTAP3Uw26njH6YOE7jRGi0y7vApsh3cF16qZkk3vZ3Q3s1mFKKa206dfSb
 yQSJyHzPkpEyFXtlOcHiotiPLb0nPNjeYbNtT9hQQfxa/M7epLYqYIeBzcsHp0Ch0TCv
 d2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772545414; x=1773150214;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TCoDyH10Egm3HR0jxZJTZ2OlK73kp0NJTUw4xgq7Wc8=;
 b=ItPAXmd3MCI/s0SoD9huRS41TbFjHeBL/zKSagWiqJcJMDSeRFmc/Yopg0r2JPGrS3
 eEt5dyAQ1V8/9ZTAskXOP3iCWQ2nmjFNLg2YF1NFXvKEdoxflYm22K7m+YWvT5eMBK9n
 ljEVlvhHlSRyXhzLZ5X7OyLRKK0N9UAFq8nQSihCQhy1exNYGI5PxmgH/Truj2NzwVhp
 /rYiDxZ7zuaOtyLQjfABw/VhJsQoMKeDTWiitxz8PqBeUcxeLIKVl/nf6Sbj5B4A9Gtq
 dCHzx4lrL7SaOjDIHIQwdSL1jf1zM1ss4VbelZNHfzVjWfVpIVvnkht2EpPVoDpLJp65
 z4BQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJZmNGV6jY86W0H8joi2sIcf+L9f8UMOt4e6wR5nfvvDIEtw6vLYGHgqtZm/l/z0+wroDPiV4=@lists.denx.de
X-Gm-Message-State: AOJu0Yz+3GEO3mhqv+hfzoDzsWZj4ow3/nMdIVK48lJVOasa25NBCycr
 agMkCrweo86Ok3ZKi6ca4+ya2F1D+CD3ynhl0JkMvx1CbpN6VUSFqk/K
X-Gm-Gg: ATEYQzzCM+SbKldnjvi0Yacl6T8ekbfCk2e3A2JTkF13vMJlFD95o1od+K/HjaKPkAY
 K9Uq8RJ2EqDvXJA2bVzIo5vsZCHSKc07KltoTgEjj/XN7lYvLTecNEwyMjZ0TQUF/WT0WYIqGD4
 gBJkQVcOj2elepuKAP2X0TMsnO8AVpT9AD8YXMfXx0u7b0OT2QGKDCT8UiT8VUnGmh4BDz7a3Mm
 UtSLTzD2buQbXSEd+YwyRRRvi+YXgaqRfVR9J3G0Xa7bzKWtd9rmZP9+HLnxqx6W3q7pBuVX5g0
 JTmlq+sjOEgj1hrxkSicZRQ/kaTlPNYUSbsLR5f05mwZoS4C1aDYJ3c6dmeUmdRKepj7kFGRjbU
 0IFfyzBDISX9pmjfpj6RP6ryTdH3fqNWe87E/rCFZGbR6BoiHiTAVgwI065N6j6s+FHg0Hpu7SA
 ctHpVGzZwVZyALgv2ZlfevZbPrhZU8KN1n+U4uV5+wm6mU8qYZDK2lViyFjaNCEOKX
X-Received: by 2002:a05:600c:1e89:b0:482:f564:d613 with SMTP id
 5b1f17b1804b1-483c9ba37b1mr281152765e9.15.1772545413964; 
 Tue, 03 Mar 2026 05:43:33 -0800 (PST)
Received: from Ansuel-XPS. (93-34-88-122.ip49.fastwebnet.it. [93.34.88.122])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485135d0676sm20750165e9.29.2026.03.03.05.43.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 05:43:33 -0800 (PST)
Message-ID: <69a6e585.050a0220.1492ea.9245@mx.google.com>
X-Google-Original-Message-ID: <aablgQeBHNgY9GK3@Ansuel-XPS.>
Date: Tue, 3 Mar 2026 14:43:29 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Casey Connolly <casey.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Harsha Vardhan V M <h-vm@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Chen-Yu Tsai <wens@kernel.org>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Justin Klaassen <justin@tidylabs.net>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Sky Huang <SkyLake.Huang@mediatek.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 1/5] misc: fs_loader: fix ubifs not unmounted on
 dev_get_priv error
References: <20260303132916.5502-1-ansuelsmth@gmail.com>
 <20260303132916.5502-2-ansuelsmth@gmail.com>
 <aabkOylaIZO0w7gF@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aabkOylaIZO0w7gF@makrotopia.org>
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

On Tue, Mar 03, 2026 at 01:38:03PM +0000, Daniel Golle wrote:
> On Tue, Mar 03, 2026 at 02:29:08PM +0100, Christian Marangi wrote:
> > When dev_get_priv errors out, the ubifs is not unbounted (if used)
> 
> I don't understand why or where UBIFS is being used here.
> Did you mean to say "UBI is not attached"?
> UBI != UBIFS.
>

Function that is not called is umount_ubifs. That calls cmd_ubifs_umount.
unbounted is a typo for unmounted.

Probably the confusion is present already in the FS loader driver where ubi
needed to be used instead of ubifs?

There are mount_ubifs and umount_ubifs but they should have been mount_ubi and
umount_ubi ? But then they use ubifs cmd OPs. I'm a bit confused here.
 
> > 
> > Correctly handle this handle condition and while at it also return -EINVAL
> > instead of -ENOMEM as a better error since no memory is allocated but is
> > actually an invalid scenario for fw_get_filesystem_firmware().
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  drivers/misc/fs_loader.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/misc/fs_loader.c b/drivers/misc/fs_loader.c
> > index 2928cf75f89e..7e432a7ebd62 100644
> > --- a/drivers/misc/fs_loader.c
> > +++ b/drivers/misc/fs_loader.c
> > @@ -178,8 +178,10 @@ static int fw_get_filesystem_firmware(struct udevice *dev)
> >  
> >  	struct firmware *firmwarep = dev_get_priv(dev);
> >  
> > -	if (!firmwarep)
> > -		return -ENOMEM;
> > +	if (!firmwarep) {
> > +		ret = -EINVAL;
> > +		goto out;
> > +	}
> >  
> >  	ret = fs_read(firmwarep->name, (ulong)map_to_sysmem(firmwarep->data),
> >  			firmwarep->offset, firmwarep->size, &actread);
> > -- 
> > 2.51.0
> > 

-- 
	Ansuel
