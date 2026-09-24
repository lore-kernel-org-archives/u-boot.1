Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C0CC9831E
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 14:26:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 69D7381E1C;
	Thu, 24 Sep 2026 14:26:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jje0m8zkQFOl; Thu, 24 Sep 2026 14:26:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6199681E06
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790259974;
	b=OZtkgSNU4p8Z4aHzqwYvg3uim98eXiBr9CUA7rODc9xzZQtUlmPg32+EgzbeZ1tfjOz2
	 NO70+hFN4JY2VoTq6C+wUx7qERQZG+jfrS7SF3TewHuxy3e1uJSazFTGRIMQhMhHFNgrr
	 GKFBFnnIL1jdReq+uSIIm4JqGVx/PBYwmn5GNbvTTi8hDzU10O/6gweZ6yCqoXujoQcDP
	 sNgiQS2KEpYsLG989lymSqDQ5TXURZ7JxP/MLqv1egwMRx1V6LaG/Qd2sp1e53GkyzmjS
	 Kj39pDJD/nwNPPXoUPBg0HHin4r2Nygoprt7kd6dYvJPWJInjxD0wlcezFEeM8K/c2w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790259974;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=O7Bk0vOESZM6oGxlpcmR659pgNv3EM2YbsOC+u0miA8=;
	b=TxyJzevadM2tDK8ObflteytdcRSPBtrGtS1vkgZvsA4FzP8o+H0Xdt3Iok13jZRw0H3x
	 P/wLFOQJcHhIPCZikM7CDQDldAYvgcWRx1hMo4QTEDjXHyghfD3eflGi+hbakgy38tg7g
	 v3tGUK42nmPBo2PKf+0Z0y9GPydp1eZePwv1yew0yfQnCvk2ebIBLCYGF1nnNfkMfGsht
	 ADpNKoEvbMiS49i8YfC2An9/BWR1q6fJBFrKpXl/aprUDP1ZlSogQBN/ypUgMB2pa7aK+
	 W+zzN5V/IHrhZSV6hqr4CCsU+qJAEaBlvySceOdgdRZGhHekbPXGnhTSzMEFk4CRtLg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790259974;
	bh=O7Bk0vOESZM6oGxlpcmR659pgNv3EM2YbsOC+u0miA8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k7nFvVCsABs7fbZq25HvvSO5yZ37MvBH2hNUTd4Spx24Em/txZ7jJtiDPcJtXxQCV
	 oc1VUlVbzX2X1VcZOO85wwKI7muAM/+FQBC/9sRWbLEdxvTsNpsQZqOx5TfAcQHXnG
	 5GyZ8iQ/vdWKe20hTKRYYu0CdZliH0CuJceXCVmWl1JfI7BpF9kX6yg36BctA5s2kR
	 e7MDKCTbzzOjRQMzTF/4jaxhvK9jHdOHDPZr1LiP44YF8QNrxpTF1NjD6DX3lk10ww
	 EYq9NxaDyoYDJYbhKDHf4jLf9eh+kwVwlp56c2ygUDNLMDMGz25+9zTBV3ypqUnkk0
	 nukno+6CQS8Lw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6199681E06;
	Thu, 24 Sep 2026 14:26:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DB024194
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 13:38:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D83E34077C
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 13:38:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OciYOJRsFHfU for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 13:38:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A09AE4069D
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790257110;
 b=oNs8jEQdnc0rersp3AnV4oQpDN/cSUDJ/E0ttBACTvPi/Wy6J1Ww7hr/XTmbKR6PZsTY
 yJeDjf36Bpowu+f/9BRwy97gi7hwcex3iB5gTyYT+w/aP7dgeatzFaK3lrK74Zp+JYlXp
 4Lqmfm/hxyGU/ro6wOKk7WUjQEshAjhLpvNSH1gPRKfRBRaOET7z3Pn/b+w9m1QPcxOst
 NLwJ5SJ8YcIRL4xnrW/ejQxWec2b2l2+ZpFZ6EA0+b21IDHI/rj9vuM73Rbl8QhiUjoz+
 +ox19K0iclEE3iJtbrJ5T7xKJdtKVt1ZNiSvVvSH7xv/N9Q3BTvn+Am2xaq5PJ/hsTQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790257110;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=O7Bk0vOESZM6oGxlpcmR659pgNv3EM2YbsOC+u0miA8=;
 b=YKFCN0VrkqABSTt+MUnDNcwXdtdhwTjqOFQuXi70sA3AWSJ01ZHCv3kTXFecNapnDKA1
 V1mid49P/ymALtt5ct2cbDaM/EvCXMHENTynCr/D29nx94XNPncqhtd00rWpwHiHPVqA5
 e04AkCWJ1TkdYejhGrEXSISE/JyBY/GkHDPUDdkEyRf7YefJ5vpqBA96+cHX6md1K70Dg
 URqxe02rkc3nvy8Z5zayKxJr7vetZcQyIlWE/AiipCoKILIQS4YPIG5XG9mYKsjvjQH4F
 fGBuqcMxXTJhZWC5GjBBS1ZgZ+8uj9RgGorDH6RGVQ9eapV6cYn4aMSPJsZoxRwcYbw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="U9/frdGo"; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=andrey.lalaev@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=U9/frdGo
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A09AE4069D
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 13:38:29 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e8185e037so11450525e9.3
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 06:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790257107; x=1790861907;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=O7Bk0vOESZM6oGxlpcmR659pgNv3EM2YbsOC+u0miA8=;
 b=U9/frdGodUkUZ09xrMhTbefB7gDCz4KH/48qMdq4PHLu2oRpn0I+rUAtAuE+qCxdh2
 D6iguw+DWi9lXoRaKqkpj1tR+nshNtc+C6H2e8bFBeZd+xyn56yXv0cnXxOD59U9GdYe
 yNk/m1Qeq4YLQvacPzZPldN2v/GOqqKPCRst/FUO+xvjWzr5tDywvTXny6mklPHIN7F5
 d59vLXBc84gQzgKIxl0RgTnXhAEIqLO6ZqxdShDpvD5Z2bvci/ovSLgs7KHjxxz60tmB
 Ai7nJbPuqHDGXqaLoL+g1GfJ1zN6z/UXjFdZ6HvHYcVTbCyavEt2q4TL+uSoaG2XCtgf
 W+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790257107; x=1790861907;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O7Bk0vOESZM6oGxlpcmR659pgNv3EM2YbsOC+u0miA8=;
 b=YL6eq5E3g+VYtMQriFKJ1tt6oUolNEcS1bi4YCTy0nw7QyTzJIm3nghi+dSSHl6vGE
 tlb1+phc9C926i4unNE/oUsNVUCdRmtk5GMkAue7hW+NIqEZ5YRNx6KD8fWqTVU3Rfpk
 fMf1y3Sq5lQ4wyXA89L3K4dm4o2eNAfh593kgpGesDeJZysprfyOGkgOwT7XrGAlEqd7
 c31uBXLGZUg9pGgGUEbN45NuuaNhIa4rbYWXjxt4Vkd0eDLRTbVPCiAvshjsy1m+7vYF
 ScgZdDKRz5/mvsWHL5R3y2cYDrarp7Lj6tH7wx9UdzD55UYquDEIuiOwPHFJeAV/fplv
 FVIQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwYdE25XIZURUCoRl7lvZFYaQLdHDZTHbSaQagMWI+pQUioGYhtH6HFIw+uWpkNa+Jr7X5i6ow=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++le5hFcR8gmAA1p19XYcwtgYG3NVkUXJzHluEBNKRNJhrmbWGLI
 wz/hFlJilqtacYRr/AMi7GP4Qoie8JChvD+CRw0fT7u1T0Ya5spr+gzS
X-Gm-Gg: AYBFou3D8RIEWvgkHA9PkekvqXmTRUmmDkzXZMc2Fv9/7e4LJ/HFpqI9sO5Un3f734b
 Q5FKJT85Pw3UypkNXqUXu46QvqJG5OEs9+gVFBAerYLGhZJZbfeuQJI5+MYjGaHyslyMDAL/Nj5
 m8KdbLpzk35BR/ZhTrrskBQNAuxG2oODiSR0LMgHmeAUMdIOLjQ5IsQP2U9F8cb3v5wWs0rt5+H
 Oih75KCDxzfgZ6WSl1EYhyV+xSmVZZhy3FJjPqdnQiAEtKOSX2LCXHzcv+imVEnvWkEkD50am0z
 MTXFpYCe3kEJEE8j+Nt8xXOkZylUGKIFTPnoIm2WIYanbwE4tqonUdXCxUNcXSk6XBPasFVNmWl
 5XXOsTJ1URX/+Wlop6xiXOvdPslpMaWxGVysYKrXKZ+wmX5BMDiq8xqcDl8XRvm2mkGchrSPEvT
 fQPA87lWumOuM1MQAxittT+LlnFQKDlmjg8caFAwbpf8+MTV9Z9pqk6h07FdZN0Y9yPcbjq+vo1
 PluXU0nLpbz8CH+XXej1Qr2YcBfJzy1ULzbH5PnwdZeS3c5Rp1FHXesG0rQV7v/A1MAzXXgT0X2
 gDO7lhiDoUsQrSm82vVZjgM7wZLHqhCYAprUckFiJc9+vUzbZnJUJzdVsTPZG8xy9JPtbNvaaTI
 zgiM=
X-Received: by 2002:a05:600c:1d0c:b0:49f:bc43:9e96 with SMTP id
 5b1f17b1804b1-49fe66d103bmr40341345e9.8.1790257106852; 
 Thu, 24 Sep 2026 06:38:26 -0700 (PDT)
Received: from ?IPV6:2a02:8388:e6ca:5780:5835:215e:3cc0:ac1c?
 (2a02-8388-e6ca-5780-5835-215e-3cc0-ac1c.cable.dynamic.v6.surfer.at.
 [2a02:8388:e6ca:5780:5835:215e:3cc0:ac1c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdf99df60sm108558765e9.1.2026.09.24.06.38.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2026 06:38:26 -0700 (PDT)
Message-ID: <68349b01-23e8-4f71-bbf5-b3b3783ef2bd@gmail.com>
Date: Thu, 24 Sep 2026 15:38:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] riscv: milkv_duo: Use upstream devicetree
To: Zhuxu Ran <zhuxu_ran@zohomail.com>, u-boot@lists.u-boot-project.org
Cc: guodong@riscstar.com, hfranco@baylibre.com, jh80.chung@samsung.com,
 junhui.liu@pigmoral.tech, leo.liang@sifive.com, lukma@denx.de, me@ziyao.cc,
 peng.fan@nxp.com, schwab@suse.de, seashell11234455@gmail.com,
 stefan.roese@mailbox.org, thomas.bonnefille@bootlin.com,
 tim609@andestech.com, trini@konsulko.com
References: <20260806-milkv-duo-upstream-dts-v3-4-917cf70a2337@zohomail.com>
 <20260827173540.621755-1-andrey.lalaev@gmail.com>
 <DLN8LLB3CDHM.3OGZWFAAO14M6@zohomail.com>
Content-Language: en-GB
From: Andrei Lalaev <andrey.lalaev@gmail.com>
In-Reply-To: <DLN8LLB3CDHM.3OGZWFAAO14M6@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 24 Sep 2026 14:26:13 +0000
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

Hi Zhuxu,

On 24.09.26 05:46, Zhuxu Ran wrote:
>> However, this doesn't work for U-Boot because it places its stack
>> and heap near the top of RAM, therefore region in the top of RAM
>> is not reserved.
> 
> Hi Andrei,
> 
> Thanks for reporting this, and sorry I missed your reply before
> sending v4.
> 
> You are right. U-Boot selects its relocation area before LMB
> processes the reserved-memory regions. As a result, the top of RAM
> may already be occupied by U-Boot when the coprocessor region is
> reserved.
> 
> In the next revision, I will exclude the reserved region from the 
> memory available to U-Boot. The Milk-V Duo 256M has a similar reserved 
> region at the top of RAM, so I will address and test both boards.
> 

Please leave it as is, I was wrong. Probably 'reserved-memory' will
likely be dropped in the future. See [1].

1 - https://lore.kernel.org/sophgo/aqtKAuoVSCxcts52@inochi.infowork/

-- 
Best regards,
Andrei Lalaev
