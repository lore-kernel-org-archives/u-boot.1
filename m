Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28523D10F21
	for <u-boot@archiver.kernel.org>; Sun, 17 Nov 2024 16:47:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5F2A8939E;
	Sun, 17 Nov 2024 17:46:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hIzpPH4O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D9D0893CE; Sun, 17 Nov 2024 17:46:48 +0100 (CET)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71B4689383
 for <u-boot@lists.denx.de>; Sun, 17 Nov 2024 17:46:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7b15d7b7a32so257124285a.1
 for <u-boot@lists.denx.de>; Sun, 17 Nov 2024 08:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731862005; x=1732466805; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3H1r4AwjoZeca02Vz55kxkf0u1AwJihUKgiJ/YBYGjE=;
 b=hIzpPH4Oisw5lmSrau1H+yPi3zEubqDT92WiHceDxmQu8tAkeCV3UKAa0Nc58qNqBV
 KugBiplv+uWVbpLRSokK36gvukYIeHemqxfO8NuBGjH7yO2B33YT7OkCkSipoU5sW8y8
 AdTQPZuqEVivQjDUJEo8xtgWXVgGCcVonOlns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731862005; x=1732466805;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3H1r4AwjoZeca02Vz55kxkf0u1AwJihUKgiJ/YBYGjE=;
 b=BtM8OU4UrS1KBOLcq+vM5JX7n/I0XzRWIhQDTFMpGfeF9S8MaPVJWvTY0GHOz5dRSU
 pUOZiEXNX1FJySjM8asrAUJcfPMFw/w7q/zjSzF7u6WwW2wMWL1G7LgwCYqRXrM6Yv5g
 E0nSdEjZvzjMD+WPnlYbCT6EsK0dyakQe+IBA0h6tWhfpvsR72c/RxLgDVSxpoN+PGkC
 IcBh0u1LytKHAWs0sgdmm3FyCFz01sCfGCw5fiQq8M1m54E5Ibs35XrL3Ct2ezo6N1J5
 EQaBJv3ClxCoYrydAQ3u6TWC6EEhUs4GACT5Nufa9dL5YQ1Ws7YoeUx7t0U/3T7IRLbx
 skKA==
X-Gm-Message-State: AOJu0YwV+xiRJB2+cuBxG5rhwHyq6VH/MfNvuwOP14lepVJpQxecDF5u
 3uSt0r/Qb5Bc4+blE8Kknh76Q30ESAaD8+WwPXQUgHyMR2JW5fTON2zCVgG7qT9KOL4RSblUYDf
 yPiY=
X-Google-Smtp-Source: AGHT+IGsKVrrQ3bMk19qz4RTgXrKvUIAknPooKG6keShq7vQqr2g/PGQj08SwmxSVMtZFqk/CwELdQ==
X-Received: by 2002:a05:620a:179e:b0:7b1:462f:46f7 with SMTP id
 af79cd13be357-7b3622ccab7mr1386731485a.30.1731862005459; 
 Sun, 17 Nov 2024 08:46:45 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b35ca4dcdcsm375768885a.102.2024.11.17.08.46.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Nov 2024 08:46:44 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Yuri Zaporozhets <yuriz@qrv-systems.net>
In-Reply-To: <20241108131329.15193-1-yuriz@qrv-systems.net>
References: <20241108131329.15193-1-yuriz@qrv-systems.net>
Subject: Re: [PATCH] bios_emulator: add missing includes to debug.c
Message-Id: <173186200368.3244505.4536559672746611689.b4-ty@konsulko.com>
Date: Sun, 17 Nov 2024 10:46:43 -0600
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

On Fri, 08 Nov 2024 14:13:29 +0100, Yuri Zaporozhets wrote:

> When compiling with X86EMU_DEBUG, the compiler complains that debug.c misses
> two include files. Fix that.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


