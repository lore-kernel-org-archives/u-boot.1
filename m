Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65394C3DA7F
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 06:03:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B3B188806;
	Mon,  5 Aug 2024 08:03:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AtsCh+PW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 093F8887E8; Mon,  5 Aug 2024 08:03:15 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EB7388874
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 08:03:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-428035c0bb2so28547445e9.1
 for <u-boot@lists.denx.de>; Sun, 04 Aug 2024 23:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722837792; x=1723442592; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LulymfjVZNX5dxOM/ci7R0h9ArwDRMbunN9SB6ivKQ8=;
 b=AtsCh+PWznlD/qMsBUEAbBT2X/nwYAnWMlUR9ktxcqfPw85E9W28XiF1S6m8E4Db18
 75su/+PV5Hg6IKXoUL1snDWG6X2o+pk0bmBNIVbZb2VqGp477fjh2IGDCOhpIMcwSoAY
 fxcXc3aNv7/ieBYdZYSca7AeO4YCmM5r3Ex1SeXM3lij69NksCZPhLb0QZFwyKINQG5F
 AKSH20O0GJbatbHZaGnPhTy7iIcHRseMk7kioJ49ss7r+inUkCYx1cgCYV9UR66qFkR4
 1Ac4KBJm+Dvx4CpOnFJxv9Gxk9wLIS29vF67DEC1MPuATXphFdenUGt5bq3IuryTSpZp
 Ppig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722837792; x=1723442592;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LulymfjVZNX5dxOM/ci7R0h9ArwDRMbunN9SB6ivKQ8=;
 b=qp2CV2dgZ9DA2U5V9qdI7UmZw0+PGEcGBzB5U0x6Al4bZ4T6DKRQg17VapPD7gNbcq
 L2up0QozMRwETrwJ1w4bzgqZsVnw2LSXkl9kGQZLkLc6bFcHLGLiNdFmemEa+OwcGfgC
 q/F7jt7Yyw8X4pYhLGrWlD3g3AfCDb5Y9OMlo9mA2y9gzpceOlKWt5UNpA50c2umWj3b
 c4lQNN2QYfYV2wXXK3GVlE6foCFADfEDhk9677BqovHD8Yc1quIHcbTPHYWfB1pRNjd0
 tJ3jitS4SOK2AYdd+v7/WqSnvHdb7LoMdOMCwBPRHmZZUAEglYtPvInTRdg3v/1fQczR
 WaLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5Hb7Vcshg/My31Z89d+h/lQ9s+256E93CL1ggj2hSjV7xTDjJe64WJzKnPXJejbLEnY+yKqY=@lists.denx.de
X-Gm-Message-State: AOJu0YwLlOGo2VIvC5xdXXjJ6YUbrhFEyzT9Hvr1fHEVqP8Kn849xLgw
 DE1Gi9Z2A3Y4NO4daQKHCzMODjaIQNdjk5GDg5ELFiS/H43Vh8Q/uhYgAmBo6QzlSBwHRnNcd4i
 JrYq8E/KfgudagDKKLEQ4dq3JUIU=
X-Google-Smtp-Source: AGHT+IEULB1yH4bdSDcCiuRym2cYwWAqtNJIdiTbZfYKaVA3KuNV/GioPntRS4ZL+owJj/zcavV98fBY3NXKZ1GwLkc=
X-Received: by 2002:a05:600c:470d:b0:426:63bc:f031 with SMTP id
 5b1f17b1804b1-428e69866admr74043975e9.1.1722837792061; Sun, 04 Aug 2024
 23:03:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240801055738.7601-1-clamor95@gmail.com>
 <20240805053343.GB7516@francesco-nb>
In-Reply-To: <20240805053343.GB7516@francesco-nb>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 5 Aug 2024 09:03:01 +0300
Message-ID: <CAPVz0n0vn7yTiEBdwJUmGogH8AZUL+YgmNobBzGzgcomiRP_sg@mail.gmail.com>
Subject: Re: [PATCH v1 0/1] board: tegra: convert boards to text env
To: Francesco Dolcini <francesco@dolcini.it>, Tom Rini <trini@konsulko.com>
Cc: =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Thierry Reding <treding@nvidia.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Joe Hershberger <joe.hershberger@ni.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>, u-boot@lists.denx.de
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

=D0=BF=D0=BD, 5 =D1=81=D0=B5=D1=80=D0=BF. 2024=E2=80=AF=D1=80. =D0=BE 08:33=
 Francesco Dolcini <francesco@dolcini.it> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hello Tom,
>
> On Thu, Aug 01, 2024 at 08:57:37AM +0300, Svyatoslav Ryhel wrote:
> > Move env stuff into dedicated files in boards (1st stage).
>
> Is there any plan or expectation to move existing boards to text env file=
?
> And what about newly added boards?
>
> Francesco

If Toradex developers want to deal with this on their own, I have no
objections and I will load v2 without Toradex boards.

Best regards,
Svyatoslav R.
