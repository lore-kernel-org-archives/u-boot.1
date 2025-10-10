Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1287CCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 10:36:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E25A83FB0;
	Fri, 10 Oct 2025 12:36:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GzR6JG/w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 523B983FB5; Fri, 10 Oct 2025 12:36:09 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8094583F69
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 12:36:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-63963066fb0so3797555a12.3
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 03:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760092567; x=1760697367; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JQ9fXeCdRNBD2MvrCymSrbrU0O6xW7lQgmOtLkW6Gv4=;
 b=GzR6JG/wp5EFee46Yp6udGW1OuGGEByj8cI9OgVmcLh5JvHfWNxI5wIpSzgHGuuf2N
 74y9WDDJzzz8gRcvyC354BEfpGWdgUtud3Ef2B/4rbSEsO7w/vL7BwZWkf2nth9w90ck
 yq6DfzBjQUApcA7/JFk2Bj1jAw38umep5ZNNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760092567; x=1760697367;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JQ9fXeCdRNBD2MvrCymSrbrU0O6xW7lQgmOtLkW6Gv4=;
 b=B7HXg0r1+fARa4ZdUd7Q4TStZuPgNY04xPfaHWcXPMZDXyq3KQ6INvDCvvExgDLZlW
 DkBvwReCgI/NojRNSQS/NmjRJHI4X4yuAPCg2aKcpUi3zVWYQYb7NcteEkziM0rzljj+
 2wtzZsrFUf7dVHXsEo0dJ6D8AuoufYvlcgD4JIaRkoRIacLGP3q8ML1AH9FNPiuaqWPa
 dqpMv8JQ1ULReHvIGxC1ed5qaUHXoA7ktorQi54+SU10w/TrMKaKwveyMdwscqMzdk80
 cd2lP6osBu7OTpzSWhOqBy/7kuB1aeOSCnJCB95Zk/cKq29rrsGvpxD37xngGq4sbTKl
 xgAA==
X-Gm-Message-State: AOJu0Yy1TDFckTybg8SUnpWUnwKwiH2gUiyJ6co4jdWXeFXf4DnZPDMm
 fML6Cy5Yke6qish5vysQTIUVK4GPYyyn/VqwqNuBSyPqqgXasyWhkQzpznhG0BPL8Q8JLEsL+7m
 nkbYCq0JUt8tNYCjgcbxISSyrsYPBONga3+5FXhC5
X-Gm-Gg: ASbGncvyXJPm+QtdUhnUgsOfVL+gyronzswtkDiIwuH/CBiMfLC91sJmBXnjZKaHYJP
 JhhtJAAr95cVUdH9kYWvxzJaRsMoqtF8ZmyivtWq/qmxBH1GAlHW1Gk8MnILXGPebQuh+X0VCQQ
 d/uwvf5X29SKxo0+tgR/oJc7Vq96jRCvl75AgL485VfZxyj4Utx2lx9qpcfwPGwySYtWGndhMNI
 iaqLAK997WgAKGqjO+zFuTiSN+PkyMz
X-Google-Smtp-Source: AGHT+IFn1K8L7aJYgvoXKlHjm3+obRN8HmocL41IklsKBhbnPE9pVUMha5QJ2u5HspyKV9Tugr2rVJ/38nQBnuVv190=
X-Received: by 2002:a05:6402:5241:b0:638:d495:50a7 with SMTP id
 4fb4d7f45d1cf-639d5b8b694mr11214138a12.16.1760092566984; Fri, 10 Oct 2025
 03:36:06 -0700 (PDT)
MIME-Version: 1.0
References: <20251009092959.260121-1-sjg@chromium.org>
 <20251009092959.260121-3-sjg@chromium.org>
 <20251009172428.GP298503@bill-the-cat>
In-Reply-To: <20251009172428.GP298503@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 10 Oct 2025 11:35:54 +0100
X-Gm-Features: AS18NWD_qS_Qo_tMeJEZGm7R3WWfDheBdlSRl_LDF6yNSA-Hk3FiLie9nGWuFfs
Message-ID: <CAFLszThKqdoRwqSbazWgdw27q9RxJorTwkLmRzZ9FAV48S7gdg@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] boot: Move obtaining the label into a common file
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Guillaume La Roque <glaroque@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Maximilian Brune <maximilian.brune@9elements.com>, 
 Moritz Fischer <moritzf@google.com>
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

Hi Tom,

On Thu, 9 Oct 2025 at 18:24, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Oct 09, 2025 at 03:29:53AM -0600, Simon Glass wrote:
>
> > The 'bootflow list' command supports looking at the EFI device-path when
> > available. Move this piece into a common function so it can be used
> > elsewhere.
>
> The point of this was to enable the show_bootflow->bootflow_show chnage,
> so should be dropped.

OK.

>
> > Use 'usb' instead of 'usb_mass_storage' for usb so that it fits in the
> > column space.
> >
> > This updates the output from 'bootflow list'.
>
> And this is unrelated and should be its own patch. Wikipedia says USB
> MSC or UMS are the common short forms for USB Mass Storage devices, and
> we should use one of them to have the output be more precise (since we
> support USB networking devices for example).

Ok I can move it into its own patch.

Are you wanting this to say 'ums' instead of 'usb' ? Will anyone know
what that means?

Re the second point, at least in U-Boot a USB Ethernet device shows as
'ethernet', i.e. the interface doesn't matter. We don't have logic to
look a level deeper, at present.

Regards,
Simon
