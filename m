Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB3CCD37BE
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 18:13:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7572683E76;
	Mon, 11 May 2026 20:13:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=iki.fi header.i=@iki.fi header.b="VIlew3b7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4375883FEC; Mon, 11 May 2026 20:13:05 +0200 (CEST)
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 362FA83E81
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 20:13:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marko.makela@iki.fi
Received: from kehys.lan (dsl-hkibng32-54fb5f-245.dhcp.inet.fi [84.251.95.245])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: msmakela)
 by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4gDnrn5qrpz49PwG;
 Mon, 11 May 2026 21:12:57 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu; 
 t=1778523178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kdkb4gkkRSC4WJ3b/4svTh4Kf+wP9mi0PxZ3Qo4FogQ=;
 b=VIlew3b786/LSZ8IxTBydzdiX4SVGDeFRST1sWsEqeTo0lvAhjWyPZRq4yvdd/oNe6PRso
 VeWy3yDm2YTfJaL566gHMAp0+Te7orHpGb8Nb5C0cnfvAutEY1ORPjJIm3eUB00Rt5mw2v
 TjqJfrXS603yeDqQ0upw3JoOW1Q9xfQ83ZzOXEyorVUNU8GoHMQbfgrGb5PPHZLInc+APG
 KEuQNZSMVn6FOUEh7ZQPSrAIKJSu0WOqnpkvSkYuPDcl9Z84iMX+cNVaGSzoPJZB9rLNx9
 IK2sWXi9DR/qKnaZ95EHBa9f0y6ZQrz/x1v4K5QDDa+Y+pncKYeaXxKnfQDS7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
 s=lahtoruutu; t=1778523178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kdkb4gkkRSC4WJ3b/4svTh4Kf+wP9mi0PxZ3Qo4FogQ=;
 b=HXynEfdPZYnxDOIzoEoY5m+e+y9RXYSleRHn99l2BvDfMas97lL4qNfBpK4fHxbHFDeAaU
 ujXKyD4xBAZjnBRSbXdWMhM9pgC4VDn7+IWjgas3+Lkxayy35Ekgn4u4rIzYaCo4m7448d
 C7rfLEWjlXkZ8pNERwIbxSAG2RplUFtsOaOUWBvWtfaWo5OuPUImC+P5Yr7MLNik68Emxj
 WoCJGz41Ibyg7Jsb4LlXeGkFvOkY6egwAwqqgxG3x9Z9GGgQ54WVBge6ji9drImcQQRvrO
 iomVT4HaE0SRf7Ic/FrrtRz2ZERlFErZTurTyPC3k/b3BZS/gDjaDiMPLUCV9A==
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=msmakela smtp.mailfrom=marko.makela@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1778523178;
 b=JCOyh+1TkpiRCOpxA5FQk2tINiQ2Xsknj5SSWeGD2aVW3z4haNTfU3wYfp7+Ej8W8hLtIF
 FyLMJUqzaenkhBB/i3/xgOGHPT4VrbVFl4pq8uuzcWQ3n4/gMhJ9uCWTqoMgLTXyNGJ2vB
 IzUut+O+s+oBrNdjmG1Q+0h3EeMXLFBE3klrMFt/nnLaTcT6fI3c/EQ5TB0j/OCBnmhup3
 iu0t6lLFCVXp1Sb+Z2prpMHcsqgF8CsvXjpCJ9ILeKEcx0XudZsr5t8V1FC7ojcK8rh89P
 nKnoAKLPt0vys9JZqtXCqVlUtMKo0ddX5O56gfI3DFYbDFAniqYu2Qs4XnWT0Q==
Date: Mon, 11 May 2026 21:12:53 +0300
From: Marko =?iso-8859-1?B?TeRrZWzk?= <marko.makela@iki.fi>
To: Robert Nelson <robertcnelson@gmail.com>
Cc: Randolph Sapp <rs@ti.com>, Erik Welsh <Erik.Welsh@octavosystems.com>,
 Anshul Dalal <anshuld@ti.com>, bb@ti.com, nm@ti.com,
 trini@konsulko.com, afd@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH 2/3] k3-am62-pocketbeagle2: add initial board support
Message-ID: <agIcJSyF5vf99ouY@kehys.lan>
References: <acaTPyGbaUQj7hk3@kehys.lan>
 <CAOCHtYidPpJMZeDj0KkLkuh6YYOFVAe80NMWWu5wbmV2ou+=UQ@mail.gmail.com>
 <acbXV--BvxNuZxEa@kehys.lan> <aceOvTK4JGQvET11@kehys.lan>
 <CAOCHtYhN42myMkq9zTUM2ETMP6oBA4mBAzPsYcOqVRG=ZskgfQ@mail.gmail.com>
 <aeOdF46Ny1AfNsMi@kehys.lan>
 <CAOCHtYguNVs+epQH8Lf80MXRJj-udsRfEuQO0LRO0cvG4HhKZw@mail.gmail.com>
 <aeTeiZER1IJar_w6@kehys.lan>
 <CAOCHtYin=6r86ThsagZrdFu5+_b2ACGmMZs3yK3tPd45PXJw4w@mail.gmail.com>
 <aeZubllYVLLpznWr@kehys.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aeZubllYVLLpznWr@kehys.lan>
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

Hi Robert, all,

I finally came across to testing this again. A more careful comparison 
between Robert's build script and mine showed that my build of 
trusted-firmware-a was missing the parameter 
PRELOADED_BL33_BASE=0x82000000. Once I specified that parameter, u-boot 
would fully start up.

Next, I applied this patch series to the current u-boot and reran my 
build script. The output proceeded a little further, but it would hang 
in the middle of U-boot initialization:

--- snip ---
U-Boot SPL 2026.07-rc1 (May 11 2026 - 17:57:58 +0000)
SYSFW ABI: 4.0 (firmware rev 0x000b '11.2.5--v11.02.05 (Fancy Rat)')
Set clock rates for '/a53@0', CPU: 1250MHz at Speed Grade 'T'
SPL initial stack usage: 13464 bytes
Trying to boot from MMC2
Authentication passed
Authentication passed
Authentication passed
Authentication passed
Authentication passed
Starting ATF on ARM64 core...


U-Boot SPL 2026.07-rc1 (May 11 2026 - 17:58:12 +0000)
SYSFW ABI: 4.0 (firmware rev 0x000b '11.2.5--v11.02.05 (Fancy Rat)')
SPL initial stack usage: 2048 bytes
Trying to boot from MMC2
Authentication passed
Authentication passed


U-Boot 2026.07-rc1 (May 11 2026 - 17:58:12 +0000)

SoC:   AM62X SR1.0 HS-FS
Reset reason: POR
Model: BeagleBoard.org PocketBeagle2
DRAM:  448 MiB (total 512 MiB)
--- snip ---

When I compiled Robert's version of u-boot 
(ef03e35488377a32cdd4f76d1a03ef7f60c798ef from January 30), I would land 
in a menu like this:

--- snip ---
U-Boot 2026.01 (May 11 2026 - 17:38:46 +0000)

SoC:   AM62X SR1.0 HS-FS
Reset reason: POR
Model: BeagleBoard.org PocketBeagle2
DRAM:  512 MiB
Core:  89 devices, 32 uclasses, devicetree: separate
MMC:   mmc@fa10000: 0, mmc@fa00000: 1
Loading Environment from nowhere... OK
In:    serial@2860000
Out:   serial@2860000
Err:   serial@2860000
Net:   No ethernet found.
Press SPACE to abort autoboot in 0 seconds
switch to partitions #0, OK
mmc1 is current device
SD/MMC found on device 1
Failed to load 'uEnv.txt'
Scanning for bootflows in all bootdevs
Seq  Method       State   Uclass    Part  Name                      Filename
---  -----------  ------  --------  ----  ------------------------  ----------------
Scanning bootdev 'mmc@fa00000.bootdev':
   0  extlinux     ready   mmc          1  mmc@fa00000.bootdev.part_ /extlinux/extlinux.conf
** Booting bootflow 'mmc@fa00000.bootdev.part_1' with extlinux
PocketBeagle 2 microSD (extlinux.conf) (swap enabled)
1:	microSD (failsafe)
2:	copy microSD to eMMC
3:	microSD (debug)
4:	microSD (default)
5:	techlab
6:	techlab workshop
Enter choice:
--- snip ---

Should I apply the patch set to an older revision of U-boot? As far as I 
can tell, it may now be hanging related to some DRAM layout or device 
tree mismatch.

	Marko
