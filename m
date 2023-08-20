Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F969EE49A4
	for <u-boot@archiver.kernel.org>; Sun, 20 Aug 2023 21:59:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36C0E87012;
	Sun, 20 Aug 2023 23:57:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GaUZ+8yi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EB9286EB7; Sun, 20 Aug 2023 23:57:44 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F06D087000
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 23:57:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-51cff235226so5663292a12.0
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 14:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692568661; x=1693173461;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FC7P9mlZ4qcccuye3W8ZjOGZr6JtJeBPvIqw/IOpMs4=;
 b=GaUZ+8yi1W4ZTjEW0qycqP1vCFUbr5o9e8WygzaPgBHEGZbFax1S4aLO7jsW5r6q2g
 0z/sEapyqlUb34CYjQZUQB4zyNKhjlhb9nq/BIN9R+fwwef7bVcqV77DvArRVmP5I7rt
 8v4u14197PVStUq0Eo1TxikCKzMOuuw1jOm/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692568661; x=1693173461;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FC7P9mlZ4qcccuye3W8ZjOGZr6JtJeBPvIqw/IOpMs4=;
 b=jWU3hycNRPII7yii5JKxpZ3QpO/SKPRfEWogjy8DExvZGBb5TOmLsePqxUsxR3nRRX
 uEUnv4WhNf/f4oTE60fuAbC0WPifzYa/OTcbTXG6nndb/eia23ai0oTtMdH+KVSvS1ub
 Z8LskIdhVAlPzzwW5s8psTnSNY7SZu1kLeNdHyC9+fq48yAEX4o5kpckaeJsoG0GIuEC
 STNubrYUtIeLY0nFut+ndOHm49VbBJtAzxhZnNHcGe5LlF9fBoHUArmVVfkehlcs7mTO
 y1q80EFiCX/1RI27jZCxDZNvhuU1pYIgIrY6ZlqyrDwcn+akec6L8Zh1joiMh4/nVB+x
 sayQ==
X-Gm-Message-State: AOJu0Ywk880wN8p7ISmYQbS93q5L5wCcjqIeB2f93LZsiriB4uAMiqmC
 EH9hF0XOa9EEUo7ex7juxfKVko+UtJ1MokWa7fF4Zg==
X-Google-Smtp-Source: AGHT+IHRsfCH7+WTDZvz72zyZGtGO88wZnlXGJ17g8cys6rG/Cnm3hgVLwUq3Cm6+mcAGujUbmJjLZrtAIaUP9j5m7E=
X-Received: by 2002:a05:6402:d56:b0:525:4d74:be8c with SMTP id
 ec22-20020a0564020d5600b005254d74be8cmr4414172edb.14.1692568661464; Sun, 20
 Aug 2023 14:57:41 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 20 Aug 2023 14:57:40 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ1Rm7u_=XeJJdw=KJc-8MUQ8ggqmDaQRSYOoZfauJBGtw@mail.gmail.com>
References: <CAPnjgZ1Rm7u_=XeJJdw=KJc-8MUQ8ggqmDaQRSYOoZfauJBGtw@mail.gmail.com>
 <20230813001553.286403-1-marek.vasut+renesas@mailbox.org>
Date: Sun, 20 Aug 2023 14:57:40 -0700
X-Google-Sender-Auth: cWtkmTVy4TMhQdn9CtVovHgtrgw
Message-ID: <CAPnjgZ02MkDF=OKwPXWcN2A3fC=9iMP2jsBbONb3e+23O1vS5g@mail.gmail.com>
Subject: Re: [PATCH] configs: sandbox64: Enable SF bootdev
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mario Six <mario.six@gdsys.cc>
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

On Sat, 12 Aug 2023 at 18:16, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Align the sandbox64 defconfig with sandbox defconfig. Enable missing
> SPI NOT bootdev. This fixes ut_bootstd_bootdev_test_cmd_hunt test .
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Mario Six <mario.six@gdsys.cc>
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  configs/sandbox64_defconfig | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot-dm, thanks!
