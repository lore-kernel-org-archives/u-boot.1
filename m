Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B550D606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 18:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=glAuI2gU;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=omxpfiNH
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7B66360771;
	Fri,  6 Nov 2026 18:41:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oBS1Gwxu3kZw; Fri,  6 Nov 2026 18:41:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9B1EE607AD
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793990468;
	b=ortpKG1/XQqlrLCX84/cTsLJSAojILwNkent0AfLhB2CJUxnvQRGEyU6x8xwkUK42RQ8
	 FogAaVyqT0pIJzxGQAONLDI49k0tx7NYs6k6dW3GOP2soDZlGH0wE2ggkN2EjuKuOASdq
	 UWx2IPgII+0tZadOPeYl/ZI9XQiDoAX9dvicZMKV3szogxY5fEYGNL1GufxXcAdFF3tZj
	 jUSbGc3kI/v35Jf/pCz7xPbQIICRDGNTkpo5JvVRc5+Zbf49ywYEJF6ZwBQGkbOLeSeru
	 S7wdNjn9qwA32JFUTL92aU7MCgYN1WZi7lH3Q2Vxr+RO5OeXdKVUQ3sEPviKGB8pt9Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793990468;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EdTxjy5UJOM2kUMwGoc5AL78DlwYkck42CXz5DTwU2U=;
	b=ar5w3TC0c9eElysTwjRrCgd6tWdOWlb7kJrn32sPNFoia4IIwVflkHlWhcxEQnrLVfTa
	 JqtdpR2U+ooSIVIwE/xeOCwpm21v/u3YbrdVDDHXo8uZJ0qx4fQ/NGy6gDOKmB0wgMPel
	 A2O2WAwaJC4IgnBHidTUFvGOZOtI/lhNFVGKQKRFLf85GFP4v83/+rWFH/NQBbbRt83zr
	 JJG5eULv4fg2aAc3JCAFZTLuAyTWjYEwUbSBeDs+tqGHGCEkh/Gi4EnFiyIngxHSNhH3s
	 eP1Pz46LEG/D6IBPNLfRg0wSIpHE8UZFnsZBgxfexmegzLti65OFHe7mJ0ehvaXELzA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=omxpfiNH;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793990468;
	bh=EdTxjy5UJOM2kUMwGoc5AL78DlwYkck42CXz5DTwU2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=glAuI2gUbzoAP0sKnUI9H7Ovi154MPJuuxXkXQpo4JVQbC2mvaW1QjTl70+AyVXCX
	 koQjOaMXrVUsp9Ir46fx5BrqzI644NsARGLtLO1DuUj98e4PFzFWHvaR1h3uKoxUXN
	 0ci8YTnYOv+hN6Hzh5zgDiNMz0WxS5mXCdxAZPqZ2/HyMB7hneYGNbx5dE8SLuhsDj
	 H7b1Loo2msJ7P1subCAvZIw2q97QHbI/aelX/gOFLoLpf7LXCadEB2VKuE4YMsF/1S
	 F0bds2aq6BXRV3uI3D3uJlpOtwHeh4PxUyHZPbEvEYefuYm2x79rtmQm7gI68V5BwG
	 8uf+Qt8zpPYPw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9B1EE607AD;
	Fri,  6 Nov 2026 18:41:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 63BD932A
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:41:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 490A660771
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:41:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ztLt3PLzokJn for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 18:41:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2469460744
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::e36"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e36; helo=mail-vs1-xe36.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=omxpfiNH
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com
 [IPv6:2607:f8b0:4864:20::e36])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2469460744
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:41:04 +0000 (UTC)
Received: by mail-vs1-xe36.google.com with SMTP id
 ada2fe7eead31-7d06ecaf709so553328137.1
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 10:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793990463; x=1794595263;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EdTxjy5UJOM2kUMwGoc5AL78DlwYkck42CXz5DTwU2U=;
 b=omxpfiNH4WQI9zWr1I8wjuoou7hFPFEfIlPCb/rVs6H9GYb1FVTpjeJLeDG3twuEdq
 6Q5+MNLlUUYbgWjPxnNN7u690ywlUnw0J7WZVyTLMdfOXmj47qrfk/ILkCbDM3GDjr5E
 zOD+w5TIqEJQB5067e3lz34eTE+3K56tSI3XV6fe9sA0caX0p37w/6X/eG34MECeXfJI
 nHR++qlIpvihy9yHuQHjsm9MrTGmqBCRdGrWLQtan+njZsGdbYPFlWO9EdWPWI/7Q+du
 Vr99Z9UDuVf5YfqCrrvPSTI7g9L5XmLFslfCTm84tJ1WBugyFtQO9WkE/KOW3iAlWNaB
 6dbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793990463; x=1794595263;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EdTxjy5UJOM2kUMwGoc5AL78DlwYkck42CXz5DTwU2U=;
 b=s70KMnEn4JJHWboWu6Z/EL13kL+VOkriK3Tei+0SNYoVC/lXCScUxBsP0UNVDKUYAk
 ZaSXfzMgGvvko/6v7tP38RoLHBaGYLMp2QZyFIA1mHFU1z4E6j6kY4dUQafg3UGbxufA
 GLvUt2m4srwhUuWVSAuDMQpX7fOBzivPmdlVO/9fyxJR22qXW2/Mqzil8qZShig4Hf3n
 z9xdGmZIz8XuRjS1Cwp2bbT5DwSOgmtsJ6iR2V9msCkuf+hse0kQlDI9NOLGTmI7Wp6e
 It1VzO8avB9KIydWJNnYzST2glZazaNmcrxQ/2tJZJ+V47oJf6/CNDnpK/O8LBz1bv4G
 VLjw==
X-Gm-Message-State: APuU4Z+jTAgps//9W3WGEIXsmU7FCXEFwDB7anx6LBRpNcFpcor36cWV
 1CsMS+KtENVxeEQG2iiNi8G6UQymXAvWjQsoZ2vK52zp5gOxaBjovPLUNPX3tSdeuzQ=
X-Gm-Gg: AYBFou2DNegt/DVvrjkbiGRA0Ga18AWsuiTVT+JR38T7iL7rIQtKlM1VZJnZEBgINyl
 n9lQYQb2qUnJSsPwY7vppaDBHnyXT6GdX/Hq+vNZSG5z3orZNjh9uL6MDgUdSvpJ/XuxmPAPYw4
 c0+NM5xCDyEe6TNf84NI/tNjWiaEMFYCRhXKxpqqd1MzTrm6Zv1s+neGhAM1F2/4k6wYlLdkY0p
 AIaiw5hEUtcvGeUv3Dr4yzrRYhfFVSSgnk0pbe5Xy2tIgzpXTkm0f7DCIeu2+wMMzTcJzjfcE/U
 h8/TeWUeVIDqQecN4mcUbcBl154bcmSZjI6JopC5ewKc+QVMjmoQx/y7nypSOAPm8RAg/xJRm0e
 Jky8ekvuBBKRbRM8DPp9gRfn3aTp/jPlVfWAXv3/jUUT5wJBHudB56VwXorz5YrMvVsXu0wlpqQ
 1wzCJ3N+YwsYWTuxV2iR9riIinFHfnQkmzglIa9jQw83HsQAizyNG7DUBoc/Yu88404TpBV+uQt
 ULMUmkjONYwG3A8tuy6CLhozys9cQGgkN3rjZQ6bQa9kj7dcoWmf74WgMr5ygXnhpnwWY9Fh4o/
 cZywBSUQJwnO6UodRq8WJlNw7apTvXYWbvr/f//CJHEWqu/POed/iysLlGXdknDg7MNhPes1KeH
 CirIM7Ob2mu2HhiQGbkEjueWCjTTVIa9UbeZ7VtTJSbWL8w==
X-Received: by 2002:a05:6102:f11:b0:7bf:74c1:b607 with SMTP id
 ada2fe7eead31-7d2a16b4725mr2011737137.34.1793990463260; 
 Fri, 06 Nov 2026 10:41:03 -0800 (PST)
Received: from localhost ([204.244.107.52]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5ecc64a6174sm1834926e0c.5.2026.11.06.10.41.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 10:41:02 -0800 (PST)
Date: Fri, 6 Nov 2026 13:41:02 -0500
From: Ralph Siemsen <ralph.siemsen@linaro.org>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, E Shattow <e@freeshell.de>
Subject: Re: [PATCH v2] doc: develop/sending_patches: add tips for series
Message-ID: <au4fPht4wT72RFUD@maple.netwinder.org>
References: <20261104-doc-sending-patches-v2-1-c0a90ff6c049@linaro.org>
 <76240a0d-96ed-4a8b-9336-8cc96c6e6e4f@cherry.de>
 <auyTzNmT63e_mEWO@maple.netwinder.org>
 <fc54cf9e-e56f-427b-b390-fbb2c9ea5c1c@cherry.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <fc54cf9e-e56f-427b-b390-fbb2c9ea5c1c@cherry.de>
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

On Thu, Nov 05, 2026 at 04:46:17PM +0100, Quentin Schulz wrote:
>Hi Ralph,
>
>On 11/5/26 3:33 PM, Ralph Siemsen wrote:
>>I also agree that it is hard to detect the actual dependencies. And in 
>>fact they are not static: when a reviewer of one series requests 
>>changes, it can often impact other series. Which suggests that there 
>>is a dependency, even if it was not apparent initially.
>>
>
>At some point, there's also "don't send too many series at once". If 
>your series A requires big changes in series B, it either means it 
>should be series A+B, or that series B was sent too early and we 
>should focus on answering design questions in series A before having a 
>look at series B. Sometimes patience pays off in the long run.

When adding a new SoC, we end up with series A+B and often many more. 
All of that code needs to be written in order to get the device to boot, 
so it is generally not possible to "upstream" any of it until it's all 
functional. (I don't like to send out untested code!)

The problem then becomes, which series to send first. Inevitably, in at 
least one of the series, a reviewer will suggest another approach, 
perhaps to extend some existing subsystem, or simply to do certain 
things a different way.

Unfortunately such suggestions frequently result in changes to the other 
series. These changes are hard to anticipate or plan for. Sometimes I 
try to send an early preview "RFC" to help identify such issues. But 
even then, during the actual merge, further changes are requested, once 
again with ripple effects on other series.

Sending out the series in a different order would not avoid this problem 
in general. Specifically because it is hard to know which parts will 
generate friction with reviewers. My guesses have been wrong more often 
than not in this regard.

Not sure there is anything we can really do about it, but I can totally 
understand why someone would send large "add new SoC xyz" patch series. 
It keeps everything together and the ripple effect of one change can be 
seen more clearly, than if all the pieces were done in separate series 
over a longer time period, with goalposts being moved along the way.

Anyhow, I've posted v3, with a focus on making it easier for the 
reviewers and the future code maintainer.

Regards,
Ralph
