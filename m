Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B34BFC52D71
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 09:55:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18DBE88BAE;
	Fri,  9 Aug 2024 11:55:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F062788BE6; Fri,  9 Aug 2024 11:55:04 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A338887B4
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 11:55:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=richard@nod.at
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id B30496196A56;
 Fri,  9 Aug 2024 11:55:02 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id sacpgNlcminp; Fri,  9 Aug 2024 11:55:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id 4D94D6195FD7;
 Fri,  9 Aug 2024 11:55:02 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id KdKPfpOXh_DQ; Fri,  9 Aug 2024 11:55:02 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
 by lithops.sigma-star.at (Postfix) with ESMTPSA id F3DC161966C1;
 Fri,  9 Aug 2024 11:55:01 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, Jixiong.Hu@mediatek.com, marek.vasut+renesas@mailbox.org,
 patrick.delaunay@foss.st.com, ilias.apalodimas@linaro.org,
 xypron.glpk@gmx.de, seanga2@gmail.com, trini@konsulko.com,
 upstream+uboot@sigma-star.at, Richard Weinberger <richard@nod.at>
Subject: [PATCH v2 2/3] compiler: Ensure __builtin_*_overflow() support
Date: Fri,  9 Aug 2024 11:54:29 +0200
Message-Id: <20240809095430.3656-2-richard@nod.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240809095430.3656-1-richard@nod.at>
References: <20240809095430.3656-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

Both gcc and clang support this for a long time.
Make sure the feature is present.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 include/linux/compiler_types.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_type=
s.h
index 1a3060117f..8b6ce9c11c 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -70,6 +70,13 @@ extern void __chk_io_ptr(const volatile void __iomem *=
);
 #error "Unknown compiler"
 #endif
=20
+/*
+ * At least gcc 5.1 or clang 8 are needed.
+ */
+#ifndef COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW
+#error Unsupported compiler
+#endif
+
 /*
  * Some architectures need to provide custom definitions of macros provi=
ded
  * by linux/compiler-*.h, and can do so using asm/compiler.h. We include=
 that
--=20
2.35.3

