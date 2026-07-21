Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 775D2C4451C
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 16:01:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1A69080DC9;
	Tue, 21 Jul 2026 16:01:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f7R_ZmogMHIg; Tue, 21 Jul 2026 16:01:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 02A3680DA6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784649664;
	bh=1pc0vEWWKwdQhCleOop9pFo9bxiMnjnnMIBhSC5zNkk=;
	h=Date:Subject:Cc:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=hQQfT2E/2EgoorCBhcTplzZMkwIyTrnme0h9P4ksCi4QytkAEcYV63h37C1tZG0EK
	 Z9Ieo9pNIoakW/St0WU1AkFo0B4EH0YidYqKOi8Q+9P4cMGOtsHoEEle8EfzuLuqQ1
	 YeC87TQbN6zcZ29CeOZnW/bkBY0S4IkR8ANMPL4PYd2H6m585Iq4/L5D5/AEIpHFn+
	 ZRYZjEe/5GOa0YzeibIYjCoKeIE3K/+KJ3G3v82xCLmxFYDKimK+7zbACmZXB13/G/
	 O3eD0Kya1J6GBAjS/9K43K5q5n2L/8jxpOf53LJbtwnVjkooHz3n+5T0VYNw/xt5a9
	 Y9+fMX7nDsbEw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 02A3680DA6;
	Tue, 21 Jul 2026 16:01:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 45093DF0
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 16:01:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2AF5440167
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 16:01:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oXmH-hh9cKyM for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 16:01:02 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 2B82A40071
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2B82A40071
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2B82A40071
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 16:01:00 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE28A846A4; Tue, 21 Jul 2026 18:00:58 +0200 (CEST)
Received: from mail-wr2-x01.google.com (mail-wr2-x01.google.com
 [IPv6:2a00:1450:4864:30::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 264A8803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 18:00:56 +0200 (CEST)
Received: by mail-wr2-x01.google.com with SMTP id
 ffacd0b85a97d-46cbf263216so4133127f8f.1
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 09:00:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784649655; x=1785254455;
 h=in-reply-to:references:content-transfer-encoding:mime-version:from
 :to:cc:subject:message-id:date:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1pc0vEWWKwdQhCleOop9pFo9bxiMnjnnMIBhSC5zNkk=;
 b=U+Nx27qCUqUAr/YIOTdy1RA9GAcuFt6RoCJkiB8id0yWjYWwyhQj8cNbsgSKMxz4ex
 54ejzevtkRRNpU53/fw+ZujkD2ry9965F6ymTWRiMNNsGoHpuZwQtZO/xTqQMGsFnmnT
 HxM6tfwqXCyeQ/Kat+iv8LR3bfs5VkYUAhhQeCiDLHun6+swL5kP5sdyaHLZBTDOgSpu
 Da+s0i7AVsTC2YEwkaACHTDI/jZwt1eCzC1noiqy9OY8jeCvrOOw7ktD+9sMwrEH/WXu
 E8x+wDzZjrRV64QHITWTP8PMrLjvte1r7EddB6VOLbrem5knuDSfvBBJsZh/rnEZwKCO
 rfZQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrxg0QTSoUJyMwsAqzQ05gJe4EqVIrT5Gu94MGF65xARG8ucIJSHjQGzoPo/sw60EX00GEYNgs=@lists.denx.de
X-Gm-Message-State: AOJu0Yw6ufiqn2JuzmNp5YjdDnTXkBJ8uDj8LaJNo1B1WhB58qnus9KE
 XfEn4twgrnQ4lVUcKdML2HRNQU6P+EjXMIHfHbXGQoZYu9YP9nY/6SFLLMJUf2xGoSs=
X-Gm-Gg: AR+sD13mvGv5YLka0JkKJWsxY+xorBBRjODa+bEzjCjfK5vrVuUsUhOgnlyr5dDKJI4
 p4bCluFyyIiGOe3pAy9L2RGiAePOd6+wxnt2qElB4BG1hfYy7yDI+BzZNbxoRmc7+DlXXFp0LSy
 vAIuDbr6s/cc0wTmJQbDIW1pJM2PplHCYY2sY+/W6rUzy96USuiWyXphhMQtBmhFxNrzVLkXeOE
 ArXG9Pj4oHWEk2oiFiCcMaTr2KooV4pSmEMXMuFE0UybNRaYpY5hQIcPrT5y5zLzSCCPza8pjBB
 rE4u0tm2y5p4TomHNTgPBNulGOp/7GnphnwiqDtFB6U/xuFydYLzvcYuexj5UwNP0HhzNW0ZzpD
 jK1ENt9cNfWM9eO8W3VUMRp/x9Z6gKVQYnT/A4p6PYjR2wXgb3sdiIo8ZK3aezXibLFR3yDTPRI
 tyVP8G9rA/LlvzWtdF3qzO7cdiYAQop86OCDsdg1I/8AlMEFlHUWHkjta4z2JOFHKzs/Q=
X-Received: by 2002:adf:fa05:0:b0:47e:9f03:e542 with SMTP id
 ffacd0b85a97d-47f62338c89mr18797760f8f.45.1784649655322; 
 Tue, 21 Jul 2026 09:00:55 -0700 (PDT)
Received: from localhost (host-87-0-90-136.retail.telecomitalia.it.
 [87.0.90.136]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e496afsm41972813f8f.1.2026.07.21.09.00.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 09:00:54 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Jul 2026 18:00:54 +0200
Message-Id: <DK4DI4TBW04W.2DN95RZF2H4XO@baylibre.com>
Subject: Re: [PATCH 4/4] doc: board: mediatek: document Genio 700 SPL boot
Cc: "Ryder Lee" <ryder.lee@mediatek.com>, "Weijie Gao"
 <weijie.gao@mediatek.com>, "Chunfeng Yun" <chunfeng.yun@mediatek.com>,
 "Igor Belwon" <igor.belwon@mentallysanemainliners.org>, "Julien Stephan"
 <jstephan@baylibre.com>, "Macpaul Lin" <Macpaul.Lin@mediatek.com>, "Tom
 Rini" <trini@konsulko.com>, "Ilias Apalodimas"
 <ilias.apalodimas@linaro.org>, "Julien Masson" <jmasson@baylibre.com>,
 "Johan Jonker" <jbx6244@gmail.com>, "Quentin Schulz" <u-boot@0leil.net>,
 "Marek Vasut" <marek.vasut+renesas@mailbox.org>, "Vitor Sato Eschholz"
 <vsatoes@baylibre.com>
To: "David Lechner" <dlechner@baylibre.com>, "Carlo Caione"
 <ccaione@baylibre.com>, "GSS_MTK_Uboot_upstream"
 <GSS_MTK_Uboot_upstream@mediatek.com>, <u-boot@lists.denx.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0
References: <20260718-ccaione-upstream-mt8390-spl-v1-0-1256b6dfda3f@baylibre.com>
 <20260718-ccaione-upstream-mt8390-spl-v1-4-1256b6dfda3f@baylibre.com>
 <7ec5f838-e62c-4a35-afaa-8320901cd8d3@baylibre.com>
 <DK47KU0R1WUG.1SFYMAO1PAA7B@baylibre.com>
 <2ca02789-5806-4672-99fd-30ea217fe5f5@baylibre.com>
In-Reply-To: <2ca02789-5806-4672-99fd-30ea217fe5f5@baylibre.com>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784649655; x=1785254455; darn=lists.denx.de;
 h=in-reply-to:references:content-transfer-encoding:mime-version:from
 :to:cc:subject:message-id:date:content-type:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1pc0vEWWKwdQhCleOop9pFo9bxiMnjnnMIBhSC5zNkk=;
 b=N9J+Y+c3q9T0MtGR9z3BWNUcPB6EQ0/MT/VGZwvOdnxvPc6x36GD5dj9OOgf6t0CXb
 ihm8EZudgtXJlJUt5Fn6pGyq+38mYgOCdwnf4A55svrPuuy2+TdSk/0/q/QA+rJvKpDU
 JNIPr8BWnws4GBzQf4I6KkWo491zlaRoHNg16+UyqmWCMvjAD86vkLqFmlFR4u4Q/3vb
 cMTi3VKyKQXgH2QW0N7/8OWIC4D+qKnNr0QMZSN8xuZFmHIuBsyVwArUqrI/3Q6+DGUS
 FwmY2+ffUmyVfOONutrKvwHC1qy7roIGEI4HVvws8c1wXOuUiNVNDIRdpAf2n2fBlJPk
 Y2bw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=N9J+Y+c3
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=ccaione@baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=baylibre.com header.i=@baylibre.com header.b="N9J+Y+c3"; 
 dkim-atps=neutral
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
From: Carlo Caione via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Carlo Caione <ccaione@baylibre.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Tue Jul 21, 2026 at 4:50 PM CEST, David Lechner wrote:

>>>> +Using Genio Tools
>>>> +~~~~~~~~~~~~~~~~~
>>>
>>> Probably deserves an external link on where to get genio-tools and pre-=
build
>>> images.
>>=20
>> I'll add a link for the genio-tools. About the pre-build images there is
>> no place the user can download them from (for now), they are currently
>> compiled as part of the yocto image / distro.
>>=20
> I was thinking of https://genio.mediatek.com/doc/iot-yocto/latest/sw/yoct=
o/download.html

Ok, I'm just realizing that I was probably not clear enough on this
point.

That prebuilt image you can download at that link, is indeed usable as
the image directory passed to genio-flash: it provides the partition
metadata and the lk.bin download bootstrap. We have tested that
arrangement, overriding the primary boot artifacts with the newly built
mtk-boot.bin and bootloaders.img (output from this patchset) and it
works correctly.

It cannot, however, provide the external DDR-loader input required to
build these new images. The currently published image contains bl2.img,
which is the legacy monolithic TF-A BL2. After initializing DDR it loads
and parses fip.bin; it does not copy an appended U-Boot SPL from the
fixed offset and enter it at CONFIG_SPL_TEXT_BASE. It therefore cannot
be used as ddr-loader.bin.

The Yocto integration I mentioned generates the compatible DDR loader
and the remaining inputs for the new boot chain (and inputs to the
binman processing in U-Boot), but that work is not merged or published
yet (but it will be, hopefully soon :)

So bottom line is that if you want to use this new SPL, you also need
some kind of special DDR loader firmware that is generated by a not-yet
but soon-to-be available yocto release.

I'll try to clarify better this point in V2 (and I hope this is more
clear now).

Cheers,

--
Carlo Caione
