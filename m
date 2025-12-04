Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80308D2CDE6
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 23:12:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78B43841A5;
	Fri,  5 Dec 2025 00:10:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NDHEE2Ux";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3135841A5; Fri,  5 Dec 2025 00:10:42 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61E30841B9
 for <u-boot@lists.denx.de>; Fri,  5 Dec 2025 00:10:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7c78d30649aso1403284a34.2
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 15:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764889834; x=1765494634; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jJdFBoq2LFeCURcO0W5E451x21X8JhqE3LK0BLyDjWQ=;
 b=NDHEE2UxcRzXTi6QwqS+/e5m8dMGxpu4j4zdrH4jiUrWoZb5hnPcoY+EqMKhArGYeI
 IUKdCtiWjy4G5ari0pQ+sBzFYRpxh9yydpxTxA/3dvdQvhrzq66YP6pl2o6kpSaMcIkX
 4+8ipgnIMSBgjJQ95aG/nhdQ5xdDcJd5R08aM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764889834; x=1765494634;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jJdFBoq2LFeCURcO0W5E451x21X8JhqE3LK0BLyDjWQ=;
 b=clF8dS9f4f2LFIbrfQQqhh1yzWdvZs2+avXWTuYDFTnhHlLHkMkHM/owGGO2Uwhu7p
 nADHDhQTNrIi5KS9AM05TbXyjSuEzYmz2QMdMhnTtgvBpnJLj+mkeU7t9rIYgVo26TE8
 6YMHGKaKumk0z7t9TdrugHLj3nqWsmdg3pAnjIlREZlbZkQITj2ro665km03tELcOdIT
 ZufB1yDHgKmAZ3eESvaWSFQIKvUGxqYUnLIox4Wc+urvIdF3GNebjiUje7FP0vvHFWdW
 oGCFvBO1o9A8m7c8d2sNVyDXdetcUwuRgcwqOLMxwKqjt1/eIXjuurZdsWQSmSsDPYpq
 wKUA==
X-Gm-Message-State: AOJu0YxOiNcn4rnkRGkDex+Cnyx2qKEvHJaha4c/HeFohBEpFvXMYrxL
 ueWtY6KBxy/G+v3FygD6Qme5lJa8Uev/hk8GE78F+59bUQZpcncNNGP9B/eK7RASA2I=
X-Gm-Gg: ASbGncs0emgTWoSo88ijR5t/bq9jmD6KBLiC5WcXYnmOEXo6isFsdo5xVt499Nqlqx6
 EYpnvi5IDKKoWDcvlX39567s5tkiuPWAuG1fdeeuFiGJ9+N6Pmli0vL2KA6CaY51SXvPdz+SW1b
 RhnFG9cxcPoJBYwE3t+hzZqcFxfyQOZBu4ZDCv7lPKPAUMVYCs+ROYIPSdwj47jSbeByein8ORZ
 e5z98MT0m/GKUjFVSg8KctYa9vOMtR24jvWyJivsggVdpjQXZZbGZjkYYIuClCdZkvJ3j9uO/gW
 gZVqX+tJOgQ66prgL/rYkqu9Q6tYKbJyExysNUbtNfkYPr6yS7ew3K0MwHEKhBCXNecjGTMQ337
 dmhuVhll+654xSGZTqWXhCjKmoQ5JqTzLKGvtiS+BEpiNgwiviEL9bZ8cee6mDosWwcbQfWbMZG
 r8UJpFdY/s76byOse+q0dL0B7xvYYD9VQifHrVKFIdAxMD4E6q
X-Google-Smtp-Source: AGHT+IFR3TBCCuJ00Dl2jrB+cNluFdyajvRSEMq6r/DL/XgUVYh+V0PsTnVsk2ZW2PNQ+A5Xx4qv1A==
X-Received: by 2002:a05:6830:6d83:b0:7c7:6cf2:b72 with SMTP id
 46e09a7af769-7c94da2cda9mr4751605a34.10.1764889834152; 
 Thu, 04 Dec 2025 15:10:34 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95acfafeasm2360264a34.29.2025.12.04.15.10.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 15:10:33 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20251119145520.843195-1-trini@konsulko.com>
References: <20251119145520.843195-1-trini@konsulko.com>
Subject: Re: [PATCH] am335x_shc: Stop disabling device tree relocation
Message-Id: <176488983333.2091996.12232240987683275161.b4-ty@konsulko.com>
Date: Thu, 04 Dec 2025 17:10:33 -0600
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

On Wed, 19 Nov 2025 08:55:20 -0600, Tom Rini wrote:

> Remove setting of fdt_high to ~0, which disables device tree relocation,
> from the default environment. Doing so prevents U-Boot from correcting
> problems such as having an unaligned device tree and leads to various
> failure modes in the OS.
> 
> 

Applied to u-boot/next, thanks!

[1/1] am335x_shc: Stop disabling device tree relocation
      commit: 5b6432484df4a2b781e3156d2347e7db019ec6a8
-- 
Tom


