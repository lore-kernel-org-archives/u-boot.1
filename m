Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5872C10DCE
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 00:53:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A46A2878A9;
	Tue,  5 Dec 2023 01:53:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Mo8KWUct";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 441E387888; Tue,  5 Dec 2023 01:53:01 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12A3587888
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 01:52:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5cfc3a48ab2so53904297b3.0
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 16:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701737576; x=1702342376; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bqV5UPtBSaYiz228Uto9Vw4zeWUZv/cN8hiN4gdjEdA=;
 b=Mo8KWUctrgkYNaJFoBhIrwr2PSWSk6prh+hPkF/pX45yPSw72suFvffduHmiOaY03b
 ZN1iqqTpaG47Y0ap4hh0/w1218a3Q1NIIgXO2fh0IrpwFCiW5xCUQ0DRUx35/iRwe7Ps
 crnZs7Mqi5/2Gshj91z3f1J/Jd15ZpsdvmTo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701737576; x=1702342376;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bqV5UPtBSaYiz228Uto9Vw4zeWUZv/cN8hiN4gdjEdA=;
 b=a4wPH+inRj2Y6Ir4eZNBvCHO0RSwZowCZP1CXDO1UpGlp41H/HXhJMF3phVz2mbBfW
 FA38Hpw7PbP0PYp4mfhK9sRy30nkAm5/q33+6DqWHGHAWSaysdb+QdRto70vxFSmedZf
 dz1qDIIXuygpfDNDk2teGA6rU/8vrUdxy7Wuo+qDfR6foYhWZ7lZoPdgwSGo9IMhC1WF
 wcRyGDmxODXaOpnYn5lOByDHEnbDK/gDlQP07yJ6PFkLQFKl+M72nNCYs7r3ZKQXg7R+
 nfspTQPf/qL2ds1k2zhEt4MfLj5z9EpP+8LK3wI8YoEhcLzt7ttZqJKcL633ePL+VHZQ
 cmoQ==
X-Gm-Message-State: AOJu0YzGybBfqnTS99vV5K5aHSb0i/QJ4pGIv8kczekUYsdvJ1OUR+pN
 8PpTrS6FMDOT1J2cdaF6APUVwlq3m1/FeuYElA08Pw==
X-Google-Smtp-Source: AGHT+IG1rtPn2Hto2Hpfht3DrkFdO7RBq5gwkZfIjNyG7sAc+OMqjqkPQKnD7eoKziwu9runptRqnvzpAH68eZTnwRA=
X-Received: by 2002:a81:a009:0:b0:5d7:1941:ace with SMTP id
 x9-20020a81a009000000b005d719410acemr3861292ywg.105.1701737575583; Mon, 04
 Dec 2023 16:52:55 -0800 (PST)
MIME-Version: 1.0
References: <20231127195029.90951-1-raymond.mao@linaro.org>
 <20231127195029.90951-19-raymond.mao@linaro.org>
 <CAPnjgZ0yJNrpSV7dxmJky_QynEmPQQv5mTXT9MRTdn8rhVxpEg@mail.gmail.com>
 <CAEfUkULhw2SBEgWmijHtorKvQRmhV0q2Mf4MBd+vLyzJnW0fmw@mail.gmail.com>
In-Reply-To: <CAEfUkULhw2SBEgWmijHtorKvQRmhV0q2Mf4MBd+vLyzJnW0fmw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 Dec 2023 17:52:11 -0700
Message-ID: <CAPnjgZ1kwSSsQB8nBs5qPzQtvvVqb8vj02zif6CXY0N36VB0cg@mail.gmail.com>
Subject: Re: [PATCH v2 18/18] bloblist: Load the bloblist from the previous
 loader
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, 
 Bin Meng <bmeng.cn@gmail.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Nikhil M Jain <n-jain1@ti.com>, Baruch Siach <baruch@tkos.co.il>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michal Simek <michal.simek@amd.com>,
 Stefan Roese <sr@denx.de>, Sean Anderson <seanga2@gmail.com>
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

Hi Raymond,

On Mon, 4 Dec 2023 at 13:21, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Hi Simon,
>
> On Sat, 2 Dec 2023 at 13:32, Simon Glass <sjg@chromium.org> wrote:
>>
>> Hi Raymond,
>>
>> On Mon, 27 Nov 2023 at 12:53, Raymond Mao <raymond.mao@linaro.org> wrote:
>> >
>> > During bloblist initialization, when CONFIG_OF_BOARD is defined,
>> > invoke the platform custom function to load the bloblist via boot
>> > arguments from the previous loader.
>> > If the bloblist exists, copy it into the fixed bloblist memory region.
>> >
>> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
>> > ---
>> > Changes in v2
>> > - New patch file created for v2.
>> >
>> >  common/bloblist.c  | 29 +++++++++++++----------------
>> >  include/bloblist.h | 14 ++++++++++++++
>> >  2 files changed, 27 insertions(+), 16 deletions(-)
>> >
>>
>> This should already work so I am hoping that this patch is not
>> needed...these changes seem to break sandbox_spl
>
> By "already work", do you mean any existing patches already done for loading the
> bloblist from the boot args?

No it doesn't have that. But we need to figure out [1]. I have marked
in 'new' in patchwork.

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/patch/20230926141514.2101787-40-sjg@chromium.org/
