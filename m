Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E424C5321D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 17:58:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 979F988A12;
	Mon, 26 Aug 2024 19:58:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eCRCmRw/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB77D88981; Mon, 26 Aug 2024 19:58:22 +0200 (CEST)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A3CE884CA
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 19:58:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7a20b8fa6dcso304410885a.3
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 10:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724695099; x=1725299899; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q4hlTfqmAdwb42SCFEalbAYz/q6cBkEKXnB9EbM3Eh8=;
 b=eCRCmRw/MPZ1EXB9PcMB8P30Zo101kxd+Ty317VuAd2Dpi4oRsxYhgHRDxA53qdRCw
 YQibYmxRQ9r03Ch2aP5FoM+Z/9Yjc4VAscFlqMGvRHpTND8nJO//gv9R1afA3crpHgFx
 gBTxo5UtOkcz37Di3L1SAZ9xkpNpXAzjDAulA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724695099; x=1725299899;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q4hlTfqmAdwb42SCFEalbAYz/q6cBkEKXnB9EbM3Eh8=;
 b=b+O2vxfoHHblBoArm7u7zE2fYuV5oMOnyVZW4C3lQsR/hy3nbQ5+LeR1VLrOfPqj5B
 GfqGKBnh/xe/XT5UpCTFLoiJrZ32RqR/2DNnvCUdmCgGIS43uFXtjCA3Q1H+u4yy51bJ
 021VG9ShyinoT1haK2mC/jB4WKSX5pp9Oo9z+zu8Q87co1d4eXX9IJqVyYQKmAj1vnCl
 V+cu1ftamg6nOEog1SwQtRABMssDjkkFoP0IEXRr0McqD2EIstOTb8EMzE/dwBh9gdKE
 LM/88+eUFnIbyumIWRiv3dDXA//to4RlGafaLx3dDyFz9EURzYPjG8daU7hlE7Cgafx1
 uVnA==
X-Gm-Message-State: AOJu0YzT8qx7CetejvgjaNonrPjrGrt7YRzmDCjzhCTKvBDg2Ez6zR5w
 ya4Q4YDz15Hxsra33slX2p4nQlqk2IkomOsLN7PbSV8jTbWj+ZLdusFzERCXLbqmnrraDC4kTUg
 9NbOZbq0tUV5t1LrnPFVjtc7RTA0Qrd/A3MuesG8y79hsad8=
X-Google-Smtp-Source: AGHT+IE832ny/NJspqtIQ9RdpWv/DHJNWgRI9FAZTm2m27SaK9+c3j4Do1gBvXkRH9oAWDJXqQtNRFo92mZ+HNQN20s=
X-Received: by 2002:a05:6214:2f0c:b0:6c3:2a41:cc14 with SMTP id
 6a1803df08f44-6c32a41cc79mr10279576d6.0.1724695099088; Mon, 26 Aug 2024
 10:58:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240815202424.766778-1-sjg@chromium.org>
 <20240815202424.766778-12-sjg@chromium.org>
 <CAC_iWjL4kkSzX6YEv63gBJk9ruwBCRP+_NFATtBPgk7u3Xa=Yg@mail.gmail.com>
In-Reply-To: <CAC_iWjL4kkSzX6YEv63gBJk9ruwBCRP+_NFATtBPgk7u3Xa=Yg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 26 Aug 2024 11:58:08 -0600
Message-ID: <CAFLszTiDKs5GQwoqOjjLMe-kyGBY=utCAi6+cpykxHmd0iKUxA@mail.gmail.com>
Subject: Re: [PATCH v4 11/14] efi_loader: Add a test app
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
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

Hi Ilias,

On Mon, 26 Aug 2024 at 05:17, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Thu, 15 Aug 2024 at 23:24, Simon Glass <sjg@chromium.org> wrote:
> >
> > Add a simple app to use for testing. This is intended to do whatever it
> > needs to for testing purposes. For now it just prints a message and
> > exits boot services.
>
> We have tests in py and efi selftests, can you explain why you need
> another EFI app?
> I'd rather skip this and add it when needed

Well, I originally hacked the hello-world app but you and Heinrich
both asked for a new one[1].

It does something strange in that it exits boot services, then exits
back to sandbox, so that I can test that the EBS doesn't do anything
odd. It was causing a hang booting Ubuntu due to a bug I later fixed.

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/patch/20231121113557.800353-7-sjg@chromium.org/
