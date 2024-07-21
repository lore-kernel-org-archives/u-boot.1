Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 378DBC3DA61
	for <u-boot@archiver.kernel.org>; Sun, 21 Jul 2024 10:09:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3959F8806A;
	Sun, 21 Jul 2024 12:08:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jD0sJklA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9119387B8D; Sun, 21 Jul 2024 12:08:55 +0200 (CEST)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 181BE87EB4
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 12:08:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7a115c427f1so235665a12.0
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 03:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721556531; x=1722161331; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=49OTLffb5n59cgctai071C377IuP8qSyteEXF4rsPrQ=;
 b=jD0sJklAzZZZ8GYGJoBBjBiVcrokGWJlO1sI9LDizZck08Lm2ZNmagyK9ySJ7OlA2z
 /o4ds4fymeRUecVPFFMl8hiWwwt+pgLDYN7iDeaXwsDUrvFSOMGF/jbuVC3xIkJz1Dr6
 3LVi3UHnX2cxgQcsDl/AFH4b9B3OAsu0vxYb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721556531; x=1722161331;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=49OTLffb5n59cgctai071C377IuP8qSyteEXF4rsPrQ=;
 b=atBvxaGWzvRU1oS4bCoqMctoxmhgATHGaY2hGIBt0/+gxIc8FRFb/g7Km50Pp4oEcc
 ZiYudw14CXEzKVD1IqmNKIEHAtwSHuehHQ8Xpiju+WuMrlgW42QmnJuTfKIGSo3IhRrM
 XhWacBEEhD3eoeia+ZEInak3Z6ctrmcz3lner63xC+2geAUwOxCNRa5gtIp4N6x3uvb7
 3U3HlRRXGli1hY0bF2gcf0cZog9T83nCPesPUH5rVR2/q+XqUzkkVPZaeyp33336bVfC
 ShcwycRGARhWoCPnzUlQleSb9llRzzClGtx8uESaJqCgfAo6tyCaBSa1eC7dvmmEmeAw
 WqJg==
X-Gm-Message-State: AOJu0YxB2Fyv8gNSGY6h+HvKbSC8wvB3SVb1rTmi2/2EHAnm9cWx/vhP
 NLxMjxnaY42l9fkCgoqbD8NU2uyYpM5+fe+dTFJ1U0Z0aoQbdrRWJiUBLEE1P1m6aFuoUnsOKiw
 sPL/jPsvP9CZzuLCh9BvHFwss41jBnJR6K0Uv
X-Google-Smtp-Source: AGHT+IGNHu4b0mW57aC1IdbLpPgi6KfJa3mO9AMJks2NNaocXcXUiG9pl/YEYrGlWbfJwB8/qC/FNfQdLJmdRYZUrxM=
X-Received: by 2002:a05:6a20:a12c:b0:1c3:a411:dc48 with SMTP id
 adf61e73a8af0-1c42299e229mr4332608637.38.1721556531511; Sun, 21 Jul 2024
 03:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240720061706.2644229-1-sjg@chromium.org>
 <20240720061706.2644229-10-sjg@chromium.org>
 <b6bd4451-9893-77e1-e293-f6aad2cf1295@gmail.com>
In-Reply-To: <b6bd4451-9893-77e1-e293-f6aad2cf1295@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 21 Jul 2024 11:08:35 +0100
Message-ID: <CAFLszTi_kNreRgTDo6dy3wO+CqS4cBydZF+qQrtpBZk7SUzXAQ@mail.gmail.com>
Subject: Re: [PATCH 09/14] spl: mmc: Handle error codes consistently
To: Sean Anderson <seanga2@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
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

Hi Sean,

On Sat, 20 Jul 2024 at 16:58, Sean Anderson <seanga2@gmail.com> wrote:
>
> On 7/20/24 02:17, Simon Glass wrote:
> > Use 'ret' as the return code, since it may not be an error and this is
> > the common name in U-Boot. Make sure to return the error code when
> > given, rather than transforming it into -1 (-EPERM).
>
> Does this transformation affect code size?

Not that I can see, e.g. for firefly-rk3288

Regards,
Simon
