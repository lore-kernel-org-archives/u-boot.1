Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5AB7C9830E
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 11:26:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ED14F40DD6;
	Thu, 24 Sep 2026 11:26:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KvicCIZ9NgEb; Thu, 24 Sep 2026 11:26:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C4D4B40DB1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790249182;
	b=oz0uaVhdJ0z14P6iNxPoDQ/h1PwhdonVr0qsghwJvODZijZL319T+3lCOugBQ8Q/3uym
	 lq+nIfv2+g0cveLHt/LfAOTAYAUebukRjg6P68hpyHQkArZD8Vq7WVibrVonF6dY3RYoo
	 subfq9NVZ2jX4X0JfjDDiIOzs+QVP13hODsFWxBfVD06fXDODRIA9Z8qe6B8D6n9HFsZ6
	 mItuqZ7jZa54lTpXyRo+uLkz5GvTRn7mFL8LZCL0LdxoCcqz5dHJqMUJEfjnasw/bCl6I
	 s4XoI7NQMlfL0d3FQVs/20I+DFz5fmi27FkpLN17Ze9UOxkNs/JIXkx4kWFq0vyBWhA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790249182;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=ov5QtBVO+5fCuvtdRGFbDGDsZwXXvNK+TRRJf1IxuW4=;
	b=J9ULddZYnvFn5lXzYmndWNd4FIP0rB+DOh1ErBaTKUec4BB2ujBSH00aL6Or7va6eoEn
	 kHbUknnG7gMlU/F1twFIATEh03O1Xz3fyLKxOiSCKPegJB17ymxAdElwmm5YNFT7o6HnS
	 oakqqwWb8ku6NA1989iwYUbPZf00+BNiMGyOo+O+9ba4DK2M1CxLvhDGuIEzUT9eCx0yz
	 VR8X0SHxXNjT/CDhBtORmu/5a1262TGdYu7NLxP3/Z6QuHL7O9P2ZPC6PwqCJ1sySWX41
	 nRLKJDG0+lZ6JrX63gVB8o1rUqDRcgECD85VR3KebnyhhzKyC6c0FQplcJHlowFzk9g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790249181;
	bh=ov5QtBVO+5fCuvtdRGFbDGDsZwXXvNK+TRRJf1IxuW4=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=bLP1MwCstnxEd96Qt8bQPeEUerb33ZTvjFpY+pP5Omheu5KTrWmUPoF/iCwTN/kZo
	 DDQzFk2Na4RVUINZDY7gevborNyd6F8cAFZi2EgzTBbsdNg3RCWfhhOrXokP8h0nt5
	 960Of4g9AN6Dxuw+s4DSE8u7JkoyelFCBHdRy54mlU6+bJs+0sVEFIpWTQBxPbeeXF
	 hUOX+7QEWVPFyd77gOPiX7adJSK4VWHHOfhleiT52kjT2pjVeFUWuZAbnK17a+U9xX
	 Te7ArrMbro3GFmtR3eX4ERO26BxLSoxTdti0nWHZYMeEs0e1Oe7hmGHPQ77PVvAO49
	 hNwhXjZypUIeg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C4D4B40DB1;
	Thu, 24 Sep 2026 11:26:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4681B13B
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 09:10:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2BCC34043C
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 09:10:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WuxiAQxfnj7u for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 09:10:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 1AF134043A
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790241014;
 b=W5egLHYpOzekAa7T82lSTcoAFF3KMyypuLcjaBOVPiY1foo9h02/agDvSc7xIUatDrBQ
 /byaFEhkCZfyymaWtS3wmiIRe9sTRNPX8C/Qcd7lvDZFrGedsni6thQkqg5iMMYR6suvH
 jcPTgozYJl9CM1SM/ADZiktQN+bWYOEfGmOvAVqDgbfyajicq+HlXYivKnCOniKMwol88
 IU8MOItLtNAYv/TCPJvSatftyVD73y/s+EKEEA98cTb8bydJSeih1S6COXHXbYdWr4w3m
 z5qItGE+RsDIXwFSZ8jaNlxlNTb/Vomira1R2Xd6DXwmsd8G1DcUYrZV51bAYq1eCHg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790241014;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Subject:
 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To;
 bh=ov5QtBVO+5fCuvtdRGFbDGDsZwXXvNK+TRRJf1IxuW4=;
 b=n2UwsDrK9cTiF2ZQrJdYK7D5hs7BPAmciXJP5KSXLuhhvUtNE0iTn7HN4GJs8o/Ceek8
 C4kOnvsB1zulq/6TahWCarKxbuCogWHmIldBXLNa2KhbThFCmzRNb4HsttA225W97HZht
 DnPy/3mXAK3jo4wEr+hZhUJ9XVx9qVr38E8S7VoFHyLIX9azUxk3mKbBa3vjDVqV2UOmq
 ziuSr34jJxl0fNHO+B11fPCijXVVY3+y2B4xKjLBIwvb03hx9k1TIEGlahObq6s9WH61T
 O55BZHtuWf2vrlFGtQOjcr7rByTqdUcuaYZx+NoFpzZe01vI+hr3w8zIOvJ7QUNf5Kw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b="fIpk2FI/"; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+takahiro.kuwano.infineon.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=fIpk2FI/
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1AF134043A
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 09:10:13 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 71AAC4061A;
 Thu, 24 Sep 2026 09:10:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 47AFFC2BCB3;
 Thu, 24 Sep 2026 09:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1790241012;
 bh=CQ0CFZojaJUYmTjR6jeK96ke4oz9tmnbjsEjRrPew48=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=fIpk2FI/4LZKNNY1aju83f+RR6Py6Y40F1E1XRGOm6fnX87HRqki53YAUU3lYdQDr
 VDEv5NwEqpkkN9FTmmL5WJKbk+2HhcIi53MO+M6i8Wvd/X3OVZdjSHchbx0XNCjpcS
 ZNEl8RCkKI/oXthGpC5eE1LuMECV858XfX31t4U+C0Z4v+urJbPGRiZYhQ+JoZ5AJb
 GezuahPmznjsDC1UVPJnXADcJk5aKIKa6uhnd0s1B+1oPvuWl3cUNMMmY9NYx97xVl
 W1X0ck/8IjCr5HPeR05Yuv019XSEcb32NNs61d252epTgv00V/Exi5NQIK7oWp2kLs
 StEoS+81cJ1EQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8B2C98314;
 Thu, 24 Sep 2026 09:10:12 +0000 (UTC)
From: Takahiro Kuwano via B4 Relay
 <devnull+takahiro.kuwano.infineon.com@kernel.org>
Subject: [PATCH v2 0/4] mtd: spi-nor: split SFDP, ID database, and fixups
Date: Thu, 24 Sep 2026 18:10:04 +0900
Message-Id: <20260924-split-sfdp-id-v2-0-aafc70e0b657@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOzotGoC/yXM0QpAQBCF4VfRXNsaG4pXkQu7OxiJbQcpeXeLy
 6/T+S8QCkwCdXJBoIOF1yVCpwnYsVsGUuyiQaMusdK5Ej/zpqR3Pi6qKNEaRJflWED8+EA9n1+
 vaX/Lbiay2xuB+34AMhgi3XEAAAA=
X-Change-ID: 20260924-split-sfdp-id-560cb00d1405
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Vignesh R <vigneshr@ti.com>, 
 Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Marek Vasut <marex@nabladev.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Ssunk <ssunkkan@gmail.com>, 
 Flaviu Nistor <flaviu.nistor@gmail.com>, 
 Eugen Hristev <ehristev@kernel.org>, Jeffrey Yu <jeyu@issi.com>, 
 Takahiro Kuwano <takahiro.kuwano@infineon.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790241010; l=3508;
 i=takahiro.kuwano@infineon.com; s=20250227; h=from:subject:message-id;
 bh=CQ0CFZojaJUYmTjR6jeK96ke4oz9tmnbjsEjRrPew48=;
 b=TGWKfpFGbAC6WPIeue3zf/xor0kzp2Me+/+uPUlFBhanRq5C6dTgFp+5FawNj+DtP7Cza+8fg
 MK4j5C3ak+6Br9y4GooOEWU1D3Cm1BtrbwZIGTLXtNBLR4/4wUyvW6f
X-Developer-Key: i=takahiro.kuwano@infineon.com; a=ed25519;
 pk=aS8V9WLuMUkl0vmgD0xJU19ZajdJmuyFBnBfVj0dfDs=
X-Endpoint-Received: by B4 Relay for takahiro.kuwano@infineon.com/20250227
 with auth_id=566
X-Original-From: Takahiro Kuwano <takahiro.kuwano@infineon.com>
X-Mailman-Approved-At: Thu, 24 Sep 2026 11:26:20 +0000
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
Reply-To: takahiro.kuwano@infineon.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

The spi-nor-core.c contains optional logics like SFDP and manufcaturer
specific fixups. The spi-nor-ids.c has single large ID database. There
are many #ifdef directives in those files and that negatively affects
readability and maintainability.

This series, as the first step of cleanup, move SFDP logic, IDs, and
fixups to newly source files. Reworking, renaming, and reformating
existing code is not a scope of this series and further cleanup will be
taken place in follow-up patches.

Here is the code size impact when applying this series.
Measured by my AMD Zynq-7000 (ARM32) environment with SFDP and all
manufcaturers are enabled.

SPI-NOR:
            text    data     bss     dec     hex filename
BEFORE    731133   14696       0  745829   b6165 u-boot
AFTER     732301   14696       0  746997   b65f5 u-boot
DELTA      +1168       0       0

TINY:
            text    data     bss     dec     hex filename
BEFORE     80492    3744     248   84484   14a04 spl/u-boot-spl
AFTER      80748    3744     248   84740   14b04 spl/u-boot-spl
DELTA       +256

---
Changes in v2:
- Rebase on top of next
- Link to v1: https://lore.kernel.org/u-boot/20260612-split-id-table-into-vendor-files-v1-0-dfaaa82cc6f0@infineon.com/

To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
Cc: Vignesh R <vigneshr@ti.com>
Cc: Michael Walle <mwalle@kernel.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Pratyush Yadav <pratyush@kernel.org>
Cc: Marek Vasut <marex@nabladev.com>
Cc: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: Raymond Mao <raymond.mao@riscstar.com>
Cc: Ssunk <ssunkkan@gmail.com>
Cc: Flaviu Nistor <flaviu.nistor@gmail.com>
Cc: Eugen Hristev <ehristev@kernel.org>
Cc: Jeffrey Yu <jeyu@issi.com>
Signed-off-by: Takahiro Kuwano <takahiro.kuwano@infineon.com>

---
Takahiro Kuwano (4):
      mtd: spi-nor: move SFDP logic out of the core
      mtd: spi-nor: import manufacturer driver concept from Linux
      mtd: spi-nor: move flash info entries to manufacturer drivers
      mtd: spi-nor: move fixups to manufacturer drivers

 drivers/mtd/spi/Makefile        |   18 +
 drivers/mtd/spi/atmel.c         |   28 +
 drivers/mtd/spi/dosilicon.c     |   25 +
 drivers/mtd/spi/eon.c           |   23 +
 drivers/mtd/spi/fujitsu.c       |   27 +
 drivers/mtd/spi/gigadevice.c    |  140 ++
 drivers/mtd/spi/issi.c          |   84 ++
 drivers/mtd/spi/macronix.c      |  154 +++
 drivers/mtd/spi/micron-st.c     |  169 +++
 drivers/mtd/spi/puya.c          |   56 +
 drivers/mtd/spi/sf_internal.h   |  135 +-
 drivers/mtd/spi/sfdp.c          |  720 ++++++++++
 drivers/mtd/spi/sfdp.h          |  152 +++
 drivers/mtd/spi/siliconkaiser.c |   18 +
 drivers/mtd/spi/spansion.c      |  700 ++++++++++
 drivers/mtd/spi/spi-nor-core.c  | 2751 +++++++--------------------------------
 drivers/mtd/spi/spi-nor-ids.c   |  752 +----------
 drivers/mtd/spi/spi-nor-tiny.c  |   11 +-
 drivers/mtd/spi/sst.c           |   34 +
 drivers/mtd/spi/winbond.c       |  250 ++++
 drivers/mtd/spi/xmc.c           |   27 +
 drivers/mtd/spi/xtx.c           |   54 +
 drivers/mtd/spi/zbit.c          |   19 +
 include/linux/mtd/spi-nor.h     |    2 +
 24 files changed, 3378 insertions(+), 2971 deletions(-)
---
base-commit: 6b78e91c4d4e9c47fe825bd2d31c0496d15f03d9
change-id: 20260924-split-sfdp-id-560cb00d1405

Best regards,
--  
Takahiro Kuwano <takahiro.kuwano@infineon.com>


