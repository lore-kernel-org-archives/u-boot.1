Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893CEC4828F
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 14:35:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05B1E87E7C;
	Thu,  8 Feb 2024 15:35:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="doHiKjoc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE44E87E7A; Thu,  8 Feb 2024 15:35:40 +0100 (CET)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54B9787E79
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 15:35:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2866b15b013so490933a91.0
 for <u-boot@lists.denx.de>; Thu, 08 Feb 2024 06:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707402933; x=1708007733; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tUjyYp/7Gr//QydtDBYPRHJNBnBxYDdkZvpyjoogbOI=;
 b=doHiKjocJwa2/27pIgY8HxtiVLdJRY/8TKGLSw8NSmgGSZPjC+tQo/lusKP6Vo9JZv
 5cYUDa1s0fnJ7yuW+W3B7VBfpMEBCmwXmIpjIFHQd30yT1495FXmX+bIFRSeJK90lxFK
 RVfwF7P3G0/GZT1t5tYETrL0UTXGWX4dil4cvjdGe0UhEQK0638WZ8WG1SRckrUvdtcH
 t+O411qKaiIDwRbKPVSAo/CSb7+38mcPR0ivTFacd9jFgWQ1kTLw9P0qocvA2EUdYPbT
 QV6KTRqOlMc5kTyj/4WuolW81RD6VfQwZhRVQsyVlxwjTtArKDEIjhkH1WZZfvjbwZDg
 pELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707402934; x=1708007734;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tUjyYp/7Gr//QydtDBYPRHJNBnBxYDdkZvpyjoogbOI=;
 b=KTOmUG9t2Ai6H72wsZ8TYjJ5m9g1NRiNW9Jnn4ZxW4Yhyq24U5mHpJbhFYnrDWG1Eq
 j/jhTMz8gvdr0EHp3v9Ssz1Koj0+YeUV7QdIRmwmup89GRATmtQdkr6mwDPU98xF0mgs
 d6kWqUqWV+IoOjT35Ek25jRJdgG1s8VODBX5WXe98PctxK9rIFsmhW8CIs9ZxU4YX6Uf
 zC/PM4M9A1lT+03roMY7cPVXhOUxYCvBwsTWfz5EvWI+xKLUpi3pHKv8N0gAfpM5yQ5b
 JH7NAAJxx/zX8AEHWS3pEn2b3p4vIH6bVHXy/H/2gAZoNGWdlFb5xSDVPHo5ECw2NbD8
 iPEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsXvD986GK0U9mzeqLMmLc7Wo+xU9WdxRNND/Dg2pqGEph/3eEciZMeWaLMqHdrLYw+y2G0S5JYf15/8F2S5HNGqftgQ==
X-Gm-Message-State: AOJu0YwZDPEb2N8EoT5YnKTDc2ooNDcOY4meMybwCQGlQJI6EVLIzg3e
 gfEEREwjVEl476CYNX+TfN0OB0MSnKclVunlB7GH40B+BV0ZZJcMEaBbSzqfr5NvqnohsfOUu/Z
 txDZFzoJ+wbLHQrykLsM0FbMvy/g=
X-Google-Smtp-Source: AGHT+IG543hBlutH1rC70m4O7WHvf78HDAgOl1OObU9FTqQBm95/r5lynbHi3qGfoDfZAWdLNPENkKmk+Kw+Se4j6ic=
X-Received: by 2002:a17:90a:304c:b0:296:f78b:d9f2 with SMTP id
 q12-20020a17090a304c00b00296f78bd9f2mr2299553pjl.2.1707402933623; Thu, 08 Feb
 2024 06:35:33 -0800 (PST)
MIME-Version: 1.0
References: <20240208-usb_support-v3-0-e605efd50512@phytec.de>
 <20240208-usb_support-v3-1-e605efd50512@phytec.de>
In-Reply-To: <20240208-usb_support-v3-1-e605efd50512@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 8 Feb 2024 11:35:21 -0300
Message-ID: <CAOMZO5DuPztWrTK92GZdVfVLRX+7iDAVbn1qYOn_gsv6qtpvXQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] imx8mp-phyboard-pollux-rdk: sync with kernel
 devicetree from v6.8-rc2
To: Benjamin Hahn <B.Hahn@phytec.de>
Cc: Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Teresa Remmet <t.remmet@phytec.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, 
 upstream@lists.phytec.de, Dan Carpenter <dan.carpenter@linaro.org>
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

On Thu, Feb 8, 2024 at 9:03=E2=80=AFAM Benjamin Hahn <B.Hahn@phytec.de> wro=
te:
>
> sync devicetree with kernel v6.8-rc2.
>
> New commits on kernel v6.8-rc2:
> 4a58fcdb1818 arm64: dts: imx8mp-phyboard-pollux: Add support for RS232/RS=
485
> 3bd7fdcc359e arm64: dts: imx8mp-phyboard-pollux: Add gpio-line-names
> f5faa633daf8 arm64: dts: imx8mp-phyboard-pollux: Enable USB support
> 27c0dc128d04 arm64: dts: imx8mp-phyboard-pollux: Add flexcan support
> fa2a1ec50456 arm64: dts: imx8mp-phyboard-pollux: Add missing usdhc clocks=
 assignment
> 055e38c76388 arm64: dts: imx8mp-phyboard-pollux-rdk: Fix led sub-node nam=
es
>
> Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>

Applied all, thanks.
