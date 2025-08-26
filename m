Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA58ACA0FE9
	for <u-boot@archiver.kernel.org>; Tue, 26 Aug 2025 10:10:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 577B2830A0;
	Tue, 26 Aug 2025 12:10:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZNaO/YAj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA083830B4; Tue, 26 Aug 2025 12:10:29 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74A2A83071
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 12:10:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45a1b0c8867so44485075e9.3
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 03:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756203027; x=1756807827; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MYCApx3j1ExPeuFojegMA4Y9nVZhlPB6b7R/qY7R2x8=;
 b=ZNaO/YAjs26yQ+iW6VYpqhvWbC+RKaku+u/Vac5Eq5BLl2e70qTjnPUWnxvtyJgZO8
 igNnavXXJro3t3SBz6jVkzSbebPzMujj5xw/5Jtif3CjxJuCSiUDVkZYLETbWbMcJcQW
 K7i807XnmyQBNNGxYPfUrPxP/IQChM5gXhX3hnHcSB7NTtTxsguYUOgKj9C4EHkbYIQO
 JrQQ0h3AFi7xC231qmOgZW3MMxwz4NCymCm2oI3AVZgfkbI4v15b4CEOTfKR2HkGymLh
 i8Zz2zwzlecsIsBXtsrCY9bEgRw+1V1IDgVbIdzIBPU7Cj85FK0m86Nt36PFSeCwO0ed
 viAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756203027; x=1756807827;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MYCApx3j1ExPeuFojegMA4Y9nVZhlPB6b7R/qY7R2x8=;
 b=dGsnhB1NfriOqzFpKUG8Yz8R+7+bkyL6IHUR1fNl13hB/2szFwLTpIcIn+trD9uRRe
 DJsleXjm6KC06bP8Bl8KwiyYuc/jGKWfmGClPJB4rFrCqhufOWNxolo0ysv59b6k46hJ
 Fwx5wu2sCijRVB5fbrwqVQJxn9kcyH7iaxEjW0InO5en657HYs7VsNH1/TlvAwruPCG7
 V6fwT5CilvU8PBFo8eUP1QOpvOpv8A1ly2Z3NLRMLvyrFugL9n+ZI1xtfh//2tITGHRB
 AIeOuf3s557jhk5YuQbUe9ldjdXnDneNU+KkaPUWW/uddzqBfRfcODHEtqMhTZ+KXAT6
 vLfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNSMkrNroomuQYubBLWHRdCZakVRatbw6t5qqBMFikER2OzrPY18MgTrq+Kq/tvqyPZkyWvOU=@lists.denx.de
X-Gm-Message-State: AOJu0Yzm+cAkg8L2p7oXBRjSTgetu+ezmvPrUsO6KKA4xZc7rAoiKhNm
 7bxNhtNbV9LwaAHmBAHMfXddxIF4ba5c/p/uQ6NxMsmVkvu+xYFuLBmG0erd1iEfY1F7IT0Zxd7
 gZwYitgMZQ5ilfC4nYmbkKwvkTuxLTB++KA==
X-Gm-Gg: ASbGncs5jZN3BpR5fRkGLxZED/1+pzasoOKwe6qChkHeQ3mDL9ondMRko7UCm/hlIli
 divpfZKsXRNsXKi7YMX1VRwNpDIrpDvrkIuuGFl7CiqmNIEGjAsk0Q7rg+R1Qoa9kNLJEmiIpXE
 Jt1l1dt5mbMCbcUqFK2ngTkZKQWyVJq2wjkK6rYSu0EHC8G0gHPr2ub7NF8o8EwIxMULWHQUfEL
 L/s3qho
X-Google-Smtp-Source: AGHT+IGAw3CCs/nSbZdiWxykiLwCbwkIerCWVa2Fe/v3oxg16rEYD957g3v1Z8oKu+6DqXoNrWLjOqlDYIxCHjp0dUQ=
X-Received: by 2002:a05:600c:a08d:b0:458:c059:7d86 with SMTP id
 5b1f17b1804b1-45b57035c5fmr107855985e9.10.1756203026693; Tue, 26 Aug 2025
 03:10:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250826093936.3521235-1-lukma@nabladev.com>
In-Reply-To: <20250826093936.3521235-1-lukma@nabladev.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 26 Aug 2025 13:10:14 +0300
X-Gm-Features: Ac12FXzED1bHwJ5yAU3sxHcy6YIyzPOK5P1YmhFKRZyimLWpBtnxGD03dHSd7G8
Message-ID: <CAPVz0n3wpLtXB=1ZS4WiihVkDPTza75dXDKMjD63OyeSQwACRQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] timer: tegra: Bind watchdog driver when timer node is
 processed
To: Lukasz Majewski <lukma@nabladev.com>
Cc: Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

=D0=B2=D1=82, 26 =D1=81=D0=B5=D1=80=D0=BF. 2025=E2=80=AF=D1=80. =D0=BE 12:3=
9 Lukasz Majewski <lukma@nabladev.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> The Tegra30 SoC is a bit special, as it doesn't have the separate IP bloc=
k
> to provide watchdog functionality.
>
> Instead, timer IP block allows such functionality when properly configure=
d.
>
> As in the tegra30.dtsi there is a timer node, which "covers" all timers,
> with 'nvidia,tegra30-timer' compatibility it was necessary to manually
> bind U-Boot's WDT driver (based on WDT_UCLASS).
>
> Signed-off-by: Lukasz Majewski <lukma@nabladev.com>
> ---
>  drivers/timer/tegra-timer.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>

What is the practical application for this diver in therms of Tegra
and U-Boot overall? Where is can be used so that existing means of
U-Boot cannot handle such case?
