Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F87CCA476
	for <u-boot@archiver.kernel.org>; Sat, 11 Oct 2025 17:08:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0458683A43;
	Sat, 11 Oct 2025 19:07:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mcUch1RV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23F4683929; Sat, 11 Oct 2025 19:07:32 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16EF48386D
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 19:07:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-3c715955a8cso2208566fac.0
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 10:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760202449; x=1760807249; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XyI/cOLBwUhVnCBWvn7yZksxNHcllBMzvqYNXALLqSg=;
 b=mcUch1RVvIqAtVk9Dcll0Pl5n/QsgxuHd/dizMZVU3guOfkqu9VafcocDvo4eSB67X
 kfvchxU3YgPvyrutF7ACxXORz2LExGhdvL2vJX0FPcRZAns/m02pOC+aVE6a5rqCiIHq
 13BiVMXbJsa7IwboSxy/LLe2XgXbn/DIkWCZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760202449; x=1760807249;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XyI/cOLBwUhVnCBWvn7yZksxNHcllBMzvqYNXALLqSg=;
 b=k4aTRFQxTwnRxsyuW3kO/RA1VBblrPUze/9YHusH+av/vT9L+JnuvmX71g6EoIqVJr
 eqnuQJGPSlLeJXsCJ/ytBlHEgvfMu5TODcpymZcQ/g3sPwmrOzYvbAiGLXNDB1P4mdpk
 ikNupsYJyQ8lTxLywo7Lfttd+qliofQN5DwYXsF6Jdnq73Ci1SNm1lds5ukNita/umvm
 IdxQK+UJleyvkQ4uiHF5LGz0ILo5zjtikZoSxpdaFxeBHA/n/niodlzNtsse1enrAYab
 aAgajMM7pZc6sLIPbpQsFCacaItPYXXzn/R0n2MngHcvpR0i7PDbktEx7j+BFi1JmRQS
 ZZ+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVV5fEfu9Kg+0nlXicvPR12Vk8vIKFrFhK9xUG0HCMXQGKgHq0i7SQoH28uyNe3Ivn8nZ9MKqM=@lists.denx.de
X-Gm-Message-State: AOJu0YxAR47N+gHewitS9P3wYDaXofed27Z99OAtIVYT7P6WQThbCYUD
 oczjjmdsr8Jf2DeeXxRpMKXJ9TqtaD/+031ALVlQBSNZpEcmwcFV7aftTuc326jbX95sDKItajS
 jlOQ6LnY=
X-Gm-Gg: ASbGnctbrgTBvNZbdt/Fyj/nxXy07auB/67kWo2oFaOKgnlzb5OUdUsOrR0b5L9Y59A
 kpUAUUHjAuzvMAS/NlENbtlAlT4W+62huk0qUf9AYzYUvqK/gTqVSlIRar4xOtH7zQgfv3cgnzP
 hl7InwW6q7d0U90JebiVeOpADnbWP1z3Wr1o+R83q9ToDREsnj8ew/0ZQzSoeT0HRQWHhHSymw9
 LK2akdginQ81sKiOAX28LsP1uPi8t/B5GPviIbOkyi5+kpZRnapmZ8zKtR4JQFbgza9jGgpsbN9
 Jvl4VnJKNTgX6iZspVO+WGowpLdBnw4Z14HesUzJ6iCfthnKtg+hqGa+ps+KkqurU1uKe9V3JQh
 OYKUpGCRjDAZf8NMk+f6iEvVLXRrMd2o5jjpv7XTkEJw8gGtQINExqX4xcdM//ZuFoueBLIp+WO
 J1FXn4eajsuFzv0Q==
X-Google-Smtp-Source: AGHT+IFRBAr0vcANVyGcz16OOjBQ3m1VhwyMJsDqUBAmaYOAuZZzRNlERbmMA2+rR+d4zOQQtcw9gA==
X-Received: by 2002:a05:6870:d29e:b0:345:ee86:3565 with SMTP id
 586e51a60fabf-3c11483e0e5mr7455066fac.4.1760202448863; 
 Sat, 11 Oct 2025 10:07:28 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3c8c8adcdfesm1970991fac.1.2025.10.11.10.07.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Oct 2025 10:07:28 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, u-boot@lists.denx.de, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Joao Marcos Costa <jmcosta944@gmail.com>, 
 Andrea della Porta <andrea.porta@suse.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20251002-fs_squashfs-v1-1-d72e624dd056@linaro.org>
References: <20251002-fs_squashfs-v1-1-d72e624dd056@linaro.org>
Subject: Re: [PATCH] fs/squashfs: Ensure memory is freed by using unwind goto
Message-Id: <176020244791.1312138.13705535285071348697.b4-ty@konsulko.com>
Date: Sat, 11 Oct 2025 11:07:27 -0600
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

On Thu, 02 Oct 2025 11:36:09 +0100, Andrew Goodbody wrote:

> Returning immediately from sqfs_read_nest is not consistent with other
> error checks in this function and can lead to memory leaks. Instead use
> the unwind goto used elsewhere to ensure that the memory is freed.
> 
> This issue was found by Smatch.
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] fs/squashfs: Ensure memory is freed by using unwind goto
      commit: 87b7eaf3244e1a991404602c3422a4ce06bfae55
-- 
Tom


