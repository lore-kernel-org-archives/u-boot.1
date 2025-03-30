Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61FC2C28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 22:11:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA0C480F9C;
	Mon, 31 Mar 2025 00:11:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1743372671;
	bh=ZH6PsNKhSoEBBDZ+YF0pacq12xMFu39MpPAwE/ZP4fY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uA84YmlPfDXb/yzrzkMabc7kN/bpVEibp3BlEXOPD2faI4rkMu3YuCBbsND1tlDkd
	 M3xHrFUiXXvGc8s7Hy3LAaZWlJXcaaso/DdMOoI/+EyZhKxPfN15t0/h91klje4wpw
	 kKoZgDGUx3f99vtg3sRVs62YuqBm0rrXIfp5HYS1+OZTgRYOMFy2NbpKdcIUxYGFH9
	 qJjAbXdpmHPnn0xAZkt0OZUuRJ3aBZNmfVBCTeqjAwkZ/Kjagl6HkberiQwuK8I1wl
	 B/OWquMnq+3Y3+wk81HEhYQrM9ll86rV3EwiwD/rG+VXy3BQz84yAIPheaGe3A/SQv
	 ChYYu9Gf13P8A==
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0A6F80FDA; Mon, 31 Mar 2025 00:11:09 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F293E800C1
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 00:11:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="PkoCaOvq"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D4EC8102F66E1; 
 Mon, 31 Mar 2025 00:11:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1743372665; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=ZH6PsNKhSoEBBDZ+YF0pacq12xMFu39MpPAwE/ZP4fY=;
 b=PkoCaOvqI7gwia1DhwAfDmu7Hlj+RWtQqXKHbn4wTWlISebjgab1E38WJtV9h8SGzoquIp
 E1yL/1RzXmP335mdAxo+5TSiEXo4BqDIs/r8CAnvkmVVC6hkWk/kw1hi2ARwCdyZR3SzWP
 R66C5WQvxppHhIO3ABO/Mwild4ynp2lqg5GyI51SYDsnXwBbL6vzQUJUvXdM7cW0lKXvcz
 w9X/VjEwZECSe1OnGlB99lvTvnkuvAJeESDHpQkCLBu7V3cJN44+hrV2OrLy9O+lBK5VNs
 27pgmYFeq1l9+4jrJB3XSg/KKoQyYJoVEWJvGP4XXGiTpx1co02KC9kC7W+xtA==
Message-ID: <0f4fcc93-9b9d-4fff-8110-70ac3f8bacd9@denx.de>
Date: Mon, 31 Mar 2025 00:11:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] binman: Fill in most of the imx8mimage and imx8mcst tests
To: Simon Glass <sjg@chromium.org>
Cc: Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Brian Ruley <brian.ruley@gehealthcare.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Tim Harvey <tharvey@gateworks.com>
References: <20250105203714.158480-1-marex@denx.de>
 <ff692c58-76fd-432d-a73c-191e6e753d9a@denx.de>
 <CAFLszTgHHtNzPONVhz4ZrsZqUb2Cz+CeaaNpggYpUx93=TwdRQ@mail.gmail.com>
 <cc2896cd-eb08-4c26-b86c-a4f37ccf70b5@denx.de>
 <CAFLszTh6f8efphOYgv7wMU=z6zt0E=uiG6RK5O8hE=q1WtEhhQ@mail.gmail.com>
 <dc010565-03b3-48f6-85e8-1b79e17be14d@denx.de>
 <CAFLszTjcdFKn2ayTrLx930b+P5ebBfX_EE8-aS8sOJTBsqQKHQ@mail.gmail.com>
 <8647abd3-9378-42cf-a1fa-302c7891d439@denx.de>
 <CAFLszTiw01KB4ipwqi1b64A4MP3SyU=zFRymV4moiJ_nBtnHRw@mail.gmail.com>
 <a05cf63b-820d-4b27-8f66-37a6e6c7b372@denx.de>
 <CAFLszTgF+g2OXz=L=r7rOQcNkk19GfdCrwixG8ZAsR=1rh9Fqw@mail.gmail.com>
 <f1e4014e-658b-4a47-af8d-72ef76c1b134@denx.de>
 <CAOMZO5B7cxEftN0TeTF--pKXqOmbmaFLc9mEPO4=8odrLBeypQ@mail.gmail.com>
 <f71762e5-ba15-43ec-91a3-dbdc8f8e1437@denx.de>
 <CAFLszTj69OUZj9ZBcmnsiLLvxCB+Y-rJYEW_Ep8V6WFtvXP2Nw@mail.gmail.com>
 <5bec35cc-99b9-468e-bc01-1de5dc39825c@denx.de>
 <CAFLszTh3weO+4bFuaRGR9-1zMU57R+Xcn2UVOMY9=JAtpfZgnA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAFLszTh3weO+4bFuaRGR9-1zMU57R+Xcn2UVOMY9=JAtpfZgnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 3/28/25 12:42 PM, Simon Glass wrote:
> Hi Marek,

Hello Simon,

>>>>> This patch causes a CI error:
>>>>>
>>>>> https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/1057151
>>>>
>>>> I think this might be what Simon was pointing out, but I never got any
>>>> suggestion how to solve that.
>>>
>>> There was a patch for this...and it looks like Tom has applied it:
>>>
>>> 19a342f9122 Merge patch series "binman: build_from_git: Add argument
>>> specifying branch"
>> It is in u-boot/next , but it does not seem to help ?
> 
> Did you figure it out?

No

> I'm not really sure. It works fine in my tree and I just tested it
> now. Perhaps there are some other patches missing from Tom's tree?
Can you push this tree somewhere ?
