Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92259D111A7
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 22:35:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 025F383A71;
	Wed, 26 Nov 2025 23:35:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="CoLlfAhq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57B1883AAC; Wed, 26 Nov 2025 23:35:13 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65A0983A64
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 23:35:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1764196496; x=1764801296; i=xypron.glpk@gmx.de;
 bh=jDI8LM5HspZe22hMHjrFUKwiHDCAVoX0PlhzJcDHmhA=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=CoLlfAhqYxJgDP9Pr9NqzBv4KGkYg7Lr9rZJBeeV8cuiRzXBLhe+d3963DGwjnpp
 lrwfUaLPWQU0wJlYKXutzqvo5OT5Y35hBxk0B80mreVEqZwEyzMJLHuf6JCMLcvug
 GQeoSSRBFu3DfxMIt4Gi05LLsP1g2UYB/8tlPxzRwy1oU+aDl50AXSZEu31V811nj
 Vc/HQUoMNSO7jEcXZQAyctNUlupN+PMHx+5C2LdLuvT/nnpnYhTDa54oh+0r6wPF9
 9Pk8G+VY0fYS30lSDav/8okligDAWTLt98LU0flsVnu5fGypCYhcFcKA9xd21SwGU
 3Frze/OuGRhWT3/8Bg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ehlo.thunderbird.net ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MplXp-1vtwEk2jXR-00qSiQ; Wed, 26
 Nov 2025 23:34:55 +0100
Date: Wed, 26 Nov 2025 23:34:51 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: E Shattow <e@freeshell.de>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Tom Rini <trini@konsulko.com>
CC: u-boot@lists.denx.de, Icenowy Zheng <uwu@icenowy.me>
Subject: Re: [RFC PATCH v1 0/4] Add upstream board Xunlong Orange Pi RV
User-Agent: Thunderbird for Android
In-Reply-To: <20251126221552.87574-1-e@freeshell.de>
References: <20251126221552.87574-1-e@freeshell.de>
Message-ID: <B7BF64B9-B3C7-4885-B1F2-767D69298313@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0L3ne/9e0QaI803K/RtUwFwD57iXcILEhOsXRd/nsroQA4BBhGk
 h2JOb4fXm6E12VhAfNOSNtn7tk23+RQT8S4HaW1WHbimRsFU+W8m9CFQ6GhJ5UO7rXRcMCd
 DIclrtFtmdiWF1l2evUymvLWf3+gI+T6FFB73+vkkzDE/r3O9r2KUeT3PtHqfXLfSMU3i8I
 u00OHiYKNhgLUQX7hEO1w==
UI-OutboundReport: notjunk:1;M01:P0:uhUlDoq1L0M=;aSrsokGqL3sE8K/H9zJJ5TiSxHo
 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
 okRfgNwtbhzt23VMEeheAVKhM5QlMj+ZD9in1n
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

Am 26=2E November 2025 23:15:25 MEZ schrieb E Shattow <e@freeshell=2Ede>:
>Xunlong Orange Pi RV patches are now queued up for the next merge window
>to Linux v6=2E19, so let's introduce support for this board=2E
>
>Note: The content of EEPROM is not known to be unique on this board, and
>in this RFC there is a placeholder value of "XOPIRV"=2E

If OrangePi is not providing a unique value, shouldn't we create a separat=
e defconfig (including the vf2 one) and override the output of the eeprom r=
eading function by a configuration value?

That way we can reuse most code and avoid that users have to update the EE=
PROM to "XOPIRV"=2E

Best regards

Heinrich

>
>E Shattow (4):
>  riscv: dts: starfive: Add Orange Pi RV from upstream Linux for-next
>  board: starfive: visionfive2: Add Orange Pi RV selection by product_id
>  riscv: dts: Add placeholder files for pending upstream Orange Pi RV
>  configs: starfive: Add Orange Pi RV to visionfive2
>
> arch/riscv/dts/jh7110-orangepi-rv-u-boot=2Edtsi | 76 +++++++++++++++++++
> board/starfive/visionfive2/spl=2Ec              |  3 +
> =2E=2E=2E/visionfive2/starfive_visionfive2=2Ec        |  2 +
> configs/starfive_visionfive2_defconfig        |  2 +-
> =2E=2E=2E/src/riscv/starfive/jh7110-orangepi-rv=2Edts |  0
> 5 files changed, 82 insertions(+), 1 deletion(-)
> create mode 100644 arch/riscv/dts/jh7110-orangepi-rv-u-boot=2Edtsi
> create mode 100644 dts/upstream/src/riscv/starfive/jh7110-orangepi-rv=2E=
dts
>
>
>base-commit: c5e6d2ab7eba68cbfb600cdc131c0c375ced2ec9

