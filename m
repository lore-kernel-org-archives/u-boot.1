Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F399C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 18:57:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3248084C0B;
	Thu,  9 Jul 2026 20:57:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eDmmN9AP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07E5184C0D; Thu,  9 Jul 2026 20:57:47 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A7B484C0B
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 20:57:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-69a5ecbbfb2so220168a12.2
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 11:57:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783623464; cv=none;
 d=google.com; s=arc-20260327;
 b=T0KHtZlRVUHz8ivkonoXG4CDyUpBnjgLlt0Pc6OJvBMQqACQKsJUkhCiP4Fg3X6q6C
 CCQY1Zkoag+DCM2549VBag1SV5TKaYQln/I4gnekPykl2WF0mc3WQvwDOOf+1dL6iblY
 CS4WcTrsymc4amRXUnkvO7bkQUH51lkVfwG86dhdB3Z3v1osplAyYcC/81uOUk3MYUqw
 5k2MCxBWbaLa/oeNvbpN7D5xQh0u1kp4Kzom7cQHM+u/wGMkF9Xsuqh6iOgBwnbsqb+M
 6yLdznlUpX5IJDvkAkygPRglDrM+lrnD0lkKlwlpOyqdBOmkMYYdmlhJSVTjC8so7hhf
 YDOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=oajtfnybmDgzhBMWfLeCHrPUjCn7VuWF9wxX1uybt/g=;
 fh=TliE1Jet2erAwxe87EYqLrPpLQmH/Bomcvaj7zIAsQg=;
 b=RdIzpgNdu1LrKm/uvDRo0QEGCR1qsEPn3tDa3ZA3+BiuiVki7N1WkpojqZqIGK8Tgq
 q9yyBN1lwjCFmWipKgVV4koGQpfgRaOYSbnduidI9cnpZjHJMQVpVg6GgFImDIQ9wuQu
 S8HFC2LOe+YiGbto9t2VXoGgBxmSCNXDDp4ppf6OrX0txPmxHBvUu+gfVeJgaaiN2MuT
 spsDlGHbJyroI4aZNmxH7PwN1x7LmnHSP/DQ10Uax2vruicRBWNOxalN47ri6qUDD2g8
 ldIEEGP5pmaBMo2ZoTDLMyYnTqUnmRSMzFYr6G5xOBvbua7klf2hYB4QfXZ8q+MQy1TM
 bUCg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783623464; x=1784228264; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=oajtfnybmDgzhBMWfLeCHrPUjCn7VuWF9wxX1uybt/g=;
 b=eDmmN9AP7RA5jm4I1owB9f0QXmOA5k+Zz8cKmS2CziVCbDQORFoj3WYYuJyMVK8wk0
 91BvpnEdAM3xoS38S8TgToWPbQhvoTdJEl1xuE0tlEHkbBxtoFWRnd0EDEi8OBAC2uQ2
 4pNM5ExiqRQ8Ip1kpb0Xe2rKCONUBsmKjo/4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783623464; x=1784228264;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=oajtfnybmDgzhBMWfLeCHrPUjCn7VuWF9wxX1uybt/g=;
 b=gkIlfCU97+I5f9cXjftWkF31ObMcaIiKM96Q0eMmUK0WYsUDuImI+XQGqkR2XYowJx
 ZEH8Bo2PZqxkjr72NS7VKSsgvBrqTOJwoijBmCBg+75lnVMRpe7sclJFZdGTowBg2SSZ
 3Nr/D90SS9Q4wxBdKfbF0gkywfEPdsDPweLziiwU0FzmMLScY4bpe/od+GTDUKQ+aUJ0
 MLz41EFb17XVGwbDxyEuMEQaMwfNWRtlhfTfreSBo7F1u7Nqh3h5zVBa6QFwThisqhD1
 76qsDqFkll8mofxOM0J8rc5182uQsgfq3wuZrTZClCT+3JvWa/3vWMO8wHPLAq4oJbx6
 iahQ==
X-Gm-Message-State: AOJu0Ywkr5317vQLn7o6P4yHkit9DUqB7/gGbohDJGAUJiebU/x7s1pj
 uhPzPqIu+pMuMiUVcSBYqm4PLecsoViqYswPJLLhzvpOzCi3rUVdEDu8cqwmwK0UJBnKIZwubh8
 UgSkFshiBAX6J4fTC8e0fme7XnoEWeg0d2PcQmhiO
X-Gm-Gg: AfdE7ckQ+JZJgaR+B6pU3/o4ZnYvswkXvoeKNaJFrvU2qPerJH1RxetRSn0v4GkSek7
 XLsIKwxIC3iz0QkzAHQKTpjaH9jR7CxROLH6FU2sOESX4eiWOBUZPazSakh+UPRr46k23flwNDg
 ZujQu6HkD1kWYLv6STpzhv2DHnU3sIF8ZME5DNjnynIE5gLTeiuHgR8XhDqclfbwGcAT5AcU+hC
 G0E2t/RNhbRMX569csKPylI81rrUdCMKeWSIE5XVxjf6hOI74NkfG/hw7N7oxV5cjg7CrE=
X-Received: by 2002:a05:6402:2747:b0:698:aea2:260a with SMTP id
 4fb4d7f45d1cf-69ab4499264mr3884109a12.25.1783623464612; Thu, 09 Jul 2026
 11:57:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260706105111.2018334-1-vjardin@free.fr>
 <20260706105111.2018334-8-vjardin@free.fr>
In-Reply-To: <20260706105111.2018334-8-vjardin@free.fr>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 9 Jul 2026 12:57:31 -0600
X-Gm-Features: AUfX_mwdpB8d54DGHlNliL0rUcCvAD3SmUQIhO5PHHDr3niWBKSW4FQ-1SNoSNk
Message-ID: <CAFLszTgh0nH4uL8zkgaYSVEbjoEiZgnCrSJ9DP2Ev08JnupunA@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] test: dm: pmbus: test pmbus command and framework
To: vjardin@free.fr
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>, 
 Jerome Forissier <jerome.forissier@arm.com>, Peng Fan <peng.fan@nxp.com>
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

Hi Vincent,

On 2026-07-06T10:50:51, Vincent Jardin <vjardin@free.fr> wrote:
> test: dm: pmbus: test pmbus command and framework
>
> Add dm unit tests that drive every pmbus subcommand handler against
> the sandbox PMBus chip emulator:
>   dev (select by bus:addr and by regulator-name), list, info,
>   telemetry, status, dump, read, write, clear, vout, scan and help.
>
> Tested using:
>
>   ./u-boot -T -c "ut dm pmbus*"
>
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
>
> MAINTAINERS      |   1 +
>  test/dm/Makefile |   1 +
>  test/dm/pmbus.c  | 247 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 249 insertions(+)

I'll leave the biggest pmbus question to others, but this looks good.
BTW you should not need the console_record_reset() calls at the end of
functions, nor the 0x before what should be already-hex values in the
commands.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
