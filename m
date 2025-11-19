Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E204ECF34C3
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 14:57:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 773C48004F;
	Wed, 19 Nov 2025 15:55:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ocut2iLC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9BB883FC8; Wed, 19 Nov 2025 15:55:39 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE8AB83FBC
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 15:55:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7c704bf2d9eso3061137a34.0
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 06:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763564136; x=1764168936; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2oAJgv9D96OYLKeZWkbH3GrJ1DePhKTBOKGsKge/upo=;
 b=ocut2iLCbqV07qcbyL01atc/5MgKsauPqSKmNXdtQqU0032/XbHph9Y1ajd0sifc3L
 QqOEi8TOGvP2rAUs5RtWuExlJlgn9ufA49J+cIw6yaHwHPr/MSbBi94aX/fSOznAknGK
 Bu3GQ4TSfM/kEBS1S/3EbHdg9y+Xd+3AUwdP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763564136; x=1764168936;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2oAJgv9D96OYLKeZWkbH3GrJ1DePhKTBOKGsKge/upo=;
 b=hewrd2HLrLEYxjVUDmdqFYk9LHjMR4kdE9lpndSTABl+ypsW3G9QILVdYdpu18JxZl
 jTQom9GEVjBBMeh3V5wMp/M4azJS3rlNsR4J6Z6BL6ACOYjP/Og7eeallzBJ7/qP3OFB
 EmHZlLVITdubrJX1t5Zy9FhkLDtGwOTCgp06OSSkQrjQ+AN/p0XMM3JC8w7Ig5vPFheH
 JgndRsmpU+p80dXuBcPVRDPqT2E0nLw2nazIf4NT+e+j8Q/u1jzXRiAUsPux4t0I51VY
 X/DwjIO7IqsT6JS9rn6S90p6udBuSoqeJh3O/j8sgWD0WwhLMRuZVMUA+LX/bHxl6J49
 3Glg==
X-Gm-Message-State: AOJu0YzH6IcgsKXCIqNBlcEtaEAB03MRvnS3BUS92cTMPaSTIDLnYluQ
 meApPLQHOnuBhd+8WYqGZvsaKLCB0qOW+ydMzOVvq+SIDnArhg/68QbNCtWtIDBGmXf8kStRWyJ
 C4PKnLH8ByQ==
X-Gm-Gg: ASbGncu6nMEo40LSETsLAtKTPgTbKJvt70+9kiR8cwnqMjCBRrP4oIY/crdbVlJVor8
 lMzakEaUzzed236nzFVOsFXmJXO1a6/g/rr1oREMCD2hRjxcMoJ7J+Dv11ig+eLZrjXJiG/zmxZ
 4OWqpEBdMXIyk2e3ZP30N5BLMuIAWF1GqXZOrDu10BNIO0XwliY3lMvxIJDpb59BzsF0/rsSwMA
 nrbUucJkkHjGht7G8lXROXFDfqXtKDg8V8angKDmKwLEgshh6BilvkdGqXvdqUvVCD4PdPhT7uC
 rbnmi23W4Y+E29VSjnD4QfENLITKWl1QMNzrZnH7IbMTywuKWWEentbBVRj4fG/gjk093hnQnza
 a2sjoi4LuHtQFEipwSxonlV+AH3HB8RMdaiUuONcilGabMXd/ULNGkrgI4q4Osyci71iZvWKdRL
 nrdCEblTp8XT78VD42bgDERFMXlHzqGIccvvZSlvjECvKzZ4gtJkKwnFbAjKRl+2w=
X-Google-Smtp-Source: AGHT+IFq5PMEkx+wAUkZttLcE9IqXUm0SdEHAaqfZ+amjTEa4aAjQ4gopqEPcQNq5eTLhg+3CHlf1w==
X-Received: by 2002:a05:6830:6610:b0:7c7:827f:2b6b with SMTP id
 46e09a7af769-7c7827f2d08mr2188490a34.38.1763564136441; 
 Wed, 19 Nov 2025 06:55:36 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c752e73ff3sm4564037a34.11.2025.11.19.06.55.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 06:55:36 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Stefan Bosch <stefan_b@posteo.net>
Subject: [PATCH] s5p4418_nanopi2: Stop disabling device tree relocation
Date: Wed, 19 Nov 2025 08:55:35 -0600
Message-ID: <20251119145535.843388-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

Remove setting of fdt_high to ~0, which disables device tree relocation,
from the default environment. Doing so prevents U-Boot from correcting
problems such as having an unaligned device tree and leads to various
failure modes in the OS.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
If there is some window of memory that must be used for where the device
tree is relocated to, bootm_low + bootm_size (or often just bootm_size)
or bootm_mapsize are the correct way do this. Please see
doc/usage/environment.rst for more details.

Cc: Stefan Bosch <stefan_b@posteo.net>
---
 include/configs/s5p4418_nanopi2.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/s5p4418_nanopi2.h b/include/configs/s5p4418_nanopi2.h
index fec1bfd50eb9..8a8d54daf7b4 100644
--- a/include/configs/s5p4418_nanopi2.h
+++ b/include/configs/s5p4418_nanopi2.h
@@ -139,7 +139,6 @@
 #endif
 
 #define CFG_EXTRA_ENV_SETTINGS				\
-	"fdt_high=0xffffffff\0"					\
 	"initrd_high=0xffffffff\0"				\
 	"rootdev=" __stringify(CONFIG_ROOT_DEV) "\0"		\
 	"rootpart=" __stringify(CONFIG_ROOT_PART) "\0"		\
-- 
2.43.0

