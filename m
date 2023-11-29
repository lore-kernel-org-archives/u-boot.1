Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE96C4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 15:35:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 914BB8772C;
	Wed, 29 Nov 2023 16:35:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZZro16mc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9CB886D34; Wed, 29 Nov 2023 16:29:08 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A9138753D
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 16:29:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=phanbagiabao2001@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-54acdd65c88so7588543a12.2
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 07:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701271746; x=1701876546; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=/pD1EIuSQ5TqJ+l7yeuTgByaKFYtjTkQCP46as+Q7ho=;
 b=ZZro16mcL4/gD2iNP6PFLxGGiAtd7TILxvrphPagLFewaa73WCNoz29Z4v3JkJLD2H
 hVIDHbr6U6/thxPt5DxgfF7Zh4jaeu3zO3nFZpuNF8MKpshxCnKPXjuYGjVsRN0GhT8f
 hjhfQRoBZT9FO7se3rfany5GjJVY6gQvy0nObmSdjubg6GerNNW7smUJdFds6C/UAVCe
 T82as/9aZYHHax9HNHgqV0QjhWsttbBMDqRMQSZpv9Z7fZbau/TcWq7CnH03mdRPxc7/
 KtbYON6KnC4So9SCmh5FvBuKos5pfzUCbe6VkspOgqBCziYUdb4exccyGlm25nq2BHbe
 lN4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701271746; x=1701876546;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/pD1EIuSQ5TqJ+l7yeuTgByaKFYtjTkQCP46as+Q7ho=;
 b=Vqykt8BYipNdsQRg6/KooHRzr64rcbG0GriFEdTv2/ZVQU4/je+2vyklyXJdKqHTqf
 qEqmxgOr9aA2X9jOv5a1M5QzbrAxokwLO3Wz8AkYH+KwO/ubYH0lUHCl+ku4iFHPdroG
 Kt9UWHLAJlETsi+nxvYxgAys08tliySKM3nysy0IYvrdg5UMq64o4vSe+LOqfGDhQs0C
 CkJlpwg8UdMh+JtF4NiGkAZGj7yQY7AO8mI2fIyyyC2Y+UeafOgpsDfHYRRpRVHZ0e7Z
 JJ/kFIYdEmDBaRpdY4Zl3GXhdkx4QnJYimVUL0ffA//wnradnqbuLgeEJ70FyfMtjT1c
 mmPA==
X-Gm-Message-State: AOJu0YyAeYl92Stetp7QtzQlS2h8AlBUJ3fzD/ZuWHdRL4PG1Z/dIPPr
 NCbRi1O7rAS5Cnf4gWNSrrh+Dam5DjdYe3rCm0hTQMCmviI=
X-Google-Smtp-Source: AGHT+IGZOg7ajWzBLdGlLIZTjMIBgeHpf8YSfGZFIgnYdVDQvgbzR3jRU6nnH+K82/yinSkidlnBCLvXB6u0NUEAv/8=
X-Received: by 2002:a05:6402:5c7:b0:54b:67a7:efe5 with SMTP id
 n7-20020a05640205c700b0054b67a7efe5mr8324734edx.1.1701271745540; Wed, 29 Nov
 2023 07:29:05 -0800 (PST)
MIME-Version: 1.0
From: Ba Gia Bao Phan <phanbagiabao2001@gmail.com>
Date: Wed, 29 Nov 2023 16:28:54 +0100
Message-ID: <CAK9R8u_QmcHLv6KbNm8+8EDvnmgehFZfoPNVCVn8n5P17ArErw@mail.gmail.com>
Subject: Setting up boot chain ACPI on ARM with STM32MPU
To: u-boot@lists.denx.de
Cc: andy.shevchenko@gmail.com, trini@konsulko.com, sjg@chromium.org
X-Mailman-Approved-At: Wed, 29 Nov 2023 16:35:21 +0100
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hello everyone,

I am a trainee at STMicroelectronics France. I am working on a project
"Setting up a boot chain ACPI" for STM32MPU, which is based on ARM Cortex-A
. The objective of my project is to add a way of booting (with ACPI)
besides Device Tree available on STM32MPU.

I found that ACPI was enabled on some x86 platforms but I don't know
whether it was set up on ARM or not. I found a PATCH that discussed*
Enabling ACPI
booting on ARM with Raspberry Pi 4
<https://lore.kernel.org/all/20211201160315.2203099-1-sjg@chromium.org/T/#m3f705d5a3b59d3e58861a2f983e3d48fa20addf4>
*but I don't know if it functioned or not. Did anyone here succeed in
setting up ACPI on ARM by U-boot?

What are the differences between x86 and ARM platforms when enabling ACPI?
The architecture of my board STM32PMU is ARM so can I apply the technique
used on platform x86 for my board?
