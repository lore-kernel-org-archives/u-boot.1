Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C30E5CD54A7
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 08:27:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F192086AA4;
	Tue, 19 Sep 2023 10:27:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EcxDJEe7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83C6586A49; Tue, 19 Sep 2023 10:27:42 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 272BE86AA4
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 10:27:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9aa0495f9cfso1409202466b.1
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 01:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695112059; x=1695716859; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t2daEt1xeSGgz1s4ASFdxURRDBVVg4GqkurQSKpG1Hc=;
 b=EcxDJEe7JzsZBPttYeBwKShnkhEdKZRtcDAKUWK7Jddc2HCvlTGEuEjKW5KE6XEygr
 38qh1jP0dpe/3KwkSZhtwhx5UJZHsftozZQHihTvtJTxUqRQ19Jzy7k7G/ef8g38H8Ww
 9YYeIMUbZU/lzkVmB47YLMbc4DwYVy7N/tckPjmp3PgCs1u87axaFOeSx/1BM0MArslk
 y4UoxAWp49ZT2tDzz9YL2dfqDj0edQk/o8J0IHdk2A5MTPSS2V6xQHIkTFJw6oY7fSMj
 epPKeOZXEs3hjrusWVVrkgMsjGbkpr01Tp8s2EZJDCU2K5QAhxU+1HAnSUj6o9dzeEAH
 3ZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695112059; x=1695716859;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t2daEt1xeSGgz1s4ASFdxURRDBVVg4GqkurQSKpG1Hc=;
 b=pEDg72LKDbPyLs1L1FMvjyzOwn6aixOC+PYR9zIwKj8hU4PIHkWry59rals6k2XSXp
 wlP/4YBMaDkvTs8VJafDbLSaZGBX9su8Gvfm0Tp54WlQ8s6ht3jaroVy4ER8ApA0zyzw
 oX+mLOdjBSMS6ExotS1VqNd6elkjznh+M+COgMYbVYJYTjSepN5tjAFWQLeDJM7DGA2C
 V2kVFoGnz3RhV4aPqhILxp4Yivl8H06Kb5pHwOOOl2+JDC1lQMXu9oKRXh2hR764IVxi
 dWkqb1x6O3d+tcEkk+ktId00c/12hFi5FAQKPi13K05v8Ji/RQ4UTno0K2B0FxG4KWYF
 N0zw==
X-Gm-Message-State: AOJu0YwfyeO11P1HmvFjgjV3blsBCLjNlj93qidphx1uVB6oV3tI3PxE
 A21CG1iqzKk8jfo+qkj7AdOR+rQc6QavIu6SQf0=
X-Google-Smtp-Source: AGHT+IGgFJ1NuN7zynIyGh46NYk1HINOhVg3AbtWskS+xTu7diFf8omuGj7FLxQTX9XeIS8DU+dgmc6VASTz2RK4kY4=
X-Received: by 2002:a17:907:7ba9:b0:9ad:e15a:f9d3 with SMTP id
 ne41-20020a1709077ba900b009ade15af9d3mr2624284ejc.36.1695112059658; Tue, 19
 Sep 2023 01:27:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230907155825.48056-1-sjg@chromium.org>
 <20230907155825.48056-9-sjg@chromium.org>
In-Reply-To: <20230907155825.48056-9-sjg@chromium.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 19 Sep 2023 16:27:27 +0800
Message-ID: <CAEUhbmXzgVm-rWFA5j+=wpZoJzCrzi9VBJU-WTP_KNgNrrwAdA@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] x86: dm: Mark driver model as dead when disabling
 CAR
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>, 
 Pavel Herrmann <morpheus.ibis@gmail.com>
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

On Thu, Sep 7, 2023 at 11:58=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> When turning off CAR, set the flag to make sure that nothing tries to use
> driver model in SPL before jumping to U-Bot proper, since its tables are
> in CAR.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v2:
> - Add new patch to mark driver model as dead when disabling CAR
>
>  arch/x86/lib/spl.c | 3 +++
>  1 file changed, 3 insertions(+)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
