Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF1CC369A2
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 18:10:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B717841F5;
	Fri, 11 Apr 2025 20:10:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AiAXhM9L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B515841DF; Fri, 11 Apr 2025 20:10:36 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E2EF841DF
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 20:10:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-72bc3987a05so1203270a34.1
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 11:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744395032; x=1744999832; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ggdbPXbM4RmDkhYtycQyJ3CFWEkqCKjRaagEm19v460=;
 b=AiAXhM9LkV1erd9a5qY2S5iOHKoMp8cBPMJHHSQ6dWNUC03crEzMHxdtFF2nEVpVeY
 aFss+45OLwzuXMqZ/sZ6OJEk5ALYg6I7jxXkojnlnCq1uf6zDh9f/dh73/JkMfvXdrlc
 ifTAqq4ODxFuVqqqdKdXDH4I8KM8dAGH2zzTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744395032; x=1744999832;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ggdbPXbM4RmDkhYtycQyJ3CFWEkqCKjRaagEm19v460=;
 b=FhBD3R53vYlMzeN7Wh+BPAzhakw8w1OeKhN0RQJ/td6gG1orBk8Bx57NWoOK0INwV/
 Qtkfmct4Th//h47/dJRYyLhhitecYYM4xN91p7MLEkO9c342LPYUFKQ1sDvIaxlRRQC7
 X8LYLHc9e79Kxm2LptFOoItu6ZLTrUfht8tBxWQwsBzGMdXhq+H79UZL3uY9rSCp7K/d
 DMAOTqpTiCiqi6E/ncfycM21TIFgi+QNNdH0/b2oJZ5WBTYwGaX95s3iEW/Iyaw2oobr
 GZjcr0HeHQzbKe5uqAJ9gGFPEVe8Nf+B7TVS1NelpiNsH3EzRVcEjd6AHSHbN1aAoscv
 Mpgw==
X-Gm-Message-State: AOJu0YyM7fDwQpr9NUBYTaB/gB5Fcm3+XFGzrE+T8R9gV2rAP0Eg6XG1
 Sd1uJP90leXiivk5b2VauIgggypHXjFz4+2/SOIdxLOMWtn/S12ZiWdb6xwaw1/ZqPqfVCmEhmV
 i358=
X-Gm-Gg: ASbGncvEYkW5MQlSggva/3vUvJztpQ/yYTdvZVl9pxxeovuTY9lYKoHu2t7Y4MZKaFL
 AvHYOjNLzmXk2f2mDDF8GWi9Bn6O9+YFE6WNYHM4qDRJTYvZtlaE8jDKL1AcWT6jOggadRxXpn7
 ncsGOgsHSjQzvTnyDvGCm8m4X4TdMw1xxluLVs7VJg5KQhDzBJmJ1GzNqfo+pCP15AH1lbBHRGS
 tvIOByggItaiMjnDyifsn4AKVb50ObqkZbO+iqaYZUG1hCeQxKnzRTriyR55LVobSkNlOeJBeX/
 Bt2hIwayLLfvd0X/jJjYUc9xAmOBE7zdYn6RSl3di2VB/E8T48vQLG/I6RtSRCgexSHkBSLaacS
 Odmaio9khdV8=
X-Google-Smtp-Source: AGHT+IEd5rKrADDvkrLxHy0kK78Hk1hEmhu04ly04LoGuDPS+11akXXHYhtOSnCVzD0NA3nnDg1YhA==
X-Received: by 2002:a9d:7dd4:0:b0:72a:48b6:720 with SMTP id
 46e09a7af769-72e7c1a071amr4021576a34.14.1744395032362; 
 Fri, 11 Apr 2025 11:10:32 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d096a20194sm1261969fac.30.2025.04.11.11.10.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 11:10:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250411073923.GA5328@nxa18884-linux>
References: <20250411073923.GA5328@nxa18884-linux>
Subject: Re: [GIT PULL] Please pull mmc-2025-04-11
Message-Id: <174439503109.3256164.14288265479165709250.b4-ty@konsulko.com>
Date: Fri, 11 Apr 2025 12:10:31 -0600
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

On Fri, 11 Apr 2025 15:39:23 +0800, Peng Fan wrote:

> Please pull mmc-2025-04-11
> 
> -------------------------------------------------------------------------
> Support Sandisk and Micron eMMC BOOT/RPMB hardware partition resizing
> Optimize eMMC erasing time
> Simplify poll CD logic
> Fix possible Synchronous Abort for sdhci
> Kconfig dependencies fix
> Minor code update, return fail if mmc_complete_init, avoid uniniting twice
> -------------------------------------------------------------------------
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


