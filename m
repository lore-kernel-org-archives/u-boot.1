Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06488D3399D
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 15:54:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45F2689080;
	Mon, 28 Oct 2024 16:54:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="uEfSGdQR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 205CF8907E; Mon, 28 Oct 2024 16:54:18 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8F6289080
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 16:54:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=moritzf@google.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-20ca03687fdso170535ad.0
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 08:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1730130854; x=1730735654; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GDhT8aK1NxM2n49a3EhfZ/HnoLhyPW/pgSImtwZtZEk=;
 b=uEfSGdQRYW9G7ETyvhuwgFnjbiRFyYhb8xw37o4S87KFGpiqyl/MExOdkz5Z+8vxKc
 JAM5UZF/KhxJGRzhfVubfe+9dRMs1FH3tctsoyBEYodtogNzUdIsnYEZ9/HbI3UFNVEY
 XBoUNA6JmB7W7WI9dDtvAJt+8GvfYJqFw2O8TJSG8pRZ2tZtfYbRHkZhdlCkIjsqOp75
 yW4iZlvk4sUnqtAlRa+g3SJNx6aTe7QDc3Er4ITa8MIff+hoYF+5kBWbCV/fQYQD5eWC
 lB6LPBOI6tqV0N93vd6+XbrfqZe2rtoJIk/8wXCDncZkP19kX4IOKHBxRYNOwxBG54fM
 yr7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730130854; x=1730735654;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GDhT8aK1NxM2n49a3EhfZ/HnoLhyPW/pgSImtwZtZEk=;
 b=ErGjTO5LjREjtab28m70TX/B5lADrzTYgDbYt2FmzXIutLO+WmOs+TsADf0oKXUxvw
 U1d2Q7KMYWvtwQvI9jb6o5tufqtDmuJHYsu8keJPvOhqIvnePg6UBJOhOxpVwPtLaWyv
 7rUb+RzUixNinQ55nPV3e+GLSt7H7qREnCjR63Pk62AMKsMQSn+uvgJM5bK6tU7iWyl5
 WVwlodi12mFeHboRjzgGj8B1B+p4+Q++gk3i+u2MYVDd9ihstOZ41FWEplq2xsqhw3tN
 xHZzCxcrMnsyoybXURMJi7CwRLBknhSRwz+b4LyZR9RnHEwe1gafFcCsCAvpXNwnL4Nn
 42Rw==
X-Gm-Message-State: AOJu0YxKNZAGEnRcMzxhs8MF1xuebugCK2sYECvpKqXF+6jwjYUsCg6x
 Jjgye7ZDFyxL8mR2loNNh3G7dZPDrBSKkv05rIAYAFHuOeGlTINZutTHyMdUFZ4fvetPznGIdsZ
 I1JfQJdSwJoxgmg3HGYjEc6kAlAK0dHpSAwjj0iRiyppAMf6JHQ==
X-Google-Smtp-Source: AGHT+IGez7T5ARakki+1Y/1DfE288fOs/Pw6X2bqbz8j9N0D8qqFJaJM5r5a7ZdMlRODvwVBD5VfBIj4KDpY43KQSuY=
X-Received: by 2002:a17:902:e804:b0:205:8ceb:79a7 with SMTP id
 d9443c01a7336-210c7bb6d73mr2386795ad.23.1730130854041; Mon, 28 Oct 2024
 08:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <20241028080837.1590247-1-patrick.rudolph@9elements.com>
In-Reply-To: <20241028080837.1590247-1-patrick.rudolph@9elements.com>
From: Moritz Fischer <moritzf@google.com>
Date: Mon, 28 Oct 2024 08:54:00 -0700
Message-ID: <CAFyOScr335rvA0mnNkBOTLfTv-wFebTAwK5MT1ZxXFT+BQXqQQ@mail.gmail.com>
Subject: Re: [PATCH v1] acpi_table: Fix coverity defect in acpi_write_spcr
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
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

On Mon, Oct 28, 2024 at 1:09=E2=80=AFAM Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Fix "Integer handling issues  (SIGN_EXTENSION)" in newly added code:
> Cast serial_info.reg_offset to u64 to prevent an integer overflow when
> shifted too many bits to the left. Currently this never happens as the
> shift is supposed to be less than 4.
>
Reviewed-by: Moritz Fischer <moritzf@google.com>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> ---
>  lib/acpi/acpi_table.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/acpi/acpi_table.c b/lib/acpi/acpi_table.c
> index 6473d95c10..b9e12228fd 100644
> --- a/lib/acpi/acpi_table.c
> +++ b/lib/acpi/acpi_table.c
> @@ -420,7 +420,7 @@ int acpi_write_dbg2_pci_uart(struct acpi_ctx *ctx, st=
ruct udevice *dev,
>  static int acpi_write_spcr(struct acpi_ctx *ctx, const struct acpi_write=
r *entry)
>  {
>         struct serial_device_info serial_info =3D {0};
> -       ulong serial_address, serial_offset;
> +       u64 serial_address, serial_offset;
>         struct acpi_table_header *header;
>         struct acpi_spcr *spcr;
>         struct udevice *dev;
> @@ -473,7 +473,7 @@ static int acpi_write_spcr(struct acpi_ctx *ctx, cons=
t struct acpi_writer *entry
>         }
>
>         serial_width =3D serial_info.reg_width * 8;
> -       serial_offset =3D serial_info.reg_offset << serial_info.reg_shift=
;
> +       serial_offset =3D ((u64)serial_info.reg_offset) << serial_info.re=
g_shift;
>         serial_address =3D serial_info.addr + serial_offset;
>
>         /* Encode register access size */
> --
> 2.46.2
>
