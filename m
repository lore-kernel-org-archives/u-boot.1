Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5006C7EE30
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 17:57:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7249282E27;
	Thu, 26 Jun 2025 19:56:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pBsCli7D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5410480E9A; Thu, 26 Jun 2025 19:56:53 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E28E882DA1
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 19:56:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7382ffcb373so673623a34.0
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 10:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750960606; x=1751565406; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zpCKt+ThvzIeayzZ2An2s7OOmbFBq8WKwWeFARIWnTM=;
 b=pBsCli7D2Xqbnq/ejAjCiVeursEFZ7Rsda/2L4ZVAng5ZA4LSQBzLXFO9vrxO8HL2u
 0djmkPvlCOqmIOe8fIUV2LhgPeyY3x3ocPS0m8TWebkBMLtQpXcUqU+OYI01Giso8Hzk
 JaeSbXU5ppKPdMEGJaKLMaoaCNwH9mnaanHhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750960606; x=1751565406;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zpCKt+ThvzIeayzZ2An2s7OOmbFBq8WKwWeFARIWnTM=;
 b=kch6iNRj8rvQpuZAihArdaSkKo3KFBY7oORNaFvlXR/TisFG4KauJaHJl3/oBbZ8ye
 5wzY4L7Ns3/YOzczgOdmIiVJb4iknwCgJQIB3HhjKS+Q37GA+0gvUBxEYgwbXKWChAsa
 GFS9ZyUg7teTj4V8OVuJ8q4H8tpyQJ5Ge5wxobbGFh0NM0L8lkHq1iX2h3S482/T6mlv
 I4dxOY/qWczBGHdj9FKfXmQY4qjhU2Up6Yw4HErp2VEerzVByUkwGeyaJSKzMqFH1Hb+
 /a6QutqO4sEKfc39WQR324EH2rKxR4ICDroRVZKhXCMSCMDKShXoGmK8ZtVbEeSIByGr
 66vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCzj1qZ/Ghli5efLTrgTzLEagH0/qrsHMLRTXa/JbNrzo7RmT0peGgrxMAaAEeRQws1LRrsoM=@lists.denx.de
X-Gm-Message-State: AOJu0YwWBmWZkvzq+c40wPLDe/s8ubosTjoEfYc3dzlj4sQqHPtCOew1
 /68j9ICBPaoFZXBJK0tpGXZX50P5+VbcKu1b3DZd/CVab56ifk04kUHTLATR00LbUvzFIGbJLVe
 xGw9xdgw=
X-Gm-Gg: ASbGnctbKcJnrZrevkaQOWDtbmhObwQ+Pl1Ze0PWLMq2OczkO3tuLBxSuvwezJMhq9t
 lfAg7sDn79mBqWmrnn6cFMkGFIkJiFRkjGv20hYtKAhyODYPRJzIsRqyd/po7tOiE+vbRi2jmOO
 bEbs2Q1zGpgR7NE8ddik7du2kRPw8UnutxMchoEiC9Y+8WPcjNdLSK3/bkYbV23EhfM5/5eg5mR
 VV6xVmxAB2ZmH4i2ThEKMAloCmAVHvIkg7YzGFNvraIoY0gisuiTTtGqAiE8EDFAwD+raQ7iSEE
 IfsUuSxCabT8od+j7YCBhdzhmJEtvM7G029hQ00bIZLygJqwE/wDpIrX+ILjicDO6mib+QfxmRy
 d/xHzc9ZyCgchoPWKV9q9aA==
X-Google-Smtp-Source: AGHT+IEQM+29daEoJxaiJsN3UNkgBw6u+3vv9O7MewnJbFhlEimqR5KQ9oKTBJJNO4sN3Sz36hjE7A==
X-Received: by 2002:a05:6830:6082:b0:73a:6d48:dec6 with SMTP id
 46e09a7af769-73afc43bb1cmr57483a34.5.1750960606673; 
 Thu, 26 Jun 2025 10:56:46 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afb008936sm63877a34.24.2025.06.26.10.56.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 10:56:46 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Yannic Moog <y.moog@phytec.de>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, u-boot@lists.denx.de, 
 upstream@lists.phytec.de
In-Reply-To: <20250610-pkg_resoures-removal-v1-1-97a269446d35@phytec.de>
References: <20250610-pkg_resoures-removal-v1-1-97a269446d35@phytec.de>
Subject: Re: [PATCH] binman: migrate from pkg_resources to importlib
Message-Id: <175096060589.1879961.5116208264808970833.b4-ty@konsulko.com>
Date: Thu, 26 Jun 2025 11:56:45 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

On Tue, 10 Jun 2025 14:26:12 +0200, Yannic Moog wrote:

> pkg_resources is deprecated, use migration guide in [1] to migrate to
> importlib.resources.
> Keep the Python 3.6 backwards compatibility.
> This also fixes the binman version test which failed for setuptools
> versions that print the deprecation warning.
> 
> [1] https://importlib-resources.readthedocs.io/en/latest/migration.html
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] binman: migrate from pkg_resources to importlib
      (no commit info)
-- 
Tom


