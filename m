Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA10AC3DA79
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 17:08:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9E5D8784B;
	Mon, 15 Jan 2024 18:08:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mHsw0D8S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBE5D87856; Mon, 15 Jan 2024 18:08:40 +0100 (CET)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5249586D82
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 18:08:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5c66b093b86so6874770a12.0
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 09:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705338516; x=1705943316; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qGwE6yIVHiaKKIcP0PeyKFyKuxc7T6G3U6dzFkFwy9E=;
 b=mHsw0D8S+YxR+JO35gqbsN/xzAg5YY6D6ttZ6fzmakSa1TIkLzEjU0Kv4JDIUcz1Ar
 d2kjlyc+X1NZ3I3varNzYH5zj2rek/osryxrZ/92L5nQukAEI3FN2Sda2LGJHKp+4JRJ
 y/cgmglDThghQSlP87GrVVgSxhYAX53bGkswHxwKw9KIxCaX9Xw3Apz01Cv4DjPfzLXb
 KjYGvH3aQQf6e0xrN7efJsUow/JWgTPcfuFwSvjPCIsnaKsnwM5WGBWXTMPcVDW5axRr
 lE2a/p2AttACuExD7Q3mSbCJ5qqwVgCwgsMKRTG6ffFSjrYs2va0dbSSzI54usg5zmgS
 RJPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705338516; x=1705943316;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qGwE6yIVHiaKKIcP0PeyKFyKuxc7T6G3U6dzFkFwy9E=;
 b=YZhBCyZA59PZ1TfF0oN8Ax0Bb9d+YXh3KGzvbbCHLnruCbdDQFsg3e83sEMWnSUq7M
 umrWCqazqnAg6EaoM3Xs9fL5NjQOWTe9FMhU4qQYai2jl7p/GJBB66fnBUtn2787F1Lk
 cyaycleG5JhXSfTsjQd0JhdRaNejmBcddMP5Obcx982l/5xYXtRzZ1EfNza/OWwxCW/b
 iuLyVL/epZFJODlE8l2dZfPysu10pXA199U8EHOxeVPsqL098EnBupevVPEzR70GyZTO
 YINegbhyfxcSGWxMvRTei1tp3AAkLy+It1k6HFI2KhgB6EaNU//qjNnPZU5uveEM3EOE
 STjA==
X-Gm-Message-State: AOJu0YzdVx8oOF3IRupNhNr7U0xNoMbJMsNAl/Vxh785wmPS6Ti+hjkG
 MpyQu2qPGaiut/NAASdY9TdM6weibLGxq7qLekMZBpE/GsnJgQ==
X-Google-Smtp-Source: AGHT+IGqCB0VMA+a1BGdYgDtkU4jo8DSMbW6HF7sJibeTUWTNERmRHZTIUcvoiCOEr2lubUXnKP0wAmdsy+ROKs4dnk=
X-Received: by 2002:a17:90b:23c3:b0:28d:9cf2:373d with SMTP id
 md3-20020a17090b23c300b0028d9cf2373dmr8243389pjb.30.1705338516674; Mon, 15
 Jan 2024 09:08:36 -0800 (PST)
MIME-Version: 1.0
References: <20240112213337.185460-1-raymond.mao@linaro.org>
 <20240112213337.185460-9-raymond.mao@linaro.org>
 <20240113152732.GH1610741@bill-the-cat>
 <CAEfUkU+fDjfJ02Pjyeock=MhV-SUU0raw8uSvfAi6mwxq_R=xA@mail.gmail.com>
In-Reply-To: <CAEfUkU+fDjfJ02Pjyeock=MhV-SUU0raw8uSvfAi6mwxq_R=xA@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Mon, 15 Jan 2024 12:08:26 -0500
Message-ID: <CAEfUkU+xJ+Zwyer-2fo=EtfcELYw4Gw0QNM9pd1PuNYk-RXf3g@mail.gmail.com>
Subject: Re: [PATCH v5 8/8] fdt: get FDT from bloblist
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org, 
 jwerner@chromium.org, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Kevin Chen <kevin_chen@aspeedtech.com>, Sean Anderson <sean.anderson@seco.com>,
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Devarsh Thakkar <devarsht@ti.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shiji Yang <yangshiji66@outlook.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, 
 Samuel Holland <samuel@sholland.org>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Tom,

On Mon, 15 Jan 2024 at 09:57, Raymond Mao <raymond.mao@linaro.org> wrote:

> Hi Tom,
>
> On Sat, 13 Jan 2024 at 10:27, Tom Rini <trini@konsulko.com> wrote:
>
>> On Fri, Jan 12, 2024 at 01:33:34PM -0800, Raymond Mao wrote:
>>
>> > Get device tree from a bloblist if it exists.
>> > If not, fallback to traditional way.
>> >
>> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
>> > ---
>> > Changes in v2
>> > - Refactor of board_fdt_blob_setup().
>> > Changes in v4
>> > - Move the logics from board custom function to fdt library.
>> > Changes in V5
>> > - Rebase the changes on top of master.
>> >
>> >  lib/fdtdec.c | 18 +++++++++---------
>> >  1 file changed, 9 insertions(+), 9 deletions(-)
>>
>> Why was this just not dropped after:
>> commit 70fe23859437ffe4efe0793423937d8b78ebf9d6
>>
> In commit 70fe23859437ffe4efe0793423937d8b78ebf9d6, the FDT from bloblist
> is always overridden when OF_BOARD is enabled (OF_BOARD is enabled when
> OF_HAS_PRIOR_STAGE is on). I think this is not what we want.
> The FDT from the bloblist passed from the previous stage should be the
> default setting.
>
> If we want to build with OF_HAS_PRIOR_STAGE=y and without OF_BOARD to
avoid the
FDT from bloblist not being overridden,
`imply OF_HAS_PRIOR_STAGE` needs to be dropped from Kconfig for ARCH_QEMU,
otherwise check-of.sh will always complain.
Do you mind me adding a patch to arch/arm/Kconfig? And then we can drop
[PATCH v5 8/8].

[...]

Thanks and regards,
Raymond

>
