Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1D8606A32A
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 18:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=n5u2OB6R;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=t0e3FHe3
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 909D980F68;
	Wed, 25 Nov 2026 18:20:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 16IscWYNAQf0; Wed, 25 Nov 2026 18:20:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9EE7080E04
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795630834;
	b=o10IncfVI6H7veK2PW+bw3ZpX3oAIVV7pGi438J2y8z1rmIeIZjaBxS+/LBR58ianKyU
	 Zg/rBKF5IuveFUgzI269idXfnSwBxLNPX6H3n5NKYQ0ygcnYVZSpltUYZB79MWq+VUJJx
	 f6GGEaqyWQ6kEEdHM55RmQw77rRW1WpfOKZCeXg9x+h0oRzqGnQW6jODakKD5mKsFuad3
	 criY7hhU3VHMIwv7AeWztEu7LAczBNZShA02U2+31ignNm46tWzy9Z+x5tZ1awovlsBHh
	 nKx7uy9hlZ8Z9kwFjnbC5dKDaa9zaeJRkzvsN/bFMJdA3Rf8oCyd8+pSvOcsIkwBixA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795630834;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=dR+XrUWu0we5Z/B90L9zfMi0tCc6MaFmVLLRNmiYNOU=;
	b=ATZkwT8IURHeZdOoAHt8f/BeBfGlvae84BHdO/zp8d/TT3bUyJYDsZ4QrhQ2m7XvLvyb
	 Y+R9D5pvIxc1eUEOsn7cJvtf3q7b7SddcBrXOtrdDaYcZmFupBODJZ/Nvl3uol6K+TPoW
	 APCbYsiO3inoeLGqlHFY75SAvTN5j7ntiH39rTrJQJ+CHrlA/05RYP8reCNrB9FWvrq45
	 QaO4y/rJ6zfgVqgcUdu/5PePBlDDIzJl2CilyY6n2eeOz6bftvTkC1E7aPl3qCnIiVOKv
	 cVaPmzAnuV0fTN7uhqOvHWKcOANjnhVns3BcS+VBP2l4AeGyBEUHgpYjXqBsYcyDyZA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795630834;
	bh=dR+XrUWu0we5Z/B90L9zfMi0tCc6MaFmVLLRNmiYNOU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n5u2OB6RpM6SLzGyR1aZYxNdYflqEnc2rWXqPrkezxMkX+p6HtbLSsFeg4zmVrqiO
	 AMQDYQf5jCU+tKmlKSJ6br9gStUKily2xEG+wSady1u03wBHvqUNx3oErZYvYVqZN+
	 IKG8tmSHjQNVQhhnZAPHJFfeCWUAW62ABD9x+wCIzJzjX8y/0l7f71JUZHvaM+1AOM
	 RgzfGkhXmkVXafdz1voLvDQhc3BSgfCr7T6BiWb3t5S5cyhVxJJRmM1WOOWHBqpJsa
	 YFd6lOcWK5s5/DqU12oIswRkhbgrkmVYhYYV1RBT1LmjdoWUGsfXFkmz1HuuDfYwPi
	 RoQWqRCkQKX7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9EE7080E04;
	Wed, 25 Nov 2026 18:20:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A6DE4325
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 18:20:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8CD6D400CB
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 18:20:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KTfk6blqJY1H for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 18:20:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2F4DB40050
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=andrew.goodbody@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=t0e3FHe3
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2F4DB40050
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 18:20:31 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4bb6057b333so29195905e9.3
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 10:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795630829; x=1796235629;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dR+XrUWu0we5Z/B90L9zfMi0tCc6MaFmVLLRNmiYNOU=;
 b=t0e3FHe3skqiVTYk5uan1PZ2nG/fA9K0ILoGeeLClikxa6T6QvJ8AjMNP6cIp3c8Xi
 KZmIj6OPifYDq5eP+EMJo0tAK112p42aLzron89B8QPaDtvdnYLzMH/Becnk2zuLsL05
 dRkd1yXcapx5uwNUmYgw99EV1JbWMc37DTvqQ1aLeTl9W+lTW0L4IOM/xn4rJ1czsGjZ
 cas24PQjQZG41kMURRIoa4LPMKDJHqFyJOWz968T4vO8dR4nnvt9ymCbCy1rmS/F3Rrr
 i2Jo59mI5WuYAFqKmtYXXjxetnboMsWBBJ6pFRpANkvUBYgFVC3czohvGCUCEpRVdlLP
 J1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795630829; x=1796235629;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dR+XrUWu0we5Z/B90L9zfMi0tCc6MaFmVLLRNmiYNOU=;
 b=s+pCVPmpNkYGqKNMmWa60RniriMpIFgR8kRIvbvCzmpMUI+LUComEom0qZ6XdSZ4RL
 o+gEroHkcTpQNPvpo8IGW6VGOac5vcXRAfp2NeM/b3G5E9tc5QffevgtPovKt3WFl4kg
 SxF4aqgx/GJqJfJ1xVfTvJC08dEiw9MkEAwQ8sZemBdMXgEQOntQVoKAXQ4yNkJDK4qx
 XVoeCfKxVieFqHX10Uj0OCaU0/PID9g9sgINCCWtJZmVybp9ZX6mNo2rev36/dy83uo3
 f7kaa3VXHMrCL5BOWWnOrNztimPXZM7HmxwlWHFF0AYj5fr1ekKmHVw0jADlceheRcLx
 jFgw==
X-Gm-Message-State: APuU4Z8DDhtRJMfWiiTmwKrBSxGv4WinuSkPEHT1biWbLTy/u78bP3mj
 U02rU+PrjkeyqvQD9WGoimAT4srUQtA7PMb0TvSw8ylVQ1dawUzkBYAEYDnmaUE1PGQ=
X-Gm-Gg: AZFdTZexosO2TxfH7ADZFS+pPa59LrQVizCZvtRT8xary+39yZUS2Y2iiaAWSL4KFh6
 j3oPSazvBmX8ZyvfORLVUXRmoYGCI6AHtblvuC/w1FJkCrNGHZtEZKOgO+klScse2CRRbXab4Vk
 wkENA952trDdGlnz4k19smfVMHTfuBhSFW+QTEePXnOs6kUnlXlqGqcn9JoxmukdypKu0yAUnol
 3Nb4Ddykm4rLsc5S+wloa05mkyy1Er3tOCr1di/p/bvSyg2n+ILKso1XigKGD3OTlVWBjtvnrgv
 r35hRIbmysXgY5cUA9ZSX8Rl9uleX/w2teTHaLrbwM+ycF+zKBvHBER+MIA/OGWcqoCkhjEFufa
 w/1i0K2jMQ3CXR5nuxjS0nqRWCf00U4btUkMwrTLu50Rvf7k7WJeBt1+q0+G9gu1h8mHzyv/Br/
 ChvYZlj+ETsnU1xQ78UgL6jyobhtSkfntKwMaKJ1WZjDexrRp1ou1k1Gc8PO70Gf/I00X3vbeV7
 Ndx6SH3hyGUsCIlymYsi/G99QRsSrNsmV0yq7OVuppJ2pEXDscXGnUuOmeQqGZTL04UmOuSd2Nw
 10q0vW8y4kVxLTBOf9UFvkZuMxDNxUjs6VUBeu3QK676zRZb6nTsZUeE0orGXw6v1FeZyWKWxTO
 yuXqbq3o=
X-Received: by 2002:a05:600c:500c:b0:4bb:82f7:549f with SMTP id
 5b1f17b1804b1-4bb8881409bmr403065255e9.19.1795630829391; 
 Wed, 25 Nov 2026 10:20:29 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:ee3:3401:61d6:dec1:43be:43eb?
 ([2a0a:ef40:ee3:3401:61d6:dec1:43be:43eb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884865b1sm538939305e9.5.2026.11.25.10.20.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 10:20:28 -0800 (PST)
Message-ID: <2a31beff-c1c6-42d8-9697-acd4cd3b57d4@linaro.org>
Date: Wed, 25 Nov 2026 18:20:28 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] test: Add more tools tests to CI
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>
References: <20261123-ci_more_tests-v1-1-52e9984f42cb@linaro.org>
 <20261124190931.GA3176972@bill-the-cat>
 <176aef67-030d-4ba8-84f0-da7dcab3b091@linaro.org>
 <20261125144235.GD3176972@bill-the-cat>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20261125144235.GD3176972@bill-the-cat>
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
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 25/11/2026 14:42, Tom Rini wrote:
> On Wed, Nov 25, 2026 at 09:47:19AM +0000, Andrew Goodbody wrote:
>> On 24/11/2026 19:09, Tom Rini wrote:
>>> On Mon, Nov 23, 2026 at 03:19:18PM +0000, Andrew Goodbody wrote:
>>>
>>>> 'make check' runs various tools tests that were not being run by the CI
>>>> scripts. Add the missing tests to the CI scripts so that CI will be a
>>>> complete super set of the local test runs such as by 'make check'.
>>>>
>>>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>>>> ---
>>>> This patch is in response to Tom asking what is tested by 'make check'
>>>> that is not tested by CI. This is the simple answer that shows what
>>>> tests are not being run by CI. This does not claim to say whether these
>>>> tests are actually useful or not.
>>>
>>> Thanks for doing this. Were you able to push this through one of the CI
>>> pipelines as well?
>> Yes, although it failed on a world build due to lack of disk space I do not
>> think that is related to my changes. For the purposes of this PR, to run
>> Azure CI, I based it on top of the series for the 'make check' fixes.
>>
>> https://github.com/u-boot/u-boot/pull/1087
> 
> Thanks for confirming. And yes, I had missed it was disk space causing
> that part of the build to fail.
Would you like this resent without the RFC prefix?

Andrew
