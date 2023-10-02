Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F78E784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:40:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B27A871A2;
	Mon,  2 Oct 2023 03:22:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jACc/clt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF4B9871A2; Mon,  2 Oct 2023 03:22:34 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CF5687280
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:22:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2c12ae20a5cso247020051fa.2
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209743; x=1696814543; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JaxwkQ1yaV76tlxsm9yC1YFk56NIMrwVMorSrvdtRzA=;
 b=jACc/clt/1atvfsg/RGdfQdN4k/PaB/MqKTzXSJQhMXqSZJ/Xmh2wG9lOHPpW86ETi
 TVywBHwGrwc830SXqcTSU8wHJ9oF9gSPi9vnUt8KK9egh1DGFYW+R9HvlRWMbPAiXF8h
 /bTpeucmh2UfZRARFbd76nvq3kQ9qS8ZOLsV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209743; x=1696814543;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JaxwkQ1yaV76tlxsm9yC1YFk56NIMrwVMorSrvdtRzA=;
 b=mjJIdebU43Q9jOLqGG4g7HpzpNUIC+TCq7+K1UbmnHZosVYpHo+wVumxoJjXrjTfvg
 INRjG39Q4bmc1tgBwM6Z+5G0FZwYkOorI/ruvAdDFgH4OSC2nU9NXqHA2B96yFOrz/sU
 8G42x+6PcVFNNY5az2+ZTSx2rI4h/ZM5S1sKQkuUXFvpiXFzhujHqQEO5IbS/z05EAi3
 viRuowV1rRBCmesI5QfdJOeu6Ey82Imenw/0DgmAfEEz/OgsafZP8UtA4beghdhiDpzN
 0kuWXO3qJALzxp4co9+4eBAvrMv8OCiRutamhM3K/JYMljrzQ3TV3gUmm0WIQFNxiEl+
 w72w==
X-Gm-Message-State: AOJu0YxhFZrSrsQASP+HtPiUesGEesoo2cRjcUYLGd8QZ6BfrJQJrR8z
 kQuNdcMm5V/ieUD0Z7HfeboNb1S7m8zhDbNo77PDLzhi02feeURb5pQ=
X-Google-Smtp-Source: AGHT+IHcImoYmhQEFz1Fn9/yznWEU/im3BoKm0mMaUPIPJGV+fqTKOBwogwrLziY4ruiN++sieiE6lwAklDuOSfcRng=
X-Received: by 2002:a05:6512:2507:b0:500:a08e:2fd3 with SMTP id
 be7-20020a056512250700b00500a08e2fd3mr9248682lfb.21.1696209743033; Sun, 01
 Oct 2023 18:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230926163510.219804-1-artur@conclusive.pl>
 <20230926163510.219804-2-artur@conclusive.pl>
In-Reply-To: <20230926163510.219804-2-artur@conclusive.pl>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Oct 2023 19:17:34 -0600
Message-ID: <CAPnjgZ3qWUwPUypFN8QEgDhUAJLir4hFg65PyXQP9nvXh5qjmg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] common: add prototype & rename
 populate_serial_number()
To: Artur Rojek <artur@conclusive.pl>
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
 Jakub Klama <jakub@conclusive.pl>, 
 Marcin Jabrzyk <marcin@conclusive.pl>, Wojciech Kloska <wojciech@conclusive.pl>,
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

On Tue, 26 Sept 2023 at 10:36, Artur Rojek <artur@conclusive.pl> wrote:
>
> Rename populate_serial_number() to a more descriptive
> eeprom_read_serial() and provide the missing function prototype.
>
> This is useful for boards that wish to read their serial number from
> EEPROM at init.
>
> Signed-off-by: Artur Rojek <artur@conclusive.pl>
> ---
>
> v2: - rename the function
>     - move function documentation from .c file to the prototype location
>
>  cmd/tlv_eeprom.c | 14 +-------------
>  include/init.h   | 14 ++++++++++++++
>  2 files changed, 15 insertions(+), 13 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
