Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876BC606A326
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 13:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XXWSo1Yu;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=gnhT7OA3
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DFDBD40A36;
	Wed, 11 Nov 2026 13:29:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NMK3gjuzkAIA; Wed, 11 Nov 2026 13:29:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3B38440A46
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794403799;
	b=F7s2v3aEb9FwkdsZro1SKgIcrdjxitmSFhJuCyEZr6SJJvZGPBEG2uyLMH1nP67mZBK8
	 iaseUZ/ZsBnr8uXWrZ9rJTZQ/tf1Q+Vrx3a9EIo1loIdyz5UjRlRfkoNQwVQG3/eWN2G8
	 WkjqHLp7G/6RVbfWs9dujtcD+ELbXRA+E80G+gJRWn2PIswcS9FQyC9X0Rs3g0vE2sP5P
	 NwGzfCCEKhkUkm910qM/Tkd2aXtBRnwVU7ZsBhFcv5H4WrEePIVQu/ZQFa0RX+G7E7hdG
	 nQ7bG6KS5jIl9cULI4NaAVTQ+5CceLeAcbky8yFEdTZXDwWLGSMXI+9f7/HhtPZWDRQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794403799;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=MXfJT54IKT1tW9APZmRN7l6QoTDYtqYJsGVh7OZgf9Q=;
	b=GFwe/DHFp1sbsCBlPvUDLJFzzdw3zlZhe9sVm28unTP3MSnBLMSt8yKH5Jd63zMVzBfi
	 2uQVT0nFRkqSBZfmp2DgYD0+ZiwpwWjvggAyQV4elciLmj7LFb4DaHA5bN2kYcV9mrcv8
	 S1fJCojbDDo9CKIGqGH2heMGrbuOD/Ubm2GePOAEWUTCXVqsusV//SF5t6uhNe0/x25bi
	 hjKoNGNNHBtRlCip8Z0HJspwM50T+xLEHfsghUIeakKXjwsChMUBljfb5WH47S15IATgJ
	 NoJ/IGAXR4Au9UHXkcwhavAal4Ui4S5dttWbfEhQjNibvW5iwZ4uXR9AHSnN0MnIPtw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=gnhT7OA3;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794403799;
	bh=MXfJT54IKT1tW9APZmRN7l6QoTDYtqYJsGVh7OZgf9Q=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XXWSo1Yuhs5cAmDpmTe1/iKONnbzUPmfl3DMWAu3mIy3d83Tv96NvT/5pSbBWBVd6
	 KJ5PSmxqePGEJKENFLsHisLV5hR2g0imtb6yr0i0RJENaXoKNierW9daHhBB4x0cMr
	 7pxWyb9oqiXlGkd17RVGKNGv2lmsd73k+fZF5g0M4DQgdMCYMsIA4TMHPg6UYYssIS
	 15RuiufEV7InPZkw+XbHJpddEsDLSk6tcs/hbSlkkoiTRgcFLlNgq1Aif9sAbfQIQP
	 3vM/iEZkxiAP9XQAuR6mKB6MPIZLoKohbRSzIMPB0kOFd/W5pXy99QXJMeLaIHlP6v
	 NzHe8FYNd3vng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3B38440A46;
	Wed, 11 Nov 2026 13:29:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3C7E7731
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 13:29:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 22B5A40A36
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 13:29:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wEHMa8m4bQIB for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 13:29:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D050740A46
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=80.241.56.161
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.161;
 helo=mout-p-103.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=gnhT7OA3
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D050740A46
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 13:29:54 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jPksB6TXxzKnVR;
 Wed, 11 Nov 2026 14:29:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794403790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=MXfJT54IKT1tW9APZmRN7l6QoTDYtqYJsGVh7OZgf9Q=;
 b=gnhT7OA34ml0ZVo22jStJPYhNT6DuERXCycaBAZ+q5swOAzHgSlHPqyUNcfNsFZ2t+yOM+
 st44Bq7Kk2PYp2WMR/ApeUEDqkwdoQFJpE93yFWM74LpE5oJam5HKuPXzUfZ0JwQBd3x/R
 14Yj4VhOmgHwO0Xo4RSslaDSjbEZMYu6oeNOcRi+2QRjZ7cZb3P9WPYgPQGz9wDZgkeyQB
 2+M2PoU6ZUq8YB3Agen6q9oNyXniJrWniKgteYesvQ3biRzL54bxUDXS2ihUX/kLbzBrQP
 z3rcxzzmtd7F1mOHhUM+9iwV54+F/t0mPlRE/XPxM5YF9lH+oIIsCdJIorUanw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/3] arm64: dts: renesas: Sort I2C4 node in R-Car
 M3-W/M3-W+/M3-N U-Boot extra DT
Date: Wed, 11 Nov 2026 14:28:06 +0100
Message-ID: <20261111132943.7216-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 7fhowi9fnfuj16b89fww3egtfquqf3ez
X-MBO-RS-ID: a676a6331c8a1107991
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

Place I2C4 node in the correct location on R-Car M3-W, M3-W+ and M3-N
U-Boot extra DTs. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 arch/arm/dts/r8a77960-u-boot.dtsi | 8 ++++----
 arch/arm/dts/r8a77965-u-boot.dtsi | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/dts/r8a77960-u-boot.dtsi b/arch/arm/dts/r8a77960-u-boot.dtsi
index 2a8c5a96390..d048efb3463 100644
--- a/arch/arm/dts/r8a77960-u-boot.dtsi
+++ b/arch/arm/dts/r8a77960-u-boot.dtsi
@@ -57,10 +57,6 @@
 	/delete-node/ vga;
 };
 
-&i2c4 {
-	/delete-node/ video-receiver@70;
-};
-
 / {
 	soc {
 		/delete-node/ fdp1@fe940000;
@@ -96,3 +92,7 @@
 &a57_1 {
 	/delete-property/ operating-points-v2;
 };
+
+&i2c4 {
+	/delete-node/ video-receiver@70;
+};
diff --git a/arch/arm/dts/r8a77965-u-boot.dtsi b/arch/arm/dts/r8a77965-u-boot.dtsi
index 6eb7bbeed26..269eb6a1814 100644
--- a/arch/arm/dts/r8a77965-u-boot.dtsi
+++ b/arch/arm/dts/r8a77965-u-boot.dtsi
@@ -46,10 +46,6 @@
 	/delete-node/ vga;
 };
 
-&i2c4 {
-	/delete-node/ video-receiver@70;
-};
-
 / {
 	soc {
 		/delete-node/ fdp1@fe940000;
@@ -69,3 +65,7 @@
 &a57_1 {
 	/delete-property/ operating-points-v2;
 };
+
+&i2c4 {
+	/delete-node/ video-receiver@70;
+};
-- 
2.53.0

