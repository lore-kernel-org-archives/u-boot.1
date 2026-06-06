Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26376CD8C8C
	for <u-boot@archiver.kernel.org>; Sun,  7 Jun 2026 05:11:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58FB88063E;
	Sun,  7 Jun 2026 07:11:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=smankusors.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=smankusors.com header.i=@smankusors.com header.b="o49psvvZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98A4A839DF; Sat,  6 Jun 2026 23:37:18 +0200 (CEST)
Received: from serval.cherry.relay.mailchannels.net
 (serval.cherry.relay.mailchannels.net [23.83.223.163])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 308C18063E
 for <u-boot@lists.denx.de>; Sat,  6 Jun 2026 23:37:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=smankusors.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux@smankusors.com
X-Sender-Id: hostingeremail|x-authuser|linux@smankusors.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 80F254014C9;
 Sat, 06 Jun 2026 21:37:14 +0000 (UTC)
Received: from fr-int-smtpout29.hostinger.io
 (trex-green-3.trex.outbound.svc.cluster.local [100.106.45.226])
 (Authenticated sender: hostingeremail)
 by relay.mailchannels.net (Postfix) with ESMTPA id 1C78C401253;
 Sat, 06 Jun 2026 21:37:06 +0000 (UTC)
X-Sender-Id: hostingeremail|x-authuser|linux@smankusors.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: hostingeremail|x-authuser|linux@smankusors.com
X-MailChannels-Auth-Id: hostingeremail
X-Language-Arithmetic: 07e2cb6839c20599_1780781834318_3406739272
X-MC-Loop-Signature: 1780781834318:1460125317
X-MC-Ingress-Time: 1780781834318
Received: from fr-int-smtpout29.hostinger.io (fr-int-smtpout29.hostinger.io
 [148.222.54.18]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.106.45.226 (trex/7.1.5); Sat, 06 Jun 2026 21:37:14 +0000
Received: from [192.168.1.100] (unknown [125.163.201.137])
 (Authenticated sender: linux@smankusors.com)
 by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4gXs8B1g1hz2xYd;
 Sat,  6 Jun 2026 21:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smankusors.com;
 s=hostingermail-a; t=1780781825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PMql9wOKsv+UvPsAnIg5+y0fsCp+NkrIIkBSrGNb0Cc=;
 b=o49psvvZJwqaOlS4XvVAZqwMh/dplnl2a1qTjbfOq3OkPdxKPvT6kAe03mnfMAVwVOTt31
 HWVXACV6ggPcIsP29imD4YDbApgW6IHNwQntV3ohxGvRd7MnSmpcWcolODpqA1pfbvqt+X
 j/rhuaqS7yNkUif3GnbBDyo3TZ+3akC6HnZOXbu26cqvozMF/lEEI4zGcibnPVCWztR7Sm
 QaVp2uueWI/WKJyV0AcTWHBrb136Ldro4LIhD818rOkorbpozACuIt5KLUX/iRNJBJ/7tQ
 ZQPV/bmNIsFODo3rSsxLmaoTw0QQ+lrI2wHCE2QzhhGASPqPdAwh4UTyy23QZg==
Message-ID: <05a3ecdc-ab97-4942-b597-a05bfcd2bc7c@smankusors.com>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 00/16] MSM8960 / mach-snapdragon ARMv7 support
To: me@samcday.com, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Eugen Hristev <ehristev@kernel.org>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Yao Zi <me@ziyao.cc>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, George Chan <gchan9527@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Anshul Dalal <anshuld@ti.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Tingting Meng <tingting.meng@altera.com>,
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Lukasz Majewski <lukma@denx.de>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Jens Reidel <adrian@mainlining.org>
References: <20260601-qcom-armv7-v1-0-05a08d87e476@samcday.com>
Content-Language: en-US
From: Antony Kurniawan Soemardi <linux@smankusors.com>
In-Reply-To: <20260601-qcom-armv7-v1-0-05a08d87e476@samcday.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Date: Sat,  6 Jun 2026 21:36:58 +0000 (UTC)
X-CM-Analysis: v=2.4 cv=GMJaEfNK c=1 sm=1 tr=0 ts=6a249301
 a=CaeAY4CxSq97IgnVPYXnTg==:117 a=CaeAY4CxSq97IgnVPYXnTg==:17
 a=IkcTkHD0fZMA:10 a=lKQ-AihTAAAA:8 a=l3ijUGStESE0n0ih24MA:9 a=QEXdDO2ut3YA:10
 a=K6G5NyU7usMl-irPePdK:22
X-CM-Envelope: MS4xfEYsYz0JIN76WR9VngxolyLj8hTWjJ3t77Rsf4EOBxsmSeue9s52u5udhE8V5y0kgIPf/46CYs559uXkOXN1uNzE4POX8q2oby3a13V3EvOIOzl4Efeo
 ieBn90keC61oP83PQhkbSc7yHuemkm28gt5xr3lB9hsJMfmS/h0nlr/ZkmffA1YhPtLwPcYC35dqIwkHOuib5b9KZQX7j5lCBeGxmJVEIxCb3INshca9xLEL
 beQt7nQ9qNPqPLCcwonlB37C9b/EqvPhzaCXU6wO3FQtHMFvEUPqORWVrCng/vj69njQ6cJjuiQfNxigNX1OmgXEkh4cFWg867W9pXvX6ZxpgzRUaLgdu8ts
 g3mfVFw2fZrtNp3m26RGwbaOaEbMRaNdbM39uLmP44QEg3s5oJFErKFIfhAa/8x5PhGCCaCQI2TywAOekCChT/2VT1RW4TOlrBEY0E8+Vlk8zT5bAln4Q+pe
 gOiTZzuzCc3DiXG4W1+lq2kA0Wpfqy1XLalcrU4AyCQ+LGu7bNMcD71XMuPvZ/4/fW6vIJB+3td0o9WNo3m9Y+zxRNP5ZzMkaW7p22RBp3byZgHdWdnPMVr5
 E6RGKS7347CwKG4Piw22Pl4Ot9RCJ0JrPD6KK5MyzaqAoLwYpmEuFAjIw7IHNT0P8qCqENKOxQZ9zTd7MTxlScWAtoeR9GyCQ1wO0T1ZwCWygOzMzzFGwWUf
 IJxrofDwYVpmMx024Ui/wzmN8RBWghU+A3/flBTCiuYzayUduYeZX2uktX4uCufsFG3wi+xa8qY8+Em+50Q7SbjEhG3nGp+It7BG7+C/PxyoHEQOIwCN1hHI
 CHCnx+NUi/Q6wMJusIV8bGpRj61RFN67pX7bPeyMTjOmmT8BqrOktxUIf9wEZCAJSPE+K11R72tq+rIs1m5oQ48EqscTBRrcDxgcy01Mz2hoglBnhoaHcRfD
 qT+8+dKuafVHB95
 Ckm0WaCM28Q8WNvyyczTl8WU4O2KWfRdTPCWZgsfS61LZMgKBJ8AddjjiEpZoh1cXQaNR/cX6fet1wyKsaoMFalZMCp9fTa1ME7ax4LJF
 UEmDDY9DFLYJVHUn5L0rFAyFfgeFCl/qOH58qIBRuPamxVfPnK0+6AgOjJXoXIX6N/8XOq9YDImasyZPquP9qznzl0eAzRtU4yOOaX35i7aytZ1aiD9umYf4
 3BOofnADZn82T2KE+boBcqizv7+OM+rZJvxPMq1IxBKUucD+bkHbZuBo4j7wFhz/nIx+wcPCldUNYcUS14j8JE599RNltsOsiHvPG3siO5p7O2yOJWyKHsB8
 JdAk0u+qe+uc2eCsnmjPeZEiXleHOw==
X-AuthUser: linux@smankusors.com
X-Mailman-Approved-At: Sun, 07 Jun 2026 07:11:15 +0200
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

On 6/1/2026 3:12 PM, Sam Day via B4 Relay wrote:
> ** Resending because I found new ways to dislike Proton Mail (it failed
> the series midway due to "spamming". Sigh.). **
> 
> This patch series introduces support for ARMv7 Qualcomm SoCs, starting
> with MSM8960/MSM8930/MSM8227.
> 
> An overview of the changes:
>   * serial_msm reintroduces the previous packed RX/TX software mode
>     operation, as this is compatible with all UARTDM versions (1.4 and
>     older). It's added alongside the newer single-char mode for 1.4.
>   * A timer driver is introduced for KPSS. I don't know if *all* ARMv7
>     qcom SoCs lack generic ARM CP15 debug timer support, but at least
>     MSM8960/MSM8930 do.
>   * mach-snapdragon board code is shuffled around a bit to build cleanly
>     on ARM64.
>   * prev_bl_data support is extended to ARM32 (which uses r2 for passing
>     FDT/ATAGS pointers, rather than r0)
>   * qcom_parse_memory is revised to support arm32 memory nodes (which are
>     1-cell rather than 2-cell).
>   * Basic ATAGS support is introduced, so that the memory info can be
>     used from previous bootloaders that do not understand FDTs at all.
>   * PS_HOLD sysreset and pinctrl-qcom needed some minor tweaks to handle
>     some nuances that challenge the current assumptions.
>   * A pinctrl driver is introduced for MSM8960.
>   * Initial MSM8960 GCC infra is introduced.
> 
> I tested this series on:
>   * Nokia Lumia 520 (msm8227). No working buttons yet as these are
>     exposed as GPIO-over-PMIC-over-SSBI (drivers will be proposed at a
>     later date).
>   * Samsung Galaxy Express GT-I8730 (msm8930). Volume rockers + home
>     button are working via the new pinctrl-msm8960 driver. Power
>     button not working yet (needs PMIC driver infra).
>   * I have no msm8960/apq8064 devices, looking for folks to test those.
> 
> To confirm there was no regressions with ARM64 and/or newer devices, I
> also tested on:
>   * db410c (msm8916)
>   * google-sargo (sdm670)
> 
> Signed-off-by: Sam Day <me@samcday.com>
> ---
> Sam Day (16):
>        serial: msm: UARTDM <1.4 support
>        timer: Qualcomm KPSS timer support
>        arm: save_prev_bl_data: ARM32 support
>        mach-snapdragon: qcom_parse_memory 32-bit support
>        mach-snapdragon: gate ARM64 features
>        mach-snapdragon: introduce ARCH_SNAPDRAGON_ARM32
>        configs: introduce qcom_armv7_defconfig
>        board: qualcomm: add MSM8960 debug UART config
>        sysreset: qcom-pshold: offset support
>        pinctrl: qcom: configurable GPIO offset/stride
>        pinctrl: qcom: introduce MSM8960 driver
>        mach-snapdragon: parse incoming ARM32 ATAGS
>        clk: qcom: MSM8960 GCC driver
>        clk: qcom: arch-agnostic pointer fmtstrings
>        serial: msm: wait for TX empty before reinit
>        button: remap phone HOMEPAGE button
> 
>   arch/arm/Kconfig                             |  11 +-
>   arch/arm/lib/save_prev_bl_data.c             |  49 ++++---
>   arch/arm/mach-snapdragon/Kconfig             |   6 +
>   arch/arm/mach-snapdragon/board.c             | 188 ++++++++++++++++++--------
>   arch/arm/mach-snapdragon/include/mach/gpio.h |  12 +-
>   board/qualcomm/debug-msm8960.config          |   5 +
>   configs/qcom_armv7_defconfig                 |  61 +++++++++
>   drivers/button/Kconfig                       |   2 +-
>   drivers/button/button-uclass.c               |   1 +
>   drivers/clk/qcom/Kconfig                     |   8 ++
>   drivers/clk/qcom/Makefile                    |   1 +
>   drivers/clk/qcom/clock-msm8960.c             | 189 +++++++++++++++++++++++++++
>   drivers/clk/qcom/clock-qcom.c                |   8 +-
>   drivers/gpio/msm_gpio.c                      |   2 +-
>   drivers/pinctrl/qcom/Kconfig                 |   9 ++
>   drivers/pinctrl/qcom/Makefile                |   1 +
>   drivers/pinctrl/qcom/pinctrl-msm8960.c       | 135 +++++++++++++++++++
>   drivers/pinctrl/qcom/pinctrl-qcom.c          |   2 +-
>   drivers/serial/serial_msm.c                  | 142 +++++++++++++++++---
>   drivers/sysreset/sysreset_qcom-pshold.c      |   9 +-
>   drivers/timer/Kconfig                        |   7 +
>   drivers/timer/Makefile                       |   1 +
>   drivers/timer/qcom-kpss-timer.c              |  98 ++++++++++++++
>   23 files changed, 843 insertions(+), 104 deletions(-)
> ---
> base-commit: 8d3ba3753bdb5068884196ff696cc48177bfdda5
> change-id: 20260530-qcom-armv7-1486308a835c
> 
> Best regards,

This looks great! I have a Sony Xperia SP (MSM8960T) and would like to 
test it.

Before I dive in, I need to clarify the build setup:

- For cross-compilation, should I use `CROSS_COMPILE=arm-none-eabi-`?
- Which defconfig is appropriate for the Xperia SP?
- Is the config generated with `make qcom_armv7_defconfig 
qcom-phone.config`?

Would appreciate a quick pointer on the build workflow.

-- 
Thanks,
Antony K. S.
