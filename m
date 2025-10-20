Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4721CCD193
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 15:19:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC6E882C84;
	Mon, 20 Oct 2025 17:19:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L+0uk1AC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FEF1831D5; Mon, 20 Oct 2025 17:19:01 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21955807B1
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 17:18:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47100eae3e5so879245e9.1
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 08:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760973538; x=1761578338; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gE/zXH7oj8luuojug2mx0yUjKnI3txoF+d9+NmJbjas=;
 b=L+0uk1ACv4ihkErCtFNmUOrzbtSWQ94U2wUBIpl9YA90bKmSCbyi4wjXmrrVgFU8Ug
 mefJw+E6scoQHjvkiWhDxsNcS3GF0+XgpUMHiOsWjCFzJv2JiB3TJsoKEyOhNZetT7xW
 OX2DgreIdWXs4Mm+GdcMZM2ssUnCX8SzCmEKG7JayZYspfPZtXd7mxgnaW4aLk7oszZb
 8+I26SPwUOf6HzBk9pI2ucNYf+VqiyWNeK8/PuGra9jjhaMh4j7uPJnN98iKRdbYC9eN
 gS0T8Orm4tviB8dOH+Nq4ZT5QfYCxlZz0gkeDTX+aCHGldDP+1+FUekXlFipG8iM8Dgr
 Q5eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760973538; x=1761578338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gE/zXH7oj8luuojug2mx0yUjKnI3txoF+d9+NmJbjas=;
 b=tkHs/ajxfEMFkIVEftlhJ02w/W6hmFJvGF53GJX4xhmlDXN0PwwZAIBu+d2EMk53kB
 dwTZPy366Li4fTOZE3jSupUATkexNymwM3+sBNaJilOicbv9EAaUSW/hbDEbdio2ii01
 TugCKbjQBOx0QsRewEotv2JuCI/nxoxfpA6kxUN8JwZno0MCaZ4qibAPBVpaGVyEnha6
 1sCIffDCiYsP3uoUphtN+ycMXRjMPqNwtXK8xaT6siUwu6W+J2LGdIwf82L5o7uhZkRD
 ljTGaZO2LIZw/pdiG7NcjK8qCh14+TDI9uuvIlqKzmxHo8FKdwRpHP+3mWkxrCw/XfW0
 ot6w==
X-Gm-Message-State: AOJu0YxKiJbsnjgpGG76z3Iw6Ytkae5Bs9Gb67zEG16WVZ5dfHVaF3rc
 zOKHiE8Sjm43g+yvvScWOq0yUiURsij++sCUcvUd6PgadLOv5/8XEcCG5YcmNA==
X-Gm-Gg: ASbGncvUAylYn3A6Of2RetWrbjIqBomMvTFwfcYcH2cqnrB7U0hR2QsZZ+hHuLQT6i/
 rPRhv8/E997/yzSfreutVA0wIntuapa9M65JiXQzaYDgedRbdCkydoLMISlQk4tgLPCjxDi1/9U
 Ka0P6GIO3z5/poJloNKv/C054c0DhWLlBJgPbEr5JF/0MI2IrSG01oxEJNUCCS5BBHb418kBwUR
 45aZ1Ts8UyCFhmY+QB05KvSESOXo5eSPmWCXwytA3ZUHcaW0mj340TavRdnOnlBoyPIargXZZHc
 /BlNFeILGkoGYTwTnvDJPCLvmu9I+2BouceF1GoLL89xcjWbqmlvtpze5GAklwE+C3BOGeD6dNA
 wFqmKuTvBt5x9X9nC5lizgKmt7nUwhA3oxaVCb0meBGL1VfrWISZDIuGqD7nb/l+ekOsyHeH98Q
 Ui+0eCQunn219D34TttJEkQJ0wmoI8WAH8yZDnReMPc4fnFezz2kTMQznWeTqCIwkXPhil
X-Google-Smtp-Source: AGHT+IH5qaGiohHu1jrL8Sfsr2c1k7P4tZGm1c6prBnxmOD+RBX2uP8H/wW7wKCjofz+j3EUhUgieA==
X-Received: by 2002:a05:600c:64cf:b0:471:12ed:f698 with SMTP id
 5b1f17b1804b1-4711786c793mr106360845e9.8.1760973538344; 
 Mon, 20 Oct 2025 08:18:58 -0700 (PDT)
Received: from jernej-laptop.localnet (178-79-73-218.dynamic.telemach.net.
 [178.79.73.218]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4715520d753sm150384595e9.13.2025.10.20.08.18.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 08:18:58 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: u-boot@lists.denx.de, Chen-Yu Tsai <wens@kernel.org>
Cc: Chen-Yu Tsai <wens@kernel.org>, Andre Przywara <andre.przywara@arm.com>,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] .mailmap: update email address for Chen-Yu Tsai
Date: Mon, 20 Oct 2025 17:18:57 +0200
Message-ID: <5047219.31r3eYUQgx@jernej-laptop>
In-Reply-To: <20251020145527.2702250-1-wens@kernel.org>
References: <20251020145527.2702250-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Dne ponedeljek, 20. oktober 2025 ob 16:55:27 Srednjeevropski poletni =C4=8D=
as je Chen-Yu Tsai napisal(a):
> The email forwarder I'm using has run into severe problems with Gmail
> lately. Switch over to my kernel.org address.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@kernel.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  .mailmap | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/.mailmap b/.mailmap
> index f1b93d168e90..e08dfd3a5263 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -36,6 +36,7 @@ Bin Meng <bmeng.cn@gmail.com> <bin.meng@windriver.com>
>  Boris Brezillon <bbrezillon@kernel.org> <boris.brezillon@bootlin.com>
>  Boris Brezillon <bbrezillon@kernel.org> <boris.brezillon@free-electrons.=
com>
>  Casey Connolly <casey.connolly@linaro.org> <caleb.connolly@linaro.org>
> +Chen-Yu Tsai <wens@kernel.org> <wens@csie.org>
>  Christian Kohn <chris.kohn@amd.com> <christian.kohn@xilinx.com>
>  Christopher Obbard <christopher.obbard@linaro.org> <chris.obbard@collabo=
ra.com>
>  Dirk Behme <dirk.behme@googlemail.com>
>=20




