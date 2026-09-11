Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24010C88E45
	for <u-boot@archiver.kernel.org>; Sat, 12 Sep 2026 01:07:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8984D407F6;
	Sat, 12 Sep 2026 01:07:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HCrUekPjY0nA; Sat, 12 Sep 2026 01:07:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A707E407CA
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789175249;
	b=b2GW+CqviktG6+Jsc5nPpl8YxYKI5Cok7QoxVo5S7xGJQwwujSJwi5SvHYWsxzuKfKdJ
	 GEI0R9Va9hI8UA7PxSbzOuNTx9nX8QXGx9CL9cczQPxb0BjNdwifs+T3yPy38x8VY3WYd
	 jPpqudhWJm5QXEonJD54ikkolvsckX1hMlG0KKaJnCpRjDB+SdGITCdqS47BD+ZJbezkN
	 OJXr4LAWtWMMn1ZSdRHBOwz97tsze8wuVhnem335GFih+wBM9T/TY4b5Dldplv4tvBGF7
	 xOm5IAegDVFZI7aPW1iVU1yT04DaOtdn4C/aeMT9i4Laztmfk0PHlLdw6NtfUCr0Ggg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789175249;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=JaDZ6AK/QEzxSOo91lUXhKZPs10QvE6z7wlpO3RSZzo=;
	b=Ef7/BCPfCd/FAP6siPzKdvzu6XwZeLEyD8W3IOU25Vt0B1i9zG5jcic8AfO8S8U6njhc
	 7npVWKcG4HJyA30oIRkpxzSYN7KgOo8zZtJzDR3DgiJDlJXMHfios8gG4kh5Vt7mUnH4F
	 N46Jwu83iAWsGjYa2hHci49zHsaGcSiGHLb35nK0N8BBdHzUe0TaamDnhQOmHkbU00ZCv
	 KFr9Ce7dRw+pOcxNrC4dJuJZRm0T3i6fCB0ZR2kOYTZmlsdZpDxQB8CyDE7F9NGucKAge
	 V6yJwghdwM4cik/JJ+C5rSqT+xf2FOfl//FOANZipcVpPJooe+YTgB0skKIz2Lrs6Cw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789175249;
	bh=JaDZ6AK/QEzxSOo91lUXhKZPs10QvE6z7wlpO3RSZzo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=wVdRWVCuxsYzHZ5rt73j16bgb26pjZobpC0HxVx9j5D26xxeSVDHwfS6vldCRY/Af
	 Crrhg2JV+Wr6j2haJSUAdy5GKmszdUYLJVpElxe0Y0RTCZKuK5g8RpXHX5O2VtZS1P
	 bRjQWlQGwFB3SfaYgm3M9hH2KfqboGetj8dnWcSzk98zVJ5WuKRSmz40qcHWjTR/4C
	 reKpI8oQHhJAgI+LCuI86Nrsj1v+bZAdXVla13cUj5PoQB9q7p1HQDVNf+Oq9623cs
	 1POvAIskKkLKfyjeMUjTgBp/xC+wXMFBNqtUzpam4R4ZHlXB6ttgE46YzmD5gbE98N
	 fc8MoYj50e7BQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A707E407CA;
	Sat, 12 Sep 2026 01:07:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 68D0B32F
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 18:19:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4F90B4000B
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 18:19:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lymwjsF9a0um for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 18:19:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 7CD3540061
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789150743;
 b=OzS9QBNSWmDNcGf3PVoKBifxzggi9nM4NHnSsAEKxQP/MlmcKKLUXi/Ws4PltQjp+QOH
 8X63A6pj03SAeEid1+Ynu+zNVOeiqABGt10uSY/PkgDcBUnLzgT6Y7tICXmRQHr/0JAj0
 Hv9LtXed6FuU4sSgvSzAAWptW4xtIGhnG3dzhGn6k2MLte8zFoTiBDjNRctwq1PRgetSX
 d1ZW4cDYArRro9ftUZ1DnQfYsMMryBP6WKUABA5H4niY1ju8h87TvWz53079yGKTLj1IA
 vMZJLKo26KQ78KD94wJ2zRsZVHXCcF8U4Ns0WrL4Fkm3WePBQDcF9BK48qYqgHtgKwQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789150743;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=JaDZ6AK/QEzxSOo91lUXhKZPs10QvE6z7wlpO3RSZzo=;
 b=rPFQy+fmzRgI+cQ1a+xhgYSP55ZOcWoL8KjgvNVYAF95NRNnHQqQlf1Zvo40EtTJfD3o
 THBD5FOKVTrxPubkLY1SaWFXBiKlbfJwtjkHLmA4fg3AmJ+Pwr2Rdmiw6WuXkWhd0v3bc
 AOnvTv6pwoffVENqF/W3q9UeouAND+V6bTwtGsLE+92YjvozNH7KMc5kP0htD/awRnHrB
 d9vsuOQ72MBwCYAc0hpZMWqbAeel+sr5eWC3w6yG98jPEM7DEUiWn8cSpclN0fGXS+KBU
 FzIZCAUCbeLisCPrwBLc107ZgxlqnMT6FuG5pHKH/Ssf7HNa3Q4StLe4xRaCeNs/j9A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=lpvmNMIo; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=lpvmNMIo
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7CD3540061
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 18:19:02 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id DA69040C55;
 Fri, 11 Sep 2026 18:19:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BBE96C2BCFB;
 Fri, 11 Sep 2026 18:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1789150741;
 bh=fTyIFwxYiwgq+uQwF3+8gsoVLFO6eVQgbiCqdd2di1Q=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=lpvmNMIokV1/6hOxentb6j0v604v6sLCWYfhTjog9/PCsFMXCzXagMKIjvybtPct3
 z9g+vmyWs3XWOSRXtgj/WaXdwPPmd3QKxtka+tSj9PpvUJxfD5XrbK5TwaIzzXJwym
 lvhrzSoG6kNz48UJHB5lLqqAKdmf5iXCPQIwWMs4HLY39bgNUUTqS1SfykNov5GTSy
 Gw7vWkc+MDaqPS/Eshw059UwUARQLfuttYbE5KfNI+v8G8KGVayNoxMP/Teo29sjNP
 EhXlC4Z+03EkiY61RbL3lr4dPAo1I6HWsNCcQrqG1d1kzWUcpLCgjn2AYcZKT1SulK
 MtBydc5ZZNQKg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id A4E2DC88E4D;
 Fri, 11 Sep 2026 18:19:01 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Fri, 11 Sep 2026 20:18:49 +0200
Subject: [PATCH 3/4] common: Add Android bootloader parameter parsing
 helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-b4-android-bootargs-carryover-v1-3-6ebb43da3df0@protonmail.com>
References: <20260911-b4-android-bootargs-carryover-v1-0-6ebb43da3df0@protonmail.com>
In-Reply-To: <20260911-b4-android-bootargs-carryover-v1-0-6ebb43da3df0@protonmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Kory Maincent <kory.maincent@bootlin.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Markus Niebel <Markus.Niebel@ew.tq-group.com>, 
 Alexey Charkov <alchark@gmail.com>, Heiko Schocher <hs@nabladev.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Anshul Dalal <anshuld@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 David Heidelberg <david@ixit.cz>, Petr Pavlata <petr@acrux.cz>, 
 Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789150739; l=4609;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=ADTW9ak8hL9UuOnFKO7/IuU053qw6uSflnja4Upt8cc=;
 b=38dag9Zqw3SzsOnZ8PnlGY0aPm1TZwwnmb2ssJQi20si20oTXqXLOaZLE1HxNICtQPCGlFIu7
 BKRRxhzUrqCBUYiipJzLd7UlXlxB8UlsQalQLsMzQ/OnWkAtOwl2hII
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Sat, 12 Sep 2026 01:07:23 +0000
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
Reply-To: petr.hodina@protonmail.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Petr Hodina <petr.hodina@protonmail.com>

Add a convenience wrapper for parsing common Android bootloader
parameters from the kernel command line. This simplifies extracting
the numerous androidboot.* parameters used in Android systems.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 include/cmdline_utils.h | 32 +++++++++++++++++++
 lib/cmdline_utils.c     | 85 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 117 insertions(+)

diff --git a/include/cmdline_utils.h b/include/cmdline_utils.h
index fa6e20b2417..af9b5226dab 100644
--- a/include/cmdline_utils.h
+++ b/include/cmdline_utils.h
@@ -25,4 +25,36 @@ struct cmdline_mask_param {
 
 char *mask_cmdline_params(const char *cmdline, struct cmdline_mask_param *params, int count);
 
+struct androidboot_params {
+	char *hardware_ddr;
+	char *ddr_info;
+	char *ddr_size;
+
+	char *dsi_display0;
+
+	char *slot_suffix;
+	char *slot_retry_count;
+	char *slot_successful;
+
+	char *hardware_platform;
+	char *hardware;
+	char *revision;
+	char *hardware_sku;
+	char *hardware_majorid;
+
+	char *bootloader;
+	char *bootreason;
+	char *secure_boot;
+	char *mode;
+
+	char *cdt_hwid;
+	char *dtb_idx;
+
+	char *serialno;
+};
+
+int parse_androidboot_params(const char *cmdline, struct androidboot_params *params);
+
+void free_androidboot_params(struct androidboot_params *params);
+
 #endif /* _CMDLINE_UTILS_H_ */
diff --git a/lib/cmdline_utils.c b/lib/cmdline_utils.c
index 4355bdd45f4..f8fe5e79bb9 100644
--- a/lib/cmdline_utils.c
+++ b/lib/cmdline_utils.c
@@ -244,3 +244,88 @@ char *mask_cmdline_params(const char *cmdline, struct cmdline_mask_param *params
 	*dst_pos = '\0';
 	return result;
 }
+
+int parse_androidboot_params(const char *cmdline, struct androidboot_params *params)
+{
+	struct cmdline_param cmdline_params[] = {
+		{"androidboot.hardware.ddr", NULL, 0},
+		{"androidboot.ddr_info", NULL, 0},
+		{"androidboot.ddr_size", NULL, 0},
+		{"msm_drm.dsi_display0", NULL, 0},
+		{"androidboot.slot_suffix", NULL, 0},
+		{"androidboot.slot_retry_count", NULL, 0},
+		{"androidboot.slot_successful", NULL, 0},
+		{"androidboot.hardware.platform", NULL, 0},
+		{"androidboot.hardware", NULL, 0},
+		{"androidboot.revision", NULL, 0},
+		{"androidboot.bootloader", NULL, 0},
+		{"androidboot.hardware.sku", NULL, 0},
+		{"androidboot.secure_boot", NULL, 0},
+		{"androidboot.cdt_hwid", NULL, 0},
+		{"androidboot.hardware.majorid", NULL, 0},
+		{"androidboot.dtb_idx", NULL, 0},
+		{"androidboot.mode", NULL, 0},
+		{"androidboot.bootreason", NULL, 0},
+		{"androidboot.serialno", NULL, 0},
+	};
+	int ret, count = ARRAY_SIZE(cmdline_params);
+
+	if (!cmdline || !params)
+		return -EINVAL;
+
+	memset(params, 0, sizeof(struct androidboot_params));
+
+	ret = parse_cmdline_params(cmdline, cmdline_params, count);
+	if (ret < 0)
+		return ret;
+
+	params->hardware_ddr = cmdline_params[0].value;
+	params->ddr_info = cmdline_params[1].value;
+	params->ddr_size = cmdline_params[2].value;
+	params->dsi_display0 = cmdline_params[3].value;
+	params->slot_suffix = cmdline_params[4].value;
+	params->slot_retry_count = cmdline_params[5].value;
+	params->slot_successful = cmdline_params[6].value;
+	params->hardware_platform = cmdline_params[7].value;
+	params->hardware = cmdline_params[8].value;
+	params->revision = cmdline_params[9].value;
+	params->bootloader = cmdline_params[10].value;
+	params->hardware_sku = cmdline_params[11].value;
+	params->secure_boot = cmdline_params[12].value;
+	params->cdt_hwid = cmdline_params[13].value;
+	params->hardware_majorid = cmdline_params[14].value;
+	params->dtb_idx = cmdline_params[15].value;
+	params->mode = cmdline_params[16].value;
+	params->bootreason = cmdline_params[17].value;
+	params->serialno = cmdline_params[18].value;
+
+	return 0;
+}
+
+void free_androidboot_params(struct androidboot_params *params)
+{
+	if (!params)
+		return;
+
+	free(params->hardware_ddr);
+	free(params->ddr_info);
+	free(params->ddr_size);
+	free(params->dsi_display0);
+	free(params->slot_suffix);
+	free(params->slot_retry_count);
+	free(params->slot_successful);
+	free(params->hardware_platform);
+	free(params->hardware);
+	free(params->revision);
+	free(params->bootloader);
+	free(params->hardware_sku);
+	free(params->secure_boot);
+	free(params->cdt_hwid);
+	free(params->hardware_majorid);
+	free(params->dtb_idx);
+	free(params->mode);
+	free(params->bootreason);
+	free(params->serialno);
+
+	memset(params, 0, sizeof(struct androidboot_params));
+}

-- 
2.55.0


