Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61EBAC52D7C
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 13:50:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7669A8890A;
	Fri, 23 Aug 2024 15:49:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="w0nXjwsC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86C6E88A39; Fri, 23 Aug 2024 15:49:19 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CE9A88A10
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 15:49:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-37196786139so1034916f8f.2
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 06:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724420957; x=1725025757; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RYA9NeMGf/EOsm4I8RC0qHiTNbH71LXUaESIJufafA0=;
 b=w0nXjwsCQSJVbMtPrM3+lmhuDgvSCDtwG2l3wvAFzXoY3Y5YlByirnQSGx8Dd59AQ6
 0tIo3jSoNoZpbSAnhkG0XT+P5dGcnfJOU30pcEbPBGJHpT/+ssnwAy4+QTd+x0ZrlgOI
 2gENZA159P0wBLZqb2qTuuWVBI1wE44FS/NFzFmFVFWzljcXUMAwmgvVtvAXaEPmSHjD
 4zLmLs8aLZZYQj6Y6g0URdGipVK4ZYQxX1x9QHTlrgWYUV23qjJvweOvfDIApWrsXlg/
 gTBYJArgp3YaocFjTudMbBoWTP+CeJ5Zjws6ZpsTba3Gx4i7LWlvN9mJBW0U/A5DCBeE
 oeMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724420957; x=1725025757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RYA9NeMGf/EOsm4I8RC0qHiTNbH71LXUaESIJufafA0=;
 b=cVUbnLan2cFMhGzrNz49gkVmxUwIVKZHWiFnLYggXXfzlIiTrJCrLs4auHmTn7nwSu
 DszkNHV1Tdjsvd8CVr5Hm/YbSe6PYhVOF/Ol3mmRaR1617NI1wdpcQVcCIje0nLFUSHj
 uf2HLRrcjc6HKF7qAoy2/Gqrql6AlTOMI+9g9Z5z9eq1iK5TpmCyxYkJNWr9MeINbU5C
 UDrqFmmpEnkG0YRUwv72cVAUTPv3ubAl43WKc+gTssI40VaJCRpZJl/0CCG67a7sfiyS
 8Kr2uJfPTfybE4J524ojxZm/gXAe2+ZP7PIPpZxjOLgQDb7A09kYxIRHCmwLZsGVZ2IE
 FtYQ==
X-Gm-Message-State: AOJu0YxgYKsz4sWDoxuxGjn5p1LdEa+pp2Ptz1IsfRBjII3UnqjlGjGu
 1JfCq+xYcKx91cvG2hwTHQOBVmRpWrjc1RN0JAeQS1IP6CwsgK5mCNXEBwyNw/KzuXCHoIx+ppJ
 HKDu1v80S
X-Google-Smtp-Source: AGHT+IGN+5bfx2x6VvmvLfFRu2MoVfK6yjr+LCsfiFmlIKs7XZoE//rcbJOZY6HVKBaOSCCRM07+bw==
X-Received: by 2002:adf:ed08:0:b0:371:8c19:f5e6 with SMTP id
 ffacd0b85a97d-373118e3475mr1504548f8f.40.1724420956703; 
 Fri, 23 Aug 2024 06:49:16 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:e668:dc94:35c7:8064])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-373081ffb40sm4201665f8f.76.2024.08.23.06.49.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 06:49:16 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Simon Glass <sjg@chromium.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>,
 Richard Weinberger <richard@nod.at>, Marek Vasut <marex@denx.de>
Subject: [PATCH v9 06/37] net: wget: removed unused function wget_success()
Date: Fri, 23 Aug 2024 15:48:10 +0200
Message-Id: <d871702b334917b56a9778a88b3e1c0b156c33ea.1724419624.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1724419624.git.jerome.forissier@linaro.org>
References: <cover.1724419624.git.jerome.forissier@linaro.org>
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

wget_success() is used nowhere so remove it.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 net/wget.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/net/wget.c b/net/wget.c
index f1dd7abeff6..0e4dc5159d0 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -199,13 +199,6 @@ void wget_fail(char *error_message, unsigned int tcp_seq_num,
 	wget_send(action, tcp_seq_num, tcp_ack_num, 0);
 }
 
-void wget_success(u8 action, unsigned int tcp_seq_num,
-		  unsigned int tcp_ack_num, int len, int packets)
-{
-	printf("Packets received %d, Transfer Successful\n", packets);
-	wget_send(action, tcp_seq_num, tcp_ack_num, len);
-}
-
 /*
  * Interfaces of U-BOOT
  */
-- 
2.40.1

