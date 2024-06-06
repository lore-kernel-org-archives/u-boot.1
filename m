Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C74FC25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 15:04:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78A9B88444;
	Thu,  6 Jun 2024 17:04:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TI61P/QQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A1B3883AA; Thu,  6 Jun 2024 17:04:30 +0200 (CEST)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4ADF8844F
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 17:04:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7952b60b4d7so64861685a.1
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 08:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1717686267; x=1718291067; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xekTd5RPV8YK1O1rvKT7WiEZ+vvTf4tSmxPUvJ15ShA=;
 b=TI61P/QQUnlwCUVqVnJHsbXEKOxfl+GR6Q888iFFQipr2pa/jvGwFBWkn2vfob1Oso
 s9ddEbO3yqr6MQKCxqWPL0v2pdYEnz7e4f1ffjLyKcR/9n9JN1NgpznRyRK4EoFsNOWT
 bhI/F7KShLzqRZSKU7toFP2EYlwzz9h4X0jKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717686267; x=1718291067;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xekTd5RPV8YK1O1rvKT7WiEZ+vvTf4tSmxPUvJ15ShA=;
 b=lsPh88upBw+QZn9uze9wSyQGvUfHSdzOgdQsNde+9VFhIY1LyIekDvRepBV4FNP3sQ
 CnktLNamyc6yxIE/xT9B9OaX7iW9OgTgDdwL0bmMa2L5YE2VaeA/rF/dyZ8SIW4vHo+7
 p+SoESAH1Wjit75mUv25vJm9xU8h04ZFsx5vhGY6W5BFRta+xB0IUr/+g/Z480lWPzcq
 xGK1wY9+Z3UJuMhhI3o5/j9s/dvWYzFLB4jxidWdJxT69DqLbgMgUQ4uGwAxA//6xz3X
 g7ywuX7bk4EeaFLUIAWTcDDqEHkAamY8kpBvQ6hzRy4QdcN8ME+R67cxyhIcL1O3HMuT
 Zpgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6gkN6obmgeMhpBUYUxO8bRaP4gq+1GmdAC0I20Uo/Nj7kLutAoJRqJWdi2wtxZ0ymjVGdCUY/q+MdnZtZkJGuaqLt4A==
X-Gm-Message-State: AOJu0YxWEsSAOCzytVxgKGZ1nF2nIWHtw8T3Lwf/uNCktxxw+k9yV0xn
 wW9xaD9fWhzdXN/IOj2Emz+Whr9XRWcMLDvARjm3bEDRRLyw7s5o1AJlC36HMCWq103BCt1zUBd
 HqKKWmR3Yz5P0j54KNzk2EvDpUAO3t0lvXCIE
X-Google-Smtp-Source: AGHT+IHOWeJtR947rcmx3LZp43UtiRFJS4RhSRZxNmOP5Z1lqYcPXaK5/Hdkc7Ma76soZ+TPnkW5oc8SbXEcjJqpz/c=
X-Received: by 2002:a05:6214:3a02:b0:6ad:9e77:8a20 with SMTP id
 6a1803df08f44-6b030a96cbdmr68730186d6.54.1717686266601; Thu, 06 Jun 2024
 08:04:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240605-pmic-rk8xx-v1-0-2349fdf68aa0@cherry.de>
 <20240605-pmic-rk8xx-v1-3-2349fdf68aa0@cherry.de>
In-Reply-To: <20240605-pmic-rk8xx-v1-3-2349fdf68aa0@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Jun 2024 09:04:16 -0600
Message-ID: <CAFLszTgrv4YHW3TZbL5e+zJea0eJno7OkM_0dxkPhdt1ZvS=-A@mail.gmail.com>
Subject: Re: [PATCH 3/3] regulator: rk8xx: clarify operator precedence
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

On Wed, 5 Jun 2024 at 03:33, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> My linter complains that the order isn't clear enough so let's put
> parentheses around the ternary condition to make it happy.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  drivers/power/regulator/rk8xx.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
Tested-by: Simon Glass <sjg@chromium.org>  # chromebook-bob
