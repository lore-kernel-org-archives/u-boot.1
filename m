Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789CE606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 13:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QXG43qt/;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=raX3retL
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4FCFA8121A;
	Wed, 18 Nov 2026 13:19:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NPfb5_7hjchy; Wed, 18 Nov 2026 13:19:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9D03581297
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795007960;
	b=PI/GcdQHuzJ9l22h6dTRzhWJHz8dq2G9gocpM/hkHrlOILwOdGz0ab2VKU6Q9NcBtZSf
	 WgHZxhfcURpwH7q6KWCvBv8Mg7obISF7dH/EQITyysivCLPcrFSb8FKQofQsJuN9Te1ai
	 VyvuZgA3MlUb9xWqiZwWtM0/nBmMI+/OgSRzm3icm5t1we+T0VG+U2xf/Z45YKxYsVCJ8
	 0wqTPa3ZhLYS2eKb8/K8lzZjOklF5IEDXEBtEcbY/EagPcXeiSOxQ2ScyilnXI9m0YUbA
	 X26w8ag+g1KKNXzo9xCRjtsBYCLkipLroFXf2vvxxh3yt8dhbzI4ApfI+c08UsATrEg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795007960;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=UK46IcXwljcQt12rJlWFK6dgxR+wFcGtLqm6G9TlV/Q=;
	b=Y8P7fro9nyleXpUr0DK2wUwxRJJmyHH8YFpbp3fKEtmd+HmDSLn3byVkVrkM2WUghhVt
	 N9sdICLPuwtdI4RkDSmIVPeqpbCSUXpIyHXUJXjsiny5/ITHnqqsLmP9NEhIZSEO/R/MP
	 e/3hVMAkInDCiqkyJkFxyqUZFHDUXaJhxp7bvwd/hZRRT4AX9cArZFLlYrreUuLOiT1af
	 L+zLPc46moO8oDwKw65b56xTa8GP5V7ilVyvnhAZLi2oXpjXpT+7e8qYpje7t7aZUltjo
	 mThvZSgq0qa05MvYnWY9/gxgU+wwAmcfNh3qsapLIs4dgbkNtQ/KZdrKH17jpHijHdg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795007960;
	bh=UK46IcXwljcQt12rJlWFK6dgxR+wFcGtLqm6G9TlV/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QXG43qt/ULcbBHhGeQ9vn6IcAZsPc9VsD/2V2sgNPKBKQj3cL4TNb01nBXh33J1+7
	 FMCsrQfwtRU74KtZ0VjtIT0KjAznSemQbjG7CFwvxNkHNfMX4otKebtCqykBJAocVk
	 XpyBHN7n8Rdt4lbKr7GsBFy8YT92nxZZoILunNPPCbnNhqMAA2cJeAkMt/WAzpoTBt
	 4vKndOzT5XC1YnblRfF7i1ENSFwaaJR/u81aCZAGgXz3NakCVA67qXMybl8Oxkqko8
	 KVP9rzEIjDvfKXuB1hMS+uUSHmzQohNzlLN9qx28bgH4ZX16rNQXeZqZN/HcxdJnke
	 5BXhfRMayxcFw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9D03581297;
	Wed, 18 Nov 2026 13:19:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 75DE670B
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:19:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 687C94047C
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:19:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d2oU0BfzgorS for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 13:19:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 917BD40060
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=185.246.85.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=raX3retL
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 917BD40060
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:19:15 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 4BFAA4E41627;
 Wed, 18 Nov 2026 13:19:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 1AC845FE9B;
 Wed, 18 Nov 2026 13:19:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2C9E811BC1FB5; Wed, 18 Nov 2026 14:19:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795007952; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=UK46IcXwljcQt12rJlWFK6dgxR+wFcGtLqm6G9TlV/Q=;
 b=raX3retLWBEWr7fC38WYEnKiZScNbzkiNu1cGK5TpoZqsLi533FBrrKKd7vASE9MIviB44
 +wcq0vz3DunzOQlaGV4wdrRoMYaG8KoIINjU1ugmXaZt7YBsShDcQKyVyOIjIwIGg1JmJs
 jTegpQAaLbrhOEDuQantjGiWsAk4s8Brc2lokEtPGqGewZVmJoCHxeNZjcKZ1fYOv7zVA0
 EQiMB2iyQjLv2Elbjkz+QizqL11Ocn3ONJgkQ58iDo/02OdF/idSaZyZ0PZSOZGQaC3dUg
 s3x1DRsE6P4awiaBOJTqYDYL7UeA3n7CZK8nZinqwp98gQYiP09MlQcA3BdvyA==
From: "Richard Genoud (TI)" <richard.genoud@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 "Andrew F . Davis" <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Bryan Brattlof <bb@ti.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Kendall Willis <k-willis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>,
 Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v7 18/20] arm: dts: k3-j7200: Remove background firewall on DDR
Date: Wed, 18 Nov 2026 14:18:05 +0100
Message-ID: <20261118131807.135859-19-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261118131807.135859-1-richard.genoud@bootlin.com>
References: <20261118131807.135859-1-richard.genoud@bootlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Prasanth Babu Mantena <p-mantena@ti.com>

With updated TIFS version tag v11.02.06, the background firewall
for DDR firewalls are applied by the TIFS. This removes the
dependency of applying firewalls through binman.

Remove background firewall on the whole DDR, as this
background firewall is applied by the TIFS init for j7200
and j784s4. Modify for j7200 only, as there are no firewalls applied
for j784s4 from SPL.

Removing the firewalls only when CONFIG_K3_LPM is set preserve
compatibility with older TIFS.

Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
Co-developed-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
---
 arch/arm/dts/k3-j7200-binman.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/k3-j7200-binman.dtsi b/arch/arm/dts/k3-j7200-binman.dtsi
index b4e0ce8bfcf2..0840e9710a8a 100644
--- a/arch/arm/dts/k3-j7200-binman.dtsi
+++ b/arch/arm/dts/k3-j7200-binman.dtsi
@@ -294,12 +294,14 @@
 							region = <2>;
 						};
 
+#ifndef CONFIG_K3_LPM
 						firewall-4762-0 {
 							/* nb_slv2__mem0 Background Firewall - 0 */
 							insert-template = <&firewall_bg_3>;
 							id = <4762>;
 							region = <0>;
 						};
+#endif
 
 						firewall-4762-1 {
 							/* nb_slv2__mem0 Foreground Firewall */
@@ -308,12 +310,14 @@
 							region = <1>;
 						};
 
+#ifndef CONFIG_K3_LPM
 						firewall-4763-0 {
 							/* nb_slv3__mem0 Background Firewall - 0 */
 							insert-template = <&firewall_bg_3>;
 							id = <4763>;
 							region = <0>;
 						};
+#endif
 
 						firewall-4763-1 {
 							/* nb_slv3__mem0 Foreground Firewall */
