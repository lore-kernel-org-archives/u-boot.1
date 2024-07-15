Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5548C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 13:33:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D81D888E6;
	Mon, 15 Jul 2024 15:31:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HjZZD7Bg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96A63888D7; Mon, 15 Jul 2024 15:31:36 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3614E888CF
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 15:31:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-64789495923so40389977b3.0
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 06:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721050293; x=1721655093; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9YUitpvk/xgAESTEKPp7pa9Y2WmYyF2LvEYpxTCVFUs=;
 b=HjZZD7BgMe0pzy7PQefWvTZ71ROEpu0Voh4gNRYVyA0SP0gAP2Ynp41cgXlhrtD9xH
 uaVqLiap96l494COcmUXH+2KzkNkqbLbUxBvtmfsie55PCy9Kd/hphgJb9XtnrbdA5yJ
 AFRULOeW0ZnGc0IwHfIkGKtENYhTeyMSfDNdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721050293; x=1721655093;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9YUitpvk/xgAESTEKPp7pa9Y2WmYyF2LvEYpxTCVFUs=;
 b=dw66CvkXKKZhlVibgO/hAy2pTtptN4S2HD+zjP4i01pUWyZMCozORELznuW3auYiRI
 fVN5nHOYfL3jm9m0a3h5SPGlYDgNXrUkRvxPSMLcK48MMhc7eIf+DbIsO1le3dJSOW78
 viD3aXZs7VdF4Hf9gxUVsUfuC5dGrrU7QHjDg6zE1XO55rwyJQyA0Cpim113TMVud1ML
 2/j0oogalooyr/GgbQnGouMTXrlumfbWhvBsFHQvJOzaM+8Yn7Tp5+GzRPSJJDqa89P7
 SO8GfBRFVt9PH5wXnVBbsxXKFYYIkNnRLi1scv9gN9vCBcsC2/vUClN341mAR4BsisZW
 jfPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmxo6/U3wAVK79YdR4C2hxlwV/g4EMPh5uK6zlwGUQiv/Bm/n16J7LKubW1RXKswyWa637jVvDSaKUAo1szKpTABlJTg==
X-Gm-Message-State: AOJu0Yw6RnbCC5huS32F/kFUaYKmJ2p/ByoAj/waVXDSMWTQmEl1nK5T
 ZaI660bVODxm52CDrKiDsrgvUEuN/YBgTTo3oxrMBDdzx+8gZYHwQMBWf3sZ1HBOULHth9H+uFv
 VRBnvmFLYOCsjU+jyp8obCQFLvrTJlq4GKDa1
X-Google-Smtp-Source: AGHT+IHa4tAqXoON4nduTilxgguvtldvPTXiXzy03J9tPKD79ZaH5G7t7x5xgo43rFAzR/Tdao506LPTZwl+HYRSy5w=
X-Received: by 2002:a0d:c8c1:0:b0:63b:c16e:a457 with SMTP id
 00721157ae682-658eec69283mr203070687b3.13.1721050293105; Mon, 15 Jul 2024
 06:31:33 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Jul 2024 08:31:32 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240623175515.1466908-8-sjg@chromium.org>
References: <20240623175515.1466908-8-sjg@chromium.org>
 <20240623175515.1466908-1-sjg@chromium.org>
Date: Mon, 15 Jul 2024 08:31:32 -0500
X-Google-Sender-Auth: -3xNFpPuvuEfIXx5PBLXFmORN5Q
Message-ID: <CAFLszTjm8Fs7KKY_x7-wsYqDEzYqDg0xTpytdQ6wUNv5qJsLSg@mail.gmail.com>
Subject: Re: [PATCH v2 07/14] x86: Set up some assumed sizes for binary blobs
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Add assumed sizes so that Binman can check that the U-Boot binaries do
not grow too large.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/dts/u-boot.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

Applied to u-boot-dm, thanks!
