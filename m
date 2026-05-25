Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B88F2CD4F54
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 02:31:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FDE2846C0;
	Mon, 25 May 2026 04:30:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="iBXUyQma";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B18108039B; Mon, 25 May 2026 03:28:54 +0200 (CEST)
Received: from mail-244121.protonmail.ch (mail-244121.protonmail.ch
 [109.224.244.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6217883EF9
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 03:28:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=johan.axelsson@proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1779672531; x=1779931731;
 bh=MhP4f1T79XMLp/vQEUsmQm0LRNz+Q4Pr2L2Y8ma1C/M=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=iBXUyQmah4gQuKeLgfa0hvT5Bzns1GxZMx6DS5DzBndwfUp9irgedfmPNmHHeEm70
 RFSgVxUDP98VABpzCLW28Y1WCR8z90FSEx0KPgHhBjBUo3iXylS6CePpPf2Ny/hGO1
 TqEttiksQ6eXHiqZwRZxXx/j1+Dzm2IgwNYlxNqmTBjxVz3qm89FTmhcPJSAs+9PIw
 KidbbNtCpCx457izomiqwPTsSOewe0NCOaEjKV4+0oiQpQGyrDoR3pvaIw06Vmgx6D
 rQZrgnUOy8qRAoORuXtCwQ/uQQPwNCIeaAqkX9U03+4jObBbDa/fC8hmjUVHaxgwUH
 yqTFyHr6xgFYw==
Date: Mon, 25 May 2026 01:28:47 +0000
To: u-boot@lists.denx.de
From: Johan Axelsson <johan.axelsson@proton.me>
Cc: kever.yang@rock-chips.com, philipp.tomsich@vrull.eu,
 Johan Axelsson <johan.axelsson@proton.me>
Subject: [RFC PATCH v1 01/14] sysreset: psci: exclude from XPL builds
Message-ID: <20260525012824.121-2-johan.axelsson@proton.me>
In-Reply-To: <20260525012824.121-1-johan.axelsson@proton.me>
References: <20260525012824.121-1-johan.axelsson@proton.me>
Feedback-ID: 111481869:user:proton
X-Pm-Message-ID: e9453afb9863129b71c5bf145ceceeb1583f7fb4
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 25 May 2026 04:30:57 +0200
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

sysreset_psci.o pulls in PSCI firmware calls which are not available
in XPL (TPL/SPL) context where EL3 is not yet initialised.  Guard the
object with ifndef CONFIG_XPL_BUILD, mirroring the pattern already
used by other sysreset drivers.

Required so that CONFIG_SYSRESET_PSCI can be selected in full U-Boot
while TPL for RK3576 (which sets CONFIG_XPL_BUILD) still links cleanly.

Signed-off-by: Johan Axelsson <johan.axelsson@proton.me>
---
 drivers/sysreset/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/sysreset/Makefile b/drivers/sysreset/Makefile
index b5b99235b6e..a5e50f17909 100644
--- a/drivers/sysreset/Makefile
+++ b/drivers/sysreset/Makefile
@@ -16,7 +16,9 @@ obj-$(CONFIG_SYSRESET_MPC83XX) +=3D sysreset_mpc83xx.o
 obj-$(CONFIG_SYSRESET_MICROBLAZE) +=3D sysreset_microblaze.o
 obj-$(CONFIG_SYSRESET_OCTEON) +=3D sysreset_octeon.o
 obj-$(CONFIG_$(PHASE_)SYSRESET_PALMAS) +=3D sysreset_palmas.o
+ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_SYSRESET_PSCI) +=3D sysreset_psci.o
+endif
 obj-$(CONFIG_SYSRESET_SBI) +=3D sysreset_sbi.o
 obj-$(CONFIG_SYSRESET_SOCFPGA) +=3D sysreset_socfpga.o
 obj-$(CONFIG_SYSRESET_SOCFPGA_SOC64) +=3D sysreset_socfpga_soc64.o
--=20
2.45.1.windows.1


