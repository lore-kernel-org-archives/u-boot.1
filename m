Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5311CC4451C
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 08:14:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EC3A260810;
	Tue, 21 Jul 2026 08:14:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kmy2KKAJRbni; Tue, 21 Jul 2026 08:14:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 315F5607FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784621660;
	bh=YLwPYYoAJuVTwFMMJHNBdlzsOiT+gSNb1dBJNG9n0GY=;
	h=To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=NaQmbOWKXYxAw4DECDhJ6mC/f8PXBWnWdmmjsF91cqQdNihmbE/HAPXG09/XITQjE
	 1r3bDfi4ByyPp6w3lR7QPMSK6po7BYqZY1AWSu0aoMJayMtOK+VPjVvTsesD1RBKle
	 i2LZxP3cXfJxGdNnmXdwlD+uQH/F7v8DY42g38QfGTAMPf/iNpypBzVlwAXShNpyGy
	 6O2sE3T4Wnqr9jsarv3t8LLFj7SnyQgKt37//8lRtZ7SVOk/mdjMR+CohppFmJF/aU
	 CZAWNVaisL1xkFGkRl7KgEXUoWaJn1DK3JNFeo+8JvCl2qUUtuAjUxR1dDa5n6oAju
	 bRIN3jCIkVvSA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 315F5607FA;
	Tue, 21 Jul 2026 08:14:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D672C42A
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 08:14:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C8C16607E5
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 08:14:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pHf9j-T8L3Rc for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 08:14:17 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 06D2F607FA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 06D2F607FA
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 06D2F607FA
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 08:14:16 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69866844F6; Tue, 21 Jul 2026 10:14:15 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58AC5803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 10:14:13 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 089D960A9B;
 Tue, 21 Jul 2026 08:14:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FABE1F000E9;
 Tue, 21 Jul 2026 08:14:11 +0000 (UTC)
To: Anshul Dalal <anshuld@ti.com>, Guo Hao <guohaoprc@163.com>
Cc: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>, Mattijs
 Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de, Bryan
 Brattlof <bb@ti.com>, Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>,
 Patrice
 Chotard <patrice.chotard@foss.st.com>, Vishal Mahaveer <vishalm@ti.com>,
 Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] board: ti: am62x: Fix build without TI_I2C_BOARD_DETECT
In-Reply-To: <178418750029.393743.12900440415467707713.b4-review@b4>
References: <20260715-am62x-no-board-detect-v1-1-2969faec1001@163.com>
 <178418750029.393743.12900440415467707713.b4-review@b4>
Date: Tue, 21 Jul 2026 10:14:08 +0200
Message-ID: <87a4rkkbe7.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1784621651;
 bh=YLwPYYoAJuVTwFMMJHNBdlzsOiT+gSNb1dBJNG9n0GY=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=QfQ+c58SFlnTpCAM09EvgdzPqXe9HwWum3zGoCjSuRN3EAYFnz8/PggNfd5q+CBdq
 GtJUk780RbYK8H6IBOdAKpPnJra1gspZm4PNL335Njjmm0chiNKFNGnTq/tE5SNy75
 /B53B1Dw9qt4mExFpdUqhqaambM6bTz7RNgbwDSua3VpoQgVOIQVS7XQKiIAinYnL3
 XcaQ7NgHBrtzMi8AZ+nQhkPE1w9JKssCqS9nSIpmYB5Y60Zet/bB8S55uZrWNCrSpy
 LfoWcHM0Z2LuRinE8ydtL46AfHy4p3TT2jvy8V0rjSofaQIlJCpCAuJRHArADmujn9
 XTGnTEGxNfOqg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=QfQ+c58S
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="QfQ+c58S"; 
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

On Thu, Jul 16, 2026 at 13:08, Anshul Dalal <anshuld@ti.com> wrote:

> On Wed, 15 Jul 2026 11:32:26 +0800, Guo Hao <guohaoprc@163.com> wrote:
>> setup_board_eeprom_env() and setup_serial_am6() are only available when
>> TI_I2C_BOARD_DETECT is enabled.
>> 
>> IS_ENABLED() does not remove the guarded statements during preprocessing,
>> so disabling TI_I2C_BOARD_DETECT results in an implicit function
>> declaration error. Use a preprocessor condition to match the condition
>> used for the function definition.
>> 
>> Fixes: ff1b83c095c2 ("board: am62x: Add support for reading eeprom data")
>> Signed-off-by: Guo Hao <guohaoprc@163.com>
>
> This is a valid fix however I wonder if there's an actual use-case where someone
> might want to disable TI_I2C_BOARD_DETECT on an EVM board.

I agree with Anshul here. What's the use use-case for disabling i2c
board detection?

Also, if we really want it disabled, we could also create stub functions
instead of replacing this.

>
> Also, it looks like the same issue exists for other platforms too (AM64x, AM65x,
> J721s2 ...).
>
> -- 
> Anshul Dalal <anshuld@ti.com>
