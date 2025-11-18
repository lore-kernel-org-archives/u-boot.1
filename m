Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73F6BCEE348
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 18:04:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A0CC83E71;
	Tue, 18 Nov 2025 19:03:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="e6JFv1xG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAAC483E69; Tue, 18 Nov 2025 19:03:55 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B406A83CDF
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 19:03:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-450bbac0368so29674b6e.1
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 10:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763489032; x=1764093832; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3d6aRzmoY6X+5dYN18ZUffnmEW7eK2M36O0+MQgVhiY=;
 b=e6JFv1xGQLQWKDMoxb6z8PhAN4LxPRLXk1R8HZmVnOk7K8wZhVgOOqGuktJICm67E6
 Xjdj+oWzpTGYux2OSaIBEcz5rA+/QplLoeDowvuljgqFqqxan0hrcVOkun5qi2pFbDUW
 icZ0oS4uJzrh0VlZD92sHdqJjzX2uT9zj5egc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763489032; x=1764093832;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3d6aRzmoY6X+5dYN18ZUffnmEW7eK2M36O0+MQgVhiY=;
 b=t9b9SHzojoltsvcgj3na7lyeJAWKR4BXmOREzQe9eHfF4yW89VW07Lvin1o1iAtFdv
 uq26f2SSZx7mfUO3mzm6Lav5gFlLzvxxStvDCo8dcJoIWytZVqPh60DYAS3sWfJDMsUi
 4LIJ02LdHofgh/GxDZl81pgfrno8Ofu7AyMONtc0YvsNQMr1Y6+YZeu6DVDZrjswSwa+
 roBppAadAXTeueJwX1oxDq3mZEl83OYWAoDcw8hGeLbjaFzxuGk76C3vOYmcZuSlnb87
 7hS6qxNZUAPaF6UIvfrhLnn5/FBNxyORzhs0GkqW83PcfiKscsrKY1OppggZEh9zYp6g
 3LZg==
X-Gm-Message-State: AOJu0YxkirWcpSNESbmOA0SNtl/i7zIolAI4yDGTTJbXBsJ8JMJGpep1
 DA7umGcKJW4nr3zJPyN2++UkrPd8DjOoCO8hDDbGjWEJEwIfJbXvMb2l1CChBM9PTqITsP+QoX3
 QVrgpS1iHig==
X-Gm-Gg: ASbGncviAqZr021zmZblC8M2OAHxJj2jD0kv/nxZMKgEbg8cVAytSpjavAg9LGlCSo2
 2YglD10QCn/xrrnZgE833q+3gzVeefXuLBhMByz5Cl2uwEmS+H/Q2RSY3e9LD/zGrob0+0LhxSl
 ua20gSI17E7tU7h379+W7RX76/1howbJeBbItbD+E0mK+ySvvrt4Ahl9pCAi9sLTJsTBG7ua7GN
 dFd+9PZnrwvPGIPaDuilYmVjPBncWzCNKoO70o5l+Hb0BmnsmoO9KZcYHuOMSAezsdsd7UCkZLX
 7dAw9XggOYjJIPBZEhGed7IWzLLB+IYeDUrf251yJgVvIUtmc5YFqUc5rJ1HEco2fbUJmTUw8nz
 +GU6aRm/uI+hGH0Bw9KR0xOuR2LmdhCV6hA6b2MUXPpCvX3g+4nG19MnX267/PpzpJIvuVK6V/Y
 lJ0KtzZ+21k1r1OBgKE8NpWWQSacGmAr9jx0OjXhfM1Js+MeCx5CAgXrp6slFSaLe7UmrjXXxva
 g==
X-Google-Smtp-Source: AGHT+IEuu0NA4siaSFF6mZBfI0iRfjmId+P8iI9TkvFl0+TAnsBAJm0kWw41JMopsS8LO7d2P15RjA==
X-Received: by 2002:a05:6808:1526:b0:450:36ba:f552 with SMTP id
 5614622812f47-450ee0db4f0mr184398b6e.6.1763489032169; 
 Tue, 18 Nov 2025 10:03:52 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4508a55548csm5315875b6e.10.2025.11.18.10.03.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 10:03:51 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Uri Mashiach <uri.mashiach@compulab.co.il>
Subject: [PATCH] cl-som-imx7: Stop disabling device tree relocation
Date: Tue, 18 Nov 2025 12:03:50 -0600
Message-ID: <20251118180350.590968-1-trini@konsulko.com>
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

Cc: Uri Mashiach <uri.mashiach@compulab.co.il>
---
 include/configs/cl-som-imx7.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/cl-som-imx7.h b/include/configs/cl-som-imx7.h
index 8c363137b4fa..baf7bbf0ad4a 100644
--- a/include/configs/cl-som-imx7.h
+++ b/include/configs/cl-som-imx7.h
@@ -35,7 +35,6 @@
 	"storagebootcmd=echo Booting from ${storagetype} ...; run ${storagetype}args; run doboot;\0" \
 	"kernel=zImage\0" \
 	"console=ttymxc0\0" \
-	"fdt_high=0xffffffff\0" \
 	"initrd_high=0xffffffff\0" \
 	"fdtfile=imx7d-sbc-imx7.dtb\0" \
 	"fdtaddr=0x83000000\0" \
-- 
2.43.0

