Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E96D2A528
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 15:23:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D452088C05;
	Wed, 16 Oct 2024 17:23:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Fw5vdzMc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96A5B88D14; Wed, 16 Oct 2024 17:23:19 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D51888BC2
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 17:23:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2e3d523a24dso238513a91.0
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 08:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729092195; x=1729696995; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jEileMepHtco8SorJVErU5x1EUvMv/NJgToviLZfMK8=;
 b=Fw5vdzMchdUaHw5yD3OJp5B6/g3lYN4BnKihNbo93sdSO6pQZM+rIr4ktczFb39Ls6
 /yMvkvszr/mgW2VCPxEmfRcIXYeT8+2ii3emjvlxinSHP5gd7sEMSKkwXpjiD9EFYLA7
 1XYRar3BjpJOMe/aLmPvyuGQ0dS3KbQleLaXx8rIEflwKjR6J4fZw7fVgQiHUox85Qlp
 aLJgZY2p0hYquIxzZUvhHpKH7VTbz95zI1NnmPCZPuebJBz+Y0dc1sXdSxly2JzpXOkB
 nqH8D8uA9O5wdRJWjvAujpcI3NOR7QcvetAT6ixS7HlJcLuchubkTb6soC9BOnJLusjE
 Bj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729092195; x=1729696995;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jEileMepHtco8SorJVErU5x1EUvMv/NJgToviLZfMK8=;
 b=Snsxbe5fxOjOvdPvfwMYX8E3iCdLGNgiIzoysoqh1InuHcfHJWXW+DyQa3OdlZWlvy
 yTcol7sf6o8nQSPmrzrg5Q7I4wVwK2anEHQSjsnLpBY8p60xqPFDq5ljnoO0WH14WVOD
 0Re3XgnljHDwvpOU2nADcD1apzbufx454Z1Lm9JyKFEZxVe8I3mIeSQg1LRQpKD9MeUd
 jHVxBjjZJowDX3FbBDYiJrAlAHftq2Du8gl7zEtZ8+wn/1gCVvHH4ukf8zbK0TEMV/lU
 beqebuGIT2fPBZPoZmWfvmDE8s/vlr5q9aXUv2a/M1/tz3er23vVvSQdJFLgesQ6+IVT
 hcCw==
X-Gm-Message-State: AOJu0YyFd/w6/wIu4eSIhIzo69SWijaDwP9UUKalwj1JXoQnhdnmcEUS
 b9KX5lAid9XFwIQC5kdJMD0goKsGMz9Rg6jEk6XN4Gj0y5uMnQiiq/vjii6riCkPWfmk/K1VZyI
 FTX9Ti6bdSTn8TyIxNiWhE+mT231or3FJNHUA2g==
X-Google-Smtp-Source: AGHT+IHgv4fkPnnVl1eiUaWqpTddgfEMnZnvuws+Bb+hxLfadUbL/0MROQOhvOKnk6JZueXj/vBS+CCC6H4odhkNa2A=
X-Received: by 2002:a17:90a:9a9:b0:2e2:c6a6:84da with SMTP id
 98e67ed59e1d1-2e3ab8e7c1dmr4347274a91.34.1729092194836; Wed, 16 Oct 2024
 08:23:14 -0700 (PDT)
MIME-Version: 1.0
References: <20241016034725.GD6412@bill-the-cat>
In-Reply-To: <20241016034725.GD6412@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 16 Oct 2024 11:23:02 -0400
Message-ID: <CAEfUkUJ4Z5eb7oQxSYz-N8UQ9VT8Hs=RvajNcB7dWS1zyLLV-Q@mail.gmail.com>
Subject: Re: New Defects reported by Coverity Scan for Das U-Boot
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Vignesh R <vigneshr@ti.com>, 
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Pratyush Yadav <p.yadav@ti.com>, 
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Joakim Tjernlund <joakim.tjernlund@infinera.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Tom,

On Tue, 15 Oct 2024 at 23:47, Tom Rini <trini@konsulko.com> wrote:

> Hey all, here's the latest report.
>
> ---------- Forwarded message ---------
> From: <scan-admin@coverity.com>
> Date: Tue, Oct 15, 2024 at 5:06=E2=80=AFPM
> Subject: New Defects reported by Coverity Scan for Das U-Boot
> To: <tom.rini@gmail.com>
>
>
> Hi,
>
> Please find the latest report on new defect(s) introduced to Das
> U-Boot found with Coverity Scan.
>
> 22 new defect(s) introduced to Das U-Boot found with Coverity Scan.
>
>
> New defect(s) Reported-by: Coverity Scan
> Showing 20 of 22 defect(s)
>
> [snip]


>
> *** CID 510809:  Resource leaks  (RESOURCE_LEAK)
> /lib/mbedtls/pkcs7_parser.c: 385 in x509_populate_sinfo()
> 379                                   signed_info);
> 380             if (ret)
> 381                     goto out_err_sinfo;
> 382
> 383     no_authattrs:
> 384             *sinfo =3D signed_info;
> >>>     CID 510809:  Resource leaks  (RESOURCE_LEAK)
> >>>     Variable "mctx" going out of scope leaks the storage it points to=
.
> 385             return 0;
> 386
> 387     out_err_sinfo:
> 388             pkcs7_free_sinfo_mbedtls_ctx(mctx);
> 389     out_no_mctx:
> 390             public_key_signature_free(s);
>
> I will post a patch to fix this defect  .
[snip]


> *** CID 510807:  Control flow issues  (DEADCODE)
> /lib/mbedtls/external/mbedtls/library/x509_crt.c: 2750 in
> x509_inet_pton_ipv6()
> 2744                 MBEDTLS_PUT_UINT16_BE(group, addr, nonzero_groups);
> 2745                 nonzero_groups++;
> 2746                 if (*p =3D=3D '\0') {
> 2747                     break;
> 2748                 } else if (*p =3D=3D '.') {
> 2749                     /* Don't accept IPv4 too early or late */
> >>>     CID 510807:  Control flow issues  (DEADCODE)
> >>>     Execution cannot reach the expression "zero_group_start =3D=3D -1=
"
> inside this statement: "if ((nonzero_groups =3D=3D 0 &&...".
> 2750                     if ((nonzero_groups =3D=3D 0 && zero_group_start=
 =3D=3D
> -1) ||
> 2751                         nonzero_groups >=3D 7) {
> 2752                         break;
> 2753                     }
> 2754
> 2755                     /* Walk back to prior ':', then parse as
> IPv4-mapped */
>
> This one belongs to MbedTLS lib itself, I will send a separate patch to
the MbedTLS project.
[snip]

*** CID 510806:  Control flow issues  (DEADCODE)
> /lib/mbedtls/pkcs7_parser.c: 209 in authattrs_parse()
> 203                                     return -EINVAL;
> 204                     }
> 205
> 206                     p +=3D seq_len;
> 207             }
> 208
> >>>     CID 510806:  Control flow issues  (DEADCODE)
> >>>     Execution cannot reach the expression "ret !=3D -96" inside this
> statement: "if (ret && ret !=3D -96)
>   re...".
> 209             if (ret && ret !=3D  MBEDTLS_ERR_ASN1_OUT_OF_DATA)
> 210                     return ret;
> 211
> 212             msg->have_authattrs =3D true;
> 213
> 214             /*
>
> I will post a patch to fix this defect  .
[snip]


> *** CID 510798:  Resource leaks  (RESOURCE_LEAK)
> /lib/mbedtls/x509_cert_parser.c: 220 in x509_populate_signature_params()
> 214             }
> 215
> 216             ret =3D hash_calculate(s->hash_algo, &region, 1, s->diges=
t);
> 217             if (!ret)
> 218                     *sig =3D s;
> 219
> >>>     CID 510798:  Resource leaks  (RESOURCE_LEAK)
> >>>     Variable "s" going out of scope leaks the storage it points to.
> 220             return ret;
> 221
> 222     error_sig:
> 223             public_key_signature_free(s);
> 224             return ret;
> 225     }
>
> This is false-positive, we need to keep the memory pointed by 's' as the
signature
returned to the caller.
[snip]

*** CID 510796:  Insecure data handling  (TAINTED_SCALAR)
> /lib/mbedtls/external/mbedtls/library/rsa.c: 1316 in rsa_prepare_blinding=
()
> 1310             }
> 1311
> 1312             MBEDTLS_MPI_CHK(mbedtls_mpi_fill_random(&ctx->Vf,
> ctx->len - 1, f_rng, p_rng));
> 1313
> 1314             /* Compute Vf^-1 as R * (R Vf)^-1 to avoid leaks from
> inv_mod. */
> 1315             MBEDTLS_MPI_CHK(mbedtls_mpi_fill_random(&R, ctx->len
> - 1, f_rng, p_rng));
> >>>     CID 510796:  Insecure data handling  (TAINTED_SCALAR)
> >>>     Passing tainted expression "*ctx->Vf.p" to "mbedtls_mpi_mul_mpi",
> which uses it as an offset.
> 1316             MBEDTLS_MPI_CHK(mbedtls_mpi_mul_mpi(&ctx->Vi, &ctx->Vf,
> &R));
> 1317             MBEDTLS_MPI_CHK(mbedtls_mpi_mod_mpi(&ctx->Vi,
> &ctx->Vi, &ctx->N));
> 1318
> 1319             /* At this point, Vi is invertible mod N if and only
> if both Vf and R
> 1320              * are invertible mod N. If one of them isn't, we
> don't need to know
> 1321              * which one, we just loop and choose new values for
> both of them.
>
> This one belongs to MbedTLS lib itself, I will send a separate patch to
the MbedTLS project.
[snip]

*** CID 510794:  Control flow issues  (NO_EFFECT)
> /lib/mbedtls/x509_cert_parser.c: 78 in x509_populate_dn_name_string()
> 72      do {
> 73              name_str =3D kzalloc(len, GFP_KERNEL);
> 74              if (!name_str)
> 75                      return NULL;
> 76
> 77              wb =3D mbedtls_x509_dn_gets(name_str, len, name);
> >>>     CID 510794:  Control flow issues  (NO_EFFECT)
> >>>     This less-than-zero comparison of an unsigned value is never true=
.
> "wb < 0UL".
> 78              if (wb < 0) {
> 79                      pr_err("Get DN string failed, ret:-0x%04x\n",
> 80                             (unsigned int)-wb);
> 81                      kfree(name_str);
> 82                      len =3D len * 2; /* Try with a bigger buffer */
> 83              }
>
> I will post a patch to fix this defect.

Thanks a lot for the report.

Regards,
Raymond
