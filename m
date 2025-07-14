Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D769C83F1A
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 23:12:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89CB183013;
	Tue, 15 Jul 2025 01:12:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IjLGreJg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6282F82E37; Tue, 15 Jul 2025 01:12:06 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5536682E37
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 01:12:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-73e58d5108dso131016a34.3
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 16:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752534723; x=1753139523; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=viMWi2Vz/zdcuWMFxRjZEnKT66XoYUmUYzuULTTeThk=;
 b=IjLGreJgYsTbAEvEQR6LGiKXSghXm8/Ld8nhGI07aNJY/0grAbnscxf7EUhl9Rmc56
 OSqiUeF/ZaSfOdTAi7R6xZJFPm+VYeosX87CDz9dNgqvPemhOCctD2DfGisGc+wQhNQh
 U7oQF5IdrsGja8TX4GatTgWQR8HgSbJ/5YVus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534723; x=1753139523;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=viMWi2Vz/zdcuWMFxRjZEnKT66XoYUmUYzuULTTeThk=;
 b=HSVdx/QIq+V3xs6Gk/3wC86LGZWhjRzv+ZCif+Fs3Utv7QRf2aNscSpv7X29eaQ4EO
 uV3ei0X4nx/fWdWce9+TlLn81hzKRTF56JyR213KW2gj6fypr2sHoYdpr7DKNpbBQ79w
 JvuVqDeVpin30SIOGikmk7gYmQZ6iKxIAJ2POnbBYogj+z0a5INb08F0RH8kpJUGxalm
 TfUwiKlwx5Tf2WbVoviRK9djbV+pUf/E8rWlbH31i4rQQiBjH/RXbIbVdq0uwgh4n6C1
 uGz5W0GvAmqVKBc+Z/olcE3BVAzGA9RG2XR5cR7KSMInOjgyvi1dstoheDauChnF+PGb
 tyYg==
X-Gm-Message-State: AOJu0YxhauvZmFLo4kNorXEGRI3COcW76/LlEA+uOiY3jUkS8gc3D3K+
 XMd2M60CxLOXznp1DIvNvhLztjfo1DEhEOkROLLmBiCQJ0bW+qg8yLF8eRtyZaWN4NMjPFv9JGF
 gwqiLXx4=
X-Gm-Gg: ASbGncvqb+qydtLIzfB0XTkBhVeDQtD+jgKG5rQhadghc/Od0syO8hdtDbAasddApnv
 qlm0/EhmH81VXn+zCIiEiOeGPTyLjuf405VTr3dcq/ow1CCOvX/LVWYELjiR9wpyiEABkXsAhbD
 qA2Pd1IH/zd9YqSqd53nNvpzso1SW+o1h5r+Mb54eLLqrvLpbH7US8bfcGpYqlDH7xQf42AoBFf
 4KJlmU2RbUQT9kWOJq1AHH/ADEUnp2rSGKcBSXM2SXWgEfqkvUBDNkbN9VC43Hm2idM1ao7leUB
 74aH/N9VN/Ig5JRLtIaugnXBzTzpRe17WNAfmFLymNeHCCr4W2RDoRIVfdfYVcRWIpGoyh7ixoH
 MzJF49zLSf/RyF4QGKztiTusx13C53r8XMq45fD28+pBKJ1UA/8IISVg=
X-Google-Smtp-Source: AGHT+IH4JMwEPak5X3xipwr9M80Yp9MD4LOvdSz3dADLLk6WB9qXPxDzcaXK+aOp8oXEShr7MhOfXg==
X-Received: by 2002:a05:6830:3695:b0:72b:9af7:d766 with SMTP id
 46e09a7af769-73cfc2b4ff1mr8549746a34.6.1752534723085; 
 Mon, 14 Jul 2025 16:12:03 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf108af60sm1729410a34.21.2025.07.14.16.12.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:12:02 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250707112419.103724-1-ilias.apalodimas@linaro.org>
References: <20250707112419.103724-1-ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] tools: bmp_logo: Mark local functions with static
Message-Id: <175253472210.280771.1811245690419409220.b4-ty@konsulko.com>
Date: Mon, 14 Jul 2025 17:12:02 -0600
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

On Mon, 07 Jul 2025 14:24:17 +0300, Ilias Apalodimas wrote:

> These functions are only used locally. Enabling -Wmissing-prototypes triggers
> a warning. Mark them as static.
> 
> 

Applied to u-boot/master, thanks!

[1/1] tools: bmp_logo: Mark local functions with static
      commit: bcc8d24d62b5fadb19013c6e00211bf14210954b
-- 
Tom


