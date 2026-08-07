Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A16C2A09B
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 14:26:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EF2C78131D;
	Fri,  7 Aug 2026 14:26:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 44B4_pZGXCq5; Fri,  7 Aug 2026 14:26:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DF7F1812AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786112798;
	bh=0iama4JbNbyd5WqQcTpbPUXO7KFl8B4z9N2Gr8JmpRw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k71hv9D3ytJHN+LoZ9uepjI2sSHV72xSzMQVFKcfEV7dvFPYz48rhWvdToSPCMSD7
	 fNuykTQUG0YYbxSCuH6yghO38hTGcgfTrdIbQhZEEJmFRjN6mV3VbHWTeakWEbSw3T
	 4ljATZ6eaOJZ72HB3zIedywkExAQo5vwRjvtd+HYsORkC0D2bb12p3Lm78wLqdVnVB
	 qQpiXOsG7sgtGn2/VXC8QFPcJO2uhuMZyZQKI03vCglvrYNwMsA1oSe6qNwAWNg3EN
	 1P8fbIXmfFeiDdNWuvW19dVY89eraVj8L25WJdoQM0c/RDA+9UkD4vQv0F0j2i+Iw5
	 qx5jh6lFfHtUA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DF7F1812AB;
	Fri,  7 Aug 2026 14:26:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E7C4E282
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 14:26:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CD98B60A74
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 14:26:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hxpYI8dYMR4d for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 14:26:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A1AC660A77
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A1AC660A77
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A1AC660A77
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 14:26:35 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c15cd3fd760so373963866b.2
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 07:26:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786112793; cv=none;
 d=google.com; s=arc-20260327;
 b=f+RIPwrgUKIoVerH9ywzSaBN83CtEoTeSfPbhnKJ4HOSouJ31hW172r/h9C5442uGU
 wEDyTvT72vxfiZs+qRIjbBO54Zgb0G0k3UAX4DnMWF9tx4e5VgAwsgY86P7UWE9v3etC
 xrn/Lb8FIrSgrV1VBKWFq15erku9rIinBBlkONGrOMtXka6Osy9uDms2qTbJJ2wozx4D
 7Zq5RSy6CfBmve/Q7ELVm8oEJ6qDMkZT01k79aQervAS0I7JAsVlOoDoAL9qRgazDe55
 YsvuvUDvbgH3dqVWETD+UEV6cfsxPBbJ7SPmnCHP0feWgWd/YcuMtbGtLMYKL9qFkCob
 QXgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0iama4JbNbyd5WqQcTpbPUXO7KFl8B4z9N2Gr8JmpRw=;
 fh=ji3IF8yU0BPIm0rmmDgZzRrcvCslligTw/ixf3K7O1s=;
 b=fh9cdTJ4VJGk1exVoyMOHYG5xedQSSJ1fO0Z/2knf7Svjvf3QQDtLLcf+ialSYaVpx
 zfI920EJGktoO3eA1BXhWEgJ4vB4YOm0f30DYgYBpfbOOgvJdA34QJxiVka9r3pYzvyI
 ciKRN3xf1+rUxuJwYseWT4towxa1I6UsbZeA6PclvhZp4TKSU/7ryqo0MIJdbG21CJZ/
 YABFeu5WUxesWjmc7GvD3jE451QBZHeJjEtih1+7WCp/uUQhWiBYnrlbT0Ty89Fywizn
 QPRDgFcpew0GeGdkn58+foKeTJqPw32g0HYDzLplhi7ZtooCRhrXys1WDVX1+8tXutPy
 G/Ow==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786112793; x=1786717593;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0iama4JbNbyd5WqQcTpbPUXO7KFl8B4z9N2Gr8JmpRw=;
 b=KWlyUEC7TKYKlqguRl+OtwUn+6tQ96XbJHme7YeOTT+U5wb6ofjr2TwL9gF3Wg3nIg
 rdyP6WF0iF7e1WoAR0r47/IhS/sL9/WwxLfrrUEBVrC8IHZEJNFOuyn4YApB/EBuqrHL
 Pz1teifrkDFuh+0KA1ZOSn+lfdqP+6aMTIbf5YGZEsd15c25A6WPkL87PWXZKsHXr2pw
 pkIM1wQZAVJE3LLgRAmUfaGMQEFnrjjdMNMuTwp7SWFV5lZl9uhB6XaEitMN+selXcyK
 b8z0lZAhIfPSXwp6sMCYnq5Jo3qU+mKzAu2D4+PKI++MuEyn5Jo98GYSsSPX6ro6Qi7R
 HUvA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqsZW3i7CAOVVZUNZ2r02aCELvkvPe6mqRFK/emBKlBJGnA8HbfnvPNFUlfVx9gqOQNuTmY5bA=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyLBRd4XbLDVmViNPMDB7ytCIoz13sfb/I5n4/eK3qsLMPoyUUR
 +o+Qs95AqOUcYZqKYGo88ziSKG5Ka5FP+MAoGwYBSV14MLanChXM2MYHCIwCbBUriCCpdCqgdbS
 zNqwsbGbGvYpjtsoOXuvfpAAMHeyo/PPaWuphUaHKDg==
X-Gm-Gg: AR+sD122aBtJn7YnN3VTVOEP8zBshFL/kvK3KMgC24xVqcKAaReE4TTYfSXHUcEpJyQ
 nAGhsSHbIIsfOA6pzVzGO0HD6vHC7+WvyxlT77ibMLVbm9yKO7MQP+kVhoq32vOIFujt9uvp+pw
 2E/iyF7XfvDkZwWPRCGyKihjlpNLttIX3XWWtTw455rt8wGG34DRdAGwGSntwO2ZON4brfVhmfY
 OCNEys4go9vGfmDG7180ryqeUp2+8BTtyQZTiyRqJb2sapxzPRecLAHa3wcaF7hBtNGTMnrU2kc
 82GBA5unfAEKfjtx7zDNg+M8l9Hk5GKLfFRvXZt1hqQh7DEP4ON9cQjqLoPP1abpcjCTdt0wEzD
 64oU+fafXzltyEmi7sse/Vh9yaSZBNcc7nWFFprbpWrDewyG1iBmYw2xaxVt1TNE=
X-Received: by 2002:a17:907:d644:b0:c20:34de:5050 with SMTP id
 a640c23a62f3a-c2039afb05amr1138272666b.7.1786112793116; Fri, 07 Aug 2026
 07:26:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260806-mtk-net-mt8366-support-v1-0-5eb259ff69dd@baylibre.com>
In-Reply-To: <20260806-mtk-net-mt8366-support-v1-0-5eb259ff69dd@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 7 Aug 2026 16:26:22 +0200
X-Gm-Features: AUfX_mzoZWbDqXSZRVxZzX4_eKMCr4VyqXYnFOix6C4twUM9TL3EkuFxoSRcz8Q
Message-ID: <CAEHHSvaJ_XWBtBJRuuMtaRYQBQWGgbJHO1qU1TscN9Q9DiHC6g@mail.gmail.com>
Subject: Re: [PATCH 0/3] net: mediatek: add mt8366 support
To: David Lechner <dlechner@baylibre.com>
Cc: Jerome Forissier <jerome.forissier@arm.com>,
 Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786112793; x=1786717593;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0iama4JbNbyd5WqQcTpbPUXO7KFl8B4z9N2Gr8JmpRw=;
 b=VQy023rTp8Yo5n6HwJw5kF8D45Bu7vykaWk+mjV9CiWImAB3iITVACfXeASJFETiAm
 J0OK1qwHWDYVZ+L/nk9C5k0AlQV1Dp4p+I3o4pdYJsQtmIu/BJFp3FwdwxTr09u27zxk
 cdNK/PvoGojPr6jy7qEJo6jVI+31Z/RhIDJFeY9GL/1rCRSUREKZt68v6J+8G5UV9Z0H
 63WW3Z3LiYBi6ZxmNVOU73pEcexztoF9Pb9JomsazgZ8irbQkjKjmM/ZUJMdA/0MjPWC
 8nf0WeBc6MpOcs1CiHAeEiCPQ2oT5Gw79t8mdDwyKalNOEQAHIYbUpXlIlztYFK/RXz6
 /aIA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=VQy023rT
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

Le jeu. 6 ao=C3=BBt 2026 =C3=A0 18:15, David Lechner <dlechner@baylibre.com=
> a =C3=A9crit :
>
> In order to support MT8366 (Genio 360 EVK), we need to add a new
> compatible string match since there are a few registers at a different
> offset on this target.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> David Lechner (3):
>       net: dwc_eth_qos_mtk: support platform-specific PERI_ETH_BASE
>       net: dwc_eth_qos_mtk: add mt8366 support
>       net: dwc_eth_qos: add mt8366 support
>
>  drivers/net/dwc_eth_qos.c     |  4 +++
>  drivers/net/dwc_eth_qos_mtk.c | 63 +++++++++++++++++++++++++++++++++++++=
------
>  2 files changed, 59 insertions(+), 8 deletions(-)
> ---
> base-commit: b2817120d3506e3c4f1329fb8745b40ae7f6ba60
> change-id: 20260806-mtk-net-mt8366-support-2901d2c811b3
>
> Best regards,
> --
> David Lechner <dlechner@baylibre.com>
>

Reviewed-by: Julien Stephan <jstephan@baylibre.com>
