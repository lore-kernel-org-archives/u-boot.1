Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CEADFF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 18:07:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AC12844D8;
	Sat, 25 Apr 2026 20:03:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=seznam.cz header.i=@seznam.cz header.b="HboBGov8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AF70842BF; Sat, 25 Apr 2026 19:01:45 +0200 (CEST)
Received: from mxd-3-71c.seznam.cz (mxd-3-71c.seznam.cz
 [IPv6:2a02:598:96:8a00::1200:71c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE53080087
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 19:01:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Michael.Srba@seznam.cz
Received: from email.seznam.cz by smtpc-mxd-68df9c878f-gdfk6
 (smtpc-mxd-68df9c878f-gdfk6 [2a02:598:96:8a00::1200:71c])
 id 36bbd02c6db5844537121c72; Sat, 25 Apr 2026 19:01:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
 t=1777136502; bh=/SaWiySK1VlT8Xh6zy8hStSqUnp9gICJ3C/gufNmazw=;
 h=Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
 Content-Language:From:Content-Type:Content-Transfer-Encoding;
 b=HboBGov8Jv5Y+gx6TqTiziuG6gDTC/l2j9/1nZpYCMeYbGvFNiW5vmGgGQBjF259P
 Dm85AbRdHbMISo506ux2rNECfvebnkKgbwgQHIXujMAp/Ut447P3baYSbqY8tTzIHD
 4lXfB/LgJIiyKciXfDBH/5qEGfot+jFSaL8EmzcK9y6np94hsvPnTciLgLvvBG7K3p
 hwwaeP8/+ZJA3M68y4BWq9cS4Jsg7RwYhJHYsuXIbYjRsezrnPWp1nWPoQRmJxl68i
 RzW5OM0JuNiFUoC329vnnWl3cz5cbBuozTHE3ZCeIB7NNjYiMQmlK346o3u5s6g64V
 7E6LigJzIhUmg==
Received: from [192.168.0.240] (ip-111-27.static.ccinternet.cz
 [147.161.27.111])
 by smtpd-relay-6597cc8696-6mkdd (szn-email-smtpd/2.0.72) with ESMTPA
 id 7baa3c3d-cb05-4424-b596-4aff9a4c02cf;
 Fri, 24 Apr 2026 19:05:05 +0200
Message-ID: <07351632-4572-4bd0-890b-c162ef0ba5d4@seznam.cz>
Date: Fri, 24 Apr 2026 19:05:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/11] Makefile: add SPL_REMAKE_ELF_LDSCRIPT feature
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
 <20260421-qcom_spl-v3-1-efee3f76754d@seznam.cz>
 <20260421204536.GA41863@bill-the-cat>
 <68690d5a-e48c-4ff7-920f-f0d4b65f5bec@seznam.cz>
 <20260424161955.GJ41863@bill-the-cat>
Content-Language: en-US
From: Michael Srba <Michael.Srba@seznam.cz>
In-Reply-To: <20260424161955.GJ41863@bill-the-cat>
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

On 4/24/26 18:19, Tom Rini wrote:
> On Fri, Apr 24, 2026 at 02:14:42AM +0200, Michael Srba wrote:
>> Hi,
>>
>> On 4/21/26 22:45, Tom Rini wrote:
>>> On Tue, Apr 21, 2026 at 09:43:44PM +0200, michael.srba@seznam.cz wrote:
>>>
>>>> From: Michael Srba <Michael.Srba@seznam.cz>
>>>>
>>>> Some platforms (e.g. least Qualcomm), use the ELF format in creative
>>>> ways, including in the bootrom. Make SPL_REMAKE_ELF use a linker script
>>>> specified in SPL_REMAKE_ELF_LDSCRIPT (with the previously hardcoded path
>>>> as the default).
>>>>
>>>> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
>>>> ---
>>>>    Makefile           | 10 ++++++++--
>>>>    common/spl/Kconfig | 10 ++++++++++
>>>>    2 files changed, 18 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/Makefile b/Makefile
>>>> index 8af18668b0f..50893d5689e 100644
>>>> --- a/Makefile
>>>> +++ b/Makefile
>>>> @@ -2004,16 +2004,22 @@ u-boot.elf: u-boot.bin u-boot-elf.lds FORCE
>>>>    quiet_cmd_u-boot-spl-elf ?= LD      $@
>>>>    	cmd_u-boot-spl-elf ?= $(LD) spl/u-boot-spl-elf.o -o $@ \
>>>>    	$(if $(CONFIG_SYS_BIG_ENDIAN),-EB,-EL) \
>>>> -	-T u-boot-elf.lds --defsym=$(CONFIG_PLATFORM_ELFENTRY)=$(CONFIG_SPL_TEXT_BASE) \
>>>> +	-T spl/u-boot-spl-elf.lds --defsym=$(CONFIG_PLATFORM_ELFENTRY)=$(CONFIG_SPL_TEXT_BASE) \
>>>>    	-Ttext=$(CONFIG_SPL_TEXT_BASE)
>>>> -spl/u-boot-spl.elf: spl/u-boot-spl.bin u-boot-elf.lds
>>>> +spl/u-boot-spl.elf: spl/u-boot-spl.bin spl/u-boot-spl-elf.lds
>>>>    	$(Q)$(OBJCOPY) -I binary $(PLATFORM_ELFFLAGS) $< spl/u-boot-spl-elf.o
>>>>    	$(call if_changed,u-boot-spl-elf)
>>>> +SPL_REMAKE_ELF_LDSCRIPT := $(addprefix $(srctree)/,$(CONFIG_SPL_REMAKE_ELF_LDSCRIPT:"%"=%))
>>>> +
>>>> +spl/u-boot-spl-elf.lds: $(SPL_REMAKE_ELF_LDSCRIPT) FORCE
>>>> +	$(call if_changed_dep,cpp_lds)
>>>> +
>>>>    u-boot-elf.lds: arch/u-boot-elf.lds prepare FORCE
>>>>    	$(call if_changed_dep,cpp_lds)
>>>>    PHONY += prepare0
>>>> +
>>>>    # MediaTek's ARM-based u-boot needs a header to contains its load address
>>>>    # which is parsed by the BootROM.
>>>>    # If the SPL build is enabled, the header will be added to the spl binary,
>>>> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
>>>> index d1a85f50209..1d279a2bb05 100644
>>>> --- a/common/spl/Kconfig
>>>> +++ b/common/spl/Kconfig
>>>> @@ -247,6 +247,16 @@ config SPL_HANDOFF
>>>>    	  proper. Also SPL can receive information from TPL in the same place
>>>>    	  if that is enabled.
>>>> +config SPL_REMAKE_ELF_LDSCRIPT
>>>> +	string "Linker script for SPL ELF"
>>>> +	depends on SPL_REMAKE_ELF
>>>> +	default "arch/$(ARCH)/u-boot-spl-elf.lds"
>>>> +	help
>>>> +	  This allows specifying a linker script that will act on u-boot-spl.bin.
>>>> +	  Some platforms (e.g Qualcomm) use the ELF format in creative ways,
>>>> +	  including in the bootrom. For such platforms, you can change the default
>>>> +	  linker script to a platform-specific one.
>>>> +
>>>>    config SPL_LDSCRIPT
>>>>    	string "Linker script for the SPL stage"
>>>>    	default "arch/arm/cpu/arm926ejs/sunxi/u-boot-spl.lds" if MACH_SUNIV
>>> Did what I said about cleaning up the remake elf Makefile logic itself
>>> get lost somewhere? Sorry. To repeat, we should have a remake elf
>>> function, make use of $(PHASE_) and have Kconfig entries for both
>>> REMAKE_ELF_LDSCRIPT and SPL_REMAKE_ELF_SCRIPT (so we can use $(PHASE_)
>>> again to get the right one. Thanks!
>>>
>> Trying to figure this out, I feel like I must be missing something...
>> It seems like $(PHASE_) is never going to be anything other than an empty
>> string inside the main Makefile?
>> While `libs-$(CONFIG_$(PHASE_)ALTERA_SDRAM) += drivers/ddr/altera/` would
>> make me think otherwise, most of the contents of the toplevel Makefile
>> strongly suggest that it's only ever executed once, rather than one time
>> for each of u-boot proper, spl, tpl, vpl. I have tried to use $(PHASE_)
>> anyway, but it really doesn't seem to work. Could you explain more
>> specifically how I should do this?
> I had thought this would work, yes. Does this mean the other cases of
> $(PHASE_) in the top-level Makefile also aren't working? And, is there
> some other Makefile where $(PHASE_) does indeed work, that we could move
> this particular logic to?
>
Yes, I'm pretty sure the other cases are also not working.
I don't see a way to do this "properly" with the current Makefile setup,
but obviously I don't know that much about it.
I think the cleanest way would be add a new Makefile, maybe
Makefile.foreachphase in scripts/ (or some shorter name), and have
the toplevel makefile do include magic to include it multiple times
with $(PHASE_) set (and probably stuff like $(phase) and/or $(BIN) too,
those currently don't exist at all but would be handy for obvious reasons).

In any case I would prefer if the current iteration could just go through
for now, since this looks like a non-trivial change that would better
be done by someone who spent more than two days trying to understand the
Makefile system.
