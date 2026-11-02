Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8AC60B339A
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 16:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LCmF4Vl2;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=bEY7Hyun
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2DE3C81111;
	Mon,  2 Nov 2026 16:44:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OWw6p2xXTBGL; Mon,  2 Nov 2026 16:44:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6F0C080FFE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793637843;
	b=nr01TXPWqVf0+PEf93UsS7MTHHQS7M+fZSfzrZ3CCQWskH9y7eroKE+SwMmMuc45lGgx
	 WIU+WZ7hbipAxxJ0f9PMAIJRoenBpGSGEDElH5mShoCdGZHzuUmMWa7wE74ROHhyPoWUA
	 vjib+rwXGasKtrpS3noo37Xh+TmfR3jKLuH7CbNe9e7xAzsFC7rk+N6QTYuGjHMCOKnfw
	 ZaQLdSTv2NI7hQny9kFjU3iusd/2nUQcwU8ONylJ8LR3rmMaHXkrQXlrvs2XDM8bR+Spl
	 bS/6SIDqokvuRUsCIIyyjV020BwadJapI3IkHL3IUECpTnyeM3reZFtxJmpEHgEcE0Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793637843;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=5S3ukOwZZu/25O8JeC1tjGhnBI4Z5PLxiaghMLlFNq0=;
	b=PVKG/QxAcwOVfpItyq6UDCH+4xLGF0/iEguBdfNTXnKafsX9hhKWPEC7E08gnUYxJ1gK
	 BYWOwfNKRoWslRfCTr2QHrJhHWdnpznoVzT5BrJnq0jju/n0aEDfPhPqL+6eVk3rL38z1
	 oRFsj6ZI/3DeszPYiJBj+vzjgy3xlOxatwMjZNnHyaIjOawPDM2hoHMW5UFdc8mxs5TFe
	 BhHW9aKYhGfd9YNLsRbAkqYLBkEzLDMX3OcQNORdQfTrzWaymZyBefQ+wt8QwqG+m/MID
	 WaG6qCPkBjunUAL7UIJpuRo2+Dbsw27WAcHotmf9HoDQoaA8skms2lSZaX9FdibroXA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793637843;
	bh=5S3ukOwZZu/25O8JeC1tjGhnBI4Z5PLxiaghMLlFNq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LCmF4Vl2xyu1AqbRgkR669EjqZwGfm/H/4P573mD6N2jjNDJAzBEgW067rMVYjLA1
	 fiU6Ju5GOcCQa9TCEirFLM6P2S4eQTtkOH6qUUvugTAiLmDSxpbCfRVxpmnZVJxQux
	 rmDVM/Tl/o2BO99Gr+B1xEa7o0lhaJnzLaDe/qsmytC6aROxtjoh6vDlaVWvhIAUUF
	 d+MKmytIovczaJTs1CPypodPPsCihrqjWGbqs8wwU4cvwbakSCqELXPBaDc94NzuZV
	 aKG6/Dd92lerv6gO75OJj3fQGLW8XsBbXhe6tNIvw0VvRja7zwGagOpjmX7v24ryzR
	 M4ykSIMCBfjZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6F0C080FFE;
	Mon,  2 Nov 2026 16:44:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id CD005411
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:44:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B28C0607F5
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:44:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1vebyYbQmCqx for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 16:44:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EDC3B605E6
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::336"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793637841;
 b=tcLXt9YYzlUc/SAmFaRim1Ogi62n3Q+0ii1bELGPrBJ42DyLBPN5eSA6AKl4QXQ0hQVS
 SxkpuLx0/GQxL0s3Z/PGoP/bSiGN5zaUcaHh/pFldJu8fBlgDGRTX6QnLpm9s55gqEtZa
 nne5pGGsV7bx16brk3V3bT/v6K/LLbKqy5sJj/e+L4NMurcdHUg8wcOY1ZstYu9hsjGIW
 gba9eoAYpVa9MU36oCj+6d16z2mzZWnwhGu7tNbIPPUT5SRCG8IAyEw935alUZmk342Nk
 Y8bRZMARsG1ZJJ0zZ3fnOVGsvPiWSSrjU5EZDlIlkOxg5eZmZ61UxNysdobnI6PA4qg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793637841;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=5S3ukOwZZu/25O8JeC1tjGhnBI4Z5PLxiaghMLlFNq0=;
 b=cLA4HNQmPRm+YOpwBF0q3Gh2JWZ/uzGgUyvvgk4JvAraxWwclSHi1SmNShXqUYbFC52t
 E1Tt7JQNvvaiaxDW3HDvNy20iWdcS6SF5tD7lc86AU2HBBaJNatNAT5VxAHncjUFd04Qs
 zFGwy2I1srdzxyog5PpdXMAAkMVJMWES4nJT/atBMtNERK9wR2I0k1JqL11l627iwCW/A
 AkrvmXPp2wxAECeSks+W0PsMnx5TtiRV1smICjRtxf73Vx7ZZ1U7X8IdB1rmHhwXOqLIf
 vzl1M4tnLLHVO7H1ft+Xnq585i5G7cb4Jv+PexwnXDDUM0oTqLf6tnZt7+KG2LDn+8g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=bEY7Hyun; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::336; helo=mail-ot1-x336.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=bEY7Hyun
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EDC3B605E6
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:43:59 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-84621d8c7aaso1417791a34.2
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 08:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793637838; x=1794242638;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5S3ukOwZZu/25O8JeC1tjGhnBI4Z5PLxiaghMLlFNq0=;
 b=bEY7HyunXxNqr0zxTPo87kGqh1CRHz4oDjhaq0ZCMNhoSDI5h014G1ty7LeikBQj1l
 st7hMI+XzOhis6tLfy/wWAt1qLL0BMMQXudn9RWuLlzWjDzipfoRvjxJCcrma6WkmCyb
 94Ue1d1mudhUYG5uUHaGzuo9+G9umTqVwsrho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793637838; x=1794242638;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5S3ukOwZZu/25O8JeC1tjGhnBI4Z5PLxiaghMLlFNq0=;
 b=qLTb4WXS4NksBrTmvmUlAPB3qk/pcW19uOKgeFdAh4/fJQGQBsavacghd6tUXO1E8A
 cGG7ltT81eo6qd0wXzWSivNz7ruAFpKCVfnKKMtJcLdhvYpQbG6qtUYzUt7HorIJ7KUM
 TfXtpkGiH5GYB7y8uiqAU5sFD35qfhn5jiwKhF92o87gXh3q9Z7ddD4n3TAONxfEGPLq
 S3z8EhYa8jcOXYwfje1YPL4kaVZEr2qjUTXFTwoeRQ6RJpX2/4W3dPLUcY19DeEEfeuU
 EGP93kfZ5act46BAKtW/IX+NZI0tjeAODGWUAd0URmM0r7+1Ieh07zOxRsdDR3B0uwzf
 NHdg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw3t7vbqiBXZ5U8HgpWjyriTrppb3dfWz4E5hS39f1NtjK8E+MUA/rnneAnsa0h2dgaizjHTaw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI4wbnB98hSgWjFTd+f/1DdstN3xcaGjLYXMxRlKVn3QvTGC2Eu
 290yIX6ImvE0QgvfaVNMgd8Ui9wbgb01YmLnGTQ5lhb+sg1MMQmcE+6TgyDVVhYgQOM=
X-Gm-Gg: AYBFou2wmvfKj/EflxW28uADEK0r5CgAm5gGQN3uvHse2bR0twkDqPvlRZTqT+2D4c9
 fyMyLnMJouyDv61oSny2veuY5wFz9qlG9ybrwV7Aa/2mbu0GuG3eyFxy+GZRTWDrHImYVlAYW0r
 RmGJDQupMetxCEPpdwUQk1ZuVr/gtPvu3V7KBi1cDXywuKxjQJTvXeBhiHAGxAJ45KmQzbRgf9d
 ofj0P8cv5QDLoN3ENiRE8qTeOjmWoaypUWvAX7hNTgsykbGVkZ1Qa/ubUh0tFX/7GZBjgWjGxNT
 hUe++FirtQc7MtVwe9AXGPEkzE5Zm5wB7EyXqR4hZn4PAXdE7wCI2rUKMWQjC/1BRM2VYzMXGWY
 yvLpJfTFyCQ93JeNTAD6en8+jlSGIi/49pHYR5mu4tOZhCGIJ9m+ohCGHkAEdALpdUWg78zwGJ+
 neNx9N6EQKvKdJkSYZqsMzHSWPilMsyhmNW86NIdL4HivQUpjB7BbqKT0MEQJT9qOWrBx9go1Jk
 0NZRyRhqWkWVcktJXhbqRdTWlz5gRExDrLKODHf9Yz0WutMEyzePNfXKOrEXMFCkEQHopKO+1Ud
 Cge9Dlol/+XSkaO3MQVl/08Ptdijo72/INeWi0j4rGT4l9PQdX/epMi822TcLS1Z7Jcd4bHKlO5
 uEOlEY6/j5OBRzM9395YksDxI7tT3OnvSigSoFSsSFt2UxMP9p1TTXtqrWyneaa7m7rnahvT0ks
 8N3/Fowz9liqsSCIGCtc6wqxiSBHObdg==
X-Received: by 2002:a05:6830:4490:b0:804:bb22:6d42 with SMTP id
 46e09a7af769-85d36405583mr7751683a34.17.1793637838488; 
 Mon, 02 Nov 2026 08:43:58 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d351e841fsm10351239a34.1.2026.11.02.08.43.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 08:43:57 -0800 (PST)
Date: Mon, 2 Nov 2026 10:43:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Andrew Davis <afd@ti.com>, Michael Srba <Michael.Srba@seznam.cz>,
 Alice Guo <alice.guo@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Lukasz Majewski <lukma@denx.de>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jens Reidel <adrian@mainlining.org>, Erikas Bitovtas <xerikasxx@gmail.com>
Subject: Re: [PATCH RESEND v10 04/15] mach-snapdragon: spl: Update boot
 device information in SMEM
Message-ID: <20261102164354.GY3309461@bill-the-cat>
References: <20261102-spl-v10-0-224d421c6201@oss.qualcomm.com>
 <20261102-spl-v10-4-224d421c6201@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wNJ0/0YskPUBVlkS"
Content-Disposition: inline
In-Reply-To: <20261102-spl-v10-4-224d421c6201@oss.qualcomm.com>
X-Clacks-Overhead: GNU Terry Pratchett
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--wNJ0/0YskPUBVlkS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 02, 2026 at 11:18:36AM +0530, Varadarajan Narayanan wrote:

> Update the SMEM with the boot device information got from the boot rom.
>=20
> Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.=
com>
> ---
>  arch/arm/mach-snapdragon/board_spl.c | 42 ++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 42 insertions(+)
>=20
> diff --git a/arch/arm/mach-snapdragon/board_spl.c b/arch/arm/mach-snapdra=
gon/board_spl.c
> index 41d8789a002..460d07ef0a3 100644
> --- a/arch/arm/mach-snapdragon/board_spl.c
> +++ b/arch/arm/mach-snapdragon/board_spl.c
> @@ -21,3 +21,45 @@ __weak void reset_cpu(void)
>  	printf("reset_cpu called, going to hang()\n");
>  	hang();
>  }
> +
> +#if IS_ENABLED(CONFIG_SPL_SMEM)
> +/**
> + * qcom_spl_populate_smem() - Populate shared memory (SMEM) information.
> + * @ctx:	Pointer to the global SPL context.
> + *
> + * This function initializes and populates various SMEM items with boot-=
related
> + * information, such as flash type.
> + * Return: 0 on success, or a negative error code on failure.
> + */
> +static int qcom_spl_populate_smem(void *ctx)
> +{
> +	int ret;
> +	size_t size;
> +	struct udevice *smem;
> +	u32 *fltype;
> +
> +	ret =3D qcom_smem_init();
> +	if (ret) {
> +		pr_err("Failed init SMEM (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	size =3D sizeof(u32);
> +
> +	fltype =3D (u32 *)smem_get(-1, SMEM_BOOT_FLASH_TYPE, &size);
> +	if (!fltype) {
> +		pr_err("Failed to get item: SMEM_BOOT_FLASH_TYPE\n");
> +		return -ENOENT;
> +	}
> +
> +	if (IS_ENABLED(CONFIG_SPL_MMC)) {
> +		*fltype =3D SMEM_BOOT_MMC_FLASH;
> +		wmb();
> +		return 0;
> +	}
> +
> +	pr_err("Boot medium not specified\n");
> +
> +	return -ENOENT;
> +}
> +#endif /* IS_ENABLED(CONFIG_SPL_SMEM) */

You're adding a guarded, static function in a single commit and not
calling it. It should be added when called, and then we can see what
guards if any it needs.

--=20
Tom

--wNJ0/0YskPUBVlkS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaui9ygAKCRAr4qD1Cr/k
CqRJAQDGDSMOVzhSW/U168qJy9P6XeV6kHjMpCp6Z4YO11TzuwEAuBSzTeV/r5xM
vOccuHb3YuwPWnG9OF2Y52lCZKBelwM=
=7IC7
-----END PGP SIGNATURE-----

--wNJ0/0YskPUBVlkS--
