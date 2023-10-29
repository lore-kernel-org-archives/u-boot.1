Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C55B4C4167D
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 04:28:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4745C87C84;
	Sun, 29 Oct 2023 05:28:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XkqPqy49";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91A4287C89; Sun, 29 Oct 2023 05:28:36 +0100 (CET)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9628087C73
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 05:28:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-586ad15f9aaso1727018eaf.2
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 21:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698553709; x=1699158509; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HQXSxe0w/Q5KtCBQUm29jEaHWmgM8B/W8Ktd/ORq+34=;
 b=XkqPqy49reu/FpbB7CoAT9kv6hd1LzHGWOFbG4VxiKEAzBAKsgdGdbQbA0lqQ4KPcf
 tKNgc7NM8+0jwFW9MUe46YQtQzrgMdNGMrD/CH4lVWMW4gGmPgZORrRNXUiru/r4lO5R
 /VTB4rA+wCGHHVLK1g4UwV50D/OkS2ieCKOis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698553709; x=1699158509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HQXSxe0w/Q5KtCBQUm29jEaHWmgM8B/W8Ktd/ORq+34=;
 b=aw8tcC9Hdw/Umoli7aLOKMwX8uziUKaDgf49Z3P4uynrSzD762v6odPWWycEcM7tck
 TE7zoNT4EE1HH+e987d9cBnS+i6oAkEDc3yBTstLudpAGmvpUIegKftT45tb9FFRtLnO
 PsWhjC4XV/oo1jOg59lvFXpd5IoAAThGEdFZFzzUi2JHhWt8NTtz3ePO+RugZB1Yq4Xw
 2WMB0VvdLaiy4RNUXwMuJlN7ZNdCuaw9gs/3U5JU/Ge3DmbXHGCkGerdMClUMadgGZBM
 0VD1o9FnbnozkUFu1Vs4/Ny3PlCBIHD2s7BhxiHI2hSD38goInmNQP+oVHxHf6exL9OL
 yzsQ==
X-Gm-Message-State: AOJu0YyPgrNQk8Jr/Phgwh9vErAPtEmtjDPU8BjZk4kXa9WCZnMS1bm0
 eMT3xsrtH9OrsOh/g4jLeOfpRj9ns2eKyuNmJ79Cfg==
X-Google-Smtp-Source: AGHT+IHM1ihaZL87KwDp1XUkGO9MJwaoPuSVF+1I4rTGIpvChh7UGFgJ9ZLDyZo1PDJVvKARTLTdsA==
X-Received: by 2002:a05:6358:71f:b0:168:e8a8:6760 with SMTP id
 e31-20020a056358071f00b00168e8a86760mr8815570rwj.6.1698553709337; 
 Sat, 28 Oct 2023 21:28:29 -0700 (PDT)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 s194-20020a6377cb000000b0058ac101ad83sm2920564pgc.33.2023.10.28.21.28.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 21:28:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 1/3] tpm: sandbox: Support self-test continue in emulator
Date: Sun, 29 Oct 2023 17:28:12 +1300
Message-ID: <20231029172813.1.I2fad865da519b36eb7d5879bb9ab552db8055e1f@changeid>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
In-Reply-To: <20231029042817.3938657-1-sjg@chromium.org>
References: <20231029042817.3938657-1-sjg@chromium.org>
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

Add support for the self-test continue command in the TPM v1.2 emulator,
to match the functionality in the TPM v2 emulator.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/tpm/tpm_tis_sandbox.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tpm/tpm_tis_sandbox.c b/drivers/tpm/tpm_tis_sandbox.c
index 7350e1c4d525..ca992eeb90f9 100644
--- a/drivers/tpm/tpm_tis_sandbox.c
+++ b/drivers/tpm/tpm_tis_sandbox.c
@@ -222,6 +222,7 @@ static int sandbox_tpm_xfer(struct udevice *dev, const uint8_t *sendbuf,
 	case 0x72: /* physical set deactivated */
 	case 0x99: /* startup */
 	case 0x50: /* self test full */
+	case 0x53: /* self test continue */
 	case 0x4000000a:  /* assert physical presence */
 		*recv_len = 12;
 		memset(recvbuf, '\0', *recv_len);
-- 
2.42.0.820.g83a721a137-goog

