Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63849606A321
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 13:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RrIzpd7/;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=XAvbefyw
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 26FD060677;
	Wed, 11 Nov 2026 13:30:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zEysC70ZLEJM; Wed, 11 Nov 2026 13:30:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0D2366079B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794403801;
	b=MyAC0rrf81sDQtvYdJie/v3yk3U0tG5rKgl30iOpV4f66yrb37+7pSa+uj9UD+xWFUnT
	 JVf6pSYLYbA0ISZhZhYuSb1qedu89ibxolE19XVqWo3oVDllqizJnnn9C7maidSh5G7Tz
	 r8ElMyAgTrU96f1g3VQGaloEIKzcrAs3FyY7aCiMQEL2gxZJaWgGPEfxttFADT8KkDqWK
	 OqwT1Ph3FpmZHuGzw0IK5G4BVC+qPfh5NmBXMlKpfxVtOT8yZRHIO6IHLk9W7bMfBsXyK
	 TVzLye38Zi0gzXgPmnq0Ek4rlLL0sW37TxBu9MPRa2UYz0w7jEe+b5ypCUrRkG7tXSw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794403801;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=V0TWs1g37jJaPwa0/uhxX2ciBQcssiKykSNpqsBAif0=;
	b=OD50nco7hf56lKDmqlOkiX2Q74fMjxJSCRQJissXYq0Z2QqNP1Cib/wX+6EaAICtft7Q
	 89S153GW7HOkzOOIrAuIXXiXl6e50SPQtvUJB0iGYWI4/63Gq4UkWzOn1uxt6FbE44xRI
	 ZiplDdg8GPEboKreGVI17zYp7SMGZKv+PstZeIxOi6O5rs4GtuGj8aJedFVfauxd8qsNT
	 KEZEllDkqR2X/Ggh/ZQtPYI2eQHjRLHABDU1meeNeQOtcM3tql4jElBPIFS/8sXY1L0xb
	 dqo4i0T70+As8bIHPOJ59ZMwriiLDN9KL0R+CqqyXDd+ELxdBhVUfizna1JQVOsVTDQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794403801;
	bh=V0TWs1g37jJaPwa0/uhxX2ciBQcssiKykSNpqsBAif0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RrIzpd7/tjpzKmWZVdRFGbpG8VKZaieftf8ghSQt/OPcO0gQUMQ5OwlsuSZTwmVI5
	 6HYdLQP+zY42AYTeauVpv1OZHbIhwIjzYGAfq0uPnHX2UgAsF8d1Dn0ZPqDvvklzZZ
	 lTQkA4YrGTcNLsRnZIl404Elv9YzJxJA1MUR0MkIS8Zh3o5t5ZkQYPKj7yvJOjsza5
	 /cxXvM8d0fui7qi160Z/E6n2VV7Z/gkZ1mMcmlJyBQH7bXwluAjVtAhiEqBdqC/rve
	 QocyEkeAfBqezhZfxykJVVGULedMcSvUyQIc/lVNxzSKmvDJzNFi2V4Mwq9g0Otack
	 NA89T1p3CCKkg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0D2366079B;
	Wed, 11 Nov 2026 13:30:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2D367E09
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 13:29:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 84A1381301
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 13:29:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i497ukNQ3f_X for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 13:29:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6F8DF812C9
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=80.241.56.151
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.151;
 helo=mout-p-101.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=XAvbefyw
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6F8DF812C9
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 13:29:55 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jPksD1wvbz8sh2;
 Wed, 11 Nov 2026 14:29:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794403792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V0TWs1g37jJaPwa0/uhxX2ciBQcssiKykSNpqsBAif0=;
 b=XAvbefywImRkedyNLoq5jLg1EsCgiNBoyOo5lFe45krv9zrYzcE6r1zcdG2reDEVmmN+u7
 TNn8MbALNjLBwe45Ut9ukG9re6Wr7hO0cSdv/VusFQt78QdwNj6a//IrcoPtQvHT2H9ebG
 Dd4cAzvgraaEmKeDzUCSZgAWeZKUDr+clwXGfzroIxWspIL7YL9LZXVdm6OOqpMZjKdHKl
 FbucEEIIx30CDYlDv6DbxVGWjUjEqzyMR3dSqpqo33LnkLgqW9L3hP5ta3UtDUSfUlpCCd
 UThUz1vRk0o7NE0btpPFNRf8C15LARirQRD16zGvf74RPaZyRsWlenp97x9iBA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/3] arm64: dts: renesas: Remove unused IPMMU nodes from R-Car
 H3/M3-W/M3-W+/M3-N
Date: Wed, 11 Nov 2026 14:28:08 +0100
Message-ID: <20261111132943.7216-3-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111132943.7216-1-marek.vasut+renesas@mailbox.org>
References: <20261111132943.7216-1-marek.vasut+renesas@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 83e131c6a1db915eae4
X-MBO-RS-META: 4gcrz3qwk71wk5g7gsxtcowhn41geo8g
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Remove IPMMU DT nodes from R-Car H3, M3-W, M3-W+ and M3-N DTs,
those nodes are not used by U-Boot and only increase the control
DT size and complexity. This saves about 2 kiB on the resulting
U-Boot binary without any impact on functionality.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 arch/arm/dts/r8a77951-u-boot.dtsi | 61 +++++++++++++++++++++++++++++++
 arch/arm/dts/r8a77960-u-boot.dtsi | 51 ++++++++++++++++++++++++++
 arch/arm/dts/r8a77965-u-boot.dtsi | 54 +++++++++++++++++++++++++++
 3 files changed, 166 insertions(+)

diff --git a/arch/arm/dts/r8a77951-u-boot.dtsi b/arch/arm/dts/r8a77951-u-boot.dtsi
index 0c00cc8bef9..8170d3d1f89 100644
--- a/arch/arm/dts/r8a77951-u-boot.dtsi
+++ b/arch/arm/dts/r8a77951-u-boot.dtsi
@@ -36,6 +36,23 @@
 /delete-node/ &fcpvi1;
 /delete-node/ &hdmi0;
 /delete-node/ &hdmi1;
+/delete-node/ &ipmmu_ds0;
+/delete-node/ &ipmmu_ds1;
+/delete-node/ &ipmmu_hc;
+/delete-node/ &ipmmu_ir;
+/delete-node/ &ipmmu_mm;
+/delete-node/ &ipmmu_mp0;
+/delete-node/ &ipmmu_pv0;
+/delete-node/ &ipmmu_pv1;
+/delete-node/ &ipmmu_pv2;
+/delete-node/ &ipmmu_pv3;
+/delete-node/ &ipmmu_rt;
+/delete-node/ &ipmmu_vc0;
+/delete-node/ &ipmmu_vc1;
+/delete-node/ &ipmmu_vi0;
+/delete-node/ &ipmmu_vi1;
+/delete-node/ &ipmmu_vp0;
+/delete-node/ &ipmmu_vp1;
 /delete-node/ &lvds0;
 /delete-node/ &rcar_sound;
 /delete-node/ &sound_card;
@@ -100,6 +117,50 @@
 	/delete-node/ video-receiver@70;
 };
 
+&avb {
+	/delete-property/ iommus;
+};
+
+&dmac0 {
+	/delete-property/ iommus;
+};
+
+&dmac1 {
+	/delete-property/ iommus;
+};
+
+&dmac2 {
+	/delete-property/ iommus;
+};
+
+&pciec0 {
+	/delete-property/ iommu-map;
+};
+
+&pciec1 {
+	/delete-property/ iommu-map;
+};
+
+&sata {
+	/delete-property/ iommus;
+};
+
+&sdhi0 {
+	/delete-property/ iommus;
+};
+
+&sdhi1 {
+	/delete-property/ iommus;
+};
+
+&sdhi2 {
+	/delete-property/ iommus;
+};
+
+&sdhi3 {
+	/delete-property/ iommus;
+};
+
 &soc {
 	/delete-node/ fdp1@fe940000;
 	/delete-node/ fdp1@fe944000;
diff --git a/arch/arm/dts/r8a77960-u-boot.dtsi b/arch/arm/dts/r8a77960-u-boot.dtsi
index 335be487576..3f3c5545002 100644
--- a/arch/arm/dts/r8a77960-u-boot.dtsi
+++ b/arch/arm/dts/r8a77960-u-boot.dtsi
@@ -30,6 +30,17 @@
 /delete-node/ &fcpvd1;
 /delete-node/ &fcpvd2;
 /delete-node/ &fcpvi0;
+/delete-node/ &ipmmu_ds0;
+/delete-node/ &ipmmu_ds1;
+/delete-node/ &ipmmu_hc;
+/delete-node/ &ipmmu_ir;
+/delete-node/ &ipmmu_mm;
+/delete-node/ &ipmmu_mp;
+/delete-node/ &ipmmu_pv0;
+/delete-node/ &ipmmu_pv1;
+/delete-node/ &ipmmu_rt;
+/delete-node/ &ipmmu_vc0;
+/delete-node/ &ipmmu_vi0;
 /delete-node/ &hdmi0;
 /delete-node/ &lvds0;
 /delete-node/ &rcar_sound;
@@ -81,10 +92,50 @@
 	/delete-property/ operating-points-v2;
 };
 
+&avb {
+	/delete-property/ iommus;
+};
+
+&dmac0 {
+	/delete-property/ iommus;
+};
+
+&dmac1 {
+	/delete-property/ iommus;
+};
+
+&dmac2 {
+	/delete-property/ iommus;
+};
+
 &i2c4 {
 	/delete-node/ video-receiver@70;
 };
 
+&pciec0 {
+	/delete-property/ iommu-map;
+};
+
+&pciec1 {
+	/delete-property/ iommu-map;
+};
+
+&sdhi0 {
+	/delete-property/ iommus;
+};
+
+&sdhi1 {
+	/delete-property/ iommus;
+};
+
+&sdhi2 {
+	/delete-property/ iommus;
+};
+
+&sdhi3 {
+	/delete-property/ iommus;
+};
+
 &soc {
 	/delete-node/ fdp1@fe940000;
 	/delete-node/ fdp1@fe944000;
diff --git a/arch/arm/dts/r8a77965-u-boot.dtsi b/arch/arm/dts/r8a77965-u-boot.dtsi
index 8bc6bd726b5..e73b3828b14 100644
--- a/arch/arm/dts/r8a77965-u-boot.dtsi
+++ b/arch/arm/dts/r8a77965-u-boot.dtsi
@@ -21,6 +21,16 @@
 /delete-node/ &fcpvd1;
 /delete-node/ &fcpvi0;
 /delete-node/ &hdmi0;
+/delete-node/ &ipmmu_ds0;
+/delete-node/ &ipmmu_ds1;
+/delete-node/ &ipmmu_hc;
+/delete-node/ &ipmmu_mm;
+/delete-node/ &ipmmu_mp;
+/delete-node/ &ipmmu_pv0;
+/delete-node/ &ipmmu_rt;
+/delete-node/ &ipmmu_vc0;
+/delete-node/ &ipmmu_vi0;
+/delete-node/ &ipmmu_vp0;
 /delete-node/ &lvds0;
 /delete-node/ &rcar_sound;
 /delete-node/ &sound_card;
@@ -54,10 +64,54 @@
 	/delete-property/ operating-points-v2;
 };
 
+&avb {
+	/delete-property/ iommus;
+};
+
+&dmac0 {
+	/delete-property/ iommus;
+};
+
+&dmac1 {
+	/delete-property/ iommus;
+};
+
+&dmac2 {
+	/delete-property/ iommus;
+};
+
 &i2c4 {
 	/delete-node/ video-receiver@70;
 };
 
+&pciec0 {
+	/delete-property/ iommu-map;
+};
+
+&pciec1 {
+	/delete-property/ iommu-map;
+};
+
+&sata {
+	/delete-property/ iommus;
+};
+
+&sdhi0 {
+	/delete-property/ iommus;
+};
+
+&sdhi1 {
+	/delete-property/ iommus;
+};
+
+&sdhi2 {
+	/delete-property/ iommus;
+};
+
+&sdhi3 {
+	/delete-property/ iommus;
+};
+
 &soc {
 	/delete-node/ fdp1@fe940000;
 	/delete-node/ fdp1@fe944000;
-- 
2.53.0

