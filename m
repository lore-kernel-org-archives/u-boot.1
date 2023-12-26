Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48156C46CD4
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 09:53:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF27987950;
	Tue, 26 Dec 2023 10:50:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aY9voHKc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44E7C878D1; Tue, 26 Dec 2023 10:50:25 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E201D878F1
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 10:50:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-781590ae919so11336485a.3
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 01:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703584221; x=1704189021; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jsMtdlMBjpViAVuBfr/nkmiuUhxMbG42+zQM6oAIw0s=;
 b=aY9voHKc+A0Ctzc8NBhja8D6p3BKOfAuMvKN4S3QSkvxz0rBUkLKgvHGezypbDTIux
 ILxT/7C+/7o3nEmfZ3aP/bqtS5CwgMstFvXyMMhg+2ZRJ2dKLAiyf/lRjRqFrDh7L+i2
 ID+cIY7P7RFEbiOwit5cdOCBErOiUsVSXiiJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703584221; x=1704189021;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jsMtdlMBjpViAVuBfr/nkmiuUhxMbG42+zQM6oAIw0s=;
 b=JdzjMNn8ssHeBtWfs2Aotd5TxBWr1C70ACXo7dOP8kRmBNKWdUvBwX681AHBug0F1J
 6ox0uKHUhOzZejK58Dh7Ob4Ms7jdT7ZSey2Qntjn5Irh0AIoAHvoAgwllkmEZG+Au/qI
 H+PcvlPuPaQuGz+VeEt8gzHF1pn3OfRRVstaoHIVybqWU6Nfy1+hjTJiQ8AzNjKF7Om0
 SJ7oBReKEbC5lDBMoWgMQuEDtgAxmDil29NOsAmjWy2MuBGU1GiA9B4XQ8dlMiVisJCc
 /tGDWc8w44WxDYon14GlM2qQD54C+mYutsKX2swiVgMg6J61jJlv/4iKYPJ6TSsSFa4t
 s/1g==
X-Gm-Message-State: AOJu0Yz1PN0SiFg0YtYYtutfPrA0z5KP0cGHN8rZ0S+GALxdYV8bv6/j
 HFf3AdXDyHHeeTAmNpD4GrPgmcKbIMqPNsAQIr8hWsIl091A
X-Google-Smtp-Source: AGHT+IEgGZ4HFGrnzz/orsjBKivx8laqvu3y2E77AhSPqbssNJx3B9RhWmnEPyoaNOGVueaqkGFOJXYNjDhK9hn31YY=
X-Received: by 2002:a05:620a:260a:b0:781:29c1:d43f with SMTP id
 z10-20020a05620a260a00b0078129c1d43fmr8892404qko.13.1703584221673; Tue, 26
 Dec 2023 01:50:21 -0800 (PST)
MIME-Version: 1.0
References: <BYAPR15MB25515376B1F7B285D2DFD39B9A82A@BYAPR15MB2551.namprd15.prod.outlook.com>
 <BYAPR15MB255153EBB2B6240B31E1E5849A8BA@BYAPR15MB2551.namprd15.prod.outlook.com>
In-Reply-To: <BYAPR15MB255153EBB2B6240B31E1E5849A8BA@BYAPR15MB2551.namprd15.prod.outlook.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Dec 2023 09:50:09 +0000
Message-ID: <CAFLszThxDY3EwOWDNVhkYWDKShB6YGXTdZhAv8WGhHma7pgsOg@mail.gmail.com>
Subject: Re: Fw: Upgrade u-boot to use a redundant environment
To: "Hernot, Adrien" <adrien.hernot@zoetis.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

Hi Adrien,

On Thu, Dec 7, 2023 at 12:53=E2=80=AFPM Hernot, Adrien <adrien.hernot@zoeti=
s.com> wrote:
>
>
> Hi,
>
> We are using u-boot and until now we are using a single env storage on th=
e eMMC.
>
> We want to change to using a redundant environment, and the way to do tha=
t is well documented (thanks for that).
>
> The problem we are facing is transitioning from one single to redundant, =
as the format of the env storage is different (redund has one byte flags ri=
ght ater the 4 bytes CRC, at offset 4).
> After the updating the u-boot binary and restarting the machine, u-boot C=
RC check will fail and all environment will be lost, due to the format chan=
ge.
>
> What is the ussual way to deal with this?
> Is there a tool to upgrade the environment blob format?

I am not sure about that. If you can suggest a solution you could send
a patch to code or docs?

Regards,
Simon
