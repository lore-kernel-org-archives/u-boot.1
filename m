Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0149CC56208
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 13:23:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 097AD4063E;
	Thu,  6 Aug 2026 13:23:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X4geZG9Yh-Rh; Thu,  6 Aug 2026 13:23:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 03816405AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786022582;
	bh=taxpDAeKq3b14TcnrJKrHwBdmml5nLBGNuW8AUTOogQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jY6FCsqwJVuX1NQHssg7GS6e4wol+lUmgoSlOW94v3FvjvyiHE9g+KVfwtGWxYosO
	 C8h4QXrPiKBEvuhOlhRz+xjloJN8QA/DS0yEqcn7axdSl2KtPAQfQ5WOJcyY1pLR0K
	 MwBtHNvytP+xMurvZ9aPzcWPbGa/UHdV6dOl2EW2tKQw/HN0ILJZKU23wNav21Ooac
	 Tn2VbTUBX00H2qkx4qTCdc9F5m2ST/Zw8lT4TP9F+0MvM1nCtkAY5yzQ9coNA2GDpq
	 vSqBzEvABoEsUSws4lSopHmXZzsvIOWUKRv69Nt3lj7yqhiBeu8yUhki+8W0aq12uW
	 9E14WZ0Ctip9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 03816405AD;
	Thu,  6 Aug 2026 13:23:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BD0D9198
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 13:23:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A241C405AD
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 13:23:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0LLlFE3xRLhO for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 13:23:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D35C4403A9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D35C4403A9
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D35C4403A9
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 13:22:59 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-69c108fee7fso3244133a12.3
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 06:22:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786022578; cv=none;
 d=google.com; s=arc-20260327;
 b=hdE85AysNmxci53d3PdG+COAyc27fJKXjjdeON4WWepEOtSdQNCvDVVDB8E7HLLzgf
 k5lfVyiisJBc4xEyCJTImXOQcDcaL1Oj1OKY4YtlG+MQ//LhgNxLDc7O6AmkmBvzbSaD
 dk6G2ZI6gC3VtfMX2dD6axqTSjZNx6Y8dOjiRbEomV3FjdM9FQgEPJ7/czvxmSUJo7MG
 i1xZGsWlKyjyiABPzDKN6a6/25Oe0AzwAXCvyz2kTuoFBpOY+rpyKq8VkNKCNXsTxugU
 Oy0JDBDjQpZ7XuFnDLbep5NBsBF67SSXos7/zB88GB1CPUo15NMNGR7uUllCDzd8gPU9
 pRaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=taxpDAeKq3b14TcnrJKrHwBdmml5nLBGNuW8AUTOogQ=;
 fh=7xxvTH2sQtJt5Ay+3iwadnldSn0Fw9o87gYzUPDaOIA=;
 b=H8/SykpRJY9Nhvo4Zq7Lw9waiBW0L/1/sg0KK81DlE4GNvOAwze4LPjLYxEv+VY7vo
 aCDYlx6rVPUFExjtyo4lPXCwd9c366/pNQ3M29n56KEonKqNWps5tDzu3SvZFoHx0H5Y
 /bP/C7vVMsOKq0jw+ghAchbceeqimBm47x2UxHAk2HiCh406VzTB0RVypXsk3HxJnJsg
 BF5rzbO+s1977y9tLYHbAMW0sS6dITQPWIPEG5MyT/PKJn7Gwhi5abGJ3olppJx/cUKU
 QUVR0Nw/7xnwB7TOFqfYrF7TYMlw/S6qf7AP+298fPH2CSr54LxEPzOy37AWCOhOk8Qs
 4xrA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786022578; x=1786627378;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=taxpDAeKq3b14TcnrJKrHwBdmml5nLBGNuW8AUTOogQ=;
 b=OPvfd6OTGyeZK2okwdD5dPjE+MI2svJmoIEtTjEdUVKKUY4wqMx4TB7Xa6erQeoBW2
 uiXPkX2K6Ojn0pOAJyQ3Hx0CXXABG3X8XWLdM9zSIiNAfi9v6B2al8LsoCc26VnJCZpS
 NI9RWEQfLTFztcL+s2arcdnxIIiGUeWvG8hchzNaoVKW7b0QwFhzErqjkSy6hgfrmlMY
 jT2v3cfb+QOH8n8sHnGWf35HiTzmT+8fV6A4Mx+lY/FXsKeL6uU+9KGRat5wqS64A1iz
 qnvqFoLAerENC4F4XFUQmXWPy/P2NSS+5a+5ijiuKLkBK4hpwR3tubesOmel7OOB46OC
 gJMA==
X-Gm-Message-State: AOJu0YzYcg8rcM1wS26dFmh+6jbND40AE4EMRACktEU6uO/zUmryZaf0
 VOud7pNjx6vBKs9r4ePVGxAYfRoapS3/zWzgAdO1YLXmT2+uKIzMqWC23ZP+YN9nIOeTsvfEG1S
 UJCoX2Myh1F2f54XccKvo6eOt3JbnMql/eMqZVV3O
X-Gm-Gg: AR+sD12wryGZnxzZz8sBhoD8G3xWNbE4Ibhy97RTxdcIXREdr2vQwxJMpeM919smcMi
 rOYsHqfiJT9WcqdmxlTNJL1qhNi+/4br3HnkjBps4TXuhb3XDRyssGl5s4ttR7AkVpg56u1Pv3K
 bEukyNbfF+kTcsrvMbmO3TyYOPfnzY4q4tzlkRRLMFhi5j4U8gmjXGAnCAdjjfTPcCX732DEymb
 H9IaR48w0FHKIhiqiv1TGVNfQWFwX3G7Uxl5M3tCfe77VNIOGtNzQqNjZuBixAVnOtp5oJZpmz1
 rm5c6rt99U51OHurSsuLwbvxA3fjVa9AAvnsoh/nDFg=
X-Received: by 2002:a05:6402:324d:b0:69f:e3cd:5b0d with SMTP id
 4fb4d7f45d1cf-6a14f284f6dmr6497792a12.19.1786022577869; Thu, 06 Aug 2026
 06:22:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260730155119.3328020-1-mehmet.fide@gmail.com>
 <20260730155119.3328020-3-mehmet.fide@gmail.com>
In-Reply-To: <20260730155119.3328020-3-mehmet.fide@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Aug 2026 07:22:45 -0600
X-Gm-Features: AUfX_mzRrS4z-mjZERXLGGPbS57AGVDTzVtShPCynLV2LNZM6UvLMoxG6MPoEuU
Message-ID: <CAFLszThkdc_SOq5LY8d2cgFDYr6d6oMJGU0hoySAfF1=ahPwXg@mail.gmail.com>
Subject: Re: [PATCH 2/2] test: cmd: add a test for bootd
To: mehmet.fide@gmail.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Mehmet Fide <mehmet.fide@screeningeagle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786022578; x=1786627378;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=taxpDAeKq3b14TcnrJKrHwBdmml5nLBGNuW8AUTOogQ=;
 b=WBv8e6xWHxL8M3GxVh5GFd1zDQca1FXbdrTsI7yv8L1rSJTriEO2cIF2KN7lHl1Szl
 xoI/JMdpA6XXswB5/LxHH8Z9cqgZJK7aNvPkok207hsJ8JDoN2H+m4eK//eenFCNKdyD
 9/WqIKiZBqrqUPXeqlwp4/vnpgnPbu5bo5Nrg=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=WBv8e6xW
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

Hi Mehmet,

On 2026-07-30T15:51:17, Mehmet Fide <mehmet.fide@gmail.com> wrote:
> test: cmd: add a test for bootd
>
> There is no test for the bootd command. Add one to the cmd suite that
> covers the documented behaviour: bootd and its "boot" alias run the
> command held in the bootcmd environment variable, and the return value
> of bootd is the one of that command.
>
> Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
>
> test/cmd/Makefile |  3 +++
>  test/cmd/bootd.c  | 35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+)

> diff --git a/test/cmd/Makefile b/test/cmd/Makefile
> @@ -17,6 +17,9 @@ ifdef CONFIG_CONSOLE_RECORD
>  obj-$(CONFIG_CMD_ACPI) += acpi.o
>  endif
>  obj-$(CONFIG_CMD_BDI) += bdinfo.o
> +ifdef CONFIG_CONSOLE_RECORD
> +obj-$(CONFIG_CMD_BOOTD) += bootd.o
> +endif

The CONFIG_CONSOLE_RECORD ifdef is not needed. UTF_CONSOLE means the
runner skips the test when console recording is unavailable, and
bdinfo.o just above has no such guard. Please add
'obj-$(CONFIG_CMD_BOOTD) += bootd.o' next to the bdinfo line.

> diff --git a/test/cmd/bootd.c b/test/cmd/bootd.c
> @@ -0,0 +1,35 @@
> +     /* the return value is the one of the command in bootcmd */
> +     ut_assertok(env_set("bootcmd", "false"));
> +     ut_asserteq(1, run_command("bootd", 0));
> +     ut_assert_console_end();

'false' is a hush builtin, so this leg only works when the sandbox
build uses that parser. Please either note the assumption in a comment
or pick something that does not depend on the shell.

> diff --git a/test/cmd/bootd.c b/test/cmd/bootd.c
> @@ -0,0 +1,35 @@
> +static int cmd_bootd_test(struct unit_test_state *uts)
> +{
> +     ut_assertok(env_set("bootcmd", "echo hello bootd"));

The test clobbers 'bootcmd' and unsets it at the end without
preserving the previous value. Please save it with env_get() and
restore it in cleanup, so a later test that relies on the environment
is not affected by ordering.

> diff --git a/test/cmd/bootd.c b/test/cmd/bootd.c
> @@ -0,0 +1,35 @@
> +     ut_assertok(env_set("bootcmd", NULL));
> +
> +     return 0;
> +}
> +CMD_TEST(cmd_bootd_test, UTF_CONSOLE);

The cover letter mentions the recursion guard in cmd_process() never
fires on sandbox, so I won't ask for a test of that here, but it would
be nice to assert that do_bootd() itself, when invoked with
CMD_FLAG_BOOTD and bootcmd='bootd', does not recurse - that part of
the guard lives in the code you moved, and you can exercise it
directly with cmd_process_error() or by calling do_bootd() with the
flag set. What do you think?

Regards,
Simon
