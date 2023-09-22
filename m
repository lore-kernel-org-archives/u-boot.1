Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8BECCD4850
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 18:29:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A6EA86B09;
	Fri, 22 Sep 2023 20:29:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZGJnOvLq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B25ED86AFE; Fri, 22 Sep 2023 20:29:04 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B594F86B09
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 20:29:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-59bebd5bdadso31670037b3.0
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 11:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695407341; x=1696012141; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TRGikZYhacB3jaEu1n7+tovLR7Yf4OcrdNxDZULmfwQ=;
 b=ZGJnOvLqfV8NQcI26ARDSjaSkcnhXo5iyvBPU5iscfckuW65q7pHx6a8SM2fpJVVvT
 SwNFrWyWAGqnZbLHsu2iO4NkqHKmZ/aKpTF7hKThRbax3YlUZvbEQDZSA7oOJOaZORRg
 0I7XNsAJzKk5Pnxy6gFRWKqpF252pAtP+lo3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695407341; x=1696012141;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TRGikZYhacB3jaEu1n7+tovLR7Yf4OcrdNxDZULmfwQ=;
 b=j+h2AZAkVcPeDqj/S0Qt3BwBDA7CwbwGUq5neE2U9K0IFNAZG1VyHoHnsdr/l6uEFk
 M1H0cjjYjNbrzfZKGWf6eJtGavu3BYqvv0hJF3T+ftqczyFOjt+lrjNsQPGr3ZhMCfo3
 0ULPl6lW56DJIK+iUk7/c/Ors6OZFn26/VhR3SL/stk228509iUj89B8htdasOnbIagC
 BUL6K1Arzm61u2f+IFnqFj4IDh/SRE8HXW/TiruUkNPpOAnSMSiKuP9snQPjCCidjBoY
 jMuZnEoNj7ms3P/nnTTO6eiXbFUXLiPt5iTk4W3piOyn+BmdImNdsuAynrTdzwhsOAI0
 7MTA==
X-Gm-Message-State: AOJu0YyiW2t1pYkyGXRurKfW1zjXDi7H9LEhNWNuX4TyzKSid6I/ODPC
 SFRqzv8PsbupuaJERk40sGnJt82TcCpWgHS/h8mahA==
X-Google-Smtp-Source: AGHT+IHa1vsiaFyOkI+j2LDxAZqovwDG9Pou/NIHb/PaukcQRyquQZ1g2LMORhd52Gap4rWTUqK7tz5m+IAYapXK964=
X-Received: by 2002:a0d:cc87:0:b0:56c:e70b:b752 with SMTP id
 o129-20020a0dcc87000000b0056ce70bb752mr542440ywd.13.1695407341306; Fri, 22
 Sep 2023 11:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230917230649.30357-1-mibodhi@gmail.com>
In-Reply-To: <20230917230649.30357-1-mibodhi@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 22 Sep 2023 12:27:24 -0600
Message-ID: <CAPnjgZ0e68fVDvz+TugziET8CS27t-nKpSw81jKLJ3VWymBmGQ@mail.gmail.com>
Subject: Re: [PATCH v4] bootstd: sata: Add bootstd support for ahci sata
To: Tony Dinh <mibodhi@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Stefan Roese <sr@denx.de>
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

On Sun, 17 Sept 2023 at 17:07, Tony Dinh <mibodhi@gmail.com> wrote:
>
> Add ahci sata bootdev and corresponding hunting function.
>
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> ---
>
> Changes in v4:
> - Revise logic in bootmeth_script() to set devtype to sata for non-scsi
> SATA device
> - Rewrite sata_rescan() logic to properly remove all devices before probing
> - Add description to sata_rescan() header
>
> Changes in v3:
> - Correct drivers/ata/Makefile to compile sata_bootdev only if
> ahci sata is enabled.
>
> Changes in v2:
> - set devtype to sata in bootmeth_script for non-scsi SATA device.
>
>  boot/bootmeth_script.c     | 14 +++++++--
>  drivers/ata/Makefile       |  2 +-
>  drivers/ata/sata.c         | 32 ++++++++++++++++++++
>  drivers/ata/sata_bootdev.c | 62 ++++++++++++++++++++++++++++++++++++++
>  include/sata.h             |  6 ++++
>  5 files changed, 112 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/ata/sata_bootdev.c
>

Reviewed-by: Simon Glass <sjg@chromium.org>
