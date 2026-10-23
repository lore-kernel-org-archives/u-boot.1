Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534F0606A32E
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 13:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kWjvS1qK;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=BVRP8WrN
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1B81A608AB;
	Fri, 23 Oct 2026 13:12:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bvIdGUCsaZUW; Fri, 23 Oct 2026 13:12:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 672E86070F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792761166;
	b=DkoAB+kYJeQWznViOOg5JR6bwhCtwaB6+cVbK8T7X0/Sjo1XquFon5OKpFEJ4HbL/Kdj
	 Fnw+lRqjttSWo77QbkWmL3K8Z99wAtdXwerM0V3Gxfdaxe8FRt8vxcVfAAJRMeaKFi7jZ
	 0dczvNFwM6Zy2crzOPlnLSK1qVuXij6R32uoX2Nsti55SaPyO2bX7d+OTffRhIoLlmYeU
	 mMnBjs6pa2aCBKWl2D5k3iI3kzf1X4Zq3ULt8C9WnziJdPZV5my0bg2GolXJVwU1Sk7qL
	 OL2MEV8x8UCRd4yer271X1PSv/nplWJmohONzjYO5C/v3j84GKP3tNe5mdXzYkXuhaA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792761166;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=XKXSIDTiN5fRNpHIGp6Ds5FxGPN+4wqjKR5tIcx/n7Q=;
	b=PNERYs/HOpnc9GMr4N7PNDl5lFqOcIwRIGq6IbwAfaJ3jQsYA7OmjMkx41WHsmxdL36I
	 jdbCy8csgDD8ZtEfY5zwK+cDJ38GjxVNjG77L38NuEu9QLzQ1HV5Yd9UEpwZqThTrtrND
	 VHvIAxLdq1T5AiRB4v8VYhUlzuZmvQ5zye0NbX7Gt+kFdMb7kHMxw/h9v/+zl6f/pfNCn
	 JkAGf6Wu2z/XgGjVGxPSS1X+f9sEcbwYwzr3UOlW5ty/AtO5HHGSnqr5Bp+RrubfO2W/+
	 4CHPPYOWNdo3ysSaGt0aGrO8UnJD7pA3fULlnR37dYqnD+GA0Q6aEsEaEY8eeCAVx/g==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792761166;
	bh=XKXSIDTiN5fRNpHIGp6Ds5FxGPN+4wqjKR5tIcx/n7Q=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kWjvS1qKPTxL2okuKmU2C0g3nbT/AYo92mg/JlCkkZs8oOeOMmjE3Gjs4C3zOKFqA
	 Swg6sAaAUN26AxnICLFA1iKbZegigZtx4ssOI+amXz8XOsxnv9wBmR8eCOpDz+bcjt
	 JTl4HuuADQQOAT2ngFF1jhevRkrizy4O4rZyT85drkbxM1/sZRwV5S40Ez34ZtWdSV
	 Uc1Ra0Z+TSP2VPgm6kvwZJCtr6rYryrKUplZGKusoD4WJM2GD35Wdievtm5KFsfR8b
	 IAuZLSIhkX/tGJHiB80k1ojRnzcwCxjKZdhsSIB3LeZihwKu7IPKlI2u2hrujCICNq
	 UUfhQDaUhE6aw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 672E86070F;
	Fri, 23 Oct 2026 13:12:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 604C612C
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 13:12:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5269281467
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 13:12:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MFsTSyHdKTd6 for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 13:12:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 56ABD81298
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::535"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792761164;
 b=ERHx5+AxWmSKcrroauFLkK1yJwTFQh3LluaHiN5g0vykAJpAtERjulYaGXxxjCf5lEWf
 id7kcjFEnvUn4vI1zYzDGANdFpMsDw3qC8jqsenGyuASr3F1RDJH09J7d1LZcOiYkJS50
 nM94fB302iTc2pWpUiLZ42HM7HPlEpeBGlKmHJVHZ8hfe/8p0nt8VSX+fUAbupeQqpUk5
 C6nEX+fc7bPWdSgmHzqHkkJu/nQZeDwUYBB+eqRjS1HfPynEDwKKErPYCLO6tEDccA3Wl
 /Hczxgg89/e04PYL36UT4Rbnqme9rD0wDehCgTRyuoKMd3miqzzD0+2ikoSCtZxNWzA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792761164;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=XKXSIDTiN5fRNpHIGp6Ds5FxGPN+4wqjKR5tIcx/n7Q=;
 b=AXSXum9p8hG+B4EiQZbEeh5FQee721RYbkagGxzrVjVVE7zXEUdtEz+rK7oh9I6iU2PK
 EAOlcnZrNRgdtNLseJrHPLEVXv9kfsXd9ej6PjW/KAeXgXIYXJGwYjZmstJjE/myVk2n6
 uNK98OV3UyMT2pi2v9xeyHEVUTqd7TJ991/zQANKExUV1r6W0uAFIU5yHfEktbPKddX8Q
 m+k2XNXo8R113YfAaFe63RMZ249n08AmkjqG7QTDXALfoVpIv13Aqdp4FtqjBcKL9elfm
 GE7numpN6wuqWe6B8u05XewnJ90aFOQHqUt4gFT6qwE/k0q1U4VTQADoxyRCWQKCXoA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=BVRP8WrN; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::535"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=BVRP8WrN
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 56ABD81298
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 13:12:43 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6acb9c018ffso1172562a12.1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 06:12:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792761162; cv=none;
 d=google.com; s=arc-20260327;
 b=ihIlQvk1G5BZIfuZZimIW21hnSkj23CL2I0fO5mKaqNV0p3b8r8Qydw26a3Gi/Q2ai
 ZAJf7GusJMPOtC6kDopHOG2V4plWHV4fWoLXSxPw2hVpNEnwxRGxE8AdRa2ivz9DF55M
 iZf1Cqzwa4ViZlmQFA2FZkCRUszbqc7z2B5DBFIWMV+OT8mQdYCLjQ2bboNJ99MLcMyR
 Zuj3Z50DYaLH3w0RpuQG0iwoTc0xvtOWof7KpUD/QmYULBFiffWpt773h36yTbYHDlz4
 dKu7SIftAL6I453UVvD56xSKe2O0boQAnkOWDDLrAHRrT6oETavFAZ6WNHAHMleQN+EY
 rMNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=XKXSIDTiN5fRNpHIGp6Ds5FxGPN+4wqjKR5tIcx/n7Q=;
 fh=lwFp+RoQvQiqXJEyTRBAE1NAR68WlXiyjRWpiUMz/bE=;
 b=qFJSP0prXYA7mFzFRF1C+Oz3WLzNTeJQmgA6hlDDNHqZVXZ/ac71RgS0W6xzDqTBxl
 ZaHGstY+xAGjO9GVMMcNG/2kIqOXkMhx9XitFnjRg7E342hyWEv55QIfkAkNhyTKw0VU
 lWn4ySueY7YNqSSQS74Ouof5FfbHPNCTgxgeY+k3QdtqRWpD4iGO8WqdLBlswdItzXc9
 Gvrd5cBLNAaPwcaR1o8lBO600myYQlnchpL2riyjQeqCPGgj0jaIbbgZPBvaeBhmD1jk
 lEr63O/e9gIGaqxBsD0KCExH+iLAKZiCfHq5GcHDHftxSh2iD8W0riVAFA34qzmmLBg0
 GlgQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792761162; x=1793365962;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XKXSIDTiN5fRNpHIGp6Ds5FxGPN+4wqjKR5tIcx/n7Q=;
 b=BVRP8WrNy8e65o5EvY80ZUbgpGLTHB/ncXI8MQVJuzK5jtwxxxWKJ0dpfcgQtaENSz
 SNMKnR2rljRToA6V7v05VhGHxrcv8kPNHGBaQH0I6D8PG8laqyYEwc9sbiKiYPPmXWU1
 hZT79c3X3tIzNIXnYIddq4GRaxOcyzjQTTfXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792761162; x=1793365962;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XKXSIDTiN5fRNpHIGp6Ds5FxGPN+4wqjKR5tIcx/n7Q=;
 b=MA/y9jQwwI+2dGICkDjVruGYc2NHY2yceHINckH4yr0i2Csz7+Tle+KWB9hFYFlLZb
 rCH+KhdHhVxOGZ/73bMIrhcGN3E7uDSKqUI5htldDOQWrUevmKuyhyov5SPUHV7lbzyv
 nZ6VIN4YXtDKYgu4i9ugYr2d6hZVowB+KnT2z36TNPwVzgJkC2RXmn/3j97WTFV3KdrK
 DS6ImE3OzAm9i/9vdhz1SQy+3P2WJnI6Jt/9qwN0xFT7EgrTjltL4SkZDtuxdviWOTbw
 KKh65yVdABsdCLaz2dFGg7nIBlhY+jkomHA8tjqKU0RaTQlxifBtQiqqI77Hfwyc0Gyu
 pkuA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzGfMg1qzA0QsqXbhcVCxPUfmx4ja+Ul1GEMnKOQcpDEUexHgDNtb0eLeCJ79CvLgOa+rEyqhU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKq1S8WTPGDSPnCcJmwTvtm4mEDMeNypydY/ib8Ck2ubc2n/aCi
 2NfTNyYJ1ZpFdmKC3dRzF5I9ugNZRSWvloPkd7Fm+9QBWFLmUluXNxLeP+x0azfabvVCG4SJ4qU
 o8JoNXsFWyNYBrZspy6MrLH4FexZ4/dQKFUYs42Em
X-Gm-Gg: AYBFou1Ls+Dh1QDMvlKKXnSYzL4qUNhUZdtXb//xKVFgPLM91dQf1ToZDE5TG1DpavW
 tAHElvEY6yho2c7uGloPb3o4aF5Jzp6QGobjNjMnblrk8ZXoZSoPbLhWGuflvG4gXG42/0gSXS8
 SMEVPr5mx/O6bHKwOcQDB+jH2w5iuplFAXjL6vMygiJHEF2X18AEVbY7CYpst4J66yX5YSssZEl
 lW4ZXOFF08jg/fJMgLvr8oNdatzb+mTh9oCAwWzIDoueULM+zX+yKtlONhrLobi4kB4ICs+bweX
 XWMJn9buCSYor+YEE4PtWOg4y7WfBNdBVYHIyoICEL+CSV6OqAfuSvPZjOAzyd+EWwj9Buw8o00
 aWbJtknacX3TXPNQfYFopwRpM4s2nuPfk4RI=
X-Received: by 2002:a05:6402:516:b0:6b3:e89b:128f with SMTP id
 4fb4d7f45d1cf-6b432bdea34mr2249484a12.9.1792761161901; Fri, 23 Oct 2026
 06:12:41 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 06:12:38 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 06:11:35 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261022194049.670889-8-ansuelsmth@gmail.com>
References: <20261022194049.670889-1-ansuelsmth@gmail.com>
 <20261022194049.670889-8-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 Oct 2026 06:12:38 -0700
X-Gm-Features: AclHuK-wTM4-XYoJ-6MudNqJ4dpzzzV1mwUTQn33bHM7ap0gy1GJze8u1KOdlXU
Message-ID: <CAFLszTg76SRJS3MZNi-OhuXSeaM8Sc4j_zA-CTdCGc04j2LB5A@mail.gmail.com>
Subject: Re: [PATCH v8 7/7] test: dm: Add test for FW Loader feature
To: ansuelsmth@gmail.com
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heiko Schocher <hs@nabladev.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>, 
 Aristo Chen <aristo.chen@canonical.com>, "Lucien.Jheng" <lucienzx159@gmail.com>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Casey Connolly <casey.connolly@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, Anshul Dalal <anshuld@ti.com>, 
 Romain Gantois <romain.gantois@bootlin.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>, 
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
 Tan Siewert <tan.siewert@9elements.com>, 
 Peng Fan <peng.fan@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Yao Zi <me@ziyao.cc>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Martin Schwan <m.schwan@phytec.de>,
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Christian,

On 2026-10-22T19:40:35, Christian Marangi (Ansuel) <ansuelsmth@gmail.com> wrote:
> test: dm: Add test for FW Loader feature
>
> Add basic test for FW Loader feature for the Filesystem way and FIP.
>
> Additional MMC testing image are added that loads a dummy firmware.bin in
> a fat partition or a simple FIP blob.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>
>  arch/sandbox/dts/test.dts          |  38 +++++++
>  configs/sandbox64_defconfig        |   2 +
>  configs/sandbox_defconfig          |   2 +
>  configs/sandbox_flattree_defconfig |   2 +
>  configs/sandbox_noinst_defconfig   |   1 +
>  configs/sandbox_spl_defconfig      |   2 +
>  configs/sandbox_vpl_defconfig      |   2 +
>  test/dm/Makefile                   |   1 +
>  test/dm/fw_loader.c                | 218 +++++++++++++++++++++++++++++++++++++
>  test/py/tests/fip/test.fip         | Bin 0 -> 101 bytes
>  test/py/tests/test_ut.py           |  26 +++++
>  11 files changed, 294 insertions(+)

> diff --git a/test/dm/fw_loader.c b/test/dm/fw_loader.c
> @@ -0,0 +1,218 @@
> +	ret = request_firmware_into_buf(fw_loader_dev, "firmware.bin",
> +					buf, firmware_size, firmware_size + 1);
> +	ut_asserteq(0, ret);

These tests show that the two loaders behave differently when the
offset is past the end: FS returns 0 here, but FIP returns -EINVAL for
the same request (see below). Callers go through the uclass and should
not need to know which loader is behind the phandle, so please can you
pick one behaviour for both drivers? I think -EINVAL is better, and
the cover letter says FIP is meant to match FS anyway.

> diff --git a/test/dm/fw_loader.c b/test/dm/fw_loader.c
> @@ -0,0 +1,218 @@
> +	ret = request_firmware_into_buf(fw_loader_dev,
> +					"45a113ac-c7f2-30b0-90a5-a399ab912716",
> +					buf, firmware_size, firmware_size + 1);
> +	ut_asserteq(-EINVAL, ret);

This is the FIP case mentioned above.

> diff --git a/test/dm/fw_loader.c b/test/dm/fw_loader.c
> @@ -0,0 +1,218 @@
> +	/* Enable the mmc12 node for this test */
> +	root = oftree_root(oftree_default());

This helper is used for mmc13 too, so the comment should not name a
specific node.

> diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
> @@ -685,6 +685,31 @@ def test_ut_dm_init(ubman):
> +    fipfile = os.path.join(ubman.config.source_dir,
> +                            'test/py/tests/fip/test.fip')

Please can you explain in the commit message how test.fip was created
(e.g. the fiptool command line), so the next person can update it?
Better still, since the format is just a header plus one ToC entry,
you could build the 101 bytes in Python here and avoid a binary blob
in the tree. What do you think?

Binman has a atf_fip.py but you can't use that here, unfortunately.

Regards,
Simon
