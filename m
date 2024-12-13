Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E7EE7717F
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 16:56:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0070800CF;
	Fri, 13 Dec 2024 17:56:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HJA3EFdy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1D99800D7; Fri, 13 Dec 2024 17:56:31 +0100 (CET)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 687B2800C8
 for <u-boot+nodisclaimer@lists.denx.de>; Fri, 13 Dec 2024 17:56:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7fd4c0220bbso1933650a12.0
 for <u-boot+nodisclaimer@lists.denx.de>; Fri, 13 Dec 2024 08:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734108987; x=1734713787; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FPKTPmbSgeD0Equ2crn+BV9fV4/V/tsF615G9NZyVSg=;
 b=HJA3EFdyecAevBAbc/sVEDKxb3IB0RjFbJOD81SdD1A1Lf5/89xNJtSM5mm6aa75QG
 GEOOTP0d9fAPUEUtPxeUlwT/eo9xQ5RqH+BAZBPG1O3oqUwDUeEas6CZH5cxfDuf66It
 Q4L66FD3BOsP2KiSU1x5Tq/Cv4GtNVvSo0kC96r6FKK9t8c1lje5aUSCIITATl6vvuzq
 eAjkEXnlY6h95WicW5DNkL3r3lQX37IXKKSGu4ifwykfBHzirYVtnIcfBIftpAVH+TPG
 oWL5OZmQLf+EEEJk1lsNCtspOS6GjVxQLpud+fU39c78LJQWoSdCBocopiuGMCU5WYz0
 JTrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734108987; x=1734713787;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FPKTPmbSgeD0Equ2crn+BV9fV4/V/tsF615G9NZyVSg=;
 b=htiUgzmBEehufMQzixguAn2esI5EKrz2jhTtRZgr+imppVuHVa1xgHq4lItYWiaMv1
 LbcdF8UrX/G03fBLvx96Wzl8IAxoIuAiTMPy+BSYNsq2olhQOht3GxqvsK7JGfNnk/4y
 5VLtV+ZyeN1lY9082GOww4mnvAVK4fUUO/zZIf3I+FR5QQnB1kD24ONtP361nANpYx13
 DSeS80NbMw3OWoKu872y67flNeUH53+oUebZsgMw1G6+SE6ouzdAeVpkedWhOQY0wiOQ
 fNK0H4dDnKqmrMJCxh/DjQynCrWsOaNjDva9mWhOJe4gVWHiwlqXvlJ4pyH7bD+6fjgq
 Uj+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZHB/zdtsZy8ZWNHO3aS0S/1d1dD4OsUdbupjemXsUWAOq1evIxVEU2dKmlhvn9zyP39NcJGI=@lists.denx.de
X-Gm-Message-State: AOJu0YxTuxvdDLSzSpzrwVI7bCVnElc9wKPfeDsvpz0xnlY5X736eAjt
 GgjDF0oPGPZZ6Lk+AjUowCHRVZ1QfdOMFzNZW8BA/qBbJcMXJJnwH1YV/hyoaluLqrdBGYheDmA
 5VvwQwOX9zMye37zBR7nbETTP0JlUG2qTlDTIWw==
X-Gm-Gg: ASbGncuVGELwlU7ShhKqknJ5B5x11aA74r9eJx2FqpF/lxx/HSRWU2SquSKwvCis4Ib
 YyhsOecA3gGNY2rhay+9TukrUhguWBKec10QIqrzZocMEkLPfEwNjFlJ+qlpiXKgB2AOdb7Y=
X-Google-Smtp-Source: AGHT+IGwR3EaXLWJcoPjOYVIv51VjxuXM4KAk0Iirc8ffLdoLVbCM+DgakOTZbWVwque6ZrMULPlcI5i/dwIfgOI4R0=
X-Received: by 2002:a17:90b:3c4e:b0:2ee:d63f:d71 with SMTP id
 98e67ed59e1d1-2f28fb67304mr5462896a91.14.1734108986651; Fri, 13 Dec 2024
 08:56:26 -0800 (PST)
MIME-Version: 1.0
References: <20241212133710.172404-1-philippe.reynes@softathome.com>
 <20241212133710.172404-7-philippe.reynes@softathome.com>
In-Reply-To: <20241212133710.172404-7-philippe.reynes@softathome.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 13 Dec 2024 11:56:15 -0500
Message-ID: <CAEfUkUL-JDovdtwmvywd8vfjK-vqPWnJwpeQGo+sZXWJNPFmjQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] test: lib: add test for sha256_hmac
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: sjg+nodisclaimer@chromium.org, raymond.mao+nodisclaimer@linaro.org, 
 u-boot+nodisclaimer@lists.denx.de
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

Hi Philippe,

On Thu, 12 Dec 2024 at 08:37, Philippe Reynes <
philippe.reynes@softathome.com> wrote:

> Adds a test for the function sha256_hmac
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
>  test/lib/Makefile           |   1 +
>  test/lib/test_sha256_hmac.c | 296 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 297 insertions(+)
>  create mode 100644 test/lib/test_sha256_hmac.c
>
> diff --git a/test/lib/Makefile b/test/lib/Makefile
> index f516d001747..4c0abcba81a 100644
> --- a/test/lib/Makefile
> +++ b/test/lib/Makefile
> @@ -24,6 +24,7 @@ obj-$(CONFIG_ERRNO_STR) += test_errno_str.o
>  obj-$(CONFIG_UT_LIB_ASN1) += asn1.o
>  obj-$(CONFIG_UT_LIB_RSA) += rsa.o
>  obj-$(CONFIG_AES) += test_aes.o
> +obj-$(CONFIG_SHA256) += test_sha256_hmac.o
>  obj-$(CONFIG_GETOPT) += getopt.o
>  obj-$(CONFIG_CRC8) += test_crc8.o
>  obj-$(CONFIG_UT_LIB_CRYPT) += test_crypt.o
> diff --git a/test/lib/test_sha256_hmac.c b/test/lib/test_sha256_hmac.c
> new file mode 100644
> index 00000000000..78b87ec98a8
> --- /dev/null
> +++ b/test/lib/test_sha256_hmac.c
> @@ -0,0 +1,296 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2024 Philippe Reynes <philippe.reynes@softathome.com>
> + *
> + * Unit tests for sha256_hmac functions
> + */
> +
> +#include <command.h>
> +#include <test/lib.h>
> +#include <test/test.h>
> +#include <test/ut.h>
> +#include <u-boot/sha256.h>
> +
> +struct test_sha256_hmac_s {
> +       unsigned char *key;
> +       int keylen;
> +       unsigned char *input;
> +       int ilen;
> +       unsigned char *expected;
> +       int elen;
> +};
> +
> +/*
> + * data comes from:
> + * https://datatracker.ietf.org/doc/html/rfc4231
> + */
> +static unsigned char key_test1[] = {
> +       0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b,
> +       0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b };
> +
> +static unsigned char input_test1[] = {
> +       0x48, 0x69, 0x20, 0x54, 0x68, 0x65, 0x72, 0x65 };
> +
> +static unsigned char expected_test1[] = {
> +       0xb0, 0x34, 0x4c, 0x61, 0xd8, 0xdb, 0x38, 0x53,
> +       0x5c, 0xa8, 0xaf, 0xce, 0xaf, 0x0b, 0xf1, 0x2b,
> +       0x88, 0x1d, 0xc2, 0x00, 0xc9, 0x83, 0x3d, 0xa7,
> +       0x26, 0xe9, 0x37, 0x6c, 0x2e, 0x32, 0xcf, 0xf7 };
> +
> +static unsigned char key_test2[] = { 0x4a, 0x65, 0x66, 0x65 };
> +
> +static unsigned char input_test2[] = {
> +       0x77, 0x68, 0x61, 0x74, 0x20, 0x64, 0x6f, 0x20,
> +       0x79, 0x61, 0x20, 0x77, 0x61, 0x6e, 0x74, 0x20,
> +       0x66, 0x6f, 0x72, 0x20, 0x6e, 0x6f, 0x74, 0x68,
> +       0x69, 0x6e, 0x67, 0x3f };
> +
> +static unsigned char expected_test2[] = {
> +       0x5b, 0xdc, 0xc1, 0x46, 0xbf, 0x60, 0x75, 0x4e,
> +       0x6a, 0x04, 0x24, 0x26, 0x08, 0x95, 0x75, 0xc7,
> +       0x5a, 0x00, 0x3f, 0x08, 0x9d, 0x27, 0x39, 0x83,
> +       0x9d, 0xec, 0x58, 0xb9, 0x64, 0xec, 0x38, 0x43 };
> +
> +static unsigned char key_test3[] = {
> +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
> +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
> +       0xaa, 0xaa, 0xaa, 0xaa };
> +
> +static unsigned char input_test3[] = {
> +       0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd,
> +       0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd,
> +       0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd,
> +       0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd,
> +       0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd,
> +       0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd,
> +       0xdd, 0xdd };
> +
> +static unsigned char expected_test3[] = {
> +       0x77, 0x3e, 0xa9, 0x1e, 0x36, 0x80, 0x0e, 0x46,
> +       0x85, 0x4d, 0xb8, 0xeb, 0xd0, 0x91, 0x81, 0xa7,
> +       0x29, 0x59, 0x09, 0x8b, 0x3e, 0xf8, 0xc1, 0x22,
> +       0xd9, 0x63, 0x55, 0x14, 0xce, 0xd5, 0x65, 0xfe };
> +
> +static unsigned char key_test4[] = {
> +       0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
> +       0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x10,
> +       0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18,
> +       0x19,
> +};
> +
> +static unsigned char input_test4[] = {
> +       0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd,
> +       0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd,
> +       0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd,
> +       0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd,
> +       0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd,
> +       0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd,
> +       0xcd, 0xcd,
> +};
> +
> +static unsigned char expected_test4[] = {
> +       0x82, 0x55, 0x8a, 0x38, 0x9a, 0x44, 0x3c, 0x0e,
> +       0xa4, 0xcc, 0x81, 0x98, 0x99, 0xf2, 0x08, 0x3a,
> +       0x85, 0xf0, 0xfa, 0xa3, 0xe5, 0x78, 0xf8, 0x07,
> +       0x7a, 0x2e, 0x3f, 0xf4, 0x67, 0x29, 0x66, 0x5b,
> +};
> +
> +static unsigned char key_test5[] = {
> +       0x0c, 0x0c, 0x0c, 0x0c, 0x0c, 0x0c, 0x0c, 0x0c,
> +       0x0c, 0x0c, 0x0c, 0x0c, 0x0c, 0x0c, 0x0c, 0x0c,
> +       0x0c, 0x0c, 0x0c, 0x0c,
> +};
> +
> +static unsigned char input_test5[] = {
> +       0x54, 0x65, 0x73, 0x74, 0x20, 0x57, 0x69, 0x74,
> +       0x68, 0x20, 0x54, 0x72, 0x75, 0x6e, 0x63, 0x61,
> +       0x74, 0x69, 0x6f, 0x6e,
> +};
> +
> +static unsigned char expected_test5[] = {
> +       0xa3, 0xb6, 0x16, 0x74, 0x73, 0x10, 0x0e, 0xe0,
> +       0x6e, 0x0c, 0x79, 0x6c, 0x29, 0x55, 0x55, 0x2b,
> +};
> +
> +static unsigned char key_test6[] = {
> +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
> +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
> +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
> +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
> +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
> +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
> +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
> +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
> +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
> +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
> +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
> +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
> +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
> +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
> +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
> +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
> +       0xaa, 0xaa, 0xaa };
> +
> +static unsigned char input_test6[] = {
> +       0x54, 0x65, 0x73, 0x74, 0x20, 0x55, 0x73, 0x69,
> +       0x6e, 0x67, 0x20, 0x4c, 0x61, 0x72, 0x67, 0x65,
> +       0x72, 0x20, 0x54, 0x68, 0x61, 0x6e, 0x20, 0x42,
> +       0x6c, 0x6f, 0x63, 0x6b, 0x2d, 0x53, 0x69, 0x7a,
> +       0x65, 0x20, 0x4b, 0x65, 0x79, 0x20, 0x2d, 0x20,
> +       0x48, 0x61, 0x73, 0x68, 0x20, 0x4b, 0x65, 0x79,
> +       0x20, 0x46, 0x69, 0x72, 0x73, 0x74 };
> +
> +static unsigned char expected_test6[] = {
> +       0x60, 0xe4, 0x31, 0x59, 0x1e, 0xe0, 0xb6, 0x7f,
> +       0x0d, 0x8a, 0x26, 0xaa, 0xcb, 0xf5, 0xb7, 0x7f,
> +       0x8e, 0x0b, 0xc6, 0x21, 0x37, 0x28, 0xc5, 0x14,
> +       0x05, 0x46, 0x04, 0x0f, 0x0e, 0xe3, 0x7f, 0x54 };
> +
> +static unsigned char key_test7[] = {
> +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
> +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
> +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
> +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
> +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
> +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
> +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
> +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
> +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
> +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
> +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
> +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
> +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
> +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
> +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
> +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
> +       0xaa, 0xaa, 0xaa,
> +};
> +
> +static unsigned char input_test7[] = {
> +       0x54, 0x68, 0x69, 0x73, 0x20, 0x69, 0x73, 0x20,
> +       0x61, 0x20, 0x74, 0x65, 0x73, 0x74, 0x20, 0x75,
> +       0x73, 0x69, 0x6e, 0x67, 0x20, 0x61, 0x20, 0x6c,
> +       0x61, 0x72, 0x67, 0x65, 0x72, 0x20, 0x74, 0x68,
> +       0x61, 0x6e, 0x20, 0x62, 0x6c, 0x6f, 0x63, 0x6b,
> +       0x2d, 0x73, 0x69, 0x7a, 0x65, 0x20, 0x6b, 0x65,
> +       0x79, 0x20, 0x61, 0x6e, 0x64, 0x20, 0x61, 0x20,
> +       0x6c, 0x61, 0x72, 0x67, 0x65, 0x72, 0x20, 0x74,
> +       0x68, 0x61, 0x6e, 0x20, 0x62, 0x6c, 0x6f, 0x63,
> +       0x6b, 0x2d, 0x73, 0x69, 0x7a, 0x65, 0x20, 0x64,
> +       0x61, 0x74, 0x61, 0x2e, 0x20, 0x54, 0x68, 0x65,
> +       0x20, 0x6b, 0x65, 0x79, 0x20, 0x6e, 0x65, 0x65,
> +       0x64, 0x73, 0x20, 0x74, 0x6f, 0x20, 0x62, 0x65,
> +       0x20, 0x68, 0x61, 0x73, 0x68, 0x65, 0x64, 0x20,
> +       0x62, 0x65, 0x66, 0x6f, 0x72, 0x65, 0x20, 0x62,
> +       0x65, 0x69, 0x6e, 0x67, 0x20, 0x75, 0x73, 0x65,
> +       0x64, 0x20, 0x62, 0x79, 0x20, 0x74, 0x68, 0x65,
> +       0x20, 0x48, 0x4d, 0x41, 0x43, 0x20, 0x61, 0x6c,
> +       0x67, 0x6f, 0x72, 0x69, 0x74, 0x68, 0x6d, 0x2e,
> +};
> +
> +static unsigned char expected_test7[] = {
> +       0x9b, 0x09, 0xff, 0xa7, 0x1b, 0x94, 0x2f, 0xcb,
> +       0x27, 0x63, 0x5f, 0xbc, 0xd5, 0xb0, 0xe9, 0x44,
> +       0xbf, 0xdc, 0x63, 0x64, 0x4f, 0x07, 0x13, 0x93,
> +       0x8a, 0x7f, 0x51, 0x53, 0x5c, 0x3a, 0x35, 0xe2,
> +};
> +
> +static struct test_sha256_hmac_s test_sha256_hmac[] = {
> +       {
> +               .key = key_test1,
> +               .keylen = sizeof(key_test1),
> +               .input = input_test1,
> +               .ilen = sizeof(input_test1),
> +               .expected = expected_test1,
> +               .elen = sizeof(expected_test1),
> +       },
> +       {
> +               .key = key_test2,
> +               .keylen = sizeof(key_test2),
> +               .input = input_test2,
> +               .ilen = sizeof(input_test2),
> +               .expected = expected_test2,
> +               .elen = sizeof(expected_test2),
> +       },
> +       {
> +               .key = key_test3,
> +               .keylen = sizeof(key_test3),
> +               .input = input_test3,
> +               .ilen = sizeof(input_test3),
> +               .expected = expected_test3,
> +               .elen = sizeof(expected_test3),
> +       },
> +       {
> +               .key = key_test4,
> +               .keylen = sizeof(key_test4),
> +               .input = input_test4,
> +               .ilen = sizeof(input_test4),
> +               .expected = expected_test4,
> +               .elen = sizeof(expected_test4),
> +       },
> +       {
> +               .key = key_test5,
> +               .keylen = sizeof(key_test5),
> +               .input = input_test5,
> +               .ilen = sizeof(input_test5),
> +               .expected = expected_test5,
> +               .elen = sizeof(expected_test5),
> +       },
> +       {
> +               .key = key_test6,
> +               .keylen = sizeof(key_test6),
> +               .input = input_test6,
> +               .ilen = sizeof(input_test6),
> +               .expected = expected_test6,
> +               .elen = sizeof(expected_test6),
> +       },
> +       {
> +               .key = key_test7,
> +               .keylen = sizeof(key_test7),
> +               .input = input_test7,
> +               .ilen = sizeof(input_test7),
> +               .expected = expected_test7,
> +               .elen = sizeof(expected_test7),
> +       },
> +};
> +
> +static int _lib_test_sha256_hmac_run(struct unit_test_state *uts,
> +                                    unsigned char *key, int keylen,
> +                                    unsigned char *input, int ilen,
> +                                    unsigned char *expected, int elen)


const unsigned char *


> +{
> +       unsigned char output[32];


Please use SHA256_SUM_LEN to avoid magic numbers.


> +
> +       sha256_hmac(key, keylen, input, ilen, output);
> +       ut_asserteq_mem(expected, output, elen);
> +
> +       return 0;
> +}
> +
> +static int lib_test_sha256_hmac_run(struct unit_test_state *uts,
> +                                   struct test_sha256_hmac_s *test)
> +{
> +       unsigned char *key = test->key;
> +       int keylen = test->keylen;
> +       unsigned char *input = test->input;
> +       int ilen = test->ilen;
> +       unsigned char *expected = test->expected;
> +       int elen = test->elen;
> +
> +       return _lib_test_sha256_hmac_run(uts, key, keylen, input, ilen,
> expected, elen);
>

Why we don't just:
return _lib_test_sha256_hmac_run(uts, test->key, test->keylen,
                                 test->input, test->ilen,
                                 test->expected, test->elen);

+}
> +
> +static int lib_test_sha256_hmac(struct unit_test_state *uts)
> +{
> +       int i, ret = 0;
> +
> +       for (i = 0; i < ARRAY_SIZE(test_sha256_hmac); i++) {
> +               ret = lib_test_sha256_hmac_run(uts, &test_sha256_hmac[i]);
> +               if (ret)
> +                       break;
> +       }
> +
> +       return ret;
>

This seems to be better:
       for (i = 0; i < ARRAY_SIZE(test_sha256_hmac); i++) {
               ret = lib_test_sha256_hmac_run(uts, &test_sha256_hmac[i]);
               if (ret)
                       return ret;
       }
       return 0;

+}
> +
> +LIB_TEST(lib_test_sha256_hmac, 0);
> --
> 2.25.1
>
>
Regards,
Raymond
