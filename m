Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1BF4CDB46B
	for <u-boot@archiver.kernel.org>; Sat, 20 Jun 2026 16:19:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37521849AA;
	Sat, 20 Jun 2026 18:19:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NgfmAOj8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3F43848EB; Sat, 20 Jun 2026 17:07:48 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F4E484873
 for <u-boot@lists.denx.de>; Sat, 20 Jun 2026 17:07:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=qstrydom0@gmail.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-7fdb04d774aso33329307b3.2
 for <u-boot@lists.denx.de>; Sat, 20 Jun 2026 08:07:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781968065; cv=none;
 d=google.com; s=arc-20240605;
 b=Q3px3XZr2d/+RaXZLK/ZGmgljygPDlY7U/CGaT2CTHzxD11VjQ7ILdu+elXn/hZsWS
 psrp4nQue7tPeu4M6QNnZSwm2U8kJmplypQqVb/ryq5ZxnYUHlcw9wYpLchztkacRGgJ
 Fmv8MkSlFsA1P+kNjS2ngTehyAxWMVLiueQ7bgIhzwCsgrjyeJkYA2gyr4jbMUtgDDKn
 Nfq/AE/Y0/tSkKlkRQld517TCD8hqT15LjGMNc5szU1QpLeY0quoBojxZCChR5r8rM+2
 PGfK/RaOEjz2uQb36HR2uK6ll3ekCJbPlKHoczjdZww4q4BxCn9C+xrD2pmVtHMVJaTt
 So7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=HhYQPAWy1p6ateOPl4Quv4t5ZOMNWu6ragQcNlh6JDE=;
 fh=Zbum+Bxm3UjiJUzzbSelwfpZPsAlW7FfnsL/KSbQFWE=;
 b=de1d2Sxaktk7YOOyk/WheVYubJ9JuWv10MMQu7qlVUtdt/fwoJUaeSTphBCYFX1WPk
 7aJlt70UJGkSAVAsYQM9VlmlgbSiDqaThXAHwvnW7vVDOHYJ0onWTEDOgALAq/WHMq8f
 t3MtjXki0Dr8OGMt6+xVZc6uGhndl1TCarqH13D74WXilBoQ9naiDKhxTXJIy3JN/dfi
 dUTEEtpk4tRsn0QnQzDCy30bZ2xJ4jtqoQihSvRC9U35hAVMBNINd8DwUmZyoF6vfWjJ
 KTt5MWFoRtwsl/U9e3JX9h5g7Lgsu//Udv0eMxbteZMVRENdlS2u3K0ov4mNgA9DQIIT
 kteQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781968065; x=1782572865; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HhYQPAWy1p6ateOPl4Quv4t5ZOMNWu6ragQcNlh6JDE=;
 b=NgfmAOj8YoAmvAciTHfBG47ANd6YjofQv1nTsbuuuUrmb1YMTgKWnA135wF5LGkXyP
 zuwrZaM8b8xEazDdFKSdH9KMYt7nYTHCHWVumv51aiTLw9Az4Vua9gwqPRMJv1OGKTir
 G6Ih35aQJxGE0n+OmpVhqyGxMvN0NBa8nGzgFfuyQW8+ToLVbWzxFeBrIR5wnqYiGAYk
 OIsnGvnWNSbljWnvM05CVsaGQhEJ8dStaHSbGdAuGpeQK5eISqGBBh9jjG/ywUkxUXaO
 O0ZCIldIIzAzRIS0RN2IN63GcpyPfreaZPzf724n+LNTc4zbVPDG+AUN2WyPabs1YLcV
 t6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781968065; x=1782572865;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HhYQPAWy1p6ateOPl4Quv4t5ZOMNWu6ragQcNlh6JDE=;
 b=P9D+fSBJNbDTVmooretAcKXJ2vjRwH4aGX3n464R95BRcobQHztjoq2aTT1VvZNN59
 5KHU4fjuse5WWj414hbR7gNVOLYhkv9YrUKOeuguv3r+qB6LetDtMO5Q7uO5OB2HvJ4N
 A67k7LIoi4PfyVefNYiQLvt3nA467MQG9iz39oDBmkjsRTxhiU5UBtM/PW6ebr3IhF+M
 LmvkW7yJhn/gD1umXeEv01V0XU6OpgEHLyV+JtKXv3nqqR+a/sUK1NZ4ZHHottHOS47u
 uCy/93VUTolWPR29SQ6ATq7MgkFHnYb5dloo7qw+dGIAeDK1WHIW/pxXhIZMaW9BXc6C
 mxtg==
X-Gm-Message-State: AOJu0Yzxq0mqQ8aFabZ3z8kwzw2j654Z5H3V8ct0zntrpYjBeX04cgWY
 1qxRiMPWXez55AqqHa3+rpVS1P/OHjCflDdGXE4a5NBT8ZHnNm0BXYNdh7J7yI7RqiGJPwt6rBg
 6bK5QfVov3IgBLiuZYDNTmnekJm+7xKQ=
X-Gm-Gg: AfdE7cnT2JetYvKFL+ydjFGU+G5HCIXQsI0iW7/jNTdhjvAlx8sYpQwBnm4STHvApO0
 5r9i2WaHUn2xp5+EgcBAN7Hk2iPR75LwDqGIQ/dauACnKxuLF+0NMqJMG+8kVOX5wqOTTY8WVMA
 KseGzaSy9HG4dKB6/R62bxRitnWQlrMsti7WVztq8I1p7ThRRE62n8nUbQWZkQ4JTItImkMpCza
 WgnKQDfH5wSdHmzEJtNEIrSjvrptqcXuwajSq+86rhZzVTiOimRIXKr5yEpew/O/CDB2PNS0BqB
 8RyKhlecty84zaMaB3eufD8A5w==
X-Received: by 2002:a05:690c:d8d:b0:7f8:7e50:6390 with SMTP id
 00721157ae682-80267225da0mr36758187b3.50.1781968065200; Sat, 20 Jun 2026
 08:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260619105529.50815-1-qstrydom0@gmail.com>
 <20260619200419.GW382693@bill-the-cat>
In-Reply-To: <20260619200419.GW382693@bill-the-cat>
From: Quentin Strydom <qstrydom0@gmail.com>
Date: Sat, 20 Jun 2026 16:07:33 +0100
X-Gm-Features: AVVi8CeG2MqRvYoQmczOh8qkhPKirS3CdXQgImCN3HXQBIi0rJKkrfyK9Abi3yg
Message-ID: <CAF28xv_-OmrqKQz2Wqm9Cz=_oHSqSp4qtGR7_bxkmM2QFt4wRA@mail.gmail.com>
Subject: Re: [PATCH] spl: pad external DTB to _image_binary_end with separate
 BSS
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org, 
 james.hilliard1@gmail.com, malysagreg@gmail.com, tien.fong.chee@altera.com, 
 sughosh.ganu@arm.com, philip.molloy@analog.com
X-Mailman-Approved-At: Sat, 20 Jun 2026 18:19:37 +0200
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

Thanks, that makes sense.

Just to clarify, I reproduced and tested this with QEMU=E2=80=99s ast2600-e=
vb
machine rather than physical AST2600 hardware.

I checked the SPL section layout and I think you are right that the better
fix is in the AST2600 SPL linker script rather than in scripts/Makefile.xpl=
.

With the v1 Makefile fix reverted, the mismatch was:

sizeof(spl/u-boot-spl-nodtb.bin) =3D 0xc92c
_image_binary_end                =3D 0xc930

The last emitted section was __u_boot_list, ending at 0xc92c, while
_image_binary_end was advanced to 0xc930 by the alignment associated with
.binman_sym_table. In this build .binman_sym_table did not contribute
emitted contents, so objcopy -O binary did not include those alignment
bytes in spl/u-boot-spl-nodtb.bin.

I have tested a v2 which moves the 8-byte alignment into the emitted
__u_boot_list section. With that change:

sizeof(spl/u-boot-spl-nodtb.bin) =3D 0xc930
_image_binary_end                =3D 0xc930

The appended SPL DTB starts at 0xc930, and the external-DTB build boots
successfully under QEMU with:

qemu-system-arm -M ast2600-evb,execute-in-place=3Don,bmc-console=3Duart5 \
  -drive file=3Dflash.img,format=3Draw,if=3Dmtd -nographic

I have sent v2 with the linker-script fix.

Quentin

On Fri, Jun 19, 2026 at 9:04=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:

> On Fri, Jun 19, 2026 at 11:55:29AM +0100, Quentin Strydom wrote:
>
> > When CONFIG_SPL_SEPARATE_BSS is enabled, fdt_find_separate()
> > expects the SPL control DTB at _image_binary_end. However,
> > u-boot-spl-dtb.bin is currently generated by concatenating
> > u-boot-spl-nodtb.bin and the SPL DTB directly, without padding
> > up to _image_binary_end.
> >
> > On evb-ast2600 this places the appended SPL DTB at 0xc92c while
> > _image_binary_end is 0xc930. The SPL therefore checks four bytes
> > past the FDT header and fails early with:
> >
> >   Missing DTB
> >   No serial driver found
> >
> > Add padding between the xPL nodtb binary and the DTB when separate
> > BSS is enabled, so the DTB is placed where fdt_find_separate()
> > expects it.
> >
> > Signed-off-by: Quentin Strydom <qstrydom0@gmail.com>
>
> I'm glad someone has been able to test this on hardware now, and I'm
> sorry it wasn't fixed when dealing with the rest of the fallout here.
> I'm not sure this is quite the correct fix however as we should be
> ensuring that output file and _image_binary_end agree. What sections
> are, and aren't being included when we create the -nodtb.bin file? I
> think the place I ended up putting the '. =3D ALIGN(8)' in commit
> 8b0ebe054bb3 ("arm: Update linker scripts to ensure appended device tree
> is aligned") ended up not being correct on this platform.
>
> --
> Tom
>
