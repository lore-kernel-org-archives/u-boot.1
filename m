Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 638ABCA6009
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 22:16:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 975E940632;
	Wed,  7 Oct 2026 22:16:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TJNHgap9bPUd; Wed,  7 Oct 2026 22:16:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B01F540852
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791411409;
	b=DZ93C6BPRbHmLOxKpHWX+odyPzsNAP+VI/CosP/318Q5EJ0gICEUTiWELBRk+zT4r3RY
	 41R/yMWLMgRiVvoIdOx77IBqiDFpuXHk1coUaArNa6K8nY+S4OgoyqMyqnAd+VugAwi+m
	 fVgfe54P+4Xv5qlNvyp+bJBeOpnFE5eG8VIBEWUP40djSeyaQd+Tz0gq5A+LfqBopxK2p
	 MJqvcZPojFkPokruHONrz2SjBURxs0ea4xlAuCuKgc0uJziE4U8P4L9NTMiAX/2yxS6qB
	 Q9ubDOuXNUDCfNCwvbVgC6PS3HllALjx+DUGkrl/YnQOXSriCJpgCF7jk2ecIgC0bNA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791411409;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ufNMA+C9M3GTrbhGFcz83WwWqv5PA8x9kty54MsaOkU=;
	b=H67OqaqJcWWgNfDdxI2P2YSsHzQGmLL9nhWpb8GBvQlUXDMf+b3xe25tMmcBVZ2lt3AG
	 Kri8iSNaIG8HmAuOOe1pnuKhyDEogXIFTL43a0YWty4LuNlGwKBJwOHUYWzKDJB4RhlIi
	 vTFVOxxb8sc/JqWi5PI4r5WsAyOqbxGudLjmXq1MxreJLWo64e+YprbxER5HFajwn922Y
	 8ij9vkehyLbPCxfceXgohwfaBb32CexEG1JEREymICem+EEPEiHt/FY5YSWvBltm/QUJQ
	 ZmnlQ6q2HhmUuLphsrV/wim7tjaAEg/tia2IZqSs6HJaYFRD2E+eyW0mYKD6PchRiUQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791411409;
	bh=ufNMA+C9M3GTrbhGFcz83WwWqv5PA8x9kty54MsaOkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fVP/xzTnVHoNfuiWWhjBzZo6XQI2chKbRMoNXJst6fOX4yqRemTfx4Lv3rpG31bXR
	 eYaVLcqmpXmlTiCDzwlaFySFBHiaLUjZtkf2/fTQGAKUDKQjmWH8rYzV2U//8xhbC1
	 7WAZlmQVLAKAdpri0BZWaobm8eInzPmlV6Yfuvp3cmX+3pJ4SUyfRbqIqdK+BryWqs
	 ys0NeesqLTob4SMZ3JXm+FbmB3zYuQv5gm8bELe7m+Gsryti3dXx2R8joBTNSLHTAU
	 P8V3nKy6r5k2APdQCnm1x8e98lcICKhy4hxOV6/6RjNtwJ6OGsLuNb9DLRsR3EhSTj
	 l6WNQ5KaPj3/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B01F540852;
	Wed,  7 Oct 2026 22:16:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C0CC475
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 21:49:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A69A68112A
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 21:49:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qsH6pZLya20c for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 21:49:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org DD4D281122
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791409757;
 b=A7uSIRkVEsil45NSHbjM7ggnBcSaIapr13gPCv3C8WVdIKSVlcNCsiKPw6OMsuO/pSMu
 QXQh+LPcyDIRQyXcc9SR7rbYnO9fOREtH+6WtPUZUmJRhYAguJ7q0KEaNIQ3XGVlMoItT
 Dc1MuDk/olQCF+q1BNfvukqST+XdNSDQoqFSANAUaUij2rFmHPpheeyvhczYLoCQJCVwH
 i4YO3lYs1ZnAe2esk1j28WjiXNLGQG+hblORMKKUU1o9aQxaCFkzFVebz+ho8w9IkpLdt
 43ymDtJosPdTYXG4jaj0UdkAjH8GyVNzCyIqDICFM1pxC8G6BN1Ps2ax6RqMNtNk3bA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791409757;
 h=Received-SPF:DKIM-Signature:Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
 bh=ufNMA+C9M3GTrbhGFcz83WwWqv5PA8x9kty54MsaOkU=;
 b=j+IrfLibetR+G9dl0kDkWrLsQJmX9QqjSnuHAAZa/J5H+Cr369kZfPfLGpD/lRMQn2jL
 ZULH76YEVn535hOswFrtSdhoHcxibDN8nNsPRinqu4sot1vODw/Gc/4ae0uezaEPfRPEL
 1JE6lWWMB0HWzbudInE6jJYGqUusYZUo+ub/cSNsLMi6XfY75T7Pzl4PjDDqKN/M9JO0M
 O8o5DOosa6zHYYJ+PVT5TuXjozhxwDkV6iYEKyUufB/Ljpvkj53gyFdqioWC4peDWUQ22
 1UeW/+iXrfCvZCbZ5+EWlK1pqvgQthNo/qyPCG9R7sIAE6JHnE/BlG5soROCnhC9uQQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=ziyao.cc; 
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=LNpWRJgd; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=LNpWRJgd
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DD4D281122
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 21:49:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791409745; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=HdL/CEZNQLuLp1Ri8ux/8eqPtqMpryDanOuOWspFoYak/jZZwruvqNZ1e7HeSF7tVsioKgZn/ejCWY3Eeo9jxK620qVku8trZiT3hervZNrA6sqwI0vDtA9jvefzyRb1r3ZvszAcS6br1djDQpPSWrwsM2sb8jFhoggyQ232EQc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791409745;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=ufNMA+C9M3GTrbhGFcz83WwWqv5PA8x9kty54MsaOkU=; 
 b=X1UpAHrl2hh+kmjidF7+8/AYUFsNGl2BRjcjx8dXu0FNM5pcIK2rHN03ZZDjr6UvycsxBgm83Md1q1HjHm94TN1MafvxJMeVp1XOLIoT7cbHk9/S5uN/FcL4qxEhNT7XN3Y7prhMVjLlRzZp7OQrAsR+tyqASORmfLUaSOCGIzk=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791409745; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=ufNMA+C9M3GTrbhGFcz83WwWqv5PA8x9kty54MsaOkU=;
 b=LNpWRJgd4CcE/5zysV+feUCdM+M6nRBr9j6lZXgEs4kr1DvEqpLs91ThmzlbVQ1J
 XN8LsmYcyuZL2Q8PVQF5abngX1o4nAePbRDTdjyppY2m0y6HAZwWcU5HMJoDXr5nFlZ
 QHwyKwbBKbfKZxY3XvJv+ZlWnq4frXwtHeVPHAFg=
Received: by smtp.zohomail.com with SMTPS id 1791409743968688.2317371651782;
 Wed, 7 Oct 2026 14:49:03 -0700 (PDT)
Date: Wed, 7 Oct 2026 21:48:59 +0000
From: Yao Zi <me@ziyao.cc>
To: Hiago De Franco <hfranco@baylibre.com>,
 Leo Yu-Chi Liang <leo.liang@sifive.com>,
 u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>,
 Zhuxu Ran <zhuxu_ran@zohomail.com>,
 Kongyang Liu <seashell11234455@gmail.com>
Subject: Re: [PATCH 0/2] riscv: cv1800b: Milk-V Duo boot fixes
Message-ID: <asa-S7LCji4uX4af@pie>
References: <20260930-256m-fixes-v1-0-69546876ff28@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930-256m-fixes-v1-0-69546876ff28@baylibre.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/291.389.60
X-ZohoMailClient: External
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

On Wed, Sep 30, 2026 at 09:17:48AM -0300, Hiago De Franco wrote:
> This series fixes two problems on the Sophgo CV1800B/SG2002 Milk-V Duo
> boards.
> 
> Patch 1 fixes the fdtfile environment variable of the Milk-V Duo 256M.
> CONFIG_DEFAULT_DEVICE_TREE is a quoted string, so the quotes ended up
> in the environment.
> 
> Patch 2 keeps U-Boot out of the memory reserved for the coprocessor
> firmware. The upstream devicetrees reserve the end of DRAM as a no-map
> region, but U-Boot relocates to ram_top, which is the end of DRAM, so
> it lands inside that region.

I think the issue solved by PATCH 2 is introduced during switching to
upstream devicetree? Could you please cooperate with Zhuxu so nothing
is broken at the first place? Thanks.

Regards,
Yao Zi

> This was tested on both Milk-V Duo 64M and 256M (CV1800B and SG2002).
> 
> Signed-off-by: Hiago De Franco <hfranco@baylibre.com>
> ---
> Hiago De Franco (2):
>       board: sophgo: milkv_duo_256m: fix fdtfile quoting
>       riscv: cpu: cv1800b: keep U-Boot out of reserved memory
