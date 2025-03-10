Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3363C282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 07:11:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4CE4811B2;
	Mon, 10 Mar 2025 08:11:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ewmcwEYI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D6F5811DF; Mon, 10 Mar 2025 08:11:14 +0100 (CET)
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com
 [IPv6:2607:f8b0:4864:20::a33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F4C180107
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 08:11:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-51eb1a6ca1bso1543890e0c.1
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 00:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741590670; x=1742195470; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DHuV4RPVcManbFoDyY/eJV5/NsI3UQPieDMISU5qFZI=;
 b=ewmcwEYIinP4MaakbBnvMBEP0SLbu654OtUga2dYNizH0o3XWhMHHmaM6F1Z41D4O7
 hwRrRvRKnkDv+31tWzcVVJPUIQt206zb7heV/ijsrfUQymNhxxDaiovBFEGeBBR1fcmW
 9/1FhpI3pJHr7Moeu+LusLTrEsdNqpYqbD1dOJ0z0tyeiVpNMWTlLhZwbvFXoFN7bhKB
 PZ/4WQ6pgbfF1ry3Vf+3vRM+cdwQIf3vaseoLSpHU0jgp7KdkmUQX94x4Ndtc+Oey/3X
 V1NflwHioVXm920UWjIlesKOPrFFPETj/VsJhzgfaACqFvwsNqTGYFmmA0075l7vzE7p
 rFGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741590670; x=1742195470;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DHuV4RPVcManbFoDyY/eJV5/NsI3UQPieDMISU5qFZI=;
 b=LzvUvKH4upaSqLShkAlFfUMX+Gytl/E4od9kAMNgq6eXmv2PQlzlyeD5tSKyqNdJtv
 LLqVp2CSIS09TxlTsgCBMy6fhsvRpY5vEVsO5GWydYPk2duCgYyfUZoZUq/snE8eSMI4
 chJsxuzXxu4JfovA2ySvvxOQxsKK4Ldf4lTU3OACBhNepVbWeMlpOen7HNYUNGjasOvL
 Zpx74OUTEUAVodpYnb5m9tPh2bfi3Rl08Qb1urb30a9TyUnTR1IWqa5DStrA4p0x1IE6
 bT9iFphgMA5LzgEcmDxLUR0E3hxW3n+Q0O/t6lb6XnnmB8xTIU0fAEF3SO3aFNXTcq4z
 rCJQ==
X-Gm-Message-State: AOJu0Ywl2d9YjBnU2g6imx9wHu3T8oSPdWMhVROcVR3qFgO7I20mSPZU
 v3Furyo6OQR0gaDVgJLdrQSfTZ0e950f2nNunmRxes4HORRN9MzWnlihRox6I0GDB2t4CtL4loy
 ko2tJDDhjL3ZiAtXHPb7ljmm/RiTx5H8Zuz6z5w==
X-Gm-Gg: ASbGncumWWgCoR8tQxEg0grypF1uyNhrolksyNxnpbfxQK0yC+fsFGGr0/BDkYb6Haf
 rjHlp8rG97HVXvgp5pvaQ8TlJqfenrs0wVhKMjkA/4ukKtZJDytEIA3pTBeD03yn1StXitOdgWT
 f5uQy/szKc+wUYtMG1wzgfMtHoh7o=
X-Google-Smtp-Source: AGHT+IEZqBQN3292H2WRbOivKQWTFcJpgf2JiePHFOO4Ywosa8piaVX1b2bYy/LG6BoQPpIYg7sqANj6MBbgLBNe3XM=
X-Received: by 2002:a05:6122:3c91:b0:518:6286:87a4 with SMTP id
 71dfb90a1353d-523e404e63amr8115181e0c.4.1741590670307; Mon, 10 Mar 2025
 00:11:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250228084529.127823-1-sughosh.ganu@linaro.org>
 <20250228084529.127823-7-sughosh.ganu@linaro.org>
 <CAC_iWjLGnYzY1XZX4HXKZg8YBqYq9LFJrC_ysm7WN_nFx_kJww@mail.gmail.com>
In-Reply-To: <CAC_iWjLGnYzY1XZX4HXKZg8YBqYq9LFJrC_ysm7WN_nFx_kJww@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 10 Mar 2025 12:40:59 +0530
X-Gm-Features: AQ5f1JpAI93nP0Y6QAGKwT4Un8fl_v6C2dmH-FDM-a5YVQP5CmHioP_q1Qq_TDQ
Message-ID: <CADg8p94qS+uU1ivgqbjrxY0P2czXvLx1ydiAt=JwFaPXfkPajw@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] blkmap: pass information on ISO image to the OS
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Anton Antonov <Anton.Antonov@arm.com>, 
 Tobias Waldekranz <tobias@waldekranz.com>, Bin Meng <bmeng@tinylab.org>
Content-Type: text/plain; charset="UTF-8"
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

On Sun, 9 Mar 2025 at 14:29, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> HI Sughosh,
>
> [.,.]
>
> > +static int pmem_node_efi_memmap_setup(void *fdt, ulong addr, u32 size)
> > +{
> > +       int ret;
> > +       efi_status_t status;
> > +
> > +       ret = fdt_fixup_pmem_region(fdt, addr, size);
>
> As we discussed offline, this will never get called if bootefi has run
> before the final OS image we want to load.

Yes, we currently have the logic where if a DT is installed on the
configuration table, the DT does not get installed afresh. Only thing
I was wondering was if this logic was put in place for some specific
use-case. We are now going to change the logic completely so it should
not be that it breaks some current assumption made in the code
somewhere. But then like Heinrich mentioned in the other thread, this
change was made in 6182495e101 ("efi_loader: need either ACPI table or
device tree"), which was authored by him. So if he is suggesting that
we install a DT afresh, it should be fine.

I already have the patches ready. Will post them once I have done the
required testing. Thanks.

-sughosh

> The reason is that U-Boot checks the installed config table and skips
> the installation. Earlier versions where applying the fixup on the
> config table for that reason.
> Since Heinrich and you agreed that the DT can unconditionally be
> re-installed, I think you should send a v7 including that patch.
>
> Cheers
> /Ilias
