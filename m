Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09321D41D68
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 08:07:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AD2689383;
	Tue, 12 Nov 2024 09:07:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBAA28878A; Tue, 12 Nov 2024 04:07:21 +0100 (CET)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67E97888BE
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 04:07:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=hal.feng@linux.starfivetech.com
X-QQ-mid: bizesmtpsz4t1731380783tar10vj
X-QQ-Originating-IP: RJZLgsQGp6qXVHy36jUZZUUOX8I31KtMnZEcnvCIv6s=
Received: from [192.168.125.182] ( [183.27.99.69])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 12 Nov 2024 11:06:21 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12984989738745342617
Message-ID: <AC6CC7B59AED601B+eec260dc-44a4-40b8-8134-b309c0781574@linux.starfivetech.com>
Date: Tue, 12 Nov 2024 11:06:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/13] riscv: dts: jh7110: Drop redundant devicetree
 files
Content-Language: en-US
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hal Feng <hal.feng@starfivetech.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>, u-boot@lists.denx.de,
 Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 H Bell <dmoo_dv@protonmail.com>, E Shattow <lucent@gmail.com>,
 Conor Dooley <conor.dooley@microchip.com>, Nam Cao <namcao@linutronix.de>,
 Bo Gan <ganboing@gmail.com>
References: <20241111020808.38974-1-hal.feng@starfivetech.com>
 <20241111020808.38974-3-hal.feng@starfivetech.com>
 <e152cc16-7501-4c60-92e7-d967a03bcfc9@gmx.de>
From: Hal Feng <hal.feng@linux.starfivetech.com>
In-Reply-To: <e152cc16-7501-4c60-92e7-d967a03bcfc9@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:linux.starfivetech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: NimHjVa2t/kILMqQYE0N60IOGG/7EwP0jrB8+MIQCfMs9DNFTj1M/ltJ
 PwWfdFpcGQx1GuT8P3/5QxQhWdpL8tPEx68nVNyoXdtnrMxbrDEnxTm0DNxHsvWoIfViYz3
 a2L5ZtH3TQjyzx/THm4/F/jgAvu7iq51cSjDHyK4zadfQ18T8cV0dO1eq+/ZLSLOlxw3svW
 L72/BNOOZjHV+4k3x2B+uflpk+LfyXqhGd9NK37yFcQnJ59EU/E391gEyxTGWH/gbyHet5A
 QlVhCR8TAw5owHbUqGfp7TFyb/f4eCULsi5xKkhVYxpIBb78PHFPNKR3VHSykYGko1hE+Dh
 AOjj4wJ5OJ8w3zEvUi8+73GbD5PO9Jlqxu9sFCmazXRoJ+qN5dUJJXNo1IEIJNHuv1923Pw
 G8kgQDDXUDMzaMn24NwjM37x/KQPbSoIDeB7ySg5c089cR3+c7MYQ0bQwnmSHAh5Z2HAnt6
 dNroH7Dz+CkLqCHfsQyTkdyIG61gumaeoazejdrfeAuCLlar2FO69j30p45CvDPguOcnovD
 J6Fca8mp8wnVHLqnv3cmkXQksjtXpcsUUVC46kgk7cvu1ZcYbfETt1EMmS0/lvqDNF4hz3x
 KOcxftn3W4X6GfnBDr8WupTRF/p7NOn5QMCaTFv898PImz5C6cew0UCwyhwQu8vwyk4HM5i
 8aPUd0Rh41YdvzzZUEvQI8k/t56+ouEcBWEruc9pcnBL0pQ6GcirMXA2yKkSdubFrwNP18y
 Go5qJjht9Fc8V3PsvT4hlrAsH2YqYQxUKYJCL1BwzK5ssrm/kymcxjeHGU6OSjnA8RH7b0V
 phPSfAHZW7em8Dwz2G2rlJs4jci487y8F5aEPnKfOSdMi83nFujai9VvIsnQVsVNIN3TJGL
 fT6uYwHET8n6Vhhj0PjC6ZFSKhciMho0/Z4Z8ineuqpkGnjxNdKJqvZOWhbrnFOpetp2Bas
 fUFSi01YlFvnm5CB0eTrnYShe88+Gy/5ZoEc=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Tue, 12 Nov 2024 09:07:28 +0100
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

On 11/11/2024 6:26 PM, Heinrich Schuchardt wrote:
> On 11/11/24 03:07, Hal Feng wrote:
>> JH7110 boards switch to using upstream DT, so drop
>> redundant DT files from arch/riscv/dts/.
>>
>> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> 
> I added paches 1/13 and 2/13 to origin/master.
> 
> make starfive_visionfive2_defconfig
> make
> 
> yielded the following error:
> 
>   DTC
> dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2-v1.3b.dtb
> Error: dts/upstream/src/riscv/starfive/jh7110.dtsi:518.15-16 syntax error
> FATAL ERROR: Unable to parse input tree
> Check
> /home/zfsdt/workspace/u-boot-build/denx/dts/upstream/src/riscv/starfive/.jh7110-starfive-visionfive-2-v1.3b.dtb.pre.tmp
> for errors
> make[2]: *** [scripts/Makefile.lib:423:
> dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2-v1.3b.dtb]
> Error 1
> make[1]: *** [dts/Makefile:60: arch-dtbs] Error 2
> make: *** [Makefile:1175: dts/dt.dtb] Error 2
> make: *** Waiting for unfinished jobs....
> 
> include/dt-bindings/clock/starfive,jh7110-crg.h
> which does *not* include the symbol JH7110_SYSCLK_TDM_TDM is evaluated
> instead of
> dts/upstream/include/dt-bindings/clock/starfive,jh7110-crg.h
> which contains the symbol JH7110_SYSCLK_TDM_TDM.
> 
> We want git bisect to work. Hence we must ensure that after each
> individual patch building works.
> 
> Before merging the series we need a patch ensuring that upstream
> includes are used.
> 

The include/ dir is included before dts/upstream/include/. To make
git bisect work, one choice here is merging patch 1~5 together.

Best regards,
Hal
