Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 966EFC02192
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 00:39:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 646A2803B5;
	Tue,  4 Feb 2025 01:39:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DLOWN41l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18AAA80050; Tue,  4 Feb 2025 01:39:10 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5790480207
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 01:39:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5d3f65844deso9283039a12.0
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 16:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738629544; x=1739234344; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hgRah0KiBl7HYeJNOlQhK+GtCS/oWATzO0w6UCnJVc4=;
 b=DLOWN41ldJu2HN0uquEuOKvgyftRN/n9hT/wHx4V/T1lwo0fU8rt6ayJKpyOn4A7hF
 VzdmbM1rL5ojCXLnWeRasNce1Ts6LNg3G2SxGiMBAxHKjVdCkbiSDnSv0R3dX5xxejvk
 wXnn9fS+i7eQn0Lq0QLnCQWYL7pO7NyB3x2Mg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738629544; x=1739234344;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hgRah0KiBl7HYeJNOlQhK+GtCS/oWATzO0w6UCnJVc4=;
 b=Y8DB6rG7+Z3IGEd8zMVMr9MqHg/8NF3ClRcY4AnfOvgym6I3Tjb9Rmvtk6ktKjcBtz
 Qm6iKEic/9G5xX1qp5+Hjozv1/hUs9zBdxuDBn1SJ/kfZSPHgdAzKOc0fVVX+EvNvosK
 4QQOnJ/Z/ErMPGINClGsUJePTv1IUC4//nDLQ6JjBuflcf1jrmMJbGwil8OqJAnZwPhj
 CafBwyfAovvEpGGPgXvDYltdFTL8DP90wuo3T54SqWEjq1QttDoz/KI8vb9O/Mryoj8v
 Ll5MYRAbMdwOluPFypjcZNRP/t3fnSZE4r9XuzOQcyB/IECA26R0mm46/VUHHDi/FUKs
 az6g==
X-Gm-Message-State: AOJu0Yy9HjI7bbhP5zF9ZE1tjeUIOThm5/ufdkxVtUczM/aDmVOIAOIG
 zwpFHSXeZMoeFLduDF1SODeLVU5NWXiCk9EdYGZlNXQ39zzUgr8vn6wLhrMTiSsxaZBgvjrfrJh
 AEyEFxdKH5vrarzaAZ+Peb/dxrQiQ+ILnPoh2
X-Gm-Gg: ASbGncvbU6pr88eQaHtN/gSsaQ1OfNwyF1zV+08I+XOlzrangG9+DOjyn2mRxcwyUNG
 RtyS+4iYzqME83ZloA26S6kad22gc3JCuebJQ0x64oPoM8kBGG7U8wiaTEb8LS5MJLkd8UwDIKg
 ==
X-Google-Smtp-Source: AGHT+IFl4gUwlNRK1tTzf0VQvsy/b/VbRn6BIpwqH+OllkkxeN2RgMkA/uvWN+WMvIEQ7heolxToIzkJVbqcG5SWRHw=
X-Received: by 2002:a17:906:d550:b0:aae:8495:e064 with SMTP id
 a640c23a62f3a-ab6cfdbf717mr2542398666b.40.1738629544443; Mon, 03 Feb 2025
 16:39:04 -0800 (PST)
MIME-Version: 1.0
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-22-sjg@chromium.org>
 <20250203200937.GL1233568@bill-the-cat>
In-Reply-To: <20250203200937.GL1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 3 Feb 2025 17:38:52 -0700
X-Gm-Features: AWEUYZl4scbk1aPI0RlbYAHQWl6ZdzpEJ2YWUUuqlvp-TS7Nj1Wspbxb7IElkqw
Message-ID: <CAFLszTgO-nErzRg4FnM3rGCeHgfsAKCui3p9OhqP1YipyyN3=A@mail.gmail.com>
Subject: Re: [PATCH 21/32] efi: arm: Drop exception code when running as an
 EFI app
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Patrick Rudolph <patrick.rudolph@9elements.com>
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

Hi Tom,

On Mon, 3 Feb 2025 at 13:09, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Feb 03, 2025 at 10:42:14AM -0700, Simon Glass wrote:
>
> > This code cannot be used since EFI is in charge of managing exceptions.
> > Drop it.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  arch/arm/cpu/armv8/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Why is SPL on in this case?

SPL is enabled by a specific Kconfig option, which seems to have
exceptions but not exception levels. That seemed to match what the EFI
app wants, for now.

Regards,
Simon
