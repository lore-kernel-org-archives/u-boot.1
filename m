Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA63C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 11:19:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABE6C84867;
	Thu,  2 Jul 2026 13:19:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HEbs6fYd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDA19848EB; Thu,  2 Jul 2026 13:19:54 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7A7A843B6
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 13:19:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c1276f8414bso205132466b.0
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 04:19:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782991192; cv=none;
 d=google.com; s=arc-20260327;
 b=ASl+ZmAS5D+RgS7/VPi0GSmuTik9PQxglcYah3QAVROOE6EDWg52tkWvgPGAt0obZR
 E5tMkogXk6T4B6iqfchQC2CiQjy03a+XMiCz28UcawKwzVwbysuchfoLlLK8HDNhA9a5
 W93S1nWsJOlsdvAtwCelr2JMr/npP+NzjwO/cEMMyVwj9j4DP9azThiqmJeXaPOTxRkh
 7SQATkgIRUO7qHyabnVNLADcHjXi6hA6cBW38fxn8B6Y4vyCzKgq31/8opDqPgwPccDV
 U83EDvfbSR+Vrd1t+QoN0p5yusGv0nPfwbl0VIK2+/jlh357sZl4B4zcbZ+hGLYqNRYA
 SAbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5N5RRQywDwvVbqLYjIDibeVsFGoqpmaweRBVMU+ffYU=;
 fh=jbjkM1qF6Feml0cFN/Wg1DviFsrziaKriKHXrH2++aM=;
 b=BWpkGnU89RgnunEmdhIkrP8mZq4KNvTAhzNzW5kTABeMlF3iYFOfd1xSsk56s2Uste
 TRt4rqURdqDUy4RRnx4SxfH14kmWkaFeMfUXJyuaMTZdiP6Ww23uS9a+UmBcR09qA38U
 GUomWZJfqEXryU0w4znJqA8QmfVsEkqpE9txqoH5C/A0mlPQIscL8EwyqTpBblFBDAXm
 oPJZgHUV4FT55r9FSGBSvhG/k7aAYkfK5ZTBWOzgdhlqvOyD/1gCpokQZcmuExXy5lKm
 ruWxfbX+8OohYrEvWWcr0f2SXUE+W3XVFhL+o6mjqG1kHn5JaOig/C8aP1IsNMq7xlwl
 4K8A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782991192; x=1783595992; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5N5RRQywDwvVbqLYjIDibeVsFGoqpmaweRBVMU+ffYU=;
 b=HEbs6fYdyRJVDvjWWtkpVn8wzoF7Hc1WSInzmuJ5kftVzHen0FF7kMwY5QXfLMgH6G
 40o/bB4N7WseyaYdF4JjPEacbrAylWAGnbMEuyAldZDQjAwNkKUIR5TMvtvAhzB49lcK
 bhNvAeE5k7f+dyeq2QgdTtdywy2eo3Gi2+QFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782991192; x=1783595992;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5N5RRQywDwvVbqLYjIDibeVsFGoqpmaweRBVMU+ffYU=;
 b=UfQ2gFGY3ZNFspoGQJuzGY3xZyIM9q4QIggOMaJtEy9aXc34fZMpVW5d97YpZ+nXe5
 QxxiwEPsk1Ji3pRUwzXtJLLSz9YVyfjfuf1ALgNzucDcqLdcOqorBDvvVkYe7O41TucY
 6dgBZxFa4HafPsvUA04aFHH0kkw2xuT2pK7ONcm5amKu1mKQhu8uHl1Ji5Cej1a776Qa
 mb53klYRaW/uSMuIexb+zaY7DkLXVv4zUMaeWXQNXhFJNe26EFoh8Kn/2o44ejkH2hKs
 6ct6aCk3dm1WQL29XwXmGPYErGXTqJlrtunZYYXg/65e8ojdwWyAH1x6qlaYvX8uB0uc
 Oyeg==
X-Forwarded-Encrypted: i=1;
 AHgh+RofFKbkocnkfKp1ND40Sil8ntrTg1BjC23wIN0TVmjJLxx9t/Mdn1wMGpCVWQhH9msAIngWuOg=@lists.denx.de
X-Gm-Message-State: AOJu0Yz5BHFoYhygwkbcVJ5HLoe3jRgtAjntyXQu7osGkDhXiX4qtaCY
 ogizA3wJ7BYjZuoPRQq3cH3lsBIbOQ9nHdGIyhyNAkKR2+C4l7Bs57teKnD4ouTCh4hRRjYOlW7
 yUICgFf0QBqlWFc/AfPlUQR6hHXpQUbIuW/LOJUcj
X-Gm-Gg: AfdE7cljcVzYQykcjz2A4Bi8mm8Sbt1KSloKtAblTvLzVhvcceBJEbGwSVj039KRcjD
 La8ROAA7cufEkFYo9fPl14PwfqTlSIMA5t9X5iPXZ239vL5Of8I8LcPoogfsLgnqo1uBECFP6Jd
 t9Eka+GvgPOUzQmkOfMyGzIR/4UIPU6pXv2pqNRq/8eRfPUWDadLobFeHH8gMNnzjJfD5EK9Z0K
 UbMrBN70PEf5HWatTHzzIe91DkiwIkr1wh74zb5X9voMliPM/rDGyLAUe0RVwO5wgNATB8c+g==
X-Received: by 2002:a17:907:d40b:b0:c0f:fb53:9308 with SMTP id
 a640c23a62f3a-c12aa1367f1mr238321766b.29.1782991192378; Thu, 02 Jul 2026
 04:19:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260630152809.1933616-1-s-tripathi1@ti.com>
In-Reply-To: <20260630152809.1933616-1-s-tripathi1@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Jul 2026 12:19:37 +0100
X-Gm-Features: AVVi8Ceh21x76JBcQ9y3xFjvPBCtllvrb95zkUce-rxX20QD902i4Es4Kw8rghs
Message-ID: <CAFLszTjRcMKVXw7Xs=eBJTh=E=2pHiYph1cUMB7ryxCxjFO7OQ@mail.gmail.com>
Subject: Re: [PATCH] tools: binman: ti_board_cfg: Add configurable sw-rev
 support
To: s-tripathi1@ti.com
Cc: trini@konsulko.com, sjg@chromium.org, alpernebiyasak@gmail.com, 
 u-boot@lists.denx.de
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

On 2026-06-30T15:28:09, Shiva Tripathi <s-tripathi1@ti.com> wrote:
> tools: binman: ti_board_cfg: Add configurable sw-rev support
>
> The software revision field in the combined board config binary header
> was hardcoded to 1, preventing independent control from SBL SWREV
> configured via ti-secure-rom's sw-rev property.
>
> Add support for the optional 'sw-rev' DTS property in ti_board_config
> nodes, which sets the SWREV byte in the header. Defaults to 1 for
> backward compatibility.
>
> Signed-off-by: Shiva Tripathi <s-tripathi1@ti.com>
>
> tools/binman/etype/ti_board_config.py              |  4 +++-
>  tools/binman/ftest.py                              |  5 +++++
>  .../test/vendor/ti_board_cfg_combined_sw_rev.dts   | 26 ++++++++++++++++++++++
>  3 files changed, 34 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
