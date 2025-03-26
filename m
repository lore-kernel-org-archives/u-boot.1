Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D92C28B30
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 05:01:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D415D81D3B;
	Wed, 26 Mar 2025 06:01:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="PdzCPGST";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 545E08186D; Wed, 26 Mar 2025 02:44:26 +0100 (CET)
Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com
 [203.205.221.242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FC938083E
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 02:44:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=423756212@qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1742953457; bh=/xNmSrvz0i8UBrUYBXIQ2cL87WBd97VeDILvhZNWH+g=;
 h=From:To:Cc:Subject:Date;
 b=PdzCPGSTX9jjrjD1YOAIJbRMxOKCzGWLnzPq/9O5OtWQSXxKPzNTBpBbVnURYNQjO
 4x2rG4bx4ZpcxyfC1Mm7oAlvFE8OmAvF1jNfX+8N/Q+wFYmAK1vvAziMTrXcTxFKm4
 +iu25BOuvt5RphrlmqJmZimrMxk6BfeF+BlILkEE=
Received: from server-204.smartlogictech.com ([103.90.178.122])
 by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
 id B0F19A06; Wed, 26 Mar 2025 09:44:15 +0800
X-QQ-mid: xmsmtpt1742953455ts0slwhlq
Message-ID: <tencent_1860C63CA04A383E29D25FC5C59DC5C2EB0A@qq.com>
X-QQ-XMAILINFO: NOfX9IN/+ZyZOM1YRst9qfpKb5J7+t7SbBJIDbFUY0c2OWCFsazKGRCuHAgsjg
 rt4bc1jLBWxXCN+s8AsIbpNTzFm+rn7sBvABqO2wouIfPS06unEHHblq8Bh8rrSty7EsIorB3gKg
 E43z8/mXBfgnKDttOtDynjOAo82FnGkDn/ZetIzHinKcCAALwGVxC0BQFqwVfuA5gqDuBwpJENtj
 fZRaHIBSoBSf38xZYJoMvVKng5+1zcsMknFVY2TyCNhpWCNj9NgsgvAfOwJGqTcdJXLj4Lpi4TKn
 U16Kbxptod7XU2pQC6M7pZz02ezZ9YnZURngMSIoF9lng+vNFgMemgL4PAOIqy+sU222OhaQcnX0
 JFMN909JtptwGZTDTRh9ltPT/NLC29pRSXyL49G0gXBDS1kSx4NTWIimlycYxkrB5rSPY+gv6abK
 yr2F+RHgqQ2GU7c1VBQdcOe4GHMqVlpzg136SDN/RqUzZFGV+RCLdz7sLePgGOtN7xUmZlXFqLre
 ETIc0XuRUu5YI0zg77CASdqADQHolLw9WJQUCtUoVP+Y40jN6JQMx4Eanu0Mr2qfvVmNO+c6IN8L
 ex5cF3te/OFAGfCC96+vL5tlteGHuOv0UNFWv3hTOL58IVosSqPUo2PWV8rwU2KalRcUEPS3Fho+
 Q7xy8PmsrEjnyqFvM9LhrteCKDSB4Qq4SDw1pT4F2RJ5BEfLoB7JXvXOH/cIykjmyOP3H2cg+/vr
 RDDm6lYvllQtVsBfMdDbn0MtgKpidLuHJaEcxOocrNlGh7WhuppnpX2ZuBH++EtbZ/RButu0x+vH
 AvMVanyYOuYJVAzGzqnxm7D8y2jqjzSFAKzm0AQ3OwiqB8T5I8EaTbhVZKJzGgYh3q7y+pYarkQE
 Cu0lJX43BLwhlb+XBttSwzHxa5KkX7K26oY6TRvUsXdYqMlUozBbT5EcJiFLLhXL5fmUzPLBlz
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Xu Zhang <423756212@qq.com>
To: u-boot@lists.denx.de
Cc: Xu Zhang <423756212@qq.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] armv8: start.S: Subordinate CPUs psci setup vector
Date: Wed, 26 Mar 2025 09:44:12 +0800
X-OQ-MSGID: <20250326014412.15422-1-423756212@qq.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 26 Mar 2025 06:01:30 +0100
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

As current design, only Manager CPU called armv8_setup_psci() before
jump to next stage(such as Linux Kernel), Subordinate CPUs also need
setup psci vector to handle trap request which comes from higher EL
level.

Signed-off-by: Xu Zhang <423756212@qq.com>
---

 arch/arm/cpu/armv8/start.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/cpu/armv8/start.S b/arch/arm/cpu/armv8/start.S
index d3a8a7c4787..c7872e935e9 100644
--- a/arch/arm/cpu/armv8/start.S
+++ b/arch/arm/cpu/armv8/start.S
@@ -334,6 +334,9 @@ WEAK(lowlevel_init)
 	/*
 	 * All slaves will enter EL2 and optionally EL1.
 	 */
+#if defined(CONFIG_ARMV8_PSCI)
+        bl      psci_setup_vectors
+#endif
 	adr	x4, lowlevel_in_el2
 	ldr	x5, =ES_TO_AARCH64
 	bl	armv8_switch_to_el2
-- 
2.20.1

