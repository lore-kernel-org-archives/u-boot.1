Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 737CFC2D0D1
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 13:38:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA259883C2;
	Mon, 24 Jun 2024 15:38:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VexbAKae";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18305883C2; Mon, 24 Jun 2024 15:38:30 +0200 (CEST)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67E9387DEA
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 15:38:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-6e3341c8767so119075a12.0
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 06:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719236305; x=1719841105; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oKetbJxWKV5UNnNFu4slU6aNMe6wuAR4uUc//nBzKV8=;
 b=VexbAKaebE3eg94neTpbRReYgg6ZrFNWhrp2iAZI72DAuNvBVnNHvzvQWjdeBrAKPO
 8H8vW4KoRVdQ9NLSmLDgngI7W6Q5CqCnPEarOTnPPh+cuNYdVUX+BsADvFhsn+3dDbEH
 jXYS5Im44A/KKZIaSqpohDSVMc+suj2bIx3czpPpAUBUEeuzcR0Rfd+tW9ro1+5SaixV
 /1ZVAbuUfOO82Zdy9uKhsbirEmZ53cR9gbE4SdWmWAYgcqZSbS0I+cu6XyuBalYcOc0a
 GHL0x7B/Wy5/MDvEeGXC5c0wOIRhG439mN6MCQR4/J8FBarhxheld3tBaIBIvt8rnbY8
 QXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719236305; x=1719841105;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oKetbJxWKV5UNnNFu4slU6aNMe6wuAR4uUc//nBzKV8=;
 b=HiUBugdZBTPFDAqv3BIN+8GRG3YXafnJKUopkP4ioTEmfZCKRfjqOi9UwIjVXfB9Pu
 XmqKBwGFylwCPYXrSLEuFA6hEWZ2nW9dg/It/mt5xysXn04JG686FU6gBO6Mfz4KZoTu
 TxFW3Ai4WYGrHzWDHlSp5+i7jrYDfalGqNdYlgTGeBOLnBRoUnDuPKbp3cXFIuUyK/es
 JUsj0j4C2c32Ros4A5CANJXconwoiNEqoJMFDqWwws5qXJ+u+Ozhq81HxI6o4GVSdpI4
 xJSVWXqtL8j0iaW2MRkgKsvUPzAGWSMt3L+sQMRmJkPn9J98WA8enJV05AKXCQW4+KtK
 8UGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRWN+M7rSAlEfmIWRK4D+nR88qB5/URKpKVoD9pQmaJL8THvri6tqOcpAG5ZFXqEYHL9DKXzEElcEC6Se0AgKWQsCgTA==
X-Gm-Message-State: AOJu0YzaTmroyBFGB1XR2Si7b2GX6ZSBgfMfBSn1Dvo/FsXMbXcsdLKx
 GaXiweU7t4ql7ROzXHW0BL7lXsnPwL4FUOnF/kw28Bm38pTdd90yRYmP7xnO5E6u/jhFPjZ3vbw
 bR1bToSIcytr3dEqkiGVVJqYhMS4=
X-Google-Smtp-Source: AGHT+IFVDSHvU3ASVPGn8v5iKKnr4W8QtDVSUbpJPa0AryhUQkbAR9HyAjIV1Pso61e/CjWAT2+gBG6fSWb+J8v9fv8=
X-Received: by 2002:a05:6a00:3119:b0:705:c0da:bdc1 with SMTP id
 d2e1a72fcca58-70667e29347mr6091569b3a.2.1719236304889; Mon, 24 Jun 2024
 06:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240613102409.19535-1-patrick.barsanti@amarulasolutions.com>
In-Reply-To: <20240613102409.19535-1-patrick.barsanti@amarulasolutions.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 24 Jun 2024 10:38:13 -0300
Message-ID: <CAOMZO5C2p-EApdjTJ6YZSSB+_4M6EiXdhxJizONy1cJnjj7sPA@mail.gmail.com>
Subject: Re: [PATCH] arm: fsl: imx6ulz_bsh_smm_m2: Migrate to OF_UPSTREAM
To: Patrick Barsanti <patrick.barsanti@amarulasolutions.com>
Cc: sbabic@denx.de, uboot-imx@nxp.com, u-boot@lists.denx.de, 
 michael@amarulasolutions.com, linux-amarula@amarulasolutions.com
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

On Thu, Jun 13, 2024 at 7:24=E2=80=AFAM Patrick Barsanti
<patrick.barsanti@amarulasolutions.com> wrote:
>
> Migrate imx6ulz_bsh_smm_m2 board to OF_UPSTREAM.
>
> Signed-off-by: Patrick Barsanti <patrick.barsanti@amarulasolutions.com>

Applied to u-boot-imx/next, thanks.
