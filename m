Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A608C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 07:12:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2C648897D;
	Tue, 16 Jul 2024 09:12:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="0hKSlW3Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B9618897E; Tue, 16 Jul 2024 09:12:29 +0200 (CEST)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 563908897B
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 09:12:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e04196b7603so5216806276.0
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 00:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1721113946; x=1721718746;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xMcOmAdm8Fw6EeQ7RjuUmZYmo6hFIlX3YVbvH9mkau8=;
 b=0hKSlW3ZwQ88P1CQ8QTjFEULkRcZIAGzWYVPkSAru172G635GOc+rU6MbGgNwjVZ3G
 EeB5XfIb04PI4WskrqMdcBc/+Zm5n6YMd5nQ+Ap9MepF5RmxQEAiiaCjofAtIPznUoNM
 Kx0PWfNaMeg87bDVBfGSjYngcxggx3f1JPz81k7Xu63AYjcBt/rFi7zmsZyrBii8YKH9
 ce6ziLHEUOAauynJIz9LYwrQ2PjrCx7/mFXP4f2gRDwdydvInTwu9poKDAsqJXplDtOu
 +95yUGbQ2jJF86awn0pHfmR3hTCAkgt7pKXToeYVBjNLD8pt4L3x2rYWKRXOJpW+1u5W
 D9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721113946; x=1721718746;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xMcOmAdm8Fw6EeQ7RjuUmZYmo6hFIlX3YVbvH9mkau8=;
 b=A2w9EIPWQduaygWm9N5ymvgFqXPyF+1i9ww2ToNDSKr3cyjl+6+5D5binB4aUT9E/T
 bVa2GPiP/Kb9HoFHP+7TelDAaQjnIyW24737giIBdOXK+gw+CHjEHpVu29ZFZH4iIeQg
 3Uj1GaL5Fd+KhylY6klu0fcgQF0sKx8jtm6s49v0tB29q0b/W1p6xfWt+qvBmxQkx+S2
 4UB94+ZciKdDBBc3pXhx4mU93+SEjfU133Lk6RGS0YDa33fUvMPQk+geW+SQF9/VQ2i8
 IXMQhdbBWT7ARJwTR4oYu5MhM97NyIWFn1WRy0e9ZPf+JW3AK2W6z7o5zncB9LFuKUSq
 s3Qw==
X-Gm-Message-State: AOJu0YzRRdZcQOsjktoW3G4GE7Acg5jYMqdLHimGq83H0CUFBb5za2rJ
 4NCa5SekDzlu1fq9N+HzXr8xZY0OHLTwgKwMBOqsAJT0/bkxMqrxHDxa/2LEHjthEHBPp5upF3+
 XoWHwzq38svtFO+zMLpXBT6tcP9IdPnGyI4LEFKhue6DdMPbVIw==
X-Google-Smtp-Source: AGHT+IE3gR4VbanWduQSge1tQnSdy6pSwqfmd/jsPWL1lCrwLWXtllqRswLDE6FeKSS+6Y0vFgQPgmem6qyzPE4b2Gk=
X-Received: by 2002:a05:6902:1142:b0:e05:6817:63d3 with SMTP id
 3f1490d57ef6-e05d57bded4mr1579651276.43.1721113946052; Tue, 16 Jul 2024
 00:12:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
 <20240713132021.57650-33-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240713132021.57650-33-marek.vasut+renesas@mailbox.org>
From: Michal Simek <monstr@monstr.eu>
Date: Tue, 16 Jul 2024 09:12:14 +0200
Message-ID: <CAHTX3d+bGJZnQ5mJboZX0eUOZ4PBdD1AARxm5hz=HkkV3khFKA@mail.gmail.com>
Subject: Re: [PATCH 33/45] microblaze: Remove duplicate newlines
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
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

so 13. 7. 2024 v 15:26 odes=C3=ADlatel Marek Vasut
<marek.vasut+renesas@mailbox.org> napsal:
>
> Drop all duplicate newlines. No functional change.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
> Cc: Sean Anderson <seanga2@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  arch/microblaze/include/asm/bitops.h      | 2 --
>  arch/microblaze/include/asm/posix_types.h | 2 --
>  arch/microblaze/include/asm/ptrace.h      | 4 ----
>  arch/microblaze/include/asm/system.h      | 1 -
>  4 files changed, 9 deletions(-)
>
> diff --git a/arch/microblaze/include/asm/bitops.h b/arch/microblaze/inclu=
de/asm/bitops.h
> index 2cab2ac62b9..9ea217cd854 100644
> --- a/arch/microblaze/include/asm/bitops.h
> +++ b/arch/microblaze/include/asm/bitops.h
> @@ -32,7 +32,6 @@ static inline unsigned long ffz(unsigned long word)
>         return result;
>  }
>
> -
>  static inline void set_bit(int nr, volatile void *addr)
>  {
>         int     * a =3D (int *) addr;
> @@ -257,7 +256,6 @@ found_middle:
>  #define hweight16(x) generic_hweight16(x)
>  #define hweight8(x) generic_hweight8(x)
>
> -
>  static inline int ext2_set_bit(int nr, volatile void *addr)
>  {
>         int             mask, retval;
> diff --git a/arch/microblaze/include/asm/posix_types.h b/arch/microblaze/=
include/asm/posix_types.h
> index ccc6235c8d9..f4795f8d317 100644
> --- a/arch/microblaze/include/asm/posix_types.h
> +++ b/arch/microblaze/include/asm/posix_types.h
> @@ -47,7 +47,6 @@ typedef unsigned int  __kernel_gid32_t;
>  typedef unsigned short __kernel_old_uid_t;
>  typedef unsigned short __kernel_old_gid_t;
>
> -
>  typedef struct {
>  #if defined(__KERNEL__) || defined(__USE_ALL)
>         int     val[2];
> @@ -56,7 +55,6 @@ typedef struct {
>  #endif /* !defined(__KERNEL__) && !defined(__USE_ALL) */
>  } __kernel_fsid_t;
>
> -
>  #if defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2)
>
>  #undef __FD_SET
> diff --git a/arch/microblaze/include/asm/ptrace.h b/arch/microblaze/inclu=
de/asm/ptrace.h
> index b796d4faf6b..ff861d10bb4 100644
> --- a/arch/microblaze/include/asm/ptrace.h
> +++ b/arch/microblaze/include/asm/ptrace.h
> @@ -16,7 +16,6 @@
>  #ifndef __MICROBLAZE_PTRACE_H__
>  #define __MICROBLAZE_PTRACE_H__
>
> -
>  /* Microblaze general purpose registers with special meanings.  */
>  #define GPR_ZERO       0       /* constant zero */
>  #define GPR_ASM                18      /* reserved for assembler */
> @@ -54,7 +53,6 @@
>  #define SR_DIR         21
>  #define SR_ASID                23
>
> -
>  #ifndef __ASSEMBLY__
>
>  typedef unsigned long microblaze_reg_t;
> @@ -74,7 +72,6 @@ struct pt_regs
>         microblaze_reg_t single_step;   /* 1 if in single step mode */
>  };
>
> -
>  #define instruction_pointer(regs)      ((regs)->pc)
>  #define user_mode(regs)                        (!(regs)->kernel_mode)
>
> @@ -87,7 +84,6 @@ struct pt_regs
>
>  #endif /* !__ASSEMBLY__ */
>
> -
>  /* The number of bytes used to store each register.  */
>  #define _PT_REG_SIZE   4
>
> diff --git a/arch/microblaze/include/asm/system.h b/arch/microblaze/inclu=
de/asm/system.h
> index 050a8b40763..4e31206436d 100644
> --- a/arch/microblaze/include/asm/system.h
> +++ b/arch/microblaze/include/asm/system.h
> @@ -40,7 +40,6 @@ extern void *switch_thread (struct thread_struct *last,
>         }                                                               \
>  } while (0)
>
> -
>  /* Enable/disable interrupts.  */
>  #define __sti() \
>  {                                                              \
> --
> 2.43.0
>

Reviewed-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
