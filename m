Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9CDDC55184
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 09:17:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 738F580C72;
	Tue,  4 Aug 2026 09:17:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bA7XOoEBwV9w; Tue,  4 Aug 2026 09:17:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B59C080B12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785835033;
	bh=CDK3AgjvZlxjZMytD0zx2ReFFPjj5NFPoL/lFT79++0=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yVMFI122LHMhO1r+C+AYIre7ddvf+2WyYN3PpBfbCV182FoNCoGJ/fM11kXmoCdj6
	 YumyCllDCGaWof3AN057yDnIp9b0ctty1Q050t+OIWLlz0xr1dwzfEX4R7bC/d7VOK
	 AW8jrS4YgP7aGPOXrVJS1V5v+LAGyUcGJtTHKvGBUNU1iXWS9003k50wIKVQp9R88D
	 FpeyLykVqfC6yYK+LKSVVGguuuDz0vzy8zet468SWm6ozzNpc3ENh1gTD84dqzPJaF
	 IzMTUSgO8eCa1LGDoYCCB23+8V2NY8vDZNpNQ0ho5b0gsCf05fgFcJHvqepiAdRXav
	 UVg1/UVDyECng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B59C080B12;
	Tue,  4 Aug 2026 09:17:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8D15326C
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 09:17:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7F0E8406F5
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 09:17:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JEGmbexduIPu for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 09:17:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E7D0C406EE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E7D0C406EE
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E7D0C406EE
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 09:17:09 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-47c2b362ee2so3729679f8f.1
 for <u-boot@lists.u-boot-project.org>; Tue, 04 Aug 2026 02:17:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785835027; x=1786439827;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CDK3AgjvZlxjZMytD0zx2ReFFPjj5NFPoL/lFT79++0=;
 b=AIzMU7qwkPecE8fQ7keUu6f7I84l9fAiuG6E4kaSfa/fX0DWMLNIJk0abjo6Ye5aff
 y1TTh8tglfqm1QEuijEu2s9VH4VmmRSXKskrbHObUIigqZitMFDRHJ16RJ2yvBiV9kPz
 GUzA7egNPVj+MWkisL7FmXA4DWr5HjOPQ019MYk/3dXjCR/iKl2K9CKD94GaeiDTr+eY
 JwVd25t9K6onNM7KxaSvgP6vthKWxD0KHJBb7igP19YdABHtzgcPkPuCDyJpggnbgpX7
 peJZmeFNnv86b/bjyvGprYpDbgtr35MFSGcpUqe0wihGQ0Woo9q/v/1dWod9jTo89eLD
 UAhQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoM7ZeRFOf6BxBu1x1HY4cy9ebX7naz8rpYrUboB8KXKPpRjMkT8czx5dpjT9+97KZbHayf8aM=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxKufMf0TR7e4cDftj7qQ1X3CtJPA1J5OUaQt4NpgRLFWg2/ViW
 2i6tXQlEXHoSjaTaSK4vCVXv1EYcb3fEa8AzzeU9bEEl4RSOoE/6YEoctEYS3njL+7EHJYIK2E6
 QVEPea6g=
X-Gm-Gg: AR+sD132SDqyRpB5aaQLASX5P4EB25pSCy9JY48TBhiCEioU8llWG4fGNDWTQBQmGZu
 YHUr40f9mgCIqwH/mdQnTN/aMabCaZoHCZpycujMK4bJGJEip/8pGyDlbS5UOzTESqLmBnAcT39
 0Oqxv5XklmnFS1Dk3+nUV1JrvFF8QJ9KEMq7gTBOZ4vcNUCfe2CXlk94SrxmMi2Ej7Uj7KpTTBN
 KG0q9rUW0JDkIvA7ceYBYqB7UtHp8oSXgFTlP4cS01qys0Zw0NzppOnjLO+ADgIcYXZVXzVK3F2
 mExvB7gRjw+AH27sDv+7td63OdUHGQfWzV3sKW22LWDsHnqsM1CR8mVgQLstbe4bsbzz0vUsBF8
 rSevFtMPTTbQWguY7RBFPs2VU7pXpzpYBNU9lZ9w7VXzSoIxv2uRNobjjlkgBolsQCc7S+ePfWf
 /QVEJzWWcwr81LXPE1XMzLZ7SIbH93/fwSFT4dxTa22wSeqdOFuBzg94Bdit/7pGqFRuDHw+GCg
 O0jzcTOGzelszOznHWpazmWsZOLRsxg+JWm4b++MSRtBVXOe/5F132G
X-Received: by 2002:a05:6000:40e1:b0:47f:8b1f:efa2 with SMTP id
 ffacd0b85a97d-47fd729e88bmr34713979f8f.8.1785835027493; 
 Tue, 04 Aug 2026 02:17:07 -0700 (PDT)
Received: from localhost (host-212-171-227-71.pool212171.interbusiness.it.
 [212.171.227.71]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41cf404sm41307054f8f.1.2026.08.04.02.17.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Aug 2026 02:17:06 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Aug 2026 11:17:05 +0200
Message-Id: <DKG1OKWLVQR4.339ERXWKKY09D@baylibre.com>
Subject: Re: [PATCH v4 1/2] usb: mtu3: support the upstream devicetree binding
Cc: "Ryder Lee" <ryder.lee@mediatek.com>, "Weijie Gao"
 <weijie.gao@mediatek.com>, "Chunfeng Yun" <chunfeng.yun@mediatek.com>,
 "Igor Belwon" <igor.belwon@mentallysanemainliners.org>, "David Lechner"
 <dlechner@baylibre.com>, "Julien Stephan" <jstephan@baylibre.com>, "Marek
 Vasut" <marex@denx.de>, "Tom Rini" <trini@konsulko.com>, "Ilias Apalodimas"
 <ilias.apalodimas@linaro.org>
To: "Marek Vasut" <marek.vasut@mailbox.org>, "Carlo Caione"
 <ccaione@baylibre.com>, "GSS_MTK_Uboot_upstream"
 <GSS_MTK_Uboot_upstream@mediatek.com>, <u-boot@lists.u-boot-project.org>
From: "Carlo Caione" <ccaione@baylibre.com>
X-Mailer: aerc 0.22.0
References: <20260722-ccaione-upstream-mtu3-spl-gadget-v4-0-9719f4cecaeb@baylibre.com>
 <20260722-ccaione-upstream-mtu3-spl-gadget-v4-1-9719f4cecaeb@baylibre.com>
 <33c75886-eeb9-4e67-b378-7a83ff1fd58f@mailbox.org>
In-Reply-To: <33c75886-eeb9-4e67-b378-7a83ff1fd58f@mailbox.org>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785835027; x=1786439827;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=CDK3AgjvZlxjZMytD0zx2ReFFPjj5NFPoL/lFT79++0=;
 b=AjrKn7ODjPAgXOLByjfV4DY2YsmmMa7kpnqsAiyzsL14zosmVyhzOfq2EMSnSpcbnC
 KNaPHWUIdeHawOcc2k+bgRvaIm9sJ8VHL+oax6XyU9kYbfQ0G6JrAeNNdXKokTELKlUl
 tUh2i4lJxZMUeYrGg5TiK2+ZDWmbI5MpFU2QzhAjWS80oZQV5RVzYdXCTxjve4KEN9Pl
 dyU+qjVySbJf7i4G/0NG1VWF3ji0pGOb9DLMmVxc+0UJOSWwhmXWwGX60QXJNt2WTCGH
 P+rDM3qGE4ZM/7W1Q6uxgAaYhn/lSmW5WSVtEIL0E5fNN2s9D2QH8ZM0FxAhxTbX4ubm
 msyw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=AjrKn7OD
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

On Sun Aug 2, 2026 at 10:13 PM CEST, Marek Vasut wrote:
> On 7/22/26 11:43 PM, Carlo Caione wrote:
>> The MTU3 glue driver only supports the legacy U-Boot layout, where a
>> synthetic mediatek,ssusb child owns the gadget resources and dr_mode.
>> Upstream devicetrees instead place these properties directly on the
>> controller node. The gadget therefore cannot bind when U-Boot uses an
>> upstream devicetree.
>>=20
>> Search the controller children for the legacy U-Boot-only node and use
>> the controller itself when none is present. This preserves compatibility
>> with existing U-Boot devicetrees while allowing the driver to consume th=
e
>> upstream binding.
> Can the U-Boot DTs be aligned with upstream DTs , and the driver fixed=20
> instead ? Then this compatibility goo won't be necessary ?

Yes, that would require a bigger change in the driver to support host
and peripheral in the same node / driver. I'll push a V5 soon.

Thanks,

--
Carlo Caione
