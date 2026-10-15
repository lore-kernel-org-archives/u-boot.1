Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B43CC6B2F
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 07:48:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A5B7660825;
	Thu, 15 Oct 2026 07:48:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id svJe59wJKwEk; Thu, 15 Oct 2026 07:48:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CC490607F5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792050520;
	b=hIWJsaoc34VFNHQ901pnbwAF0OXX5fFOb1OUbK/8eh/LYrkfJMm+TPAS/6muwkDtscDJ
	 ZUHd9hghyKczHitBIfcg8hF+PreJvwYkB8byaxNGVy06RvMTVD2snAUH52+ql2Pc7XC/7
	 gfButtV582xmVx03ZRdtTFb/tukDwYVujrHLJne9ZzWyuHAAmEkqCwtSme82ciin/wo4b
	 IuNq/b9Hjd6lowfasdX4awWrCVprVIvpiK6sJAN2+bseERZj78C++ccsEdwyANFaVHn9V
	 XOMqZVt123FO7NAenjgQxmqFL09ZgSaMjovNgaEMlbhv6idRlW2uTCfGgYCyU1xB0oA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792050520;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=AT/DilyhrECmJ68fAWQ6WWRD+BH8i8Q6KoI4j6dyv4w=;
	b=QiYCpmhCwWbMdkhVU6+HTfnsEQgAPSaEcjowG6vrX6keN70ycQmNC72PQhc6GYao0Pzu
	 V14ma0PFlDYWePTmetGWFa24TrbfL1nBOe/COHmfrrXV2pEeKEVxx2grWDnSQf2fn0wzC
	 a2SGtcO81g/hsewg8L5YDKvSDbrmk8oGPz8EwQs2xiBDAbR+cALK0sn89j/KCWSwF/6mQ
	 moVguMepSJ+eC759xTEH9JrxSRCTOyQSQa5lgsSxU+iKBPB8Sx9XKPXLMpTYPxY6hTAmn
	 DlZBT+PcGZpOF+3HcBErb4iTlTiRGn6xucQqckbLoyhqBnnq0hGom3VZwa7qiek3XXA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=NYEew9Qr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792050519;
	bh=AT/DilyhrECmJ68fAWQ6WWRD+BH8i8Q6KoI4j6dyv4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OMgPiCLqkFZ0HvFjr/ozvc0/W3bj6ZET0BWWcR+25sDZEQNjx5ZtcWNpe3FhKiEv1
	 N+6WBpJQkY0WezO5Ht4LCqCL8qSlXSEgpNbr9gJwOuRM5PiuQf2W3tAU1OqMDxAzuV
	 0d+udcSdN2MOFD6OX70ty8HgMUsUFnKcaw58sQSC7iOq8C6xiBBh1PfuNgoozVw9b6
	 Q7AZih9k+lk66nZBc7hXhTBMuTBKkASZWlAvriR6M8Ivu9Ouhvmt/9acNRC1mkYyNL
	 oyEpRBB17LRYTaKC56DqY+NqzvJB2Ga3oC8QDC6dWTVgiUfBQ8hC30MTy2pZ9MWAkW
	 KgU58kPjvagng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CC490607F5;
	Thu, 15 Oct 2026 07:48:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7BB5C1DE
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 07:48:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6D7BE607F5
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 07:48:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rJYblEZD0Lr4 for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 07:48:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8801760787
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=212.27.42.2
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792050517;
 b=J0XNBpK0TEkfpd2RP7uXVfDARO7n2wOZHM7/Pbak70Nuh4egzpaTgQhveYbKJaNncGeE
 E6R4MeCWLR1bHkTltM6D/e+2OmfEK33H1WxNZ8kaC2tqnR10GF2aBba1rl0Gyc0JC3ani
 Znp1zYxWrzNByCwn004xkLQ4FnKGML0z4PB2khiC24+LIA0R2dvsY7PmP7//HacVI7U5x
 BsPFZrATLk0RxYfs/VHajQb4h9k7lk+6FnxwkKQ0imnsVtZxc320NC5kEQlptXiOqJ4MS
 VebeO/WEnEtxVr0ZpXipCngmnjbxbcRkuoEJB3LrGND6LRwG4fqZNURJv/JzakubdxQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792050517;
 h=Received-SPF:Received:DKIM-Signature:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To;
 bh=AT/DilyhrECmJ68fAWQ6WWRD+BH8i8Q6KoI4j6dyv4w=;
 b=PZrHSgLCV4aY3TkCeJOQlTLQwyNEV3Rb+m1jeL0lHVJitVXzr6mC50wDJRnE1x3pzWK+
 mYtDbnC6SKd92u+x1jvOJE6UgPSqpOEHUOk2FZILi+pFNBmgeVNh1L2ouu+AU1V+gw+Cq
 OOfAiaJZt9KqQZFdeZGlU4Qk4/Ls4KpcBPBU4QT41qZWmPw5nuY9qgXR3e5z1cCwF8rnD
 bQ5TV2xQVMkGEMLvdYSHcPhkEKOvym2dCAFPZ8fsIf8Wfel7MlJd2/8ZYFkV6kSf1EcOv
 yY8KKTbiVZHrOaOYkwef0DWJ43r1/9oUy1oLa0yidGs1ffScjwg/o978FXn1CXzygxQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=free.fr;
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=NYEew9Qr; 
 arc=none smtp.remote-ip=212.27.42.2
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.2;
 helo=smtp2-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=NYEew9Qr
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8801760787
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 07:48:37 +0000 (UTC)
Received: from L30177.local (unknown [78.240.198.129])
 (Authenticated sender: vjardin@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id 37B2B2003C3;
 Thu, 15 Oct 2026 09:48:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1792050515;
 bh=qtqCpz488FPSvQgMIeDaH8l4Ig5EFuZbBZCrCUU1h60=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NYEew9QrXNL29HOckvELP6rfmYFSFGekVUsZcu/bFt+T/4ccyXkHhQ6wbNIp/UFZM
 dtE+k+I0wIPHYxQCgtI9K6pYywpAxyS4mGmFv/1si8Cp/CGvo+fKOXXQbHeePrHV1i
 nJJ/+oI6BenpR1YODo/BT/GmG2qgvVcifwmAs4dXo0hc96JhQOf2oox6pyoHqAHpOP
 kEPdvyOORw9CkjQ6/QUGk7TIGsxLDBdOxC162DaAR3N0iUx8fvN2pfwlQh1WG6hHw6
 S+5qH69RvmRSKpMU0gaPgLuqQ3Kt+8JVtUCWDF41/qaxqBE5gyQiGXxpn4d4igkrvl
 EiooAyBUDSi6g==
Date: Thu, 15 Oct 2026 09:48:28 +0200
From: Vincent Jardin <vjardin@free.fr>
To: Peng Fan <peng.fan@nxp.com>
Cc: u-boot@lists.u-boot-project.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v1] armv8: fsl-layerscape: icid: also find DWC3 nodes as
 fsl,ls1028a-dwc3
Message-ID: <atCFTD0J6ZvxTtsA@L30177.local>
References: <20260930060742.1446427-1-vjardin@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930060742.1446427-1-vjardin@free.fr>
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

Hi Peng,

It is a gentle ping on this patch:
  https://patchwork.ozlabs.org/project/uboot/patch/20260930060742.1446427-1-vjardin@free.fr/

It fixes the "could not find node snps,dwc3" warnings on LX2160A.
Could you have a look when you have time?

Thank you,
  Vincent
