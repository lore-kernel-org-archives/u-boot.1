Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FA9C3ABAC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 20:12:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96153820EB;
	Fri,  2 May 2025 22:12:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="s+1rlhCi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7059B8212F; Fri,  2 May 2025 22:12:34 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F393581F7E
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 22:12:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3feb0db95e6so1633759b6e.1
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 13:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746216751; x=1746821551; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=+zTE0+warmJ69cPZNd3zgaLwawH5oWaubOdAcheYuVo=;
 b=s+1rlhCi4S1sqs9sPSpvzfgo/tdUpdAh0xYJUFH5I+AQpW/sFcEr0wBZzeIntfIaio
 uKmVqaMG9Bno4xYd6+gcPEkfbkDwpbVaJKLAql7GE3h//PtlY7bOMDegsEP4JhX11hx5
 cndJDx142RgrhHItEhmKlUl23HBO1Y7HjsFoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746216751; x=1746821551;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+zTE0+warmJ69cPZNd3zgaLwawH5oWaubOdAcheYuVo=;
 b=boEO+RyILiHUM6YCK8Fkjgmy9319PmW4gaFyo7WvVdXQayjKpY6QmDuoSVO0+ADhyJ
 7JmgBK4XWGTxqW80LMTpG7icVTTrzkY3E1e9QC5nydkGJCx2fuwxsKxWfuQfku0W9yDB
 BAYcnmfBEkZSJTQmGziznghFJQwi/UZZqhWqZiCXKtUpw+nafzYc00VXcRrsVX6MIkjB
 JaXjfM2OTNT75gi+APB8KsYGTv02xAYWLIWx0S7jBHFN6XBqiju4X5IeIVH582Y9BfE5
 yNABEqnwORKTA2/tP3bKo2wfLXDnExJqz3JReuVcM7OkeQCngxfRHXpeUhnXp/o/yxHg
 jAWw==
X-Gm-Message-State: AOJu0Ywhh54SKC+hJlUGlvN7s9K1u2Yp+2Z5sJGhv8ygYeCmUEWhjk5h
 2osEes40rED/o5LSNTjpeoS0o1py8tgUgb3aegCvkY9Qg1oONmb1ZDOoNWJ1U0D/IV8E0R5s8KQ
 c
X-Gm-Gg: ASbGncuOn1E4XNM+JK8UwM73GkXeoJ8aJmYuj20KkqugXfqX3NrPzI1CFbNHZ7GJZts
 ooV9Xm18e1MQOANGVUW3JheCbv5XcWWfNfV/1AgD1+NBErmbayMhxj9oGqeUajw7c1IUIHZTzfS
 ozXEnmMc1c98rJ/7KOlwhUN3kDMrFFlXYSBMCoSsxATE13PjHJV6xNhI+4bsDqy/ZvXaULv0OrK
 UC2bkz9ioRI5R+2lMOnAFLEtwljBqavEEkMe2Yov4QChLTL7I1f4R/rR9W7Jln0VymEfv2Grm0/
 GiGIeVXkHVG0m4Q3Ez08N0XHnouvxqAEs8nJEOw/vpjk/DkZneA15Vf4arVuvRn08rE0YX5TFHS
 S+W8h
X-Google-Smtp-Source: AGHT+IG9M1M+khNkt2ZtBX4az1vSbVgE50/Ak4TmX8KkTXMvmAHq/wEX8T+qwQWaw89ICkaKFHCodg==
X-Received: by 2002:a05:6808:3a12:b0:401:e949:6374 with SMTP id
 5614622812f47-403413937f5mr2569685b6e.16.1746216750702; 
 Fri, 02 May 2025 13:12:30 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-607fb1117e4sm27786eaf.3.2025.05.02.13.12.29
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 13:12:30 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 0/2] Almost complete DM_SERIAL migration
Date: Fri,  2 May 2025 14:07:38 -0600
Message-ID: <20250502201226.1369013-1-trini@konsulko.com>
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

In a private thread, Simon asked about what's needed to get PowerPC
migrated to DM_SERIAL. I went and took a look, and to complete the
entire DM_SERIAL migration (excluding SPL/TPL) we're actually nearly
there. This series first migrates PowerPC (and some NXP Layerscape
boards that share history more clearly with PowerPC parts), with the
biggest change being to make sure we still use the correct legacy
drivers in SPL/TPL (where SPL is extremely constrained). With that out
of the way, I looked at what was left. With two exceptions, it's
platforms which can be trivially enabled for conversion, and so we do
that.

What remains to be converted are:
- Xtensa:
https://lore.kernel.org/u-boot/20250501230349.GM1261075@bill-the-cat/
- The DS109 platform which has a special reset done over UART:
https://lore.kernel.org/u-boot/20250501230530.GN1261075@bill-the-cat/

I believe both of these should be rather clear conversions by someone
with the time to do so.

-- 
Tom

