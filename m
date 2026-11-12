Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B97B60A2605
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 13:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dGAC9DiC;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=R3S3SK1R
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1AC3681547;
	Thu, 12 Nov 2026 13:21:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mrKE0fQXIX_L; Thu, 12 Nov 2026 13:21:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7079081549
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794489674;
	b=GRgGY0mvQVOc0P2XyZ7xHz6jfyoBxxrc3OkERtexiOt4IFfsvQ2DrGfI9qrACgrm9a8T
	 J/67qTGKP2WyFadlvRBiDSqwM3ChZoTE+svg8m0dvBHwhvgqKQjChSu0xaNM1g7ULj/Q2
	 epc0IWWxED8QrnI3zDxU05zRzinDrULQpxMVjMgEHDB2jkgSMC8F68Pq+Nhw0NvcPWkxI
	 so4u6s3Mu3iDa8zx1gyOIAS3azdhz5Btwt4Vvbl8D7yeI1Qt5TbYQooLLLIZjvJ2R9RQV
	 S+//9jjupDBmXtyPzdSBzTD4PbbAaR2iP8xh4/bWixbj03KskdyGb7uEryv7LH9js1Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794489674;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ttvGU8F8LPOhSuxX1H5wzHvScW2Yjg0g6ZftmrHNvws=;
	b=V3Mdv+NKFrclkbDv1+mZJ3sVg6yKUyF/gLnaO9n+WAlDhbvQuTbNgX9sIDMlN9RhmsbH
	 GX2i5vusKtkqqyk0/cl8Onmk21KlvenLzBr0PSt7YSryMKqP+Rh3KEbLzgOI5nT1fUMm4
	 anSfmM37lR5BgMJjjm7e/HsE1bUZkFA1I6GAvlH4evf5PHrx2lkkfektDTNN/sXrlC6E9
	 Wd+U8cb4204oVCNBBZnP9Si2iv/FayiqXsq0vFmN/sATG9LvS7CXYq8Z6BhqMzBUOjPnE
	 p0sjtuCYq0EFBfrNmbM9lCI5d1midrHd4qLcbtRIgm86kMIyvA1FIxLKDUL2k0BT7bQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794489674;
	bh=ttvGU8F8LPOhSuxX1H5wzHvScW2Yjg0g6ZftmrHNvws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dGAC9DiCSXv9zFXf+DpiaHMipmqWy/0QJLYTvPEPciRwGjCpuOgZV68skxWauurIi
	 aBG/94ygsU88bP0DXn0KYxycZwxukH1vKzvXdsuBctznI8zlCXXQKxVV9bgxn/C1QD
	 4RPcpCenBLlcbJKiUxzMKoFwFoHsSxnNoewTIa8Bf5nYHQwmuN82Q1oZqRhAm0y9D5
	 b5FZZal6Ph0nmMlHtabuikEmVkhHA+259ido6Bb5apoH6jqgrNDfefd/lcJQ+KnF+2
	 rpF0YxxKkj25lSdgZLDYXTOcmkY2pbod8zR1RE/UP3+D41yHM8Unjc7oJLNkPObo6j
	 D6PzCCXhvHL7g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7079081549;
	Thu, 12 Nov 2026 13:21:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7E1CCE09
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 12:20:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6FC616069B
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 12:20:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tr_7TN2_Gw_l for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 12:20:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 346E8605AD
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=R3S3SK1R
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 346E8605AD
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 12:20:33 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c505994e5f5so18810066b.1
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 04:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794486032; x=1795090832;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ttvGU8F8LPOhSuxX1H5wzHvScW2Yjg0g6ZftmrHNvws=;
 b=R3S3SK1R3pRCQAff+X2u6RHMGuaGYZlvkJI6NCJ446IEbl68DGHGKNo+ICHXGko3dF
 BB7lzypT9DZFnvWz6AJQPBSTLL3k+brt1VuGf3ly84IzoQYI5zlDZ+D8sanMemHXMgTP
 QbrqWYD0RQ8UHVz4//EzSCmBH26aG48WmUhaEd4GBfurwVcuPrqEPfmrmgY9XD4PYvur
 QnBK0bFzR7wqKghCd9QTiEFhQxQyHbrJ+v0dvlVRsdoSSMtfX8GEx44bWnXWTTeZ2fNo
 dhCGJbXd6IYmcppiOEhQDQQfjSsLAaJTCT3VXiH54IT1KyDsQKHnihXniRBfzqW656Le
 4P5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794486032; x=1795090832;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ttvGU8F8LPOhSuxX1H5wzHvScW2Yjg0g6ZftmrHNvws=;
 b=KWr6C7QYKAigDT2wHfGlEYHZ9YAOC92+bgLRQ0VnMYnjX+CxOEiypRYVLR4fNXi6Fg
 0yRtXADEXA82eSJkk6x3nQOtFpi0WCPFesvN1gYds1Tu/f8XvQga/DYlhLcZFX1USza0
 WD8P9wphHjE4LfLiHy9kvlf8cF10h1LHRe4mE6aqlSrW9zoj9MGOzAFZ/0yIUaAsmu4p
 yss8uQHHug6LS5OOlKOu8c1hfiSxldsWaY0pnWD+E083qAhh2vNmNW8cRbnSm5uusPPw
 CTdqWIij6w4NqF48NeH0D2lyx9tmPLoC8Zw5jzDU3PzKLVVGYiSCJRiGqkzU7jfjLeta
 cVGg==
X-Gm-Message-State: APuU4Z8ogC03w+jMgZBbSFeDDwhn2YqwVsSsesKDOPQGbsU11FoXkhtf
 lBDJ94fYXDB2dpANGSUJ/GzC9//xj/VLpnWogXkkKfXbfJzkIj1loR95wZBgE0FW3VI=
X-Gm-Gg: AYBFou2z6VPREbgzGiKlbFsd1uB/Zhic1z2gYNtXJbpYBcFpl5pegy4dlBiMLFmHMnq
 F/Ayp5sBbjRgBsmophOsrI3QmPfsDyTM431j+5YXdb0+16vARS9hItMGu5va4lD/oHZ/SQxbnxs
 5Nrm+i7YyWCcD+Ws9OjNXkfNpf7Ji1gbUjo+WmsFL73ujjqFyKpC3KMV8j4kCmCKCGROpLv7EHo
 hsGUswYLtVL0XeEccl/VpDL8wl5aCHnG3taegR0rY4c+bTKXX1NDAFkNEoXFgxLE3EJuitB1OZ6
 Pwdk+GPrgN8AOgwv4gMIRgT69FXkIyttMHNTTxLcFbM9liLsXupL+Nm+Lo47GV8k/4sCj/k5kPH
 6fg7dttNjg9JWCILtZfrxVfXuiCTBUt+4YsPVho9jlIKtIZZpJZyx0U2LcIYIAXFva5Z452pmGl
 CJ3RFaMQOiai1s9OIplWwdg23Fdrz63YNfwiE84oketA+qVSXpWUiwLIjqig7jRCSobhEIpJd/X
 51jCrscpfoa+aHEsSUqsyy+WNIN3aubemBzkgD5SoD8w8fAQniKSqLAlE+F6wxsdoc8/vHSfhb1
 Ozf9SrzWZXLTshLzO1B3OYv7Gz7DNfoWCRm608ArlSlFN75UkgWe4JcS04C65A==
X-Received: by 2002:a17:907:72c8:b0:c2e:8801:9139 with SMTP id
 a640c23a62f3a-c5066982807mr606290066b.1.1794486031672; 
 Thu, 12 Nov 2026 04:20:31 -0800 (PST)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c504a593b5esm339388166b.34.2026.11.12.04.20.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 04:20:31 -0800 (PST)
Date: Thu, 12 Nov 2026 13:20:29 +0100
From: Anders Roxell <anders.roxell@linaro.org>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com,
 ilias.apalodimas@linaro.org, michal.simek@amd.com,
 lukma@nabladev.com, alchark@flipper.net, jerome.forissier@arm.com,
 dlechner@baylibre.com, anshuld@ti.com, sjg@chromium.org,
 Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com
Subject: Re: [PATCH v11 00/30] usb: dwc3: part 2, make the resynced code work
Message-ID: <avWvDRPamFpE6Oh5@monster>
References: <20261107072224.3492260-1-anders.roxell@linaro.org>
 <205058d0-f257-49ce-be85-19c44bc6c5a7@mailbox.org>
 <avRoy3ghzzRPHWnu@monster>
 <b7fb9a05-6e03-4bfa-bed1-0d4319504d38@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b7fb9a05-6e03-4bfa-bed1-0d4319504d38@mailbox.org>
X-Mailman-Approved-At: Thu, 12 Nov 2026 13:21:07 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-11 17:18, Marek Vasut wrote:
> On 11/11/26 2:08 PM, Anders Roxell wrote:
> > On 2026-11-10 16:18, Marek Vasut wrote:
> > > On 11/7/26 8:21 AM, Anders Roxell wrote:
> > > 
> > 
> > [ ... ]
> > 
> > > > 
> > > > The rest is build tested only.
> > > I would like to move this series forward, so let me get input on the status.
> > > Below are the vendors which use DWC3 core that I could find in tree, can I
> > > get a go/no-go on this series from each of you ? I hope the CC is complete,
> > > if not, please add the missing people.
> > 
> > 
> > Hi Marek,
> 
> Hello Anders,

Hi Marek,

> 
> > I have v12 of part 2 ready, with the review comments you had on a
> > few patches in v11 of part 2. Part 1 did not change. Do you want me
> > to send v12? Or do you want to merge v11, and I send follow-up patches
> > with the fixes once it is merged?
> 
> I suspect this series is now v2027.04 material, since we passed -rc2 this
> week. Please give others a bit of time to test and then do a v12 sometimes
> next week -ish . Thank you.

A bit sad to miss v2027.01, but it makes sense. I will wait for more
test results and send v12 part 2 mid next week.

Cheers,
Anders
