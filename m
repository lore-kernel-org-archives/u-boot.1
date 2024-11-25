Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E02DD3B7EF
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 08:29:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 041C18961D;
	Mon, 25 Nov 2024 09:29:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="l58U4cVn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B281899E3; Mon, 25 Nov 2024 09:29:21 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B726D8961D
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 09:29:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43168d9c6c9so38432125e9.3
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 00:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732523357; x=1733128157; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tiz8btQLCDQNvptZcd59Rtpx84EDspfxbClke28mxwU=;
 b=l58U4cVn7KOcIPfuTK/lNppQTczfdJpXJjmlkhOizmxA+nQLABoVac7N7YC5g6PR8R
 eKqmZLSmjVIBrHFS45naitQ2o+5sg8EqQBN2c0rBCbj9+L7DhmwEGV0df+kg5AkF+iPy
 elCnZUulI5iBYf4h7CT4H0B9O3pFlfh9Stmu83AQTz6FfqxN4W0LDC7QpekDcR8x1tag
 BMMZoufD7TCK/sEg7sv4TEcNtG+v/uv8Q4WBj0a+2K6l9ojpl/OjWbb8aW4CglbQg8Jz
 AZdMkrMa8PJU2E/AUqiKpqxdwuwH+hEcpYEgW9XeQ2ElUvCBuhBYUmuOskPmiHGkj6IO
 oH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732523357; x=1733128157;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tiz8btQLCDQNvptZcd59Rtpx84EDspfxbClke28mxwU=;
 b=xS3VJuSFS2OJL0fh7HEXqMeHjUL8CYk51Vnq/S4VbL9G3I7vPW/y29mpgK/ZgKwm/x
 UWzFn613yGjpjt7uvkvBC8fPjMDjSjV8gdKPaC4zq55pDOsLhgU2HQd8nJXHChMCsG8J
 GVXHWIKB2Uq3mkq2g1UBzc+KePUJDrQOo+c/kko4WsZAIf6/oZpVbIBBminDdDiD/p0l
 3Azi3v1cT9fVabiz9Gg4j3ovkl84mPz4Fq229WJ7o219FS6DfJqtou4ZfI/b3CPIjX40
 y9zsTun7EQogKN5azjdLSydtnGjrr9ko9tf1g3ICqTJuVvKP9xHajQqlbDIiopBxc6xH
 Xi8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqKBZLwrljPqxRjwRhNosYxefFlDJ/K5rqFPLZefizC0YTYR9Da1PoK/+0ZWufBf/A9wkpds4=@lists.denx.de
X-Gm-Message-State: AOJu0YwG6rIYJbB1++GnI5mTFEENhwEgytJ+OdixzyiMdqejLt+SNI8O
 PSITdyt2x/y3Wzp7jFJ/5hyN/okNtDzx1F3tv5pobDEnO/JS8GTEPE4NZ05xiig=
X-Gm-Gg: ASbGnctk2zCBwo21Eh1PJh+YKcBE3Ga3LSxdakAmn86sgPd6LeqVtsSX0rsoXWCDI+R
 JUKrn8S3nifwJvvfunLBVr95fAHzObK6s6vadRllxa1XCeEqbGx/PxCi8tbzZ+45ypE2PQ+jLkW
 a3ePxEyFukVmnzRL/MhFZtweC/+G4xRClZsxZVTecBpTulALbL0RxOTUK8IAhK1A7K9T0vsjayZ
 dVgPklsn/ES4bPzIVqVJYWw5IsXKWK077YmApmaoRFRduq0dW3A0QKlnz25/mr6Zw21mFM=
X-Google-Smtp-Source: AGHT+IEAZllX5y4kdpqMFNrhEEL9Q3VXzKB4EatguLBL6gp5Yy3nFDPItsrgN6rn8qyPCzRzUXoJaA==
X-Received: by 2002:a05:600c:4f41:b0:431:5eeb:2214 with SMTP id
 5b1f17b1804b1-433ce4c2ad6mr89971765e9.33.1732523357241; 
 Mon, 25 Nov 2024 00:29:17 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433cde1107csm121423545e9.15.2024.11.25.00.29.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 00:29:16 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 25 Nov 2024 09:29:10 +0100
Subject: [PATCH 1/3] pinctrl: qcom: sm8550: add pcie1_clk_req_n function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-topic-pcie-pinctrl-v1-1-4df323d90397@linaro.org>
References: <20241125-topic-pcie-pinctrl-v1-0-4df323d90397@linaro.org>
In-Reply-To: <20241125-topic-pcie-pinctrl-v1-0-4df323d90397@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=772;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Bt1qcS9xhaEMOKDt1rqUEVey4CX3q8T1s1aCzIeAdFE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnRDVZhJlWLNBvba8mEKomFMVbOkZ3WIDv3IXVZcqP
 cgjvI5+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ0Q1WQAKCRB33NvayMhJ0QmXD/
 40CztL6DDZfJRQpaj1NmhcAwmiWTv9X9adMHFzfj2Z9ftL6gxRPKVAVkY/fVo7f8VbWrNlNhj9TZgp
 1Rdv8iHukZy/2flkZCjUJL1af39D+CG3+TSV2LHmQ8Xp2UMosfKsSPgj3QB/70oONn0lbKEx4aZ8Md
 uff06LEBtfdm9IwEKGmzGmh1TS0tEZcU1sr624jTRxG8Vhatw9oo7bvxFI8eVakef/8A9eBPofbXQZ
 34jrwYqwCX33Png6PXt/K4srV6TVHmEOTRX5gRbE9GRWQelNQSgYVcdCegUa3PL0Lic57rbrKeSpFa
 t8J14GBZRCE3KHxvCyNQz9uu8RBmrtw55DVkkL2Teio3Yb+emSCnNDPFGZRolzc8wBqI3drI3hf19B
 CVmdUNGitpIQXfw3ARJcTh7gQFehZ/ojV9RHIJXN90R72U6Gu6ACqjQ+qzFUpOgGP68UEZpAH4VmLf
 G7hInqSAOEfN1X9oRNbRVcrgYA6keF4X0aXGRJbNBqkosRVz1hzRCb7I4DBVM8blXm/rUmgrHRvQ34
 0pxaZWsbDcw5yEx6ZHzE/LCK0uBbDu6nLfjia6Ns8d5BDdtx6tAil1wsuELLmUjdjjY9PqUpwSLIto
 nOFwPVNXabE6Qbqbhtjovjn3bYMaxFA6rx9IzKIx/AziBByGnzxtwfGXfTnQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Add the missing PCIe clk_req function for the SM8550 TLMM.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-sm8550.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-sm8550.c b/drivers/pinctrl/qcom/pinctrl-sm8550.c
index c65dfe0435eb6d72e1033fcb151114b7671bd537..25b972a6d8233df8eadab3dc30db9533173803d2 100644
--- a/drivers/pinctrl/qcom/pinctrl-sm8550.c
+++ b/drivers/pinctrl/qcom/pinctrl-sm8550.c
@@ -16,6 +16,7 @@ static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
 static const struct pinctrl_function msm_pinctrl_functions[] = {
 	{"qup1_se7", 1},
 	{"gpio", 0},
+	{"pcie1_clk_req_n", 1},
 };
 
 #define SDC_QDSD_PINGROUP(pg_name, ctl, pull, drv)	\

-- 
2.34.1

