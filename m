Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41020CCF9F8
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 19:48:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE81D83ABA;
	Fri, 31 Oct 2025 20:48:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="orAtRnj4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1B9083ABF; Fri, 31 Oct 2025 20:48:33 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03949839AC
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 20:48:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=f3a5=5J=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1761940109;
 bh=MZNbSr6cR96aIKX4XziRiZJa3ZxYKs1wkpUy0qGt2uU=;
 b=orAtRnj4KUe0YD6N3EaAUK8Auxu7hZmmaXQ8FAx05t+HFI3Hgl+3iiBnnU92uXhAXYM6EQRWJ
 v+yGrRPZE7E2/reBrfS/7PC/XW/l2ENxjjxja003OquVEUMGO5n2cbacUiNehfrgWaraN/5hLXb
 IVCLIfbKDcqw0Py1KawzOTJRXIfWnt3xaPuEeiUep4vDoshXEO7p0z46l1hW0LCpMyWSHUdm4Y5
 MKuLPIPneg/mbeRZvqHZemKEweajYaCcX8Sog1RfLA0GuTy8sNKAcRuIlrJZURUEB0PJNRW/3uG
 Dy67n1Gwg87N3X0A4fPa32YPYPHQCsz0zMxzIOW9E+Qw==
X-Forward-Email-ID: 690512860a03120dafdb958a
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.4.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <97a6d067-8c57-48cb-ab9b-c5094a798d99@kwiboo.se>
Date: Fri, 31 Oct 2025 20:48:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [DEBUG] rk3399-nanopi-neo4: SPL SD init may report -5 due to SD
 power-on timing
To: Sune Brian <briansune@gmail.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <CAN7C2SArdbhag_56MwOMGoaEYSLiHbHHo3KFhUS5U03ntEJbGA@mail.gmail.com>
 <20251031191728.GG6688@bill-the-cat>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20251031191728.GG6688@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
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

Hi Brian,

On 10/31/2025 8:17 PM, Tom Rini wrote:
> On Fri, Oct 31, 2025 at 12:10:36PM +0800, Sune Brian wrote:
> 
>> Hello U-Boot maintainers,
>>
>> While testing mainline U-Boot (v2026.01-rc1-00070-ge34d01d23e45) on the
>> FriendlyARM NanoPi NEO4 (RK3399), I observed that SPL sometimes fails to
>> initialize the SD card with the following message:
>>
>>     spl: mmc init failed with error: -5
>>     SPL: failed to boot from all boot devices
>>
>> After investigation, the root cause appears to be related to the **SD card
>> power rail (`vcc3v0_sd`) timing during SPL startup**. On the NanoPi NEO4,
>> the SD slot is powered via GPIO0_A1 to a fixed 3.0 V supply. SPL may attempt
>> MMC initialization **before this supply has fully stabilized**, resulting in
>> a generic I/O error (`-5`). The SD card itself and the controller are
>> functioning correctly once the supply is stable.
>>
>> **Workarounds / fixes observed:**
>> - Add a small delay after enabling `vcc3v0_sd` before SPL starts MMC init.
>> - Ensure the regulator is fully powered and stable at SPL start.
>>
>> This appears to be a **hardware/platform-specific power-on timing issue**
>> rather than a device tree or software bug, but documenting it would help
>> users encountering similar errors on the NanoPi NEO4.

U-Boot v2025.07-rc4 changed how sd-card regulators are handled for the
nanopi4 family of boards.

Is your issue specific to a reboot or cold boot?

Try adding something like following to rk3399-nanopi-neo4-u-boot.dtsi
to add a 2ms delay to ensure the voltage for the vcc3v0_sd regulator is
stabilized when it is enabled. Or any other timing that is required.

&vcc3v0_sd {
	startup-delay-us = <2000>;
};

I only have a NanoPi M4B from the nanopi4 family to run tests on.

Regards,
Jonas

>>
>> **Hardware:** FriendlyARM NanoPi NEO4
>> **SoC:** Rockchip RK3399
>> **U-Boot version:** v2026.01-rc1-00070-ge34d01d23e45
>> **Reproducibility:** 100% with SD boot
> 
> Adding the board maintainer and come other active rockchip people.
> 

