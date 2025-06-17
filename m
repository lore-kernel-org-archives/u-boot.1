Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9CF8C71157
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 10:08:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A63AB82D59;
	Tue, 17 Jun 2025 12:07:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tbTzXsOk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6E8E82CD5; Tue, 17 Jun 2025 12:07:51 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E037A80C83
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 12:07:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a4fb9c2436so3231660f8f.1
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 03:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750154869; x=1750759669; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zw2o6MnolNwOFvuGvEw5Nc0YvBVz9NEXlG0S6QtGMrM=;
 b=tbTzXsOkit8y3pSth/W4OMrs/e/QcaYEA58ERsufHCH+i0QBFe8XjXFC0NpXjflIze
 2lB1Cthp4lUmtxet75gNYphgB27hLSZAxjvCCykmT3TjdFGNJaZcrQQN05dpjx0QHbCQ
 F9LJsROvY/hZkRT2atDj9l/n30LLVercc3MoOb3UHF1tw+7TjFrUs+UevrO1sTz+kYx2
 PtHWNh13+BMmCnlK8GbrBB9LWDIl4xSJMPuxm+rDOE+p76BeOOZMyz6JBnDevBK7zhKn
 Du4vDyYHsCVFzZUZapUEkopuuXuAPFYEQMuvZNkBC1pdtuxWAhpfViRP7X9CP7e4Y4AV
 /f0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750154869; x=1750759669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zw2o6MnolNwOFvuGvEw5Nc0YvBVz9NEXlG0S6QtGMrM=;
 b=sJuHUGCxvO2HfcYFEYv+imsNSxDc1wWyk0YQby7WryJkNnQZqf1BqwVTYz8JAzG4Fy
 j8xF/G0TK/2UgL7lRfWNDZ+U1IExv+jNRVpz7nvgMgpIU7rVinUaCBckhajr6z8A/Kib
 X2n4ogGfOJkJ55Hn7gb2wpRZhSK+9rxBGrWIJsRLVLGIIIijwHnnzvmHpVq65sCRQAvR
 e6GguFott7YG6/n5h0elvFemPSdzoJeraN4oi/I9PreQhyhTYLTRC6+YjHNHfB4hf0kK
 X+leLJr03Z6TfhArQ2dQX77WtXTSsMc9uM/5jO8Xhvury8l+XV4/FXfEZOVMPVAw2vPP
 h23Q==
X-Gm-Message-State: AOJu0YzS/RHKBmpLQdE6u7Om8oyN9/uEVQZguCTEQV7PcF7c1jXRBF1/
 b9fPO8o2qw03nMSJCOCwk8brttZ4UxyVusfyT3JKiQENOA2h/Zfmfn/75JI8F0J7xS+ISGV8Dih
 27uAL
X-Gm-Gg: ASbGnctCwnSnw2pDUbA3Xbl03qPNqErfB4L75pfoXmZyTwpo2eynt9ztN98W0V5LSpi
 JMG5CvKR0e/YJJA4Ui2ydImg8ph1PKE+/19tNODt3PlB04b+gMJRsT3Ki0uU7GvQrBlivbVt9ck
 F8YztWqQ2ebIFr7bH4djYWFf9zlFNqSSPrYDNeysiFI/V2ywKwMkTsjztgMnmIMpk/1yA4z/ebP
 iMWY99rKPhOoQ+PBqEEfwxYOSm7Ab+iVY8tT8L1+0gS9RTbRRpp7N/7pMkPpjl1vTDuZkrYPgD0
 lOqBxzfPtZcevCHYl0ZKJqf9pUGA5tfSWlEbNAdIoUUCsimOlUNv23fg29RyRM6EhUcroOE=
X-Google-Smtp-Source: AGHT+IFpHibFSjTPsCCpxsM4MKjYVZrrpQzi/ltC5a5KGi9YSZjSyzaWrMESslQUe2o91MQLK8atPA==
X-Received: by 2002:a05:6000:2184:b0:3a5:783f:5297 with SMTP id
 ffacd0b85a97d-3a5783f5770mr5786983f8f.35.1750154868966; 
 Tue, 17 Jun 2025 03:07:48 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:d4f5:465a:56e7:e545])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568b61071sm13582412f8f.90.2025.06.17.03.07.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 03:07:48 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 07/13] lwip: dns: do not print IP address when a variable
 is specified
Date: Tue, 17 Jun 2025 12:03:57 +0200
Message-ID: <20250617100720.2544758-8-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250617100720.2544758-1-jerome.forissier@linaro.org>
References: <20250617100720.2544758-1-jerome.forissier@linaro.org>
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

When calling "dns <hostname> <varname>", do not print out the IP address
of <hostname> onto the console. Print it only when no variable is
passed. The reason is to be able to call do_dns() from another command
in need of the DNS services without polluting the output.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

(no changes since v2)

Changes in v2:
- New patch

 cmd/lwip/dns.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/cmd/lwip/dns.c b/cmd/lwip/dns.c
index 4689ecce513..344f9a68bb9 100644
--- a/cmd/lwip/dns.c
+++ b/cmd/lwip/dns.c
@@ -42,8 +42,6 @@ static void dns_cb(const char *name, const ip_addr_t *ipaddr, void *arg)
 
 	if (dns_cb_arg->var)
 		env_set(dns_cb_arg->var, ipstr);
-
-	printf("%s\n", ipstr);
 }
 
 static int dns_loop(struct udevice *udev, const char *name, const char *var)
@@ -107,8 +105,11 @@ static int dns_loop(struct udevice *udev, const char *name, const char *var)
 
 	net_lwip_remove_netif(netif);
 
-	if (dns_cb_arg.done && dns_cb_arg.host_ipaddr.addr != 0)
+	if (dns_cb_arg.done && dns_cb_arg.host_ipaddr.addr != 0) {
+		if (!var)
+			printf("%s\n", ipaddr_ntoa(&ipaddr));
 		return CMD_RET_SUCCESS;
+	}
 
 	return CMD_RET_FAILURE;
 }
-- 
2.43.0

