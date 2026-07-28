Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE856C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 11:36:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9DB2D40840;
	Tue, 28 Jul 2026 11:36:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fbgu1VPFpour; Tue, 28 Jul 2026 11:36:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7A10540A23
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785238593;
	bh=V/V3PFaB51JNPOIELsKo9UxwNdtibbMeuYOE7AMQqLk=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SJBv4dYMSsss2A32jcrPeuxrodyXEqFnZGHUCzTYYPXk/bl4ZCcDDykN9Y8Vta5CB
	 Z6a7wa3UB37zUhtaO8EhtyuhKi/8q76VN7slLRGjeN3xCI6r+BsTR0gSU4nxbUTmA5
	 ARUqavAsL7WpkRFjJ5GB7jc3XBQBnWi5sMCe9b7HDUeJbqD94m6gBigKp5KfGRoq16
	 ouf9NVkML5CLgGa8TIQufNY9hhXUMtYmyYTaTn/SNEeAs31/KzfZ5rBWBgOMlDB6Mg
	 KoNlNQtWV95DZugEVB06v39y+F4399NXmT3OKdkaobdqU8dqaohGDTgMbjAR7olCBH
	 I7Sa6NBJN3NfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7A10540A23;
	Tue, 28 Jul 2026 11:36:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DADDE42A
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:36:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C12FA40A1D
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:36:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kRppZMoCeIOy for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 11:36:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B175840A11
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B175840A11
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B175840A11
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:36:29 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4954afac04bso42968055e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 04:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785238588; x=1785843388;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=V/V3PFaB51JNPOIELsKo9UxwNdtibbMeuYOE7AMQqLk=;
 b=QzIBujkEfutptHAdQBF3Qp1su/axBf6nXnIW2LIBdSQT7IaYc+Q+cp9duYv81BSDKR
 cYIbMnTCLTlsUT/ST1zzFeTPXXuN/sL3JvpFyP4wmiOe8FPXN9OcSwu5rNWxJdFrQl0c
 DG54l+NNXw5a/kDJWl50eRm9l5p1ZQdUJcwPZbxRqWUX2f07N6Fkh7oy/dSrx+33P/x0
 WOedOMe9CqqmAZNw7xeNsme/b1TZmfkrXK0kUUn3KPDCu9rk3M0YoxnMzFFRLnMdmpmD
 GlwQT47rN1LoR3Hlin5xMkApdtb/ovsVJzo9jS/FGlnkfdv53GAN/QWKfKTkb5reYdt9
 hTTQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro/Jm6yXIT960AQEiLrAadaoundOZbi74bQO9EuTA+w5Hf1vp16XPzM/FJGumkZGZAG4C5hKMc=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yw4QI59Nn0HECrsZywyW08hccD5aIEs3hdFfdfaJBt8+NOpNX38
 KNiqAZaRxcTbF+dZ0chVOo4G8vtNiyLUi4QwZNNkwijBTCBmIcm9yeac2i1UYEe8rxE=
X-Gm-Gg: AR+sD10v9S+tOWArB4vEO1Ac5Tglfua0iaxOC2JWvPQDppCbVCCOK8B8OLgwuXwHX7U
 6ZhG0gLHxMEK+1Nw7n8FVNNCb6r5STfjxKSK/oR/2G8KZqbPUqTDg4trWqMCyn6zInaOoqPfS+f
 zkxb/LDyrkSZRV+njFT9rw6t6apAn/HRYwuFLjR3IwmJ9TrWib9ncwXXmOphsCXwYoILrtX+bt4
 f1kXakDLzyy3MwNRwZRajKqBpIl/LcEMs43i/oY7qvZGsWyk3RWAkfd/E9TiHk23wvmyFf4Bb1p
 IJbA2VaqRRSgc3gri5/KWR7uwVjBoBUiOGJQIWf53twDNlp6EqKf7D5BmB4liPiB8Od32us7+XC
 qiisRHWLPub+ENAlopsAHf2xpaoBGZxm6Lp9eHiLOdIFvAmFcyrSFiiuXDJ8/0AsGR4SrQk1BGU
 Z7gaxm8G3MPfrOw3VHcjv6eCjqN3RzIwRoxqRvfCAQJntSzB6y64Rz7Lpe
X-Received: by 2002:a05:600c:c493:b0:495:4d88:e630 with SMTP id
 5b1f17b1804b1-496c6545a58mr20876025e9.10.1785238588099; 
 Tue, 28 Jul 2026 04:36:28 -0700 (PDT)
Received: from localhost (host-87-0-90-136.retail.telecomitalia.it.
 [87.0.90.136]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c45c297dsm66938085e9.7.2026.07.28.04.36.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2026 04:36:27 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Jul 2026 13:36:26 +0200
Message-Id: <DKA69GFQDDF4.282SBZCJTDO3O@baylibre.com>
Subject: Re: [PATCH RFC v2 2/5] fastboot: use the common handler for USB reboot
Cc: "Mattijs Korpershoek" <mkorpershoek@kernel.org>, "Tom Rini"
 <trini@konsulko.com>, "Quentin Schulz" <quentin.schulz@cherry.de>, "Sam
 Day" <me@samcday.com>, "Julien Masson" <jmasson@baylibre.com>, "Vitor Sato
 Eschholz" <vsatoes@baylibre.com>, "David Lechner" <dlechner@baylibre.com>,
 "Lukasz Majewski" <lukma@denx.de>, "Marek Vasut" <marex@denx.de>, "Peng
 Fan" <peng.fan@nxp.com>, "Jaehoon Chung" <jh80.chung@samsung.com>, "Alexey
 Charkov" <alchark@gmail.com>, "Adrian Freihofer"
 <adrian.freihofer@siemens.com>, "Francois Berder" <fberder@outlook.fr>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>, "Peter Robinson"
 <pbrobinson@gmail.com>, "Vincent Jardin" <vjardin@free.fr>, "Casey
 Connolly" <casey.connolly@linaro.org>, "Heiko Schocher" <hs@nabladev.com>
To: "Neil Armstrong" <neil.armstrong@linaro.org>, "Carlo Caione"
 <ccaione@baylibre.com>, <u-boot@lists.u-boot-project.org>,
 "GSS_MTK_Uboot_upstream" <GSS_MTK_Uboot_upstream@mediatek.com>
From: "Carlo Caione" <ccaione@baylibre.com>
X-Mailer: aerc 0.21.0
References: <20260722-ccaione-upstream-spl-fastboot-v2-0-2ba3f71c42bc@baylibre.com>
 <20260722-ccaione-upstream-spl-fastboot-v2-2-2ba3f71c42bc@baylibre.com>
 <9db60818-e50b-49b8-b2b3-3cdb5aaa41a0@linaro.org>
In-Reply-To: <9db60818-e50b-49b8-b2b3-3cdb5aaa41a0@linaro.org>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785238588; x=1785843388;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=V/V3PFaB51JNPOIELsKo9UxwNdtibbMeuYOE7AMQqLk=;
 b=oN6ZwxZaIEMgBgpP2WBfLipYUcT0Sw69rHZlPWZqc9f9ZnsVD2q5hQQj2FhK8D0YvY
 mzJK/nsiBXSbGS4/FbZ10SoGtXC16meT1zWaaNSlV10T3fFbvSzh0DzjBKwn3/TDTsa7
 BR4FZEMi0GMy6hevzzKIsP9Rg2/zkzqu7bXBzzRXWoUSatC6/Iigispm7DfB+c+bRl4Q
 acroZd6LjGjtc7mUskIpmdVWix+SeO8EyY2i+CFhTnhwTaXVmO/oWuedGEPyrPYbs19u
 f5pUvJD1tSHFUvW9FdMTHq5ydaidZ8wH8CY/U76YOo9kk+ezHrdASmy0OyGGIj9nkLOh
 K7Ew==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=oN6ZwxZa
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

On Thu Jul 23, 2026 at 10:50 AM CEST, Neil Armstrong wrote:
> On 7/22/26 22:43, Carlo Caione wrote:

[...]
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Hey Neil,
is this only for this patch or for the whole set?

Preparing a V3 and I wanted to add this to the proper place.

Thanks,

--
Carlo Caione

