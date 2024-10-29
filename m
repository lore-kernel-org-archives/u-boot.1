Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4519FD2AB11
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 10:00:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B00A2890AE;
	Tue, 29 Oct 2024 11:00:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="t9sUluN+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FB9B89070; Tue, 29 Oct 2024 10:59:59 +0100 (CET)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4326089070
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 10:59:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-71e49ef3bb9so3656597b3a.1
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 02:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730195996; x=1730800796; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5pHd7WeiFnbRauYnRuFZFp53UmVlXnyb0vbM5zmk8Nc=;
 b=t9sUluN+A4n3rVxjpXjBnrYZlL0MeTHOFhpqZ3bJIELfHddEYipZUAYKFQYxu7+T2I
 hqdxJAGdPBMZmiuN078pvPAECnpa7bRJmus0t0mRaklqyfJcUo4o/k2zJ7qWvD/PFb6c
 nmt1y4qKytN+g0FfAVr19BImO2e0YyaRqQz5q1Ra+/ZC43pJXpuXIPu3aBDXIk1cmf2R
 cqkn6IFKDbdOvURBCX8THpEVEDkfkvyGWguwRev77dGeib2ZWyZfZoXzw8T8w1USyCxc
 NxYotBMsT4K6jmivF2XTxCQeu8emrFFSe8yjmjHZ9mUljgfY84bUZnOgIK6hcaarHxDL
 MZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730195996; x=1730800796;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5pHd7WeiFnbRauYnRuFZFp53UmVlXnyb0vbM5zmk8Nc=;
 b=OQZ2kpOjKhj0SW6HIYNeAfI1KaRTNzikekQqgwQSBw2pYxL6+/yqupm1isSKiODt0+
 1yFibmkbz3EO0bILYI48BNNgwMo5242dLgRlQBF92GZCCQ35X7+5f+SNHwjRHERk/dHA
 QqLqH2+muxp2lvoXuOXzTBJ5IXb8ez/vKcexK6yFJ2xNt+tI7kIUI1q4hNm0ud8qXODH
 D2eXsD+QdRCZojkdJDCra5uvXm3WGWEEsBS4F6GqE8Ov9nvEMkxvbq1RdOoKX44HKoln
 3GCC/gUNNgxDGmJFXsn2TxR+Xcwn+ZlXPf/FNZD9TTufGhItZfGu53a2AtVyhf8q9YWg
 XoWQ==
X-Gm-Message-State: AOJu0YwTKqxMjlxoxTb9LDM0IHYtivd/9WmuST+sPlqFaAwQdhsh/wRi
 goApY3gkGKYWEVqsbg7PcdymKIqkbet3pinGB9etpVwMXchcPXl43XicofqpWvY3F/k02W2pIzg
 5FpzThmtU8Bc2c8cmCTftPRuTQrnEglBPMSEx9g==
X-Google-Smtp-Source: AGHT+IHe1SWihZSHZH46N+ZbTSp6ifmq9ZJZtOWsGN99lmXDVE5M/d0F0ctgq4aRvFf0czwk/57L28+Lsh1kdp4QVHo=
X-Received: by 2002:a05:6a00:3c88:b0:71e:6a57:7288 with SMTP id
 d2e1a72fcca58-72096bbb3a9mr2329771b3a.5.1730195995665; Tue, 29 Oct 2024
 02:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <20241028124815.47262-1-sjg@chromium.org>
 <20241028124815.47262-7-sjg@chromium.org>
In-Reply-To: <20241028124815.47262-7-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 29 Oct 2024 11:59:19 +0200
Message-ID: <CAC_iWjKx_r0TjdehHU+y7sJe3J+qGSs8FnXAbqXpCyyXcA0V2w@mail.gmail.com>
Subject: Re: [PATCH 06/15] sandbox: Add a way to show the sandbox
 memory-mapping
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Simon

This seems completely unrelated to the series.

Please send it as a separate patch

Thanks
/Ilias

On Mon, 28 Oct 2024 at 14:48, Simon Glass <sjg@chromium.org> wrote:
>
> This is mostly hidden in the background, but it is sometimes useful to
> look at it. Add a function to allow this.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  arch/sandbox/cpu/cpu.c         | 13 +++++++++++++
>  arch/sandbox/include/asm/cpu.h |  3 +++
>  cmd/sb.c                       | 11 +++++++++++
>  doc/usage/cmd/sb.rst           | 25 +++++++++++++++++++++++++
>  4 files changed, 52 insertions(+)
>
> diff --git a/arch/sandbox/cpu/cpu.c b/arch/sandbox/cpu/cpu.c
> index 06f8c13fab9..d1c4dcf0764 100644
> --- a/arch/sandbox/cpu/cpu.c
> +++ b/arch/sandbox/cpu/cpu.c
> @@ -253,6 +253,19 @@ phys_addr_t map_to_sysmem(const void *ptr)
>         return mentry->tag;
>  }
>
> +void sandbox_map_list(void)
> +{
> +       struct sandbox_mapmem_entry *mentry;
> +       struct sandbox_state *state = state_get_current();
> +
> +       printf("Sandbox memory-mapping\n");
> +       printf("%8s  %16s  %6s\n", "Addr", "Mapping", "Refcnt");
> +       list_for_each_entry(mentry, &state->mapmem_head, sibling_node) {
> +               printf("%8lx  %p  %6d\n", mentry->tag, mentry->ptr,
> +                      mentry->refcnt);
> +       }
> +}
> +
>  unsigned long sandbox_read(const void *addr, enum sandboxio_size_t size)
>  {
>         struct sandbox_state *state = state_get_current();
> diff --git a/arch/sandbox/include/asm/cpu.h b/arch/sandbox/include/asm/cpu.h
> index c97ac7ba95b..682bb3376d1 100644
> --- a/arch/sandbox/include/asm/cpu.h
> +++ b/arch/sandbox/include/asm/cpu.h
> @@ -8,4 +8,7 @@
>
>  void cpu_sandbox_set_current(const char *name);
>
> +/* show the mapping of sandbox addresses to pointers */
> +void sandbox_map_list(void);
> +
>  #endif /* __SANDBOX_CPU_H */
> diff --git a/cmd/sb.c b/cmd/sb.c
> index 9dbb53275b3..9245052492e 100644
> --- a/cmd/sb.c
> +++ b/cmd/sb.c
> @@ -7,6 +7,7 @@
>  #include <command.h>
>  #include <dm.h>
>  #include <spl.h>
> +#include <asm/cpu.h>
>  #include <asm/global_data.h>
>  #include <asm/state.h>
>
> @@ -29,6 +30,14 @@ static int do_sb_handoff(struct cmd_tbl *cmdtp, int flag, int argc,
>  #endif
>  }
>
> +static int do_sb_map(struct cmd_tbl *cmdtp, int flag, int argc,
> +                    char *const argv[])
> +{
> +       sandbox_map_list();
> +
> +       return 0;
> +}
> +
>  static int do_sb_state(struct cmd_tbl *cmdtp, int flag, int argc,
>                        char *const argv[])
>  {
> @@ -42,8 +51,10 @@ static int do_sb_state(struct cmd_tbl *cmdtp, int flag, int argc,
>
>  U_BOOT_LONGHELP(sb,
>         "handoff     - Show handoff data received from SPL\n"
> +       "sb map         - Show mapped memory\n"
>         "sb state       - Show sandbox state");
>
>  U_BOOT_CMD_WITH_SUBCMDS(sb, "Sandbox status commands", sb_help_text,
>         U_BOOT_SUBCMD_MKENT(handoff, 1, 1, do_sb_handoff),
> +       U_BOOT_SUBCMD_MKENT(map, 1, 1, do_sb_map),
>         U_BOOT_SUBCMD_MKENT(state, 1, 1, do_sb_state));
> diff --git a/doc/usage/cmd/sb.rst b/doc/usage/cmd/sb.rst
> index 6f54f9d9eb7..37431aff7c8 100644
> --- a/doc/usage/cmd/sb.rst
> +++ b/doc/usage/cmd/sb.rst
> @@ -12,6 +12,7 @@ Synopsis
>  ::
>
>      sb handoff
> +    sb map
>      sb state
>
>  Description
> @@ -26,6 +27,24 @@ sb handoff
>  This shows information about any handoff information received from SPL. If
>  U-Boot is started from an SPL build, it shows a valid magic number.
>
> +sb map
> +~~~~~~
> +
> +This shows any mappings between sandbox's emulated RAM and the underlying host
> +address-space.
> +
> +Fields shown are:
> +
> +Addr
> +    Address in emulated RAM
> +
> +Mapping
> +    Equivalent address in the host address-space. While sandbox requests address
> +    ``0x10000000`` from the OS, this is not always available.
> +
> +Refcnt
> +    Shows the number of references to this mapping.
> +
>  sb state
>  ~~~~~~~~
>
> @@ -42,6 +61,12 @@ as ``sandbox_spl``::
>      => sb handoff
>      SPL handoff magic 14f93c7b
>
> +This shows output from the *sb map* subcommand, with a single mapping::
> +
> +    Sandbox memory-mapping
> +        Addr           Mapping  Refcnt
> +    ff000000  000056185b46d6d0       2
> +
>  This shows output from the *sb state* subcommand::
>
>      => sb state
> --
> 2.43.0
>
