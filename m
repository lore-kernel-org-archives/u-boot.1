Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 933DAC54ED1
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 14:02:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96E9C8329C;
	Fri, 23 May 2025 16:02:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JaiK3LwP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 423CA8329C; Fri, 23 May 2025 16:01:59 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A4CB83285
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 16:01:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3fa6c54cc1aso6044634b6e.1
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 07:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748008916; x=1748613716; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m25LzdGGMNIUMZZd1VuS2tEa1ucKG4NZxtvVlyDrmlk=;
 b=JaiK3LwP3s6v+P6fHppqrEqW94CcQQ6phKzEOhbNbUnqFFUUUk1XdoO1CBc/nr14FF
 lF/YEBp7hu1xHgEI53up4KXcFsA/sG+DkQN/St69VNJXbtRugUVQnnm16i2LE07oQC54
 +KrZttx7/qr5nplU+ydXB9rpd7Z7pysOX4p5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748008916; x=1748613716;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m25LzdGGMNIUMZZd1VuS2tEa1ucKG4NZxtvVlyDrmlk=;
 b=eeGCasp/TtfvFk1tv3CWwYXgP7dDpnBVJsKKATtiFAFZpBwPGupmgpYMeVfmbFC+N5
 F5kar4JLynHL99O+xL2skwTaBd6Vp0gI5eSQ4sZ3jDRq7QlJ9MOwAs7tM3YGg+2kTBti
 0ZsDA6BiaOEeZ3rWfU2QQ+7HTY9QJGO3HI3pVaJJ5hq23F0UZpixSMRDzKl7t208e6zZ
 df2Ixm9KXsOXlT3A2y3p3CcBvEeuhiiFN4PAi1nfB8XfUcg9pa67+lvxDzz+MrXZWIT0
 zAMXZ3Ds3/xz50eEJnqhL9pRwgoicCiew5zApDKbDpqnTLAmssoIH2QFlxs/XN0W1n3h
 2qsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJl/dD4kr1+dA1pgOZ025mN5yeRvyVU9yaSAP4LTuoXzLtKr3taczuuhpOF1zGuczxcwphxAE=@lists.denx.de
X-Gm-Message-State: AOJu0Yy22NwYy2cE0Obo2pLm1RnBPVVXLzTUEOtlAvwDCnZRDNk/roSP
 bHX643titx9bwo/hbeIqvHFbyS1dPBMWV7Ol3kY+Mu2wJp9Zc4kCswQqat0JUwGN3qU=
X-Gm-Gg: ASbGnctXWnKwFmvaCWlXkv+8R/wzN3rleXnXja7j3KjI5baEoG3kg7a1nfxu14zq1Ea
 lMz8lYwdOlKCdi8GviLHJj6wp9jszWRJ4MNrXX/kBs4nIl4z49f6g00UhLYe9zNFTlNwY1VNeM7
 VJth9unokyf1lzO94sJEnBZxLDT8ilYs4gV5Q1XWvJMPH+KE7eyrg6+wcYjVVU38GikKGk8OPGG
 hRORaq/9UQuHfnKoMkKiKxzUQlNtUuo3/9ux3Fyz3XUVtkt0Of54Dp77bOOajRHOCLbRy9NksRb
 q7zL05Z7vImSZ+B2yQEYbkADXqm3y/cWlGG1AhG761DrNwj+QO8FgA+9yniKf7faZ5GmRpHzNwX
 s/uKaV0gnU3U=
X-Google-Smtp-Source: AGHT+IF1Rr3V5QD0t80n29KtxwmgmOtQizLPvtICqliPzT+rlPU4tIdpT9h9OWD7QzrQGQ6lvOt9aA==
X-Received: by 2002:a05:6820:1841:b0:602:7078:df55 with SMTP id
 006d021491bc7-609f374f802mr17804992eaf.5.1748008910348; 
 Fri, 23 May 2025 07:01:50 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-609f303156esm3167610eaf.38.2025.05.23.07.01.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 May 2025 07:01:49 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Jayanth Dodderi Chidanand <jayanthdodderi.chidanand@arm.com>
Cc: nd@arm.com, oleksandr.tarhunakov@arm.com, artem.kopotev@arm.com, 
 manish.pandey2@arm.com, u-boot@lists.denx.de
In-Reply-To: <20250508105556.2205022-2-jayanthdodderi.chidanand@arm.com>
References: <20250508105556.2205022-1-jayanthdodderi.chidanand@arm.com>
 <20250508105556.2205022-2-jayanthdodderi.chidanand@arm.com>
Subject: Re: [PATCH 1/1] board: total_Compute: enable bloblist for SPL handoff
Message-Id: <174800890895.2288012.13647576475172987497.b4-ty@konsulko.com>
Date: Fri, 23 May 2025 08:01:48 -0600
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

On Thu, 08 May 2025 11:55:55 +0100, Jayanth Dodderi Chidanand wrote:

> Add bloblist support to total_comput platform for passing data
> from TF-A using the firmware handoff framework.
> 
> 

Applied to u-boot/master, thanks!

[1/1] board: total_Compute: enable bloblist for SPL handoff
      commit: ab0e1c11a9e2591371474d9567db80ffc9060e1a
-- 
Tom


