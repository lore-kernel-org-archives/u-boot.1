Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB505C98314
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 12:37:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9164040869;
	Thu, 24 Sep 2026 12:37:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CFv83N-jIBGt; Thu, 24 Sep 2026 12:37:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D4E2E408A4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790253446;
	b=DgwJ2TTozTzNhV1cdclSymZnkpLvOVzrwnVatXyys1E1aNSIOFRl+76+DVOm+LOOG+6J
	 WIA1Ehsfwcciw8fsThjAYDIM4zeXgFF8O5NPLrVxxPN8iptp9iV2tOD5vQgvWscBv5kx0
	 +OR3UUDfuWyc4znQVpZhSeEGrFdXBAbKHyXxncShOZD6TW0Ewmqz6LgpO+qLZGT4JfXlY
	 B33gZaiUanWfH7X5aQyVexI7938qbwfJOaZ2CrBItOcKajLfBDQgDEgKmWSLOcIFaa4tK
	 JmMsNBWa2Y1ohmCfmbhMLaDu9TYBl5ZjNqQEni8bK1qkZS3/PItHUWVL8YgNi8rqx9g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790253446;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Sg/WEcg1kmEkO/L34wiXMGl/ufnV/J2IuGqZ/fMyX+8=;
	b=IUMmQkeV0k3EBj6I1OnBfkOwpFGl9HhGwnkBWidUPH55uqtD8p2zSJ9EWXVQP24tf0xm
	 niyGwf76OZumfSRGnsk23nY5ZuUDOmUtXeU5s6jyyNkPeYTmDrpk+l+aTuDK4LSuFYD02
	 erOVdeAbRnuRrYyjV5bVM5DCRxtzhkTETBQLkabKneKuIJ+bKCRKsBGWBS/1sdAq593PO
	 3RapjBDv/KtcZt7yDNZ5ZhxCEhSb3i9+zdX+NApK+I4pmZ8I/S7cLWVQ58jSXVQfPWVcl
	 r8YWYM1zAAoDyUw7iWWcpz73/2YxrcYEEtCE21pWLeHTBXHdkIVXJCdEC8RI6wf0BuA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790253446;
	bh=Sg/WEcg1kmEkO/L34wiXMGl/ufnV/J2IuGqZ/fMyX+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bJhQsdgVwDTH/P+So5Mc+M46nvoJCv8vicG+rEJ+DZx0esJ+fQNTyVQszYEiuqLg6
	 8uMXVtiKL6tHynRjFl/Wlkud+PFlc5FgWeQbNGDL5XrqBLzAfosUTz/HJIIeE/NEAz
	 JRuML5JhhQUrG1sU2+WP+lkdGzwCNmksYWb0/DhkcL4zAbhU3pmnZiK10YxmKwIRkM
	 bHPVmbtdOBDyIyca9qr2kjYvst/fmIV3QtrR7/Pb+E+HuCyi1UiCYPkXwuCgKWAQ84
	 BJYv1lbxvEKE6Pvm0JDCIKsTikHixiInOW0D02y1F45T8KCUZ30Bs9JkXaSniKnGyO
	 NkqxaAbuTpqOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D4E2E408A4;
	Thu, 24 Sep 2026 12:37:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D27D194
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:37:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3F86B40456
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:37:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iQK5AHheQ0GY for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 12:37:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 82C74400FB
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790253441;
 b=WRJowjlbmbPPimJvhIMhbcB6XLvp/7kyfgo8AcY43okhn7BBv5+tzT+4RinK30sJGwYj
 VtHK3uObeQk1Tk0NeBIXSGhKMX4Yw5+rTJvw2v2nJXrD/ik5WBb/jeflA/GGAxO6yawi6
 dY8ezIB5A9ia5tn4yyLGfpJotF3SRLHCWCTb7mT+87Cp6KBgCVyLToLgF4qutJG6YKD55
 dONk1YVSPdYsxYrby59HnrVrC9Ax2/5nRHNXleiutn8ZCDKNAGokLn8XMM8BG2RVUTAzh
 kFaxmAtkK14XiiY0RJoItaxrG1FWbarqVubraGEQQD8zkCT2nivjlMSnDPSdp9jau9g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790253441;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=Sg/WEcg1kmEkO/L34wiXMGl/ufnV/J2IuGqZ/fMyX+8=;
 b=ApXDYzs2y1LnXi5VuWOsIFNB0A+us+/3jtEnIrWhSUBujyXjD6q+IEjon8y5om06BlyO
 +Trj+jzEx79/UCMXXyeluSDKFNCYpoio04JkLP4woGAZmwNiYD2YVrDTa/foRg7giMbpw
 FztX3xDVV4dyRdJ2mbfajYIbIkJJc4WVEld8sB8UnBT5O5jHnZTqPTKyVKhiQnH0I13Hr
 /TE71tuKGPuucggHFkJTfbk4CeGShfx9S6YbZNU3EN1DEWAkYzJ7jNQttuIG5GNp0XLi0
 miKP01HKvK6x8x0bDud5poAEIavwdbRmCKha9o8O1qzI4h5aYdsIbGDcYtTPfxP2U0w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=yFYVYS4X; 
 arc=none smtp.remote-ip=185.171.202.116
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.171.202.116;
 helo=smtpout-04.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=yFYVYS4X
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 82C74400FB
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:37:21 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id C37D7C211C1;
 Thu, 24 Sep 2026 12:38:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 5A20660341;
 Thu, 24 Sep 2026 12:37:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2971310329472; 
 Thu, 24 Sep 2026 14:37:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790253437; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=Sg/WEcg1kmEkO/L34wiXMGl/ufnV/J2IuGqZ/fMyX+8=;
 b=yFYVYS4XSuZmByHKKBMaMndPQiLn7r2ZTCXoY1yeQbTdxS1dRalvIpVi0dzu+VDv9lXZHw
 awZVPNhkt8nXnC4PM10+PAn9/g1HsyfsdilyLYw588lyCG2c20MRj23JOKFXj5XmWrMsSW
 Pc2n8yamCA5mIjlCkLXq0jAmzZtWgg6v6sRxFxxVFXxPWDLfP1IKzLPqDNLgvnBNdM8UQw
 RpO1Q9EPVSD+OEjQFLmNVA/1qqGwtBrLMPW41Oqn9TwGE6zLIsDq5DGWaMiEkFMKqhzwzS
 76FFgQj/2YAk9fXQ7TgVUCCWw5WMIV+VKdSyeDNaxfplLW8eceXvg3kjMxi8ig==
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
Subject: [PATCH v6 20/22] arm: dts: k3-j7200: Remove background firewall on DDR
Date: Thu, 24 Sep 2026 14:35:31 +0200
Message-ID: <20260924123533.2599438-21-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924123533.2599438-1-richard.genoud@bootlin.com>
References: <20260924123533.2599438-1-richard.genoud@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

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
-- 
2.55.0

