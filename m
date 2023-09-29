Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38015E71D37
	for <u-boot@archiver.kernel.org>; Fri, 29 Sep 2023 13:47:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E41C86EE6;
	Fri, 29 Sep 2023 15:46:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aUHswIzh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83FE886EE4; Fri, 29 Sep 2023 15:46:58 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82EA486EAA
 for <u-boot@lists.denx.de>; Fri, 29 Sep 2023 15:46:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 8C03761E63;
 Fri, 29 Sep 2023 13:46:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 614C0C433C8;
 Fri, 29 Sep 2023 13:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1695995214;
 bh=a/1kZBgr1jOSXh/HRliL2L/+lC/ajJZKzPMIArq8M68=;
 h=From:To:Cc:Subject:Date:From;
 b=aUHswIzhALvJlzTFfrG3cpp5Pv1t5eXPHQVKmbMAKnsXmNzib1suYdOFgCNy6CEFE
 iNzoRyX5XgxEk11Cq726P7gchUFiOuV8OYuqg36Dh6dqQ6VTrEecX6rrndT/uI++T9
 WT9M6ZuDl7GFhkmUVLPy42AIA8WOm3dAvGYS94ONmiNIHF5sN+Tw/Z44vJqwhTsMjg
 gAduYfldnZ1uONW9G3OxoQS+YPaOy4AOQfE4QbQjHyvuzIHTyH/v2XluquO7CXfbdx
 UM/LVQGjZ48CtPRaOU9IKZOnlTvpTxkvasg9kYEGFcHDCm/U+zeTMQna71EymwfyqC
 XvzgnTOcZjXhw==
From: Roger Quadros <rogerq@kernel.org>
To: trini@konsulko.com,
	nm@ti.com
Cc: vigneshr@ti.com, m-chawdhry@ti.com, sjg@chromium.org, jonas@kwiboo.se,
 srk@ti.com, afd@ti.com, bb@ti.com, praneeth@ti.com, u-boot@lists.denx.de,
 Roger Quadros <rogerq@kernel.org>
Subject: [RESEND PATCH 0/6] arm: dts: k3-am64 / k3-am62: Fix boot
Date: Fri, 29 Sep 2023 16:46:40 +0300
Message-Id: <20230929134646.214781-1-rogerq@kernel.org>
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

(Apologies for resend as I missed the u-boot list the last time.
Thanks Vignesh for catching this :) )
    
Since commit [1] A53 u-boot proper is broken.
This is because nodes marked as 'bootph-pre-ram' are
not availble at u-boot proper before relocation.

To fix this we mark all nodes in sk-u-boot.dtsi as
'bootph-all'.

Move cbass_mcu node to -r5-sk.dts as it is only required
for R5 SPL.

[1]
9e644284ab812 ("dm: core: Report bootph-pre-ram/sram node as pre-reloc after relocation")

In addition to this we also fix some dts warnings related
to CPSW nodes in R5 SPL DTBs.

cheers,
-roger

Roger Quadros (6):
  arm: dts: k3-am64-evm: Fix boot
  arm: dts: k3-am64-evm: Mark dependent nodes for pre-relocation phase
  arm: dts: k3-am642-sk: Fix boot
  arm: dts: k3-am642-sk: Mark dependent nodes for pre-relocation phase
  arm: dts: k3-am625-sk: Fix boot
  arm: dts: k3-am625-sk: Mark dependent nodes for pre-relocation phase

 arch/arm/dts/k3-am625-sk-u-boot.dtsi  |  93 ++++++++++++++-------
 arch/arm/dts/k3-am642-evm-u-boot.dtsi | 104 ++++++++++++++++--------
 arch/arm/dts/k3-am642-r5-evm.dts      |  16 ++++
 arch/arm/dts/k3-am642-r5-sk.dts       |   4 +
 arch/arm/dts/k3-am642-sk-u-boot.dtsi  | 112 +++++++++++++++++---------
 5 files changed, 230 insertions(+), 99 deletions(-)


base-commit: 90c81f407dd4a7747385b10f9b8f732202c45cde
-- 
2.34.1

