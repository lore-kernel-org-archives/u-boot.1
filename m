Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05650C25B10
	for <u-boot@archiver.kernel.org>; Mon, 13 May 2024 12:14:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD968882AB;
	Mon, 13 May 2024 14:14:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NErZcEvL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEFB6882E4; Mon, 13 May 2024 14:14:17 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BA5388275
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 14:14:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 51C7660D33;
 Mon, 13 May 2024 12:14:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B76FEC32781;
 Mon, 13 May 2024 12:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715602453;
 bh=RVQTFLh08em8zM+sa9btHLCgPEcv6NfXkkcYSrXU/0I=;
 h=From:Subject:Date:To:Cc:From;
 b=NErZcEvL9ofQGzj8xYJYIQdPjLN7Hyfr0c/SX4l/1XSorfzh+SIxZ/1iVr9JWTB4n
 owlMqzdWvdtrpZP+3ea1gmisW4qfoO84sYkTJ0e8VRwbjYWN931h8QWYghkFATbGXI
 4xupEccsij9U4yhGxGFuiUpyClxOZ7vP87NjDDxL/iYtodvsEkLVdA8I1APtl4/usp
 Kvl58hcU4QB+8QQU214lc2KuRXzaZZc25tV4x8ebj5I9+l+w+lFB47dUgXXso0+Gqy
 tSIewoCp6yfo1jqBVrKuiXkbJFg/IGtSgWRDM6ZCUhn3ABS7fqUnlydIYOSj3k4kqO
 J0JjXtkGU7CJw==
From: Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 0/3] arm: dts: am62-beagleplay: Fix Beagleplay Ethernet
Date: Mon, 13 May 2024 15:13:53 +0300
Message-Id: <20240513-for-2024-07-beagleplay-eth-v2-0-a9bf457c3bb8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAEEQmYC/43NsQ6DIBSF4VcxzL0NF0WkU9+jcaB4VVIjBoypM
 b570albO/5n+M7GIgVHkd2yjQVaXHR+TCEuGbO9GTsC16RmgouC51xC6wMcAVzBk0w30DSYFWj
 uoa2EkYha6VyxBEyBWvc+8Uedundx9mE9vxY81r/YBYEDodCFkUpai/cXhZGGqw/dcXMahfhtl
 FZXsiG0OZbfRr3v+wcn/fIWCQEAAA==
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 Wadim Egorov <w.egorov@phytec.de>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Simon Glass <sjg@chromium.org>
Cc: srk@ti.com, s-vadapalli@ti.com, vigneshr@ti.com, r-gunasekaran@ti.com, 
 danishanwar@ti.com, u-boot@lists.denx.de, Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1942; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=RVQTFLh08em8zM+sa9btHLCgPEcv6NfXkkcYSrXU/0I=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBmQgQRayH1Fotkd6kyYNtFcDGHI70esJg45T2OL
 l0v194PY9aJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZkIEEQAKCRDSWmvTvnYw
 k58YEAC1rO3rPeooDRT1paBx+6I2xrAetGEy/eNKxDNmuFzxt6ko+/D9wqS5S0pHKdZ6MUSEipj
 fuQf4M8+Uayi3BW78NKM3wHMDP43k8OASyaT5O0QzDg56l7orUYjms8bbtx3SKuPFrsiUcUQXTO
 p8ZpfNvendhsrPCvKrS5y5sDC60J1Q78+CC0fAomrs/hzbIkXshK+oLgBMJ00ILFNZ+359t+F61
 kVkb9H/OXjQY09HD1p44xwjsPKByMSA93IdVbJQ9t+ilu+VswzHNQ7MgWyzXokaTTshHVmG6vrR
 cdRBU/jEfioM2VlEqUZtcCkejIQszHXEJ1u+kCTlrUa7dKF+RYDq3RkTd/n89zgOUWOo5GYvmMn
 HzsRVP8fcxdUILtWjSuj/2OvMEV3cUbtEFmutLZgvkjF2BkcfxppjXnlNpqToxj1UhBevB//eSp
 xKNqu0HTUKWgIebzqQi/03kMz89x9lfzBFpf1bQUptrbZavwr366xA8ARf72alvYnAuLhXOoVi9
 tWbkfL4o+RSWSLd4j4h7nKAIeQeE8YdymPIcyxE0MWqPb0ufHOqUCcRMTEF8vEJHmYHDtYzvE9a
 itnzVamIPga35j+Bf1hj5XyJXtEVohybwnWmdalwsGKLqVwJZ6YiEoqmSOGObWdAMyzwTm3PNne
 8pnlbSd28GAzKkg==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093
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

Sync AM62 device tree files with Linux v6.9 and
add in the missing bits in -u-boot.dtsi to get CPSW
Ethernet working.

CI testing
https://github.com/u-boot/u-boot/pull/534

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---

---
Changes in v2:
- rebase on u-boot/next 13th May 2024
- drop 'not-for-merge' comment for patch 3 as it can now be merged
- Link to v1: https://lore.kernel.org/r/20240425-for-2024-07-beagleplay-eth-v1-0-6c985de1c316@kernel.org

---
Roger Quadros (3):
      arm: dts: k3-am62*: sync with Linux v6.9
      arm: dts: k3-am625-beagleplay: get CPSW Ethernet to work
      arm: dts: k3-am625-beagleplay: Fix Ethernet PHY reset GPIO

 arch/arm/dts/k3-am62-main.dtsi               | 126 ++++++++++++++---
 arch/arm/dts/k3-am62-mcu.dtsi                |   4 +-
 arch/arm/dts/k3-am62-thermal.dtsi            |   5 +-
 arch/arm/dts/k3-am62-wakeup.dtsi             |  38 +++--
 arch/arm/dts/k3-am62.dtsi                    |   4 +-
 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi |  63 +++++++++
 arch/arm/dts/k3-am625-beagleplay.dts         |  66 ++++-----
 arch/arm/dts/k3-am625-sk.dts                 |   4 +-
 arch/arm/dts/k3-am625.dtsi                   |   4 +-
 arch/arm/dts/k3-am62a-main.dtsi              | 201 +++++++++++++++++++++++++--
 arch/arm/dts/k3-am62a-mcu.dtsi               |   4 +-
 arch/arm/dts/k3-am62a-thermal.dtsi           |   5 +-
 arch/arm/dts/k3-am62a-wakeup.dtsi            |   4 +-
 arch/arm/dts/k3-am62a.dtsi                   |   4 +-
 arch/arm/dts/k3-am62a7-sk.dts                | 162 ++++++++++++++++++++-
 arch/arm/dts/k3-am62a7.dtsi                  |   4 +-
 arch/arm/dts/k3-am62x-sk-common.dtsi         |  24 +++-
 17 files changed, 621 insertions(+), 101 deletions(-)
---
base-commit: c67199962b2a819a4b0ae8d57dc68b7cadee0c9e
change-id: 20240305-for-2024-07-beagleplay-eth-f82a51197937

Best regards,
-- 
Roger Quadros <rogerq@kernel.org>

