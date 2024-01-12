Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA82C4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 08:41:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF4048798D;
	Fri, 12 Jan 2024 09:40:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dDcW0YX4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B8158798D; Fri, 12 Jan 2024 09:40:55 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73E438796A
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 09:40:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-336990fb8fbso4917449f8f.1
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 00:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1705048852; x=1705653652;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kVeu/ujg9A8LlKAT/XpvgJs7JWzrpRysCi4+ZmetWsQ=;
 b=dDcW0YX4C5q+9pwI8FwyuMhYfqbl6Sp8w3w87t7//v/sQFpweeVTVxccb6Pb43Dpuk
 NIRt7X5vnGdrrfgRbBQx+VmRWDkg/bfcItfF6FsiLSGGApprCtsw+ezJDq7EwM+fPdHX
 OEiwrgiQkqXa5R8hMN6fpfh90AHbOjKt9wsaNhXBZBSKanBvTFV1l8NID0IudDJXcfMy
 NTC3WJMaNMZEvAaJ3hnN1va178Ac9EQONoeLybc129YjwfkKtH5Ju+IuUaKwRSAlUD27
 RrFcDjVypQsuTwm1f1ttOJj/WtvErVXjQ5ki0ujbF5EJm3rHNNdKGtAj5RvwR1UP1ccZ
 A7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705048852; x=1705653652;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kVeu/ujg9A8LlKAT/XpvgJs7JWzrpRysCi4+ZmetWsQ=;
 b=MVJAh3yu19zmNz++rnUMC44TcFCx2RUBls/ANp93dEd5rT3yceHPyo0Q8YmDc4YDeI
 //AdTA4onzlATxslWEuzQpQQK3Yapg2JhHZNlKPciUNaGeAxaKuynxAHmkqZxlfRXy3l
 he8Zxaz7tEslCP4lsJ0SBlCC5fF+0GvSGIC6RDKGTPnEjyHABysmxGHn2DPyJQrKl8pr
 PkYhRNhOtXhY35N4A5tQJ9AFDgxlPndpTeJ3EWV8g0ykcOQ41WBZx90U6PCNnH3vQW1P
 irFgsWnQWzj4yn0Q5kiyzndirghvgFkX6wOQyA4kCdtlf08pTYGJNiTkYATsufqQ6NuX
 VXvw==
X-Gm-Message-State: AOJu0Yxqw4xD8eH0iIgmT14ir7PiGuxt6s4ey14x3rhUs77cH9z4ovvC
 rnLzhWwlVLiZS0CAvrQeCvmcIZwxDjrJ5A==
X-Google-Smtp-Source: AGHT+IGtv494TUS06XPkYuvNpBRR1zk3Mput4tRtZuNc3RtckoY62DPjqZXVkGb4p3H37Nqt/7wpsg==
X-Received: by 2002:adf:e5d1:0:b0:337:7ac9:7907 with SMTP id
 a17-20020adfe5d1000000b003377ac97907mr388164wrn.13.1705048851814; 
 Fri, 12 Jan 2024 00:40:51 -0800 (PST)
Received: from [192.168.1.20] ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 m7-20020a5d4a07000000b003365fc41bcasm3202118wrq.51.2024.01.12.00.40.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 00:40:51 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Fri, 12 Jan 2024 09:40:45 +0100
Subject: [PATCH 2/2] MAINTAINERS: add Mattijs for Android AVB
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240112-maintainers-ab-v1-2-f2a538eab18a@baylibre.com>
References: <20240112-maintainers-ab-v1-0-f2a538eab18a@baylibre.com>
In-Reply-To: <20240112-maintainers-ab-v1-0-f2a538eab18a@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.12.4-dev-6aa5d
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

Igor has not been active for quite some time on lore:
https://lore.kernel.org/all/?q=igor.opaniuk@gmail.com

I'm interested in helping with maintaining the android_avb
command. I'm a long time android/aosp developer and my daily job is
still doing android work.

Add myself as maintainer for Android AVB.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3c73d8c35c4a..4978470c1664 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -70,6 +70,7 @@ F:	test/py/tests/test_android/test_ab.py
 
 ANDROID AVB
 M:	Igor Opaniuk <igor.opaniuk@gmail.com>
+M:	Mattijs Korpershoek <mkorpershoek@baylibre.com>
 S:	Maintained
 F:	cmd/avb.c
 F:	common/avb_verify.c

-- 
2.43.0

