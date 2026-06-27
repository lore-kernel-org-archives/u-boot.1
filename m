Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D587DC43327
	for <u-boot@archiver.kernel.org>; Sat, 27 Jun 2026 08:28:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECD2883FEE;
	Sat, 27 Jun 2026 10:28:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LvrbzTU3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60EFE8404D; Sat, 27 Jun 2026 10:28:30 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB625805D7
 for <u-boot@lists.denx.de>; Sat, 27 Jun 2026 10:28:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-697e93b0d9bso2975420a12.3
 for <u-boot@lists.denx.de>; Sat, 27 Jun 2026 01:28:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782548907; cv=none;
 d=google.com; s=arc-20260327;
 b=LSNpMB0dOKo91UJsUmvge7icbHnrIUwEXTTMH5VYZg7VetH/kY8tXjujd5dS12M5nW
 qwi0Ozv+jKNukcuWSR7Q5ZiedtMqdaKqWXOcNIkdEPXSsWdQV4RPb+wZ3IJNcm3BXCDH
 a6Dps6aIg3KFGKUBYwdSDj5Mxk72ywjchn0LWLrXAsB9kBoaXhoTcAB/izxWfvVyuZ0q
 KXJ+38fWiAGuHEPNxHBmO5ciUuTgABbqdkoZv7tvaWlAFUjri9PJ45Gg1/h6H6WrJsJt
 RX/tagAJ6hz9tSDMhx6ZDzYcN39Z7yMrZAXYJT+zpdxb+K32PV13/OwklPTipAScAsRy
 bBwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=kD9aRsPF73KYldLMO3hvsndzzXD7Zhph6za0NNM9v4c=;
 fh=7Ty2C+cA7Lk9JaeQfkWWxaqMrcV8hx00af54X0o0c94=;
 b=R56iU/wq1rKMXvkMqpZC5tgMyAouBHCHubxenfNNklMLkq+cL7pdv1CTjmQQuvcj2K
 C2Us8esVFxLV5dx82Zo0sQHxxQwgrvUZP/RWYABNdfms8m9RrKOK0bOa4KjWBfAN/WTw
 xgXPGYnrxakh7+mhq12mfB7z02RDUrllgL0+RG7Ddv2XwU7J6j4fhLFxtX+cAuYtIKPo
 9lzbiNFeCzBlk5K6/LjaSMPAt2s51UfIba1qVy/BBFmIOqvqTK+RiZwLtlk+OHCE92IU
 Rgxw1ijP8e3u1U9ICCQG1RTvgzvRYVBPOF+bIFk+d4Yjaxeeo7CrkkP4yDoMQde9P75e
 zNsg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782548907; x=1783153707; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kD9aRsPF73KYldLMO3hvsndzzXD7Zhph6za0NNM9v4c=;
 b=LvrbzTU3Kc96eelGt0NxSHyTXUL9RyfSpvPd1PTADOoXIrfDm2K9zP+TEhcbFWsMOF
 +DbhlZcT2DrQfZwGIJ/mxCfVoZh46QDq3X4W0X9kyKXyQ36krvklMCjRufZX9Uq7qHew
 eHL2QK2pJkVisKSNhXEh2tex+cjUd2vouNd3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782548907; x=1783153707;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kD9aRsPF73KYldLMO3hvsndzzXD7Zhph6za0NNM9v4c=;
 b=U0soSenq/tdugac6jFL3vakZKiJhTycMfk6c2TQYB92nLKhgILX1s0w21SptODa8rg
 mz4ilFJcpHCJmUUZbxNDEYmAKTunopjs57rJVe1VvJ9FYFogCAMdR3ENDJ2xAcFFlcES
 WyWosqaFSR9dnLrgG88wikgHzMMXzIjfd3oEy1n+SzQEY/H2Io7quRiUEnQ1CbQc3r0E
 XkhaAj4TDGVx/Dx5Z3AF9dpcsOinkPX/wNToEbgcdpvd/XAlZKUNz32e4jxl9oyMHuam
 vCSfzHRfHRL5cteLMOi+O4BoG5GfiUpHQTe3zSi/Tg6wGIg8I0RMyzseYcV/qt8xrYva
 3xDg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrcRIcnRVNvjiY7pfc+EOmTYSCcduzn8kUFO9CENutiy2VGSMn4T9/uNp+SQeri2u91qlgxTP4=@lists.denx.de
X-Gm-Message-State: AOJu0YxX8cYKTKBkJBcNgbmJOLkoWdNQPw9dPCnBn9zL8cnnspr2Owv/
 LtmCQwYg+a32M3791kmOtdzSwd0ihuVoD1ijuHxDQmOfsHxO9v+tGXtOLGi80/DFIX5YylDQDTx
 1PEY6ff5p8VN6bfEXkXvQ6Spby1adCcCZR/gujQTp
X-Gm-Gg: AfdE7cl1tY0zzvkBq1MXMuA345KQE4j7iVult1JPiYRSmmwPxDnaSDZFrgwaaMtxAym
 9Lws3LWar37NEfs+CjJ9gbZLz/D05kTP1hKt5JMSu8TsLAOZkyDbN57IH6lERzrfSQTIvRznBxM
 v+ez/0k8rhAwv80GLC6eYanFBBC/17kc422aEue09NbFF7t7kMvuUbmv5oRzUOIZBrQThD3Prxs
 dovPTtQe8BWHHdrpfGYnZXCKgRotxD6fUFE+cJiqrSfk19ZFD3m2OJ7Ad5ujKdPjAPxXSwLWw==
X-Received: by 2002:a05:6402:2402:b0:698:3b7c:3b35 with SMTP id
 4fb4d7f45d1cf-6983b7c3e2amr1450615a12.33.1782548907100; Sat, 27 Jun 2026
 01:28:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260603070743.1268544-1-dmukhin@ford.com>
 <20260603070743.1268544-3-dmukhin@ford.com>
 <dc8099b0-bd91-4aec-8683-16e46b7910cb@cherry.de>
In-Reply-To: <dc8099b0-bd91-4aec-8683-16e46b7910cb@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 27 Jun 2026 09:28:15 +0100
X-Gm-Features: AVVi8CdZREaXDO60c2-FFVjKLI0IBezHH8f7TgUey9BTWYHS14aTbqStlegVIHs
Message-ID: <CAFLszThGtmrZYV+npTcjpQh1q5XYJPYYCzwGS_Qsrufqcb+58A@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] reset: Add explicit cold reset support
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: dmukhin@ford.com, u-boot@lists.denx.de, trini@konsulko.com
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

Hi Quentin,

On Fri, 26 Jun 2026 at 16:00, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Denis,
>
> On 6/3/26 9:07 AM, dmukhin@ford.com wrote:
> > Some prototype boards default to a non-cold reset type, e.g. warm reset.
> >
> > Add 'reset -c' so users can explicitly request a cold reset when needed.
> >
> > Signed-off-by: Denis Mukhin <dmukhin@ford.com>
> > ---
> > Changes since v3:
> > - preserved existing behavior for 'reset -edl' handling
> > - corrected commit message formatting
> > ---
> >   cmd/boot.c                         |  3 ++-
> >   drivers/sysreset/sysreset-uclass.c | 13 +++++++++++--
> >   2 files changed, 13 insertions(+), 3 deletions(-)
> >
> > diff --git a/cmd/boot.c b/cmd/boot.c
> > index 29cdf4a9a81a..5cac6cf3fed0 100644
> > --- a/cmd/boot.c
> > +++ b/cmd/boot.c
> > @@ -59,13 +59,14 @@ U_BOOT_CMD(
> >   U_BOOT_CMD(
> >       reset, 2, 0,    do_reset,
> >       "Perform RESET of the CPU",
> > -     "- cold boot without level specifier\n"
> > +     "- reset using the configured default type\n"
>
> NACK. It performs a cold boot when the level (-w) is not specified so we
> need to keep this as is.
>
> >   #if IS_ENABLED(CONFIG_SYSRESET_CMD_RESET_ARGS)
> >   // All options handled by sysreset drivers via their sysreset_ops.request_arg callback
> >   #ifdef CONFIG_SYSRESET_QCOM_PSCI
> >       "reset -edl - Boot to Emergency DownLoad mode\n"
> >   #endif
> >   #endif
> > +     "reset -c - cold reset if implemented\n"
>
> But... why? `reset` already does that why do we need yet another option
> for something we already do when no argument is passed?
>
> >       "reset -w - warm reset if implemented"
> >   );
> >
> > diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
> > index 5c6dd7cc1c55..1ba698b37285 100644
> > --- a/drivers/sysreset/sysreset-uclass.c
> > +++ b/drivers/sysreset/sysreset-uclass.c
> > @@ -168,8 +168,17 @@ int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> >       if (argc > 2)
> >               return CMD_RET_USAGE;
> >
> > -     if (argc == 2 && argv[1][0] == '-' && argv[1][1] == 'w') {
> > -             reset_type = SYSRESET_WARM;
> > +     if (argc == 2 && argv[1][0] == '-' && strlen(argv[1]) == 2) {
> > +             switch (argv[1][1]) {
> > +             case 'c':
> > +                     reset_type = SYSRESET_COLD;
> > +                     break;
> > +             case 'w':
> > +                     reset_type = SYSRESET_WARM;
> > +                     break;
> > +             default:
> > +                     return CMD_RET_USAGE;
>
> NACK. We support passing arguments to sysreset drivers whenever -w is
> not passed, so this will break them. See the sysreset_walk_arg below.

Yes, I wasn't too keen on that [1]...it seems to be causing problems
now. So I suggest removing that method. The only user is Qualcomm - we
can define a new sysreset_t value instead (such as
SYSRESET_TO_DOWNLOAD). Passing argc/argv to a uclass method is really
not a great idea - arg parsing should be done in cmd/

Regards,
Simon

[1] https://lore.kernel.org/u-boot/20260217143957.GZ2747538@bill-the-cat/
