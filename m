Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D50BE9413E
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 02:32:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BF71864CB;
	Sat,  7 Oct 2023 04:31:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HO3SGCcw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D090E8642A; Sat,  7 Oct 2023 04:31:56 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 620008642A
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 04:31:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5363227cc80so4554021a12.3
 for <u-boot@lists.denx.de>; Fri, 06 Oct 2023 19:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696645912; x=1697250712; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TsC5btBWemMnniALmw57el7pprNXK5koXN9gd9X9qCY=;
 b=HO3SGCcwgdVaqbDMPIEtMIbouO1csR1LVW5BqSC2jJVWsLS9XmfKr2/Ys6MTrTUQFV
 LFrZExfF7tI2ZXD1UvnV2IumNrhYktns1bnypE9BjQtZMLO0j+uHs8Z8A19O34Srcj/r
 oNOcFcQ2wzr2t+SEl1TfCRlLjZoZj8w0/0BDLJwjM6H4sHeV2nEDRUOrfUNvIv3Z2YR9
 4AAbaSQZuRBAufpjwxjycXIsNqYHLhUt/h3WEY7B9Se1fh6Kdh9STL7fnchv35ASqqNR
 rTCBGGaLUZSVCVKnSeQsQk3QWtVMLreF5MCTNU24o2k4kNTfEBwwNFlJg1wogJTa3TAB
 d5Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696645912; x=1697250712;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TsC5btBWemMnniALmw57el7pprNXK5koXN9gd9X9qCY=;
 b=EmaBdI9bBKdv23h480bMipbZ9E7bV1TFHDfwYh9LAEcpYNxfMDLlEm/XHXO494gPZG
 xVk32Rkd+njK5Wsh9SM54VWcg2yEiOSDit1Fcqsjtb31hi6ui7IWl3Qqoq3RnVe+2p0i
 4tGaI59qfrr+1tT4nW2Ra+cg8qDLdM8BYoUMK5dqWgOUiCE1bRk7UgPhP9+oaoTvFDvP
 b/pcZ0tYI6z6XlFrUkhXjMqCe6gu+dJerZwWA5L+VRNmqq30U8agOCnLYW5MAUQfpOGc
 lUSHcQ49d5MvoVLChXpMUgUsD4XkKrrZBUUHeyszX/05nSVdR7ZbADmvzcED3FkJrnH4
 RyhA==
X-Gm-Message-State: AOJu0YyV1Aw9T1u0eB/ee0coSX6Ipc1dYXFhDiKg7anG9oDDkFTEw3+N
 Ihh7JRVyzwt1KRXztaRPMaa1b/J/ukpU7CuiubMUyqhG
X-Google-Smtp-Source: AGHT+IFqfDlWwWmU3NQtPI2GrjlaD1js++bOz2cGrKvHIheYJAEwzYZEt1nWRZSZUAQKkumMmz7jgfI/mOOM7sD/3GU=
X-Received: by 2002:aa7:c68e:0:b0:530:a186:f8a8 with SMTP id
 n14-20020aa7c68e000000b00530a186f8a8mr9161557edq.37.1696645911624; Fri, 06
 Oct 2023 19:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <20231007004937.11600-1-mibodhi@gmail.com>
In-Reply-To: <20231007004937.11600-1-mibodhi@gmail.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Fri, 6 Oct 2023 19:31:24 -0700
Message-ID: <CAJaLiFwEnH8+SO14+BvwLw49fn8y_P1pSq+xdoj6AjSOdzn+cw@mail.gmail.com>
Subject: Re: [PATCH] bootstd: sata: bootdev scanning for ahci sata with no
 drive attached
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Oct 6, 2023 at 5:49=E2=80=AFPM Tony Dinh <mibodhi@gmail.com> wrote:
>
> It's normal to have no SATA drive attached to the controller, so return a
> successful status when there is no block device found after probing.
>
> Note: this patch depends on the previous patch
> https://patchwork.ozlabs.org/project/uboot/patch/20230917230649.30357-1-m=
ibodhi@gmail.com/
>
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> ---
>
>  drivers/ata/sata.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/ata/sata.c b/drivers/ata/sata.c
> index f126b84e05..59c40a829f 100644
> --- a/drivers/ata/sata.c
> +++ b/drivers/ata/sata.c
> @@ -79,6 +79,11 @@ int sata_rescan(bool verbose)
>
>         ret =3D uclass_probe_all(UCLASS_AHCI);
>
> +       if (verbose && ret =3D=3D -ENODEV) {
> +               printf("No SATA block device found\n");
> +               return 0;
> +       }
> +
>         return ret;
>  }
>
> --
> 2.39.2
>

Sorry, I need to resend this patch (fat finger).

All the best,
Tony
