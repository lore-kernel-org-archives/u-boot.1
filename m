Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3516C5AC7C
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 12:02:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 846F560A63;
	Fri,  7 Aug 2026 12:02:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Uon0qduVhQm6; Fri,  7 Aug 2026 12:02:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A8A1D60A52
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786104175;
	bh=tK+soql3t2ScNBpV3pvQ8jAAq3wTwl1xQIqaJTH4xpE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xnjZDYaomuUiYTd2tK5+2nAJNSYbUsJedyucyt2TceaQtcwMuKxrl1w4a/d+bo0hh
	 zjsgScDvMFU59fkpK2q+IvSq3bUk/hWiOGWrKbh/ogFx0PjOLdR4TGI4ZZXqLJjKZP
	 1b+yQt438ZK45Ur2Mwaa1yx8vvtF3cY8OdmHlKR0QZsc3faJcHdwCB+4jrQZjL/+yb
	 PVV2cr8vBmfMK6jhAc/Xeo365+u2jCmnua76UhzQSYnzGIfC+rSWTH5b7Y7qmpeAW4
	 Kc9wFjHRU5yqXRz24Q7EB0xLzUi57mt/sUY8cbfhckEFaLYxDbEIKz6lq0evFCY7Bf
	 4SN0FLhEXlp3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A8A1D60A52;
	Fri,  7 Aug 2026 12:02:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8A393198
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 12:02:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6FD2181209
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 12:02:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i12ax-V8egw9 for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 12:02:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 9E1BE80D07
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9E1BE80D07
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9E1BE80D07
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 12:02:51 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c169ae1cb26so357551266b.1
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 05:02:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786104169; cv=none;
 d=google.com; s=arc-20260327;
 b=RitmxQIr6RjiWt5FTUurs0j8HDx5x1BF4CxSg8KJ8JoPnJrEpesPobvHvClm+DJOzV
 3DTi9/UQm8AYzPSgc+B12y3V1xQFvKmFM57+UecF3ov/uyu46gG86qztDK83CQm0H1Ns
 LN5FEcfd4avJIYWbD3YFWEp/tQR2IJoWgEGj8LoAGUwveDQSTEQfDXDVd9K1mNM+cMzO
 Yhk5j0lU3bTHh57hwuLB7iutlIbPZZwpacjHVF9vnx5teD5MXxpaSNe45DVuQlE1oRXA
 DBJJakJLNhXlkQ62GJQuv6NNYnXryUBuJ4yq/eNZMUwRYK/jdqyrcP7XKHzr5a7ogfVm
 KNDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tK+soql3t2ScNBpV3pvQ8jAAq3wTwl1xQIqaJTH4xpE=;
 fh=iv54SaXOmQE0KJNbqABWrJEr5QASLkJ7HrNo33hBtYk=;
 b=GVJ203PpSmeuu1FsTjL13wBSd4vmrM/8AzkUdmMiP1LTfnEsCwVjElu/7vRxQidQEp
 h4Kw8U7jpRmcUaaLUeGZ35Jvj11+nxlWFD7pvGq36A5Z7Dqp8WyKrRS+kjV3HT2T5UFG
 sHQsk4q1AX3AoTGI/DCfkeWt/wI76tyz3vJM4gkgjGM+mkS1lCTfpxFl/ReDZm9V5b3x
 XuLVcveCRfTz0t7nAOop8GyDW4pWghfyHcK8AuTDu7ieTxT8Y9hfQmVYx6nrdphHp+3h
 2m5KfqUO34jPTGtPnfvZm58m9PEoMsNZAINlKZJDjzKgiyHScrvbeV7y77/ijcFFGyr+
 YxGw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786104169; x=1786708969;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tK+soql3t2ScNBpV3pvQ8jAAq3wTwl1xQIqaJTH4xpE=;
 b=RepsWeLVVWaFW5V4D5uOYn7mOPCeU9ch+NXw+IW2cd6JxNjqk2o/yq59QNwqbJuRED
 1t5zGWnls2qtl6kWze4XzeI+XDhRxIVp7U5Ps4Gys6vnZlIIGs9rgd4RbqM+5HCnU9Uh
 e1a7ifXeDjBkyBFMNUuBAv1/yQJc/sCEwn5kpiriXOUhsbkvJKqA9ZoTmRytSAZ9V3s5
 NDsckPuDPjYmnYw7GJJGX8DJcM9aASmOTP83BzzK8idaPn5Eh8J24rOuFh8oyeBTWuxY
 l5I+GCo3oeGQsuwurvQugURcCCu4DNbPnS1Uw+XnpuHnheWghyfgR5MrV39PBGVxp9gH
 Mx3Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RqMK0CZwkXxwrAolLXFS6MSvgwo0mpoS4REmORvtSoLAnnrIr/Zx74g3dUXxaz0J2gCI6AvZZw=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyQad4Xjg3gmLjPAPyHwEfRhCjQJ+zslMoByA4GGcv0KXyneQfy
 FxY8ISd2Qx5BbFUaNJokw4roJbXAocEw1izDLOK7jAsLlf6JtLL496henLLXgA44b47X86GFXk0
 ZQIIGwdBWiiShOcGOmjbGjEgPlf4rbrDaZeVSNMAs3g==
X-Gm-Gg: AR+sD10Jgi0c5w2kRDJkh0QwRCQ11Pfr4eetF/WcCsG4FDVPxETOSgr4EHtjn1n7POi
 7/Q797cyxk8xVHma4hfVL5bMXICEzb2EuER5KnkkxoHjevgxF9zNilTs6pa1gd7s4iYgYjid5pL
 GodAZVD8eGBfoC4ZG3+9x+bQDr1x4PG4aokjSWn34oC2kuXX17xA9ggdiCqjqd0mugJQ1EI/lfh
 mGL0t3jeFwIHfWZlNjiQz9Yf4chZQOXV/ldgn6PxFTVNZzN63uhVVaTik1ky9PV6A2tOfDQGJIA
 Oih0XhIJKHi2GDdmxKASF6ddQyrlcwy5FZREYnejaNwPapoh2tOVl2I8LEwcZw3Y4pqqpVh1GNO
 ac2glQYOy7QJujgdfPVT+ckTm+9fmuSK2FTqt5g/wmEjqJOXJz5iKDWpRciECvH6J+gTyEycsIg
 ==
X-Received: by 2002:a17:907:7253:b0:c12:8a:7d7b with SMTP id
 a640c23a62f3a-c2057d86410mr674175966b.1.1786104169251; Fri, 07 Aug 2026
 05:02:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260803-mtk-pinctrl-kconfig-cleanup-v1-0-fef1ff69d1cc@baylibre.com>
 <20260803-mtk-pinctrl-kconfig-cleanup-v1-2-fef1ff69d1cc@baylibre.com>
In-Reply-To: <20260803-mtk-pinctrl-kconfig-cleanup-v1-2-fef1ff69d1cc@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 7 Aug 2026 14:02:38 +0200
X-Gm-Features: AUfX_mxNBi-sTLllIDZNMbnPq9pzc0NJIyV0ibWAnw95GdA1zsLAk4AkpGZk-KM
Message-ID: <CAEHHSvYr=e1_KiVexCA-u-ofqq95y3ypQQtpuUgmFSVhKDJJ5A@mail.gmail.com>
Subject: Re: [PATCH 2/4] pinctrl: mediatek: remove PINCONF conditional
 compilation
To: David Lechner <dlechner@baylibre.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, 
 Sam Shih <sam.shih@mediatek.com>, David Woodhouse <dwmw2@infradead.org>,
 Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Macpaul Lin <Macpaul.Lin@mediatek.com>,
 Julien Masson <jmasson@baylibre.com>, Mingming lee <mingming.lee@mediatek.com>,
 Fabien Parent <fparent@baylibre.com>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786104169; x=1786708969;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tK+soql3t2ScNBpV3pvQ8jAAq3wTwl1xQIqaJTH4xpE=;
 b=j2nafFcVNpe/WHfbfsUn1BkjaCs1d2Lg5zLv+tpbUneRwzTSC2Rua890HysO+gE7Fh
 WvP2jxQcGX8LZN49Y1ncXMHzaB6yT1PJ+rDr69tMa1D10PBPCLnSzSMuaAEK+0WJXNsF
 RvMBVMLBv0R5MJUC83AMrSc/Hysv82Rzj0gM2j6k7Vtz4qaiyp5wOejzDPDWySqAbZsU
 j5zDY7UtorL3IwzVx6JDZNp1mB5S4ONwjSViDqjue0mcxJlty2hHiVgHvB4RoGRGPXhx
 ifvXQl/3MQoVtkUJfEzlQxBd4/Qj2hnpi6j/pNwAy8k2c3CbKV4QOkNLpvcDF3mig7Lm
 gvcA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=j2nafFcV
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Le lun. 3 ao=C3=BBt 2026 =C3=A0 22:57, David Lechner <dlechner@baylibre.com=
> a =C3=A9crit :
>
> Remove #if conditionals that checked if PINCONF was enabled. The Kconfig
> now selects PINCONF, so it will always be enabled and we don't need the
> checks anymore.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 13 -------------
>  1 file changed, 13 deletions(-)
>

Hi David,

 I see some remaining #if CONFIG_IS_ENABLED(PINCONF) in
pinctrl-mtk-common.h  should they be removed also?

> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinc=
trl/mediatek/pinctrl-mtk-common.c
> index 01f67f09407..0b8234e167f 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> @@ -19,7 +19,6 @@
>
[...]
