Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE649C47DD9
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 16:40:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FD86880F5;
	Wed, 27 Mar 2024 17:39:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="rpJBUu3B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFDAD88105; Wed, 27 Mar 2024 17:04:20 +0100 (CET)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D744787F4F
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 17:04:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cgmeiner@igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:Message-ID:References:
 In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mWDvdziSmQxwcoCLFgEP+k/za7G/xeROyPzPVma/Mf4=; b=rpJBUu3BQFysE0VpjQJtIBkKU9
 n4AGWCIPwyXzk7VAMVDbAJ12FvfgQ1falrROQXtbCER2p0IR1+FhdWzyd+KB8EKEFvNzfvo+RxZfd
 3Az3tC3CePj5qvv3xk3z4SmC1kTl2SgPR0jntvNBpikQ+i2YZr8KrIMDsnM+e4XX3vm56ELGOC5Yb
 6c9wfOgj5HlkFtWMLnpx7vmEL5RV9vL7NbLG4TLXoprXUE8ycfeg70hQT+OMG2pbt2y7TpPB9E/tq
 A3myrrtsg323m1RfCaADKWA+Bx6JNs/rKt3NVGEgPtXW/TDSSgoTYx8Uok94AdEbmU73D7hReTHcX
 eAEdu0Cg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtps 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1rpVl5-00FvQu-Me; Wed, 27 Mar 2024 17:04:11 +0100
Received: from webmail.service.igalia.com ([192.168.21.45])
 by mail.igalia.com with esmtp (Exim)
 id 1rpVl3-00Cwt8-L1; Wed, 27 Mar 2024 17:04:11 +0100
Received: from localhost ([127.0.0.1] helo=webmail.igalia.com)
 by webmail.service.igalia.com with esmtp (Exim 4.96)
 (envelope-from <cgmeiner@igalia.com>) id 1rpVl3-004v1I-1Q;
 Wed, 27 Mar 2024 17:04:09 +0100
MIME-Version: 1.0
Date: Wed, 27 Mar 2024 16:04:09 +0000
From: Christian Gmeiner <cgmeiner@igalia.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: baruch@tkos.co.il, trini@konsulko.com, josua@solid-run.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH] mx6cuboxi: Convert to watchdog driver model
In-Reply-To: <20240327141849.2126157-1-festevam@gmail.com>
References: <20240327141849.2126157-1-festevam@gmail.com>
Message-ID: <9eadf309c5c617bb6f4792889a8f674a@igalia.com>
X-Sender: cgmeiner@igalia.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 27 Mar 2024 17:39:52 +0100
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

On 2024-03-27 14:18, Fabio Estevam wrote:
> Commit 68dcbdd594d4 ("ARM: imx: Add weak default reset_cpu()") caused
> the 'reset' command in U-Boot to not cause a board reset.
> 
> Fix it by switching to the watchdog driver model via sysreset, which
> is the preferred method for implementing the watchdog reset.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
> Christian,
> 
> Can you test this, please?
> 

Sure.

Before the patch:

U-Boot 2024.04-rc5-00003-g774ec4fda8 (Mar 27 2024 - 16:48:35 +0100)

CPU:   Freescale i.MX6Q rev1.3 996 MHz (running at 792 MHz)
CPU:   Extended Commercial temperature grade (-20C to 105C) at 36C
Reset cause: POR
Model: SolidRun HummingBoard2 Dual/Quad (1.5som+emmc)
Board: MX6 Cubox-i
DRAM:  2 GiB
Core:  82 devices, 17 uclasses, devicetree: fit
MMC:   FSL_SDHC: 1, FSL_SDHC: 2
Loading Environment from MMC... *** Warning - bad CRC, using default
environment

In:    serial
Out:   serial
Err:   serial
Net:   eth0: ethernet@2188000
Hit any key to stop autoboot:  0 
=> 
=> reset
resetting ...
=> 
=> 
=> reset
resetting ...
=> 
=> 


After the patch:


U-Boot 2024.04-rc5-00003-g3988fdb94c (Mar 27 2024 - 17:00:03 +0100)

CPU:   Freescale i.MX6Q rev1.3 996 MHz (running at 792 MHz)
CPU:   Extended Commercial temperature grade (-20C to 105C) at 36C
Reset cause: POR
Model: SolidRun HummingBoard2 Dual/Quad (1.5som+emmc)
Board: MX6 Cubox-i
DRAM:  2 GiB
Core:  84 devices, 19 uclasses, devicetree: fit
WDT:   Started watchdog@20bc000 with servicing every 1000ms (128s
timeout)
MMC:   FSL_SDHC: 1, FSL_SDHC: 2
Loading Environment from MMC... *** Warning - bad CRC, using default
environment

In:    serial
Out:   serial
Err:   serial
Net:   eth0: ethernet@2188000
Hit any key to stop autoboot:  0 
=> 
=> 
=> reset
resetting ...

U-Boot SPL 2024.04-rc5-00003-g3988fdb94c (Mar 27 2024 - 17:00:03 +0100)
WDT:   Started watchdog@20bc000 with servicing every 1000ms (128s
timeout)
...



Tested-by: Christian Gmeiner <cgmeiner@igalia.com>

Thanks & Regards,
Christian
