Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC128C369DC
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 01:07:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EEAF80FDA;
	Thu,  1 May 2025 03:06:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KJeroA05";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA97380FDA; Thu,  1 May 2025 03:06:06 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70ED08283E
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 03:06:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3d965c64d53so1878405ab.1
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 18:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746061562; x=1746666362; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p2u37CRncHqP46ha1dXdu0D1wYo2iqF6MLQq2+qs2L4=;
 b=KJeroA054O/0F3TI8Hfism2PEZj4d4w9lSsRaLGtsLoBu/ioZN1xW2HYip3y4YYmer
 Opj0HY0n97kDmM5GBIY3GAw7AF1jatxKBsQJcSPU/mJhTG46G+LdffMIiaKx14TTHO6/
 KREkkfD22G/AMw7+DZjhvbjPKbtlyyu9uG5U8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746061562; x=1746666362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p2u37CRncHqP46ha1dXdu0D1wYo2iqF6MLQq2+qs2L4=;
 b=R1eUbs0r+EZsEr8Le1O1Xy8cukSQSRp+RuZQSQTg53S7q2mcDsLn6Pm4c/aVs8bBSf
 gAZR3Rt/gakBM84NdZdfmGP9Qeg5UVW64l3UInsoy6CgzVUeVv0dAT5VQngRdBOboyvA
 YZ77BDZanm4vDyxPzB88/CaRRf+A7MjRfPr41pD1UvPEZjhOrFILAFvtEYiQb0Gl/rT0
 VFHrxS2CyRWhe6pOtsGf4NYIhTjMSYJjO6EwgSRd7zn5aDIiAiVPTwiaPPC1ZlL5wsLq
 j7Jf0iHTrH4SeabHeOHOOO8ufqMQ+SGS4UDEoBHXMBdXqr1dPtMDJn7Ys4GRd0h2xqWb
 4Y6w==
X-Gm-Message-State: AOJu0Yxb9iFMBpo6nPGlaeYjDKigspoM7HANC06FGQpMkjE1mpdz5s15
 ydDLO9n3fk1DdaXjOg/9AxEp6wKjPagHhBK5J1Tb9gda+zhFwGTdVuAe8wuI30YJQN5a66N9dVk
 =
X-Gm-Gg: ASbGncsjpEjhuokOe18J8LkieZ+BSNB+HRhht5BavCBe49IFc9rMSmoGMGfh/mbdvZM
 qKirHnMKjJqtiFz9BEJV9+xfY86MEZAgwmenc/wPU6/SuDX63IpzfaY2Fa5X/CMAbNKlU9gH46X
 1LSdX9ESK3qG+QegN/XwcNxIghMXsxSoqSutZ3VrY1KtByLtTriggnsrIvsci41yZfuxvUUsq/m
 VetJxixLCKQ3lYF9tkz4wxugTwP086DJ3wKmmE7JWpvZKApCB8JnblajrTWZc9FvqZYypJlpTJw
 iMzER7Hy9mVYYkP42JYugQp7St3XTl8bnCkzBe9XRAPtJyg6dI94KXrz0uMxXHSEWUfdHYFRh20
 tmg==
X-Google-Smtp-Source: AGHT+IHM+lLNIDdzdXjkaJJmrZwf4bGP72hEymvV6l2L8ckUsy6pPnD3KxXRJNJ+sIbqK0Y7d21TKA==
X-Received: by 2002:a05:6e02:3002:b0:3d3:dd32:73d5 with SMTP id
 e9e14a558f8ab-3d9701a4ba8mr8867375ab.4.1746061562663; 
 Wed, 30 Apr 2025 18:06:02 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d95f480a99sm10771855ab.68.2025.04.30.18.06.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 18:06:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Daniel Palmer <daniel@0x0f.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 17/22] elf: Only use network environment-variables if net
 enabled
Date: Wed, 30 Apr 2025 19:04:42 -0600
Message-ID: <20250501010456.3930701-18-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501010456.3930701-1-sjg@chromium.org>
References: <20250501010456.3930701-1-sjg@chromium.org>
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

If there is no network support it doesn't make sense to try to read
these variables. Add a condition to handle this.

This is needed so that env_get_ip() is not called when it is no-longer
a static inline, but included in net/ code.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/elf.c | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/cmd/elf.c b/cmd/elf.c
index 6b49c613703..c94125dc4a9 100644
--- a/cmd/elf.c
+++ b/cmd/elf.c
@@ -242,30 +242,33 @@ int do_bootvx(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		 * The following parameters are only needed if 'bootdev'
 		 * is an ethernet device, otherwise they are optional.
 		 */
-		tmp = env_get("ipaddr");
-		if (tmp) {
-			ptr += sprintf(build_buf + ptr, "e=%s", tmp);
-			tmp = env_get("netmask");
+		if (IS_ENABLED(CONFIG_NET) || IS_ENABLED(CONFIG_NET_LWIP)) {
+			tmp = env_get("ipaddr");
 			if (tmp) {
-				u32 mask = env_get_ip("netmask").s_addr;
-				ptr += sprintf(build_buf + ptr,
-					       ":%08x ", ntohl(mask));
-			} else {
-				ptr += sprintf(build_buf + ptr, " ");
+				ptr += sprintf(build_buf + ptr, "e=%s", tmp);
+				tmp = env_get("netmask");
+				if (tmp) {
+					u32 mask = env_get_ip("netmask").s_addr;
+
+					ptr += sprintf(build_buf + ptr,
+						       ":%08x ", ntohl(mask));
+				} else {
+					ptr += sprintf(build_buf + ptr, " ");
+				}
 			}
-		}
 
-		tmp = env_get("serverip");
-		if (tmp)
-			ptr += sprintf(build_buf + ptr, "h=%s ", tmp);
+			tmp = env_get("serverip");
+			if (tmp)
+				ptr += sprintf(build_buf + ptr, "h=%s ", tmp);
 
-		tmp = env_get("gatewayip");
-		if (tmp)
-			ptr += sprintf(build_buf + ptr, "g=%s ", tmp);
+			tmp = env_get("gatewayip");
+			if (tmp)
+				ptr += sprintf(build_buf + ptr, "g=%s ", tmp);
 
-		tmp = env_get("hostname");
-		if (tmp)
-			ptr += sprintf(build_buf + ptr, "tn=%s ", tmp);
+			tmp = env_get("hostname");
+			if (tmp)
+				ptr += sprintf(build_buf + ptr, "tn=%s ", tmp);
+		}
 
 		tmp = env_get("othbootargs");
 		if (tmp) {
-- 
2.43.0

