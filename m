Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092A8D72A11
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 20:00:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6C2E89489;
	Fri, 29 Nov 2024 21:00:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Oud5go9q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80E1789248; Fri, 29 Nov 2024 20:42:42 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADB9C89486
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 20:42:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+j.ne.posteo.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id BD22B5C5D70;
 Fri, 29 Nov 2024 19:41:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57D40C4CED2;
 Fri, 29 Nov 2024 19:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1732909356;
 bh=ddXzY+N/WtEAvyi8VxpzCOdjXAbcXGZTwj/7I9K/EB8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=Oud5go9qXJ/RlXukQ6JNQFZHeBxTHPp2AX25e6VFkAeb+HcDKZR0JVCnN3vMHTcUw
 stcrbWRkTj/u2QGbyVoZ4H2LDZSe4AHL5ZCO6km/pE6VeUclwxuTU0bfBA/lv58on+
 uGL83fjP0cXlPARMncMB3rNyv27OvPo4zU+9A8Ai7S/EatwQRu0bWf41nBsqCCxPNk
 HhSHxnCNIxLHEx7U2nvGaS6hMlnjoWTC2p6VmsrdyJqxR7bJl7aCJLCk6Hi6E+pRLp
 WFn/LNUBdE1/eOpYuMRKgCb+rKx1RvE5ACE3qvMwNHI3IUdfWWxoVmSZp3wM05PDzw
 HwpVZ+kGvUxmQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 474AED729FD;
 Fri, 29 Nov 2024 19:42:36 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?=
 <devnull+j.ne.posteo.net@kernel.org>
Date: Fri, 29 Nov 2024 20:42:28 +0100
Subject: [PATCH 1/2] clk: mpc83xx: Fix typo in "Coherent System Bus"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241129-typo-v1-1-1ac3fef74eee@posteo.net>
References: <20241129-typo-v1-0-1ac3fef74eee@posteo.net>
In-Reply-To: <20241129-typo-v1-0-1ac3fef74eee@posteo.net>
To: Mario Six <mario.six@gdsys.cc>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732909355; l=748;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=d1Imfeaz4mmEu1sdX3Ph06IdWoxZEdhIx3m0qbtgCfM=;
 b=LQ5Kp2MuI9bS+EQwehlTjN/qI/Cgl/84DfOtQp51ryVLtEq48CKlSeVvf9iE+VG6gzvzydwDk
 EwTbbh8p9YJAoVH6l3sLegMdY6WAefyy+t83arkOHhP4vR5atsPbIK9
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailman-Approved-At: Fri, 29 Nov 2024 21:00:21 +0100
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
Reply-To: j.ne@posteo.net
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: "J. Neuschäfer" <j.ne@posteo.net>

Cosmetic change.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
 drivers/clk/mpc83xx_clk.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/mpc83xx_clk.h b/drivers/clk/mpc83xx_clk.h
index c06a51ecd43a426e8ecd4e99a3f8ff3e902f9106..6b74fc5f16b613cec4fbc654644835fbc0dfe3eb 100644
--- a/drivers/clk/mpc83xx_clk.h
+++ b/drivers/clk/mpc83xx_clk.h
@@ -321,7 +321,7 @@ static inline u32 get_pci_sync_in(immap_t *im)
 }
 
 /**
- * get_csb_clk() - Read the CSB (Coheren System Bus) clock speed
+ * get_csb_clk() - Read the CSB (Coherent System Bus) clock speed
  * @im: Pointer to the MPC83xx main register map in question
  *
  * Return: The CSB clock speed value as a 32-bit number.

-- 
2.45.2


