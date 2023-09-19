Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 253CBCD3445
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 07:20:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2F0786A84;
	Tue, 19 Sep 2023 09:19:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Je36p6l0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3054B86A81; Tue, 19 Sep 2023 09:19:52 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E01F86A9F
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 09:19:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-98377c5d53eso680034366b.0
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 00:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695107989; x=1695712789; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q4Il5nIaNGerDUL7WqdAWOQP7Tqp9i+pVnR4YoPywus=;
 b=Je36p6l0sf0gG+TfaWN6Cy6896dK81rh94y736Kn3n2+zRcgLaHxuudFTJJW9YkFyy
 AEIwRqvp4+Ar89ownRisdF99kK9lw5zPYl/a37eAfHbtn6DDnvK0OFQ626VmniLHpPyT
 V4ulyA/aDbndaGz+ZzTKhunRSdC64aT/dyWAdThWdV/MFBdLq0Oq8CDqXRJxl6ViADZX
 5C1R3gc4HoumPjLCLL7tUIoypc4fvXIoYUujS4f4BapByyvm5ySLGsSltsOpFdM9lmhG
 bnvksO/HmLSN0DS5mwLJF3ZUVPuUEgU4qrxs9+6DfIBuVcjekP/oBRi3DabuGDzyP9SA
 20xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695107989; x=1695712789;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q4Il5nIaNGerDUL7WqdAWOQP7Tqp9i+pVnR4YoPywus=;
 b=vevse8PVup0Pqzv6J76jqVeT+mxSCGh3cgP0CgwmPeWZUqOmvCCxURWFkKQXSknTv3
 WkZvo7JrYf9RT5uOPIw0KSlJEfDlctmE+INDYmLe9Pnh0sDLBN0YNRjtvxu9xPOInYlR
 X9IBbyNbsTAa8ysuPPQYNv5K51YRu9GBR5dj2QtBvqZHWJF6nMC4MwoRbbAw68VjjCEb
 zVgzmcIlpAvUYom2lQy1xg/CukVcZ845XyLZyvCc+A6F/rUBidk1dOYFJYYXP80amQ2v
 tWM8bE5NCA2qT4VwthHYMmfUwzIITK7JlyPIVcMyI3TWKzixrcgtJcwJ9t8NIqb92jsH
 +6zQ==
X-Gm-Message-State: AOJu0YxD1WSoc+MshIqoicC6cB1tyIMb6zBpa5bcfhQ9qyXNkZXljAy2
 wfLALJlky3ly6fuzBnzqlJJlp+hpgtQuRptfa3Y=
X-Google-Smtp-Source: AGHT+IGYCQG7Uq1jQ18QSeZjMO3iOkmfnYx46Au6amuBWMMhjzEAhztOyvKRFeQgo0T0uhLwD3AVDFZtI5ODiNyF9go=
X-Received: by 2002:a17:906:31c7:b0:9ad:805d:f123 with SMTP id
 f7-20020a17090631c700b009ad805df123mr10004814ejf.18.1695107988820; Tue, 19
 Sep 2023 00:19:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230823211059.1235147-1-sjg@chromium.org>
 <20230823211059.1235147-8-sjg@chromium.org>
In-Reply-To: <20230823211059.1235147-8-sjg@chromium.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 19 Sep 2023 15:19:36 +0800
Message-ID: <CAEUhbmVLr+B7sU7MQjKjgbzNaB6XGB84p0RuPhKcHSDVytPQ-A@mail.gmail.com>
Subject: Re: [PATCH v4 07/20] x86: coreboot: Enable CONFIG_SYS_NS16550_MEM32
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Simon,

On Thu, Aug 24, 2023 at 5:11=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> The debug UART on modern machines uses a 32-bit wide transfer. Without
> this, setting debug output causes a hang or no output. It is not obvious
> (when enabling CONFIG_DEBUG_UART) that this is needed.
>
> Enable 32-bit access to avoid this trap.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>  configs/coreboot64_defconfig | 1 +
>  configs/coreboot_defconfig   | 1 +
>  2 files changed, 2 insertions(+)
>

Can we use CONFIG_NS16550_DYNAMIC?

Hardcode CONFIG_SYS_NS16550_MEM32 in the defconfig just works for one
configuration like yours, but it fails on some other configurations,
e.g.: IO port based ns16550.

Regards,
Bin
