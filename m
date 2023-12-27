Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE20C46CD4
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 10:57:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEB768771E;
	Wed, 27 Dec 2023 11:57:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aC4/L9aQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89CA287974; Wed, 27 Dec 2023 11:57:53 +0100 (CET)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6BA887718
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 11:57:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2ccad57dadbso35331951fa.1
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 02:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703674671; x=1704279471; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=s0OhYMqQjMvPeQIGFx+SIi0ZSRKI9pT5aEUQQ9XgZ4M=;
 b=aC4/L9aQOj4pM19nxsHGYNG3+2v/0nA4tGqgLrOf+GE9NNmJLSxiyaJYr+0oLA02mm
 jJpV+P4y4572EevxHXpfBh6JBJj7l19sWmYJBY84Q/TrpQQFKi1zQ2PlwVaO8LQ8cP8c
 M/A2VwYT4dG7BkUezE2zc9JNrWC/F4RltL9Mlf1rJnpv2xg64LYMso/jvZdnTGNw0Wvn
 Tu2PvwtJDWwSD4Mr7oyPO+3beGwHBnNfDFviyqpWuWAIEdGV5JmWfNM3AKHG+HeEb7XU
 pgwXXO/+6qaKxoZMgz69AzxVLpkkQZqVntH0tBlSgHE+AltAXfgiPqjWIA8qNSh8IsK7
 bNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703674671; x=1704279471;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s0OhYMqQjMvPeQIGFx+SIi0ZSRKI9pT5aEUQQ9XgZ4M=;
 b=rVAGx14twnf+8zz3d5yII8//S72Z19OxTz+CaerqbHVeuVHZZ3iihT4tjXvPvBJ89F
 abwDNa+1jY0xdY0OLJUDdEzyhbxSB93aTgYyz/KkIvf1kHlmY1Oy9KZdrm2bgPH5/1ew
 HALge92ysOujhutP6SD6POgTY/Y+4NmG6LX+SSHsrzf5FPLAhDV3cksXB+Vr41NLRwob
 6jLTAlvC92QnlEOXAY5kIWdFVGH81mZFwL4Z7E/XIS3qH0aDxPRtEZdKPWB8tLhzJwZj
 kJOHHrrpDT09BSL2xWT/2An6eqzrKd9WIKny/e5uYMis8BufguKvLlZk2ihGdL/lM8KX
 8s/w==
X-Gm-Message-State: AOJu0Yy4Sf4d3V2kHeZwoAGkIvM2ba7kp/Azdd5F+328ttdVT1ZUxZIb
 ykWfauVRyfxmh1NRw9cgZY9E7rDK/WMUbdKtjQ8AqGEVce/Pjg==
X-Google-Smtp-Source: AGHT+IEjTChTbZFx6NrUFlL7iiMBuu1DAAzWolBipCYrTCfN6EbHqgpYxjVytatzPCWAv9hu0jRGxQ2sSJ8gsKgTsJI=
X-Received: by 2002:a05:6512:6cd:b0:50e:7f56:bfaf with SMTP id
 u13-20020a05651206cd00b0050e7f56bfafmr1399365lff.129.1703674670962; Wed, 27
 Dec 2023 02:57:50 -0800 (PST)
MIME-Version: 1.0
References: <20231015024511.3995580-1-sjg@chromium.org>
 <20231015024511.3995580-2-sjg@chromium.org>
 <a22aa340-d355-45bc-a920-6b95f38a6364@gmx.de>
In-Reply-To: <a22aa340-d355-45bc-a920-6b95f38a6364@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 27 Dec 2023 12:57:15 +0200
Message-ID: <CAC_iWjJxex6BWG95SQC3ox4zA2u+5+8+s4mOkKHH2UGt1eK9-g@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] smbios: Refactor 32-bit code into an else statement
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
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

On Tue, 26 Dec 2023 at 12:46, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 10/15/23 04:45, Simon Glass wrote:
> > In preparation for adding support for SMBIOS3 move this code into an
> > else statement. There is no functional change.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
