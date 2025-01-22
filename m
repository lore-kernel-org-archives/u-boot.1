Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE912C02182
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 21:01:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50D968076E;
	Wed, 22 Jan 2025 22:01:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CCMfWZN6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55DF280762; Wed, 22 Jan 2025 22:01:02 +0100 (CET)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50CA18001F
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 22:00:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-46df3fc7176so2087341cf.2
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 13:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737579658; x=1738184458; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E0U8Ex4j5YkLc0lX0bqOSpX8+3Mo4H/l2nu9Yt44XxA=;
 b=CCMfWZN6oiUIJSvbpmdumHvBZhmRC7Z3+iqTl2xD/m+dbKufLUDW3udzfDasqYjwpB
 AVPyga/8/EotL3rIbU2d4etzDQKpBe791WPC0/cpnqb372aZM2uudLN5LqIRSM1wHu7m
 0ksHlU0CCorEWV297WHaWaWI4tiFGkfL2PnR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737579658; x=1738184458;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E0U8Ex4j5YkLc0lX0bqOSpX8+3Mo4H/l2nu9Yt44XxA=;
 b=b9If8tccht8wMMEkDurN91Xpa2tRG2bZWa9oAMwjRhFu0KQZhj8LYtcuYoQOsTaYbS
 uwWEb9RGnBm4u2Ke6LrUVDh3qsL3lwAkndErXcehlmWrvsE+Jfv5Zw1q7cfTSF88b5Xi
 1uvCrcVDDaijopkCH+rQeMeI7VVDduMhVy24HBGmxtHllP07s/1dytj4ePe9BWjq+BUh
 fRbwo3CDUIxBM6HfjoSoWPdxZWKCsmWfLe72zicWZssOxm5SfCpSFDYS4zzZcB/0qryE
 uwURYM1F/nwWT82Oa4K3p167aRpfNZkUWSODIiw62xj4srCZhm7YDj1+t282Cs5ikR9q
 c5TQ==
X-Gm-Message-State: AOJu0Ywa+u/mhkuMK54DnjD85qfsBMIvtLtbwonGO/ACSOzQ0uRk2I9d
 sUN4y1i0q0HFf8IIvc0NOwigAfimrYc/ApsBH/oteCv97OTZIFQRbUa+1rjl8Hk=
X-Gm-Gg: ASbGncttkL0muwO4/5zbr8xDbrJMGmTklaiELLRmdcEQbrjxjKAw3H1Xzh49GZJhy1g
 AkKAY53zx504sj1go256mDLyOm8nDYI2Avi1ttFJV2ZJJd7dMtab+D6MIPvYEkvM6TQzlCVmbzu
 t2W3/zQvw1lon9qUnwbs3NBVuF0BN+ROvrnAMtSjq2PCeFGQikRfaxc6PaZ7Ic1hDD025ZBEfAB
 Y0NydgQhM5/diKw/ZLWKxh/Q/0haQX9//QJgBr0fnOLqQrZt8VFZqm0ofmDJMSOcjf8
X-Google-Smtp-Source: AGHT+IHfgnmz8IO29QSaBh7kkDo6s9+VJbEvT2Lm+fOAMi67QbXcIE9bvz/lpzqoiu89wY3TSjDHYw==
X-Received: by 2002:a05:622a:eca:b0:46e:541b:c80e with SMTP id
 d75a77b69052e-46e541bcae0mr43428411cf.20.1737579658203; 
 Wed, 22 Jan 2025 13:00:58 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e10305328sm67560021cf.32.2025.01.22.13.00.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 13:00:57 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Ronald Wahl <rwahl@gmx.de>
Cc: Ronald Wahl <ronald.wahl@legrand.com>, Vignesh R <vigneshr@ti.com>, 
 Pratyush Yadav <p.yadav@ti.com>
In-Reply-To: <20241211205104.16099-1-rwahl@gmx.de>
References: <20241211205104.16099-1-rwahl@gmx.de>
Subject: Re: [PATCH] spi: cadence-quadspi: fix potential malfunction after
 ~49 days uptime
Message-Id: <173757965689.68186.8889251997771060488.b4-ty@konsulko.com>
Date: Wed, 22 Jan 2025 15:00:56 -0600
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

On Wed, 11 Dec 2024 21:51:04 +0100, Ronald Wahl wrote:

> The get_timer function returns an unsigned long which may be calculated
> from the ARM system counter. This counter is reset only on a cold reset.
> U-boot divides this counter down to a 1000 Hz counter that will cross
> the 32bit barrier after a bit more than 49 days. Assigning the value to
> an unsigned int will truncate it on 64bit systems.
> Passing this truncated value back to the get_timer function will return
> a very large value that is certainly larger than the timeout and so will
> go down the error path and besides stopping U-Boot will lead to messages
> like
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


