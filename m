Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F98FEE4993
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 19:15:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79BE787094;
	Mon, 21 Aug 2023 21:13:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="YlO3/hBm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3292C80770; Mon, 21 Aug 2023 21:13:54 +0200 (CEST)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96AF1871CA
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 21:13:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-d7225259f52so3832014276.0
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 12:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1692645213; x=1693250013;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HKxBms1ZPr8kP4GP+nLSTF20h7US2qEv6KZ3iMNF4PY=;
 b=YlO3/hBm4FsvmVKVa2ZQLac50pAVqibnyQm9WrWE+gUBLyJC6611pEH1lC5pLXxSvy
 8bAavGXAgSwWAdYeS5cDkArgTs0Me+25DhepxLvicFfE2qajCZKe2Lb9BStFwnREMlHW
 gZi685mGmdRckU+CZKSbKvYzqlW9fcUhv3s59vDJP+sCclUhWzZdmzlG46Y8kZrUZoUA
 ytd71DyJ5dJqHPZXW2QFtVSC9P0yL2zaH5QDffCZBTqZeHVqLwWLayf0GyWxriIneQy0
 g6CVE6/jKZDeWMfon86nuUdrhUmyuKg8QQINj6hQ86Ui/w0RvgxhNR9jSlzmIKWcNM6h
 skfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692645213; x=1693250013;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HKxBms1ZPr8kP4GP+nLSTF20h7US2qEv6KZ3iMNF4PY=;
 b=GorGTYNfJ076UnAvG/AsGBZaFNPvu1vjw0NbcwP8f+UC+HZX2kQeBuy1y3yfqG3FI9
 V6xO/IY+JYMc8f2ak72y8b8sD6++tNOsqXhR9720yq3qcO/6nga/jDuTnZU0tYYNie+8
 1nwWfkCZ8ANYay4VBqHZPUAPnb7Cpk2GhakhGt0U9N/HnIvZZpf1YuQYbTJX5omijXZC
 c/BW2qlw4AF3kvo8BjU8dbAkmC5843HJ+OoyGdBEGhP7LOhLWvCm3JonYKr/fkK6Qtm0
 szrOFpRTmtvQekpToxPT1ixgCGgHFkyTNwJEwOW0DSwB6sQSVX84riKvkbdxO8pC/AiP
 9sYQ==
X-Gm-Message-State: AOJu0YxsPGK0NwENg5/nQsY/3ggptaySzl9ArsjbWkLct/WS6Q9IuvBt
 cKuk01g4IgR7Syn6MnMLv3RD926xYMQk/xuemxBg7Q==
X-Google-Smtp-Source: AGHT+IFhWqpdw4VkA78VQ2dzGPcgT2w1tWfpKTOoA7RO27/R3Sua3HcVTXKcFKDLvD74aLcpuiH9P6QE5QTUTRkVdic=
X-Received: by 2002:a25:2693:0:b0:d6e:3544:9874 with SMTP id
 m141-20020a252693000000b00d6e35449874mr7386484ybm.58.1692645213120; Mon, 21
 Aug 2023 12:13:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230706112020.24528-1-avromanov@sberdevices.ru>
 <20230706112020.24528-2-avromanov@sberdevices.ru>
 <CAPnjgZ1AqUYxAU0BNhxZLXc+y_h5XKbuoLBDekbkqzaJeon-1Q@mail.gmail.com>
 <20230707084313.vecmsr5z3aj4gqxs@cab-wsm-0029881>
 <CAPnjgZ3Wfnc_rMJBVZTv_eikUu7vpPWsL1MQ_SruXySV9EZi3A@mail.gmail.com>
 <20230710083443.fuw74gbvwoha75ab@cab-wsm-0029881>
 <CAPnjgZ1aZsFBaX2eBh35CXVExaE90YJHQ98S+2XOWJrJ9pz37w@mail.gmail.com>
 <20230711102459.phpyem2ehlya7osz@cab-wsm-0029881.sigma.sbrf.ru>
 <CAPnjgZ2t2xf05PSgCbQr7MUvJrpQPcRs_Zoux804h4UmTrZRKw@mail.gmail.com>
 <ZLDdaIyXjp9yN5aW@laputa>
 <CAPnjgZ3oQ1qZtWFpezNfV-dZhbCrnqbi1+B=JKb1sfJP6xk-cA@mail.gmail.com>
 <6303961e-3edc-4356-905b-89820a52b227@linaro.org>
In-Reply-To: <6303961e-3edc-4356-905b-89820a52b227@linaro.org>
From: Simon Glass <sjg@google.com>
Date: Mon, 21 Aug 2023 13:11:58 -0600
Message-ID: <CAPnjgZ2GA7ktNi9HVJ1Mw=4nuqcQJALVBqHQr1_JtVmkzEVgdw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] drivers: firmware: introduce Meson Secure Monitor
 driver
To: neil.armstrong@linaro.org
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Alexey Romanov <AVRomanov@sberdevices.ru>, 
 "narmstrong@baylibre.com" <narmstrong@baylibre.com>, 
 "u-boot-amlogic@groups.io" <u-boot-amlogic@groups.io>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 kernel <kernel@sberdevices.ru>
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

Hi Neil,

On Mon, 21 Aug 2023 at 03:16, neil.armstrong@linaro.org
<neil.armstrong@linaro.org> wrote:
>
> Hi,
>
> On 16/07/2023 01:40, Simon Glass wrote:
> > Hi,
> >
> > On Thu, 13 Jul 2023 at 23:30, AKASHI Takahiro
> > <takahiro.akashi@linaro.org> wrote:
> >>
> >> On Tue, Jul 11, 2023 at 01:13:29PM -0600, Simon Glass wrote:
> >>> +AKASHI Takahiro
> >>
> >> Me?
> >
> > Yes, I'm asking for your help to try to clean this stuff up.
>
> The thread is long and hard to answer directly, but as AKASHI
> said there's no point to add a SMC class since it's only the message
> passing instruction, and there's no point using remoteproc since the
> firmware runs on a separate secure state of the same CPU.
>
> And I don't see how we can actually define a finite set of ops because
> none of the secure firmware interfaces has even similar functions.
>
> So a new UCLASS for each firmware interface should be added, not sure
> this is scalable or required since those firmwares are mainly SoC or
> vendor specific, except the PSCI or other ARM specific interfaces of course.
>
> So I think UCLASS_FIRMWARE is good enough since it avoids using UCLASS_MISC,
> but it should be probably documented somewhere that the ops are implementation
> defined.

Yes it needs docs...but what exactly is the 'firmware' uclass? I
assumed it was for loading firmware into a device, but it seems that
it is something else?

Perhaps we should have a UCLASS_SVC (supervisor call) or something
like that, rather than continuing with firmware?

[..]

Regards,
Simon
