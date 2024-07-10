Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD59EC3DA41
	for <u-boot@archiver.kernel.org>; Wed, 10 Jul 2024 13:43:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AE4088711;
	Wed, 10 Jul 2024 15:43:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gCQfuezH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E7B388710; Wed, 10 Jul 2024 15:43:35 +0200 (CEST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EFEA88711
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 15:43:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2ee98a224b8so3593971fa.2
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 06:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720619012; x=1721223812; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cWCTh05RWsmry2ti4334mWqWEsEo239sD897N5GUhxg=;
 b=gCQfuezH+e1Kp3ETVWEg18oJrbEMeJzCmKvE5Fg3nYbAAlMrKZjBRv1orx616S512R
 +FnL+I1so2E5Cwe3shB+02yCurTML+qYli7p2gLBugkZROAjmBf/fYB/vtaBYLbLTQEr
 gVSPi1S2KH83r4HXU/7+4Cp100u7+ADLO9LQugd4g2EMZqHgustJHU0CP1Hzb1smsfCt
 NE1z88DMqtN8l43XAdW93YGT1TfCXmyAHiObSttT3A5RI9xDdzPLX8Kdd5H0g3uUVP8U
 NFh+jIKCF1Ll8mb1nlGJPevZU1mwMfT3lA64UCszrjrUgSWgQ/PUts7RqzbOjypOwWKN
 mgvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720619012; x=1721223812;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cWCTh05RWsmry2ti4334mWqWEsEo239sD897N5GUhxg=;
 b=pcZ3FxYFRc7sbvzFcxIKZ3Prx1AjiH5rYjGxwxFXC5X8A6oVfM6OxJWQRw1qZjaHUQ
 jbbK0TePWapMAuJF7CjE74dkSdacsV+if3+IdGKxq2SqDRyh2tYMhYAwFRusnF3ICtVE
 5jVOepYoFyjCBpBWi86s5wyDGEHqFHNUpf701j+MH0Zh4/U6PhFnXAiu261u/biJm8e6
 HdS1jJW4Rd1t18tjiSOLYPU1hKOWV7suv31zUbjPJYraREAAmWKL4e/7NV5J/MGMLIo0
 JBSmYph/E17ksLnNZU6XfNYSaVm7QMdQFmnDAR0pnjUhINzlxRMPAyyAvgl/f8AHuo7e
 LU1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHIWeRYdSUIrp9JeXDmMpc8kwB0MIVIlYuONybNOLyO9SXQyRX/4P5KEPrxsmcg2OrdZT2M5+XQHqjuRt2sT9FbZSlrQ==
X-Gm-Message-State: AOJu0YzXiaXg7ZBCXwCLkez+U8S83SQI8jmnf87w2gyU48Lc+00iyalj
 7rTmKBAVzM+YzCKZRuT0i6r7PE09OrmX4APOx7zLxX9/WWZRY2nusCqJuZf2da6Yu7Svo4tSrCi
 MY8dyBob2ca0oCGdgbHRIVNnQB5S/VQsD
X-Google-Smtp-Source: AGHT+IHT7NNdjiLr7o8Y1kEt4zcAeqkmN1YQ/kPXNMnq7V5SjDz1JgQNDnneNUacMJ/Eb4SYFsUuBdZqq4CnMde+4QU=
X-Received: by 2002:a05:651c:198c:b0:2ec:18c7:169d with SMTP id
 38308e7fff4ca-2eeb30ba1afmr36494031fa.1.1720619012324; Wed, 10 Jul 2024
 06:43:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240707082001.20746-1-michael@amarulasolutions.com>
 <20240707082001.20746-2-michael@amarulasolutions.com>
 <CAOMZO5Ddm_2rerosTctkCzcd_+ku7VfsrxfXOEU1NynEOgoQbA@mail.gmail.com>
 <CAOf5uw=wktwcRrPOXmCjehKSsQvzAAhmM4KKsbdxyE6cRVBMrw@mail.gmail.com>
In-Reply-To: <CAOf5uw=wktwcRrPOXmCjehKSsQvzAAhmM4KKsbdxyE6cRVBMrw@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 10 Jul 2024 10:43:21 -0300
Message-ID: <CAOMZO5CyFvpa_Fkfjmte9FvPROdNyTS3X1gzweeatu_Evpz2_A@mail.gmail.com>
Subject: Re: [PATCH 1/4] clk: imx: clk-imx8mn Fix nand and spi clock parent
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, 
 linux-amarula@amarulasolutions.com, u-boot@lists.denx.de, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Marek Vasut <marex@denx.de>
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

On Wed, Jul 10, 2024 at 10:39=E2=80=AFAM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:

> clk dump
>
> It's how uboot is registering the clk in dts. My idea now was not to
> change it to not impact other architectures.
> I have a lot of changes but I don't want to address regression and fix
> and test before send more patches

Ok, I see that 'clock-osc-24m' is already used in U-Boot by the other
peripherals.

Your change looks correct.

Ideally, we should use 'osc_24m' in the future to align with the
kernel, but that's a different task.
