Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE42E7716A
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 04:04:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED6E5801F9;
	Tue, 17 Dec 2024 05:04:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IIz7dLyK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37AF980202; Tue, 17 Dec 2024 05:04:11 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AFD1800D2
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 05:04:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6d8adbda583so59308766d6.0
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 20:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734408248; x=1735013048; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=x//5u2ai8AhUX55ZpXlNfG5RnqtEkVzdJg0tQenKrh4=;
 b=IIz7dLyKsnRfCrPxCKzAO2McvUqCvoNDEA/+kPuEFCcyqeLj3sFeCJwOJEVYXladte
 CDE32nWg3zUEEPJgTDWtJ9cShCcuBfkIy2Ef9WWTmyi/Aade0kEVbJY5r8QKONeVETUS
 8pHbsLfOjt4DYhaZM470ots4s2KPvIzhRj2n0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734408248; x=1735013048;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x//5u2ai8AhUX55ZpXlNfG5RnqtEkVzdJg0tQenKrh4=;
 b=UwFvjPgIiF8ItnrZGXncC+GlwSkYForFBbcqhgSRiljXNSDvt0y1ro9TdwdLtbNKbS
 FKDVD1vqAkYcxHk9NapgWgiAONX3pn/tA0Cqf/Uhk/GI0PeB3Y2BaAGdLuRcTMzzeweY
 lK7tvhVaB99GXM+lNX1r37Y3/Co9m8Y74Nud/BlHGIHnequXHjEUxgWeYCzZPyEU6T8l
 d8lD1zRE8uCC7x6eci3msC8MALQkuNcOOvhIsncUqs22vpizCKUk2baTi8VyFe6mOrjt
 HbC6GQQREo72CFyll9DIQnGfnCFXvVJS46v5M8/pD10mrb7vucnYYiaXFWQrzwhEzDvm
 QN4w==
X-Gm-Message-State: AOJu0Ywzzq5RFAe7Jf3z3H24Hl4fRc5N1nlDGor6sfER0fGCoOWB6upZ
 lSmjRTQBKrFvy9Auy2KMFA0FmYJhpRp7QVhXywTOwetOvQRJV5S3yvZpNjQCLYLnkU0uNdIWDZU
 GcEU=
X-Gm-Gg: ASbGnct8o/F/dsKE1aBmhVPwVwRxEf1A9W9+KQ85aqSgHV4hC/CDQI5iC0lqH21yjz5
 gAuqioIFENNSl7Nwp5tJDaniHgye8j1q8W3d9f1yxsWFsTKFydepGslkCC9LD9V43jfsAgZV7as
 xmeMw5VZ6S1yIjn8k4P10+/hlBLvYRwB25ahqvr6x0TACxSR6keYw0l05NUsQtR9c4WzA3z47/p
 mChiP9h8sWzCggWb30isZTZkgDWBM+Lk8kmIFT/hhreTX+2jbwodic=
X-Google-Smtp-Source: AGHT+IHPPRggkDg5jAEb4KRqO/dMCAgvLvtV8pdLaGAknrOTWog0jBov4fkvrM6rMPS6LArLB5HPdg==
X-Received: by 2002:a05:6214:1d0c:b0:6d8:9124:8795 with SMTP id
 6a1803df08f44-6dc8ca3e6fcmr280824646d6.1.1734408247996; 
 Mon, 16 Dec 2024 20:04:07 -0800 (PST)
Received: from [127.0.1.1] ([187.144.29.192]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dccd256fd9sm34358136d6.37.2024.12.16.20.04.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 20:04:07 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Yuri Zaporozhets <yuriz@qrv-systems.net>
In-Reply-To: <20241126215937.15532-1-yuriz@qrv-systems.net>
References: <20241126215937.15532-1-yuriz@qrv-systems.net>
Subject: Re: [PATCH] bios_emulator: fix garbled printing of disassembled
 BSF instruction
Message-Id: <173440824611.3115242.7323778674932978778.b4-ty@konsulko.com>
Date: Mon, 16 Dec 2024 22:04:06 -0600
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

On Tue, 26 Nov 2024 22:59:37 +0100, Yuri Zaporozhets wrote:

> When DEBUG_DECODE_F is enabled in bios_emulator, the printing of BSF
> instructions is garbled because the '\n' symbol is used instead of
> the correct '\t'. Fix that.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


