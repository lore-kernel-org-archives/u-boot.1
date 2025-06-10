Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91DFBC5B552
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 10:50:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E93E680E9A;
	Tue, 10 Jun 2025 12:50:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=zugschlus.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06E0A82A39; Tue, 10 Jun 2025 12:50:13 +0200 (CEST)
Received: from torres.zugschlus.de (torres.zugschlus.de
 [IPv6:2a01:238:43fa:bc01::28:100])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 276608070C
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 12:50:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=zugschlus.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mh+u-boot@zugschlus.de
Received: from mh by torres.zugschlus.de with local (Exim 4.96)
 (envelope-from <mh+u-boot@zugschlus.de>) id 1uOwYV-0020p8-07
 for u-boot@lists.denx.de; Tue, 10 Jun 2025 12:50:11 +0200
Date: Tue, 10 Jun 2025 12:50:11 +0200
From: Marc Haber <mh+u-boot@zugschlus.de>
To: u-boot@lists.denx.de
Subject: Re: Searching and Finding boot.scr and uboot.env on a Raspberry Pi 4
Message-ID: <aEgN40XL0D8gIg0F@torres.zugschlus.de>
References: <aEcOkQdwEF9zNJu2@torres.zugschlus.de>
 <dc51ba46-010e-4fc5-a0bd-88c758940e96@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <dc51ba46-010e-4fc5-a0bd-88c758940e96@cherry.de>
User-Agent: Mutt/2.2.12 (2023-09-09)
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

Hi Quentin,

thanks for answering. I really appreciate that.

On Tue, Jun 10, 2025 at 12:36:23PM +0200, Quentin Schulz wrote:
>On Theobroma boards (Rockchip-based), we force the environment to be 
>coming from the same storage medium as U-Boot proper, c.f. 
>board/theobroma-systems/common/common.c:arch_env_get_location()
>
>This is the location of the U-Boot environment in raw, not in a 
>filesystem, so this won't apply to your use-case.

Sadly ;-)

>But quickly looking at env/fat.c which makes use of the 
>CONFIG_ENV_FAT* variables from above, it seems like you should be able 
>to override env_fat_get_intf and env_fat_get_dev_part from a board 
>file and implement what you want there, provided U-Boot (and/or the 
>RPi firmware) provides you with the information from where it was 
>booted.

Can I get u-boot to somehow log where it is looking for files? That way 
I wouldn't have to guess where to put a board file.

>If you don't want to change the U-Boot binary and somehow you can have 
>a minimal environment to run a few commands, you could probably erase 
>the whole environment and re-import it manually with `env import`?

As far as I have understood, if u-boot finds neither its environment 
file or a boot.scr (that one comes from the environment as well, right?) 
it just sits there doing nothing. It's that first step that I don't 
understand.

If a change can be made while keeping backwards compatibility, I figure 
I can talk to the u-boot maintainer of Debian, or rebuild the 
u-boot-raspi package myself as a last resort. I just don't have a clue 
(yet) what and where to touch. I am still on the lower end of my u-boot 
learning curve.

Greetings
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Leimen, Germany    |  lose things."    Winona Ryder | Fon: *49 6224 1600402
Nordisch by Nature |  How to make an American Quilt | Fax: *49 6224 1600421
