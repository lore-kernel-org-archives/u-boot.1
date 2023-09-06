Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05485EB8FB6
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 12:22:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A4FF86571;
	Wed,  6 Sep 2023 14:22:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="dJLuixiq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19510865A0; Wed,  6 Sep 2023 14:22:17 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42FC686568
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 14:22:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-58caaedb20bso36755047b3.1
 for <u-boot@lists.denx.de>; Wed, 06 Sep 2023 05:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1694002933; x=1694607733;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=96cVDFzOHOp0O2xlSYyiAW3RJ7AcS9RZUVnDpiwLyDw=;
 b=dJLuixiqHoelJc8AOPcIMkTiyQ5+j5SzMfHXNiNAgoUlz0kVMM9MoMxxLx3V7BvD9v
 /631DM94g9H0eAkb4+9Or578ARWCSIw467e/uBM/P6JSbr/XyHSYsCddihHalxBO6fvy
 Ommd7xoK0UEXyKOjLN9ViFuoPyT4bX3WQx1kaQlI2Awnb9u9abCuTBFbr/cuTn2t8C5w
 pAEfNhBUVwt4PLN+jTC+miJUbfmm1oo9BfYunKNCV8uoiXO33k1DRaF+M9uRNcSI4HQD
 D2DuJd4psUYWgelhPypQOQb1cqsuKVVode6S4+oXwefGvUZ3zQMHv+X967btkHBd5cVw
 jQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694002933; x=1694607733;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=96cVDFzOHOp0O2xlSYyiAW3RJ7AcS9RZUVnDpiwLyDw=;
 b=izTLgWcsilAsednFOv6JwPXyD2/z8uJBlyMtf05IECarsyW1WLYCC7W1Lli0HeG0wc
 hZ630rG7zpPmXwiwil4ByLAloH3W52OvBZYvrfSrrHOFWvyAOB9ZfOcX7USC8Ky9lsHs
 c3+ea/LUhA/jIIxId3ukntwlKyyTTqkQku/LWel1/8c6HQYtOSJv0GkBSNIUwVpRjznf
 JngHiop4vUpT3IW5B1DdaicRdB8yOKM2ZuvyCejz/f8A0yM4Fmuif0GWddP9AOQ0f36w
 5+842PwIVojEo0YsTs+ukZ3OG9qyntp3THmCGTe4f3nYzPQjOetnDDndLow55MtK7go+
 gJEA==
X-Gm-Message-State: AOJu0YyOUhH0y/wKM7MFFBMPdBd2dLc4J5QABd3SBGBj6clmeGc/1U6o
 Vq7G/m9PDK+bdh6fgLNKecEw9nVpgh/1dL59vhxEWg==
X-Google-Smtp-Source: AGHT+IGMXD/ZguDiHmKlbRuofngzU+UC1eCjVwNU5ynjgiZcyATzj2mi36u+vnJsKQ6ptRwJEowgIxhDz+CfRc+b9Qo=
X-Received: by 2002:a25:2f95:0:b0:d78:ef4:76ae with SMTP id
 v143-20020a252f95000000b00d780ef476aemr15391336ybv.33.1694002933001; Wed, 06
 Sep 2023 05:22:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230725213634.255345-1-sjg@chromium.org>
In-Reply-To: <20230725213634.255345-1-sjg@chromium.org>
From: Michal Simek <monstr@monstr.eu>
Date: Wed, 6 Sep 2023 14:22:01 +0200
Message-ID: <CAHTX3dJ+es41yLzPA32kLWt70d0rGATCROJBW8aXMZjZA5w=Hg@mail.gmail.com>
Subject: Re: [PATCH 00/14] bloblist: Align to firmware handoff
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Julius Werner <jwerner@chromium.org>, 
 Dan Handley <dan.handley@arm.com>, Jose Marinho <jose.marinho@arm.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Michal Simek <michal.simek@amd.com>
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

Hi Simon,

=C3=BAt 25. 7. 2023 v 23:36 odes=C3=ADlatel Simon Glass <sjg@chromium.org> =
napsal:
>
> In moving from v0.8 to v0.9 the Firmware Handoff specification made some
> changes, including:
>
>    - Use a packed format for headers to reduce space
>    - Add an explicit alignment field in the header
>    - Renumber all the tags and reduce their size to 24 bits
>    - Drop use of the blob header to specify alignment, in favour of a
>      'void' blob type
>
> This series attempts to align to that specification, including updating
> the API and tests. It is likely that refinements will be made as other
> projects implement the spec too.
>
> As before the code is dual-licensed, to permit use in projects with a
> permissive license.
>
>
> Simon Glass (14):
>   bloblist: Update the tag numbering
>   bloblist: Adjust API to align in powers of 2
>   bloblist: Change the magic value
>   bloblist: Set version to 1
>   bloblist: Access record hdr_size and tag via a function
>   bloblist: Drop the flags value
>   bloblist: Drop the spare values
>   bloblist: Change the checksum algorithm
>   bloblist: Checksum the entire bloblist
>   bloblist: Handle alignment with a void entry
>   bloblist: Reduce blob-header size
>   bloblist: Reduce bloblist header size
>   bloblist: Add alignment to bloblist_new()
>   bloblist: Update documentation and header comment
>
>  arch/x86/lib/tables.c    |   3 +-
>  common/bloblist.c        | 102 ++++++++++++++++++++-------------
>  doc/develop/bloblist.rst |   4 +-
>  include/bloblist.h       | 121 +++++++++++++++++++--------------------
>  test/bloblist.c          |  53 +++++++++--------
>  5 files changed, 152 insertions(+), 131 deletions(-)
>
> --
> 2.41.0.487.g6d72f3e995-goog
>

Would it be also possible to align names in the bloblist_hdr structure?
magic->signature
align_log2->alignment
alloced->size
size->max_size

The same is for bloblist_rec.

I don't know the history but spec is about transfer list and transfer entry=
.
Do you plan to rename it to avoid confusion?

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
