Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52486C3ABAC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 17:33:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87375820E1;
	Fri,  2 May 2025 19:33:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="tRa58FEI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF620820E2; Fri,  2 May 2025 19:33:43 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A26B981FAB
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 19:33:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1746207215; x=1746812015; i=xypron.glpk@gmx.de;
 bh=UHHvswxRkIw8s8xSApt4EJTMhpzKhoIRO4hRCYQMHu4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=tRa58FEIpIvKOPP70IdKqoAGqY1emZWfdWaUoXoP7tem86HE4t+t9ZFbAZiA5v+3
 RsGXZocVDC4SykEpGhPJe3bn503onoS+tbYworWgmbcvgeHKtY+cv+3mHdhvI7JBo
 +MV6bqvEX+QuOuYfZfoNVN49Ie7gZneul7rlpdXOQwo1NarazIEYnetSCPwr50UUi
 PzMrhUXyhIJE0EB6rYdz86pbui6D4ppk+SlZSuFq54XedKmGGP2HDmDRlNNCUdfEe
 rABbZux6Ib53lApFWQSofMqSua6/O7nA1798QLzpIwZMHA9DeFu5KMKqc1DJFTcM8
 ahEyK9nh6dGZDwJYbw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.111.64]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mqs0R-1uoPsM2I65-00pCIZ; Fri, 02
 May 2025 19:33:35 +0200
Message-ID: <a0971d75-fb68-476a-9d65-025584231859@gmx.de>
Date: Fri, 2 May 2025 19:33:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bugfix CAAM error on startup
To: "Baehring, Olaf" <Olaf.Baehring@draeger.com>
Cc: Gaurav Jain <gaurav.jain@nxp.com>, Marek Vasut <marex@denx.de>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <BE1P281MB229278535DE4B55BD7240B14E18D2@BE1P281MB2292.DEUP281.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <BE1P281MB229278535DE4B55BD7240B14E18D2@BE1P281MB2292.DEUP281.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2XCYXXgVamQUvjhjTzraUMwhQecg70enoISIQGp+na47QUNkmvg
 KJkmaO58FEkCsF/78vLQRhvjE9WJPCO4G+7J1BQi9ypzo+VpFMd6gUWuda0DAOpdwtzjzsG
 deqxw7ZggLDuRBVwgZSu/aRcBVQOaM0hoOsW6aqLqHiOGwcsofDS+m98xoIA/L5XDBJBjWk
 ttMX+C8QKIYVIL+uK9/Jw==
UI-OutboundReport: notjunk:1;M01:P0:3gvcsMbxETA=;wpjTLydq/f5iDJMZUZcLpEVSdD5
 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
 g==
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

Hello Olaf,

The mail arrived without any subject line in the email header.
There was only a subject line in the message body.
The patch cannot be processed by the tooling of the U-Boot project=20
without a proper subject line.

Please, resend your patch with a subject header line,
e.g. using `git email`.

Best regards

Heinrich

On 5/2/25 11:02, Baehring, Olaf wrote:
> Internal
>=20
> Subject: [PATCH] bugfix CAAM error on startup
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>=20
> In rare cases U-Boot returns an error message when intantiating the RNG
> of the CAAM device:
> "SEC0:  RNG4 SH0 instantiation failed with error 0xffffffff"
> This  means, that even when the CAAM device reports a finished
> descriptor, none is found in the output ring.
> This might be caused by a missing cache invalidation before
> reading the memory of the output ring
> This patch moves the cache invalidation of the output ring from start of
> the job to immediately after the notification from hardware where the
> output ring will be read.
>=20
> Signed-off-by: Baehring, Olaf <olaf.baehring@draeger.com>
> ---
>=20
>   drivers/crypto/fsl/jr.c | 30 +++++++++++++++++-------------
>   drivers/crypto/fsl/jr.h |  4 ----
>   2 files changed, 17 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/crypto/fsl/jr.c b/drivers/crypto/fsl/jr.c
> index 8f7a821ebf3..edf678d363e 100644
> --- a/drivers/crypto/fsl/jr.c
> +++ b/drivers/crypto/fsl/jr.c
> @@ -217,13 +217,6 @@ static int jr_enqueue(uint32_t *desc_addr,
>=20
>          jr->head =3D (head + 1) & (jr->size - 1);
>=20
> -       /* Invalidate output ring */
> -       start =3D (unsigned long)jr->output_ring &
> -                                       ~(ARCH_DMA_MINALIGN - 1);
> -       end =3D ALIGN((unsigned long)jr->output_ring + jr->op_size,
> -                   ARCH_DMA_MINALIGN);
> -       invalidate_dcache_range(start, end);
> -
>          sec_out32(&regs->irja, 1);
>=20
>          return 0;
> @@ -243,6 +236,7 @@ static int jr_dequeue(int sec_idx, struct caam_regs =
*caam)
>   #else
>          uint32_t *addr;
>   #endif
> +       unsigned long start, end;
>=20
>          while (sec_in32(&regs->orsf) && CIRC_CNT(jr->head, jr->tail,
>                                                   jr->size)) {
> @@ -250,6 +244,14 @@ static int jr_dequeue(int sec_idx, struct caam_regs=
 *caam)
>                  found =3D 0;
>=20
>                  caam_dma_addr_t op_desc;
> +
> +               /* Invalidate output ring */
> +               start =3D (unsigned long)jr->output_ring &
> +                                               ~(ARCH_DMA_MINALIGN - 1)=
;
> +               end =3D ALIGN((unsigned long)jr->output_ring
> +                                       + jr->op_size, ARCH_DMA_MINALIGN=
);
> +               invalidate_dcache_range(start, end);
> +
>          #ifdef CONFIG_CAAM_64BIT
>                  /* Read the 64 bit Descriptor address from Output Ring.
>                   * The 32 bit hign and low part of the address will
> @@ -283,28 +285,31 @@ static int jr_dequeue(int sec_idx, struct caam_reg=
s *caam)
>                  }
>=20
>                  /* Error condition if match not found */
> -               if (!found)
> +               if (!found) {
> +                       int slots_full =3D sec_in32(&regs->orsf);
> +
> +                       jr->tail =3D (jr->tail + slots_full) & (jr->size=
 - 1);
> +                       sec_out32(&regs->orjr, slots_full);
>                          return -1;
> +               }
>=20
>                  jr->info[idx].op_done =3D 1;
>                  callback =3D (void *)jr->info[idx].callback;
>                  arg =3D jr->info[idx].arg;
>=20
>                  /* When the job on tail idx gets done, increment
> -                * tail till the point where job completed out of oredr =
has
> +                * tail till the point where job completed out of order =
has
>                   * been taken into account
>                   */
>                  if (idx =3D=3D tail)
>                          do {
> +                               jr->info[tail].op_done =3D 0;
>                                  tail =3D (tail + 1) & (jr->size - 1);
>                          } while (jr->info[tail].op_done);
>=20
>                  jr->tail =3D tail;
> -               jr->read_idx =3D (jr->read_idx + 1) & (jr->size - 1);
>=20
>                  sec_out32(&regs->orjr, 1);
> -               jr->info[idx].op_done =3D 0;
> -
>                  callback(status, arg);
>          }
>=20
> @@ -378,7 +383,6 @@ static int jr_sw_cleanup(uint8_t sec_idx, struct caa=
m_regs *caam)
>=20
>          jr->head =3D 0;
>          jr->tail =3D 0;
> -       jr->read_idx =3D 0;
>          jr->write_idx =3D 0;
>          memset(jr->info, 0, sizeof(jr->info));
>          memset(jr->input_ring, 0, jr->size * sizeof(caam_dma_addr_t));
> diff --git a/drivers/crypto/fsl/jr.h b/drivers/crypto/fsl/jr.h
> index b136cd8d05a..8d5ca03e501 100644
> --- a/drivers/crypto/fsl/jr.h
> +++ b/drivers/crypto/fsl/jr.h
> @@ -83,10 +83,6 @@ struct jobring {
>           * in-order job completion
>           */
>          int tail;
> -       /* Read index of the output ring. It may not match with tail in =
case
> -        * of out of order completetion
> -        */
> -       int read_idx;
>          /* Write index to input ring. Would be always equal to head */
>          int write_idx;
>          /* Size of the rings. */
> --
> 2.34.1
>=20
> ---
> This communication contains confidential information. If you are not the=
 intended recipient please return this email to the sender and delete it f=
rom your records.
>=20
> Diese Nachricht enthaelt vertrauliche Informationen. Sollten Sie nicht d=
er beabsichtigte Empfaenger dieser E-mail sein, senden Sie bitte diese an =
den Absender zurueck und loeschen Sie die E-mail aus Ihrem System.

