Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D3B606A92C
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 16:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LnPTr25f;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=pigmoral.tech header.i=@pigmoral.tech header.a=rsa-sha256 header.s=zmail header.b=gENAv1fo
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1BA2D60871;
	Thu,  5 Nov 2026 16:42:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zQ2X0OxbpmUQ; Thu,  5 Nov 2026 16:42:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5ED8E60878
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793896968;
	b=iXf3ckEx02Hm1yA1YZd1SjvlohHhLMljESawgUVukVakW900CP0I4vJwAZOKqVJvdCOw
	 m7fITnsPB7YrsWK9YfZT3xy3CYO+XpCsD/i8CS8/3CyTsVGNKtm9/XLqlabu2TbHzAbj0
	 q3ljNAGbyfqC6mK4zBaaRj8d9/v9H4taVZFqDSwZrZTruEfV/VSz/DEkmotUzTSrYxg56
	 hjYhQPmPmJ3T4MmUtU6/H5IQJcGqCuUxg2amfd4LE/4MkNtnP+hU4dCond/oaQ3c5nu0v
	 zcKDKnAZ/YTiXCgVCQ7jXHR4NtErZG3r/+ziWrp10hD7DzkFFPdM7ql+aEzUFFw4xng==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793896968;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-ZohoMailClient:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VdOXZ/MwaXcJALxDuy5RGlD8pzPqNyV923QPq8novrY=;
	b=jN6sg7pmjBVEnD450OxV3TDgklSZ5nK/SkkgSE4yaNcalkO+rgXxbXZaNdNNUzsksSPg
	 MhH59xhfKhqqsxUcr/UkUUU1pYRl+2K+X4c0e+3ffTwllIkVueu+KfIcvs80TxbzG7FQ0
	 f9cLvZJKZbs/TQY+OvCYi/9kfQV0NtD6SSL81MFXrBrfAI88yXu0wDeM4M3rbCuibDosc
	 1Uhi5mIMZw+wykPF5HR3z5Tii8Wr9DGUw5KyTxID1K7mQop/BOqzg0g+4yFSQoY3KFo2A
	 gqbSZbzekqoDeU/2VkPRWCkka0mPgPwkNyzhuitW7TXZnThhpFDMNDBoo4o8s9y0cQg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793896968;
	bh=VdOXZ/MwaXcJALxDuy5RGlD8pzPqNyV923QPq8novrY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LnPTr25fO4jhdpKh3tFr3IsdSYXxyEIzEQtj6hQaInqur+EVJixCd02XSy3lmsa+p
	 mlHZMb/P/hYP5ySJPh44euCAqW1PadlL04O5ln0q6hSdmL0uZ3TAskaWizWgS783Kk
	 OTaA5WB5g4Q0cAbE4taN0kB/41Ft+4bwUWZXuxMwBPWB/oCxgRfnQLAPjdBUsjfTuU
	 rCNEiqXJSFhwQ7gpRpBmsQJ7ThYkHgLpzYzdrJa6ogWD7BIanU4sKLaDhVuU0EE+yc
	 Xj4NkjEBLK1fJ5ZpCyodUNXm54VgOhlpbfASykybmz6SXknGuzIv+EG9vwksDvbSEo
	 6CNF4QWJIMnpQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5ED8E60878;
	Thu,  5 Nov 2026 16:42:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 208AF31F
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 16:42:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 05D8940869
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 16:42:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HPbr2MPw_pBE for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 16:42:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1815640829
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=junhui.liu@pigmoral.tech;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=pigmoral.tech header.i=@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=gENAv1fo
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1815640829
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 16:42:43 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=gENAv1foho+FAmmbu/lo+wsMfyJKDhLvrZZS1dxj/3aH1dzmF7c8oWEY/8rX+DHNXguFjj6r8JxbKxDifA1n9xNUYPT+1HoR/xrK9sxLJS+foVigczKuokBDrQAC6N/IT4gF/+joWOHDmcsJ3ACJml02zIqAQz24a0Y57ZI5HZw=;
 c=relaxed/relaxed; s=zmail; d=pigmoral.tech; v=1;
 bh=VdOXZ/MwaXcJALxDuy5RGlD8pzPqNyV923QPq8novrY=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793896949657928.990175647405;
 Thu, 5 Nov 2026 08:42:29 -0800 (PST)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Fri, 06 Nov 2026 00:40:41 +0800
Subject: [PATCH 3/5] riscv: dts: spacemit: k3: Add SPL device and image
 descriptions
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-k3-ddr-v1-3-1e60e1d78020@pigmoral.tech>
References: <20261106-k3-ddr-v1-0-1e60e1d78020@pigmoral.tech>
In-Reply-To: <20261106-k3-ddr-v1-0-1e60e1d78020@pigmoral.tech>
To: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>, 
 u-boot-spacemit@groups.io
Cc: Tom Rini <trini@konsulko.com>, Yixun Lan <dlan@kernel.org>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, E Shattow <e@freeshell.de>, 
 Huan Zhou <pericycle.cc@gmail.com>, Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2184;
 i=junhui.liu@pigmoral.tech; h=from:subject:message-id;
 bh=IyrDvPjSRo2Q7UdCf3JF10VEhYVQdX4MaM8nV8StWZE=;
 b=owGbwMvMwCWWvDb1VEXc8j+Mp9WSGLLebDzZrFry1ytycuNFGZaQD/Ec5T7fp0XuD5oW9eHaR
 GfjpLbYjlIWBjEuBlkxRRYuf/F/1jo8344ItN6HmcPKBDKEgYtTACYyt5aRoVe5fELw00x9/yun
 Ovf2TTgZqBA0+/K+OWzV7Sr9lik2oQz/Hd3Z1nkeCNNe/7mTi1X87DEWqUxZ9yK7mb8exO18Ib+
 FDQA=
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=openpgp;
 fpr=15B30CC69C4BF0CC3C08F85A2A90CDC122DF37BF
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the DDR controller node and mark the UART, I2C EEPROM and required
clock and reset providers for use before DRAM initialization.

Add a binman description for spl/u-boot-spl-mkimage.bin, combining SPL
with the external LPDDR5 PMU IMEM firmware and wrapping the payload in
a SpacemiT K3 boot image header.

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 arch/riscv/dts/spacemit-k3-binman.dtsi | 24 +++++++++++++++
 arch/riscv/dts/spacemit-k3-u-boot.dtsi | 54 ++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/arch/riscv/dts/spacemit-k3-binman.dtsi b/arch/riscv/dts/spacemit-k3-binman.dtsi
index f1c1c3ee6fd..3f77868a90c 100644
--- a/arch/riscv/dts/spacemit-k3-binman.dtsi
+++ b/arch/riscv/dts/spacemit-k3-binman.dtsi
@@ -4,3 +4,27 @@
  */
 
 #include "binman.dtsi"
+
+&binman {
+#ifdef CONFIG_SPL
+	spl-img {
+		filename = "spl/u-boot-spl-mkimage.bin";
+
+		mkimage {
+			args = "-T", "smtimage", "-n", "k3";
+
+			u-boot-spl-ddr {
+				type = "section";
+
+				u-boot-spl {
+				};
+
+				lpddr5-imem {
+					filename = "lpddr5_imem.bin";
+					type = "blob-ext";
+				};
+			};
+		};
+	};
+#endif
+};
diff --git a/arch/riscv/dts/spacemit-k3-u-boot.dtsi b/arch/riscv/dts/spacemit-k3-u-boot.dtsi
index 352e85e7de8..0976b2647b5 100644
--- a/arch/riscv/dts/spacemit-k3-u-boot.dtsi
+++ b/arch/riscv/dts/spacemit-k3-u-boot.dtsi
@@ -4,3 +4,57 @@
  */
 
 #include "spacemit-k3-binman.dtsi"
+
+&{/soc} {
+	ddrc@cb000000 {
+		compatible = "spacemit,k3-ddrc";
+		reg = <0x0 0xcb000000 0x0 0x01000000>,
+		      <0x0 0xcc000000 0x0 0x01000000>;
+		spacemit,apmu = <&syscon_apmu 0x4e8>;
+		bootph-pre-ram;
+	};
+};
+
+&i2c2 {
+	bootph-pre-ram;
+
+	eeprom@50 {
+		bootph-pre-ram;
+	};
+};
+
+&osc_32k {
+	bootph-pre-ram;
+};
+
+&pll {
+	bootph-pre-ram;
+};
+
+&syscon_apbc {
+	bootph-pre-ram;
+};
+
+&syscon_apmu {
+	bootph-pre-ram;
+};
+
+&syscon_mpmu {
+	bootph-pre-ram;
+};
+
+&uart0 {
+	bootph-pre-ram;
+};
+
+&vctcxo_1m {
+	bootph-pre-ram;
+};
+
+&vctcxo_24m {
+	bootph-pre-ram;
+};
+
+&vctcxo_3m {
+	bootph-pre-ram;
+};

-- 
2.56.0

