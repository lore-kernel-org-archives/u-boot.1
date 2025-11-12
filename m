Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE0F0CCFA1A
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 13:12:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCA0483C54;
	Wed, 12 Nov 2025 14:12:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="EnR5b+zM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1406283C01; Wed, 12 Nov 2025 06:05:39 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EBAA83AAD
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 06:05:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 13C1310A01C; Wed, 12 Nov 2025 06:05:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1762923935;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=ZC3i+jvRSMtgka5yxPRk4glGUwDccdPm3tkHV1XptP8=;
 b=EnR5b+zMepTg/m9lAm+SjiZpxo6oGcYugkHnfXO5af3BZWpusOhi6i6qvEp607VjzWHfgs
 dJYvhFV1IkhQK10xFxrUo5XPkjoEz5NWK0qw3vgVd+i3lS9YJrd7ErUHC1IgwLEzD28AVv
 2gNGKCWWk8AR7xDCYsF3IWd4nmHS3AMnyeKKFtwj3dPzT/qxeVdm3UhSKEz0tP8H2VMGcK
 gwmt2dCZHGvrS/804c65Z5zjTX7sB47ZiqSuQLyb8GwnDyLRsNOr/z890qQdSfd4ztOdS5
 brRgoIz7GpGI2X2h5cEwwYus+TQyxwJ0ELlJNgMm6x+iiwHeix2q8ns532FMqw==
Message-ID: <fc3615dd-39a5-54f3-548a-472e13c14326@nabladev.com>
Date: Wed, 12 Nov 2025 06:05:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 2/5] lib: implement sm3 256 hash
Content-Language: en-US
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Greg Malysa <malysagreg@gmail.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut@mailbox.org>, Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Raymond Mao <raymond.mao@linaro.org>, Sean Edmond
 <seanedmond@microsoft.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <stefan.roese@mailbox.org>, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>, Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Yao Zi <ziyao@disroot.org>, briansune <briansune@gmail.com>
References: <20251111054813.1966-1-hs@nabladev.com>
 <20251111054813.1966-3-hs@nabladev.com>
 <CAC_iWj+6gXzHi85zsZ_ewpjAGMCHGTGPxuxTRXMNxhiXKW=4FA@mail.gmail.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <CAC_iWj+6gXzHi85zsZ_ewpjAGMCHGTGPxuxTRXMNxhiXKW=4FA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Wed, 12 Nov 2025 14:12:01 +0100
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

Hello Ilias,

On 11.11.25 10:47, Ilias Apalodimas wrote:
> I think this would be easier to review/ack if you split the cmd
> implementation from the actual hashing algo.

Okay, I will split it in v3 into 2 patches.

> 
> [...]
> 
>> +void sm3_init(struct sm3_context *sctx)
>> +{
>> +       memset(sctx, 0, sizeof(struct sm3_context));
> 
> I usually prefer sizeof(*sctx), but up to you

Hmm.. I have no preference here ... so I change it.

>> +
>> +       /* Load initial values */
>> +       sctx->state[0] = SM3_IVA;
>> +       sctx->state[1] = SM3_IVB;
>> +       sctx->state[2] = SM3_IVC;
>> +       sctx->state[3] = SM3_IVD;
>> +       sctx->state[4] = SM3_IVE;
>> +       sctx->state[5] = SM3_IVF;
>> +       sctx->state[6] = SM3_IVG;
>> +       sctx->state[7] = SM3_IVH;
>> +       sctx->count = 0;
>> +}
>> +
>> +static inline void sm3_block(struct sm3_context *sctx,
>> +               u8 const *data, int blocks, u32 W[16])
>> +{
>> +       while (blocks--) {
>> +               sm3_transform(sctx, data, W);
>> +               data += SM3_BLOCK_SIZE;
>> +       }
>> +}
>> +
>> +void sm3_update(struct sm3_context *sctx, const uint8_t *input, size_t ilen)
>> +{
>> +       unsigned int partial = sctx->count % SM3_BLOCK_SIZE;
>> +       u32 W[16];
>> +
>> +       sctx->count += ilen;
>> +
>> +       if ((partial + ilen) >= SM3_BLOCK_SIZE) {
>> +               int blocks;
>> +
>> +               if (partial) {
>> +                       int p = SM3_BLOCK_SIZE - partial;
>> +
>> +                       memcpy(sctx->buffer + partial, input, p);
>> +                       input += p;
>> +                       ilen -= p;
>> +
>> +                       sm3_block(sctx, sctx->buffer, 1, W);
>> +               }
>> +
>> +               blocks = ilen / SM3_BLOCK_SIZE;
>> +               ilen %= SM3_BLOCK_SIZE;
>> +
>> +               if (blocks) {
>> +                       sm3_block(sctx, input, blocks, W);
>> +                       input += blocks * SM3_BLOCK_SIZE;
>> +               }
>> +
>> +               memset(W, 0, sizeof(W));
>> +
>> +               partial = 0;
>> +       }
>> +       if (ilen)
>> +               memcpy(sctx->buffer + partial, input, ilen);
>> +}
>> +
>> +void sm3_final(struct sm3_context *sctx, uint8_t output[SM3_DIGEST_SIZE])
> 
> I think it's more readable to just define this as output[]
> [...]

okay, I also change it in sm3_hash()

> 
>> +/**
>> + * sm3_hash - Calculate SM3 hash of input data
>> + * @input: Input data
>> + * @ilen: Input data length in bytes
>> + * @output: Output buffer for hash (32 bytes)
>> + */
>> +void sm3_hash(const uint8_t *input, size_t ilen, uint8_t output[SM3_DIGEST_SIZE])
>> +{
>> +       struct sm3_context sctx;
>> +
>> +       sm3_init(&sctx);
>> +       sm3_update(&sctx, input, ilen);
>> +       sm3_final(&sctx, output);
> 
> Ah ignore my comment on patch #4
> init, update, final is wrapped in this function

Yep, it saves in lib/tpm_tcg2.c tcg2_create_digest() another ifdef
in the variable declaration part.

bye,
Heiko
> 
> [...]
> 
> Thanks
> /Ilias
> 

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
