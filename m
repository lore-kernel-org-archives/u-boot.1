Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 296FFC369B2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 15:59:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F8CC82A27;
	Thu, 17 Apr 2025 17:58:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IMVhEjQ6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFFEF82A96; Thu, 17 Apr 2025 17:58:57 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 722F081F7E
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 17:58:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ac25d2b2354so143826266b.1
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 08:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744905534; x=1745510334; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5P9eaPjgTq737iixjnguz9XimreM0IiU1l38EGugGTM=;
 b=IMVhEjQ6O/ub9lknXgxTgdA5dTot2Gf4QfjaxlKPyvbdRA1eHYrBccyPsEM/IePJOQ
 Bp8tl47+YdBiPjHsSbY1mQVkD+Z/gmElVNFjoEqJnTu11MY1f4aBmWW+tkMBQdNnTE7G
 V0MRgJD/nWC4Hs56zBERCSPEptzd1Wp+jPAxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744905534; x=1745510334;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5P9eaPjgTq737iixjnguz9XimreM0IiU1l38EGugGTM=;
 b=sRMo8IvH+xZpNHjrMOKJlPFnxvoLZXoMvX9FtJi0J1SA+MYjRLMPwCHhpJGsnEM0kE
 LOFgL+M5MMG7OiOlP8tWIpO667EvuNl+Uxh+9s0U6Em3BPngrUVKVd4I8/dbO+XE3jm3
 LtL9M2ZLknmVO6EOEt5TdidP9G7ggPxl+QmO4S9OzDep07F/pFEUoG9vTiBwmRGkBzvs
 NyQdyeNMzuB2R3vCo7A0B1wQ0kr3PBDnAAO0/4XIUmkm1KUSNtTv0UaC6+5H5rcVoL3p
 Je/o051ozNKeuhdBe9E51LfDmgDhgzLGVh3udUXhNbAtdfkB3WpyjFLsRwluQE64tOJo
 SEGQ==
X-Gm-Message-State: AOJu0YyDzBOHCMcp1m7+YKLfDQuFOJBLLcVOAbSfxQv99Xutci5SjGGW
 ibJm/tyF+uCOpVDlvHOzxSfATUAbD0+5ri0jQXQoyR/Wwjn/6YXX8PqKVkKXw2b1gbOvnPy/twG
 G4Ot+70qxelC9BVbJ0unaTDBDuFGVv3upFjSb68tb5Ydmlm9D3A==
X-Gm-Gg: ASbGncu8F0sgj1A5/cDtb3+92y+DSV0+6pqSBcs4KVERDtVLYCRf+rrkr5I+51SyTao
 WB41Q/xATYpBYgc8Gxc6f/+bN7G88iSl7YnemRKCt11xSQa1MVo0rHqolRAcAIn2gF1EPF1sW1u
 mLL1UiXldz9Tu2DwexuuoA2Y8=
X-Google-Smtp-Source: AGHT+IFogkWUh0vnK+3ponBE5N4rphsDwPW1N9NyMN1xORPjepsn4ZBFHgzA3SJDkNNj963rbL08sWDpayEllMCyqeo=
X-Received: by 2002:a17:907:3d8a:b0:ac3:ed4c:6a17 with SMTP id
 a640c23a62f3a-acb4298d90amr550363366b.24.1744905533776; Thu, 17 Apr 2025
 08:58:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250101195817.995321-1-sjg@chromium.org>
In-Reply-To: <20250101195817.995321-1-sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 17 Apr 2025 09:58:42 -0600
X-Gm-Features: ATxdqUFtfEFa3E0t_uirx4lO4j6OCYJz2NfM8oRWilHIijOBHpVX3khAA1MO6lU
Message-ID: <CAFLszTj_JvCRNQw716CGD=i+eJm1YMb=WjOqpF0VFFiac3GmCg@mail.gmail.com>
Subject: Re: [PATCH] bloblist: Drop BSD license
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Levi Yun <yeoreum.yun@arm.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
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

On Wed, 1 Jan 2025 at 12:58, Simon Glass <sjg@chromium.org> wrote:
>
> Linaro has decided to write their own version of bloblist from scratch,
> so there is no point in having a non-GPL license on this file. Change
> it, to better fit with the U-Boot project.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Link: https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/22215
>
> ---
>
>  common/bloblist.c  | 2 +-
>  include/bloblist.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied to sjg/master, thanks!

(Tom, this one seemed to get dropped but I'm not sure why)
