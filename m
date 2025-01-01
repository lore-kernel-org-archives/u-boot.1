Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36EDCE77188
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 00:59:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD13B803AC;
	Wed,  1 Jan 2025 01:59:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HImL40Rs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E547C803A9; Wed,  1 Jan 2025 01:59:12 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFD078021A
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 01:59:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6dd15d03eacso94523006d6.0
 for <u-boot@lists.denx.de>; Tue, 31 Dec 2024 16:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735693149; x=1736297949; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FkUEfvdMqO/1BM4LZqwNQ6SZKPVz0cmpHm7VwcKqlCs=;
 b=HImL40RsRqwWCstYU2S16wyk40m1/mycAUOOUqGS+H7KUhdqHl1IP6prJhVXAex023
 r/SZaX0/7FEAQOWtBHB0xhjUj5DrtEaJb4OspXHAoQLqtO5aFKpE+Ce64YWY6NyxFgls
 2RPpxuagCLYzqjacmAKZpQq1uZTe0UnTqza7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735693149; x=1736297949;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FkUEfvdMqO/1BM4LZqwNQ6SZKPVz0cmpHm7VwcKqlCs=;
 b=XrX5W8CoqzmxQPuIXlqAHUBrCoUdMOnRxrOmmJ917rVpIRMYEXlzU6yLZ7y1T0r+Rl
 EDkCAKYXWQOPaihA0KTH3G6pT5ZAyRVu93YuGgLJ1XjodAQl1b75Tp6hauadImwzg3bx
 rRUvtyGGskBhTDOW8n0/I+TJP7+CTIoS07kg1/UP2w+pjqIWNaTsE2a4A1o2QK/1hBf2
 WIxj18VYIt1FQwWGD+Ym2SByXmPcEDgdjAOmYgTh4ZN26utuHXipLqbi4rnN//DENVga
 1+kfaxWl1L8rzGzliJhMWWyjOm6fOYh8vDBR/RqM0WKaO4JoY1KqSDL0fcLZqjvPs4it
 qsHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvbXh22tV5gxJwq0T0h3+w/MnZF9LBawDI6tsdSQgiNXbm8X3NLoOPFPuT9G4nA/HnVxF3Qk0=@lists.denx.de
X-Gm-Message-State: AOJu0Yy9f2I+CU9PGeS8zdgX2S9hqQNIrYO+ppPWk2R8odJkYJZA9KBK
 DnVruqBrS67j060qyLhlQLy42AuB7ykrWWmwZ0/aQtw4axqJ1U5+hO5jrL5cUtKDPzRhqGSF2xB
 SSoE=
X-Gm-Gg: ASbGnctdGFLRWJjLugLDfDD2S8LavE2xQcd98OWkvDVYQZpBVeCvGqI2pb19GB/ukoi
 B6SpIfSHXmhCpOxLbuVtasNwpqUWNze/BCD9I5yE2ogxd49/9FvflDRJise25gN106wzknlvcM6
 t0CfySLUn4fyobeAgLKT/M/4ZPNVjeWxSsTuK31X7M3ZNfH7kYlwj2+BU05KYipFsBhg9nH/Sxe
 gudnMSEA6P/wUws8q0K5+inxNbrMtC2PPQvnPiMXOgt/zuRQ8w7z00B
X-Google-Smtp-Source: AGHT+IHVI6CWVBSEODKaGl1+iQ+z1wErx18CrmptdI/iEpRgTzwVvYZ/Rr3dxCaB/KNYNQawWTcgAg==
X-Received: by 2002:a05:6214:5bc7:b0:6d8:8a0b:db25 with SMTP id
 6a1803df08f44-6dd23618b5bmr659434476d6.21.1735693149578; 
 Tue, 31 Dec 2024 16:59:09 -0800 (PST)
Received: from [127.0.1.1] ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd180eacb8sm117147896d6.20.2024.12.31.16.59.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Dec 2024 16:59:08 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
Cc: Neha Malcom Francis <n-francis@ti.com>, Aniket Limaye <a-limaye@ti.com>, 
 Beleswar Padhi <b-padhi@ti.com>, Udit Kumar <u-kumar1@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, u-boot@lists.denx.de
In-Reply-To: <20241217-b4-upstream-dm-pre-reloc-v1-1-ccd29165bbb6@ti.com>
References: <20241217-b4-upstream-dm-pre-reloc-v1-1-ccd29165bbb6@ti.com>
Subject: Re: [PATCH] drivers: firmware: ti_sci: Add DM_FLAG_PRE_RELOC to driver
Message-Id: <173569314732.1610380.2851057625410344610.b4-ty@konsulko.com>
Date: Tue, 31 Dec 2024 18:59:07 -0600
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

On Tue, 17 Dec 2024 14:24:37 +0530, Manorit Chawdhry wrote:

> Currently the driver relies on bootph flag to probe it during PRE_RELOC
> stage but with the upcoming cleanup of v6.13, we don't have the bootph
> property in the parent nodes anymore and ti_sci driver being one of the
> parent nodes required during SPL stage would end up hampering the probe
> model [0].
> 
> Add DM_FLAG_PRE_RELOC to ti_sci driver for mitigating this issue.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


