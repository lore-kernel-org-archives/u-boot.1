Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA4C0F30299
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 02:44:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8E568405E;
	Mon, 16 Mar 2026 03:44:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WWPx1Ss1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91C1084067; Mon, 16 Mar 2026 03:44:14 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D4318405B
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 03:44:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b9773abf811so376963766b.0
 for <u-boot@lists.denx.de>; Sun, 15 Mar 2026 19:44:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773629048; cv=none;
 d=google.com; s=arc-20240605;
 b=lxom9kG9u8HQLcZul4fRJmaRYbjWwDcyWr3S85GE3Fb9P18lUSaGu2J65k7RmD/xYl
 r3EhcASSldoqgDuBZobPZ91ZrrkYtEVin+nf6NymRfi7zbrWdQtpHEfT28geobDitDpd
 /BWHQ61506oHTAW18z7ry10D+KL15JjGyXUFbeOHEWfALWRugVccZO3c8Zv2oHps1YgK
 +64bNs+wA5Dtr1Q0xvINmvCV3++RW+lcxG6G3oWgYSc1/uUMrchqxqA9CFqluUpIqJkG
 ShiSONHMg39Kugg5kXzdD9pxJmPf7sSvTI0ka8vBtOTERqBqz6BDd29WFVkoPflaD0Fo
 MrYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Hg/P2Fa7PlUmFJoMnlskqX90bQufP+XPGuKEK3E01PE=;
 fh=77GWSjT2mlmLf3PtBjW8TPqEIXbpJQfI8TB2+BGo2u8=;
 b=Jo8O09Xl5+21o4gOxImgzCvnUT/5nIfz6wkx3IHtw7/tXrcEpq3m27nBka2gYhf5Kn
 UOBfKuq5nneYL/TKnCnGy7XZIBv8/2yRLL6/QbOvH81kB6+LqYblebvvc6dVEFWWevLn
 K2CcgjX1/NCI3ewWwWFp5VssXndZ7X5WE/mUsa8xGEW0x3EABYo2Abiro/jR57VeSEa2
 Qlz7X9FoUnlOcXnuRjq+wNxKuftChY2K4UKOojFrgmLvZNxo685wHfsV49uxWmfpoXYk
 L8ikvS9Rd+10UxrGnf958eMfmE15IHV6jGCIWOvpYihgeC1ljXhKpaIRjh/QVakm2+YS
 uSQQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773629048; x=1774233848; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Hg/P2Fa7PlUmFJoMnlskqX90bQufP+XPGuKEK3E01PE=;
 b=WWPx1Ss1uRqwWH4U91kBL7SAFm6ZNGpNEAdnyww52qzoENJ81N7Rankmh7FdzXniMP
 IW0ho5N795rQZ2FMlurlUbFez9MgxMMUH5HzFC8A5XvUFJGr6/X/NX0bf8x933val/Fo
 MoXRPcY4jpgBKD5ZH/sYaL+sZAqE2dL1Q9wh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773629048; x=1774233848;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hg/P2Fa7PlUmFJoMnlskqX90bQufP+XPGuKEK3E01PE=;
 b=iVtxbTRLeTf+nngN9Cxu/xQXeUKhbRnGksm8fpSETHrfTANKd64jnNPwxInFL+G6dW
 /PFtmccYEyUEy3deWgyVp4m84VWXqXyxj/L3Lj3EZBxkTcSEeq41p+8oYoRj9pjq36ea
 kTUCw92aOy1zYnqkujQxvVcuGXciXpAa7fo/xzdoOf+JsPeBfoZ/LjeK/EfrhJS5+x8D
 b71nXR6XzWy/TTTlvfdzIuJ07oNzTd4j+y4IfoQKJvRw7OH0bv4BChBuBgDzfnUyY++x
 Ou3Jc+W1FbDQV8Rtw4p5gkYrRO97LtRxN/N2EdlM7HEjc0EfjstPbGOr/VnJNfEmp0IH
 AfCg==
X-Gm-Message-State: AOJu0Ywho3YFFALPf/fKDwrXcJjBrnRdRS2n9SC/CzyAA5/F607Jjy4s
 0EcaIEX7jDv+VQLf90ZgPgMvRhdQMy9hGGh9kmwGqxKBysy6r7E9F/IAqRYHPZfwINwCthPgnBo
 1x5L4eE/vzlpjSYXsCf+NhWiI+cvNWvqytXDT5Xjdlm7hp/cwcsk=
X-Gm-Gg: ATEYQzzJdaDcRbJol6FQ5aCXQ7EFCJxnF6I9NOpURZpImj273EOkWoEGyPLe+S86W7N
 rRrtT6BEXNIaoTOW8UpgPc+c60Epp0gSLYNRG40Ysyv2qgaL5kUrcJ7gWUEboiXTPBsD6FAXcaR
 HbyHm93qRL0n2Yw+64iHGISqp2cTEPNpu2jxkIA0wNC6HxgcRf4p6ttULGhLzcqEel6Un8NAjw7
 t4Pingoqa76o+SRbaUhuGRWbFpojASBAFIdwhbGGeuqBiOJMSSvwz3/9XDJVZNeW2xsSmnGGOpl
 Io0v8TJ04lhI5e6G
X-Received: by 2002:a17:907:3d9f:b0:b97:be43:dfcd with SMTP id
 a640c23a62f3a-b97be43f53fmr70817866b.7.1773629047741; Sun, 15 Mar 2026
 19:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260311120910.3934114-1-ravi@prevas.dk>
 <20260311120910.3934114-4-ravi@prevas.dk>
In-Reply-To: <20260311120910.3934114-4-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 15 Mar 2026 20:43:54 -0600
X-Gm-Features: AaiRm53NQgDb4bi_YWeHawY8jGkPEDJYFJRaf0-Id6hs4TQkNpuQXbi2jJsJaRI
Message-ID: <CAFLszTijkvOc+OsCv0bY_7VVgBDzp+ZQx3vvBt31fC-KW6Re8g@mail.gmail.com>
Subject: Re: [PATCH 3/3] cmd: test: fix handling of single-argument form of
 test
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

Hi Rasmus,

On Wed, 11 Mar 2026 at 06:09, Rasmus Villemoes <ravi@prevas.dk> wrote:
>
> POSIX states that
>
>   0 arguments:
>       Exit false (1).
>   1 argument:
>       Exit true (0) if $1 is not null; otherwise, exit false.
>
> and at least bash and busybox sh behave that way.
>
> The current 'argc < 3' does the right thing for a non-existing or
> empty argv[1], but not for a non-empty argv[1]. Fix that and add
> corresponding test cases.
>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> ---
>  cmd/test.c     | 11 +++++++++--
>  test/hush/if.c | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+), 2 deletions(-)
>
> diff --git a/cmd/test.c b/cmd/test.c
> index f0645ef98f1..0d0f090386c 100644
> --- a/cmd/test.c
> +++ b/cmd/test.c
> @@ -71,10 +71,17 @@ static int do_test(struct cmd_tbl *cmdtp, int flag, int argc,
>                 argc--;
>         }
>
> -       /* args? */
> -       if (argc < 3)
> +       /*
> +        * Per POSIX, 'test' with 0 arguments should return 1, while
> +        * 'test <arg>' should be equivalent to 'test -n <arg>',
> +        * i.e. true if and only if <arg> is not empty.
> +        */
> +       if (argc < 2)
>                 return 1;
>
> +       if (argc == 2)
> +               return !strcmp(argv[1], "");
> +
>  #ifdef DEBUG
>         {
>                 debug("test(%d):", argc);
> diff --git a/test/hush/if.c b/test/hush/if.c
> index 148e9a53e90..e82a95aaf27 100644
> --- a/test/hush/if.c
> +++ b/test/hush/if.c
> @@ -32,6 +32,15 @@ static int hush_test_if_base(struct unit_test_state *uts)
>         sprintf(if_formatted, if_format, "false");
>         ut_asserteq(1, run_command(if_formatted, 0));

Can you use run_commandf() here?

>
> +       sprintf(if_formatted, if_format, "test");
> +       ut_asserteq(1, run_command(if_formatted, 0));
> +
> +       sprintf(if_formatted, if_format, "test ''");
> +       ut_asserteq(1, run_command(if_formatted, 0));
> +
> +       sprintf(if_formatted, if_format, "test 'abc'");
> +       ut_assertok(run_command(if_formatted, 0));
> +
>         return 0;
>  }
>  HUSH_TEST(hush_test_if_base, 0);
> @@ -343,6 +352,27 @@ static int hush_test_lbracket_alias(struct unit_test_state *uts)
>         ut_asserteq(1, run_command(if_formatted, 0));
>         ut_assert_nextline(missing_rbracket_error);
>
> +       sprintf(if_formatted, if_format, "[ ]");
> +       ut_asserteq(1, run_command(if_formatted, 0));
> +
> +       sprintf(if_formatted, if_format, "[");
> +       ut_asserteq(1, run_command(if_formatted, 0));
> +       ut_assert_nextline(missing_rbracket_error);
> +
> +       sprintf(if_formatted, if_format, "[ '' ]");
> +       ut_asserteq(1, run_command(if_formatted, 0));
> +
> +       sprintf(if_formatted, if_format, "[ ''");
> +       ut_asserteq(1, run_command(if_formatted, 0));
> +       ut_assert_nextline(missing_rbracket_error);
> +
> +       sprintf(if_formatted, if_format, "[ 'abc' ]");
> +       ut_assertok(run_command(if_formatted, 0));
> +
> +       sprintf(if_formatted, if_format, "[ 'abc'");
> +       ut_asserteq(1, run_command(if_formatted, 0));
> +       ut_assert_nextline(missing_rbracket_error);
> +
>         return 0;
>  }
>  HUSH_TEST(hush_test_lbracket_alias, UTF_CONSOLE);
> --
> 2.53.0
>

Regards,
Simon
