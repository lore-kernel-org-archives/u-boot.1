Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D356F606A32D
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 17:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Qpsmr7g7;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sQvo5TgJ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9E03F6066D;
	Sat,  7 Nov 2026 17:57:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oDCmZDxnDA38; Sat,  7 Nov 2026 17:57:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EDD8860664
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794074224;
	b=MkVYdwFU5/2Vv7dox3ixR0x0thAUSVKCeJc6sTGndkG3ylXuZxVozmvwVA2wGajecUax
	 r+72cfN1LkuZN5x0ZZ6ZGMdR232RRVgtWpXTnB2g1dCJQbUSm0KQEcCG4kVWmfcc7RIei
	 uqGtuKP6lv3qK6HB9oiwCkRUz8Nqh7Onr1fXY3xZG1ZK+xwmsLWxpyj+0C4sjysJp4dTA
	 /T8iLpVb+4oRuFd0H4lCkZlvzpf5yRvRr4/dc1ai5XgXSXCLLpiEC6Ru5AsyZyuRFkIeu
	 4+npjkl9qyyZ2np7FrbKkLBdEBfmNKsUxrIYSIMZfjsE87irtIIJVP2lgxa6bQdVEnw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794074224;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=QT4dWrOkbqhX7QGi13TyCGT9PxJ6fZM6+2ZVKNLVxjU=;
	b=HDU26BBm3qF4u3hmJ8J3QEYTFaXP1/ifaJOER1vYADMhPPGnFvE73QCCOsTVPRkYPqlC
	 aX7R3Hr0tTOH6oB7p53dlpHXe3GwdnXAZjOo4yCRJUsA2YSmSacEE5k66cAYaemdoUGUp
	 SYLZQnXLwehsOwRVpjgA0sB8PcaZJz/NHEtZKVouBaxIB/ZLmkLU/Nuhi33Y8RYeJEGP0
	 SMYuZ8cH+3VkpG/UvOTPHGvvEEmMnAYJDkLbftzYlOwzD+XFOZi2GqPH2+/g5a23iA8hq
	 AMdWEENdP/YNuUUzOU6z+TptlSK5s/4PpqZSvPgTl0yrjY28hxPtsszrzrj30Huat9Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794074224;
	bh=QT4dWrOkbqhX7QGi13TyCGT9PxJ6fZM6+2ZVKNLVxjU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qpsmr7g7UH0dwYGvHdqdfdfpDzXZU1UbxBL4II8o4jvsyOGUHQN5UNt4XWQWDyae2
	 wihWSQtSjUJ6NhSe4a4B6ynytkxJtSqrXeSn4OdUO24Yz/KBcAOyVBFJS0d2z9vPq3
	 mglHo28A4eLuwfklruqmilpNSToEP1dGVF9421kokjgPHTIwSwdu5eI8yfX+WVXeC4
	 IoqBBRznRgmkqeVTu/lR5FTQWo8UV2/lIZqnWUDXoeqswweeRdS5Q7q0lpkWpWl7tE
	 8oatmIZJf88+G4YPthkBuJVzFpRjovYAMsyTA3JvnCVdjaZ+8KSYZSB8fQ2+SPLoZV
	 wfBq1ccCMJn4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EDD8860664;
	Sat,  7 Nov 2026 17:57:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id DE9E2211
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 17:57:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C42384069D
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 17:57:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ilY2ae4nkQNJ for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 17:57:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CAC4C4072C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::232"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::232; helo=mail-lj1-x232.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=sQvo5TgJ
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CAC4C4072C
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 17:57:01 +0000 (UTC)
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-3ab53a99771so11107261fa.3
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 09:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794074219; x=1794679019;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QT4dWrOkbqhX7QGi13TyCGT9PxJ6fZM6+2ZVKNLVxjU=;
 b=sQvo5TgJtW6DghP1MBynK4a+gok8hIMNMnGtroFwJm1teWWUiTkS90rNq2r1MECejj
 9AsNqjYWGiDNyiKXFBlYKnrzDWMs3rtBQNIv3P3Is70/qh9urhTTPSC5T9zHunBE6bbb
 fHT9sdSzu6wZJ21sOz2ss2jYE9Wha+np6DnKtT1ChCjXnH/1od7OCVWeGM+8ECpCIXVp
 II/A4iaObNffor+vtvjXYuabPlvuaub3evD6jvvagLr36TRgVZ8KKOj5CKyalc+sCr9/
 gZt5KufENpKd2sJr1txhWrkbQmukpovwfSNMGij0uYavmouOpD3H/iwWl/IVBUvqMfR4
 igZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794074219; x=1794679019;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QT4dWrOkbqhX7QGi13TyCGT9PxJ6fZM6+2ZVKNLVxjU=;
 b=BeKhM9FE2lxTq/3WZqZIjMYf4iJa8xN6pxD/IOKeridSUpz16WYOLjdX1f5TFBTQ1D
 rq35fwIztFFPS9vyNHFauGLTEVYnwGgr7YeWW/3FxPYFhpIgAJYKt+gjk1vZ8Sl7z1LD
 PNAu9P7BB1faI+tkiCJLSvU1azMIyOPjgqycFDSO1ksvE8YbUqdZnmYt18Lgol1dGb7q
 BAo0xZHbAbdCO5aCWgxNCxWR0PxmtDuUy7lUD9FoA5NuqbV4wygZ8w2R9PzZqgERLC0B
 Y9mN8ECBEUNR0m2O9uf3XCwaetlgsEFDXDC4VjNNfTei9Ic19pT9sp0k3PAvFKf/gdpf
 xDdA==
X-Forwarded-Encrypted: i=1;
 AL+hErESBBW7BOnbXHX3IBoCt2d77NQajWQBIXcZKFf6Ff95ggBEzZWxjt2IUtaLDhSsQKiZYi16pIU=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8Bs/zHh0+FBGMarg1BpL+NcdlFbccE+aOd5LrcUwIfKQWwxflZ
 4mGgBpNmfSq7GYxY4EKr2gyGrigWap6nRENVfIwzrVwCgGshxxXOEVoBTHEnMTtTaisylmGrbm9
 OpWplj+hv7I3HyVx9qlCX+kRL2X/kAg0=
X-Gm-Gg: AYBFou1Z0mtxqFDW1PxlXC93MAGu3gICRxfDT8kVWXIAChFv5nKeeSUxlDyAAYwDhfF
 mdkOCJt1i09ByCZ7pbTmcvfe/nJhCJJ04VX5gClJ5VUS3b6Mrl4uzDFbP5iry+Wl2Po8P6Fn+0W
 PGWHYtFeB32kJ00wIdNxNiDYIzqWU2My3/Jom/zxc4nmWnRCjMx5eRvLEezsJDwwebONGdKMK5C
 9yA787S3xREMz9Nt40b23pQ74gU7GO9CjDqMrO2SVRBMtTw3PzaZn7mwHCJ28oAvqzI1B4MRqSS
 3CEh8kpVeNP7Qjr+jN3dKbbfbKFYwtXqm+DyzliMfFV2X1Fv7s969NYFQ/1W3tlutI7LTQ2B6oq
 9stYEnsn3Vkr5sFY15CRTqBLiREe0G1nuDnlu5V3LL0NeygbhqGpsmdxNCZg7qcw81cvFAlTQaY
 M9uNd49qTAG6nhF56YcYdhbxeEKw==
X-Received: by 2002:a2e:be8c:0:b0:3a9:9a60:2c46 with SMTP id
 38308e7fff4ca-3acf3a24d4dmr13125031fa.11.1794074218594; Sat, 07 Nov 2026
 09:56:58 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029150701.625466-1-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20261029150701.625466-1-dario.binacchi@amarulasolutions.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 7 Nov 2026 14:56:47 -0300
X-Gm-Features: AclHuK-t8X4xmZ28LWmQ7D1676UyUDnxfG_DGNoaDEX0w1vE7_AVX1cpbcvENmg
Message-ID: <CAOMZO5BARZJg5RRG8+cESiONXpRKPcUtyCVMrjNYkUfA_fvp5A@mail.gmail.com>
Subject: Re: [PATCH] board: engicam: imx8mp: adjust the fdt_addr_r and
 initrd_addr location
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: u-boot@lists.denx.de, linux-amarula@amarulasolutions.com, 
 michael@amarulasolutions.com, 
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>, 
 Matteo Lisi <matteo.lisi@engicam.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Dario,

On Thu, Oct 29, 2026 at 12:07=E2=80=AFPM Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:

> --- a/include/configs/imx8mp_icore_mx8mp.h
> +++ b/include/configs/imx8mp_icore_mx8mp.h
> @@ -33,10 +33,10 @@
>         "kernel_addr_r=3D" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
>         "image=3DImage\0" \
>         "console=3Dttymxc1,115200 earlycon=3Dec_imx6q,0x30890000,115200\0=
" \
> -       "fdt_addr_r=3D0x43000000\0"                       \
> +       "fdt_addr_r=3D0x48600000\0"                       \
>         "boot_fdt=3Dtry\0" \
>         "fdtfile=3D" CONFIG_DEFAULT_FDT_FILE "\0" \
> -       "initrd_addr=3D0x43800000\0"              \
> +       "initrd_addr=3D0x48680000\0"              \

I applied this one, but please consider converting it to a .env file.
