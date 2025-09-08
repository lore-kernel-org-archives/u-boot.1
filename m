Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0439ACAC581
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 11:32:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCFBC830F6;
	Mon,  8 Sep 2025 13:31:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sBk6ul/k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE113809A5; Mon,  8 Sep 2025 13:31:49 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFF2C82C84
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 13:31:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-62221568039so3390664a12.0
 for <u-boot@lists.denx.de>; Mon, 08 Sep 2025 04:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757331107; x=1757935907; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fSAf4bgetHaWATAXJSOD5bMCmtvvpJy3oR6HViKqw3g=;
 b=sBk6ul/khbRJg8ignAMdDzyVjXvdV9odi518VEnYTZ26DtmB9cc81gwU2irntayOX2
 qnKhpapZCpNwI0U0JJrBv/5o1ZuZ0dIHdA96v+K/AbjCUGW2bbsOkcFfbxn9Ry4X771r
 QJH3Ng89VSXnTETwohRncUV5TkwkAKpqazG2+Wh8iDNm6aPFgRbdGGBtDzP6fe9x2Axw
 /WkGcBEhtB57weYkbwOL832sGwRXdudumyp9VgngnMbKmffhos2eMAzXqWL2Gt9mfAlx
 Befkt57rQX+jB2fFs4Y3eOnWch78fKODeGy2Ej783BEEIvoodsPb6tbilqfWGjBMfzqW
 2miA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757331107; x=1757935907;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fSAf4bgetHaWATAXJSOD5bMCmtvvpJy3oR6HViKqw3g=;
 b=kYOsTwAvkzhBkPXqo3QjTNvm3z1ffoxcd8OB8VPef18CanBCJGWcFS3iVLpV8uUsiL
 7i01jjb9ICABvwyCoWqFmQ0zdBJSZgZc63p4rRh4QHg9cHPNERc7PQ0fnFPmbVi73P4Q
 /e06DkxJpUKTfwYfS/768Es/AFiO79d/myiOD2P+D4RpzVVF/NL276YJxSmXu0R3dmKX
 eANGtu8Nmb4ruXnipD2C1thccuh9wfsiSHKSd8DcLPr1V2k+8eqgUuAlIGS6NFW2HJAp
 NL4cWBEtV1qrrXBQ8krZCZ9W4cPL8T7HIBiODHYmdHQzeEnkwE3NGr4aUS3mWovBrlQn
 jtSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrbUf/MS8akFE2LMCujfSjuUMbLmYsByaTI8077IqU658eAq19sjDu2UYK6jFODlRnEXmkFvE=@lists.denx.de
X-Gm-Message-State: AOJu0YyE8sEk7LwFZGrwLx3mEc6x/mtFyI3iP69P2mYzBj8nDD2f/WQq
 ZYIPfGT9Xn1NbcZXZ+Rtm4XWlvt/xyxv4/zXbNdfFibBKRkMjAkizg0ItL5LyxFMulI=
X-Gm-Gg: ASbGncuV9v9s5Cf+0SUvHClSVCIfWi6bRjNLuU5Vvbo59x0tlAO8KFIDQeixSXwTXJe
 44fsSiHajfMu8j3UV/D65eEI5yB5orMrRhtzYoOh/3l6dS1EkTVaCTWlBo4bVfW6OctsJXcwaYh
 udv+6besEcQaCOed51o/GvHUp3aowM/76Kog4tkzRYOBy6wr3ikhpXTT7qryEEYNKdjoEK54g2z
 d4viwM+FWTjEC/SHXMppGXDbhcqTl2RdopjXd4xQyTxHkBHBlatFVaOuWYnKPOs5/Xxi0r1NXCV
 ao4oqbugw+wcUOc8muIR+l4M2r39LIQ8WAWtalmMfboibu4hFIW7HL6LVj89CnN4sEy2E0Kch51
 FKWwzoNVhhcb1WswE21kiFGaOpPWegnC9cg==
X-Google-Smtp-Source: AGHT+IGFo6RCdEjjrLzs1l9u7ZOfU5NE8pi09GwbSNvdacNNVbB5CGxvOH1u30PZhgrFv3+1Zwv+Ng==
X-Received: by 2002:a05:6402:440f:b0:61c:d606:9ce5 with SMTP id
 4fb4d7f45d1cf-623729d0511mr6281658a12.4.1757331107192; 
 Mon, 08 Sep 2025 04:31:47 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:30:60d4:28a5:7729:b0b6])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61cfc214bb7sm21251501a12.13.2025.09.08.04.31.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 04:31:46 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Mon, 08 Sep 2025 13:31:25 +0200
Subject: [PATCH v2 5/6] serial: msm: Re-enable after resetting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-db410c-autoboot-fixes-v2-5-316ed98e0143@linaro.org>
References: <20250908-db410c-autoboot-fixes-v2-0-316ed98e0143@linaro.org>
In-Reply-To: <20250908-db410c-autoboot-fixes-v2-0-316ed98e0143@linaro.org>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Sumit Garg <sumit.garg@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Sam Day <me@samcday.com>, u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14.2
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

The documentation for the UART controller in the APQ8016E specifies that
both RESET and ENABLE commands must be issued to set up the receiver and
transmitter, but at the moment we only issue RESET. This doesn't seem to
cause issues in practice (looks like the reset already re-enables the
receiver/transmitter), but let's add the two writes to RX_ENABLE/TX_ENABLE
to better match the recommendations in the documentation.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 drivers/serial/serial_msm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/serial/serial_msm.c b/drivers/serial/serial_msm.c
index 5523ec4afe17f242d61bc2ec4b4534b5b974434c..2c08a84b02773663f3c3a11eddaaa7a8bab2b4a1 100644
--- a/drivers/serial/serial_msm.c
+++ b/drivers/serial/serial_msm.c
@@ -50,6 +50,8 @@
 #define UARTDM_SR_UART_OVERRUN   (1 << 4) /* Receive overrun */
 
 #define UARTDM_CR                         0xA8 /* Command register */
+#define UARTDM_CR_RX_ENABLE               (1 << 0) /* Enable receiver */
+#define UARTDM_CR_TX_ENABLE               (1 << 2) /* Enable transmitter */
 #define UARTDM_CR_CMD_RESET_RX            (1 << 4) /* Reset receiver */
 #define UARTDM_CR_CMD_RESET_TX            (2 << 4) /* Reset transmitter */
 #define UARTDM_CR_CMD_RESET_ERR           (3 << 4) /* Clear overrun error */
@@ -225,6 +227,8 @@ static void uart_dm_init(struct msm_serial_data *priv)
 
 	writel(UARTDM_CR_CMD_RESET_RX, priv->base + UARTDM_CR);
 	writel(UARTDM_CR_CMD_RESET_TX, priv->base + UARTDM_CR);
+	writel(UARTDM_CR_RX_ENABLE, priv->base + UARTDM_CR);
+	writel(UARTDM_CR_TX_ENABLE, priv->base + UARTDM_CR);
 }
 static int msm_serial_probe(struct udevice *dev)
 {

-- 
2.50.1

