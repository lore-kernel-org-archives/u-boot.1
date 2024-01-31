Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F391BC47DB3
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 13:34:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B4E687B5D;
	Wed, 31 Jan 2024 14:34:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DRYK82Ow";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A95787BE5; Wed, 31 Jan 2024 14:33:59 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D3DF87B1D
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 14:33:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 927246176A;
 Wed, 31 Jan 2024 13:33:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3088AC433F1;
 Wed, 31 Jan 2024 13:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1706708035;
 bh=UMJDBqUmkhJf+gIXFnq3iZR27E1FvvmT5fQ0sdfxB5s=;
 h=From:To:Cc:Subject:Date:From;
 b=DRYK82OwDYw73RUkm88cwoSbd+11+6RG42cEpfXLyG56m4mhyjAcnTuri+/wK5H9I
 IuNmkuWDn6IoHof9ppwr8U3ct0J04nd+9Y5R82s4yzpTstPQxGvLKV9ohEn/tg2w5V
 QEdsSMdBjRg1x/nwjSgJBA1Qac9XlmSg4+UuV+4i8ESUNmDRNqqbPHF5uMcD5UfCXz
 GGL0vr6x5XxT0YvtlNt+gPX0Knf4xkF2DngFh8RibahDdMh0NIq7ZPII12uWAUMGft
 OzzHj/lfWayv/y+M6D/MKgeZaT0/uXN9NJsDYBhmVB39U+zZSEZhnmCm8W7UPh5XE8
 Xpc+5wZp4NshA==
From: Roger Quadros <rogerq@kernel.org>
To: trini@konsulko.com,
	nm@ti.com
Cc: vigneshr@ti.com, s-vadapalli@ti.com, srk@ti.com, r-gunasekaran@ti.com,
 u-boot@lists.denx.de, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 0/3] mux: Drop usage of "u-boot,mux-autoprobe"
Date: Wed, 31 Jan 2024 15:33:45 +0200
Message-Id: <20240131133348.182987-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

MUX driver should autoprobe if the device tree has "idle-states"
property. Drop using the custom "u-boot,mux-autoprobe" property
in TI device trees.

cheers,
-roger

Roger Quadros (3):
  mux: autoprobe if "idle-states" present in device tree
  arm: dts: k3-u-boot: Drop usage of "u-boot,mux-autoprobe"
  arm: dts: k3-u-boot: Add missing "bootph-all" property to MUX nodes.

 arch/arm/dts/k3-am642-sk-u-boot.dtsi                | 2 +-
 arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi    | 2 --
 arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi | 4 ++--
 arch/arm/dts/k3-j721e-sk-u-boot.dtsi                | 4 ++--
 drivers/mux/mux-uclass.c                            | 3 ++-
 5 files changed, 7 insertions(+), 8 deletions(-)


base-commit: 28760ce8640ff6266bd1c1c568a4a231576f3919
-- 
2.34.1

