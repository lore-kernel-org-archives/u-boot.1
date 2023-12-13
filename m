Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00FBDC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 20:41:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1470D87890;
	Wed, 13 Dec 2023 21:39:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gKNWtYM0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4214487878; Wed, 13 Dec 2023 21:39:19 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3041987873
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 21:39:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a1e2ded3d9fso893262766b.0
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 12:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702499952; x=1703104752; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7y47Fx6s+yrm1UXSRjPzBUcg49/9BYQixQCIYiJmX6U=;
 b=gKNWtYM0Axk1t2l5E6P++Gj4s86+ANScxWzm9VddS4pHlzG13Sb4bozMHOBJy0dHir
 pvTqAsBJp7a2P0V9N1aXrc19KwzsXQKTHwt+xXIfwW9AkYT0ajMFWJTV7WiFuSqNlC0/
 yVK/CNZOb4euuM8E6AHDPGCFiP2jZKSuWO41Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702499952; x=1703104752;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7y47Fx6s+yrm1UXSRjPzBUcg49/9BYQixQCIYiJmX6U=;
 b=LDTHVLbjDnSDXJcHzRfAD04kGV948T+7LRNeCL2t3sYJ58H1Sn647Qn9xzoSJstNK+
 0Ekm+lvJXzPB3xkz9MpHBe1IcXzgzN4yRk2xkUx74igDS7Uue7OLjVNvXeJDGumdSyMw
 EDFXcZQBhkQEYiYLUBFGo7P8yjPpY6S1kXFWpkoe0OTyRi1sENy7T/HHzR02iBIHLSN6
 +LrsM3MKRVBgjpzSDQ6uq2THFSdAgtRuqyp/BCfWZk+eYPwtFlZmMK/YrZbkU2qwELS4
 ISsVrMkOgtZfcE8nC1KUt3IwklToV33cywG9dvHrvxbvebbeFf7by3JusJjEmv0fnZMd
 dC9Q==
X-Gm-Message-State: AOJu0YybqxkTxolXWyngnhDeuH7O6ODQ05ZM+xPkbbeD33wG+pJ0mQvJ
 PnD4KWpMAIOnoMsHqRikvs+QZ3lElrhRCrodeqP0cA==
X-Google-Smtp-Source: AGHT+IFzCkuozAr6FspxOW0j+1hCdQJrE8M3WADx9GbSiKtZx04a2q57APwFzCUVJe87ABNqaC/XU9VUPme0wFsP7ss=
X-Received: by 2002:a17:906:ff06:b0:a19:a19b:78d5 with SMTP id
 zn6-20020a170906ff0600b00a19a19b78d5mr4315773ejb.152.1702499952343; Wed, 13
 Dec 2023 12:39:12 -0800 (PST)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Dec 2023 14:38:58 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ2og=T1gj1Q4xuE8zTLEy2Um8c4kvthHkCZXzYSZycekQ@mail.gmail.com>
References: <CAPnjgZ2og=T1gj1Q4xuE8zTLEy2Um8c4kvthHkCZXzYSZycekQ@mail.gmail.com>
 <20231205094220.2301360-1-n-francis@ti.com>
 <20231205094220.2301360-3-n-francis@ti.com>
Date: Wed, 13 Dec 2023 14:38:57 -0600
X-Google-Sender-Auth: NDWwMWJlIzkT3pBQnBhO2zqZZ_w
Message-ID: <CAPnjgZ2OnBM892MyvmguuQViz+kTpC2RkOrV3fD6N5-MTyMKug@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] arm: dts: k3-*-binman: Move to using ti-dm entry
 type
To: Simon Glass <sjg@chromium.org>
Cc: marcel.ziswiler@toradex.com, alpernebiyasak@gmail.com, 
 u-boot@lists.denx.de, hs@denx.de, christophe.leroy@csgroup.eu, 
 mr.bossman075@gmail.com, afd@ti.com, m-chawdhry@ti.com, kamlesh@ti.com, 
 nm@ti.com, c-shilwant@ti.com, u-kumar1@ti.com, 
 Neha Malcom Francis <n-francis@ti.com>
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

On Tue, 5 Dec 2023 at 02:42, Neha Malcom Francis <n-francis@ti.com> wrote:
>
> Move the DM entry in tispl.bin FIT image from default fetching an
> external blob entry to fetching using ti-dm entry type. This way, the
> DM entry will be populated by the TI_DM pathname if provided. Else it
> will resort to the ti-dm.bin file.
>
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> Reviewed-by: Andrew Davis <afd@ti.com>
> ---
>  arch/arm/dts/k3-am625-sk-binman.dtsi              | 4 ++--
>  arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi | 4 ++--
>  arch/arm/dts/k3-am62a-sk-binman.dtsi              | 4 ++--
>  arch/arm/dts/k3-j7200-binman.dtsi                 | 4 ++--
>  arch/arm/dts/k3-j721e-binman.dtsi                 | 4 ++--
>  arch/arm/dts/k3-j721s2-binman.dtsi                | 4 ++--
>  6 files changed, 12 insertions(+), 12 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot-dm/next, thanks!
