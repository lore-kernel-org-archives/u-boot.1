Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E84F3C79FB7
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 21:23:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 40FCF6080B;
	Wed,  9 Sep 2026 21:23:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z4yKvkmPKyoT; Wed,  9 Sep 2026 21:23:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4AE8A60802
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788989012;
	b=hFZUBLezIzM3eaQslVsPrOEhxM8+3seYjIA+p/5ByH6XbxrkbY1H/05opdIK0GLoj34V
	 L89luDLX7EhH6ZQy7GzPFA4XtBcNu/awBPLcZjRFTqXKqGWDFB8up49coVrsgPml5Ns+Q
	 8O7zPRjJpeGvSWlNtlZWc7xwB/zI5Q5YP7dipf01LfcCD6jHDDGCunD/qx4uF4PpicaIb
	 2UorbRG0OnT1A3vAsuQLasTV2xXWYgH5UQ3U20aYgQPIb2zVO4uKS+8vzPN/bbBafeJM/
	 IexDe4CzU+sRu+TnS0ThAWCZA7h6iYX8CKVY3W9rM+RcisZVa1kZRvsDUJtihQY9OKQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788989012;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RdJRjF1BZMAzzpF7w4gUlDviVCcyCK6A5FFZgUOkETg=;
	b=HCozLn/kTKOoFqCngA781n6Gyzp3MXq4PHPpBRXA4EUPw0eTMwq0Sye0jaYTcsxJmh7I
	 DmCVk/ursLXLRD4rqD670ZoN11zt7kFodhIYO7mvpQyYz0GBsIN3fImCWp5nyjdyBrmSr
	 4qBLOZ6OI5xXP/fcQo5IZp+Bxjq2qYv8eiAxA1zDu/+uFhjluJBHb9w9V9lWkzJhWO5J6
	 bd4xwvO2FEJgY7IpswZteRxVu3iqFv3NNPRayYgyhoCX23twR4ZNf+vfzX7Lbp3VbPM2i
	 IS7DbL1SkR8g0l87KPK18DdNdWK1BflE56Fb6o7UqJv/2vImThdPd5X/c3OlgGaER+w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788989012;
	bh=RdJRjF1BZMAzzpF7w4gUlDviVCcyCK6A5FFZgUOkETg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SKjSxBraJJhRVKuawsY3TPVNVUoKT4qEskEltPuzvd9MGk9Flu+OtiGDmsfsOZdEQ
	 qm6eLDh6aFpXg/CzhsImgHL9Tt1SBWlql36vB6+aiul7KoAzNwdvR9UYU+y6182Mhl
	 3Qmqe0Euu71KJqzMrGhz97oR3274kgUyhroSR8XPOKCwAcB0+eD4Zai8c/eB7p+FhR
	 MEclHTFEzBgOZU+m7uSpA/TZiqeCqY2jAYP7ieM7nFUJmp/Uq1Td2d47WF2we6vurY
	 BaEFe5bP7NrDu+Dnc3c9cr9aUgdhOVPgtzvE5jVnHPO9zgpTlOojCq2N2wm2Hd3jPN
	 d9e0I5iyo20og==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4AE8A60802;
	Wed,  9 Sep 2026 21:23:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id CCF57724
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 21:23:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CA63540AF9
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 21:23:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wLorVcIMxmGn for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 21:23:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3306840AF8
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788989010;
 b=G8gUMrvoZlf+lqh79mqWy1jzpV9Khf2EyVD0lJjT4ZUoaGB9qv9PFpGSK4cC9GrLNgjr
 3ErdzW5bgb++JDXTiTgpgscNYobIUtnb40H/p2j2o9vJkbDTn2d1A9FkO0R9MqwM5XU+u
 WdfbaFh60udfdKc4gDso/A4QJr+bgMVVHZoFD9pjD/b0UIwTzm66gguXJ3Ria11iEqc1y
 fCc7e7mDkwr+eplJ0l4VnqvCAfh5/paCQ4DuFi1kWKzZR3p5CnHw3u8KTeRtsan/RTv1G
 f1ipxEIBny0ZbkKm48mrWCVVMwpTeeCk4EsPhwsfoBOAXW6iEM2JCv/26SP0v/NP91w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788989010;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=RdJRjF1BZMAzzpF7w4gUlDviVCcyCK6A5FFZgUOkETg=;
 b=aGg9vSeXuGx+ybrYcsfzqxeKskY3YYMQj87j6mjFs28K4v81PqOUV9O5spp35L1z/YuR
 AL7/YGtwYwscjrp+gX0/2XVJOuIJz8Rvcx4Rh3MqWgT0LOZwpYF5BFi2RVyFolY1zU8z0
 t2UYHG9rsUqIhkhqm2Qh7eAE0EqazNA8RccRB0GcDu239yWX5SIxuoxOhMgWBDpQ9CJ+i
 ryhs/RqImbrel4zuA/MElrno4zNPuTeC08qm+3UwKIApRZU5glV2pMP8qCstJB6ZVDiCi
 +hJFqA7ZQ/ksJqYEWZ+4rOzjahri1hxFPIRNfpur2FPTGihS14wB5qBMEApBmr6grFg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=jPgxA9Vv; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=jPgxA9Vv
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3306840AF8
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 21:23:29 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49cc9f581c4so9698035e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 09 Sep 2026 14:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788989007; x=1789593807;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RdJRjF1BZMAzzpF7w4gUlDviVCcyCK6A5FFZgUOkETg=;
 b=jPgxA9VvM7lhyG61gCkI6043al5C1mdIe4uS5O5RwteEWPMvdUXDSCALtyFPdy32FJ
 3QFnCt44nHRzpiUpvvaRs6E50XW30im9qft6wF7lGgYu1Oz3UcckQJPAQpjFkFZDK49A
 UYfChYJtHS9xF6n4bWVe8eXNUSEIPTfjregzDsph1o/qTpdkeg2HcHfdPgsI5QCP97t7
 5eFbYo6opUaU398zXBvqWyLqQIWaFBwVfe19843/DbKuQtZnhCEqREfoqoGYMZA2SCXv
 Xz0cB9PvIBr9JpxFR3ldADOjdh7MK3XFZ8EHuZKkz/CkC59lky9OqCTm5ank7Uu6XW6a
 LSmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788989007; x=1789593807;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RdJRjF1BZMAzzpF7w4gUlDviVCcyCK6A5FFZgUOkETg=;
 b=BXfx+jHHIN9J540ArBuKnQEzOh0FL2pnpZl/YYugu4RoKBJM6cB39tvEUII/kqDQMq
 F+KhJC9vS1uNbrpbXAKk0jmuoU76+cFJe9bmrTA0vsu76eoZAvg1nEVHL/xBbwiYiSnZ
 J6mSmENQUWNU9leiAiI2xnjkoGdBk8ksKfIWTs6zAKEPvNpN3kwun6iAk5ZdSN4/tuEO
 IBn+RCh09hqBTQbl4MR1QtJre7Oqx86o9/BC7TvWtEQDfSDuIhELdG6a/jYARDP2xWNB
 rR9GnvRYKMpMaqDIvObk0/KS93y5YpyjQUhUbmHSfM7zbnF2hhtjYdviKKBk0/75LEfV
 zvVA==
X-Gm-Message-State: AFuF++nPCS4vKmidykJHkDmdFw5DEY5breJYvqB+qXPws0H/bBAdMa81
 hWCZXPByxLP+TE9cxoYAH1rwPeGhvRNmR/HlenNSZ7FOwIASSdL1eI5pEAYTmzTs9iY=
X-Gm-Gg: AYBFou2BWJkW153ucCD0eFo0zmziUWBGU6lHBCi4rSECCMmxI4N57qbG+Cc23lC5O/F
 7CbqEOhs3IN1uEskG2g8jgKHiqYRj3naZv6PbOj3TE2bWRpcorUML2b/ORwDb9sE0Emh8v5ij9x
 jKoY4C8ewEfmIcxJTyb92NUgV09Xh/WnSvHz5i9x3ac3SlAJiHB82crtKy7Bu2Dk/Qp8dAIOHn2
 7Rua/bIIG3bnKtdMCe++PbG/V2BGcS8qdoxtNtkY9sWBTx+6lT4MAWJ+getdhzz8zGl9N9zDm6B
 y3lKdTwKl68q+MYcseVm18rTzdMJeHAqhslZk0/XJgun6NCfqghaneLg/gRfU/kuT7RsCystpXD
 qvjSyDrRgRJ/ty5niYN1a+0MG8J0Bzh2dNnwnxMl/kA7hfQls5xbxShxklPhc+W+tJVaWgkzHnV
 gNiNsRFj39tQwk9Y6TeKFQWGHxYiqnPKE/Gijq0EomHMadbobeADtP4h8pIEWax3KifXiBPzthy
 2Bij/KeSuGDG9wNQBRSM3BIWUecnKs9GWmakmzNQb8A9UQ0JRe8stp6Zw==
X-Received: by 2002:a05:600c:c4b8:b0:49c:f13e:e52 with SMTP id
 5b1f17b1804b1-49d26dcbc5emr13157025e9.15.1788989006645; 
 Wed, 09 Sep 2026 14:23:26 -0700 (PDT)
Received: from macbook (host-95-232-147-181.retail.telecomitalia.it.
 [95.232.147.181]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26bdb789sm22184245e9.1.2026.09.09.14.23.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 14:23:26 -0700 (PDT)
Date: Wed, 9 Sep 2026 23:23:24 +0200
From: Carlo Caione <ccaione@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 Macpaul Lin =?utf-8?B?KOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>,
 Pablo Sun =?utf-8?B?KOWtq+avk+e/lCk=?= <pablo.sun@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sam Day <me@samcday.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Alexey Charkov <alchark@gmail.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>, 
 Francois Berder <fberder@outlook.fr>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Vincent Jardin <vjardin@free.fr>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH v5 5/5] fastboot: add SPL support
Message-ID: <aqHOCHRyUGfhJcXf@macbook>
References: <20260906-ccaione-upstream-spl-fastboot-v5-0-023516e77321@baylibre.com>
 <20260906-ccaione-upstream-spl-fastboot-v5-5-023516e77321@baylibre.com>
 <7b98b6c4-078e-48f1-98d1-1b65fc19b611@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b98b6c4-078e-48f1-98d1-1b65fc19b611@baylibre.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Wed, Sep 09, 2026 at 16:16:16 +0100, David Lechner wrote:
> On 9/6/26 3:02 PM, Carlo Caione wrote:
> > Some recovery and initial-provisioning flows run before usable firmware
> > is available in persistent storage. In these flows the SoC ROM loads a
> > small first stage, but that stage must still provide a standard protocol
> > with which the host can provision the device.
> > 
> 
> ...
> 
> > diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
> > index 111516fd1b3..a2a89fc04f8 100644
> > --- a/drivers/fastboot/fb_command.c
> > +++ b/drivers/fastboot/fb_command.c
> > @@ -48,10 +48,59 @@ static void oem_board(char *, char *);
> >  static void run_ucmd(char *, char *);
> >  static void run_acmd(char *, char *);
> >  
> > -static const struct {
> > +struct fastboot_command {
> >  	const char *command;
> >  	void (*dispatch)(char *cmd_parameter, char *response);
> > -} commands[FASTBOOT_COMMAND_COUNT] = {
> > +};
> > +
> > +#ifdef CONFIG_XPL_BUILD
> > +static const struct fastboot_command commands[FASTBOOT_COMMAND_COUNT] = {
> > +	[FASTBOOT_COMMAND_GETVAR] = {
> > +		.command = "getvar",
> > +		.dispatch = getvar
> > +	},
> > +	[FASTBOOT_COMMAND_DOWNLOAD] = {
> > +		.command = "download",
> > +		.dispatch = download
> > +	},
> > +	[FASTBOOT_COMMAND_FLASH] =  {
> > +		.command = "flash",
> > +		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_FLASH, (flash), (NULL))
> > +	},
> > +	[FASTBOOT_COMMAND_ERASE] =  {
> > +		.command = "erase",
> > +		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_FLASH, (erase), (NULL))
> > +	},
> > +	[FASTBOOT_COMMAND_CONTINUE] =  {
> > +		.command = "continue",
> > +		.dispatch = okay
> > +	},
> > +	[FASTBOOT_COMMAND_REBOOT] =  {
> > +		.command = "reboot",
> > +		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_REBOOT, (okay), (NULL))
> > +	},
> > +	[FASTBOOT_COMMAND_REBOOT_BOOTLOADER] =  {
> > +		.command = "reboot-bootloader",
> > +		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_REBOOT,
> > +					     (reboot_bootloader), (NULL))
> > +	},
> > +	[FASTBOOT_COMMAND_REBOOT_FASTBOOTD] =  {
> > +		.command = "reboot-fastboot",
> > +		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_REBOOT,
> > +					     (reboot_fastbootd), (NULL))
> > +	},
> > +	[FASTBOOT_COMMAND_REBOOT_RECOVERY] =  {
> > +		.command = "reboot-recovery",
> > +		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_REBOOT,
> > +					     (reboot_recovery), (NULL))
> > +	},
> > +	[FASTBOOT_COMMAND_SET_ACTIVE] =  {
> > +		.command = "set_active",
> > +		.dispatch = okay
> > +	},
> > +};
> 
> Do we really need to make a complete second table or can we just #ifndef
> the indivdual commands in the existing table?

That was actually suggested by Mattijs here
https://lore.kernel.org/all/877blphqmg.fsf@kernel.org/



