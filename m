Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C53C5321E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 14:37:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C4B088905;
	Mon, 26 Aug 2024 16:37:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MClKnnNz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18F6E8891B; Mon, 26 Aug 2024 16:37:48 +0200 (CEST)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9009884DB
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 16:37:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-201df0b2df4so35183995ad.0
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 07:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724683064; x=1725287864; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FmMudQYyqBmimm3xczhRkeejLn1X7G9r5bwiVF5cHfM=;
 b=MClKnnNzHDqt+wS+uP+oQPGiYXZkfv8rLqvtKlMDILt9qGmC742mbo9no4f4dkx+1D
 9xttIT8weEQtr7k4/yQL2reufP5w1CX092lEAxLdUBZasJKPN1B5z4ZlO5xvt1Ax4FOi
 joOdqzl77rtdKOVdQQ7Y21D1y9ydT9Zs6P5vsUstOLmBrg0JGTeVJKTZuzPy5wz6oF2H
 WnDKvti8CfC4fBq4T96icyTFs9SrLB7NT/Dh6dn5P/RLUtceRmI9sjqa42p5zRQEkX+6
 xwU6sraXqiNbteg6a2Sds83H3VdKwPxsRIJ8XpRyWr0i1LHYHpOu7zRHypdGI7NMZ6wo
 Mpgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724683064; x=1725287864;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FmMudQYyqBmimm3xczhRkeejLn1X7G9r5bwiVF5cHfM=;
 b=eDqy+0F2/SuENcB3zqlG19EXW3NWE4ccduTYDWrMjoWQpOSVMEVWVKOg3Lf8/Pi1tL
 bGQh4aR0HCwewJO0D9RPz+WSkL78h5MbgilOSs9+YjSjdn+Hj8tCzKT91ecUy1tPbFq5
 Ktx+eqpR05wv7hP4qNbVOvYM+NUKXnEiuY6Cln94qQqhrBo0fqobMuti5YtdPS6A7G38
 eJA0jXp6lRKf2EuzAokjbi4IU8PUwYzHKtdDFs8MCetEJAldxmeMRPjU0+m5P+IO76eO
 Id9YhqTYrdirZDaF54HTxbiv6W92l+zxJeSZYSinwt5ayPXgjNahEaHeMwQBlLb661zz
 8TSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2NctyaYyX9FquWL7CqX8Qjgi+csWGOzRMEP5uOmJ2+/sNmERiAt5Z37ok7QyLrplMTV7vu9o=@lists.denx.de
X-Gm-Message-State: AOJu0YxioIYo9bMHpGO56vqSd8r/+kQQLyre73G1jNwjXGlK0xMtP06L
 a9z0vDLQuEWidmh2z5JW6VSYZmBVk4d+VZRxG6kUdv7P7Bu1kFPbWYdttzkjWdFCJh5HvlHSU9T
 ST75ZFlyUaXw4Qn0hzSxuWcPQow53VPweDlAklg==
X-Google-Smtp-Source: AGHT+IHWHCeDddwZ2PCBCM3OGhHqCWTE6HixkGBUBmF/XI6nkmxB0Dbm/DVtxwRGIPlwnqShRyr9hIeujMa9MN0aarU=
X-Received: by 2002:a17:902:d2c2:b0:202:45a7:84d1 with SMTP id
 d9443c01a7336-2039e51b728mr111130115ad.52.1724683064195; Mon, 26 Aug 2024
 07:37:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240809-b4-dynamic-uuid-v7-0-8c44ab1f06a5@linaro.org>
 <20240809-b4-dynamic-uuid-v7-11-8c44ab1f06a5@linaro.org>
In-Reply-To: <20240809-b4-dynamic-uuid-v7-11-8c44ab1f06a5@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 26 Aug 2024 17:37:07 +0300
Message-ID: <CAC_iWj+VH6UisiUUrRJd-1VgjavkB4nrbTAgCcxm3j1RZTqLLA@mail.gmail.com>
Subject: Re: [PATCH v7 11/11] test: lib/uuid: add tests for UUID
 version/variant bits
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de
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

On Fri, 9 Aug 2024 at 03:56, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Add a test to check the version/variant bits of v4 and v5 UUIDs.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  test/lib/uuid.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/test/lib/uuid.c b/test/lib/uuid.c
> index 2c6cfd42ddc3..bbaf821f007d 100644
> --- a/test/lib/uuid.c
> +++ b/test/lib/uuid.c
> @@ -43,8 +43,46 @@ static int lib_test_uuid_to_le(struct unit_test_state *uts)
>  }
>
>  LIB_TEST(lib_test_uuid_to_le, 0);
>
> +#if defined(CONFIG_RANDOM_UUID) || defined(CONFIG_CMD_UUID)
> +/* Test UUID attribute bits (version, variant) */
> +static int lib_test_uuid_bits(struct unit_test_state *uts)
> +{
> +       unsigned char uuid[16];
> +       efi_guid_t guid;
> +       int i;
> +
> +       /*
> +        * Reduce the chance of a randomly generated UUID disguising
> +        * a regression by testing multiple times.
> +        */
> +       for (i = 0; i < 5; i++) {
> +               /* Test UUID v4 */
> +               gen_rand_uuid((unsigned char *)&uuid);
> +
> +               printf("v4 UUID: %pUb\n", (efi_guid_t *)uuid);
> +
> +               ut_assert((uuid[6] & 0xf0) == 0x40); /* version 4 */
> +               ut_assert((uuid[8] & UUID_VARIANT_MASK) == (UUID_VARIANT << UUID_VARIANT_SHIFT)); /* variant 1 */
> +
> +               /* Test v5, use the v4 UUID as the namespace */
> +               gen_v5_guid((struct uuid *)uuid,
> +                       &guid, "test", 4, NULL);
> +
> +               printf("v5 GUID: %pUl\n", (efi_guid_t *)uuid);
> +
> +               /* This is a GUID so bits 6 and 7 are swapped (little endian) */
> +               ut_assert((guid.b[7] & 0xf0) == 0x50); /* version 5 */
> +               ut_assert((guid.b[8] & UUID_VARIANT_MASK) == (UUID_VARIANT << UUID_VARIANT_SHIFT)); /* variant 1 */
> +       }
> +
> +       return 0;
> +}
> +
> +LIB_TEST(lib_test_uuid_bits, 0);
> +#endif
> +
>  struct dynamic_uuid_test_data {
>         const char *compatible;
>         const u16 *images[4];
>         const char *expected_uuids[4];
>
> --
> 2.46.0
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
