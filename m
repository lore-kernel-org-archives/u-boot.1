Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 721D1E77170
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 02:40:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54E4C89752;
	Fri,  6 Dec 2024 03:37:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Zq9Kc+UX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F08E4896BB; Fri,  6 Dec 2024 03:37:49 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BECBF8918C
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 03:37:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-841a7ae8d8aso107762239f.1
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 18:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733452665; x=1734057465; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=95iUHcKaIvde41hMaQPreEKC3EfpLOe5YPuaL6m3KN8=;
 b=Zq9Kc+UXpHTf051Ez69+E1av+9ACNbLhcFux6YLnVxYPIBe3aD/0QlHsFchqSJZeFY
 45hXcB6+MaOI0XsHuLPGk92tByvyJfsOvys3FdXnC9iUR8WhhZmmKUeXQimvcUaIMg6D
 p6wa57+jPH/Kmn9ScJAgPDXJ3uUZmw5nxmquM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733452665; x=1734057465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=95iUHcKaIvde41hMaQPreEKC3EfpLOe5YPuaL6m3KN8=;
 b=EDLWAsyZEyIq/BdhnHHDD04YSjcHHe/jnNJjapzJVd4d5wkQble6FR3CM+OqAvfj6O
 7jk342vdNrYLk5g8AapJcFAwcUJgDPAjccIYwVoc6KL4COO1if8HiRkipQQkO3cYTlqx
 9rDRtBY8rikb2rvHSBQzP39bdRrTqwj7wK/fW7yRLfmHi07rKtPGQYLOdZJ4Ogr9lpXP
 p5rB59OV/ewWTawav8Bw5midxGGDdTippIsic6pAAdGTnxXv9AfITc5+E/6rUzFRkSYh
 b1e96DHjOinc5AtdE/YIpiyZlCUu9vy/vCIjZN8CfbZJVufqeaagE3ESnxexalNO6g/1
 JT0w==
X-Gm-Message-State: AOJu0YzmUs/G8iD4aWQSKy6gEIYLRxnpk/BZ4rjkJVRXy3dHCy918d/a
 PsL5hIhtXtcO/WXnAm2eXOLdXPUDwQOnVIbTrwT+ynVJVZVSlWCv60Vj699Rf5hm6qbhn9gmA/c
 =
X-Gm-Gg: ASbGncs6kZgPra137VKL0xCYdpWZe3dayjqRQVbLrMR6zdPTQxSk94bCu6ZVR9LXGAI
 A80LkDifU1YardHKwrN3cDKYntfqxu6zhITeld7ZiwtbjB3GbViuFeD1pMhcmwytlypG1AJ0mKC
 GevldNj45UOYQXtcAoO8ZT/t85eYFbn4PhXAp16+3NB55bmgyHgLpqd8UyFVEwYLIvHgbtNvGNS
 YEVv4g+jFrBwNT3KJldL8lNHhtiqq2GBf9eQQUWtGytJhqsRBN+rcHWVU2M7Xvaez8TDUIY0yVj
 8JSzQEIcd3o=
X-Google-Smtp-Source: AGHT+IG6MIXUGvnTPH3czKn+liJDNMEfNyGL7vMVl8Qr/nIDTEFK7akfnOsUzxZQ/ey9YGbw+QwOwg==
X-Received: by 2002:a05:6602:1509:b0:843:e11e:e7e1 with SMTP id
 ca18e2360f4ac-8447e2c393amr269206539f.14.1733452665655; 
 Thu, 05 Dec 2024 18:37:45 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861f51bfsm575506173.112.2024.12.05.18.37.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 18:37:44 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v3 28/46] net: Drop #ifdef in parse_args()
Date: Thu,  5 Dec 2024 19:36:07 -0700
Message-Id: <20241206023626.2456858-29-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206023626.2456858-1-sjg@chromium.org>
References: <20241206023626.2456858-1-sjg@chromium.org>
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

Use IS_ENABLED() to avoid an extra build path.

Signed-off-by: Simon Glass <sjg@chromium.org>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

(no changes since v1)

 cmd/net.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/cmd/net.c b/cmd/net.c
index f980448e0ef..6d1c6374f76 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -368,13 +368,13 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[],
 		}
 		break;
 
-#ifdef CONFIG_CMD_TFTPPUT
 	case 4:
-		if (parse_addr_size(argv, addrp, sizep))
-			return 1;
-		*fnamep = argv[3];
-		break;
-#endif
+		if (IS_ENABLED(CONFIG_CMD_TFTPPUT)) {
+			if (parse_addr_size(argv, addrp, sizep))
+				return 1;
+			*fnamep = argv[3];
+			break;
+		}
 	default:
 		return 1;
 	}
-- 
2.34.1

