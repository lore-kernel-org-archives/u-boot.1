Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 435E7C282DE
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 01:39:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E6E3814B6;
	Tue, 11 Mar 2025 02:39:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=per1cycle.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=per1cycle.org header.i=@per1cycle.org header.b="iwNauUY6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A3038169D; Tue, 11 Mar 2025 02:39:26 +0100 (CET)
Received: from mail.per1cycle.org (mail.per1cycle.org [188.245.231.141])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9F9380F77
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 02:39:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=per1cycle.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@per1cycle.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A60FD4033C; Tue, 11 Mar 2025 01:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=per1cycle.org;
 s=dkim; t=1741657150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5SJwSnjLWh/oBt/UDKlYv24lO6gttKIXdbfnpAUEP2Y=;
 b=iwNauUY6pDR5h6KfB09s9x7+D53GxD7GQ8NrrRyufgKzJNRhzk03SQd5ge5DbSsgdVUEe5
 CvYgJW04WegPpwt9lswPXL06uG8xMfmKHasxj1joFwPdtF4+Jw/4KKxxm6qt5h+Q0ObSvs
 0OeKQ9VECEyuk1d4dOGurMkaiPLCHVFGoirqiKwSrOMSQVCL34VZpLbyopevGIFIzUEluf
 gzQTyW1tOPvpNugVoM/eITK2Q7dsBUU1GisJWR2st7N+1QtBwWuwDkH4ttWfZo47pMBwuX
 8k0Ng59QAD5UB/+JKfQhAVg3OcoHUATpKttMXRqjzFJjCMnyLUo0k/F5fPqWfA==
From: Huan Zhou <me@per1cycle.org>
Date: Tue, 11 Mar 2025 09:38:50 +0800
Subject: [PATCH v2 3/4] riscv: dts: k1: add reset controller node in device
 tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-reset-k1-v2-3-8a838752c265@per1cycle.org>
References: <20250311-reset-k1-v2-0-8a838752c265@per1cycle.org>
In-Reply-To: <20250311-reset-k1-v2-0-8a838752c265@per1cycle.org>
To: u-boot <u-boot@lists.denx.de>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Tom Rini <trini@konsulko.com>, Yixun Lan <dlan@gentoo.org>, 
 Huan Zhou <me@per1cycle.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741657131; l=1049;
 i=me@per1cycle.org; s=20241231; h=from:subject:message-id;
 bh=8wlCnMjOMf5LcYRPs/pmibDUGksAiTPk2NV2Ih9Ftr8=;
 b=DOrIzWUQAg46Hw2eF/sDw6vzTNI3NIwLz6gKyzAV4ymMeEGLjnXCmwEaGDslPrhZVxAeeZuzv
 xhXweSxE0C4C53N/UXHAgEjR8S4dDNx/Ms3lLK2brwCF9XKNQRAvXVc
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

Signed-off-by: Huan Zhou <me@per1cycle.org>
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

