Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5947CC44529
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 07:25:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 26A944082E;
	Tue, 21 Jul 2026 07:25:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 78rO0K0XAM4h; Tue, 21 Jul 2026 07:25:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4F6F240825
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784618721;
	bh=RLlHaJoCj3/6HGuJHu9f5G06zFTsKHYvwIEQnH3mgnY=;
	h=Date:Cc:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=TXxOluwIqDWvdpg8gAu+UfFQRt/CZdQbUz7Xe4bSnTw1XNYBtmpSFxFnS32m/1Qtu
	 vB4u27YQSNFnsYgI2YZN1NtlzdRaDtMLmrMsrXbfnhVbKGmneHjFFN7/Sw/mYbu1Tc
	 NK289m+n/4A0O/NzUc7VPE1X4aBuUQC2Jae8xaWSbMLLknQKDNGfJ69lmWnarhfKKt
	 G0qOPcMyVCVJOB52a9/FyIvb1o9eu7j020kXLMRQTjloJAPGv501AA9pSb9UA9yynC
	 49UaoPEB3BmYVvFopqH+zszWdUzLccQKWv/YJbCOvRqsLrgVo1OESf+wcsYF68DqyU
	 aDnwsPH3cIGcw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4F6F240825;
	Tue, 21 Jul 2026 07:25:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 837E3109B
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 07:25:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6983140042
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 07:25:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xCZsPugf49Tm for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 07:25:19 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org F38C940116
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F38C940116
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F38C940116
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 07:25:16 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3058284659; Tue, 21 Jul 2026 09:25:15 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EFE3803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 09:25:13 +0200 (CEST)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-49557167508so25876115e9.1
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 00:25:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784618712; x=1785223512;
 h=in-reply-to:references:subject:from:to:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RLlHaJoCj3/6HGuJHu9f5G06zFTsKHYvwIEQnH3mgnY=;
 b=GRKfqvFSrFxbXNtEwYQ77lcHPZaxtuR1c+BYynGYEoW1+2s7JqZb82YE2X5Ej4xS0R
 pTD/vQq72yhcqlL4sMLHekdCAF4JbK4gN2rK9ZjBETE6uGWf5H4L3GD8z3o4Q125NTMD
 +62mAlWcg0qohN0pm1qURtHJ/nPa1nQDoFeXNvvhfYm3AIWUv19593Kc+fI9hlFrHwwZ
 WRFCcK2b3m1yEXzkTbmiXJSd7kw2nxEpRB8Pbpg5Jf2guAk94FQcj4TYPlIJGsLx2gV9
 /knMi7WLxuJ+oS1LLC/EJ+v4GdNh/7UjxeaW6pFMcX/26GipXopZk5p2YeaHQAwGH6Uo
 bqSQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrithpcB/9MWnQ0JXSSEGqjkZ5PN4ixTt25VgDeorXj5T/LtsS+9Ok96JBrrl4crtkUhrEODyI=@lists.denx.de
X-Gm-Message-State: AOJu0YzqidhCh/pWKBvC/Upqc2S4SqcyxYnafj0X1LHhRun3EXqd7mhu
 xkyYeCfcd5iQK5B0o1amyp3xjaf5xk98HbhG3KFU6FmwxPt83UTnMmjen/EyY3X8HZc=
X-Gm-Gg: AfdE7cnmEyxW0/uwSdmXaT2o71XzvSAt7ICNkK2Lj+uOubZiFd8m298cPDLJ4glrq3L
 /qdz6jqQj/msh8/ohtMS51btfw00B2wihUM1KMhgkV8QYR8GLQTRIgmyI/RnWXFt3yRko44zhc0
 4DG4Xegf994WycQg9E+IvRNUPNI8hXELTbV0Osg2WdMbGquSZ9yXoUkWbjQhI9cPRA+HQflBVAU
 CFuFtKBrQUpdwo+pHa05mt/1ew6v+9huLEVJgkAVuWoYm4L5mKp8rc57l/4xixCfCbiByMB9e8q
 0mUBcqM25aejPCdNTyRteCOyrd0U4yV0OFIedFclXX/1IOqdUymdYdCpaUCpbD+8BcIgJTd97E6
 eghSFw9FESRR+IktFMj+IpNJ80IeHl/zVdCJvA40YyvLfLpbMzsF0fHp8v4KirXJM5lqjI0fmCx
 QkxLHLac4dk2O9lMKDvVI9gzBrScaM/19Z2ungJuG3aQp9UQY847/+RKxP
X-Received: by 2002:a05:600c:a210:b0:495:6396:8b67 with SMTP id
 5b1f17b1804b1-49563968ffbmr38698875e9.4.1784618712429; 
 Tue, 21 Jul 2026 00:25:12 -0700 (PDT)
Received: from localhost (host-87-0-90-136.retail.telecomitalia.it.
 [87.0.90.136]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956547af7esm51805555e9.8.2026.07.21.00.25.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 00:25:12 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Jul 2026 09:25:11 +0200
Message-Id: <DK42J9UXAY1K.1TP24RIPV2MRD@baylibre.com>
Cc: "Ryder Lee" <ryder.lee@mediatek.com>, "Weijie Gao"
 <weijie.gao@mediatek.com>, "Chunfeng Yun" <chunfeng.yun@mediatek.com>,
 "Igor Belwon" <igor.belwon@mentallysanemainliners.org>, "Julien Stephan"
 <jstephan@baylibre.com>, "Marek Vasut" <marex@denx.de>, "Tom Rini"
 <trini@konsulko.com>
To: "David Lechner" <dlechner@baylibre.com>, "Carlo Caione"
 <ccaione@baylibre.com>, "GSS_MTK_Uboot_upstream"
 <GSS_MTK_Uboot_upstream@mediatek.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v3] usb: mtu3: support the current devicetree binding
X-Mailer: aerc 0.21.0
References: <20260720-ccaione-upstream-mtu3-spl-gadget-v3-1-91cff44b1622@baylibre.com>
 <ec3f60c9-4088-4767-a262-18453eb3c719@baylibre.com>
In-Reply-To: <ec3f60c9-4088-4767-a262-18453eb3c719@baylibre.com>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784618712; x=1785223512; darn=lists.denx.de;
 h=in-reply-to:references:subject:from:to:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RLlHaJoCj3/6HGuJHu9f5G06zFTsKHYvwIEQnH3mgnY=;
 b=WSQJuyzVnRIU2p3IlN7mR4fdUxrMy8rdq+kRxZ9V6qA8v1+GdnCZfLOxtzLF3vSYgw
 UDqujjsmYdr5WuQheEgxJgFa9V0HZ3DfQaGr7rFDQDqpo6L2ceRr0M8DAVBgwfnt2eX+
 67VNpVXO9CPHywsi2E2n21NtJj9fOFeGYn31PVFTkaHpGAPDnoBgJlQcpb0LRQTuvYz0
 CNr/FoaFwQB9d5GmWwEV7e+kD+n4kaSTsqasCCiG6xGnU0CU0x885OGcaURfXdsadSdg
 jiBufaEwXBjmPV39zk/FUdHs/73hTL5pSjck+2G5rMe5jYtmPFARU6Cy6y3kb1X2PuCA
 NcVg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=WSQJuyzV
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=ccaione@baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=baylibre.com header.i=@baylibre.com header.b="WSQJuyzV"; 
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

On Tue Jul 21, 2026 at 1:47 AM CEST, David Lechner wrote:
> On 7/20/26 2:53 AM, Carlo Caione wrote:

>> -	ssusb->mac_base =3D devfdt_remap_addr_name(child, "mac");
>> +	mac_addr =3D dev_read_addr_name(child, "mac");
>> +	if (mac_addr =3D=3D FDT_ADDR_T_NONE) {
>> +		dev_err(dev, "error mapping memory for mac\n");
>
> This looks like an error reading the address, not mapping the memory.

Yes, indeed, I'll fix it.

>> =20
>> -	node =3D ofnode_by_compatible(dev_ofnode(parent), "mediatek,ssusb");
>> +	node =3D ofnode_null();
>
> ofnode_for_each_subnode() initializes node, so I think setting it here
> is dead code.

Nicely spotted, thanks.

>> +	ofnode_for_each_subnode(node, dev_ofnode(parent)) {
>> +		if (ofnode_device_is_compatible(node, "mediatek,ssusb"))
>> +			break;
>> +	}
>> +
>> +	/* Current bindings keep the gadget resources on the parent node. */
>>  	if (!ofnode_valid(node))
>> -		return -ENODEV;
>> +		node =3D dev_ofnode(parent);
>> =20
>>  	name =3D ofnode_get_name(node);
>>  	dr_mode =3D usb_get_dr_mode(node);
>>=20
>> ---
>> base-commit: 96c308b8d2a6a1496c0a7366db9a7becf42d2454
>> change-id: 20260717-ccaione-upstream-mtu3-spl-gadget-aa3d39cad06a
>>=20
>> Best regards,
>> -- =20
>> Carlo Caione <ccaione@baylibre.com>
>>=20
>
> This would be a bit more clear to me if we change "current bindings"
> to "upstream bindings" everywhere (I think that is what you mean?) and
> add some comments in the code that "mediatek,ssusb" is a U-Boot-only
> thing.

I'll do.

> Also, can we remove the obsolete entries from the U-Boot devicetrees?
> arch/arm/dts/mt8183.dtsi already has "mac" in reg-names, so should be
> safe to remove ssusb child node. arch/arm/dts/mt8512.dtsi needs a bit
> more work.

Yes, for MT8512 we should first add that to the linux bindings side and
later apply the change here, so for now I'm going only to fix MT8183.
I'll try to push a patch to modify the linux bindings to address MT8512
as well.

> And we should be able to remove doc/device-tree-bindings/usb/mediatek,mtu=
3.txt
> since there are upstream bindings now.

That would be a followup patch when also the MT8512 is fixed.

thanks,

--
Carlo Caione
