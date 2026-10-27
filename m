Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C3F606A31B
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 07:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=s2BPVDhM;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=XTkXI4FH
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DAFB8606FA;
	Tue, 27 Oct 2026 07:46:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y4ELF9RxjHks; Tue, 27 Oct 2026 07:46:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B063F606CF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793087217;
	b=mB8tShbp2SDkZXX1soYEK2cvAwiwyxRlkC8EpYjlH53fohqyTTGMyJEE+c1DwMNLWcZq
	 MFerPtaF6Sa8pUnZe8n/bj6lZ3RSNInNRgiB0oQNbMETiRWCP7N6fiKiIqtQo4hyPF1u6
	 sYUBURkHBYLk341A19obGYIumDQGwFADSIeVWgfO5k238Wn/qGpiN5u7FmCR/rg5Zrxj1
	 NzVRZCRx3FX1bkaltrNJv04yVvl6nplUGF+Ui3ffGdk02Xz1PxdFdpI1RL47siK7E96Y6
	 Qhv5hJp++iXZVbcthieGbpdRL0AxVFf4sm8ILxh+MoC9w0JWeeiOwewQMYPLug1dxeQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793087217;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vPLW4fVnSdcLnp3Lbd/zogxe0hmbCOARBuwXGgeGliA=;
	b=s1jZLfnxLe3bxj6g6kftRBT6AZ09pLtBM2vZiHP83VT5lqEFit70kOhf4Z0p2wvkqfDM
	 df9Y2ZUYbzfjZDV3EqdwDiAA1Vg14dllFhPQVdU4Tl1nRvOMZ3s/ME6KQ+WyAKXzRdy8u
	 mdI71O2ti4K6hkRa4fhu61V3EfPe6Om3dM5pBr9aHSWes3Q9//kh4vGIcgtsITyx5DWiw
	 rO2p/XaCrtBDnXmP42RMcM3/CuT487m7pfzrPEkLQneRGgXC4d70jECxyR0a4EUW+kk8/
	 O5sx42rPCrWrErqiYmFlHrHXkkcBqG6joRJBWWPXUT+TQmy7uvAYZt/p0sjxgTPcFMg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793087217;
	bh=vPLW4fVnSdcLnp3Lbd/zogxe0hmbCOARBuwXGgeGliA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s2BPVDhMdJJYc+x67I1Wp8VC1p1eU5bIp29g/300WrvLIb4/m/RVcLCmaCCzyl/Eh
	 LWPU06ZtLrPScUz9PIoInohYuy1FVJ521mludNpuxWyFeZS8v8cqNQm8cn9llUvKd2
	 6HUvHDvDYF0ZIN7rI+l5D6B36q46+TzA9w/bCwAhF0mLSqPXbH9gwhfaF8Wg2uauAY
	 ifJcOcix9JtZ7HI2ce6JPZPcx1kun/Y3kk8v1BUQ/0dMxgiKdyKbRU97k1G4dU3Me2
	 H5fugpv1AdiQnBGn6j1m9FYYik288krJaT4+7G0kThtDcBNSek6aNXeHFO9yyZA4YK
	 QWrld+HAOX/2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B063F606CF;
	Tue, 27 Oct 2026 07:46:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4B2842F5
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 07:46:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 48D784059E
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 07:46:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7bnZzRGdPqLC for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 07:46:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 658574059B
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793087215;
 b=IFRHRZzoJ7QzmJd8mC5rvwcWo650g3px9tG+FjllRIoZR+FptpuVPN0fYMs7um3JVMQb
 uV8jYfjxsjtmn9+l8qdU5O0207mAKGIiATI//Ishb5ZZf2Oayvd+4tiJjsPf3qfCpGy8w
 cIeXngZ05I4D1rxziMvqhiSvhZz9ET6l1CbIbZu3gUoCXcoLGyq8Oh+KccadWcgQYC3ZI
 onl8d0Nb9S2bLXggEG7gjmfyFYaIbt1/GKKd4G5xdEaZ+2fLmvleBvyjfk+SAvjjNmR4Z
 elF6ZneB8rYFf1ebkfOXrSr4x1qehAQPmIfN7toUE7LN+1h+0NHPi6wYgFEo/MOetRA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793087215;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=vPLW4fVnSdcLnp3Lbd/zogxe0hmbCOARBuwXGgeGliA=;
 b=ULirybn3BnSiH0iSRglZSpQ5Qg55rG2fyHe4v+qWGIJ+D43Fq1ZS9QJs61ridNTDd36F
 VpEPHHuWgVCmP3xlWGmMYzSFnEQgJaKrCJA6fo+4UmpAmZwflVmhinv/hNiYp7tHs0QRf
 fagbXwyDOGWt19W19sy6fz1lfBD5wUa7hgR6+HX0GjDvzggqtP3i1P3PekLMaDS8Ka5dk
 IzN+JCk6w7DImuhhfo8ZG7+oxE4fwEN67TjTPx84n/mFHwybT2zT8a6wC6BtlxOY2O6fK
 rjarTBpW/dF4n4YL+rKqyStlQkGOJhoAFYMO5AkVFucECc3M6Y6Sz3ppQtAPuIPO+dw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=XTkXI4FH; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com
 header.a=rsa-sha256 header.s=dkim header.b=XTkXI4FH
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 658574059B
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 07:46:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B9DB810B830; Tue, 27 Oct 2026 08:46:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1793087209;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=vPLW4fVnSdcLnp3Lbd/zogxe0hmbCOARBuwXGgeGliA=;
 b=XTkXI4FHCu2QtnmdtCyz01M5KAtoBn1V5yO9uSTEwAe0Up/2zn5cC+HnTngGK8BD+uwZDR
 lMuoKaXjLwskuJNFqk4NtEEy7yYcT8P3dPERjJSVjQYriSBTkS0CY3X8mt9FmaIfrNf0Xq
 ESJBBtJdc15wxCyPyf8lFuFeUItGD78yjqk34AzeQVMIeLbMcqZjP2yNDr/z0tFpi9yRMf
 zrwZ1eNbQC0G47VTtfk/FySY0+jpzECXMOD+hutQ+xTJGCW6Iy3r6o8S4Vadg+VYF8h/w7
 ZIW7p2WxNv+5PQIw5huTOz8W1G38iVB4FFkFuWfljXq2mUA3EhBe43N9EEGgww==
Message-ID: <d8a62180-3baa-27b9-d98e-08665b00ec1c@nabladev.com>
Date: Tue, 27 Oct 2026 08:45:59 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH RFC 0/2] Add i2c ignore NAK support
Content-Language: en-US
To: Swamil Jain <s-jain1@ti.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org
References: <20261026-rfc_i2c_nak_suppress-v1-0-bc01e8393b9a@ti.com>
 <CAFLszTg_ob1mTz9=Nh0BHM-yZDDoyYTu4STzHgk5tWALyZ5yZw@mail.gmail.com>
 <4d4a46e9-e75b-4bc2-a0c6-88a0bbc13b3b@ti.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <4d4a46e9-e75b-4bc2-a0c6-88a0bbc13b3b@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Swamil,

On 27.10.26 08:04, Swamil Jain wrote:
> Hi Simon,
> 
> On 10/26/26 21:40, Simon Glass wrote:
>> Hi Swamil,
>>
>> On 2026-10-26T07:16:33, Swamil Jain <s-jain1@ti.com> wrote:
>>
>>> Some i2c peripherals do not require or wait for i2c ACK, so the series
>>> adds a flag(DM_I2C_CHIP_IGNORE_NAK) to ignore negative acknowledgment
>>> (NAK).
>>
>>>
>>> Our usecase is SII9022A[1] hdmi-bridge, while reading the EDID block
>>> the bridge doesn't send ACK (mentioned in programmer's guide[2], pg 22).
>>
>> Thanks for looking at this. Are you plannning to send a SII9022A driver?
> 
> Working on the sii9022a driver.
> 
>>
>> I've commented on the design on patch 1. It would also be worth
>> checking how Linux handles this for sii902x, since that driver reads
>> EDID through the bridge too.
>>
> 
> Tried following the programmer's guide but will check how linux handles
> the EDID read for sii902x.
> 
>> If the generic flag does stay, please can you add a sandbox test in
>> test/dm/i2c.c, like the existing tests for the DM_I2C_CHIP_RD_ADDRESS
>> and DM_I2C_CHIP_WR_ADDRESS flags.
> 
> As per your feedback on the patches will try not to use the generic flag and handle the case within 
> the driver itself. Will re-spin the series
> with sii902x driver as well.

@Simon: Thanks for the review!

please try to not drop me from cc, thanks!

bye,
Heiko
> 
> Regards,
> Swamil.
>>
>> Regards,
>> Simon
> 

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
