Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7E4606A31B
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 13:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DMOmHcFJ;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=gjvaUDlX
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 27A8960724;
	Sat, 24 Oct 2026 13:04:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dyizZwgIuJLu; Sat, 24 Oct 2026 13:04:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6DE8060A70
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792847040;
	b=GhqSeLwG4N3RR3aFUX2PEhhR0TNnLJnw7EE35u+wDZN6w3sOyuOLEXK2aw1AnkOwZWLG
	 jiEpnGHDv3KkKw8wVTsgRqU86g1vzEVSS062Z9SR8wfz5DIL11ZFSlWIfiYIVxxakwQ+S
	 ALabSuO/aTjMAJaMOi6XCUe5tdn1zByU8ymzzo26X1k2TedSoWSmuFgpsQJrbXNoqL+Hc
	 PUJWS4GYUPE9T+IVR86EIhQvmmp2vCfl2/WvAaj6mbHjcUJpq2y3IiweKbkbOteN5jwch
	 sIybGuH2Xvlx9+zH9mUIC7zeydpF0r1nReneGbmgOv2nE/7WHz/i6A87Uez6mcIb7jg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792847040;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9qf9IKxbbYN/uWZx+uMN/oj83FionkB3b7lr1Bgi31M=;
	b=jkDw8JMolBrovWcqJJamGXHG/Cs+RBb6w6/XmMiKQxV5L+nYgqPx4HygF7aEmmvwqorY
	 85JPnYQglioo3BBN9esrZQ3JH1h/LTnXM6vJDbywZiQ3KXxzvO7AU4yfNYQ7jhLsDD5pP
	 QcJyvYoEMo1yfj12eJn8mvjsuZr3fFhUJsN2uf2YowMIzgBGtE/HexLoVYL1vgNKV0k/u
	 Oz3IT+ojvHcMeVvTGbsabo0rSooxEZv8DUhkWkxsuzkqXNsxGd+PIKxEYmkVOnGuY+aJ+
	 CHzgWtXOtbyXjqTB2HK6K8+aLmrww3IIJKebcauHPe2p+sX+SGUtrg5HX3vUlDqcTdw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792847040;
	bh=9qf9IKxbbYN/uWZx+uMN/oj83FionkB3b7lr1Bgi31M=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DMOmHcFJQ5QYJPQ11tPJr5BFedd5/2J16qIbVZjL0z44nZMtfTasvug0IX1aESUnn
	 w+duR6XQGm/hm27LPds97DyBSdZW95SSXXI5S3XA4n5ueckqS3CrtcTKdMKVb3+ELn
	 lTuT2l4RJc7pPAlzydZhrkuHdj6cg/jr6d7N2z12NNKEfenLy9Y8/Dd6OYvwk0//+a
	 szdoV0PFspKArITuHRL7xR1hH8/XZYd6/E1Km8IPK1G4ritPPbSDSMy7hs3UugZjeH
	 vADXOAgrlFYHNFPgtzGPW2hFez6eessq2WoMT9VHtYCxbIeQFy2nqP8DIqLh4Xmy+N
	 rSe1XHEKQGvFw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6DE8060A70;
	Sat, 24 Oct 2026 13:04:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E4AC8235
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:01:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D6F1181589
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:01:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gVyTpifWkL6W for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 07:01:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org ED0718127F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792825260;
 b=JJw+wEYwQYdMQKbxGAy1M92i8jNFHec1Nw7ks3YyOj4hZTBxURv9PI7aQ21tCIPb11uP
 quCHIEJ3tZWXz0dpXgh8R05t35IODdO8RwyMbLF/6uTh/lWCZ4uTJnMNFqHqQYtI5rilt
 OLAQA3uhcxpBEbmm717kgUWiLdU87YnLsvX4B3D1mth4JlM9MhMchwSyh4Ezt08n7mXCw
 UWU6/b48lIzAHD/rQ6ZQcxQzIOyCnM15Cn/S2vVuz5DAbHbhYW2koOW1/14PgI7h/kDKO
 AwJ+vuwSlqFSlUcr3D7NegNMVTtpx+ylbzqJAJCr2jCG5O2jvfY95VcgG64GKaE4Q6Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792825260;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=9qf9IKxbbYN/uWZx+uMN/oj83FionkB3b7lr1Bgi31M=;
 b=cnyVNppbebfMN/p3Rj80ns9GGhbcyeatslJDvvA9I68YeWSLVGid7xlu/R0Lb0CZXib3
 cRnvSL9UD3plqRKEFZI1nHHy4XvJ09WZesQ1hvDy/1k1h2tQcGGi7L4GCth27TxrtMNQo
 OaSDhibo46rzwJqVc2Qdb7NnevYdru/yPzqpINf6Pzc+JPcuQuKNp4DwMVit1wb3AH7nt
 T6Y/8c9UKtIkj9+dGlagjdk2e11BC03fYR7vWvHajEaK2pdYGXaBYUHlH2BHES51oEBbC
 Mq+RGXvrpZcm/j2qtG55+YeekYkaamLuoF44++O9Qbuq82qPfdameGxjI2LQPWN3vNg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=gjvaUDlX; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=gjvaUDlX
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ED0718127F
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:00:59 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6aa8d04fcddso2921717a12.0
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 00:00:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792825258; cv=none;
 d=google.com; s=arc-20260327;
 b=JcjnzxYOuxsdR8Eh9F7iovxsO6PBn8EhPKtRlYf1Ou/cXRcUiW36OreiRUVwVSqERB
 Xbhvxb36SqLBxLkIzR47lybQqZUkeIwPFXcVyAsbJZXfONCzupqLjw43aEiDKUP7mcpB
 m9UxHB1v4xn3FGkx2QQGO4G03+SUkRxZjHEjtnKRvhtwjbIoD/jH/AIxf2oy6mDKD73U
 jUWT8+34Y6oFCcErqIrBTIVH5xKfrQfX718HpIJpeineYOldbgdrOrAI+maSYDfyBHoh
 kP+u9WLMSwRRX2m9cdcsPinBB3P2bTro/j7ZPg3q5GfJ+6o8PLtW1Gn2uSwoBQXc/jzp
 dGQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=9qf9IKxbbYN/uWZx+uMN/oj83FionkB3b7lr1Bgi31M=;
 fh=K3qBHk2ExO+3ijmhm2JLE5PguYt4WNVvCbTK1y2ofoc=;
 b=WsMeHikV6FVsM/YLxk9Ylq3vwP7/r8kV2huWIU92UyzK9z5kwB3fIghvSh/sLq/qgi
 C0GHlWdVjvwYoNiHDJR5ue75/f8Haf/MRLdcv1Mpl505h9WVPLyBpC86XzmFOo34wjAZ
 w+n3BhooWkqmF6+A/cfjofEohXxfQwt25Hw+W7069G0dgzYLCqUxKmF7fiziYNoLqrks
 mevC96bujEcKMBu7LM4HGO88XcPukfbOyA99t9QiVAuZF4v37tnqjg/hSktYp3a2zIoD
 qMKpz91Qsx6lezY4sx/zmzTGP+91pxADhGmLU+bijhmdgliiEymZmxzfsC6M86206m2S
 bo8A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792825258; x=1793430058;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9qf9IKxbbYN/uWZx+uMN/oj83FionkB3b7lr1Bgi31M=;
 b=gjvaUDlXdvxx1NHoc0C9zimCmRxzmSUJgunu8YKVbnf4XWIieHvND9J3ieUHeq7WCF
 VGF/mYw259zFfl1yeIqeKmgWFILEQXAYH8c+4irke6OtatyrPj/lclNPp4cZ8j3UP8vm
 urzqcb3/oUQpFppF64lmfi2acJZmIgR4/iBQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792825258; x=1793430058;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9qf9IKxbbYN/uWZx+uMN/oj83FionkB3b7lr1Bgi31M=;
 b=sFx8ggombUpKxeA/KCWNLeqhbhBNt164ORyLPZEFSG2fDtVBDy4NiCcFkIef1IrjjF
 e2iUnwRmpWfxw++3sMvBEj0KCa25ZKEyB8mc14ifLTUXuxHQj/ppeh+wPMn56zsbKbMT
 OGEgbv6vQWho+sPCRwbDe7nkekeNIiB0IysH2c6iaqYa0/yUd/aCTtzrCIFkybttgyu4
 jOlHoT4tkqIgkp1GUIqckg2jtQd8jdLQPIK8FnZzp0v/44mOljNp/ge9ZeIjItnkpZT/
 rKWgrUvKHY/jdvuVOYoXrs8am/ELm3B+VVj55WBFwumCCKdKKb9jGX4HY4XGEbICV4zB
 xZXQ==
X-Gm-Message-State: AFq9FYLIFEPyd6Ezh1U2vW7gtbrzqI4HlnfmR1XrCDQYPc7uLOhKuH+n
 xU1+yc4oTRRHb7OYueQeUt5jG5Vj8l9LNpMo65DdSrrL7/lblDzCMflIb19Z4rF9eKfpHzuFbsY
 XRyV0IEypdXHZi1tPpuS1yVvepI2SQiMm43lyC57M
X-Gm-Gg: AYBFou33xyB+nsc4K9gZEBpqxumbaSAZssSza5hs1gVGlV7qKHlg6Lf9ed7+5YFip7Q
 HsP+owGQfIGHEXgCuiZ77IfbA6Z3NPhy1Uyhh6ynMCPsXdejde69oKTcrxHBNxDSsx2U91uRXvK
 yfogaMu49LRwLOwM5U2FPPtURBB1xw4uQha6gaIWgh21JqHuAhImbb7qo/Oe1HTyCM3snEkfaMw
 +fZAP7I7ZqywIyspWP74MR00Bj1BFU3yHYuI4YzZZCeW2nTgWmt2BR5nsoLPtw44nff4s3UinlT
 T17Gg9BvDW3zbSCl7emMxCPT3FZ8fsEbx3qfidULpcPsqKvx995TswsR8NLMleZOQegYaLijmzV
 t7427p8oCJnXgrqbHmnZzFm1dmYB5SCTii/Uj
X-Received: by 2002:aa7:d6cf:0:b0:6a9:8863:ada4 with SMTP id
 4fb4d7f45d1cf-6b442fb85c8mr942994a12.3.1792825257584; Sat, 24 Oct 2026
 00:00:57 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 Oct 2026 00:00:55 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 23:59:00 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261020-spl-fit-compression-v3-22-6647aa23ade5@flipper.net>
References: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
 <20261020-spl-fit-compression-v3-22-6647aa23ade5@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 24 Oct 2026 00:00:54 -0700
X-Gm-Features: AclHuK-qfBE4l3Zq6X_Uh0JbNlJ-XrQRrldNRRTo0bHgKHSdNcXSN8KqmEwq_sg
Message-ID: <CAFLszTgEvWEqiLv9ZVhEanyE=a7_OLqBK_m2dppieFUBBpKgdA@mail.gmail.com>
Subject: Re: [PATCH v3 22/23] rockchip: generic-rk3576: Compress U-Boot proper
 with zstd
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, 
 Cole Munz <Munzzyy1@proton.me>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>, 
 Richard Genoud <richard.genoud@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>, 
 Max Merchel <max.merchel@ew.tq-group.com>, u-boot@ew.tq-group.com, 
 Petr Hodina <petr.hodina@protonmail.com>, Bruno Banelli <bbanelli@gmail.com>, 
 Carlo Caione <ccaione@baylibre.com>, Peng Fan <peng.fan@nxp.com>, 
 Marek Vasut <marex@nabladev.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 24 Oct 2026 13:03:24 +0000
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Alexey,

On 2026-10-20T16:40:47, Alexey Charkov <alchark@flipper.net> wrote:
> rockchip: generic-rk3576: Compress U-Boot proper with zstd
>
> No in-tree board picks a compression for U-Boot proper, so CI never
> builds the compressed path of the Rockchip FIT, nor links zstd into an
> arm64 SPL.
>
> Turn it on for the generic RK3576 image, at the highest level, which
> shrinks the payload from 690KB to 296KB. The image is meant to boot from
> whatever medium the board has, so this suits it, and its SPL heap and
> SYS_LOAD_ADDR already leave the decompressor room to work.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
>  configs/generic-rk3576_defconfig | 2 ++
>  1 file changed, 2 insertions(+)

> diff --git a/configs/generic-rk3576_defconfig b/configs/generic-rk3576_defconfig
> @@ -9,6 +9,8 @@ CONFIG_DEBUG_UART_BASE=0x2AD40000
>  CONFIG_DEBUG_UART=y
>  # CONFIG_BOOTMETH_VBE is not set
> +CONFIG_SPL_FIT_UBOOT_COMP_ZSTD=y
> +CONFIG_SPL_FIT_UBOOT_COMP_LEVEL=19

You could regenerate this with 'make savedefconfig' to see how it will
look. Apart from that the layout looks fine to me: TEXT_BASE is
0x40800000, so the 690KB image ends well below SYS_LOAD_ADDR at
0x40c00800, and the 2MB SPL_STACK_R heap has plenty of room for the
94KB zstd context.

Regards,
Simon
