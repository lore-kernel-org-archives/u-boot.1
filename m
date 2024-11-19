Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF86D4415E
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 13:53:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3059A895D0;
	Tue, 19 Nov 2024 14:53:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="p7RUBV50";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD686895C1; Tue, 19 Nov 2024 14:53:07 +0100 (CET)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2952D895B7
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:53:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5ee645cf74fso1897681eaf.2
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 05:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732024384; x=1732629184; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gAsaSJbFq7CTP4jrQVJ3K6Ui7A1aXX/w8kSB2gOF/Ao=;
 b=p7RUBV50moFcq7lUjMcTyTXvn1PXXWX7dEvpP8ZlanHf+miLEtNSKZqKjmxt2FQ4C1
 XCoZD99EVDPq5QQDAP7Pjc2FbWqVQUfZ718mLAyTKrKgSadds8RW+whb0fvDIC4WKWvd
 Mm/KYtxcDG4YybUJekt3HkrMSgERJNeAKUECI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732024384; x=1732629184;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gAsaSJbFq7CTP4jrQVJ3K6Ui7A1aXX/w8kSB2gOF/Ao=;
 b=rxHIWYuKh88e4AJqf2qhkBu2YS+S7GSP8I4R70uHndCWVCIgQLebewOYHwlT/ia6Hy
 zUKlZ3RYFNJRQnVi4pf5N0W6L2RsjlpHtVD82nLXSd2aeXROHxM6rWfFlLwAGFs+aOFb
 7Fm0F1kxf4wpc6MePU2AxqxgcjkrIoNsekjphZT1wB1vUKy10F+lzQSMT5kTKywitguR
 7q0+7gMLnskTZXyEUHYAduMT4ABwOwCZyLYZo3siFIZYbEIiqctY/aqGFRf5G3Gwgaas
 n5vYhjNoGdS3oWH+BiJo/qDaVMzKU5AYKv9mte+uliP7Z9z9bIyDMsLQkv7jxkCgbDyZ
 S+Yg==
X-Gm-Message-State: AOJu0Yyogxn5YfqR4Ltkjxi6hgG7UBm54t4g+Cwa20o1GjqjmUFKrqLL
 Hycfb0Q9IArha4YwQ88VGd9SIescZwrEFRKCWqFUddrnCY+HPfAY9rym1AN4HLg=
X-Google-Smtp-Source: AGHT+IHiw4e/2uKt2eMMILzfLmDoO5lQInIkbzcj8LCuyQ6gCQaKF8bnTseaaqTl14thlILlImrynQ==
X-Received: by 2002:a05:6358:6e88:b0:1c3:9835:84ea with SMTP id
 e5c5f4694b2df-1c6cd0be8ddmr635566355d.7.1732024383917; 
 Tue, 19 Nov 2024 05:53:03 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d40dd23291sm48507786d6.81.2024.11.19.05.53.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 05:53:03 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
In-Reply-To: <20241116200822.27160-1-heinrich.schuchardt@canonical.com>
References: <20241116200822.27160-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] test: cmd/hash: check return value of
 ut_check_console_line
Message-Id: <173202438266.3483935.13000229217378621298.b4-ty@konsulko.com>
Date: Tue, 19 Nov 2024 07:53:02 -0600
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

On Sat, 16 Nov 2024 21:08:22 +0100, Heinrich Schuchardt wrote:

> ut_check_console_line() does include an assert.
> Pass the result to ut_assertok().
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


