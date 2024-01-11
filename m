Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 751EFC4707B
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 08:33:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B789E87A77;
	Thu, 11 Jan 2024 09:33:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TMkaNwqd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95FCE878B1; Thu, 11 Jan 2024 09:33:14 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D76A87A88
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 09:33:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-50e741123acso5757693e87.0
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 00:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704961992; x=1705566792; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tlzxG0rQCPadT/sJieM3I82ATGTOUfgrSRuIPnqhm6c=;
 b=TMkaNwqdDr1mXjf3n+FNJpSLYuEbkFkMKHkFU+Q3Rd6udkU02B2gJlGCetnYeP0qeM
 Im2Lj9NPUYPVWCIWOKfULXC0y5+qN7iD2QEdj2ssYWCyx3ryB0aPztdzqQ5eCl6l0z8w
 +1iVvieNQWtLWJKk3uQyMVrZWdcS4bG2DjF+ua2CNLaldGnWMOwBl3kjtg+52+KgyM90
 Gqfw8tZJ/11X4DG4Ehiysjmz2N0+0ysdeRIQ0623Kh4hLDt/CrLASThDl5owchVw3PFF
 0I6WJcpcux4y/CZckXu5SpT+RGeRhkbivpgNpnrpcV/12DtDsC/6fJtNVlOanbNfozyQ
 aKag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704961992; x=1705566792;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tlzxG0rQCPadT/sJieM3I82ATGTOUfgrSRuIPnqhm6c=;
 b=Mq8mMrGg2i8bhBbOCXm0CCNczKqalVGt+jaB/NnDtZ/x3YgNbg40LuXVKcT8zYPnUH
 Oxahit4Q5kvc5B1bX0L/B8vS9ByCzmqHKsI//B1+NgbwET0idnSCjC+TohXbKrsgpTSv
 ckH2D+sTmwe+o+NrmLqHfwsNqC16MdpgRnUJr5fl/3onksbukH0aTcRfP8Gg+lACgnnw
 koNdXE2rdkcIwj9Mgb7GOiLZChbyq+Y8jF8rZ1WPQpupJFyGNEnIIPDCXWCq97LGuUz2
 DHA6ZUC8mOawruRKpXkv2vupAo1oww1xT4DIsH5c0I0EdSoVCOuyv84hWZFzJF/LpZKI
 GUcQ==
X-Gm-Message-State: AOJu0YzNJgjTW2Z+M3y7LKfMER3Djl1rwfo01HyXYD84DqQ/NiV+1sut
 HuC957c5O157qn32vAr4Cw2vG9iqqckNUtLrVx525nNHA3qp/A==
X-Google-Smtp-Source: AGHT+IHJEUpzPMIZ++eu9tuVnA9vTNiNJgTSk2p2/zjx7Z+gIN9jslZaOhEuVEQzus/BV/xUf67mHFipN6juakoWT8A=
X-Received: by 2002:ac2:5de3:0:b0:50e:7f88:f541 with SMTP id
 z3-20020ac25de3000000b0050e7f88f541mr334426lfq.16.1704961991823; Thu, 11 Jan
 2024 00:33:11 -0800 (PST)
MIME-Version: 1.0
References: <20240111082535.191136-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240111082535.191136-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 11 Jan 2024 10:32:35 +0200
Message-ID: <CAC_iWjL79sLhA6Ej6s2qQnu4KbEHp_2cH8sBPu2pX9vaOt=nzw@mail.gmail.com>
Subject: Re: [PATCH] cmd: efidebug: check pointer after memory allocation
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Masahisa Kojima <masahisa.kojima@linaro.org>, u-boot@lists.denx.de
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

On Thu, 11 Jan 2024 at 10:25, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> After calling efi_alloc() we must check that the return value is not NULL.
>
> Fixes: f01c961ee34c ("cmd: efidebug: add uri device path")
> Addresses-Coverity-ID: 477185 Dereference null return value
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  cmd/efidebug.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/cmd/efidebug.c b/cmd/efidebug.c
> index e10fbf891a..997469b485 100644
> --- a/cmd/efidebug.c
> +++ b/cmd/efidebug.c
> @@ -754,6 +754,10 @@ static int efi_boot_add_uri(int argc, char *const argv[], u16 *var_name16,
>
>         uridp_len = sizeof(struct efi_device_path) + strlen(argv[3]) + 1;
>         uridp = efi_alloc(uridp_len + sizeof(END));
> +       if (!uridp) {
> +               log_err("Out of memory\n");
> +               return CMD_RET_FAILURE;
> +       }
>         uridp->dp.type = DEVICE_PATH_TYPE_MESSAGING_DEVICE;
>         uridp->dp.sub_type = DEVICE_PATH_SUB_TYPE_MSG_URI;
>         uridp->dp.length = uridp_len;
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
