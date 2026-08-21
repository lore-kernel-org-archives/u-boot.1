Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF35C5DF89
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 14:01:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 631F240C58;
	Fri, 21 Aug 2026 14:01:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dlVFFHCrEqXe; Fri, 21 Aug 2026 14:01:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787320863;
	bh=QoO+sty2DOmW7f5NYryEg4WO7CtsixBk2Wl4m3viq5Q=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X/9BWWL3nSxdutKiyjfC5kXSlQuPb/3g4wBgrbKTGqNGn+W2zj/+qF2kxPD19vXzA
	 zIZbmcci5ODNm1rsWSzAKDs+/qjxqAlzjnggRqtXgNaEflb2Xfnh1/6mN5OYBReDFt
	 bW2q9pEWisbhvaDYaS6jyYaNH9puns7VIlUOJGwqNYJfi+hRZmW3STRqnEfiUBNa97
	 vX3PtUsyI4g2hibGIO6MiNihOFpNafRYaMKttN16wvxfyayS8/6D1jBJxKe2e1Uqnw
	 KJY3uRjEbfaNi6OkU9R8SidXf2NVjImGMDHYewGG4dUAcWLahkXYQa0nkane+TmApP
	 nauMIMWHr+gKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1540E40C11;
	Fri, 21 Aug 2026 14:01:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D25654B8
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 14:01:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B805260649
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 14:01:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dDXySFyxk0Xm for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 14:01:00 +0000 (UTC)
X-Greylist: delayed 515 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 21 Aug 2026 14:01:00 UTC
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=os-cillation.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=os-cillation.de header.i=@os-cillation.de
 header.a=rsa-sha256 header.s=202409 header.b=bTU4haWm
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=213.165.83.196;
 helo=os-cillation.de; envelope-from=hd@os-cillation.de; receiver=<UNKNOWN> 
Received: from os-cillation.de (mx.os-c.de [213.165.83.196])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2314760648
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 14:00:59 +0000 (UTC)
Received: from core2024.osc.gmbh (ip-094-079-177-042.um30.pools.vodafone-ip.de
 [94.79.177.42])
 by os-cillation.de (Postfix) with ESMTPSA id 24ABEC0064
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 15:52:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=os-cillation.de;
 s=202409; t=1787320343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QoO+sty2DOmW7f5NYryEg4WO7CtsixBk2Wl4m3viq5Q=;
 b=bTU4haWmnOvtJ2Z2RnC9rN2YtwPI9oDQKpPpuzOa6m/Xh8U/rwNn5CPl6AIP8TXOnT3085
 4BWTMpqlYEEMgtw80vsgpMYcTGu6phwwtwajO7iQnsBuZSX8KSP/GY6hqQr+a5Edhaqs42
 mJ9l7jfFPHBwOd2aNFO/WhEZ8rcjyx23wE6e1FltfHa67NQ/PEFqig8luUjfcWnN7K7pyi
 7aUMTAz2AlxtfZIaRM1Guw/VF5CiQ7GWjzOd09FGnL5uttZWN4vLBQ8P45K/aA6hFNdd0w
 kM6axZoruE9mQE2Xuuzu9q8xA66scm0j9eSgu/NWcw84ppUklMOynBM2BYgsVA==
Authentication-Results: os-cillation.de;
 auth=pass smtp.auth=os-c@schweissgut.net smtp.mailfrom=hd@os-cillation.de
Received: from [192.168.3.45] (hd2022.osc.gmbh [192.168.3.45])
 by core2024.osc.gmbh (Postfix) with ESMTPSA id CA8E220110A
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 15:52:22 +0200 (CEST)
Message-ID: <60b9e928-e2c7-47a0-9e87-0e30d2c09fbb@os-cillation.de>
Date: Fri, 21 Aug 2026 15:52:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] env: Fix compile error for envtools
To: u-boot@lists.u-boot-project.org
References: <20260713083141.2772971-1-Jacky.Cao@sony.com>
 <MRWPR04MB1233021A0AF8D2117DBE5984888FA2@MRWPR04MB12330.eurprd04.prod.outlook.com>
 <KL1PR04MB6734F919E17C467C8B29DBD787F92@KL1PR04MB6734.apcprd04.prod.outlook.com>
 <20260714015324.GZ749385@bill-the-cat>
 <KL1PR04MB6734A43A5179C30DA1F9B9A887F92@KL1PR04MB6734.apcprd04.prod.outlook.com>
 <20260714213802.GF749385@bill-the-cat> <87wltjvct9.fsf@prevas.dk>
Content-Language: en-US
From: Hendrik Donner <hd@os-cillation.de>
Autocrypt: addr=hd@os-cillation.de; keydata=
 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 li+2
In-Reply-To: <87wltjvct9.fsf@prevas.dk>
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


Hello,

On 8/21/26 15:10, Rasmus Villemoes wrote:
> On Tue, Jul 14 2026, Tom Rini <trini@konsulko.com> wrote:
> 
>> On Tue, Jul 14, 2026 at 03:04:42AM +0000, Jacky.Cao@sony.com wrote:
>>>>> I use master branch of OSS u-boot repo and meet the issue with below
>>>>> commands:
>>>>>
>>>>> make mx6qsabrelite_defconfig
>>>>> make -j8
>>>>> make tools envtools
>>>>
>>>> What host distribution are you building on? And, <config.h> *must* come first
>>>> in the include list, for it to function correctly.
>>>
>>> Host OS is Ubuntu 22.04.3 LTS.
>>> Toolchain is Arm GNU Toolchain 11.3.Rel1(arm-none-linux-gnueabihf-).
>>> Also tried Ubuntu 24.04.4 LTS and Arm GNU Toolchain 15.3.Rel1,
>>> the issue still happens.
>>
>> So, are you on an ARM host too? You aren't specifying where you are /
>> aren't using the ARM toolchain in the above. Thanks.
> 
> It doesn't matter what toolchain one uses. The mentioned commit does
> break "make envtools" for all our boards, building through Yocto. And
> when I build manually using my distro's cross-compiler, the same thing
> happens.
> 
> Note, it's not the board build itself that breaks, only the "make
> envtools", which I assume few people do these days.
> 

i have seen this issue too and now build without a board specific config
as a workaround:

make tools-only_defconfig
make envtools

Before the mentioned commit for the userspace tools relevant code
config.h was never included but env.h is shared code as far as i can tell.

Regards,
Hendrik

> Rasmus

