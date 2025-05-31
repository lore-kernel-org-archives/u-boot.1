Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58CD0C5B549
	for <u-boot@archiver.kernel.org>; Sat, 31 May 2025 14:22:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CB9D82AB9;
	Sat, 31 May 2025 16:22:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="e8Zget10";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 695C782AF6; Sat, 31 May 2025 16:22:41 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CEBF82AC4
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 16:22:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7382a999970so151530a34.3
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 07:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748701358; x=1749306158; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wA5W4cKV000gHEhqiVTKEje2ZYOgOdagoJYU56Zzduw=;
 b=e8Zget10DO8+wTI/AGt+t2gmfDnQVMWgvMRzB7EG0aQILFTuLSEFu49Psw06NRK98c
 1TDT992hPdp3fjdhSjeIYsb2Zx78DZkfXtsSx5mABbrj7VreWbk4CfQ6YZ1XuQMygSQC
 1Y64V3dwqfhMhkXMxASAJY7icZN5cWTZFijD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748701358; x=1749306158;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wA5W4cKV000gHEhqiVTKEje2ZYOgOdagoJYU56Zzduw=;
 b=paP2cMUvImnhppLk9+10X/2ezTgoS7eqNgRnp1i7O6O8hgPtF1zz9r5uCSyq/GDU74
 9D8NJ8NAniHcbGF9o+E4MXnWBzYCotbNxxx4kdi9m6hW1ujE4BHM2+f1WUSWrmvBXkKn
 R/7lHCqfLGCR9rpGAFx7dgcMHkFWBnqXUsUQGI4aMDj0OHq4oRk0DcRnYlqnaq9pHpXS
 JJYslwdRlp3xXvt56A4H2cFyWAj+M+o5vV+0i3TISs/XdBmrgVWGkgsIYl6xVUbIg9Jr
 hyqdKiTtYOyhmDsVGZmk05SlMFMNpZhSvnlinAfX3caSRNDAVvOVlUXPoD4MFL3iBBCs
 tl3Q==
X-Gm-Message-State: AOJu0Yx7h77jqUvDEz1smRvMhPVkVYnT4pqfCNYTaY3v1/wPj9ytaCWO
 SNYEL6/9FL96TcpoywgHqp/F+ovF+yq6Eu+E2l68p/Cce+Wwi93bSloQBOHWBDX+q/8=
X-Gm-Gg: ASbGncv+lUoaw8AbCyUHgF5+HDTL4hB3C59vSnhM0kez2IvbpCKu3/LZbbJjvtBRkWW
 xUtycCl8ZDejL4CZBtFhc88VjEY6aKoBkOHJ/r5pkZCC9GEHUUF1veh/Ayr8rmLqBAegqkI94t8
 wZEFpKpu+nD9m0O0med0Y9eQYgJqOTd1atknikNbLEgVt4DvvxmDbKUbInQoBOobY5bBG/il2sj
 aLfsno/vRu72yGvS/LgZz2OPcKIrQCcCkiXfzJLMziYvnnb7Ju/hyeafYbw1jLFtETcVwfrwgUK
 4GYQ6PwmUWR/o5Wrk4EtRT+kpYoB11nHfEMOY1yBBEq0VbjBX0QKhyZMQ0c7VfeldB55DTcIlvo
 3REjknI7JrGP/rH2ZujETiA==
X-Google-Smtp-Source: AGHT+IFtpLJDUZbxXCGy9LFM64qkwPNCB8Ne3o2459xsoK/ezHC91GDyz8ibH/BuZm0seZcfQ3tKNg==
X-Received: by 2002:a05:6830:7102:b0:727:39d7:b0d5 with SMTP id
 46e09a7af769-73676b58cfcmr4853268a34.15.1748701358059; 
 Sat, 31 May 2025 07:22:38 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-735af855ce7sm938083a34.21.2025.05.31.07.22.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 May 2025 07:22:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Benjamin ROBIN <dev@benjarobin.fr>
Cc: sjg@chromium.org
In-Reply-To: <20250520203515.25839-1-dev@benjarobin.fr>
References: <20250520203515.25839-1-dev@benjarobin.fr>
Subject: Re: [PATCH v2] bootm: Fix bmi->images pointer not initialized in
 some cases
Message-Id: <174870135655.979488.17935939698366684135.b4-ty@konsulko.com>
Date: Sat, 31 May 2025 08:22:36 -0600
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

On Tue, 20 May 2025 22:35:15 +0200, Benjamin ROBIN wrote:

> When building with only bootz command, without bootm, images pointer
> inside bootm_info structure is not initialized. And since this structure
> is stored in stack, the generated error is kind of random, but most of
> the time this will generate: "ramdisk - allocation error".
> 
> Also, after analysis, this problem could occur with the command booti,
> if the command bootm is disabled.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] bootm: Fix bmi->images pointer not initialized in some cases
      commit: b8f282b8e0ee1e2c36694071c26b6b796f50c0a1
-- 
Tom


