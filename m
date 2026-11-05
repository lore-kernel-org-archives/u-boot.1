Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AC7606A326
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 14:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wpv5d67v;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=VLfBHEpG
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1736A81173;
	Thu,  5 Nov 2026 14:33:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2iHrUPT0W_KB; Thu,  5 Nov 2026 14:33:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 57C8C81177
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793889236;
	b=U9VRx8ktXlzneCw1hV+iJTWuLO6//zWQDaq+PUABZ1h6x0nO4S9HVSltJxmzPIETA+L/
	 9tpA9r0xQMf/JoGmotVdIrQdmgU6MrUH0M5dcw4vVxoej1lX5tAdir/SbvxGtmyGLch80
	 OihfnyletpPPYz7NQUiXprVcMRJLUrthQDqz9XLDx7pFlU9h0bQW+6bay/9F8D0m2jTAP
	 MwEng5jjOV1ayznTrfJldmfpSZ1adlTwfQdhdM4iCBaTpMr9w5rRlvEt78xACoW/B22Cp
	 EEb8l+cBYH2x8cHZpa+dxZQsqRyPoHssg0qiGJhFMJD6dLmZ0Q9vNDB0p87cZ9RxWTA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793889236;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6IIkAz7TEQLZBWAICHEj5bgbej2ozJc3NfJ2STUUNfA=;
	b=PX00P8O1Cz4fWGt09KjzXxo4MRTsnv5p8gwPih+0fPjScrL4Ulk6Bn0Dw82H8Zn1c/+d
	 EfotKS+wFnDk0dqIc3Qpj3i5L5w8FbUzcftbQZc95i3KKi3tIAScnHX15x63REe6nTMDp
	 FM8KY6jHplWSim56pGDP+dDWjq77bkZa2mR75nm3GvTdzCifqm1ONAzN8yYokyrETM3d5
	 Cd5QmikW1x5wNiYC/ol9v+3ZgkCg+rjebAD4E0Ui4oLcY8KybL/2H/YI+/RfkJjqFkZGw
	 eTUpXCQO+j25UwK2gRopWmHKaM8qRdr5631kGMkA9oiMYkgkIFyNXQCW5T6OaYSriGQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793889236;
	bh=6IIkAz7TEQLZBWAICHEj5bgbej2ozJc3NfJ2STUUNfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wpv5d67vanMeopd3+RwWiadIc3l1cPW7b5NLnn2R4oVRKVioQuX96PIjaFyNvFHAD
	 3OUwjOPPT8RBeeUd+QOkITz6QcQAK09pSRXXBwdvq/xzU1s156iZceDZmdFRf2dLKK
	 upSnNddPXEzvLi1XkqjFMxVMjXqPmnr3GReGDcU8rFUHTsUczSZ2Oi7ujFKwE5lfnX
	 XKSgrCFCGqgwWXGeI5nIy5QCi0peqSRrWqLlg9EGOpYQTGLLpkP9qv1mvCpQTi8CXo
	 wpn/Iv+vxqBPgpAW4KyYHOjRYsGrLCHQVSd/t7ueMMjH3gjN2t702r65tmvLmYVYzT
	 RSbTzF1qh1raQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 57C8C81177;
	Thu,  5 Nov 2026 14:33:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 23CA3235
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 14:33:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 09A5540889
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 14:33:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wv1wmxzYVOrS for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 14:33:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EEF84407F0
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a2f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a2f; helo=mail-vk1-xa2f.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=VLfBHEpG
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com
 [IPv6:2607:f8b0:4864:20::a2f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EEF84407F0
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 14:33:51 +0000 (UTC)
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-5ebf39def3aso679569e0c.3
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 06:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793889230; x=1794494030;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6IIkAz7TEQLZBWAICHEj5bgbej2ozJc3NfJ2STUUNfA=;
 b=VLfBHEpGjzcbhahC8kCZe8RjQIrNfxCuxx0uH3cEpaAgrnnRMoXctDdSe3UgTtdTE4
 M6+rVF+/ZUdihyynKuX1JpmjF8kmR9EJbwNQ8eOvxF1Ly7N22Y5Lv3aVEjd6FCxvofw+
 hchE8aNHWqzwYGxPjmWSpf1e3id8QqJdmAu6ufnP4DHoAK93WQErz1Eg49f5+ly8FKSq
 OBcQp/StjtzHNC4dgPx0s6G+/GkVI9//7Zd8Emq3p05xqccVCFX4IO8jDmjAafxZ/lqs
 XU7Rm15fG0pC1IY+qjVZTGQ6MVlyXZ8ektKRQuJxUhw6u1w9fFYTIY0vgpUUzyZ3LCDz
 spuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793889230; x=1794494030;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6IIkAz7TEQLZBWAICHEj5bgbej2ozJc3NfJ2STUUNfA=;
 b=Er3uzrr1tWQhnTrEh6iOHRlEpMlr3zT7mwY4N6ToArG3t+VRtXcempEijjOaC5Wcj4
 6IFhjlomNTBhBBco0PfW1U52UW+dsuNveW5K9ZiPPdCRduw3qukyDJCEnIZ91u1WLXan
 KCXGMDzdVnWXYcVJeXZ7SSaL1zvJ9iliJVrtU3bWHHSgQ2cRpcCLR2OUIsv7GJc/aA/z
 C/o7Iy+zRD5fv8XYZv+FAygh47mp2TM+xDHi3SJKA4halmqeWuHw/ZV1lwbY6mAr2+IH
 4mUKLpNFaomTB5nLvqHbvtiQPs0zagkg48nIxizlo6cMpGJDhOJMjm5FNuSqrMA87EnQ
 4Vcw==
X-Gm-Message-State: APuU4Z8O4HV4sqzPozd/cz4ulHTFurJfSPedufV9rlZRUDpRUmZZ77PC
 VyQFZH/btYoSgPpEO4vSrRsxB0W94TPGVcvsXmhkjrxgCWzsKL1qIDLYoxG3L2dY08w=
X-Gm-Gg: AYBFou0SwxlJV29hRRSoiZAc1DjfGcXhvhih60ViPeJu6OKHweaqxIP0z/8Ux1uVxzf
 qFPT9SfgWaMB44TA5kGmPTWfQhR4vSogla6L7JxhZwc7+UqBRw5c/agufx9PVlsN/zBTSN222Gg
 nRhUK7yeFXIBTmkpM4W1MFf7Pm0F0PbE06hO7mTAEzUOhGEFgjYMe7txqTtcVBt6Bs7sly3No4g
 tXqDqu6A9+UefHR6VP+79XVaZlZFF3CMqjWtZ/I83x4SukxlIRDdoM0j0M0XEe/mtbuEFGsG4iZ
 qQU3AG1UVyO6lqk9xwcTEF52K91izjULQ/4JQNVb42nztqZMHZoLmDPR65VzxNoxEr0r+S3ZoJV
 Tt3SqyY7GO0C6SnxA12otoiWz31xdmh28WN3iUmxsxu2gZAyKIx5rfkvygiWKAjSitY3AjASEVb
 ESWleNd8yLe92JynUkA/z4wIxVi17VLbTgllFXDvT6klP1UTgid0Ug7ZZH0dMwRW740pu7208LT
 DI75nEy5jHalOx2w2XMVMrObyyDjvr2LMacp/6x/duNe1FBwKRJ+PwIT3keoOFq3unmG30CBdIq
 eUg2u5vGeDXIDH1TfEFPwQrhscoQn3DJtYAQlnIbFN6BJyllnzSoZovDSI470KnRhorIssasG/D
 3VtM4uy1qdNH7WtwTsNNW4qsXM+QWKROruVDOR2Y0cTQ1UQ==
X-Received: by 2002:a05:6122:3121:b0:5ea:c727:11fa with SMTP id
 71dfb90a1353d-5ec68292511mr9408582e0c.0.1793889230255; 
 Thu, 05 Nov 2026 06:33:50 -0800 (PST)
Received: from localhost ([204.244.107.52]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5eca8d775aesm4368901e0c.4.2026.11.05.06.33.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 06:33:49 -0800 (PST)
Date: Thu, 5 Nov 2026 09:33:48 -0500
From: Ralph Siemsen <ralph.siemsen@linaro.org>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, E Shattow <e@freeshell.de>
Subject: Re: [PATCH v2] doc: develop/sending_patches: add tips for series
Message-ID: <auyTzNmT63e_mEWO@maple.netwinder.org>
References: <20261104-doc-sending-patches-v2-1-c0a90ff6c049@linaro.org>
 <76240a0d-96ed-4a8b-9336-8cc96c6e6e4f@cherry.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <76240a0d-96ed-4a8b-9336-8cc96c6e6e4f@cherry.de>
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

On Thu, Nov 05, 2026 at 12:00:27PM +0100, Quentin Schulz wrote:
>
>On 11/4/26 8:48 PM, Ralph Siemsen wrote:
>>+Of course there are sometimes cases where a large patch series is 
>>okay:
>>+
>>+* when the changes are all in a specific area: for example when fixing a bug
>>+  in a driver, but also doing some refactoring or cleanup in the same code
>
>issue: This is typically the things we don't want to see I believe. 
>Separate bugs from refactoring, cleanup, and new features. The 
>argument is: we want the bug to be fixed as soon as possible, but we 
>*reaaaaally* like to merge full series at once, so having this kind of 
>changes mixed in a series means it's likely we'll either ask the 
>contributor to split the series, or if the non-bug-fixing part of the 
>series is controversial or not in a good state yet, unnecessarily 
>postpone the merging of the bug fix.

Maybe I should have said: "*directly related* refactoring or cleanup"?

Ideally a bug fix should be its own patch, and certainly it should not 
include any new features. But sometimes a bit of refactor/cleanup helps 
to make a bug fix easier to implement and/or understand.

>>+* when there are unavoidable dependencies between patches: keeping them
>>+  together avoids having to explain how multiple series are dependent
>
>thought: People usually struggle to detect the *actual* dependencies 
>and are usually leaning too much on "I need those two drivers to be 
>merged for the board to work" for example. We've seen this more 
>recently with a full SoC bring-up being sent as one series. Yes, the 
>SoC is unusable without all the minimally required drivers, but each 
>individual driver can and should be sent a separate series. I'm not 
>sure how we can word this better, maybe providing a real-life example 
>would be nice. This can always be improved later on, so not a blocker.

Having struggled with this myself, while I do agree with the idea of 
using separate series, it does complicate the development process. It 
means a branch for each series, and merging them together for each 
compile/test cycle. Only after doing this dozens of times did I realize 
that I could stack the branches on top of each other rather than merging 
each time. Then "git history fixup" and "git history reword" made it 
much easier to modify the stack. But all of this has to be learned and 
it is not immediately obvious.

I also agree that it is hard to detect the actual dependencies. And in 
fact they are not static: when a reviewer of one series requests 
changes, it can often impact other series. Which suggests that there is 
a dependency, even if it was not apparent initially.

>With the issue in the previous paragraph fixed, I think this is a good 
>improvement and we should merge as soon as possible.

Perhaps I should just drop the whole "Of course there are sometimes 
cases where a large patch series..." section?

Regards,
Ralph
