Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ED1606A31A
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 19:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=f9ktJG99;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=i2gC3ZrA
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 99447607E4;
	Thu, 22 Oct 2026 19:02:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iVMDpotX-EIR; Thu, 22 Oct 2026 19:02:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B80956068B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792695764;
	b=MaU5ohalbJF+kXUvKAMlS1oqfBD/CqxlgEXTGliZ49QdNyNykWoSiVco1K5e/0eTIpFS
	 jmfslYHD80B9sIp/wLDsC7WNEfGAibApBBsrSFNxPbPWWWA992Qr5gaPx5Z/ywFedkCzM
	 fyC6zYdbcV3ntfY1/Kd0IjFCNpTyM24hOYg1II2UmyV4JSzh5vGBsSkfxruTGUQRu8/H7
	 Lew0o4REbTt13B+bgQtm9xDxyrUj7RLzpFiQjk4Jn8ZxebXJIFbfVG894KU+CBVC/Q7Zj
	 By5m9tX/+7gzSw0xV/5wh4jk6MHK62d7AT9sosDHxR0T4UDVaDp+/TBz1ogi2kJ8JAw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792695764;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=fsJ+biaHS9ORPrhqH1BJbb9ytNg1tz4B85ZrshNtr9s=;
	b=YbPgSE5z1OAYi0+X1wdkJKS0+fDoBtwR7mLSfCL3KWj9TwTKVlS4x3wEbfwqAhOX9pA8
	 X2ptMJirwlUNjGQUAvtoMA7vbMhBrq2OJ8pkb1aCjhRZ7hAd+jYbwQ3TeJoVg0wVamsLP
	 9nZh94r+O7AiQHjX4Y+b8jw/7Bwk2BBng76YqgMG9eX8XnleOWGU2JZv1Lne1w/WUwToj
	 NWKBkUvdgLLegVLc5m7v2+0Q3ngqdCEkXtdSFRSomt0XlMEUCqLBGOiiBazbfMsjyVvtv
	 nsVPVgjWuf/dxCdEO8yX8QZFsOUv6Pvlfo/AU/HZxtNXTqY3QiTIe+hupn7wOK/HW1Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792695764;
	bh=fsJ+biaHS9ORPrhqH1BJbb9ytNg1tz4B85ZrshNtr9s=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f9ktJG99g8ZceMI8S5hnjogSiNOZ6E40ov+i33ffmAIeMG7xiuNxajDalgoIlgwQi
	 /Qt6gDECCETRNZm81UFNKBfiQQrmfA1N2x/S+4HQNX7R4eHpk5ZSAQ6tepG89obtFW
	 xOA7NQF1L8xtdnhqlcV4jdq3c5unD/z1/xQX8yopyA6UOVxZQBQtQ+JgbNAljK/m/t
	 geBqc2dP5HcJ4sgELxMtzFov2qD08srZRgHMA4cgPIZUhOXAKr4oWbnaNaS4oiZFP/
	 j3ds13UJPrDjRUjS1zmiGWgwaVI4dOOblt610bQr5vWIHSMpies9vPj8+ARzF8/z0h
	 AzhnMsAm/klzA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B80956068B;
	Thu, 22 Oct 2026 19:02:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E527D3A7
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:02:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D5FDE81246
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:02:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hTa6hw9HvKFz for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 19:02:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C1E9D81069
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::430"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792695758;
 b=dI+8BQneWDy0gwBproRULyTggWrgMQx5B5spJmEkMtgz5SNrL9rGJc2ajX0k9T642LPK
 d+p6Dj7ycHoAPU0DVJKB7jhONgdS2sH1nFbFPLGfFukYNC4ExMeU1gPBpudjy6gnl0Lmd
 qHaVhcmTZ2CwRcnGCqAJafCBwbOGSE+lUw6cQWNrF1z15HCm99M4RGWsZbqiZu6wlPIvq
 Yc/Jk36FTJDd9kUiOo3s+nbSY4vzkEbMINCdNc2fVYt9ZUIXz+7i8AFI1An8cUzG+Pr97
 gLI8UuFemmC1z19sJEBbMY5+CndcdV/2EKvyiFMGa1QJ4hB14mdiOh7TETM77DCWb/Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792695758;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=fsJ+biaHS9ORPrhqH1BJbb9ytNg1tz4B85ZrshNtr9s=;
 b=pQ+R2iKa1W7Hi3mEI3tD6A/dOJ4Kg2DR8dp25YbMzEx0o4qKuQC+JjaWU5V6xHQBPPHx
 QPJLGXEj1Djon5eRqiQiZd6Gky4kvFaDDtFQrQy6QJHBXPkv+he9sk2Y+qnUm7kVC6n1I
 P0SxEQyLzAz+b1xQdOJfy2bJUWN8zIdKC9Zhf0ztxJc+aiMsklxJZ/8f7wtA+mBSBwCHp
 Rfg4E0e9DFNkCuMyzbUDiWf3it56Jlxya5aKDr9fAaPAFE4D0dFFaHxs3IWJTbbxxmMdd
 sConPakv1Q90lILpmeCETJ+XbIQi1CsoMeBViFL4ERGaTonleAr3n2cOfZZ4au7ACOA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=i2gC3ZrA; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::430"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=i2gC3ZrA
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C1E9D81069
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:02:37 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48c4d870d54so79088f8f.2
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792695755; x=1793300555;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fsJ+biaHS9ORPrhqH1BJbb9ytNg1tz4B85ZrshNtr9s=;
 b=i2gC3ZrANhCI8MC000YnlRwE8TGfWZqZSA7q2usOohJM2cGMOU5DE+S7jO8uB1yhJ/
 egxNSx5o0LpQobK2oBThTJrCUReWieUnvv3ZkY/gH0UYa+zPRsKoEYATWQolKqUnphqS
 iZp8Kr/ZjeEJfZUrcRzctYYssJ5IVmrZAUialKEshEXDIF9T/csx9j90w8170Xoxe0aQ
 0ZcGyiJl4tsmVWJlgUg8qUOejeJq+Oz9cNA7mSJXt8Cg5+m1xI59x/Cos+A2RYdghaGI
 pQfodkvGfLhMj+q26BgwC+UP/vTTL+z9+aXAd6JrCTdDXXEyj28khM73NuqUUN/8no8a
 HjTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792695755; x=1793300555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=fsJ+biaHS9ORPrhqH1BJbb9ytNg1tz4B85ZrshNtr9s=;
 b=UkTMP5z4ZEb8pgX6Gf55pC9N3ALKHtx+gfrV+Qq833Y7xklXnbR9zIFJqdtYbLiPWZ
 oB7jd/DMQzWueYlJVJOvGIA0MCISZGa1J7xA57CkIPLr2w8OFpODTRDpGm1U/+025/R+
 fHX7Ia+F3UhXbSJw03sFI+CYmzmAm9pYYETGjEIhlJ620JYMB80vRMl0zG+iSOFf29gP
 1x57pbEHJehOo4oZBb7O5KtKeRkmixPPyC91VoCZL/+M9SBOtcUX9OurRREEJEnYc5O0
 Au1w57YTa0q8F2+iUBSlSYpYdcin7MNdCCRU9luIIvUzLrZ1KrHOkkoCbne+sDoUhdjV
 wwjg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzr9ui5k7X3wK1NNGyu2KOA8nYpRV3SCl1kKcrZ9+p1vT9LyLFA5G17hgFi4BM2Rysg6fsqk2Q=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJRsN/4i7uZUuM+BLl96r4uJATvTmbY5UHZCRAq4TpIQwTSqphz
 9BLXZ1axkcqwZXM68XazHgqngON/l6kjwSyBpdBl89y6KFlRsjVakku7/f2dfw==
X-Gm-Gg: AYBFou1Aj474IoeeE4c75+HdsA9GxAea8MiNEUvP4CkC9riq9lSeNaPd/+NxqxItQRc
 yK/JpLmTbiev9RcBnNwgfNqFSOHLC5VvEXd4rZftpV+KNki96Af+hG1i+h1OZcBbclTy2slxXUA
 ZJp7zzQRHdpVN2lrMw+Li5bwBiUrQnfTQIuYLHVc5Y3sYw3Z+K8X43j1nJX3r/VxVvM/dYAOV1r
 cJS+gzseNGwmuA2W1ylERYM68cRST78gzJJaN4dbSkZa9uzDnZ+dXzzuAV/H2lHWNIyzSyf0Afr
 n0sI1N/B6HuBXl/0Iu4ySnMW/jSYrYPIH/RaKKCASAi0l+9QSW33uuCtvLLnUSLsHEyUic3NNwM
 L1ZihZIrR4NUIeWU67qHiaPIPZqifTVfmz96VmAC8v1QQk9mdHT8mx+Y32At/C5YvwPtvSQ/E4d
 XZAR4al90a5DfCAYh+Y0yyAt2jUKal7AiQpRdMnE9/3cJpSCz8StlzvpxJ3DnJKFdjFNS6dkr2R
 tCGosEv7EQFZhrmjCqhLtJRz2JX3A/PwvqLCSkel+LCkfTi/CY6yNsDGmE3cUCtK1MmxtRj3rPs
 wGGAUypVLYTB3OINQclZw/KnvEgAUsILCbXb95ELuUw8EgLzbeISRlF8N8rg
X-Received: by 2002:a5d:6f11:0:b0:48b:9d80:53a5 with SMTP id
 ffacd0b85a97d-48e2649399cmr12484484f8f.10.1792695755210; 
 Thu, 22 Oct 2026 12:02:35 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it.
 [93.34.92.187]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-48e37a0e841sm189495f8f.54.2026.10.22.12.02.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 12:02:33 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Julien Masson <jmasson@baylibre.com>,
 Zhengping Zhang <zhengping.zhang@airoha.com>,
 David Lechner <dlechner@baylibre.com>, Wayen Yan <win847@gmail.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v3 05/16] clk: airoha: add support for Airoha AN7583 SoC clock
Date: Thu, 22 Oct 2026 21:01:47 +0200
Message-ID: <20261022190206.666950-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022190206.666950-1-ansuelsmth@gmail.com>
References: <20261022190206.666950-1-ansuelsmth@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add support for Airoha AN7583 SoC clock that implement more base values
for clocks compared to AN7581.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/airoha/clk-airoha.c | 159 ++++++++++++++++++++++++++++++++
 1 file changed, 159 insertions(+)

diff --git a/drivers/clk/airoha/clk-airoha.c b/drivers/clk/airoha/clk-airoha.c
index 89a8b4cb1cf8..5e73455573eb 100644
--- a/drivers/clk/airoha/clk-airoha.c
+++ b/drivers/clk/airoha/clk-airoha.c
@@ -19,6 +19,7 @@
 #include <asm/arch/scu-regmap.h>
 
 #include <dt-bindings/clock/en7523-clk.h>
+#include <dt-bindings/clock/an7583-clk.h>
 
 #define REG_GSW_CLK_DIV_SEL		0x1b4
 #define REG_EMI_CLK_DIV_SEL		0x1b8
@@ -36,6 +37,7 @@
 
 #define EN7523_MAX_CLKS			8
 #define EN7581_MAX_CLKS			9
+#define EN7583_MAX_CLKS			11
 
 struct airoha_clk_desc {
 	int id;
@@ -78,6 +80,14 @@ static const u32 bus7581_base[] = { 600000000, 540000000 };
 static const u32 npu7581_base[] = { 800000000, 750000000, 720000000, 600000000 };
 static const u32 crypto_base[] = { 540000000, 480000000 };
 static const u32 emmc7581_base[] = { 200000000, 150000000 };
+/* AN7583 */
+static const u32 gsw7583_base[] = { 540672000, 270336000, 400000000, 200000000 };
+static const u32 emi7583_base[] = { 540672000, 480000000, 400000000, 300000000 };
+static const u32 bus7583_base[] = { 600000000, 540672000, 480000000, 400000000 };
+static const u32 spi7583_base[] = { 400000000, 12500000 };
+static const u32 npu7583_base[] = { 666000000, 800000000, 720000000, 600000000 };
+static const u32 crypto7583_base[] = { 540672000, 400000000 };
+static const u32 emmc7583_base[] = { 150000000, 200000000 };
 
 static const struct airoha_clk_desc en7523_base_clks[EN7523_MAX_CLKS] = {
 	[EN7523_CLK_GSW] = {
@@ -293,6 +303,147 @@ static const struct airoha_clk_desc en7581_base_clks[EN7581_MAX_CLKS] = {
 	}
 };
 
+static const struct airoha_clk_desc an7583_base_clks[EN7583_MAX_CLKS] = {
+	[EN7523_CLK_GSW] = {
+		.id = EN7523_CLK_GSW,
+		.name = "gsw",
+
+		.base_reg = REG_GSW_CLK_DIV_SEL,
+		.base_bits = 2,
+		.base_shift = 8,
+		.base_values = gsw7583_base,
+		.n_base_values = ARRAY_SIZE(gsw7583_base),
+
+		.div_bits = 3,
+		.div_shift = 0,
+		.div_step = 1,
+		.div_offset = 1,
+	},
+	[EN7523_CLK_EMI] = {
+		.id = EN7523_CLK_EMI,
+		.name = "emi",
+
+		.base_reg = REG_EMI_CLK_DIV_SEL,
+		.base_bits = 2,
+		.base_shift = 8,
+		.base_values = emi7583_base,
+		.n_base_values = ARRAY_SIZE(emi7583_base),
+
+		.div_bits = 3,
+		.div_shift = 0,
+		.div_step = 1,
+		.div_offset = 1,
+	},
+	[EN7523_CLK_BUS] = {
+		.id = EN7523_CLK_BUS,
+		.name = "bus",
+
+		.base_reg = REG_BUS_CLK_DIV_SEL,
+		.base_bits = 2,
+		.base_shift = 8,
+		.base_values = bus7583_base,
+		.n_base_values = ARRAY_SIZE(bus7583_base),
+
+		.div_bits = 3,
+		.div_shift = 0,
+		.div_step = 1,
+		.div_offset = 1,
+	},
+	[EN7523_CLK_SLIC] = {
+		.id = EN7523_CLK_SLIC,
+		.name = "slic",
+
+		.base_reg = REG_SPI_CLK_FREQ_SEL,
+		.base_bits = 1,
+		.base_shift = 1,
+		.base_values = slic_base,
+		.n_base_values = ARRAY_SIZE(slic_base),
+
+		.div_reg = REG_SPI_CLK_DIV_SEL,
+		.div_bits = 5,
+		.div_shift = 24,
+		.div_val0 = 20,
+		.div_step = 2,
+	},
+	[EN7523_CLK_SPI] = {
+		.id = EN7523_CLK_SPI,
+		.name = "spi",
+
+		.base_reg = REG_SPI_CLK_FREQ_SEL,
+		.base_bits = 1,
+		.base_shift = 0,
+		.base_values = spi7583_base,
+		.n_base_values = ARRAY_SIZE(spi7583_base),
+
+		.div_reg = REG_SPI_CLK_DIV_SEL,
+		.div_bits = 5,
+		.div_shift = 8,
+		.div_val0 = 40,
+		.div_step = 2,
+	},
+	[EN7523_CLK_NPU] = {
+		.id = EN7523_CLK_NPU,
+		.name = "npu",
+
+		.base_reg = REG_NPU_CLK_DIV_SEL,
+		.base_bits = 2,
+		.base_shift = 9,
+		.base_values = npu7583_base,
+		.n_base_values = ARRAY_SIZE(npu7583_base),
+
+		.div_bits = 3,
+		.div_shift = 0,
+		.div_step = 1,
+		.div_offset = 1,
+	},
+	[EN7523_CLK_CRYPTO] = {
+		.id = EN7523_CLK_CRYPTO,
+		.name = "crypto",
+
+		.base_reg = REG_CRYPTO_CLKSRC2,
+		.base_bits = 1,
+		.base_shift = 0,
+		.base_values = crypto7583_base,
+		.n_base_values = ARRAY_SIZE(crypto7583_base),
+	},
+	[EN7581_CLK_EMMC] = {
+		.id = EN7581_CLK_EMMC,
+		.name = "emmc",
+
+		.base_reg = REG_CRYPTO_CLKSRC2,
+		.base_bits = 1,
+		.base_shift = 13,
+		.base_values = emmc7583_base,
+		.n_base_values = ARRAY_SIZE(emmc7583_base),
+	},
+	[AN7583_CLK_MDIO0] = {
+		.id = AN7583_CLK_MDIO0,
+		.name = "mdio0",
+
+		.base_reg = REG_CRYPTO_CLKSRC2,
+
+		.base_value = 25000000,
+
+		.div_bits = 4,
+		.div_shift = 15,
+		.div_step = 1,
+		.div_offset = 1,
+	},
+	[AN7583_CLK_MDIO1] = {
+		.id = AN7583_CLK_MDIO1,
+		.name = "mdio1",
+
+		.base_reg = REG_CRYPTO_CLKSRC2,
+
+		.base_value = 25000000,
+
+		.div_bits = 4,
+		.div_shift = 19,
+		.div_step = 1,
+		.div_offset = 1,
+	}
+};
+
 static u32 airoha_clk_get_base_rate(const struct airoha_clk_desc *desc, u32 val)
 {
 	if (!desc->base_bits)
@@ -542,6 +693,11 @@ static const struct airoha_clk_soc_data en7581_data = {
 	.descs = en7581_base_clks,
 };
 
+static const struct airoha_clk_soc_data an7583_data = {
+	.num_clocks = ARRAY_SIZE(an7583_base_clks),
+	.descs = an7583_base_clks,
+};
+
 static const struct udevice_id airoha_clk_ids[] = {
 	{ .compatible = "airoha,en7523-scu",
 	  .data = (ulong)&en7523_data,
@@ -549,6 +705,9 @@ static const struct udevice_id airoha_clk_ids[] = {
 	{ .compatible = "airoha,en7581-scu",
 	  .data = (ulong)&en7581_data,
 	},
+	{ .compatible = "airoha,an7583-scu",
+	  .data = (ulong)&an7583_data,
+	},
 	{ }
 };
 
-- 
2.55.0

