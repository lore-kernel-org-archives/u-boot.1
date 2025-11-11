Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B2D2CCFA1A
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 13:09:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 308DE83FA1;
	Tue, 11 Nov 2025 14:08:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="N9ju3wln";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BC6783A79; Tue, 11 Nov 2025 10:47:49 +0100 (CET)
Received: from mail-yx1-xb12a.google.com (mail-yx1-xb12a.google.com
 [IPv6:2607:f8b0:4864:20::b12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1729283B5D
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 10:47:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-63fc72db706so3694915d50.2
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 01:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762854466; x=1763459266; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wgEr6jZirNfsUHfXYGkrgj6n9vGzMJvvYFkHlyboGZw=;
 b=N9ju3wlnelQa1y3BNdumoSggFOgPaJP8UkEE2cZZ8FQ1o7nx88ZcPWpkCJP+w/5DdN
 /wbt3wmRoLwsQVQcLQd53ZaY6oIFxU2V/Vg/zDBpfdBlNpRiNyU8Hq1ciZkIcVIJyOzg
 BQDElIWDK3OsMqOghLmQ95IEDADRD4sKzrpSpkSHorvBnWETibQaHqb27B6Kkfiszvio
 xkBSLM767XNeCtOXo8ZHpJRzyCEPbtFU6tPkH2T6/ZtTp14Fd8v+CZuqU/rDs8wIQeqi
 SrrZJmABzSRzGrMT7M3LNdtGw/r5D9WVWQyAtrDP8gbfdSj0RzAHcEHZhyCX9jOEM4y8
 g08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762854466; x=1763459266;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wgEr6jZirNfsUHfXYGkrgj6n9vGzMJvvYFkHlyboGZw=;
 b=UTVqcmmlDX4So+/gNo7YPAObVSAxU0Zcf4FsAmEE4VD6mRk1FoQUeSzkZ5RtPaXdVa
 rr0/tU92Pvb+wP2gK2ACMAKrOSPB0Em7okEymG+1VsRrqV02Mn9Vlu3hGRKKyinJGSi9
 i8KowcID8vJUVUOJcT6lDmnTQ/JjzR9/6YL83WHo793xp4n5NL4gd9u+UDUjRVsWOU7O
 /6JHuPLQ7XB+Oc9FoGvDp+0tZ0tRJOF6qo5h5+XpxX0OgMXOYF4mrkGjaoEM0Dc3txc/
 J9bTVVc/cOD2KvzlDMwHoEy68VrNJUQlHkrFepbcJEOKEUe2OtlYamxcHJxtJ9u9BH9t
 AI9w==
X-Gm-Message-State: AOJu0YyYRLfuikLgbmD5x87kMH2bYhc0jAosLahUiZcgbJXUVqb3Qpqm
 azUdHHfCJoKGLOj8GgAdYI6xEu9q6prv5tOwosgH4K5Xj1dxq1XekLsEv8J8pMZ68il1BIqIbQD
 YYZNEOXB/s1TlONFZDtezp8aR1bmOFHfsk7yCjD0Siw==
X-Gm-Gg: ASbGnct/A+ZcuVZbsbbzzFbZHEmRY1RlijwPntej/F++ImOUj889Rl/kEnUFTZAM1Uj
 lPAs7378i7ltW/krDS0If1EvwXoe3G3jZ8B1B2BUfm3zaiGbxianPlYQ/FlnxwEmzLJtWeP/63n
 N4CWVJ+YJHGYQdxhBpRuF3JO19uwHLu/y4pDXe+TJqWFnfbRvZXEBdPaV5orewO/YbVgqIC2SX7
 0gGcnhNQE66GNJtSmuiespGbTCatqQZnYJTFsxbPlzyRvdDC/BGGHMYuw+es4pqhhBcGRu14nEb
 F4vYUmwvlMQoTh1w1AuhYmiOnFZwqU7AaiCuMl5/4rCZkLsx1jbDiDLCJrjb1A==
X-Google-Smtp-Source: AGHT+IHFUfKrk7nH/IMWX/J1q9xAOu67ibYfQPwaE1RZWHu/01+sbt+TiTnIVbqEK2Hx78S47UnlGfZp0snj06q1wyA=
X-Received: by 2002:a05:690e:1507:b0:640:d038:faef with SMTP id
 956f58d0204a3-640d45277b4mr9092748d50.9.1762854465794; Tue, 11 Nov 2025
 01:47:45 -0800 (PST)
MIME-Version: 1.0
References: <20251111054813.1966-1-hs@nabladev.com>
 <20251111054813.1966-3-hs@nabladev.com>
In-Reply-To: <20251111054813.1966-3-hs@nabladev.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 11 Nov 2025 11:47:08 +0200
X-Gm-Features: AWmQ_bnfQHtl_DW7a9rBKE1UTC9W1v_eMveZB-kx04Zpbn4QhJzOTWDb0xoL_0Q
Message-ID: <CAC_iWj+6gXzHi85zsZ_ewpjAGMCHGTGPxuxTRXMNxhiXKW=4FA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] lib: implement sm3 256 hash
To: Heiko Schocher <hs@nabladev.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Casey Connolly <casey.connolly@linaro.org>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Marek Vasut <marek.vasut@mailbox.org>, Martin Schwan <m.schwan@phytec.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>,
 Raymond Mao <raymond.mao@linaro.org>, 
 Sean Edmond <seanedmond@microsoft.com>, Simon Glass <sjg@chromium.org>, 
 Stefan Roese <stefan.roese@mailbox.org>, Sumit Garg <sumit.garg@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Utsav Agarwal <utsav.agarwal@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Yao Zi <ziyao@disroot.org>, briansune <briansune@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 11 Nov 2025 14:08:29 +0100
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

I think this would be easier to review/ack if you split the cmd
implementation from the actual hashing algo.

[...]

> +void sm3_init(struct sm3_context *sctx)
> +{
> +       memset(sctx, 0, sizeof(struct sm3_context));

I usually prefer sizeof(*sctx), but up to you

> +
> +       /* Load initial values */
> +       sctx->state[0] = SM3_IVA;
> +       sctx->state[1] = SM3_IVB;
> +       sctx->state[2] = SM3_IVC;
> +       sctx->state[3] = SM3_IVD;
> +       sctx->state[4] = SM3_IVE;
> +       sctx->state[5] = SM3_IVF;
> +       sctx->state[6] = SM3_IVG;
> +       sctx->state[7] = SM3_IVH;
> +       sctx->count = 0;
> +}
> +
> +static inline void sm3_block(struct sm3_context *sctx,
> +               u8 const *data, int blocks, u32 W[16])
> +{
> +       while (blocks--) {
> +               sm3_transform(sctx, data, W);
> +               data += SM3_BLOCK_SIZE;
> +       }
> +}
> +
> +void sm3_update(struct sm3_context *sctx, const uint8_t *input, size_t ilen)
> +{
> +       unsigned int partial = sctx->count % SM3_BLOCK_SIZE;
> +       u32 W[16];
> +
> +       sctx->count += ilen;
> +
> +       if ((partial + ilen) >= SM3_BLOCK_SIZE) {
> +               int blocks;
> +
> +               if (partial) {
> +                       int p = SM3_BLOCK_SIZE - partial;
> +
> +                       memcpy(sctx->buffer + partial, input, p);
> +                       input += p;
> +                       ilen -= p;
> +
> +                       sm3_block(sctx, sctx->buffer, 1, W);
> +               }
> +
> +               blocks = ilen / SM3_BLOCK_SIZE;
> +               ilen %= SM3_BLOCK_SIZE;
> +
> +               if (blocks) {
> +                       sm3_block(sctx, input, blocks, W);
> +                       input += blocks * SM3_BLOCK_SIZE;
> +               }
> +
> +               memset(W, 0, sizeof(W));
> +
> +               partial = 0;
> +       }
> +       if (ilen)
> +               memcpy(sctx->buffer + partial, input, ilen);
> +}
> +
> +void sm3_final(struct sm3_context *sctx, uint8_t output[SM3_DIGEST_SIZE])

I think it's more readable to just define this as output[]
[...]

> +/**
> + * sm3_hash - Calculate SM3 hash of input data
> + * @input: Input data
> + * @ilen: Input data length in bytes
> + * @output: Output buffer for hash (32 bytes)
> + */
> +void sm3_hash(const uint8_t *input, size_t ilen, uint8_t output[SM3_DIGEST_SIZE])
> +{
> +       struct sm3_context sctx;
> +
> +       sm3_init(&sctx);
> +       sm3_update(&sctx, input, ilen);
> +       sm3_final(&sctx, output);

Ah ignore my comment on patch #4
init, update, final is wrapped in this function

[...]

Thanks
/Ilias
