Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305E4606A323
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 10:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uHIM9cA5;
	dkim=pass (2048-bit key, unprotected) header.d=riscstar.com header.i=@riscstar.com header.a=rsa-sha256 header.s=google header.b=MMHdobMl
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F10FD81801;
	Fri, 13 Nov 2026 10:49:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L-6BADj0jNKV; Fri, 13 Nov 2026 10:49:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 128E281839
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794566973;
	b=RGzQBfnT9Xb0ocBO+JIP243lVtxiGdrro1w850zxTU5tVL0KUwtWXmzqEjvqh6IW2oBS
	 Ot6aYWLTN9IpibY/nKv8d2pQYJxggzDJPqxQxh+CEgWZOd3ZEIlERkERgXftydrGLmsX2
	 WN7moKt2V/FlRiSj908+UhRcWZnxz53POMillAQJbv1rzAgpBJT27f2kO6zGhzGh5eejT
	 mbWWKAbJyeQOmcNIlU9N4lM3mW+TqlzcaWfqEBsqTouvm58L26EjZL2c9F0jv527YM7cv
	 7ys/2dhH7M/43158nbz34PIt6jV7rQe0BuJ5giiUXJA4Y/Jzmk8nEf3gjHG0JNBReLA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794566973;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=p/XRS3fMn7E2b4f7Cvdh73XoO6XMpFr29RI0CVEbCNg=;
	b=Xq4pvtq0+nDEsorYbJ/h7cOYPvwn4jd29BNHgq7RoqGCL5ULX+yqLDS+uxUlnL2SI5P3
	 tmI7Jhv6bf/B/VjZ5JTotV69htGN3udeTbmnPt5yzOsAXjrMBBAfgXfPyldqm0cE3hvL9
	 cq7LIKca4btlrsHAcHS8aNfvQhCzJQS7/DLGtFZhsUHh39evEyPQzSuEpyFa3PUYqhMHB
	 6dqsBaMo/F42WEzrtclMWgjYgek8tQgys1it18T+iSOrNDtaHzKzebRMaJO7OC06HHjO1
	 2qlIV82Fp+3TNGbMTDnvkKHJN9MtT9G17mTf+RoHWe67V2hyyZpmwUaa/pmac2AoBzg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794566973;
	bh=p/XRS3fMn7E2b4f7Cvdh73XoO6XMpFr29RI0CVEbCNg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uHIM9cA5UlAwiyCFz6DBVPLFUOkwDlgXl+R+S0EW4QkQ+0d5l/s2owXGJqv2VZy3t
	 wKAMWnlv++8bCxmg35JuyvgAMPbClcObjkPS3+I7x80JR4VIGSwBgSRfwxbx/Cx4lm
	 9wqW4x4tocRWZlxSP478we/p7koST1hciZwu/5RoSt58gDojWxXAYkeVVYeI1gspG6
	 7NvFOB1HKZ8dbh4kYLLIkcP15PyqlReuWzZi9M3r4r+TEVKY54sED/AfrBeUf5h57b
	 dPGTL5QetddcQCvugQOK/dNcb0geFVhnHv6CpDfyuyVdPJxIL1FcZ+uDOe6j3epCaE
	 zd4QImfJRSgeQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 128E281839;
	Fri, 13 Nov 2026 10:49:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C621F2FE
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 10:49:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ABEF060FF1
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 10:49:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DBuBh6yCRFpy for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 10:49:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4579E60FEC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::136"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::136; helo=mail-lf1-x136.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=riscstar.com header.i=@riscstar.com header.a=rsa-sha256
 header.s=google header.b=MMHdobMl
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4579E60FEC
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 10:49:29 +0000 (UTC)
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5c14f3dab0cso986222e87.1
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar.com; s=google; t=1794566967; x=1795171767;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=p/XRS3fMn7E2b4f7Cvdh73XoO6XMpFr29RI0CVEbCNg=;
 b=MMHdobMl3qhIf5VasyqDL+y0QMPeubot3w3PPjD26AH1mJ3S8XE+tAyNyaaDfWiUU+
 osn7RI2iKRkRKjBdtaHttIxcNnb8BKYWsc+rA2DJzYP8j4hubimRj9lTi56XLfiyNv+H
 M/GWtUM+NDMGBzBr5Br9/wHI4SlmR9nAoSYlVAbPdXHjDpEi5hSpr2A2JJUj1E2oiGOl
 ywovA9NlFBs4Wb7yaffrExcZf5QzUHkHR2+w19HfLANaMz2vsA9/QfljST6dLqKj2wF2
 ICdAPzp2JdAUIEHJwCirXOhb04X1OXNw5ro37jGxGDx8AxgaYPyZnkdrigS5geOQLJ5c
 tqgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794566967; x=1795171767;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=p/XRS3fMn7E2b4f7Cvdh73XoO6XMpFr29RI0CVEbCNg=;
 b=razn+hhXrG021VDvMmAhGdtrVtxDf1kPDu255qBkNGt+rvj681VAwgfpBgBsvb+Q3F
 GcoxVOyM5b9E06HqKy64lc/xE4TflGADpZy73DWhNVUEQ7yJaVrQcJ38NtPclqHDUnVG
 W6ptJoT0az67uz2MpOVUdoeGu49cPVayo3RNjugI7UGDkrMyxwG36bR/DioXasC3LKUC
 H9wvaEZIyLlsv15jjzeHPg3rxcUr/qY6QD04UaO8mYabIJRiOgZPYGfuZpNeIjG/q6ts
 HMsG4T8a5K0ATPayn6e72JKZ3Y6m8SBZSPU41i8XmHrykDnzWJUkLgbcJymC2iNpfDJa
 6Row==
X-Gm-Message-State: APuU4Z92r81G49lkUXCnfHCyDEslygfmWa8rZWEIBRzp21bWPMCvD4dZ
 RN4lsorsHylyhGPioisgEWewfZHbIeyfdQIneBV+X/Zr0ZuSugg9yHA2F1KixPn5otXV21Req7P
 b7jiIbdNEMgvWE/1YOhx7m0sMj6cqqYunUT7uClkUcw==
X-Gm-Gg: AYBFou22KT2PXstQ7JmUXPFDjx2UfPtSiJQHXtQ03MfWcdseYoqst2b6imzAMD39Fhc
 b+Gra2nybQxz/DFlekwlcB7iXTjp94QOze2Epd5SbQsiC9PNrN+Dx/UTKjK5OJi2JjeHk5O8omw
 WFHzD29p49l4M+hOK2p1XnZUX05fI0R26msIJOJ7SoBf+mqPKxzMHA7JfvVgumZHVzMx9kfOGtX
 ItkoCdYkMYB/nPEPh1hDd9TD15hY1j2vSyLhGGG3QohTvXtUDaBtMedrmpf5NO6TFNA9GYhnXAU
 i5cNsgX9p2CGzJfSgMMrKBtzOYD0Z2bLTWftP5U2hQC0utGInSmYqAShEoo5i5jVXN9ZuNqgEvN
 jigd5M69YYCaGM3GlkrF1i9bB4hngl8xbVCedQomefCfepy9ORZeC9YhMzxL9BzZLJiYolol1pj
 QU5YHUAtsqS2+iYpj/2pwtFrbX5mT3z1zCrK0idTSRRbzgWxSoGPKf5Bm6yVwGMVC2rE+bLQ==
X-Received: by 2002:a05:6512:3e24:b0:5be:494a:f966 with SMTP id
 2adb3069b0e04-5c1709d6a91mr879696e87.44.1794566967429; Fri, 13 Nov 2026
 02:49:27 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261111-04-k1-milkv-m1-prefix-v2-1-3dae0c911965@kernel.org>
In-Reply-To: <20261111-04-k1-milkv-m1-prefix-v2-1-3dae0c911965@kernel.org>
From: Eric Chung <eric.chung@riscstar.com>
Date: Fri, 13 Nov 2026 18:49:14 +0800
X-Gm-Features: AclHuK_Vkx1r3HcwOHK-sQDexLtZHhEuCJJ-SPMXV3kPStDehZ2Tnpx2vyXUkUs
Message-ID: <CAH22mJwpYhKNQYT9XiKreqqzDH9WBqxpWJFPQkCy29Z+aWnVkw@mail.gmail.com>
Subject: Re: [PATCH v2] board: spacemit: k1: accept the "m1-x_" TLV product
 name prefix
To: Yixun Lan <dlan@kernel.org>
Cc: u-boot@lists.u-boot-project.org, u-boot-spacemit@groups.io, 
 Bruno Banelli <bbanelli@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Guodong Xu <docular.xu@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Dave Klotz <DaveWK225@protonmail.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 5:36=E2=80=AFAM Yixun Lan <dlan@kernel.org> wrote:
>
> From: Bruno Banelli <bbanelli@gmail.com>
>
> board_fit_config_name_match() derives the device tree name from the TLV
> product name held in the board EEPROM, and only recognises boards whose
> product name starts with "k1-x_".
>
> Boards fitted with the higher-binned M1 part report an "m1-x_" prefix
> instead.  On those, fdt_name is left empty and the function silently
> falls back to "k1-musepi-pro", so an M1 board selects the wrong device
> tree with no error or warning.
>
> A Milk-V Jupiter fitted with an M1 reads, from the 24c04 at i2c2 0x50:
>
>   00: 54 6c 76 49 6e 66 6f 00 01 00 1a 21 12 6d 31 2d  TlvInfo....!.m1-
>   10: 78 5f 6d 69 6c 6b 76 2d 6a 75 70 69 74 65 72 fe  x_milkv-jupiter.
>
> i.e. TLV code 0x21 (product name), length 0x12, "m1-x_milkv-jupiter".
>
> The device trees are named for the K1 in both cases, so accept either
> prefix and keep deriving a "k1-" name.
>
> Signed-off-by: Bruno Banelli <bbanelli@gmail.com>
> Signed-off-by: Yixun Lan <dlan@kernel.org>
> ---
> I've dropped all Reviewed-by tags due to the change.
> ---
> Changes in v2:
> - rework according to recent main code
> - Link to v1: https://patch.msgid.link/20260825065257.69536-1-bbanelli@gm=
ail.com
> ---
>  board/spacemit/k1/spl.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
> index 0ce0a811830..8931c5f5362 100644
> --- a/board/spacemit/k1/spl.c
> +++ b/board/spacemit/k1/spl.c
> @@ -149,6 +149,7 @@ static const struct {
>         { "k1-x_MUSE-Pi-Pro",   "spacemit/k1-musepi-pro"    },
>         { "k1-x_deb1",          "spacemit/k1-bananapi-f3"   },
>         { "k1-x_milkv-jupiter", "spacemit/k1-milkv-jupiter" },
> +       { "m1-x_milkv-jupiter", "spacemit/k1-milkv-jupiter" },
>  };
>
>  int read_product_name(char *name, int size)
>
> ---
> base-commit: 8ea02c99391d2d922810065206721ead2863f075
> change-id: 20261111-04-k1-milkv-m1-prefix-762704637cba
>
> Best regards,
> --
> Yixun Lan <dlan@kernel.org>
>

Reviewed-by: Eric Chung <eric.chung@riscstar.com>
