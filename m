Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44389606A338
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 09:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KvQnYwF8;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=yUvZtFck
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8851380E76;
	Wed, 25 Nov 2026 09:47:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 49mScUtQ4IVJ; Wed, 25 Nov 2026 09:47:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9853E80E37
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795600046;
	b=h36n3r5GUVquD/TKokyzrqzUbdOIuhwIdjg7kzeeFyx+yq4kN+wpBGo8mFINxDs6NXGT
	 wi74brBEDyaruSLXhllW8g86ujLH7qWZOMotDSl6WfYrnITlKIvxxzEJSeYdmAKOMlIc9
	 pyXtXoIZz7EzVjk+71P6ZXz3K91mpVb3Zd7LLe0qlqe6XbRmaNCVW1FuHVmjF+pHA5OrA
	 L+nr1EWlwznbtZ1aFvobGWZpis/m+II9eSxg07j2xk91ku8DU9yr7gQJZIs1cCI6gGl9O
	 0X2gXmvnAq3CbY4KdT94DrH/87XVy5wUA3mP8EXHIt10shfpiBAvIo1Dps9fEIqZGVw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795600046;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/B4ar4c2MpTAiEftV1fgDLsNDpQRihN9/HG40AWmoFk=;
	b=fjvz8wWrIlxfQdico68A7B/+v84GOKLzCp0Vd+ZHG1spIa+IKq1MVcSEWs4cLgHhx9UX
	 +P5usZ3mTdsymCbKG5vCViuipbjxHyj2BBhfKWwRQ32S+wnHtFd6RkJWrqCajNOImSThX
	 cLlUc3Ke0pWIuerQGqzmQ2jN/Uoj2TnajbGgZ467zySyJUj3H4AqJZSozXHC463eS+lcL
	 l+cnWY7KjAu0Z8AUSnUA2K4mB0V9aJu5H8IT9jJx23EpoeWdEHFI1c+vOfUcj4+HMvPiH
	 0TkGGX9bplRvEODWuAviIQ/zBjPpDF0M0D4lFNDj2Y6n0ARo+GxBj9RvC06/a3wvong==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795600046;
	bh=/B4ar4c2MpTAiEftV1fgDLsNDpQRihN9/HG40AWmoFk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KvQnYwF8rntyID/CSTgk6ZS7ykydXtkt5XzABCuhhDHr/LjYFZ/TLK9KxCtOAX3Rv
	 wYY+4B40n+a0AH/+CDoVWDH6EwbnlpYWsDgkMCFP799Sul9OZI6axRqpw1RZFh60ZX
	 X++6pIVWc7wKs1ypi95K1e32g1fL24uYCXSbn+BxUFXqyMxrU2MqAePNf66M/QkjHO
	 T1e4QuanOjNlV8OQOWpGl+krL7HM6nrQa06XjcDZYZqynxDOFL9S/+aay5oo83cEob
	 xcbwAtsi41MtQJbkNDQp6HRG2vbEd5445w4W9E8Ll+3AdfvHIEI4YlohpfHGM6qT/i
	 yMHzsDL8RsV5g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9853E80E37;
	Wed, 25 Nov 2026 09:47:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D3555311
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 09:47:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C4AB7606EF
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 09:47:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PluUQ-SqdWPt for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 09:47:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 839C3605E8
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=andrew.goodbody@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=yUvZtFck
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 839C3605E8
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 09:47:22 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4bb85e07aadso68503965e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 01:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795600041; x=1796204841;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/B4ar4c2MpTAiEftV1fgDLsNDpQRihN9/HG40AWmoFk=;
 b=yUvZtFcksrr+EsBu0TbCRyBzaWOOUppv3RMUVv0CxMHDTEKKNPhmziBIuRXTcJr+PE
 T8xsLg2LIBw8Hd75GbVaiY8xRY/Tp8/zZLiYFLn3DZItJg11qujAmpw6nw/WO2Xckw/V
 WjuxiVUGpEqQGNtyp1qeHC5hvZ5ETnYw3L/wZ594vuowC9rFquTV5j1TZOS2koOD7xqq
 GQfle6cYv521SeeIYVan31Tl4wgIlWCF03vl+gmSzdPLo6XzkOSeAU98l4U+nDlb81tB
 1sx5sBBucNziaCjr59kap965zM4CuLTFio7bli7ktigbBdJREOmNH4by/5hp+V98kMxx
 flVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795600041; x=1796204841;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/B4ar4c2MpTAiEftV1fgDLsNDpQRihN9/HG40AWmoFk=;
 b=QLr6PkvmHFGQM8Xtifvq7l8XDmzCCtHBWBbV924rRVQl30IHNvRaEfs32mJXeQ+o3P
 ZyMN4ze1r0O27amN3SeN62aT9P0LtoI+6c92Ov5pFF/8MJC+ZzCtU9aJQ0esKqmQSTOx
 OoBC2Fxg6PM7z136+w7mUotECdIuj11cQcaWVislJBya/hPP22pCBSTALVPdbs2YelZG
 Ce0ETC0QKd9ibEcIuqY7fXHUxocazCfygWpLPid8iwvFGWjss/+x5SZnoqqLtx4x4Zu7
 +oQs6RJWWo2VAoX1tzLS2PnhHX/IiBdnZdTW7yg5hmWLg8ccHRFwKRlAus/fO0X0N9nD
 XZHQ==
X-Gm-Message-State: APuU4Z/FQluBnFRwZpkcKFanCiE0c5Zkzw/HjPZXu8+q9qcPnyISLuAS
 oAe50+ozm2gbfEHSYd/TTrVuxJGme6nmcW4jrTVEIc3tVQtM9/zaZ11NIupfxyZgRe4=
X-Gm-Gg: AZFdTZdTwGyr0kwIzOFjM5OF+bTv53UCyTH9vhwS6tLe9uwAbBfcpQ5bNOIZ08KP5a2
 kLxCqaUYpgWbQ/iFCniaTQRs8XOwU7GXn23HG2TWgQoF9az9/MyVcKllzLYpEGC3krQRyfXsAEH
 EgtAw/x+nq0EY97KjD27J5EBEoh9cekZmclV3eNtW/woq9nX5ayxcLMaKSFbUdSowdARb/D8rJM
 aUvKTr4FtUwVbGZ7ZPXNbxV8xQkX5Xw8YPa7qy1quhE/2VM2tuQvEav0+IQEbsHctUauNZPqump
 wczk2qr2FIvmrWq0LhSPGIDAto9uEayyUm6OEJsHGl57NSG+Q1CMm/Ix23loktqvGo2DFXtPkxZ
 rgEcVkctnBe4bMPqbwit2jdTp0SZqRg8TAbMD4h11PhPL20PeHurhoMBfEW2wmSiGfcoKcZvvpQ
 NNtqbO8nUmVbXIdlbkeZeiDyOgGnPXUezN3RuudhqomsEIGY/TOGA3kOzvdgsl9hDL9B+OwaSmx
 kGxPRh9M1tw3pJnniY54Wa9j6x/OQP+6HMM9lKhDkCS6eDIzkAUdaUJ2XtFZdey4XIKyFdGy8yZ
 /q4Si/utByiW7ka3clkX+wff4NNcXCBLHQQURRORM/xsHm+SqkaZETraYZ1G8ASbwzoQTCw6o1q
 XVDDKM0o=
X-Received: by 2002:a05:600c:a4b:b0:4a1:dade:f049 with SMTP id
 5b1f17b1804b1-4bb88806292mr357305285e9.15.1795600040844; 
 Wed, 25 Nov 2026 01:47:20 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:ee3:3401:5b1f:f1da:c88f:2170?
 ([2a0a:ef40:ee3:3401:5b1f:f1da:c88f:2170])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b110ba3sm27162294f8f.35.2026.11.25.01.47.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 01:47:19 -0800 (PST)
Message-ID: <176aef67-030d-4ba8-84f0-da7dcab3b091@linaro.org>
Date: Wed, 25 Nov 2026 09:47:19 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] test: Add more tools tests to CI
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>
References: <20261123-ci_more_tests-v1-1-52e9984f42cb@linaro.org>
 <20261124190931.GA3176972@bill-the-cat>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20261124190931.GA3176972@bill-the-cat>
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 24/11/2026 19:09, Tom Rini wrote:
> On Mon, Nov 23, 2026 at 03:19:18PM +0000, Andrew Goodbody wrote:
> 
>> 'make check' runs various tools tests that were not being run by the CI
>> scripts. Add the missing tests to the CI scripts so that CI will be a
>> complete super set of the local test runs such as by 'make check'.
>>
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> ---
>> This patch is in response to Tom asking what is tested by 'make check'
>> that is not tested by CI. This is the simple answer that shows what
>> tests are not being run by CI. This does not claim to say whether these
>> tests are actually useful or not.
> 
> Thanks for doing this. Were you able to push this through one of the CI
> pipelines as well?
Yes, although it failed on a world build due to lack of disk space I do 
not think that is related to my changes. For the purposes of this PR, to 
run Azure CI, I based it on top of the series for the 'make check' fixes.

https://github.com/u-boot/u-boot/pull/1087

Andrew
