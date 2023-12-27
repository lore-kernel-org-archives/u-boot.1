Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D03C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 14:50:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA9A3877E2;
	Wed, 27 Dec 2023 15:50:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="umpMJhTe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24CA287823; Wed, 27 Dec 2023 15:50:51 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E35B58772A
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 15:50:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-28c467446f0so1575608a91.0
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 06:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703688647; x=1704293447; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Bi034tRwkoMBsbSBuRfBIquIPgmKB8QJ29utHfoOtGU=;
 b=umpMJhTe4d21mptD1xC6WbN5RQkvDJrrx7IgTpUTApX3eg1p4G8ZM/1Vx+QtaDBM1C
 Q4BzIJauAeysptsekBTVhuy8QEBrsqU8uDizrvTV3zR122fdTWmNQur4w8Nz0hEQErzC
 pf85J/F0qfC7cV/jeqYiu1Hpbhr7wp/Q0wx9ms/C/cfxw63WCwIs29zV0cqC2iPH+968
 1tXUuVnWlNC2jAhkIyT+jpn63T7Wni2oBTsWMAci4PndheOl0KrNH0p2wSv1VAGWTx+U
 bffgG79r3sk2Fcj5iAUUba0UB3+a8aOjQhJN1tZcnWQIwkt1GWdGO9JXByd0/2LSpMOh
 e0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703688647; x=1704293447;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Bi034tRwkoMBsbSBuRfBIquIPgmKB8QJ29utHfoOtGU=;
 b=ofyH6g6YrBhUJhaIaE109kV1SG/9thz3NbhqCkkY2bMX64MPqJvmSR4d1EOXGaJokB
 CpH4pzon1AVIo40ZyZzgIkVc4xllSpTf/xL1HGnCcFWfM2lxulUIFtTmuK+1IpL0ufXP
 EyUWQemVORLpV6IbWBPB5R2RwM+rI+f+wiScxS2PqeTvV6Bkgy++X7IS+wdp2y0GGj9U
 8Xdyt7+2q5ThL9FMM9WJHn1tBTsamrHekApjQJFPIstj1P59h7H9+N+WcHWZG+vLwiGk
 zbWCqXZw8o1vvda+r1cdvKKIMkyPUbZyM8WaQ11s+R9ifexeIQJjDhTLzlYcFPwUpssC
 U81Q==
X-Gm-Message-State: AOJu0Yy77hsZd4gYTuaLOvYqMjhFUulb7Ww962MiUakmpVVYaRTeRgjR
 uYTU5t1cXyDBqxIGxFHMPFtHwzlfHRHbQtkuENw8px0x93EWcQ==
X-Google-Smtp-Source: AGHT+IGSA8rlBweI0w0D9tBA7+zgfNgW5QgoB8h7qh6xmIcaS/zhC2toqhJLWclhEbFv4OUuyQh+M58sFodvGOW0xQ4=
X-Received: by 2002:a17:90a:9b11:b0:28c:9851:10dc with SMTP id
 f17-20020a17090a9b1100b0028c985110dcmr470264pjp.49.1703688647089; Wed, 27 Dec
 2023 06:50:47 -0800 (PST)
MIME-Version: 1.0
References: <20231218181901.337515-1-raymond.mao@linaro.org>
 <20231218181901.337515-12-raymond.mao@linaro.org> <ZYv5wc_D1VgRcQKw@hera>
In-Reply-To: <ZYv5wc_D1VgRcQKw@hera>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 27 Dec 2023 09:50:36 -0500
Message-ID: <CAEfUkU+4ePLot_81gx7JH4Fcs=qPxa-jCSEDrEXswwbHA+uyQQ@mail.gmail.com>
Subject: Re: [PATCH v3 11/14] bloblist: Adjust the bloblist header
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, jwerner@chromium.org, 
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Ilias,

On Wed, 27 Dec 2023 at 05:17, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

>
> [...]
>
> > - * @chksum: checksum for the entire bloblist allocated area. Since any
> of the
> > - *   blobs can be altered after being created, this checksum is only
> valid
> > - *   when the bloblist is finalised before jumping to the next stage of
> boot.
> > - *   This is the value needed to make all checksummed bytes sum to 0
> >   */
> >  struct bloblist_hdr {
> >       u32 magic;
> > -     u32 version;
> > -     u32 hdr_size;
> > -     u32 flags;
> > -
> > -     u32 size;
> > +     u8 chksum;
> > +     u8 version;
> > +     u8 hdr_size;
> > +     u8 align_log2;
> >       u32 alloced;
> > +     u32 size;
> > +     u32 flags;
> >       u32 spare;
> > -     u32 chksum;
> >  };
> >
>
> Aren't fields still missing from the current version?
> e.g max_size and reserved?
>
> They are all in. Please see:
[PATCH v3 14/14] bloblist: Align bloblist used_size and total_size to spec

[...]

Regards,
Raymond
