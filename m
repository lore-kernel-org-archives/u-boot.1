Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3561FC77B7C
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 10:00:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DADA82103;
	Thu,  3 Jul 2025 12:00:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vA+gq6Mi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A2CF822D7; Thu,  3 Jul 2025 12:00:39 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C8C580E9A
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 12:00:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-450cfb79177so47176285e9.0
 for <u-boot@lists.denx.de>; Thu, 03 Jul 2025 03:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751536837; x=1752141637; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sDwEdSziR+EcKjXaEbigfk+5lSFsvtsnjkONJKy0p7k=;
 b=vA+gq6Mi20aicluiWBpA+ber5s/m98hNxDMbbuPsTpKT3SkPlf0ceVFRqyEat2J0gj
 KPDbey1RT5JTlq18d/yOsWWJmmuUMckMRRGFOGqeI1nS246yLbshVrg3QvkVGXUWIiDW
 V8FXoHOCpZNQlE+8EMsvgZAVjp5yi09VA0KFVU3g1twFajj72AIWl0GnEmA5NShPvbi3
 vPEP0mSftljeAdFObXZwfEYI1GIBdJNyWaJdjRHeV6B7PSjwrkdgmcIQQvtZC8oH20fm
 083Rhb2GHgPsbn2TpYBc00bVsQvjdEEf8GSiqgm/AznEUOl3YM0+nalSxkJTqGDuCaF1
 lwiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751536837; x=1752141637;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sDwEdSziR+EcKjXaEbigfk+5lSFsvtsnjkONJKy0p7k=;
 b=sh1yUQUzcWQu78L1OQ4QezLAjleJNFbUTmxn5UDo7pZeO3iktH4P+NBznY35JDsasG
 Xh3flP3tidiqJNASyTBIqszZ3MWmzBVtQHCIBFbb0WIoa19d7wX8TUPJUB8V4hdsf37Y
 w3plMDYzApHwjlhh+4GvXr8s4BnGuoZNy/b6KPHMZhS7UDT2pENBJif3OuhF0ffTIzXR
 wz6ZJYb1dWGhFzLbgOIwObjhEijrnEJJKnPouMEVyiQ9EGVTLYfVOO3pSZNAr3+rXQdW
 GhjeCbAOUIDDsrWwT2DxhmcMgFE2dJYmBvrr0itIqZKZt+EDu+Vdqwqyay53XXdft19Y
 xdlQ==
X-Gm-Message-State: AOJu0YzZVrCq9nkxkFKun5YJ90SAsdB5wjLLZaZDmaszDmeOy1Z3JsGm
 ZxOhM5K7R5aFjWicEdF/Zaa+p3l9XzotqP+KLHkE9OYRlTNoH2IcmFvmfaqD8qNTvO8=
X-Gm-Gg: ASbGncuGFh2fnmpSsS3T5GHBItlfnKZ61GimUG9mAC0H4yiEGCP0p2sieCQSYKr7IPK
 bBzLmmjFFV6IWf/IKd29aD2LbYYoOUo5UxuZG7LThqdkQAJeML2XH0Nzzsqlp3j8RJyqApFhxL2
 flBMD+8h8sY6DJtXJGiyuC/8NR84aYtLZhj/2vbblDP8sqVPUf3xg4J6JxQpZkijW0GQPpRxhRH
 LA5sLVTRF1wtXnbs4o0LSxuRiGAYbJmplMCp0DhDpWQJTVYqEkBVNs6UYjjaVTIQvWSixLllOqW
 TMXJPSVSH5OxYqIPBkO6zMmlDlvk1D2woQdiTkRk+KjX0uNIwVgh9gPS/CFlM/c4Qk3jjIWFHrW
 jG5R27gWVFOBW
X-Google-Smtp-Source: AGHT+IEZrlNPR/tDKv6HfSxYw0BVBzN0xrURVEEqlCEnZYGN0OJoJLoKEJp6wTmnvRdNI5lr0rMvVg==
X-Received: by 2002:a05:600c:1c83:b0:43c:f513:958a with SMTP id
 5b1f17b1804b1-454acf5e6a5mr17056625e9.13.1751536836422; 
 Thu, 03 Jul 2025 03:00:36 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:e07:801:b5c8:44f:55cc:3182])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a997e24bsm22099445e9.16.2025.07.03.03.00.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jul 2025 03:00:35 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Thu, 03 Jul 2025 11:00:33 +0100
Subject: [PATCH] cros_ec: sandbox: Use correct value for number of slots
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-cros_ec_sandbox_fix-v1-1-04ac442b8f69@linaro.org>
X-B4-Tracking: v=1; b=H4sIAMBUZmgC/x2N0QqDMAxFf0XyvELtHMJ+ZYySNlHzYDuSIYL47
 6t7PJx7uAcYq7DBsztAeROTWhr0tw7ygmVmJ9QYgg8PP/q7y1otco6GhVLd4yS7G4aJApPvmUZ
 oZUJjlxRLXq52RfuyXuKj3Pb/u9f7PH9gaDEvfgAAAA==
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

In the definition of struct ec_state the number of slots that are
created is VSTORE_SLOT_COUNT (==4) but the value of req->slot is
checked against EC_VSTORE_SLOT_MAX (==32) so this can lead to memory
access beyond that allocated.
Instead change the size check to use VSTORE_SLOT_COUNT to ensure it
matches what has actually been allocated.

This issue found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/misc/cros_ec_sandbox.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/cros_ec_sandbox.c b/drivers/misc/cros_ec_sandbox.c
index 3ac690a3733..432b1fbb0c4 100644
--- a/drivers/misc/cros_ec_sandbox.c
+++ b/drivers/misc/cros_ec_sandbox.c
@@ -540,7 +540,7 @@ static int process_cmd(struct ec_state *ec,
 		const struct ec_params_vstore_write *req = req_data;
 		struct vstore_slot *slot;
 
-		if (req->slot >= EC_VSTORE_SLOT_MAX)
+		if (req->slot >= VSTORE_SLOT_COUNT)
 			return -EINVAL;
 		slot = &ec->slot[req->slot];
 		slot->locked = true;
@@ -553,7 +553,7 @@ static int process_cmd(struct ec_state *ec,
 		struct ec_response_vstore_read *resp = resp_data;
 		struct vstore_slot *slot;
 
-		if (req->slot >= EC_VSTORE_SLOT_MAX)
+		if (req->slot >= VSTORE_SLOT_COUNT)
 			return -EINVAL;
 		slot = &ec->slot[req->slot];
 		memcpy(resp->data, slot->data, EC_VSTORE_SLOT_SIZE);

---
base-commit: 7027b445cc0bfb86204ecb1f1fe596f5895048d9
change-id: 20250703-cros_ec_sandbox_fix-44fd2ed01ed7

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

