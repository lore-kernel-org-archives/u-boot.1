Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD9CEEE645E
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 19:00:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7D7984158;
	Wed, 31 Dec 2025 20:00:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WaO5fV7E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95C9F84131; Wed, 31 Dec 2025 20:00:26 +0100 (CET)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35B9A84120
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 20:00:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-3f9e592af58so6365582fac.2
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 11:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767207623; x=1767812423; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kufAIU5farnxYbYOwdHc+HU2IEWAs7OQJPeUxy4A8JU=;
 b=WaO5fV7EvZX3R63U6J3ca9m+/Oy0tAfGvj3KoSLFQ67haK64IU10JU4a3DK2puGFwA
 kY/94tSWUELcRgI/rMRyQYTeQp/V+Dc5k5Oy36tykwhzbIWyF4o8vz8KVOWUueRm+9Nn
 gQuV4xLwwYC6DODkGwNVerJzRohmYRkA6HZWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767207623; x=1767812423;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kufAIU5farnxYbYOwdHc+HU2IEWAs7OQJPeUxy4A8JU=;
 b=Ygme26UDjIpFAZ0vr9spoW47261q1hfJ6rPkOUj1Cv0+ccdAZPinlH7Dbk7HLW6/ed
 Cg5akd69Y1zzVCXzQ0EK07O4ojUbUkBtXm6pB8lqv801AX+ooFFg9u93jikleM5EpN+7
 myFgOBlyZRZ09lMb4fiwQPj1Egv/kwz7WciwXOythuxxbYJpwMzveQyf9k9jIKrks8tp
 Ir2h82nKADNWeQ4j6V83R9rGI6mwYU17MEehkcDckUCUAPQM7MCKKE37ArPF5LHygCgK
 W/NYINGAu22kQdYGIGOc1x/43DZzckFetioRXSttEmHlBaY3PnusOBnHHz4XDEfTMWN0
 x2yA==
X-Gm-Message-State: AOJu0YzqbblRa9lvRsA8h0nb6FTWQxmcJAy6YdMQYxzSjFuNeYoE/RMO
 yOpDxmBR8DC8/xkmz6nVXzSuKydgm1iwZ1I+24+9if2GgvCuvrT0prM9WSGmJnX5OpY=
X-Gm-Gg: AY/fxX4UeDXbnqiNMkYkix51VDsEx4OHU9rmV/nQvBrNHbeS6fj7cCRJ81tozpN8B2r
 2N7EYxVeXoC9wl71GVUCL1v05I7rFQPBC5tSurl+TK7IzXa22umBr3qQZOY1tl+9rvRhE+OnaAa
 3FQazqOhqXFMwI42o3b9Bbjj54VNY7MJLhxwUbWWgPj0Yhjheqrl4uZxvD31n8jrAmv9ta/i2Bo
 kDzF+5T66cBpMVf6ndPcbRtRRqPuJWLhK5rwQzocqdqMPmKFNZ0ZRvedyNWmysLmOtvxM/5sKWP
 5XDuQmZRoOO6Fvf0Mlbp9yY8mvxc6gRNybnOQ3a5BoQ8oHKlhdWFg9KWMW9S9/hVL88Gp4DHrY1
 RtQk9Ri6FddioAHWHMbHcu4trc96uH9EBKGRNOlx2ViLIInSDfOrbcmA5njnRPJO0xKHFc7ge0l
 P9o6BXXUR/kYZ58bKh/r1MhfXx6XMvVUIZ9YJv4BtIAbedfHbyTu4suokG8g0Yv/AQTpE1kGR8I
 0KWSidcS3uMErdEKEygUa72MRmE355EAkr4c1iTkk1Z1gNc
X-Google-Smtp-Source: AGHT+IHXNP/y9QrY24r5FKu1PLS/Dq8Qwf+57UHMVu5TO0GDIecu2KiXUNrepwXjuHmm+w8KmAdIXg==
X-Received: by 2002:a05:6820:825:b0:659:9a49:904b with SMTP id
 006d021491bc7-65d0e99d95dmr16500720eaf.22.1767207622509; 
 Wed, 31 Dec 2025 11:00:22 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65d0f69b9e9sm22099392eaf.12.2025.12.31.11.00.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Dec 2025 11:00:22 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: JJLIU0@nuvoton.com, Jim Liu <jim.t90615@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20251216024729.1031306-1-JJLIU0@nuvoton.com>
References: <20251216024729.1031306-1-JJLIU0@nuvoton.com>
Subject: Re: [PATCH v1 0/6] modify npcm7xx/8xx feature and bug fixed
Message-Id: <176720762185.3066473.9225396339307311395.b4-ty@konsulko.com>
Date: Wed, 31 Dec 2025 13:00:21 -0600
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

On Tue, 16 Dec 2025 10:47:23 +0800, Jim Liu wrote:

> modify npcm7xx/8xx feature and bug fixed
> 
> Jim Liu (2):
>   gpio: sgpio: modify persist check condition
>   arm: dts: Add SGPIO node in dts
> 
> Stanley Chu (3):
>   watchdog: npcm: Support more timeout value
>   pinctrl: npcm8xx: Add smb11ddc pin config
>   dts: fix typo in the pin name of GPIO191/GPIO192
> 
> [...]

Applied to u-boot/next, thanks!

[1/6] watchdog: npcm: Support more timeout value
      commit: f74beb8dcf325707dcf6b4f6e260c940236f8067
[2/6] pinctrl: npcm8xx: Add smb11ddc pin config
      commit: 78dbe92cb0bd3ca527769dea199c9ab1300512ab
[3/6] pinctrl: npcm8xx: Remove incorrect spi0cs2_pins and spi0cs3_pins
      commit: 05d60262951df7cd204170c284d26ba5257d099d
[4/6] dts: fix typo in the pin name of GPIO191/GPIO192
      commit: 73a7155ba3e8e8a78dc2b65f815079b99ec1f41a
[5/6] gpio: sgpio: modify persist check condition
      commit: 1f6b701959a640646a0df98b0d320fd480213ee6
[6/6] arm: dts: Add SGPIO node in dts
      commit: 80430530996b672c5ea30257b95f3682f2d326cd
-- 
Tom


