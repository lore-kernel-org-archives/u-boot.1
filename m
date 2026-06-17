Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8328CD98F0
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 12:30:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A800849A1;
	Wed, 17 Jun 2026 14:29:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JV+0RSJ9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0F05838BB; Wed, 17 Jun 2026 11:26:36 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED526848EB
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 11:26:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+raz.benyehuda.mobileye.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C792C6012A;
 Wed, 17 Jun 2026 09:26:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A4C1C2BCB0;
 Wed, 17 Jun 2026 09:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1781688391;
 bh=VZCq1y84yK5BN21LbUxkMzZCN57S4o/cxZhr3EXKK7s=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=JV+0RSJ9fKDII0fHau0cI3jJ6Cs8OTRWM1mvedoHqtCYfvkw9V6blbIkmMGpnL3On
 n3EZxQVltJLw+sSCVynWC9i68lSc3haUWGd2quIWIYrjduPgM8dYVX4jA2NUs5miWx
 UKtzKy5aZyEOA/pSLCQ+YvfQvrb1DGTz5XQiAAXwRC4EKPJFzrF7DmpIWhD00Ch9Jl
 klhNJkDa+Yc+kNFwGkgwEAD2irJuTDQL3BFa2/dzpqzP+VhSd54x/Q7F3zvo/HTrtP
 xBYGkntAkYGTOogw3zpviO7GgA6ADk//frIawg6dz3EQQLWjqxGkUOubQKzFR4Vcko
 sjijS3E731/DQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 93AB0CD98E2;
 Wed, 17 Jun 2026 09:26:31 +0000 (UTC)
From: Raz Ben Yehuda via B4 Relay
 <devnull+raz.benyehuda.mobileye.com@kernel.org>
Date: Wed, 17 Jun 2026 12:26:17 +0300
Subject: [PATCH v5 5/5] ufs: wmb is not implemented in x86.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-ufs_tool2-v5-5-1cf099f71111@mobileye.com>
References: <20260617-ufs_tool2-v5-0-1cf099f71111@mobileye.com>
In-Reply-To: <20260617-ufs_tool2-v5-0-1cf099f71111@mobileye.com>
To: u-boot@lists.denx.de
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Vladimir Kondratiev <vladimir.Kondratiev@mobileye.com>, 
 Raz Ben Yehuda <raz.benyehuda@mobileye.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=792;
 i=raz.benyehuda@mobileye.com; h=from:subject:message-id;
 bh=nydWn0gbQOIFrfZq/h+hyYVuDb3OiJ5/WINnvK7yB10=;
 b=owEBbQKS/ZANAwAKAZ+a6ZSW6I45AcsmYgBqMmhFTjU3xeXkx5bGDyGSkG1yrF0Ne4feL0hQx
 29PWv4jbvKJAjMEAAEKAB0WIQSC7lz5E3UmOrJvRDqfmumUluiOOQUCajJoRQAKCRCfmumUluiO
 OULPEAChE1dNCMnJXxsX2yKpeGZ8RlDs/drD90ChrsOi6eP2tM/KiqoFF89OkcEbCyAO6UbrzMd
 vlSndOP6aOBcyDEZhi3/5cD9QtHHHkmrZrrlUj0/NQuYRdRJeDdbWU4cQ1UopCZcYDFR63xYpVI
 +HSD5mzBKLsZILC0fqZwU644BLFfJUc42fag1Cnj0g4HFWKZZGNvVjDT+28oQMIvVm1PmWRgg/J
 2uQbYT+Bt/xxrKzlG+J91qQnG4Si10jHepao5m68pIDO5aFGFdaT26slWS6b0KPXREOfxgh/aJt
 JcSlc9LswEPrt8CpMNpq6QqgNyiMHV+pPLG6QZusWVgsAfmLJe0N0XiPCPJUOjvc7HSaZqr+pcK
 kTi2JfqfipA4eUevsyge1+oVfbFDWq9MDSGKD3UKnrrVEbMG5diebgtf45g1HlyH/mWIy1bRAGz
 e97Z0sFJBxnyulcxAfNIXYAA6AVhlh6gkHPb1Y7mgun9fz2W4irDr5704/091tP6gWSEQTuJWSs
 TB64GDLHXPYra40M0lhIcMGIU8EtHHw4rJymgUKbL5jeWBMG8A+gLxZIUZHp4Gcdr7ia4qVaAbc
 gaMMR/LvEW9ME4vT4qqRG5zU7xU5HlrkaHgoJ+WxjHPMiiJw+32Arnh7L8xuEoSDFzo0TWyIkK9
 Nlxu4uC5inWWJqg==
X-Developer-Key: i=raz.benyehuda@mobileye.com; a=openpgp;
 fpr=82EE5CF91375263AB26F443A9F9AE99496E88E39
X-Endpoint-Received: by B4 Relay for raz.benyehuda@mobileye.com/default
 with auth_id=808
X-Original-From: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
X-Mailman-Approved-At: Wed, 17 Jun 2026 14:29:55 +0200
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
Reply-To: raz.benyehuda@mobileye.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Raz Ben Yehuda <raz.benyehuda@mobileye.com>

sfence: All stores (writes) issued before the fence become
globally visible before any store issued after the fence
memory: Compiler barrier

Signed-off-by: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
---
 arch/x86/include/asm/io.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index 1390193f09c..9293588c9d7 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -241,6 +241,8 @@ static inline void sync(void)
  */
 #define dmb()		__asm__ __volatile__ ("" : : : "memory")
 #define mb()		__asm__ __volatile__ ("mfence" : : : "memory")
+#define wmb()		__asm__ __volatile__ ("sfence" ::: "memory") /* store mem barrier */
+
 #define __iormb()	dmb()
 #define __iowmb()	dmb()
 

-- 
2.43.0


