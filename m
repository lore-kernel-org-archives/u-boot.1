Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46226C43458
	for <u-boot@archiver.kernel.org>; Tue, 14 Jul 2026 12:17:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A65D84D0C;
	Tue, 14 Jul 2026 14:17:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NjBE5/iL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C907784D16; Tue, 14 Jul 2026 14:17:38 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E8BD84CEB
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 14:17:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2cc7e86e7aeso8098615ad.2
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 05:17:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784031455; cv=none;
 d=google.com; s=arc-20260327;
 b=HgmMvk4l8DM2KG2GdTYgrAv4vjx2mqQLBJBJw0pRwFAQCHJhZ00SAmbTqm5nJyQz/U
 ZWaNtNZaDwP49OFhKoumNVdBtkqYPxQLo6e8ryEBC6J+2DNsrhs0gYmXJRNA69OAvb71
 lB4RWh5Nl0Vw1pbxUEP7X4xlCP2I5lkiN7zqu7nHoFFhFmToNthQlpUvon8Kr9nn6Fdh
 dZb/IyaM45ZqjHZRu09BFk8PRuEmT69XugOYclMFBVnwgbocx0qzzEuPim2KraoOC/RK
 1YzTmxSl9irdeLksMYcd+8Yl46zCdGo/KKhBkTHYNIVUZkYUEmuh7wRrKKU2yhAFQnBM
 FqbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VWvl65PdSduhp0gerFOBNHvdiFAFb34nndxbe4l3Yps=;
 fh=aKO+wj1tXSCvsqO6STvK2Xycn+f4kyHxGj/G0aaEIPM=;
 b=lrZntgdCnHvAu++GFgfTXre0Z8JOG5KzboOt0qqk2i1maCOeFWlzk1l3xnJ7h0i60h
 Wemub6RcLDTNPw3G4usCNiiuwIm4ID2JzK2NNTbznt5EOFBvrXFIHQsndDmu+oaCLJC5
 jIvh0mv4zEtzlAdeRURaRtIs4e20fWAvyR0SqWl6D5bkHe3pvLzG7gKxtuz7nZZjtMmJ
 MdoXXBR8L4zGqSyCgKZX9MoAY4HYUo/z/EJml5z/zmh4wZioQvzNFEkbpHfh4AngiYX/
 oE3KE2ozgEShmw3j6R45gq4Z24sK/w7XkchYkLEbgig7Ih7qb+tq8J+wF/EycsYTBAUq
 vQiw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784031455; x=1784636255; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VWvl65PdSduhp0gerFOBNHvdiFAFb34nndxbe4l3Yps=;
 b=NjBE5/iLpw3fzUaT+N/Paf0ea7t2eIX4+0CrBpX2+sCYLxmbWHE/JsdLlpWJTtgKSj
 LsbPpCc8e2sdF1FWGVjNvuREyLD/Y8pK4+QgtT3ORa4BfH3z9Hn8X8h5QmRqpufRWp90
 NEKHhtDhDRpS6YKQGffWk0ACurVL+7AKlHBtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784031455; x=1784636255;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VWvl65PdSduhp0gerFOBNHvdiFAFb34nndxbe4l3Yps=;
 b=RTdlHKmL6W/TXQ+WdlL2X1Cpg9LubYaU14+1Hbz4OxwwibK1Qe5EP0PVsBPSLiI1dP
 1/zkpqxP3zvna5fS08X8P5Ba8JLTn4SDXGI1V78DOt736WyZLDbDV7jdN7lq6q09+oM2
 Tk7umq+Lk5sV+Uzmoegax66XiQ5o15jCC+7P4k5p6ZSLQsPxgCClf8IKbTZgqDgSD/u0
 QiF5M9EYE3imJu1Hja0QXpf1HJWQNlZbcPn8XRphYrl64iCqaPTRwR2XCdGXKUej3fqF
 G6Ka2lIf+XKsmp7D+iH26NIrDJXrtkumjPHeei59sFTAPeGiXAA14uoQ6rUdobVazrVv
 xerQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoUXeu/wJcivh2kFbjnvv9V768y26OneWJY81EdTLl/qxt7ef0Qe0mQGLIOrRMPx3JmIcZAkzE=@lists.denx.de
X-Gm-Message-State: AOJu0YxJsDouIJLuNAqg81NHqzI7r+Ru37rZRqOvF0ATrI7q843o91bs
 QC/bkNjrn+d38xrfqrhe9KdE5ATBntQtYYT4pZtmfZ9A8yDMaD5yYdZTeMMypjAX6DIqNJ1v3x4
 UZXgC7LL538G3oJ+0JVZIB9BpYD6YOsda5kTsRMmK
X-Gm-Gg: AfdE7cmafTKzgvsK7zGkWI+TtRx01RkGMAQ2grJGBawKsaMmG8RgY0ee19xjnQ9zim5
 XlNAwY/d1lyuJB0EyskGoxx7s5DH1IANKQUIT/CL+n6LAzfcOOXWml99g2+v69TIRAAV//56ql0
 xchz4lRWDHca+p4nZe7+2u/+noDTyzl2Q7u6ZsQFH7lXWpTE0aQoAFEjOhQnUBh4BMcRihzeQfb
 4Bxqdv+awEDnDO7mJcAHnrSo2N/cg0Fh8lgEtb5/TRecXNlFu606jLuGZxYcmo85u9z8uJbW3Q/
 aCECaA==
X-Received: by 2002:a17:902:f68e:b0:2c2:cf20:213 with SMTP id
 d9443c01a7336-2ce9ee1142emr140232485ad.29.1784031454811; Tue, 14 Jul 2026
 05:17:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1783816074.git.daniel@makrotopia.org>
 <4adbf45f0d33802ebd2afd627f639e47c6609e17.1783816074.git.daniel@makrotopia.org>
 <20260713220842.GY749385@bill-the-cat>
In-Reply-To: <20260713220842.GY749385@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 14 Jul 2026 06:17:11 -0600
X-Gm-Features: AUfX_myJK5CEBwMn-XiWN4FFtrmdZCUUuOoD0Jse4VMjHCATfA-kg6OZiAP8-T8
Message-ID: <CAFLszTjfcmPuUnmVg60pVzsnzSm0kPn3zLL7GMkCTpUyHCQUZw@mail.gmail.com>
Subject: Re: [PATCH 3/3] test: fit: verify dm-verity roothash is covered by
 the config signature
To: Tom Rini <trini@konsulko.com>
Cc: Daniel Golle <daniel@makrotopia.org>,
 Ludwig Nussel <ludwig.nussel@siemens.com>, 
 Anton Ivanov <anton@binarly.io>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Marek Vasut <marek.vasut@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, Randolph Sapp <rs@ti.com>, 
 Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
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

Hi Daniel,

On 2026-07-12T00:33:05, Daniel Golle <daniel@makrotopia.org> wrote:
> test: fit: verify dm-verity roothash is covered by the config signature
>
> A dm-verity protected filesystem image is not hashed by U-Boot; its
> integrity is delegated to the kernel, which trusts the roothash taken
> from the FIT dm-verity subnode. For that chain of trust to hold, the
> roothash (and salt) must be part of the region covered by the
> configuration signature, otherwise an attacker can replace both the
> filesystem and the roothash while keeping the signature valid.
>
> Add two independent checks of this property:
>
>  - test/py/tests/test_fit_verity_sign.py signs a configuration that
>    references a filesystem image carrying a dm-verity subnode, then
>    confirms that tampering the roothash or the salt is rejected by
>    fit_check_sign. A control that tampers a byte known to be signed
>    proves the check can fail.
>
>  - test/boot/fit_verity.c gains a runtime unit test that builds the
>    exact node list the configuration signature is computed over,
>    turns it into hashed regions and checks both that the roothash
> [...]
>
> boot/image-fit-sig.c                  |  25 +++--
>  include/image.h                       |  25 +++++
>  test/boot/fit_verity.c                | 194 ++++++++++++++++++++++++++++++++++
>  test/py/tests/test_fit_verity_sign.py | 162 ++++++++++++++++++++++++++++
>  4 files changed, 399 insertions(+), 7 deletions(-)

Somehow I didn't get this email, but I'll try to reply here.

> diff --git a/boot/image-fit-sig.c b/boot/image-fit-sig.c
> @@ -340,8 +340,19 @@ static int fit_config_add_hash(const void *fit, int image_noffset,
> +#if CONFIG_IS_ENABLED(UNIT_TEST)
> +#define VISIBLE_IF_UT
> +#else
> +#define VISIBLE_IF_UT static
> +#endif

Tom commented on this, but I'll just add this. Linux has
VISIBLE_IF_KUNIT but in U-Boot so far we just stop the static when the
function is needed elsewhere. LTO can be used to avoid the code-size
increase, for platforms that want it.


> diff --git a/test/boot/fit_verity.c b/test/boot/fit_verity.c
> @@ -304,3 +309,192 @@ static int fit_verity_test_bad_blocksize(struct unit_test_state *uts)
> + count = fdt_find_regions(buf, node_inc, count, NULL, 0, fdt_regions,
> + ARRAY_SIZE(fdt_regions) - 1, region_path,
> + sizeof(region_path), 0);
> + ut_assert(count > 0);

fdt_find_regions() can return a count larger than the max passed in,
meaning the region array was exhausted (see the 'count >= max_regions -
1' check in fit_config_check_sig()). If that ever happens here,
fit_region_make_list() reads past the filled entries. Please can you
assert that count is within the array size, matching the real
verification path?

> diff --git a/test/boot/fit_verity.c b/test/boot/fit_verity.c
> @@ -304,3 +309,192 @@ static int fit_verity_test_bad_blocksize(struct unit_test_state *uts)
> + /* Tampering the roothash must change the signed hash. */
> + ((u8 *)digest)[0] ^= 0xff;

You already have digest_off, so you could write to buf[digest_off]
instead of casting away the const from fdt_getprop(). Both work since
buf is writable, but avoiding the cast is cleaner.

> diff --git a/test/boot/fit_verity.c b/test/boot/fit_verity.c
> @@ -304,3 +309,192 @@ static int fit_verity_test_bad_blocksize(struct unit_test_state *uts)
> + digest = fdt_getprop(buf, verity_node, FIT_VERITY_DIGEST_PROP,
> +      &digest_len);

The python test also tampers the salt, but the unit test only checks
the digest. Since both properties sit in the same dm-verity node the
coverage result is the same, so I don't feel strongly, but a one-line
comment noting that the digest check stands in for the whole node would
make the asymmetry clearer. What do you think?

Regards,
Simon
