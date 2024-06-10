Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B925C27C5E
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 16:51:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D9738867A;
	Mon, 10 Jun 2024 18:51:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SMm/HzGI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8848885E7; Mon, 10 Jun 2024 18:51:13 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C8FD88663
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 18:51:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3d228309540so758263b6e.0
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 09:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718038270; x=1718643070; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KbnBgA/uettzTgZ8EZJCTGQ0PYbnFNAyJoZwRZiNLhk=;
 b=SMm/HzGIn1FunrUvJXZrh19y5xPMver5k6KvhpFYxl94As3u9ikD1mMU0JG+Tkd+Lh
 Y/Ch2s1yQdNMC/LMuMxGCxCjMYFEDMBY+w1a6Ov4A9ArQZANxfN1w9NQ55SGYtM5A/dc
 61tdBpHxjL/edLbT6wfZXS8M1Leua9wMXPt6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718038270; x=1718643070;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KbnBgA/uettzTgZ8EZJCTGQ0PYbnFNAyJoZwRZiNLhk=;
 b=bRgq+zdIqVxY3ZFEnKfeMkxnqGwyDWsicftIIbPsWlqDbi7DZ9l0wfu5+z1UZgT+RB
 MoObVNSeyDCIZTnCpLk9E8OPik8pFlOaS/2sJEvdwLwcf5c0F/FLeoMVxvtipbnVI/Kl
 nmVLQKC0D7vnHypR7TFYVSgTn7vJ5lY/Az9i+wXyuwxkQTAkQ+qOrQhsQuYHGOeB5SDr
 fqhYpIP1PASiI3k8PM+AJKGhrcgNEDNYqPML6BmF+BZQWLjAppjBpdEOnKnepgE6NSpN
 naoUyMZXicDpwc50t3u7GRut7DILfB0naumTAjhzANjVUrQSnnSYIHpGCeoO4Mdndj+o
 mpcA==
X-Gm-Message-State: AOJu0YyBZ24q6XU7Edsz4Gl/9yuDJAywzNN9QrjP05bI1grmAFXU32zQ
 ezbq6PLWxZ6qgt2MrI+Hi+HvPulmJnlZlGaDgwASg4FFXHtFGS4equ1qNJ8EME8=
X-Google-Smtp-Source: AGHT+IGjIjUy+Ax/nYstSOdJHndr7mMTCZZ5w6XDyjbQFCSm8yjWS1Rwg52yYlZRl5o3hNe0vIYbIA==
X-Received: by 2002:a05:6808:1797:b0:3d2:2a43:1c03 with SMTP id
 5614622812f47-3d22a431f7fmr3804912b6e.9.1718038270041; 
 Mon, 10 Jun 2024 09:51:10 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d20b66cb57sm1668475b6e.10.2024.06.10.09.51.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 09:51:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Roman Stratiienko <r.stratiienko@gmail.com>
Cc: sjg@chromium.org, igor.opaniuk@gmail.com, mkorpershoek@baylibre.com, 
 semen.protsenko@linaro.org, souajih@baylibre.com
In-Reply-To: <20240519130951.2558467-1-r.stratiienko@gmail.com>
References: <20240519130951.2558467-1-r.stratiienko@gmail.com>
Subject: Re: [PATCH] android: Fix ramdisk loading for bootimage v3+
Message-Id: <171803826930.2405130.4264880883452111384.b4-ty@konsulko.com>
Date: Mon, 10 Jun 2024 10:51:09 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Sun, 19 May 2024 13:09:51 +0000, Roman Stratiienko wrote:

> The boot_ramdisk and vendor_ramdisk must be both concatenated together.
> Without this change, Android root is missing some of the necessary tools
> to complete virtual AB OTA.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


