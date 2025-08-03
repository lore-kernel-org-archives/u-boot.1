Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C62DEC87FCA
	for <u-boot@archiver.kernel.org>; Sun,  3 Aug 2025 08:15:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B783D83CEE;
	Sun,  3 Aug 2025 10:15:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="rhWbqZAP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24EAC83D0D; Sun,  3 Aug 2025 10:15:54 +0200 (CEST)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E23383B5F
 for <u-boot@lists.denx.de>; Sun,  3 Aug 2025 10:15:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b4239091facso1446851a12.0
 for <u-boot@lists.denx.de>; Sun, 03 Aug 2025 01:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1754208950; x=1754813750;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vHGTVkxjmvSWMOJRq7CmZoC9a3k3XJxmtoUTe+1XzCk=;
 b=rhWbqZAPrltQuxFiKPjluQOmJ10pgJja4odRXl1stxELQJi6CZjHVVsbm+HmRQrpl6
 qhNMWoa21e70b4M5iSU39w4coVgkCNoJpB81RBR4NZOvy7PgLurvdLV9o4bougLR4eO1
 flhhkm/unq8PkvdGaw84ikoZDLirLrVu20Pmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754208950; x=1754813750;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vHGTVkxjmvSWMOJRq7CmZoC9a3k3XJxmtoUTe+1XzCk=;
 b=kk/1boFQTmAwNKOlxurjf3TgZXtno9kv7kRzK9DnC68jDqUpAH8iO6rKjk74kmnqkr
 YM7A4gJl7hYdq17jUzV0o1kPvXzMI/BQzszsgtUtHb2RAEQbEFsZGEBxTNR/aSlAvx3M
 LfCnJuHygjFoZCLnNajmK9cZiwmYu1sSD5DkpoMBUKkHKM2pW6NdorZ18T+OfT6zZ6I0
 NqwIOMt4pL5kq5mdznTTzfW9ElPtrZLqX45OzQ8+SRGzEmiSVcMFBsOZ4whVujx5EAEY
 ArxrwOMktykOcPab6J3HvsKCEa2FSaBhTAME/JGX5qDERsEMMR7GDtUF1jAeIPfW5EAm
 ZOHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoTAC1tfVYGyTPLSNrpDWBnr/NbRyEJyGqLTWEltKWQAJ4/v5nupNH4LtQna7WWWKub1R2dPA=@lists.denx.de
X-Gm-Message-State: AOJu0YzJGAQM2pnT/0mqmZrSPxrxxK11qHil3uIeWet4SYu9pCFtd1Lw
 suw4HJ8ziCBtJQnT67lD4hmLaaAZlxKaZaqbk6ByhTsRMPaTfYpSQBTcpfWbFU7t46z72aRcB/U
 A6kZNQND1rksz0t4p3qgZI1swTta+aDBYtB8Qm6A3pw==
X-Gm-Gg: ASbGnct4jQ3APmy/WxrQlojd2ekflEIXucm60/yOWPbpCYPoExLEvJgS0EhHx4UMWsV
 XnM6WW2h0/l21OKRc3ebVUcJ0/DlRDUhFWBybnalf1pGKsUnPXZR9xZDD7qoe3LVuriiG7Ol/jr
 KCk8sdjVA0PtDNE8vXwR5WqndAHpmxIvvoZU24Gv6y14Pk2JA84ZkXpfITmdbhuTLPiPQaHKyaX
 WwyzQ==
X-Google-Smtp-Source: AGHT+IEMIMOiP8ChYIaGUrw0PMkg50wT6QhYm8WNYv/JUP3CQ9UnD6sTEjzT/FaFIoFkPhNmYBzA5ky0AnJeUAvYPS8=
X-Received: by 2002:a17:90b:5110:b0:31f:6ddd:ef3 with SMTP id
 98e67ed59e1d1-32116330b8amr7552068a91.35.1754208949850; Sun, 03 Aug 2025
 01:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250801-mtd_nand_raw-v1-0-80c316f5bb99@linaro.org>
 <20250801-mtd_nand_raw-v1-2-80c316f5bb99@linaro.org>
In-Reply-To: <20250801-mtd_nand_raw-v1-2-80c316f5bb99@linaro.org>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sun, 3 Aug 2025 10:15:34 +0200
X-Gm-Features: Ac12FXyTvJe892lvi2KFsSW-L6hpUWSQPgq7lgwMNS8CPiSQEN2kRJ7th9nQUFY
Message-ID: <CAOf5uwk07WtBVyBt5CyxaVcYF15zhsFipNKv9dU1LKNctY4ueg@mail.gmail.com>
Subject: Re: [PATCH 2/3] mtd: rawnand: denali: Remove always true test
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Alex Nemirovsky <alex.nemirovsky@cortina-access.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi

On Fri, Aug 1, 2025 at 11:54=E2=80=AFAM Andrew Goodbody <andrew.goodbody@li=
naro.org>
wrote:

> In denali_wait_for_irq the code will either return from inside the while
> loop or exit with time_left being 0. The following test for time_left
> being 0 is guranteed to be true so remove the test and the following
> unreachable code.
>
> This issue was found by Smatch.
>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  drivers/mtd/nand/raw/denali.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.=
c
> index b2401116689..39cb641e0b3 100644
> --- a/drivers/mtd/nand/raw/denali.c
> +++ b/drivers/mtd/nand/raw/denali.c
> @@ -173,13 +173,9 @@ static uint32_t denali_wait_for_irq(struct
> denali_nand_info *denali,
>                 time_left--;
>         }
>
> -       if (!time_left) {
> -               dev_err(denali->dev, "timeout while waiting for irq
> 0x%x\n",
> -                       irq_mask);
> -               return 0;
> -       }
> -
> -       return denali->irq_status;
> +       dev_err(denali->dev, "timeout while waiting for irq 0x%x\n",
> +               irq_mask);
> +       return 0;
>  }
>
>
Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>


>  static uint32_t denali_check_irq(struct denali_nand_info *denali)
>
> --
> 2.39.5
>
>

--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
