Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D9D4C4345F
	for <u-boot@archiver.kernel.org>; Mon, 29 Apr 2024 06:38:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E31E888BB;
	Mon, 29 Apr 2024 08:38:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jiXZG8ju";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 401A98880E; Mon, 29 Apr 2024 08:38:19 +0200 (CEST)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DACD3888C1
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 08:38:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6e46dcd8feaso2185912b3a.2
 for <u-boot@lists.denx.de>; Sun, 28 Apr 2024 23:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714372693; x=1714977493; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tPz/d2FPONrcakhh5rr78gmMnGwzaoVQ43NbvSn1XZs=;
 b=jiXZG8jumVvqpL7gU23a8hKnzrmlmPWV+TKufxeV5c+b+ZmPYRr7J8AhqbI0XGUlcc
 SSJd8633hayVbBpx38NuDcxyRUjQlD9pZYKwJ2qPikSix0Wk3DWs9KgKb9+5n4JrtrdU
 oY26AQ31D2YwyDjgvcYl2iNJgd+rFO2vraurjF2e2FfWxznCn37JuCvj/XvN/fG+9G5e
 C1wXb5q2aoX8XjyunU6nr13yE+QGup0LB/awLakOm/9JvpHNvNLfjMD1ydAJtEjnX7X+
 24rdpi8EbbHeVGePdvp+j4SyFhJiPBGJp4UQ7TGuvEDF5l6TWKCP8yfmIgllfaXr2/it
 +57Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714372693; x=1714977493;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tPz/d2FPONrcakhh5rr78gmMnGwzaoVQ43NbvSn1XZs=;
 b=h18uk+IfuMX+5ILizUxWV8mfvQZNqjAx5qlBO/5HWQHDPeSAQQ0gRwGRa2RsrZ1HXU
 OIj4RaYk/TDIkG1TXTIDaBGm81uSTIaYS2YqoAkVm+fl8r0kl6cRdxVrLchGBGd6NlSH
 qDBwotgxYn9kugtev0TU5HGJCrQCD0/huNae5kIe1lSjkkurXX2fo23t/KFC5vVz0oIr
 9L/jxfFPE9HkERAw+EpF6T+tIdukfsjuKc9LpHLPdLLhiJQHsFQktALoaFkewmp2NVSQ
 XF0CcZCzV2mv78bCfO9dDnTx669Y8aGvJHLbZiUUnCaKFfCenP3w8tnUpRbipSW0uOkK
 XEsw==
X-Gm-Message-State: AOJu0Yx0tgKJNCZ1WpApqfBrQJ0szOaOJbug0auz7cC2hQfoxgNvx5BU
 B6WDQL4WegevvUVRK4vIINEhLbezKEGFpel9EWzkj11l1H5XBaZZ
X-Google-Smtp-Source: AGHT+IFC9KAZHPZ2wa8KTi4n+pLQ+X33xZaDtjbn3nyBrnH/3JkLD3v9zzPTFpDpNQmstEGfRgQYxw==
X-Received: by 2002:a05:6a00:138a:b0:6f3:f5e8:31f7 with SMTP id
 t10-20020a056a00138a00b006f3f5e831f7mr6257224pfg.7.1714372692939; 
 Sun, 28 Apr 2024 23:38:12 -0700 (PDT)
Received: from localhost.localdomain ([1.200.153.166])
 by smtp.gmail.com with ESMTPSA id
 u12-20020a056a00098c00b006f09d5807ebsm18090172pfg.82.2024.04.28.23.38.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Apr 2024 23:38:12 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, YSCHU@nuvoton.com, KWLIU@nuvoton.com,
 jim.t90615@gmail.com, trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v1] crypto: nuvoton: npcm_sha: Support SHA 384/512
Date: Mon, 29 Apr 2024 14:38:03 +0800
Message-Id: <20240429063803.3049736-1-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
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

1. Use vendor naming rule to rename each function
2. add SHA 384/512 support

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 drivers/crypto/nuvoton/npcm_sha.c | 1024 +++++++----------------------
 1 file changed, 252 insertions(+), 772 deletions(-)

diff --git a/drivers/crypto/nuvoton/npcm_sha.c b/drivers/crypto/nuvoton/npcm_sha.c
index 7ebdfa16f4..2a5e672688 100644
--- a/drivers/crypto/nuvoton/npcm_sha.c
+++ b/drivers/crypto/nuvoton/npcm_sha.c
@@ -1,868 +1,345 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (c) 2022 Nuvoton Technology Corp.
+ * Copyright (c) 2024 Nuvoton Technology Corp.
  */
 
 #include <common.h>
 #include <dm.h>
 #include <hash.h>
 #include <malloc.h>
-#include <uboot_aes.h>
 #include <asm/io.h>
+#include <linux/iopoll.h>
 
-#define HASH_DIG_H_NUM			8
+#define SHA512_BLOCK_LENGTH     (1024 / 8)
 
+/* Register fields */
 #define HASH_CTR_STS_SHA_EN             BIT(0)
 #define HASH_CTR_STS_SHA_BUSY           BIT(1)
 #define HASH_CTR_STS_SHA_RST            BIT(2)
 #define HASH_CFG_SHA1_SHA2              BIT(0)
-
-/* SHA type */
-enum npcm_sha_type {
-	npcm_sha_type_sha2 = 0,
-	npcm_sha_type_sha1,
-	npcm_sha_type_num
+#define SHA512_CMD_SHA_512		BIT(3)
+#define SHA512_CMD_INTERNAL_ROUND	BIT(2)
+#define SHA512_CMD_WRITE		BIT(1)
+#define SHA512_CMD_READ			BIT(0)
+
+enum {
+	type_sha1 = 0,
+	type_sha256,
+	type_sha384,
+	type_sha512,
 };
 
 struct npcm_sha_regs {
-	unsigned int hash_data_in;
-	unsigned char hash_ctr_sts;
-	unsigned char reserved_0[0x03];
-	unsigned char hash_cfg;
-	unsigned char reserved_1[0x03];
-	unsigned char hash_ver;
-	unsigned char reserved_2[0x13];
-	unsigned int hash_dig[HASH_DIG_H_NUM];
+	u8 data_in;
+	u8 data_out;
+	u8 ctr_sts;
+	u8 hash_cfg;
+	u8 sha512_cmd;
 };
 
-struct npcm_sha_priv {
-	struct npcm_sha_regs *regs;
+struct hash_info {
+	u32 block_sz;
+	u32 digest_len;
+	u8 length_bytes;
+	u8 type;
 };
 
-static struct npcm_sha_priv *sha_priv;
+struct message_block {
+	u64 length[2];
+	u64 nonhash_sz;
+	u8 buffer[SHA512_BLOCK_LENGTH * 2];
+};
 
-#ifdef SHA_DEBUG_MODULE
-#define sha_print(fmt, args...)  printf(fmt, ##args)
-#else
-#define sha_print(fmt, args...)  (void)0
-#endif
-
-#define SHA_BLOCK_LENGTH        (512 / 8)
-#define SHA_2_HASH_LENGTH       (256 / 8)
-#define SHA_1_HASH_LENGTH       (160 / 8)
-#define SHA_HASH_LENGTH(type)   ((type == npcm_sha_type_sha2) ? \
-							(SHA_2_HASH_LENGTH) : (SHA_1_HASH_LENGTH))
-
-#define SHA_SECRUN_BUFF_SIZE    64
-#define SHA_TIMEOUT             100
-#define SHA_DATA_LAST_BYTE      0x80
-
-#define SHA2_NUM_OF_SELF_TESTS  3
-#define SHA1_NUM_OF_SELF_TESTS  4
-
-#define NUVOTON_ALIGNMENT       4
-
-/*-----------------------------------------------------------------------------*/
-/* SHA instance struct handler                                                 */
-/*-----------------------------------------------------------------------------*/
-struct SHA_HANDLE_T {
-	u32                 hv[SHA_2_HASH_LENGTH / sizeof(u32)];
-	u32                 length0;
-	u32                 length1;
-	u32					block[SHA_BLOCK_LENGTH / sizeof(u32)];
-	u8					type;
-	bool                active;
+struct npcm_sha_priv {
+	void *base;
+	struct npcm_sha_regs *regs;
+	struct hash_info *hash;
+	struct message_block block;
+	bool internal_round;
+	bool support_sha512;
 };
 
-// The # of bytes currently in the sha  block buffer
-#define SHA_BUFF_POS(length)        ((length) & (SHA_BLOCK_LENGTH - 1))
-
-// The # of free bytes in the sha block buffer
-#define SHA_BUFF_FREE(length)       (SHA_BLOCK_LENGTH - SHA_BUFF_POS(length))
-
-static void SHA_FlushLocalBuffer_l(const u32 *buff);
-static int  SHA_BusyWait_l(void);
-static void SHA_GetShaDigest_l(u8 *hashdigest, u8 type);
-static void SHA_SetShaDigest_l(const u32 *hashdigest, u8 type);
-static void SHA_SetBlock_l(const u8 *data, u32 len, u16 position, u32 *block);
-static void SHA_ClearBlock_l(u16 len, u16 position, u32 *block);
-static void SHA_SetLength32_l(struct SHA_HANDLE_T *handleptr, u32 *block);
-
-static int SHA_Init(struct SHA_HANDLE_T *handleptr);
-static int SHA_Start(struct SHA_HANDLE_T *handleptr, u8 type);
-static int SHA_Update(struct SHA_HANDLE_T *handleptr, const u8 *buffer, u32 len);
-static int SHA_Finish(struct SHA_HANDLE_T *handleptr, u8 *hashdigest);
-static int SHA_Reset(void);
-static int SHA_Power(bool on);
-#ifdef SHA_PRINT
-static void SHA_PrintRegs(void);
-static void SHA_PrintVersion(void);
-#endif
-
-static struct SHA_HANDLE_T sha_handle;
-
-/*----------------------------------------------------------------------------*/
-/* Checks if give function returns int error, and returns the error           */
-/* immediately after SHA disabling                                            */
-/*----------------------------------------------------------------------------*/
-int npcm_sha_check(int status)
-{
-	if (status != 0) {
-		SHA_Power(false);
-		return status;
-	}
-	return 0;
-}
+static struct npcm_sha_regs npcm_sha_reg_tbl[] = {
+	{ .data_in = 0x0, .data_out = 0x20, .ctr_sts = 0x4, .hash_cfg = 0x8 },
+	{ .data_in = 0x10, .data_out = 0x1c, .ctr_sts = 0x14, .sha512_cmd = 0x18 },
+};
 
-/*----------------------------------------------------------------------------*/
-/* Function:        npcm_sha_calc                                          */
-/*                                                                            */
-/* Parameters:      type - SHA module type                                    */
-/*                  inBuff  - Pointer to a buffer containing the data to      */
-/*                            be hashed                                       */
-/*                  len     - Length of the data to hash                      */
-/*                  hashDigest - Pointer to a buffer where the reseulting     */
-/*                               digest will be copied to                     */
-/*                                                                            */
-/* Returns:         0 on success or other int error code on error             */
-/* Side effects:                                                              */
-/* Description:                                                               */
-/*                  This routine performs complete SHA calculation in one     */
-/*                  step                                                      */
-/*----------------------------------------------------------------------------*/
-int npcm_sha_calc(u8 type, const u8 *inbuff, u32 len, u8 *hashdigest)
-{
-	int status;
-	struct SHA_HANDLE_T handle;
-
-	SHA_Init(&handle);
-	SHA_Power(true);
-	SHA_Reset();
-	SHA_Start(&handle, type);
-	status = SHA_Update(&handle, inbuff, len);
-	npcm_sha_check(status);
-	status = SHA_Finish(&handle, hashdigest);
-	npcm_sha_check(status);
-	SHA_Power(false);
+static struct hash_info npcm_hash_tbl[] = {
+	{ .type = type_sha1, .block_sz = 64, .digest_len = 160, .length_bytes = 8 },
+	{ .type = type_sha256, .block_sz = 64, .digest_len = 256, .length_bytes = 8 },
+	{ .type = type_sha384, .block_sz = 128, .digest_len = 384, .length_bytes = 16 },
+	{ .type = type_sha512, .block_sz = 128, .digest_len = 512, .length_bytes = 16 },
+};
 
-	return 0;
-}
+static struct npcm_sha_priv *sha_priv;
 
-/*
- * Computes hash value of input pbuf using h/w acceleration
- *
- * @param in_addr    A pointer to the input buffer
- * @param bufleni    Byte length of input buffer
- * @param out_addr   A pointer to the output buffer. When complete
- *           32 bytes are copied to pout[0]...pout[31]. Thus, a user
- *           should allocate at least 32 bytes at pOut in advance.
- * @param chunk_size chunk size for sha256
- */
-void hw_sha256(const uchar *in_addr, uint buflen, uchar *out_addr, uint chunk_size)
+static int npcm_sha_init(u8 type)
 {
-	puts("\nhw_sha256 using BMC HW accelerator\t");
-	npcm_sha_calc(npcm_sha_type_sha2, (u8 *)in_addr, buflen, (u8 *)out_addr);
-}
+	struct message_block *block = &sha_priv->block;
 
-/*
- * Computes hash value of input pbuf using h/w acceleration
- *
- * @param in_addr    A pointer to the input buffer
- * @param bufleni    Byte length of input buffer
- * @param out_addr   A pointer to the output buffer. When complete
- *           32 bytes are copied to pout[0]...pout[31]. Thus, a user
- *           should allocate at least 32 bytes at pOut in advance.
- * @param chunk_size chunk_size for sha1
- */
-void hw_sha1(const uchar *in_addr, uint buflen, uchar *out_addr, uint chunk_size)
-{
-	puts("\nhw_sha1 using BMC HW accelerator\t");
-	npcm_sha_calc(npcm_sha_type_sha1, (u8 *)in_addr, buflen, (u8 *)out_addr);
-}
+	if (type > type_sha512 ||
+	    (!sha_priv->support_sha512 &&
+	    (type == type_sha384 || type == type_sha512)))
+		return -ENOTSUPP;
 
-/*
- * Create the context for sha progressive hashing using h/w acceleration
- *
- * @algo: Pointer to the hash_algo struct
- * @ctxp: Pointer to the pointer of the context for hashing
- * @return 0 if ok, -ve on error
- */
-int hw_sha_init(struct hash_algo *algo, void **ctxp)
-{
-	const char *algo_name1 = "sha1";
-	const char *algo_name2 = "sha256";
-
-	SHA_Init(&sha_handle);
-	SHA_Power(true);
-	SHA_Reset();
-	if (!strcmp(algo_name1, algo->name))
-		return SHA_Start(&sha_handle, npcm_sha_type_sha1);
-	else if (!strcmp(algo_name2, algo->name))
-		return SHA_Start(&sha_handle, npcm_sha_type_sha2);
-	else
-		return -EPROTO;
-}
+	sha_priv->regs = &npcm_sha_reg_tbl[type / 2];
+	sha_priv->hash = &npcm_hash_tbl[type];
+	block->length[0] = 0;
+	block->length[1] = 0;
+	block->nonhash_sz = 0;
+	sha_priv->internal_round = false;
 
-/*
- * Update buffer for sha progressive hashing using h/w acceleration
- *
- * The context is freed by this function if an error occurs.
- *
- * @algo: Pointer to the hash_algo struct
- * @ctx: Pointer to the context for hashing
- * @buf: Pointer to the buffer being hashed
- * @size: Size of the buffer being hashed
- * @is_last: 1 if this is the last update; 0 otherwise
- * @return 0 if ok, -ve on error
- */
-int hw_sha_update(struct hash_algo *algo, void *ctx, const void *buf,
-		  unsigned int size, int is_last)
-{
-	return SHA_Update(&sha_handle, buf, size);
+	return 0;
 }
 
-/*
- * Copy sha hash result at destination location
- *
- * The context is freed after completion of hash operation or after an error.
- *
- * @algo: Pointer to the hash_algo struct
- * @ctx: Pointer to the context for hashing
- * @dest_buf: Pointer to the destination buffer where hash is to be copied
- * @size: Size of the buffer being hashed
- * @return 0 if ok, -ve on error
- */
-int hw_sha_finish(struct hash_algo *algo, void *ctx, void *dest_buf, int size)
+static void npcm_sha_reset(void)
 {
-	int status;
-
-	status = SHA_Finish(&sha_handle, dest_buf);
-	npcm_sha_check(status);
-	return SHA_Power(false);
+	struct npcm_sha_regs *regs = sha_priv->regs;
+	struct hash_info *hash = sha_priv->hash;
+	u8 val;
+
+	if (hash->type == type_sha1)
+		writeb(HASH_CFG_SHA1_SHA2, sha_priv->base + regs->hash_cfg);
+	else if (hash->type == type_sha256)
+		writeb(0, sha_priv->base + regs->hash_cfg);
+	else if (hash->type == type_sha384)
+		writeb(0, sha_priv->base + regs->sha512_cmd);
+	else if (hash->type == type_sha512)
+		writeb(SHA512_CMD_SHA_512, sha_priv->base + regs->sha512_cmd);
+
+	val = readb(sha_priv->base + regs->ctr_sts) & ~HASH_CTR_STS_SHA_EN;
+	writeb(val | HASH_CTR_STS_SHA_RST, sha_priv->base + regs->ctr_sts);
 }
 
-/*----------------------------------------------------------------------------*/
-/* Function:        SHA_Init                                                  */
-/*                                                                            */
-/* Parameters:      handlePtr - SHA processing handle pointer                 */
-/* Returns:         0 on success or other int error code on error.            */
-/* Side effects:                                                              */
-/* Description:                                                               */
-/*                  This routine initialize the SHA module                    */
-/*----------------------------------------------------------------------------*/
-static int SHA_Init(struct SHA_HANDLE_T *handleptr)
+static void npcm_sha_enable(bool on)
 {
-	handleptr->active = false;
+	struct npcm_sha_regs *regs = sha_priv->regs;
+	u8 val;
 
-	return 0;
+	val = readb(sha_priv->base + regs->ctr_sts) & ~HASH_CTR_STS_SHA_EN;
+	val |= on;
+	writeb(val | on, sha_priv->base + regs->ctr_sts);
 }
 
-/*----------------------------------------------------------------------------*/
-/* Function:        SHA_Start                                                 */
-/*                                                                            */
-/* Parameters:      handlePtr   - SHA processing handle pointer               */
-/*                  type        - SHA module type                             */
-/*                                                                            */
-/* Returns:         0 on success or other int error code on error.            */
-/* Side effects:                                                              */
-/* Description:                                                               */
-/*                  This routine start a single SHA process                   */
-/*----------------------------------------------------------------------------*/
-static int SHA_Start(struct SHA_HANDLE_T *handleptr, u8 type)
+static int npcm_sha_flush_block(u8 *block)
 {
 	struct npcm_sha_regs *regs = sha_priv->regs;
+	struct hash_info *hash = sha_priv->hash;
+	u32 *blk_dw = (u32 *)block;
+	u8 val;
+	int i;
+
+	if (readb_poll_timeout(sha_priv->base + regs->ctr_sts, val,
+			       !(val & HASH_CTR_STS_SHA_BUSY), 100))
+		return -ETIMEDOUT;
+
+	if (hash->type == type_sha384 || hash->type == type_sha512) {
+		val = SHA512_CMD_WRITE;
+		if (hash->type == type_sha512)
+			val |= SHA512_CMD_SHA_512;
+		if (sha_priv->internal_round)
+			val |= SHA512_CMD_INTERNAL_ROUND;
+		writeb(val, sha_priv->base + regs->sha512_cmd);
+	}
+	for (i = 0; i < (hash->block_sz / sizeof(u32)); i++)
+		writel(blk_dw[i], sha_priv->base + regs->data_in);
 
-	// Initialize handle
-	handleptr->length0 = 0;
-	handleptr->length1 = 0;
-	handleptr->type = type;
-	handleptr->active = true;
-
-	// Set SHA type
-	writeb(handleptr->type & HASH_CFG_SHA1_SHA2, &regs->hash_cfg);
-
-	// Reset SHA hardware
-	SHA_Reset();
-
-	/* The handlePtr->hv is initialized with the correct IV as the SHA engine
-	 * automatically fill the HASH_DIG_Hn registers according to SHA spec
-	 * (following SHA_RST assertion)
-	 */
-	SHA_GetShaDigest_l((u8 *)handleptr->hv, type);
-
-	// Init block with zeros
-	memset(handleptr->block, 0, sizeof(handleptr->block));
+	sha_priv->internal_round = true;
 
 	return 0;
 }
 
-/*----------------------------------------------------------------------------*/
-/* Function:        SHA_Update                                                */
-/*                                                                            */
-/* Parameters:      handlePtr - SHA processing handle pointer                 */
-/*                  buffer    - Pointer to the data that will be added to     */
-/*                              the hash calculation                          */
-/*                  len -      Length of data to add to SHA calculation       */
-/*                                                                            */
-/*                                                                            */
-/* Returns:         0 on success or other int error code on error             */
-/* Side effects:                                                              */
-/* Description:                                                               */
-/*                  This routine adds data to previously started SHA          */
-/*                  calculation                                               */
-/*----------------------------------------------------------------------------*/
-static int SHA_Update(struct SHA_HANDLE_T *handleptr, const u8 *buffer, u32 len)
+static int npcm_sha_update_block(const u8 *in, u32 len)
 {
-	struct npcm_sha_regs *regs = sha_priv->regs;
-	u32 localbuffer[SHA_SECRUN_BUFF_SIZE / sizeof(u32)];
-	u32 bufferlen = len;
-	u16 pos = 0;
-	u8 *blockptr;
-	int status;
-
-	// Error check
-	if (!handleptr->active)
-		return -EPROTO;
-
-	// Wait till SHA is not busy
-	status = SHA_BusyWait_l();
-	npcm_sha_check(status);
-
-	// Set SHA type
-	writeb(handleptr->type & HASH_CFG_SHA1_SHA2, &regs->hash_cfg);
-
-	// Write SHA latest digest into SHA module
-	SHA_SetShaDigest_l(handleptr->hv, handleptr->type);
-
-	// Set number of unhashed bytes which remained from last update
-	pos = SHA_BUFF_POS(handleptr->length0);
-
-	// Copy unhashed bytes which remained from last update to secrun buffer
-	SHA_SetBlock_l((u8 *)handleptr->block, pos, 0, localbuffer);
-
-	while (len) {
-		// Wait for the hardware to be available (in case we are hashing)
-		status = SHA_BusyWait_l();
-		npcm_sha_check(status);
-
-		// Move as much bytes  as we can into the secrun buffer
-		bufferlen = min(len, SHA_BUFF_FREE(handleptr->length0));
-
-		// Copy current given buffer to the secrun buffer
-		SHA_SetBlock_l((u8 *)buffer, bufferlen, pos, localbuffer);
-
-		// Update size of hashed bytes
-		handleptr->length0 += bufferlen;
-
-		if (handleptr->length0 < bufferlen)
-			handleptr->length1++;
-
-		// Update length of data left to digest
-		len -= bufferlen;
-
-		// Update given buffer pointer
-		buffer += bufferlen;
-
-		// If secrun buffer is full
-		if (SHA_BUFF_POS(handleptr->length0) == 0) {
-			/* We just filled up the buffer perfectly, so let it hash (we'll
-			 * unload the hash only when we are done with all hashing)
-			 */
-			SHA_FlushLocalBuffer_l(localbuffer);
-
-			pos = 0;
-			bufferlen = 0;
-		}
+	struct message_block *block = &sha_priv->block;
+	struct hash_info *hash = sha_priv->hash;
+	u8 *buffer = &block->buffer[0];
+	u32 block_sz = hash->block_sz;
+	u32 hash_sz;
+
+	hash_sz = (block->nonhash_sz + len) > block_sz ?
+		(block_sz - block->nonhash_sz) : len;
+	memcpy(buffer + block->nonhash_sz, in, hash_sz);
+	block->nonhash_sz += hash_sz;
+	block->length[0] += hash_sz;
+	if (block->length[0] < hash_sz)
+		block->length[1]++;
+
+	if (block->nonhash_sz == block_sz) {
+		block->nonhash_sz = 0;
+		if (npcm_sha_flush_block(buffer))
+			return -EBUSY;
 	}
 
-	// Wait till SHA is not busy
-	status = SHA_BusyWait_l();
-	npcm_sha_check(status);
-
-	/* Copy unhashed bytes from given buffer to handle block for next update/finish */
-	blockptr = (u8 *)handleptr->block;
-	while (bufferlen)
-		blockptr[--bufferlen + pos] = *(--buffer);
-
-	// Save SHA current digest
-	SHA_GetShaDigest_l((u8 *)handleptr->hv, handleptr->type);
-
-	return 0;
+	return hash_sz;
 }
 
-/*----------------------------------------------------------------------------*/
-/* Function:        SHA_Finish                                                */
-/*                                                                            */
-/* Parameters:      handlePtr  - SHA processing handle pointer                */
-/*                  hashDigest - Pointer to a buffer where the final digest   */
-/*                               will be copied to                            */
-/*                                                                            */
-/* Returns:         0 on success or other int error code on error             */
-/* Side effects:                                                              */
-/* Description:                                                               */
-/*                  This routine finish SHA calculation and get               */
-/*                  the resulting SHA digest                                  */
-/*----------------------------------------------------------------------------*/
-static int SHA_Finish(struct SHA_HANDLE_T *handleptr, u8 *hashdigest)
+static int npcm_sha_update(const u8 *input, u32 len)
 {
-	struct npcm_sha_regs *regs = sha_priv->regs;
-	u32 localbuffer[SHA_SECRUN_BUFF_SIZE / sizeof(u32)];
-	const u8 lastbyte = SHA_DATA_LAST_BYTE;
-	u16 pos;
-	int status;
-
-	// Error check
-	if (!handleptr->active)
-		return -EPROTO;
-
-	// Set SHA type
-	writeb(handleptr->type & HASH_CFG_SHA1_SHA2, &regs->hash_cfg);
-
-	// Wait till SHA is not busy
-	status = SHA_BusyWait_l();
-	npcm_sha_check(status);
-
-	// Finish off the current buffer with the SHA spec'ed padding
-	pos = SHA_BUFF_POS(handleptr->length0);
-
-	// Init SHA digest
-	SHA_SetShaDigest_l(handleptr->hv, handleptr->type);
-
-	// Load data into secrun buffer
-	SHA_SetBlock_l((u8 *)handleptr->block, pos, 0, localbuffer);
-
-	// Set data last byte as in SHA algorithm spec
-	SHA_SetBlock_l(&lastbyte, 1, pos++, localbuffer);
+	int hash_sz;
 
-	// If the remainder of data is longer then one block
-	if (pos > (SHA_BLOCK_LENGTH - 8)) {
-		/* The length will be in the next block Pad the rest of the last block with 0's */
-		SHA_ClearBlock_l((SHA_BLOCK_LENGTH - pos), pos, localbuffer);
-
-		// Hash the current block
-		SHA_FlushLocalBuffer_l(localbuffer);
-
-		pos = 0;
-
-		// Wait till SHA is not busy
-		status = SHA_BusyWait_l();
-		npcm_sha_check(status);
+	while (len) {
+		hash_sz = npcm_sha_update_block(input, len);
+		if (hash_sz < 0) {
+			printf("SHA512 module busy\n");
+			return -EBUSY;
+		}
+		len -= hash_sz;
+		input += hash_sz;
 	}
 
-	// Pad the rest of the last block with 0's except for the last 8-3 bytes
-	SHA_ClearBlock_l((SHA_BLOCK_LENGTH - (8 - 3)) - pos, pos, localbuffer);
-
-	/* The last 8-3 bytes are set to the bit-length of the message in big-endian form */
-	SHA_SetLength32_l(handleptr, localbuffer);
-
-	// Hash all that, and save the hash for the caller
-	SHA_FlushLocalBuffer_l(localbuffer);
-
-	// Wait till SHA is not busy
-	status = SHA_BusyWait_l();
-	npcm_sha_check(status);
-
-	// Save SHA final digest into given buffer
-	SHA_GetShaDigest_l(hashdigest, handleptr->type);
-
-	// Free handle
-	handleptr->active = false;
-
 	return 0;
 }
 
-/*----------------------------------------------------------------------------*/
-/* Function:        SHA_Reset                                                 */
-/*                                                                            */
-/* Parameters:      none                                                      */
-/* Returns:         none                                                      */
-/* Side effects:                                                              */
-/* Description:                                                               */
-/*                  This routine reset SHA module                             */
-/*----------------------------------------------------------------------------*/
-static int SHA_Reset(void)
+static int npcm_sha_finish(u8 *out)
 {
 	struct npcm_sha_regs *regs = sha_priv->regs;
-
-	writel(readl(&regs->hash_ctr_sts) | HASH_CTR_STS_SHA_RST, &regs->hash_ctr_sts);
+	struct message_block *block = &sha_priv->block;
+	struct hash_info *hash = sha_priv->hash;
+	u8 *buffer = &block->buffer[0];
+	u32 block_sz = hash->block_sz;
+	u32 *out32 = (u32 *)out;
+	u32 zero_len, val;
+	u64 *length;
+	u8 reg_data_out;
+	int i;
+
+	/* Padding, minimal padding size is last_byte+length_bytes */
+	if ((block_sz - block->nonhash_sz) >= (hash->length_bytes + 1))
+		zero_len = block_sz - block->nonhash_sz - (hash->length_bytes + 1);
+	else
+		zero_len = block_sz * 2 - block->nonhash_sz - (hash->length_bytes + 1);
+	/* Last byte */
+	buffer[block->nonhash_sz++] = 0x80;
+	/* Zero bits padding */
+	memset(&buffer[block->nonhash_sz], 0, zero_len);
+	block->nonhash_sz += zero_len;
+	/* Message length */
+	length = (u64 *)&buffer[block->nonhash_sz];
+	if (hash->length_bytes == 16) {
+		*length++ = cpu_to_be64(block->length[1] << 3 | block->length[0] >> 61);
+		block->nonhash_sz += 8;
+	}
+	*length = cpu_to_be64(block->length[0] << 3);
+	block->nonhash_sz += 8;
+	if (npcm_sha_flush_block(&block->buffer[0]))
+		return -ETIMEDOUT;
+
+	/* After padding, the last message may produce 2 blocks */
+	if (block->nonhash_sz > block_sz) {
+		if (npcm_sha_flush_block(&block->buffer[block_sz]))
+			return -ETIMEDOUT;
+	}
+	/* Read digest */
+	if (readb_poll_timeout(sha_priv->base + regs->ctr_sts, val,
+			       !(val & HASH_CTR_STS_SHA_BUSY), 100))
+		return -ETIMEDOUT;
+	if (hash->type == type_sha384)
+		writeb(SHA512_CMD_READ, sha_priv->base + regs->sha512_cmd);
+	else if (hash->type == type_sha512)
+		writeb(SHA512_CMD_SHA_512 | SHA512_CMD_READ,
+		       sha_priv->base + regs->sha512_cmd);
+
+	reg_data_out = regs->data_out;
+	for (i = 0; i < (hash->digest_len / 32); i++) {
+		*out32 = readl(sha_priv->base + reg_data_out);
+		out32++;
+		if (hash->type == type_sha1 || hash->type == type_sha256)
+			reg_data_out += 4;
+	}
 
 	return 0;
 }
 
-/*----------------------------------------------------------------------------*/
-/* Function:        SHA_Power                                                 */
-/*                                                                            */
-/* Parameters:      on - true enable the module, false disable the module     */
-/* Returns:         none                                                      */
-/* Side effects:                                                              */
-/* Description:                                                               */
-/*                  This routine set SHA module power on/off                  */
-/*----------------------------------------------------------------------------*/
-static int SHA_Power(bool on)
+int npcm_sha_calc(const u8 *input, u32 len, u8 *output, u8 type)
 {
-	struct npcm_sha_regs *regs = sha_priv->regs;
-	u8 hash_sts;
-
-	hash_sts = readb(&regs->hash_ctr_sts) & ~HASH_CTR_STS_SHA_EN;
-	writeb(hash_sts | (on & HASH_CTR_STS_SHA_EN), &regs->hash_ctr_sts);
+	if (npcm_sha_init(type))
+		return -ENOTSUPP;
+	npcm_sha_reset();
+	npcm_sha_enable(true);
+	npcm_sha_update(input, len);
+	npcm_sha_finish(output);
+	npcm_sha_enable(false);
 
 	return 0;
 }
 
-#ifdef SHA_PRINT
-/*----------------------------------------------------------------------------*/
-/* Function:        SHA_PrintRegs                                             */
-/*                                                                            */
-/* Parameters:      none                                                      */
-/* Returns:         none                                                      */
-/* Side effects:                                                              */
-/* Description:                                                               */
-/*                  This routine prints the module registers                  */
-/*----------------------------------------------------------------------------*/
-static void SHA_PrintRegs(void)
+void hw_sha512(const unsigned char *input, unsigned int len,
+	       unsigned char *output, unsigned int chunk_sz)
 {
-#ifdef SHA_DEBUG_MODULE
-	struct npcm_sha_regs *regs = sha_priv->regs;
-#endif
-	unsigned int i;
-
-	sha_print("/*--------------*/\n");
-	sha_print("/*     SHA      */\n");
-	sha_print("/*--------------*/\n\n");
-
-	sha_print("HASH_CTR_STS    = 0x%02X\n", readb(&regs->hash_ctr_sts));
-	sha_print("HASH_CFG        = 0x%02X\n", readb(&regs->hash_cfg));
-
-	for (i = 0; i < HASH_DIG_H_NUM; i++)
-		sha_print("HASH_DIG_H%d     = 0x%08X\n", i, readl(&regs->hash_dig[i]));
-
-	sha_print("HASH_VER         = 0x%08X\n", readb(&regs->hash_ver));
-
-	sha_print("\n");
+	if (!sha_priv->support_sha512) {
+		puts(" HW accelerator not support\n");
+		return;
+	}
+	puts(" using BMC HW accelerator\n");
+	npcm_sha_calc(input, len, output, type_sha512);
 }
 
-/*----------------------------------------------------------------------------*/
-/* Function:        SHA_PrintVersion                                          */
-/*                                                                            */
-/* Parameters:      none                                                      */
-/* Returns:         none                                                      */
-/* Side effects:                                                              */
-/* Description:                                                               */
-/*                  This routine prints the module version                    */
-/*----------------------------------------------------------------------------*/
-static void SHA_PrintVersion(void)
-{
-	struct npcm_sha_regs *regs = sha_priv->regs;
-
-	printf("SHA MODULE VER  = %d\n", readb(&regs->hash_ver));
-}
-#endif
-
-/*----------------------------------------------------------------------------*/
-/* Function:        npcm_sha_selftest                                      */
-/*                                                                            */
-/* Parameters:      type - SHA module type                                    */
-/* Returns:         0 on success or other int error code on error             */
-/* Side effects:                                                              */
-/* Description:                                                               */
-/*                  This routine performs various tests on the SHA HW and SW  */
-/*----------------------------------------------------------------------------*/
-int npcm_sha_selftest(u8 type)
+void hw_sha384(const unsigned char *input, unsigned int len,
+	       unsigned char *output, unsigned int chunk_sz)
 {
-	int status;
-	struct SHA_HANDLE_T handle;
-	u8 hashdigest[max(SHA_1_HASH_LENGTH, SHA_2_HASH_LENGTH)];
-	u16 i, j;
-
-	/*------------------------------------------------------------------------*/
-	/* SHA1 tests info                                                        */
-	/*------------------------------------------------------------------------*/
-
-	static const u8 sha1selftestbuff[SHA1_NUM_OF_SELF_TESTS][94] = {
-		{"abc"},
-		{"abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq"},
-		{"0123456789012345678901234567890123456789012345678901234567890123"},
-		{0x30, 0x5c, 0x30, 0x2c, 0x02, 0x01, 0x00, 0x30, 0x09, 0x06, 0x05, 0x2b,
-		 0x0e, 0x03, 0x02, 0x1a, 0x05, 0x00, 0x30, 0x06, 0x06, 0x04, 0x67, 0x2a,
-		 0x01, 0x0c, 0x04, 0x14, 0xe1, 0xb6, 0x93, 0xfe, 0x33, 0x43, 0xc1, 0x20,
-		 0x5d, 0x4b, 0xaa, 0xb8, 0x63, 0xfb, 0xcf, 0x6c, 0x46, 0x1e, 0x88, 0x04,
-		 0x30, 0x2c, 0x02, 0x01, 0x00, 0x30, 0x09, 0x06, 0x05, 0x2b, 0x0e, 0x03,
-		 0x02, 0x1a, 0x05, 0x00, 0x30, 0x06, 0x06, 0x04, 0x67, 0x2a, 0x01, 0x0c,
-		 0x04, 0x14, 0x13, 0xc1, 0x0c, 0xfc, 0xc8, 0x92, 0xd7, 0xde, 0x07, 0x1c,
-		 0x40, 0xde, 0x4f, 0xcd, 0x07, 0x5b, 0x68, 0x20, 0x5a, 0x6c}
-	};
-
-	static const u8 sha1selftestbufflen[SHA1_NUM_OF_SELF_TESTS] = {
-		3, 56, 64, 94
-	};
-
-	static const u8 sha1selftestexpres[SHA1_NUM_OF_SELF_TESTS][SHA_1_HASH_LENGTH] = {
-		{0xA9, 0x99, 0x3E, 0x36,
-		 0x47, 0x06, 0x81, 0x6A,
-		 0xBA, 0x3E, 0x25, 0x71,
-		 0x78, 0x50, 0xC2, 0x6C,
-		 0x9C, 0xD0, 0xD8, 0x9D},
-		{0x84, 0x98, 0x3E, 0x44,
-		 0x1C, 0x3B, 0xD2, 0x6E,
-		 0xBA, 0xAE, 0x4A, 0xA1,
-		 0xF9, 0x51, 0x29, 0xE5,
-		 0xE5, 0x46, 0x70, 0xF1},
-		{0xCF, 0x08, 0x00, 0xF7,
-		 0x64, 0x4A, 0xCE, 0x3C,
-		 0xB4, 0xC3, 0xFA, 0x33,
-		 0x38, 0x8D, 0x3B, 0xA0,
-		 0xEA, 0x3C, 0x8B, 0x6E},
-		{0xc9, 0x84, 0x45, 0xc8,
-		 0x64, 0x04, 0xb1, 0xe3,
-		 0x3c, 0x6b, 0x0a, 0x8c,
-		 0x8b, 0x80, 0x94, 0xfc,
-		 0xf3, 0xc9, 0x98, 0xab}
-	};
-
-	/*------------------------------------------------------------------------*/
-	/* SHA2 tests info                                                        */
-	/*------------------------------------------------------------------------*/
-
-	static const u8 sha2selftestbuff[SHA2_NUM_OF_SELF_TESTS][100] = {
-		{ "abc" },
-		{ "abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq" },
-		{'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a',
-		 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a',
-		 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a',
-		 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a',
-		 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a',
-		 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a',
-		 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a',
-		 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a',
-		 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a',
-		 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a'}
-	};
-
-	static const u8 sha2selftestbufflen[SHA2_NUM_OF_SELF_TESTS] = {
-		3, 56, 100
-	};
-
-	static const u8 sha2selftestexpres[SHA2_NUM_OF_SELF_TESTS][SHA_2_HASH_LENGTH] = {
-		/*
-		 * SHA-256 test vectors
-		 */
-		{ 0xBA, 0x78, 0x16, 0xBF, 0x8F, 0x01, 0xCF, 0xEA,
-		  0x41, 0x41, 0x40, 0xDE, 0x5D, 0xAE, 0x22, 0x23,
-		  0xB0, 0x03, 0x61, 0xA3, 0x96, 0x17, 0x7A, 0x9C,
-		  0xB4, 0x10, 0xFF, 0x61, 0xF2, 0x00, 0x15, 0xAD },
-		{ 0x24, 0x8D, 0x6A, 0x61, 0xD2, 0x06, 0x38, 0xB8,
-		  0xE5, 0xC0, 0x26, 0x93, 0x0C, 0x3E, 0x60, 0x39,
-		  0xA3, 0x3C, 0xE4, 0x59, 0x64, 0xFF, 0x21, 0x67,
-		  0xF6, 0xEC, 0xED, 0xD4, 0x19, 0xDB, 0x06, 0xC1 },
-		{ 0xCD, 0xC7, 0x6E, 0x5C, 0x99, 0x14, 0xFB, 0x92,
-		  0x81, 0xA1, 0xC7, 0xE2, 0x84, 0xD7, 0x3E, 0x67,
-		  0xF1, 0x80, 0x9A, 0x48, 0xA4, 0x97, 0x20, 0x0E,
-		  0x04, 0x6D, 0x39, 0xCC, 0xC7, 0x11, 0x2C, 0xD0 },
-	};
-
-	if (type == npcm_sha_type_sha1) {
-		/*--------------------------------------------------------------------*/
-		/* SHA 1 TESTS                                                        */
-		/*--------------------------------------------------------------------*/
-		for (i = 0; i < SHA1_NUM_OF_SELF_TESTS; i++) {
-			if (i != 3) {
-				status = npcm_sha_calc(npcm_sha_type_sha1, sha1selftestbuff[i], sha1selftestbufflen[i], hashdigest);
-				npcm_sha_check(status);
-			} else {
-				SHA_Power(true);
-				SHA_Reset();
-				status = SHA_Start(&handle, npcm_sha_type_sha1);
-				npcm_sha_check(status);
-				status = SHA_Update(&handle, sha1selftestbuff[i], 73);
-				npcm_sha_check(status);
-				status = SHA_Update(&handle, &sha1selftestbuff[i][73], sha1selftestbufflen[i] - 73);
-				npcm_sha_check(status);
-				status = SHA_Finish(&handle, hashdigest);
-				npcm_sha_check(status);
-				SHA_Power(false);
-			}
-
-			if (memcmp(hashdigest, sha1selftestexpres[i], SHA_1_HASH_LENGTH))
-				return -1;
-		}
-
-	} else {
-		/*--------------------------------------------------------------------*/
-		/* SHA 2 TESTS                                                        */
-		/*--------------------------------------------------------------------*/
-		for (i = 0; i < SHA2_NUM_OF_SELF_TESTS; i++) {
-			SHA_Power(true);
-			SHA_Reset();
-			status = SHA_Start(&handle, npcm_sha_type_sha2);
-			npcm_sha_check(status);
-			if (i == 2) {
-				for (j = 0; j < 10000; j++) { //not working
-					status = SHA_Update(&handle, sha2selftestbuff[i], sha2selftestbufflen[i]);
-					npcm_sha_check(status);
-				}
-			} else {
-				status = SHA_Update(&handle, sha2selftestbuff[i], sha2selftestbufflen[i]);
-				npcm_sha_check(status);
-			}
-
-			status = SHA_Finish(&handle, hashdigest);
-			npcm_sha_check(status);
-			SHA_Power(false);
-			if (memcmp(hashdigest, sha2selftestexpres[i], SHA_2_HASH_LENGTH))
-				return -1;
-
-			npcm_sha_calc(npcm_sha_type_sha2, sha2selftestbuff[i], sha2selftestbufflen[i], hashdigest);
-			if (memcmp(hashdigest, sha2selftestexpres[i], SHA_2_HASH_LENGTH))
-				return -1;
-		}
+	if (!sha_priv->support_sha512) {
+		puts(" HW accelerator not support\n");
+		return;
 	}
-
-	return 0;
+	puts(" using BMC HW accelerator\n");
+	npcm_sha_calc(input, len, output, type_sha384);
 }
 
-/*----------------------------------------------------------------------------*/
-/* Function:        SHA_FlushLocalBuffer_l                                    */
-/*                                                                            */
-/* Parameters:                                                                */
-/* Returns:         none                                                      */
-/* Side effects:                                                              */
-/* Description:     This routine flush secrun buffer to SHA module            */
-/*----------------------------------------------------------------------------*/
-static void SHA_FlushLocalBuffer_l(const u32 *buff)
+void hw_sha256(const unsigned char *input, unsigned int len,
+	       unsigned char *output, unsigned int chunk_sz)
 {
-	struct npcm_sha_regs *regs = sha_priv->regs;
-	u32 i;
-
-	for (i = 0; i < (SHA_BLOCK_LENGTH / sizeof(u32)); i++)
-		writel(buff[i], &regs->hash_data_in);
+	puts(" using BMC HW accelerator\n");
+	npcm_sha_calc(input, len, output, type_sha256);
 }
 
-/*----------------------------------------------------------------------------*/
-/* Function:        SHA_BusyWait_l                                            */
-/*                                                                            */
-/* Parameters:                                                                */
-/* Returns:         0 if no error was found or DEFS_STATUS_ERROR otherwise    */
-/* Side effects:                                                              */
-/* Description:     This routine wait for SHA unit to no longer be busy       */
-/*----------------------------------------------------------------------------*/
-static int SHA_BusyWait_l(void)
+void hw_sha1(const unsigned char *input, unsigned int len,
+	     unsigned char *output, unsigned int chunk_sz)
 {
-	struct npcm_sha_regs *regs = sha_priv->regs;
-	u32 timeout = SHA_TIMEOUT;
-
-	do {
-		if (timeout-- == 0)
-			return -ETIMEDOUT;
-	} while ((readb(&regs->hash_ctr_sts) & HASH_CTR_STS_SHA_BUSY)
-						== HASH_CTR_STS_SHA_BUSY);
-
-	return 0;
+	puts(" using BMC HW accelerator\n");
+	npcm_sha_calc(input, len, output, type_sha1);
 }
 
-/*----------------------------------------------------------------------------*/
-/* Function:        SHA_GetShaDigest_l                                        */
-/*                                                                            */
-/* Parameters:      hashDigest - buffer for the hash output.                  */
-/*                  type - SHA module type                                    */
-/* Returns:         none                                                      */
-/* Side effects:                                                              */
-/* Description:     This routine copy the hash digest from the hardware       */
-/*                  and into given buffer (in ram)                            */
-/*----------------------------------------------------------------------------*/
-static void SHA_GetShaDigest_l(u8 *hashdigest, u8 type)
+int hw_sha_init(struct hash_algo *algo, void **ctxp)
 {
-	struct npcm_sha_regs *regs = sha_priv->regs;
-	u16 j;
-	u8 len = SHA_HASH_LENGTH(type) / sizeof(u32);
-
-	// Copy Bytes from SHA module to given buffer
-	for (j = 0; j < len; j++)
-		((u32 *)hashdigest)[j] = readl(&regs->hash_dig[j]);
-}
+	if (!strcmp("sha1", algo->name)) {
+		npcm_sha_init(type_sha1);
+	} else if (!strcmp("sha256", algo->name)) {
+		npcm_sha_init(type_sha256);
+	} else if (!strcmp("sha384", algo->name)) {
+		if (!sha_priv->support_sha512)
+			return -ENOTSUPP;
+		npcm_sha_init(type_sha384);
+	} else if (!strcmp("sha512", algo->name)) {
+		if (!sha_priv->support_sha512)
+			return -ENOTSUPP;
+		npcm_sha_init(type_sha512);
+	} else {
+		return -ENOTSUPP;
+	}
 
-/*----------------------------------------------------------------------------*/
-/* Function:        SHA_SetShaDigest_l                                        */
-/*                                                                            */
-/* Parameters:      hashDigest - input buffer to set as hash digest           */
-/*                  type - SHA module type                                    */
-/* Returns:         none                                                      */
-/* Side effects:                                                              */
-/* Description:     This routine set the hash digest in the hardware from     */
-/*                  a given buffer (in ram)                                   */
-/*----------------------------------------------------------------------------*/
-static void SHA_SetShaDigest_l(const u32 *hashdigest, u8 type)
-{
-	struct npcm_sha_regs *regs = sha_priv->regs;
-	u16 j;
-	u8 len = SHA_HASH_LENGTH(type) / sizeof(u32);
+	printf("Using npcm SHA engine\n");
+	npcm_sha_reset();
+	npcm_sha_enable(true);
 
-	// Copy Bytes from given buffer to SHA module
-	for (j = 0; j < len; j++)
-		writel(hashdigest[j], &regs->hash_dig[j]);
+	return 0;
 }
 
-/*----------------------------------------------------------------------------*/
-/* Function:        SHA_SetBlock_l                                            */
-/*                                                                            */
-/* Parameters:      data        - data to copy                                */
-/*                  len         - size of data                                */
-/*                  position    - byte offset into the block at which data    */
-/*                                should be placed                            */
-/*                  block       - block buffer                                */
-/* Returns:         none                                                      */
-/* Side effects:                                                              */
-/* Description:     This routine load bytes into block buffer                 */
-/*----------------------------------------------------------------------------*/
-static void SHA_SetBlock_l(const u8 *data, u32 len, u16 position, u32 *block)
+int hw_sha_update(struct hash_algo *algo, void *ctx, const void *buf,
+		  unsigned int size, int is_last)
 {
-	u8 *dest = (u8 *)block;
-
-	memcpy(dest + position, data, len);
+	return npcm_sha_update(buf, size);
 }
 
-/*----------------------------------------------------------------------------*/
-/* Function:        SHA_SetBlock_l                                            */
-/*                                                                            */
-/* Parameters:                                                                */
-/*                  len - size of data                                        */
-/*                  position - byte offset into the block at which data       */
-/*                             should be placed                               */
-/*                  block - block buffer                                      */
-/* Returns:         none                                                      */
-/* Side effects:                                                              */
-/* Description:     This routine load zero's into the block buffer            */
-/*----------------------------------------------------------------------------*/
-static void SHA_ClearBlock_l(u16 len, u16 position, u32 *block)
+int hw_sha_finish(struct hash_algo *algo, void *ctx, void *dest_buf,
+		  int size)
 {
-	u8 *dest = (u8 *)block;
+	int ret;
 
-	memset(dest + position, 0, len);
-}
+	ret = npcm_sha_finish(dest_buf);
+	npcm_sha_enable(false);
 
-/*----------------------------------------------------------------------------*/
-/* Function:        SHA_SetLength32_l                                         */
-/*                                                                            */
-/* Parameters:                                                                */
-/*                  handlePtr  -   SHA processing handle pointer              */
-/*                  block - block buffer                                      */
-/* Returns:         none                                                      */
-/* Side effects:                                                              */
-/* Description:     This routine set the length of the hash's data            */
-/*                  len is the 32-bit byte length of the message              */
-/*lint -efunc(734,SHA_SetLength32_l) Supperess loss of percision lint warning */
-/*----------------------------------------------------------------------------*/
-static void SHA_SetLength32_l(struct SHA_HANDLE_T *handleptr, u32 *block)
-{
-	u16 *secrunbufferswappedptr = (u16 *)(void *)(block);
-
-	secrunbufferswappedptr[(SHA_BLOCK_LENGTH / sizeof(u16)) - 1] = (u16)
-	((handleptr->length0 << 3) << 8) | ((u16)(handleptr->length0 << 3) >> 8);
-	secrunbufferswappedptr[(SHA_BLOCK_LENGTH / sizeof(u16)) - 2] = (u16)
-	((handleptr->length0 >> (16 - 3)) >> 8) | ((u16)(handleptr->length0 >> (16 - 3)) << 8);
-	secrunbufferswappedptr[(SHA_BLOCK_LENGTH / sizeof(u16)) - 3] = (u16)
-	((handleptr->length1 << 3) << 8) | ((u16)(handleptr->length1 << 3) >> 8);
-	secrunbufferswappedptr[(SHA_BLOCK_LENGTH / sizeof(u16)) - 4] = (u16)
-	((handleptr->length1 >> (16 - 3)) >> 8) | ((u16)(handleptr->length1 >> (16 - 3)) << 8);
+	return ret;
 }
 
 static int npcm_sha_bind(struct udevice *dev)
@@ -871,12 +348,15 @@ static int npcm_sha_bind(struct udevice *dev)
 	if (!sha_priv)
 		return -ENOMEM;
 
-	sha_priv->regs = dev_remap_addr_index(dev, 0);
-	if (!sha_priv->regs) {
+	sha_priv->base = dev_read_addr_ptr(dev);
+	if (!sha_priv->base) {
 		printf("Cannot find sha reg address, binding failed\n");
 		return -EINVAL;
 	}
 
+	if (IS_ENABLED(CONFIG_ARCH_NPCM8XX))
+		sha_priv->support_sha512 = true;
+
 	printf("SHA: NPCM SHA module bind OK\n");
 
 	return 0;
-- 
2.25.1

