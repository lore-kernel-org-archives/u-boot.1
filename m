Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD37E77187
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 10:56:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8824801CF;
	Tue, 17 Dec 2024 11:56:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NJPHHsi2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63D1D801F9; Tue, 17 Dec 2024 11:56:41 +0100 (CET)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A54C801CE
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 11:56:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-30229d5b229so50476121fa.0
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 02:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734432999; x=1735037799; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RYGwkfS9uEc0zLPZMK90LkKNyMA/EfMvKFcpHIiH3dw=;
 b=NJPHHsi2FQIiaVMeprZI3+Fh2T/3pkMEhPLWhEqBUauCJQ3jNMFYXzD6oQ7oBTcRK3
 VWk8V6VTNWDgQTWN35RdsE0f9HaVArEVMWSSjqjB+6eJyccAi7RMNlUmheJ/lSUosLJl
 82HnYmw8Qdlggy7hCEGAd2PEpsrwXO1HkdP7N/Rbs8iYb7G8pSf47s7xyA85zlv/gASK
 qLtVNHMRnbTrY5NCPKRsfRgmlocW0Htb4fBoCFL5N1YKCJe+YN1ABt/yw6dXZc7xp/3t
 +fueVtKHCAm8dPui3ASiaAOB+XUjI+YJaKUSEDbR1ZMkkWXFEv854lXJkch3N+/xHUvm
 r2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734432999; x=1735037799;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RYGwkfS9uEc0zLPZMK90LkKNyMA/EfMvKFcpHIiH3dw=;
 b=e3jZl4aYzjNT2gSSgJC6VKgzzkcwJW08TTZNq+cBz3ViJ/00vNBiZnfn/xDtlQLBg6
 CH19JHaha5rMNZadUQGwj6pYSyg/eBy4AanTTkHjNgMw1f+GrcBghfFHnPfkvR2BobfD
 u7sXrFsCiznlzahF4Hsk8sF7cLQamzCijgQqGIJE8+Nfiu9AH6pU1Gsw26jP/hCQw8U7
 mSemme070EiKCC6IRW/kFl/JpTAXoHToiBdrJAX9yNzAE8fzMJK+2q2N23tYA2Us61WQ
 nheopWv5JNe5tTIKzWmJKtojH099KE9pOrqWNADmxfB664aEibvAXJaO3om8zNgkp+TB
 WPhg==
X-Gm-Message-State: AOJu0Yxmp0FBnyH6Q2nXdgeim78zfeMv8GSm+Htbd2miWkx7lu3rwL4Z
 ArheQF+gy3QxOuYPBYhgCl04jZAzD/Rw6AuwTWuDGUYEv9w3xcPneA5sFpeL7bd7DaO3tBcHfvl
 yXUi2L6V7x2rnP10xD6nA6R3GnK0=
X-Gm-Gg: ASbGncvvfXwwLugfszGkIxJw2v2mtly/HZ4iAlkbk4koUz0ELSMfza2sPYMeV1a03Pr
 GUpkuLt3Mt4FodT17g0WruETCJl0Y1cUApsPEZy78bHTGmgfZx846iiBJOAvz6imxGiSH
X-Google-Smtp-Source: AGHT+IHLHG90pgS9NxN4YiC3MPtRIKpLKXXOdxoAXrJCC6UN+nER0D+rC6fLtHqHZbuYJqm2bpvMZU6VDtlxUdiRQJA=
X-Received: by 2002:a2e:a781:0:b0:300:16c0:b67 with SMTP id
 38308e7fff4ca-30254502b27mr71052141fa.33.1734432998502; Tue, 17 Dec 2024
 02:56:38 -0800 (PST)
MIME-Version: 1.0
References: <20241212172530.2551014-1-alexander.sverdlin@siemens.com>
In-Reply-To: <20241212172530.2551014-1-alexander.sverdlin@siemens.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 17 Dec 2024 07:56:27 -0300
Message-ID: <CAOMZO5DtaACcC4QGsy5RK+eH4aNSpYhiXR+-DnM9220z1WTsBw@mail.gmail.com>
Subject: Re: [PATCH] net: fec: phy: Don't advertise Gbit on (R)MII
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Heiko Schocher <hs@denx.de>
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

On Thu, Dec 12, 2024 at 2:36=E2=80=AFPM A. Sverdlin
<alexander.sverdlin@siemens.com> wrote:
>
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
>
> Currently if a gigabit-capable PHY is connected to FEC via RMII or MII, i=
t
> will advertise 1000FULL and 1000HALF to a link partner.
>
> Different problems may arise here:
> - usually with (R)MII between MAC and PHY the PHY's connection to magneti=
cs
> would have only 2 pairs routed as well, otherwise a PHY can negotiate 100=
0
> speed and there will be no traffic possible;
> - but even if there is no way to negotiate 1000 speed in HW (only 2 signa=
l
> pairs routed), it may take a lot of time for PHY to figure this out; in
> case of AD1300 it takes 17-20 seconds, which is waay longer than default
> 4s PHY_ANEG_TIMEOUT.
>
> Use phy_set_supported() in such cases to disable gigabit advertised
> options.
>
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Applied to u-boot-imx/next, thanks.
