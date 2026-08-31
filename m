Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45638C624C6
	for <u-boot@archiver.kernel.org>; Mon, 31 Aug 2026 07:55:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E91B660607;
	Mon, 31 Aug 2026 07:55:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rUtzXg6JgxvZ; Mon, 31 Aug 2026 07:55:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788162907;
	bh=z4jApL5Up/yWj1EZuCZK+qWtcBaazcvqkpXX2EbY7v8=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Jwl9oaEWqMuvSzll1rgiAjqnMlUtgC2pf+r2PWI2JFk6NvM884KEqunex25Z29Dtl
	 7dZdRJqXuOTtTU4hmLZ6xEiYlBWD3420qUJIwRw7zYuWbF1hQSw9C4rsztWQI9zjFN
	 PCr6L3MJ0+wSLBSbko78w9Vnyq0awfmy4iZ0YInW+rmcptMS9kfHirRerIYfttb5M0
	 JYTQya/7wtSF4Liv4hLcT7Sl0cih3QvX12s0m7+s8l58pGAad4TlDIfSCtAmHkxGlu
	 ARnMMsDzw/RZyM57PAPBwfmrfauBiOG4C9SSSWQW7bi7EKvnoiM5WoIN0GGXtMP5p5
	 zTgJvQj2xfJZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1F947605DF;
	Mon, 31 Aug 2026 07:55:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7E71A230
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 07:55:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6F9C140560
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 07:55:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PGYdHYMicvKu for <u-boot@lists.u-boot-project.org>;
 Mon, 31 Aug 2026 07:55:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=bxTk9TRs
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ABA4F40557
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 07:55:02 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-49556f97a9dso20923605e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 00:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788162901; x=1788767701;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=z4jApL5Up/yWj1EZuCZK+qWtcBaazcvqkpXX2EbY7v8=;
 b=bxTk9TRscg/iGHY3V9ji0Sg7hQiWoI/RS+As+8CAda8PKAf4VpRtpyC0Vz3k/rQVQb
 JqKZiOeyKU4cjUn3Pf5zLHfXaWl1Vj5HjY3JfUrPrnZwaGd9p1PRITMpx9Sf34XpF2+J
 5s7PsLZF4CvC3/Zfe1cvCeXhdZBX2/e5a4w8DnG4GWY49ASEjoj4p5Obh/4btlrnE/QV
 azN5hRLCLfgHrObca3Fc985D6BfKWGaCEb4wDQXGw1iBIJlwcqO1heIVMUgcJTLhinYd
 yZ1/SqQbXsVJtngVQMsHhSxt9ozudgu5mtVkAzhSwAgD0cBa2NbBv+aODlJY0tad0TR5
 j3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788162901; x=1788767701;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=z4jApL5Up/yWj1EZuCZK+qWtcBaazcvqkpXX2EbY7v8=;
 b=MCLfxVvwRt06FrbBN7dtJLgMZbSLzhR6FCRGj+dcT/tU6UkybsariGJlBBx+u9Zkec
 /Er58z4gN3EcvxDaj97/8lkgFr8elONJnVBa5ki5UsIXk0rW3UHcGAk0saVGmg4kgBxN
 ZSyUFsZKw84Rk///Vqtn/9GjFbn4DGMaGlHRIoZfYnfjSIG0nuHe9gEPae5W9EWzA+6T
 ExMEKqLSXW5bHp9bWm+9TliGcjKbBDwdj95BIIcUcJ8g0u3SPJX0TLQnV7fPuqHycHZr
 vuTTx4sBHzSzwGkpj1BezUIXUY0I50/hI8I+djGPhJ8oXg8xywUoNNpj3FV5xvHJ2xZ6
 9BzQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoakjJenZoReJ7sLU+ttQtPh1ypqnF6OTwNfb3Vq7BB6OcrPx6Nj6iN/v3DaiDgnzCTYN7ntYk=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lspdtP4gHtKv9GDmleFpkMop+HVeqNd4u1rPFOVfcU7ftwPkC6
 KftmRJxvbS1X55TvIPP7kp7VzdL/PVGLCW2y/CtDM2zNtcM/2OajDLLpnA+BrtOLWSY=
X-Gm-Gg: AR+sD13mSWJpbbJNKVxCYhgXvnT+no4DcloSsvC7mxjJfU/wV9qnn8PeFxJdPEBC/oT
 mZ0oH2FTl4B3Y1zxSCfE/K5CC/ADEfy4qQvBWUrUzNUXloP2ixwkR3lKzskg6/7nj1YFPQ32B4B
 SzY6uC5nVBP9LwF+KSjkF0En4Z728YkDR+P66EIlSEppI6JbwEd3/hNDHmLgop98uU/KhuoflNw
 arsKlgtYkUCXB8kZo+/OQ2SV3LyaTOOiBFXWsA6Qqnq2+I/HTt4kHPH5pIPjR01g1v6B/5aIF1D
 wY+cZko6CAPE/Pj9l3BMNZZ+Yb/3Kkl7gd50dJPpa3/Cl0Sixe5PR7UfzPbluBC3/shhcxnYV8+
 FkJGGd+Jx9Jf4k1KNi/I3Z9+L4g913c6rboJVgAPTPJ2Q5BIfoCrjyPqv+tqEev42YYiecCtHxn
 fHuQgU/S7LvdlSke5rshh6PPZ70U4j8iiu9cZTnuRvdPLLKwwGEdmgncVftWhGF6DFkywWZn98Q
 xN8+sUtmIRPS+7BD+UsDi7/Ynu1Np+6gKQ6P1uNbqahs6Iicg==
X-Received: by 2002:a05:600c:a418:b0:49b:9433:ea44 with SMTP id
 5b1f17b1804b1-49b9433eb4dmr338457185e9.4.1788162900893; 
 Mon, 31 Aug 2026 00:55:00 -0700 (PDT)
Received: from localhost (host-95-232-147-181.retail.telecomitalia.it.
 [95.232.147.181]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b9266be71sm567517805e9.2.2026.08.31.00.54.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2026 00:55:00 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 31 Aug 2026 09:54:59 +0200
Message-Id: <DL2YUFG39FD4.1MPXRK4G8ZGQR@baylibre.com>
Subject: Re: [PATCH v2 0/3] Add RITY devicetree preparation support
Cc: "Carlo Caione" <ccaione@baylibre.com>, "GSS_MTK_Uboot_upstream"
 <GSS_MTK_Uboot_upstream@mediatek.com>, <u-boot@lists.u-boot-project.org>,
 "Tom Rini" <trini@konsulko.com>, "Ilias Apalodimas"
 <ilias.apalodimas@linaro.org>, "Ryder Lee" <ryder.lee@mediatek.com>,
 "Weijie Gao" <weijie.gao@mediatek.com>, "Chunfeng Yun"
 <chunfeng.yun@mediatek.com>, "Igor Belwon"
 <igor.belwon@mentallysanemainliners.org>, "David Lechner"
 <dlechner@baylibre.com>, "Julien Stephan" <jstephan@baylibre.com>, "Johan
 Jonker" <jbx6244@gmail.com>, "Macpaul Lin" <macpaul.lin@mediatek.com>,
 "Chris-QJ Chen" <chris-qj.chen@mediatek.com>,
 =?utf-8?b?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>, "Simon
 Glass" <sjg@chromium.org>, "Quentin Schulz" <quentin.schulz@cherry.de>,
 "Vincent Jardin" <vjardin@free.fr>, "Marek Vasut"
 <marek.vasut+renesas@mailbox.org>, =?utf-8?b?UmFtYXggTG8gKOe+heaYjumBoCk=?=
 <Ramax.Lo@mediatek.com>
To: "Peter Robinson" <pbrobinson@gmail.com>, "Marek Vasut"
 <marek.vasut@mailbox.org>
From: "Carlo Caione" <ccaione@baylibre.com>
X-Mailer: aerc 0.22.0
References: <20260830-ccaione-upstream-mtk-fdt-prepare-v2-0-f9cfce2ed42a@baylibre.com>
 <CALeDE9O3Taz2Q-NgEM4Prjn_Q=z6mXduMR7y_iSvwgBR6yKGXw@mail.gmail.com>
 <DL2BE0LQPFRK.1IXQLUXGFDKAW@baylibre.com>
 <3aa3d789-3cfc-4913-9003-9a9d8dc81647@mailbox.org>
 <CALeDE9MPBAt4P3Dw9oE-eEF_UjSWUprFG_ipic8SwjwTAb0Ubw@mail.gmail.com>
In-Reply-To: <CALeDE9MPBAt4P3Dw9oE-eEF_UjSWUprFG_ipic8SwjwTAb0Ubw@mail.gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Sun Aug 30, 2026 at 10:54 PM CEST, Peter Robinson wrote:
> On Sun, 30 Aug 2026 at 21:47, Marek Vasut <marek.vasut@mailbox.org> wrote=
:

[...]
>> >>> RITY images select a base devicetree and an ordered list of overlays
>> >>
>> >> What's an RITY image?
>> >
>> > Fair enough. Since this is all MediaTek-specific code, I took the term
>> > for granted, sorry about that. Anyway, RITY is MediaTek=E2=80=99s Geni=
o IoT
>> > Yocto SDK. By a "RITY image", I mean a boot image produced by that SDK=
.
>>
>> Can this instead use fitImage core code which can already apply DTOs on
>> top of base DT ?
>
> Or boot using UEFI and be generic, deal with the DT overlays with
> standard U-Boot mechanisms.

Hi Marek, hi Peter,

In principle, yes, we could use FIT core, or the EFI bootmeth together
with the extension-board framework, to implement parts of this. The
problem is that neither currently covers the complete interface we need
(and we are using).

The RITY boot contract supports (among other things):

- selecting the base DTB and an ordered overlay list at runtime through
  the environment

- loading those files from either block-backed filesystems or UBI/UBIFS

- accepting both raw DT files and individually signed FIT-wrapped DT
  files

- preparing the same resulting DT for both the normal EFI boot path and
  the legacy boot path

- allowing Genio tooling, in particular genio-flash --load-dtbo, to
  modify the overlay selection without rebuilding the image (important)

Now, the core problem is that using FIT core for the complete operation
would require changing the image producer and on-media format so that
the selected DTB and overlays are represented by a FIT configuration.
The EFI payload would still be discovered independently.

Also the EFI extension-board support is useful for automatically
detected hardware, but it does not currently consume the
user-configurable ordered overlay list, cover the UBI/UBIFS and legacy
boot cases, or handle the individually signed DT files.

One of our objectives is to allow existing RITY users to replace the
vendor U-Boot with upstream U-Boot without also changing their images,
tooling and environment interface. Changing the RITY interface and
image layout would prevent that kind of drop-in transition, and it is
something we would prefer to avoid (at least at this stage). This is why
we are proposing the functionality as a platform-specific
well-compartmentalized command.

If preserving that existing contract is not considered sufficient
justification for platform-specific code, please let me know. In that
case we will need to reconsider the approach and find another way
forward (still unclear which :)

Thanks,

--
Carlo Caione
