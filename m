Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDBA7C5DF89
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 13:08:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A207F80D1D;
	Thu, 20 Aug 2026 13:08:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WEKjKk_ziLNc; Thu, 20 Aug 2026 13:08:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787231287;
	bh=SI3XTKuk0s11de2E1zNO8S0Cmx/uxTEXZuq2M5FJgMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BWr1qXrLdu68Wup1KhmsKuJ45HHFy3pMq2a/mnl4ywYMUmo2pm1izjCZeJZV2ZQWh
	 DrWa19X8YEROJuEGuCr4HCzcZJcbbADFbQziezfqNS8AM5lnSqWJpwuWNwPm8slOkC
	 ezfDetHTijkgjT9f1t0DxURxfTHcI4RtTTgbwa2rZ/1BaBnJnNWzvxQy2Fo0bOlZ6e
	 P5WSE08gI8VigvqHW+WWweg8VeXf6htCOfYQ2EpiQoJGQEUD2DR6u42O1zpuZIfZ59
	 zRL+rX9IXfZbwOS4QouSF/XhVQSRxAs9atsXNpSgl0GIV4LQmmJTuQTXr25T2TsElz
	 ibh82f3PqO3VA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C887980D62;
	Thu, 20 Aug 2026 13:08:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A66013AC
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 13:08:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9911F402BB
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 13:08:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5lQxh5KIxxbq for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 13:08:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=IJ90csGj
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B4E8540051
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 13:08:01 +0000 (UTC)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E37E842595
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 13:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1787231278;
 bh=SI3XTKuk0s11de2E1zNO8S0Cmx/uxTEXZuq2M5FJgMA=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=IJ90csGjgrrCjnfkJ+0uiNjF9SCkToNEy9vio64A2BRQyNwJaCRfGljB3pQkGDPBf
 yG48MHQZ8kr/BAo2n93wXwZMsEEOsL91agOLvAWfyG30LsM6ysmdAGe4pXdAO8HB1G
 c9eGzEFEQHqQSUYm0tPGQFsNiq1mkKIsMJt+pUkWK/0HOiReESDKd2r7kuoqAZljiB
 O82+jsefG0JkMzM1KCac2yL5ayzQQHFhZuQIgdw2Ja9tIzatqW7pPsy58XdKCl0G8M
 xxLDDvtewNdi9rc4pycI7M82KjJnZpnANilkJVpExM/fu8cEioACEQ/7WQVUq6GF+N
 nvNOzSL5vDovoFg4MuntcSPlGE6er7O69zoYflCddSwgVkNewKNlySbqPjQVAvLB+J
 hrZtk7QI8tho0bsYOaI8+vhG7dsyeF+e2GQgLp/b3el8LRVG8vE4ksN5J49RNXAQ6G
 /4C64SH2OWDHpKSgELyCQKAGIfKV6je9n2PG44F6S7bZNpt2CV3sVe/fiwZkIrphFv
 gWA6DkQAsigbU01/o0hejC5tst7yvD9RgktJy5V6BPuRg00uGkzU211TV6wX5AocgK
 qwl8jEaAPxxzMso5z9QmO00IqOKdSG/dvdILnhVPvWGIVp9+GibR8fnowjtlT6EnZa
 NLc7e0zDsOgSzt3O/bPFgFo0=
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-499a8039ff5so23768175e9.3
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 06:07:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787231278; x=1787836078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SI3XTKuk0s11de2E1zNO8S0Cmx/uxTEXZuq2M5FJgMA=;
 b=N4GNozxCdIdup/cnmf9L9MjbzBKhIJKHc1zWEBjpKr299ZattZheWkjL6iyYeFIoOk
 gxnA5Zf9vsfKY7lY1NBWBrX2YTD2iy801D1aLeeAKYV7HGRtXOu5lgD6+dKeghUM7YFT
 1y8B5COQ2dHq4ZN2a3pHFxDGsnoyBlg54uqMGy2qb1ZTnkNTtjo6TLk8wJMi9Acgivjk
 9kzssa1djeAg4IehwU+O2AN6CnmLYaKhOGH1qnwgVy90gm4t93xvBGFaKcUa+McuaBwP
 TJI/Ki/yzeWEhlzuW2BeYC81czx7idEiTZygWdjPFfEpB8HZkpZXSjrYzjm02hpbLIoB
 vpLA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq9+eneCwFyZdB6ZZ4wH0xyDk0gxQOkUNoj65jRkJypB8S2Rc1lvmuP/v0mESmW4bPlsGEwbN8=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyKmsEoOU5LcEKrDB2saYz4PN5VqGpgaUMQCeovZENi0X+2CkKM
 KMM/wEzTGgdF5TVEUYx5TnFPVkis0ypPjo/0lTxoMMX39hHGj/qrgVxHTgQ0o1EkEIv8RlFzfnB
 /HbCqxCZaxs/7akW4ZzkCu2ZaqhcY5gh7yb4BCMWrbBv1gQhU4ZEW5C7yxnlppykIyyjibmMTQB
 H9i9G5espKbQ==
X-Gm-Gg: AR+sD10VpZb2t15kmX+pyygt5Hbe/doHjkBUlo7tjEFfnW06KAhW4azoRSS1GYxtlw1
 uNbyaavX22ebF82gwJcB/AiaA/40h+c0iig/8UZjU4+33D/JPHZne+vByst5lf8jXXoR+9nDheb
 bN2eNVIlMRQTUpyOXYNe+66DPHtkFjcBu2ET8UFm1mpeal3GwBe1vqwoF0/HOln2DkEGH61GwEu
 d4Fg11C5EEx9sSF/0zgp1nM789klN7V+8MSEV8Q7US9OERth1Vq+zXGHQzeQSLFIgvHkqSuBvyY
 dURTm2zkuszUS7UUu9kKE9pCS57aguSH8teIAbStfbl4SGuvt+5q1V78tFU71Hh/sn1dD8aAtCz
 RUruCcrW4JzSlhJ59Nx3lGN751BdW7q/C6rKqGvqF/VMksEZZIGPlSkY=
X-Received: by 2002:a05:600c:4e04:b0:499:8ed2:8234 with SMTP id
 5b1f17b1804b1-499aa0e221fmr271876775e9.0.1787231278532; 
 Thu, 20 Aug 2026 06:07:58 -0700 (PDT)
X-Received: by 2002:a05:600c:4e04:b0:499:8ed2:8234 with SMTP id
 5b1f17b1804b1-499aa0e221fmr271875875e9.0.1787231278103; 
 Thu, 20 Aug 2026 06:07:58 -0700 (PDT)
Received: from workstation5 ([2a02:908:1242:30e0:cba:879e:28f0:3c57])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa0fd7a9sm183722785e9.2.2026.08.20.06.07.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 06:07:57 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/2] efi_loader: in platform_get_rng_device() use EFI_PRINT()
Date: Thu, 20 Aug 2026 15:07:45 +0200
Message-ID: <20260820130746.164424-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820130746.164424-1-heinrich.schuchardt@canonical.com>
References: <20260820130746.164424-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Use EFI_PRINT() instead of debug() to correctly indent the message.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/efi_rng.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_rng.c b/lib/efi_loader/efi_rng.c
index 7810b4e47ea..9c5a60ea963 100644
--- a/lib/efi_loader/efi_rng.c
+++ b/lib/efi_loader/efi_rng.c
@@ -31,7 +31,7 @@ __weak efi_status_t platform_get_rng_device(struct udevice **dev)
 
 	ret = uclass_get_device(UCLASS_RNG, 0, &devp);
 	if (ret) {
-		debug("Unable to get rng device\n");
+		EFI_PRINT("Unable to get rng device\n");
 		return EFI_DEVICE_ERROR;
 	}
 
-- 
2.53.0

