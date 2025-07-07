Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C86B4C8303C
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 04:30:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E1DD81D5D;
	Mon,  7 Jul 2025 06:30:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1751862646;
	bh=Mnwk+moUKP0VCxu3C9C/cCQ4/9sH1xQtVmd7nIiqGjA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=v2qs7QFkJrQ8VbencsILldI/cX+xiwBOamnQoyzhp03YJdclw8BvI0v6NOD9mJzEC
	 pDm2AF2cYZDSk6jzd5m4b8AczU6RXtKEvlMiV9BuytWhFgC2z52z6VDyCMY0la4l47
	 +C5n4wv9hKoCsxis/lWcQ3w33fzcB5G4RQGj1h8X5xGajTcAiPBOmtR65vT8t9ty49
	 V3poWwVb3S9dIKuL/kOHA1aXWuc1KvQsE7Y0ZWkdq4D1afueZUSE5d5yCTXRPNN3Sy
	 euLf6VCiGS9fEUqckWMLo4gi3GRFxwRj3O9FP7DgmgQ9/DJHy+I00Qvp+Ry7chFT1H
	 8fiTOL/XmejYw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6A9481D6A; Mon,  7 Jul 2025 06:30:44 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E5EE810EB
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 06:30:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Ni7Wd3qM"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EB19610380104; 
 Mon,  7 Jul 2025 06:30:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1751862641;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=Mnwk+moUKP0VCxu3C9C/cCQ4/9sH1xQtVmd7nIiqGjA=;
 b=Ni7Wd3qMoRj6KYHU7FhBS1aMOYc3C0UR88RjojcNrtNzbK9ccY+e60+iRjp0vZbrbVzbdr
 LxYLwyXKc3GcBQIoxFJ1DjP+eia8ugKaJiuV+kS2fx1b5BpFovgb3EKb6WTQpxhVPT+n7a
 bZ/e3XOXKZyQlqskkYX8gQRITEgWfXrOc3/ghEisz5i6YdzyZ2NYbEKGxdLRHHDmWD0Y0D
 Fjvsf1+hMx8sCrFm9WoPFSu00/OTjJhnp26yUTR8+FIWXPT3z4w3SceOiQBcuPkDHrN/a8
 tlFZWyxKNlkxTfEUPVfDCVQ9xG/UALxLxSlGunJ0KtdzhelCQunOodIcpkKXMg==
Message-ID: <072c3a1f-7501-891c-b2b7-a55ea47be0f4@denx.de>
Date: Mon, 7 Jul 2025 06:31:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: i.MX6UL: Adding bootcount support
Content-Language: en-US
To: Fabio Estevam <festevam@gmail.com>, U-Boot-Denx <u-boot@lists.denx.de>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Schrempf Frieder <frieder.schrempf@kontron.de>,
 Michael Trimarchi <michael@amarulasolutions.com>, =?UTF-8?Q?Marek_Va=c5=a1u?=
 =?UTF-8?Q?t?= <marex@denx.de>
References: <CAOMZO5Ag7CmRBhpvOB5btNvHiAMayBoxSYMoBJXbV3-w1ET7jA@mail.gmail.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <CAOMZO5Ag7CmRBhpvOB5btNvHiAMayBoxSYMoBJXbV3-w1ET7jA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Fabio,

On 07.07.25 03:18, Fabio Estevam wrote:
> Hi,
> 
> I'm trying to enable bootcount support on the imx6ul-evk board like this:
> 
> --- a/configs/mx6ul_14x14_evk_defconfig
> +++ b/configs/mx6ul_14x14_evk_defconfig
> @@ -110,3 +110,8 @@ CONFIG_SPLASH_SCREEN=y
>   CONFIG_SPLASH_SCREEN_ALIGN=y
>   CONFIG_BMP_16BPP=y
>   CONFIG_IMX_WATCHDOG=y
> +CONFIG_SYS_BOOTCOUNT_ADDR=0x020B0068
> +CONFIG_SYS_BOOTCOUNT_SINGLEWORD=y
> +CONFIG_BOOTCOUNT_LIMIT=y
> +CONFIG_SYS_BOOTCOUNT_MAGIC=0xB0C4000
> +CONFIG_SYS_BOOTCOUNT_BE=y
> 
> However, the 'bootcount' variable does not increment after a 'reset' command:
> 
> => print bootcount
> bootcount=1
> 
> Has anyone managed to get bootcount working on it?MX6UL?

Have you checked if CONFIG_SYS_BOOTCOUNT_ADDR address is stable over
reset? May someone overwrites it...

I had it working on imx6ull

CONFIG_BOOTCOUNT_BOOTLIMIT=3
CONFIG_SYS_BOOTCOUNT_ADDR=0x20d8024
CONFIG_SYS_BOOTCOUNT_SINGLEWORD=y
CONFIG_BOOTCOUNT_LIMIT=y

I did not needed

 > +CONFIG_SYS_BOOTCOUNT_MAGIC=0xB0C4000
 > +CONFIG_SYS_BOOTCOUNT_BE=y

but may because I have an older base...

Hmm.. your register seems fine ... I read in RM:
"""
For backward compatibility with earlier
versions of SNVS LPGPR0 is aliased at its original offset of 68h.The GPR will be
automatically zeroized when a tamper event occurs, unless GPR zeroization is disabled
via the GPR_Z_DIS bit in the LP Control Register.
"""

May try 0x20b00090 ... just a try...

May tamper event occurs? And the register is in "low power domain" ... may
there is a problem... so no real idea here from my side, just speculation...

bye,
Heiko
-- 
DENX Software Engineering GmbH, Managing Director: Johanna Denk, Tabea Lutz
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
