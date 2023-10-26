Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 935E8C25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 14:22:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B67487B72;
	Thu, 26 Oct 2023 16:22:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NRcQj2D9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4B38875DE; Thu, 26 Oct 2023 16:22:05 +0200 (CEST)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A0D687604
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 16:22:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6bd20c30831so210254b3a.1
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 07:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698330120; x=1698934920; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zowPVLLeOEqiZEjX8imEmB8khvvMStkszg9sf2/BY6E=;
 b=NRcQj2D9ZxpwMDqTrKuY3jKgAIOkZvd0mFXE9AaUco64F8CRZfcW0vwq66ranZDtRp
 kCdWv95lFpLjI9LD4v5qk2PTM8AVMqt4trTVAWRFtKdWt7ZjzgmX3XUfVDMtDNkzBYex
 c35DMJa/QetRHCr1odheAVlYaAj9SHe7AXXQBBm45hTOUZLiTuIN5k6ODM6ETNO4slgk
 RYSeSHRZ/IO8t54DaB6xcgJsU/aNJokXAskYWEPpaYhIrATyClOoP/5dmGx+5ARVKOSo
 6SGExseAZzCWzWJKcwT5rw4B9+xXJpyTLo+yokcgcQVGFgYFg2ew5nR+4rkoOrKA91tG
 Hwqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698330120; x=1698934920;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zowPVLLeOEqiZEjX8imEmB8khvvMStkszg9sf2/BY6E=;
 b=jjbnJJV7jiIfoclFrMlop2zZkBzu9cdnpPsqjTo6lFMN6/ui7QyNWHWSjaY/ifeG4d
 WbqxS3yIcAt9HZl8qzdZo7/Uvg/QPOyhuFR38o3lQYjrMHf4lXUTKSzuZarciWAoSpd4
 m7xn7RLsGQDzIisrxXzzYEwYd7P/jK9BDCzL9C2/g/hRaJB54zL6lTNZlpcbCPPgMWki
 9cWXKHwdQvXghDE/S8FIFSDVrX5W2yi+w6b9FBUR7Dngsbu9S+kfVPLXMwkDuc5luPo3
 vJwtpbbjZcSGOGM1bVaxETZsC/7+5tt3x1rOTcYXMdbbmvq8hn0m+7s95KBR/GrgzOh0
 pxWQ==
X-Gm-Message-State: AOJu0YwTTqP1N6n0cO3cCYuwqM1H7VciR+LvnHs3WQ0ajdkxUzbXuy8b
 Y+SIpm2Ai2U3jLP1ZPpZsh4/1B0BxOTL7m0wm2s=
X-Google-Smtp-Source: AGHT+IFwFqJMEiaq8Qsu5Fic/EsMhQCCqL2ZXQz5EcwBzOF6PEsFn1pcqc3inMCSJXX5AsqsuJsTaTzUnFYV1SwE7D8=
X-Received: by 2002:a05:6a00:1a8f:b0:6be:cb8c:92c7 with SMTP id
 e15-20020a056a001a8f00b006becb8c92c7mr19763333pfv.3.1698330120375; Thu, 26
 Oct 2023 07:22:00 -0700 (PDT)
MIME-Version: 1.0
References: <20231019194323.2207989-1-hugo@hugovil.com>
In-Reply-To: <20231019194323.2207989-1-hugo@hugovil.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 26 Oct 2023 11:21:48 -0300
Message-ID: <CAOMZO5CX82MrdQEwv7FNPw4tDayw4uKzFJA+CGreBHyJGjLYbA@mail.gmail.com>
Subject: Re: [PATCH] imx8mn-var-som: Simplify FEC initialization
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, u-boot@lists.denx.de
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

On Thu, Oct 19, 2023 at 4:43=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.com> =
wrote:
>
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>
> With DM enabled, there is no need for board code to initialize
> the FEC interface.
>
> The ethernet PHYs on the symphony carrier board have a dedicated
> crystal/oscillator. If the SOM has the EC configuration option
> (onboard ethernet PHY), it also has a dedicated crystal/oscillator.
> So in all cases, there is no need to enable the RGMII TX clk output.
>
> This follows a similar change introduced by Fabio Estevam:
>   Link: https://lore.kernel.org/u-boot/20231019170441.1610453-1-festevam@=
gmail.com/
>
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
