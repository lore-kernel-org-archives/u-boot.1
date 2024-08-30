Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 098FDCA0EFB
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 10:20:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6841988B61;
	Fri, 30 Aug 2024 12:17:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dHkYpQxI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59DF5886E5; Fri, 30 Aug 2024 12:17:42 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B8198817C
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 12:17:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-428e1915e18so13773315e9.1
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 03:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725013060; x=1725617860; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rOUr1jJ+j6ojrKOGYMMp1I08UMtj5w8Ma+X7l6RjDsQ=;
 b=dHkYpQxIYXSOEYKVJfIC5bUov1NfyCTc0E1g1BLCU2YZaBKNBUeZQbtLMoJ39Mg03k
 dnb7oDIqE3L7lMQxQVoxUpMLzpNIueLsGAaVm3Iqyoadrws4LFnYjcHzUf8GbwuE0dQ7
 kohrPHi/x5BaQCENuJ4fOp2Ub8/oxw/YXwqN2n6580VQqcs8bocIZ2af1u+do8GiLrgz
 Y+yUKVgHu4OXhGO+o1BlEdduauDbKoZWUUTnxFdqJ3vZytbLpZmz/lDXHHPwAtK3sh2G
 dTEc3HZumGU2aBlEm/yuyEm67DifHjPLh/8MxdqRNpJ49kr30uy8wjRhcNcGHwQq2Lsc
 pkLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725013060; x=1725617860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rOUr1jJ+j6ojrKOGYMMp1I08UMtj5w8Ma+X7l6RjDsQ=;
 b=PPwB9q+QHgakzPfkoCMa2Zx+IvPuNLB9hAAk2zRcee4sRwtm7UBlhUDN3pmuhPQJiW
 C+DxhKk3Qq8tjAt6Dzrp93Ort2Cxb7Eh/8aFOKepmU6vwZoGm85D10dMXOfPziPkPzFh
 lyx2nCE9+e5jRHZ2y0fogGdGMfO6yykZL0c/H9cC0aVMMCmGwPmEKSxikX2/x4n48dJP
 Imp7zKwrNh41jfiOB0SXxKvhN9+wvnrV/1EM9MVJGU/17DE/88aiiozDeeUcusTNO3Rs
 dWJ3HBa85ZR/bpmpuySYrGHl/FW9kkqgW+4Do3aXTuJtXutZUnpiBqk/bYtHCYZRthU+
 sZlQ==
X-Gm-Message-State: AOJu0Yy20jdt3RKH18zOjk7RF9YCNzB2m0pDpreQ9k+5iD4dfLYIt3aE
 DkwnWA8hiW5kNLGiJmLWIHUhwCqTCsdQCCQq0ml/UM/2mxMD3dGWfdEzoO/c560YLb3pj8pMyj6
 qnfFwC973
X-Google-Smtp-Source: AGHT+IFqmEqpnvUsHEWovOi3361uz63mM2qIo4tJPWFxz7PDVudrF7blg1Hd7M21jme76Tx0qA6h+Q==
X-Received: by 2002:a5d:4b46:0:b0:366:f8e7:d898 with SMTP id
 ffacd0b85a97d-3749b58e7a1mr3547129f8f.50.1725013059727; 
 Fri, 30 Aug 2024 03:17:39 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374b6a3d27fsm472728f8f.59.2024.08.30.03.17.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 03:17:39 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Devarsh Thakkar <devarsht@ti.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v2 15/16] common: update: UPDATE_COMMON implies CMD_TFTPBOOT
Date: Fri, 30 Aug 2024 12:16:58 +0200
Message-Id: <ba3bd0c9116b3338e4d08f4c2caebf5818c0d94e.1725012294.git.jerome.forissier@linaro.org>
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

common/update.c (UPDATE_COMMON) depends on tftp_timeout_ms which is
defined in cmd/tftp.c (CMD_TFTPBOOT). Therefore add the appropriate
imply statement to Kconfig.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 common/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/Kconfig b/common/Kconfig
index 83c81edac2..968d4fb66a 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -934,6 +934,7 @@ menu "Update support"
 config UPDATE_COMMON
 	bool
 	select DFU_WRITE_ALT
+	imply CMD_TFTPBOOT
 
 config UPDATE_TFTP
 	bool "Auto-update using fitImage via TFTP"
-- 
2.40.1

