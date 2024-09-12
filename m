Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F8BEE57F6
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 01:05:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF42E88E50;
	Thu, 12 Sep 2024 03:01:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="l+andF2L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 932D688E45; Thu, 12 Sep 2024 03:01:57 +0200 (CEST)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EBC488D09
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 03:01:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2d89229ac81so355600a91.0
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 18:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726102914; x=1726707714; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PylSVl+kN3wTQaC+Bwgq0gTCooV0FA4ICleB6rt8PHg=;
 b=l+andF2Lcxz6FDawCPSDbJo4CUUV5RqSKJoRJ/1bCTHZ/XuSXaEF2f+NoThcuSpoHx
 GYiJhWR54Biyxe0t0Z8VzH+lgCOKEwswcsgq1rUa/o4GW+QYh8oxQdcWjr62bAAQmuSu
 EpUbU9bUlC9D2ABBKLsQvEbM9AC/hSlQ/7rCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726102914; x=1726707714;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PylSVl+kN3wTQaC+Bwgq0gTCooV0FA4ICleB6rt8PHg=;
 b=ghtu9X08ARrLSGOxGcnC4HYxYXbT/5fq5J0uFpmp5RH8bgsSx3KKAd+Z/02ZbZUgFU
 nXJSgphgtbrSXNyhQxIKLbuHsx+Bo3cjnEqzOO79DGauUxFHa+RZgfJ3CgQP6QXQizOq
 9u7ZtVFEXddXMHp1JpZA+tNuP+Gf2SrKq+U8r2ZzT4da3wKjcd/c7ql5d8J71vELMCBW
 cHMWmxKEHVBQBY0iI9cDVdPKeifGFw0Wu0YEHgwVRebddF4jEtjGTKM/eYndysw+Ty+J
 JOvSt/ChL+y3LklQgnGPMr3NLATsxUvMvqZBIEqUK/H5Dt7a3mqhfnRf2f+8cWw5ZaP9
 /j8g==
X-Gm-Message-State: AOJu0YzS7lrOZFU+YFftH7bqmqDTsR8+OIsCV5Zj+QyWMB493WQoCtMN
 XdW7svoH+SIWFMvWuByjNWJNKKWIUVOqx18ubWcrmVbc9++B5pm4L+d8EdPQ/0y2Ttzj/ILuZW9
 r0h303zxpwa4R1LFO/qIlwWpjY/wAcQzjnVni7cx4AglPvCM=
X-Google-Smtp-Source: AGHT+IGKeKSWbjjT6EXBvb1mivkpt0oVA0u2kY/sTgckIa1o7iP3zUPal4cEMjRGcO1qY9XJuLjiEO5fTQCZb5ZqJdI=
X-Received: by 2002:a17:90a:ab0b:b0:2d8:97b7:449f with SMTP id
 98e67ed59e1d1-2dba0065e20mr1272008a91.38.1726102913823; Wed, 11 Sep 2024
 18:01:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAHWDVAm=nKWzKEa4nTc--ZZ-CAQaqso3MK48pGeK7_BUMvuqhg@mail.gmail.com>
In-Reply-To: <CAHWDVAm=nKWzKEa4nTc--ZZ-CAQaqso3MK48pGeK7_BUMvuqhg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 19:01:39 -0600
Message-ID: <CAFLszTjhd=Aa=r64CJcaCGoGhQsFba0tuFvNoYr_9C-rUPOFRw@mail.gmail.com>
Subject: Re: fit signing without access to private key
To: Mikael Pahmp <mikael.pahmp@gmail.com>
Cc: u-boot@lists.denx.de
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

Hi Mikael,

On Fri, 6 Sept 2024 at 11:06, Mikael Pahmp <mikael.pahmp@gmail.com> wrote:
>
> Hi. We want to sign fitImages but our company policies does not allow
> access to the private signing key from our build machines. Is there a way
> using e.g. mkimage to
>
>    1. Generate the hash of a fitImage configuration section?
>    We will then request a signature for the hash from our enterprise PKI.
>    2. Incorporate the signature in the fitImage?

There is not, but it would be a useful feature. Let me know if you
would like some pointers for how to implement this.

Regards,
Simon

>
> BR / Mikael
