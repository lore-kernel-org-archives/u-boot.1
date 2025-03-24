Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 920A1C36002
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 00:35:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94DE980EEF;
	Tue, 25 Mar 2025 01:35:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="SZjfdwEF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3839E80EEF; Mon, 24 Mar 2025 16:19:03 +0100 (CET)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AC48805D7
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 16:19:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-30bae572157so43845401fa.3
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 08:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1742829540; x=1743434340;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dW3stUKm6C+4iTbQ0F48pAB7nlcb5Xnfgm5+xA987Gk=;
 b=SZjfdwEFjhQN/ZPujh0hL2hs4Qy1ZGrVr9Y2hf4IDLxLXYKzhuJhjT3HJdSR0X3nSJ
 VB6zifQN18JCkLuuN+O3LLs57t4W+Jt8glUnkyv9N8zVpiTtlGImtZigZkgC3JYGFwSp
 nCG01rAnwdJ9QSskprg0D9idClwlrr/9a2o/YydTTqRVZXdJ0uQ7qF7UeNqowvs0AH+5
 jrwJjH3IGbY/QqwSdPSYzn8q1ig3z0QFdcIAAh9A0CzDqMV01CKNf8WHwqFp/vCDqHl7
 92LqdYKSaelI2jMUh80EMR6MTbVzI/h55r7h7IFDf8ed7ts+83TwXi+GuNelcW3cclcr
 z7DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742829540; x=1743434340;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dW3stUKm6C+4iTbQ0F48pAB7nlcb5Xnfgm5+xA987Gk=;
 b=t40g+2OHsqnbNh6Kwgy+FxyGN4JVbmHv/rKSpXP+1umLOpQiWpXusHtlsYeiOGgneh
 tj/D0tzPCEITCd5byzkv1sBBAON6g6ICOMA5HmmlLrhtz5qMjMNPp/g6UzdwvsIFXqLY
 bCttLUUsnGs+3SjwpNhGWKADfm7ZlU/1H5+crt2IMbWzIaE90ZyP3n9nwmP86q0eUQDV
 ELQuoCT/A/msbRo6FGJHxAocb+fuJkrOikDj390b/+JbUNtUAZQzyKNvXfcp7IvG4WAu
 tDrT9yq3bz/0JEW8511Nrtsw4ACQ+CFsGSyMqRwbaA5wu+w6Xuns5x1SRPbKOiaOR7v5
 zfTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIOAS1fEB39MiQi9ILqBo7ZSn3QwRdU61g51Ql/SzkTl5Dc9J8UaOCUIVhMLmXBTQ7VoPS4RE=@lists.denx.de
X-Gm-Message-State: AOJu0YxvMdT5aYoCBdiSRZ3kr9Vf3MeB8jZUWmnRcMu9zLETZ2m7sqMV
 1a4RKYCnx1gwvrX0rUHUW/aJiwBqOQI8uKkIlQS50cjQlC3QuQzzaw9xKUfdTBA/4uR4hIcRH6A
 MqscPKQktxC2lNTNH0eTgwEp1qT9q3xrlhGmafr1UCLurm1XKKu4=
X-Gm-Gg: ASbGncsx06SlGEHUdSEnLQSUUu1wzWpRdVFac+ESkrQagStoO2iY/YWzu+oAbvASPg0
 dTGSuJNojVpucO7M5VhzWFy1/M73IGDI0GQtkCG06vw8DrNs2FaoNEvUMOovHlMCR4s2eczqno8
 YynxBjhLe4ISnasXE7bQUYL1rpGnKdkhulKU0l
X-Google-Smtp-Source: AGHT+IFQHyId+WV9acYtDBh4xNLDC4X/DpLdjmKdZO4zLLwwXTmIAeJ/9q29akmhNzRsbskLMn2OrC0in7Osho7hw7Q=
X-Received: by 2002:a2e:bc0f:0:b0:30b:ecfc:78bf with SMTP id
 38308e7fff4ca-30d7e206777mr45791481fa.5.1742829539839; Mon, 24 Mar 2025
 08:18:59 -0700 (PDT)
MIME-Version: 1.0
References: <CA+GyqebHib_N7szGKkR0Ejac1rmoDQp+0a8t7ROng=PE3g9pGA@mail.gmail.com>
 <72987a42-4e5b-4b53-a5de-2c654e129c43@denx.de>
In-Reply-To: <72987a42-4e5b-4b53-a5de-2c654e129c43@denx.de>
From: Zixun LI <admin@hifiphile.com>
Date: Mon, 24 Mar 2025 16:18:54 +0100
X-Gm-Features: AQ5f1Jp7KdsFJSJef-TcrZmdTOufGiq3pUeA3-VCY4n9cTe7L6Hy4sSrVp4KWeM
Message-ID: <CA+Gyqebv+Cuz0ectGciihU+G5uY2_bHRceH7nWASrxPMUh5Muw@mail.gmail.com>
Subject: Re: usb:composite: data abort on second ums launch
To: Marek Vasut <marex@denx.de>
Cc: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 25 Mar 2025 01:35:45 +0100
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

On Mon, Mar 24, 2025 at 3:12=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
> Can you reproduce this on u-boot/master too ?

Yes I can reproduce it on master 2025.04-244e61f, since fsg init/deinit cod=
e
are the same.
