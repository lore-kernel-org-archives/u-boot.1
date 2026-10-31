Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128EC606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 14:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZeMz5cI2;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Fu4iHjLN
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E2F9880F66;
	Sat, 31 Oct 2026 14:06:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aFU-MQ7IJuW4; Sat, 31 Oct 2026 14:06:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 293FB80FBA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793455565;
	b=PeVLcmBouS3YqbZN8wclQd44ZaJK4X8YTX2YC/lCRiOmQ5CDqMFxyRH7fX3XF2/a/3Hg
	 /dxDrZXSOJm7/1RMnzemyOxoGMFSC5jvn4YSnDUxu7T3GcOPizXdk7HNxKpNLINLL61do
	 tng/meNUDexjlAiNhCLZnJMXfUo9fMYpu2qkB+yud0C8j3VHUiJ+iqJxMVdxBPaiMJFGt
	 zyKEHBnnjtot1C4Av7WqRvnAkETYTvH3u5LqiZIBUq9+oOUYhf3m4X3WOlhr1jmDhY6OF
	 BJyvOiOOo1wQ4aJ9joRnMpcAOpgRvDmws4C1Ae89L3zv/RnzZfzIF4HsE9GSQcubNWA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793455565;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=XMQI7NEQARmCVjAOHJELfRlkVpNKRidjrWSkAa8fiPo=;
	b=Rk9PuRuSeHxaBmLO5Ii5D0bCCP/xhwkyLEDCzw+K4TyCojfHHAHoKEqKstnYl7BGVxF9
	 8KvJGEgbuNOS2DLDSssc2ZaXD3EYvXqiMSmpk/dRqNds7b3zbCW56kGMpAbLnWQJ4KnKL
	 LIF03sCo9BvvZZZoBHsV6AAEfO1/R41VlUpr7SMd5RPzLhTct6s9dE04gpcoyqXCpN6mF
	 QjSlUSNlI/93eiacMMCc6eqsaMpeKj6RKUraw4ockD+fBeJhjS5wU2zqxPzt071wFeJhG
	 dBVqonhaFSNNhb9smpPbY74MNgsao6KbOh+BFOT/MmKB6YhE0u0OPQ/HMYISCn9jijw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Fu4iHjLN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793455565;
	bh=XMQI7NEQARmCVjAOHJELfRlkVpNKRidjrWSkAa8fiPo=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZeMz5cI2n+j3uZ3uUE743ANykVHcYpG/1lsDT1jIStl/stddlUai62T1/1nlYUbeT
	 3CZYg7YjC5+WaWiquR7Y7cXh7PwSi+M5FcIo4sl4c83JuVBe124TjnYfEhtvORfm+x
	 z/2c6jFPSSySKFVrVe0SVPF/N5h/a91rB6UmwcKYS+w+yrKeOFbfoE61ejotDfjXr2
	 TL6D4myh1D01hSX26yZxkvbGs0FeFpVjYew99AGGozr0a3uuLrFq0U/LkaSuKSx68m
	 LsoXHuVXMCasmtz/H4ZqMf5NP1i366dLqCB6cZN6OOG8/GDtsB9EulUy9Lb2aGNFw3
	 5MCWs9tyxNUQw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 293FB80FBA;
	Sat, 31 Oct 2026 14:06:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1D9A4156
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:06:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0EFE380F55
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:06:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0LzEuz3iqWyz for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 14:06:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1DC2280F4D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::536"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793455561;
 b=aMepfGY7JJ4xf8nNVfwbwCOTyB38Rthrnm8R06Nj0Wc1Ez++V9+uTsqNRuz6WPgMJX8U
 EybqBzVFy0vtrRQFy0QzIA+8BkOul14o/hNplX4ucNocU1Kvsr+siLH4E1v4TOsheqMvL
 s7B9zl5KQm3iLYn/3VFhowj0J4GFxzQHc11z81plecJrwlvOsuWf8Rfc4vjhGT3OhfSvt
 oPGpvNx901Z6d2CXbyNc2orJm9PNq4wZCYe/6hUcPNNUS42BY47HuM44CMHet0dZCOtHN
 X6nyejievvUUSXulFtbA9BhHMhS9OYxvVGu7M8A/T3CZyW/QxTbUfVdlIVQ8dhOt1MQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793455561;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=XMQI7NEQARmCVjAOHJELfRlkVpNKRidjrWSkAa8fiPo=;
 b=PMmsGo1UmYpg5XpO8IBjIH+oQ8FnWVPbmR54RYP+IsPBRJvZ68HLWbtFgN+KHdIWJ1Ft
 sFE2soUxEOfMayK9SvjejeYtHsCY7Boq9yqyVbDFbsEkp0WoU0/CwZ3zpMpzwR8Z8LDjQ
 jVFIW4Ah5esvKH1Et74/PJtJGWps9tADVVQnYyQ+PuqUIkYeFFc4OSrAyNA6EQrC51nuQ
 vmVIzaDj1ozqSJNKwMnSwUnm2dRiS25MRk/33drexox0BtzqxT0fNXb1oelQlW2+umR/8
 N1ILQIJjpyT7ghOPStoTLVT7AdBuvysXMyMUepdNezcwYpOADrZ0r8iSEy9YPBusJlA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Fu4iHjLN; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::536"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Fu4iHjLN
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1DC2280F4D
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:06:00 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6b167ffd132so2563737a12.1
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 07:06:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793455558; cv=none;
 d=google.com; s=arc-20260327;
 b=cOrBhKZBnrgq5sgEaBvL5UyTnc55KTpi/BDz0hv4iczLmd27j1gRP7SoECk1xSg/8q
 ut6e9bulRZFIXlLM/kHAhguMiku6zAgsco1DXxyuxJvDTe8BoIr14Nh7rU+z1eYIjP3N
 oizCDnIc1c1BKrGZWzNhnYLG7DuM1kibiGagnNbuJ6sWrVb64S+mLcRH5/sx0akiFKgj
 HM+vBZuTdapGyVQcqSsRPqiRR2N2hje/A2nG2Yw+cKTR8E2jnxnhumWJzriolUKBKvDx
 RPxmdegh3Y/06Tkjx0O9QSxQY9EGKKn0DwjWAZlXWMyMSOYwQSfhOm6J00l63CdLPO4G
 fx/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=XMQI7NEQARmCVjAOHJELfRlkVpNKRidjrWSkAa8fiPo=;
 fh=esqQ5hInL8YhQnKkMIO5BrDvW0R1Mr66hZxqV8e5gJY=;
 b=HFgNnau35Eo1ye60lEUvf//6Ud/XnyTYJOUtQZHA9vpads6l/ZVKo8Pbkww1q5yPhg
 stCIt7LBBWKrGzgpf7ybPSBccwz5aPoiEbVjELdYGEQtN/+lTj7qQLaTmmt4cXJ/zBW+
 6qM6yZfkuloUxlzwtcaIXk8j+WcwHpDuazlWbMBm9hWQjklIewpFvC5TA5emUxUGBZHy
 OQGMuJMgMCqi9CbceN8YUbIPHZlEGAZzm6OvYeykYqkO1/ahw33TgoveD94H6YLL8nTj
 0nqxmpg40IuOayy/2K+S3G/BfCk6W7sm2Ijuo+IfK7zvQAbnGbOXGWq7Big05KhlR8tl
 ZafQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793455558; x=1794060358;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XMQI7NEQARmCVjAOHJELfRlkVpNKRidjrWSkAa8fiPo=;
 b=Fu4iHjLNGMaQra397Yf1wUecidmYMJSva8bRlh6Jm9nCv93uqRstdMs2KZa/od4+xi
 5eBiX1b7DyCxgiysXUKIaebqmNUUU2NSxGCa6HohWSVnNRZQG5Xsi13KHu/eQpAYzE4P
 czeNJAFoSC//DvcNvZYJem4/nwRKodu176ENI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793455558; x=1794060358;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XMQI7NEQARmCVjAOHJELfRlkVpNKRidjrWSkAa8fiPo=;
 b=RgkckX3Yf0Wv1eqR7egC3WEpMDBjoZEXanfLT4VhBu58fUJxHEc9//9sYH1Bl8gnvA
 RUwxCOiK0PvwELyMfWTj9a2j1waU+ie1iGFtfp66oLihojLHhitqb+NZ/U9D2D06oHyL
 0m6tEpfNJ3N7fMK3jv9RN9euGY3N3PoI/yJZLWQijJKlrAo+sjnJVoKFSWhWz1hSEBkH
 LXaj1czD3gX6oXNyWTmWYSnnk8WmviL4lgk2qRKkdcI0vxhhibAq44QFldHK76wbtxXq
 69mXNNQVFaEAyJjO254yeqfGnOVd7JlfMoG0qIFbgOXx9Rq9nCNfCU7y5l0JEHi+pTAO
 g3hA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwTOaYk1QHkvhDSV27Wyw4UbjEx9uXJPgao7V+wMNvtGSgAKlXm+EbkC81CEGWChCRAqdb9j2g=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI5FE7+6YxUmvZ9PqWuM9XsXa0BKp62a099ykZ7J8o62SUSUlN5
 Fabl2Y5YE2anYIhKwspWP/aswxavRTXN39ZhL1cQJMjXYT4ps9GWFjPgYms8+F1coGnEyVXNXeV
 jfpGCoS5D6dJaTM+arNiiziC1zSiIAdttQgvs2RnkgbQ5ve3o+Qqo+w==
X-Gm-Gg: AYBFou2CxdeSYu8I7154O+k/2iQkXDU3kLA4EyAFT/+nD1V2f7UrObJFnA5cQFOLcgP
 QgWu+x3/fyO38a72UY/zmz3U6Ds962UaNTd1GKWclg8OO3IiQpnVQ/+VTGG9hNLCFTD1mmEggbv
 NK/clGZlpgVCJcgu9u14TlxHfpEdJm4bw+4WpB5+GHyxpar5pimN+v/FfFi5noiRpvHQh6h8yRL
 7sHvOgWFKZmEz1tyZf0sJ2h5fOZj2Q/GpZciLWd/OxcB3jNnzU84h+OyRlgXdndGCuIv2M9F2Ci
 V6QWsXMbZFN3YqBKvvNZbKLn2l+mfEv8kVBw36L6XiJ/P0q2zZnh73/oqUK6qyqJ9H7edIKo0cm
 xRJF2kneVYQQnQSTu5mK043jciJmGL/vWEsFRFVb9IwUjWYvB1Ocy5b4YSDclq5qqHARoW1w=
X-Received: by 2002:aa7:df0d:0:b0:6b3:f05e:fd4b with SMTP id
 4fb4d7f45d1cf-6b4d468688cmr2767006a12.14.1793455558645; Sat, 31 Oct 2026
 07:05:58 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 07:05:56 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 03:14:31 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261029-main-v1-3-b5a878627107@kontron.de>
References: <20261029-main-v1-0-b5a878627107@kontron.de>
 <20261029-main-v1-3-b5a878627107@kontron.de>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 07:05:55 -0700
X-Gm-Features: AclHuK-NP7PgiYNBAk82R0-31ftfIdB6WYmf4kyNklptpeQuMgKRKhb56TJ7CdE
Message-ID: <CAFLszTgDO26qJUY+3cw1J+mPaofueYyEGUe=BVWmDH30RgA5ow@mail.gmail.com>
Subject: Re: [PATCH 03/10] bootstd: rauc: Fix overflow of the BOOT_x_LEFT name
 buffer
To: frieder@fris.de
Cc: Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Aristo Chen <aristo.chen@canonical.com>, Alexey Charkov <alchark@flipper.net>, 
 Daniel Golle <daniel@makrotopia.org>, Johan Jonker <jbx6244@gmail.com>, 
 Francesco Valla <francesco@valla.it>, "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Michal Simek <michal.simek@amd.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Frieder Schrempf <frieder.schrempf@kontron.de>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Frieder,

On 2026-10-29T16:23:07+11:00, Frieder Schrempf <frieder@fris.de> wrote:
> bootstd: rauc: Fix overflow of the BOOT_x_LEFT name buffer
>
> The name of the BOOT_x_LEFT variable of a slot is written into a stack
> buffer of BOOT_LEFT_LEN bytes with sprintf(). BOOT_LEFT_LEN leaves room
> for a slot name of 32 characters, but not for the terminating NUL, and
> longer names are not limited at all.
>
> When booting, the slot names come from BOOT_ORDER in the environment,
> which is only checked against the configured slots when the bootflow is
> read. Setting BOOT_ORDER to a long name between 'bootflow scan' and
> 'bootflow boot' therefore overflows the buffer in find_active_slot().
>
> Make room for the NUL, and write the name with snprintf() in a helper
> that fails with -E2BIG if it does not fit.
>
> Fixes: 7e5c2c782fb9 ("bootstd: Add implementation for bootmeth rauc")
> Assisted-by: LLM
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>
>  boot/bootmeth_rauc.c | 34 +++++++++++++++++++++++++++-------
>  1 file changed, 27 insertions(+), 7 deletions(-)

> diff --git a/boot/bootmeth_rauc.c b/boot/bootmeth_rauc.c
> @@ -167,7 +176,10 @@ static int distro_rauc_read_bootflow(struct udevice *dev, struct bootflow *bflow
> -		sprintf(boot_left, "BOOT_%s_LEFT", default_boot_order_list[i]);
> +		if (boot_left_name(boot_left, default_boot_order_list[i])) {
> +			str_free_list(default_boot_order_list);
> +			return log_msg_ret("env", -E2BIG);
> +		}

This is a build-time configuration error: a slot name longer than 32
characters in CONFIG_BOOTMETH_RAUC_BOOT_ORDER now quietly produces no
bootflow, and the log_msg_ret() output only appears with
CONFIG_LOG_ERROR_RETURN enabled. Please can you add a log_err() here,
as you do for the missing partition names in patch 6, and mention the
32-character limit in the BOOTMETH_RAUC_BOOT_ORDER help? Also, the
other callers pass on the helper's return value, so it would be worth
returning 'ret' rather than repeating -E2BIG here.

Reviewed-by: Simon Glass <sjg@chromium.org>
