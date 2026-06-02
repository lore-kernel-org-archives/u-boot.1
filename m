Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85E8CCD6E4A
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 07:19:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6DB38488F;
	Tue,  2 Jun 2026 09:19:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MuB+/sRg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4913848BB; Tue,  2 Jun 2026 09:19:07 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3EFF84884
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 09:19:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+me.samcday.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 9ED3640237;
 Tue,  2 Jun 2026 07:19:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7D6C6C2BCC4;
 Tue,  2 Jun 2026 07:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780384742;
 bh=19S5qVmFlK52UImU0lpIBeUvXtYRQZbJ9jM1w+/H6Rk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=MuB+/sRgHSJisPBYJ8tbzhaUHUokPRaJZxI/eHOq807o4vzY+8j7IhBCfx/CWRfBM
 Dyk+28zrtfUmDgVHFg2vGCX0dwJneHnlnB1vFRU1pTDIwqJtwrDiz0MUB8Sh/d0s2p
 bFTqT4H3hWtWGos969eoE1iyDJoxKFCW233ywoPaGVm7JozqmOO2mBkqvltZ2Kp0V7
 vTgLbjVIUHHdEvoxpFmIcFBtKhLPVu9RJ9LiDqv8lpyIO0o9kkRLQPhKlCT7DY6Ao1
 v0vm6m6vPPeRTvQ1sKdHtihT90ZSNJvFUDaGktJm+ODFtT+2pv9FU9EWwr17Fv483+
 i2PlSwRvgbNdg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 66C2FCD6E4A;
 Tue,  2 Jun 2026 07:19:02 +0000 (UTC)
From: Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org>
Date: Tue, 02 Jun 2026 17:18:58 +1000
Subject: [PATCH v2 2/6] armv8: spin_table: add hook for booting cores
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-msm8916-smp-support-v2-2-792e53dac374@samcday.com>
References: <20260602-msm8916-smp-support-v2-0-792e53dac374@samcday.com>
In-Reply-To: <20260602-msm8916-smp-support-v2-0-792e53dac374@samcday.com>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Sumit Garg <sumit.garg@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Casey Connolly <casey.connolly@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>, 
 Peng Fan <peng.fan@nxp.com>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Michal Simek <michal.simek@amd.com>, Sughosh Ganu <sughosh.ganu@arm.com>, 
 Antony Kurniawan Soemardi <linux@smankusors.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Sam Day <me@samcday.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780384740; l=2300;
 i=me@samcday.com; s=20240502; h=from:subject:message-id;
 bh=t8uheGFiPfRm69fYegUVGyZihoji0eRWhr6Iiux+UJM=;
 b=h2j2FY5v+u6eHjabCrzQsHTugBSivUipxhjnmaPi/ZXDfwfWBag0hyYrR+xQB4NDn9UDCy5la
 MrBCm7q24uRDvM6dTvX7rp1GGkEv+rGlS5yRVw/sdugoaLjXGngEL1N
X-Developer-Key: i=me@samcday.com; a=ed25519;
 pk=bzyS0akxWMqr9+AXzgBRIp28KKpEOs+GjYMc2yf+aeU=
X-Endpoint-Received: by B4 Relay for me@samcday.com/20240502 with auth_id=595
X-Original-From: Sam Day <me@samcday.com>
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
Reply-To: me@samcday.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Sam Day <me@samcday.com>

Introduce the weak symbol spin_table_boot_cpu, which is called by
spin_table_update_dt during pre-boot FDT fixup phase for each CPU that
has enable-method="spin-table".

This saves the board/arch code from needing to scan the DT looking for
CPUs to boot, and also makes it easier to bring the secondary CPUs online
as late as possible.

Reviewed-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Sam Day <me@samcday.com>
---
 arch/arm/cpu/armv8/spin_table.c   | 20 ++++++++++++++++++++
 arch/arm/include/asm/spin_table.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/arch/arm/cpu/armv8/spin_table.c b/arch/arm/cpu/armv8/spin_table.c
index 5ba20efa33b..32bf680f02c 100644
--- a/arch/arm/cpu/armv8/spin_table.c
+++ b/arch/arm/cpu/armv8/spin_table.c
@@ -8,11 +8,18 @@
 #include <linux/libfdt.h>
 #include <asm/spin_table.h>
 
+int __weak spin_table_boot_cpu(void *fdt, int cpu_offset)
+{
+	return 0;
+}
+
 int spin_table_update_dt(void *fdt)
 {
 	int cpus_offset, offset;
 	const char *prop;
+	const void *release_addr;
 	int ret;
+	int found_cpus = 0;
 	unsigned long rsv_addr = (unsigned long)&spin_table_reserve_begin;
 	unsigned long rsv_size = &spin_table_reserve_end -
 						&spin_table_reserve_begin;
@@ -45,12 +52,25 @@ int spin_table_update_dt(void *fdt)
 		if (!prop || strcmp(prop, "cpu"))
 			continue;
 
+		release_addr = fdt_getprop(fdt, offset, "cpu-release-addr", NULL);
+		if (release_addr)
+			continue;
+
+		found_cpus = 1;
+
+		ret = spin_table_boot_cpu(fdt, offset);
+		if (ret)
+			return ret;
+
 		ret = fdt_setprop_u64(fdt, offset, "cpu-release-addr",
 				(unsigned long)&spin_table_cpu_release_addr);
 		if (ret)
 			return -ENOSPC;
 	}
 
+	if (!found_cpus)
+		return 0;
+
 	ret = fdt_add_mem_rsv(fdt, rsv_addr, rsv_size);
 	if (ret)
 		return -ENOSPC;
diff --git a/arch/arm/include/asm/spin_table.h b/arch/arm/include/asm/spin_table.h
index 8fc61237e07..3c422046b83 100644
--- a/arch/arm/include/asm/spin_table.h
+++ b/arch/arm/include/asm/spin_table.h
@@ -10,5 +10,6 @@ extern char spin_table_reserve_begin;
 extern char spin_table_reserve_end;
 
 int spin_table_update_dt(void *fdt);
+int spin_table_boot_cpu(void *fdt, int cpu_offset);
 
 #endif /* __ASM_SPIN_TABLE_H__ */

-- 
2.54.0


