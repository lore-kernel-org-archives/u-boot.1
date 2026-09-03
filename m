Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC7DC61DD3
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 14:32:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1F11860B71;
	Thu,  3 Sep 2026 14:32:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BqqRIBmosiqp; Thu,  3 Sep 2026 14:32:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org EA41160B79
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788445954;
	b=pBOBrn7bvIUxE5buTN6s1RsIyaIz7gznRPX8LRPzPLkQSc8kupqDcNuFXE6gUL/2bu8L
	 UlPeUdMrhlEr1/VylDItk/FCAnxQCNqHbW62oK1vKTkF1R3ndNq2abE1b6jwaGXpoIx4+
	 DS5MW6NukN6N24iyaE0KBPI2j2uQtNAOcMrLaLWgdE3bh0Dvh2SEhJatkvYF6afRbCV4q
	 GTdx50XjOaq8ZPzdS1Ow0BA3wnJ5AZabwzS89zw9Amdv2JCJ1EAPbXo0AxYo+jK7RPjl3
	 vna3TAxnIsNStbMsg6RUFIr/w80wNDalCovTM5NzAbsuWV1daGHtSiXV0y8+BxLj5IQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788445954;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=LKA8irXLidMUEe+u0mjkJv4k7NgVS+JjPybDV7bN6ns=;
	b=jlOSlQOsaJP60cdnww7GBQ2YM00nQY5tddx5fVcf4xjtYqY1PzuZznImCwyOpP6LwlaX
	 rHsABThpyLpVfnKP8bzCdKxF4drYkO/kS9GF1c7kb/e67O3ajZeYWhsVxsmxS//De0KmL
	 izOSopOpbNgxdx2avfUmrhtebXWvq23MIMml5bGSuOLIdFbaylt42f4TfLdt+TIZo690K
	 WuC5NAX3I8ahXBq/P/+GWIMn34AXXmmv6IidFH8V5OPY+VkoKf9PKLMfcf4wb5NCHI+Jm
	 kL7NhAvyfmDdnSUQr7g/YMTR+HD81PUcSPMecPncfYiAv7gvlj025YY29OPY7D3sUiQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788445954;
	bh=LKA8irXLidMUEe+u0mjkJv4k7NgVS+JjPybDV7bN6ns=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YU7eLBoaxz+6Uk/lJI39BOG+giFJLwdetj8nnRRRHIXlPmZSYjBQNQ7rfd6lydrcB
	 Pl95xspKdYz9MZ4UXPnw+8+4BaaG4cY8I7gMTC6Q7wCw8MTqSldLZEazZcJkXUQcLM
	 NXqF0v6DLsBf7U6PcCDr2ETp3Qm/uh6GEPAnSRnnUUcTy4Qb0WshpJjz2lEmx9lUpw
	 4yGBIoyLNqmopiKL5pF6Mnq1PIhCVgnq24Nghl0A7DiPW8HWvCg7JuUjYAZGKiw+rI
	 QoAyntikQje9kBQdikOpot3Mojj7kgnyftmfAXrTH2BTvWnf4dznC+EUjwKEZ/FaiU
	 QP8ULFtsyNBuw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EA41160B79;
	Thu,  3 Sep 2026 14:32:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id AD9B634E
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:32:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9C53E80DF4
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:32:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gyp_kGcMN9Ux for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 14:32:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 81E4380DFA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::e2c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788445947;
 b=eXkd3lV75A++cQT8KIxLG3JYQLHnWrS89sHBOLxETv5br/3tsWUkfTd6jGt7U3+cW56y
 nPklvF4e7EKXrJdVpa6mCWuPVWev5cD5T4d58O3JUEsPz0Y3ZKzviTWwDgTdI0DB2og1Q
 mafbAHP7+59tExZS1kn2mWTjeNtEgc1cFhO2PxSDnyoEtrvAwcyfGWV2HU89FWYiim5/X
 AfETnro1KeAW+/l1Trt8ZUqFOb5CFV/zbCW7Oiz32MSUXPzqxb72J1rtrmjqui2KaRNwN
 4+gfreNe/Z6dBlsabP90gib/pe8ciwA2eDMW9gl6jFBsf2opkJgkBgDUSMdfIAyK84A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788445947;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=LKA8irXLidMUEe+u0mjkJv4k7NgVS+JjPybDV7bN6ns=;
 b=PZmSIYqUeU+DYlncWyWfhd8fONCj2WKg2xbY/ZQzgXXrAdWPLWZdtHTxrRi3Mdr9tObJ
 GUwRKiudHp+X2ud9fDA10mOzseItwQG4HvP67X3rgYLFs+cAcIj3W/eIoknjKohhyfG7Y
 2s5n9Dqc50Td3LbG5p28sQ5rL6Vfkl23fk1vCMpnJs52Rgc0W9x51S08ZMwMHnQLCvYgW
 Ocqnvd8O3OsULYSVenDjX+jlPMuhNY+ubIfmxPTBfYdfRNLGlOl3czaOOa8wGTn6lEh9e
 fHpwqACHLCQNPbdrWqNvrkBoxSzdJXbRVmLPNtDtWd3XA4tmfbj19vQtO/7rKVe3EXg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=RgO+5Z3E; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::e2c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e2c; helo=mail-vs1-xe2c.google.com;
 envelope-from=raymondmaoca@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=RgO+5Z3E
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com
 [IPv6:2607:f8b0:4864:20::e2c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 81E4380DFA
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:32:26 +0000 (UTC)
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-78a220b5778so1038030137.1
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 07:32:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788445946; cv=none;
 d=google.com; s=arc-20260327;
 b=Stz8Ti+17RR1mz+JZEnV2i7aZq9XaPX8uyvtZ0FjUQjxSXQVCV88kvLNX9TcIBhnzt
 2sSwis/iNvkk2Upqd+UpNxRtY+OeFb6R0yQhre/gn88xDDgbNJb3Bw8NXewnKLUxMCEW
 aORDvBu9W2bH5gwlbwhffA/QvJ8FBM6ueXwVSTpf2thBY++LOZyewD8mP3YoQ25hR3n/
 tXXzYzZUOqDNN3yK74J85fiZuqXB/WC4p76nKHMJUAQy0fJCXZbSTqxeZ5yR0KNlOW1t
 UKBinhuuuoAVdAGmofjfBmgmC5RtW6OEu7zw3IoLEjfmn/7aC6YnxJJPp6Nl4akUOnkm
 b0hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LKA8irXLidMUEe+u0mjkJv4k7NgVS+JjPybDV7bN6ns=;
 fh=vOHALQmA9STz1zfJgzEwgWVqFgiSYrx5Se72b+rs8s4=;
 b=IwKx/dOFj2kzmb1UjEANmAt+36DXj+wWbQc8ma1l1rP2MQIJVKtzgg6EFMS9NFNNVL
 ir8Ak44D/DYjrv5Klq0f6sskDrnNn+CdvmdHnQSs4zSoBJetuiQouyzY26M4J4Ty4IKM
 43+/gT+FM51GG2S8EJXh0t+YElYH5a0X1Y8tlUB2d9dX/Dd1shv9OT5JK6n4g0TCE+w3
 69GFJtM59jnwGKpX2Jk5JkIfETX+l5PukdXHfjf0unYYHvVbaOQGwRMDXJaoNK64NmLe
 6eBjB7zP3UuR7EvMgKj8pjm7dM8beKGDEFCzb1SdmMHREUSS93HXN9Yha8mfJSuUV7jn
 gTYw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788445946; x=1789050746;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LKA8irXLidMUEe+u0mjkJv4k7NgVS+JjPybDV7bN6ns=;
 b=RgO+5Z3E2eaGbVD3dn1EGdBqDJjiikBsnUxVMch1BJ9z+ziRijVukVlCpr4BiJ/7Va
 kkcHgy7seZez1G4qpxkYYgRREbysG8NXND9ToX4XZ2cWjlaeCFnHoM+wxHx+mQUaDPqk
 QqlWbifR2m/hTuJ/L1HaqN2wClzW+2hzokvTCBAi/E5T22olzVoL7oSZc0RrbDMYnTDf
 g4bQPxBGKS1xZ/j4lr/u2d7XxxkSn/wDxl/WlXxfeQqPJBqH3K0CIrjy8kMQyE3jKzRR
 sBDLr0C6CiCE67Upqky0KJzyxvEZwAVpHHqEayevhnPHTTAlPX6T2KkegoqK9SE5Af6y
 mVXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788445946; x=1789050746;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LKA8irXLidMUEe+u0mjkJv4k7NgVS+JjPybDV7bN6ns=;
 b=Jygz3uAVugrm2ajeGIOyawidFUz9ju2mhl2Bb1Rg2EHZttoxSxqhkoWOhW2jp6hHib
 ueg7xbPKfBU4skz+NCQxSaa1K6kWyzqpkOOdfHw8meTEH0iQeX3QG7lhI5YRTlsGFw8G
 3yxPz/09Qs0oRTCKK5+HNi/kmdl3Jn+huSjPmcgGJHTE7pWnmY4YSTxaV82WOHNsrWBd
 oLNQumwQCFWKXZYCk/MPcmslx63+ZWjYRURUywCGQC42sdMGf2KVw8n0R/6IldcMgKgq
 UOifrZx7l3zkAY+FjThjllzhBbdwxrz9TRnfXCGyvQ+ve26NT4cadHMvmPnmSIQXuTnG
 6Jaw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz3TkhZVty5NbhiUFv7I7n6hYbfVinxlnCJd0HWeGqSRQs1Bgfif319NkiD57XO54j7qu7Si7o=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++ko6E5tqudjEYTDLoxEu+p9dqJIGYk6kMrEI5CX2TG9Hml2iHpq
 ZOKx+UnPuhJxIX6xOIa0q1RMfE+xqbfwM6xvZsX/pu7d/nZ+guOA4XOsb4TMY6J/mTkXDonqnGE
 kBELCIWPBQ4AYzEMIAiaMns6C2NSeG2E=
X-Gm-Gg: AYBFou0+FlrDbjHrilxR6tr5otaIEj4dAnhNrMx58g7K2gOM34p9lqqdQuH1WYQKNNd
 3JcxE1N18djNJsaYm9bXdJ6AoRxcq89H4Qi4IagqLxcQMPAB7+RU+aWOh3QLvgm9daVmYhPIvAj
 /AZupskXennM3rlYMCCON9E7uPgmOdbKAbZH6XvHBDKYSMcyi8gRfcqiGKa2O8QiSCPvCdbUcfY
 FByUAZi5Az144vzjy66l1lQqQCY1nRSbfBn2IqzHOkOpV0J4bUXETtiopmMt/Zb6Ive8OghWA/p
 hBS1O4JJFCXTCzl1P8DjPTZnYKYJ5PFAX0LaQDX6UE0hBVA=
X-Received: by 2002:a05:6102:5493:b0:779:328:8a2e with SMTP id
 ada2fe7eead31-78a2ef01223mr1361144137.5.1788445944335; Thu, 03 Sep 2026
 07:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260903081705.12894-1-philippe.reynes@softathome.com>
 <20260903081705.12894-5-philippe.reynes@softathome.com>
In-Reply-To: <20260903081705.12894-5-philippe.reynes@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Thu, 3 Sep 2026 10:32:11 -0400
X-Gm-Features: AcwNN1Vl05nnIvPU_VA0H65gD7y2YYW4bPpbScqznsOl5Wep_8FLvE-pk00x8AU
Message-ID: <CAMDkj5zkz+PSzjWihKb1yb2KZXESQ+D-=L8G9xniLT45h9qBXQ@mail.gmail.com>
Subject: Re: [PATCH v9 04/15] test: lib: ecdsa: add initial test
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, trini@konsulko.com, 
 simon.glass@canonical.com, u-boot@lists.u-boot-project.org, 
 Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Philippe,

On Thu, Sep 3, 2026 at 4:17=E2=80=AFAM Philippe Reynes
<philippe.reynes@softathome.com> wrote:
>
> Adds tests to check that the function ecdsa_hash_verify
> using mbedtls is valid.
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
> v2:
> - little change to only use test with sha enabled
> v3:
> - remove useless field *k in struct ecdsa_test_vector_s
> - change expected value on error (don't use mbedtls error)
> - manage function returns
> - update third parameter of sha*_csum_wd
> v4:
> - define SHA256_DEF_CHUNK_SZ, SHA384_DEF_CHUNK_SZ and SHA512_DEF_CHUNK_SZ
> - report skipped tests
> - add const on some variables
> - code cleanup
> v5:
> - do not define SHA256_DEF_CHUNK_SZ, SHA384_DEF_CHUNK_SZ and SHA512_DEF_C=
HUNK_SZ
> - use CHUNKSZ_SHA256, CHUNKSZ_SHA384 and CHUNKSZ_SHA521
> - do not use 528 to compule ecdsa 521 sig size but compute it
> - use ut_reportf instead of ut_failf
> v6:
> - no change
> v7:
> - no change
> v8:
> - no change
> v9:
> - no change
>
>  test/lib/Makefile |   1 +
>  test/lib/ecdsa.c  | 456 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 457 insertions(+)
>  create mode 100644 test/lib/ecdsa.c
>

Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>

Thanks!
Regards,
Raymond

> diff --git a/test/lib/Makefile b/test/lib/Makefile
> index f25383a40e5..e9c779a7b47 100644
> --- a/test/lib/Makefile
> +++ b/test/lib/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_$(PHASE_)UT_COMPRESSION) +=3D compression.o
>  ifeq ($(CONFIG_XPL_BUILD),)
>  obj-y +=3D abuf.o
>  obj-y +=3D alist.o
> +obj-$(CONFIG_ECDSA_VERIFY_MBEDTLS) +=3D ecdsa.o
>  obj-$(CONFIG_EFI_LOADER) +=3D efi_device_path.o efi_memory.o
>  obj-$(CONFIG_EFI_SECURE_BOOT) +=3D efi_image_region.o
>  ifdef CONFIG_RISCV
> diff --git a/test/lib/ecdsa.c b/test/lib/ecdsa.c
> new file mode 100644
> index 00000000000..bc7737837e5
> --- /dev/null
> +++ b/test/lib/ecdsa.c
> @@ -0,0 +1,456 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 Philippe Reynes <philippe.reynes@softathome.com>
> + */
> +
> +#include <command.h>
> +#include <image.h>
> +#include <test/lib.h>
> +#include <test/test.h>
> +#include <test/ut.h>
> +#include <crypto/ecdsa-uclass.h>
> +#include <crypto/internal/ecdsa.h>
> +
> +#define ECDSA_POINT_SIZE       (DIV_ROUND_UP(521, 8) * 2)
> +#define ECDSA_SIGNATURE_SIZE   (ECDSA_POINT_SIZE * 2)
> +
> +struct ecdsa_test_vector_s {
> +       const char *test_name;
> +       const char *curve_name;
> +       const char *x;
> +       const char *y;
> +       int size_bits;
> +       const char *hash_type;
> +       const char *hash_message;
> +       const char *r;
> +       const char *s;
> +       int expected;
> +};
> +
> +/*
> + * Those data come from RFC6979
> + */
> +
> +static const struct ecdsa_test_vector_s ecdsa_test_vector[] =3D {
> +       /*
> +        * secp192r1
> +        */
> +       {
> +       .test_name =3D "secp192r1 sha1",
> +       .curve_name =3D "secp192r1",
> +       .x =3D "AC2C77F529F91689FEA0EA5EFEC7F210D8EEA0B9E047ED56",
> +       .y =3D "3BC723E57670BD4887EBC732C523063D0A7C957BC97C1C43",
> +       .size_bits =3D 192,
> +       .hash_type =3D "sha-1",
> +       .hash_message =3D "sample",
> +       .r =3D "98C6BD12B23EAF5E2A2045132086BE3EB8EBD62ABF6698FF",
> +       .s =3D "57A22B07DEA9530F8DE9471B1DC6624472E8E2844BC25B64",
> +       .expected =3D 0,
> +       },
> +       {
> +       .test_name =3D "secp192r1 sha256",
> +       .curve_name =3D "secp192r1",
> +       .x =3D "AC2C77F529F91689FEA0EA5EFEC7F210D8EEA0B9E047ED56",
> +       .y =3D "3BC723E57670BD4887EBC732C523063D0A7C957BC97C1C43",
> +       .size_bits =3D 192,
> +       .hash_type =3D "sha-256",
> +       .hash_message =3D "sample",
> +       .r =3D "4B0B8CE98A92866A2820E20AA6B75B56382E0F9BFD5ECB55",
> +       .s =3D "CCDB006926EA9565CBADC840829D8C384E06DE1F1E381B85",
> +       .expected =3D 0,
> +       },
> +       {
> +       .test_name =3D "secp192r1 sha384",
> +       .curve_name =3D "secp192r1",
> +       .x =3D "AC2C77F529F91689FEA0EA5EFEC7F210D8EEA0B9E047ED56",
> +       .y =3D "3BC723E57670BD4887EBC732C523063D0A7C957BC97C1C43",
> +       .size_bits =3D 192,
> +       .hash_type =3D "sha-384",
> +       .hash_message =3D "sample",
> +       .r =3D "DA63BF0B9ABCF948FBB1E9167F136145F7A20426DCC287D5",
> +       .s =3D "C3AA2C960972BD7A2003A57E1C4C77F0578F8AE95E31EC5E",
> +       .expected =3D 0,
> +       },
> +       {
> +       .test_name =3D "secp192r1 sha512",
> +       .curve_name =3D "secp192r1",
> +       .x =3D "AC2C77F529F91689FEA0EA5EFEC7F210D8EEA0B9E047ED56",
> +       .y =3D "3BC723E57670BD4887EBC732C523063D0A7C957BC97C1C43",
> +       .size_bits =3D 192,
> +       .hash_type =3D "sha-512",
> +       .hash_message =3D "sample",
> +       .r =3D "4D60C5AB1996BD848343B31C00850205E2EA6922DAC2E4B8",
> +       .s =3D "3F6E837448F027A1BF4B34E796E32A811CBB4050908D8F67",
> +       .expected =3D 0,
> +       },
> +       {
> +       .test_name =3D "secp192r1 sha512 error",
> +       .curve_name =3D "secp192r1",
> +       .x =3D "AC2C77F529F91689FEA0EA5EFEC7F210D8EEA0B9E047ED56",
> +       .y =3D "3BC723E57670BD4887EBC732C523063D0A7C957BC97C1C43",
> +       .size_bits =3D 192,
> +       .hash_type =3D "sha-512",
> +       .hash_message =3D "sample",
> +       .r =3D "4D60C5AB1996BD848343B31C00850205E2EA6922DAC2E4B8",
> +       .s =3D "0F6E837448F027A1BF4B34E796E32A811CBB4050908D8F67",
> +       .expected =3D -EINVAL,
> +       },
> +       /*
> +        * secp224r1
> +        */
> +       {
> +       .test_name =3D "secp224r1 sha1",
> +       .curve_name =3D "secp224r1",
> +       .x =3D "00CF08DA5AD719E42707FA431292DEA11244D64FC51610D94B130D6C"=
,
> +       .y =3D "EEAB6F3DEBE455E3DBF85416F7030CBD94F34F2D6F232C69F3C1385A"=
,
> +       .size_bits =3D 224,
> +       .hash_type =3D "sha-1",
> +       .hash_message =3D "sample",
> +       .r =3D "22226F9D40A96E19C4A301CE5B74B115303C0F3A4FD30FC257FB57AC"=
,
> +       .s =3D "66D1CDD83E3AF75605DD6E2FEFF196D30AA7ED7A2EDF7AF475403D69"=
,
> +       .expected =3D 0,
> +       },
> +       {
> +       .test_name =3D "secp224r1 sha256",
> +       .curve_name =3D "secp224r1",
> +       .x =3D "00CF08DA5AD719E42707FA431292DEA11244D64FC51610D94B130D6C"=
,
> +       .y =3D "EEAB6F3DEBE455E3DBF85416F7030CBD94F34F2D6F232C69F3C1385A"=
,
> +       .size_bits =3D 224,
> +       .hash_type =3D "sha-256",
> +       .hash_message =3D "sample",
> +       .r =3D "61AA3DA010E8E8406C656BC477A7A7189895E7E840CDFE8FF42307BA"=
,
> +       .s =3D "BC814050DAB5D23770879494F9E0A680DC1AF7161991BDE692B10101"=
,
> +       .expected =3D 0,
> +       },
> +       {
> +       .test_name =3D "secp224r1 sha384",
> +       .curve_name =3D "secp224r1",
> +       .x =3D "00CF08DA5AD719E42707FA431292DEA11244D64FC51610D94B130D6C"=
,
> +       .y =3D "EEAB6F3DEBE455E3DBF85416F7030CBD94F34F2D6F232C69F3C1385A"=
,
> +       .size_bits =3D 224,
> +       .hash_type =3D "sha-384",
> +       .hash_message =3D "sample",
> +       .r =3D "0B115E5E36F0F9EC81F1325A5952878D745E19D7BB3EABFABA77E953"=
,
> +       .s =3D "830F34CCDFE826CCFDC81EB4129772E20E122348A2BBD889A1B1AF1D"=
,
> +       .expected =3D 0,
> +       },
> +       {
> +       .test_name =3D "secp224r1 sha512",
> +       .curve_name =3D "secp224r1",
> +       .x =3D "00CF08DA5AD719E42707FA431292DEA11244D64FC51610D94B130D6C"=
,
> +       .y =3D "EEAB6F3DEBE455E3DBF85416F7030CBD94F34F2D6F232C69F3C1385A"=
,
> +       .size_bits =3D 224,
> +       .hash_type =3D "sha-512",
> +       .hash_message =3D "sample",
> +       .r =3D "074BD1D979D5F32BF958DDC61E4FB4872ADCAFEB2256497CDAC30397"=
,
> +       .s =3D "A4CECA196C3D5A1FF31027B33185DC8EE43F288B21AB342E5D8EB084"=
,
> +       .expected =3D 0,
> +       },
> +       {
> +       .test_name =3D "secp224r1 sha512 error",
> +       .curve_name =3D "secp224r1",
> +       .x =3D "00CF08DA5AD719E42707FA431292DEA11244D64FC51610D94B130D6C"=
,
> +       .y =3D "EEAB6F3DEBE455E3DBF85416F7030CBD94F34F2D6F232C69F3C1385A"=
,
> +       .size_bits =3D 224,
> +       .hash_type =3D "sha-512",
> +       .hash_message =3D "sample",
> +       .r =3D "074BD1D979D5F32BF958DDC61E4FB4872ADCAFEB2256497CDAC30397"=
,
> +       .s =3D "04CECA196C3D5A1FF31027B33185DC8EE43F288B21AB342E5D8EB084"=
,
> +       .expected =3D -EINVAL,
> +       },
> +       /*
> +        * secp256r1
> +        */
> +       {
> +       .test_name =3D "secp256r1 sha1",
> +       .curve_name =3D "secp256r1",
> +       .x =3D "60FED4BA255A9D31C961EB74C6356D68C049B8923B61FA6CE669622E6=
0F29FB6",
> +       .y =3D "7903FE1008B8BC99A41AE9E95628BC64F2F1B20C2D7E9F5177A3C294D=
4462299",
> +       .size_bits =3D 256,
> +       .hash_type =3D "sha-1",
> +       .hash_message =3D "sample",
> +       .r =3D "61340C88C3AAEBEB4F6D667F672CA9759A6CCAA9FA8811313039EE4A3=
5471D32",
> +       .s =3D "6D7F147DAC089441BB2E2FE8F7A3FA264B9C475098FDCF6E00D7C996E=
1B8B7EB",
> +       .expected =3D 0,
> +       },
> +       {
> +       .test_name =3D "secp256r1 sha256",
> +       .curve_name =3D "secp256r1",
> +       .x =3D "60FED4BA255A9D31C961EB74C6356D68C049B8923B61FA6CE669622E6=
0F29FB6",
> +       .y =3D "7903FE1008B8BC99A41AE9E95628BC64F2F1B20C2D7E9F5177A3C294D=
4462299",
> +       .size_bits =3D 256,
> +       .hash_type =3D "sha-256",
> +       .hash_message =3D "sample",
> +       .r =3D "EFD48B2AACB6A8FD1140DD9CD45E81D69D2C877B56AAF991C34D0EA84=
EAF3716",
> +       .s =3D "F7CB1C942D657C41D436C7A1B6E29F65F3E900DBB9AFF4064DC4AB2F8=
43ACDA8",
> +       .expected =3D 0,
> +       },
> +       {
> +       .test_name =3D "secp256r1 sha384",
> +       .curve_name =3D "secp256r1",
> +       .x =3D "60FED4BA255A9D31C961EB74C6356D68C049B8923B61FA6CE669622E6=
0F29FB6",
> +       .y =3D "7903FE1008B8BC99A41AE9E95628BC64F2F1B20C2D7E9F5177A3C294D=
4462299",
> +       .size_bits =3D 256,
> +       .hash_type =3D "sha-384",
> +       .hash_message =3D "sample",
> +       .r =3D "0EAFEA039B20E9B42309FB1D89E213057CBF973DC0CFC8F129EDDDC80=
0EF7719",
> +       .s =3D "4861F0491E6998B9455193E34E7B0D284DDD7149A74B95B9261F13ABD=
E940954",
> +       .expected =3D 0,
> +       },
> +       {
> +       .test_name =3D "secp256r1 sha512",
> +       .curve_name =3D "secp256r1",
> +       .x =3D "60FED4BA255A9D31C961EB74C6356D68C049B8923B61FA6CE669622E6=
0F29FB6",
> +       .y =3D "7903FE1008B8BC99A41AE9E95628BC64F2F1B20C2D7E9F5177A3C294D=
4462299",
> +       .size_bits =3D 256,
> +       .hash_type =3D "sha-512",
> +       .hash_message =3D "sample",
> +       .r =3D "8496A60B5E9B47C825488827E0495B0E3FA109EC4568FD3F8D1097678=
EB97F00",
> +       .s =3D "2362AB1ADBE2B8ADF9CB9EDAB740EA6049C028114F2460F96554F61FA=
E3302FE",
> +       .expected =3D 0,
> +       },
> +       {
> +       .test_name =3D "secp256r1 sha512 error",
> +       .curve_name =3D "secp256r1",
> +       .x =3D "60FED4BA255A9D31C961EB74C6356D68C049B8923B61FA6CE669622E6=
0F29FB6",
> +       .y =3D "7903FE1008B8BC99A41AE9E95628BC64F2F1B20C2D7E9F5177A3C294D=
4462299",
> +       .size_bits =3D 256,
> +       .hash_type =3D "sha-512",
> +       .hash_message =3D "sample",
> +       .r =3D "8496A60B5E9B47C825488827E0495B0E3FA109EC4568FD3F8D1097678=
EB97F00",
> +       .s =3D "0362AB1ADBE2B8ADF9CB9EDAB740EA6049C028114F2460F96554F61FA=
E3302FE",
> +       .expected =3D -EINVAL,
> +       },
> +       /*
> +        * secp384r1
> +        */
> +       {
> +       .test_name =3D "secp384r1 sha1",
> +       .curve_name =3D "secp384r1",
> +       .x =3D "EC3A4E415B4E19A4568618029F427FA5DA9A8BC4AE92E02E06AAE5286=
B300C64DEF8F0EA9055866064A254515480BC13",
> +       .y =3D "8015D9B72D7D57244EA8EF9AC0C621896708A59367F9DFB9F54CA84B3=
F1C9DB1288B231C3AE0D4FE7344FD2533264720",
> +       .size_bits =3D 384,
> +       .hash_type =3D "sha-1",
> +       .hash_message =3D "sample",
> +       .r =3D "EC748D839243D6FBEF4FC5C4859A7DFFD7F3ABDDF72014540C16D7330=
9834FA37B9BA002899F6FDA3A4A9386790D4EB2",
> +       .s =3D "A3BCFA947BEEF4732BF247AC17F71676CB31A847B9FF0CBC9C9ED4C1A=
5B3FACF26F49CA031D4857570CCB5CA4424A443",
> +       .expected =3D 0,
> +       },
> +       {
> +       .test_name =3D "secp384r1 sha256",
> +       .curve_name =3D "secp384r1",
> +       .x =3D "EC3A4E415B4E19A4568618029F427FA5DA9A8BC4AE92E02E06AAE5286=
B300C64DEF8F0EA9055866064A254515480BC13",
> +       .y =3D "8015D9B72D7D57244EA8EF9AC0C621896708A59367F9DFB9F54CA84B3=
F1C9DB1288B231C3AE0D4FE7344FD2533264720",
> +       .size_bits =3D 384,
> +       .hash_type =3D "sha-256",
> +       .hash_message =3D "sample",
> +       .r =3D "21B13D1E013C7FA1392D03C5F99AF8B30C570C6F98D4EA8E354B63A21=
D3DAA33BDE1E888E63355D92FA2B3C36D8FB2CD",
> +       .s =3D "F3AA443FB107745BF4BD77CB3891674632068A10CA67E3D45DB2266FA=
7D1FEEBEFDC63ECCD1AC42EC0CB8668A4FA0AB0",
> +       .expected =3D 0,
> +       },
> +       {
> +       .test_name =3D "secp384r1 sha384",
> +       .curve_name =3D "secp384r1",
> +       .x =3D "EC3A4E415B4E19A4568618029F427FA5DA9A8BC4AE92E02E06AAE5286=
B300C64DEF8F0EA9055866064A254515480BC13",
> +       .y =3D "8015D9B72D7D57244EA8EF9AC0C621896708A59367F9DFB9F54CA84B3=
F1C9DB1288B231C3AE0D4FE7344FD2533264720",
> +       .size_bits =3D 384,
> +       .hash_type =3D "sha-384",
> +       .hash_message =3D "sample",
> +       .r =3D "94EDBB92A5ECB8AAD4736E56C691916B3F88140666CE9FA73D64C4EA9=
5AD133C81A648152E44ACF96E36DD1E80FABE46",
> +       .s =3D "99EF4AEB15F178CEA1FE40DB2603138F130E740A19624526203B6351D=
0A3A94FA329C145786E679E7B82C71A38628AC8",
> +       .expected =3D 0,
> +       },
> +       {
> +       .test_name =3D "secp384r1 sha512",
> +       .curve_name =3D "secp384r1",
> +       .x =3D "EC3A4E415B4E19A4568618029F427FA5DA9A8BC4AE92E02E06AAE5286=
B300C64DEF8F0EA9055866064A254515480BC13",
> +       .y =3D "8015D9B72D7D57244EA8EF9AC0C621896708A59367F9DFB9F54CA84B3=
F1C9DB1288B231C3AE0D4FE7344FD2533264720",
> +       .size_bits =3D 384,
> +       .hash_type =3D "sha-512",
> +       .hash_message =3D "sample",
> +       .r =3D "ED0959D5880AB2D869AE7F6C2915C6D60F96507F9CB3E047C0046861D=
A4A799CFE30F35CC900056D7C99CD7882433709",
> +       .s =3D "512C8CCEEE3890A84058CE1E22DBC2198F42323CE8ACA9135329F03C0=
68E5112DC7CC3EF3446DEFCEB01A45C2667FDD5",
> +       .expected =3D 0,
> +       },
> +       {
> +       .test_name =3D "secp384r1 sha512 error",
> +       .curve_name =3D "secp384r1",
> +       .x =3D "EC3A4E415B4E19A4568618029F427FA5DA9A8BC4AE92E02E06AAE5286=
B300C64DEF8F0EA9055866064A254515480BC13",
> +       .y =3D "8015D9B72D7D57244EA8EF9AC0C621896708A59367F9DFB9F54CA84B3=
F1C9DB1288B231C3AE0D4FE7344FD2533264720",
> +       .size_bits =3D 384,
> +       .hash_type =3D "sha-512",
> +       .hash_message =3D "sample",
> +       .r =3D "ED0959D5880AB2D869AE7F6C2915C6D60F96507F9CB3E047C0046861D=
A4A799CFE30F35CC900056D7C99CD7882433709",
> +       .s =3D "012C8CCEEE3890A84058CE1E22DBC2198F42323CE8ACA9135329F03C0=
68E5112DC7CC3EF3446DEFCEB01A45C2667FDD5",
> +       .expected =3D -EINVAL,
> +       },
> +       /*
> +        * secp521r1
> +        */
> +       {
> +       .test_name =3D "secp521r1 sha1",
> +       .curve_name =3D "secp521r1",
> +       .x =3D "01894550D0785932E00EAA23B694F213F8C3121F86DC97A04E5A7167D=
B4E5BCD371123D46E45DB6B5D5370A7F20FB633155D38FFA16D2BD761DCAC474B9A2F5023A4=
",
> +       .y =3D "00493101C962CD4D2FDDF782285E64584139C2F91B47F87FF82354D66=
30F746A28A0DB25741B5B34A828008B22ACC23F924FAAFBD4D33F81EA66956DFEAA2BFDFCF5=
",
> +       .size_bits =3D 521,
> +       .hash_type =3D "sha-1",
> +       .hash_message =3D "sample",
> +       .r =3D "00343B6EC45728975EA5CBA6659BBB6062A5FF89EEA58BE3C80B619F3=
22C87910FE092F7D45BB0F8EEE01ED3F20BABEC079D202AE677B243AB40B5431D497C55D75D=
",
> +       .s =3D "00E7B0E675A9B24413D448B8CC119D2BF7B2D2DF032741C096634D6D6=
5D0DBE3D5694625FB9E8104D3B842C1B0E2D0B98BEA19341E8676AEF66AE4EBA3D5475D5D16=
",
> +       .expected =3D 0,
> +       },
> +       {
> +       .test_name =3D "secp521r1 sha256",
> +       .curve_name =3D "secp521r1",
> +       .x =3D "01894550D0785932E00EAA23B694F213F8C3121F86DC97A04E5A7167D=
B4E5BCD371123D46E45DB6B5D5370A7F20FB633155D38FFA16D2BD761DCAC474B9A2F5023A4=
",
> +       .y =3D "00493101C962CD4D2FDDF782285E64584139C2F91B47F87FF82354D66=
30F746A28A0DB25741B5B34A828008B22ACC23F924FAAFBD4D33F81EA66956DFEAA2BFDFCF5=
",
> +       .size_bits =3D 521,
> +       .hash_type =3D "sha-256",
> +       .hash_message =3D "sample",
> +       .r =3D "01511BB4D675114FE266FC4372B87682BAECC01D3CC62CF2303C92B35=
26012659D16876E25C7C1E57648F23B73564D67F61C6F14D527D54972810421E7D87589E1A7=
",
> +       .s =3D "004A171143A83163D6DF460AAF61522695F207A58B95C0644D87E52AA=
1A347916E4F7A72930B1BC06DBE22CE3F58264AFD23704CBB63B29B931F7DE6C9D949A7ECFC=
",
> +       .expected =3D 0,
> +       },
> +       {
> +       .test_name =3D "secp521r1 sha384",
> +       .curve_name =3D "secp521r1",
> +       .x =3D "01894550D0785932E00EAA23B694F213F8C3121F86DC97A04E5A7167D=
B4E5BCD371123D46E45DB6B5D5370A7F20FB633155D38FFA16D2BD761DCAC474B9A2F5023A4=
",
> +       .y =3D "00493101C962CD4D2FDDF782285E64584139C2F91B47F87FF82354D66=
30F746A28A0DB25741B5B34A828008B22ACC23F924FAAFBD4D33F81EA66956DFEAA2BFDFCF5=
",
> +       .size_bits =3D 521,
> +       .hash_type =3D "sha-384",
> +       .hash_message =3D "sample",
> +       .r =3D "01EA842A0E17D2DE4F92C15315C63DDF72685C18195C2BB95E572B9C5=
136CA4B4B576AD712A52BE9730627D16054BA40CC0B8D3FF035B12AE75168397F5D50C67451=
",
> +       .s =3D "01F21A3CEE066E1961025FB048BD5FE2B7924D0CD797BABE0A83B66F1=
E35EEAF5FDE143FA85DC394A7DEE766523393784484BDF3E00114A1C857CDE1AA203DB65D61=
",
> +       .expected =3D 0,
> +       },
> +       {
> +       .test_name =3D "secp521r1 sha512",
> +       .curve_name =3D "secp521r1",
> +       .x =3D "01894550D0785932E00EAA23B694F213F8C3121F86DC97A04E5A7167D=
B4E5BCD371123D46E45DB6B5D5370A7F20FB633155D38FFA16D2BD761DCAC474B9A2F5023A4=
",
> +       .y =3D "00493101C962CD4D2FDDF782285E64584139C2F91B47F87FF82354D66=
30F746A28A0DB25741B5B34A828008B22ACC23F924FAAFBD4D33F81EA66956DFEAA2BFDFCF5=
",
> +       .size_bits =3D 521,
> +       .hash_type =3D "sha-512",
> +       .hash_message =3D "sample",
> +       .r =3D "00C328FAFCBD79DD77850370C46325D987CB525569FB63C5D3BC53950=
E6D4C5F174E25A1EE9017B5D450606ADD152B534931D7D4E8455CC91F9B15BF05EC36E377FA=
",
> +       .s =3D "00617CCE7CF5064806C467F678D3B4080D6F1CC50AF26CA2094173082=
81B68AF282623EAA63E5B5C0723D8B8C37FF0777B1A20F8CCB1DCCC43997F1EE0E44DA4A67A=
",
> +       .expected =3D 0,
> +       },
> +       {
> +       .test_name =3D "secp521r1 sha512 error",
> +       .curve_name =3D "secp521r1",
> +       .x =3D "01894550D0785932E00EAA23B694F213F8C3121F86DC97A04E5A7167D=
B4E5BCD371123D46E45DB6B5D5370A7F20FB633155D38FFA16D2BD761DCAC474B9A2F5023A4=
",
> +       .y =3D "00493101C962CD4D2FDDF782285E64584139C2F91B47F87FF82354D66=
30F746A28A0DB25741B5B34A828008B22ACC23F924FAAFBD4D33F81EA66956DFEAA2BFDFCF5=
",
> +       .size_bits =3D 521,
> +       .hash_type =3D "sha-512",
> +       .hash_message =3D "sample",
> +       .r =3D "00C328FAFCBD79DD77850370C46325D987CB525569FB63C5D3BC53950=
E6D4C5F174E25A1EE9017B5D450606ADD152B534931D7D4E8455CC91F9B15BF05EC36E377FA=
",
> +       .s =3D "00017CCE7CF5064806C467F678D3B4080D6F1CC50AF26CA2094173082=
81B68AF282623EAA63E5B5C0723D8B8C37FF0777B1A20F8CCB1DCCC43997F1EE0E44DA4A67A=
",
> +       .expected =3D -EINVAL,
> +       },
> +};
> +
> +static int ecdsa_test(struct unit_test_state *uts,
> +                     const struct ecdsa_test_vector_s *tv)
> +{
> +       struct ecdsa_public_key pubkey;
> +       unsigned char x[ECDSA_POINT_SIZE];
> +       unsigned char y[ECDSA_POINT_SIZE];
> +       unsigned char hash[512 / 8];
> +       size_t hash_len;
> +       unsigned char signature[ECDSA_SIGNATURE_SIZE];
> +       size_t sig_len;
> +       int ret;
> +
> +       sig_len =3D DIV_ROUND_UP(tv->size_bits, 8);
> +
> +       pubkey.curve_name =3D tv->curve_name;
> +       ret =3D hex2bin(x, tv->x, strlen(tv->x) / 2);
> +       ut_asserteq(0, ret);
> +       pubkey.x          =3D x;
> +       ret =3D hex2bin(y, tv->y, strlen(tv->y) / 2);
> +       ut_asserteq(0, ret);
> +       pubkey.y          =3D y;
> +       pubkey.size_bits  =3D tv->size_bits;
> +
> +       if (!strcmp(tv->hash_type, "sha-1")) {
> +#if CONFIG_IS_ENABLED(SHA1)
> +               hash_len =3D SHA1_SUM_LEN;
> +               sha1_csum_wd(tv->hash_message, strlen(tv->hash_message),
> +                            hash, SHA1_DEF_CHUNK_SZ);
> +#else
> +               /* sha1 is not supported so we skip this test */
> +               ut_reportf("Test %s skipped (sha1 not supported)",
> +                          tv->test_name);
> +               goto out;
> +#endif
> +       } else if (!strcmp(tv->hash_type, "sha-256")) {
> +#if CONFIG_IS_ENABLED(SHA256)
> +               hash_len =3D SHA256_SUM_LEN;
> +               sha256_csum_wd(tv->hash_message, strlen(tv->hash_message)=
,
> +                              hash, CHUNKSZ_SHA256);
> +#else
> +               /* sha256 is not supported so we skip this test */
> +               ut_reportf("Test %s skipped (sha256 not supported)",
> +                          tv->test_name);
> +               goto out;
> +#endif
> +       } else if (!strcmp(tv->hash_type, "sha-384")) {
> +#if CONFIG_IS_ENABLED(SHA384)
> +               hash_len =3D SHA384_SUM_LEN;
> +               sha384_csum_wd(tv->hash_message, strlen(tv->hash_message)=
,
> +                              hash, CHUNKSZ_SHA384);
> +#else
> +               /* sha384 is not supported so we skip this test */
> +               ut_reportf("Test %s skipped (sha384 not supported)",
> +                          tv->test_name);
> +               goto out;
> +#endif
> +       } else if (!strcmp(tv->hash_type, "sha-512")) {
> +#if CONFIG_IS_ENABLED(SHA512)
> +               hash_len =3D SHA512_SUM_LEN;
> +               sha512_csum_wd(tv->hash_message, strlen(tv->hash_message)=
,
> +                              hash, CHUNKSZ_SHA512);
> +#else
> +               /* sha512 is not supported so we skip this test */
> +               ut_reportf("Test %s skipped (sha512 not supported)",
> +                          tv->test_name);
> +               goto out;
> +#endif
> +       } else {
> +               ut_reportf("Unknown hash type (%s)", tv->hash_type);
> +               return -EINVAL;
> +       }
> +
> +       ret =3D hex2bin(signature, tv->r, sig_len);
> +       ut_asserteq(0, ret);
> +       ret =3D hex2bin(signature + sig_len, tv->s, sig_len);
> +       ut_asserteq(0, ret);
> +       sig_len =3D sig_len * 2;
> +
> +       ret =3D ecdsa_hash_verify(&pubkey,
> +                               hash, hash_len,
> +                               signature, sig_len);
> +       ut_asserteq(tv->expected, ret);
> +
> +#if !CONFIG_IS_ENABLED(SHA1) || !CONFIG_IS_ENABLED(SHA256) || !CONFIG_IS=
_ENABLED(SHA384) || !CONFIG_IS_ENABLED(SHA512)
> + out:
> +#endif
> +
> +       return 0;
> +}
> +
> +static int lib_ecdsa(struct unit_test_state *uts)
> +{
> +       int i, ret;
> +       size_t num_test =3D ARRAY_SIZE(ecdsa_test_vector);
> +
> +       for (i =3D 0; i < num_test; i++) {
> +               ret =3D ecdsa_test(uts, &ecdsa_test_vector[i]);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +LIB_TEST(lib_ecdsa, 0);
> --
> 2.43.0
>
