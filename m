Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BBC0C3DA63
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 20:25:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87ABA88056;
	Tue, 23 Jul 2024 22:25:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="SWN4OrL1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95D8287E23; Tue, 23 Jul 2024 22:25:18 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E47A087C38
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 22:24:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: a115a080-4931-11ef-a712-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id a115a080-4931-11ef-a712-005056992ed3;
 Tue, 23 Jul 2024 22:24:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=2MqEowVmRb59t9+bWjoYvNXtIXX5JP7xKzo1a/QVeNY=;
 b=SWN4OrL1voNyJwYxgC0tQtR5l92dWEEBLd/1Zm7ySrt+rCmXklzZ3bJnibvNBR7FRnWooQuCEoKqM
 XDTss1W7El/mnFSTh8KKpJY74MPp3aXWr4z+fcbWDLqIOJdd4JbHdU/yYwAMZ4bk9Mo1gCFbeysiND
 wMytj1CnnRXUngwescd7b06yx2A7rA9RDf63gOxaRTJVN+AKHJCK945RAiq4JOFoeGKIO1X5uW4asN
 OVLai4Vb3ExusuHXIY06NldUTTOpeKR25l432jxZ6R/wBk0DxdWKf0fYzpMCb4gvGVy2OuVhr3Chth
 eqSpJ/VA3aAt3yWvuYq1wG44kdoDBdg==
X-KPN-MID: 33|yBTDVI1g5mn2pYY+OyevbCamYRNzpwT5TuItwUJEXZKqHnzsuAEPpAip0WlDLO9
 pt/N+B8c7cWyh7hglbS4JEa4CwtWX4B49dIoJNWQw+NM=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|/k/RPb3yFxu3r3JnoLA84uwS2QFQ2AJe9JiHzSjiNWaUp30ZKpdyGZ2eeTHPwWS
 vRTtUOatpoA8Ylr0gSmvzOQ==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id a179aaa2-4931-11ef-b403-005056998788;
 Tue, 23 Jul 2024 22:24:59 +0200 (CEST)
Date: Tue, 23 Jul 2024 22:24:58 +0200
Message-Id: <87plr3g8kl.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: heinrich.schuchardt@canonical.com, trini@konsulko.com,
 sjg@chromium.org, bmeng.cn@gmail.com,
 ilias.apalodimas@linaro.org, kojima.masahisa@socionext.com,
 pbrobinson@gmail.com, michal.simek@amd.com,
 u-boot@lists.denx.de, heinrich.schuchardt@canonical.com
In-Reply-To: <87r0bjg94m.fsf@bloch.sibelius.xs4all.nl> (message from Mark
 Kettenis on Tue, 23 Jul 2024 22:12:57 +0200)
Subject: Re: [PATCH 1/1] smbios: add extended Extended BIOS ROM Size
References: <20240723104634.116082-1-heinrich.schuchardt@canonical.com>
 <87r0bjg94m.fsf@bloch.sibelius.xs4all.nl>
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

> Date: Tue, 23 Jul 2024 22:12:57 +0200
> From: Mark Kettenis <mark.kettenis@xs4all.nl>
> 
> > From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > Date: Tue, 23 Jul 2024 12:46:34 +0200
> > 
> > U-Boot claims to create SMBIOS 3.7 tables. The type 0 table has
> > a field Extended BIOS ROM Size since version 3.1.
> > 
> > BIOS ROM sizes of 16 MiB or above must be written to this field.
> > 
> > Add and fill the missing field.
> > 
> > This patch does not cover the case of a ROM >= 8 GiB which cannot
> > be configured in U-Boot.
> > 
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---
> >  include/smbios.h | 1 +
> >  lib/smbios.c     | 9 ++++++++-
> >  2 files changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/smbios.h b/include/smbios.h
> > index a4fda9df7bd..00119d7a60c 100644
> > --- a/include/smbios.h
> > +++ b/include/smbios.h
> > @@ -105,6 +105,7 @@ struct __packed smbios_type0 {
> >  	u8 bios_minor_release;
> >  	u8 ec_major_release;
> >  	u8 ec_minor_release;
> > +	u16 extended_bios_rom_size;
> >  	char eos[SMBIOS_STRUCT_EOS_BYTES];
> >  };
> >  
> > diff --git a/lib/smbios.c b/lib/smbios.c
> > index 4126466e34a..e2a2f873a94 100644
> > --- a/lib/smbios.c
> > +++ b/lib/smbios.c
> > @@ -348,7 +348,14 @@ static int smbios_write_type0(ulong *current, int handle,
> >  #endif
> >  	t->bios_release_date = smbios_add_prop(ctx, NULL, U_BOOT_DMI_DATE);
> >  #ifdef CONFIG_ROM_SIZE
> > -	t->bios_rom_size = (CONFIG_ROM_SIZE / 65536) - 1;
> > +	if (CONFIG_ROM_SIZE < 0x1000000) {
> > +		/* CONFIG_ROM_SIZE < 16 MiB */
> > +		t->bios_rom_size = (CONFIG_ROM_SIZE / 65536) - 1;
> > +	} else {
> > +		/* CONFIG_ROM_SIZE < 8 GiB */
> 
> I don't think that comment is true ;).

Uh, never mind, MiB vs. GiB.  Sorry for the noise.

> > +		t->bios_rom_size = 0xff;
> > +		t->extended_bios_rom_size = CONFIG_ROM_SIZE >> 20;
> > +	}
> >  #endif
> >  	t->bios_characteristics = BIOS_CHARACTERISTICS_PCI_SUPPORTED |
> >  				  BIOS_CHARACTERISTICS_SELECTABLE_BOOT |
> > -- 
> > 2.45.2
> > 
> > 
> 
