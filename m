Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6330A606A329
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 10:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZCXlHo4o;
	dkim=pass (2048-bit key) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=VBqMxZW+
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1B56E6073E;
	Mon, 16 Nov 2026 10:28:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gatV5AdZRqKJ; Mon, 16 Nov 2026 10:28:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 31CA5606CA
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794824932;
	b=rTMg8dGNj78PWj3Faut0HnhgNQOIvvCveJIxNspe1TUn/mioJYt9bz+WqyDYhTpH0lDv
	 rClkMghzqzzmjrIt0AbsZ6qF+hKa8W90XyPoc8+zjHhMeGj6/bAnw9ANk+hJsmEEVhyxr
	 gS+QfKuEKxuv3eZRxJF5QNpfxRQdpkSgw5cnWN/qeOYiB7WWNn0krhc2ST0FXl2NOftbU
	 e/tj+DrvyOG1aMHlDXOtROiu2NhcHj9I2aZVJETHq2xDvWFMUR+ypaqU1gEj/2ZfPfUYT
	 pUN0bit0/O2vNKdDr0nEjEeAQjn4zPQdWU+NYQP8B5FYLi6Xtg9WqDPWTuEGkEcgfkA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794824932;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LBCt9XPvBOS5oJyISZKDYc+PuTAGzOrGHm1GHFIecg8=;
	b=QX1Q7KIccHCs0nVsYlozykjDViaoOk/Xvq50UiYPdkDsRDnlt/Q3J5wZlUW+BLe8m+Mq
	 kma92zH9UhSa22bjEg9iPQny6CUC0VdBmIuQcmbECSnQZRyKzzFCIwuS3DH4azg4KQmpJ
	 QZIB/m1JHzlv3Xn3jt1p9ZP/OEBimAQcb2tUQPgEUvX34tKdMvXPWjvN1N0H3RpVatKgV
	 6j93vic9NV7DPqp1MrTmbxvigulPLs/VxkFBkQ5BYZ/RlKRXa1hkOFW3xxhP/4gUqaikA
	 3PgtvPS2+Lumaj4jRMVx/qE27oyNrG3+s+ghVk2wVNqUhJ5Efnj2rA8S9SrSYJTXKjg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=freeshell.de;
	dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=VBqMxZW+;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794824932;
	bh=LBCt9XPvBOS5oJyISZKDYc+PuTAGzOrGHm1GHFIecg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZCXlHo4o8rVloRJHCORF4SuhemVQhRt6Pr04tCFtHt+3SksFfHQwplSEtvfTkdw4A
	 BNLczX/tim7jTJFM25C1nAJJM/SpJNmL2m8gquyZyn7/VGEnMbjqXmpMdYTt6goJl9
	 TAGHuf/Du3fXJGz3aneHjuFUvMa3nd69LITuVHcQ44l+dNPOEpdCKPmpcY3tzqG1Am
	 d0YWGeZZnB+jYzLs8yTvLKcGmEC/ohHfYyMF0KOCJfNZSy+l3nRprYVlBYozRJ7mzH
	 gRcpSMJNEfVEzoiQBXUYwJG71ol/lmVrlUxlkBm7C2RE2SmvAFDVjuKv6mNg1pkm7Q
	 jL2B+68ONilSg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 31CA5606CA;
	Mon, 16 Nov 2026 10:28:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DF64428C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:28:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C61A0606CA
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:28:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZI9aaJn5arQe for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 10:28:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E22A3606AE
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=freeshell.de header.i=@freeshell.de
 header.a=rsa-sha256 header.s=s2025 header.b=VBqMxZW+
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E22A3606AE
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1794824868;
 bh=LBCt9XPvBOS5oJyISZKDYc+PuTAGzOrGHm1GHFIecg8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VBqMxZW+bejOgYXpRH7ob9FY4xCFcntgb81ClfuX+f2MAlOX9e1FaIHXlEHcwCtdE
 N3L+zaakXXkGmAwkIJYmxsrR0PUOXVVQZBNC81BI59je7izHBiCTwWVEdUk3WxUkMd
 zykMjlOMrzbUROD3L4PQFaI2DkLEGdCtO1XpWYqpaLE4uCKEme77IA69W1uR5rtFzS
 ugKJSrbAG0yVc/4tr2zmyTml5VNubP49GweD+8/Pw33EAF5P9vH1TFZm+DiJYM+RF1
 RcblroA6CLoRVPIAMXVz3HRAGcIPdWsq5yj2R1OyahOowZ5U/MJQ8Dxq5DgoNmdY+i
 LQqGt1vVCGapQ==
Received: from hay.lan (unknown [IPv6:2605:59ca:364f:d400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 8D13EB221467;
 Mon, 16 Nov 2026 11:27:46 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>,
 Yixun Lan <dlan@kernel.org>
Cc: E Shattow <e@freeshell.de>
Subject: [PATCH v3 4/4] riscv: dts: spacemit: k3: adopt com260/pico-itx 8gb
 memory override
Date: Mon, 16 Nov 2026 02:26:30 -0800
Message-ID: <20261116102653.36927-5-e@freeshell.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116102653.36927-1-e@freeshell.de>
References: <20261116102653.36927-1-e@freeshell.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Adopt [1] "SpacemiT K3 use 8gb memory size on CoM260 and Pico-ITX"

1: https://lore.kernel.org/linux-riscv/20261115195112.32120-1-e@freeshell.de/

Signed-off-by: E Shattow <e@freeshell.de>
---
 arch/riscv/dts/k3-com260-ifx-u-boot.dtsi | 9 +++++++++
 arch/riscv/dts/k3-pico-itx-u-boot.dtsi   | 9 +++++++++
 2 files changed, 18 insertions(+)
 create mode 100644 arch/riscv/dts/k3-com260-ifx-u-boot.dtsi
 create mode 100644 arch/riscv/dts/k3-pico-itx-u-boot.dtsi

diff --git a/arch/riscv/dts/k3-com260-ifx-u-boot.dtsi b/arch/riscv/dts/k3-com260-ifx-u-boot.dtsi
new file mode 100644
index 000000000000..cce42122a015
--- /dev/null
+++ b/arch/riscv/dts/k3-com260-ifx-u-boot.dtsi
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (c) 2026 E Shattow <e@freeshell.de>
+ */
+
+/* https://lore.kernel.org/linux-riscv/20261115195112.32120-2-e@freeshell.de/
+ * riscv: dts: spacemit: k3: use com260 8gb memory configuration
+ */
+/ { memory@100000000 { reg = <0x1 0x00000000 0x2 0x00000000>; }; };
diff --git a/arch/riscv/dts/k3-pico-itx-u-boot.dtsi b/arch/riscv/dts/k3-pico-itx-u-boot.dtsi
new file mode 100644
index 000000000000..8995d5e137eb
--- /dev/null
+++ b/arch/riscv/dts/k3-pico-itx-u-boot.dtsi
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (c) 2026 E Shattow <e@freeshell.de>
+ */
+
+/* https://lore.kernel.org/linux-riscv/20261115195112.32120-3-e@freeshell.de/
+ * riscv: dts: spacemit: k3: use pico-itx 8gb memory configuration
+ */
+/ { memory@100000000 { reg = <0x1 0x00000000 0x2 0x00000000>; }; };
-- 
2.53.0

