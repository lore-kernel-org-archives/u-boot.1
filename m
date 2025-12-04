Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD97D2A536
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 20:29:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 134478416F;
	Thu,  4 Dec 2025 21:29:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="arBTj0+k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7975F84144; Thu,  4 Dec 2025 21:28:56 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 910388412C
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 21:28:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7c6d1ebb0c4so1116834a34.1
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 12:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764880128; x=1765484928; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DY/+CKzae7BobHhNPXEEWlZmcaMeKQDPQjVksUoX/uU=;
 b=arBTj0+kxMBVoRpnj2aNTzNV831dFwd8KrwwJKWUIkP+cmlecqMHvTGpSsLZ3w8wq6
 PPh1CuGPA8HNbtxxcYXq2dg/IvX54jr9f46AvgqpJ79T9fNWq+Jsk5aMLfur0k2DaPt7
 /yKwadaymKTLF+4SkonaKY5ukR9CrlRFC2a6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764880128; x=1765484928;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DY/+CKzae7BobHhNPXEEWlZmcaMeKQDPQjVksUoX/uU=;
 b=wY4NSwgpHBZiTZbBW0Mnsf0+uZz0Jrw2TSNUOtLskbBnaqXd865Xan+68U8PpXzwGA
 R66WjYsZxlBoV1ljd0aQ89UW6qLSCHovVZIGEfxwcB3rFrZSNfmXoL/kle1MaVsKTQRe
 s1hOGxccu19yZ3oY1xzmmSQyADRHTNyrHnx9zgIURRAZ0JRxkxyIzJJGAaPKT7bg7SG1
 oKsgYF3J6upQxfuGM/H0LYM8FQ/DVuHp4hLBs0+bVLG0oTNAvFBEBSU05tk9n2OD+tBK
 BK4b4vC09j//gJq5c4mmMfJkPUQ8s5aNhiC38ah1hnUrfiIWgSyPK0faA/hPm3HFj5vw
 jrCQ==
X-Gm-Message-State: AOJu0Yx5ptGXG+S7fisoG/DCicTrziY2d0arYD2k9aFsHGmALIWMdHav
 vnQ6iLOSys3uwv71d8Db9GnsH6pzOFZWpDzZ+GhV8BJNHgDFEEFm6B/YpYpKXJf5eB4=
X-Gm-Gg: ASbGnctC3EZUss8XUgwbFc8n9I7lO9QJD6IeVco3AJ5+yN1lCisOLbvO6bjMUdm+lVZ
 rnTvQclykqZxnnVwJIPQ3ObqTQbAG/eSVzNQkjOIx2bEWef+ZA3Bcs4So7F5Lt949wqKVnK3TEU
 d1VvbKdZ/OEPJwsft6aIpTTz7NjAbkgzopnRWOjnZoCzX2NX0S794oxNsI1Tac75nmW/9Oj/CHm
 KzCWcNsd1iTKZ35Xf5wCM7wxP6/YHUaNNYzJa28qPX1W+75Qju25jmJB7Is1+O88xUB+rJYVxtq
 scgnZc/HWwQkyEV9URNWeujiY7Oaw7iCsnbzhCce1Lh+1QG2MC5x0UbcO/VuFkEFWnQX4ZlcxjP
 n5DyS7x+qg5dy4DYKOdexG3D4wOAwsotKGVCjCEKhQrtLUK1t4x3qx69nmHhntkw3iIwFiiOo3D
 pYVXHUCp/PH7Mv6AyPgkqzuCva+txCWH/sCLC0kVMfyJbXT1t+
X-Google-Smtp-Source: AGHT+IFL/nEpuAZDLN5TXdCPGRuKWGYNBGj6KktmLOsDPUxxcvBksqXN10hNaDkORjRwIHwF0UMUaw==
X-Received: by 2002:a05:6830:4410:b0:7c7:6348:5946 with SMTP id
 46e09a7af769-7c94da26dafmr5160460a34.5.1764880128349; 
 Thu, 04 Dec 2025 12:28:48 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95a8f8d0bsm2336131a34.5.2025.12.04.12.28.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 12:28:47 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Wolfgang Wallner <wolfgang.wallner@at.abb.com>
Cc: Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Abbarapu Venkatesh Yadav <venkyada@qti.qualcomm.com>, 
 Bernhard Messerklinger <bernhard.messerklinger@at.abb.com>, 
 Christopher Obbard <christopher.obbard@linaro.org>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 Greg Malysa <malysagreg@gmail.com>, Heiko Schocher <hs@nabladev.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Michal Simek <michal.simek@amd.com>, 
 No generic patch CC mail please <noreply@example.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Stefano Babic <sbabic@nabladev.com>, Sumit Garg <sumit.garg@kernel.org>
In-Reply-To: <20251202092513.71879-1-wolfgang.wallner@br-automation.com>
References: <20251202092513.71879-1-wolfgang.wallner@br-automation.com>
Subject: Re: [PATCH] Change email addresses for B&R Industrial Automation
Message-Id: <176488012675.2061624.2706868928832272572.b4-ty@konsulko.com>
Date: Thu, 04 Dec 2025 14:28:46 -0600
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

On Tue, 02 Dec 2025 10:24:58 +0100, Wolfgang Wallner wrote:

> B&R Industrial Automation has been acquired by ABB in 2017, and this
> will be reflected in our email addresses beginning from December 2025.
> 
> The email addresses change as follows:
>  @br-automation.com -> @<country-code>.abb.com
> 
> The existing email addresses will be valid until December 2026.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] Change email addresses for B&R Industrial Automation
      commit: d9a765222dae01ea24fc3240cc05745b4b47c698
-- 
Tom


