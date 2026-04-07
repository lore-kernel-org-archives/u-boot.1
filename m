Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33079105D986
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 21:11:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 909978405F;
	Tue,  7 Apr 2026 23:11:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="d5Ra78LC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F376840AB; Tue,  7 Apr 2026 23:11:42 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F7BB8404A
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 23:11:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-46eca92a297so2935165b6e.0
 for <u-boot@lists.denx.de>; Tue, 07 Apr 2026 14:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775596298; x=1776201098; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jTzviRVlgSIYgl2GpgC+N28aqELoodZ3TQRnlTI8JvI=;
 b=d5Ra78LCEPcYXzXgWHLB2K2oNFL7j0eiBzTjW14JQUpsVdMgPlA7OJtgT0+aGJ3e+V
 Px9M8sSpCzD2fGVwAtZbqtOT76uKy3Th9zi2QSsuaq901OJMmUofk/nFKRFT/tIyKSS/
 BnlWE+6L9j7RpgCdW+BwdQKXpn8khPxcpjP8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775596298; x=1776201098;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jTzviRVlgSIYgl2GpgC+N28aqELoodZ3TQRnlTI8JvI=;
 b=LYEmO1z0FuS5s2e5xqW+tuFKZWjB4S0ZuGCkc+wlAuvzV5ij/2J9oN9TrIbtNmGwqZ
 OsMpwwPa8xMiF/v7S5qxHkyPqBOmR2j/DvukKnGY5t7Zcd6dQ489t/BN8wULtx/av5jX
 il6JcdFzeDu6PlCIjUw6WrZTF8IyuhF1EpixIKgDjdAeZBJVtW5Yt57bR9eHem44i3Er
 f8XojaGScxetFHAcGB8h3v/YbpX6Kn1nQ+DukixjBrr7lG+CNoSN5lMXJCB34CXvP5sD
 AoJC3rG7LY/Uzaz3VikLzsAGN/zxly03NS2+/B9k4nbNPOZ7NPU2sWhORISv4fmcL4VC
 KVwg==
X-Gm-Message-State: AOJu0YytaF/W3L/MjF2Utqwnsvfl6YIQiPIUma+IgJ1M1GJ3UGmqS5l6
 5s2Nv0sKtiolG+IJRTIUU8Kv0Y89QZrdp2UDgDPxUb3XUV+DSpSJDN6/s0AAJeFjb8YlSP3rPMx
 zFTyPaC4=
X-Gm-Gg: AeBDievxcCllFgDZn9GYIeVr4+ALfOq2qrdMWs/Sv7tKSCO0v5VFHFTZaYJny6u+H7X
 jlpVK2NqRH1RlALD6D5hE+0kx4sQm6iS2JF+nJoWsFm78H/onvg82e5PNGqIxg4nX8RovjG0Aj3
 MLzP6QmQq8hB2BhGrTlCYIwB9Zo6rIB3L5wbu5mzbnymB2fpcJJyB/ArBUHJN/ZYbhlgN/F6Q/v
 uxp9h3j6EwvHK65huRRNFX1kVF7NaablKm4ZqiPx1oBVjFd+GqqqfCkcTZ9trCwZ7MiLgLIiYdX
 G6BSAoTqW+QfXkA67FMIiSxlDyb97EeR6V7TQnU+AbHmzTBGcASTtQhs0Qh9ti01+AwLMB0M/Kp
 ouZ+MFOy4pNUSi/qEkvPfXcF0MsOIBM7OfOEo/m07Ux8x1YTg+LHhCwVnlYWSyFaoZcqCUT/D8K
 utdTCA755Wo21BT+6whNcROiCHkasmBf0kn4xUDf+EfWN7dmCgBmsX5USYum9S3PMVbgIW//bsU
 StL4tnnuTlDdTzergavOIk5srOWDDv1GQdSP7W2XAMLNvk=
X-Received: by 2002:a05:6808:c16e:b0:467:5571:1b0a with SMTP id
 5614622812f47-46efb1cf759mr9739009b6e.26.1775596298566; 
 Tue, 07 Apr 2026 14:11:38 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-472813cdbe7sm4351682b6e.7.2026.04.07.14.11.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 14:11:38 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.denx.de, Julien Stephan <jstephan@baylibre.com>
In-Reply-To: <20260407190552.2223177-1-dlechner@baylibre.com>
References: <20260407190552.2223177-1-dlechner@baylibre.com>
Subject: Re: [GIT PULL] Please pull mediatek-for-master-2026-04-07 into master
Message-Id: <177559629790.2127262.11217295552739603644.b4-ty@konsulko.com>
Date: Tue, 07 Apr 2026 15:11:37 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Tue, 7 Apr 2026 13:36:13 -0500, David Lechner wrote:

> This is the first wave of MediaTek changes for this merge window. We also
> expect to be sending another decent-sized pull request later for the backlog of
> patches that are currently waiting on dependencies or need little more time for
> review.
> 
> The following changes since commit 93f84ee022a8401421cdaab84fe7d106d83fdb4a:
> 
>   Merge branch 'next' (2026-04-06 12:16:57 -0600)
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


