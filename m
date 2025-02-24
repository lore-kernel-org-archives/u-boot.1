Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE46EC021B5
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 08:20:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18ECD80079;
	Mon, 24 Feb 2025 09:20:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="iG5wKYrE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87A69805C3; Mon, 24 Feb 2025 09:20:46 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74D9380017
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 09:20:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1740385241; x=1740990041; i=xypron.glpk@gmx.de;
 bh=2EKVQelaSz59RmZOB4Tz0ZtqHCZ2TrcAX9cDOFh9OtA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=iG5wKYrEW9gyjp2sq3UzgIipHeXzr4ofuAOcijAUJHYb6aV+AgfLr3MxHdo4Mxug
 H6DiTxSg2jgQbIS20oDy/qolrWaEXdEC+yqYNDuwPTcT2b05zG3X8JParubkz+aPZ
 /dLmIDNb+aKFU/I/pfRML3LYGCBujvZqbRFpT4J6Hk72Omd1R3UYp7SPuCDprcNAz
 6divhyynXedIsw0bVXGMOO0wO03r9z9QFvadFZq54WsC3Ia13DD7BoWLzKAY85KDn
 dSAAjek+etPc9Z0BOIGFY0KS/9ARBCfHpf5yr7asLNPYgpBQClWH81EDxAPc5GRsq
 3AjovdVyDAxcpDU+3A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhlGq-1t92DI43VY-00oBxw; Mon, 24
 Feb 2025 09:20:41 +0100
Message-ID: <fe6585a0-e0e5-4686-97b5-aee51b5cdd00@gmx.de>
Date: Mon, 24 Feb 2025 09:20:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/17] arm: Use -mstrict-align when the MMU is off
To: Sam Edwards <cfsworks@gmail.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>
References: <20250224055524.1334929-1-CFSworks@gmail.com>
 <20250224055524.1334929-7-CFSworks@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250224055524.1334929-7-CFSworks@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8BPRHQW+6/I5DEnwyS34zh2PpG2Ycx2iHGPZuyXlROSFzvj8B2d
 hd+vQ7ltcNYeNPwjahLCOppqqApLr3Xv30fJojTORLSAUvzgXh64z3L6qoCgIiLa1kbSjOh
 M4vNGelAuCJzmBBaX3+KlalCaY60szLTaeLLR3Ba/TOesbD3sHzvars2vMLM1zKgpKHdtbO
 YZzj5orgkZ369haDg6X3w==
UI-OutboundReport: notjunk:1;M01:P0:RjHbD5VI6Gc=;Xghj8ab5/OqaF6LOSwdV2g3ElH6
 LESrOtd7w1ZXkYEz7QkHLSt43E/OM4Gfg9dGZL/XBx7uW95x7nr8Rz2Dl/Ozt99jEZCMtHvX1
 o3LZVXRJ/PfnZjAt039IpaXXdKy4lYWxkc2MygsGfatdClWx4y7KWOzzNkvhOWkQ6aKTY/W3Z
 anK+Tz2aHQf+RzG+8+MJOXr2O1gVwtyGYt3K/aMhl3Jn/4YLPI8vMvqK6y8YejQU7qk0OcEhC
 t0/492TtGdTfosCDnZnEdphXxD9gCg3+A0OIqmSzG0i8WkfJo92rcZBWsTjcZrLbgh0iSMVJu
 LQsdCPqsMIP5YamWukAjjHFZJMuuFZu4ij+6rr//cXCW+4PT3ZKBs0db53NEFrkF1SshBdPpQ
 99dcmleRd5yU2w+SXMjKXlHfivgseoGQbMdy72f7Pjrna3ryiHYRLw/bp+4IGJRXridO7a9iv
 JYNqmyldHVwW4VkMyQmSySI3pJi2+ZPYy3wTaM2hgLhdqZK//qnIzneMJ1PTNfdUhntbpsZKG
 HR/fCfHSrAmXnSX6HolmHtoecu/3zEQxnumGITEfJ6lDgV/IPaQu6TUhfXLlt70uLnr42S7yP
 mLLj36oKlNoPkelCpXI3+HPY7zMSadA3agkPBZdYnDCu20vXwiOLpaFe7Tde/2huCSCtvUVbs
 p6HDOPACHevZs9ABwa96p2NVdw8Rl+qLDW0i7EkYNjgKFQpVfPT/XgqB6tmdk5TlSmra+yufh
 mupSq+dI+k+TUOy6s4eKxVRah4f/Wfi05K2uQ7RSgrZjKO0P3zaqTu7bQ1zlSiXjhKY4pqbER
 82V9dgbKSmDeLe8ixf9B7iXOm2XZlpLioEPZVQ4R3706E1UXMBFExi0Ut9/LRvBR+PMCM6n+Q
 lEf0s8uhuL2/uAi52PjCBfTVJHSGHXFFDis/QeB4k1ZtcLv+bglPGZqAtep3NylZkO3+/NIMt
 3titXcjzc85uZmTiBHG6OMo9dZamnrVXyhahx0ZQFsBe3ZEOaJuAh9zSC2wmKWrurjIf2ulwJ
 KPPYwmD/WoWsncJ2Of/gwDSIezPVhj4OCF9lAa4AtvcBH9rLZnX5ZsIMbxw42kcq4dDrJFr6F
 vZ257yphhESDRdHvJxJCjGiPfSb4aWpljF1AWHd3lqyExqjRmHyLus0RIAN+PGwXqzv7QQNMI
 Qn3DYzwp88FDym2qvk9KF26R6ROyOjtyurO2j0lcYAalUIPC22GqiwbGkYsraDmSpFzvusOp4
 4cob499fPCgTKAP2wAr2UPKhzNuzMNlMtyrqMqmYEXHcZjEpEc74n9MXs6fDhdoUR1CA84ZeI
 XS1pIyDYCznZtAe5IDx5fPmRl5Ud6dAoi8uNMnr/wErreJD0KSRH66hGdww+pRiPnoT7FglD4
 HyHupFiyPGJWuOVbXbXyRBk8bgOzT9B+27TyccjseV5W1SVFd4k40CXiPg
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

On 2/24/25 06:55, Sam Edwards wrote:
> On ARM, enabling the MMU is a prerequisite to enabling caching, which
> allows unaligned memory accesses by consolidating them into aligned
> accesses. When the MMU is disabled, however, all accesses must strictly
> adhere to the alignment rules.
>
> Some compilers (e.g. Clang) contain optimizations that may break these
> rules on the assumption that misaligned accesses merely incur a
> performance penalty. We do not necessarily want to prevent the compiler
> from applying these optimizations where it believes there may be net
> gains, but we do need to tell it to respect the alignment requirements
> when the MMU is disabled.
>
> Therefore, add the `-mstrict-align` compiler flag when SYS_ARM_MMU is
> not set.
>
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> ---
>   arch/arm/config.mk | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/config.mk b/arch/arm/config.mk
> index e0045e22271..98237b251f1 100644
> --- a/arch/arm/config.mk
> +++ b/arch/arm/config.mk
> @@ -33,6 +33,10 @@ PLATFORM_RELFLAGS	+=3D $(LLVM_RELFLAGS)
>
>   PLATFORM_CPPFLAGS +=3D -D__ARM__
>
> +ifneq ($(CONFIG_SYS_ARM_MMU),y)
> +PLATFORM_RELFLAGS +=3D -mstrict-align

We don't set CONFIG_SYS_ARM_MMU on armv8 though we initialize the MMU.

The flag -mstrict-align seems only to exist for 64bit ARM and is already
set in arch/arm/cpu/armv8/config.mk.

On 32-bit ARM there is a flag -mno-unaligned-access which we set in
arch/arm/cpu/armv7/config.mk and arch/arm/cpu/armv7m/config.mk.

Here are some places we forbid unaligned access irrespective of
CONFIG_SYS_ARM_MMU:

arch/arm/cpu/arm1136/start.S:80:        orr     r0, r0, #0x00000002
@ set bit 1 (A) Align
arch/arm/cpu/arm1176/start.S:82:        orr     r0, r0, #0x00000002
@ set bit 1 (A) Align
arch/arm/cpu/arm920t/start.S:81:        orr     r0, r0, #0x00000002
@ set bit 1 (A) Align
arch/arm/cpu/arm926ejs/start.S:102:     orr     r0, r0, #0x00000002
/* set bit 1 (A) Align */
arch/arm/cpu/arm946es/start.S:88:       orr     r0, r0, #0x00000002
/* set bit 1 (A) Align */
arch/arm/cpu/armv7/start.S:229: orr     r0, r0, #0x00000002     @ set
bit 1 (--A-) Align

Best regards

Heinrich

> +endif
> +
>   ifdef CONFIG_ARM64
>   PLATFORM_ELFFLAGS +=3D -B aarch64 -O elf64-littleaarch64
>   else

