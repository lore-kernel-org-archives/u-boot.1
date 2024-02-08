Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 035DDC48260
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 10:50:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0CCF87E3B;
	Thu,  8 Feb 2024 11:50:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="mDsaApmF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DEE186D9E; Thu,  8 Feb 2024 11:50:12 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA62187BF0
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 11:50:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4B8F540A28
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 10:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1707389402;
 bh=s78yCo4rl+eNr4tyduTY1oe7C8VCEwC83q9jKVIrGkQ=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=mDsaApmFsuthfEo0py9h17WMLxNSwJS/7/2NEdc4O64bZpumbSP8lxLQXXQ8Kd45/
 o8HKs+jTxpeAo8cr9NiKz/rdEdCRGiakqQvZoqOPnJ8IIAdJKHzCky0l3oQ4LSip7m
 OZOi57qMmdUV1kE9qx4MvgtMwFUu0AJ2308uQkr+xu1uRUIn4Kpnr+9A3WRO7XoEUV
 se4GZ97d8p0WC3zsh6Bru/EktCtcJQ0ZpSqDlKZ1Br9EhoforDF2EaBeFfNC77rq+1
 HpvT3NL3Hv1kdLqS3JiWPH22m0Oe2jfR8koD9H2A4RjVwlVuylKsnHCBQ1QK/mfY4i
 g3bgm+zBSkI7w==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-33b508b9738so298175f8f.0
 for <u-boot@lists.denx.de>; Thu, 08 Feb 2024 02:50:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707389401; x=1707994201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s78yCo4rl+eNr4tyduTY1oe7C8VCEwC83q9jKVIrGkQ=;
 b=jBJjkmcSn0rGeDTwJeyhkZRYQxC4QyDjBYCrgsKovGZQpDT1dc8xtSWyE07HiyLZhs
 cjqEbA8JIKhaWjSglnmxLR0/35HPrWCDxWOBpxiXxxWloj4Nlt4BcrPtEdf5zdI8iFxu
 JdJgMZMYBg7QsdEsi4L1dqTfhRnxg4E30azNxmEhJBqAw8AjNOo/CQ5JGvMux+bqvsWt
 52PgakOGJhy9COPEPTqwJhagGRv9XUkO4D8wstOOGlv6SbLKGXyWI69Dyj114Jg7dO+/
 MtEGwN4Wz0DD1q2kMkAXvt0OX75cjIyjLqQYd9akr8Zz5UkZ4h4IdYMt0YECiZdpMBSA
 HWug==
X-Gm-Message-State: AOJu0YzLzRWhwWcXyV+eul+oiHBs4Y1pjsyiDaXYrUEEEK1ZX+G9q3Qt
 2Sgxi+kUcMvAvDPgH8n+GA53n203j3rqg3p+uFMqSg8biygJX1q+Ez/Pkjkk1nb8lKXdq6IGZ/W
 y6AwWeILd0Lx4erBVRI44Cz+i6UfebY9e9ZshBqRMF9Ce+m6OCvQ/QRlpu6QXD/TP4aLFBjc6Xl
 Q=
X-Received: by 2002:a05:6000:4007:b0:33b:5c8c:bcf with SMTP id
 cp7-20020a056000400700b0033b5c8c0bcfmr114402wrb.10.1707389401776; 
 Thu, 08 Feb 2024 02:50:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVL4AnnAAJJNrBxm16lRWLVAFe1WUeqGCcg7u6D8JT+MfD9e3o/tM8p7Nn+vUWGLKGvP/Izg==
X-Received: by 2002:a05:6000:4007:b0:33b:5c8c:bcf with SMTP id
 cp7-20020a056000400700b0033b5c8c0bcfmr114378wrb.10.1707389401546; 
 Thu, 08 Feb 2024 02:50:01 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWCplii3wFdLSDJZvSbwZ2Pz+EU2x+nA3orlpnfq/pdlqGSGj7YUBC+K3Lm1AHW2/ocIWL9Q3Rb06STuNrkbixtulUdbNJGs165bTrhSwPFDQTUdaM/2VxNHzmi5nSWZBPl1pJRjYxG
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
 by smtp.gmail.com with ESMTPSA id
 v12-20020a05600c470c00b0040ff7e3170asm1248348wmo.2.2024.02.08.02.50.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Feb 2024 02:50:01 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/2] smbios: fill wake-up type
Date: Thu,  8 Feb 2024 11:49:52 +0100
Message-ID: <20240208104952.19964-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240208104952.19964-1-heinrich.schuchardt@canonical.com>
References: <20240208104952.19964-1-heinrich.schuchardt@canonical.com>
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

We should not use the reserved value 0x00 for the wake up type but
use 0x06 (Power Switch).

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/smbios.h | 2 ++
 lib/smbios.c     | 1 +
 2 files changed, 3 insertions(+)

diff --git a/include/smbios.h b/include/smbios.h
index 3df8827b60d..704d7e5dc86 100644
--- a/include/smbios.h
+++ b/include/smbios.h
@@ -108,6 +108,8 @@ struct __packed smbios_type0 {
 	char eos[SMBIOS_STRUCT_EOS_BYTES];
 };
 
+#define SMBIOS_WAKEUP_TYPE_POWER_SWITCH 0x06
+
 struct __packed smbios_type1 {
 	u8 type;
 	u8 length;
diff --git a/lib/smbios.c b/lib/smbios.c
index c83af730a91..8599743738a 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -394,6 +394,7 @@ static int smbios_write_type1(ulong *current, int handle,
 	} else {
 		t->serial_number = smbios_add_prop(ctx, "serial", NULL);
 	}
+	t->wakeup_type = SMBIOS_WAKEUP_TYPE_POWER_SWITCH;
 	t->sku_number = smbios_add_prop(ctx, "sku", NULL);
 	t->family = smbios_add_prop(ctx, "family", NULL);
 
-- 
2.43.0

