Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D50C41513
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 15:35:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C4158884D;
	Wed, 22 May 2024 17:35:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="kBcnkvOX";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hc1dT7Pg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7992A8886C; Wed, 22 May 2024 17:35:15 +0200 (CEST)
Received: from wfhigh8-smtp.messagingengine.com
 (wfhigh8-smtp.messagingengine.com [64.147.123.159])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C77A88859
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 17:35:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailfhigh.west.internal (Postfix) with ESMTP id AFDB51800096;
 Wed, 22 May 2024 11:35:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Wed, 22 May 2024 11:35:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716392111;
 x=1716478511; bh=aaofPGSPN/fFFqjj/Hw/a/dnQPu2GTSJ0E6PxgxgSw4=; b=
 kBcnkvOXwPjownPH6K/FVuR9oxiMnWvab0qNj7+iWyr4olwbJyfSOK2FwGgLKbn4
 KDqJ2B3/OwSuqiWCDYEy/J4zbDBnakmtVvm7aClLy8myo6uU2FiipARp2sOlkV0t
 8Kb9mO/OqShav5u1u7GG/4Nd2wLIOvfpu4fWBcTUIjy0oDkwhbV2IJsjdXKC36Uu
 4lraZBwn2x4AorEk8Gy+PP79VOeO28vnWxu2IQsM4MQGegjtvaTienHe2yTXba6d
 UNxr/Dc3Q4w1kvlg6RnQicJ05CHRSEI1uU9KVnyI7OU/opcphNQ9z1oU7DxVVuQs
 shYLoWZhXD1agEN3JvATRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716392111; x=
 1716478511; bh=aaofPGSPN/fFFqjj/Hw/a/dnQPu2GTSJ0E6PxgxgSw4=; b=H
 c1dT7PgRQTXcVGDJ62Zzgp7h9soZcuU4MY9Go12viEn40kAHKZbSZXUzP+gxUxuD
 Y3aWArpWQjxE+2WPkyjceBbhfI7Gi2HnrRgeQbQ8/pnAeweG0jGNd0q9mdCJ8FNY
 +GGGhCxftoqcWh0pX7W5hw7kjWP1WD0xrmkWtcU5dD5RvUfqsC6zvmEhOQdMBPEC
 s7/DGhWlNDocN75ahOUmapzto9CBXRIxOFmCsFT8MJ0m5Po1TP/lYf4FDm3xjF0g
 TbM2vopl/PpvnTg3hUIzL2CsPqclWCBSbkVYx+nmw0WtKi63FLYHmU6f4lBRku67
 wl4MSs9kZkr0BMgo9MF9Q==
X-ME-Sender: <xms:rxBOZglSsH8RLNq9j-mvUA8Nzn_VQWMB2oXIllgtk0XEZQnqy-7GQA>
 <xme:rxBOZv0fCX55XO-dIrExQOX4FM_SSDR5peb_qmBE3nPPnt2vD3CzExDMzvPCSQCIy
 k8dEfDK-F-OP-dzGTU>
X-ME-Received: <xmr:rxBOZupEPLdhL3wO5_PmhuFtDN57AUTDfvtgBZLfltT7CGNU46kx_l8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeigedgvdegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:rxBOZsn_LuMhAi27PjTII5B4u-9tZFVDsJ_5miLDm1MBAKuDzt_rhg>
 <xmx:rxBOZu1CYUwy8cScsEBcm3dL8fsqKIaw-zj_4mZ45fkgy4T2B1rdrQ>
 <xmx:rxBOZjsJ7aA1YHBsFtcZmgMmv1RMWQYA4ml2rxfNicSAtLyfE0sNdw>
 <xmx:rxBOZqWBOZrmQ6OCg_Z8q48UgR6UJHxHrXaXAGLdygN3S18oDBohig>
 <xmx:rxBOZopL6gN9WUmlpZoT-0ck5l4tZcbG60DYkbq54uwFiUMEVHVSTmLf>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 May 2024 11:35:10 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 22 May 2024 16:34:47 +0100
Subject: [PATCH 04/16] elf.h Define LoongArch bits
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-loongarch-v1-4-1407e0b69678@flygoat.com>
References: <20240522-loongarch-v1-0-1407e0b69678@flygoat.com>
In-Reply-To: <20240522-loongarch-v1-0-1407e0b69678@flygoat.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1043;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=xGPa1l/xKPdnjRCibaa5XkEFMwzEvG1IzJKtZ5Ki0i8=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjQ/geUX683/+H6a/WXz0V1yn4Nmfg/nOFxyNkPG9Lzql
 i33F5Yf7ChlYRDjYpAVU2QJEVDq29B4ccH1B1l/YOawMoEMYeDiFICJrDnCyLCvN8a3Wrdyn4uI
 9rWGd5xPg/6f/F+vJuQUWlizXG8GXykjQydTS+wFdftIuc0TvvApLL/24uoVA+NPHXVXXiRYHJ3
 syA0A
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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

They all come from glibc's elf.h

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 include/elf.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/elf.h b/include/elf.h
index a4ba74d8abeb..cb3bb20c4f2e 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -219,7 +219,8 @@ typedef struct {
 #define EM_MN10300	89		/* Matsushita MN10200 */
 #define EM_MN10200	90		/* Matsushita MN10200 */
 #define EM_PJ		91		/* picoJava */
-#define EM_NUM		92		/* number of machine types */
+#define EM_LOONGARCH	258	/* LoongArch */
+
 
 /* Version */
 #define EV_NONE		0		/* Invalid */
@@ -699,6 +700,12 @@ unsigned long elf_hash(const unsigned char *name);
 #define R_RISCV_64		2
 #define R_RISCV_RELATIVE	3
 
+/* LoongArch Relocations */
+#define R_LARCH_NONE				0
+#define R_LARCH_32				1
+#define R_LARCH_64				2
+#define R_LARCH_RELATIVE			3
+
 #ifndef __ASSEMBLY__
 int valid_elf_image(unsigned long addr);
 unsigned long load_elf64_image_phdr(unsigned long addr);

-- 
2.43.0

