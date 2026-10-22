Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB92606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 23:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JWDAhNR5;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Yg0aasKj
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 63386607E4;
	Thu, 22 Oct 2026 23:07:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EGRdiVV1l-Sp; Thu, 22 Oct 2026 23:07:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5A6A5608C0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792710425;
	b=rsWu4gTDYMcIY7fQ1TAeuEhc7laAgRtI0cfp0WuHs3V74tn+JU5tRubnmjQgmcTwdYhU
	 iW7tMlphEBqVIJ+5ef59LR4vOUVmCbfn1LXTUSCtnobxOEF8jPwStbF0WiB1nh1eug2np
	 Yrdu7QoGXGUEBFs79t1XyGNyvKAAbshwuzGOltzuH3V3VmAc2Hvv6DUvZFVbZgfokYc2A
	 OjrroV3pkCRwEAZaX5qxqgvWxNwfC3tcxGfESIU4CQ+PN3QAdMw9kwQO/QDI1HJ2mEScx
	 j8zCRqag4RQBnET0ldVVhVN+esdSxyoFaCdCI9TXM4mgsSEtfE36C77qUDoseDfOnWw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792710425;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=72UbbXAjtoiAH5iT3vEmfK7zvduR0ifCpf6r+EoETrs=;
	b=T0dtljAsLKEmrNt51hkx3MnFdLqPUpJvgEkDaOOuRKHHyZI2IrbeV0DYNSZTv2HpSWa+
	 fRkXnUIOTSmiU3Ltcy8CUlS15+8OMZNIT+z2FV0NPSwx0ch/Zdt4q/uifEi+uOYdDmizT
	 CY1VIgQHg0NOutn6PY5BOvbO+w2wcmcdXcJbNRrIzgW/qSg21SwoDheZw5pMAtxdssjQ7
	 gikmPi857pHOQWaBNZiDEQ8CFBTgdpI1Xo3TPl6P2ZeHpLOkiqDOu5RKyHBN0mRE+uPcS
	 rzRD3LcE6hsG6JFBak/ASxTWqL3ckL/0y40oC6LFYHWJgbONFoVRmlzmEGMY8Gh7zag==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792710425;
	bh=72UbbXAjtoiAH5iT3vEmfK7zvduR0ifCpf6r+EoETrs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JWDAhNR5mwjyV1X9vzcsVd9a+78dnL101oG8syDExiI4xsOwutRhvqqQUnAOWfjAm
	 aoe78UxovysLynpzqXn0e2zfRP00d0hYUWzjqQewkpTITq5NgbMyY4eC6lVfKNM5fG
	 4a9qtYSBPbKHnrYqdgTb1QFviD5rGm3+8xoBuLLQrxf5aG0cmjwB1RofHtr9ZnUM1l
	 tbHBoogUrwKOwWEUHGkIhFr+pj8OWQx3cvgcTd8OCYyIIBAbywWra9JXhMDgCvaXIV
	 I/YNTnC6+KKTpUaveDAF1KURv6Dzo60vHr90XxmScjxqbincexk97DWIFXxFfUnBra
	 WAhLY3B7X3iJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5A6A5608C0;
	Thu, 22 Oct 2026 23:07:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0AF311DE
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:07:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F0E4281490
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:07:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KQMiFdyhs2Zn for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 23:07:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CA4AD81466
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792710423;
 b=dfiyd2zHxkQFWFB1nsB8fuOftUwJc8ETYbFLzbqiZ71MRAsvRya1U4s3ewCX577goEDQ
 /G3iti9932APJZxMJnTBThVrN8CRQZyxclUBrhzIIWwTi7g+z8nbqCZja/Lm7b0RXKeVL
 Z0bjO18QgkuCaYisCHrdXVZKoxc63wjmnf1Px9ztzuXhGC+MJhNaoG+kPSIt0nYsHRlgr
 BUeONxrXfaM7KtbCuqIgXEIBHier2zmtCsDmXFwa4XeZNcX+g4QNyBkQye9ocf98s2uEY
 vai+w+EDllj4QPmjpCOWoM2E4BUR4y04J+Ac97DxrdbzOe3vWk68ELVfaaTIxcsCXbg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792710423;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=72UbbXAjtoiAH5iT3vEmfK7zvduR0ifCpf6r+EoETrs=;
 b=nQZtlnVNhX7WMHxHWeu4B1jX+MzMn4kjQyy/tXWbPRLtuYvQFhbU0CrzcgfMknue0jHN
 2Byl6vF/NjiA95Xh0i8xKjCBvJKAiA7IPMmbQpFgutsvjtmUVontThk6qaZPWFsaxGUgP
 KpXByk1KhJCsjtpb3wCJ0VUa67ZAinnn7iWJQPqenV225SXOtgkDIUCCl250ow3w1BUtZ
 ePm/PbVa4OP9ujfltTfElZMxTQpH3b4F2K8ysYp1VdcX+WqL4OeSAun4eqVjNmIBrPGEq
 MTWG5ftfNjp6fR99g+LvHZ/ePlq15gBBOeAo48OS7YCDNNwu5WL1ckikC8sFffMBCwg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Yg0aasKj; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22d; helo=mail-oi1-x22d.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Yg0aasKj
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CA4AD81466
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:07:02 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-4ab8cb2a6e4so277804b6e.0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792710421; x=1793315221;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=72UbbXAjtoiAH5iT3vEmfK7zvduR0ifCpf6r+EoETrs=;
 b=Yg0aasKjvBsSiTMIaam1j7CqIvferDGo/kEGQqW90S7kxsFm5OfgHoL29ngF/I1cjz
 7chvfzPhzbsQWc9sSnBvHRSPueWFw8BAQO9p6VecLIEYKF+RDfb/5lbEOTWlT+/SJYw0
 +S2GiPm4TTdmPLkZeses1lvAHrq5sSvZCc9Beyho9STG6Sz4B3ATaxwTmUJ1dgs5QyG1
 9HsnRRHJzvZcV18t/Q/GkjM0UR6nhFgIfgbNqnS8echDQ/zWhCzm753HdXUGiG/JVBIE
 CkJ0OqGA8/7WNG4M6+a+Ake6ZMFY8nUyiUu7mw4qeVe1zfP2DidboGiqA61pahfsGYtT
 fwbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792710421; x=1793315221;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=72UbbXAjtoiAH5iT3vEmfK7zvduR0ifCpf6r+EoETrs=;
 b=jpUUR9b/V3wFQ7LjFL/QpSjyc6HZVNpZyJsQAmhuJtCaSyaojF0ZXkiBA6Vpu2zvg/
 ccsBLlZQJhv/WTMVzF5gFmE98Xp8a4yTpvAx+RMKXgDNzLAZghVb6SiLQpF5cAKqRd7d
 zE+hSTSPki6Lsj4UnxOzrlinXlZYri3JI31/UzWJT+Cek/UlVJ0DDUa1SC76cl/d9WAX
 QckIMS+4JxyuctY8i59zCV7vs4S0G7Pm7N2NOSMULR3ooWS6KA0QEtvThU7ZB6UzthnZ
 L7bdghaHIUYbJ48ev1Wa9RqR5t3/oYMVGFJegjSt4xETA5hdpL3S6AyPeX1V9k7pyWch
 Bx8w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxq69z5XXQmG4aiW/as1fuMqV31aQOXIT6arHTfM4M9v60DF8RsEy0HF1i9c6VYZMd+qusGKlE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYK2UMpWzn7JAhtfbwz2XM2Ks9wOKs34g8UBK+vQdeinsVzb4hzy
 r2iM28neuiRkOzdrYSQ/HVT2/0noC7q+dSnjGijMPXxDTDxCI8z8qDw5X24Qfd34INQ=
X-Gm-Gg: AYBFou38q/d/I1KCAI+1HFSqjokpncIfHN5+SrVBMVfgFI4yBKJJMxSenPkQjNg1eR1
 fpykTgpJ61tU3QPSo88q0T/dyBA6yJHGxbPPPRm+a1aeFNEPeNIK2AaH0RKfeuafZoBv2UaxcGv
 6jTTtXh18T1IXF9NHPLXGFKT6GPSC+hwbfpBNJHEVJNRSIp+/k9VATsXy8h3pjT1jPIR/wKP080
 fFOvLP5tBik8vazDpkelFor3DGN5va85uCYUn+61e9dsvgVrwRZt5Ou2G1keP1Hz6os8vSm0CQl
 RDq3RWoW65wxWj7dQf2kP9ZEic9iBdoiyyvQqIrKRVKdRm2ppaghtY/cHHVvLcSPjEoxvDHkEcz
 dFzGES7ltnannVmrKK+GMJ/qy046Aot/uuN1SeK/MRugFexzuq9nmeI77P09/0S4n4Sso/LHRG0
 Kz/ieCCLkcYFgBUTpVPWMntN6n3Wo/6AI94kt9MOgF6F2i6Is7Q5ahtKeZZs7PlUgvq2aR6PQcB
 R28uqDz8s933tjs8t7MfcnoHmW1RBMGuhf5/FN3eTt4EieswMmQozPV6lONwJt4UFLAyt4Hp7x/
 g/mKdlfBfg1wma9KSAuw+FXdVjl0Hg==
X-Received: by 2002:a05:6808:1b2c:b0:53b:ca1f:1850 with SMTP id
 5614622812f47-55be862a5e8mr367974b6e.28.1792710421394; 
 Thu, 22 Oct 2026 16:07:01 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:d0bd:a587:44ef:f6bb?
 ([2600:8803:e7e4:500:d0bd:a587:44ef:f6bb])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-55be90bf98fsm283851b6e.0.2026.10.22.16.06.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 16:07:00 -0700 (PDT)
Message-ID: <a65e5b4d-7013-4969-93a7-632dd51da46b@baylibre.com>
Date: Thu, 22 Oct 2026 18:06:58 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] video: mediatek: add an eDP driver
To: Julien Stephan <jstephan@baylibre.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
References: <20261009-mtk-genio-720-edp-v1-0-4fbcf5b2904d@baylibre.com>
 <20261009-mtk-genio-720-edp-v1-9-4fbcf5b2904d@baylibre.com>
 <179188123839.53105.16613390010590944006.b4-review@b4>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <179188123839.53105.16613390010590944006.b4-review@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/13/26 3:47 AM, Julien Stephan wrote:
>> Add a video uclass driver for the embedded DisplayPort transmitter found
>> on MediaTek SoCs such as the MT8189.
>>
>> The register programming, the AUX transport and the link training
>> sequence are based on the Linux driver drivers/gpu/drm/mediatek/mtk_dp.c,
>> reduced to what a bootloader needs: one panel, one mode, no hot plug
>> handling and no audio. The PHY is a device of its own, driven through
>> the PHY uclass, as the in-flight "drm: MediaTek DisplayPort cleanups and
>> MT8196 eDP" series does in Linux. Register offsets are therefore relative
>> to the transmitter itself, without the 0x2000 the PHY used to occupy
>> ahead of it.
>>
>> The driver owns the whole output path: it brings up the vdosys0 front
>> end (OVL, RDMA, SMI and the display mutex), routes it to the DVO output
>> stage, and drives the transmitter and its PHY.
>>
>> On probe the driver powers the panel and its transmitter up, reads the
>> panel's EDID over the AUX channel and takes its preferred mode, trains
>> the link with rate and lane count fallback, programs the video stream
>> and hands the resulting framebuffer to the video uclass. Failures are
>> propagated where the reference driver discards them, because DRM can
>> retry a modeset and a bootloader cannot.
>>
>> On removal it hands the link back quiescent: the backlight goes off, the
>> stream is muted, the panel is put in D3, and the PHY and the panel supply
>> are turned off. The display domain itself is powered off when the DVO is
>> removed.
>>
>> The driver requests no clock. The transmitter generates its link clock
>> internally, and CLK_TOP_EDP_SEL, the eDP mux, is the parent of the DVO's
>> pixel gate, so it is driven through the DVO.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>>
>> diff --git a/drivers/video/mediatek/Kconfig b/drivers/video/mediatek/Kconfig
>> index 6e9ad26ab54..f26ce979077 100644
>> --- a/drivers/video/mediatek/Kconfig
>> +++ b/drivers/video/mediatek/Kconfig
>> @@ -57,3 +57,25 @@ config VIDEO_MEDIATEK_HDMI
>>  	  connected display, selects its preferred mode and drives the
>>  	  vdosys1 display pipeline (MDP RDMA, padding, merge, ETHDR
>>  	  mixer, DPI) to scan out the U-Boot framebuffer over HDMI.
>> +
>> +config VIDEO_MEDIATEK_EDP
> 
> can you sort it?  Should go before VIDEO_MEDIATEK_HDMI. Same in the
> Makefile below
> 
>> +	bool "eDP video path for MediaTek SoCs"
>> +	depends on VIDEO && ARCH_MEDIATEK
>> +	depends on ARM64 && CLK && PHY && POWER_DOMAIN
>> +	select ARM_SMCCC
>> +	select BACKLIGHT
>> +	select DM_REGULATOR
>> +	select I2C_EDID
>> +	select MISC
>> +	select MTK_SMI
>> +	select PHY_MTK_DP
>> +	select SYSCON
>> +	select VIDEO_MEDIATEK_DISP_COMP
>> +	select VIDEO_MEDIATEK_DISP_PIPELINE
>> +	select VIDEO_MEDIATEK_DVO
> 
> VIDEO_MEDIATEK_DVO already selects VIDEO_MEDIATEK_DISP_COMP and MISC. Do
> we want to add them here again?

The eDP driver uses them directly, so like a #include, I think it makes
sense to include them here rather than depending on indirect route.

> 
>> +	help
>> +	  Enable support for the embedded DisplayPort output found on
>> +	  MediaTek SoCs such as the MT8189. The driver drives the vdosys0
>> +	  display pipeline (OVL, RDMA, DVO) and the eDP transmitter, reads
>> +	  the EDID of the attached panel over the AUX channel and scans out
>> +	  the U-Boot framebuffer to it.
>> diff --git a/drivers/video/mediatek/Makefile b/drivers/video/mediatek/Makefile
>> index 3bd69617b74..0f4eb6b5c0f 100644
>> --- a/drivers/video/mediatek/Makefile
>> +++ b/drivers/video/mediatek/Makefile
>> @@ -28,3 +28,5 @@ obj-$(CONFIG_VIDEO_MEDIATEK_HDMI) += \
>>  	mtk_ethdr.o \
>>  	mtk_hdmi.o \
>>  	mtk_mdp_rdma.o
>> +
>> +obj-$(CONFIG_VIDEO_MEDIATEK_EDP) += mtk_edp.o
> 
> sort
> 

