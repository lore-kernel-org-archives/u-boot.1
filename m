Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF15C001B0
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 17:48:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AF7086384;
	Tue, 15 Aug 2023 19:48:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mvMqF27L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38EDD86776; Tue, 15 Aug 2023 19:48:28 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BCF7833BF
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 19:48:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhupesh.sharma@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-31965c94001so3217073f8f.3
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 10:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692121705; x=1692726505;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FhlR6LJIF9ptnLozq1J4CDYLMUP0xHlpuVBDMAkj46E=;
 b=mvMqF27LpumFdnDpXL+mjv0mMQ7VN1QI/l4dWjneZ5djelJVEGOjQxEeQWWw7Vs5Ht
 ng4ajIQdP/2LP85fzj9qzfuOzg0PMa2hUYlPiul6cuakLzEBK01n3hGh/e6CBy5ssfXX
 FMg6Fdcs9nFAbTzjJhZFs3kD8daEY7PYG3BcoJfRxK0fUmSzLtqvkzyCRycDFrC86b4g
 u6JHgATHANtWftGQb9gRS3H4Z6YM8UpPbjhsdTi6NtWexFe8KessXXri/NCYxdNANX8m
 MNUksaN1NurSPnfKOsIa2jhjvIBSlZcBkZ+cMcTeVDK4enjoVfdcJDlrTR8+y5gx7aOy
 3hRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692121705; x=1692726505;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FhlR6LJIF9ptnLozq1J4CDYLMUP0xHlpuVBDMAkj46E=;
 b=QBOJJ6NQUmwtK1d3IuHLXi7/jSmeXwH6pzLOmiGjySKoMeTFvhFlgUEq2yEocbvmSp
 pRwnNzx5A10x7lwRO8SfhZAZIpzilR1vV9q4QRnWC4YtBDMmehdDOZjTmajif0UWvbF4
 RzYXIBaBj1vUYWCGQhbqI2T8YFCZ17L5epxwA1j2XRbCRV7kQm9ORDLYjmETtIxWXCO4
 Z9r4WuNZTaefT5xZ8q4cJtLlvGUY9tCn5Hy3ZPbyiT+NO33fDdblZDwUN5sMoADtw15Q
 OSCOpgXR01txEg/xi9+mQR/djUzgatWPZr7Hk97ifHUw086gde1FPtSbySjXQNZXW5tv
 W/vA==
X-Gm-Message-State: AOJu0YwVpEmsA7ycYB7Nret1TwRK5skUwV8w77L11QD08SZjRfWzFyx1
 fitI6KccoeXrII4jDOJW6z7kaeKn2OzOxOG8G/pgKQ==
X-Google-Smtp-Source: AGHT+IEU1KtGEzaAwIgBU6AC0F0MgC8LnItkzvbleIy+VdqG5zIeN4VAHrRxlZSsrq6+/IhGF7p4E8LEurt+RvLj2KQ=
X-Received: by 2002:a5d:49cf:0:b0:317:5b1b:1a40 with SMTP id
 t15-20020a5d49cf000000b003175b1b1a40mr9975645wrs.49.1692121704968; Tue, 15
 Aug 2023 10:48:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230814215457.4075025-1-bhupesh.sharma@linaro.org>
 <20230814215457.4075025-18-bhupesh.sharma@linaro.org>
 <d4b2b0f9-6231-6087-a06f-df7f059a80e5@mailbox.org>
In-Reply-To: <d4b2b0f9-6231-6087-a06f-df7f059a80e5@mailbox.org>
From: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date: Tue, 15 Aug 2023 23:18:13 +0530
Message-ID: <CAH=2Ntw_4sJYy_ehbQ2ZL6GMd6bbFcAO9pJBWRrmqMjKNehSwg@mail.gmail.com>
Subject: Re: [PATCH 17/17] MAINTAINERS: Update UFS maintainer
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com, 
 bhupesh.linux@gmail.com, marek.vasut+renesas@mailbox.org, 
 sumit.garg@linaro.org, rfried.dev@gmail.com, patrice.chotard@foss.st.com, 
 jbx6244@gmail.com, kever.yang@rock-chips.com, eugen.hristev@collabora.com, 
 "vigneshr@ti.com" <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
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

On Tue, 15 Aug 2023 at 04:01, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 8/14/23 23:54, Bhupesh Sharma wrote:
> > Since Faiz Abbas's email ID is no longer valid,
> > drop him from UFS Maintainer list.
> >
> > Since I am using the UFS framework now extensively
> > on Qualcomm Snapdragon SoCs, so proposing myself as
> > the new UFS maintainer.
> >
> > I have also been sending out u-boot UFS fixes in the
> > recent past.
> >
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>
> I believe TI is working on something here, so please coordinate with them.

Ok, well I haven't seen any reply to my earlier UFS fix related emails
from TI, so I thought maybe no one is actively looking into this area.
But I would love to hear from TI on the same..

Anyways since I will be working on the Qualcomm UFS glue layer going
forward, I can propose to either be a UFS maintainer or a reviewer for
now to make sure that the subsystem patches are reviewed and tested .

Thanks,
Bhupesh
