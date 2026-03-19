Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C44771091931
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 23:02:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3AB9840F1;
	Fri, 20 Mar 2026 00:01:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vNHHfxvp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B98483FC0; Thu, 19 Mar 2026 21:57:17 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F336783F8A
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 21:57:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-439b7c2788dso786261f8f.1
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 13:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773953834; x=1774558634; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OJvm8hJq5dvTL5t+nuiKKxZ20+5uLhO/dmppj5+JcmU=;
 b=vNHHfxvp1Wmt/dZc7NLJHFHWNCMJoHrJQUfNNDflqh17sxtnWScAsAw1qxW5Qey1WD
 nzDDWEEWF0QBQ9W/fPkdOTpV/1ChvmsbaMqz/PbALe+Ys4HKFwa4XSHOYV8zsR7d4iDI
 VRWmwJrqb1i3pYolch2AwB5zO/VQDPekvN0OyG7CmkfwANJ32AL8016775UK7fZV29ow
 DGaHfNTIyYKEOD8l48VRBXrGhCESDG+AJjHXlmt1JUfvAv9cgmHQWR8EcfWkePNh52ry
 BHDQghCB2tXE3qCBrCAQlKY5FoD+bfCOeYgXe2qMvGdYi3gxVsaUq+FLXG8hvDIjZcLg
 PLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773953834; x=1774558634;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OJvm8hJq5dvTL5t+nuiKKxZ20+5uLhO/dmppj5+JcmU=;
 b=sUK0fRIQuX31DFltMKJrXxQvaVsmxvxOxZes/BuMK2UVKyged0Is7DF7B8eqrjjW9C
 Dacc6tamO30gBKIpf42DJTFehmqpXUQOARypNjlEiA2/zd4Z+cUB1ptewYMk7SB2vX2p
 cptnLGkx5SGaX0GzBqQDMIewCX2CKjAfhFwsXqaU5FD9oly3wQIouEBDZNNzLeinfyt8
 T5/mDacsaGfFhHpaAhBjM5QBkI/Wx2xMdj9fBHGjLWadJEccg6y/neBzYbWQBZwPyRfM
 s1PR3LUpfL/6vVnP9R89Lxl1zZ+2duzDsY+3Leb+jTtb0jtKDg7k3/30nlaYcsBouBX+
 7VpQ==
X-Gm-Message-State: AOJu0YyN0ULQfmFkiFoi7S2B0i4n/TVW9yy9OzHYCBZACT1bSIvEKkis
 rIpJholNWi4BWT1F/vyle5mjC95aIg6Q7dF4pcMvTlwkSw+pLiEg3dIS37dx8CgVMpo=
X-Gm-Gg: ATEYQzywDDvyrMQPHQb9glsqrazjw1C2IEiGkE/hB0+DFlVN8KWxIFpjUBVzXDEGbW6
 D+ffH12zZKVUoPdK+PwUXkAE+mSLZ3Z3mMSfPVEZNupKJoA9XiIGLxHLEQD67d6liyJdPcYhX5H
 Fd2XCAlvchGhRARPy/INTCbzvA94+k3hCh5ggOP7EamM+9ERhD8ki5aAl/+EcVoDSWOBUwLK+Sx
 KAVP83JAemK2WKUcCE99qbcaXcTm8dh733AfRUT8sB0QH9iSsmc0oa+UjsJCW225cjv2zORfGCR
 gaixR5P2yil7lyEGUyS2t5WTlowgL/cMzZG4TjuCUPjn3tHE9NcI0FLjsVXNBndkPaFgTzCx/EX
 G+ienJj2j6KFatAeeGi5dPkbvttkEEkbCG3C5CkYyoINzFKVO6+xZR7/SkaPMHWnTjsTOrjQnkH
 e2Yy/Lgdt+KNp5gItA7MU5p4BLKNLFUJf59JG26iFx/AM5OMhmlkZM7pgNIaFOkDmMJEY=
X-Received: by 2002:a05:6000:22c7:b0:437:745f:a6b8 with SMTP id
 ffacd0b85a97d-43b642432d7mr1437628f8f.9.1773953834211; 
 Thu, 19 Mar 2026 13:57:14 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd39.dip0.t-ipconnect.de.
 [79.195.221.57]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64714e2esm1191396f8f.32.2026.03.19.13.57.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 13:57:13 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 19 Mar 2026 21:56:27 +0100
Subject: [PATCH RFC 05/40] string: add strdup_const and kstrdup_const
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-casey-ccf-upstream-v1-5-4df2ee2226da@linaro.org>
References: <20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org>
In-Reply-To: <20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org>
To: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>, 
 u-boot-qcom@groups.io, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Paul Barker <paul@pbarker.dev>, Dai Okamura <okamura.dai@socionext.com>, 
 linux@analog.com, uboot-snps-arc@synopsys.com, u-boot-amlogic@groups.io, 
 uboot-stm32@st-md-mailman.stormreply.com, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Stephen Boyd <swboyd@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Yannick Fertre <yannick.fertre@foss.st.com>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Yao Zi <me@ziyao.cc>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peter Korsgaard <peter@korsgaard.com>, Greg Malysa <malysagreg@gmail.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Sean Anderson <seanga2@gmail.com>, Liviu Dudau <liviu.dudau@foss.arm.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, Thierry Reding <treding@nvidia.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Ryan Wanner <Ryan.Wanner@microchip.com>, 
 Varshini Rajendran <varshini.rajendran@microchip.com>, 
 Manikandan Muralidharan <manikandan.m@microchip.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, Jens Reidel <adrian@mainlining.org>, 
 David Wronek <david.wronek@mainlining.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 David Lechner <dlechner@baylibre.com>, Nishanth Menon <nm@ti.com>, 
 Alice Guo <alice.guo@nxp.com>, Valentin Caron <valentin.caron@foss.st.com>, 
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>, 
 Naman Trivedi <naman.trivedimanojbhai@amd.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Jonathan Currier <dullfire@yahoo.com>, Sam Shih <sam.shih@mediatek.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Loic Poulain <loic.poulain@oss.qualcomm.com>, Sam Day <me@samcday.com>, 
 Rui Miguel Silva <rui.silva@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Shmuel Leib Melamud <smelamud@redhat.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Finley Xiao <finley.xiao@rock-chips.com>, 
 Joseph Chen <chenjh@rock-chips.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Andrew Davis <afd@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, 
 Udit Kumar <u-kumar1@ti.com>, Heiko Schocher <hs@nabladev.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Paul Sajna <sajattack@postmarketos.org>, Marek Vasut <marex@denx.de>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=4099;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=5jwUMh0k+N1QnC8WW0D/qoE/XYGivWXyZ6pP2y+2UGs=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsw9ybwvjA6WOG9Zav4uzHiHZUrt3R5/MXmRHfcuf3j/9
 PjO69qHO0pZGAQ5GGTFFFnETyyzbFp72V5j+4ILMHNYmUCGMHBxCsBEFvEx/I/dz8bzxldfs27O
 qQ2/hFumnf/aclE7+bkQ36TMJw+al9Qx/DPkeqQ52V3YdcNpqzPhCc8VzhsHf3tx5ejPwB4t97m
 e94IB
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-Mailman-Approved-At: Fri, 20 Mar 2026 00:01:15 +0100
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

Extend Linux compat by adding kstrdup_const(), backed by lib/string.c.
This leverages U-Boots .rodata section on ARM64 to avoid pointlessly
duplicating const strings.

This is used by the Linux CCF_FULL port and may be useful elsewhere
in U-Boot.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 include/asm-generic/sections.h | 19 +++++++++++++++++++
 include/linux/compat.h         | 13 +++++++++++++
 include/linux/string.h         |  2 ++
 lib/string.c                   | 31 +++++++++++++++++++++++++++++++
 4 files changed, 65 insertions(+)

diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index d59787948fd1..48bd4fa86043 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -8,8 +8,9 @@
 #ifndef _ASM_GENERIC_SECTIONS_H_
 #define _ASM_GENERIC_SECTIONS_H_
 
 #include <linux/types.h>
+#include <stdbool.h>
 
 /* References to section boundaries */
 
 extern char _text[], _stext[], _etext[];
@@ -61,8 +62,26 @@ static inline int arch_is_kernel_data(unsigned long addr)
 	return 0;
 }
 #endif
 
+/**
+ * is_kernel_rodata - checks if the pointer address is located in the
+ *                    .rodata section
+ *
+ * @addr: address to check
+ *
+ * Returns: true if the address is located in .rodata, false otherwise.
+ */
+static inline bool is_kernel_rodata(unsigned long addr)
+{
+#ifdef CONFIG_ARM64
+	return addr >= (unsigned long)__start_rodata &&
+	       addr < (unsigned long)__end_rodata;
+#else
+	return false;
+#endif
+}
+
 /* U-Boot-specific things begin here */
 
 /* Start of U-Boot text region */
 extern char __text_start[];
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 623814516175..d4ba4d0088a0 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -66,8 +66,21 @@ static inline void vfree(const void *addr)
 {
 	free((void *)addr);
 }
 
+/**
+ * kstrdup_const - conditionally duplicate an existing const string
+ * @s: the string to duplicate
+ * @gfp: the GFP mask used in the kmalloc() call when allocating memory
+ *
+ * Note: Strings allocated by kstrdup_const should be freed by kfree_const and
+ * must not be passed to krealloc().
+ *
+ * Return: source string if it is in .rodata section otherwise
+ * fallback to kstrdup.
+ */
+#define kstrdup_const(s, gfp) strdup_const(s)
+
 struct kmem_cache { int sz; };
 
 struct kmem_cache *get_mem(int element_sz);
 #define kmem_cache_create(a, sz, c, d, e)	get_mem(sz)
diff --git a/include/linux/string.h b/include/linux/string.h
index d943fcce690c..a8a6cf4af505 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -103,8 +103,10 @@ size_t strcspn(const char *s, const char *reject);
 
 #ifndef __HAVE_ARCH_STRDUP
 extern char * strdup(const char *);
 extern char * strndup(const char *, size_t);
+extern const char *strdup_const(const char *s);
+extern void kfree_const(const void *x);
 #endif
 #ifndef __HAVE_ARCH_STRSWAB
 extern char * strswab(const char *);
 #endif
diff --git a/lib/string.c b/lib/string.c
index d56f88d4a847..302efe048b07 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -378,8 +378,39 @@ char * strndup(const char *s, size_t n)
 	new[len] = '\0';
 
 	return new;
 }
+
+/**
+ * strdup_const - conditionally duplicate an existing const string
+ * @s: the string to duplicate
+ *
+ * Note: Strings allocated by kstrdup_const should be freed by kfree_const and
+ * must not be passed to krealloc().
+ *
+ * Return: source string if it is in .rodata section otherwise
+ * fallback to kstrdup.
+ */
+const char *strdup_const(const char *s)
+{
+	if (is_kernel_rodata((unsigned long)s))
+		return s;
+
+	return strdup(s);
+}
+
+/**
+ * kfree_const - conditionally free memory
+ * @x: pointer to the memory
+ *
+ * Function calls kfree only if @x is not in .rodata section.
+ */
+void kfree_const(const void *x)
+{
+	if (!is_kernel_rodata((unsigned long)x))
+		free((void *)x);
+}
+
 #endif
 
 #ifndef __HAVE_ARCH_STRSPN
 /**

-- 
2.51.0

