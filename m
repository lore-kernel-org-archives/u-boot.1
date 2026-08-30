Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F33C61DDE
	for <u-boot@archiver.kernel.org>; Sun, 30 Aug 2026 13:32:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E776E80A75;
	Sun, 30 Aug 2026 13:32:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uwP5iRYE18q6; Sun, 30 Aug 2026 13:32:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788096735;
	bh=Q5LHCiwGeAWmVumlFeIDGROMtKoocRAExPZkusmXJbQ=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FPFjbD1M4D8flN7RW8rLHcUTtoRqj6G6QbfkGH00vX5u4hcfX1TLUNeHpWsI00x+C
	 1FCZXKWq0+9Cz+ltOWKQ2wWMrIbJgw8Dbk4LQcLAh7454E39JwEiFA1Otle/79Iz83
	 14bAKBLptJ52YHsf3Fb6zzWhAfzUQfO/qOl96Q3cXmDQcMbEduIXVdBlAsW3Cm+q6S
	 mirkiZnt8CDzx7l5FdvdMvLfHjmFxZVL05eFnUODf/mHkhx3G8pqqhpARkv+xdMFk3
	 ROZ05tn5c5I4nJAXsNLQMMO0XdCy0MRODs3PuIfWmEoibRhN2XRmbkFLPNpdiU+T0M
	 X7ht4LQW6EuwQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AC57E809CA;
	Sun, 30 Aug 2026 13:32:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2D5A123E
 for <u-boot@lists.u-boot-project.org>; Sun, 30 Aug 2026 13:32:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 13412605EC
 for <u-boot@lists.u-boot-project.org>; Sun, 30 Aug 2026 13:32:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kiu0raSKS2_5 for <u-boot@lists.u-boot-project.org>;
 Sun, 30 Aug 2026 13:32:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=CAPaeQN8
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9ABF8605E7
 for <u-boot@lists.u-boot-project.org>; Sun, 30 Aug 2026 13:32:11 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-495437bb891so15526075e9.1
 for <u-boot@lists.u-boot-project.org>; Sun, 30 Aug 2026 06:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788096730; x=1788701530;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Q5LHCiwGeAWmVumlFeIDGROMtKoocRAExPZkusmXJbQ=;
 b=CAPaeQN841IxIl6kelBdIETHVkMXWFyjmjhC47KIuxxK6u2Br4JSJtZw9Unq8WOyK6
 d9bE+F1nP1rsvqu4+g8un7GcPPYF78H/WsZHkUS2pXry45hfwxvki8eYzONFV77qoJMc
 Z4dzoESPXZF0UmPc7eCW40uQmMgjOq8ihdBpSNlQoN4slmSalobr+FF1ar2jmNMtxl7n
 4BTbM6IZDqE6Ng6oeX/2QN8LwC6/OGHZo3AqIRmovNd+fwzrZ9o9vJkoCPBSsPZDy3/e
 q6dfRBuAHyLM/zB/9bI62Qc7L3VIfPlZV5p9NAOzaNwaIY293sANc2D5OUzmbwtz42C3
 3+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788096730; x=1788701530;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q5LHCiwGeAWmVumlFeIDGROMtKoocRAExPZkusmXJbQ=;
 b=e1UrInrHxGPfbZUVNA3/om9PQZUyu6+zo6Ig80fV2ou7yqhdTesfo1cQEMHi0dZWDi
 P6DyRYDHmXbxTnxDc78uWD/58YLT6p6jidTXbvok1Mi8lccg3HfmjczN2zVnEq+llG24
 1RtEhU35Bj8F+c/bsRBw0H5zv8NCgsbE4yq1vdp4/v6qQV94vg5Q8T/9BTZErDMwJRzA
 yKdJx7N7lk9uwRjxgzvcxob1M131DC03nql05KNEN5IowF/Tx+rr6gDDQhtXgTrN1DOr
 d4Usxl1GEUIGtEy+97Qkmd6I5gH1coZR6ieVOfaA8OsD3cX/N75Wb/R1kIPNdjgnhRjE
 PIFw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrrUrv+mXxPpoWyJ8dTH3/p2AOnZ/DIf/popI/EJrRYvoKn7WOLxd/zD/51anJ5rMrGPAo3l6Y=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kVUjLLpC1DdCbIit/ORP6LJIbWZ36PWM9sh5lf2azuXNTP8Gsz
 9XRETbCvzdZ82iN39dtGixnIgKv29zB4Jkim80caoVTFYWerT6q21swRVQCcDLAXZqI=
X-Gm-Gg: AR+sD12mpFlwReDtf2LwJOVv5VoR4zypG5rf50t/LaKs2HUI+3v/BtpW9zPlMQJkL3l
 UI3+P1ejNXpvjeTQHSjwb/OO3Upq+djJeBePsS40/8zGvzIZm3HS9y0+bR2R61n8Mf0Ky/q/f+W
 LHCbuHL9dYLjRHon8+DvfCO/dhc8K/hOr/w1Av/v4fj0BNJ8F8Ly8iXdtrbonBPwXM5LPMyP/RJ
 Zo8HLcu8VIsFTfRLB8e9B+DSuLRC8C4DRwhOiaxIpXCQ0AFWFSWvEr8DxXcJvX8GlN7RN7ryLGu
 KDMseiGJZTHvkOpFG3/Mq6ioQl1O9VNNH4JjHnZqQx/oopOJoJe623e3bEddhMhY8KNLcudaWfJ
 /Q6piZKNieycl9e8uAx7SO7L9+vgAawgQXU+0G/+mcuCLWg+yam7VyQwpMNXOVV86zZuCFbOOdA
 DZKJXdUG0VKJsEEKre614Ew6bg+pg6dr7nEPQq55xZ1KHIkY3rHEzIFJPbW9iSEn55rpGYpsvbC
 C0cKbfyeOhr5sr4uodsO9W8X6o0BQEGwzpKvTh3+5Xf6sUGoOZHOTnlPIny
X-Received: by 2002:a05:600c:6216:b0:49c:a2f3:fe9a with SMTP id
 5b1f17b1804b1-49cd53bf560mr41740695e9.7.1788096729551; 
 Sun, 30 Aug 2026 06:32:09 -0700 (PDT)
Received: from localhost (host-95-232-147-181.retail.telecomitalia.it.
 [95.232.147.181]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b9500c80asm240878475e9.9.2026.08.30.06.32.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Aug 2026 06:32:09 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 30 Aug 2026 15:32:07 +0200
Message-Id: <DL2BE0LQPFRK.1IXQLUXGFDKAW@baylibre.com>
Subject: Re: [PATCH v2 0/3] Add RITY devicetree preparation support
Cc: "GSS_MTK_Uboot_upstream" <GSS_MTK_Uboot_upstream@mediatek.com>,
 <u-boot@lists.u-boot-project.org>, "Tom Rini" <trini@konsulko.com>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, "Ryder Lee"
 <ryder.lee@mediatek.com>, "Weijie Gao" <weijie.gao@mediatek.com>, "Chunfeng
 Yun" <chunfeng.yun@mediatek.com>, "Igor Belwon"
 <igor.belwon@mentallysanemainliners.org>, "David Lechner"
 <dlechner@baylibre.com>, "Julien Stephan" <jstephan@baylibre.com>, "Johan
 Jonker" <jbx6244@gmail.com>, "Macpaul Lin" <macpaul.lin@mediatek.com>,
 "Chris-QJ Chen" <chris-qj.chen@mediatek.com>,
 =?utf-8?b?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>, "Simon
 Glass" <sjg@chromium.org>, "Quentin Schulz" <quentin.schulz@cherry.de>,
 "Vincent Jardin" <vjardin@free.fr>, "Marek Vasut"
 <marek.vasut+renesas@mailbox.org>, =?utf-8?b?UmFtYXggTG8gKOe+heaYjumBoCk=?=
 <Ramax.Lo@mediatek.com>
To: "Peter Robinson" <pbrobinson@gmail.com>, "Carlo Caione"
 <ccaione@baylibre.com>
From: "Carlo Caione" <ccaione@baylibre.com>
X-Mailer: aerc 0.22.0
References: <20260830-ccaione-upstream-mtk-fdt-prepare-v2-0-f9cfce2ed42a@baylibre.com>
 <CALeDE9O3Taz2Q-NgEM4Prjn_Q=z6mXduMR7y_iSvwgBR6yKGXw@mail.gmail.com>
In-Reply-To: <CALeDE9O3Taz2Q-NgEM4Prjn_Q=z6mXduMR7y_iSvwgBR6yKGXw@mail.gmail.com>
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

On Sun Aug 30, 2026 at 12:56 PM CEST, Peter Robinson wrote:
> On Sun, 30 Aug 2026 at 11:18, Carlo Caione <ccaione@baylibre.com> wrote:
>>
>> RITY images select a base devicetree and an ordered list of overlays
>
> What's an RITY image?

Fair enough. Since this is all MediaTek-specific code, I took the term
for granted, sorry about that. Anyway, RITY is MediaTek=E2=80=99s Genio IoT
Yocto SDK. By a "RITY image", I mean a boot image produced by that SDK.

Thanks,

--
Carlo Caione
