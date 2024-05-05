Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9291DC4345F
	for <u-boot@archiver.kernel.org>; Sun,  5 May 2024 19:12:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D398E88622;
	Sun,  5 May 2024 21:12:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ADvPxmSM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3C4888625; Sun,  5 May 2024 21:12:39 +0200 (CEST)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF2668860E
 for <u-boot@lists.denx.de>; Sun,  5 May 2024 21:12:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2b432d0252cso366755a91.2
 for <u-boot@lists.denx.de>; Sun, 05 May 2024 12:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714936356; x=1715541156; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gxBAx+Ys9tLw6C6ziLVyWRJpbKXUQT9rpmD06o20rdg=;
 b=ADvPxmSMODhcDHYDqwuIXwAi5vbWGQOgcNaXlIYeZL8r2vmcRTIhvWCTeKLXrjM4SB
 dZ09ZRsmMyt35hV5ckaHBhF9wlEUewNbdHyRZjL15A3A4RZuq8mp9r2fynlnFaMnRBWt
 mUXCCK900gXf9BevatHzu2WQ3qzcofh7/mosySBI7gjI3GekG9u9c7ktaOpONcGqLFSV
 9gVe6hj7R6IIDOUGravVr9LLkSdLhiQRee9L+VklhXHLKsilMFauYjjmznUavTnonMif
 zUQFzZoKOa8nfHBE0uJou6V6pA17rklhP6EzBwssZcAuKjHE285ziNBCVHbIodqmMO/5
 xkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714936356; x=1715541156;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gxBAx+Ys9tLw6C6ziLVyWRJpbKXUQT9rpmD06o20rdg=;
 b=nScfQAPynQm79mxB5IhdH3JGjC45/HAz2Pl+waFMry7NWyRomlZe3CoRIUqEzik+po
 6crqzvmU15F2dmWDdLiCRhqueYnp+xbZC2+s8Ohgx6Ngs4P0Oifn9KcLKNep5LExjP+n
 nnHlPknRSnNSc8OYD9Z/dXlV5kz/WsvlKOzTsZr+IAcYTdLg+gEjuHIPnqwCqAmIDHcZ
 oxtpXdAkda1Tx9NeC1uM1MPZTqDviNxVlFsMIu26LIxEhhgegcbw6wJNeucgjTRldHy/
 3S6cMmyliDaPM4yaZ6W35Gsdj2wGXrzmXdIUSvPcYFWiGKODHPsRMgtNNsFSis6SJNLT
 S/3Q==
X-Gm-Message-State: AOJu0Yw6sOm+3ERRpd5CNAOiKtgAX8o6ToAg1AS7n0Tbwqp0j+K4AGPZ
 Rz+qM+jbefF/3oEzuYiz7gA0mYf/haYFukSvdQBy9tZxSeCrVqOyOBFnLWb+Anj4JJ7Wh7DXVN+
 vE4UHu3Rxpk+3USSoZ1MuNFWiP1Q=
X-Google-Smtp-Source: AGHT+IE2gnTRZH/x7/0LsAzSfNApafuXO51yKm8CGmCEQbEQRbYP6bk5/YZEGGCJLbCt/oyNzugDQyq/QV+riiafuxc=
X-Received: by 2002:a17:902:f689:b0:1dd:b54c:df51 with SMTP id
 l9-20020a170902f68900b001ddb54cdf51mr11148742plg.4.1714936356125; Sun, 05 May
 2024 12:12:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240425230314.497203-1-marex@denx.de>
In-Reply-To: <20240425230314.497203-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 5 May 2024 16:12:24 -0300
Message-ID: <CAOMZO5A4kVgxpYjbJ6YZXrK7KnN4zQEgf54U3UMUq3Lhr-zzZQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] rng: Introduce SPL_DM_RNG
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Angelo Dureghello <angelo@kernel-space.org>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Gaurav Jain <gaurav.jain@nxp.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michal Simek <michal.simek@amd.com>, 
 Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Tim Harvey <tharvey@gateworks.com>, 
 Tom Rini <trini@konsulko.com>
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

On Thu, Apr 25, 2024 at 8:03=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Add SPL variant of DM_RNG so that the DM_RNG can be disabled in SPL
> if necessary. This may be necessary due to e.g. size constraints of
> the SPL.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied all, thanks.
