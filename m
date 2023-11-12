Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3457C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 20:06:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFE8687456;
	Sun, 12 Nov 2023 21:03:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lkl8BHpo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 718E387026; Sun, 12 Nov 2023 21:03:34 +0100 (CET)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6385B87498
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 21:03:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-da30fd994fdso4061048276.1
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 12:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699819409; x=1700424209; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5GRweUT1uMq2KilyWHAO7FHqbJECAT26/CmFiAC2wTM=;
 b=lkl8BHpoSU1Qx7eERr9u1w19XTOlX66MYGdWFN8x3nsSflnVr4lqRMIpuhCZtiaIpp
 NKiQ8wqNsieRewSTcDXopIMZMkUQnDF8xh1npzJMmU8Eah0mzyM2xa4E8M5CMvSoH8AZ
 9U6e/uK/mihM+nwaubW9vl5KrkPSDix073m3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699819409; x=1700424209;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5GRweUT1uMq2KilyWHAO7FHqbJECAT26/CmFiAC2wTM=;
 b=vDrcRfsNahGEhgsKRg4m3cvaeeXhPCdHm7CTXwTazr3eKBdVIDGf4oANX8JZsw0Nmp
 dygpxJpPT+Stf6SI/cUuOf9VoJYzCVT4Rko0KkQMqThzLepc4r3sqn616k9AseZDoVr8
 R34tjZ3H0MYPhLIbyznV9Wc7WDcsCEfo1QXtsXS7/Vn0djJ0vyQZQzHw62kRwOCsM8vq
 ZCmYgBh2pLhYv6ptdWYKBSVBiiDdoZlM8iqXsym6L1j+5qOHa8u9FGSmS8coNYJUnrcQ
 QmGxdSMuTO79LFFettqOfMR8OjLV2D2cTMIv98wiw8yQDrENEkIBBmkbP8+RwaRGk7ZR
 mJyw==
X-Gm-Message-State: AOJu0YzyNqN6LLxKgQPsYRiSvQ07xnOUYWdTgCLftDFtATjKhl4bAx8g
 ZNAGt2Z9MIocNGratEV+PMQW5Eo/qiZvrDmcrFv6zFrUBeXc0QlT7rk=
X-Google-Smtp-Source: AGHT+IFhDesfcDRnTEwTr/+SLd62sPSUEcoemtwtO+2HUnok2mlp6WN/i6yZIjiPVhcLInObECR8C87G1T1AZ8f4Gjw=
X-Received: by 2002:a25:3417:0:b0:da0:454d:cf57 with SMTP id
 b23-20020a253417000000b00da0454dcf57mr5270940yba.16.1699819408967; Sun, 12
 Nov 2023 12:03:28 -0800 (PST)
MIME-Version: 1.0
References: <20231112070316.17982-1-heinrich.schuchardt@canonical.com>
 <20231112070316.17982-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231112070316.17982-3-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 12 Nov 2023 13:01:28 -0700
Message-ID: <CAPnjgZ3scsicFCvRwWapE9SxPoj2Vk9+TJRx2b0o7iE7vQAv3w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] cmd: acpi: fix acpi list command
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de
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

On Sun, 12 Nov 2023 at 00:03, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> ACPI tables may comprise either RSDT, XSDT, or both. The current code fails
> to check the presence of the RSDT table before accessing it. This leads to
> an exception if the RSDT table is not provided.
>
> The XSDT table takes precedence over the RSDT table.
>
> Addresses in the XSDT table are 64-bit. Adjust the output accordingly.
>
> As the RSDT table has to be ignored if the XSDT command is present there is
> no need to compare the tables in a display command. Anyway the
> specification does not require that the sequence of addresses in the RSDT
> and XSDT table are the same.
>
> The FACS table header does not provide revision information. Correct the
> description of dump_hdr().
>
> Adjust the ACPI test to match the changed output format of the 'acpi list'
> command.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         add unit test for offset of field Entry in RSDT, XSDT
>         merge patch 2 and 3
>         remove leading zeros from address output
> ---
>  cmd/acpi.c     | 48 +++++++++++++++++++++++++++++-------------------
>  test/dm/acpi.c | 18 +++++++++---------
>  2 files changed, 38 insertions(+), 28 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
