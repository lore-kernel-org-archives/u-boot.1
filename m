Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F21BCC54798
	for <u-boot@archiver.kernel.org>; Sat,  9 Mar 2024 12:29:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 864E587CC1;
	Sat,  9 Mar 2024 13:29:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a76A9Aw5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFFA987D54; Sat,  9 Mar 2024 13:29:25 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DE2C86F67
 for <u-boot@lists.denx.de>; Sat,  9 Mar 2024 13:29:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1dd3c6c8dbbso4603575ad.1
 for <u-boot@lists.denx.de>; Sat, 09 Mar 2024 04:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709987362; x=1710592162; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dbwnfBFVjLAeYeWUNdW4g7EFqIw/u7etNn4A5QzjypE=;
 b=a76A9Aw5bNHa1Oq0t4VKqk+3OABuk9ptggJj7tX1LX6zww++uErea+FqXuDko69joP
 6WlXWoIl3h4Owr4o7fIkgVvVTTjuTdw1yzNNU6Lhifea6zQNWKfh00LShsPzwjhmi+LD
 H1la6DaKNc4PhHzB/8ai2zIs3Zlzxf/Vis1zdQAIzJF1shO1+OMWTZKsCg5PkBTwgwb/
 dHcU251T7S4FKzCMSu+VZYQ4c23Y0N2Xi6La7VTp1Td0GxfRi1lo2TgmEkFGMPjw5Y2H
 e8LM3BPH1lKqlom59cyaE2uds9AtJBCpEAxqLLMaHF8EKEDSY6DOnujjfOtxOGS22yxb
 ZzLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709987362; x=1710592162;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dbwnfBFVjLAeYeWUNdW4g7EFqIw/u7etNn4A5QzjypE=;
 b=eJCZOoT/kFBBBPPjYFgvWB+R6N5K4diJ7YZ2zhTHsTRE2AWS43/+q/K+8QjD+z1BaE
 TwcgSbmBXy7sgB66PoplQuHMwRMdlOW5Wq4QX2vfKCJcPjipu/2KeSSG5uOxKkYhqGvo
 +eqfV2DpYjSiiToi+4F4aAAEpqZuFTNgCszjVnks8mR7y23ppSuTM3QUgk9mO44rJC4G
 UsnjvS9AdChUOBbrGaneIbt3xX47fdnjb4tVd6LZJ5JI+7cF8107xnv1go5hk+R8Muqg
 3AGbJMRBFSxhy7CS1huhI9zIvXOaKvAemuWPqcQFZolgjisP1HaYmupVHvpNqbHTfE1T
 Nx6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuSavxJoNUz8YH9ztDRRacqQDRmdmZ26Ba73t5H1+5XWlc90Lmy19mJ3VTiyGqGAObwZrznX0BI1a1Mffw6aY6QUeMsA==
X-Gm-Message-State: AOJu0Yy/1ozWkPjcgjuBNCXOkneFWHztydLFPLuC84vE4Wx+Z/ookq5/
 9VW1PAV/6xur/1Z7ORg06BtWIlZyhQHeph39mbZVYziXRByoOE8QWwyxQQv2nPBwZyJ06G2PrNp
 V3v6iWDfPpWQQfNll7kkrHQ8p4e4=
X-Google-Smtp-Source: AGHT+IEyR02UI3chJaIt4hiQdLqwe67Eug5KZ3MhwaqBvDpvARRibbW8yllRVzSA/e/eMFVHkH2FbxSpF9am5iGtDb8=
X-Received: by 2002:a17:90b:2306:b0:29b:e0c5:2d90 with SMTP id
 mt6-20020a17090b230600b0029be0c52d90mr112679pjb.0.1709987361839; Sat, 09 Mar
 2024 04:29:21 -0800 (PST)
MIME-Version: 1.0
References: <20230214133814.4173549-1-paul.liu@linaro.org>
 <20230214133814.4173549-2-paul.liu@linaro.org>
 <CAOMZO5B=EYPSNXkr=FM+iRvRYiv9fysB8DfhntuhQ_jhkKz38Q@mail.gmail.com>
 <875xxvratg.wl-maz@kernel.org>
In-Reply-To: <875xxvratg.wl-maz@kernel.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 9 Mar 2024 09:29:10 -0300
Message-ID: <CAOMZO5DBzEcga0-QGBBP3twT6imLuCv0cD6EYLOTwGN47wTxsA@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: Reduce add_map() complexity
To: Marc Zyngier <maz@kernel.org>
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>, u-boot@lists.denx.de, 
 =?UTF-8?Q?Pierre=2DCl=C3=A9ment_Tosi?= <ptosi@google.com>, 
 Tom Rini <trini@konsulko.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
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

Hi Marc,

On Sat, Mar 9, 2024 at 6:53=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrote:

> It would be good to narrow down which access is generating this. It is
> an asynchronous error, so the code above won't help.
>
> Alternatively, and if you are sure that this is due to this change,
> dumping the page tables and comparing them before and after would
> help.

Yes, I am sure the error is due to this change. It is 100% reproducible.

I am not familiar with this part of the code, so I would appreciate it
if you could
tell me how to dump the page tables so I can compare them before and after.

Thanks,

Fabio Estevam
