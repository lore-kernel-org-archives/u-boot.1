Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3195AC35FF1
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 15:30:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52FE381D6C;
	Fri, 14 Mar 2025 16:30:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tLWa6XQh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 317BE81DAB; Fri, 14 Mar 2025 16:30:18 +0100 (CET)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9B8081D52
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 16:30:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-476ac73c76fso23593371cf.0
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 08:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741966214; x=1742571014; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZTbeHeiisnVaU/67jttEe0KXst4/m5JEoLgSoADTpVs=;
 b=tLWa6XQhAEhI2CwqVh7z2OMSG0s8cGMC9NrpEcUiC51TN85dE2WOWtGG1fK2dJUM6s
 Wn6R7KM+WRoUaOGu3QQd1BMEVHAkFcsohE1deXizEURqGhB9fEMUvPREWEtHUnuQ/8O4
 Nk7YEG3SuT8MZQeU3PULvPdTV3cy/Fz5zrYOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741966214; x=1742571014;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZTbeHeiisnVaU/67jttEe0KXst4/m5JEoLgSoADTpVs=;
 b=LxDp4WThK7BPkyfwHHwDuOytf/7wUz7IsSHCFaWCF24HjYOL8OsXIfLjxfJnx5Y7hK
 O77AuUH5yAGhMgfzEEjULJfmT9acu5UffBzuIbun/RFEi4MPfJy2Y6lpHlk8powdTW1v
 pVQEnxA9XT14kQx83E8UZXMU9JLu1O/Yg8BGHU4yHY06ufKodqRtdnH+r5H2X/tAVKKx
 5vzHhkz1HmA/y9KyeBcU23CTwJAO9v8tb57fXURut5vqz8OGHr9V6lHUpv+SGcGKvHhp
 P2RYqrliafZ7aVlB5Wj1t3dj9kvEGP6yml7bO4w8XSFv3lk3PNI4X19HdkW8YgWeIugm
 wiNA==
X-Gm-Message-State: AOJu0YyEFcmJOR7tdoyik0g7A/zsbD91ahZ0qOcTMqwnQg4sLrIxaECn
 E+HcpoZMjHyTaVrlGDBN4mY+TcfetcWU0CjId7J/oJm+5BSevCEjxFkV4DEicyjYw6dLCjyOT3u
 l
X-Gm-Gg: ASbGncugMCxaVdP0Y5JlArOB7OUfSxn6AqF8NdpCrXOcd6Ls43W2CZMFXULdE6zPhju
 LpOyV9V/BjsiG2FsbE13Blv07HzWTQwnDuzccvs6piQTllfViEFgndDG2ISoCQqou6vK4JIC8DG
 d6f9lkOkmplHaB+GOoclegIrcADbQB+CKkAMux10bKDaNSiO0maXUJRwgS3c3VDLybAZ8e6Ev0Y
 6W4ZKixSEzhvchsfvHHrX66UMV7scmigFfQ0RUNhC3YtXNx6cKqXjtvmkmOJNNoqpTcP6iwf+z0
 LASDj0z2zNeX9u4TYwr82i3PHkByLxxM6nRmaRL8MJTS
X-Google-Smtp-Source: AGHT+IHlNwZ6BTNEkE7uqmHGrTbcxIiIrPHsaAiO8SPis3/P/RTtx02CLM8Yg3QwFYXBaUmEXUOp7Q==
X-Received: by 2002:ad4:4ee4:0:b0:6ea:d604:9e5b with SMTP id
 6a1803df08f44-6eaea996040mr44524146d6.2.1741966214702; 
 Fri, 14 Mar 2025 08:30:14 -0700 (PDT)
Received: from [127.0.1.1] ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6eade2092e6sm25471786d6.21.2025.03.14.08.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 08:30:14 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250313195427.1554312-1-festevam@gmail.com>
References: <20250313195427.1554312-1-festevam@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-next-20250313
Message-Id: <174196621371.2238905.5134746602976279718.b4-ty@konsulko.com>
Date: Fri, 14 Mar 2025 09:30:13 -0600
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

On Thu, 13 Mar 2025 16:54:27 -0300, Fabio Estevam wrote:

> Please pull from u-boot-imx/next, thanks.
> 
> The following changes since commit eeefcacb851f7f0bccabc3089a725f5ce86f5c70:
> 
>   Merge tag 'u-boot-stm32-20250312' of https://source.denx.de/u-boot/custodians/u-boot-stm into next (2025-03-12 21:36:52 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


