Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E03F94CB0
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 21:12:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8E7A842C7;
	Tue, 21 Apr 2026 23:12:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=seznam.cz header.i=@seznam.cz header.b="fspeGuhE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79DB8839D5; Tue, 21 Apr 2026 23:07:44 +0200 (CEST)
Received: from mxd-1-a09.seznam.cz (mxd-1-a09.seznam.cz
 [IPv6:2a02:598:128:8a00::1000:a09])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2325A805D7
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 23:07:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Michael.Srba@seznam.cz
Received: from email.seznam.cz by smtpc-mxd-fd5c5cd95-bfmjc
 (smtpc-mxd-fd5c5cd95-bfmjc [2a02:598:128:8a00::1000:a09])
 id 2a022c57710c783e2babe009; Tue, 21 Apr 2026 23:07:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
 t=1776805620; bh=4Yis+iKZha4owRezLg6rjoQ5lnJwxkONuHsqqn6zpPg=;
 h=Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
 Content-Language:From:Content-Type:Content-Transfer-Encoding;
 b=fspeGuhEO8vidv0n1ciooUBtncRNgMOhRyJheutZkSrVdQZYvtMql5g+r1kSmBcUh
 r5RxGZ0ROAOozuOuSS3COjsUu0y6IHrT1Y6YDu5SoRxnhrM2a4JjKNHtQnQIHgvx3y
 kbLiCiyZ2X/VcPblwjeOPXTq2kMMHS8oU5N1QX6Cy9VY33ep2dwYw93slihMZNJgrP
 mH737RTf21LqerbOXRm7lPG+P3BQUBxlKkWTTKk3DojJ0dO3j1TpuLZNl8ER56etJP
 X3xUSaQN8Yp+jSrMktCCc4hrdklI5O7kB65hehylXPKNOfZqH8OKQO4Fw8pWByCoQt
 p02j7ysmNHQBQ==
Received: from [10.8.0.3] ([130.61.229.222])
 by smtpd-relay-7c7c659656-rb5ts (szn-email-smtpd/2.0.72) with ESMTPA
 id be58aa00-505d-44c3-b2b4-34d349650ef4;
 Tue, 21 Apr 2026 23:06:02 +0200
Message-ID: <5958da60-b8b1-40bb-bc66-5589a3d5ba7f@seznam.cz>
Date: Tue, 21 Apr 2026 23:05:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/11] drivers: allow clk_stub and spmi in SPL
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Ye Li <ye.li@nxp.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Dhruva Gole <d-gole@ti.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Jerome Forissier <jerome.forissier@arm.com>, Heiko Schocher
 <hs@nabladev.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, Yao Zi <me@ziyao.cc>,
 Peter Korsgaard <peter@korsgaard.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Alice Guo <alice.guo@nxp.com>,
 George Chan <gchan9527@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Alexey Charkov <alchark@gmail.com>, Ronald Wahl <ronald.wahl@legrand.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
References: <20260421-qcom_spl-v3-0-efee3f76754d@seznam.cz>
 <20260421-qcom_spl-v3-3-efee3f76754d@seznam.cz>
 <20260421204651.GB41863@bill-the-cat>
Content-Language: en-US
From: Michael Srba <Michael.Srba@seznam.cz>
In-Reply-To: <20260421204651.GB41863@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 21 Apr 2026 23:12:41 +0200
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

Hi,

On 4/21/26 22:46, Tom Rini wrote:
> On Tue, Apr 21, 2026 at 09:43:46PM +0200, michael.srba@seznam.cz wrote:
>
>> From: Michael Srba <Michael.Srba@seznam.cz>
>>
>> Only Makefile and Kconfig changes necessary.
>>
>> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
>> ---
>>   drivers/Makefile      |  2 +-
>>   drivers/clk/Kconfig   |  7 +++++++
>>   drivers/spmi/Kconfig  | 13 +++++++++++++
>>   drivers/spmi/Makefile |  4 ++--
>>   4 files changed, 23 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/Makefile b/drivers/Makefile
>> index 43d0ba33281..477718ce89a 100644
>> --- a/drivers/Makefile
>> +++ b/drivers/Makefile
>> @@ -35,6 +35,7 @@ obj-$(CONFIG_$(PHASE_)RAM) += ram/
>>   obj-$(CONFIG_$(PHASE_)RTC) += rtc/
>>   obj-$(CONFIG_$(PHASE_)SERIAL) += serial/
>>   obj-$(CONFIG_$(PHASE_)SPI) += spi/
>> +obj-$(CONFIG_$(PHASE_)SPMI) += spmi/
>>   obj-$(CONFIG_$(PHASE_)TIMER) += timer/
>>   obj-$(CONFIG_$(PHASE_)VIRTIO) += virtio/
>>   obj-$(CONFIG_$(PHASE_)DM_MAILBOX) += mailbox/
>> @@ -106,7 +107,6 @@ obj-$(CONFIG_DM_REBOOT_MODE) += reboot-mode/
>>   obj-y += rtc/
>>   obj-y += scsi/
>>   obj-y += sound/
>> -obj-y += spmi/
>>   obj-y += watchdog/
>>   obj-$(CONFIG_QE) += qe/
>>   obj-$(CONFIG_U_QE) += qe/
> Code-wise this is fine. But this reminds me, did you run this whole
> series through CI? Thanks.
I tried, but on gitlab.org it just didn't work at all, and locally it only ran partially
before running out of disk space. I tried making an account
on https://source.denx.de but the anti-spam measure is blocking me
and I'm waiting to see if that gets resolved (since it's not clear to me if
the unblocking is supposed to be automatic or not, and if it's manual
then just waiting is probably all I need to do) (fwiw not sure if that
instance allows random users to run the CI, the docs don't really
say *where* I'm supposed to run it, but I figured it was worth a try)

Before it ran out of space, it successfully built the documentation,
so I hoped that would be good enough (since I don't really see any
other way for me to run the CI at this time)

For what it's worth, checkpatch reports some issues with boot0.h, but
I strongly suspect that's because it assumes it's C code rather than
assembly.
>

