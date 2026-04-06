Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F250FB5173
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 23:26:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C83F8352B;
	Tue,  7 Apr 2026 01:26:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=seznam.cz header.i=@seznam.cz header.b="ExZdLM4w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA65383EC6; Tue,  7 Apr 2026 00:44:35 +0200 (CEST)
Received: from mxd-1-a04.seznam.cz (mxd-1-a04.seznam.cz
 [IPv6:2a02:598:128:8a00::1000:a04])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7534B8352B
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 00:44:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Michael.Srba@seznam.cz
Received: from email.seznam.cz by smtpc-mxd-7644845457-4tx79
 (smtpc-mxd-7644845457-4tx79 [2a02:598:128:8a00::1000:a04])
 id 03e88bef58e6df86024147b1; Tue, 07 Apr 2026 00:43:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
 t=1775515418; bh=hVvU18/Oz4SyoSqT1PQnYgSuKR+i06cvkOtHJkBeeSc=;
 h=Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
 Content-Language:From:Content-Type:Content-Transfer-Encoding;
 b=ExZdLM4wkea46Zb2mrZclKSasVlJ+kwElU9/Mqy17ybNFIsK70qcWASq16fCQFSo7
 fTwyTMJZW7ubw26YkmUEQC5RS74/wg3sswsQKjnObiPOBk2gyGBh3dAYKQkf6UsQ+Z
 emmGpryE3GEUepd/DdCGKJ2FxpNKnEv82h2L4HOU+mVjG5irAs7RjRgvE4YsRP0cXH
 i/PhO9glIhkwDOniE1SkVYoUbw+wR35MfsYw1eRFmbMqs/P0ttP6URJhQo5lAC/bnl
 63VbcxLn6IOJoIrmxTfTy96l73hvIsimZsNgb4x7NhmyO8FncNRN7Ak+EsdfsohRrr
 +1QkLYR1vxbjQ==
Received: from [192.168.0.240] (ip-111-27.static.ccinternet.cz
 [147.161.27.111])
 by smtpd-relay-789d8dfb5c-8xvwn (szn-email-smtpd/2.0.71) with ESMTPA
 id 0ea1d4a6-2f0c-4e93-adcb-3ae9483f7d52;
 Tue, 07 Apr 2026 00:43:07 +0200
Message-ID: <be4b085e-cafe-4d68-bb80-7c929b0060d5@seznam.cz>
Date: Tue, 7 Apr 2026 00:43:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] Makefile: add SPL_REMAKE_ELF_LDSCRIPT feature
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
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
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
References: <20260404-qcom_spl-v1-0-9e6c2ac66587@seznam.cz>
 <20260404-qcom_spl-v1-1-9e6c2ac66587@seznam.cz>
 <CAFLszThhVEp3EH1Rqb6acPzJ6TbPc0p0thCG0+PHHCruKGz=iQ@mail.gmail.com>
Content-Language: en-US
From: Michael Srba <Michael.Srba@seznam.cz>
In-Reply-To: <CAFLszThhVEp3EH1Rqb6acPzJ6TbPc0p0thCG0+PHHCruKGz=iQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 07 Apr 2026 01:26:10 +0200
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

On 4/6/26 17:50, Simon Glass wrote:
> Hi Michael,
>
> On 2026-04-03T23:18:18, Michael Srba <michael.srba@seznam.cz> wrote:
>> Makefile: add SPL_REMAKE_ELF_LDSCRIPT feature
>>
>> On some platforms (at least Qualcomm), the bootrom expects an ELF file.
>> Since the contents of the ELF file are platform specific, add a config
>> option that allows specifying a linker script to use to produce the
>> ELF file.
>>
>> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
>> diff --git a/Makefile b/Makefile
>> @@ -2014,6 +2017,26 @@ u-boot-elf.lds: arch/u-boot-elf.lds prepare FORCE
>> +quiet_cmd_u-boot-spl-elf ?= LD      $@
>> +     cmd_u-boot-spl-elf ?= $(LD) spl/u-boot-spl-elf.o -o $@ \
>> +     -T spl/u-boot-spl-elf.lds --defsym=$(CONFIG_PLATFORM_ELFENTRY)=$(CONFIG_SPL_TEXT_BASE) \
>> +     -Ttext=$(CONFIG_SPL_TEXT_BASE) -z max-page-size=0x1000
> The existing cmd_u-boot-spl-elf includes $(if
> $(CONFIG_SYS_BIG_ENDIAN),-EB,-EL) for endianness. Please can you add
> the same here for consistency.
>
> Since this redefines cmd_u-boot-spl-elf using ?=, the earlier
> definition takes precedence if both SPL_REMAKE_ELF and
> SPL_REMAKE_ELF_LDSCRIPT are enabled. This is probably fine since
> enabling both does not make sense, but maybe add 'depends on
> !SPL_REMAKE_ELF' or a note in the Kconfig help text.
Hi,
slowly going through the reviews, I think when I originally worked on this
u-boot didn't support remaking SPL into an ELF at all. I completely missed
this change when rebasing (or didn't miss it, made a mental note, and
completely forgot... hard to say at this point).

I could certainly just
add a conditional, though there's probably cleaner ways to do this where
only the linker script is conditional (not sure what to do about the page
size, would need to test to double check if it's even actually necessary).

Actually, making the linker script path default to the standard one would be
the cleanest option by some measures, but since you didn't suggest it
I assume that's not your preferred solution?

>
>> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
>> @@ -247,6 +247,12 @@ config SPL_HANDOFF
>> +config SPL_REMAKE_ELF_LDSCRIPT
>> +     string "Linker script to run with u-boot-spl.bin as input"
>> +     help
>> +       This allows specifying a linker script that will act on u-boot-spl.bin
>> +       (see also REMAKE_ELF)
> Can you explain when you would need a custom linker script rather than
> just using SPL_REMAKE_ELF ?. Something like:
>
> Some platforms (e.g. Qualcomm) require the bootrom to load a custom
> ELF format. Unlike SPL_REMAKE_ELF which uses a standard linker script,
> this allows a platform-specific one.
Can do
> Regards,
> Simon

