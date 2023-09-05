Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F95CA0FFA
	for <u-boot@archiver.kernel.org>; Tue,  5 Sep 2023 18:05:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE39386595;
	Tue,  5 Sep 2023 20:05:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dWm5fql7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 606AE865DF; Tue,  5 Sep 2023 20:05:09 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2BDE8071F
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 20:05:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=massimo.pegorer@gmail.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5925e580f12so27806337b3.3
 for <u-boot@lists.denx.de>; Tue, 05 Sep 2023 11:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693937105; x=1694541905; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hSeIVbzqeNCP/lSJuHySN5ogGP4E5u7hHjqUQa2lasU=;
 b=dWm5fql7v2fuORMevqqf76tCL2wu3Mpeg7SekQg434W5YyLPOlUOn5j5b/Df1XYLiq
 dx+wKyKfjCKmZF/pBnsoNNOCJsBiWTfbxjMu0nqbxpMAlKXeFbjvb/8HnQBhJI8qH5aT
 3MANnPdCh3KY51ovm6X0SUhhu2CdpEmyo5PzFdVgKgklQeXkdmg0NTVH2ohD4z1XPoxN
 zCIpxQiIKLzSeAR28D+sYiZWTL/zXRTRwqpvaMzUND2UYEjMw34NNbCdx1uoRc3m6QyM
 KxNErLWOYfLxw+abMBygsHF/SwAAIA3IfIlZBxFG/FL+5uav40MyXvueb73MzN6xkVE2
 5Wdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693937105; x=1694541905;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hSeIVbzqeNCP/lSJuHySN5ogGP4E5u7hHjqUQa2lasU=;
 b=NiXLokxJlplpvRP9FBTmXRxES9x3hzD6y4LOsM9nDjc223P9YmG7oMnIHOQW2hJo+e
 gsdCSfGKERuZCJUqb1XyXUdjH7gjGVfiJz4uRQcjbVqqW1ZEqiQOxlaTLT6LKWAHkwgC
 5v5FpHLyrqbStKhV4oMFTJllSrGc0RdtzpW5PE7o5yW+cj4H8P9wt5wPz4DHoI82ABrL
 rPzFNfCAEFNFqL4PBNoBZpC+/fCNR9kfJd1x2WVWmX475dC2nx+ecVWaQfDDD5Hfyhb+
 igzxSRglZna0w2cJim37Kkw08RGvkEGTWPKOhtBsCrmqbacICfbGsr7dqVXzgyGvqjf4
 hcog==
X-Gm-Message-State: AOJu0YxxJWvSr28MsED4Elf9+JUlmiv4g14uE04jhNfxi+c7o4U8X6T6
 SsuaKE6tLkFW7bseJGLbfPCIOM6j3oDC1dIagOA=
X-Google-Smtp-Source: AGHT+IGWuh/eVadXuTndV/F/TUIh6wtSCt0X/Vh9D0Q6LebjGX9PNMwNMOlt+AVRwsHTnDO7s9hEhldom0xRjKKq5Zo=
X-Received: by 2002:a81:48d1:0:b0:577:616e:2d72 with SMTP id
 v200-20020a8148d1000000b00577616e2d72mr14470362ywa.5.1693937105318; Tue, 05
 Sep 2023 11:05:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAC928HYMtd=RZnZYW9CNc5wPjzGk11X0+RpcuwHMFEuUpv0C4w@mail.gmail.com>
 <CAPnjgZ1U1an8+2-VgEXkqZtf3yWTggtEmjn-RFjm+ESgS+Qu3g@mail.gmail.com>
In-Reply-To: <CAPnjgZ1U1an8+2-VgEXkqZtf3yWTggtEmjn-RFjm+ESgS+Qu3g@mail.gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Tue, 5 Sep 2023 20:04:54 +0200
Message-ID: <CAC928HZo8LTpp9eWST2vt_N7cN4Tdhbok_d3m9M4d+pN5rWtCQ@mail.gmail.com>
Subject: Re: Binman how to build using Rockchip BL32 binary as OP-TEE
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Kever Yang <kever.yang@rock-chips.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
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

Il giorno lun 4 set 2023 alle ore 18:49 Simon Glass <sjg@chromium.org>
ha scritto:
>
> Hi Massimo,
>
> On Mon, 4 Sept 2023 at 09:05, Massimo Pegorer
> <massimo.pegorer+oss@gmail.com> wrote:
> >
> > Hi,
> >
> > Is there any way for binman to package FIT with U-Boot TF-A and
> > OP-TEE, using bl32 binary provided by Rockchip as TEE?
> >
> > I've tried with TEE=/path/to/rkbin/bin/rk33/xxx_bl32_vX.YZ.bin, but
> > binman failed.
> >
> > In my poor understanding of Python code, it seems binman accepts only
> > ELF format or a binary format starting with optee_v1_header, but
> > binaries provided by Rockchip in rkbin repository do not have this
> > header.
>
> Yes that is correct. How would U-Boot know the load address of the TEE
> fille? Hmm it seems to be a fixed address. Perhaps you could change
> the rockchip-u-boot.dtsi file to make the 'tee-os' node a 'blobext'
> node instead, then add a filename property in there with the name of
> your file?

Yes, I agree, it can not. But I was not complaining about binman, just
wondering what I was missing, or why Rockchip binaries are lacking of
optee_v1_header. It seems these binaries are in the format of
tee-pager_v2.bin. I suspect the load address is the value of the ADDR
field in the [BL32_OPTION] of rkbin/RKTRUST/RK33xxTRUST.ini file. That
is 0x08400000 except for RK3308 which has 0x00200000. I will give it a
try.

Thanks. Regards,
Massimo

>
> >
> > Thanks in advance for any hints!
>
> Regards,
> Simon
