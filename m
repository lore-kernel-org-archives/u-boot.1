Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A67E1C4451C
	for <u-boot@archiver.kernel.org>; Sat, 18 Jul 2026 09:36:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70A1F80287;
	Sat, 18 Jul 2026 11:36:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="StWkpQZD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D22580517; Sat, 18 Jul 2026 11:36:02 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 790C480117
 for <u-boot@lists.denx.de>; Sat, 18 Jul 2026 11:35:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ccaione@baylibre.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-47c6e9a694bso4705946f8f.1
 for <u-boot@lists.denx.de>; Sat, 18 Jul 2026 02:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784367359; x=1784972159; darn=lists.denx.de;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Wi+HoAKn8l+afKvta8WAEHul4wOwFTcRWW/Q8yf0i1o=;
 b=StWkpQZDQiGjw0X4eUbUSY7Z9jax2n4E5mT6PE68ETeN8oF/vMLXcHavFZ9vll54eW
 1pRLa7XVtZdM37YtbD7jZOnyPhwLbLOxG2wYF9D3NZf3s6xqSD961TqOzfabRkj7snGN
 m71bHXr7m99ttGOCkLGVt11CmfVOl17at7Np2AAwS+uIZZ4hfXN1WvXfyGcr9/BwgqK1
 KGraBNprgPfwm5+KKQyBrO4EV3lb4/0jVAduEOKWx2mLsMs3rBd2slm16PyxLru9naCN
 A21JTh68U+fBVuVzB/d0jbGWfTg1JiZei9hn5+rHxP4LLPelQdp3OhQ1VBouy3ZooUXm
 GuGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784367359; x=1784972159;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Wi+HoAKn8l+afKvta8WAEHul4wOwFTcRWW/Q8yf0i1o=;
 b=ge/EyhxC7OfOypHuUpJCwJhYoA3Zk+JmJkN8leRNitLYIbehPMn/vfOiFKhry70kFC
 7MTbFCKKOZoxcmB5Jq7xzthj4odUAs+RO43v14j1/i3guhlya13xh3SORiG+Gz5UImyB
 YK8srZ4ZyWBzXqHwXwnIdYETZC+AFguatuTRtMqTLs+T/J9JcnlQ0WjEwqkPJOkQgwnH
 cGONZf5BW4aTTvNUL4RVKkwbWCaZwCI/zm1IUt1H1HigwTyiyWANJacY1T2TL9EWSLN0
 Bm9Nu/dfw2kDFF0kfL7HhAvB61/2P59S9MMjPWzUtUZsWIbWWvWuQEWauXR74W/nISbU
 dzHg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqU0jc5bNm0/teKJmyOCAJ/NFo+3KxfWZABXE9uTJR4KKXlrbQ5Tcpa7Bo8MTxyYCyfbG2ibys=@lists.denx.de
X-Gm-Message-State: AOJu0YylPzkRT/N9kteuCdsFMhPDBspke4rsiRN8KrBPF2rj6uQSahJO
 Caq8Qq/UG7FOXe8/XlVtThwsxgozJlpJ8K8bnoe8nQj+90QfGzHTZKRe9jUhzzm/R50=
X-Gm-Gg: AfdE7cls7m99DXRmB18frKxxANGgpqJu3sxpSITMG62hapSKSmPqq8XXrkpHG9c1Q3l
 HCheGLFJHryWk7CR+fQBI7ssKJRp0LunX8rUI8GmMWM48Bou7d90EWfQGYRf5XGeZehGhITzg5a
 43kmM1xVDlNhozI0IdfLredQouwoU0LEM/dtMlPDLdzX36Zg+Dn7CfdoD+PxeqYI/TpBHLlh7+r
 UGt52GytniQlVANws1z/klybnuAbN7ibYn/v3JEV8sKfWvWIerslKhCaGObfJNWmI5d2XzSBGd3
 4pSbiOl/D/0XqRRL+FBXhOvA4H3MZ0og5j+3kdeW9HtDFXvpNslNv4mnpYOHmktuErkCPsf52Y+
 e1bYYEIKTFdOhA7aEWxL1TH92WvXoIf7+jJhLAIRHVX1oJr9sc7bq3yseU/JkQp8GMyupVMBBtb
 y9JiN7Dpi3yeHQiI+R1PVYLR2xDvF1kRTKMUrBtNHMhvzehGnn8PuaR5inaCJ9nw==
X-Received: by 2002:a05:6000:619:b0:464:8d68:618a with SMTP id
 ffacd0b85a97d-47f62328339mr6899035f8f.32.1784367358853; 
 Sat, 18 Jul 2026 02:35:58 -0700 (PDT)
Received: from localhost (host-79-16-115-126.retail.telecomitalia.it.
 [79.16.115.126]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f6fa848fcsm93736f8f.0.2026.07.18.02.35.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Jul 2026 02:35:58 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 18 Jul 2026 11:35:57 +0200
Message-Id: <DK1LFRGO4U2W.Z7AW6YS9A8NZ@baylibre.com>
To: "Marek Vasut" <marek.vasut@mailbox.org>, "Carlo Caione"
 <ccaione@baylibre.com>, "GSS_MTK_Uboot_upstream"
 <GSS_MTK_Uboot_upstream@mediatek.com>, <u-boot@lists.denx.de>
Cc: "Ryder Lee" <ryder.lee@mediatek.com>, "Weijie Gao"
 <weijie.gao@mediatek.com>, "Chunfeng Yun" <chunfeng.yun@mediatek.com>,
 "Igor Belwon" <igor.belwon@mentallysanemainliners.org>, "David Lechner"
 <dlechner@baylibre.com>, "Julien Stephan" <jstephan@baylibre.com>, "Marek
 Vasut" <marex@denx.de>, "Tom Rini" <trini@konsulko.com>
Subject: Re: [PATCH] usb: mtu3: support the current devicetree binding
From: "Carlo Caione" <ccaione@baylibre.com>
X-Mailer: aerc 0.21.0
References: <20260717-ccaione-upstream-mtu3-spl-gadget-v1-1-57a3e2d0a2b0@baylibre.com>
 <626b3219-d0c8-44b0-8947-0e216bd65713@mailbox.org>
In-Reply-To: <626b3219-d0c8-44b0-8947-0e216bd65713@mailbox.org>
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

On Sat Jul 18, 2026 at 12:08 AM CEST, Marek Vasut wrote:
> On 7/17/26 2:20 PM, Carlo Caione wrote:
>
> [...]

>> +	/* Current bindings describe the device block, not the whole MAC. */
>> +	if (!legacy_binding) {
>> +		ssusb->mac_base =3D (void __iomem *)((uintptr_t)ssusb->mac_base -
>> +						   SSUSB_DEV_BASE);
>
> Can we avoid this typecast horror ?

I think we can.

>> -	node =3D ofnode_by_compatible(dev_ofnode(parent), "mediatek,ssusb");
>> +	node =3D ofnode_null();
>> +	ofnode_for_each_subnode(node, dev_ofnode(parent)) {
>> +		if (ofnode_device_is_compatible(node, "mediatek,ssusb"))
>
> This is already invoked in get_ssusb_rscs() above, can the value of=20
> legacy_binding be cached somewhere ?

yup, let me add some platform storage for that.

cheers,

--
Carlo Caione
