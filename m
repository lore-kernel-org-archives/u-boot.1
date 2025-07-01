Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF9B1C83038
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 18:40:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6BEC82ADA;
	Tue,  1 Jul 2025 20:40:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EtvGP5H7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B21182E9A; Tue,  1 Jul 2025 20:40:38 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 080828003E
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 20:40:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-73a45bb28f1so3677685a34.1
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 11:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751395235; x=1752000035; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=koCYh0dFdj/zZ8twvzDxoooITwrVaXCsuLb3XEGMsbk=;
 b=EtvGP5H7vGASDTXsz2ZrHsInJtWPPd3R8vDZ6oyf42H00/aW21QamosvjFsT4/hF8m
 QYZqwc5ei+GA1VzaEHSIg1w+nZoMRX9C7rf7XcEjfQeJ1e+OLCS6x3u4wJlhROrB+6Wn
 +reE0l8LWmkTg2nibC2e3abMSxpRgFAyaPBuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751395235; x=1752000035;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=koCYh0dFdj/zZ8twvzDxoooITwrVaXCsuLb3XEGMsbk=;
 b=rBelPVWRpTZapJbe512Iej2bqhF7/QO1NKETTIut1nSnlyGS6bWG2fefsSGfv1kHnD
 ITIHwjXCZ6tkDzmEy2f/oUc0BDvIp+JJfQlT6oVo0OcTzzyXL3++rmoUTkexd5i/5llR
 hXIYRrl3iLrGzgKeFG1yTEY4lOx7I0XfQLyOlYw5dAsMNX/gh5t/I16Y1DdXctX97uPc
 alW2XXT9bNmgJGam5Np4CSuRpSzuzu/bOQZiLCPzY9pNJn+I9puFu6DbJ9kWAMLRWa46
 Y2U5isW5Rt/WZ5kvAmLahNDp/DezjgN6bc8fFO9VSh3+TQ+cPWKww/mxe1u/U6+DbpF8
 Ipgg==
X-Gm-Message-State: AOJu0Yw4jCYmGdT2DRTZX/LgvQJZH3CMYQJre4nLSS8QLuTXHvQcChBn
 /8NuM9peeZPipIMVXInpa/VFwUx36uRgEA/FP8lNK8xyw70Ak4bDWg1FHGLarisM3XJjzf1EBIs
 c60+c54M=
X-Gm-Gg: ASbGncsjqZzLSbX//dD6FEkESwXbSCOgUn1OzEAJh4dXYkH5+HrRNcI2LHLt38asOXQ
 1mVNv+Vy/tuUF0FLTgloHhpYMQO+C7YrN6rw/HUf5YdJfF5HCOuY6g03OKiCD8BjFQ52/RpdyvN
 /xE+3+IHAKF5Fk+q6cHeNf3SImLgPtURKdURrhDBem5Nw/Ow5USmG/jtWHGrrmDIUNQV32JPq+N
 yx4F8gcMR7bl9NMEYuqW28fp/p+RN6YyoXbv6ISYj67DOZuq5TlEM7HO4+jLfhItaMTDO5BjwJf
 PntgY65Fzt9Lc00haPQJnKeP0SLIoUFBYfePgVbl3/QzupX8Vu7j+zbc7RXXmOxwnurEN3U+eTS
 QopBfpQo/K7DpG/U5vIV80dSkh1J/mVhU
X-Google-Smtp-Source: AGHT+IHwoHPQSoJp2s84orFvajkoIF3KQckqQ/6jkLQSn5X1vKzOoL+2tV+qbPeuD3UMc+08EXNX+g==
X-Received: by 2002:a9d:6018:0:b0:73a:dfae:3202 with SMTP id
 46e09a7af769-73b4c1c10c7mr133304a34.5.1751395234306; 
 Tue, 01 Jul 2025 11:40:34 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afaff249bsm2210913a34.6.2025.07.01.11.40.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 11:40:33 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Chuanhong Guo <gch981213@gmail.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20240501074524.1143518-1-gch981213@gmail.com>
References: <20240501074524.1143518-1-gch981213@gmail.com>
Subject: Re: [PATCH] mtd/spinand: gigadevice: sync supported chips with
 linux 6.9
Message-Id: <175139523349.3190871.15193966750662486026.b4-ty@konsulko.com>
Date: Tue, 01 Jul 2025 12:40:33 -0600
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

On Wed, 01 May 2024 15:45:23 +0800, Chuanhong Guo wrote:

> Adding support for:
> GD5F1GQ4RExxG
> GD5F2GQ4UExxG
> GD5F2GQ4RExxG
> GD5F1GQ5RExxG
> GD5F2GQ5UExxG
> GD5F2GQ5RExxG
> GD5F4GQ6UExxG
> GD5F4GQ6RExxG
> GD5F1GM7UExxG
> GD5F1GM7RExxG
> GD5F2GM7UExxG
> GD5F2GM7RExxG
> GD5F4GM8UExxG
> GD5F4GM8RExxG
> GD5F2GQ5xExxH
> GD5F1GQ5RExxH
> GD5F1GQ4RExxH
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] mtd/spinand: gigadevice: sync supported chips with linux 6.9
      commit: 506ceddffdc40acf709822b678b986e2e22c5056
-- 
Tom


