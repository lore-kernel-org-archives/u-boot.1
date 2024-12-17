Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F2C0E7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 14:00:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 657A7801FB;
	Tue, 17 Dec 2024 15:00:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vBk5Barf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E676380224; Tue, 17 Dec 2024 15:00:32 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC75880107
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 15:00:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5401d3ea5a1so5883748e87.3
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 06:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734444030; x=1735048830; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S7whYjDQHJlqeA4U672NPdTK3pBuFQjLWBkowWyU6Eg=;
 b=vBk5Barf+ZjUSK+u4FzviAU4TSgFyC/ShPS0qTEfloRMBNK/3zUn5dLBV3f557dkUw
 x++V2k71TSjpkAa1V8jsdnCo5fLd6vSDs424KodM17b2rOK92DNdqk+Gkl+EXVR8Ij2c
 6Bs8ggvpYr2ny0TRrzpFry8I4ei8DjSIYik0mk5xxDqMapDHhH6LxK+aMZOD4m1meQDN
 +44Y9YGSVRrqwMtxk2X5uu9Qvhaesst2Xz92ztLcnKfvwbr7FPzi/WOpnLmgfmr1iy8Q
 CrkUT5uUcHNahS1mCr4CVUK/C4S9YpapJ9hygwPF9hzET2PeKT2d19oDYJS71l98S5B4
 EV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734444030; x=1735048830;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S7whYjDQHJlqeA4U672NPdTK3pBuFQjLWBkowWyU6Eg=;
 b=RoPZTJfxtlql8tS/LnK89kBD97p1MTvAO8oJz7kmwsR/8jCYr49AvCifYN+RGkqJhV
 Re5esdgd1pV3Uy9gcD1XZrug8r8u84E2aJg18z0uYTwV3XofYMvnHnfI1vBQy4r1S1EV
 mGppJadtboR3scnvhwjcUlEmJ06to5eq6VAQgCqUvfuhBeuNPc2+VKLv27u84QOHaROl
 gnsU1FNWo/0hPERFC0XOpPyd1GreV8kkBifPPhb90MISINYV50Us/1LQ6NVmZkAylxC0
 Y3dcJ9X2qBwUJSqF15IYlRI4rF2TDnYI7ou6nnEwS1VQ78zkF6h3A2kSLNRahNDDNdpa
 tN4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW79+p3Vvh1ohZOxFSWg3sQ8q5CEatDwbIveommPYYGWDHWiyz34GIUyDXC6CHdtmCrh5i57rM=@lists.denx.de
X-Gm-Message-State: AOJu0YypyX9NquOeebgrkZjxlI3RQhVw1rKa2LF0QDQTtx9LQoMlq4s9
 lveFTN3pRidhjDm/ZtXjRCftdcpUAK/3IF8q3n1vWl1QkyGUZKh12UKBCerfEbhz5Tmqih9QoAT
 G+62GrP6ueBP9mlqpWktP0v7i4uY5Wt14R9HNUWYLMebGLxxscUI=
X-Gm-Gg: ASbGnctESW4ewmnoDuEXz9juTcfrIW/hBt7IgethRRXyszjNAg9ZKJglSUlm7/DoKRc
 kDvfNhXhvSwgtQeaWug7hEkV6mPIabeWsBih+kw==
X-Google-Smtp-Source: AGHT+IExw4lNLAiC9T4zmzy3xGaLk8Do04AsuZFznLW9esHEEUhwipqCTVpZGbX97O/Lo4bVqM3tXsvKcPs24VZZrek=
X-Received: by 2002:ac2:5b10:0:b0:540:75d3:95af with SMTP id
 2adb3069b0e04-54090563f67mr4058463e87.29.1734444029969; Tue, 17 Dec 2024
 06:00:29 -0800 (PST)
MIME-Version: 1.0
References: <20241205203033.42915-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241205203033.42915-1-heinrich.schuchardt@canonical.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 17 Dec 2024 15:00:18 +0100
Message-ID: <CACRpkdYqUJEfv+JJ=PzSfkcADwv1n3QzZ68MSMDE0S3=XvpoNA@mail.gmail.com>
Subject: Re: [PATCH 1/1] rtc: CONFIGS_RTC_PL031 must depend on CONFIGS_DM_RTC
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Dec 5, 2024 at 9:30=E2=80=AFPM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:

> Building qemu_arm64_defconfig with CONFIGS_DM_RTC=3Dn and CONFIGS_RTC_PL0=
31=3Dy
> leads to a build failure.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
