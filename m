Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7798EF43697
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:45:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FBD78431E;
	Fri, 17 Apr 2026 14:44:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=seznam.cz header.i=@seznam.cz header.b="YLrmdOXX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B7828424E; Thu, 16 Apr 2026 21:16:21 +0200 (CEST)
Received: from mxd-1-a09.seznam.cz (mxd-1-a09.seznam.cz
 [IPv6:2a02:598:128:8a00::1000:a09])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C532D8423F
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 21:16:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Michael.Srba@seznam.cz
Received: from email.seznam.cz by smtpc-mxd-fd5c5cd95-bfmjc
 (smtpc-mxd-fd5c5cd95-bfmjc [2a02:598:128:8a00::1000:a09])
 id 00a1bb8e5bafefe7010877d0; Thu, 16 Apr 2026 21:15:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
 t=1776366924; bh=Jw19iE2UMoq45L/PTVPsC5e85l/1bMc+oqP09UFxcTo=;
 h=Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
 Content-Language:From:Content-Type:Content-Transfer-Encoding;
 b=YLrmdOXXLM5OjmNSGUOO/O6CeAV7vL2skKKAI+FGnVLyqhmbcJ0wC9qTT85qKQ4hq
 f8Nw6wW9cM8+I6N/1WQ9JmKFCmraei2PsvaTHkiv59X3z2QUOHOLVrxNAqHf8muaF/
 ZsQ0P6i8YzOCZ646TwXYkZdeM6n/S/dwQHMUb+uoQVPk/y56DqmpFC1Axkm9VeQkdN
 biNfxQXLBFS8qKxRT+8Pc/qYyIhTpscIPaK7o6YfeddPG0Kxz+UYAJ0jgUouImBt+t
 SswNH5m9M6dGDJqhqkzhjsS+Rt9ZbGpa1N3vI9NQwG2zXKesW2DqUfucGWNw7NER3j
 YMWthILlnKWqA==
Received: from [192.168.0.240] (ip-111-27.static.ccinternet.cz
 [147.161.27.111])
 by smtpd-relay-6597cc8696-j2tv7 (szn-email-smtpd/2.0.72) with ESMTPA
 id a49c71a6-6f82-438d-a658-ff9fe4254ff6;
 Thu, 16 Apr 2026 21:15:19 +0200
Message-ID: <c2f3199f-480a-4d28-840d-f29bd9e5f0b9@seznam.cz>
Date: Thu, 16 Apr 2026 21:15:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/10] mach-snapdragon: boot0.h: add sdm845_spl_boot0.h
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
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Alexey Charkov <alchark@gmail.com>, Ronald Wahl <ronald.wahl@legrand.com>
References: <20260411-qcom_spl-v2-0-9609557cf562@seznam.cz>
 <20260411-qcom_spl-v2-7-9609557cf562@seznam.cz>
 <CAFLszTicL2M709+Mm3g1bdnVcYwcuX4SOEPKjbqW1SuJ8LF+2g@mail.gmail.com>
Content-Language: en-US
From: Michael Srba <Michael.Srba@seznam.cz>
In-Reply-To: <CAFLszTicL2M709+Mm3g1bdnVcYwcuX4SOEPKjbqW1SuJ8LF+2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 17 Apr 2026 14:43:59 +0200
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

On 4/11/26 17:40, Simon Glass wrote:
> Hi Michael,
>
> On 2026-04-11T00:00:12, Michael Srba <michael.srba@seznam.cz> wrote:
>> mach-snapdragon: boot0.h: add sdm845_spl_boot0.h
>>
>> On sdm845, running u-boot SPL in EL3 requires escalting by using
>> an unintentional feature in old builds of xbl_sec.elf. We do this
>> in boot0.h so the rest of U-Boot can stay blissfully unaware
>> of XBL_SEC. If we are already in EL3 for whatever reason, the
>> code is skipped.
>>
>> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
>>
>> arch/arm/mach-snapdragon/include/mach/boot0.h      |   4 +
>>   .../include/mach/sdm845_spl_boot0.h                | 120 +++++++++++++++++++++
>>   2 files changed, 124 insertions(+)
>> diff --git a/arch/arm/mach-snapdragon/include/mach/sdm845_spl_boot0.h b/arch/arm/mach-snapdragon/include/mach/sdm845_spl_boot0.h
>> @@ -0,0 +1,120 @@
>> +.macro movl Wn, imm
>> +    movz    \Xn,  \imm & 0xFFFF
>> +    movk    \Xn, (\imm >> 16) & 0xFFFF, lsl 16
>> +.endm
> The macro parameter is named Wn but the body references \Xn - does
> this actually build?
I'm not sure why it displays like that for you, both for me locally and on
https://lore.kernel.org/all/20260411-qcom_spl-v2-7-9609557cf562@seznam.cz/
it displays correctly...
>> @@ -0,0 +1,120 @@
>> +.macro movq Xn, imm
>> +    movz    \Xn,  \imm & 0xFFFF
> Similar issue to above - also please use tabs to indent.
>
>> @@ -0,0 +1,120 @@
>> +el3_payload:
>> +     /* disable the mmu for EL3 too */
>> +     mrs     x0, sctlr_el3
>> +     and     x0, x0, #~(1 << 0) // CTRL_M
>> +     msr     sctlr_el3, x0
>> +
>> +     /* jump back to our code, but now in EL3 */
>> +     movl    x0, CONFIG_SPL_TEXT_BASE
>> +     add     x0, x0, (el3_ret_point - _start)
>> +     br      x0
>> +el3_payload_end:
> After disabling the MMU in EL3 shouldn't you have an ISB before the branch?
>
> Regards,
> Simon

