Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2CCFCDB482
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 15:44:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46F3186EA9;
	Thu, 12 Oct 2023 17:37:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="itKXh3oF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD54686DDA; Thu, 12 Oct 2023 17:31:06 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB7D286EB8
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 17:30:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-53d9f001b35so1924039a12.2
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 08:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1697124553; x=1697729353; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4mOthyMyFmAGw0LNIfY66E5o2XUUrsoS6HEVog9Xito=;
 b=itKXh3oF8sK1IcD5B9u1YcVvgccPAyuaN756DEMFR6QAT01zZz+Cd7ZjdyulqGTYUp
 2jWRjl4hpLPcZModQsGUDNEVhq2oBWgAApqqolYRsBl9gPrxr/rt9y7FYJCW4Q97sIX3
 fYMN81e5P45wLkfCY6m9WsBxGcFqMKOuUtxcWVjT+BdEnvSar16u2K0HvI9fMdEj/qHK
 u/EPQoMUZ5l+zfX6MjQQFXvXVaRiBoYmTuPHnhhsBZGk4RodZNoqcXSbFjiL+s9jqKDx
 ALEYECNv5wKkvz6+KqQypjvBVz4UkjIWvkGohVQ5ft6dFW7D7ZL0Lb3h6kaUoFLaAtRu
 jPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697124553; x=1697729353;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4mOthyMyFmAGw0LNIfY66E5o2XUUrsoS6HEVog9Xito=;
 b=wxn8xw8kkJJiaasv5Ir6dijptL5qtFERi98IPOjz+E8fJiFaR4lgXTD+ddjsPkKMKu
 lAV+GqtkZrhfDp06HzG9Gxal4PpkffOgHTLueoCMMLWcdiOP78nYvuT17t8d38FKOYuW
 pkTfd22cvPtyMbiwPnzwIh6ZtLixVhQlObmq5PW5DWLbXSCIEIvqgW9HmuDFS97F2aJ1
 uoo40DlLgcDIsgtm2vZKtPgo7jts3ZmBbTZ9mYU2qsJ9DanuXIpH9je7YsByr++xKCGy
 qWX+YdSKPOk1SxX/R7KcOio1+6dr8s6uzpuwx1YNSMauwzWt+7N+++xLjcvHiNfOWYef
 P1lg==
X-Gm-Message-State: AOJu0YyIe/2vmS6jcT5OiA3i00F2pr2+GbTSIwGYRlRSCuXhXftuF7Y2
 eVRKI3NooA9b95IcVkK1+RBXljeIDS131jumR7thUw==
X-Google-Smtp-Source: AGHT+IGl/HMkQ80Yt5nA6orDwgBUmkvf/bUTQE5V8Pq/bKRRRCpgv3BOFGz9ibXETEGcw7F6RHMwpKm7GAoIXROko54=
X-Received: by 2002:a17:906:1097:b0:9b2:b786:5e9c with SMTP id
 u23-20020a170906109700b009b2b7865e9cmr21814433eju.28.1697124553312; Thu, 12
 Oct 2023 08:29:13 -0700 (PDT)
MIME-Version: 1.0
References: <20231012063509.2963258-1-randolph@andestech.com>
 <20231012063509.2963258-3-randolph@andestech.com>
In-Reply-To: <20231012063509.2963258-3-randolph@andestech.com>
From: Simon Glass <sjg@google.com>
Date: Thu, 12 Oct 2023 08:28:56 -0700
Message-ID: <CAPnjgZ007hXESjnr4HWnoZn8m0-Lr02X2=YstZd3HSTppaygXw@mail.gmail.com>
Subject: Re: [PATCH V2 2/7] riscv: kconfig: introduce
 SPL_LOAD_FIT_OPENSBI_OS_BOOT symbol
To: Randolph <randolph@andestech.com>
Cc: u-boot@lists.denx.de, randolph.sklin@gmail.com, dylan@andestech.com, 
 tim609@andestech.com, peterlin@andestech.com
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

On Wed, 11 Oct 2023 at 23:42, Randolph <randolph@andestech.com> wrote:
>
> Introduce common Kconfig symbol for riscv architecture.
> This symbol SPL_LOAD_FIT_OPENSBI_OS_BOOT is like falcon mode on ARM,
> the Falcon boot is a shortcut boot method for SD/eMMC targets. It
> skips the loading the RAM version U-Boot. Instead, it will loads
> the FIT image and boots directly to Linux.
>
> When SPL_OPENSBI_OS_BOOT is enabled, linux.itb is created after
> compilation instead of the default u-boot.itb. It initialises memory
> with the U-Boot SPL at the first stage, just as a normal boot process
> does at the beginning. Instead of jumping to the U-Boot proper from
> OpenSBI before booting the Linux kernel, the RISC-V falcon mode
> process jumps directly to the Linux kernel to gain shorter booting time.
>
> Signed-off-by: Randolph <randolph@andestech.com>
> ---
>  arch/riscv/Kconfig | 8 ++++++++
>  1 file changed, 8 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
