Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF11C44529
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 14:14:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DB2A380AAB;
	Tue, 21 Jul 2026 14:14:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0dVpayIX6REp; Tue, 21 Jul 2026 14:14:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 10D1180AD5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784643269;
	bh=3rGuPDJMdhBGBSq44pWyrOz1HnBa05Rz46FctNzdJlY=;
	h=To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=rSew532BEMNC09cCkhpnx3hUtyJyiz4qlhk75Bn2MPvYDPO0vbKUyVBkVrO+mB+Pk
	 4odf51mXtAxJJC/fmnuTW2qnBeszyg+N98CrXUkp5e2VCw+IexvGpuZCqlKodXqtt6
	 KgPPr+QIMC6KiQHS3bU3mEZqSIZU0ZH1wuZJY8FknsDhC5HR6s61DD/tSdBvl8JXQ7
	 BlPdIcVX7ZXmrnou7B4jL3kvRxosw4nc66N410BIFAoBYVBZD5KKEZvVO4ZVof+Xxi
	 Xtue8tcSOkPMJZJw5CDvp3p51z3VEFeO3njaVXxApVeLSTQ0v9bkPK3Y5vHUFLPjZP
	 DSgUd9XJQYo0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 10D1180AD5;
	Tue, 21 Jul 2026 14:14:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8B01C109B
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 14:14:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7912480838
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 14:14:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T0bdVe-PSr3M for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 14:14:26 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 4755680A95
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4755680A95
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4755680A95
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 14:14:26 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id A97AF84659; Tue, 21 Jul 2026 16:14:24 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14873803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 16:14:22 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 269B243480;
 Tue, 21 Jul 2026 14:14:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A9021F000E9;
 Tue, 21 Jul 2026 14:14:19 +0000 (UTC)
To: =?utf-8?B?5Zu96LGq?= <guohaoprc@163.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>
Cc: Anshul Dalal <anshuld@ti.com>, "Guillaume La Roque (TI.com)"
 <glaroque@baylibre.com>, u-boot@lists.denx.de, Bryan Brattlof <bb@ti.com>,
 Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Vishal Mahaveer <vishalm@ti.com>, Peng Fan
 <peng.fan@nxp.com>
Subject: Re:Re: [PATCH] board: ti: am62x: Fix build without TI_I2C_BOARD_DETECT
In-Reply-To: <7b7be0c1.8185.19f841a7a0c.Coremail.guohaoprc@163.com>
References: <20260715-am62x-no-board-detect-v1-1-2969faec1001@163.com>
 <178418750029.393743.12900440415467707713.b4-review@b4>
 <87a4rkkbe7.fsf@kernel.org>
 <7b7be0c1.8185.19f841a7a0c.Coremail.guohaoprc@163.com>
Date: Tue, 21 Jul 2026 16:14:17 +0200
Message-ID: <87v7a8ig5i.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1784643260;
 bh=3rGuPDJMdhBGBSq44pWyrOz1HnBa05Rz46FctNzdJlY=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=gfvLDMsbZNbkElpu1jb7yQzfB41uSnrxK1j0osy+yLPfMA/Zh4fNA8Zz8eBIvKcc5
 fBeC5od3g4zqh4l4qVqCl4UAske5bpo8CrkgYVWps8VAgQMM3WSLKwB4Hkc10HwVed
 rcTIDO8uODKu4PnSAIkEIIUzALt9au64SBf8Z11emzrh4983dkI5hjT3dVcZBmFoW5
 l4FfKsrZLAvyAcPlFDiTNjLCak/QBwiLjfqjYygXJkJoGD47Ki5LROqq6Fb9Rg/3MO
 MCl6nqeg0X+C03n8U/k1xI6yD0i9SmDvUrDkI2+PDj8x3sYYm4JREqPjjBKD2ICW4D
 J+ymUnL4rM9pA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=gfvLDMsb
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="gfvLDMsb"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Mattijs Korpershoek via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Tue, Jul 21, 2026 at 17:55, =E5=9B=BD=E8=B1=AA  <guohaoprc@163.com> wrot=
e:

> Hi,
>
>
> Thanks for the question.
>
>
> My use case is a third-party board based on the AM6254 SoC, rather than a=
 TI
> EVM. The board reuses the common AM62x EVM boot flow, but it does not hav=
e a TI
> AM6-compatible board EEPROM. Its board identity and device tree selection=
 are
> fixed by the board configuration.

I see, thanks for the explanation.
I think that this should be mentioned in the commit message.

>
>
> I verified this behavior on the board. With TI_I2C_BOARD_DETECT enabled, =
U-Boot
> probes I2C addresses 0x50 and 0x51, and both probes fail. The AM62x late-=
init
> code then sets:
>
>
>         board_name=3Dam62x_skevm
>         board_rev=3Dunknown
>         board_software_revision=3Dunknown
>         board_serial=3Dunknown
>         serial#=3D0000000000000000
>
>
> This information is incorrect for the third-party board. Its configuration
> therefore uses:
>
>
>         CONFIG_BOARD_LATE_INIT=3Dy
>         # CONFIG_TI_I2C_BOARD_DETECT is not set
>
>
> This keeps the board late-init hook, including the fdtfile setup, while
> disabling the TI EVM EEPROM detection.
>
>
> The submitted patch fixes the build error for this valid configuration. I=
 am
> also fine with the suggested no-op stubs, provided they preserve the beha=
vior
> of not applying EVM fallback information or setting a serial number when =
board
> detection is disabled.

I have a slight preference for adding setup_board_eeprom_env() and
setup_serial_am6() as no-op stubs. But I'm not the TI board maintainer
so I let them decide.

>
>
> I limited this patch to AM62x, which is the platform I tested. I agree th=
at the
> same pattern should be addressed for the other affected platforms as well.
>
>
> Best regards,
> Guo Hao
>
>
>
> At 2026-07-21 16:14:08, "Mattijs Korpershoek" <mkorpershoek@kernel.org> w=
rote:
>>On Thu, Jul 16, 2026 at 13:08, Anshul Dalal <anshuld@ti.com> wrote:
>>
>>> On Wed, 15 Jul 2026 11:32:26 +0800, Guo Hao <guohaoprc@163.com> wrote:
>>>> setup_board_eeprom_env() and setup_serial_am6() are only available when
>>>> TI_I2C_BOARD_DETECT is enabled.
>>>>=20
>>>> IS_ENABLED() does not remove the guarded statements during preprocessi=
ng,
>>>> so disabling TI_I2C_BOARD_DETECT results in an implicit function
>>>> declaration error. Use a preprocessor condition to match the condition
>>>> used for the function definition.
>>>>=20
>>>> Fixes: ff1b83c095c2 ("board: am62x: Add support for reading eeprom dat=
a")
>>>> Signed-off-by: Guo Hao <guohaoprc@163.com>
>>>
>>> This is a valid fix however I wonder if there's an actual use-case wher=
e someone
>>> might want to disable TI_I2C_BOARD_DETECT on an EVM board.
>>
>>I agree with Anshul here. What's the use use-case for disabling i2c
>>board detection?
>>
>>Also, if we really want it disabled, we could also create stub functions
>>instead of replacing this.
>>
>>>
>>> Also, it looks like the same issue exists for other platforms too (AM64=
x, AM65x,
>>> J721s2 ...).
>>>
>>> --=20
>>> Anshul Dalal <anshuld@ti.com>
