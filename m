Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F5CC41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 15:46:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EAB8877BC;
	Fri, 22 Dec 2023 16:46:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lmcYZini";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37D3787874; Fri, 22 Dec 2023 16:46:50 +0100 (CET)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1832A877B7
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 16:46:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-50e60d67e6aso1622678e87.1
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 07:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703260007; x=1703864807; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1yk9cQ3S/QGUsIeAuijQk9a6H2ndFylho/aoi7+Sl1Y=;
 b=lmcYZinivBgXtIdr9n6eWNWruNyz+h+6kIaIjVsa6F29jKxsLuwIKbnLU6/sm0F9+q
 Ix87EG+oSu8XMBjvjDXLVvzg7KxvM5RT+TpUDkqhjZQi1zKKvErAXuhqYjJYjB8lJUWg
 lG2dhiVmZCRI4RqwGv+SSFA37R96YewDcU5DVm0CmjlzM4Twb6Fb8fiQahXmBu7YSKUC
 3df2XWlRFB1eeW6qQ4zETNTXDqe8DgZS8mWp2YP+TgTOZFXi+gCYP2Lg6vmlnUwGn2oa
 9AV+CNqJ7+8xA8WeTDymT3ySQqtGsadSd1UWO629bj7WWa9Kf4wvl69PK+sO5NXHwRYl
 0gsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703260007; x=1703864807;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1yk9cQ3S/QGUsIeAuijQk9a6H2ndFylho/aoi7+Sl1Y=;
 b=CN44uCgWIp3MIEzupr740ZFiQwwGZkCwAy+8SBhk8eNmA0MQwfskGk6Tx4opOC2wWU
 VxGWzptnDMXjVzMd+50K+ePjbkaf4dq56RAjO7Kx6n8yv17FXVFq1eEOYfl5DSNNiZzs
 pj2VEeWtTNychlrAF/l91OO3y/dpP1Wo4GC6Oyt2C6mX+leqviE9/bg5d9nDucxymr4H
 tZ7XE+1ewc1noQ3mOxs4u6+8wps2ZKFezumX6KQBe4v+Ufkc2vA4K6x+Y/Zvxr3TViYU
 rApwk0z5+XTJKqVMfyxSwOOJLC5fe1DR8+TuS8umxOnhJgEfTNF+1S6sUjDvnH9Wfns3
 7qrQ==
X-Gm-Message-State: AOJu0YwuVPhE2CuXqqgVsDhQeffiyRckH1gSyOuSQwnvwA3EcEY8ei9u
 q5MFMjnZhDdmePjGrA4a0CCZbbSH/bScmv4VjX5rbBF3WW9V3g==
X-Google-Smtp-Source: AGHT+IEiqEDK0uBvTJuRa/FLWwyXkpgBEZcwQnGmJoHlQTFID3bg7/ksR1TEMuAXXpNbeWUuIZhjCwzhnvQoE4AVdvo=
X-Received: by 2002:a05:6512:23a2:b0:50b:f231:d444 with SMTP id
 c34-20020a05651223a200b0050bf231d444mr1242502lfv.7.1703260007337; Fri, 22 Dec
 2023 07:46:47 -0800 (PST)
MIME-Version: 1.0
References: <20231222150156.39783-1-xypron.glpk@gmx.de>
 <170325942760.2653128.4640507980296072811.b4-ty@konsulko.com>
 <CALeDE9PwPsxKQx5j_embNv_4NwXSt68Mo7apBPwDOWdApPA=mw@mail.gmail.com>
In-Reply-To: <CALeDE9PwPsxKQx5j_embNv_4NwXSt68Mo7apBPwDOWdApPA=mw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 22 Dec 2023 17:46:11 +0200
Message-ID: <CAC_iWjJTRZV9_n1-j93y=aMwQhhUgvx7N56n9d+-p1aPb3W+Aw@mail.gmail.com>
Subject: Re: [PATCH 1/1] bootmeth: pass size to efi_binary_run()
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, u-boot@lists.denx.de
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

On Fri, 22 Dec 2023 at 17:43, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> On Fri, Dec 22, 2023 at 3:37=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Fri, 22 Dec 2023 16:01:56 +0100, Heinrich Schuchardt wrote:
> >
> > > If we call efi_binary_run() with size parameter set to zero, we get a=
n error
> > >
> > >      Not a PE-COFF file
> > >
> > > Fill the missing value.
> > >
> > >
> > > [...]
> >
> > Applied to u-boot/next, thanks!
>
> Is this a fix that should land for 2024.01?

I was about to ask the same. I think it should go into -master as well

Thanks
/Ilias
