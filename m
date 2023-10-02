Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60740E784A6
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:44:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B268C87501;
	Mon,  2 Oct 2023 03:23:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Nrw5qWiJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25016874C9; Mon,  2 Oct 2023 03:23:21 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F15D874D2
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:23:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3247cefa13aso5567647f8f.1
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209784; x=1696814584; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8S7CLCWWs+BEF32e0nk5jmGC986rwgnIzWQrtit1ssw=;
 b=Nrw5qWiJRdQIbsfcOJowlMlvtg4Tq6gzTKoVYDVmFu0IZzQOaNiKGYliqBOF2d8ilK
 8iKojK9qBAkdjiY41tYTsOvMOb54ev0wBeFK0jab9Wo2OybVzJZOndu9/d+i1G+hlRkv
 U9AHB7IuXqvk1VuG3y52SDeYK+Z4eRHqYzJ3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209784; x=1696814584;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8S7CLCWWs+BEF32e0nk5jmGC986rwgnIzWQrtit1ssw=;
 b=D7r1vLFQj2+Po+tGS0WHD/4gLfNew+jWVtNWruwOhyUsOAja/yEUXP38az+uVd7NbN
 tqldwajq9RPdeumRF0wae5dk0Og2ykFtpAXJd+Eb6rXWsXqBbY3rD7j+IMxJlbsB/Wsg
 9yPfbBbEZ9v73zZIJuiwcmxluTVegt37l2+AQL0Yp/dJaG6u4HOQLD2IRcQ5kwMXM3pD
 U+lTpJKxPjgdFIsnVn3EBemYNoyata84/pg+NIbuONvAh6GUHcjnp2ATN1bIAUmUlV9j
 0rlAwu2k8tDYDYVRfBb1ehZgyNFxD/CC5zQTE4boYZT0hhjpj9QPSQ6QHb2qw2mD7t7R
 tbtA==
X-Gm-Message-State: AOJu0YxbHld8Uj6laVeQiVZePy7R+VrY0AKCt0llqipEUPWbIAqrXM2h
 nTQ/2jZPbaadUaATUJ7VEFmDOAsJVbBav+/9l0SAUw==
X-Google-Smtp-Source: AGHT+IFSzQXPWBIlFY+BMuhlhHW1s3KF/SXSVTxNXPDwEDH+146U5JNHuBe74JPAzacpMio6bjSbc3aNObdEGoyo6yM=
X-Received: by 2002:adf:ec8b:0:b0:321:68af:947 with SMTP id
 z11-20020adfec8b000000b0032168af0947mr9060596wrn.8.1696209783745; Sun, 01 Oct
 2023 18:23:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230926065750.734440-1-takahiro.akashi@linaro.org>
 <20230926065750.734440-14-takahiro.akashi@linaro.org>
In-Reply-To: <20230926065750.734440-14-takahiro.akashi@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Oct 2023 19:17:16 -0600
Message-ID: <CAPnjgZ3Gx507LM3DtPEkBb8q0hDe9UTVb1AQTDnp2wh8Qfc_tg@mail.gmail.com>
Subject: Re: [PATCH v5 13/16] test: dm: add SCMI base protocol test
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: trini@konsulko.com, etienne.carriere@st.com, u-boot@lists.denx.de, 
 Etienne Carriere <etienne.carriere@foss.st.com>
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

On Tue, 26 Sept 2023 at 00:58, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
>
> Added is a new unit test for SCMI base protocol, which will exercise all
> the commands provided by the protocol, except SCMI_BASE_NOTIFY_ERRORS.
>   $ ut dm scmi_base
> It is assumed that test.dtb is used as sandbox's device tree.
>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Reviewed-by: Etienne Carriere <etienne.carriere@foss.st.com>
> ---
> v4
> * fix a typo fix in v3
>   s/scmi_protocol_message_attrs/scmi_base_protocol_message_attrs/
> v3
> * typo: s/scmi_base_protocol_attrs/scmi_base_protocol_message_attrs/
> * modify the code for dynamically allocated vendor/agent names
> v2
> * use helper functions, removing direct uses of ops
> ---
>  test/dm/scmi.c | 111 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 111 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
