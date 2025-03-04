Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF91C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 07:04:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DC6D812D9;
	Tue,  4 Mar 2025 08:03:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=per1cycle.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=per1cycle.org header.i=@per1cycle.org header.b="gLcGu0jJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 626BD80FD8; Tue,  4 Mar 2025 08:03:42 +0100 (CET)
Received: from mail.per1cycle.org (unknown [IPv6:2a01:4f8:c013:8d4e::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BAF181249
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 08:03:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=per1cycle.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@per1cycle.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BAB923FE21; Tue,  4 Mar 2025 07:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=per1cycle.org;
 s=dkim; t=1741071819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5EkuMcGEIwZ4sb71Ggwr7tyljYLHKEVbP0mJDYAwxIY=;
 b=gLcGu0jJEkUtPbBqjynd07jQGApa+s15kpNROAN9qrbNGUYVZBPiP6j6DfChVtMIbF1T1i
 /IDmzrECssB+SbhplvfDs58RRRhsQDxottf1XbfUdn8nh+516r5mznx5Aya8Iv6E++dqE8
 tvZHohC91cHz04jIxnv2Kyj7+PKzEW2dqhHT0pq8YR5W5gYkWAbd+FhQNYtmIP6+S2ZpGF
 8sgyGl5r+xYPwReELT4X24BIm+JlRaLvJEOFW0pdKbSI0sNYVPBI54op3euaOQEwLFM7Uo
 kwsnNdFcdxVmrPlHHvtZraPyG2cBl6uCv9RSr8PzdDAGCtz+hzaWzhr1vX868g==
From: Huan Zhou <me@per1cycle.org>
Date: Tue, 04 Mar 2025 15:03:29 +0800
Subject: [PATCH 3/4] riscv: dts: k1: add reset controller node in device tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-reset-k1-v1-3-dc9510ff1113@per1cycle.org>
References: <20250304-reset-k1-v1-0-dc9510ff1113@per1cycle.org>
In-Reply-To: <20250304-reset-k1-v1-0-dc9510ff1113@per1cycle.org>
To: u-boot <u-boot@lists.denx.de>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Tom Rini <trini@konsulko.com>, Yixun Lan <dlan@gentoo.org>, 
 Huan Zhou <me@per1cycle.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741071809; l=1002;
 i=me@per1cycle.org; s=20241231; h=from:subject:message-id;
 bh=4uyAz24UAVviy6OIM4BTxF7se3yUVjHVz7xw6TMBOl0=;
 b=y0fSSgrJLlvQdrw7Mzx0GQrnTKaDx6GZNvtqtBnP6PmlXxHvcVXicV5reqgFS8AgOi2AovTtf
 apmT9qodbnyBeWAT2yGiCAvsQ5dZIvOfBOmNGHiRkLozkw3V0A9dSUn
X-Developer-Key: i=me@per1cycle.org; a=ed25519;
 pk=LfN2kXe1uCRoaEzAJ8quXuPIH4MiEnZHOCRZwGytJwE=
X-Last-TLS-Session-Version: TLSv1.3
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

Add reset-controller in k1 device tree.
---
 arch/riscv/dts/k1.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/riscv/dts/k1.dtsi b/arch/riscv/dts/k1.dtsi
index 514be453dbaf6713cdf4ad5a5d653488297ebb83..b3e3f81d4dfa6e64dd4a00625280e43b014a6915 100644
--- a/arch/riscv/dts/k1.dtsi
+++ b/arch/riscv/dts/k1.dtsi
@@ -455,5 +455,20 @@
 			reg-io-width = <4>;
 			status = "reserved"; /* for TEE usage */
 		};
+
+		reset: reset-controller@d4050000 {
+			compatible = "spacemit,k1-reset";
+			reg = <0x0 0xd4050000 0x0 0x209c>,
+				<0x0 0xd4282800 0x0 0x400>,
+				<0x0 0xd4015000 0x0 0x1000>,
+				<0x0 0xd4090000 0x0 0x1000>,
+				<0x0 0xd4282c00 0x0 0x400>,
+				<0x0 0xd8440000 0x0 0x98>,
+				<0x0 0xc0000000 0x0 0x4280>,
+				<0x0 0xf0610000 0x0 0x20>;
+			reg-names = "mpmu", "apmu", "apbc", "apbs", "ciu", "dciu", "ddrc", "apbc2";
+			#reset-cells = <1>;
+			status = "disabled";
+		};
 	};
 };
\ No newline at end of file

-- 
2.39.5

