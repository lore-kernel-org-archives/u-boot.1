Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C68BCA5FA1
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 07:43:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E4A756070F;
	Tue, 29 Sep 2026 07:43:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4yKsphrnCYAT; Tue, 29 Sep 2026 07:43:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1622660712
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790667791;
	b=HA04AV6CAWvEQ9MpufNbEht4/n4b2p0z0ePLU2KSWV/ajyYrYFQfsQ33UuBq8eUkmbNl
	 P1gzhAUvCuoU5bgSVdppjSNTu9xgomzJWX79CQjbTBzleRz2UUyilh997jyM9yPwanpvR
	 GGlapgfm2Xmb1Irb5+8LEmvqNe9XV+OzgW7LpELY0S8lpzHr/rU+suQsw79IIdA4o8Z9Z
	 fqNFS80dsN6ltOhrdpo6JbEM3laf9bZaJEKtq0UjD1oDkn+Ijhk63wRvOfumNGAPOJyAR
	 IxExwDvgnNDBOQDEjxBlZI+sL+UUldY/xpaLqk76ReQFXBPWYufJ+kevinyk3AA/FWw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790667791;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=irc4up5RFaH3lMjeHEMIs8k7qXTwZelI/pW5tY9WUqU=;
	b=jdZ0AQyzhd2QhS0FAPAjEx6WFrTo6amOBTU7RGvyfRmysZjZmMWqeUoI8FaGshhuB5Eb
	 Zfb9icMNEZC4Ief7C/qAcZ4qXGoUntweDFntbJ3J7HBFyF0hzWw6fWjEAxrHPAIJhO1G+
	 WRg7RPPdUndT/mibs72tOGXA989TBYipVQYoatVD2+rc6uLm8gMaRP307y1JOKbe2HDNW
	 FExnwTJOMIzSZWC38TYO8WIA4uKH72iTmxxnyhPGpIiiAIocpkymHau5oioMkTjJicrqS
	 Omz7ofdpbiGm4kzoihg5gF/v6ovbju43qisJfSeKKRSHPNkmSFe39cub/VQDlyrF8bA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790667791;
	bh=irc4up5RFaH3lMjeHEMIs8k7qXTwZelI/pW5tY9WUqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QzqTPdgxs84lV+m64PWWG5vBHNTsbrUw5U00J4h13dEf8EkzC9lw5XWfa8OuvfLHO
	 cfMGz8FQysIcr478HnJwEKNp0YNyWRgx0Hf5B67e/76+OD9v3+LADGdgkzghw/MAH6
	 GsIiXO+QbvSydMnVZwap3x+uOV70IZmgShrRJPz1i+XQN777oJQaAZkEyxWKFx5/Kb
	 C79hE7ZHRnjfTdov18OYtBtSq80ELOaRnu5bodpiqapXTqkmT5r9d3KwOzirIXb0Zh
	 YpCNustN3P0xFoLgiaHYPexO9Q2UE2TY98X0R6Hn9924tFsIP+8wACFh7aNaEouixR
	 MNGh3YtRFAy0w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1622660712;
	Tue, 29 Sep 2026 07:43:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id F13953D8
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 07:43:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D6CA38086C
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 07:43:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RqDQAfGrlBYh for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 07:43:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D093B80851
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790667788;
 b=c3tyIPmwVF+/ZriCCbdQwvubv0ImvdshDBEGs23/Xio6NfYYImzdFt75PZnHYXtTdnRS
 iCOXDKHX0jgQxfgd+e14wmaw7jU5edAhDXLOg3JgmXspa8H8+s047My/zjATJQIJ2ZrEQ
 L++KNflN/ymJtuE/Vl+3wB6BcPRIRYWuSh0mDsRl+NDvCp/U125Tgz76pJTSG6H8OrsjG
 lrBAnzrpIcsArZCTsSca6BYplVFJEa+tQMDJBJEIRNn1r0RI4M6v/2FbpWiLwgjvisk6D
 iXvvL/Z/Div8uLV5sXsbniyEks6yqPKSWpgM+40XpcYBRwMd9ZU6yIMMDHq0GBLWSiA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790667788;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=irc4up5RFaH3lMjeHEMIs8k7qXTwZelI/pW5tY9WUqU=;
 b=jNov2apOgIXGRVhRVCV0wWHCSinJqxJTpnj8/UUZ3c3VghVCwjVbwggMtnphsEyXTCjh
 5XgP7GMygzl+aij4h5aztpAXpdKNRyDg/q9bNpiQihijsNlka7H2R2a2s2zGNsKWis/fH
 21v7cXq+UgrD0ZLErqD1YDWhl6nTTuKWMTKZf+Tf2gT6aj7rBKkrskXvc04PGv/f/DpqQ
 GLnLe72wPe1+XJ2cfBukqJleL27sX8OHHu5U06CbhLeusbAmLwY8y2iZ4L7gAawiXgxH3
 NEQuuXU3GEIpdnhHz2JLX+y49/dxuc5UcpJSOuhT0e3/jvY0KEcZWwonZChAelvbvVw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=AO9DVt5G; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=AO9DVt5G
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D093B80851
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 07:43:07 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e71cdb22bso28307815e9.2
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790667785; x=1791272585;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=irc4up5RFaH3lMjeHEMIs8k7qXTwZelI/pW5tY9WUqU=;
 b=AO9DVt5GfGwao2GjHkPm7Y/UtMODmRlXayE2RrgyAxK70XNVNitDjhSyFrByHZwCEs
 2fC0Ha3v0QMzPe0VC+hv4pEY03oGoS6hVNyqRebTAavz/LlGP7bEG3olZ//LSU/78Ni3
 jAJuzpBRkEXU3ZB6bwsZ+eSDeD/JlCOEcKUP4AHM4BBnSVOS3rkyFreSufHlEAI93Y0M
 vlHs4t806EsQvcsiQ3NmekbYBCzowaBIyvyjaQvZNYszExU7gXEUC3OWw7Z7winNhOSf
 bMLFLk3sU9FblQ5gpl5GEefl80wPlXpKDHPdviUYLzMF1b/RyntRSonAWZrXg8jJylJ2
 Ft2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790667785; x=1791272585;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=irc4up5RFaH3lMjeHEMIs8k7qXTwZelI/pW5tY9WUqU=;
 b=Kur3RlxfO6v8A51KdP2wYezrtbyPZNEGHQAttH5IUTJg3gCoRczxAwaiDPRHFtdAng
 XHEBAFlcaIxPVvvslp/+0dKcSyUoOOPm3uHc9DNV6gQ7Rs7uEhfvqGLRb1GpzLcHGbYP
 ilpAIFomQ2EoFsoNzQAPqd2TxnEtPs3u8B/iXCR8m7T0aUOUXnlT8pwtgqggrFOOmCl6
 Sif78Aw/sUibT3XXxMR4NMGuC0qQUwy096tGWjgnbAth5eZ1RgbkMvUD5p8AnR+1Cqew
 rsn7tqO6dgFwJf/zcpnguKRa/41AjNLwlqfxHBhRNO0fhAtbf6tKwpiXYraWvG2zc/JE
 gr0g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzue9LR2EVeVAeenkeA69EAFOE56VKA61ZrBAuPErumTfz5JZtyKxfzYLNax1efoxBslTTsc7o=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mFKoXyPV5Nk1oyJ2LFtOQXPrM8AvL2xMTN24yPzZ/1XWFhPLNw
 dvjx41YE1ixm5tKaeiIXuUWT5j+foC2Xx22IehWbEe+qisdqZ55yuiRmHWacz42cFeE=
X-Gm-Gg: AYBFou2TrZJdaXS5+X4oFIzfJJSRlBGqZC/NxzvDp9TnMgBkkZwTVN2MQSGqyCEoJLj
 6wbJXW2pewd112xB6L9N7qIGcuuuKcSK8+YOq66fkgJljvpSBUmMBH6uslAxDF9yI51Ur4cJg3L
 +BWTQamTxWjc51MiKmZKJmhjwkB5b3hc6EIjTYUXx8MreL2oHJC0XWzYFcNp0d/YuxJKq4XNeJ3
 zvWVbjQYvg4XXOa/WnJ2yuxF7k2iOJj1cqD5kMscBhWnneZUyjjkypbD31qQVT+vB2h184hUCXJ
 8zqCbCt7WK8D7Bv/bFnZwWlnHTELRoRqS1IdfHgGYwCu1ppElEIwqP+syPT/1HWgcPdyUKXaw86
 hXhem0Hro1LWma2hmbYuVv87JyGofc2owquFG07YLOCgH67o77uWO+NLdTt12GAjk+dfhheKzhu
 jMiI0FkOmW5Aj68vdRRcURPaqR1iKfKjxNoZb8Yv6hDiqw3VJK8W9bn4/vJ+ePJECu2bnoR7alu
 /S+EySN207gr00bBX7Jsnoefi/Ie0tkX0Sk0c1yE7S+4Zn15Za7a/A=
X-Received: by 2002:a05:600c:1c2a:b0:4a0:c2a:485e with SMTP id
 5b1f17b1804b1-4a00c2a48cdmr40121375e9.33.1790667785270; 
 Tue, 29 Sep 2026 00:43:05 -0700 (PDT)
Received: from macbook (host-79-45-166-197.retail.telecomitalia.it.
 [79.45.166.197]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00cf869c4sm56574485e9.2.2026.09.29.00.43.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 00:43:03 -0700 (PDT)
Date: Tue, 29 Sep 2026 09:43:02 +0200
From: Carlo Caione <ccaione@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>, 
 Julien Masson <jmasson@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Alexey Charkov <alchark@gmail.com>, Vitor Sato Eschholz <vsatoes@baylibre.com>,
 Pablo Sun =?utf-8?B?KOWtq+avk+e/lCk=?= <pablo.sun@mediatek.com>,
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>
Subject: Re: [PATCH v2 2/3] arm: mediatek: enable U-Boot fastboot DAs on
 Genio 510 and 700
Message-ID: <artrGkbaSYG4xCsU@macbook>
References: <20260923-ccaione-upstream-mt8390-da-v2-0-8f264678ac29@baylibre.com>
 <20260923-ccaione-upstream-mt8390-da-v2-2-8f264678ac29@baylibre.com>
 <898e280a-7af1-4f0f-9d10-a7350e4579bd@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <898e280a-7af1-4f0f-9d10-a7350e4579bd@baylibre.com>
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

On Mon, Sep 28, 2026 at 17:43:26 +0100, David Lechner wrote:
> On 9/23/26 4:17 PM, Carlo Caione wrote:
> > Prefer fastboot in U-Boot proper when the complete download agent fits
> > the BootROM SRAM limit. Its shell and boot commands support provisioning
> > and recovery beyond the SPL agent's flashing operations, without relying
> > on the installed firmware.
> > 
> > This variant requires BL31 and an external DDR loader.
> > 
> 
> ...
> 
> > diff --git a/arch/arm/mach-mediatek/spl.c b/arch/arm/mach-mediatek/spl.c
> > index 6f1ec052b95..120a94c6598 100644
> > --- a/arch/arm/mach-mediatek/spl.c
> > +++ b/arch/arm/mach-mediatek/spl.c
> > @@ -33,15 +33,17 @@ void board_init_f(ulong dummy)
> >  
> >  u32 spl_boot_device(void)
> >  {
> > -#if defined(CONFIG_SPL_SPI)
> > -	return BOOT_DEVICE_SPI;
> > -#elif defined(CONFIG_SPL_MMC)
> > -	return BOOT_DEVICE_MMC1;
> > -#elif defined(CONFIG_SPL_NAND_SUPPORT)
> > -	return BOOT_DEVICE_NAND;
> > -#elif defined(CONFIG_SPL_NOR_SUPPORT)
> > -	return BOOT_DEVICE_NOR;
> > -#else
> > +	if (IS_ENABLED(CONFIG_MTK_BROM_DOWNLOAD_AGENT_UBOOT_FASTBOOT))
> > +		return BOOT_DEVICE_RAM;
> > +
> > +	if (CONFIG_IS_ENABLED(SPI))
> > +		return BOOT_DEVICE_SPI;
> > +	if (CONFIG_IS_ENABLED(MMC))
> > +		return BOOT_DEVICE_MMC1;
> > +	if (CONFIG_IS_ENABLED(NAND_SUPPORT))
> > +		return BOOT_DEVICE_NAND;
> > +	if (CONFIG_IS_ENABLED(NOR_SUPPORT))
> > +		return BOOT_DEVICE_NOR;
> > +
> >  	return BOOT_DEVICE_NONE;
> > -#endif
> >  }
> 
> Could be nice to do the CONFIG_IS_ENABLED() conversion as a separate patch
> so it is easier to see what is added here.

Ok, I'll split it.
 
> > diff --git a/configs/mt8370-genio-da-uboot-fastboot.config b/configs/mt8370-genio-da-uboot-fastboot.config
> > new file mode 100644
> > index 00000000000..5a85b26df0d
> > --- /dev/null
> > +++ b/configs/mt8370-genio-da-uboot-fastboot.config
> > @@ -0,0 +1,28 @@
> > +#include <configs/mt8370-genio-da.config>
> > +
> > +CONFIG_MTK_BROM_DOWNLOAD_AGENT_UBOOT_FASTBOOT=y
> > +CONFIG_SYS_MALLOC_LEN=0x9000000
> 
> What is driving the need for such large allocations?

Yeah, this was actually fixed in the previous SPL patchset but not in
this one. 8MB are enough, I'll fix this.

> > +CONFIG_CMD_FASTBOOT=y
> > +CONFIG_USB_FUNCTION_FASTBOOT=y
> > +CONFIG_FASTBOOT_FLASH=y
> > +CONFIG_FASTBOOT_FLASH_MMC=y
> > +CONFIG_FASTBOOT_FLASH_MMC_DEV=0
> > +CONFIG_FASTBOOT_MMC_BOOT_SUPPORT=y
> > +CONFIG_FASTBOOT_MMC_USER_SUPPORT=y
> 
> Do we need to enable FASTBOOT_CMD_OEM_PARTCONF and FASTBOOT_CMD_OEM_BOOTBUS
> to allow flashing a blank eMMC?

This is actually a very, very good point. Now, we have two ways of doing
this: either we add the fastboot commands and let the host issue these
commands or we just do this in the code. The first solution would imply
modifying the genio-flash tools to issue the command during provisioning
and this is something I'd like to avoid, so I'm going to do this
programmatically the same way we do for the SPL DA version.

Cheers,

--
Carlo Caione
