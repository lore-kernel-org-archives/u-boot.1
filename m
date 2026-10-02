Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32178CA5FCE
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 00:22:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CF70F605FD;
	Fri,  2 Oct 2026 00:22:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NgGvA3UFEXIj; Fri,  2 Oct 2026 00:22:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 26E4260B01
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790900559;
	b=RTJZLrgP+ZTv7U6BVFXJxibTTsp63vpRVyp1ilRmtnB/QJ2WaNXxPVDeeX/tO2KilOz6
	 VtEIpUzJ13tR+JRCbPGGuWLJG0dAoWQRJTQmOQkKJhQTHHNyVky8Pg4v0LgJiPpNFzznp
	 yummfeM/Cr235W/iaFiauaH0SUtDOXP5mkICCc6jkTL4vG/FBN6KkvHnMFSvHW3TSMBHd
	 rJtK7it1kBm533Id02QocTU2fH2Caep13aOWgtG2EN0CdqMKakEp+lR8BZmCiPfY+WQET
	 PMKUmmIS/UKaDYI19wN0n28/Tt+uut3tmVGv21pSTKLohgyk+jJxrgU0VJb90ym4HCQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790900559;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=rLDhAPTVjbnr3Ir8jJgJFhNXq9t7YuRU9KEidJMHEec=;
	b=YnR5Ckz4PnPys52fE7XiCVVdhCpKorKVbQ1NL3oCJwjifZ1aeP4B5dPrKEolpIeTmFog
	 as2M4Sgi8qeuRz8Ge7+12uy1j6buDyZWLeDzxUicur6U07/RzbUqnceR9I0knc6fce/8l
	 FGLPsJ0/abmHFo7zOLt6Zp/Aix2PBaep692vSAaZjebYpSweLTqBJvpFKOvNZcbYxD24K
	 1oyE20jtAtjSEErCFYCnWrJUxWO0HUFiQKhvqbUk3m2vb6RDatjmgigkn7ZtTxHCXmDHV
	 faN9A/GNaElOC8gyuVbvAzPKuWo7xnbOkBMyVUq66c7AJ/PtobgjlBXrltmK6CGK+rA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=pSXuVAWE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790900559;
	bh=rLDhAPTVjbnr3Ir8jJgJFhNXq9t7YuRU9KEidJMHEec=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OdhAFt9rXrJWw9xSZN+9VJhGeRs5l8RXYRQZUUkYcsvcLm4jSFWXjUMNRietLqlRJ
	 xOy3k2RHrFIh6N2y6g9WwfFn5KusnFcoaAGIo1/1cWZbQOMXx0cDt0CqQ3OXWwBzC2
	 UpPWPVcB8y8hXthwsqsPdiot+NT6MrgpYhfJuVPNjHpKPtBqQgrbHATSM7wtc4kP0k
	 4TjJOD3Ijl2jNMnoHr+/LLrakt19yk0QjLSaHsy+SsUEHy5TrP66u1uY6ymbscD56c
	 l1VgQ2QXWrHHtCjSVkvmusj7vSgOtch1hFfROEjjZBqgXuWjodjzp7+hEhkBBGDDvP
	 orGtSKXg2gGcQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 26E4260B01;
	Fri,  2 Oct 2026 00:22:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6FE9032F
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 00:22:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5555B60B01
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 00:22:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PFHrozKhzMw8 for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 00:22:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 873C460880
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790900557;
 b=eTSWTZNYTUPfxc2CyKByiClkVU6SIqo9vaOzeTHEK7VGfI84oUImM31BF7KJwVHgch6C
 LEDTQSUA6Dyl/bIFce4PkwaXPEPclEjaWqHpzM8BSB+SkgcBzblTSkRmCAO/iPvj0A9nS
 rcERRH/APkAwXAqD3dpe2s3ARk2+ufBYxDzmbW1J88TYiSqGWtD0GJJ0YEflAsAX3JHNT
 8CM4syBjbsR6/R2+XdHoDjaeEIYUSJ3fCvoh9ak2YjzWpY7p6FmzNYlQGidA26hfS4Dpz
 Dggl/WINGgAndSQkigoR3RNwi5onPTFXFCIcjL8kWgSn8DzUihtyH2bRYKHZImkvjZw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790900557;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=rLDhAPTVjbnr3Ir8jJgJFhNXq9t7YuRU9KEidJMHEec=;
 b=YQRtRStdRDQTozlxWn2J0M7P2W/CDJJ2R8WE3GV/2dY6O3OQD2eE6obU4lJ/FrXCMVyJ
 E0pp2ZWgPdhcW30C1KbhLldlX8d5bQdHLawYzMl7h1Xv4lTHPSPvLvhurMSwXYap6zlsg
 zxvJIRbnfDGfcnflBEEnQUI3RqvaYC1OI+PEBwJQRg+LCToG6TAMl9AyUWcWR3WEZI6Yq
 x22+RrFZx38rwJgcbyxy1+OBnn/8NlsIdhmyxAI/qM+Zn0kLfYH0Zgjh9RDdiPmig+MBV
 dPaDwiDsYaJabMRgviT5dHIsqnAkbl7RuB8sJ773HVO61XLoD0ELZYP//173XzVR48g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=pSXuVAWE; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:32::11; helo=mail-oi2-x11.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=pSXuVAWE
Received: from mail-oi2-x11.google.com (mail-oi2-x11.google.com
 [IPv6:2607:f8b0:4864:32::11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 873C460880
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 00:22:35 +0000 (UTC)
Received: by mail-oi2-x11.google.com with SMTP id
 5614622812f47-4c4923c9429so3492955b6e.1
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 17:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790900554; x=1791505354;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rLDhAPTVjbnr3Ir8jJgJFhNXq9t7YuRU9KEidJMHEec=;
 b=pSXuVAWExhxi1E142rbwaaxhymKvwxCa7aYxRHphyLl6aXmT0zbd/Yjfqf3YMokv8j
 93opl5cPCC5qi6SwFNGdV/XD2RkvgsMFjQwxVh+zmsdw7nZLiLHbdkE3ptfgrOMayu/b
 nhP6Kv7qgQvWHLjxNvmF4QMyxydGzUMh4SiwWDujn+AvZBUY/KDFJtG4UMjPp+Ao+4rU
 nu2hORuSx2rErIaKNc3ZxjjcpQiBsHwiSz6eYyPINQN3kOlOyv9XDMWEhFm8vRhUcVS9
 ftm7ajwFrLiwNwpxQELoowxDgbiHFCx6Ronwwrb6HYnN16ERLhn1DWJJsMbueKF88Ok/
 QbVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790900554; x=1791505354;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rLDhAPTVjbnr3Ir8jJgJFhNXq9t7YuRU9KEidJMHEec=;
 b=ySQMu1TNvNeZSssZtOEpGEC2y8rhrweAz+fhOs7DOG9elfnpplGOmF6kqa1wY/SAaY
 hLL4NKdZ+lrf3n/uJTzS+OlNBi1iJdJm/wZBCX+huV9YhrbIvYFRo4i84D5WvBNu/Ta5
 JrIG2w1Rgi4K0p5k4imoQRiXAVUQZ3jDkfzw3LeEoDvy9e2c3OlkBPsfK9bg5dunw9TA
 QKotTFniZrmBlkuMGw60fDl5MxMDIXBCgPMeJI/mBeXa6n6lkaLVLrwqc/BFLo9mevsk
 PgJKykRbGNdjpxtuYVExcGzD62VlK+saRnnq2f1F8afvYALq9R7E4b7Ihxl1pgFGYqfZ
 nzXA==
X-Forwarded-Encrypted: i=1;
 AKwUvByhkH/QkUczLdWOwHCRf5SnlmfOaiF9dScHQdThWwfhPivRq+SxuoeDH17LO00Bv6EhwL6ejmY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lIiDTLQaJZTZ8tmuUpjZDwWTxmPqN7+wmQy/wrzfJrart0Q5rG
 1aENy9jclCHEtWqkY7PRToF5EMwE6HGSBe6L0Cy++AChhSNP28cssQDdn94i4x/S9pM=
X-Gm-Gg: AYBFou3DpVlT1D6WrS2bQo7nY9fjiDYmnJuf+1IviNBkoDBYVXM8V78hcpBfdN7RN4l
 YQu6yxpHCt+37/1uwVeHCI8KYhVqdLemczZSvlhHhTbiItY42h/32Mmi5bXSDosAvplcpz6eeqH
 IOdC8yP8sbeXORAx6HK0rNmv4pVY+o+d/rgkvou1sCWLHjWbMrr+sdH5FPDZ8gBAV2TjYWPZe/7
 ezNaYrOQJhHVPp/sjq5vg2SmrGNfHfGmN80c8gBpx86NWsMWVL+6dZDv1ant+ZfQxl4/Z5+YJmh
 kYKOYRDisz9BNHVM7dEOjIgb7yFp4seXERkFeKqP0xlSGBnI/+0kKN//cGCiUj3vOFHRlSZSa22
 i7XN3gC9DcUx6lZHDsdtnCgbyLU26mHrsFGAmMPn2YstDPCHQsrqs6+I4n9qSwucaIlF8O1eHsh
 8xiH0ucr6mqsWYnyKVwaJfQlEErPkPJihfFN3uckWFi3RIJ1n4gLPC01hvU1T6Qe4/LlW3vWf6h
 uSXmam6mtPfqroEv3dyx6jHjIeEUVlDJ6WQWe2geI9/zn1o
X-Received: by 2002:a05:6808:4fcc:b0:4b9:e65b:8c33 with SMTP id
 5614622812f47-4f529905f6amr1052481b6e.33.1790900554690; 
 Thu, 01 Oct 2026 17:22:34 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b543:49c5:7c72:a244?
 ([2600:8803:e7e4:500:b543:49c5:7c72:a244])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4f523d9ea7csm944789b6e.4.2026.10.01.17.22.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 17:22:34 -0700 (PDT)
Message-ID: <e1d13aac-cab9-414c-9e60-8f03d09188cb@baylibre.com>
Date: Thu, 1 Oct 2026 19:22:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] video: mediatek: add ovl component
To: Julien Stephan <jstephan@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Heiko Schocher <hs@nabladev.com>, Johan Jonker <jbx6244@gmail.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 Pavlo Yadvychuk <pyadvychuk@baylibre.com>
References: <20260928-mt8365-mt8366-add-dsi-support-v1-0-212f51b1742b@baylibre.com>
 <20260928-mt8365-mt8366-add-dsi-support-v1-2-212f51b1742b@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260928-mt8365-mt8366-add-dsi-support-v1-2-212f51b1742b@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 9/28/26 10:08 AM, Julien Stephan wrote:
> The overlay (ovl) is the entry point of the video pipeline on some
> MediaTek SoCs, such as the MT8365 and the MT8366: it reads the layers
> from DRAM and blends them into the stream handed to the rest of the
> pipeline.
> 
...

> +#define DISP_REG_OVL_CLRFMT_EXT	0x2d0
> +#define OVL_CON_CLRFMT_BIT_DEPTH_MASK(n) (GENMASK(1, 0) << (4 * (n)))
> +#define OVL_CON_CLRFMT_BIT_DEPTH(depth, n) ((depth) << (4 * (n)))
> +#define OVL_CON_CLRFMT_8_BIT		0

nit: inconsistent indent in this block

