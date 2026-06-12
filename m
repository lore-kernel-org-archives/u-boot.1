Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 975B4CD98CE
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 10:27:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1A43839A8;
	Fri, 12 Jun 2026 12:27:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HktyJLvU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5681183FEC; Fri, 12 Jun 2026 12:27:38 +0200 (CEST)
Received: from mail-yx1-xb12a.google.com (mail-yx1-xb12a.google.com
 [IPv6:2607:f8b0:4864:20::b12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C9CB8056B
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 12:27:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-660ea43107fso809029d50.0
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 03:27:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781260054; cv=none;
 d=google.com; s=arc-20240605;
 b=JW/Z+06uR79bP73RonqCYWVoswX8J7W1nLAedAz+O4CEf7xC0PaH3EaSn6xdGKY6oK
 vdG4vxCvc9tCQGEUI7dWURrdclwJtJjF3KQWqG/AQ9uQb/gDzQPGU/BqTIBsiPRfCWrN
 sraUeM5ZQX6L6rW4zzhcd9jkBG2KklgakXZPLsTxhCXS9Hauml3oNPf+G+NLNLi93iIm
 BumYzPqBdAYrLquAj/pXwD4Sq7j4ymJ5rfwDUapMPMQGl0SjTkYOHGmz5yLeXD3Z+zRG
 85X0gzHASuZo58BsNYBXbdO1P7/1YJ7bu14uXHJLGiUL6tFW90HAlZ7cSFM/DfpyYP0E
 RlNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IUy2od3pOxf8ozUAKkrWdEOensOJ/EGf98iw8L3xLdI=;
 fh=Us1TA+3nMwsY4r7JMw0d1jYKI9mzshMC/zRRQwi+dl4=;
 b=iv/jZmq9Jr17OVeDe4hVGc52YaLOMwTsxU3blQC5g6HT5lPwFEzIcMrWapc2C/Sojc
 dAsGTrL6KfuFCNKE0xMVGyoEqveRtXxiOWJ8+8kWxajuYuBwH/a311adK+eFWI9rYheQ
 in7s/5/ZUy+jBoHWGySsP/WDeWInrNYEmwPgaAE2nHvOeAfERcm0SEW/K854d51o3YHN
 cLoZrgnLL3PNJQ62HLxN+4Am1MRToYIM2+cdgDZ51i8WVpHQ9MDu8WT50Gn16SlsJ3jH
 yL0t9MO7KccUTwjR+adtLvYjaHgxdVDhkgZJDooouhsdr4FM3xAbmhwDZJ6wOi1F7lwu
 1NEQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781260054; x=1781864854; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IUy2od3pOxf8ozUAKkrWdEOensOJ/EGf98iw8L3xLdI=;
 b=HktyJLvUXqPDxX4YJ/b9PNM3iTPjajq1Dw0PF82oF0POttVLO1yIl/npmr4aGBT0ap
 brPjz12MYW1SEsBtUy0me3suHNlBAFIGtn9tYg0+rq0lAc6mSFQjAZLX5q5hjrlmqqhp
 ZyrwLy1P5kyRSZoEwB8LnuP9SbOsC6eH5iiIJRBkBA8GqpPEIUEXiCKQyMpsKMy9YN/B
 f8ftKu1LwbFzb7E1ok9x0PNzPQxQBD4C2ckBiDLGgnL5+kx1zppSYr3ZOAJKS2fgYvSE
 suomVIBBr5qFi5ycLUrZQpUTfiwJB9fI7vBRvX3S2tBH6l4hAs2LqzwkKnDyoYUntqDJ
 cbsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781260054; x=1781864854;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IUy2od3pOxf8ozUAKkrWdEOensOJ/EGf98iw8L3xLdI=;
 b=Xgh7j2M228udsq3vIY+tVgfDs5uQDor6G4JfB6oSR2hlaspFrGnaKD9TZ2H6PBPknN
 f0xjQ6yCXyLLkrAhqYd7LWsr7vYiH1ho2OmI70FC9wAWbNYDO63ov2wyseNHeVkzH4e+
 u38dbv8VPkVfQcqp2G1pft6Q1gzM6zpBFkZne1KwqQ+3QrVSScqrdVpn9sL/ftWNm6So
 12+xMCPoQ11oRKUwf5l/Jua6VmzCfvib3Mtv01IO7qRbFhU1mIBoaEKP8n/IfHHRC1FM
 wKlRdcixWFd4z4khicRWC1qZjedpHu7xo9RvIfe85iqrArp7e5UhJPeTPMVjXrml7Bey
 Bxxw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+RGOSFZzX5iGJVPZjMp6ReoWO4u2tI3uL77Y8BwarG/S6M1R3OJDBTqZceuT5PJ0CqMbrlyoU=@lists.denx.de
X-Gm-Message-State: AOJu0YwebgMKwy8MQuuIbuJMPBYhMm8pjNhKpFH1WWMZPxYP+SW535e7
 E4O6QDEvIDVvg7wC3uvRGvjKJ6b151nxxfHoehK9pVeCmetJMDeZzCWkgPF4DUzdKxJwb3g5ok8
 bVK83wLs3Sx/cTa7GIfCWRkRz8w55OMNNHU7IWidqnA==
X-Gm-Gg: Acq92OE4LyYH/fcrWxj5YcRyrT05aw+TG+jnYef4eiwdEecxMUekzuqPjWVIqViQlMV
 QBWXteXd4sMwZ+e6xdYc3dorAlNeccqLq/fjQYySiq3yaS4XqDUMd8abMZ9r0Mte7LHhSkkoytW
 dtzgGfhCSYD3eJlCzotjzh3Un3hzsGUBDBnhZ+WeHF4p1Iz6/c9/d783W6U0I5+uXHHgGRQEz6B
 vyRw7DDISsy5ex6S/0D4UHjC7NG9j87zli+tb30vEZU9pMpdBqtkjlYwcb0m+scTtYPBA9vlqNT
 dovG8AM93+Aaj/MxfkRNXAwU7ljAc4sZVxaKIqFZ6tVUN6Rdn73+s8N2d2VpJbssFnQocESRxB+
 Rv0VTPfMyhogAiCxuNX+/poJLWDdQRg7EnLs7FmQJ+vVRbl/xsEMAMU72UQagwFGaVaYG1AuXPs
 74JLfhBhksUYY+9FQkW+quBzwMNR79b4o2UAd5epZilLU4Zcp4cmh3GWnawNUwTsb/bxKn/RYgl
 RyhWeAAoCNw7twgLKrJmxDIlITymvEFscl8FE4j02mAyMkva4DE23P8Pffe1z15c+XuPfHP76Cd
 gPzfxl4ouqFc2xC8cHDhOKELG8R4hG9jCbcJ4Noe8RHXAUr7rlGD5PfAtC6Lf3LQ/q4lUggJc1+
 OKSnltA==
X-Received: by 2002:a05:690e:1698:b0:651:bb21:e7fb with SMTP id
 956f58d0204a3-6627835d36fmr1613793d50.54.1781260053950; Fri, 12 Jun 2026
 03:27:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260609131611.46399-1-ilias.apalodimas@linaro.org>
 <20260609131611.46399-7-ilias.apalodimas@linaro.org>
 <1aa19619-ed5e-4e5a-9f6d-56b5a7824a0a@mailbox.org>
In-Reply-To: <1aa19619-ed5e-4e5a-9f6d-56b5a7824a0a@mailbox.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 12 Jun 2026 13:26:58 +0300
X-Gm-Features: AVVi8CfgvLcgyXAtY35dYpojMFHePrn6iJHhPP20lB7JVGyAQIIA7U4_9aHJhOU
Message-ID: <CAC_iWjLs1W3h20nxQYh8Bq+9LJBpU_SvX8D_1HY58j=8e85mBQ@mail.gmail.com>
Subject: Re: [PATCH v6 6/7] configs: Enable RELOC_ADDR_TOP on arm64
To: Marek Vasut <marek.vasut@mailbox.org>, trini@konsulko.com
Cc: jonas@kwiboo.se, anshuld@ti.com, sjg@chromium.org, 
 christophe.leroy@csgroup.eu, u-boot@lists.denx.de
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

On Wed, 10 Jun 2026 at 07:00, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 6/9/26 3:15 PM, Ilias Apalodimas wrote:
> > Since we added an option for relocating U-Boot to the last memory bank,
> > enable it for QEMU to get some coverage
> Subject should contain at least a mention of "qemu" , otherwise it is
> very confusing.

Fair enough.
Tom if this is the only change required mind amending it during the
merge? Or do you prefer a v7?

Cheers
/Ilias
