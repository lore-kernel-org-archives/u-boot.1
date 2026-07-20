Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD970C44515
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 07:33:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1E3582991;
	Mon, 20 Jul 2026 09:33:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="Q1KWCuzZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE8D1838D7; Mon, 20 Jul 2026 09:32:58 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECFD680517
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 09:32:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ccaione@baylibre.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-47f752b3423so615104f8f.3
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 00:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784532776; x=1785137576; darn=lists.denx.de;
 h=in-reply-to:references:cc:subject:from:to:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=opPtvZZ46OC6Sx9UjFW8QmaCCu5g+tE9rEz3TIixw1s=;
 b=Q1KWCuzZl+8gBIoR8N6eZImEOavSbRjlFHhKOeWOhrvxTcmrzbV+Y+16yyO/T4sfKa
 wma/VP8pThZS1Xj2mwNP4Qurrcq7Vzds3I5Q4uaSZZ7yfRUMioD3/ni9NQNWoJjPcEin
 /U8krbDxrbnZyRCsla4WlOxu5FUxDZaSepjKGx6pCKTY2DlqkEy+zlTIBRULe5Aon9vo
 AfLcKP2kwFw5m4oFxMwA7yrTtE7f9eqQ+DIIunD6jwcIhHSyRh61WABGRI4xKGVu2A7L
 EB6wtGDY3rwBOAdA5HD+HZ+v1elu/bJtfTRrWkjflBfwJVdNBmBf245iBaf3L1e699nL
 dtUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784532776; x=1785137576;
 h=in-reply-to:references:cc:subject:from:to:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=opPtvZZ46OC6Sx9UjFW8QmaCCu5g+tE9rEz3TIixw1s=;
 b=qW4eRB416kvN6zHGAm3MIWc4ih73z1SZOGcAWTnYEUkcNbnI40tqGRdWBeqPhI3AC3
 7S+vLeACzkift3GbSxmDazh3QhsLjSG8K3/5aGbe5jmvsS2EM1TkKlmep5r+8uHGjTQB
 Vm2lha18K/NLSimvEkLMtNmoG1zArtgTC9zRVc9+z3d4al6wkueJyPBPsh+jvcK16hSp
 AvO+w0qYBZ0Ko3eWyTUbfCYX3C/YO+o6v7VdN3awjRRLDlOT37JYuHaYFSH4wzMd8O7r
 5pdd1Y7t2gr9pRNGCggNfoqc4Z2RKp4ablG8inYwG11HWEsx25wnl1EZQeKlsFpLuNSG
 2NOg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqO7nqGzjQfmEbWb9ucbFaSr3ngrzCy1CD0rbcIIDZiViJiB1fbyGm14eOJe9KlcSHQ32u2pLs=@lists.denx.de
X-Gm-Message-State: AOJu0YyY1Z2iKgU5vPEVPNRE+JLtLAGwuygV+Bzhz+gZnWGAE/LLvhfs
 NNneYLGYkBEs0lCSbZDD7rRk3Pu93lEDZZ/8QGT8PMHBigJWx1CIrgzOynG1F1eNoQ4=
X-Gm-Gg: AfdE7cmglypqiv8D9XUMqsrH58rw4SH8tJ28BdVeVfU2maspIphppTmV6Ue0kdmPcVP
 7EwLrvidwpepzi9jqignh+03Lbmf9omE1D9cFk+Y/zOCmjDMTox03FDXMxJPlNzY6iz/ksRveBV
 NMX5jF8B9pV/yXiR3rIwsqtrM8qjxPSkBRbPUKRd4L7OahUKawNTVhqQLigP5mB2u7cD4UVWgSl
 MtWgkWkgbIOD69ZxQnHgjCGbNiYQyJmPVhDDB10VVlG5H8Pzk+mV95yoMagnRWfM20GV7KutwHp
 TF2+fZ7myGWgEwqBeeVDy84TIPIwD2wwW2/vSBOO4Na8AYy3G1Z3oR/TgyIFnP/marcqI9JFxaJ
 5gGuy0YCWvG/2yo9zCiAsA3jLojvLdloDutTOKFrfMit/ldQYRiZTY131wKH2/n/tcJi4Nq2J1h
 BUR1B8z4H9uvtAKgQS1eu8EotzzZDHQr0jFrirDGnwbm9nLjcMeHZbA7/N
X-Received: by 2002:adf:e189:0:b0:46e:7f72:b6fe with SMTP id
 ffacd0b85a97d-47f6230be0amr15735261f8f.19.1784532776252; 
 Mon, 20 Jul 2026 00:32:56 -0700 (PDT)
Received: from localhost (host-87-0-90-136.retail.telecomitalia.it.
 [87.0.90.136]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e49ab8sm28938009f8f.5.2026.07.20.00.32.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 00:32:55 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Jul 2026 09:32:54 +0200
Message-Id: <DK382N861VQO.19D7SQAQ19GEW@baylibre.com>
To: "Marek Vasut" <marek.vasut@mailbox.org>, "Carlo Caione"
 <ccaione@baylibre.com>, "GSS_MTK_Uboot_upstream"
 <GSS_MTK_Uboot_upstream@mediatek.com>, "Bin Meng" <bmeng.cn@gmail.com>,
 "Chunfeng Yun" <chunfeng.yun@mediatek.com>, <u-boot@lists.denx.de>
From: "Carlo Caione" <ccaione@baylibre.com>
Subject: Re: [PATCH v2] usb: mtu3: wait for TX FIFO to drain before disconnect
Cc: "Ryder Lee" <ryder.lee@mediatek.com>, "Weijie Gao"
 <weijie.gao@mediatek.com>, "Igor Belwon"
 <igor.belwon@mentallysanemainliners.org>, "David Lechner"
 <dlechner@baylibre.com>, "Julien Stephan" <jstephan@baylibre.com>, "Marek
 Vasut" <marex@denx.de>, "Tom Rini" <trini@konsulko.com>, "Lukasz Majewski"
 <lukma@denx.de>, "Mattijs Korpershoek" <mkorpershoek@kernel.org>, "Vitor
 Sato Eschholz" <vsatoes@baylibre.com>
X-Mailer: aerc 0.21.0
References: <20260718-ccaione-upstream-mtu3-tx-fifo-drain-v2-1-837345048224@baylibre.com>
 <6f37728a-901b-4f39-9923-3852cbe95061@mailbox.org>
In-Reply-To: <6f37728a-901b-4f39-9923-3852cbe95061@mailbox.org>
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

On Sat Jul 18, 2026 at 10:17 PM CEST, Marek Vasut wrote:
> On 7/18/26 12:37 PM, Carlo Caione wrote:
>
> [...]
>
>> +static int mtu3_wait_for_tx_fifo_empty(struct mtu3 *mtu)
>> +{
>> +	struct mtu3_ep *mep;
>> +	u32 value;
>> +	int ret =3D 0;
>> +	int i;
>> +
>> +	for (i =3D 1; i < mtu->num_eps; i++) {
>> +		mep =3D mtu->in_eps + i;
>> +		if (!(mep->flags & MTU3_EP_ENABLED) ||
>> +		    !list_empty(&mep->req_list))
>> +			continue;
>> +
>> +		if (readl_poll_timeout(mtu->mac_base + MU3D_EP_TXCR0(i),
>> +				       value, value & TX_FIFOEMPTY,
>> +				       MTU3_TX_FIFO_DRAIN_TIMEOUT_US)) {
>> +			dev_warn(mtu->dev, "%s TX FIFO did not drain\n",
>> +				 mep->name);
>> +			mtu3_ep_reset(mep);
>> +			ret =3D -ETIMEDOUT;
>
> You could get the ETIMEDOUT return value from readl_poll_timeout().

fair enough.

>> +		}
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>>   /* set/clear the stall and toggle bits for non-ep0 */
>>   void mtu3_ep_stall_set(struct mtu3_ep *mep, bool set)
>>   {
>> @@ -261,8 +290,14 @@ void mtu3_ep_stall_set(struct mtu3_ep *mep, bool se=
t)
>>   		set ? "SEND STALL" : "CLEAR STALL, with EP RESET");
>>   }
>>  =20
>> -void mtu3_dev_on_off(struct mtu3 *mtu, int is_on)
>> +int mtu3_dev_on_off(struct mtu3 *mtu, int is_on)
>>   {
>> +	int ret =3D 0;
>> +
>> +	/* QMU completion may precede transmission from the TX FIFO. */
>> +	if (!is_on)
>> +		ret =3D mtu3_wait_for_tx_fifo_empty(mtu);
>
> Shouldn't this bail early on ret !=3D 0 ?

No, disconnect must still be forced after resetting a timed-out endpoint
(we still want to disconnect it, even forcefully)

cheers,

--
Carlo Caione
