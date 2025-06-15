Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3ED0C71135
	for <u-boot@archiver.kernel.org>; Sun, 15 Jun 2025 18:02:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B40AD82CB8;
	Sun, 15 Jun 2025 20:02:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BhmdGED/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4DFF82CB8; Sun, 15 Jun 2025 20:02:22 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C772E81E06
 for <u-boot@lists.denx.de>; Sun, 15 Jun 2025 20:02:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-60f22023eddso2663781eaf.3
 for <u-boot@lists.denx.de>; Sun, 15 Jun 2025 11:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750010539; x=1750615339; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FpBan6XfOBftQKs0U3yiwXf435er8WeV9JfvyozjevM=;
 b=BhmdGED/gT6InlMnM5yVkRNdybHH5EH/o4kaaZyXX73rJr7Nh9J9mbCRqnNOHk5+mZ
 XYVS1ecS9AAvD6q1H9sI23tx9oLeqQYcQAfeI4coEJKTiEIZXrp3X/WOAqnKeN+MQ0f3
 m/kKM4lfMymxwOueQqX20R8J+U5FuN9hrwWP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750010539; x=1750615339;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FpBan6XfOBftQKs0U3yiwXf435er8WeV9JfvyozjevM=;
 b=b78kCM7ZDrBSdlU2UNcLJXuw6wP+3t7vxChvHE6ikdEdX+C8LrqIUCvU7y5ZdYQTtj
 7I6g9wspoqguwnZp8bDtBPTlmrFOZcVHoSpUCgHxsgORpIxWlfsU/BvXXYbZ4G/hO/AV
 FvYJbU4+OYqYmTn4ytzLe+qgMafB4pgbkQrectMYs4wrCCmBkMrtX8zwmtNmx+HZ32yG
 14h3v8y0rX+QKNPmiia+GXWrKVTWQAKs5PryThSAdCHOGQ/b5OwCo4aJ69VXVj8yhkKQ
 0EMf0xOciL4msjMVcVuD+rR4Bo6I0Z/G3WL869moMJM686VVge7P7tkSk36xL/vknQ4U
 DvVw==
X-Gm-Message-State: AOJu0YzxaeyqT9Afg0hs6ekNjZMlJmEoda4PoTrZ1iz9uTc7lCxHYg8F
 pnERX+zsc3OsKnSjYh8mB/+yT/zv+Kom1iYLsehu+1Xm3hM/3Y8F1MCnEtNADlihH9k=
X-Gm-Gg: ASbGnct9DjAXxl6KWNV7U047Iki3KT8XyQRKHawA7eYxuvMAUuelCxCziAJruVqUAuC
 Ftk6DJwipmdCuWM22mbCRFnjVUHCy1klhkqJcKd5cvJjI50pn8g93oEJY9QrnatEpBSO7GqbPaj
 eR+Do55c6f2Zg+MVEbxMpzoGHuWK7JuI+Z0DQveme/jWRRqst3jupX7DeCQYs9qY+fosraREYDc
 PZt3yMepchWGCcltipmrpGcKNtC2KWk6rm/KM+GYVNpZ6Zexu8jrkfcse35chhLLNa3L9RbFQtq
 oldVwrHdFhKigDDoJ1NXjTbdlsyxZqxzAoKtDZMVrKVnKq6lWLUAn9kzwFPjl+USDMcsdGgl8cg
 lQVFzqfHKHxtVisv4W7vYjQ==
X-Google-Smtp-Source: AGHT+IEVrPoHBDe6xV5fU8bA5NMb0SWYVZG7u0Dyj23CMyjPWHhRO9X5xFWaZWd/O4HueDCtu+XmrQ==
X-Received: by 2002:a05:6820:1628:b0:609:dd17:795 with SMTP id
 006d021491bc7-61110ee3dccmr4082637eaf.6.1750010539478; 
 Sun, 15 Jun 2025 11:02:19 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61108d785a6sm728761eaf.1.2025.06.15.11.02.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Jun 2025 11:02:18 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Raymond Mao <raymond.mao@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Adriano Cordova <adrianox@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Sam Edwards <cfsworks@gmail.com>, Jonathan Humphreys <j-humphreys@ti.com>, 
 Prasad Kummari <prasad.kummari@amd.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Daniel Golle <daniel@makrotopia.org>
In-Reply-To: <20250604154814.1856244-1-raymond.mao@linaro.org>
References: <20250604154814.1856244-1-raymond.mao@linaro.org>
Subject: Re: [PATCH v2] sandbox: solve undefined reference to pthread_kill
 symbol
Message-Id: <175001053747.1130810.11425319695122429211.b4-ty@konsulko.com>
Date: Sun, 15 Jun 2025 12:02:17 -0600
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

On Wed, 04 Jun 2025 08:48:11 -0700, Raymond Mao wrote:

> This patch is to solve the sandbox building error:
> $ make O=build-sandbox -s sandbox_defconfig
> $ make O=build-sandbox -s -j2
> /usr/bin/ld: /tmp/u-boot.27rzOu.ltrans58.ltrans.o: undefined reference to symbol 'pthread_kill@@GLIBC_2.2.5'
> /usr/bin/ld: /lib/x86_64-linux-gnu/libpthread.so.0: error adding symbols: DSO missing from command line
> collect2: error: ld returned 1 exit status
> [...]
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] sandbox: solve undefined reference to pthread_kill symbol
      commit: 3507e6208f3df1fc1dedb8fce1e8b71c33b3b804
-- 
Tom


