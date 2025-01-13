Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF99C02180
	for <u-boot@archiver.kernel.org>; Mon, 13 Jan 2025 15:13:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F5E8801CF;
	Mon, 13 Jan 2025 16:13:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yoaThUbR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BEF9805DA; Mon, 13 Jan 2025 16:13:47 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD64B80141
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 16:13:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-216401de828so72819525ad.3
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 07:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736781223; x=1737386023; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5yCsre5CpHlpjvvtsiL0w9pgn/K3ITXAxlzy8Vg4t2o=;
 b=yoaThUbRd5wXcP7CVvHFS0yBviEkdpXan3LCIa0/9FESEMYV97fcoDOZBKriEKE1oT
 PUHfbkc91nktxtpdAqR3NL4cXFQeaGxh6GZJftsYyImTM9/KxBBK35ueihfSjwtAj2BK
 IwF2m1hbhR4sOfIceJV+8HQ2k58RiEmyQp6lnUNu9H29CeKtFLXsZ4be1bmcXDxs40Lf
 ofKd+GkgLsLztY0zfNrHBL/CWMBMzNyTZEkM1a60BaHUOA51p1OEvr1v1EjqWms9qQDs
 SQcViqOeeK3MDvx4P2GYt+Ap6r0nd3q/L2Dp8vnFV5LqGgNCmtQHTeThJVJDE/OIajE5
 +cHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736781223; x=1737386023;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5yCsre5CpHlpjvvtsiL0w9pgn/K3ITXAxlzy8Vg4t2o=;
 b=GojDgF6A4U9aq0haWFtoc5UTvLLgMVNyZPeOBF0JS+RIEicqP93zqe1y8CweuDhbx6
 qf6WrblQvsrLAY5tsUxAsMvFL1n4+ljcpBB6pa0OAXa3j4iPKsol2X1Kb7rSPy1Fr4TK
 B+fQHcK/VVSR9QEHsmDewgvldMs3w/Lj69Sb/QpIJiaf5cQaxjLJ37zYqhbk58SnAMn6
 A/6+uWyMQTbgpH3zm2vVGkxiUj1oY1LfDa1JDp2bHK89PbS/al29pIMkcTZvIxhgUXHx
 W36tMhRHtiLUjb+qkCi5cUpC/bGAADOskQRm8CGQnb/YRENntcJYDDRudHCewjInv7ri
 lDeQ==
X-Gm-Message-State: AOJu0YwGKT55HTCHlEv5Se9J+iIWIpYMTa81LE86EVCH3Vz2+PlagQBY
 gtNFLYqAOY2Kd+JErcmLeYY/x1waKcIE8tHGmPzZzL9EVgxFB8wrwQJW2LJYdIiTP2V8DXSp4xj
 zU0vH68K/I1wCSbe8Ic2IFzeR8OGooixHWKWz1w==
X-Gm-Gg: ASbGncsfywaN/dapEhqPlS2UC+rir6xtAbJUmWQbOHuU99i157riA/maDktFBH3ePIs
 NWaCJmAwkr/ZfO7K8Ec0/1ieoMFAhAh3+uf7IIZGEYr9cjvW7DFNcB5xTD2ITwTEXHgrI4Q==
X-Google-Smtp-Source: AGHT+IH3/zEVUzpbW81aSd4kTuDjVkQ0Qc52gpCpxI07eWZb5Sk6FSbAvVFw5rXvMvEGzKhHYra893uuA/VKY7b1K6Q=
X-Received: by 2002:a17:90b:3a08:b0:2f4:434d:c7f0 with SMTP id
 98e67ed59e1d1-2f548ead814mr35968238a91.12.1736781222606; Mon, 13 Jan 2025
 07:13:42 -0800 (PST)
MIME-Version: 1.0
References: <20250110215640.892539-1-raymond.mao@linaro.org>
 <20250110215640.892539-2-raymond.mao@linaro.org>
 <E578B5D7-5692-4989-B222-D11ABBFD8478@gmx.de>
In-Reply-To: <E578B5D7-5692-4989-B222-D11ABBFD8478@gmx.de>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Mon, 13 Jan 2025 10:13:33 -0500
X-Gm-Features: AbW1kvZWyqOB6tR771Vzrtt8LqeqRY8XTTSeTAd_VHSX2KydJnwStyX4y-U6qBM
Message-ID: <CAEfUkUJY6Wv0Mh-EFp9uQww4PZ4qFciQ32odthZKHwZhaNZ8NA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] tcg2: decouple eventlog size from efi
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Levi Yun <yeoreum.yun@arm.com>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Heinrich,

On Fri, 10 Jan 2025 at 19:06, Heinrich Schuchardt <xypron.glpk@gmx.de>
wrote:

> Am 10. Januar 2025 22:56:34 MEZ schrieb Raymond Mao <
> raymond.mao@linaro.org>:
> >Move default eventlog size from efi to tpm for using in both
> >modules.
> >
> >Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> >---
> >Changes in v4
> >- Initial patch.
> >
> > include/efi_tcg2.h | 2 --
> > include/tpm_tcg2.h | 2 ++
> > 2 files changed, 2 insertions(+), 2 deletions(-)
> >
> >diff --git a/include/efi_tcg2.h b/include/efi_tcg2.h
> >index 8dfb1bc952..7ed8880991 100644
> >--- a/include/efi_tcg2.h
> >+++ b/include/efi_tcg2.h
> >@@ -28,8 +28,6 @@
> > #define EFI_TCG2_MAX_PCR_INDEX 23
> > #define EFI_TCG2_FINAL_EVENTS_TABLE_VERSION 1
> >
> >-#define TPM2_EVENT_LOG_SIZE CONFIG_EFI_TCG2_PROTOCOL_EVENTLOG_SIZE
> >-
> > typedef u32 efi_tcg_event_log_bitmap;
> > typedef u32 efi_tcg_event_log_format;
> > typedef u32 efi_tcg_event_algorithm_bitmap;
> >diff --git a/include/tpm_tcg2.h b/include/tpm_tcg2.h
> >index 6519004cc4..25a31daf65 100644
> >--- a/include/tpm_tcg2.h
> >+++ b/include/tpm_tcg2.h
> >@@ -65,6 +65,8 @@
> > #define EFI_DTB_EVENT_STRING \
> >       "DTB DATA"
> >
>
> Please, provide Sphinx style documentation for defines.
>
> >+#define TPM2_EVENT_LOG_SIZE CONFIG_EFI_TCG2_PROTOCOL_EVENTLOG_SIZE
>
> Why would we need such a define at all? Can't we directly use the CONFIG
> value?
>
> Why should the CONFIG value remain in lib/efi_loader/Kconfig? I would not
> expect the log size in the non-EFI case to depend on the UEFI subsystem.
>
> This eventlog size should be treated as part of the kconfigs of
TCG2_PROTOCOL but not lower level of TPM2.
We don't have a separate kconfig page for TCG2_PROTOCOL, if my
understanding is correct, all TCG2 stuff are supposed to be used by EFI
only for now.

Regards,
Raymond


> >+
> > /**
> >  *  struct TCG_EfiSpecIdEventAlgorithmSize - hashing algorithm
> information
> >  *
>
>
