Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE81EC44508
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 16:28:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10D5F84B61;
	Wed, 15 Jul 2026 18:28:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="o/RTdAId";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3A2E84B88; Wed, 15 Jul 2026 18:28:50 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DAF284B49
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 18:28:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-497deab2d66so1969430b6e.0
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 09:28:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784132927; cv=none;
 d=google.com; s=arc-20260327;
 b=eM+07aIW1/9fcwIif4+BQngo0EsiR06TkPqRzxdym0oJi148WJNhxT7T1tHbVvZMcF
 kfs5mMl9qVmiKfmdJemdTw4EXzf9aHIAAu61WQYD8KGOOwalpjXvDlGoJYOKsecwkhLL
 q0jjY0gyeOFOjplCR05BK8vyjVfn6Y9T9XxAcQVnfnBSNsk+hPTiIq7qw85HQMgkt/S1
 J4bYUd4Bc/A2aXe8DwXoTUxGZ+WHOXzFUwsqKbxFDOoWrqF6W1r6IiVUM6qWnxNVMspu
 Olgf3w8R9xawqBnuCjFSATQWh+68HLarfvekXTjtVnzeAQiGvuuqjgFz81eUrG9JAdmt
 IrRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BD3LMNZ/6t04UflP1MzJv+35iyZnELIUa4hlWx5YGHA=;
 fh=O9tFADQ6yXXlDfHWZ/uRQFPEq9GVuIB3D47unK3I/bA=;
 b=jgwiu+Pq/YYLcFDVVS+/i5jkGZpWtb3rnfDwVa6R+dh2rEUfJJvEwNIb1MDlFTDAmB
 fi6PrUTO+JwKM2HYlwEy0EHS47Pu6G0mu0XpEUR1l3mE3HX5RAiRRTzV2bcMyUoz1I7s
 n/lh2opsm4jpIdKFc7uEylgLRbw+3FJZxn3WHNm4bd7nGPpf/8IAyjmvmjXAmJa8GqEZ
 Vix/eF7UzQoQ0nzrxl97ehdwfBHlUV7xwFLoEpxnLhgjo10iPhe3HLIESFmtZwk+YHXx
 DWjCrC1D/O0x54awl7hR7YLLN7cfxknxKe9RLwTWEg6uwh5QBVg6eZzgaBoORdNxfKOg
 PJqQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784132927; x=1784737727; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BD3LMNZ/6t04UflP1MzJv+35iyZnELIUa4hlWx5YGHA=;
 b=o/RTdAIdtxBEZkola3GDWxPOc+CKgBc12ZK+QCIb9leFDcgOiwBvn/z1zO8YnbtlfE
 2VpqOCUSaVmsbha7Y24wE6SxQHG+Uk/fZGVnsExOnFxd8qTCtld8eHtXK6IdBRSqf0lJ
 UbOHGFgamqcqmq62FEP2ztj+QqewKnZMNPBAMsDkf6MvS081E0xco0no/w7sdXFFKV8P
 Gjkqi6ZRhwXKZr5fwNmtR0M37vlopLN83vT+PHjAfGoxCyZPemTXosJ3YO8GH7f75YQy
 0y4ifJEvaysdqFcwB5n+GO1LvYy9+GtCV7KS3kC3Jt8/QhzYBMVA5qJ2EaLIUGpVLXie
 IGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784132927; x=1784737727;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BD3LMNZ/6t04UflP1MzJv+35iyZnELIUa4hlWx5YGHA=;
 b=I5DH0mXilAKMToz3tuKFOUbikNLXB5U7TYpM2tBIlzJe4xBEYqvz2Ga5zUMTpfmvt3
 5KK6Qw9zFbyweE/nC3juTvFLsdCOhweDO71b2cnP1WCt1g2TMn4DixJ5tf8EYYqJvZ/6
 DPF0B5tuhOg1V07/QXJgn8HxNCjAj4wJgV+g2GNCtS3oZw6iyQ5rfsx8XdGB/oU+NrX3
 EDKPCLdZHSi0x9i6pBOjj0gc/gbhDCylqKAXnhBOEZFKr02Mk/Wq8OhRjUlhfjS5yyzK
 IVYOTx8Ua0OB5cJqivZyiu68rJPXkEnWVfo6KmvXTTTqq0Vrt68BITbWIx0skDSscwlI
 engA==
X-Gm-Message-State: AOJu0YykRbpOhqQz8hr836grw6yQnlq7Q91jtvhIqr40tE7k5di2PLnZ
 YK5g7veYczgzPiMcJP8AtctO/uWCAd41xy5BtLnXrr+PTgGDQz+QfSiuxoUA8Br0NrVHG7zE3wT
 QF3vI9TwsI7nD3ODB9WRBjJBilPWZCH45f3ml
X-Gm-Gg: AfdE7cm23IP3VqY9FQcbU3rBOKZCedzLYLHqobqrSz/8zcADsrsUg6bke9MibhbUypD
 0M2AEIFUEDw0fjOviX2zV1lLi311iESKLGu/hopoPXAE/ZfWOotR5K/VaNsWEW1eZZUABr3sJaY
 XZrEc4VPcBRNGnV9BDfiI8X1RXC75ZoPcHLqGwukCH5xHywTGPuU2ClEQbkmumkZ1Ruvjrd2w5R
 jpbHhvF5PX+WTOhTFO0w1pS537AunYzrcdKIaSubj9Ep4UwWMk9CPZv5vtHAxOf7JCazuCTl4iC
 AWNwvvHM54dHOoUREu++fKmZdAgSwg==
X-Received: by 2002:a05:6808:14d2:b0:495:f0ac:8297 with SMTP id
 5614622812f47-4a4acb05795mr22048b6e.33.1784132927166; Wed, 15 Jul 2026
 09:28:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260712-avb-libavb-1-3-v1-0-44a50dfe2f23@gmail.com>
In-Reply-To: <20260712-avb-libavb-1-3-v1-0-44a50dfe2f23@gmail.com>
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Wed, 15 Jul 2026 18:28:36 +0200
X-Gm-Features: AUfX_mwU3bcLgWj9HufLf3Zr1pB_lCRogUCy2FbMFZVspQqZFQdPUY2hzhH2LzY
Message-ID: <CAByghJZk=+pgOaXWKVmxUaw4p_fEFAtzwWpKmpqEN7eV_THw1g@mail.gmail.com>
Subject: Re: [PATCH 0/2] libavb: update to AOSP 1.3.0
To: u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
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

On Sun, Jul 12, 2026 at 4:07=E2=80=AFPM Igor Opaniuk <igor.opaniuk@gmail.co=
m> wrote:
>
> The vendored libavb under lib/libavb/ has been frozen at a ~2019 AOSP
> snapshot (AVB version 1.1.0) for about six years. A v1.1.0 library
> rejects any vbmeta whose required libavb minor version is greater than 1
> with UNSUPPORTED_VERSION, so an image signed by a newer avbtool that uses
> a 1.2/1.3 feature fails to verify. This series re-syncs the library to
> version 1.3.0 and picks up the accumulated upstream fixes.
>
> The vendored files are taken verbatim from AOSP external/avb commit
> a1fe228b8654 ("libavb: support chain partition no ab"), the commit that
> introduced version 1.3.0 [1].
>
> Functionality the library now parses:
>   - AvbVBMetaImageHeader.rollback_index_location (v1.2)
>   - AvbChainPartitionDescriptor flags / DO_NOT_USE_AB (v1.3)
>   - AvbHashtreeDescriptor FLAGS_CHECK_AT_MOST_ONCE
>   - AVB_HASHTREE_ERROR_MODE_PANIC
>
> Scope / integration impact:
>   - The AvbOps callback set is unchanged between 1.1.0 and 1.3.0, so the
>     U-Boot integration in common/avb_verify.c needs no changes.
>   - The U-Boot port is preserved rather than pulling upstream's
>     BoringSSL-oriented crypto restructure (sha/, boringssl/):
>     avb_sysdeps.h / avb_sysdeps_posix.c and the flat avb_sha.h /
>     avb_sha256.c / avb_sha512.c are kept as-is. The SHA API signatures
>     are unchanged, so the retained implementation stays compatible.
>   - Per-file licenses are preserved (avb_rsa.c stays MIT OR
>     BSD-3-Clause). The Apache-2.0-licensed avb_crc32.c is not imported,
>     as it is unused by U-Boot.
>
> Note: patch 1 is a verbatim upstream import and therefore triggers a
> number of checkpatch style warnings. The files are intentionally left in
> upstream (AOSP) coding style to keep them diffable against external/avb;
> they are deliberately not reformatted to U-Boot style.
>
> [1] https://android.googlesource.com/platform/external/avb/+/a1fe228b8654=
3a21739c51352f5ce72f134fccfa
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
> ---
> Igor Opaniuk (2):
>       libavb: update to AOSP 1.3.0
>       doc: android: refresh AVB provenance and pin libavb reference
>
>  doc/android/avb2.rst                        |   7 +-
>  lib/libavb/avb_chain_partition_descriptor.c |   1 +
>  lib/libavb/avb_chain_partition_descriptor.h |  16 +-
>  lib/libavb/avb_cmdline.c                    |  44 +---
>  lib/libavb/avb_descriptor.c                 |  62 ++++--
>  lib/libavb/avb_hashtree_descriptor.h        |   3 +
>  lib/libavb/avb_property_descriptor.h        |   8 +-
>  lib/libavb/avb_rsa.c                        |   6 +-
>  lib/libavb/avb_slot_verify.c                | 313 +++++++++++++++-------=
------
>  lib/libavb/avb_slot_verify.h                |   6 +-
>  lib/libavb/avb_util.c                       |  46 +++-
>  lib/libavb/avb_util.h                       | 140 +++++++------
>  lib/libavb/avb_vbmeta_image.c               |   1 +
>  lib/libavb/avb_vbmeta_image.h               |   8 +-
>  lib/libavb/avb_version.h                    |   2 +-
>  15 files changed, 384 insertions(+), 279 deletions(-)
> ---
> base-commit: 6741b0dfb41dc82a284ab1cff4c58af6ef2f3f9c
> change-id: 20260712-avb-libavb-1-3-f273645366da
>
> Best regards,
> --
> Igor Opaniuk <igor.opaniuk@gmail.com>
>

Just a gentle ping on this patch series

--=20
Best regards - Atentamente - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
https://www.linkedin.com/in/iopaniuk
