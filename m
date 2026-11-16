Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878B7606A323
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 18:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ofLi7+gu;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QRI5WRg3
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5E66440606;
	Mon, 16 Nov 2026 18:17:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2pYnZtieGNJR; Mon, 16 Nov 2026 18:17:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AFBC64062A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794853036;
	b=AvHkbjJXlKcyXJrR1ye2CFmmjvlViAx9pNWTAEHKjI53De4PQl1VYPutIWXjSmmQcB4O
	 dwuf5k9Cu+BwfWupYgFJP6HujiDNkF64D01/nL6tHKP9MfBboiEPN03HfJqay7Hjm+/BI
	 /Xq8mAkgx9GQqoDuVuuj8orv+fFUCD8tzGJqVZIUp+opwHviE+BRRi0gd0hx6jS8PKpOA
	 EJkmKKCsaoHvdsIHoh8wGF1uRuJcF/B3C7DQmlxdUOJo02+e/AZTVy0Oe/t+4eqgM7I/i
	 ox6ckMHvvMR+tjFCuuMcUu2amg5rV6uLrMLO1STgPnkW76mqNslexFPDNANLf5sxu0A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794853036;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=RSRBWxDtR7LrdMNQS9QVRkr2vTY1PO05jYBXV+hFEMU=;
	b=rI473uSavISGS6Oqe/z7bqwQ4qlFGZchIc6b5JLg9mgVohFvjIRi5OB0RJPM4LW+6eDg
	 LR1hwF9NhvGpa7GisFcSmPj+7RNsF9beB811JB9v0B3imn+4ZiONtkbUSujChzAo40IQp
	 Q7bT1+bIeuKqgf3NMLT87UenlZooo1wUj6IgoIeJJlsmnfrLdGDDejxi7Kaov23sBQiZg
	 uMGyFjpsTmjQ7sc4Otw401Nxuva1oJsKJH/nQ0wF9oDiE1B1WBKVJRr3GDgKqqAcvkzUT
	 gM6vf0G+3bzAzwVj+8ova1UyHhYhb9PfCrVGL2YpgKkP2Vj4Dx5CC90POcPF6afDbsQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794853036;
	bh=RSRBWxDtR7LrdMNQS9QVRkr2vTY1PO05jYBXV+hFEMU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ofLi7+guwtL2kGSRhw8P/p6BI501TugzsRxA9yEYDmYb86ED58aQQBruq3afx0pJp
	 1VvIZp9OKmT9g3h4mzhvfMOhkN43aEDwO0jho9z7MnMPI0/faDRm51g3azmZVvNB85
	 o+ATE0EWKR3MjNzhpxJMsP/e60FzSbQ5LJaQj8Z8OxIn8TcDlEQMLijjRgLmZSZoMH
	 wvQQuIocPdi2I+O0JHdgsx9kJ5m9hHUWqEPJdHg7u4x/yz/EbNJYbA+LLugMlG7nj0
	 xeaGoym8iPiJBKWGnaS/zLlNJWIHww9dtiGVjqBQU+nt/rq7bE309+r3TmcCEv2ajc
	 ggp5A4kx/KCSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AFBC64062A;
	Mon, 16 Nov 2026 18:17:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 850794DD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 18:17:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6DEE64009E
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 18:17:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E32CFmUx84lr for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 18:17:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A39964007B
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1330; helo=mail-dy1-x1330.google.com;
 envelope-from=clamor95@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=QRI5WRg3
Received: from mail-dy1-x1330.google.com (mail-dy1-x1330.google.com
 [IPv6:2607:f8b0:4864:20::1330])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A39964007B
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 18:17:14 +0000 (UTC)
Received: by mail-dy1-x1330.google.com with SMTP id
 5a478bee46e88-37986eb6fa2so4875840eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794853033; x=1795457833;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RSRBWxDtR7LrdMNQS9QVRkr2vTY1PO05jYBXV+hFEMU=;
 b=QRI5WRg3g6sYBZ8SJBPRXa2/pllMXo14aB01YOK/V+TVpKDFkylLw5wh0WNVUEDleS
 fWsWPTK4Dk8B/fP8YilTReCg0afcx/J4ej8vbK9rKcEeolOqvznpI2eOxxfeCRm0+MOG
 MUxWEP1Zr7qRdwkDUPlChwRnADl78U3mKT5Ivhhu60cMe9vdhtO76rOIAeIu60AniHy6
 Gz7/irOxBv/rUjfPPG+OCF7XOcTsSDCmjUunap+jDnwS0Eq16u9i4DOSv6WM7lEGNa/d
 eHKPg4npUSziCq0KlDhJ0+qI3I8XvZ6nGVDCZZ+9XaJQSLsimUiSVhHv58qGCLprDCeB
 ANhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794853033; x=1795457833;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RSRBWxDtR7LrdMNQS9QVRkr2vTY1PO05jYBXV+hFEMU=;
 b=RhHQUSb7b/F+LjY6zJHo4n4KZcDjyf3PJBG3rsIkBLl+S12/Pfxbrw+7vMR5X72f9Y
 6G8ZQ0t7/Z5EIYtb/DCWiG4fV827p+2aaJANizPVDY4oqYIw4xzq/5bz5pennewmW2ms
 FXbnCprQdSO4izZfJRYwiCW/yQyI+oxve5QxwwFXa17LWO67HYxT2BwsJBwUzSoYN0c7
 y8KIlPGqCLcMLk8YVmebBq4R87h781/c8Mu/LZrumYBNvt9wl1UtsWRkZNm7rDGjUGNL
 y5mcUsZtRdSf2LH+CSIS6JBCp/NtYRbmnLaAVvaG6Ds9w8sGtucVaN0YMWvn2OviayZz
 1pjA==
X-Gm-Message-State: APuU4Z/CRxhf4FPayHPOQvPSuVxCotFnDg78V2z1zxz3tMwxy1ehGnvX
 fjkhcR1QUULD8jxt4lVBjmau049rfZfXTboBFw4eZEWn4kj9ywb+L/LqUUcSfWDCRtmMna8wFFY
 j1cY63bwqD9uT42sCJ71yGxeffJflZRo=
X-Gm-Gg: AZFdTZc090YydwULEGsE8LSHV8wZKrLo6Lsivpfm/SuCnXuxY5QvPLA8uv6umT/395G
 jvyYMOP8Ap+UmOB0kYwoSaA+shPVS+lhj+uxaRygA0ZcBOEA58b4gLhz+ZYDqUeCNkFznsIMpom
 nXuCo/1ebce/edqP8qNBvZBGIifZ8PDwY/vv/+DwdmQrFYjFRa5jVCpIqlfw5UA1njWejijnmjW
 zroYgU+ILTLMg5UkEhH+iKIgwvaOF5aY6fwHBMfLRcnwhkNx8ELSEuz8CrYSrepBP5pcO8Whn70
 yc+R0pSLpfyRJr0W0Kv0ukGpIhuuERTXiP865xJK2v4L2P011To8pGVRNHwvd+LCuk8GMdO7QAJ
 IcvNBhj0ZBxb/3XKNCcvk/XWmbFbmDdi0DmqDv/RN4LnewYRaK+SmLFyTp33r4PGE2ns8WCEkrO
 nSjQry5wHeha9Mw/0KkfYEZi7hUllIhA==
X-Received: by 2002:a05:7300:c8c5:b0:379:e0a2:1a1 with SMTP id
 5a478bee46e88-379e0a20687mr10896300eec.35.1794853033062; Mon, 16 Nov 2026
 10:17:13 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261116173546.3487841-1-marek.vasut+renesas@mailbox.org>
 <20261116173546.3487841-15-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20261116173546.3487841-15-marek.vasut+renesas@mailbox.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 16 Nov 2026 20:16:59 +0200
X-Gm-Features: Aa3M54rA4MH_PoJrwoxhbL-MMLQJGdG42ef794NwjZ1ufD70mPnFTYsUNd9T1nc
Message-ID: <CAPVz0n2_bgmvafUNdFNr8ye4SMXkwZ5G9pYTnS7gZik6XOEkqA@mail.gmail.com>
Subject: Re: [PATCH 15/20] clk: tegra: Constify driver ops
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, Lukasz Majewski <lukma@nabladev.com>, 
 Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=D0=BF=D0=BD, 16 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 19:3=
6 Marek Vasut <marek.vasut+renesas@mailbox.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Lukasz Majewski <lukma@nabladev.com>
> Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.u-boot-project.org
> ---
>  drivers/clk/tegra/tegra-car-clk.c | 2 +-
>  drivers/clk/tegra/tegra186-clk.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/tegra/tegra-car-clk.c b/drivers/clk/tegra/tegra-=
car-clk.c
> index 880dd4f6ece..8789cb02171 100644
> --- a/drivers/clk/tegra/tegra-car-clk.c
> +++ b/drivers/clk/tegra/tegra-car-clk.c
> @@ -100,7 +100,7 @@ static int tegra_car_clk_disable(struct clk *clk)
>         return 0;
>  }
>
> -static struct clk_ops tegra_car_clk_ops =3D {
> +static const struct clk_ops tegra_car_clk_ops =3D {
>         .request =3D tegra_car_clk_request,
>         .get_rate =3D tegra_car_clk_get_rate,
>         .set_rate =3D tegra_car_clk_set_rate,
> diff --git a/drivers/clk/tegra/tegra186-clk.c b/drivers/clk/tegra/tegra18=
6-clk.c
> index ec52326c3b3..34b75ad3c18 100644
> --- a/drivers/clk/tegra/tegra186-clk.c
> +++ b/drivers/clk/tegra/tegra186-clk.c
> @@ -81,7 +81,7 @@ static int tegra186_clk_disable(struct clk *clk)
>         return tegra186_clk_en_dis(clk, CMD_CLK_DISABLE);
>  }
>
> -static struct clk_ops tegra186_clk_ops =3D {
> +static const struct clk_ops tegra186_clk_ops =3D {
>         .get_rate =3D tegra186_clk_get_rate,
>         .set_rate =3D tegra186_clk_set_rate,
>         .enable =3D tegra186_clk_enable,
> --
> 2.53.0
>

LGTM

Acked-by: Svyatoslav Ryhel <clamor95@gmail.com>
