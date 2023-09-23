Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F10DECE7A88
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 18:14:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8770F86B29;
	Sat, 23 Sep 2023 20:14:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WZHTf27w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF7428469B; Sat, 23 Sep 2023 20:13:57 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E30BB86945
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 20:13:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-50437c618b4so4064638e87.2
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 11:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695492835; x=1696097635; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Od01Qz88ALhAS9ib2ya4cdpAp0FXpxnYBiwWe1bxT0Q=;
 b=WZHTf27wTduKFwAAaUMYZ6WwaUnqNq3bup6AkRbZgkYAWR3JXPmVrGfltCLdHjBTib
 PoAGgPE2PvMntJYI9azDj5N0ICZvoTCateD1ztcL10bPCcYiThbO50lHxKrgQqQmqAbx
 VjkwQcdKEbBrp2ySSeMPbNozk0ZnlddwD2N5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695492835; x=1696097635;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Od01Qz88ALhAS9ib2ya4cdpAp0FXpxnYBiwWe1bxT0Q=;
 b=akeMrzjhfLkA03XmAwHm1xB6xO5Cfow0oAmgy0W07fe0dHJLmfZXprUJhFB+l8gUcL
 g2PAw4l7TGyFs9TQ9KtYEMuMuTpf076oenZmv1v4fjkS8UIwazXVPFffHD/V58HmYo3s
 9e/fhV5AWlbPBylIljs7y5iWiCXGXcr4yZFm40qARo6LSDbq2RsDgcOqBeCmkW3llJt6
 Wc2HAXKo5lLMZUpCSJAkJz4nXyBaumf169drjy0ao//Nnf9ojNLALN37qYHfKiO+FrCE
 v1PxNOMunYQbbSS+MqoEkYuvFTh/+2/YIEMG+Oy3P2LdgTGhhil1qgO+EAmzzzTlVgp2
 QrvA==
X-Gm-Message-State: AOJu0Ywq0fS1ZZVjmoNj/ybrnijsLQZ4WHRK6blKjuLRK2W2T9Ojjw6A
 1kWoaX2/anaR6QJdm/v9pLka4FKX0q8xHGR8xZElfw==
X-Google-Smtp-Source: AGHT+IE2xyODXpdokOcgwxcOAgo6AB/GO0vSkiRKfD5o7DIBUWOG3m+/3V/Yf0+Wod0dQefOyz5ArIZdZ1eslUf+T28=
X-Received: by 2002:a05:6512:360b:b0:500:b287:36df with SMTP id
 f11-20020a056512360b00b00500b28736dfmr1927109lfs.13.1695492835152; Sat, 23
 Sep 2023 11:13:55 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 23 Sep 2023 11:13:54 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ2n-z9CEn_ej3HqNP1C9j=x7E0U-WcmnAyAHFCSeOWWyA@mail.gmail.com>
References: <CAPnjgZ2n-z9CEn_ej3HqNP1C9j=x7E0U-WcmnAyAHFCSeOWWyA@mail.gmail.com>
 <20230901050532.725-1-maxim.cournoyer@gmail.com>
Date: Sat, 23 Sep 2023 11:13:54 -0700
X-Google-Sender-Auth: uCqfdD9NiU7RHBe4f-cualtKkRk
Message-ID: <CAPnjgZ3=q9oxoZRYPKHX8+iQ9Boyb=ScfyteP45eEx4MUqDjNw@mail.gmail.com>
Subject: Re: [PATCH] tools: Fix patman launcher script.
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Maxim Cournoyer <maxim.cournoyer@gmail.com>
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

On Thu, 31 Aug 2023 at 23:05, Maxim Cournoyer <maxim.cournoyer@gmail.com> wrote:
>
> There is no "run_patman" procedure in patman's __main__.py file, which
> would cause the following error at execution:
>
>   "AttributeError: module 'patman.__main__' has no attribute 'run_patman'"
>
> Signed-off-by: Maxim Cournoyer <maxim.cournoyer@gmail.com>
> ---
>
>  tools/patman/pyproject.toml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot-dm, thanks!
