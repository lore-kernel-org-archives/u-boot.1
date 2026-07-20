Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C0C3C44515
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 07:15:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B7B3838D7;
	Mon, 20 Jul 2026 09:15:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="HZWpAlZW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEFB383E76; Mon, 20 Jul 2026 09:15:07 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F10A980517
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 09:15:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ccaione@baylibre.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-49558ce01afso8038135e9.1
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 00:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784531705; x=1785136505; darn=lists.denx.de;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ACeedMzc97dR/rQ0fmsz20ERufR2IlCPchlqi8JBpOE=;
 b=HZWpAlZW0pXsJt3fvQnwWvy6i6ZCAjCYvL3ATikk2djNNd8iT7yjTcmbsmOcxPQJlE
 hhMFTuWdEU3SDg4BEbBsdZ1ie9UlM9wISQ/v7gl2FKzHEy14b7aqAGQFJcuwE/TwISLA
 MVMawPlcBPp8/DofQ6+KLrIwlopT8NLN7pTQf2WtWgUC3LLVpHOyx7pPKpil7hLx94wu
 11t1oeXNoIZRfvQbKchoDG5tgIT4kWC0xVhfnM2zyVNn4C/7x5zcQq7NKO++fVNklSsJ
 cy9PdoQtkMh4T3nd8xri1so9C6QFcoFW4rf03L8wbnow2PO2PkwoZsaB9Kj2EpMUWowM
 KudQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784531705; x=1785136505;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ACeedMzc97dR/rQ0fmsz20ERufR2IlCPchlqi8JBpOE=;
 b=aVLzwPC2+t0+YAlh6rUf+6eagCaWrMXMsiW1b583TUqO3FrXQQQyYkEzFlgLg18F63
 W5oQd3tq+L2lRWo+W8pFSMWfsAqKJhLpmP6PKurnn7h0RzRjoXcvzZcMOPL5NcKLdWAS
 SppbRHubhr0i7sfPBFZSpVOeYHlkLpdyfYttyFy4YSQVyTimx20VyljCbZ/tuWbWrEk1
 IfyBDh/IXrubg7kusjWV9Qrh1l1ZLYxmbSVbx+VX9nsko2ZFp3B8Cbr2b5p1KCZ/vHlq
 WWoc+uKaHYBqrQ3BS08K+IZVNSgU9BdpHm1fpspSSuwy+9ovGRe5wV3mFndRp5OVBBAF
 HzaA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqu0Sfmu3rgR3yw3JRu79GTrPHKciCZDpVxqdu+oigft50EU9cHKZIjRPSCITuKodWwV+XzPqE=@lists.denx.de
X-Gm-Message-State: AOJu0YweffaE/Ma1Voh/Sp/M0X1/BZC/ilF1orCAIpLFYNpUzFoEzV4I
 BJUAFzl35THvapjgC9AM6uCKny5h3XkiV/r+pYSFsHAvIuZuyKAVGsIValWHeaJ0auQ=
X-Gm-Gg: AfdE7clRMqSUUsHzvP6/9lXznWKvVCucahr5Ei3uqbIb/ETH7IIZ8iParpDLHfkymBe
 fIhtkrKfa9983k9BNyAlpYf2b+EL0/a4d9BhqVddUmw+5i0WQVjL1bhJuArmCBfHnLA9trgkefv
 wLcRkd/fa+Cf0ncZf/MWxN5dpBhmAKhNIiIvMUrQZLbGrDTDuag4TuuYezlhr4ZFLVaJJRBEnVZ
 iYOQP8zyZCITwWecaavbn2IBAzD4iRr42HGY0f4xCVBsw+r7Wv2/l64ygP6dwnF/sKvEpqC5KC5
 tsf8hTvUS37jK54aMXeQ1KD3mb8aRwuuG4djUo+6VFGykTl6qvEzyoRN9eCc2Y2IsbwqL0sp1LA
 YxwMTghgbdjxXTGVJ+iadLA1VIDAWAmzyCe1OfvQLIEGZXeW3r5378+ewDJsuBouaPAdV9Y+V5+
 iHUo8q6BDZQZe0sFDA6gVfmYwHU+YDq/oKdHg6YqpyVgwk0Lh2v2tJ0E/b
X-Received: by 2002:a05:600c:1509:b0:495:3f5e:e7a with SMTP id
 5b1f17b1804b1-4954a51dee6mr98868955e9.34.1784531705244; 
 Mon, 20 Jul 2026 00:15:05 -0700 (PDT)
Received: from localhost (host-87-0-90-136.retail.telecomitalia.it.
 [87.0.90.136]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4955de8895dsm57234595e9.4.2026.07.20.00.15.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 00:15:04 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Jul 2026 09:15:03 +0200
Message-Id: <DK37OZ6BC3H4.3ON0322LPYRB5@baylibre.com>
Subject: Re: [PATCH v2] usb: mtu3: support the current devicetree binding
Cc: "Ryder Lee" <ryder.lee@mediatek.com>, "Weijie Gao"
 <weijie.gao@mediatek.com>, "Chunfeng Yun" <chunfeng.yun@mediatek.com>,
 "Igor Belwon" <igor.belwon@mentallysanemainliners.org>, "David Lechner"
 <dlechner@baylibre.com>, "Julien Stephan" <jstephan@baylibre.com>, "Marek
 Vasut" <marex@denx.de>, "Tom Rini" <trini@konsulko.com>
To: "Marek Vasut" <marek.vasut@mailbox.org>, "Carlo Caione"
 <ccaione@baylibre.com>, "GSS_MTK_Uboot_upstream"
 <GSS_MTK_Uboot_upstream@mediatek.com>, <u-boot@lists.denx.de>
From: "Carlo Caione" <ccaione@baylibre.com>
X-Mailer: aerc 0.21.0
References: <20260718-ccaione-upstream-mtu3-spl-gadget-v2-1-7f69ca462559@baylibre.com>
 <1c0aa375-b274-4171-801d-4ee7b857e61e@mailbox.org>
In-Reply-To: <1c0aa375-b274-4171-801d-4ee7b857e61e@mailbox.org>
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

On Sat Jul 18, 2026 at 10:20 PM CEST, Marek Vasut wrote:
> On 7/18/26 12:08 PM, Carlo Caione wrote:

>> @@ -160,13 +167,17 @@ static int get_ssusb_rscs(struct udevice *dev, str=
uct ssusb_mtk *ssusb)
>>   		return -ENODEV;
>>   	}
>>  =20
>> -	ret =3D device_find_first_child(dev, &child);
>> -	if (ret || !child) {
>> -		dev_err(dev, "failed to get child %d!\n", ret);
>> -		return ret;
>> +	mac_addr =3D devfdt_get_addr_name(child, "mac");
>
> Use device_*()/ofnode_*() DT accessors please, not the raw=20
> fdt_*()/devfdt_*() ones.

Agree, I just used what was used before in the same line. I'll fix it.

>> @@ -369,5 +389,6 @@ U_BOOT_DRIVER(mtu3) =3D {
>>   	.bind =3D mtu3_glue_bind,
>>   	.probe =3D mtu3_probe,
>>   	.remove =3D mtu3_remove,
>> +	.plat_auto	=3D sizeof(struct mtu3_glue_plat),
>>   	.priv_auto	=3D sizeof(struct ssusb_mtk),
>
> Can you extend struct ssusb_mtk with a new field instead of adding plat=
=20
> data ?

I don't think ssusb_mtk is available and bind-time. Anyway, I think I
can remove the two variables entirely and just rely on ofnode_equal().

cheers,

--
Carlo Caione
