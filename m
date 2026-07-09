Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58980C44501
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 12:56:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86F6F849D2;
	Fri, 10 Jul 2026 14:56:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="hfv9lwzf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b8XEv6/I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE77C84B73; Thu,  9 Jul 2026 16:35:04 +0200 (CEST)
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B6BA84A3E
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 16:35:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ingo.rah@linutronix.de
From: INgo Rah <ingo.rah@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1783607701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vAUxhslMFtIzUOEFvz6x81KXr0s2b3wKh3T2l+7305U=;
 b=hfv9lwzfZ+YZoMyZRJYocxQrzh+2xcliR8TyTBnWH/HcZaZmuBv7buLFprAQpH9/6y3THm
 Ow9fkAJoKQ0U0vtZj4KD/JIvLFWiHZDiSutiLJY0A0ksWt2CvNKcZpOxJrIAEsEnm+qxj7
 8aqbJCf3bexEMNstiRt50lWympx8JK9fvXhknSn8kf1wCMSkmMsuH0tS1eWdK5G0udH/Tp
 JptETt9b7BEfqAC6tCNCn+dJSxNq11SnWTSCJaybwbEb4caUzd+vNs65vMH+8UBp5DLHtN
 JZFOkKOYuerT4+NkAJcYPCXNQpr5PwJT+0EZtzjFD+pqahlHoZo7gs2XlVt2XA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1783607701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vAUxhslMFtIzUOEFvz6x81KXr0s2b3wKh3T2l+7305U=;
 b=b8XEv6/IBLikqkOA7TLEX1+4ShWqg0wzz2msrXx7uKfD6rbWJe7Rq5SdtWyLDLZYLPJQ9G
 W2HfF35J12mFgrCg==
Subject: [PATCH v2 0/2] board phycore_imx8mm: add 1 and 4GB RAM timings
Date: Thu, 09 Jul 2026 16:34:25 +0200
Message-Id: <20260709-ram_phygate-v2-0-36f8a2f44de2@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHGxT2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIzMDcwML3aLE3PiCjMr0xJJUXdMUI/NUw1RDS5MUIyWgjoKi1LTMCrBp0bE
 QfnFpUlZqcgnICKXaWgDVpxIWbwAAAA==
X-Change-ID: 20260708-ram_phygate-5d27e1e194d2
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, upstream@lists.phytec.de, 
 u-boot@lists.denx.de
Cc: Teresa Remmet <t.remmet@phytec.de>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Benjamin Hahn <B.Hahn@phytec.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>, 
 Peng Fan <peng.fan@nxp.com>, Yannic Moog <y.moog@phytec.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Gregor Herburger <gregor.herburger@linutronix.de>, 
 Benedikt Spranger <b.spranger@linutronix.de>, 
 INgo Rah <ingo.rah@linutronix.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1635;
 i=ingo.rah@linutronix.de; h=from:subject:message-id;
 bh=C5sd68RO6vEAOjWX+htRxe2+fKe2M60xpnRS0rnGZzk=;
 b=owGbwMvMwCX2MS76xElR9+eMp9WSGLL8N05UjhI1DROtqFdq3cbXwGXApNw6Ifew3GbzWzu0U
 ptfrgjqKGVhEONikBVTZDkzQWivSX3owW2fdxyCmcPKBDKEgYtTACZy04LhD2/3/8gpCQv4uGXr
 5wse+7z2qnXu3kD2lqUdmdc/JzBd7Gf4p6kvYMe1c9GZi2u3PdFQSr/w00F3DvvbFtUnTXNcVfr
 LuQE=
X-Developer-Key: i=ingo.rah@linutronix.de; a=openpgp;
 fpr=CC9012BD347F55C1B6F3B8C2F15E5BC8C91547E7
X-Mailman-Approved-At: Fri, 10 Jul 2026 14:56:43 +0200
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

This patch series heavily borrowed code from 
git://git.phytec.de/u-boot-phytec-imx commit 00ac765d6032 ("BSPIMX8M-2893
board: phycore_imx8mm: spl: add 1 and 4GB RAM timings"), commit
93962421d7b4 ("BSPIMX8M-2893 board: phycore_imx8mm: spl: add 1 and 4GB RAM
timings")

Changes in v2:
  - update timing from git://git.phytec.de/u-boot-phytec-imx commit
    f5e9c4e8cb74 "board: phytec: phycore-imx8mm: Update RAM Timings" and
    fallback to revision 7
  - split the patch into timings and logical changes
  - add config options for fixed sizes
  - support RAM detection in proper U-Boot
  - limit RAM usage in U-Boot and UEFI to 3GB to avoid address issues
    beyond the 32bit address range in DMA drivers in UEFI context.

Signed-off-by: INgo Rah <ingo.rah@linutronix.de>
---
INgo Rah (2):
      board: phycore_imx8mm: update RAM timings
      board: phycore_imx8mm: add 1 and 4GB RAM timings

 arch/arm/dts/imx8mm-phygate-tauri-l-u-boot.dtsi |   23 +
 board/phytec/phycore_imx8mm/Kconfig             |   65 +
 board/phytec/phycore_imx8mm/lpddr4_timing.c     | 1867 +++++++++++------------
 board/phytec/phycore_imx8mm/lpddr4_timing.h     |   13 +
 board/phytec/phycore_imx8mm/phycore-imx8mm.c    |   18 +
 board/phytec/phycore_imx8mm/spl.c               |   56 +-
 configs/imx8mm-phygate-tauri-l_defconfig        |    1 +
 include/configs/phycore_imx8mm.h                |    5 +-
 8 files changed, 1086 insertions(+), 962 deletions(-)
---
base-commit: ee5d46b45ec0c63f8f9dd1e816e0dac3452ccc3d
change-id: 20260708-ram_phygate-5d27e1e194d2

Best regards,
--  
INgo Rah <ingo.rah@linutronix.de>

