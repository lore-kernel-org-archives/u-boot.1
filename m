Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51BE6D26D67
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 15:57:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F2EA84206;
	Fri,  9 Jan 2026 16:57:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MtRbm0q0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C21F9841FF; Fri,  9 Jan 2026 16:57:03 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E937784206
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 16:56:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-430f5ecaa08so2139231f8f.3
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 07:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767974217; x=1768579017; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kRHcDJhjtYV0qP+YOlGCZ7puH6pSnVebJDXhFc5pybo=;
 b=MtRbm0q0GnJl+aAxY3Hu10VXrWB16hTu2AhMo3itzwgcEPbJJosRH57mqP1gzi04oo
 ZWsMRKBqYpQDmQL42BzOrH8x+KxAAbxpTYidFYM1wVs6kGrJ7Y5RXb9br0ozdIA2oeCs
 HbpwWE12xZ2oT0/Fq1/v6XWcNPIEH8VPjjNmHNywmmj77ElM/+K9w6KZPuS22fjp/zfu
 jKrWuW2BF4ksABahlq+iRr41cmHIAEEpZITCRvnVdFPW33Kvz3whs0AANYvmClLTOiA0
 w84bJRzpwXwp1nlSADZlUwsas9y8BtFQAUg3pideScQGOx6Uowf/I1uoIx0lxcTsjoXH
 N3cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767974217; x=1768579017;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kRHcDJhjtYV0qP+YOlGCZ7puH6pSnVebJDXhFc5pybo=;
 b=eDbVqcrGN+IGpjDk/+CmcdfVYBDfRDy+AYkmMtR2JyAZJGjpDQJ9QmRnWWwNSvA/z2
 inUodpN6tlDvoEcTFpjPaj4fYMGGeI2DKQvc1FBHxU4dzov19Jq/UZNrWP5vqT3NjNDS
 MTzzbiHXsYn/WiqPpKpfiy9oOtGE6fWUb2dDX3gYyFvGMDRw17zmmBhYEkV+HZ6XfH1n
 Z6vlNkA7ETlonVFOFhbn+jVhjtLdPGJU45G8inW7QgAHH2uCX4BDYKWfWnjkK6qjXhun
 CQ+K+M1G2J4HJi9JMXT2tS8XGnEHHH/Lzcd+7/Bpb3TMzvpRtRVRbK6Ytl9CucCbrIBs
 DwnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5wFTlBEzOWlrBe+X7gGQGo6POFMk3ac6/DyP8cyn59kwAi6Kv3puzeJZDfS9zB2XBZZUlnbM=@lists.denx.de
X-Gm-Message-State: AOJu0YyW/sIhaRygZoUxHVCAeOXMbB5W1ZMulvhcDjXktPMjm2WyqdnS
 eyssZbXPCojxq1WKsd26rwYxbJmaGqiObqq/gvg+KtPDzSrqw1ULbZ65m60vneZGhVM=
X-Gm-Gg: AY/fxX7cHd0mLhIjzsf1wzXs+Ab73/ldGs7yrhdkvjcH/aADP8g+smX2zJFBZAGrPRO
 Tf1EZm3pz9xJo5rBZ6i6c435fx8Ebhji6nq8d0oPge3j/r9oWOQBDkmrQtpQR7LXpU6J+1b3vwq
 aOpnDGk3bnhKANIsLEw4W0l2XTyimku5umXRGzKyY+NfZIh33YtxZF4bXTHAKExmz0e2A6Dqdix
 BMuhXqi63S/erZCndfDa1TSVIzDJWaZicht186ATPJWA66XniTFOfjP85E6PZja1DrCHfUwi/ls
 QtY2pCcuhzdd6hx9iY8bN+w9ecqEVGXxQjlNxZB3XfVRsUfg7Y03YBcTYQOA9jm0r0M1JSVQTw9
 YBp7CfZ2odO0fsFjCX1+Ftkc/ySBCiaObgKBPxT9FRM6szVlpTM9UI5iZA0visdlmxeUdj5OsmW
 n3tn8q2BYfJgW5M+nUELc6lbPx9pu+g5pbc92JtA==
X-Google-Smtp-Source: AGHT+IHKQ8WrWQVIRP10BOEP2xNTifUCQp/PDjkEmM/IHwpvN5ZmPWmH2bFYSiIVIdQ0xJgaweQwAg==
X-Received: by 2002:a05:6000:1862:b0:430:f58d:40da with SMTP id
 ffacd0b85a97d-432c3628038mr11548249f8f.10.1767974217331; 
 Fri, 09 Jan 2026 07:56:57 -0800 (PST)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:3801:fde:f3d6:453b:5d2d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df9c5sm23948635f8f.22.2026.01.09.07.56.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jan 2026 07:56:56 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Fri, 09 Jan 2026 15:56:55 +0000
Subject: [PATCH] net: lwip: tftp: Do not write past buffer end
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-tftp_fix-v1-1-64bd50abc72b@linaro.org>
X-B4-Tracking: v=1; b=H4sIAEYlYWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQwNL3ZK0koL4tMwKXePEJMukFDOzRLPEFCWg8oKiVKAw2Kjo2NpaALX
 yO35aAAAA
X-Change-ID: 20260109-tftp_fix-3ab9bd66a6ad
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome@forissier.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Michal Simek <michal.simek@amd.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.2
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

sprintf will add a trailing \0 so manually adding a trailing \0 will
result in an extra unaccounted for character being written. This
overwrote the first byte of the following allocation block resulting in
unexpected behaviour.

Fixes: 27d7ccda94fa ("net: lwip: tftp: add support of blksize option to client")

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 lib/lwip/lwip/src/apps/tftp/tftp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/lwip/lwip/src/apps/tftp/tftp.c b/lib/lwip/lwip/src/apps/tftp/tftp.c
index ecb6c55ae1100779187e7b138d098a0ef1e48ca1..25da952e92566cbca1c64bc89c89102e74d0a42c 100644
--- a/lib/lwip/lwip/src/apps/tftp/tftp.c
+++ b/lib/lwip/lwip/src/apps/tftp/tftp.c
@@ -191,7 +191,7 @@ send_request(const ip_addr_t *addr, u16_t port, u16_t opcode, const char* fname,
   MEMCPY(payload+2,              fname, fname_length);
   MEMCPY(payload+2+fname_length, mode,  mode_length);
   if (tftp_state.blksize)
-    sprintf(payload+2+fname_length+mode_length, "blksize%c%d%c", 0, tftp_state.blksize, 0);
+    sprintf(payload+2+fname_length+mode_length, "blksize%c%d", 0, tftp_state.blksize);
 
   tftp_state.wait_oack = true;
   ret = udp_sendto(tftp_state.upcb, p, addr, port);

---
base-commit: c05dba22f1f2b0b2655ee3971644acf1936cd07a
change-id: 20260109-tftp_fix-3ab9bd66a6ad

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

