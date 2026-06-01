Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18093CD6E55
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 14:54:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89A31848BB;
	Mon,  1 Jun 2026 16:54:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IgxtDjl6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93D90848C5; Mon,  1 Jun 2026 16:54:43 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A0B1848B9
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 16:54:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-68c32f3c6d6so3709178a12.3
 for <u-boot@lists.denx.de>; Mon, 01 Jun 2026 07:54:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780325681; cv=none;
 d=google.com; s=arc-20240605;
 b=OP4BfgRCTN9LK1aAAmpxxqb3njzP8p0F7zsLc/+SSwG7Yl0LaFcpze1vEUNA2MwDp0
 07w0cgDpRwnimo46LcLC6Avf1gukYH08eeHuy6aZVugUFR/jkG0hFNS+wSPdoG+bAygn
 suSCxBH4Sb9dnR5FKdZizhTowBmjKpiMtHrFdYn9o5HSZY2sEB5ngLzYV5mSMo9VCaP1
 UViNVRCY4l07wedtCrXP25z+DhIr9CMnilLhtH709r0oAgf+2AJlcYZz2hP5jrNjMEJd
 65WnEhSeOcNLFGKXPFkjfwBlxqnL8cB1Obbwrfa+Y8BJKQuNZnGhv4Ev++48RdxU48Qo
 YCVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=cPOiK+j2YLZyZWJ2sS2+5a/CE8MJQWZ7BfOUqgkabFU=;
 fh=DYMU3dRED0rmVKTDqXRHxrZw93vonVJHh6vC8tHyRiY=;
 b=SyeNbmTwfBkuhcs0w0RtZXDYpbrmhB/xrY+BvHkHN+nHfO06yYn71jM7dYcCTZhDuC
 zECOnUTEoqj/9UOFPALQ0FFarZRZXw5jf+DqU8kblwCoytFnzzzIE9ba4YM8aAgJ/334
 NTEfC4hKhDFXOMyaIvNXAyqUw5A/0BCYtcrPEubbuH1UEDp7F84gOj8rBIeJIdBFJXXE
 li/2Rf6hLl6aHHvuMpqqAip7H7uvIecTxRQzR0gWr7/WvgUm06uZcMenRmDkXq7KW5k8
 pj7Cg/ooiXL0+ZDteDudd9j8Xfnr8H4z9N62jcZMQpOlGgKbeofxHVgoBTb68UjI8NGL
 yR8g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780325681; x=1780930481; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cPOiK+j2YLZyZWJ2sS2+5a/CE8MJQWZ7BfOUqgkabFU=;
 b=IgxtDjl6m5dTOZsoQMH8v0OkuQKT7mUUZj0kTblxrJzHMnQNcbmwmYIJyHaViZgS81
 lFm5fKyBH8NemOVvBNoHB3ywlNAQlNwZFh9xtnGxwRZY+2COKhySJV1WQqgYjZGudTcB
 KnTBad4bux8xVfvc9ZFvsxAhHcE7I1LBsXlCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780325681; x=1780930481;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cPOiK+j2YLZyZWJ2sS2+5a/CE8MJQWZ7BfOUqgkabFU=;
 b=GgwHA6mN/pyAUdJ0ltP6nAFZRdKvq+pp81izt3uUlScwmh4QmqyTDNR981482CtQCP
 jXk26WaQntjqSC4W/ybE42p1FbvX4nvqCHwcWECp9OEEDRYsCFwsJiIq0bupk9PCtK2D
 dKiDf8HhuSsYdYeHJBhSwVw1laVlj4FDCMI0TdmGoFTvkSxji1MJGtknJMGe/lZufeOY
 ne+dvBO+/5jVs/H2Gm1AP+VLgG4sc+hHR38J+5yCDKJdH5XFVvQEayCY1hkxVaqQJ5xS
 UI1/0ycAKJUmt+U+lC4NkvVf1PvPzaCIr0QPPlWm3q7ma5shc9ZGSU+t6TkPh3B0/vCn
 m0kA==
X-Gm-Message-State: AOJu0YyLCLfc1G9x1o6fuyMWGcwqhnuO0SvODlQDX2NvwJPQfWF9l/85
 hbbPu0oeioK3M05mTXhrDUb/O8XQh31dk8q35pPYu8seE3Snvjnz/t7CmWWlebNSV1YxF7tgOnb
 7l1cNc4PisnYjN9oFZ/iHBrOrJT/4DZBGiI+kUUzM1PrtS/v9n2o=
X-Gm-Gg: Acq92OGd5ZvFmE02k0HoVFHWNwcEYyzkh+61Xovj2+dqQvASu7BBrnHVyazS0U46eQd
 gfNUoxNygjl/baH4fqki39H28QSAuGYmicXijeTorOiG90GU01OyTemQjGNJGjkkMsp+BR74wZP
 JY++nooGJpWxHK4d8NMGKQqbtxW0z9xXMY/4zJ3n4m5MdNkwWckf1MxXCvRRmMXpmmYsZqrLBhd
 27d/4jnbFBXNsrKK2a86ofnCRMCbN9f6HkylT7BPStFNrauyFvwuWZ+jRLLNmcZRcwWPnbCfdhv
 VodDgM+sS2mLse4v
X-Received: by 2002:a17:907:1dc4:b0:bab:ba5a:fcb8 with SMTP id
 a640c23a62f3a-beab78b54edmr436844166b.32.1780325680627; Mon, 01 Jun 2026
 07:54:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260529034839.2075806-1-dmukhin@ford.com>
 <20260529034839.2075806-3-dmukhin@ford.com>
In-Reply-To: <20260529034839.2075806-3-dmukhin@ford.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 1 Jun 2026 08:54:25 -0600
X-Gm-Features: AVHnY4LzLIVlfs0mdaN5WCoYlfRTAN7DChNSMY_iZYxAuZOg6Y82axt6tF5IUIw
Message-ID: <CAFLszTgsoLcMuhy6qQQKhwQOpWxhpF6VJiYCFt8Nh=Vs7drhkg@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] reset: Add explicit cold reset support
To: dmukhin@ford.com
Cc: u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com
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

Hi Denis,

On 2026-05-29T03:48:33, None <dmukhin@ford.com> wrote:
> reset: Add explicit cold reset support
>
> Some prototype boards default to a non-cold reset type, e.g. warm reset.
>
> Add reset -c so users can excplicitly request a cold reset when needed.
>
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
>
> cmd/boot.c                         |  3 ++-
>  drivers/sysreset/sysreset-uclass.c | 13 +++++++++++--
>  2 files changed, 13 insertions(+), 3 deletions(-)

> diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
> @@ -174,8 +174,17 @@ int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>       if (argc > 2)
>               return CMD_RET_USAGE;
>
> -     if (argc == 2 && argv[1][0] == '-' && argv[1][1] == 'w') {
> -             reset_type = SYSRESET_WARM;
> +     if (argc == 2 && argv[1][0] == '-') {
> +             switch (argv[1][1]) {
> +             case 'c':
> +                     reset_type = SYSRESET_COLD;
> +                     break;
> +             case 'w':
> +                     reset_type = SYSRESET_WARM;
> +                     break;
> +             default:
> +                     return CMD_RET_USAGE;
> +             }
>       }

This regresses reset -edl on Qualcomm. Previously, an unknown -x
argument fell through to the SYSRESET_CMD_RESET_ARGS path, where
qcom_psci_sysreset_request_arg() picks up -edl and returns
-EINPROGRESS. With this change, argv[1][1] == 'e' hits the default
branch and bails out with CMD_RET_USAGE before sysreset_walk_arg()
runs, so reset -edl no longer works.

Please leave reset_type at its default for unrecognised flags (so the
arg-dispatch path can still claim them), or call sysreset_walk_arg()
first and only complain if nothing handled the argument. Also,
matching only argv[1][1] means reset -cx silently behaves like reset
-c - please tighten with strcmp() or a length check.

The could be a good usage for getopt() but sadly it increases code
size too much [1]

BTW -edl doesn't follow the normal flags approach, so we should
probably change that at some point.

> diff --git a/cmd/boot.c b/cmd/boot.c
> @@ -59,10 +59,11 @@ U_BOOT_CMD(
>  U_BOOT_CMD(
>       reset, 2, 0,    do_reset,
>       "Perform RESET of the CPU",
> -     "- cold boot without level specifier\n"
> +     "- reset without level specifier\n"
>  #ifdef CONFIG_SYSRESET_QCOM_PSCI
>       "reset -edl - Boot to Emergency DownLoad mode\n"
>  #endif
> +     "reset -c - cold reset if implemented\n"
>       "reset -w - warm reset if implemented"
>  );

The '- reset without level specifier' line reads oddly now that the
level is no longer guaranteed to be cold - perhaps '- reset using the
configured default type'.

> Add reset -c so users can excplicitly request a cold reset when needed.

Typo: excplicitly -> explicitly. Also please use single quotes around
tokens like 'reset -c' per U-Boot convention.

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/cover/20260519233207.2765755-1-sjg@chromium.org/
