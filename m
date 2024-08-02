Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C2C1C3DA49
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 09:25:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CF0188B91;
	Fri,  2 Aug 2024 11:25:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1722590752;
	bh=Ebc+NYxi3ArmJ3ntoBidaZkwunE3dSNCimVBrqfO3T0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IeqeRLNaSpxBLT7ADzlHm4JPV/rsKwky6AL8YZf3PG+fAYF9Hl5G1Ez/9k//wRCB9
	 mrbCgDZhfg6Q2RBrt7o0zskhSEUks06vgZQ07JDJGVy7XsuXkZHoSMSofS/b7o/qbN
	 jZ/w3vJ4P2H7zMkeoVwEfdic7vvwrF38tJQrQr0unr0JVf/fuDN1tqufvxlEN6Go59
	 bbj4wMbD4OPIvCjXAxQKMtzofKgea9M5lDns1Dvz31xGBResQLnX9Kb1gtU3Zr+xX0
	 lqlYwG9rBS0i8eoFN/S22/jvdw910JJ933mcpDWbIBWQLPutYONlcMDM4J8RTnsxoM
	 SEcw0vAwTh7pw==
Received: from localhost (unknown [IPv6:2001:861:52:5f60:7f4c:42be:fdf8:3b8a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: pro@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id AE09988B9E;
 Fri,  2 Aug 2024 11:25:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1722590751;
 bh=Ebc+NYxi3ArmJ3ntoBidaZkwunE3dSNCimVBrqfO3T0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=i4dPOiyol+KgPyrSe0FFA218a1+7YdKMB63PLemF3fUClnwLx1J6G1uNt0IYZJmFB
 kg1e6kZr986wXvWIMET17/kTTghYvLrWhtZVQQtBN8y5CQb3SQLuHfBDa3VZiEgT2N
 A7Dn159LxRMeSPzvxscaqcsbXeQNG+86QiMZjeeJmGtASIsVqGBA7Hdyw9OiMpjQE1
 B2W72kMBjw7/yr3Nd+TXYCEPs9nDMlDyFJN6uNy86T71oyWA2fyTlOr7b3tE3Ox0Qu
 08+PrhllhOFgiUwX2PALZv5UOoQBeDLqeZxy6OJJvqdIrGta+b1yypEyniFXM4Lyxc
 jzE3qXceGGYsw==
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
 trini@konsulko.com, xypron.glpk@gmx.de, marex@denx.de,
 Philip Oberfichtner <pro@denx.de>
Subject: [PATCH v4 1/5] x86: provide mb() macro
Date: Fri,  2 Aug 2024 11:25:35 +0200
Message-Id: <20240802092539.162892-2-pro@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240802092539.162892-1-pro@denx.de>
References: <20240802092539.162892-1-pro@denx.de>
MIME-Version: 1.0
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

Implement a x86 memory barrier mb(). Furthermore, remove the previously
used mfence() function, which does the same thing.

The mb() macro is now equivalent to Linux (v6.9):
linux/arch/x86/include/asm/barrier.h

Signed-off-by: Philip Oberfichtner <pro@denx.de>
---

Notes:
    Changes in V4: None
    
    Changes in V3:
    	- Remove mfence() function

 arch/x86/cpu/mp_init.c     | 10 +++++-----
 arch/x86/include/asm/cpu.h |  5 -----
 arch/x86/include/asm/io.h  |  1 +
 3 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/x86/cpu/mp_init.c b/arch/x86/cpu/mp_init.c
index aa1f47d722..e2e1849c06 100644
--- a/arch/x86/cpu/mp_init.c
+++ b/arch/x86/cpu/mp_init.c
@@ -164,12 +164,12 @@ static inline void barrier_wait(atomic_t *b)
 {
 	while (atomic_read(b) == 0)
 		asm("pause");
-	mfence();
+	mb();
 }
 
 static inline void release_barrier(atomic_t *b)
 {
-	mfence();
+	mb();
 	atomic_set(b, 1);
 }
 
@@ -631,7 +631,7 @@ static int run_ap_work(struct mp_callback *callback, struct udevice *bsp,
 		if (cur_cpu != i)
 			store_callback(&ap_callbacks[i], callback);
 	}
-	mfence();
+	mb();
 
 	/* Wait for all the APs to signal back that call has been accepted. */
 	start = get_timer(0);
@@ -656,7 +656,7 @@ static int run_ap_work(struct mp_callback *callback, struct udevice *bsp,
 	} while (cpus_accepted != num_aps);
 
 	/* Make sure we can see any data written by the APs */
-	mfence();
+	mb();
 
 	return 0;
 }
@@ -692,7 +692,7 @@ static int ap_wait_for_instruction(struct udevice *cpu, void *unused)
 
 		/* Copy to local variable before using the value */
 		memcpy(&lcb, cb, sizeof(lcb));
-		mfence();
+		mb();
 		if (lcb.logical_cpu_number == MP_SELECT_ALL ||
 		    lcb.logical_cpu_number == MP_SELECT_APS ||
 		    dev_seq(cpu) == lcb.logical_cpu_number)
diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index 073f80b07f..87e0c6f12b 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -185,11 +185,6 @@ static inline int flag_is_changeable_p(uint32_t flag)
 }
 #endif
 
-static inline void mfence(void)
-{
-	__asm__ __volatile__("mfence" : : : "memory");
-}
-
 /**
  * cpu_enable_paging_pae() - Enable PAE-paging
  *
diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index c6d90eb794..1390193f09 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -240,6 +240,7 @@ static inline void sync(void)
  * have some advantages to use them instead of the simple one here.
  */
 #define dmb()		__asm__ __volatile__ ("" : : : "memory")
+#define mb()		__asm__ __volatile__ ("mfence" : : : "memory")
 #define __iormb()	dmb()
 #define __iowmb()	dmb()
 
-- 
2.39.2

