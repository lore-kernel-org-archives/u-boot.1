Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B53C982DD
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 20:45:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BF36760BB7;
	Fri, 18 Sep 2026 20:45:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q9h4pInc9fI2; Fri, 18 Sep 2026 20:45:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org F2E7960C0E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789764345;
	b=Wgleb2ksfhZ7x4yrRl6uEzLwnTYMUC4I0JlZylfX9cR3sl6ur8D6snPq0YFiZO0SDvva
	 mw0iJFBUS29fBEqdtWYm8oUPLgHZxTQOHmcfOf+BmUVZhmroeiL61rzntcUb9X6f7n4Sa
	 pgaJKTBcFbAvpwZ2cjppOVgE+5arhARMY+w7NtWnWR6+t30XTcuPODZBHplchsJM2piVz
	 G5cbN/huYF4eUqq1XanJWfOYTD9ockwC8WNTSNeIltfdvaJrK3MU2rUCvZ+jcaou/Ia9X
	 m+IUyjSP94bz1d+zM9viBIz6jpUo049ShJJ210G7p/byulOsxWYp1nddHZZn8uPInOg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789764345;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dF1zYMeDNPsIkv3BsYlmi+JSWYAqdmT8eWjtQ7RhbKw=;
	b=otWpvW8AcXiMstWUutzPrw9NHNWNFa+wRRCnBBlYnNl/4LY8OgeAk1uI8IkLsWoB+RBo
	 LtfNBKblnPlpfn9SDoe6bqjxAFaWCR/z6IBBx5FfBd40cH60YQ5YaXMzOIQXaSiHdW9JG
	 58BuLd2qJ5x9QkgEP5uNw360Gqw55oLewVsDyE0vfZ6hPdGTGTOxERUaQJAvhW96rbUkK
	 oSymPnXqqhmE+a4ugik74mdUBoZPDkAE+5JXoSdI/AMGtaQerI4VmoP1/Gfu+SlY9eLXv
	 42eqAUE87QSqGP8BbL946dccxIWinisgKlompAEpm1GmNHOei8o/UnW/mmh6/TB50sQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789764345;
	bh=dF1zYMeDNPsIkv3BsYlmi+JSWYAqdmT8eWjtQ7RhbKw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Lkj3W8HMweD8B3gOGW2/PTHa8K9EHGs2lEeBe4nHi+rs1Q1M4U37kSrKqm5ARlDV8
	 KVd2IrIAlB1GNc79XhfNej4GGf5rWWgyyoCqKq5Gmhi0grJC4Y0vfS/dTtveTVYHr5
	 9P0IR+x4esovDu7bF3NCX4jHvZQTjJYpqR5F2YtcO8jPTFj4aW1lleTdhSqICK9wtR
	 5XmD+zRyE1dtXmKCeWfuznTlrME7GgZSSUfcid8UUiJ/J+2uyYpg8DN8JE+voFAHBF
	 bs8K1PGmbTBMfP16znc0xTHBSMNOABXgaCz2xb/EovrAIcuyD3eZfQWdmfIcOeyFS+
	 SKmVUvAouTiNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F2E7960C0E;
	Fri, 18 Sep 2026 20:45:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 69AEC25B
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:45:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5B2FF4006F
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:45:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4Si-KV3yFbh3 for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 20:45:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 614F640022
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789764342;
 b=rXDFN1cEq5woIVvaAgFURGmzMYLUu9IRLLj7RrKx5Ddsj22+W+wPaf246w/SEqGAEG2c
 Hck3SeYJH8BCVKZKefXEBTywAKi+oBiYG3Z/n4h8Ffl8wSXICIMnECo0eyOIiMCyDOSVV
 FsruMf6EwRP3IfV69bnpixkdRtVcfm35Mf0wBP70YWX32Jlq8GeejZxC3tOhJNyJE0+b3
 qiaYocqu8jIpa8BK57Z0HnXDPEADbI8B7cR0iktl6r3TFgFRULx8lYETNDKW5p/5wHOfQ
 UCF3TIEmGlS9R5Uhlib6gDYDfEfbXXUaVeCFvoTOGq3dnD3hWIY09671cpSjGXIeymA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789764342;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=dF1zYMeDNPsIkv3BsYlmi+JSWYAqdmT8eWjtQ7RhbKw=;
 b=GTCKf5rjNS2laLwyAGXZPH4DC2ss6rGmIaO7WImcDtyvTI2/rf8KoXzPaxoPL87Xrsa+
 Hx4D3nL///m3d/BQgKzYffIPDs2kNCJpYjJ2YOHKPTHlRi8q1Z+oH/kYzaRQ5V98O5FD7
 GBHMuZHqlPLeQjDi3fyN8AHV+otsZ6QGHqbKnLWQ009hMW3EedqCNJHv/oDIUhcwpng3i
 iYUSdA3vXZLo/denecnDzMSpgjesQxe413EC5irmkb3w8Ls4vRYTOgc+swhMwQdmX3jUC
 t3rzO3prWMnsH8Ybl6dqB+zaDgZAp4DgO/vnY3+XsMia8vdQTmiA+SjPTV54cwcKKyw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=cAmz0zP+; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::10; helo=mail-ed2-x10.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=cAmz0zP+
Received: from mail-ed2-x10.google.com (mail-ed2-x10.google.com
 [IPv6:2a00:1450:4864:33::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 614F640022
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:45:40 +0000 (UTC)
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a98dfb8002so1736365a12.2
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 13:45:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789764339; cv=none;
 d=google.com; s=arc-20260327;
 b=jQfgLp6iofTvDhEyM3l5+QPYvH/TeiwAXD9JYBoig826x3IqQ16vzwrzuOpkIRJaNT
 u9vxiBD9FubS1GB/KG/XSp+XZGTHUKiTIhZf6PjCyX75QS75jKF1lQNloorBaLv5Z7XP
 t9kWkSMGGSVh4mhhJwFlWVfobvFM2MYxpKNKgCKczui6NXTiA+5YUZuMZX1/awltZphQ
 3uGDIgTIF3qxCIdP9lF3D5HB85s58Dv7IU56e5XnYx/ms5FW6ew1l7hnltf92vWl/Gby
 PiYyokKUdSyj46wUm1q5NA66YKZFIF4K0Fnvq+K+344CeyZChKhxPJwHBS7Qx+tlxByp
 w5Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dF1zYMeDNPsIkv3BsYlmi+JSWYAqdmT8eWjtQ7RhbKw=;
 fh=PijMMigzg6lqgX8gnr59GS8viHousaoER8Lg/oDDlYk=;
 b=cdzv/c+VMu/urRp8rxoQ67AHSL6uvNMtxHp93vHC94OBVvC9OOA9ez8mOfjvD6KDdh
 ZAC8ztTwsDnk4h+ze1oqzCGLNiQEV5YlVendTTze9XFFSxnW2xcylkFIidiEqYaUInHE
 AZKqWxtjU5xDgAo1UbL6bEV/HgHXN3mhkytK7iAqe/yLgmvlM/Pa/DROY8v+CH+Vhe2N
 6LVN+SQbr0rFWCZi1V8n/s1WjfjpOI00Va6QeF6G4EOIyLPY5XqDx0BwlLxszSAMIpj0
 rlenenjdZWPj2vxE1ATmcoiEhXUmC270WPjoRbYOtPVBL4qkvR7yGjtQuc3VPKbFP/jZ
 tDaA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1789764339; x=1790369139;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dF1zYMeDNPsIkv3BsYlmi+JSWYAqdmT8eWjtQ7RhbKw=;
 b=cAmz0zP+jj1RH8oV+ge8+08Y7HGzG3Zd1JpeuNhXSCHFhBcrACl1d17OOajDKd7OLg
 UvtOUbatjxG62KkrjFg5TPvXPrpbqXLHQqkHf+RpLMvLxnyAFaTqq7jkyxPzPuEQey3M
 2dYTb8xcgN4PxhST0tlt1dKEydQhidGhvFwzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789764339; x=1790369139;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dF1zYMeDNPsIkv3BsYlmi+JSWYAqdmT8eWjtQ7RhbKw=;
 b=AXV+jocxNEha60uz9t3Hmhnj5jXsm7FzYcX4fCKKqKBaGpRTLzHttgkrxea0UFIsQM
 TBALMrlsgBcoxUWmxcwTjE6wnqHrLw4uPSaKLR+7D7Ze/3ow0O0Pw5UBYuNuEGNmiXil
 MJQHCyYFvLLalPmKtzIOvdhmsRI4v7f3Xf5bVxI+VTIxDeHjJrNDptwSxdOP3RpHkBAJ
 r1MzMW8lXusGUBtxwYJGtBZ/1Bg1lvkOGT3r6dYO8z5Bpwr1SX4nckUd5+HKyW10saK0
 eAitQjKxiBQlCtXWbM3FnwrJil1XGv3o5gf4ODXWTl0/Xq0AhmeIgP/teYKrIB5uIQur
 uKVA==
X-Gm-Message-State: AFuF++l5yBkjjRCd7YUuo+pFYQYSvYC++2TU5i/ur2iO0LKmVXRTr/iu
 lCc1bXHA+MZ4c4KFRbamY5jdSGTluBRyR34rJYAayv/e3mR9Hun2YJNd+XEUMvP3O8d1en5Cmcb
 chy5g3h0HdYPIpxrwJPiWubwTLsnmGikXaYqwvBf2vWwvXH+aD35tgSTG6Vc=
X-Gm-Gg: AYBFou2PU5E4ygeO9viOab6tvwQwLIjfcf/oXz1750pwRg8b5HZBya82r3x1hdIkeVz
 DRKTJaZS3avDrc0yAY7HBQDpDRiW8uofe/GJnaP22QlfG0SozAM/AOi9duPTgiVC9Kvx7RGj/Kx
 Bdt0XikDnnZe0VHP/lsxV+KL387gMYtWhwMW2VFtcirVpLrVNULHPpFJe69pIy1sU7PcxkgkNBg
 vHa5l0TdikbTBxF3ywpOJFaa7g+4cprJ8x/wRl39RpLlXczD3j0ZfqCpzkEnRbIJgHJ7iV8/EiG
 bHErW+xP2HveYqOMeu1pX0sRCsJAy9Lm51N++rg6OObyQ8lf2AaY06U5wc8znRDzXhqs
X-Received: by 2002:a05:6402:380b:b0:6a9:aabb:5364 with SMTP id
 4fb4d7f45d1cf-6aa54601be1mr2338904a12.11.1789764339039; Fri, 18 Sep 2026
 13:45:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260831142800.25966-1-aristo.chen@canonical.com>
 <20260831142800.25966-3-aristo.chen@canonical.com>
In-Reply-To: <20260831142800.25966-3-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 18 Sep 2026 15:45:26 -0500
X-Gm-Features: AcwNN1UoVHX6spZLitqN5biHsbF49sQP2_RJU3ui2wrY4x5I1qbGysv2NFy3WwA
Message-ID: <CAFLszTj0H71E8K8mJS_Oc6dtvPTeQT9m_7A++91XL_H=SkV3hQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] test: boot: Check that rauc rejects over-long slot
 names
To: aristo.chen@canonical.com
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Martin Schwan <m.schwan@phytec.de>,
 Denis Mukhin <dmukhin@ford.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Aristo,

On 2026-08-31T14:25:38, Aristo Chen <aristo.chen@canonical.com> wrote:
> test: boot: Check that rauc rejects over-long slot names
>
> Boot the RAUC bootflow after setting BOOT_ORDER to a 33-character slot
> name, one more than fits the "BOOT_<slot>_LEFT" env-var name buffer. The
> boot must now fail with -ENAMETOOLONG.
>
> Before the previous commit the name overflowed the stack buffer; as no
> such variable exists the boot then failed with -ENOENT, hiding the
> overflow.
>
> Also check the accepted side of the boundary: a 32-character name, the
> longest that fits, must pass the length check and fail only with -ENOENT
> because its BOOT_<slot>_LEFT variable does not exist.
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
>
> test/boot/bootflow.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)

Since the boundary is boot_left_name(), please exercise the scan path
too - distro_rauc_read_bootflow() calls it against
CONFIG_BOOTMETH_RAUC_BOOT_ORDER, which is what a user is most likely
to hit. The current test only reaches find_active_slot() via
BOOT_ORDER at boot time.

> +     /*
> +      * A 32-char slot name is the longest that fits. It must pass the
> +      * length check and fail only because BOOT_<slot>_LEFT does not exist.
> +      */
> +     ut_assertok(env_set("BOOT_ORDER", "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB"));
> +     ut_asserteq(1, run_command("bootflow boot", 0));
> +     ut_assert_nextline("** Booting bootflow 'mmc10.bootdev.whole' with rauc");
> +     ut_assert_nextline("Boot failed (err=%d)", -ENOENT);
> +     ut_assert_console_end();

> diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
> @@ -1520,6 +1520,29 @@ static int bootstd_images(struct unit_test_state *uts)
>       ptr = map_sysmem(img->addr, 0);
>       ut_asserteq_strn("BOOT_IMAGE=/vmlinuz-5.15.0-121-generic root=", ptr);
>
> +     /*
> +      * Boot with a BOOT_ORDER slot name (33 chars) that is too long for the
> +      * "BOOT_<slot>_LEFT" env-var name buffer. It must be rejected rather
> +      * than overflow the stack.
> +      */
> +     ut_assertok(run_command("bootflow select 0", 0));
> +     ut_assert_console_end();
> +     ut_assertok(env_set("BOOT_ORDER", "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA B"));
> +     ut_asserteq(1, run_command("bootflow boot", 0));
> +     ut_assert_nextline("** Booting bootflow 'mmc10.bootdev.whole' with rauc");
> +     ut_assert_nextline("Boot failed (err=%d)", -ENAMETOOLONG);
> +     ut_assert_console_end();

This is in the wrong function. bootstd_images() scans
mmc2/mmc1/mmc4/mmc5 and produces the four extlinux/script/cros
bootflows listed just above; it never binds bootmeth_rauc or enables
mmc10, so 'bootflow select 0' picks mmc1.bootdev.part_1 (extlinux_cfg)
and the expected "** Booting bootflow 'mmc10.bootdev.whole' with rauc"
line never appears. Please extend bootflow_rauc() (or add a sibling
test that reuses its setup) so mmc10 is bound and rauc is in the
bootmeth order before 'bootflow boot' runs. Also restore BOOT_ORDER
(and the bootmeth/bootdev order) at the end so it does not leak into
the next test.

Regards,
Simon
