Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 575F7C0219D
	for <u-boot@archiver.kernel.org>; Thu, 13 Feb 2025 13:29:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A049E80EB0;
	Thu, 13 Feb 2025 14:29:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iCavAKrv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DE5480EB5; Thu, 13 Feb 2025 14:29:15 +0100 (CET)
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com
 [IPv6:2607:f8b0:4864:20::e2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 577BF80C98
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 14:29:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-vs1-xe2d.google.com with SMTP id
 ada2fe7eead31-4bb0e7e6cceso204389137.1
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 05:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739453352; x=1740058152; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=f1eDGdQU9pId81WJzRAcubA1ztu6D5oE6jP0nZc0iSA=;
 b=iCavAKrvDY0/iDnt90eAyHxhAa5ZIL/gKGTAqlIXn7Ep2JpUM+msvsm5sqbv1Ady2k
 onA/DaDB5CsW0znfkDqCMxvJ8shFjdz/UAX7B/PdwdnMLwC9WeoUUjVg8zI+xUzKFqLx
 AL2ZwzE2CDbrAgyPF0DXhjrDt+h3efoUHPWd5GvvN3LNEx/7ZxPOA7mDZ9nwIcxMtX9r
 UXQd416mEUPsxg1+zJwoUDL7OCVVoXxUOB6wMisCbFWyGbakSBsNjVK9+wYgX7s6Ml/+
 IML03fCqfYn8+eLtoLr7fbp0w4gLqvdrPYLLJ1y8Kes7SENgVjWPLuMiBbyu61Y4aqf9
 5hPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739453352; x=1740058152;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f1eDGdQU9pId81WJzRAcubA1ztu6D5oE6jP0nZc0iSA=;
 b=dNToe0QgImU0ZbJmOqxMWLk8kUXNjath7VGE6uLqS5sQeP8dT6i7tfIulvMb5WTCkH
 f5is7xjCgNfDtQJ0nMUVwJe/ipdXYbMcNAEHzyGFrU/QnzcN+mdt9uElCsNPK9AAemS0
 ZaEJs0/RiKGm1wGWGvc712BSPRHDE1LAwPu7FQDPxZvaL1WtouzV4Zil7Xn4u/e3gCNz
 n+pyGVi+H9hrrlwdA5JU9xY25/9T+pTsY83GwpRtQqhb1PRxjM6uU15S5bKCwdjo/0g0
 JAl7oQirFvrncnxeeF2pJU3vqNNy0uWmbizGOE72u8Zpcgu83nYj+xBp7aLx4nIzd4PU
 UpNw==
X-Gm-Message-State: AOJu0YyGeY8bVuf/dk3V9fX12uFy7+nss6P2obIzzh1iRSDwRRTcxRRx
 97OkOlRdkMarpPD+r8sGArELm/P3OCiLLelgEq27RNWR1YosRqZSUjrHL/1XC2bAJzI/Nv3OSS8
 KWBY3zVxKwg223oBCSNkQRHO/RBFRwMuU61j/ZYAN87z/OhOpSZQ=
X-Gm-Gg: ASbGnctyPxoUzuYrKu0BBm8RbyvwDlhUdLYxiyED/q4Y3yj9eUunKb2leVJWIFMBFWi
 B5TF990knmcQ72FKeGSzjD/HY4bm6wSi354eZxIU0aTDtegvU2OV9PKhhjTB+6Glf51uOCSeUwA
 ==
X-Google-Smtp-Source: AGHT+IHMLxhHU9nIx59hIaO3XO7e/uxzed9otvkFMs3yYO4Rc7x/+j8w5+oJVnqKT8YnqnT6G9VvcKJ0q92Yj4HqOVg=
X-Received: by 2002:a05:6102:6d1:b0:4bb:9b46:3f93 with SMTP id
 ada2fe7eead31-4bbf21ce842mr6473527137.8.1739453352142; Thu, 13 Feb 2025
 05:29:12 -0800 (PST)
MIME-Version: 1.0
References: <20250213131104.186663-1-sughosh.ganu@linaro.org>
In-Reply-To: <20250213131104.186663-1-sughosh.ganu@linaro.org>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Thu, 13 Feb 2025 18:59:00 +0530
X-Gm-Features: AWEUYZmeO6Mn4tC4C47_t7PwmP1TCSVndLGJzzY2MVqP0YxtTkurA64d_r6uf98
Message-ID: <CADg8p94wrz1M_stP=eq=i8pzb1FME8XXgZmB7gwra4_9tNmpfQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] lmb: miscellaneous fixes and improvements
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Udit Kumar <u-kumar1@ti.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, 
 Alexander Dahl <ada@thorsis.com>
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

+ Alexander Dahl

Apologies for not including you in the Cc list.

On Thu, 13 Feb 2025 at 18:41, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The patch series contains some fixes and improvements in the lmb
> code, along with addition of corresponding test cases for the changes
> made.
>
> The lmb_reserve() function currently does not check if the requested
> reservation would overlap with existing reserved regions. While some
> scenarios are being handled, some corner cases still exist. These are
> being handled by patch 1, along with adding test cases for these
> scenarios.
>
> Patch 2 is handling the case of reserving a new region of memory, but
> that region overlaps with an existing region. The current code only
> handles one particular scenario, but prints a message for the other
> scenario of an encompassing overlap and returns back. The patch
> handles the encompassing overlap.
>
> Patch 3 is an improvement whereby we allow coalescing a newly reserved
> region with an existing region. The current code exits this check
> prematurely.
>
> Patch 4 is putting an ifdef in the lmb_map_update_notify() so that the
> function contents are compiled only with EFI_LOADER. Reasoning for the
> same is provided in the patch commit message.
>
>
> Sughosh Ganu (4):
>   lmb: check if a region can be reserved by lmb_reserve()
>   lmb: handle scenario of of encompassing overlap
>   lmb: check for a region's coalescing with all existing regions
>   lmb: build lmb_map_update_notify() only with EFI_LOADER
>
>  lib/lmb.c      |  40 +++++++++++++++-----
>  test/lib/lmb.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 130 insertions(+), 10 deletions(-)
>
> --
> 2.34.1
>
>
