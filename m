Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE9F0E784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:31:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14D76871B9;
	Mon,  2 Oct 2023 03:17:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="einh0d1D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A31968715A; Mon,  2 Oct 2023 03:17:16 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31A998715A
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:17:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-34deefc2016so49919465ab.2
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209367; x=1696814167; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M+XmaRqpHgye7n3Tnv0Yuxass1aeP6m7haqFeL6TSwQ=;
 b=einh0d1D19FLW1Af5x6xP7AFXPX+cyW7piN2e8cdb5mZ9sDiX12xXn6cdUz2iR0GiP
 h27SmOyTXNHaAv/VY3pfE38gF2f8cTVvWODYyihGnmqw7trB6U/9PI1/6o08rJaGcmDL
 ZZgOA3hyRtAOW8BLqu4bJp1JsNF9TdtWPyF9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209367; x=1696814167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M+XmaRqpHgye7n3Tnv0Yuxass1aeP6m7haqFeL6TSwQ=;
 b=vgA27KBHS0E2B37yiAcoITzTrxA59NstnQtcuacwqVAKA2yP67v5PsN9Yo8AOVgOkO
 KX6u44rvFRUdcWDt+x2Ij4BsB0bGBiVL4mEaPKuMn/TqWQP1/72Y+mCkgmL2IrfmlyNP
 S0oHa2zbr+SaxBOPmBd2YpgbPS2pGbV2lS/0JasFhXaIXKpx6euVueEm2Byezcyi0c89
 NrQA2TcwsQi1dm9xfqKjhJPWGpCYDkma7xv6g35tjvlnB0wmND/VPkdL37LmmGtFsR8a
 KgKr049JJDbIyhdfEFoqqqqdXSb2NrGW+S5una4sjdemWtur/TUNmttoHh0xJ9iA7aUV
 3ofw==
X-Gm-Message-State: AOJu0YzHFrGFVjikO3kqB0gADfpq71LpUSgnG07ECtyABqEazdIZrV3I
 LWFCEt0MuzPKXWwyqsD+sYgAwbFi11LSnYIGb3Q=
X-Google-Smtp-Source: AGHT+IGFW7YUotXkH1PLkclkEZmqNhDGhkzK4YrCXQEAqABjBWFrJpuf1zdhA7KmN28rUuu87yo3Aw==
X-Received: by 2002:a05:6e02:1ba9:b0:34a:c2e2:b2a7 with SMTP id
 n9-20020a056e021ba900b0034ac2e2b2a7mr12135413ili.25.1696209367308; 
 Sun, 01 Oct 2023 18:16:07 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 l26-20020a02a89a000000b0041d859c5721sm6819619jam.64.2023.10.01.18.16.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:16:06 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Brandon Maier <brandon.maier@collins.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 04/34] test: Make UT_LIB_ASN1 depend on sandbox
Date: Sun,  1 Oct 2023 19:15:14 -0600
Message-ID: <20231002011553.463514-5-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002011553.463514-1-sjg@chromium.org>
References: <20231002011553.463514-1-sjg@chromium.org>
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

This doesn't seem to work on a real board, so use the test on sandbox
only.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/test/Kconfig b/test/Kconfig
index 830245b6f9a9..69d63a5ff7dd 100644
--- a/test/Kconfig
+++ b/test/Kconfig
@@ -31,6 +31,7 @@ if UT_LIB
 
 config UT_LIB_ASN1
 	bool "Unit test for asn1 compiler and decoder function"
+	depends on SANDBOX
 	default y
 	imply ASYMMETRIC_KEY_TYPE
 	imply ASYMMETRIC_PUBLIC_KEY_SUBTYPE
-- 
2.42.0.582.g8ccd20d70d-goog

