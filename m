Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73F5ECA0EC5
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 10:19:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0804D88B1F;
	Fri, 30 Aug 2024 12:17:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jS+k2TB3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECEEE889C9; Fri, 30 Aug 2024 12:17:37 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 118CE88A24
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 12:17:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42bb9d719d4so7907275e9.3
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 03:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725013055; x=1725617855; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DITMuE/k45R030RiiaTVcnF7dWYla7fjDZtjbbdVJAY=;
 b=jS+k2TB3Sc3HRSJd+4prIHEcZXE0a4h4Jc2fMg7XQbk+oH0ZH7r7q/fiSawNFODU2i
 bBLE5grpwQ0Fr7HQIigPcSHy2Fq2whfefCNBtl5hzykbWxx77Em7SqtRLrk3fC3I377J
 mO4E2o98KOxv/evgtFfyMJ6vSxbv+a3WcdDQEuAs+2/E96JPpRGxkChL58TlxYyiL9FV
 QLrh6pxzfvHNDl/6DGkk7CeE539gQM74LVEBYRUKnRPwvEjhexDO0dlGZLuHy94mqTNk
 GiTwMyKSNr5XDUGg9G1jNil7BJWg+YzF9VXO79VBJ9WaQno5vup+qnJfB6l/jaRFagUS
 nFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725013055; x=1725617855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DITMuE/k45R030RiiaTVcnF7dWYla7fjDZtjbbdVJAY=;
 b=s+jAwvDsmLTLvyL3bjOshr2OTzSxOCMHvVWJaLzbN3dMtCCmmBMFoFKWKRBuwz9cke
 aQtXfd5gHoKvZ+SK/nvuVxlsKevLuqIfrhhpvpoLlfzYCBSv0VGigjFunDwaGlsMpIv0
 Eh3fz0D0qomkh09JjZ2HBzzrzO1vqPR9iqy9nTarUjDQeyIVJvnTv2c9DOsYuYMzt+vc
 EYRdtL7jvkHeYTWfLKFRKni6PSFhvEp3s6vG3LHHJZMmmBt7XfBPcnwleIfPn3eRtAzo
 Qu9zR/oiz3GfRzfugNbFtaV5uHvD78jq0dNCGl5+/qT6UtdFZ2E57QwqauZ4FrHoalcT
 LDsQ==
X-Gm-Message-State: AOJu0YyIqUJfZzbI7IaVYBldLHyuGwNOQ0FEs1cDnU9QoaMzoeptrImG
 uSOQBHzRdFhRrs+23M8YK1a3rm54KcpMmTqG8l1v/VfTYeAUQ1PWswqp7/tyPSAHoSu436hswCI
 VD5Cwvbt7
X-Google-Smtp-Source: AGHT+IHY6YztN3fsusJFfnf45mNdQyoM1kmDbYxck+QFngGUIM9/q404+9D6hjvjqDrn4DHzXsJ14A==
X-Received: by 2002:adf:a39b:0:b0:367:8f29:f7b6 with SMTP id
 ffacd0b85a97d-3749b585113mr3885479f8f.51.1725013055203; 
 Fri, 30 Aug 2024 03:17:35 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374b6a3d27fsm472728f8f.59.2024.08.30.03.17.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 03:17:34 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Fabio Estevam <festevam@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Ye Li <ye.li@nxp.com>
Subject: [PATCH v2 11/16] net: fec_mxc_init(): do not ignore return status of
 fec_open()
Date: Fri, 30 Aug 2024 12:16:54 +0200
Message-Id: <cc150b05d04f911f6715ad30efe7bca6127c3910.1725012294.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1725012294.git.jerome.forissier@linaro.org>
References: <cover.1725012294.git.jerome.forissier@linaro.org>
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

The fec_mxc_init() function currently always returns 0. This does not
allow the callers to detect when for instance the PHY initialization
failed due to the port being unconnected. Fix that by returning the
status of fec_open().

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 drivers/net/fec_mxc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/fec_mxc.c b/drivers/net/fec_mxc.c
index 0a0d92bc2c..2dc1364bee 100644
--- a/drivers/net/fec_mxc.c
+++ b/drivers/net/fec_mxc.c
@@ -615,8 +615,7 @@ static int fecmxc_init(struct udevice *dev)
 	if (fec->xcv_type != SEVENWIRE)
 		miiphy_restart_aneg(dev);
 #endif
-	fec_open(dev);
-	return 0;
+	return fec_open(dev);
 }
 
 /**
-- 
2.40.1

