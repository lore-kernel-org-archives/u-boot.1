Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41CDCE77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 09:27:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C521E805EA;
	Tue,  7 Jan 2025 10:27:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736242023;
	bh=lqrUSgtw9SY2kxfgTM4jM8Eu3wdfs44Lp5StFJvl+wY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z2ZemXiXGxI1hal5+Z1YNVsJ/gY52HNRxBfxs5kFHxyO5am0CcXTutJkKlLL+8r+g
	 EDro1uk468b0UItsWWug7qsYhUdlRgMyrXMQD+0qAFcPUSwc/63dEF4AScIRdkgCyZ
	 OdsfCfaNzGO4jXTzyelvmO94cFlzfLkc9c/ukNAIZl60StVxNP/ve6IFNl1apj/VBg
	 RS5RbvVNXFJl8UAXUygEICDwe/Ygux4uIB8fPKgB8dE+prohcuthWonH1Q4F69kiJt
	 vsIkOM5zuVn1e4DC45cPNq4AaP1XZXprOAC98vvGSEETNesFIRVC2JMg/41HVY6MFI
	 QRHpWBdwlf4FQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id B01E3805EA; Tue,  7 Jan 2025 10:27:02 +0100 (CET)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [80.241.59.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E8B680607
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 10:26:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4YS5KX2R0Pz9sq2;
 Tue,  7 Jan 2025 10:26:56 +0100 (CET)
Message-ID: <1a66d080-7504-4e79-b7bf-26630e6bc0ae@denx.de>
Date: Tue, 7 Jan 2025 10:26:55 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2] watchdog: rti: drop hack manipulating WDT clock rate
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>, u-boot@lists.denx.de
Cc: Jan Kiszka <jan.kiszka@siemens.com>
References: <20241121080326.1913067-1-alexander.sverdlin@siemens.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20241121080326.1913067-1-alexander.sverdlin@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 21.11.24 09:03, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> The hack itself seems to be copied from Linux rti_wdt.c, but the WDT reset
> principle is different in U-Boot. While Linux relies on correct frequencies
> and timers and doesn't check the actual WDT counter value U-Boot driver
> seems to be more robust: it does compare RTIDWDCNTR vs RTIDWDPRLD.
> 
> Now the root cause of the original motivation to manipulate the clock rate
> is said to be understood and fixed in Linux commit cae58516534e
> ("watchdog: rti_wdt: Set min_hw_heartbeat_ms to accommodate a safety margin")
> which simultaneously removed the hack itself.
> 
> While is fix part of the mentioned patch is neither applicable nor requried
> for the U-Boot driver just drop the hack setting WDT clock rate to 90% of
> the real rate. This has a nice effect that the WDT timeout is now as
> requested and not 10% shorter.
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> Changelog:
> v2: 2 typos pointed by Jan corrected

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

