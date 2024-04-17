Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75FBCC04FF9
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 08:06:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADCEA8842B;
	Wed, 17 Apr 2024 10:06:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="EdTpSdII";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF9F888451; Wed, 17 Apr 2024 10:06:28 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 841D7882C4
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 10:06:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4F7AF3F8DC
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 08:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1713341183;
 bh=5YjK/z/xJlPyU2dyqA9X9xDQ5EReb+m4BwV26/gC4S0=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=EdTpSdII8XqehVYQ0BhjAMi/TrP0n1ThrTZaGjGDDX+I40lxB1dNXTAN1H57e4kZo
 fZjUjAdfwC9FNvBIt0OYlzxiRXTEPcdDjCbG7rLwXAgvb2NWszLgc2d7e4zpgA77fO
 zLCDg4yMlEYf3bi0nLoLCsqKfiNT7y+1i7k9uu5KkpYGDmEr4MdJ7Qp6P4j3fI+Zum
 0Dc6WvCRFZysN5ZyZqy4+kPUwI4/EfDLoHpxULqwCMKeqPz0PzIl2jRpkLYkfK58qz
 sRWVD1OiE1ppr6b6Hkol7ab4ZAbWAzbCa62dnb1+mCq5qS3bHsEDm4NmEyvpaVw1uz
 aDbMJ2OZNjSTw==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-418a673c191so4321145e9.0
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 01:06:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713341183; x=1713945983;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5YjK/z/xJlPyU2dyqA9X9xDQ5EReb+m4BwV26/gC4S0=;
 b=JPaqhe5YILRwSOuCNMyDMQhYqwGYKsvtoFC4xTdyXOsFn6UzLvC+r6TZaj3FTbmn+f
 b5E2iVaDnlHFA2m4ypQpt2gvvJumOTx758VQk7QdK5I+7NiPgwa2HEVk8qj0V07f+Smt
 Ka4ZORO0/6DRmMbu2WAwejGQxiw+iWzUdTq3SC5nXEtGoSEE7lhjHHqwfWYoN2UTwTva
 3WxcnWfUO7garSeuEQfz/6gJ1oYRPipkWDhgkK49cVudQdQa4rGNxiTz0ADzAsGUInRl
 PYn6PCDjWk4hACD+hFsUxeQRLq14geZZQ8bdxLV8rVZvWCqgi6kheJPSWKzLmET1Fbl0
 Fjew==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvXfOwrP2MDSnMR73jKpriqekeVlHAze8abpFwRjiuaICMfV1GTpEkAbzz+MiEadho5vVZ2FB6Cmqg/t0VzM7K6LZLQQ==
X-Gm-Message-State: AOJu0YzOLwD/ID2ht276nD8KfflG1gTFx+QbSzX8l2oQ4J6+Q+6Rv1if
 zRhMIMuMMLBayHxUt7a6k3YUZ8ecdfzMAL/VXDmrD2QsUDR/QrJaWwZZpF9tk5fqRSYvP315Ild
 e9mV/2LFJeTmATQjJbOYly1Tnhf4EpnrwVC1B27HnMOBjXpzso3anBC71GmsUJdD4v5Q=
X-Received: by 2002:a05:600c:3111:b0:418:4841:162a with SMTP id
 g17-20020a05600c311100b004184841162amr6270838wmo.15.1713341182928; 
 Wed, 17 Apr 2024 01:06:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDtQeLcXNHJELfL6egBOLGiOATDu88Z3fQY+ACsF6HR5DlXxBVQQQAoXyoCfbWvUb1fQe1vw==
X-Received: by 2002:a05:600c:3111:b0:418:4841:162a with SMTP id
 g17-20020a05600c311100b004184841162amr6270823wmo.15.1713341182517; 
 Wed, 17 Apr 2024 01:06:22 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 c8-20020a05600c0a4800b004182a36b185sm1759098wmq.2.2024.04.17.01.06.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Apr 2024 01:06:22 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/2] doc: env sub-commands, env list of aliases
Date: Wed, 17 Apr 2024 10:06:11 +0200
Message-ID: <20240417080613.24718-1-heinrich.schuchardt@canonical.com>
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

* sort env sub-commands alphabetically
* update list of aliases for the env command

Heinrich Schuchardt (2):
  doc: sort env sub-commands alphabetically
  doc: update list of aliases for the env command

 doc/usage/cmd/env.rst | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

-- 
2.43.0

