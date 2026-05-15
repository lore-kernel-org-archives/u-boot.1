Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1393BCD4F3C
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 18:22:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DE6F847C5;
	Fri, 15 May 2026 20:22:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dKGYovew";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C46608483A; Fri, 15 May 2026 20:22:38 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79677846E6
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 20:22:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b9358bc9c50so9511366b.1
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 11:22:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778869355; cv=none;
 d=google.com; s=arc-20240605;
 b=Vde39iCpA0cAKD+hSoPQ2c2qq8Qd+g3HfQxCGQ9OPuExpL9ZjkenIN/pX5xfDfTWSS
 5JgT6rebqKcdsTHmR83ugVzji9XnDjHTdjDSp89TOaYVrARW+FBzOxAIxkpwKM25U7Cd
 aBCsD+q2BYumx9YRz9JHURosZgihmp5jDR5PJIY06wK4AURjOIH5UKOVgz7KgEwOwnS0
 pjoNwubdTSGcDU3Ft2IOTiJNV0/Lgj/OBxCjGMDJxfOikJeyhMtXvLin7qUBLgXv5DO+
 /a34tfdhtBNdQqq8p/+lim+4EXx3nVbSpBi3ILcDGgrRXm43tn8IcgKmylW72QldVEya
 YFOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=JgJE7D4DYNpkovFZrsf5mkqGCUZv7j5EEeF/NIT3G0s=;
 fh=sKlYf1RYFkU7W57k8Hb0RqRH+ropi6os4Aw4ruwQ2Xw=;
 b=DFVkcNBRynYgtke//JBaAcvoteByYQDooZtzVHizYd77raqdPVie0vd652IYfhilRI
 BrkKbh71nMhePpZlY+TabhnYkkffTrEEHDsrTB+zHxi0V/bE0G0XIUz1nNh3Ok9z7QKS
 qtruyrfwYF5yuouip+p2m7CI25wlZexE2gyICIfy13XGmYYWIxwQabBfgzdJ7VmrAXsh
 NMhtT82jeSBaxAuLuZgYLkmsakjyObzOr7N7DgGSHwBviEiC2KuGJxrEuEUx8d5DqZRe
 zhJopa7GgHReHyf3K9tWTfLgI/tfQ8xpZuoyzhIvEAaEFmwRRyZNHOWdy1XLaM8ssH3t
 81cg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778869355; x=1779474155; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JgJE7D4DYNpkovFZrsf5mkqGCUZv7j5EEeF/NIT3G0s=;
 b=dKGYovew/Rdj+XNtDYnsFBKwOcJq1Hn6FqvffeUrhEmR9XF9tNW2uRLwPlRaTFcEJf
 Iw90o73Aq2XkKhZ/QFmDIv0lC10mxRA8b5nnfvqA+Rs4zLgFCv1Lu0KSK16foqSAPNj5
 sQdqLlw3ojHuOjVw7Mh8Ec+e2mvbs2dSsma+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778869355; x=1779474155;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JgJE7D4DYNpkovFZrsf5mkqGCUZv7j5EEeF/NIT3G0s=;
 b=W5WgxsthG//IA3IzfDYiwQ4KJ9gT7d292GCsR9bIH9Yv+nkiH2YnLkBR3G6Hc6crKl
 eVC+fexa2S9eX8RGK/bk6x2dxjp/Vl37LbCj0fHrp/ojqDkC7hVw92JitXC7IW8CucJr
 RoVuZvEJTgkLY8+59NFGzIMTupcsqoeV9n1IyOEYtyt9m2U2pQ0K1JfZttoa3MltYUQ2
 advlewc584vLuKUedA/+S5Jbyrr1tHFIXTpjTvFwKZJ2rR1WmN+n2elDH46xOzRVOSd7
 T4TT+V9NmXjk8rcsxAWchU9vZoZIie24QTJPots5VRvMLWTn+Qm4KIp5UlChsKmXWjcU
 TsuA==
X-Gm-Message-State: AOJu0Yy7CPLnfrHWsRNE9KUJAU6vc5VWxeR6/8faeBctvu9uS2fPwWXq
 3ypgAEYyx/Sc3glWUMWb3z2IZ9ozEBeEiRx0IP1nH8NqsIdd+HwTXBGR4u21ci8AOI5r2QOHX0E
 3HjIMSQzbKRwhysU/iD/yphFcsKP1h1V0SNv/vUzK
X-Gm-Gg: Acq92OGScabARxqWSi/S8/9+OXzNPTAnOjrV5rj3g9l6guNZu4Qi7GiyGfAjf7Fq4bN
 Ji2IPs9mIp/448iUc8/vUUBJy3hSSrtNhcvOfQrbiFi72K+CbZnDy+lKsNiHtmBF+LqWeSj3eq8
 jfa3cRKGGdIOv9h6MUIka3NlTBvS4xEJfqTycFTVCgDH6o+dxCSq3ZCrH0Z4BT+gHHv+U1YaaUu
 fEeaWlgEO7S1drgsIEYU68cq0KEW6qjKu/e2TVIzieQSF63C2Rhi+wDf1CKz6pCY/ifImkUxuOp
 uT3+AA==
X-Received: by 2002:a17:907:c22:b0:bc3:c6a4:a819 with SMTP id
 a640c23a62f3a-bd51796e738mr264292766b.36.1778869354855; Fri, 15 May 2026
 11:22:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260514124924.1804332-1-harsimransingh.tungal@arm.com>
 <20260514124924.1804332-8-harsimransingh.tungal@arm.com>
In-Reply-To: <20260514124924.1804332-8-harsimransingh.tungal@arm.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 May 2026 12:22:22 -0600
X-Gm-Features: AVHnY4Ig8HZUOS6Auo6C76Z8XZa1uxEqIgyO4qZEk1SAd2Hk2Vh-4LmgrB-QbaU
Message-ID: <CAFLszTjHDTALNScPLaRLRB3r1GqN7vvK6rP4qspqCXK6JCFRgg@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] corstone1000: enable bootefi selftest
To: harsimransingh.tungal@arm.com
Cc: u-boot@lists.denx.de, abdellatif.elkhlifi@arm.com, trini@konsulko.com, 
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de, hugues.kambampiana@arm.com, 
 sjg@chromium.org
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

On 2026-05-14T12:49:13, Harsimran Singh Tungal
<harsimransingh.tungal@arm.com> wrote:
> corstone1000: enable bootefi selftest
>
> Enable CMD_BOOTEFI_SELFTEST in corstone1000_defconfig so the later
> runtime-variable selftest patch in this series can be exercised on
> Corstone-1000.
>
> Keep CMD_BOOTEFI_HELLO and CMD_POWEROFF explicitly disabled.
> Enabling CMD_BOOTEFI_SELFTEST would otherwise make
> CMD_BOOTEFI_HELLO default to y and pull in CMD_POWEROFF on this
> PSCI-based defconfig. The intent here is to enable the selftest command
> without broadening the rest of the board command set.
>
> Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
>
> configs/corstone1000_defconfig | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
