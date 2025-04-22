Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1049EC369D1
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 21:08:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 677EB812BC;
	Tue, 22 Apr 2025 23:08:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VZvPaBFc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB64E810F4; Tue, 22 Apr 2025 23:08:21 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BA82810E8
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 23:08:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-72c14235af3so3727039a34.3
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 14:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745356098; x=1745960898; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JAXdix1kKwezPmn/wdZ326aC/G0GDDYI7+qoFCZnOhc=;
 b=VZvPaBFc1aUxBuRVhcXnXE3y9goLQFoPEk4nR5HjQJe7YvbS6+Xw7X3bYQegp28M++
 0rQZmVdalo4EUtTl2fQqJi771xwh7iZ1D2c7a8C8Q3ItU2LvOASBRNPp/8JE5rBMN1BV
 j+sBsbC87kS5uUFAEcLKR29ARBaPM8nRXt6Ps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745356098; x=1745960898;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JAXdix1kKwezPmn/wdZ326aC/G0GDDYI7+qoFCZnOhc=;
 b=TyBfYOsaP7HVGjHr5vGZP/bot8ZQ4POb6cELacAo2cu9W6tkuW1zfMiciHK7I+xYrD
 ujVpgTriWO/8ESdMHyk4aejJ+TUq/+bwmYMrk/+tEjlvCUITmysZqMk5oilsuR/dCvo4
 0v0Y0s9p0b6axeUkFLZJljyCz0oKQFUIQHKdhDGJelXaYqW+aN0bOQboKv8snWRI2xet
 HgihwxR80aEne8GrgiYkCokQThGqKdfYOtWH/ohY54sARLarFyzW5MDhev0G5S1gi9f5
 4TJFmB5SCnQVczoW2kgVfr/+ipCqzkI4ASZrNsJI3Hr5Vhu+bbYbqx6PY5op+0BBtoxk
 dwwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVn1wJrBbWfRejBQslsJeKP/rFVaG6uyTRSkqRQIExDrZjRE2IGFDv77r4eQvYyYKJ220/xtt0=@lists.denx.de
X-Gm-Message-State: AOJu0Yw0ACkbAMZ9NoEsdmqSPvMv5Md3aly8giU5OiqeSdXFeS94zcSX
 tES4u85ndNj+JNj0g5O7RjYn+JXaToWZOFGE7yREVu4SeF/qsDxbNlukjV9vGSw=
X-Gm-Gg: ASbGncsuDriR9EgS5gikOv814b7VxPHm3o5exM1jkJKC5U6VhU2M1mWNLPSgXD057S6
 ficEb1Jj7K6/YXlBA+MiFThjZq4wbg03og4gPMSWpNAJQaGRaKBScx7Deft1vo2tXeTZuif+LU3
 6ysDNdpSOiHN+Q6W9wtdpKgh7tMzDt62sRcPG9uVdZFGvPSutbPKUvTKNX9P9IQgfTZfi1dWEU2
 ZFYHcdjbHUqJd1ORHje4tIct6EUGx7kkk6vKMGBBJM6rxKdmGPE2OQBkTxFS0Fs2CTHp6UuBlT4
 45j/Ib0BXKcz3LmUqxFpyhcL1//cS7rZDYtaFMgIUVA0SxxHWsCs6q6wsDd8IS6Fo42ZdMI+3LR
 +
X-Google-Smtp-Source: AGHT+IGvWWrBAppYervdsrL35atBqLoTOQ3geAUxPgJ7QcWknF73pxdbG2KfRHSjnsSUFvIYxrnN3w==
X-Received: by 2002:a05:6830:61cc:b0:727:3f3e:53bb with SMTP id
 46e09a7af769-73006336b1amr10398329a34.24.1745356098352; 
 Tue, 22 Apr 2025 14:08:18 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7300488495asm2128388a34.43.2025.04.22.14.08.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 14:08:17 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>, u-boot@lists.denx.de
In-Reply-To: <20250420085929.36226-1-heinrich.schuchardt@canonical.com>
References: <20250420085929.36226-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 0/4] configs: ACPI enabled QEMU defconfigs
Message-Id: <174535609744.3811396.2471566515633936456.b4-ty@konsulko.com>
Date: Tue, 22 Apr 2025 15:08:17 -0600
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

On Sun, 20 Apr 2025 10:59:25 +0200, Heinrich Schuchardt wrote:

> For QEMU we have developed supporting passsing through ACPI tables.
> This functionality has been broken multipled times due to missing CI
> builds.
> 
> * Two new defconfigs qemu_arm64_acpi and qemu-riscv64_smode_acpi.
> * Assign the defconfigs to the respective maintainers.
> 
> [...]

Applied to u-boot/master, thanks!

[1/4] configs: add qemu_arm64_acpi_defconfig
      commit: 2d6cf24d70ef1909e6dc037f47e8d5bfb76e417e
[2/4] MAINTAINERS: add all qemu_arm64* defconfigs to VIRT
      commit: ac8b4c063d9549b7c714925f6e8170700a400c5a
[3/4] configs: add qemu-riscv64_smode_acpi_defconfig
      commit: 72d54cb7e63459b6d7e7fc57290b69cd0b9d85df
[4/4] MAINTAINERS: add qemu-riscv* defconfigs to QEMU RISC-V 'VIRT' BOARD
      commit: d7820b1cc6d7cbd36fd7b4fb51bf5accacade983
-- 
Tom


