Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 431C0EC1116
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 17:52:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39B4583E36;
	Mon, 23 Feb 2026 18:52:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NOyeMsHw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF1F083E36; Mon, 23 Feb 2026 18:52:42 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24BBB82BF2
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 18:52:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2a95de4b5cbso42434995ad.1
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 09:52:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771869158; cv=none;
 d=google.com; s=arc-20240605;
 b=SLXY/EavdcC4XgQbINumcvKQzmTn/kKauBb1eO5f3k/GtVif94uCM2TL5ghPZwzxjd
 wsM3hzXnbHApiol8/bhq9nvwUq9EEQ3w+LGEZthp5IUiRByIAzIQc2AuwFPmenSZYKE/
 HgQt8YTEEAJX+Yi2HZqfc7beKH5eQToIWi6xHtgsKao+z8CiJ0f/L3jBn6g46zevdpM2
 GKIS5XhHyg2EbStYEWT2LPCyQipsz7KrNa33dCsK59+n8lXmfPhplqlRWuJkpeH1y1h3
 aI0htPY7ul4oG7KKZrQ6l31dwVt/CfnUJii0QE28WztIUEUk3d9vMue/wRR4ezQMPxvh
 u+6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2vEupwHhDzPCIfX33HAmitO6y11FavY5uy1iCHo0Ub0=;
 fh=zJE/Fo8l/szBmEOetLct695NX5uRaYsIjDN5aCBW4wU=;
 b=V6v9BzPCKpUHIIKwiZTadDejaeBnYxj7lfxWc9CefKXzxIDvaUs5pKtQLDgHUDYalm
 NpRjYYyrdFlTD0t003AhZ3ZhTq03M3M5qbRIHsr+ReM64wrHhZR6E9C/dz0LsmV/ibA/
 pFD59JQdgWw3FtXv8tAkw9AXrJuiGB1SWZCjVUorPtXyBHEvjw2c4uB1HbAK89mCrq4B
 8O8QZfUIy9aPqVc5JZApveG2k5IjKjPcKRD0AlOFrVDyK59zkBupn/KRPQI7TIYGMcbR
 cHKnUA4a63QrCoq3YT6mllbxzDviNIRunsDn6/Qm0/Zk0c8aUPzHyKr49leU9yu5v9Pl
 ivIw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771869158; x=1772473958; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2vEupwHhDzPCIfX33HAmitO6y11FavY5uy1iCHo0Ub0=;
 b=NOyeMsHw6Mo8GPb5HA2G2umFopk9rnkJ68nOK2TZZYUj9spN2Za7pD77CGkfht72ba
 HTVDZ5xOmQIZhVLQPHE/iZOX10EhGmOR+rrCysihWL+6CLiew/wvxZf+Dh5wfJsnh2E0
 kqlPoj1Ua5MsuWd31vmlkj33y12geujCDVYdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771869158; x=1772473958;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2vEupwHhDzPCIfX33HAmitO6y11FavY5uy1iCHo0Ub0=;
 b=qSaEcf3ykb1LhRFf3/KtKttIRenWy3h/QvpC6LGzkePr8FEjIjvVOM8SgQkwjgMNHE
 Y233AWWzkQO2w8+smUAYzSJA3MueB51vc5tUzQ3bWvaDcNjSjonmQMnIxAaRdflqLPiY
 wwJfwd6DTLjk8iRTR3J7Uw2T6NBOjun0/VkGlmPg5E0RIT0z+edgPk06ECLM/ChPsDsr
 +Z8LRA7urYyDnkVLEFvovl/JO+TJocTBAa59oZA1/noJdzcJyTGVb9ywWbrW/Pr3lls+
 jafrq6FHLoaF+ef2l9YvagbmgTViEZBE+VF09NySejla8KZpA+xA6B5qUaIIL7WG3UAF
 IuzA==
X-Gm-Message-State: AOJu0Ywt6cTlhRdionqhAlPXb3H+ZLJJhhjDqSvCdNVKXuGCDpsjD57t
 h+X5f6ecYQ8CBgjzWwRcyFNOpligmIHGytm+HwhJSMn2qt/8y1oJhVZ7rJfcvRG+p8OwK220Qft
 1uaaPU2Y3qKcKI6Pqedwc61R3tzhSVK27Zc+9xCx5
X-Gm-Gg: ATEYQzwfqgc4z9QbzVIHTxNV5j99DmHerE/M6D6rZgHJ7yvsuoPr7ELBSpQp5nx5GAR
 OhFX9cAqJm+p/Vu/UTjqG8pbbACrEiRAYtEwxlN1h5iww7lI7eKAZt9lUZqYPn4gR/DS+VLi/WM
 EVCl52srXMOWC4AjwCD6kz7bT7EdZZKP/O51GJ9RZ3yuWVFbdIXl703XJb8HPFxEfF/kOy4WnlS
 LyRF+z4fR/3whB+4yBXRUe5ZS14v6YveoPgITtpq8rNJvrG8656hxNA4IHxvkWlaDIUUE8dYftq
 pdot+Q==
X-Received: by 2002:a17:902:d549:b0:2aa:d61d:79bf with SMTP id
 d9443c01a7336-2ad74527c4dmr92569965ad.42.1771869158596; Mon, 23 Feb 2026
 09:52:38 -0800 (PST)
MIME-Version: 1.0
References: <20260217-ofnode-to-fdt-null-v2-1-915e627d201b@bootlin.com>
In-Reply-To: <20260217-ofnode-to-fdt-null-v2-1-915e627d201b@bootlin.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 23 Feb 2026 10:51:12 -0700
X-Gm-Features: AaiRm53v-J1eue1vdibtoPSK7W8xAekhpBQYdZ_-v3ymyQGZDDboUg6C-c-TM9c
Message-ID: <CAFLszThZ=5LFyNV20Pze5mJXB2tRcRpF0o2oTvBUSpYqTJTF2g@mail.gmail.com>
Subject: Re: [PATCH v2] dm: core: Don't allow ofnode_to_fdt() to return NULL
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tom Rini <trini@konsulko.com>,
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Yannick Fertre <yannick.fertre@foss.st.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, 17 Feb 2026 at 02:28, Romain Gantois <romain.gantois@bootlin.com> w=
rote:
>
> The ofnode_to_fdt() function may return a NULL pointer in multiple cases.
> Or, this function's return value is often passed directly to functions su=
ch
> as fdt_getprop() which end up dereferencing it, thus causing a NULL point=
er
> exception.
>
> Don't allow ofnode_to_fdt() to return NULL, to avoid a NULL pointer
> dereference.
>
> Reviewed-by: Rapha=C3=ABl Gallais-Pou <raphael.gallais-pou@foss.st.com>
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
> ---
> Changes in v2:
> - Added back a dropped cast from cont void* to void*
> - Link to v1: https://lore.kernel.org/r/20260210-ofnode-to-fdt-null-v1-1-=
4bed28680f35@bootlin.com
> ---
>  drivers/core/ofnode.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)

Reviewed-by: Simon Glass <simon.glass@canonical.com>


>
> diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
> index cf1cf8abfbe..3a36b6fdd03 100644
> --- a/drivers/core/ofnode.c
> +++ b/drivers/core/ofnode.c
> @@ -164,15 +164,20 @@ void *ofnode_lookup_fdt(ofnode node)
>
>  void *ofnode_to_fdt(ofnode node)
>  {
> +       void *fdt;
> +
>  #ifdef OF_CHECKS
>         if (of_live_active())
> -               return NULL;
> +               panic("%s called with live tree in use!\n", __func__);
>  #endif
>         if (CONFIG_IS_ENABLED(OFNODE_MULTI_TREE) && ofnode_valid(node))
> -               return ofnode_lookup_fdt(node);
> +               fdt =3D ofnode_lookup_fdt(node);
> +       else
> +               fdt =3D (void *)gd->fdt_blob;
> +
> +       assert(fdt);
>
> -       /* Use the control FDT by default */
> -       return (void *)gd->fdt_blob;
> +       return fdt;
>  }
>
>  /**
>
> ---
> base-commit: 8666b16015d4212facacc514e2eb626f3630dcf0
> change-id: 20260210-ofnode-to-fdt-null-95a9f357819e
>
> Best regards,
> --
> Romain Gantois <romain.gantois@bootlin.com>
>
