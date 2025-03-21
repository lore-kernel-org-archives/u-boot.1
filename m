Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 557F0C36002
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 12:42:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81385807D7;
	Fri, 21 Mar 2025 13:42:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wLuMcziI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45E8B8082A; Fri, 21 Mar 2025 13:42:38 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45E2A805C8
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 13:42:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43d04dc73b7so20249525e9.3
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 05:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742560955; x=1743165755; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Yexs34rw7J3UHqOi/mnaaCfOnnEs2lIC9xJL2HkfSoE=;
 b=wLuMcziIb0ZAA7IcYdKA7IsXFhJWPgjyReIPkfUR5mVoCznNxdbVCiDe+FGBLEEyg6
 OBdmsaNu614fWKeU79QqcdAhZA5dRjgOAL6hKE2SR6AfnLrh0dnFhQADmz16T6ztU/G+
 f/YWI7jpDN5xGSje4DLx/S8JVAovdv5jl9YMIDAFFIBL3woZ+7YpSCsoKCZC8DvXJ/Dx
 m7pxBa4WASnHvPZ9m1wPPimjxokwESiy6cldiRKZh4aUT9IOXx2XVSGs0K9PJ12JOX0+
 dbOYqPeUSM/xOzRLgXd3TjgOr7zkt040EUsyY0c8Jq0Wwo+tnK9FXJr9vwvFbhDPSA/o
 1U4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742560955; x=1743165755;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Yexs34rw7J3UHqOi/mnaaCfOnnEs2lIC9xJL2HkfSoE=;
 b=AH7G0Ok9/oftlNdidslTH6Cm8oFf7OlWSlmNbw/l/+ws6g85AL0KKIuucmsPPLOO2x
 JlqWiIw6YJpFCddcWy+/4VNUkucoqsoKNoX/Gl7VQBv5c2T8ErATxqXQWJOJ2K42MQJq
 Li5/e33ih3FaTLo5C3MI0PSlIqldRLzn7h2cCeroiWdEMwyT7GfywUL0Wam0a3MAraQ9
 LeCi1GZI4E2PTDtI9E6gPJSfYds6EQC10FqGv+5AwqUVhJjb/BS9qjJKKowxh6OzPUFp
 P/39FFI9GX6F46D1scJQ6Lzvc64YNnihWNNpVOnM8gNumSN9YIg0gMbSgtMnKx9rUUzK
 cMpw==
X-Gm-Message-State: AOJu0YzsVTL544jZGmFNH6lrDSOenyaNQO/Fne0Mr5PAWHJpAvS8PYdg
 TMF2PE/13IXLheFyJlCEaSFi+FEgSLtqct07yYWGXCTA5o2iwF/5o7jwo32JTphSN6AN7+vtH27
 Jfms=
X-Gm-Gg: ASbGncs2ZG5wBH9+6XS7yKNkhH7wwcNblbLyzwn9eC6OuOqz62EocZhomeQCFwIkFAD
 8oW7Lx8cx7qwzZ6toAlaLMildNmKKy0U1ghv3uqmxsV7Loh9vE5eaxCfFBUCHZQu01EZliQnUtc
 IlRGwcZXCnwcRY5dXi/+/gbMjWO9umEFrZjCFK2G4yoAwRCcj5nEARIPfYk5KiA1vhgLM4eN1K3
 B7FAURg/60xGZotuTZpBHHlEfZdEDHR29kPxSNvI3hxvVQ/v47bwcURKj2ecmmMkKP5OKVB0mTJ
 vakY2s35tDylqnjraDowzk89kR7tLOGfFlD/5xGvKkt9iWi9fGn4vvaC9hUd6OrU
X-Google-Smtp-Source: AGHT+IGmL7EhRvCdhwigHRESNHBkZIJUyvWafAcfwm94iRUEeDm9SYAONhU3FdmXQZMk84GDohut/w==
X-Received: by 2002:a05:600c:a00e:b0:43c:fdbe:43be with SMTP id
 5b1f17b1804b1-43d50a3a2cemr22300245e9.27.1742560955439; 
 Fri, 21 Mar 2025 05:42:35 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4fd9e960sm25773975e9.29.2025.03.21.05.42.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 05:42:35 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH] net: remove commented out line
Date: Fri, 21 Mar 2025 13:42:14 +0100
Message-ID: <20250321124216.1268147-1-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
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

Commit 1d5d292b7941 ("net: split net into net{,-common,-legacy,-lwip}")
inadvertendly left a commented out declaration for do_wget() in
net-common.h. Remove it.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 include/net-common.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/net-common.h b/include/net-common.h
index 29d31f37263..89679e20860 100644
--- a/include/net-common.h
+++ b/include/net-common.h
@@ -518,7 +518,6 @@ int wget_do_request(ulong dst_addr, char *uri);
  * Return:	true if uri is valid, false if uri is invalid
  */
 bool wget_validate_uri(char *uri);
-//int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[]);
 
 /**
  * enum wget_http_method - http method
-- 
2.43.0

