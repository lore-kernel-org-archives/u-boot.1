Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9395BE9270E
	for <u-boot@archiver.kernel.org>; Sat, 27 Dec 2025 20:12:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84DA183D0B;
	Sat, 27 Dec 2025 21:12:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dsY8jkaA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CCE583C6C; Sat, 27 Dec 2025 21:12:03 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E6EF83CB9
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 21:12:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7c6e9538945so6054571a34.1
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 12:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766866319; x=1767471119; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H4U93DXwl+1GePoAxMp2x6eEGk77TTQGHRZcwiUxjQk=;
 b=dsY8jkaAbzlNBYvUvXAtb5oa3pGeYGCSYTx30ELYaxbf/YC0nurj/067f5lDQJ2sAe
 WMIYByjmIGdGy+FpgNwoWacvfPSQ15Uu6/gXqu1Hh/lhI0f7MljWhDlBrf+6IUgRxEMd
 dyadg3AoTIaeFnOTSXcQlAPoyoyVIrMl89POc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766866319; x=1767471119;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H4U93DXwl+1GePoAxMp2x6eEGk77TTQGHRZcwiUxjQk=;
 b=qi86T1wY8QfYezmf0XUqPJ9v2sN5guV+M0j2LFqHUxHvGcBAkYcOej8yOkJnTLKQm8
 lt398Zwe2naEX+8PjxI4873rrcJHyRMOq2A2ua4zeGTiQVL34Shj3ecALuhuDj7Mhc9P
 HZRnpqIxatqUUJN1WfA2E6DHnbNVKWBIMxvHZOIUpKrNM8xaepUw3wMKtNJBgdQ17jHE
 ZxtRjZE4Quqjlwo/8Auf2HVDL2LE/J7saG8OyJJPcwoDBYI2LbFEdBEJeozkk0KkljvV
 jnH8YRqFlVWC4kQU+yDL+jqeJYGdWXZaCJ6tvo3RdsXhcPqJNV5OJrWr/FU0OPUnx2rF
 byQA==
X-Gm-Message-State: AOJu0YwJffXDAP81esiCQq4bfCzC0umH8F/nFlFNWnwDcuhiqch0mIrr
 9i7mRpFm+Oe5TGiKOeBbyguSAT/g0W2VcO9Mtzo46oyJO5SMI/7TNMzQxNEpNLfuos78P1xVx0H
 RfeX023Y=
X-Gm-Gg: AY/fxX5iRfcuuB6GmsgPn7M/24up7ekISt2YMOAMQT0TXIHqz2N70n0R6cv7OpXiDmX
 icSnuTF5LbgM5ATc3Tcj1gvGqF9egsuXDMQ+3r6S3ooGEJseIUCOyMZ2tHSIfnzAG3r6SM4jBwJ
 jYEkS1zFN1yiieOHvWYVWBXkOwFgK0/aM4WqUJeGewVRk9GNd1FoG4cjo7bMAduw6kTyjuaGaOp
 yfxAqO+OoYVSDcoRlMvyYhakJBw6T9Q2kxz6mQ2NSSIwN3vz5kaUpl1GlDm/knp6FVFUwILGUek
 VNmwRuoJrxufr7sTLf11uVHJ4Cu+feEV4lSXVwNG4HbU9D3MncFCIuT7jnEsGQXB91Bf979HAsd
 4NwfBwAY/VfaavW2lwVYAeHnPkoepQIr1+RJ7CXamVSsG0uC0Ngl80l16MNgVnmQMse/YXovomd
 NC0qZ4gx5pKdnRNcsmRD6UBoSnyEkLtoppte3TM/EZWCky9D8Ri3Ga2w+wOWw=
X-Google-Smtp-Source: AGHT+IGPpjfMYvYpxpbO9biUZLFSVBwhQBgr+nKNeMhhYmQbGOLNYcO7nGAlk6dgAEMLGIBryPlFMg==
X-Received: by 2002:a05:6808:189e:b0:44f:ef44:9cc4 with SMTP id
 5614622812f47-457a298b8d7mr15849610b6e.32.1766866318808; 
 Sat, 27 Dec 2025 12:11:58 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3fdaa8d366esm16223040fac.5.2025.12.27.12.11.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 12:11:58 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20251124145128.8624-1-marek.vasut+renesas@mailbox.org>
References: <20251124145128.8624-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v3 1/2] i2c: Inline i2c_chip_of_to_plat() into
 i2c_child_post_bind()
Message-Id: <176686631767.2992512.11810242683589941190.b4-ty@konsulko.com>
Date: Sat, 27 Dec 2025 14:11:57 -0600
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

On Mon, 24 Nov 2025 15:51:00 +0100, Marek Vasut wrote:

> The i2c_chip_of_to_plat() is called only from i2c_child_post_bind(),
> inline i2c_chip_of_to_plat() into i2c_child_post_bind(). Drop the
> if CONFIG_IS_ENABLED(OF_REAL) and depend on if (!dev_has_ofnode(dev))
> which does check CONFIG_IS_ENABLED(OF_REAL) internally too.
> 
> 

Applied to u-boot/next, thanks!

[1/2] i2c: Inline i2c_chip_of_to_plat() into i2c_child_post_bind()
      commit: 5b968372e2136206585d1b0a1c9e9e683127c057
[2/2] i2c: Avoid calling dev_read_*() if CONFIG_OF_PLATDATA=y
      commit: 48e56ac26dd925984d599ce06cb769dabb1251d6
-- 
Tom


