Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F74FC10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 17:55:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF537883B9;
	Tue,  7 May 2024 19:55:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="o5WZ8O0n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9A1C883EE; Tue,  7 May 2024 19:55:26 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A6CB8836C
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 19:55:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6a0ce3e823fso21739416d6.1
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 10:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715104523; x=1715709323; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZcwDZqp4RDE8PbmTVNNlSE5JSmPCLVFLrIbd2n+0wzs=;
 b=o5WZ8O0nMWo+l4aiCrnT1p4MFII04VXpDQm+LpDPAZZIMWgm7CClVUumWa7bu8S7bA
 p1Rhi/jl45Qr3NMysNhNwTC8yxJIIjVH7PPPcrxjhI49my0RQnq4viyRfBOG6fTekpUl
 rRmT26NsRj0hAR0X0N4P/2d4q6uk9WX8qGwlq50eza3I0JTbxFL848k232re45UIUx0U
 QNRa5gq8FGruRhPzXaLobUzW9m9a5/61JPtCIQ4Dz52tjI9lqDxEPGJ9NPxdcxuc56TH
 VoOwZ9v8WF9rEEIpTNzvWzMnhtDMU4JpnPJx+tMTIVjKSq2tbAvWpKqVHCTMXU4xZutw
 k10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715104523; x=1715709323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZcwDZqp4RDE8PbmTVNNlSE5JSmPCLVFLrIbd2n+0wzs=;
 b=I2DjsDgNnX4dRwdG+sOETVRP1C+mULMOt/ngLd2VopZKXcO+B38dPlTpffr0XW+LQc
 aLFbQY5Y0oxnaLLOLrq4o3+Pq7gGc2hpKvaJIZ4pj2pP3gjgSXeFdUzF/ORfokrLtBLg
 MeBc+qgoputscQ9HwDhga3RQ6F99toMtqx5GmyfHOlNCvWqTbjXiFragY/MgCC4GnpGB
 NPmVsccCos6yM9smOaZv4irlGWLjJ1kjt6WDf5Ryt0vDczvUlgL/UpHUFmjV6F7ETqWL
 38xvuWKXNovemQrNWxJqSgtlrKJG+E6enCepru+8fqloHyx6WTLgsn+Yu5MFEQrjkvH7
 /Ldg==
X-Gm-Message-State: AOJu0YyvgZd9tTBqU6yk8deiz1laHr81zk6USPJes0vpgZAEQ3ndJAvm
 WsE285B4r8RgQ//KSbtvn4EHS2IgFGUaJYPSIRXXRWRtXPUp64StS16IINoO5jvcVoZ9Frjaud2
 F
X-Google-Smtp-Source: AGHT+IFxfXWo6b2xxHgb9EurM5SsmaT+bPU9ubCOuT1KwK4T/00fgq+UrDCL0pH5mIpRoW2S3oVVUw==
X-Received: by 2002:ad4:5ae8:0:b0:6a0:9443:b64 with SMTP id
 6a1803df08f44-6a15142778fmr6053126d6.9.1715104523347; 
 Tue, 07 May 2024 10:55:23 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-115-4-214.cpe.net.cable.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 o1-20020a0cecc1000000b006a0f126a033sm4801834qvq.28.2024.05.07.10.55.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 10:55:22 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, Andrew Davis <afd@ti.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, Ilya Lukin <4.shket@gmail.com>,
 Sergei Antonov <saproj@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Eddie James <eajames@linux.ibm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH v2 08/28] md5: Adapt to the changes of md5 header
Date: Tue,  7 May 2024 10:50:50 -0700
Message-Id: <20240507175132.1456512-9-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240507175132.1456512-1-raymond.mao@linaro.org>
References: <20240507175132.1456512-1-raymond.mao@linaro.org>
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

The md5 header is updated to adapt to both original lib and MbedTLS.
Now we need to change the API callers accordingly.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Initial patch.

 drivers/crypto/hash/hash_sw.c |  8 ++++----
 lib/md5.c                     | 10 +++++-----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/crypto/hash/hash_sw.c b/drivers/crypto/hash/hash_sw.c
index d8065d68ea4..a5033677930 100644
--- a/drivers/crypto/hash/hash_sw.c
+++ b/drivers/crypto/hash/hash_sw.c
@@ -51,17 +51,17 @@ static void hash_finish_crc32(void *ctx, void *obuf)
 /* MD5 */
 static void hash_init_md5(void *ctx)
 {
-	MD5Init((struct MD5Context *)ctx);
+	MD5Init((MD5Context *)ctx);
 }
 
 static void hash_update_md5(void *ctx, const void *ibuf, uint32_t ilen)
 {
-	MD5Update((struct MD5Context *)ctx, ibuf, ilen);
+	MD5Update((MD5Context *)ctx, ibuf, ilen);
 }
 
 static void hash_finish_md5(void *ctx, void *obuf)
 {
-	MD5Final(obuf, (struct MD5Context *)ctx);
+	MD5Final(obuf, (MD5Context *)ctx);
 }
 
 /* SHA1 */
@@ -159,7 +159,7 @@ static struct sw_hash_impl sw_hash_impl[HASH_ALGO_NUM] = {
 		.init = hash_init_md5,
 		.update = hash_update_md5,
 		.finish = hash_finish_md5,
-		.ctx_alloc_sz = sizeof(struct MD5Context),
+		.ctx_alloc_sz = sizeof(MD5Context),
 	},
 
 	[HASH_ALGO_SHA1] = {
diff --git a/lib/md5.c b/lib/md5.c
index faf3f78ab1e..34343cf8e23 100644
--- a/lib/md5.c
+++ b/lib/md5.c
@@ -55,7 +55,7 @@ byteReverse(unsigned char *buf, unsigned longs)
  * initialization constants.
  */
 void
-MD5Init(struct MD5Context *ctx)
+MD5Init(MD5Context *ctx)
 {
 	ctx->buf[0] = 0x67452301;
 	ctx->buf[1] = 0xefcdab89;
@@ -71,7 +71,7 @@ MD5Init(struct MD5Context *ctx)
  * of bytes.
  */
 void
-MD5Update(struct MD5Context *ctx, unsigned char const *buf, unsigned len)
+MD5Update(MD5Context *ctx, unsigned char const *buf, unsigned int len)
 {
 	register __u32 t;
 
@@ -120,7 +120,7 @@ MD5Update(struct MD5Context *ctx, unsigned char const *buf, unsigned len)
  * 1 0* (64-bit count of bits processed, MSB-first)
  */
 void
-MD5Final(unsigned char digest[16], struct MD5Context *ctx)
+MD5Final(unsigned char digest[16], MD5Context *ctx)
 {
 	unsigned int count;
 	unsigned char *p;
@@ -269,7 +269,7 @@ MD5Transform(__u32 buf[4], __u32 const in[16])
 void
 md5 (unsigned char *input, int len, unsigned char output[16])
 {
-	struct MD5Context context;
+	MD5Context context;
 
 	MD5Init(&context);
 	MD5Update(&context, input, len);
@@ -286,7 +286,7 @@ void
 md5_wd(const unsigned char *input, unsigned int len, unsigned char output[16],
 	unsigned int chunk_sz)
 {
-	struct MD5Context context;
+	MD5Context context;
 #if defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG)
 	const unsigned char *end, *curr;
 	int chunk;
-- 
2.25.1

