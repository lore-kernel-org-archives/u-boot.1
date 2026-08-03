Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FDC2C55179
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 13:07:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3F94F80DE0;
	Mon,  3 Aug 2026 13:07:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OAYq6pXgXT6x; Mon,  3 Aug 2026 13:07:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5BBE580DCF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785762455;
	bh=RPPu4RO5uGWN8wAKqccW+rfk+kAIJWLI/8fOV91NgdE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Vp+W/8dITA8cmY7ZfMXf255pLgnA+E5Ux/a1uvAjlFMt8ReWfuxilISC+1VuIT0iL
	 y/rXFgI7NCo7NsrKB5prwO1yLlI87vO6cfZCBo273kY9EuvlWDq04IhSmE98UVpaCq
	 Q0JWdhxPiLpI8PZKjCRt+YkSJ+x2z8o/WmsRMHX8L82fPM1BpdsNQS+HrF+u4RRrFG
	 9JKIp9hEiu8GMbUQMuJBnVyIR4zK8MJInd010rb48qtg4QYSpUj9UT6OACXynWLINx
	 MUn3XX4/4X2V/2PiRpm1oYJ+jy3st9iXjly25dNsupvVTzV6i/zEYCBV8nK9tr/rKM
	 T+qtYoB2Q9CvA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5BBE580DCF;
	Mon,  3 Aug 2026 13:07:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3C05D218
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 13:07:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 27E3440606
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 13:07:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2GaKFjCa2gld for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 13:07:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b134; helo=mail-yx1-xb134.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 5308B405E6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5308B405E6
Received: from mail-yx1-xb134.google.com (mail-yx1-xb134.google.com
 [IPv6:2607:f8b0:4864:20::b134])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5308B405E6
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 13:07:33 +0000 (UTC)
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-66825847b2cso3529966d50.3
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 06:07:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785762452; cv=none;
 d=google.com; s=arc-20260327;
 b=dO5err35M/llpvkvxTIfD6JgTil3fR/wHaP1cF0jXBpoOBF7uLs6x27LBbgNX9VMt0
 OrvouzVY64NJX4evRQNerNS1m3bNIjITBrBw+R/WAxGcFAdYnGVqjZXKsX31hv5u13Mf
 Zwy+Wy95JzcB25nXBZApMQQ/dxGoiqpCaxTQgQFvhoN8Imr+T5n4TVa0vAtSRDQyOv8l
 fDbbg7j9cy8IR0i6z5QNDu0/ijND6v0JbJX91+GS9WBoDZNYOYo0uy55RMkuyovz7x4B
 s8XhaxrOq76ijA//0kIpzx5gexzekrTc+iicbzCpCDG/m5Men5lUSDJVtl1A2ONL9Vts
 7X3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RPPu4RO5uGWN8wAKqccW+rfk+kAIJWLI/8fOV91NgdE=;
 fh=0OOq01pQUbd0XN/0qPZJhOOVy92lHQPNYRk7vnCJQ1k=;
 b=H5pExx1cNasQkIOyZmAAzMOurMeRP1Q8ADYusgbGk9hPzuo02V1CoZVZr5NR3CG/Gr
 iyes2GaFheTOkW8C7DXHe9Yel52njt9HPQ/VlpHawCd3fftZJyNayl24n5hWRnLJk77i
 xJqdj/nTcwmehAJUzYwoKL9+tqTvzB2t95ep8MEnwHbBQUeBGQWZu7L7IY3xznar574v
 u7cisBt/28XAviF2ZHzgZZk9FzrrRezTxDtfcLzOM7NFEQJp7GYsf9yqkw7CNib4+RlJ
 Kvw6RH5X3d46UcPtSJH7EcTQvGQg1ZIdfNCvOhvD72KHAZjejCs13s0QbMRvx0tFB9/C
 OekQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785762452; x=1786367252;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RPPu4RO5uGWN8wAKqccW+rfk+kAIJWLI/8fOV91NgdE=;
 b=aqvJkf46fLTK0HYxMVfybBsuHDH27oSXbaEzQPlZuBuP8lDwMYxVNwjkNHOAUjopGn
 e4F6i+Kt9JyytCuiZcA5vXU3xcOpIKP9zu6/o/C17RrtHUgeioDQnaSHtCjj9NL73b4k
 elkgFAlQanQwXcoy01/h1cQUQcCwBxmzPg/UJmz5U0P6yOz9d+G6uban7Q4ZUY1beQWc
 E2Zb3I3rMuEYgrP01DzYlHIU1zYuxHw/e9bdQHpihoxf5/fjNrsn+6pcJ/u2nb1XGXaL
 yvf9pnUdoQtZiBzXYfIlBfj22TvnkKpdVp6KFKLj1hVoDnD78RaJzbZZSEc+tJkeJNuC
 1qcw==
X-Forwarded-Encrypted: i=1;
 AHgh+RocWV0WPlYgaJ/FA4D/E+5387aZ9Ym5VyLLX0Nkbu3Asa+Vo/amH0g6BZSPHaUYqrVmzekS2HY=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxqfMgrugwfDTmp3CebEKF4zOoBUOibFkkJ7YigbickiWDWxBpg
 tZiflDBCScez9W1EqusWmAQgHsrsl1/7uaQgQpN9kWGgCtFO+CuSl7utfEpEflzN0z4kT9vJdTP
 ODdC+GuRXkDWq9Cs3hvGEtIp4/HM+VTXGsq4ZNdRrSQ==
X-Gm-Gg: AR+sD13TlBf0Y3qRC4Q9EPKrWAvP3dUiZjRQr05zA0csl8pBwIy2rpS3jFDksPfn0GO
 xnkgYobY2Xlje9gQ8vaV7Yv5ylTzKigJgGPN/C7QkdS0COROPGR+JeimmBYZzsO/vXL1Du0k+L2
 /qNJqYDPI3YLV1u+62GKi6uGuM3xFt2/2Ns1auBwDYC9RPXIlwUCiknWjJEP0HA5x3Oe2Shetcl
 qWnYneVoZ/+BZR4KvySk1dIFrMuz3WVXFGsv16kaJmX6fV1KaLTwHaC7whrJUOVnBHsyispcv4V
 E8zevbLb6E+QmFgJZik1Kkrk4JAqDnPGxtO6j+VWzQA7bFUCb9ZK+d7R9XzT1+UytDOsd7uAAHH
 zA7F9Cp5gpmxQm/lmSEgoekhWrNbzAfqexaU1Jk6pL9q7qkhor9GxQU7Y80f4zFVeVsc1bfGO+1
 M+XuPw/sPmVdFDsb555YmQ6x4t3pczfoDj7ZZIXIWzBbQQ+Poq2c0ZX+tjVoiqjyrr+GCGAzXp0
 5GwdyUB+FCioYwm8T2NfT+IN4QixKs4CYjVT2OAdcS3k++eRFfx5W3WKazD+gzge8s4OPiQ4ezl
 74d8CiIPX3WkYBCwVwmNEesTsp/41IWBiQiKK/hGAiv2PAHGIEZ32SUzF6katI95Nx/UmzimRjR
 uOTIoCNqPGx/3mrnHeJVM+R+fvXHY52A2F1jBo/fLznwALYMvzD7zRA==
X-Received: by 2002:a53:dac1:0:b0:669:485c:228 with SMTP id
 956f58d0204a3-6694f08c998mr9196466d50.4.1785762451679; Mon, 03 Aug 2026
 06:07:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-gpt-4k-v1-0-a3f1f16b53ae@flipper.net>
 <20260731-gpt-4k-v1-2-a3f1f16b53ae@flipper.net>
 <CAC_iWjJniUgONw47_WXAZZRsvrT_y6SJTyMLMOa+Hn9zy5BeFw@mail.gmail.com>
 <CALeDE9MOOjXRf4MAt=N-BmDdEQ522nQabEB7uoAcmf6t9fADQw@mail.gmail.com>
In-Reply-To: <CALeDE9MOOjXRf4MAt=N-BmDdEQ522nQabEB7uoAcmf6t9fADQw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 3 Aug 2026 16:06:54 +0300
X-Gm-Features: AUfX_mz6XvdkBqEFteepmaxgzV_mCmmEMzevo9mfHHArIrWTyLs0EVued-rNkWI
Message-ID: <CAC_iWj+SD6axn-auG+rsE=c=0aaLDHaVv7jmS+1t4T_Y4BZ5zw@mail.gmail.com>
Subject: Re: [PATCH 2/6] disk: part_efi: Add missing endianness conversions
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Alexey Charkov <alchark@flipper.net>, u-boot@lists.u-boot-project.org, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Tom Rini <trini@konsulko.com>, 
 Anton Burticica <mouse@ya.ru>, Javier Martinez Canillas <javierm@redhat.com>,
 Simon Glass <sjg@chromium.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Jacobe Zang <jacobe.zang@wesion.com>, 
 Jagan Teki <jagan@edgeble.ai>, Heiko Stuebner <heiko.stuebner@cherry.de>, 
 Jonas Karlman <jonas@kwiboo.se>, Suniel Mahesh <sunil@amarulasolutions.com>, 
 Klaus Goger <klaus.goger@cherry.de>, Tim Lunn <tim@feathertop.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785762452; x=1786367252;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RPPu4RO5uGWN8wAKqccW+rfk+kAIJWLI/8fOV91NgdE=;
 b=cp2daKhg6x0mGpQWV6Y/psIFmnRhoeBB3ulbw5BBLoR7FSBzEHmKi2tX9aFCJ+KSPY
 msvV6xzZWvGDJD7YoG7yfzPrI/Ikhh2qKTA6IPTsvuh/jpJujYqdr90w3Yy4LzU7Hdu7
 iPX+RuRS7gMzuBxW7SKB1b0bM0CwJx7u/rmIkenPAxN2+uofR7Beck0DhJNBzWtORN/X
 ap10V30BAzpfFbtOfBzqYgiVAdZxywoaPP2bZkrGXQPedw3ZrWnX71VmcvG7IlSO5pIl
 masy1OCwg4GaoUdGhvMXQeN6cBK92aBgS1vDla4zAj4QxCA2zlTELwpssnKZ+sd5XUeZ
 C8uw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=cp2daKhg
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Mon, 3 Aug 2026 at 15:33, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> On Mon, 3 Aug 2026 at 13:20, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > On Fri, 31 Jul 2026 at 15:40, Alexey Charkov <alchark@flipper.net> wrote:
> > >
> > > Several GPT header fields are read without converting from
> > > little-endian, which is wrong on big-endian hosts.
> >
> > Probably because we got no BE architecture running EFI.
>
> Isn't the EFI spec explicitly LE?

Ah yes, I forgot that part.
Alexey, you can drop that patch in v2

Cheers
/Ilias
>
> > > gpt_fill_pte() takes my_lba and partition_entry_lba raw when working out
> > > the region a partition must not overlap, so on a big-endian host both
> > > bounds are byte-swapped garbage and the overlap check does not do
> > > anything useful.
> > >
> > > gpt_verify_partitions() compares the loop counter against
> > > num_partition_entries raw, so its "More partitions than allowed!" guard
> > > never triggers.
> > >
> > > It also swaps gpt_part_size, which is already in host order, having been
> > > computed from two le64_to_cpu() results a few lines above. Drop the
> > > conversion rather than adding one.
> > >
> > > All of this is a no-op on little-endian targets.
> > >
> > > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> >
> > In any case it;'s good to have
> > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >
> > > ---
> > >  disk/part_efi.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/disk/part_efi.c b/disk/part_efi.c
> > > index af311867a285..062389c3af0c 100644
> > > --- a/disk/part_efi.c
> > > +++ b/disk/part_efi.c
> > > @@ -462,10 +462,10 @@ int gpt_fill_pte(struct blk_desc *desc,
> > >         char *str_type_guid;
> > >         unsigned char *bin_type_guid;
> > >  #endif
> > > -       size_t hdr_start = gpt_h->my_lba;
> > > +       size_t hdr_start = le64_to_cpu(gpt_h->my_lba);
> > >         size_t hdr_end = hdr_start + 1;
> > >
> > > -       size_t pte_start = gpt_h->partition_entry_lba;
> > > +       size_t pte_start = le64_to_cpu(gpt_h->partition_entry_lba);
> > >         size_t pte_end = pte_start + gpt_pte_blocks(desc, gpt_h);
> > >
> > >         for (i = 0; i < parts; i++) {
> > > @@ -851,7 +851,7 @@ int gpt_verify_partitions(struct blk_desc *desc,
> > >         gpt_e = *gpt_pte;
> > >
> > >         for (i = 0; i < parts; i++) {
> > > -               if (i == gpt_head->num_partition_entries) {
> > > +               if (i == le32_to_cpu(gpt_head->num_partition_entries)) {
> > >                         pr_err("More partitions than allowed!\n");
> > >                         return -1;
> > >                 }
> > > @@ -877,7 +877,7 @@ int gpt_verify_partitions(struct blk_desc *desc,
> > >                       (unsigned long long)gpt_part_size,
> > >                       (unsigned long long)partitions[i].size);
> > >
> > > -               if (le64_to_cpu(gpt_part_size) != partitions[i].size) {
> > > +               if (gpt_part_size != partitions[i].size) {
> > >                         /* We do not check the extend partition size */
> > >                         if ((i == parts - 1) && (partitions[i].size == 0))
> > >                                 continue;
> > >
> > > --
> > > 2.54.0
> > >
