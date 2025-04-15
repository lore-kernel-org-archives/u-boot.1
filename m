Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B6BC369B8
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 21:19:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BFA782BAB;
	Tue, 15 Apr 2025 23:18:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rvsEM+Ll";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8686E82B97; Tue, 15 Apr 2025 23:18:35 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7801682B45
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 23:18:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3912d2c89ecso5769613f8f.2
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 14:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744751912; x=1745356712; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tgM4cLiCJ9uzG8h9WiqEBy5itKu7ia2cOKYoWvK8MPE=;
 b=rvsEM+LlFrvH009YfF4BA8J1bcSL4QERq7yAckJo0zXjhBhaBpDu7sEPQgJvDt9LkB
 IqikjP4OlKWgeywi3F/V+iZBzgv9Q5MiDEOMpzY91ZcTFww21MKrmZ/csSu6/s8G0iJO
 H/lhuYXhZ3heGXqS+HM4MmoCtNvbvqjP+nS3l0CRswao+eNQW+0ErZADP/kFdqnRBWg+
 qhRvRGC6ukCjwWLMvj/bTBbYHLRRqM5DmtWa0trEaIvNZ6XHFd9Z/aaaPnvp92BzdUVs
 c7SrYfitcwvJ17SN+LUhzmixB2VFWHP8S4WFDJjaudp94pZRu5drVPxFO1ByonWhwWhR
 KoTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744751912; x=1745356712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tgM4cLiCJ9uzG8h9WiqEBy5itKu7ia2cOKYoWvK8MPE=;
 b=jcr7QswXKwnQ1N9S6DWKNTB4VQTMo6bYURd65ATAgdcuHVmFlR9SYwywxlbMNKkn1I
 oX6w90BwMC2p0Qxt07lb9gtFOqgmU9VPhGQ73r4+osFpVmsN91B6CjoPX3GZy4pf4HqM
 HHuq504GK+y6hTBWUksDQheXo8sN9Dt1l3foNsk/h5SnzCZ1yGouyxQ2lPyJ4ZoHjqoY
 GXJ7W1hZ/LodjFnPeTyFNCp9On5XK9dlIQtQjptHQCeEteMwW409pVUpTRXNsivNb9q1
 JLOyXPKpTboOu1k1wovcMOecHfTW99pEdOyhvbZ/RlFbt4hAmotYIIXgQc2Wkyl0bha2
 g9iQ==
X-Gm-Message-State: AOJu0YyXghasXDSOPduNzLhjsLK1ZJEKXuynVQToDYECdiYbrZrcZX0e
 71c+fgsEXtDdYu2K14QwxpEH2DagdPNwSdrn3smQ0lnV05rjcSGjITdYWqEH50bFAGjE2ZJqbag
 Mt0M=
X-Gm-Gg: ASbGnctVJWKaVVd8ILRi3YzblbVH9oo1HS6JGUut8OQkAYgvH8Z4Jjv5FJBbWYX7R2W
 0o7iH4VxHiTIWhwe4DGlaZMgf/+WbUwrqE640QyGW/FeVZabvk+OBuFUQFhxpclIz/rJouw/Txx
 iHgS8vK/Xq2eXuGgC1hJtdlVUB9NRG0KS3eqSc863NNoA8bb4WkdVoLllfc4Sxt2INsV9WKaczt
 nL4UMJtlPkNoU7vnAtV9Ksq/HnVqxUZDYM0tdCOXJnqO7lGYIusg3Ze7Ywb8VEAozsWLN2UOfRK
 NK2BDU65R1F1vUO0936kkynMWxVNwmVVoH7eS7uuJUx7f0YM/XgwlEhCli0=
X-Google-Smtp-Source: AGHT+IEZ02ru1NAJEr808TkCoip1oMzp33P29fYTuuWQ0yyl0NmiBcqmU685sG91ATOV6Dtn3T0wyA==
X-Received: by 2002:a05:6000:4a1a:b0:39c:1257:cd41 with SMTP id
 ffacd0b85a97d-39ee2777206mr619344f8f.59.1744751911799; 
 Tue, 15 Apr 2025 14:18:31 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6ebc:6ce:770e:95f9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eaf43cce3sm15530917f8f.74.2025.04.15.14.18.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 14:18:31 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 03/11] net: lwip: add restart support to ping
Date: Tue, 15 Apr 2025 23:17:38 +0200
Message-ID: <20250415211819.1254435-4-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415211819.1254435-1-jerome.forissier@linaro.org>
References: <20250415211819.1254435-1-jerome.forissier@linaro.org>
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

Use net_start_again() in do_ping() to determine if a failed ping should
be restarted on a different interface.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 net/lwip/ping.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/lwip/ping.c b/net/lwip/ping.c
index 542ef2cb148..d8042ceecf9 100644
--- a/net/lwip/ping.c
+++ b/net/lwip/ping.c
@@ -168,11 +168,13 @@ int do_ping(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	if (!ipaddr_aton(argv[1], &addr))
 		return CMD_RET_USAGE;
 
-	if (net_lwip_eth_start() < 0)
-		return CMD_RET_FAILURE;
-
-	if (ping_loop(eth_get_dev(), &addr) < 0)
-		return CMD_RET_FAILURE;
+restart:
+	if (net_lwip_eth_start() < 0 || ping_loop(eth_get_dev(), &addr) < 0) {
+		if (net_start_again() == 0)
+			goto restart;
+		else
+			return CMD_RET_FAILURE;
+	}
 
 	return CMD_RET_SUCCESS;
 }
-- 
2.43.0

