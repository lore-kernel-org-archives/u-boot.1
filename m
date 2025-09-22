Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62529CAC592
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 14:21:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC1AC83443;
	Mon, 22 Sep 2025 16:21:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FAbHa1qg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC35183447; Mon, 22 Sep 2025 16:21:49 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDD8883211
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 16:21:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-57bd04f2e84so1983814e87.1
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 07:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758550907; x=1759155707; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CBcb7L744pjnSxQ19XAcLaNYspMlf4fa9CQ4r7S+qV8=;
 b=FAbHa1qg2sJTsIbac70mbC4SASd6KWyEBgs9thxawa8LuCq23uxNugTwxgw0F3xmL4
 XO9G6QO9lpcVSm5EnhsgVU0IrNmqhaXHwALbbU1KFZP+loN7cSQT9tOTTTCSWaV64OcY
 zORi53dGRfl6u5fqyD2gtwczsHB8BLjWkqAGd2+yvLie+GODNupKX98EgrP3HcHLBJ9M
 rZASRb+CNO4g+jbEhvndRynC61eRvKaYTKZNh6mzD/vV5/ieMG2izDA8rbn1JnUPrsqK
 YyiwErIL/V3X8GuhXiBM/nAa1NtSzOzcvAUrlowo4KmQVEcUHSL4mw1QwDzQHmdvuijJ
 zC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758550907; x=1759155707;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CBcb7L744pjnSxQ19XAcLaNYspMlf4fa9CQ4r7S+qV8=;
 b=F86zS/likh1aIX4oj3mPrieDEaCw9sW/bOGGFtezH9GZ6/TvDpqdSV2tdqqOODcqIt
 WeK2PffqMMnuSoh0fdXwWJoLZAGiEll+jZBLnfXRT1SBMnViIQVc/kgDVWsNq9ao1/hb
 DSTz/XI6TtUhLAPhBmRGMul1jEScb55l14bTcKVyrk7OlQczn2msr+NRsurChcULT2Hi
 32aH/Doz8Y+SkSPGW6B++F6+ZcnVF5dQooCJhdc4MRl/wyzXZ+yIoAxNwl7PhdlC9YCi
 4lYd+3m/nferH29Bu54ckm2vdAFCG2IeXQ38lHgob8Wl/vbsrCV9oXdPdLDlZa8HXyC0
 hJ7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJZPhxhHVWfa0KIAh6bxLi/hpdC7wdj7m+BnkA+Xu5H1TSEH4FM+SgvyNbwsu62xNxnpUlgAw=@lists.denx.de
X-Gm-Message-State: AOJu0Yzl99orMdEHE3rarN4h+MLQKKxSsSQImrPW3/LsSo2HEJS5kB5j
 yVO+l1rQ/l1XuQBjewo1ZtCSooySzqmF5FROxAcgI7Oo2bhUPJwOPazmm0IdBE7auUEtZsHuSZs
 yGbqV5TTEe9v4V4cX6g6AXZLSkuVEOPg=
X-Gm-Gg: ASbGncu4DYE6yTCBNRToB68xP1tei7k7lzq8g9LxECJ+oxzFJLWnQL11YHPIAuNHCn8
 IChA3dsAcb0lJ3YQ7BhXWExhOfih+4fZq+pzMsCtTtJE1YGUQxtda1tuuQERLO3GKC7/ph7zKI7
 ZsAUVqzSzbgUZJuBVRxtiXl3J00zTKP5NUSrp6QCmnUFjGkV/W81RD9rau6IMkQG3ki8X0cWwKW
 HXu1FN3+e5zpDIRhAlAztnNouhTs99I/t/MBM8=
X-Google-Smtp-Source: AGHT+IETN9aZXqgLcdeuBFhfxsLTzFPhfnZhpmKm4mJZ51I0ldfnpWDpqpZi84TmMAcTu8J+Mg3cD/wpP8wtfk8cCDc=
X-Received: by 2002:a05:6512:36da:b0:55b:842d:5828 with SMTP id
 2adb3069b0e04-579e3d2b125mr3200587e87.36.1758550905381; Mon, 22 Sep 2025
 07:21:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250915-mathieu-frdm_imx93_fastboot-v2-1-a4f2a72758e9@bootlin.com>
In-Reply-To: <20250915-mathieu-frdm_imx93_fastboot-v2-1-a4f2a72758e9@bootlin.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 22 Sep 2025 11:21:33 -0300
X-Gm-Features: AS18NWCpi_UyQa4NczF_QMfTARgpiIpc1dNxKzC41_nvKbh8Ea2CYHd0f0E1xZg
Message-ID: <CAOMZO5A+u2dp9NMDv79-4gnpAYcM8Zig7PGsjCeb=2J_jLpJ9Q@mail.gmail.com>
Subject: Re: [PATCH v2] imx93_frdm: Add support for flashing board with UUU
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Stefano Babic <sbabic@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 u-boot@lists.denx.de
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

On Mon, Sep 15, 2025 at 9:57=E2=80=AFAM Mathieu Dubois-Briand
<mathieu.dubois-briand@bootlin.com> wrote:
>
> Allow to flash a board using NXP UUU utility:
> - Enable fastboot support on USB.
> - Add fastboot partition aliases with names used by UUU. Also add extra
>   environment variables used by UUU.
> - Set 'dofastboot' environment variable based on boot device
>   configuration, allowing to automatically enter fastboot when booting
>   from USB.
>
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>

Applied to -next, thanks.
