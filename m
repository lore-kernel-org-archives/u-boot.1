Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CFAEC3ABDD
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 16:28:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10B3882C2F;
	Tue, 20 May 2025 18:28:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FGYoKhS1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2194682C55; Tue, 20 May 2025 18:28:46 +0200 (CEST)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB8A682B00
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 18:28:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-327fcd87a3cso48559821fa.0
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 09:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747758523; x=1748363323; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hdLGzfc/PPizAcBxuR1aTp5G00ItCNQ75ovfnQawXp4=;
 b=FGYoKhS1cV83tp3DEUGrZStAEE1m6cg1AeeWhmMOI5B1KxaGPShai0TwPf4CKhb2w3
 m5oDu1dCwYUezXaDRjF9+pUydjAoRX2kQOSi08rmEQSQTGrCmVDqmXEo65/iYCCNWyRi
 FUjCLpFiyp0ka8bWR2KvqJeMpQdtqBG5svRwZZqcUO9ainrQx3FcEBPk32WpmRLtDyE9
 u21b6LEFyDoziyyy8TgoqN/okXo4nipIYvaWYZSvr+0poedp//nYjbh1BSIHILbWBGkj
 /3Qo+ZHzlpES5of/iF6iOLRoK5zGWqXp+8P6XR0GvG7DTHhkyEV/xJkMu2+2AIQHE13W
 RELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747758523; x=1748363323;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hdLGzfc/PPizAcBxuR1aTp5G00ItCNQ75ovfnQawXp4=;
 b=qIvcLDLY6yLUKDX7HKIM7GZiZ7lVn2P1/FFjyztFO0jcofCYRjFp3xiw3NsrAWcZX6
 JYe2moBYtTazCWSoczcJzZfxUobm9NnSoqDXpSYW1pm6luHxpIrBXt9/YfrFiQGxcytD
 EUT4NTxM7LsBphl2vXVwKzg5KikDJ0eGxl+mo2SbZikkEmkkaUqWlGUzvh6e8WB80uqP
 p1GBxancwaiuTEaGPqGMMo7oSnWz8ZsOzoCFvBp4SJEtFrfSyg+1OoPDXW3SstChm9QA
 cQOLOkAx0sijuMVl7Sn3kuDNjv4zrweMwwuXQdq2uMZWc2IYu+m6fL+gnaVqGJUuQ1g1
 6VTQ==
X-Gm-Message-State: AOJu0YxlSQXl9ek6QeulB+KdaTWOmp8+WZm+PFJq7rPndmnYD/fP6o0Y
 t4Hw3f3uji0Qh+k3RvbL5pOiGrCmOKAblAlq0bFVAWv0X5zPv/9AY0nKJh2eTjvtuWehKPBx9u8
 cTlAoqU+R77RTPFgjiRbp61hwWcNViS0=
X-Gm-Gg: ASbGncvWFI/gNmU5NSGNng7iiKRtoYe8xkn2QJ1Mtf/K3v4LXZ9h6klLXtDs52eSk+G
 m2GlOAt4ijC8+PmmXOG1hsMm00T2XsgioRH3vOpVX0J2NFxEvrwvajlrvZw+Rx2m3U5/hNGRfM1
 xWMenE6oXNFnnKqKw+8O7qkZ/ioTG7drchoZKqlgV+48nZeusBovJZEAj/hbKgivs=
X-Google-Smtp-Source: AGHT+IGjOJes4qCLhSHnQLkzzdoMX7qk4GSn5gQFibslzfeOD/qVdojBBzBUlpJ5IvO/pEh4e3PgWKy+Gux/gZL9dvc=
X-Received: by 2002:a2e:bc03:0:b0:30b:c22d:83b3 with SMTP id
 38308e7fff4ca-328096d3b48mr47643831fa.15.1747758522690; Tue, 20 May 2025
 09:28:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250520084120.4175862-1-olaf.baehring@draeger.com>
In-Reply-To: <20250520084120.4175862-1-olaf.baehring@draeger.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 20 May 2025 13:28:31 -0300
X-Gm-Features: AX0GCFuUbyiYk7cp9rNgNLj4kUl3MB8ktnWtgTIhzZ-45SWYxqTYSvAs6TcMzOw
Message-ID: <CAOMZO5CzrYL=fhj0gSaf4f-ftwptuBKwWVCmyi6XjB-8Ba6_Wg@mail.gmail.com>
Subject: Re: [PATCH v2] caam: bugfix CAAM error on startup
To: Olaf Baehring <olaf.baehring@draeger.com>
Cc: u-boot@lists.denx.de, Gaurav Jain <gaurav.jain@nxp.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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

On Tue, May 20, 2025 at 9:53=E2=80=AFAM Olaf Baehring <olaf.baehring@draege=
r.com> wrote:
>
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
>
> Signed-off-by: Olaf Baehring <olaf.baehring@draeger.com>
> ---

This patch still has issues and does not apply:

~/denx/u-boot$ ./scripts/checkpatch.pl
~/Downloads/v2-caam-bugfix-CAAM-error-on-startup.patch
WARNING: please, no spaces at the start of a line
#231: FILE: drivers/crypto/fsl/jr.c:239:
+       unsigned long start, end;$

ERROR: code indent should use tabs where possible
#240: FILE: drivers/crypto/fsl/jr.c:248:
+               /* Invalidate output ring */$

ERROR: code indent should use tabs where possible
#241: FILE: drivers/crypto/fsl/jr.c:249:
+               start =3D (unsigned long)jr->output_ring &$

WARNING: please, no spaces at the start of a line
#241: FILE: drivers/crypto/fsl/jr.c:249:
+               start =3D (unsigned long)jr->output_ring &$

ERROR: code indent should use tabs where possible
#242: FILE: drivers/crypto/fsl/jr.c:250:
+                                               ~(ARCH_DMA_MINALIGN - 1);$

WARNING: please, no spaces at the start of a line
#242: FILE: drivers/crypto/fsl/jr.c:250:
+                                               ~(ARCH_DMA_MINALIGN - 1);$

ERROR: code indent should use tabs where possible
#243: FILE: drivers/crypto/fsl/jr.c:251:
+               end =3D ALIGN((unsigned long)jr->output_ring$

WARNING: please, no spaces at the start of a line
#243: FILE: drivers/crypto/fsl/jr.c:251:
+               end =3D ALIGN((unsigned long)jr->output_ring$

ERROR: code indent should use tabs where possible
#244: FILE: drivers/crypto/fsl/jr.c:252:
+                                       + jr->op_size, ARCH_DMA_MINALIGN);$

WARNING: please, no spaces at the start of a line
#244: FILE: drivers/crypto/fsl/jr.c:252:
+                                       + jr->op_size, ARCH_DMA_MINALIGN);$

ERROR: code indent should use tabs where possible
#245: FILE: drivers/crypto/fsl/jr.c:253:
+               invalidate_dcache_range(start, end);$

WARNING: please, no spaces at the start of a line
#245: FILE: drivers/crypto/fsl/jr.c:253:
+               invalidate_dcache_range(start, end);$

ERROR: code indent should use tabs where possible
#255: FILE: drivers/crypto/fsl/jr.c:288:
+               if (!found) {$

WARNING: please, no spaces at the start of a line
#255: FILE: drivers/crypto/fsl/jr.c:288:
+               if (!found) {$

WARNING: suspect code indent for conditional statements (15, 23)
#255: FILE: drivers/crypto/fsl/jr.c:288:
+               if (!found) {
+                       int slots_full =3D sec_in32(&regs->orsf);

ERROR: code indent should use tabs where possible
#256: FILE: drivers/crypto/fsl/jr.c:289:
+                       int slots_full =3D sec_in32(&regs->orsf);$

WARNING: please, no spaces at the start of a line
#256: FILE: drivers/crypto/fsl/jr.c:289:
+                       int slots_full =3D sec_in32(&regs->orsf);$

ERROR: code indent should use tabs where possible
#258: FILE: drivers/crypto/fsl/jr.c:291:
+                       jr->tail =3D (jr->tail + slots_full) & (jr->size - =
1);$

WARNING: please, no spaces at the start of a line
#258: FILE: drivers/crypto/fsl/jr.c:291:
+                       jr->tail =3D (jr->tail + slots_full) & (jr->size - =
1);$

ERROR: code indent should use tabs where possible
#259: FILE: drivers/crypto/fsl/jr.c:292:
+                       sec_out32(&regs->orjr, slots_full);$

WARNING: please, no spaces at the start of a line
#259: FILE: drivers/crypto/fsl/jr.c:292:
+                       sec_out32(&regs->orjr, slots_full);$

ERROR: code indent should use tabs where possible
#261: FILE: drivers/crypto/fsl/jr.c:294:
+               }$

WARNING: please, no spaces at the start of a line
#261: FILE: drivers/crypto/fsl/jr.c:294:
+               }$

ERROR: code indent should use tabs where possible
#269: FILE: drivers/crypto/fsl/jr.c:301:
+                * tail till the point where job completed out of order has=
$

WARNING: suspect code indent for conditional statements (23, 31)
#273: FILE: drivers/crypto/fsl/jr.c:305:
                        do {
+                               jr->info[tail].op_done =3D 0;

ERROR: code indent should use tabs where possible
#274: FILE: drivers/crypto/fsl/jr.c:306:
+                               jr->info[tail].op_done =3D 0;$

WARNING: please, no spaces at the start of a line
#274: FILE: drivers/crypto/fsl/jr.c:306:
+                               jr->info[tail].op_done =3D 0;$

total: 13 errors, 14 warnings, 0 checks, 87 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplac=
e.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

/home/fabio/Downloads/v2-caam-bugfix-CAAM-error-on-startup.patch has
style problems, please review.

NOTE: Ignored message types: COMPLEX_MACRO CONSIDER_KSTRTO ENOSYS
MINMAX MULTISTATEMENT_MACRO_USE_DO_WHILE
NETWORKING_BLOCK_COMMENT_STYLE PREFER_ETHER_ADDR_COPY USLEEP_RANGE

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.
~/denx/u-boot$ git am ~/Downloads/v2-caam-bugfix-CAAM-error-on-startup.patc=
h
fatal: previous rebase directory .git/rebase-apply still exists but mbox gi=
ven.
~/denx/u-boot$ rm -rf .git/rebase-apply/
~/denx/u-boot$ git am ~/Downloads/v2-caam-bugfix-CAAM-error-on-startup.patc=
h
Applying: caam: bugfix CAAM error on startup
error: patch failed: drivers/crypto/fsl/jr.c:217
error: drivers/crypto/fsl/jr.c: patch does not apply
error: patch failed: drivers/crypto/fsl/jr.h:83
error: drivers/crypto/fsl/jr.h: patch does not apply
Patch failed at 0001 caam: bugfix CAAM error on startup
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".


> This communication contains confidential information. If you are not the =
intended recipient please return this email to the sender and delete it fro=
m your records.
>
> Diese Nachricht enthaelt vertrauliche Informationen. Sollten Sie nicht de=
r beabsichtigte Empfaenger dieser E-mail sein, senden Sie bitte diese an de=
n Absender zurueck und loeschen Sie die E-mail aus Ihrem System.

Please remove this part.

For v3, make sure you can apply the patch without error.
