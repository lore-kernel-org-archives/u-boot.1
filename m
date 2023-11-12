Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF7A3C4167D
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 00:45:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DC7086FE9;
	Sun, 12 Nov 2023 01:44:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZdR36PCB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8173186EB8; Sun, 12 Nov 2023 01:44:08 +0100 (CET)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 240FB86F8D
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 01:43:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-35aa43c92daso4218605ab.1
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 16:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699749830; x=1700354630; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CxwcD5OjddJDKRwD870S6v3ThGy5mRtdHx1dCJUIYwk=;
 b=ZdR36PCBktkR//T7s3nIMJpisi3R7q9Jd8HR3t3HloJ1T9P18r3noKInctbbWf2Oz2
 EKENOPYL+vg9J2kwu6Y8n6KqyTx8Sgb7z8jnCXCV+RgEIE3SuIipJrDKgvwga4/J5zNH
 we0jNA1is1agNcf2TFl9bYUcAKJE33bI3iKTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699749830; x=1700354630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CxwcD5OjddJDKRwD870S6v3ThGy5mRtdHx1dCJUIYwk=;
 b=jA6GwIGhbHGkpJ5gNkUbCsrjDvRBngAG7jh8NWV4UD4Jg0y1/GtyhL3gK0fLBPVDPW
 vHYPKDV2sP2gVOOYwsxTCVpSet1DQUR6Wo+Ws4v4VazyBQvufY4aozSJAFgd0Ey1ua/I
 vUvDVnYXJK2mOLvsGnAqTMYdJR1z8IBJiyU5fgL/cEc4rsZujD9Goj5NMRMP+Ib6Irlt
 QkLAy19VgFS2FfJMRqY36qxFeCk3stY8eamhqJS6rW6mD1vWForMMj1I1T70ilcIQ9ea
 j6XP0lGdu09OuIiBpIAgz0peHN/R4JYwzWAcrghEwit+3cOFi9JveKN6KAOZqiPB1mM4
 X5Gg==
X-Gm-Message-State: AOJu0YwZPR8WnnPhzgACbw4Uz7OgLm9v4+tAHG0gswpO5F52ejXwrCuh
 1UFHrWjGv4VpTusm09LJ3fq8y9o4C4hyjNyhbF1AEg==
X-Google-Smtp-Source: AGHT+IGCrhSO4oG2v7NCv5SWI8HIiEvRP/qxVh0lIrlccO5wpUNTFBqACboV0TH2ODws93rsdiJb+g==
X-Received: by 2002:a05:6e02:1a63:b0:34f:f19f:2b35 with SMTP id
 w3-20020a056e021a6300b0034ff19f2b35mr2081778ilv.11.1699749829879; 
 Sat, 11 Nov 2023 16:43:49 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 k39-20020a056638372700b00457a6f281ddsm711388jav.59.2023.11.11.16.43.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 16:43:49 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 1/3] tpm: sandbox: Support self-test continue in emulator
Date: Sat, 11 Nov 2023 17:43:36 -0700
Message-ID: <20231111174337.v2.1.I2fad865da519b36eb7d5879bb9ab552db8055e1f@changeid>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231112004345.80145-1-sjg@chromium.org>
References: <20231112004345.80145-1-sjg@chromium.org>
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
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

(no changes since v1)

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
2.42.0.869.gea05f2083d-goog

