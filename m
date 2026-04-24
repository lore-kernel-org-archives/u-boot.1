Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D80FF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 18:07:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05847844BA;
	Sat, 25 Apr 2026 20:03:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=seznam.cz header.i=@seznam.cz header.b="bkjO5pwV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 609EA843B8; Sat, 25 Apr 2026 18:55:42 +0200 (CEST)
Received: from mxd-1-a0b.seznam.cz (mxd-1-a0b.seznam.cz
 [IPv6:2a02:598:128:8a00::1000:a0b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 913C2842D7
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:55:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Michael.Srba@seznam.cz
Received: from email.seznam.cz by smtpc-mxd-68df9c878f-h6wlt
 (smtpc-mxd-68df9c878f-h6wlt [2a02:598:128:8a00::1000:a0b])
 id 62ee591939e00d7063479547; Sat, 25 Apr 2026 18:55:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
 t=1777136138; bh=2mLjNLY3USW5sllFNwfiJs4TfaZu4YeCncNyHCcJVa4=;
 h=Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
 Content-Language:From:Content-Type:Content-Transfer-Encoding;
 b=bkjO5pwVeKAxr/zhZXgenqLAoiJd9tBvFWCBV2XnYSEPWn3T9IVbc0OcxLdT3Ha8X
 Mh8FBpJCaNEdkyYcmeIT5+MjKjvygDH1eYI5yfDRfM7sOqKAt5gywL9y664TuI2QaQ
 tUDRCYlheTA+ob58ylQ6C1PevTYqiofgvc84HnBemyoxG1z9K3r8DU/AQW3zO2hXR5
 EQrexb3/6YgeHJf+BL4RTy1+51Hz0a6MJDojOvPrIkiejkJzFxX8PomfrE6njU9Uee
 7847txxkkmVwONzdv9BG5W82IO6QeSvFznZdMhU11YjP9kxmWOB6kCGMlvH4DqV6qe
 bUo05tU88MYxg==
Received: from [192.168.0.240] (ip-111-27.static.ccinternet.cz
 [147.161.27.111])
 by smtpd-relay-7c7c659656-jspbn (szn-email-smtpd/2.0.72) with ESMTPA
 id 4fb0051c-7bfd-4415-a64e-7d53641f53f9;
 Sat, 25 Apr 2026 00:46:05 +0200
Message-ID: <74bdca54-0780-4715-8c31-33019f2fe262@seznam.cz>
Date: Sat, 25 Apr 2026 00:46:03 +0200
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
 <5958da60-b8b1-40bb-bc66-5589a3d5ba7f@seznam.cz>
 <20260421211041.GC41863@bill-the-cat>
Content-Language: en-US
From: Michael Srba <Michael.Srba@seznam.cz>
In-Reply-To: <20260421211041.GC41863@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sat, 25 Apr 2026 20:03:18 +0200
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

On 4/21/26 23:10, Tom Rini wrote:
> On Tue, Apr 21, 2026 at 11:05:58PM +0200, Michael Srba wrote:
>> Hi,
>>
>> On 4/21/26 22:46, Tom Rini wrote:
>>> On Tue, Apr 21, 2026 at 09:43:46PM +0200, michael.srba@seznam.cz wrote:
>>>
>>>> From: Michael Srba <Michael.Srba@seznam.cz>
>>>>
>>>> Only Makefile and Kconfig changes necessary.
>>>>
>>>> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
>>>> ---
>>>>    drivers/Makefile      |  2 +-
>>>>    drivers/clk/Kconfig   |  7 +++++++
>>>>    drivers/spmi/Kconfig  | 13 +++++++++++++
>>>>    drivers/spmi/Makefile |  4 ++--
>>>>    4 files changed, 23 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/Makefile b/drivers/Makefile
>>>> index 43d0ba33281..477718ce89a 100644
>>>> --- a/drivers/Makefile
>>>> +++ b/drivers/Makefile
>>>> @@ -35,6 +35,7 @@ obj-$(CONFIG_$(PHASE_)RAM) += ram/
>>>>    obj-$(CONFIG_$(PHASE_)RTC) += rtc/
>>>>    obj-$(CONFIG_$(PHASE_)SERIAL) += serial/
>>>>    obj-$(CONFIG_$(PHASE_)SPI) += spi/
>>>> +obj-$(CONFIG_$(PHASE_)SPMI) += spmi/
>>>>    obj-$(CONFIG_$(PHASE_)TIMER) += timer/
>>>>    obj-$(CONFIG_$(PHASE_)VIRTIO) += virtio/
>>>>    obj-$(CONFIG_$(PHASE_)DM_MAILBOX) += mailbox/
>>>> @@ -106,7 +107,6 @@ obj-$(CONFIG_DM_REBOOT_MODE) += reboot-mode/
>>>>    obj-y += rtc/
>>>>    obj-y += scsi/
>>>>    obj-y += sound/
>>>> -obj-y += spmi/
>>>>    obj-y += watchdog/
>>>>    obj-$(CONFIG_QE) += qe/
>>>>    obj-$(CONFIG_U_QE) += qe/
>>> Code-wise this is fine. But this reminds me, did you run this whole
>>> series through CI? Thanks.
>> I tried, but on gitlab.org it just didn't work at all, and locally it only ran partially
>> before running out of disk space. I tried making an account
>> on https://source.denx.de but the anti-spam measure is blocking me
>> and I'm waiting to see if that gets resolved (since it's not clear to me if
>> the unblocking is supposed to be automatic or not, and if it's manual
>> then just waiting is probably all I need to do) (fwiw not sure if that
>> instance allows random users to run the CI, the docs don't really
>> say *where* I'm supposed to run it, but I figured it was worth a try)
> The thing with source.denx.de is that then you also need (manually) a
> contributor tree, for CI (and user accounts are more for bug filing). We
> have how to run CI via Azure documented here:
> https://docs.u-boot.org/en/latest/develop/ci_testing.html
>
> And my concern is changing "always traverse this directory" to "traverse
> once CONFIG_SPMI is set" shouldn't cause a problem. But sometimes
> there's platforms with unexpected (and invalid needing to be fixed)
> configurations out there.
>
I figured out the github workflow, quite straightforward in the end. There is only
one failing check, missing MAINTAINERS entry for the defconfig. Should I add
an entry in the same commit and put it under `u-boot-qcom@groups.io`?
