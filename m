Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A99E5C79FB9
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 09:43:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 462FD80E7F;
	Thu, 10 Sep 2026 09:43:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y0aI3JainKoS; Thu, 10 Sep 2026 09:43:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2521380D39
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789033425;
	b=fdjjZs9PSwAu1xttWm3ES95W/UixdBgAPM+PUr80AafB32Au+ea/nYJMHWDZe8Tiq4Ln
	 vxDKet0Z8+VGk1rw50KX7xFShQrp0eXmI4jKobvT96NnHWHwn057in93X6vVFQBV+fUon
	 0+a7wvYMBcbbgqA7ivs182GEAeBrw7B7VEs/4RWda6SVjhpytQXhuIz0XVZ1bKL0sw0cR
	 JIzwZk8pF04R6wrtOzhJ4OYlg7/Bi00mpVE3IaK9536NBE3olOyQipB7uLA+P6E0l+Tph
	 ooMe5w4WxO3jVtwnhHU0Wy3ESDMnmAo5C4yTI1cqR/ZK47kvzNtIRR7K05zLLX5yBxg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789033425;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0EBWVVaCsH8eOT2Qq7sVPGazVMjcKEn9ZH1PuGIAZ2E=;
	b=VuZHekmDxpEKMkFV45e2BEdoL72uQWmZ9oc+RlXfjvaoOhUwW9Di+NyFiHHGQN7NyP4e
	 jaai11g2+iSu4XXvBKJ4RNVO6wB/KhSM97mGIRDpgMzFn02eWtgiV2BWOc/6Y/r7nxwyV
	 rY+EhY7W6baQVwhqtp2SmlZhp/RSQtz2ixJNRTO/L1tETAkeqXp8nfBItTo3azVCip+pt
	 LCw9d/bBSz3kmYM1xyAJsgpf5+eEbJAsVqO6KyzEtH1JWoIEb4HXh0tSLvoWCC4kYEvrK
	 7++me/bE2Hl4yfi9JsTUjYzCKt1xUDrLytj34Hg940UOfdbjwkHrCsO5Z5XQSKNNRSw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789033425;
	bh=0EBWVVaCsH8eOT2Qq7sVPGazVMjcKEn9ZH1PuGIAZ2E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uFZV5HG45zLdTIahynnEYaTpJ+uxVvKwZYnQ3z2DFCRkTE6cUsHDiC5veeR5Mmzrw
	 ULYJCIeQlBQ1YL0FQKYvwq2stgn683bzSEoxQ7dB4O/M1XmW4baBbCL6edKpGqX5mV
	 B+q9CUW1fKrqBbN1C34tZIu2xpib/ZwLZVPiLAeW7mFVooZlIFym89wY5DhWdtMAyG
	 hKgjdwPpU3jkWGhGbYeTUMurMf7mg0ZG/MA+TJKwo/ToQPzKq9o8lj2esUIJ0va/cl
	 s+Z2hEcNSAZ5bPAi+eGd9reb2/ODUZwDZdvYs8VURahZjXnqp0PyxREoDQwZ/iySQs
	 lY81iDZfA7JQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2521380D39;
	Thu, 10 Sep 2026 09:43:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4E01B2E3
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 09:43:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4771740A8B
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 09:43:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CAW_pq3UML1z for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 09:43:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6914240A63
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789033423;
 b=hiNDi5306A9LwsN6lBygFrM3xxeDRH+AvJamR39yAVeDutpo8f6f/sVb6Gl/EObTPKu4
 MESqFynpaveANIMg2RKNqZg/JtIdnQzt0UZM8UNNNi2LguXjDZJxwqhSadx6XCMCYy5Cx
 Ou55lhAJiaIqoAMx6ULGuG+T+9o372ZnZGNfOtUPiqu4Hq7UtyogtFXCEDwVZ6nuW1Pq2
 yrumQDB1LPZkScNlbTbiy/d5x3HZKx3FRo0f0QBkzsbargsNKtSBQM1cGzUPGNQZtFYUN
 8QC9QXaOYAn6UKCWMWVvVeyLW9eJEPKYareIvPY8EbRHagWPBCcfTQ5kB4E++g/80Dw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789033423;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=0EBWVVaCsH8eOT2Qq7sVPGazVMjcKEn9ZH1PuGIAZ2E=;
 b=CkxZTMMX7Dj6/ExRWScStbRlnqGVx2hwrQY3mEYVPeXpkKfUMnypN+YI/Iyp6gNg/kgl
 rGJ90D2Wva4jKiSdxwTPQfSaQVTfhaEbYC7b+tVwGtyCfDBuUf4kAiQyem+d01TKB8iPQ
 Q9VE7jwKhieCCD4mCfI/vfiNO72sZJ8nzUg+mjvnQ1jAyPEYTVLZ8kftYjdDirIshRTmn
 M4AoEnW4l3FTSbPKJJmyNgNokcZDRcXE9dI5/Z3T6RdlF6Gr3ZA2ByDYwz6AOyIWalKBW
 ooIaVpVme+hRs/iS4iZ44GvDllLv6ACAF4y4X8P2MGf5ObRLTZpyBuxoR22HiPGfDUQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=monstr.eu; 
 dkim=pass header.d=monstr-eu.20251104.gappssmtp.com
 header.i=@monstr-eu.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=H0DOXsEh; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::62f"
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com;
 envelope-from=monstr@monstr.eu; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=monstr-eu.20251104.gappssmtp.com
 header.i=@monstr-eu.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=H0DOXsEh
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6914240A63
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 09:43:40 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c2940d16190so202234766b.3
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 02:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20251104.gappssmtp.com; s=20251104; t=1789033418; x=1789638218;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0EBWVVaCsH8eOT2Qq7sVPGazVMjcKEn9ZH1PuGIAZ2E=;
 b=H0DOXsEhVJL8iLRuCgsKb5cwLRyHlQR2XzX8LRWM5GNhFbNlk4ds4fjZb73ZKSb0W+
 Nxsl52+ltnpS6Cop1KGkhILRxHWbW2OzfpdXVzYRv0qeBznYdfj1K+QcpX3owVcK+h6E
 Q85Huz0BDL5dBkVytvqWgdE5V5pxJGm9IQv6Cp9br2fcDZqV0C57dn9VJ1d/GJBSP30e
 95qbvmrDhPhecyevSCDj63gsnG6xnxgqf3JS7Vdb8GkhTOsLba7kqATVhmXUmY0n0A8h
 ySsFDM+E4g1tybuSLBz8h1Pp88f9/xHgnAAzQrWHuN239BTgHRehAhRTMHuYd0/aBo9G
 q69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789033418; x=1789638218;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0EBWVVaCsH8eOT2Qq7sVPGazVMjcKEn9ZH1PuGIAZ2E=;
 b=oNoDZV7D2JIAc1Ovbpr3tIvEa9cbNcAIW5x++RwTUflTbha4WPphCr7vfgV+bWVkM8
 UB6tQFqKa5vkEaiKKjz1YYIQEXQvmg+i7EjmvDFEO82uEXoWQiMqbBADnCm2hqRcXSEH
 cnmqN9mgFE1uAAT6I3BCHzn1FqEUg3xGitQ+0bBGgn1WFelImqtP7+n8w7+pNDn9jrhf
 zzBWnNTX5tX/O1Le+wA5zGt+4EtR7988oMwvwGlicZTfInv9VWB7QEtkXehs/scWhjOE
 Y6nL/FcCT1UDnv6tHPbwTmGCGZhHG1e7qLTV/8/pqumkwR9LpFoI4311kklUDCc77aW/
 Cfsg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzUTEhe4k23XtbK1ZODTAQCeJNbAy3ZX6BlHdVa139LWYYi48nPkdFpWY7gr+hC84A55wELcnY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mQ9BwUArYPXxpo5uy0mXXxq1F0g2RUQ1/pJytJyiQmPsFM3srC
 kNlU9m2NwKyP/72Gm374MOCewW3a2e6rBb5BCKwWQFA9MGZUEliA3N11eCKzPbBmog==
X-Gm-Gg: AYBFou3vLpsdnW2EJ5WUn65Q7F2uiSBZtmcUayBuo4T4Zagv/rPif3WpTRMGJdg0JAW
 Q+63/RgQ1k+XZtvtgF6f70mWcLoVI2P32pVOnaqTdliZyNy93HIkhprN0mV5ucv44u4rsMyvnkH
 rHoEyixHqvuL/R/orSrgNPFiF/C4urYD8wPaee7hqF2i/xvDQS1ZIGQ1tJMFY5ZkGqz+WQYwccF
 7O55cSbNsDHy50E/QpP5L2mOj72KuUFBMFn9vEsxaWL1XVc4HSlLBReAXgsylTnYswqI8fK7RKU
 Hhp2Ypo2pOxt6PciCrQ7Frwim0T4esz3ayZ1VptF4AkwdULm/q15b2+6b2uRyeTIR3iaAqfyZ5A
 nt0gg+7MhNA0p4O0cub0480VwAT9cNkDmZNAiL0pkqXC9RNSQGAyZcad1jRNNkEq/e4ub/Al87o
 m09kDZrdhp2wa2MA/1AmwgPW8glgXoW/83ooAKIacLA4D0i+XexCqo3fUq+3AII44ukaEa+FzkJ
 n3bybh4ipCZ6RP/xCMLj0xff2NFdDvH
X-Received: by 2002:a17:906:478f:b0:c25:91bc:ff55 with SMTP id
 a640c23a62f3a-c260ca245bfmr1553963966b.23.1789033418173; 
 Thu, 10 Sep 2026 02:43:38 -0700 (PDT)
Received: from [10.254.183.223] ([149.199.62.131])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c260d5bd618sm937387866b.56.2026.09.10.02.43.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2026 02:43:37 -0700 (PDT)
Message-ID: <905a8de9-8c62-437a-ba4b-0c8b4ef8fe00@monstr.eu>
Date: Thu, 10 Sep 2026 11:43:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] board: xilinx: Use strlcat() in board_name_decode()
To: Maarten Brock <Maarten.Brock@sttls.nl>,
 Michal Simek <michal.simek@amd.com>,
 Sriram Sriram <sriramsriram@linux.microsoft.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
Cc: Tom Rini <trini@konsulko.com>, Drew Kluemke <ankluemk@microsoft.com>
References: <20260909192047.217421-1-sriramsriram@linux.microsoft.com>
 <20260909192047.217421-2-sriramsriram@linux.microsoft.com>
 <2ec7a375-ef8c-4ecb-ad1b-cfbf3ce12b96@amd.com>
 <GV2PR05MB1194135296D564695A241EA6183BF2@GV2PR05MB11941.eurprd05.prod.outlook.com>
Content-Language: en-US
From: Michal Simek <monstr@monstr.eu>
In-Reply-To: <GV2PR05MB1194135296D564695A241EA6183BF2@GV2PR05MB11941.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 9/10/26 11:30, Maarten Brock wrote:
> Hello Michal,
> 
>> -----Original Message-----
>> From: Michal Simek <michal.simek@amd.com>
>> Sent: Thursday 10 September 2026 9:59
>>
>> On 9/10/26 09:56, Maarten Brock wrote:
>>> Hello Sriram and Drew,
>>>
>>> It seems to me that the limit of 50 for MAX_NAME_LENGTH is pretty arbitrary.
>>> If you expect it to easily overflow, why not make that larger as well?
>>
>> do you have a case where your board, carrier cards will require more then 50
>> chars? This has been designed for Kria SOM where you have name in board eeprom
>> and carrier card eeprom and it is never over 50 chars.
> 
> No, I do not. I was just following the logic in the patch comments.
> 
>> -----Original Message-----
>> From: Michal Simek <michal.simek@amd.com>
>> Sent: Thursday 10 September 2026 10:04
>>
>> On 9/9/26 21:20, Sriram Sriram wrote:
>>> From: Drew Kluemke <ankluemk@microsoft.com>
>>>
>>> board_name_decode() assembles the board name into a calloc'd buffer of
>>> MAX_NAME_LENGTH (50) bytes using strcat(). It appends CONFIG_SYS_BOARD
>>> and then, for every detected EEPROM descriptor, "-", desc->name (up to
>>> 16 characters), "-rev" and desc->revision (up to 8 characters).
>>>
>>> The length check runs only after the loop, so it cannot prevent the
>>> overflow it documents. Each descriptor contributes up to 29 characters,
>>> so a base board plus a carrier card already exceeds the buffer, and the
>>> data being concatenated comes from the EEPROM.
> 
> To me this indicates it is very easy to overflow the buffer.
> 
> I have not followed where the result of board_name_decode() goes
> and whether 50 is a logical bound there. But since it is locally defined
> without any comments it seems an arbitrary choice.
> 
> And if both these assumptions are true (expect overflow and arbitrary bound)
> then it is probably a good idea to use a larger bound.

It is used for DTB reselection to described current board setup.
If you look at arch/arm/dts/zynqmp-binman-*
the maximum amount of chars used is 37. There is still 13 chars left.

Code is prepared for covering board, carrier cards but also extension cards like 
FMCs by simply pointing via nvmem alias to whatever EEPROM in the system. I am 
not saying we would need more space but as of today I am not aware about any 
usecase which requires more. In any case if something hit that limit panic is 
thrown and we can extend it but extending it just in case make little sense to me.

Thanks,
Michal



