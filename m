Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A7B6CCFA0D
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 09:56:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB06A83A47;
	Wed,  5 Nov 2025 10:56:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OpUJe0vr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A933983A48; Wed,  5 Nov 2025 10:56:18 +0100 (CET)
Received: from mail-yx1-xb12b.google.com (mail-yx1-xb12b.google.com
 [IPv6:2607:f8b0:4864:20::b12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9124383A3D
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 10:56:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-63fbed0f71aso2482566d50.0
 for <u-boot@lists.denx.de>; Wed, 05 Nov 2025 01:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762336575; x=1762941375; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MdrqZn+uEBwQ3j0VqQ68w9p25tDiwZ1CH+R2W/xh9Jo=;
 b=OpUJe0vrb9BX+1IbHj8OPdEPJMWbCiBcUc6J1ufcLSDQ6k1vgfpmihhUiNxOqqP8fL
 fLciNRwVcryIuv3kZdsUZPr19dIIDwVdB3e7VHAdkexyMNmG8Kv6xS+wtrGYkf00tC5c
 BqTZvN4sHV+BYiRIb+0qcmpvnNYqkAeX1ubNDlY9jaG0tcqbCeLj50i7j8AZ7XaZIgir
 1+5iATb9bjF03Mu4l2eA1WlMuWwxEjxJNoRfPlxM1N9qcqxWUhV257oUgRiYm2eAFVCp
 jVZ5kuA6yyeILtXiLSnOFAtH287tGU9b6/k91AphjnUgp20cPqXmlxv9BZRxCWYY32CQ
 qsVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762336575; x=1762941375;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MdrqZn+uEBwQ3j0VqQ68w9p25tDiwZ1CH+R2W/xh9Jo=;
 b=Y/YqdlKeUlZiYDPgl5IaJfxa9/XkWHo5G0kZEfdfgyCcijprm2HRfd26r04Lhmrszd
 DlrrFsS28P8qkQbEI8LUzCCJpjHqfSDU1XhIoioDZiobuoS2wDilThy0NLMMC8fHpvyz
 HiULHTomd1jd4YOcs1ABPBKBhjfdo3HVcVqd2Lzfh5sHk9ppsRmF6AQxSwsMme+ivf0H
 W8H2L0JMGbrogzpJCSBAN2X8rfpZOT0LwLunuvJ/D8VGeQEiVWAe+x3qdjOZ6kxJmO+f
 NtIXVqJj2luVM+JyrE0nTELJujQ+tp5REMBYaUNUIGjWAe/CywtNXPGeGXWlPmRa183z
 mbrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrAVhuSoipqzPzJ8A68sY8HcCj2ZWTYQ3YSc3ypcwWtHadgPwtGDT1fUOWQZ3UKn3hn3qpHZw=@lists.denx.de
X-Gm-Message-State: AOJu0YzeBLjctgGtNOLUixgDpo7pIZN4fyzoOhN5pZ8xSyfD458cdbDe
 lyVBCbM6+Pz2HHYQGpYOSVI2IbaUTHkBWQ1gPG16FHN4h2WtKv/Nrq67m1betKZ0nC/Z2IFaYog
 FkbhBhSxfmdyVv/tFfOAz4E/ecfVsyrw=
X-Gm-Gg: ASbGncsj2+i4m0BufcacJu1/VzjrxWkYjsYPXhukmZ1rfHpI8BsSHCdMMSy89UMVxc/
 hoEEnYciZZ7njxY/OOwryjtU8yevCr/9pWQSVlphcsLRLbpuKwGrcRBrXXehOtm56F/nEw9XSPg
 ZXBxkmy2F3V6s9NGQ/OxP/Dur3Cq6ESU5i5wThfTsFDZWbSgCXrjbUbB+3m1APkd/44s7Kn+5NO
 R/M2GE/2kGrwdyknE7K4odRqB+h1pgL7p42bCsedtloe99rDnMm8cMaMpywbl4=
X-Google-Smtp-Source: AGHT+IGIMzKfcPqRj/epeoHr8/MrTPRmI9mhPL0OPV1R10k/An7H3vfBoG81P0quV8MPCD/DyjO/dszv5Olq22rpxHU=
X-Received: by 2002:a05:690e:4303:b0:63f:b446:7019 with SMTP id
 956f58d0204a3-63fd35bd2admr1725677d50.64.1762336575353; Wed, 05 Nov 2025
 01:56:15 -0800 (PST)
MIME-Version: 1.0
References: <20251105012649.11067-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251105012649.11067-1-heinrich.schuchardt@canonical.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 5 Nov 2025 17:56:04 +0800
X-Gm-Features: AWmQ_bn_Umdg4dXlGfQ28ciR49bjF66SFH4StHmZM06JYsp7subjGesfMEL0Tdg
Message-ID: <CAEUhbmWNA+_A0RGdFLSKU4SVmhHhNZAH7kSYxc3bmseVjB6arA@mail.gmail.com>
Subject: Re: [PATCH v2] block: typo 'to be write'
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Wed, Nov 5, 2025 at 9:26=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> %s/to be write/to write/
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         use 'to write' to match blkcnt description
>         fix typo in subject line
> ---
>  drivers/block/efi_blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
