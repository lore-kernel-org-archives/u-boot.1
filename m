Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC09CA0ED3
	for <u-boot@archiver.kernel.org>; Wed,  4 Sep 2024 08:13:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED88388C9F;
	Wed,  4 Sep 2024 10:13:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725437616;
	bh=05Xq+cAA4wLZIwbRAvaimBlpwAl69x2f1fMjmFAU/nA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ItZztenDSY0UD365PGQzUg8Ri0oroXvnzYhwUTdvVS2lsdiW93fbPglcfW3oMDJ1T
	 J7xY1bEm+F/N+q8WEFIRN4JJWAtnXw3XHI6bqQZZIIfx8455Czv2S7v1G5KL63QK3R
	 XPIM8gq6u7wY+NCozI/5Il8aMkAKS+t8SidsSiDuTSTguQ8vcSeNVFS5Dm/Wf0zgTA
	 iGPxF2ikpitkgJNJuVu2ODiyvotf1iVWDbR7D6QPT6yCZTvhv5kEpqU1p9Vdpx5PvO
	 VtwMksDgp8lu+eJ2pQiDBEm/HmEwHpv4FI2OiU+kr0vxwiflebniMRIMABd+Mb9hW4
	 iGkCcv1V9+6SA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id E487D88CA0; Wed,  4 Sep 2024 10:13:34 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4F2788B23
 for <u-boot@lists.denx.de>; Wed,  4 Sep 2024 10:13:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4WzFcV3SQ1z9skq;
 Wed,  4 Sep 2024 10:13:30 +0200 (CEST)
Message-ID: <499e9fa9-12fd-4548-836e-8322126eca18@denx.de>
Date: Wed, 4 Sep 2024 10:13:29 +0200
MIME-Version: 1.0
Subject: Re: [PATCH u-boot-marvell 0/3] Turris Omnia DDR speed change with
 reset button (for 2024.10)
To: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc: u-boot@lists.denx.de
References: <20240829080849.20276-1-kabel@kernel.org>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20240829080849.20276-1-kabel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 8/29/24 10:08, Marek Behún wrote:
> Hello Stefan,
> 
> this series adds the ability to select 1333H DDR speed mode for DDR
> training (instead of the default 1600K) with the factory reset button.
> 
> If possible, I would like if this series went for U-Boot 2024.10
> release. The heavy stuff to support DDR speed change is already in,
> this just adds the ability to do it with reset button instead of
> console command (which is inconvenient for most users).
> 
> On Omnia, the user can select factory reset type by pressing the reset
> button on the rear panel and holding it. The front LEDs light on in
> sequence, representing a counter. Every ~2.5 second another LED lights
> on. When only the first LED is on, the board will do a standard reboot.
> Then different kinds of factory reboot will happen for reset types 1 to
> 7 (when 1, 2, ... or 7 LEDs are on) [1].
> 
> This series adds another reset type, number 10, which will make the
> board boot in 1333H DDR speed mode, and also write this setting to
> EEPROM, so that subsequent boots will also train in 1333H mode.
> 
> The user can set back the default mode with the `eeprom` U-Boot command,
> or with the `omnia-eeprom` Linux command.

Applied to u-boot-marvell/master

Thanks,
Stefan

> Marek
> 
> [1] https://docs.turris.cz/hw/omnia/rescue-modes/
> 
> Marek Behún (3):
>    arm: mvebu: turris_omnia: Rename variable holding EEPROM udevice
>    arm: mvebu: turris_omnia: Use the i2c_eeprom misc driver for EEPROM
>      reading in U-Boot proper
>    arm: mvebu: turris_omnia: Switch DDR speed to 1333H when reset 9 is
>      selected
> 
>   arch/arm/mach-mvebu/Kconfig              |   1 +
>   board/CZ.NIC/turris_omnia/turris_omnia.c | 101 +++++++++++++++++++----
>   configs/turris_omnia_defconfig           |   1 -
>   3 files changed, 86 insertions(+), 17 deletions(-)
> 

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
