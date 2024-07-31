Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FB7AC3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 14:40:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E7CF88A46;
	Wed, 31 Jul 2024 16:39:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MDHWLhdf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4DC488A52; Wed, 31 Jul 2024 16:39:07 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B66A88955
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 16:39:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6b78c3670d0so30875156d6.1
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 07:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722436744; x=1723041544; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=C5HhrosqXm4ClS8B3IVqtxDyVD7pygGqnHlne/eKFVY=;
 b=MDHWLhdfGDxGMyWRqPt3Cdql1fygAhsw0pgdTwuOXERQMFu1BF/jCPf2Bhvn4C2ie3
 2zr14cAk0oEkdaHlwfJgVnX4i5YBKnK8Dw8QbsFFq7zLNjSz8h9joWmrTj2q0HZa4mfH
 aCWhd3t0ov6qKWJ2UZK9xZDSFo8udSEcQqNys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722436744; x=1723041544;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C5HhrosqXm4ClS8B3IVqtxDyVD7pygGqnHlne/eKFVY=;
 b=IoQ6zUdQb074VmjaEJGR1Nv/lGku9U40iIAacJIanyt+BdRSCr2Y4/nsnQllfSm9I0
 jVn35s6XZCywOAhIwu42UWWkKIJs7rIa5mhJJRBmaX3/KEoUsQlF69VF53XupQAPpqLP
 NnDO+4pFQocD0+byZIlE2nwEdYNh0U4TAYBw4XpiVPm7ERIx70XWsx9OcdU5ar6JtauQ
 2q9VCgO9ktvhJbYjYld/lGkvPm3t1fph+HNBX74mwkpMecfpoMTrcSlXaOGMryIWZBZD
 WrxUXIKak/Fq5dhfP1P9RclMG04+1zggB8BuqfuZmHExsHV8GGNGE+2EGuxhmEVkqT9n
 jz8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7zEmnV4/nSuNy2PpaWNPT0ZoCwMvElm1PHxfqXTxUCCe+cgofh+27DBGBPFPj9ToP/+Ov3k27vouuu+g3Qeyu9iSLTg==
X-Gm-Message-State: AOJu0Ywqf8lX7eGsWXiK8IOKKzrRerwCJVaQCUoW3qeCH9tiOd5lLXMe
 4vtMUfHLnRezxrlcjhHuhzj7AgoHP8SEwLdf6R9+++iYc7IAsvR6esxPWvhXDf9VWQE+4wperTn
 zklqV3CEoOmJWv8sRofiGxkq1fBF0akzpAtBA
X-Google-Smtp-Source: AGHT+IH2FXF//SXrKYoi96zuYM872iWF3+tVs3jo9xV3TP5sC45sbWPiJy9LLyvqMnu//2ShWESrNoxidox8d4Mu7H8=
X-Received: by 2002:a05:6214:4119:b0:6b4:b179:8eea with SMTP id
 6a1803df08f44-6bb5597d3bamr154251826d6.3.1722436744350; Wed, 31 Jul 2024
 07:39:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240719-b4-dynamic-uuid-v5-0-8a83de3fe3dc@linaro.org>
 <20240719-b4-dynamic-uuid-v5-11-8a83de3fe3dc@linaro.org>
In-Reply-To: <20240719-b4-dynamic-uuid-v5-11-8a83de3fe3dc@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 31 Jul 2024 08:38:53 -0600
Message-ID: <CAFLszTjx4fNnhmiAmAVq45jPNPmik8YcHOf8LGWC+SZ_5=j5Aw@mail.gmail.com>
Subject: Re: [PATCH v5 11/11] test: lib/uuid: add tests for UUID
 version/variant bits
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mario Six <mario.six@gdsys.cc>, 
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

Hi Caleb,

On Fri, 19 Jul 2024 at 06:43, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Add a test to check the version/variant bits of v4 and v5 UUIDs.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  test/lib/uuid.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/test/lib/uuid.c b/test/lib/uuid.c
> index 2c6cfd42ddc3..63d36e120623 100644
> --- a/test/lib/uuid.c
> +++ b/test/lib/uuid.c
> @@ -43,8 +43,44 @@ static int lib_test_uuid_to_le(struct unit_test_state *uts)
>  }
>
>  LIB_TEST(lib_test_uuid_to_le, 0);
>
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

ut_asserteq(0x40, uuid[6] & 0xf0); /* version 4 */

save below

> +               ut_assert((uuid[8] & UUID_VARIANT_MASK) == (UUID_VARIANT << UUID_VARIANT_SHIFT)); /* variant 1 */

check line length

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
> +
>  struct dynamic_uuid_test_data {
>         const char *compatible;
>         const u16 *images[4];
>         const char *expected_uuids[4];
>
> --
> 2.45.2
>

Regards,
Simon
