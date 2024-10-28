Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9775FD339A1
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 17:04:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BC42890D1;
	Mon, 28 Oct 2024 18:04:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MI9q/wek";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C677F89112; Mon, 28 Oct 2024 18:04:02 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70DB8890B3
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 18:04:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5cacb76e924so5801942a12.0
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 10:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730135040; x=1730739840; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PMGzxuANFP65HEEERNM/9ZB5xQTyk1Fz4h+fXIBcLC0=;
 b=MI9q/wekACjNM4pDIL9kemdA/yDMKv9FpywRkRZHX/hOFBtB24ZT9j4eEiLt3WzEau
 3QMM5BirtGv92OMa2kdHa8uuk++2d406ZFn4MMZ7Uq4XBG22J7Fxh6dAWsHnVIJ1Ncdx
 pfCgRUBg4/ZoBA8yTFZlyIk9/+xD2Ic9JZQQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730135040; x=1730739840;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PMGzxuANFP65HEEERNM/9ZB5xQTyk1Fz4h+fXIBcLC0=;
 b=E10VA6kQSFKFSRKRe1jj7nAGxoUz3eqANJkZP8kkrp1jZkbkeAyS8coTkWsYI2Om2p
 n0h9adQPT6V2kFKKUGOlZoDiGuOmmprhC0Ul5qMpvbQugDALoKvoerwCBte7UYHn5++t
 8hebfTBXTvRYEHErfpH16xN4Zuc2oyPSMhVTkxYWyfTEPY/pHhSbyO9wePBxl8cEKSjM
 ZULeRXaPaj69KWF6rkVBGlStU1peN6sw+9SBFGBDMTeUE/U0QKH8JqqhJrG8Fh0S66Uq
 YE5t3wYY10DBf9XaLhJN5eu61y6J3Rz2WuENxtN1RngxSI+w4G4tgwmVcTMvizIS79ks
 Zwlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9igmJDH2iJdiQA204govnsmZufrpuXlugWiRNdFSe1NzcNP0YsVTjWUW8WnMrTp+t/WKpoBo=@lists.denx.de
X-Gm-Message-State: AOJu0Yzz2Z+TPw/JMkYdQwLOsnrU8eNWMnR0uHLj9vD09ItLJryX38tR
 dITxhCzruQhSEhMAgJzihycwAVdG2WSf6iNOy2BewXFHubb7z5KqpoeI8NpAkIMqen9mUnXGeHB
 zm07l95LLx12gwAGpXb8gYvO59ZN4Q5kdCCLX
X-Google-Smtp-Source: AGHT+IGCbu543z/ObT9W2UuymMmzv+vTs4UP7aZnQ7wnwH9vWbHiV2xIwmdj7Ond9N80TSyknylbAjkRaaVlPq7qw2c=
X-Received: by 2002:a17:907:9487:b0:a99:c0be:a8ac with SMTP id
 a640c23a62f3a-a9de5ee477dmr881364366b.37.1730135039720; Mon, 28 Oct 2024
 10:03:59 -0700 (PDT)
MIME-Version: 1.0
References: <20241026-fix-scsi-disksize-v2-1-bc6be9a6043d@devpi.de>
In-Reply-To: <20241026-fix-scsi-disksize-v2-1-bc6be9a6043d@devpi.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Oct 2024 18:03:48 +0100
Message-ID: <CAFLszThsmwRF3TxKBJOr6E0KhQx1h4YPFP=HCbL_+6iuwe7ZfQ@mail.gmail.com>
Subject: Re: [PATCH v2] scsi: fix disk capacity too small by one sector
To: Julius Lehmann <lehmanju@devpi.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

+Heinrich Schuchardt <xypron.glpk@gmx.de>

On Sat, 26 Oct 2024 at 20:06, Julius Lehmann <lehmanju@devpi.de> wrote:
>
> SCSI READ CAPACITY reports the address of the last block and the block
> size. The total number of blocks is thus last block address plus one.
>
> This also fixes the corresponding test case.
>
> ---
> This patch fixes the disk size reported by scsi. Up until now, the
reported disk size is too small by one sector. Read/Write operations on
other sectors have not been affected. Trying to partition scsi backed
storage via ums has resulted in "storage too small" errors.
>
> doc: https://linux.die.net/man/8/sg_readcap
>
> Signed-off-by: Julius Lehmann <lehmanju@devpi.de>
> ---
> Changes in v2:
> - fixed corresponding test case
> - Link to v1:
https://lore.kernel.org/r/20241014-fix-scsi-disksize-v1-1-0edb9959b580@devpi.de
> ---
>  drivers/scsi/scsi.c | 2 ++
>  test/boot/bootdev.c | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
> index
51cacf3479236be6c6ea3e7d15b87e03f10e7f3a..bcdeda95ed1514119057cc67974fec465cf5672c
100644
> --- a/drivers/scsi/scsi.c
> +++ b/drivers/scsi/scsi.c
> @@ -309,6 +309,7 @@ static int scsi_read_capacity(struct udevice *dev,
struct scsi_cmd *pccb,
>                          ((unsigned long)pccb->pdata[5] << 16) |
>                          ((unsigned long)pccb->pdata[6] << 8)  |
>                          ((unsigned long)pccb->pdata[7]);
> +               *capacity += 1;
>                 return 0;
>         }
>
> @@ -332,6 +333,7 @@ static int scsi_read_capacity(struct udevice *dev,
struct scsi_cmd *pccb,
>                     ((uint64_t)pccb->pdata[5] << 16) |
>                     ((uint64_t)pccb->pdata[6] << 8)  |
>                     ((uint64_t)pccb->pdata[7]);
> +       *capacity += 1;
>
>         *blksz = ((uint64_t)pccb->pdata[8]  << 56) |
>                  ((uint64_t)pccb->pdata[9]  << 48) |
> diff --git a/test/boot/bootdev.c b/test/boot/bootdev.c
> index
c635d06ec25d4bf274099f153648d34f5a845436..bc632a3d14124f5f821c4625e5b29b7d352f7161
100644
> --- a/test/boot/bootdev.c
> +++ b/test/boot/bootdev.c
> @@ -621,7 +621,7 @@ static int bootdev_test_next_label(struct
unit_test_state *uts)
>         ut_assertok(bootdev_next_label(&iter, &dev, &mflags));
>         ut_assert_nextline("scanning bus for devices...");
>         ut_assert_skip_to_line(
> -               "            Capacity: 1.9 MB = 0.0 GB (4095 x 512)");
> +               "            Capacity: 2.0 MB = 0.0 GB (4096 x 512)");
>         ut_assert_console_end();
>         ut_assertnonnull(dev);
>         ut_asserteq_str("scsi.id0lun0.bootdev", dev->name);
>
> ---
> base-commit: 29e5dbc55c64c6450f066c55a5bc48bd1717aa1b
> change-id: 20241014-fix-scsi-disksize-d73a017cadf4
>
> Best regards,
> --
> Julius Lehmann <lehmanju@devpi.de>
>
