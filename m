Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A43606A321
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 14:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QYKAZMRS;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=DE+1mFIi
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8537A40740;
	Tue, 27 Oct 2026 14:36:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UghCzGmXqQJY; Tue, 27 Oct 2026 14:36:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CB5A540756
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793111806;
	b=cZ9VlBt0MGEmxTsSJhstca4zG+fw/gZCsmXg56Tx0oXcfBtDoQPNSYSr9wNvQZNq53MK
	 lidASs6nx3FadrrA/05BrYQi0efGd4ah4p7lgKgG+Sj/+XZnBSKYPGVUFLKzS+IR7Ix5m
	 V0+jRjmGlHpX1nncOw3rBwPxtxRVTJRVdjU43BC6nGNrlQDCePuHogrj90eoeQLPR6TVt
	 GfzK/zLSBYBhMm38Sq72NaLdPKdHsVA1Olyw9wodLxMXCuDQhnAiidLNxiE0pBgl5mJgI
	 82dtURy7VU46BqaypFoo9zsgmLYxQx576h3s9+QcULY4pYj2zSZmnz/uPX4xCaBrXEw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793111806;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=qMlGtjeFAi4CEDwllcDtcW53/1BTI7uWOIbEa/rKrtM=;
	b=YHxq0ebUdYtrDdf+pRal7fhU+TS9u5Di0qx6ReLlblEz36x675KEXAZIkZQ1Ffb7z8V2
	 3kcDzGwfxT1x84r28E9Ah4y1uAGfXPH1qHsPUwSquUf2grj89SmD61wHTKJ1OqxbQQV4x
	 XS3mvtY5sb89r4vTUbU+Y4etMtsyidg4m2ceVHFfKkz+yY6tcxAQg4xh1kdmrp/ILSZda
	 eey6l0nsSnT1RaoNA1kYRe81hLIOZwPxdcc4qdd7mcpqv525oX8fL1SVYG/XyEfxHbSt6
	 hz+lDwCpfqn8G4ZfYbQlwz2yOaDyR2yBRaIAltroDbxDjA7QX33uTWKS0cGzsmWDVrg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793111805;
	bh=qMlGtjeFAi4CEDwllcDtcW53/1BTI7uWOIbEa/rKrtM=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QYKAZMRSYeKzwIvfsaxdb5+rvG7AQkY3Ywn/7tVsV68tzLbZZCohoYbQGrUXv2dU0
	 c2ElmnGg89k9twQgaecCXBpXpq9l75gVwym8On/rbl4YwVGz2QDGbpFoHVAJ9Skaz2
	 2P6otbg1q04Lzatt/OpgLeVNGDipO9Qy5ev1tFsIS8V/pRxTvtJKC1qw4VB5XyGyfN
	 /KK+ae9l46EUOfCWhkRtTf94EwDYs+K1LabpaDtPWQCbxG1WaQuqwIy8yCucrF4uY8
	 LtyXsVu3Hl4GxlOsOgE16ys2lhNlfa7dYjZVn4oAmkv9QTKNRMhFeCs60Bpgbro2z5
	 kZwNlwqqnMtUg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CB5A540756;
	Tue, 27 Oct 2026 14:36:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9353AB91
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 14:36:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 783A3402BC
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 14:36:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IF76CEdf4IY9 for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 14:36:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 816B0402AA
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::535"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793111798;
 b=dye0IetDLywc+vrx7IcTxG6a4T4lxy9RmUoErKsZjtFQcauNQyJvDq9QYvqjOm1slqud
 biOrfRGi9J5zMuSnwXO5JEDnBdImOL5be6TAJmdccsR4px1pfgbVlwt7hg2YIxJ5vvyaQ
 8HduIdMcB65l1/Goh2rQF9U7WANNjwjFjZykFmYnm5vgZ117HUwlh3HEwDZSU47aIfK31
 awlLfhFrNTL1jDdrWYrUoTpOg4fl2QcctLV1QyxUKH0MzF8x56i5emFhudM8el/H5qgFD
 vhkauqXvSVe9BuPGLLwZ2URwm2/dEE+X53gygD463wIJEoJQ47j4x9TtTB896bloU1Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793111798;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=qMlGtjeFAi4CEDwllcDtcW53/1BTI7uWOIbEa/rKrtM=;
 b=akldj6jngYZj2OIDFVZiFJ2yamidbLk+oNRoipu3MCCuqMLDwN4kj2M+JwmvM9CaTzEt
 IEGI3ltdN00PvH49TEZoAuC2s0PBsA4OBtdBy8xVxtCDpnGxKy4mKwtrD1mjGcRnbvTbE
 OCLOob9hSLAXMtZGGaRVhriuDA2C7wy+iz5TL522DJlbWfulvoL8pU0fEyO+JPQxbE6kX
 /XLrxoXxj3+V5dshRTUo32lrcPsp/r2Vyptsn423V72k1v9dgado1qC/k2gPdRZL1i3Bx
 FnFyzUFR+eHWIHgU3h7IYOwxO0+Xwf/An0rgz/GvXulJrsR5D7vk03eLhhC8/wPgvdw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=DE+1mFIi; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::535"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=DE+1mFIi
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 816B0402AA
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 14:36:37 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6b1aa2848d2so6977308a12.3
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 07:36:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793111796; cv=none;
 d=google.com; s=arc-20260327;
 b=rN2unc5XsZXfMT1N3hd6i9KNXjlUMgeSzfTA89VFaRtIYuA7C93I25bp/Rk2R4mNuP
 gYirhTzFgEP+YokXb5nR+LLuUMUOvPpJDBlJjBaYqXuFzB+hpQjnl0Uhm/0d7wncqqB5
 C569AlDoKPPI3huoG2omqrh3SZDgddlobDO+gq5naIvoNdt2i9rh8BtZl/0QZgDdoVXu
 /03UVF2B5Umpj5IfpECinsOnZpXc7LmwObdej3lB80vYSMaoN787jXc87JhmH/AE4oFC
 2GyrLRuD63vZQuyo7zsq7GExZUgZwaYaL1wdAPvHcHvzMpJgnaAcpDTSIKLqNlyUrDOb
 ComQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=qMlGtjeFAi4CEDwllcDtcW53/1BTI7uWOIbEa/rKrtM=;
 fh=T9GtstY6xlAlqUOI0xj6+iqo/7aRu4qtEupDTMWa4qI=;
 b=TK3VX5lH2fdu9KCSNse+iSEmx58+xslTz3HgXjdQq5pYPhL/1cAav9+4DvaAGZMQbN
 IVfRlTpf/ts6UKc2NIGgt5bx3Dd/Vm9hNwfikwm9hLYE9N9x3yjxZpiaDu31bykkU9gy
 qJWKuk5qiydGl0xnye/xGtweo2RxQJDAvjPW1oKr3cI753idJTgtzFhH6w9XliHfH4yS
 dLoIAVe1lOTMk17CFIwFh3qS7NaDMOh9ghZFqxHXQU3tLKcY1uMAYLF9bOvpd2IjsQLb
 unto1px4VsLob6jZoMlrofg3Nf8qq758c5GLmBHs+8ypCGtCpjtlJPWt1q6tNiSojM71
 WpTQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793111796; x=1793716596;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qMlGtjeFAi4CEDwllcDtcW53/1BTI7uWOIbEa/rKrtM=;
 b=DE+1mFIi6RA6dfVnwOhpqgaT3mwMdbWLbNZPrOlDtx88cojajKjIjawmeXyaweDyP3
 LjwqfdVFu7MfZXiHhb4WRlcZz9qQjYJskj47oebRKj+5YulsdPtSgF1wLDBtHD0pKGc1
 DcFSJ/ekAwM3YpaRhAQ3CwQpkFNbClB9Cu7bk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793111796; x=1793716596;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qMlGtjeFAi4CEDwllcDtcW53/1BTI7uWOIbEa/rKrtM=;
 b=QMYMohRN4ILm/T9lOFXmslq1cSy8V1xObGgFLVFPOcjyfM6wFVZ22Q0T17//Gqi2qO
 1g6OBelUDsV8rho/c9QG9LUgSYJtfHEd1Yj9QLE4ZHHsBbC6FbCYfKSw1voZ2FAtaXml
 04TR2+8UzFQYm/y4Gqi1oV3HPNqgsuN+5vJ0uqsT7vDh+0EE3GxeQ1oIMJ5w5bByowOV
 8CghUDusS9KbDiY2Fybh2KDu1QAjXehaj+/TyrhrpmmTV++INCyK4/j7VVevG0Snwxdm
 c1PMGgihah35nWZDIgorcPPBN9rAiLwlN92GJfNMYjXscs4dObhWA+Wa6TglRGGU9/Rv
 1opA==
X-Forwarded-Encrypted: i=1;
 AKwUvByBK5o1AiNTTAY4BAJqqBdbfcIannKK0kkHm08yUTqT8DgfnASBhnfTMVbqX/sG7Xz66Sj+P64=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI4SLRrTSxyi204Q98OJnNoDzUqoL5NWXWSbpXs33n7oS/Odd+k
 bv7KdWTvRH0jPyosSf7kBw5CFspkUjEMtV7EjRsS5VzSSoEPioIYCqHdHezHJjbhQA+aFyXUimU
 7YZcm+mlkt5D/+QfkoOl4MqXkPNB17iknH/W3gucT
X-Gm-Gg: AYBFou05PrVUJTPW+8LWhASP1h4sIePn9Igg/7EX8m/As/vwF6Z7Yn6zjr+4Ic2oFmf
 /9THbAGLPZtEFHCJLGiRKqhzeaKb7ezH2OhVkr/5EW2/ELKe7KalrUVpjx+CjkDxVYYydpYbyAf
 GJpZAXHXo5lGIc9DPE4k12ZT0BgT9TYe1eeJ/ugbw9UxS5BtoaK1rKCxiqPJyNVRktdaLaUe6zb
 ptqRQkM+saV5wcuJ/3NIfhnuGSe6q6oGtjSWIlLutfSE+ZWISvsBOd0KHRMI+nIMlaVZDCp4edW
 /QjYjcj5O7EtW62wK63qlVgkthFTko+kKgmXlTDkKXm20pn2roP6NQgLBoBMHS5L2KXJsJOgPo3
 Rqs8DefjhsvBkEidu/yeD8VdvMO18K2CFwxs=
X-Received: by 2002:a05:6402:42d4:b0:6b4:77ca:222c with SMTP id
 4fb4d7f45d1cf-6b477ca25b5mr3429449a12.42.1793111795900; Tue, 27 Oct 2026
 07:36:35 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Oct 2026 07:36:32 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Oct 2026 07:36:10 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261027123905.839-5-ansuelsmth@gmail.com>
References: <20261027123905.839-1-ansuelsmth@gmail.com>
 <20261027123905.839-5-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 27 Oct 2026 07:36:32 -0700
X-Gm-Features: AclHuK-C2djXhLsNUeavksZ6UHkOfNJvUG2GSKr10KLls8jRWJJ00FnZmluAZPw
Message-ID: <CAFLszThUxv-P5fx-7i6UtAKh2YXe-JExm4a19yynisDHjm9D6Q@mail.gmail.com>
Subject: Re: [PATCH v11 4/8] misc: fs_loader: validate requested offset on
 reading file
To: ansuelsmth@gmail.com
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heiko Schocher <hs@nabladev.com>, Alexey Charkov <alchark@flipper.net>,
 Rasmus Villemoes <ravi@prevas.dk>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Daniel Golle <daniel@makrotopia.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Johan Jonker <jbx6244@gmail.com>, Anshul Dalal <anshuld@ti.com>, 
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Neha Malcom Francis <n-francis@ti.com>, Yao Zi <me@ziyao.cc>, 
 Peng Fan <peng.fan@nxp.com>, Martin Schwan <m.schwan@phytec.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.u-boot-project.org
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

On 2026-10-27T12:38:55, Christian Marangi <ansuelsmth@gmail.com> wrote:
> misc: fs_loader: validate requested offset on reading file
>
> Make sure we are not requesting an offset for the requesting file beyond
> the size of the file.
>
> If it's such the case, log an error and return -EINVAL.
>
> Code is reworked and split in various subfunction to permit re-preparing
> the filesystem after a fs_close (called by fs_size) and reduce patch delta
> of upcoming support for reading ONLY the size of the requested firmware.
>
> Dedicated mount function are created to mount relevant filesystem only once
> and follow the same if-else logic pattern used by the prepare functions.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>
>  drivers/misc/fw_loader/fs_loader.c | 97 ++++++++++++++++++++++++++++++--------
>  1 file changed, 77 insertions(+), 20 deletions(-)

> diff --git a/drivers/misc/fw_loader/fs_loader.c b/drivers/misc/fw_loader/fs_loader.c
> @@ -113,6 +123,55 @@ static int fw_get_filesystem_firmware(struct udevice *dev)
> +	if (upriv->offset > size) {
> +		log_err("Invalid offset. Entry too small\n");

Ideally you would include the offset and the file size, and say 'file'
rather than 'entry', e.g.:

    log_err("Offset %#x beyond file size %#llx\n", upriv->offset, size);

In any case:

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
