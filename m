Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF87CFB446
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 15:24:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 926B888D36;
	Mon,  7 Oct 2024 17:23:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b0+0KLE0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FCAD88D47; Mon,  7 Oct 2024 17:23:47 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62D1088D33
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 17:23:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6cb2aaf4a73so47920586d6.2
 for <u-boot@lists.denx.de>; Mon, 07 Oct 2024 08:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728314624; x=1728919424; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Hp5TSb98cLR+8hOjrA2uOG/D1rxNFNO8VRodIjCPlr4=;
 b=b0+0KLE0snhZkHPEdLOWRwbXzmXW9YP7Ey+vQSigOQ6tkZBMQNgAYNUEfcdnLwPBs/
 cU+WqrKWbygTar+VjSnxa+Sfx8gzWh5YiocTmh9BqtF+r7IL8ed74UVpTS3sY6OZykr6
 +KV8V3+RIYVJ/9ag7Mx6B+d25cveIN2yIMdjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728314624; x=1728919424;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Hp5TSb98cLR+8hOjrA2uOG/D1rxNFNO8VRodIjCPlr4=;
 b=EIDjrppo/kK/o5lKIhFatkPf7mkoA2e2yZQ/o7dyrQk0h1GqF2vTdO9tMSbsvPG01K
 KKA6ltYrS1W/YfSKysNQMuC7GmBvkTs0wMqiidilS+4KvC9cfn52H2BHNsIP1qdiBKA7
 AjCRb9RaMskVpPOKEzVbk3nms27vp4Oe/ilnj9cwgpKqmLx/irCDKuWopUk8Vc+lI73G
 ppf2kGJgCAvY1KU8pciLUC1G48Uth5lYKOC9Ebb/jCXjSGyz/BTg76mLi9yOP8yVod6f
 N97osVTXi3J/87mtvWWKcv8uFlws31B6xcQexG3Cs6ywvZ3QX9qoi5zvPh+TpUPACKRx
 KM0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7Xv0CNtSh/l5X+2fi3pq5mF1IClh3oj2PEcmXZxBgwCOK2n0Ji1GLqNwJE7/I9R6alA6N2CM=@lists.denx.de
X-Gm-Message-State: AOJu0Yws6VwBSzr3AOzHMBDZpaV9Cg0V6NXlnPt/o9E44gl9izu1AS0A
 jbG4rBGn78xRH12gzjL5OWddUBW735HTfkgNARVIfPYx3HVyMC+4uJyug4FUYMWWSlWqi1hrIc9
 6VlHBNbh2lXyViU+IevM6sqzI06KVys0yZPbd
X-Google-Smtp-Source: AGHT+IFRlrGNVFip5rX/A9wEJc46Y0ijlNSuM3Rzo7v+lqE/YEu6xnc3oLINZMOarTIsQIAtfsKb/CpI1qwEN8oSWKE=
X-Received: by 2002:a05:6214:5902:b0:6cb:410a:ef5d with SMTP id
 6a1803df08f44-6cb9a2f8424mr207993166d6.5.1728314624315; Mon, 07 Oct 2024
 08:23:44 -0700 (PDT)
MIME-Version: 1.0
References: <20241004-qcom-phones-v2-0-c7ab67ac3043@linaro.org>
 <20241004-qcom-phones-v2-4-c7ab67ac3043@linaro.org>
In-Reply-To: <20241004-qcom-phones-v2-4-c7ab67ac3043@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 7 Oct 2024 09:23:33 -0600
Message-ID: <CAFLszTgHJW=z-C0-DHif8MqJthPGDZRaD-fjM1KgtbT4+5cDWQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] doc: board/qualcomm: describe phone support and
 bringup
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Tom Rini <trini@konsulko.com>, u-boot-qcom@groups.io, u-boot@lists.denx.de
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

Hi Caleb,

On Fri, 4 Oct 2024 at 06:47, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Add some documentation which attempts to describe Qualcomm smartphone
> support with the qcom-phone.config fragment, as well as a high level
> debugging guide for diagnosing U-Boot issues when UART and framebuffer
> are unavailable.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  doc/board/qualcomm/board.rst  |   5 ++
>  doc/board/qualcomm/index.rst  |   1 +
>  doc/board/qualcomm/phones.rst | 122 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 128 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

[..]

> diff --git a/doc/board/qualcomm/phones.rst b/doc/board/qualcomm/phones.rst
> new file mode 100644
> index 000000000000..0726f782b675
> --- /dev/null
> +++ b/doc/board/qualcomm/phones.rst
> @@ -0,0 +1,122 @@
[..]

> +Ideally, it would be possible to use the framebuffer as an early console / debug output, at the time
> +of writing there are out of tree patches for this but they haven't been submitted upstream yet.

That's quite intriguing...you should send those patches!

Regards,
Simon
