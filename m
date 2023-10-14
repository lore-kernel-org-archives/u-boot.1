Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E975ECDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:09:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8302C86F20;
	Sun, 15 Oct 2023 08:33:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PPQJVCTu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8190D86EF2; Sun, 15 Oct 2023 08:30:49 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C21B86F11
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 08:29:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-66d264e67d8so10535536d6.1
 for <u-boot@lists.denx.de>; Sat, 14 Oct 2023 23:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697351357; x=1697956157; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9C6u71drnjJHR44OU1ghdmvknOKdd2zKnAtSq9Vd/go=;
 b=PPQJVCTupM/h7YDEBSCTeXPRTD4ZQKeKKZUoBe4MfWeJrdxX1XMY7mXuehK2fGFtEA
 902LF3trwW3NFgPdjvTTomnN3GcIkfpr51tiJXFrIvXAqKSccVwjue5UGCakpdD/4pD7
 sPxxD4YRfiepV8rZW+BVP76CWCTADkd0/AcM01K6ClfJAzKEEPvkGQjuQco8l71nCmnL
 fZ8qUZOXalICXS+wJgevmgNN5gaHd2UsQUvrtbZTjonwtYUaushA2fv+258QOU0G+oAZ
 naqPcEtreHiXE1pPNZ76ofURrrE7hHejMjaFZG1jmsO/pEc6Gi2ZQSw/mbMjIiDl9rKX
 xfHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697351357; x=1697956157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9C6u71drnjJHR44OU1ghdmvknOKdd2zKnAtSq9Vd/go=;
 b=k7HDbaza0JpTYf3QbzxZKmsgy2znPS/UNhoEGh0NLP+5y9TVwP4Qu6lEa3cPzDd815
 F+OCV109I/jstsO+z0j2B5Z3erIYWhfGBmS7PPASa1slnPAJfhqXrK3g1TLgzTW/Lqt/
 4Cq5b4FkURaC/1eXZZOleDvVhIEsvA5NJzQfTDEmPJZKsEd6xI7D1K0Dw8KfkDHG7x6r
 GL6LME3GDk5FPRYONy8hvAv1B+FHKdinOTeVKF9j3XKHArTWs/RxqZHlWaELMqih2YUk
 NICYy1yI+vAC9QKXH4HE6cchaMoQsW2J5alZH9rgdGxhGFQD+uQS3jINIQdg6KXerPS8
 auSg==
X-Gm-Message-State: AOJu0YxvxY1hW8TYKF5fLTaeq1BOyuAcuAAN69SibNjCb2MgzrfISkM2
 SSiRIs5hZNvoK24wLAyHCghuLr1cUnr5mA==
X-Google-Smtp-Source: AGHT+IFdnvZCn9yj86DoKYWFzXtqUD+T+Bzlt9UQSOlRQNNhuLe1kzMk32XyMU7cel+tjJnM6iIS+w==
X-Received: by 2002:a0c:cd0b:0:b0:66d:375:4b8d with SMTP id
 b11-20020a0ccd0b000000b0066d03754b8dmr10346519qvm.46.1697316505978; 
 Sat, 14 Oct 2023 13:48:25 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 bo15-20020a05621414af00b006624e9d51d9sm1950230qvb.76.2023.10.14.13.48.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Oct 2023 13:48:25 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v2 16/29] net: bootp: Move port numbers to header
Date: Sat, 14 Oct 2023 16:47:52 -0400
Message-Id: <20231014204805.439009-17-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231014204805.439009-1-seanga2@gmail.com>
References: <20231014204805.439009-1-seanga2@gmail.com>
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

These defines are useful when testing bootp.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---

(no changes since v1)

 net/bootp.c | 3 ---
 net/bootp.h | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bootp.c b/net/bootp.c
index 8b1a4ae2ef8..2053cce88c6 100644
--- a/net/bootp.c
+++ b/net/bootp.c
@@ -41,9 +41,6 @@
  */
 #define TIMEOUT_MS	((3 + (CONFIG_NET_RETRY_COUNT * 5)) * 1000)
 
-#define PORT_BOOTPS	67		/* BOOTP server UDP port */
-#define PORT_BOOTPC	68		/* BOOTP client UDP port */
-
 #ifndef CFG_DHCP_MIN_EXT_LEN		/* minimal length of extension list */
 #define CFG_DHCP_MIN_EXT_LEN 64
 #endif
diff --git a/net/bootp.h b/net/bootp.h
index 567340ec5d4..4e32b19d424 100644
--- a/net/bootp.h
+++ b/net/bootp.h
@@ -15,6 +15,9 @@
 
 /**********************************************************************/
 
+#define PORT_BOOTPS	67		/* BOOTP server UDP port */
+#define PORT_BOOTPC	68		/* BOOTP client UDP port */
+
 /*
  *	BOOTP header.
  */
-- 
2.37.1

