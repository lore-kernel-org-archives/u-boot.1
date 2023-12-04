Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB477C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 11:00:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4382787499;
	Mon,  4 Dec 2023 12:00:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="g+WG2Kev";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12A82870B7; Mon,  4 Dec 2023 12:00:36 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78B8C8761C
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 12:00:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel.thompson@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40c09fcfa9fso11083475e9.2
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 03:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701687628; x=1702292428; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1w5VMLvTcEx1fZofK6G7GbthKs+k6BvF2asbnJrbRBY=;
 b=g+WG2KevspMym935agTDEY47sdpc/pSqP/tNBPuQB7o54MRLL8Kzoecq/aGBdDtL8n
 jmKRM8Ye1WIo374OGR87BVUURV/1KSvcNPiw3yK3yw8i1sFtmTjlyzFEbpS8wFNfegq2
 5L9ZzSqaQ6YYH2atfsv4nE8xDccegPQTI4TLwJg1P9GWwyK03jfoGaBZC0fO03P9MxC3
 AqIa607dENgWkzyIlhAecIQ6GNvrcpY800TqjBbRXJqt7QIhk3yQeOBMD/gCb1duE4a7
 /Ys4QofrD7kOFyt4l069JAcKYaxGGihTxUgyu2uUZeAbO7LsAebOo3Ce6cLqh+2omst2
 1/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701687628; x=1702292428;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1w5VMLvTcEx1fZofK6G7GbthKs+k6BvF2asbnJrbRBY=;
 b=n/mmoriMvIyYJHyFbiaNf8Gie21l08h4H8kpyKSnghmEBV0sDFanrFwLYVYAwHamYH
 VJPTWjCVPqv9rQkUh4Qkx+ynp5lgg/VFo7mqDbyBiVIOAq7IMDwH99y8A2LGD/09W4eP
 AWgQZ4+G/RSpxRs3oB4dVTX3fnp4ETuy60DZkpvCd4Np16t2/vNY8mjRC65yGgy2LQ7y
 brG8UaxmOMCM+tnJ960zd2sWRNbpr14ouayJJHUJmLHB35Tnqk4L0K5JQwAqX431g4GU
 ygEb/0CGGSTNtxRZS7vXc6ytSLTW7r5GPwkVZrEWFHft/MXDJfeMuKdw+7E9uwRoIXSU
 2gqg==
X-Gm-Message-State: AOJu0YwWk5uyNc41XLOqIdBB/sqrwxBLmOCo+31Gx2gIiGrBXdee/Ef0
 FvrHJv1xIEcnQEjbjUX+/iV0ow==
X-Google-Smtp-Source: AGHT+IHaJ5vKdobfcGbaBKtlDKE2Z3kbpYxCvVSRZnOhFL8LOff/CMZYADZR6s2gvajiGpIbWsVR1Q==
X-Received: by 2002:a05:600c:43c3:b0:40b:5e59:f748 with SMTP id
 f3-20020a05600c43c300b0040b5e59f748mr1351879wmn.186.1701687627954; 
 Mon, 04 Dec 2023 03:00:27 -0800 (PST)
Received: from aspen.lan
 (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
 by smtp.gmail.com with ESMTPSA id
 n26-20020a05600c3b9a00b0040b34409d43sm14524691wms.11.2023.12.04.03.00.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 03:00:27 -0800 (PST)
Date: Mon, 4 Dec 2023 11:00:25 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 conor+dt@kernel.org, Caleb Connolly <caleb.connolly@linaro.org>,
 neil.armstrong@linaro.org, Ramon Fried <rfried.dev@gmail.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Boot Architecture Mailman List <boot-architecture@lists.linaro.org>
Subject: Re: [PATCH 00/21] Qualcomm generic board support
Message-ID: <20231204110025.GA27965@aspen.lan>
References: <20231122140100.GT2513409@bill-the-cat>
 <CAFA6WYNoz-Pqn38FpKLj9eJxX6B019HvQoukdCma3S=+O6tOCg@mail.gmail.com>
 <20231122142758.GU2513409@bill-the-cat>
 <c47b163b-d0d9-4de6-8ea8-ebe884b28e4b@linaro.org>
 <CAFA6WYO_Dk+7FWDGjUdDub27YCwVKRjS+vZfMrT8otjvv-QO_Q@mail.gmail.com>
 <22b2c2e2-9ce1-4a5f-8cda-565184eec120@linaro.org>
 <260c6f67-17f7-4255-b759-12fe25024673@linaro.org>
 <CAFA6WYMeg6B7Ozb42u79U43=26JmK3CaxfO29uuqQnGipFowEA@mail.gmail.com>
 <20231130143512.GQ2513409@bill-the-cat>
 <CAFA6WYMLUD9cnkr=R0Uur+1UeTMkKjM2zDdMJtXb3nmrLk+pDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYMLUD9cnkr=R0Uur+1UeTMkKjM2zDdMJtXb3nmrLk+pDg@mail.gmail.com>
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

On Mon, Dec 04, 2023 at 11:02:57AM +0530, Sumit Garg wrote:
> + Linux kernel DT bindings maintainers, EBBR ML
>
> On Thu, 30 Nov 2023 at 20:05, Tom Rini <trini@konsulko.com> wrote:
> > On Thu, Nov 30, 2023 at 01:02:25PM +0530, Sumit Garg wrote:
> > > On Wed, 29 Nov 2023 at 22:06, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> > > > > I've been thinking about and hacking on this for the last week or so,
> > > > > sorry for the delayed reply here.
> > > > >
> > > > > The value is in preventing any of the existing bindings from regressing,
> > >
> > > That is actually best addressed in Linux by checking the DTS against
> > > yaml DT bindings. We don't have that testing available in u-boot and
> > > only depend on careful reviews.
> >
> > I would absolutely love for someone to make another attempt at updating
> > our kbuild infrastucture so that we can run the validation targets.
> >
>
> Given that EBBR requires [1] the platform (firmware/bootloader) and
> not OS to supply the devicetree, it becomes evident that
> firmware/bootloaders import DTS from Linux kernel (where it is
> maintained).
>
> But currently u-boot doesn't have a proper way to validate those DTS
> against DT bindings (maintained in Linux kernel). Although there are
> Devicetree schema tools available here [2], there isn't a versioned
> release package of DT bindings which one should use to validate DTS
> files.

The kernel is regularly released in multiple forms (including git
tags and tarball). Why isn't the kernel itself sufficient to be a
versioned release of the DT bindings directory?


Daniel.
