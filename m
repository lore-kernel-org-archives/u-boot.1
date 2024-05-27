Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C6EC25B74
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 09:44:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED0AF87F8E;
	Mon, 27 May 2024 11:44:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PDfPeQJV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89CDF8808A; Mon, 27 May 2024 11:44:51 +0200 (CEST)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D7F087DCA
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 11:44:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6f8ecafd28cso2419481b3a.3
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 02:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716803088; x=1717407888; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7hW7nGjbMTFf9GUas/sCBf8rDDq8/SNsM43+0viab5s=;
 b=PDfPeQJVxs8V2W/9cI8GVfyIqA4egkUw5jMEwLIZxuN6C5ZVKL7onMZucl5ll654dX
 nHNqwquNPjAmiOmUG99e/sdKZEBrUtzto6MDIVU82X/UyDtkZIzlZXZr0DNDXBM/f5ZN
 at1pWFQVmqDGaU8MN7xJbuWsj1Svi8DwnZKlMS61WRplR/AM50LHJj0XPCP1Hj9UgElS
 uJiSImn6X8SU19RGi+IZXvwizzTZjvEKyUXIKrE0+70+GbHIkq+GKfWsS0DHVgCQG5ki
 adTfg42oo2iSVGBHYVR/nkwec53ypEv7uSdtb3ctkVRPnm74Z8tJCdqVxNwA5ulFAx5k
 c3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716803088; x=1717407888;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7hW7nGjbMTFf9GUas/sCBf8rDDq8/SNsM43+0viab5s=;
 b=SYjKqar0UGY3sYX8rpc40q+BhsyVpNkAdbXGT9KmiCyFSuIot1qfzl0b05r+6uKNI9
 F4/hC34U2zOo516m7BQEG4ikhd/EaK9TKv9kom0H3noiRWuAq/QJTrLg7yynGI9249Np
 aTiy2bWW1ZSObF9X7VKtDcDKFzQ4iBM6OEH2+RGFHc0qVHEgOazfnC/O6D3SVtLm9AUI
 CIAmV7/KNg5YfoIsNPCdHPeWWHkQKnCVtc3f0VPNORoXYnTFYrlR5hNzrqLV/ixUuy/V
 2izpQPscnhbA+q1nl0KN5TljhCQJosU6VRGSHhmtmkqlXiSyRMDw22l/Td7Vc7H8pKMD
 dhTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUclaCFoWBsfUbLVRzb/y486IBCNxX+RVzXtRXXJs5hY6naMVYeYtrcNTbf7x8xTk2v8T+wV/W48aEi4niorSf/gBAn8w==
X-Gm-Message-State: AOJu0YwgiTncZKESZBvbKxr+AoWvwsDGwYcIyJLSQvCSxqf3DccY9NBm
 U0pV0f23C90tWM2zcgUlIjovi+xLBiNbfUMsXFaYRFnqV7RowBXAFp8RqQIPhK4VuAn/su/ZgJT
 U3gOq9TP7e9GB/1zdOn9UF6KeHqukVSW46sTO6g==
X-Google-Smtp-Source: AGHT+IGoC53DlKsXLvYUnZQg2jCJ5aF4abC2EJdZqCaWwkAqOIPyyFUEeNgVrHn3IvE6iZouUdvl7iSnScoqLyUFfAk=
X-Received: by 2002:a05:6a00:8013:b0:6f8:cbfb:3ba9 with SMTP id
 d2e1a72fcca58-6f8f2d6e2e8mr9649588b3a.12.1716803087685; Mon, 27 May 2024
 02:44:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240525200049.3904124-1-tharvey@gateworks.com>
 <20240525200049.3904124-2-tharvey@gateworks.com>
 <20240527105910.3bb425d1@xps-13>
In-Reply-To: <20240527105910.3bb425d1@xps-13>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 27 May 2024 12:44:11 +0300
Message-ID: <CAC_iWjKGijjMXoop2i97Rpc+ZzSWWb6Vbd9XxW9WKqvcRwJwhQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] tpm-v2: allow algorithm name to be configured for
 pcr_read and pcr_extend
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de, 
 Jorge Ramirez-Ortiz <jorge@foundries.io>, Adam Ford <aford173@gmail.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Miquel

On Mon, 27 May 2024 at 11:59, Miquel Raynal <miquel.raynal@bootlin.com> wro=
te:
>
> Hi Tim,
>
> tharvey@gateworks.com wrote on Sat, 25 May 2024 13:00:49 -0700:
>
> > For pcr_read and pcr_extend commands allow the digest algorithm to be
> > specified by an additional argument. If not specified it will default t=
o
> > SHA256 for backwards compatibility.
> >
> > Additionally update test_tpm2.py for the changes in output in pcr_read
> > which now shows the algo and algo length in the output.
> >
> > A follow-on to this could be to extend all PCR banks with the detected
> > algo when the <digest_algo> argument is 'auto'.
> >
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> LGTM,
>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks for taking the time, unfortunately I've already queued these
for Tom and your r-b is missing

Thanks
/Ilias
>
> Thanks,
> Miqu=C3=A8l
