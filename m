Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F878C5DF87
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 12:12:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3B9856079A;
	Thu, 20 Aug 2026 12:12:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iXaB0j6BiTJm; Thu, 20 Aug 2026 12:12:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787227973;
	bh=ThQLXCtOrEikM2Pefb9BRXn1sq0fFusVa6X+rDNdLdU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TcS80zsZjKF7KXRyI0OPEwqYWxS47Md0UlAUJz3lp8b/ZZ3UHpTDl0bDdJM4P30C8
	 21FaIbqi+XwH/OJ7rOw9sPrtK7Ifkqt5JIm0nyaxlnyQoSx3gOoDjfUyfCcHuwtSBu
	 xhUIAqzuAqx3MSElzuCataB1TNHroTZ0WpbCUzeePx2drAE5oQaeGOrpPacGo+cCup
	 geRmmbQPOkXLh/wTOd4tiMTxUsCru26MducgSBSePwcbddaj5T/J9jfBe6WrtkbgJe
	 LRZkwvZziM1oGhcBfa6XzcTiJ6YoJuE00L8dUhMgMRh2AftQ/v+R6nZEV0wjd6VcoL
	 E2WqxDgQ1Xgyw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8686460796;
	Thu, 20 Aug 2026 12:12:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8BAD0323
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:12:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7D5F3405F5
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:12:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S-IxIe5lNJ6R for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 12:12:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=oK+4hooF
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 68C1F405F2
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:12:51 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c15cf78d1a2so254936966b.1
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 05:12:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787227969; cv=none;
 d=google.com; s=arc-20260327;
 b=WbJFB/4l8BEAJUdlknjmAEq5A5eE0XMCu8Memk/vfJT/yn7uZhSBam7++167p/VXkR
 ZFNeOeKlGgjkkubsqDjEMypiIJpwwkALT6cdJlQR7tnl8JH/dnypCj0N96z1BgQ0b2v7
 ElpT+jsddaWQMzcDr9BvExvU1FFfGr/ROPXX0aa8NArkN9RQ9HM9xFzCrErxP2n6Lq7y
 0ocgWtETY6Ib3XS34xuGqU3g1L7O7L9h2ysblIj5U8qaDgUhAJ9LSBZ2Pb51szd6UA7Q
 pae+xvkJyzoOFVxCYcEvEjvw6RnvLYhfSamFxAR8Ydr0Srf1lkv7mJVOtrJtT+/gDULf
 3k5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ThQLXCtOrEikM2Pefb9BRXn1sq0fFusVa6X+rDNdLdU=;
 fh=Bwjok4jWsPwFzEPPOJOguv26ANoKPtuv9PCfDq8ap3w=;
 b=Jm+hmR7vU/r0+Fz6QxhEgLAXPJGtO3/GULj+j1eY9H2ws3NDU4QOhKkFz3Za+LulFk
 OQszLu2vO/JwdBrPrLBulOGWpI2rtBDJdycY7YSqBE5QX7Gw7phyX8f0O1RCU11NUHnF
 Pw/4kEzeT9oh2djqjOdnEFiBliSiTqhExmewiU9iKmK1cYZ4Q2rWowc8E+Gh/R70Mofa
 5PC06Z0yRQtzYRdT3hKy8kDP92WEc5PljsREwE+L8FS5hlc0MVSQQkBpf6ChTG7H9A/D
 utCXZj+gr8KJWDkpi1q9rIIt4QczTFHGzLQx2VVJF2Y0aTbnUiu2E0rL3Mmv6ujHO3uH
 HPDw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1787227969; x=1787832769;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ThQLXCtOrEikM2Pefb9BRXn1sq0fFusVa6X+rDNdLdU=;
 b=oK+4hooFkFedrfC3Xphe4UMPJExA4C8Dp1Aa5ubDeXrtkhLblUQx2qCrzUOPtPa7F8
 PwhbmKQedu7V8ttZxnY7CWqU05TpFSEn6wwbcJL00u1rgDl96pB/5Uq9aOMGOEjf9nD5
 9nUTYnUdzKmEpQJbtkUduBJP85u3Gb7QxjCGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787227969; x=1787832769;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ThQLXCtOrEikM2Pefb9BRXn1sq0fFusVa6X+rDNdLdU=;
 b=OVmYX0QygYD/i+1Qgi20Aw9bp0IJm7/APhYaoaJY94iLfZLOjFwn+l+d8BbTLVko07
 WlpHGrFgfrMzeEdo7igJprXjRIBH0KCRMnP0Sf21tSPxX8RtSCKk6VL/JpmQx/D4MsJn
 FlMVV8i4TodfvdleotN8Xfw9hVgENHh6Yzd/QTs90uEN+JV4Jbk74NZ64HtKshBixIDh
 o37G6rlq0s8BpqhHK+dFBUdyndgCTPvzAqPZChRuLT/JW2RKWGIqlwUZ8JDC0jwviOYE
 kPEGyf5ntFOj9kfBKvz/lLj5FDAly87vt1XV8pOCdCSCsBlW/1iEzbkFh61yzcMuPJjO
 sZXQ==
X-Gm-Message-State: AOJu0YwwWWd5vz7lqj9lhki2ztP8JhUGP2BHK39/3e1+pK4TB5vGCGkd
 mYbNfSOALZX/z3KGUZrxUH/fUbVxm9ObfOP/4aUDazZMbBf112BwJ8WyG7FAEt6Yn2zcoB0Jgb/
 RL2h0jObLcDLPzFwBAD2oBj4YB9O7/l1DciZVFGw7
X-Gm-Gg: AR+sD11aky51XiZzfQb2lDNR6DgJ/8/eyz59yQ1CPn5ptMRce+z8RRLAT142nYS/Q3H
 sEwZP3A6yeAIOK6N96M2anqm6ACrLV0Gi8x1ykbVwPCqfhfs+8HC8SPQOK0brlyCepdE4xT/PHS
 eGzvIuhDd9bbexacSBOOS6Sqxmqb/mlBWrXAGQ/G40c1XUkfkuhoPoGPtupKpBaDebaqRSP++yg
 bm9QNnN9N6xMtBft3DTe5VeyUAM53l5dedcEEXpZEEuL2OpeRR6b1+jPRXATZHWex+jni9IB7fo
 uYtfbGJMQToypUhXLu2G4Qg+Cy3YdTZCKVVgSp8ImV0=
X-Received: by 2002:a17:907:7251:b0:c15:f26a:342f with SMTP id
 a640c23a62f3a-c242e6f411bmr874212066b.23.1787227969039; Thu, 20 Aug 2026
 05:12:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260811-b4-reset-edl-rebootmode-v1-0-2e15adc156a3@oss.qualcomm.com>
 <20260811-b4-reset-edl-rebootmode-v1-4-2e15adc156a3@oss.qualcomm.com>
In-Reply-To: <20260811-b4-reset-edl-rebootmode-v1-4-2e15adc156a3@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 20 Aug 2026 06:12:36 -0600
X-Gm-Features: AcwNN1UHLpHe_-Y_w-_JdRTJ8de2wEHmgcergSd6KjUIn4yEZb_Zw_eIMlPqYKg
Message-ID: <CAFLszThSZ5KBjN3K_QxonsJCaZ=ADNAJzv+T-fFm0SAUL+bHrg@mail.gmail.com>
Subject: Re: [PATCH 4/8] cmd: reset: dispatch named reset modes via the
 reboot-mode framework
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Johan Jonker <jbx6244@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Biswapriyo Nath <nathbappai@gmail.com>, Simon Glass <sjg@chromium.org>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Aristo Chen <aristo.chen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Balaji,

On 2026-08-11T05:18:35, Balaji Selvanathan
<balaji.selvanathan@oss.qualcomm.com> wrote:
> cmd: reset: dispatch named reset modes via the reboot-mode framework
>
> Teach the "reset" command to trigger the reset modes registered with the
> reboot-mode framework in addition to the existing cold and warm resets:
>
>   reset          cold reset (unchanged)
>   reset -w       warm reset (unchanged)
>   reset -<mode>  reset into a mode declared in the device tree
>   reset -l       list the available reset modes
>
> For example "reset -edl" enters Qualcomm EDL/download mode when the psci
> device tree node carries a "reboot-mode" subnode with
> "mode-edl = <0x80000000 0x00000001>". The command never parses the magic
> values itself; it strips the leading '-' and hands the mode name to
> reboot_mode_request(), so the values stay in the device tree and are not
> hardcoded per SoC. An unknown mode prints the registered modes rather than
> silently falling through to a cold reset.

I'm going to argue that '-edl' is a bit strange. It looks like three
separate flags (-e, -d, -l) and may end up being confusing.

Perhaps we should allocate a proper flag for download mode, e.g. -d ?

Otherwise, I suggest using a flag to specify the mode, e.g. '-m <mode>'

>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>
> cmd/boot.c                         |  6 +++++-
>  drivers/sysreset/sysreset-uclass.c | 27 ++++++++++++++++++++++++++-
>  2 files changed, 31 insertions(+), 2 deletions(-)

> diff --git a/cmd/boot.c b/cmd/boot.c
> @@ -60,7 +60,11 @@ U_BOOT_CMD(
>       reset, 2, 0,    do_reset,
>       "Perform RESET of the CPU",
>       "- cold boot without level specifier\n"
> -     "reset -w - warm reset if implemented"
> +     "reset -w - warm reset if implemented\n"
> +#if IS_ENABLED(CONFIG_DM_REBOOT_MODE)
> +     "reset -<mode> - reset into a mode declared in the device tree\n"
> +     "reset -l - list the available reset modes\n"
> +#endif
>  );

The help text is gated on CONFIG_DM_REBOOT_MODE, but the dispatch code
below only exists under CONFIG_SYSRESET_CMD_RESET. Boards that use an
arch do_reset() (e.g. arch/arm/lib/reset.c) will advertise 'reset
-<mode>' in help but silently cold-reset when it is used. Either gate
the help on both, or move the dispatch into a common location (perhaps
a new do_reset() wrapper in cmd/boot.c that calls into the reboot-mode
helpers before falling through to the arch/sysreset implementation).

> diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
> @@ -13,6 +13,7 @@
>  #include <hang.h>
>  #include <log.h>
>  #include <regmap.h>
> +#include <reboot-mode/reboot-mode.h>
>  #include <spl.h>

We normally put subdirs at the end of the sorting order.

> diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
> @@ -125,8 +126,32 @@ int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> -     if (argc == 2 && argv[1][0] == '-' && argv[1][1] == 'w') {
> +     if (argc == 2 && argv[1][0] == '-' && argv[1][1] == 'w' &&
> +         !argv[1][2]) {
>               reset_type = SYSRESET_WARM;
> +     } else if (CONFIG_IS_ENABLED(DM_REBOOT_MODE) && argc == 2 &&
> +                argv[1][0] == '-') {

Please use IS_ENABLED() to match the help text in cmd/boot.c -
CONFIG_IS_ENABLED() picks up the SPL/TPL variant and there's no reason
for that in a command handler.

> diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
> @@ -125,8 +126,32 @@ int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> +             printf("resetting into \"%s\" mode ...\n", name);
> +             mdelay(100);
> +
> +             /* Does not return on success. */
> +             reboot_mode_request(name);
> +
> +             printf("Unknown reset mode \"%s\"\n", name);
> +             reboot_mode_list();
> +             return CMD_RET_USAGE;

Two things. First, please look the mode up before printing 'resetting
into ...' and delaying - as written, an unknown mode causes a bogus
"resetting into" line, a 100ms pause and then the error, which reads
oddly on the console. Second, an unknown mode is a runtime failure,
not a usage error, so CMD_RET_FAILURE is a better fit; CMD_RET_USAGE
will splat the full command help on top of the list you just printed.

Please add a blank line before the final return in functions

> diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
> @@ -125,8 +126,32 @@ int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> +             if (!strcmp(name, "l"))
> +                     return reboot_mode_list() ? CMD_RET_FAILURE :
> +                                                 CMD_RET_SUCCESS;

'-l' collides with any mode literally named 'l'. Very unlikely in
practice, but worth a comment explaining that '-l' is reserved, and
perhaps the mode-name parser in patch 1 should reject a name of 'l' or
a name starting with '-' so the collision is caught at bind time
rather than at 'reset -l'.

Regards,
Simon
