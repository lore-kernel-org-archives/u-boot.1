Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89DA5E77188
	for <u-boot@archiver.kernel.org>; Tue, 24 Dec 2024 07:11:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC76D80711;
	Tue, 24 Dec 2024 08:11:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XcAtpK9f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 977D180786; Tue, 24 Dec 2024 08:11:28 +0100 (CET)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B6D780708
 for <u-boot@lists.denx.de>; Tue, 24 Dec 2024 08:11:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e46ac799015so3977065276.0
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 23:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735024285; x=1735629085; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nHfU2qGMS1Xyv/M14fYL6nz5b4V8QHD2og7tDdkwWUs=;
 b=XcAtpK9f2V6xDJQHyKgPossYp0waqyPEDzXIYnELAzGp8t7lBgf3vsltckledAF1Mq
 BIcu4jYNVQD/Kr2l3t2SyQ9d+li6Z4Iw/wxQRX1B6dvRB6sGUgRwUo+77G+GrRi+2CI5
 S3+zmESQmrzmChpW3smGvE7bEx9Kp1qFBpNYtYIxp5cVWXg60w6eGKp0hlKgOU+QBGTu
 hEU3d/wxRhen7PdWjnXNTK6rbP78drqYqOjywp9IMIz3JDVwnaRflPS14w/MHQOIt5Ak
 GuDQGoQq94sz0RoU8IXWTVB1NiyvaVudllpT9SaYZ63rPr+L7FjMRsG5sA8HSYMbdO9O
 gTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735024285; x=1735629085;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nHfU2qGMS1Xyv/M14fYL6nz5b4V8QHD2og7tDdkwWUs=;
 b=MII51Qq3qz0Af4hOKWMcQ4En4MqAeDwcmqa9yQL12Xqm8SeuU3fx23osGDKdIPspCW
 LTDfNHrwwCofVZu8EwKGDS7nF3weFgF/02KPuuwxdlPtJVsIwwBd7FVpLn2VwYgmqQwO
 946991D/AzG7zyN/fMYkeAD4Y44db4eY9EaBXC324KHLCXiFqcWKhEASag7SVYXCLdQy
 Dm3FGZqdpbzwO6XRxvi9vcFqVAr3WGqCDIQspHup+mZ6+XC0xlScbpxwSY/YPtzbgLD3
 6w8ev0QE2CVkoDkW0Ejoas2hNdMBCcR4k9YHzdPhvlk3LczCSK/7ONVeIHCjM9YbOkfS
 KW0Q==
X-Gm-Message-State: AOJu0YziytQhkXdthrFQj4lj9iHDGeIKrTebYKB7icy+BvDng32YM21q
 TX2M0nH91QoLFs3GwYWHSBZhuzCvJk/DFr8/5wjL3Vc/sUIWN8fJKlRZVEHuco+Zl0uUe+iTOg3
 fPZTliG06HSEbVgb4lKbeYDVpUgltR7MjXbYayw==
X-Gm-Gg: ASbGncuBDtXguBBnyEzWKPgsr1BAbFwSVL93xq+y2k0GuFPNFRZP2UUv1Cl6osRigvp
 L6OEBLpybDaSVxOWsoF87w3vUbJjk4DF4zpp/NQ==
X-Google-Smtp-Source: AGHT+IGB8BAPGbZOJTzsLX97F3ZAWC9tFl7o0HJcQu7Kdc+iIFjSuIz6EWGYMW28mkCsVeNQ0Rcuzg8LnYw96B2ecHU=
X-Received: by 2002:a05:690c:8f15:b0:6f4:2794:6626 with SMTP id
 00721157ae682-6f42794666dmr32426097b3.2.1735024285340; Mon, 23 Dec 2024
 23:11:25 -0800 (PST)
MIME-Version: 1.0
References: <20241223144737.554992-1-raymond.mao@linaro.org>
In-Reply-To: <20241223144737.554992-1-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 24 Dec 2024 09:10:49 +0200
Message-ID: <CAC_iWjJ=vRJGwRsLdCyzq8DHc1VrvxEv+rcownX9RRGJQ8gXrQ@mail.gmail.com>
Subject: Re: [PATCH 00/11] Tpm exit with error when algorithm dismatches
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tim Harvey <tharvey@gateworks.com>, 
 Simon Glass <sjg@chromium.org>, Masahisa Kojima <kojima.masahisa@socionext.com>,
 Eddie James <eajames@linux.ibm.com>
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

Hi Raymond,


Overall this looks good. I could apply patch #4 manually but git am
failed for -master or -next. Can you send a v2 and fix that?

Thanks
/Ilias

On Mon, 23 Dec 2024 at 16:47, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> This patch series add the logic to report errors when:
> 1. An eventlog is handed over from the previous boot stage but TPM device
>    was configurated with an algorithm that does not exist in the eventlog.
> 2. TPM device was configurated with an algorithm that is not supported by
>    U-Boot.
> 3. Failures observed when parsing the eventlog.
>
> In all above cases, tpm_tcg2 should exit with error and prompt logs.
>
> Moveover, this series include miscellaneous fixes and refactoring to
> simplify the logics in tpm and tpm_tcg2.
>
> Ilias Apalodimas (8):
>   efi_loader: Don't warn if the TCG2 FinalEvents table is not installed
>   tpm: Rename tpm2_is_active_pcr()
>   tpm: Rename tpm2_allow_extend()
>   tpm: Don't create an EventLog if algorithms are misconfigured
>   tpm: Keep the active PCRs in the chip private data
>   tpm: Simplify tcg2_create_digest()
>   tpm: Simplify tcg2_log_init()
>   tpm: Don't replay an EventLog if tcg2_log_parse() fails
>
> Raymond Mao (3):
>   tpm: refactor tcg2_get_pcr_info()
>   tpm: add flag in hash_algo_list and API to check if algorithm is
>     supported
>   tpm: add kconfig control in tcg2_create_digest()
>
>  include/tpm-common.h      |  18 +++-
>  include/tpm-v2.h          |  65 ++++++++-----
>  include/tpm_tcg2.h        |  12 +--
>  lib/efi_loader/efi_tcg2.c |   2 +-
>  lib/tpm-v2.c              |  72 +++++++++++++--
>  lib/tpm_tcg2.c            | 190 ++++++++++++++++++++------------------
>  6 files changed, 230 insertions(+), 129 deletions(-)
>
> --
> 2.25.1
>
