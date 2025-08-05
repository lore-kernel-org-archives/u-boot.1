Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD72C87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 14:44:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BEF98383F;
	Tue,  5 Aug 2025 16:44:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nvYlFgNY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7388283869; Tue,  5 Aug 2025 16:44:56 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A697583835
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 16:44:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-741b1657dd8so1211431a34.2
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 07:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754405092; x=1755009892; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SXPLgL0+Hf2xuR7ZXEYw/qGxcOyYWLJUSrNpVY2eOTI=;
 b=nvYlFgNYiRZgaAOBwkIWeULjGRY0nyllbaJ7i1xih+9CkuI1wujexrTX3G+ldXBerq
 arxDDldNyGbaklOQp7XAT7g9Lgnml4cAYqY0jN+8MB/VrcGtlTiNnPlFQ/4S0xVookyo
 LPOMRrvz11Pqw4rDV5NXE06fWV0lbwm0qHNxVm5ohP76LqZAQwdhhb1jdPKWkT9kUHLh
 zdxvstlJyDjY11N8CSv+NwxQHf0M4mQDsyGZLQFG+np3gQzA6LjhKZkWEF1ns5BcDR9k
 ksm+1FjXyc5gC7thWTuhoBrcpUsXHaLE8x/TAhaC8v3f4+97l6fq5YZreq4k8iatEah8
 L1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754405092; x=1755009892;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SXPLgL0+Hf2xuR7ZXEYw/qGxcOyYWLJUSrNpVY2eOTI=;
 b=oAcqzyOepYxAZ9MW+fN/ZbcxfgPYtDNQO+Ag56tnx65fX+6wyv7XErun82ZKYbkb2i
 S8dAQGQHbpIHiOoi1+Hso62x/p1O1hEVPBsOmzDEJ5CmDtpb6BcmAOL+EhPvT7xCtd0D
 ilC6ViBTKTD42FS4SiverXXHaOkHf22UDGpOjEPUXISNJWaVizG71g1+JIiYgp0xPDGo
 byG5x+fkv89eyVquuFmvQUPh50FJUYr2RvDkvKVniHgKGw94o31kCOZFonCU1vCk7RZa
 yywcPqo04O3Y9fjRlamYJ5nvR2wyYHPiXSdhi7W/8NDvRFU9pD1tmqCAT/BoaZksBUth
 +bXw==
X-Gm-Message-State: AOJu0Yx1Ak79DkTiqTg27SXZI2mKLBcoVK1zPcqdy4wVbNTj+26ih2TE
 unL2IIbJ/upIAgFA/UkqzK7ZVPvFN5acJkWxsgRM83foncPO+FazxOYt4aPWLk11KXCaXNitvek
 97Ck/hHbDASsGdAMdhJuIVHfvYMzhfmtcHE0bywVCStnes95t/ZcIx0E=
X-Gm-Gg: ASbGncuKqoRM7HYi0O/FyMyAnJ9GO/5N8ES5Y5x1nqpGtJLFwMI0/SNgwqfnxXfi87I
 ZgPEHC5ocfeSK4WbpPR0hh5hfe6l9tOcfpIHa/Eg9Awu7FCqR3l6GcxnEtguFEBMcnwHJZJgycO
 C8/qQW6grVFglhc/KfyXdHi7ptBX0PG7WJbbpcbkDVrZPGV4yP8l8jhc0wYGrRY7s8DrlwGSomZ
 GSwXbFzjgXQB488hlY=
X-Google-Smtp-Source: AGHT+IEFBnQQcQCF29r2aVae8u91yc2wu1YHtuXitS8ScbWxS7fbP++6UxbIFA3b66TlOv+V/GHc+0INZIW2RSwdyh8=
X-Received: by 2002:a05:620a:a01a:b0:7e0:2c05:6ba1 with SMTP id
 af79cd13be357-7e695e8a0d7mr1805824785a.0.1754398143441; Tue, 05 Aug 2025
 05:49:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250805094012.2268436-1-tomas.alvarez-vanoli@hitachienergy.com>
 <CADg8p966M2Ym3L0ZPLMiuMMQq6=D2MrvFd0WdrZkTzUJVvUnRQ@mail.gmail.com>
 <DB9PR06MB7849F1DFD6B6D9956A8FD66FC222A@DB9PR06MB7849.eurprd06.prod.outlook.com>
 <CADg8p940FJoAOWQ3L5nRCZDhaSp_C-PdQbuh1XoT9RjfrizyWw@mail.gmail.com>
 <DB9PR06MB78496FE3E20E12819419D195C222A@DB9PR06MB7849.eurprd06.prod.outlook.com>
 <CADg8p97w3vAkvOPp2=OCXrZ5qS8iDDtT0EJ-0iNO-k3LEXMrCQ@mail.gmail.com>
 <DB9PR06MB78490807DEBB894CC3EDE4ACC222A@DB9PR06MB7849.eurprd06.prod.outlook.com>
In-Reply-To: <DB9PR06MB78490807DEBB894CC3EDE4ACC222A@DB9PR06MB7849.eurprd06.prod.outlook.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 5 Aug 2025 18:18:52 +0530
X-Gm-Features: Ac12FXxLxn1rtFnpGwzyxv_4ioPtYZvnaJBN9FLIQwkN-oXbq9RkpHZnQdYmCmQ
Message-ID: <CADg8p94jcSeOPP9dmPLM=-=Mdd8wd6NRFBvTi2Wn60O=38unMA@mail.gmail.com>
Subject: Re: [RFC 0/1] use lmb to calculate ram left for the kernel
To: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "trini@konsulko.com" <trini@konsulko.com>
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

On Tue, 5 Aug 2025 at 17:57, Tomas Alvarez Vanoli
<tomas.alvarez-vanoli@hitachienergy.com> wrote:
>
> >Okay, I see. Given that we now have a global memory map for lmb, I don't=
 think that using lmb functionality is the best way of computing the amount=
 of memory that would be available for the kernel to use.
> >Please note that with a global and persistent memory map of lmb, there i=
s no guarantee as to where the first chunk of used memory lie above your ro=
otfs memory. Earlier, I think this was fine as the lmb memory map was local=
, so you could copy the ramfs to some low memory region, and then show the =
rest of memory as available in the lmb memory map.
>
> I am not sure I understand what you mean with "there is no guarantee as t=
o where the first chunk of used memory lie above your rootfs memory".
> How is it different to when it was local?

Earlier, with a local lmb map, one could define a map inside a
function, with available memory and used memory which could be
controlled inside some function. This is no longer possible. There
could be an allocation that could have happened above the rootfs
memory, which would mean that the free memory computation would be
non-deterministic. So with a global and persistent lmb memory map,
this is no longer a robust way to compute memory available for the
kernel.

As an aside, I am not sure if you have considered using the UEFI
interfaces for booting the kernel. The EFI firmware (U-Boot in this
case) passes a memory map to the kernel which specifies which memory
the kernel can use, and which is reserved. Booting the kernel with EFI
interfaces, the memory occupied by the ramfs can then be marked as
EfiReservedMemoryType, and this would not be used by the kernel. This
definitely can be done on armv8 platforms -- I have not booted a
kernel with EFI interfaces on armv7 boards though. Something to
consider for your solution.

-sughosh

>
>
> >That might no longer be the case. So this computation of memory availabl=
e for the kernel will have to be re-designed. I think instead of relying on=
 the lmb memory map for your computations, there should be some fixed memor=
y region where the ramfs would have to be copied, and then the rest of the =
memory can be considered as safe for the kernel to use.
>
> >Btw, I tried looking for the function that you are changing in your boar=
d file in the patch, but I do not see it in the upstream U-Boot.
>
> It's not mainlined yet, here's the full function with the patch applied:
>
> ```c
> static int do_calc_ramfs_addr(struct cmd_tbl *cmdtp, int flag, int argc,
>         char *const argv[]) {
>         ulong size =3D 0;
>         if(strict_strtoul(argv[1], 16, &size) !=3D 0) {
>                 printf("%s: failed to parse size arg\n", __func__);
>                 return CMD_RET_FAILURE;
>         }
>
>         phys_addr_t addr =3D lmb_alloc(size, SZ_16K);
>
>         if (addr =3D=3D 0) {
>                 printf("%s: failed to find space for rootfs in ram\n", __=
func__);
>                 return CMD_RET_FAILURE;
>         }
>
>         // calculate how much ram we can give the kernel
>         phys_size_t free =3D lmb_get_reservable_size(CFG_SYS_SDRAM_BASE) =
& ~(SZ_16K - 1);
>         if (free <=3D 0) {
>                 printf("%s: failed to calculate free memory for kernel\n"=
, __func__);
>                 return CMD_RET_FAILURE;
>         }
>
>         /* We dont reserve the memory for the rootfs, because tftp needs =
to write it.
>          * because of that, we check here if the kernel memory overlaps i=
t or not.
>          */
>         if (CFG_SYS_SDRAM_BASE + free > addr) {
>                 free =3D (addr - CFG_SYS_SDRAM_BASE) & ~(SZ_16K - 1);
>         }
>
>         char envval[20];
>         sprintf(envval, "%pa", &addr);
>         env_set("rootfsaddr", envval);
>         sprintf(envval, "%pa", &free);
>         env_set("kernelmem", envval);
>
>         return 0;
> }
> ```
