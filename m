Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A4BC00A8F
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 18:06:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BCB8879AD;
	Tue, 24 Oct 2023 20:04:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oexusJoF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D5628798C; Tue, 24 Oct 2023 20:04:29 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48A3C87998
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 20:04:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5a7b91faf40so47647537b3.1
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 11:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698170659; x=1698775459; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aY9CmNuxRWKUevpetKk6QTGxEsr5py/im7okXcRCRCw=;
 b=oexusJoFEXb6cuBdI8AnEJs4QsaoWPaJTLWLzzXtsYyx/hW8NfFHW8E/TVoTUWM3h8
 lpluHUqQn/oX8b+IRNZ1RNb1FuqIdWXvaJjSqzfR8317bjQEsZTfDAsRW+ND5Ibp26I3
 0/udhUhW4Ze/Mejwz5KgpHd8a2EQdMsgPfCyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698170659; x=1698775459;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aY9CmNuxRWKUevpetKk6QTGxEsr5py/im7okXcRCRCw=;
 b=ZBA1PusjMwQSHrss6gk5SNKJL7eZQ9oxUc9i/+6Pu3ulG+I3fUFQ8cO2BladS86QNk
 /zntDoorrWbpLDYJxhfMzRxB0V0BRDgy2WSxOhz0RhZL5Zvxg8QMPRiKgM8XuhWj9K4S
 FhKG0sNdoao76zbCEL521wLGXpcwNvTytCOZeB1lmUBhymVLQowt70QfDZ7o8p+uz82s
 0Q1pi7BydEvdrQNZtZ48TP4IumXnJ4hWaRyFu07lK8MiTzL9/grQIt6etjfofIlgdoR6
 r55vp56/u8FOpe7+71b+0Vf4MmBsilMRM2dEsaoLYgfSB+ZcxS2irR5dr275hIHDUy9l
 Ku5Q==
X-Gm-Message-State: AOJu0YyD45xWDa7E711BqH74fcTTjs3lDgRNyIZSOaDbj9ZZhgb5sd5I
 ZFk+cIHY+uY+PO2sVpLMJOfzc3+6rrbelRfcCTdNBFhBFsiPZs8jIVf7FAFX
X-Google-Smtp-Source: AGHT+IFKlh4vCHAclqpOX5erOEWiEvXTyNOz5NHSKmXy14bxL0P9xKDnmwnpJTdAhrjd8h41mj5p9tdTn27onqSMaYE=
X-Received: by 2002:a81:4983:0:b0:5a7:b515:ae47 with SMTP id
 w125-20020a814983000000b005a7b515ae47mr14316764ywa.9.1698170658990; Tue, 24
 Oct 2023 11:04:18 -0700 (PDT)
MIME-Version: 1.0
References: <20231023080103.3780998-1-n-francis@ti.com>
 <20231023080103.3780998-3-n-francis@ti.com>
In-Reply-To: <20231023080103.3780998-3-n-francis@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 24 Oct 2023 11:03:28 -0700
Message-ID: <CAPnjgZ0c-xo+fXwNXNiTwC8Vrw2RsMqsdbG1OcspLKfOh0HSVQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] DONOTMERGE: arm: dts: k3-j7200-binman: Enable
 split mode for MCU R5
To: Neha Malcom Francis <n-francis@ti.com>
Cc: trini@konsulko.com, alpernebiyasak@gmail.com, u-boot@lists.denx.de, 
 vigneshr@ti.com, u-kumar1@ti.com, a-nandan@ti.com
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

On Mon, 23 Oct 2023 at 01:01, Neha Malcom Francis <n-francis@ti.com> wrote:
>
> Set boot core-opts to enable split mode for MCU R5 cluster by default.
> This patch serves to demonstrate how this can be done.
>
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
> No change since v2
>
>  arch/arm/dts/k3-j7200-binman.dtsi | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
