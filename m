Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19114C3ABCB
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 21:41:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 318CF80C83;
	Mon, 12 May 2025 23:41:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FCBsH02B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 807C782162; Mon, 12 May 2025 23:41:34 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77D3A80584
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 23:41:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-30effbfaf4aso51985731fa.3
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 14:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747086092; x=1747690892; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d83O6GLxxyYQA3AmDkIDimhSTJ6NFw0UXNFQ7E/O3Vg=;
 b=FCBsH02BF+3PLHU1f0li1FqmwgdJQ2iPa2lSvb0/LoEMWm4Mkmpk5rFEI8UzDdXnNP
 WsqfiLpxvn9zPLdbCwrKB0QHp0Qlz4nNZpgH+hg64Dl+EyyeBzrdnzLYTu+JQBaoY3b3
 rmDNSfmzEpOuNGvpB7JxDC49ncG70TGxaRLMcNQiZJBd3+iHbI6mug5YKOX63kkTt274
 FlQkJezE4bo68YxlkMxRTLfEcDNXuFFVN/9eo4q53L8/T/ugP2PfwqpQPZq0r61cmEUC
 GqM7xLJJHi/5Uc5WKVs7G0C9jQhmIaN9AWG13xokijVUj0DTNZS2KEJ2W1ngxHxsZjY2
 h9Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747086092; x=1747690892;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d83O6GLxxyYQA3AmDkIDimhSTJ6NFw0UXNFQ7E/O3Vg=;
 b=qYdV9/tQbBwd67Ir/uFB+yO+RZkDgp8CGoB/FJcMvvvpcXjgb15DCNQrXuZjZKO06Q
 TaBKEQPQTI3waZfAT3s1IBDT0o3Q0vN2XEAO9Wct5XxaBS6cAE6gyVH1vtx89Y2zHDVL
 IHDJtPz4eNz/lsAfOH1sdE9mv3X4qrONRqmsS86oryKcvK5nh+SmbULT+qW0yezJrk/l
 xz51UZ2bRVj3XqfM4AddzAGsn0BgZ6Ld1oggxkQcONiugzL+9U+83+PTKGzuVCqzkuMJ
 lpZ/KC4thmyB4Adqo1hqxvHRZX8kuDQMndF8PBauFy+P8/YyLRsnGdJ7KhDsfxdvdbpz
 DfLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBLwJ9VG8zRh1kyZjbA8pWLu8ohQSxwx6pw80Gsjgq9dLyJZNR1DB+XwYByyAWMhP/Rfa55rA=@lists.denx.de
X-Gm-Message-State: AOJu0YzxefqOkzBLPhBART5CYQDKgxQO/3uyylA7g966vFwhDgb4u3Jd
 vixzoqDwWWi8VxDHyfOjfap6irRfUuPLFLSIlbixaK/rAJNQeszem/jKizilYspJzfZEtjOdfOF
 YkGfzmbD7wJ2ED1yFY1kylDB6bDY=
X-Gm-Gg: ASbGncswApy5eO0pS/f3Tj5RXdgQE+eEOk2VXgn6KgCvlQNIIMmuJqWeE8IBrUBb7ev
 Y4iy18JmQL/YlCqWXeQJcfEoIEDtKUhY9ZFXuOblKsRszsjMGvvXro53lAZun7OavFkKvfSFNGj
 kKzabxhgneLgOlYg3O5EHs8PWk36Mlw4XjJQmEJe6uqZYykCeBKxqWeAmauliRxruq
X-Google-Smtp-Source: AGHT+IEDgy5B01cg+GPyJg3HM9hDK9cU54lh8Ow28Zlt0BJqHJj5sItHm2OMTD+7TwQ0YHibLnF+x1wT2VYZtwy19Ks=
X-Received: by 2002:a2e:a549:0:b0:30c:50fd:925e with SMTP id
 38308e7fff4ca-326c456a7ffmr56020551fa.3.1747086091407; Mon, 12 May 2025
 14:41:31 -0700 (PDT)
MIME-Version: 1.0
References: <BE1P281MB229278535DE4B55BD7240B14E18D2@BE1P281MB2292.DEUP281.PROD.OUTLOOK.COM>
 <a0971d75-fb68-476a-9d65-025584231859@gmx.de>
 <BE1P281MB22929674BBA49DDCF59D404CE18AA@BE1P281MB2292.DEUP281.PROD.OUTLOOK.COM>
In-Reply-To: <BE1P281MB22929674BBA49DDCF59D404CE18AA@BE1P281MB2292.DEUP281.PROD.OUTLOOK.COM>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 12 May 2025 18:41:20 -0300
X-Gm-Features: AX0GCFs1cIVadjnG7B4m4ilAwq4GQDojYKTmcmnkWn0AsPimVeMko6uwEicVbCU
Message-ID: <CAOMZO5BPH6+C1_-YjhxkS7VxrBs4ECmhEMS-N8M9UuFSm6KVFQ@mail.gmail.com>
Subject: Re: arm:, imx:, caam: [PATCH] bugfix CAAM error on startup
To: "Baehring, Olaf" <Olaf.Baehring@draeger.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Gaurav Jain <gaurav.jain@nxp.com>,
 Marek Vasut <marex@denx.de>, 
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

Hi Olaf,

Please adjust the subject line to:

Subject: [PATCH] caam: Fix error on startup

On Fri, May 9, 2025 at 9:41=E2=80=AFAM Baehring, Olaf <Olaf.Baehring@draege=
r.com> wrote:
>
> Internal

Please remove this line.

> In rare cases U-Boot returns an error message when intantiating the RNG
> of the CAAM device:
> =E2=80=9CSEC0:  RNG4 SH0 instantiation failed with error 0xffffffff=E2=80=
=9D
> This  means, that even when the CAAM device reports a finished
> descriptor, none is found in the output ring.
> This might be caused by a missing cache invalidation before
> reading the memory of the output ring
> This patch moves the cache invalidation of the output ring from start of
> the job to immediately after the notification from hardware where the
> output ring will be read.

Add your Signed-off-by tag.

I tried applying your patch, but it failed:

$ git am --3way
~/Downloads/arm-imx-caam-PATCH-bugfix-CAAM-error-on-startup.patch
Applying: arm:, imx:, caam: [PATCH] bugfix CAAM error on startup
Using index info to reconstruct a base tree...
error: patch failed: drivers/crypto/fsl/jr.c:217
error: drivers/crypto/fsl/jr.c: patch does not apply
error: patch failed: drivers/crypto/fsl/jr.h:83
error: drivers/crypto/fsl/jr.h: patch does not apply
error: Did you hand edit your patch?
It does not apply to blobs recorded in its index.
Patch failed at 0001 arm:, imx:, caam: [PATCH] bugfix CAAM error on startup
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

It seems the patch is corrupted.

./scripts/checkpatch.pl shows several issues as well.

Please fix these problems and submit a v2 using 'git send-mail'.

Thanks
