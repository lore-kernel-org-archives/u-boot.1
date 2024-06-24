Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C8FC2BD05
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 08:35:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B684F88373;
	Mon, 24 Jun 2024 10:35:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719218119;
	bh=Ez9z+95LH4CLZHB2SgRGvQmtSik9xPXGjZ3/RYbSxNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HnLDXJ7pWK5Al6JDPj7o0DurJbsGIqHvl0NQx/2u4sapTtQST0Gi1rYcQr+aCDw/g
	 jgm3G0+xOxzDiLWkapAloB1H0LbDmLZ218gvNSSz0icW5au/UU2azBxdTUVKElsKWE
	 T5YTwGnQwr8hGtSozP1MeVDcAyc9lKKxKhXqPZv+XJok/nrS3X0wIeLNlrkZvNGlwD
	 Xt6K/dSSZVFW8d8k4aSZTG6dTmtkgdF/S40riThht9s7RyM/h21nLEnxBBjHzaL5lM
	 17FgAeqS/EhVS0bOjHTtm1gdSBYcroMYQV60N8KJhqg0FhDVavwuqk8dzzojjnFwd7
	 8/262IG0sJPUw==
Received: from localhost (unknown [IPv6:2001:861:52:5f60:ff6c:4545:dfcf:4c97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: pro@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E549F88307;
 Mon, 24 Jun 2024 10:35:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1719218119;
 bh=Ez9z+95LH4CLZHB2SgRGvQmtSik9xPXGjZ3/RYbSxNY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=eYgayFzD5Fl04DmTTFXa7Me6JRg8qL659MVGS0V/biGT8G9kqD7mAlYi7YZBtHsjG
 0u1fRICHJ2PgnOf4/TKp9rrTGQ6qG6HnEqcqiYby1oWJ/X4tqaR4NZpK66Akd1lIoc
 feM/P7D/9L19+bnX5ut//ASxBhAMKwntfsIUervTA0uRjhVwmnCF/sp9gwZ+tS+CH/
 +9cfaLw77aY1nSZOL6Kc3uOP9qej3zUABF77VPb2HF6KMEn/g1xiwrXk5sKAzqCTx+
 IrMU1kaN53LgEgY3QRSKn+a0i54/zvaA2YO0wpFY2hGd6rUmZcGnJ7dm2jw87B6GqO
 QuJ4AodgPM7sQ==
From: Philip Oberfichtner <pro@denx.de>
To: u-boot@lists.denx.de
Cc: bmeng.cn@gmail.com, caleb.connolly@linaro.org,
 christophe.roullier@foss.st.com, epsi@gmx.de, eugen.hristev@collabora.com,
 festevam@gmail.com, forbidden405@outlook.com, ivprusov@salutedevices.com,
 joe.hershberger@ni.com, jonas@kwiboo.se, kever.yang@rock-chips.com,
 leyfoon.tan@starfivetech.com, marek.vasut+renesas@mailbox.org,
 marjolaine.amate@odyssee-systemes.fr, neil.armstrong@linaro.org,
 n-francis@ti.com, patrice.chotard@foss.st.com,
 patrick.delaunay@foss.st.com, philipp.tomsich@vrull.eu,
 rfried.dev@gmail.com, seanga2@gmail.com, sebastian.reichel@collabora.com,
 sebastien.szymanski@armadeus.com, sjg@chromium.org, sumit.garg@linaro.org,
 trini@konsulko.com, xypron.glpk@gmx.de, Philip Oberfichtner <pro@denx.de>
Subject: [RESEND PATCH v2 1/5] x86: provide mb() macro
Date: Mon, 24 Jun 2024 10:34:46 +0200
Message-Id: <20240624083450.90297-2-pro@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240624083450.90297-1-pro@denx.de>
References: <20240624083450.90297-1-pro@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Implement memory barrier using mfence. Linux does it equivalently [1].

"The MFENCE instruction establishes a memory fence for both loads and
stores" [2].

[1] linux/arch/x86/include/asm/barrier.h
[2] Intel® 64 and IA-32 Architectures Software Developer’s Manual

Signed-off-by: Philip Oberfichtner <pro@denx.de>
---
 arch/x86/include/asm/io.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index 5efb2e1b21..936ad6f588 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -244,6 +244,7 @@ static inline void sync(void)
  * have some advantages to use them instead of the simple one here.
  */
 #define dmb()		__asm__ __volatile__ ("" : : : "memory")
+#define mb()		__asm__ __volatile__ ("mfence" : : : "memory")
 #define __iormb()	dmb()
 #define __iowmb()	dmb()
 
-- 
2.39.2

