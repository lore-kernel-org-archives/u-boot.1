Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 923F5FF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 18:23:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DD5F8468E;
	Tue, 28 Apr 2026 20:23:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TiXFJJNF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C510E8469E; Tue, 28 Apr 2026 20:23:08 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81D2B803C6
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 20:23:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ba7a1cc0380so1969167566b.2
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 11:23:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777400584; cv=none;
 d=google.com; s=arc-20240605;
 b=ZvAl2/8jSikwHDMfC3FS3SMXuaEMWXnYuXzqmFPb8fr+fGkZkK2PTlYta+eVFT4ekO
 78GPUf9YQv9rRTAHRzYJSg9sRtsJQXh1oUy0TQds7/NbAwL9tQD1zFjMNN/ZTTSSokzj
 vYDi2RcE2V8Up35aWfrZXFYPdhd/BVtHYPvs/opH+JNO4BlOZxhfjM1cl1NDRLP2Hsf+
 UqM66d/zAM8tDLkTHFLUxuBDqQcMuECAQB08vH2Xo4z1OLamM9FSj7vEfKlyoRfreoTX
 SN15ojwOi/2KbC0mokg0NRLorctCYn7nHOF0qNS6n77iK/BxBpIO2jYMHGB5EDE0m8Hy
 kXRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CdXVyYEfc9MVatREugFrGep+HPBcXEjNAsZG9fLrcpY=;
 fh=FSZLg1kBZKtmq7hkO96s8J8bywdf/NrVlQg027zGQAY=;
 b=XgYvWEMbEu091Hru6Z78otyk5ulaLK9jyUp5pmuwpwlEclSkJDzz5n1lS00nZoB1Ak
 MV+sxSdg94BdLgl2trrgAUXp/fI4N/9Ith1XQG39+yHtF4Q5zEyQlaQ6RE2zMHRRy+02
 JHzbUN/HwnF2UZFUlOWU173uldXuSSJHLOYck7yKYrxPGOiLYKyj3rECQI5sp82U1tYl
 dorxt4KEXUSoFUhvUKY+PWOxsldU+eXQn4MannnJaJuxYKJOUGyJwJnuf09PbJIIofAp
 FiehKrG9msYg4WNxBNKbPKe+kGIqDxuzHSSKDxjUOxm8od3ZVRw4NHEcrZu6Ce7zGg2R
 q6kw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777400584; x=1778005384; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CdXVyYEfc9MVatREugFrGep+HPBcXEjNAsZG9fLrcpY=;
 b=TiXFJJNF9G/ePoydIbcm3rWZy5zrRodneU/UVEaxpQZyinnc+C81ho0li/G6Ny7sgj
 PpyqEXmZRuKPXBmOl3J0buMffpKZRW2yG6CacDAyWIksaJQjU/VlOQbgN+IMXscQPgyA
 3Uexy7skE+IURWmOp4qx29cH0eohLIfa8x0Tk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777400584; x=1778005384;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CdXVyYEfc9MVatREugFrGep+HPBcXEjNAsZG9fLrcpY=;
 b=Wa7YTQ0y4/ms/6yv8rNx/5ZbSoxIcSi4wdbjCi3PJxF2CbsKY8ZZWfGayxjqNAAFeM
 +AyQTqUZ0zJS0a5l754kayPEJqy4L0+BH7Jgm5K0FyNSiqTfCDHrQqvxyBEuGUsCPAx4
 kOYi8n9RJlc5TpRLxo4gEu7jzjn50bVtTGcYQlO+F96DknjqpogGzAi9hNnxj2t1mfNW
 Wm3dOKeys5lQAJcsC69J5oZpdKKcb3CZ2vV4Zgk3bhoaDi6GT8SJafDz8eb67HhJ6xZ9
 JvZxLVK7/aqWP9426twhDsTrAOZFyBNsml2BoPV56flAWuR2x95zDbjHg0G0TqysLHdr
 zjSQ==
X-Gm-Message-State: AOJu0Yz/6kEhR9Ksjg0SX9c8ncEKwUz6yJfZgxEb59pDgdEcZTVriRyc
 +FFHcZz5uSC4q8L/701MXi11xWVLu5pPrSZOtP4HuR+xDAI9DZbNLfNRfOeZ5bN4OMgsavHqDSS
 Ui1Irs2kaVmJW4FBNXpPBVVJ47M9B4UkcNjJ6Odof
X-Gm-Gg: AeBDieud7QOxfd2b8/sKxUGWICI1klfpQFDiYl3tCarooq4lOcMLof04YG7PnwMQhjn
 cIsxuak6s8f8ZTNbY0Pa5LqFngRjdp7KusAMshDZFSTwO284ZoeV3YajBAVzo8Pl33CRB8kC9li
 Zyr3yxC00+4T/PvfTY9JiWzmOqUZYBkQ9TxzpurzN3uFQ+RmzTFrldb+bOLrPvZWqzfLpaGH35W
 rpkSkqloYMcAJQDw5P3IeP+7Ut2AIG5rqJIIFHIwVNlN8wKaaC2mkA2tHVPfg/N+DQIRLahJmGa
 l2NIZ0WBA9E2mSSeIUgVc12LTVs=
X-Received: by 2002:a17:907:d312:b0:b9e:f58:c581 with SMTP id
 a640c23a62f3a-bb80443e813mr257503866b.45.1777400583153; Tue, 28 Apr 2026
 11:23:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260427-fb_gpt-v2-0-9e7fe3c1649a@oss.qualcomm.com>
 <20260427-fb_gpt-v2-4-9e7fe3c1649a@oss.qualcomm.com>
In-Reply-To: <20260427-fb_gpt-v2-4-9e7fe3c1649a@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Apr 2026 12:22:51 -0600
X-Gm-Features: AVHnY4IT6N-nU8qI0AvUbi2Wmd0JXr_owuMA22rVxHizqAHPA_89NtKGsk5fvok
Message-ID: <CAFLszTh2fe02ux+hC12OrDJA827HeRgvsssw0qRG3wuHAfm5yw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] doc: fastboot: Document block device selection
 syntax
To: balaji.selvanathan@oss.qualcomm.com
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@nabladev.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitrii Merkurev <dimorinny@google.com>, 
 Adrian Freihofer <adrian.freihofer@siemens.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>
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

Hi Balaji,

On 2026-04-27T12:06:41, Balaji Selvanathan
<balaji.selvanathan@oss.qualcomm.com> wrote:
> doc: fastboot: Document block device selection syntax
>
> Add documentation for the device selection syntax in fastboot
> block device operations. Users can now specify target devices
> using 'N:partition' format where N is the device number.
>
> Document usage examples for regular partition operations like
> "fastboot flash 0:boot boot.img" and partition table operations
> like "fastboot flash 1:gpt gpt.img". When no device number is
> specified, the default from CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID
> is used.
>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>
> doc/android/fastboot.rst | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)

> diff --git a/doc/android/fastboot.rst b/doc/android/fastboot.rst
> @@ -147,6 +147,38 @@ The Fastboot implementation in U-Boot allows to write images into disk
>  partitions. Target partitions are referred on the host computer by
>  their names.
>
> +Device Selection for Block Devices
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Other subsection headings in this file use sentence case ('USB
configuration', 'Partition aliases', etc). Please rename to 'Device
selection for block devices' to match - and likewise 'Partition name
formats' below.

> diff --git a/doc/android/fastboot.rst b/doc/android/fastboot.rst
> @@ -186,6 +218,15 @@ configuration options:
>     CONFIG_FASTBOOT_GPT_NAME
>     CONFIG_FASTBOOT_MBR_NAME
>
> +When using block devices (`FASTBOOT_FLASH_BLOCK), you can specify the target
> +device by prefixing with the device number::
> +
> +   fastboot flash 0:gpt gpt.img    # Write GPT to device 0
> +   fastboot flash 1:mbr mbr.img    # Write MBR to device 1
> +
> +If no device number is specified, the default device from
> +CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID is used.

This duplicates what was added a few paragraphs up in 'Device
Selection for Block Devices' (same '0:gpt'/'1:mbr' examples and the
same default-device sentence). How about dropping this block and
adding a one-liner cross-reference, e.g. 'See above for the
N:partition syntax when using FASTBOOT_FLASH_BLOCK'.

> diff --git a/doc/android/fastboot.rst b/doc/android/fastboot.rst
> @@ -147,6 +147,38 @@ The Fastboot implementation in U-Boot allows to write images into disk
> +This syntax is supported for:
> +
> +* Regular partition flashing
> +* GPT partition table updates (gpt or N:gpt)
> +* MBR partition table updates (mbr or N:mbr`)
> +* Partition erasing operations

Just to check, does erase actually go through the same parser? It does
today via fastboot_block_get_part_info(), but worth confirming it's
exercised since the commit message only mentions flash.

Regards,
Simon
