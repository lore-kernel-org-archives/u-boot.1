Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C23C4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 17:09:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F70D87015;
	Tue, 12 Dec 2023 18:09:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VHFmqU/m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB4A886FFE; Tue, 12 Dec 2023 18:09:50 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AE2787015
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 18:09:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-28ad9492d15so25343a91.1
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 09:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702400985; x=1703005785; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lhs84GLOwfawe7fZiRY6QOV9thXT+z9aOeFH2TUSYS0=;
 b=VHFmqU/mG+qoA6As3oUvAPUlpiozR5Eho/HYgRcD0QsnmFct8SClbafxzLUfW5Glgo
 aQSQbhSiWZC4nEEEloh2/CN85ospDRngN2Uz4Z3buN85rtf+FfkGvuuQwr+EJ5/awiev
 W8em99r/3lfMK7Dac+iVzdJ4h/QF8KGTPcyr1YrsI7TTJLA4kakeNQVVkOq7C6KfMzFk
 1p+4vvb6hkFK4rfVAfXrl5GATMVbvyIglmiODdKUhj2Ctw0grjJVT6RioKKjS0ZHKVWe
 JmKAmBSOjMJMkU0eiI8Fim+wnehvaC/Wza7mUZBG+wG2NLy+hAGqQKUIimMaCvlOJboU
 txAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702400985; x=1703005785;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lhs84GLOwfawe7fZiRY6QOV9thXT+z9aOeFH2TUSYS0=;
 b=IZeEUiY3Up/VwNz2/ngcAamDHs/x8D8HmWvtBio6oMioMupGK457yOGQ/ijbsQun+h
 +Mdd2Jh1yz9k40fUbRc4OlPNoCNlmgolUXS0JkKuzUZloqfjZK0aBr0Fy/hI0j19SEE7
 Zft3mVafoIbrg5/x+IvL2mOO1N0mHTPRZX28JEco68DA8l0EPmKBHWg33I80szfTnn02
 5jMJFCAoAuUvLYy7YGP8DS9SeDRJj/vUwJ4K7kHlXibS1I3yKcMu9ZBeRwK4Ky4zqGNc
 eHV1mL62uGCz5OUgZdkFppSH+EP9EsZAiFUqNwjDV+yAVarWO5nl/77J2T1ObE94hZ4U
 Hk7w==
X-Gm-Message-State: AOJu0YzIIN3uFmUfg/oyU6KasVVvE/levY/+2T2xgmXaRsNJeAj68UTQ
 eWMNoNq4e2tL8XI8L3YsX2ZHz2+E8hTocWySpkI=
X-Google-Smtp-Source: AGHT+IHpkk8CTBf5q8jvuTXcuBaMeuNetTpaLCpJfxIzXXoDxcrzPN+wXxaCdz3NA+Y+AphbvnWuP7IEshOYAV9k9Mc=
X-Received: by 2002:a17:90a:d916:b0:28a:d272:f162 with SMTP id
 c22-20020a17090ad91600b0028ad272f162mr1051437pjv.2.1702400984724; Tue, 12 Dec
 2023 09:09:44 -0800 (PST)
MIME-Version: 1.0
References: <20231025230456.7924-1-aford173@gmail.com>
 <CAOMZO5B-QMKUB7rFAqvXPyMNJVm0PX+PPZoTuwQVo3uYhsX_-A@mail.gmail.com>
 <CAHCN7xLzZexpsZ=wS0Mu-vXdEmq4564bYz6vZYmp8Ej=jFb2Zg@mail.gmail.com>
In-Reply-To: <CAHCN7xLzZexpsZ=wS0Mu-vXdEmq4564bYz6vZYmp8Ej=jFb2Zg@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 12 Dec 2023 14:09:32 -0300
Message-ID: <CAOMZO5DJu==ZCGGjY7trx5sm34_ai_dJEP+ZgROeXDfiFsxLjQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] configs: imx8mp_beacon: Do not set
 SYS_CONSOLE_IS_IN_ENV
To: Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, sbabic@denx.de, aford@beaconembedded.com
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

Hi Adam,

On Tue, Dec 12, 2023 at 2:05=E2=80=AFPM Adam Ford <aford173@gmail.com> wrot=
e:

> Fabio / Stefan,
>
> Is there any chance this series can be applied to imx-next?

Yes, I will start collecting patches for u-boot-imx next soon.
