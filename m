Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34186C46CD3
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 09:54:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A38DA87971;
	Tue, 26 Dec 2023 10:50:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VA+4JiNh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6260187910; Tue, 26 Dec 2023 10:50:54 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7BEA878EA
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 10:50:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3bb907d28fcso1912084b6e.1
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 01:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703584249; x=1704189049; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UHKOzTs8+RL0vMQKGsfCP32R3N9kTf9wYB8+6sd81SM=;
 b=VA+4JiNhoNQh6hoUPnhbZku1OkUccYZ8Js8pocoKSbwM2b5USKjedagIDNbw9wDgIO
 dlWJpsgAMaRUgqcit4Mvam7mSThlPUpI+DdLNuGOyQnnaD0gwkpsZ33uqZwI7rPg+Bk5
 fP1v3I+GBiaxT3RIS0/KP0zmusGNgrh9xWoDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703584249; x=1704189049;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UHKOzTs8+RL0vMQKGsfCP32R3N9kTf9wYB8+6sd81SM=;
 b=waEdd+kmdFdE/oSRKG+fGAoVd08XPQrgpIXt54JlMfi6O0yKvqzKDx1Ca9nKC5jQu7
 txnCnGjxchQ0+BdOIem9mwP8DhCp22n+KyQl3ZjbatP9LPZFS335vLPf5mRu6ZtiOHgP
 dipPiOD8W4a5KaR6XT56VbD7wLp/CvCAOB3EJrg9Vio0vTs4WxeW7xgUgiPSaAs0xHN3
 fiTYgWFvUNZoGji0m/ZA80QNUjVM+/+9th/T7yO8N9G9EAKFB4qL2mYMZn6bAJudgWPi
 GW9wpVnrha6nxrM6hdgispTsuBdeiGPTEIBR1Hm5qK336ZEyyiMcMQMENsz7Yuy0h4ch
 4vkw==
X-Gm-Message-State: AOJu0YzPrM/eIjLiQJb8R8O3BMaBYO+FR7fK0xxynIxxeepkgFW0IxPT
 ygBtH7zCu1mEnJsGaJo17xOmY1zosVogubXYVioVv0EnLmDA
X-Google-Smtp-Source: AGHT+IGdGGWNMxoCOliM0AIvZrEVruOgZ2Cfn/sByvv4cev06dBGktLk4qK5ejXIE1Zlg4gE7ptWxDcgCjn/zJT8il8=
X-Received: by 2002:a05:6808:10c6:b0:3b8:b4b0:e266 with SMTP id
 s6-20020a05680810c600b003b8b4b0e266mr7213894ois.2.1703584249219; Tue, 26 Dec
 2023 01:50:49 -0800 (PST)
MIME-Version: 1.0
References: <20231218181901.337515-1-raymond.mao@linaro.org>
In-Reply-To: <20231218181901.337515-1-raymond.mao@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Dec 2023 09:50:30 +0000
Message-ID: <CAFLszTh2EUpu4yVtRD3NuYRS6keY-xR683UgWqKRBoUhMP5W2w@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] Support Firmware Handoff spec via bloblist
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, jwerner@chromium.org, 
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>
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

Hi,

On Mon, Dec 18, 2023 at 6:19=E2=80=AFPM Raymond Mao <raymond.mao@linaro.org=
> wrote:
>
> Major changes:
>
> Update bloblist to align to Firmware Handoff spec v0.9 (up to commit #359=
2349 of the spec)
> (https://github.com/FirmwareHandoff/firmware_handoff).
>
> Includes:
> - Align bloblist tags with the FW handoff spec
> - Add an explicit alignment field in the header
> - Update bloblist magic and version
> - Use a packed format for blob record header
> - Change the checksum alorigthm
> - Use a void entry to handle the alignment
> - Adjust the headers of bloblist and blob record
> - Align the bloblist record data section start address
>
> In v3, the implementation from boot arguments to bloblist and how to load=
 the
> FDT from the bloblist are moved to a forthcoming patch serie.
>
> Raymond Mao (1):
>   bloblist: Align bloblist used_size and total_size to spec
>
> Simon Glass (13):
>   bloblist: Update the tag numbering
>   bloblist: Adjust API to align in powers of 2
>   bloblist: Change the magic value
>   bloblist: Set version to 1
>   bloblist: Access record hdr_size and tag via a function
>   bloblist: Drop spare value from bloblist record
>   bloblist: Change the checksum algorithm
>   bloblist: Checksum the entire bloblist
>   bloblist: Handle alignment with a void entry
>   bloblist: Reduce blob-header size
>   bloblist: Adjust the bloblist header
>   bloblist: Add alignment to bloblist_new()
>   bloblist: Update documentation and header comment
>
>  arch/x86/lib/tables.c    |   3 +-
>  common/bloblist.c        | 205 ++++++++++++++++++++++++---------------
>  doc/develop/bloblist.rst |   4 +-
>  include/bloblist.h       | 166 ++++++++++++++++++-------------
>  test/bloblist.c          | 105 +++++++++++---------
>  5 files changed, 287 insertions(+), 196 deletions(-)
>
> --
> 2.25.1
>

Just to say that this series LGTM

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simonn
