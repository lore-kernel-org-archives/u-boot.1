Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95F8606A320
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 13:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=x+bbmbPR;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=uwJqtC0e
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4248A81164;
	Wed, 18 Nov 2026 13:01:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c-RZbtUMVjFv; Wed, 18 Nov 2026 13:01:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CDDA081140
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795006891;
	b=oPuCBARrj2CCU6dAMdKPhlnxQnUI+kpK9FekA0Jkjx6Q1vfXS4Uan5fEjPPZdAG4vlR6
	 lo5X4aQvodZfhqVS+2MZ4xt0nML75keENtysNlo6WIW5ZHm9G8uDrpYcv3iwIjDEMVSvm
	 jgeHdz2e4YubGU6lnc8nGVDNOq4PKgie5W5MBcJ3wXWds8jSUED7cHvh+T1k7wK1DBRnK
	 7e4Tm6MNPmixA1uB4AHjApoS3mY65cI2JDDRBMGrfU3RDzBMU7k0ubf+V+rmDoPeCKDQM
	 KGgNwe/PK8oZsL8Wsw4zCcXvyTaiQi/OVW9e/YzF1tDODP+HE/H74tyVXdC36LHDc2A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795006891;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=TC+oaak1n9HrWdmTAZGCDjnpmunxc2YqjFatCiNXuYw=;
	b=PMO2F9z3iu2II9klhHuFtGx1ZUbqVwHEFLvBNt2IcXK9fdZV7m6GYEDkIcP91yqDTDPf
	 gXSOfsn++2qLzFrLwbjXA2T4WFnQATkhL2N6F+1rYKdGB2sAttyWKLSXiuYbq8CRFOvLG
	 OHxdus2eBzcXxH2TAQaXk4LX+UsNR/WqmTwtUDlr8rW1Vfb3/bXjDsDyIrPYTSgApUTKK
	 Fln6fqUW6RbYoQgRWP9eqMhGBSsNl6m2fll+oVmT36CaUvEYL3DlLiyQ9ExQmR1NFe9Nw
	 w2pdukJM6R2aS7O9MueDy5dQ1ts0J1Yliw2hB+E8y2B+2+UzKg66et3FADVfOJmCBIA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795006891;
	bh=TC+oaak1n9HrWdmTAZGCDjnpmunxc2YqjFatCiNXuYw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=x+bbmbPRH+oQuBEMPgcHtOAxAYURwby6U/S6Ij+6h9cFwE4jFQvW+u72mEASFRTaY
	 5NcpvYNSahHqeAk75p+/rc0sk81mw7SuWqZyqL6fGXX5A/MWpRHGKFpAecuE+51+gy
	 uq9msez/YFqpAEfkA9BgbnPT1+f9Kk5Tlsw28wqP7R+I0Vi69ifsfCYb9XgzISkpJk
	 6KxEhoXsvLLySFeuUgSz257SbmvgVZJjaJDaX81rlfaWPDIInk2imLSXFIdJ6OrE+1
	 udrCTFAixVt02pCGQ5G5hg3898egEDc7Tow1U/Ly3ctty048l5jYoTEIpwwqANMf/7
	 IL5O7FjMtnnRw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CDDA081140;
	Wed, 18 Nov 2026 13:01:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2E59A49B
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:01:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 14821409DA
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:01:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3A25KLfbeRo9 for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 13:01:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 62C9E409E3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b129"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b129; helo=mail-yx1-xb129.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=uwJqtC0e
Received: from mail-yx1-xb129.google.com (mail-yx1-xb129.google.com
 [IPv6:2607:f8b0:4864:20::b129])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 62C9E409E3
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:01:26 +0000 (UTC)
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-67db23d8892so963011d50.2
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 05:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795006885; x=1795611685;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TC+oaak1n9HrWdmTAZGCDjnpmunxc2YqjFatCiNXuYw=;
 b=uwJqtC0etIu8owvdLMo5dye3iWbmnn9vOLsdCIIVrm48YYT6LDNhdmW8SQb0mRAlkS
 BRk1wmsS1i2c1ERc9t4rrrS7BwgquLdNOz6K2ycshxqoWm7x8969de6Q1DtD7NVm5a24
 YfzbftHSwqynp8YUpmrHPsxb4MVemmF2njP+tU0asRVXXUk/h5YtZA4gMDXWlIH7iDOz
 Br8Dup1OSwk7xiwkNaQ/T++PDydsFVka2o95BnQ0k4+c5c29D97CwK934bgexcpyPp+M
 LwZJf1NTZiZe2U7wEUX7iqkXHmJEP6LXQRbG1SyClWHZPdtO5IY/UlLv4l3l282rRkaK
 o1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795006885; x=1795611685;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TC+oaak1n9HrWdmTAZGCDjnpmunxc2YqjFatCiNXuYw=;
 b=Wg+WSotN5p/ozrP+RuWqJYW8VWGBF01Pq48PPx83Anz/rbEr8r/O2ffxKRjBEq4Imf
 0+WvbUiuELkm0PkHIqamgjpZe4k82GpX0BFEVmaAqww7or5+jFEVRLYt8mVp/CaMcgxt
 /3vPAn3BRNLxDzF1ly+CazOmhCBcQN0pgvisJlLzmdOkJbIq9G60C87SosPduXS9ATWH
 4DdT06uQL3kJdJ2i/VCdej4fp+10ZHhPPQbRl1hHyGfNCG8byktCIX4/LyWNB1Aajo4v
 eo9xLgzqFmX+g57t+Kltn50z2sHKfReWsJkbP6St/wcyQFUntW1VpAKKnb9LnHMcCHp6
 aE4w==
X-Gm-Message-State: APuU4Z8BbU4JyZqIunOnuNbb/aTY7N6FzFJkustLd895OWbpUBJ56FCB
 HSAd1+iuYMsSvJBKG48G6gd+wO6PwyvqTvUUHear+c58vsAle0TkWoLGPNwFyvTum0fD3p6PL6i
 od07/BM2BjfDgrJS9jJdlGKRz4rRnBISBaSUrouFclA==
X-Gm-Gg: AZFdTZfl4mPCTGCpW+jQfZbJnFOOW+KpVFx56r+LAx5YFfj+iJ9UOP7yJK3F5JUlXko
 iwUNDQz2hNOj40R5RBJYGDIzkLBLTrBCpktYINXio3dmOjhvCDca6EgVXrs6mUrE2WUjf7TaRQd
 19/0FqrvQRmtLmaxabykqO/kxNs2iu5/F2B8iam6rZV4lN0452OjcFXx3ZUiaKeO/PAPa3KKHkV
 ENH5+O6sN50xo6queX7RJJD27je5YmDV7SCIABnO6X/sQmrNSYVw58AXfAUJCao2gWBDYstRRg2
 dmYjVLbZHbL/ZO8sp9ixRN5UgTPPon2UGLe4x387EUU4qLtmS4cTPdexx6li4BRotF+c9K01EgU
 aGvdaddU0UJXiONUSNrI/yUGimXFwG9peo1PzPeD8GGoNvqn7WWh6Mods1I+yfeeUuTBTbqvSeZ
 lH+smHMfKOExDLCJj3S6SnBT3URCMXLdzmBDgasK46Lz2aPoExKkpB7MGP3TJGwI7qHU0cz1rW2
 qNdHquINrlHbjNmoVvxfu48iE+xbUxJkn0OQC6ET5+TyHN2s3tUGD+oog8DA7KFnaEX7Ft/gAzU
 0bNOrNXj+jKjwXYddng1SgBM69GBfmxNX5ZGjpZ7rTfMXG0O7vAZZ4ZGvDMjmjyrsaNkRnyRyjN
 3DVuKGSWVJn3h4xMUJQT8EAVJXoS2ZTqJ+20Hfm0QQAc8MhznFVKWKf9zaAE49duiF4AU7vVwaO
 MfN8ayaWntN8dZ3964tB3V+hW+SysZ2MdZX/Tj7vBRMd/+oAVcwFtSQdtxqbTis475EUo2Ugo=
X-Received: by 2002:a05:690e:47d9:10b0:67d:a54b:2611 with SMTP id
 956f58d0204a3-67dd3fba364mr933077d50.83.1795006884973; Wed, 18 Nov 2026
 05:01:24 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <dacef858-56d7-4708-b784-16b0133bb6aa@gmail.com>
 <608bd6ca-5dec-4f2e-a17a-83bfd3608261@gmail.com>
In-Reply-To: <608bd6ca-5dec-4f2e-a17a-83bfd3608261@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 18 Nov 2026 15:00:49 +0200
X-Gm-Features: AclHuK8TwpGHqrZ0x49sk-7NxBcHj3YKFyrytiV5O8LP2r5HTyc41b9iPoHCXYg
Message-ID: <CAC_iWjLXfmSAgd0nSrXi-OzsKq0ZwRRwACmTUcT9uWEBRqcGbw@mail.gmail.com>
Subject: Re: [PATCH v3 10/11] test: lib: add tests for the PE image checks
To: Ana Bobillo <anabobillo3@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

[...]

> +#else
> +/* The loader supports no other machine: skip the tests that load images */
> +#define TEST_MACHINE   0
> +#endif
> +
> +#define TEST_FILE_ALIGN                0x200
> +#define TEST_SECTION_ALIGN     0x1000
> +/* Size of a valid image: headers and one section, each TEST_FILE_ALIGN */
> +#define TEST_IMAGE_SIZE                (2 * TEST_FILE_ALIGN)
> +
> +/**
> + * struct test_image - a PE image at the start of buf
> + *
> + * @dos:       DOS header
> + * @nt:                NT headers, of a PE32 or a PE32+ image
> + * @opt32:     optional header of a PE32 image, else NULL
> + * @opt64:     optional header of a PE32+ image, else NULL
> + * @dirs:      data directories
> + * @sections:  section table
> + */
> +struct test_image {
> +       IMAGE_DOS_HEADER *dos;
> +       IMAGE_NT_HEADERS32 *nt;
> +       IMAGE_OPTIONAL_HEADER32 *opt32;
> +       IMAGE_OPTIONAL_HEADER64 *opt64;
> +       IMAGE_DATA_DIRECTORY *dirs;
> +       IMAGE_SECTION_HEADER *sections;
> +};

Is there a reason to open code this to create an image?
For example, in lib/efi_loader/efi_image_loader.c we check the Magic
and then decide if we are looking on a 32/64bit image.
The headers into buf are in known offsets and we only really need to
look into IMAGE_NT_HEADER32 + Magic.

> +
> +/* Set a field of the optional header of a PE32 or a PE32+ image */

This is obvious we don't need a comment. And we can probably remove it
overall with what I mentioned above.

> +#define opt_set(img, field, val)                       \
> +       do {                                            \
> +               if ((img)->opt64)                       \
> +                       (img)->opt64->field = (val);    \
> +               else                                    \
> +                       (img)->opt32->field = (val);    \
> +       } while (0)
> +
> +/*
> + * Images are built at the start of this buffer, which is larger than any of
> + * them. The bytes after an image are zero, so that they can be read without
> + * a fault if a size check is missing.

I am not sure I understand this comment. You just need a buffer to
store the image no? What size check is missing?

> + */
> +static u8 buf[0x4000] __aligned(8);
> +
> +/**
> + * test_image_init() - set up a valid image at the start of buf
> + *
> + * The image is TEST_IMAGE_SIZE bytes long: the headers, padded to the file
> + * alignment, and one section of TEST_FILE_ALIGN bytes. Further sections are
> + * empty.
> + *
> + * @img:               image to set up
> + * @pe32plus:          true for a PE32+ image, false for a PE32 image
> + * @num_dirs:          number of data directories
> + * @num_sections:      number of section headers
> + */
> +static void test_image_init(struct test_image *img, bool pe32plus,
> +                           u32 num_dirs, int num_sections)
> +{
> +       size_t opt_size;
> +
> +       memset(buf, 0, sizeof(buf));
> +       memset(img, 0, sizeof(*img));
> +
> +       img->dos = (void *)buf;
> +       img->dos->e_magic = IMAGE_DOS_SIGNATURE;
> +       img->dos->e_lfanew = sizeof(*img->dos);
> +
> +       img->nt = (void *)buf + img->dos->e_lfanew;
> +       img->nt->Signature = IMAGE_NT_SIGNATURE;
> +       img->nt->FileHeader.Machine = TEST_MACHINE;
> +       img->nt->FileHeader.NumberOfSections = num_sections;
> +
> +       if (pe32plus) {
> +               img->opt64 = (void *)&img->nt->OptionalHeader;
> +               img->opt64->Magic = IMAGE_NT_OPTIONAL_HDR64_MAGIC;
> +               img->dirs = img->opt64->DataDirectory;
> +               opt_size = offsetof(IMAGE_OPTIONAL_HEADER64, DataDirectory);
> +       } else {
> +               img->opt32 = &img->nt->OptionalHeader;
> +               img->opt32->Magic = IMAGE_NT_OPTIONAL_HDR32_MAGIC;
> +               img->dirs = img->opt32->DataDirectory;
> +               opt_size = offsetof(IMAGE_OPTIONAL_HEADER32, DataDirectory);
> +       }
> +       opt_size += num_dirs * sizeof(IMAGE_DATA_DIRECTORY);
> +       img->nt->FileHeader.SizeOfOptionalHeader = opt_size;
> +       img->sections = (void *)&img->nt->OptionalHeader + opt_size;
> +
> +       opt_set(img, AddressOfEntryPoint, TEST_SECTION_ALIGN);
> +       opt_set(img, SectionAlignment, TEST_SECTION_ALIGN);
> +       opt_set(img, FileAlignment, TEST_FILE_ALIGN);
> +       opt_set(img, SizeOfImage, 2 * TEST_SECTION_ALIGN);
> +       opt_set(img, SizeOfHeaders, TEST_FILE_ALIGN);
> +       opt_set(img, Subsystem, IMAGE_SUBSYSTEM_EFI_APPLICATION);
> +       opt_set(img, NumberOfRvaAndSizes, num_dirs);
> +
> +       memcpy(img->sections[0].Name, ".text", 5);
> +       img->sections[0].Misc.VirtualSize = TEST_FILE_ALIGN;
> +       img->sections[0].VirtualAddress = TEST_SECTION_ALIGN;
> +       img->sections[0].SizeOfRawData = TEST_FILE_ALIGN;
> +       img->sections[0].PointerToRawData = TEST_FILE_ALIGN;
> +}
> +
> +/**
> + * load_image() - pass an image at the start of buf to LoadImage()
> + *
> + * If the image is loaded, unload it again.
> + *
> + * @size:      size of the image
> + * Return:     status code of LoadImage()
> + */
> +static efi_status_t load_image(size_t size)
> +{
> +       efi_handle_t handle = NULL;
> +       efi_status_t ret;
> +
> +       ret = EFI_CALL(efi_load_image(false, efi_root, NULL, buf, size,
> +                                     &handle));
> +       if (handle)
> +               EFI_CALL(efi_unload_image(handle));
> +
> +       return ret;
> +}
> +
> +/**
> + * parse_image() - pass an image at the start of buf to efi_image_parse()
> + *
> + * @size:      size of the image
> + * Return:     result of efi_image_parse()
> + */
> +static bool parse_image(size_t size)
> +{
> +       struct efi_image_regions *regs = NULL;
> +       WIN_CERTIFICATE *auth = NULL;
> +       size_t auth_len = 0;
> +       bool ret;
> +
> +       ret = efi_image_parse(buf, size, &regs, &auth, &auth_len);
> +       free(regs);
> +
> +       return ret;
> +}
> +
> +/* The checks must let valid images through */
> +static int lib_test_efi_image_valid(struct unit_test_state *uts)
> +{
> +       static const u32 num_dirs[] = { IMAGE_NUMBEROF_DIRECTORY_ENTRIES, 6 };
> +       struct test_image img;
> +       int i, j;
> +
> +       if (!TEST_MACHINE)
> +               return -EAGAIN;
> +
> +       ut_asserteq_64(EFI_SUCCESS, efi_init_obj_list());
> +
> +       for (i = 0; i < 2; i++) {
> +               for (j = 0; j < ARRAY_SIZE(num_dirs); j++) {
> +                       test_image_init(&img, i, num_dirs[j], 1);
> +                       ut_asserteq(true, parse_image(TEST_IMAGE_SIZE));
> +                       ut_asserteq_64(EFI_SUCCESS, load_image(TEST_IMAGE_SIZE));
> +               }
> +       }
> +
> +       /* An empty section, and trailing data of an odd size */
> +       test_image_init(&img, true, IMAGE_NUMBEROF_DIRECTORY_ENTRIES, 2);
> +       memcpy(img.sections[1].Name, ".bss", 4);
> +       img.sections[1].Misc.VirtualSize = TEST_FILE_ALIGN;
> +       img.sections[1].VirtualAddress = 2 * TEST_SECTION_ALIGN;
> +       opt_set(&img, SizeOfImage, 3 * TEST_SECTION_ALIGN);
> +       ut_asserteq(true, parse_image(TEST_IMAGE_SIZE + 3));
> +       ut_asserteq_64(EFI_SUCCESS, load_image(TEST_IMAGE_SIZE + 3));
> +
> +       /* An image with five data directories has no relocation table */
> +       test_image_init(&img, true, 5, 1);
> +       ut_asserteq(true, parse_image(TEST_IMAGE_SIZE));
> +       ut_asserteq_64(EFI_SUCCESS, load_image(TEST_IMAGE_SIZE));
> +
> +       /* The last section is not padded to the file alignment */
> +       test_image_init(&img, true, IMAGE_NUMBEROF_DIRECTORY_ENTRIES, 1);
> +       img.sections[0].SizeOfRawData = TEST_FILE_ALIGN / 2;
> +       ut_asserteq(true, parse_image(TEST_IMAGE_SIZE - TEST_FILE_ALIGN / 2));
> +       ut_asserteq_64(EFI_SUCCESS,
> +                      load_image(TEST_IMAGE_SIZE - TEST_FILE_ALIGN / 2));
> +
> +       /* A file alignment of 0 stands for the default of 512 */
> +       test_image_init(&img, true, IMAGE_NUMBEROF_DIRECTORY_ENTRIES, 1);
> +       opt_set(&img, FileAlignment, 0);
> +       ut_asserteq(true, parse_image(TEST_IMAGE_SIZE));
> +       ut_asserteq_64(EFI_SUCCESS, load_image(TEST_IMAGE_SIZE));
> +
> +       return 0;
> +}
> +LIB_TEST(lib_test_efi_image_valid, 0);
> +
> +/* efi_check_pe() must check that the image holds a 64bit NT header */
> +static int lib_test_efi_check_pe_nt_header(struct unit_test_state *uts)
> +{
> +       struct test_image img;
> +       size_t size;
> +
> +       test_image_init(&img, true, IMAGE_NUMBEROF_DIRECTORY_ENTRIES, 1);
> +       ut_asserteq_64(EFI_SUCCESS, efi_check_pe(buf, TEST_IMAGE_SIZE, NULL));
> +
> +       /* The image ends after a 32bit NT header */
> +       size = img.dos->e_lfanew + sizeof(IMAGE_NT_HEADERS32);
> +       ut_asserteq_64(EFI_INVALID_PARAMETER, efi_check_pe(buf, size, NULL));
> +
> +       /* The NT header offset lies past the end (wraps on 32bit hosts) */
> +       img.dos->e_lfanew = 0xfffffff0;
> +       ut_asserteq_64(EFI_INVALID_PARAMETER,
> +                      efi_check_pe(buf, TEST_IMAGE_SIZE, NULL));
> +
> +       return 0;
> +}
> +LIB_TEST(lib_test_efi_check_pe_nt_header, 0);
> +
> +/* efi_load_pe() must reject a section ending past 4 GiB */
> +static int lib_test_efi_load_pe_section_wrap(struct unit_test_state *uts)
> +{
> +       struct test_image img;
> +
> +       if (!TEST_MACHINE)
> +               return -EAGAIN;
> +
> +       ut_asserteq_64(EFI_SUCCESS, efi_init_obj_list());
> +
> +       test_image_init(&img, true, IMAGE_NUMBEROF_DIRECTORY_ENTRIES, 1);
> +       /* VirtualAddress + VirtualSize wraps around to TEST_SECTION_ALIGN */
> +       img.sections[0].VirtualAddress = 0xfffff000;
> +       img.sections[0].Misc.VirtualSize = 0x2000;
> +       ut_asserteq_64(EFI_LOAD_ERROR, load_image(TEST_IMAGE_SIZE));
> +
> +       return 0;
> +}
> +LIB_TEST(lib_test_efi_load_pe_section_wrap, 0);
> +
> +/* efi_load_pe() must check the raw data of a section against the image */
> +static int lib_test_efi_load_pe_section_raw(struct unit_test_state *uts)
> +{
> +       struct test_image img;
> +
> +       if (!TEST_MACHINE)
> +               return -EAGAIN;
> +
> +       ut_asserteq_64(EFI_SUCCESS, efi_init_obj_list());
> +
> +       test_image_init(&img, true, IMAGE_NUMBEROF_DIRECTORY_ENTRIES, 1);
> +       /* The raw data of the section runs past the end of the image */
> +       img.sections[0].SizeOfRawData = 2 * TEST_FILE_ALIGN;
> +       img.sections[0].Misc.VirtualSize = 2 * TEST_FILE_ALIGN;
> +       ut_asserteq_64(EFI_LOAD_ERROR, load_image(TEST_IMAGE_SIZE));
> +
> +       /* Only the part copied for the smaller VirtualSize lies within it */
> +       test_image_init(&img, true, IMAGE_NUMBEROF_DIRECTORY_ENTRIES, 1);
> +       img.sections[0].SizeOfRawData = 2 * TEST_FILE_ALIGN;
> +       ut_asserteq_64(EFI_LOAD_ERROR, load_image(TEST_IMAGE_SIZE));
> +
> +       return 0;
> +}
> +LIB_TEST(lib_test_efi_load_pe_section_raw, 0);
> +
> +/* efi_load_pe() must make room for the headers in the loaded image */
> +static int lib_test_efi_load_pe_headers(struct unit_test_state *uts)
> +{
> +       struct efi_loaded_image *info;
> +       struct efi_handler *handler;
> +       efi_handle_t handle = NULL;
> +       struct test_image img;
> +       int num_sections, i;
> +       size_t table_end, hdr_size, size;
> +
> +       if (!TEST_MACHINE)
> +               return -EAGAIN;
> +
> +       ut_asserteq_64(EFI_SUCCESS, efi_init_obj_list());
> +
> +       /*
> +        * Enough empty sections for the section table to end past the first
> +        * page, while the only section with data is TEST_FILE_ALIGN bytes
> +        * long at virtual address 0: the sections alone fit into one page.
> +        */
> +       test_image_init(&img, true, IMAGE_NUMBEROF_DIRECTORY_ENTRIES, 1);
> +       num_sections = (EFI_PAGE_SIZE - ((void *)img.sections - (void *)buf)) /
> +                      sizeof(IMAGE_SECTION_HEADER) + 2;
> +       table_end = (void *)&img.sections[num_sections] - (void *)buf;
> +       hdr_size = ALIGN(table_end, TEST_FILE_ALIGN);
> +       size = hdr_size + TEST_FILE_ALIGN;
> +       ut_assert(size <= sizeof(buf));
> +
> +       test_image_init(&img, true, IMAGE_NUMBEROF_DIRECTORY_ENTRIES,
> +                       num_sections);
> +       opt_set(&img, SizeOfHeaders, hdr_size);
> +       opt_set(&img, AddressOfEntryPoint, 0);
> +       img.sections[0].VirtualAddress = 0;
> +       img.sections[0].PointerToRawData = hdr_size;
> +       for (i = 1; i < num_sections; i++)
> +               memcpy(img.sections[i].Name, ".bss", 4);
> +
> +       ut_asserteq_64(EFI_SUCCESS,
> +                      EFI_CALL(efi_load_image(false, efi_root, NULL, buf, size,
> +                                              &handle)));
> +       ut_asserteq_64(EFI_SUCCESS, efi_search_protocol(handle,
> +                                                       &efi_guid_loaded_image,
> +                                                       &handler));
> +       info = handler->protocol_interface;
> +       ut_assert(info->image_size >= table_end);
> +       /* The section at virtual address 0 overwrites the first bytes */
> +       ut_asserteq_mem(buf + TEST_FILE_ALIGN,
> +                       info->image_base + TEST_FILE_ALIGN,
> +                       table_end - TEST_FILE_ALIGN);
> +       ut_asserteq_64(EFI_SUCCESS, EFI_CALL(efi_unload_image(handle)));
> +
> +       return 0;
> +}
> +LIB_TEST(lib_test_efi_load_pe_headers, 0);
> +
> +/* efi_loader_relocate() must check the relocation table against the image */
> +static int lib_test_efi_load_pe_reloc_table(struct unit_test_state *uts)
> +{
> +       struct test_image img;
> +       IMAGE_DATA_DIRECTORY *dir;
> +
> +       if (!TEST_MACHINE)
> +               return -EAGAIN;
> +
> +       ut_asserteq_64(EFI_SUCCESS, efi_init_obj_list());
> +
> +       test_image_init(&img, true, IMAGE_NUMBEROF_DIRECTORY_ENTRIES, 1);
> +       dir = &img.dirs[IMAGE_DIRECTORY_ENTRY_BASERELOC];
> +       /* The relocation table starts in the section and ends past it */
> +       dir->VirtualAddress = TEST_SECTION_ALIGN;
> +       dir->Size = TEST_SECTION_ALIGN;
> +       ut_asserteq_64(EFI_LOAD_ERROR, load_image(TEST_IMAGE_SIZE));
> +
> +       /* The relocation table lies far past the end of the image */
> +       dir->VirtualAddress = 0xfffff000;
> +       dir->Size = sizeof(IMAGE_BASE_RELOCATION);
> +       ut_asserteq_64(EFI_LOAD_ERROR, load_image(TEST_IMAGE_SIZE));
> +
> +       return 0;
> +}
> +LIB_TEST(lib_test_efi_load_pe_reloc_table, 0);
> +
> +/* efi_load_pe() must refuse an image whose subsystem is no UEFI image type */
> +static int lib_test_efi_load_pe_subsystem(struct unit_test_state *uts)
> +{
> +       static const u16 subsystems[] = { 0, 3, IMAGE_SUBSYSTEM_EFI_ROM };
> +       struct test_image img;
> +       int i, j;
> +
> +       if (!TEST_MACHINE)
> +               return -EAGAIN;
> +
> +       ut_asserteq_64(EFI_SUCCESS, efi_init_obj_list());
> +
> +       for (i = 0; i < 2; i++) {
> +               for (j = 0; j < ARRAY_SIZE(subsystems); j++) {
> +                       test_image_init(&img, i,
> +                                       IMAGE_NUMBEROF_DIRECTORY_ENTRIES, 1);
> +                       opt_set(&img, Subsystem, subsystems[j]);
> +                       ut_asserteq_64(EFI_UNSUPPORTED,
> +                                      load_image(TEST_IMAGE_SIZE));
> +               }
> +       }
> +
> +       return 0;
> +}
> +LIB_TEST(lib_test_efi_load_pe_subsystem, 0);
> +
> +/* efi_load_pe() must not let an image that cannot be measured start */
> +static int lib_test_efi_load_pe_measure(struct unit_test_state *uts)
> +{
> +       const efi_guid_t tcg2_guid = EFI_TCG2_PROTOCOL_GUID;
> +       struct efi_handler *handler;
> +       struct test_image img;
> +
> +       if (!TEST_MACHINE)
> +               return -EAGAIN;
> +
> +       ut_asserteq_64(EFI_SUCCESS, efi_init_obj_list());
> +       if (efi_search_protocol(efi_root, &tcg2_guid, &handler) != EFI_SUCCESS)
> +               return -EAGAIN;
> +
> +       /*
> +        * LoadImage() takes a file alignment that is not a power of two, but
> +        * the image cannot be hashed for its measurement: it must be marked
> +        * as not authenticated, so that StartImage() refuses it.
> +        */
> +       test_image_init(&img, true, IMAGE_NUMBEROF_DIRECTORY_ENTRIES, 1);
> +       opt_set(&img, FileAlignment, 3 * TEST_FILE_ALIGN / 2);
> +       ut_asserteq_64(EFI_SECURITY_VIOLATION, load_image(TEST_IMAGE_SIZE));
> +
> +       return 0;
> +}
> +LIB_TEST(lib_test_efi_load_pe_measure, 0);
> +
> +/* efi_image_parse() must check the PE headers against the image */
> +static int lib_test_efi_image_parse_headers(struct unit_test_state *uts)
> +{
> +       struct test_image img;
> +
> +       /* The headers run past the end of the image */
> +       test_image_init(&img, true, IMAGE_NUMBEROF_DIRECTORY_ENTRIES, 1);
> +       opt_set(&img, SizeOfHeaders, 2 * TEST_IMAGE_SIZE);
> +       ut_asserteq(false, parse_image(TEST_IMAGE_SIZE));
> +
> +       /* The optional header is shorter than its fixed fields */
> +       test_image_init(&img, true, 0, 1);
> +       img.nt->FileHeader.SizeOfOptionalHeader = 0x40;
> +       ut_asserteq(false, parse_image(TEST_IMAGE_SIZE));
> +
> +       /*
> +        * The optional header holds fewer data directories than it declares:
> +        * the certificate table entry would be read from the section table,
> +        * so clear the section name read as the entry.
> +        */
> +       test_image_init(&img, false, IMAGE_DIRECTORY_ENTRY_SECURITY, 1);
> +       opt_set(&img, NumberOfRvaAndSizes, IMAGE_NUMBEROF_DIRECTORY_ENTRIES);
> +       memset(img.sections[0].Name, 0, sizeof(img.sections[0].Name));
> +       ut_asserteq(false, parse_image(TEST_IMAGE_SIZE));
> +
> +       /* The optional header holds more than 16 data directories */
> +       test_image_init(&img, true, IMAGE_NUMBEROF_DIRECTORY_ENTRIES + 1, 1);
> +       ut_asserteq(false, parse_image(TEST_IMAGE_SIZE));
> +
> +       return 0;
> +}
> +LIB_TEST(lib_test_efi_image_parse_headers, 0);
> +
> +/* efi_image_parse() must check each section against the image */
> +static int lib_test_efi_image_parse_section(struct unit_test_state *uts)
> +{
> +       struct test_image img;
> +
> +       /* The raw data of the section runs past the end of the image */
> +       test_image_init(&img, true, IMAGE_NUMBEROF_DIRECTORY_ENTRIES, 1);
> +       img.sections[0].SizeOfRawData = 2 * TEST_FILE_ALIGN;
> +       ut_asserteq(false, parse_image(TEST_IMAGE_SIZE));
> +
> +       /* The raw data of the section starts past the end of the image */
> +       test_image_init(&img, true, IMAGE_NUMBEROF_DIRECTORY_ENTRIES, 1);
> +       img.sections[0].PointerToRawData = 0xfffffe00;
> +       ut_asserteq(false, parse_image(TEST_IMAGE_SIZE));
> +
> +       /* The file alignment is not a power of two */
> +       test_image_init(&img, true, IMAGE_NUMBEROF_DIRECTORY_ENTRIES, 1);
> +       opt_set(&img, FileAlignment, 3 * TEST_FILE_ALIGN / 2);
> +       ut_asserteq(false, parse_image(2 * TEST_IMAGE_SIZE));
> +
> +       /* Two sections share their raw data */
> +       test_image_init(&img, true, IMAGE_NUMBEROF_DIRECTORY_ENTRIES, 2);
> +       img.sections[1] = img.sections[0];
> +       img.sections[1].VirtualAddress = 2 * TEST_SECTION_ALIGN;
> +       ut_asserteq(false, parse_image(TEST_IMAGE_SIZE));
> +
> +       return 0;
> +}
> +LIB_TEST(lib_test_efi_image_parse_section, 0);
> +
> +/* efi_image_parse() must check the certificate table against the image */
> +static int lib_test_efi_image_parse_cert_table(struct unit_test_state *uts)
> +{
> +       struct test_image img;
> +       IMAGE_DATA_DIRECTORY *dir;
> +
> +       test_image_init(&img, true, IMAGE_NUMBEROF_DIRECTORY_ENTRIES, 1);
> +       dir = &img.dirs[IMAGE_DIRECTORY_ENTRY_SECURITY];
> +       /* The end of the certificate table wraps around to 0x10 */
> +       dir->VirtualAddress = 0xfffffff0;
> +       dir->Size = 0x20;
> +       ut_asserteq(false, parse_image(TEST_IMAGE_SIZE));
> +
> +       return 0;
> +}
> +LIB_TEST(lib_test_efi_image_parse_cert_table, 0);
