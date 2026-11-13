Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F699606A8A3
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 18:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gq/K9pQl;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=TzQ7QvJ9
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C113B81547;
	Fri, 13 Nov 2026 18:18:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ic0gvSaIBj-m; Fri, 13 Nov 2026 18:18:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CE91A81309
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794593929;
	b=k9RPtp/NAVtVYRpD06+sapdMgYPpWbf0ngO7DYQBYYLt9rdU5kpxE2kSxIm6o4UHMMxW
	 tQpYSOVyPsU0UmhOjYcORBCLugtDQjmRPQ+O6VeBfJRLcbJM1MQduM+FzZkKOMSIZERmE
	 tgan4YhY6ropwLUe4bwFSatAneg/rwkkCQDkK2P54jW1N/V2U397mM6p+vjqSHT1nzGQX
	 3WtTBKlDW86vsPlqnM4E1kjnmH+PB7CAy2RTDt0LRi/swopnw9w6J20dRj9Ix40jscrTC
	 kx1nFpLJTlvI1uJ7DwhRZddZP5TUFHjhi2uXqdeivDl4wM8KIT5/aoKyuO++lSwjt6A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794593929;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tg6aWUcT7hY7+HA0bCjy1mwtAi0fIumDbyOItDrbtzk=;
	b=o4MdEQBYRxwG5pf+TQxAKOLxY5gJVKJJNiMwOjfyL8axnzn3cFYeUhViFFz0HmMvP4C6
	 sataN5LBL/6AATXoPMFsEXf53i4RJ5KtMkqu5EG/CUkUCGMScH0vI7RA7AZ0d7HJ6lfbH
	 DKGnufjgopFHmCB0yyJyZdEZ+A4A2ePcukFA0rfGDNQd1Qy1/TzuSuvZLnf6MsfGlqYm2
	 YOuIFqAcc5WPsTePYg1c84Wu1sgfmg9qArD8QAHl1PjcoaBOoOC3U5S/rn8ZV4uVNS15A
	 OyNvg9QsYpnl1eXaXXWvX32NAIikL7QzYUOpUrf7HdJF6wtEI2SKEpSKp/qmgb7FHxg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794593928;
	bh=tg6aWUcT7hY7+HA0bCjy1mwtAi0fIumDbyOItDrbtzk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gq/K9pQlKrcQlilZB60vCVpPab0dYE5Jg4jYVvqtO2vIdAsU3zlJsuLNVYDoY9eqs
	 MnNl/2fqQTN6kV0b3Ajf/L14pe99v8ySafB7tkNLJ8Q3IReTT3D5pyndgAHKpO5cLX
	 m9k8S8mXaeEzYiouuU2VhQL1L/ZzrgmTpYPYiS7ZLvoaV9npY1kdmRLnEFnp2M+d3c
	 gTR7iqn3DCfzbMLaWG/oLVQTSXr7qajkkyB4OD0MDfOzgFM27h51I02+g3Z96UIQyb
	 kvtXjZmVfi/27aiHp7p61R0vQw5d0v1hUzWbDgrH34OS0L92tnkLnioxMXbXsYxhS0
	 E8txwQZERxpGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CE91A81309;
	Fri, 13 Nov 2026 18:18:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7119A150
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 18:18:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5FEE960D80
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 18:18:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gvhc4LDAHgDK for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 18:18:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E12D860D6E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=TzQ7QvJ9
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E12D860D6E
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 18:18:45 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-49d64a88222so354548f8f.1
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 10:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794593923; x=1795198723;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=tg6aWUcT7hY7+HA0bCjy1mwtAi0fIumDbyOItDrbtzk=;
 b=TzQ7QvJ9Dr637E3QwfGjdyo8/zwSmolZSF6ScahiEtX1nyBcwgjYaTYzdbcQNinOAn
 5WjjH1LKfcOvKP2pl2sSarCywRVYv0FcMEx332fKld4Si+70Bdx0DlfcwwEGajlTfFKQ
 eY8uPtb7urFkVIsHJtBCm+ecyMCtXCX5cZRKv1Gu5GmY+K/XzMsCKyyIavQ6J9NO/GVD
 Wk+XImNyNL1tQM9eEgYPzzOJfaYJoTYameC69OyD6pd2dUdei4f43g+Hsf3GgbQ0TVhf
 T3+Ci/02SsElfA8zJ5B4Q3RtoaLLGHmdBjb+ML1Hnv0aow882XlQnq0N4i03ja69gXc3
 nA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794593923; x=1795198723;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tg6aWUcT7hY7+HA0bCjy1mwtAi0fIumDbyOItDrbtzk=;
 b=Rs37nUgFm84urKw/uMyiV9uY2cqeo5c6lzMc3xOkBk2QEBRcf93sbL1SpXp0vhdfnG
 1XjlzwY8OSK2imGsOMaV4ybEU51ann8vNDvwCj4++8itTx9zgTsGxrTFDP1hHCoiefoJ
 FAOuFeAGilWbeG2E1RzMfKe1HnFzhaEbHK3IezlyI8SThwFPw/dc7Q66NDdjluQmSf/E
 ipaMf0RbTcTLH17z7SkJ5nRlNPDl7UpyERs9nX0+4dA0FoV7wIP8f59jrxQcOFIFu8BU
 BmZ9sV4XWsa5gGrML8kLc6NgJahHVhGCpI15OofMfaz/DLYcbjkd4Yv2qxFW1jdd5M+O
 v0wA==
X-Forwarded-Encrypted: i=1;
 AL+hErE69EaK6SkMQFPjSlg4iOxxmyiUhGc23xUdF5YzcvqLD7EisSq1Ny4IyO4MOJzAyW6VP2aV4yk=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+/+UKDTDni7hWALWJ1L9RtwYN06OJXKgT+l6KNhtJqrKY/aTGN
 w80nBNfk0AQfsK1wr1VoDjZO8/7eABbz/wu3UnU44h0kyH/dCDh732HAZAXbsPTzHvC7FvA1jT3
 CQ77c
X-Gm-Gg: AYBFou2L/3dkIH7wNb2CzgYX2a9SJnmW+EuWC7pBZrDVDvmJ1QvY0ae/Df+77kdi3Iz
 Nq1nRs7zb/4mRvhWkL+mlz0iye2To9vZS/yNDuYd5nJm9l4qyrkwt2BwSWrjm7Ok/wvHeXYTVXp
 LiPrgkDXv0i+HEHWcFVSXr62X00EfSgCd2JwWbH/WH01kLrCT7BvPDnTfoyesgLtfsGN26mTatm
 0aD0pPnLbsCRZQj5XEUrE8CWtNRgeV+mkv2LKNxqW3cHoq1HbeoIYKaiLijxss0ct/CurmhPEZ/
 jIGh592+mP22IHGHfBkAtp8o2IfcPyEt6OS9VVXIscNhdNEBh/YnDSShT1IqKOD+BXeIQW/Srci
 X7pznajJFx5iS16ae3P9ZzEz+hdVKeYxxQRILRCMfHuLZg2JaVQbxBLFidMZUabIe8Vw4C1P4QP
 TbdFsRdMIt56n/SRgieyWWuBltHQ/aah93mQn8JYL6SwE19k8s4ZMvlDAQ7QdNAFAyEjqAsBIfo
 ZqCVbNFKOsJDm0sAHZKdHCi4Ite1tSXZznjebHrXqtnmB9yMK45rKAf0c3L6iP5lIcDTrlExbKG
 N1EGRqqa5uPO5yaxHS4Yq+spd+UYn+S+J0+Lu7L6Qw07QN5FHfqx3B41t+YBT+mcye+uE9K7Nb4
 S6nSeEvE=
X-Received: by 2002:a05:6000:4a18:b0:498:be72:6364 with SMTP id
 ffacd0b85a97d-49b0287c332mr13445403f8f.19.1794593923133; 
 Fri, 13 Nov 2026 10:18:43 -0800 (PST)
Received: from [172.16.11.226] (i68975BB5.versanet.de. [104.151.91.181])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c6020bb7dsm6452164f8f.33.2026.11.13.10.18.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Nov 2026 10:18:42 -0800 (PST)
Message-ID: <67e7e8ba-172e-4d89-b5ec-0c1c936f6c75@linaro.org>
Date: Fri, 13 Nov 2026 19:18:41 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] tools: qcom: mkmbn: Updates to support ipq5210
To: Tom Rini <trini@konsulko.com>
Cc: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org, Neil Armstrong <neil.armstrong@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
References: <20261106-ipq5210-v4-0-5af12cc2b601@oss.qualcomm.com>
 <a2b6bc3d-db58-4882-9964-ae0a1fb218e1@linaro.org>
 <20261112163645.GE554944@bill-the-cat>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20261112163645.GE554944@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/12/26 17:36, Tom Rini wrote:
> On Thu, Nov 12, 2026 at 05:21:36PM +0100, Casey Connolly wrote:
>>
>>
>> On 06/11/2026 07:07, Varadarajan Narayanan wrote:
>>> As part of adding Qualcomm ipq5210 SoC U-Boot SPL & U-Boot proper support,
>>> the mkmbn script has to be upgraded to create images that can be used
>>> in the ipq5210 SoC.
>>>
>>> These changes are to address the feedback in the 'Qualcomm IPQ5210 SoC
>>> bringup' series [1] to use mkbn.
>>>
>>> 1 - https://lore.kernel.org/u-boot/78ff6a8d-5c63-4bc2-bf1e-6b71b8f9c6cf@linaro.org/
>>>
>>> While at it, fix the MBN version number for ipq5424.
>>>
>>> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
>>>
>>> ---
>>> Changes in v4:
>>> - Drop sm8550 full defconfig and instead add a config fragment in board/qualcomm/sm8550.config
>>
>> why this change? let's keep it consistent. please resend the defconfig
>> patch standalone, i'll pick the others here.
> 
> I asked for moving some of these to fragments because that's how tegra
> handles the case of N platforms that are defconfig + switching default
> dtb (and more or less nothing else). It's just a tiny bit more typing
> for humans to do the build and easily supported in
> OE/buildroot/deb/rpm/etc.

ahh i see, i think i missed that - apologies.

i've thought about it a fair bit and I don't think I'm fully on board 
with the concept of having board support via fragments. to me they 
represent optional additional functionality, and there should be a 
strict 1 to many mapping from defconfig to board support, with fragments 
providing opinionated or usecase specific features.

If the main issue is the world build CI, would it be ok to allow 
excluding defconfigs if they're trivial #include's?

There was discussion before about de-duping some of the ipq qcom 
defconfigs, and this is work I'd very much still like to see.
