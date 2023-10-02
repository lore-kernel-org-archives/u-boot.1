Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F5F6E784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:43:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4F8B874CB;
	Mon,  2 Oct 2023 03:23:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lfLxobIM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 854F08721E; Mon,  2 Oct 2023 03:23:00 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E672874A3
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:22:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-991c786369cso2115332866b.1
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209771; x=1696814571; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HRmjdeOheihkx76TuO0tVe7DLytW9q7/6SHTunAwMpU=;
 b=lfLxobIMFZ++e+OMQ0XOJNYaJBIHlO5O6YOM2urBmBjUt9OHWrUbeyHQHsRCoYbfJp
 /w03IJJRx+DTPiXX5OeMTDuxlwb8Y3OL7vIHM6JBRIYvtHmvcvDuXH3URRVkyiHTyknp
 9zeT1rKY1+lQcm6ysJZvio6vJfq2KUKaLDkjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209771; x=1696814571;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HRmjdeOheihkx76TuO0tVe7DLytW9q7/6SHTunAwMpU=;
 b=LENgMu1upSBNihPwPtZqpuusYnUDCU3xsV8PMrKw4bHMzAmp/BW1hCOhGpWpzv6mGc
 Mn27STgcFuLIgmrENOl7DqGbvoqyHUByW3hGQl7wvF38eK8SZZZtBrchSV9FfScT/lvG
 +e0M2gL1tawb6Y2NMmaRAJSRgL0oWiyxesPHyZQX27vy2DljJ0c2ELEgghdZwSz/17Sc
 IC8HF+ZAu5ChI4h8F5rE0YfZWjwistxbUzqwcjs/zt9lhZh5x+ndqL2mV+Z+iYAQmZwF
 8RNJBLCBe8QmLiguuVtbCiMPij5JhAWipwbKiGLouZP31Pf63MNGY2p/sqBdAsjgmzxr
 JBng==
X-Gm-Message-State: AOJu0YwMnnI2MdOBHCYFrzUNGxPhFEnC7NCrn0saqNuGoP/LeYnOvwhi
 +DQ1wOJX9oQG8iUoHQvADqjaV0F4SLWYWlMynUj/MJBEe3QByq6cEXI=
X-Google-Smtp-Source: AGHT+IHxKyFknSgRIk/Y9066H/Ikl6ICpTcx+awxxJsQdcQPwkoW+HoiXcNgnCcRGuAjGw1HD+ir2kkSE81YvrtG9Us=
X-Received: by 2002:a17:906:8464:b0:9b3:64b:4346 with SMTP id
 hx4-20020a170906846400b009b3064b4346mr1169665ejc.71.1696209771092; Sun, 01
 Oct 2023 18:22:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230926-binman-firewalling-v2-0-b1a084ec634d@ti.com>
 <20230926-binman-firewalling-v2-2-b1a084ec634d@ti.com>
In-Reply-To: <20230926-binman-firewalling-v2-2-b1a084ec634d@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Oct 2023 19:17:08 -0600
Message-ID: <CAPnjgZ14Uy+gBC8kgqVA7m9NXN_WiXFffu5Ob=vz=E76rMDMPQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/8] binman: ti-secure: Add support for firewalling
 entities
To: Manorit Chawdhry <m-chawdhry@ti.com>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Andrew Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 u-boot@lists.denx.de, 
 Udit Kumar <u-kumar1@ti.com>, Praneeth Bajjuri <praneeth@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Nishanth Menon <nm@ti.com>
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

Hi Manorit,

On Tue, 26 Sept 2023 at 01:58, Manorit Chawdhry <m-chawdhry@ti.com> wrote:
>
> We can now firewall entities while loading them through our secure
> entity TIFS, the required information should be present in the
> certificate that is being parsed by TIFS.
>
> The following commit adds the support to enable the certificates to be
> generated if the firewall configurations are present in the binman dtsi
> nodes.
>
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
>  tools/binman/btool/openssl.py   | 16 +++++++-
>  tools/binman/etype/ti_secure.py | 85 +++++++++++++++++++++++++++++++++++++++++
>  tools/binman/etype/x509_cert.py |  3 +-
>  3 files changed, 101 insertions(+), 3 deletions(-)
>

Please do check that you have 100% test coverage here (binman test -T)

Regards,
Simon
