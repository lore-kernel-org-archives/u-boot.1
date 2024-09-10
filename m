Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4815EB64DE
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 12:57:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FBEF890A6;
	Tue, 10 Sep 2024 14:56:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KpgEo4kB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1042E88EFB; Tue, 10 Sep 2024 09:55:09 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A1B7889CD
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 09:55:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tudor.ambarus@gmail.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-374c962e5adso2885718f8f.1
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 00:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725954907; x=1726559707; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SJzm5yc3lkuXX8lCx7K7i+3KgJABzldT/TAQLwr5gtk=;
 b=KpgEo4kBoSOzlfaamujko0v9bzsLWkyQDzQMJHtg5bERjXQ6Uml2cQhxD+eFFAsYQ6
 n8gXevD9/1Ycl/a7AsmG5T4gYOStvSyYlWsNUsZVE97yb63tvzOoGxzPvSXrNl9AQcuD
 qgLXgRztB9fJnnOnVffHM7CSVQjnyUHW2XBbhY9Yvg5TBqKl5R41c9RTvVHCHT2GujxG
 SLVcujvo7hD5MzBbjzFjWp/2Q9SdD6ffKZvQFmNmhyZhsWCjYqG5QKyAAW3A2GBpixac
 v594hFavmH6cHlgswrantLZCmt08uj8CPVwj57wsuQzajCSCrg6P4eAncNGrx9EzYpWZ
 SgvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725954907; x=1726559707;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SJzm5yc3lkuXX8lCx7K7i+3KgJABzldT/TAQLwr5gtk=;
 b=SnjwqM6J8gbrGoZ6z4ee4idem6ASEulfNjYsUJBIBfAn7Sojr7wNBNhSXPyCeTvJtq
 +mBW3f0vPKzeNWDK4x9qVZbLZtlofSouS3HANPOsRHkQXJSGC1nVc9hOxjjKYBwtYOhf
 oseCP8WN9kYSPxJ/PRdpqOAYkTc/qs73A3aY1ZoRFDxm6uXygJ1mpoeu4bS7oolFhXeE
 cuP9pgz887Fr+hgvi16Fn7zkH4t9PzbpiUk8M4M7uhTVV4xNmcwRAK20zOur09JNwRzC
 FzSTgMT4xOMtcEX1sjd2N+Xa/9wrOlUNrnT3QZSk22tNh3mDwFx7f2aqrSjuaX3/jpAl
 0KgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdODCuyTZmzoQAV7dPuj07eqesAkthyNAzMi6NImGXepEeSjcygg+OzpCvP9J7s2HhaXFe5zo=@lists.denx.de
X-Gm-Message-State: AOJu0YzxtxFPfvDiu3/UdV06hhWyqcl/xnX5CU/9JwcyLKwv0DZ3omyH
 5dR8LgZT9CJStyIcchTAhODeXFLUD617nxntXWdTSk9fEtVgbeOr
X-Google-Smtp-Source: AGHT+IEYoq7KNfpkj2eKYC7iSwl5v93789d6sYVEQWPEfCPeYZeXKpCLyM9wRlaPV41QIQ612xpR3g==
X-Received: by 2002:a05:6000:1f11:b0:374:cf83:23dd with SMTP id
 ffacd0b85a97d-378a89e639fmr980797f8f.2.1725954906399; 
 Tue, 10 Sep 2024 00:55:06 -0700 (PDT)
Received: from [192.168.0.61] ([79.115.63.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37895665762sm8105409f8f.45.2024.09.10.00.55.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 00:55:06 -0700 (PDT)
Message-ID: <c399216d-34d1-435e-96a7-6716f9f2c32c@gmail.com>
Date: Tue, 10 Sep 2024 10:55:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mtd: spi-nor-core: allow overriding 4-byte OPCODE
 support
To: Robert Marko <robert.marko@sartura.hr>, jagan@amarulasolutions.com,
 vigneshr@ti.com, trini@konsulko.com, u-boot@lists.denx.de
References: <20240425143627.54648-1-robert.marko@sartura.hr>
From: Tudor Ambarus <tudor.ambarus@gmail.com>
Content-Language: en-US
In-Reply-To: <20240425143627.54648-1-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 10 Sep 2024 14:56:36 +0200
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

Hiya,

Please specify which linux commit this patch follows. It helps reviewers
and gives credit to the linux author.

Thanks,
ta
