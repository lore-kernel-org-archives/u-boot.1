Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A98DC36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 17:18:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD1F283910;
	Wed,  9 Apr 2025 19:17:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="U+OkKqnd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4465983910; Wed,  9 Apr 2025 19:17:47 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9883D83927
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 19:17:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso75985735e9.0
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 10:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744219062; x=1744823862; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DYB4pdpQVvp03Xbf/q79COysiRGr12j5Zw6eGnH1Ae0=;
 b=U+OkKqndMoj2wO/Hjs7os0f0yAZbhaxPIN5d9J4V0gKlOYPM20sxWzVCiCTFWwJ0Ow
 uCkOzo/2/Y3k9Pq1XivOooHQCAGA+y3D8EIVfd2X8eZI+hXJLIbhqflsSrff/klepvIr
 pNJdgvKqamZi8D6+Css/wXKyCeu1C9kOK+ZnvQBuzzELCmBiUPX+T7Xpq9/ggqQVE60O
 CR8OxHN7/ubLgNj+zum7Uoo1m6DcFfssQoTvumkx6ret0V9LOYLqYT0OvcGdOhKR1XXi
 0PzE+FGBsAJNsF2eyeu8EHPF4oubwSEqIppr7O/qZjXJ2EBJIdzWWteD6Xpb/Sl4gGWy
 NT2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744219062; x=1744823862;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DYB4pdpQVvp03Xbf/q79COysiRGr12j5Zw6eGnH1Ae0=;
 b=hdNCJvY94VZmIXraK6wsD0m2+xe1OvLyINUgDBEsCEOQgnDh4SDyPihSxctnW50ZKq
 bKWSkujXxBkkwj25fjXZFH9JZsrgbq+5w5wUn1Zs1Jovtv4cTs5he7V3RFqvFS94he3c
 sATo/6V1fwKSN1Ke17pSCbFwkxQ5nK1MWZw6C44U6VXYYq4OWM5V+jIlJKt8tUBMffI7
 w6KacpP9PSIlqJoxeQ3dFUD0H+mlt5YycJK3txXbjZMvTOJfAbUsjvMq+Hqfsw7bh1pb
 qy4oSUWMWWV5V4dlWwNaYTwDafBsAYIC7LpA0hcDkXv99Lup0EsAqz+DPehjZg5LQoWh
 lUnw==
X-Gm-Message-State: AOJu0YwJ4/Tg34ytuI+TqsewbQbxHwfu7Ll6e2MRU9O2KVt4tbICGXvE
 1919Qcyqz59HBTQFn97445wrLjJd7LShgRTuvbcEjIM0q/7mDj+zJoXIA1whEf09oKfrC8B8HJ/
 7xXs=
X-Gm-Gg: ASbGncsFVbkJiw7xJvuUyiWQrGsvw1lCv1iVcxoOnpGukPfvjAo28lkKONYkqyZo8eN
 8HV2MWFYZCxyHJrk+bgfEze2RId6GCX7Ynl7DTqP7HSvfRaL4JjBZijFizCNBUdmkCTXdzl0m4K
 Fab8aZVAfiwBNTDXvvYDRGvyGzH9mxR1rJ7XnIL/0hN1wOPUWxxecHHpQ2EPWTwIV6+0WrjsaUE
 vqbgHSm6qkhrwu5vX53B5trf1zb+kFrVFsO1VxRTaT5/GIOAqbrX4tadvvsFE0NKreUht2E18Ez
 ICENrm+T6FXOll815E37SHoPm1H0xsaBetWAxa6yK17Z7TesaAZ8vc8+R3fB27YPkWXMim3yIUk
 e5DDmUl2JX+w/eSXp
X-Google-Smtp-Source: AGHT+IEf6Hmzbrq2+0usM5rf9MzCTUu3Ieama6LmChQgccn41bDi8hEeKcjoEXZLpArJQt19J9CZLA==
X-Received: by 2002:a05:6000:2584:b0:391:2dea:c9a5 with SMTP id
 ffacd0b85a97d-39d87aa7de1mr3600124f8f.20.1744219062527; 
 Wed, 09 Apr 2025 10:17:42 -0700 (PDT)
Received: from toyger.tail248178.ts.net (i5E863B08.versanet.de. [94.134.59.8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f233c817dsm21916455e9.23.2025.04.09.10.17.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 10:17:41 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 09 Apr 2025 19:17:27 +0200
Subject: [PATCH 4/6] clk/qcom: qcm2290: show clock name in set_rate()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250409-livetree-fixup-v1-4-76dfea80b07f@linaro.org>
References: <20250409-livetree-fixup-v1-0-76dfea80b07f@linaro.org>
In-Reply-To: <20250409-livetree-fixup-v1-0-76dfea80b07f@linaro.org>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=939;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=RGPidV+UwpgdErh57zk/h4UmsU0/GKD8Q4uwmRKnxNY=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn9quuUILvm5l61AsY1C1juEcsn7/18HwuquZ4g
 gvtvk0u8nWJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ/arrgAKCRAFgzErGV9k
 tltyD/9ADWI9X4O2G1i0MGar04eQgA4HqniZcNaJ/YlpMb6MxGSLVX9ncPFXkozCQ6iwidILd0Y
 OzBgnsBdnFup+xu6eklnY3raQGvYQ249Ctr3/rM0WeioO4tMMJZudHLyELjFmdsFMpsM4FpUyvQ
 byBeDjrvchDBaqdrkzdlB5aV7pv3+KptZXZgOZSxkq/ujGbHtWCQi3fU5uAhTVbtpGQeWAfG7S/
 InoUF95pAVNbQVWBjNUCLzfoK3da2mYq7NYfncsGISLjruYeVPed/UlEhGcxnqrKlYFt6rV2n8j
 0Mq87KKI2PDSSd8meSjkkxfPU3eu3MZI4DJNFd78Pau89EaBIIbwT5LmQ9zNU15nAICfCRFy/fv
 Z/iur/nx1ACLEbKrBvLqc/QouyfsFxRVfR/S60lvyan2KwZA8slmSKoj5TFj3n9bNeo06n9wfBw
 xQa39UtdslI9wc3pwBehvbaPhYH2UG913g8h7LFAFdue1nvdMJZo1WNb6QG6kbvmow5BzFmKHNr
 26wObuRSsXVjKuh1tfm/FALiYDUEvRoCJ0YtMV5XBY69D07stSVhk2UktnsiOKQlkuGFZcvV9Eh
 gylrd+1y+34YW7Af2Mn6wk2hBadMuxDXIK1VUYnhVAUazTYYdR6lzg7Dm10jPy3+ACIDRjR/S4N
 0wkV4irJv98twng==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

The device name is always clk_qcom... Not very useful.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/clk/qcom/clock-qcm2290.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clock-qcm2290.c b/drivers/clk/qcom/clock-qcm2290.c
index 1326b770c3ebd723120de4b6657aafac726023d6..fad104fb91aec8917de66b63dd546926c8856011 100644
--- a/drivers/clk/qcom/clock-qcm2290.c
+++ b/drivers/clk/qcom/clock-qcm2290.c
@@ -87,9 +87,9 @@ static ulong qcm2290_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
 	const struct freq_tbl *freq;
 
-	debug("%s: clk %s rate %lu\n", __func__, clk->dev->name, rate);
+	debug("%s: clk %s rate %lu\n", __func__, qcm2290_clks[clk->id].name, rate);
 
 	switch (clk->id) {
 	case GCC_QUPV3_WRAP0_S4_CLK: /*UART2*/
 		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s0_clk_src, rate);

-- 
2.49.0

