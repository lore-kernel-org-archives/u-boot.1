Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC56CD6E4A
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 07:19:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4634C84884;
	Tue,  2 Jun 2026 09:19:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="pKNL1soI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0E40848E2; Tue,  2 Jun 2026 09:19:09 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 076B184898
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 09:19:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+me.samcday.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id AEC3344435;
 Tue,  2 Jun 2026 07:19:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 933CFC2BCB4;
 Tue,  2 Jun 2026 07:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780384742;
 bh=7qnvH/kxy5hY6C4iBchjUiouWXFMv/492CXr7Yvw0ks=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=pKNL1soI7VWVnQjY87Zg+IQcpJTdxnE4IZur2RFk76GYP7IhVPEcLil4HiaL7lVge
 egZ1oHKpUZscxoUvd6SeGsRJj2Wc4uSdjMlAJLd7qCTO+WN7kyi+aeFz3lGp/4wOf2
 Oa+PlpT25T+VjnJwihKXcmi2YtzO61Mm5ZzoQpNFtpjrl89Bq3CmYDu9ZuVl8Oo2yP
 h68YFNxHlc9KUDwbTq62H0fUQ9iRb9KpahzD3xiOKjwTWl7fJnAKMjQta/bNVS4oEb
 415FRh+uYAVB/U7b86GzjH77VUOKIeRTesdi8I1Hr2hN9Qvgwj4v4CgeG2hjdq9mbN
 Y3P1WPk6LgTPw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFBCCD6E61;
 Tue,  2 Jun 2026 07:19:02 +0000 (UTC)
From: Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org>
Date: Tue, 02 Jun 2026 17:19:00 +1000
Subject: [PATCH v2 4/6] mach-snapdragon: fixup CPUs with PSCI enable-method
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-msm8916-smp-support-v2-4-792e53dac374@samcday.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780384740; l=2527;
 i=me@samcday.com; s=20240502; h=from:subject:message-id;
 bh=oyW4SjIaPw8uMUpJo0OqFTwzoLj2elwRTqTh9Cf/umk=;
 b=gVb1kgCfLjKaa+d9kuzBilStJA2K8MjfV90IfBscl+QA+mCOOSqhNZe+Ni09Op7BhTRRxlw3U
 EmD1y7NQS+pCQ9gfg/HEoGRf9X3z/py77qP2p/wYPOjHEYZEhqvz2po
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

If there's no PSCI implementation, then change the enable-method of all
CPUs from "psci" to "spin-table". Later, when spin_table_update_dt runs,
it will further patch the CPU nodes with the necessary cpu-release-addr.

This new fixup is only applied when CONFIG_ARMV8_SPIN_TABLE is enabled,
since that also determines whether spin_table_update_dt runs.

Signed-off-by: Sam Day <me@samcday.com>
---
 arch/arm/mach-snapdragon/board.c | 41 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 829a0109ac7..3b08069af98 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -183,7 +183,9 @@ static void show_psci_version(void)
 static void qcom_psci_fixup(void *fdt)
 {
 	int offset, ret;
+	uint reg;
 	struct arm_smccc_res res;
+	const char *prop;
 
 	arm_smccc_smc(ARM_PSCI_0_2_FN_PSCI_VERSION, 0, 0, 0, 0, 0, 0, 0, &res);
 
@@ -198,6 +200,45 @@ static void qcom_psci_fixup(void *fdt)
 	ret = fdt_del_node(fdt, offset);
 	if (ret)
 		log_err("Failed to delete /psci node: %d\n", ret);
+
+	if (!CONFIG_IS_ENABLED(ARMV8_SPIN_TABLE))
+		return;
+
+	/* If spin-table support is enabled, make sure any CPU nodes with a
+	 * PSCI enable-method are updated to spin-table. Further, any PSCI
+	 * power-domains properties are removed.
+	 */
+
+	offset = fdt_path_offset(fdt, "/cpus");
+	if (offset < 0)
+		return;
+
+	for (offset = fdt_first_subnode(fdt, offset);
+	     offset >= 0;
+	     offset = fdt_next_subnode(fdt, offset)) {
+		prop = fdt_getprop(fdt, offset, "device_type", NULL);
+		if (!prop || strcmp(prop, "cpu"))
+			continue;
+
+		prop = fdt_getprop(fdt, offset, "enable-method", NULL);
+		if (!prop || strcmp(prop, "psci"))
+			continue;
+
+		reg = fdtdec_get_uint(fdt, offset, "reg", 0);
+		ret = fdt_setprop_string(fdt, offset,
+					 "enable-method", "spin-table");
+		if (ret)
+			log_err("Failed to set CPU%d enable-method to 'spin-table', this CPU will not be available to booted OS! %d\n",
+				reg, ret);
+
+		log_info("Patched CPU%d enable-method to 'spin-table'\n", reg);
+
+		prop = fdt_getprop(fdt, offset, "power-domain-names", NULL);
+		if (prop && !strcmp(prop, "psci")) {
+			fdt_delprop(fdt, offset, "power-domains");
+			fdt_delprop(fdt, offset, "power-domain-names");
+		}
+	}
 }
 
 /* We support booting U-Boot with an internal DT when running as a first-stage bootloader

-- 
2.54.0


