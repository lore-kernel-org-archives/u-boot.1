Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11DFC021A9
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 15:49:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03A348083C;
	Mon, 17 Feb 2025 16:48:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JvF0LzZ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E90B80C7E; Mon, 17 Feb 2025 16:48:57 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FA07807F1
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 16:48:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+j.ne.posteo.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 9512FA416F7;
 Mon, 17 Feb 2025 15:47:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A9B1C4CED1;
 Mon, 17 Feb 2025 15:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1739807334;
 bh=R2aqdgct/4UO7yYwAo4hIovStGgMvZ4nh0ptjXjk+jE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=JvF0LzZ4gvWMDHvY0cgrOtmR4ZIWDq/M6omXCW7+CMV6PbC/Zi0szfZcws4OGWAgB
 yXwvesofyQE0TXUcY0+/znNr/3q013DNvuVkqTRUDEpEuKyLDtIXduc7GAEnW/m0JJ
 QUFlwgepkzW84nS6c962LHF1n+uVvCX2sL4bZDe8caIhxhkdZa0H1UR9CoB7g99MmX
 dGc8mmapqMAKEMBoc05408IRHT4vuSceP/okIL9dg08aAIuUvjlELumbIxg5Vd2/7e
 TzZboDtXbzqm+9HuCuJd8MCQo9mjwfNZ5TZdrNjspZNVxBGvKBaFGyAw0kn5+lyvsX
 Mpj7jJ6ovzO7Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 30CB2C021AB;
 Mon, 17 Feb 2025 15:48:54 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?=
 <devnull+j.ne.posteo.net@kernel.org>
Date: Mon, 17 Feb 2025 16:48:48 +0100
Subject: [PATCH 2/2] powerpc: mpc8xxx_spi: Catch bad chip variants earlier
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250217-immap-size-v1-2-f9be2e9e7b1a@posteo.net>
References: <20250217-immap-size-v1-0-f9be2e9e7b1a@posteo.net>
In-Reply-To: <20250217-immap-size-v1-0-f9be2e9e7b1a@posteo.net>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739807332; l=899;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=5W7jFz6beA8z0UvlV/2wBUQm3SnOqHJ13+g3+6jkxJA=;
 b=7KiXl8HcXElruDRQtZri+d0+rX3Ge/7Q5+Y/Xibq8ylGCqZKsQ2eM4NnsZQZS6o3PJYSk1p9T
 Rx7ev36H+yhAHonmpX/lk8uRqOdbke4MPls96LLb6V5pEEu+uPiGYGg
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
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

Currently, enabling the MPC8xxx SPI driver on an unexpected SoC results
in a wall of errors because spi8xxx_t isn't defined. This is quite a bad
experience, so let's catch this kind of issue in mpc8xxx_spi.h.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
 arch/powerpc/include/asm/mpc8xxx_spi.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/include/asm/mpc8xxx_spi.h b/arch/powerpc/include/asm/mpc8xxx_spi.h
index 2b2095ad481d19a48e1f8d521626a0356773c0b5..3efd4bdcac2c3725a8065b3bb7faa11c78da0c78 100644
--- a/arch/powerpc/include/asm/mpc8xxx_spi.h
+++ b/arch/powerpc/include/asm/mpc8xxx_spi.h
@@ -28,6 +28,8 @@ typedef struct spi8xxx {
 } spi8xxx_t;
 static_assert(sizeof(spi8xxx_t) == 0x1000);
 
+#else
+#error "SPI register layout not defined: Unknown chip variant"
 #endif
 
 #endif	/* _ASM_MPC8XXX_SPI_H_ */

-- 
2.48.0.rc1.219.gb6b6757d772


