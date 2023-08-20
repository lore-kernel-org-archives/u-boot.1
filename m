Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C8EEE49A6
	for <u-boot@archiver.kernel.org>; Sun, 20 Aug 2023 21:58:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C57586B86;
	Sun, 20 Aug 2023 23:57:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="B16qPHgG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B30BC86BB2; Sun, 20 Aug 2023 23:57:40 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CC2C86FD9
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 23:57:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5254f9eda36so3436890a12.1
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 14:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692568657; x=1693173457;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BBd/lOnE9PshW4foc7mdZ4CfCjgUhmEYm8YQXjP5uvM=;
 b=B16qPHgGMNJ7Vg2E6DVd1qjTJ32ePwQeoNrfFt3iWHd5X6riz4LzZpfSK6A+A4NEWU
 gARhPwyyLB2QVcxEalN22h0MdBiAgAW6aWImEKGB4yItdmsWxNKsI7Dbe1kv0Y5yZbdu
 62eCM0HQc7F0P8fCYGzgLDeD6GrkoMn/wCKBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692568657; x=1693173457;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BBd/lOnE9PshW4foc7mdZ4CfCjgUhmEYm8YQXjP5uvM=;
 b=ftOcpsr1WqUMIwGE4daX8VM/m10BAQPcfySOVtkg7Z5SMDYniGYv9REf31enEGpXGU
 j59DWRF7EU3Tb5O5m1z7BQhm+ibDWBBWwZt2S9xEhfoPOj2Y8KlS6QJY1dt35HWWI1ie
 gNvorhCZaVPD89hf3k66fvr0sb1bm+ch9oJEZyIl4IxevfvyH30nLRk/EE//wSK5Sr8b
 mnuvT6HMx/kQiFnn9t6dfmAPgL17DdoH0LxizCs45dB4dt/JMRliyzbIymI+LS41afwb
 go9/gybGwLRON59SlF5yp51J8XdTmtaxsKQnQ37MBEqDdliuJLkbJbddHtfD1JlBcWsu
 5jMQ==
X-Gm-Message-State: AOJu0YxnEXKB5c+9jrOGMoOj2HqUhZx4pJ5QBL5udcZPjFe2Lugkp/Kr
 LJAO257OmxWUYCa4I0XcVz6pHmwyW6jKbtVIkGnazCYbw/xNAAQXDHo=
X-Google-Smtp-Source: AGHT+IEXgOnfImaxRorlJAWzIFoOJ8dETEINv/pae8FYV8EBSI27JqCQDgctND9YY6WrKEPuJXopnr2DCHoBHcAq0+c=
X-Received: by 2002:aa7:cd50:0:b0:523:b121:4228 with SMTP id
 v16-20020aa7cd50000000b00523b1214228mr2954387edw.41.1692568657697; Sun, 20
 Aug 2023 14:57:37 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 20 Aug 2023 14:57:36 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ2P7tCQDpCz1ke67buvYrGiD_T8SUG_N8h=4q73ag++wA@mail.gmail.com>
References: <CAPnjgZ2P7tCQDpCz1ke67buvYrGiD_T8SUG_N8h=4q73ag++wA@mail.gmail.com>
 <20230813030552.421275-1-marek.vasut+renesas@mailbox.org>
Date: Sun, 20 Aug 2023 14:57:36 -0700
X-Google-Sender-Auth: Md1d89_RfVfvtnZBCeorq8nPQ08
Message-ID: <CAPnjgZ29pmNXoTtmzdm6qcDbX+k57O=9S+EZm=eB2w+tfXURdQ@mail.gmail.com>
Subject: Re: [PATCH] configs: sandbox64: Enable BUTTON_ADC driver
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
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

On Sat, 12 Aug 2023 at 21:06, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Align the sandbox64 defconfig with sandbox defconfig. Enable missing
> BUTTON ADC driver. This fixes ut_dm_dm_test_button_keys_adc test .
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  configs/sandbox64_defconfig | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

As Tom mentioned there is likely not that much reason to have as many
differences between the sandbox configs as we do...so you could do a
bulk meld if it is easier.

Applied to u-boot-dm, thanks!
