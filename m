Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90480606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 12:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xQEsqcWY;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=Sd9uxOGE
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 53CD840651;
	Tue, 27 Oct 2026 12:54:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8xCmcrPD_ESV; Tue, 27 Oct 2026 12:54:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 39FE0405F4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793105694;
	b=eYt6fz3DlTk7HbH8BEZLJABSk/Yi4H0bWXQ7Tx0+nlZL8wcSplt3VolHwjwBf6+QCElv
	 CxJrLLUxSeSkgxwjwrIdJXVoA/+LFsmYrgcCBhDdUhq1fcUpCjHmrtElBnhl095sO+E2+
	 d2UkpdVj41rsOzzZV0B5VTS8q6OjCXqzib53FaQ+auyL9vQxo8OyumAi3aLfT3lP6jsvN
	 k++v8xy0HVzjlavQm/Q6gWL2fiPYkwTHG6CfgLXe4+aytQSxeMuIvqKz8HucWh3CqDjxY
	 /L+ca12eb+kZMVL1ujvuejUTHCZ7Fjda6yaILZqeV3S0UvIzPi4T5xm/neT3gHYi30g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793105694;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:From:To:Cc:References:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=MiqzD02ZY/DmQBJxRR2TLuCLP24yikQyve9mz8EEjc8=;
	b=qd7DgsL8gItKf/eYuABjohm3duxk5hoELx2c7e4qjpPFn2fxjghqtf8/hY832NdHIQ2w
	 jc6DhpQKFrqgSKnUCehFuuNVvoJfySZe4dpmI+BVFWiJuqjQvaSZFJoUycLmlm3AFIxQZ
	 r+xJ1zkMqfrtvz2eIPaApCE6gDA+SLso60TUQRSgc6PoiF6IMjAoq48saoVgya7cOEc7h
	 edPq7lPeq2JTY8M2Z4XH1hp+ix5eGeqngpf568RTpk7wkCdvPETmwXNHAASb4y7O683x6
	 5s5qrYyMXz7YprbtNOc29aET9IrosAxKpQACWapoOWUB6Skb4G/YlQNotvQO/hLUK4Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793105694;
	bh=MiqzD02ZY/DmQBJxRR2TLuCLP24yikQyve9mz8EEjc8=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xQEsqcWYYBxYOOziHCitZs6g61DTw0b9XIb+J3UEhaquftR+Swe8qT2PSWNXIXTy+
	 nszj0Mc3Injc0AM+RDSNpvV5BrNAQovFpqs+GFvJ4msFhMbpLAAUo9+yU6+2Awdn36
	 JOEEsHcQKQtXyVOLhqUa7GKfTw6n8O6E47WEH2DhrJf02Ize0y6aBWnPtdgsVw7mNO
	 VeftsWWfpwTIQ4VhN6G64eLEG49KgVA+guJNNlFOvgP3Tffh1mLpb3+e7AtHiNj4Lr
	 c9awjxN+80fUisFn9KtCwhan/okMA3O6ss5UZ0hxS7IY/iq+hI+PBYo2ocmiIB/ARR
	 pkjl+HfnsvR6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 39FE0405F4;
	Tue, 27 Oct 2026 12:54:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 26297279
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:54:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0C5AE4007E
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:54:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yhI4DQfDxNwh for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 12:54:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C7CE44005F
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793105692;
 b=m4/LcgKaQNvHeFqlLdsmzNOUCV4Fko/t4KVruy8euH+tGD0+oS/cwyCTE2VRTtFQxqon
 mKq2Nj2bSgXH2PQD82PvzOYEGV2wqHrIWWrTP0G5X68V47BjgJuUEf8WLMX9hl5N4L6Ql
 gSXV/poq5NAWb0klJtAftzUeWoUUvBBpFJzbGOeKuijbPBRYvvodznqJEJt4BTnLNojjg
 uwj25AeVR/TqyxmZI5CgneAL9Nf1onKBMVrWhiJNYhwRmvDivyqmuetoKjVPmoE1UVZN1
 eea8oF4r2rrlzQyoPTX182R+Ja3oaSmfL83NoR0ZQ6jxjkLRCBeWkY5nrXEi5FyuurQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793105692;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:Content-Language:From:To:Cc:References:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=MiqzD02ZY/DmQBJxRR2TLuCLP24yikQyve9mz8EEjc8=;
 b=omrxbqD+S6X/3yGO7mrXkRMKjZVWAANb/KAJBXSotTY6CruZczyQvmGYvpx++zZ4vUdr
 zhR4BLagKOt4Y/optmJqklA5uQAIyJSWod7HcuFqvG9orzWNPkwKHsk42KSlCTrR7mGJm
 m+O6nGiajjQRZFapFAYKKeiIhOpALw5Xwb/xmOnA0mWN3NFuOJwq3MS454VQ+RzDdMxc5
 DWrm3z4Az9Zdyeeq1NS8B5GHgFIBoKFxne+RuDKl9V4gpSiUcVKOul7bjevS9O4R+glXQ
 zhjQ3cs1Vtl3roJZet3/2FEhYaX/flNAeGBcc2YMNBQe+PHT+TLqBp98KqwwtHRwWpw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=Sd9uxOGE; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=Sd9uxOGE
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C7CE44005F
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:54:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8013A108A85; Tue, 27 Oct 2026 13:54:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1793105684;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=MiqzD02ZY/DmQBJxRR2TLuCLP24yikQyve9mz8EEjc8=;
 b=Sd9uxOGELTKY9wcbeWkFOCW7s+Raeu2gG6XcDh82JFPbQTs6c5M3cBJLvAC7QHXxRBofya
 kHHr/oaokAyQ5n6tdOoGVgNgi4sDMU0KrIS9ya44pJIh8Ni0wPtVwriQdWxbCFHNvj/CM0
 Bh8a1vpN6LT+X0M9HSDvnMOB4EfVEf3WoTvvIv4r93kIq5dIJxNuqr3yjOEDSd+ByeTak8
 2rXhB1G6girMgXv0EY10N9/Z42+Q8F3Xo+1DOFTMjKcxgzvupj8F16+nVjZefDrwp677FC
 B7XIHJU/S/KjXKWuZrfcX6eemHonpYqYx2Ke6iEi9zlj6kaLoRI7Y6iFmAiZCg==
Message-ID: <15d15baf-1a78-1bca-bf70-02ec4881702e@nabladev.com>
Date: Tue, 27 Oct 2026 13:53:50 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] ubi: part: Claim only the block device UBI created
Content-Language: en-US
From: Heiko Schocher <hs@nabladev.com>
To: Alexey Charkov <alchark@flipper.net>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 u-boot@lists.u-boot-project.org
Cc: Kyungmin Park <kmpark@infradead.org>, Tom Rini <trini@konsulko.com>,
 Daniel Golle <daniel@makrotopia.org>
References: <20260918-ubi-part-test-v1-1-cad4306b45a7@flipper.net>
 <7b2d57ad-32e2-a45f-736f-2ac78a9757c2@nabladev.com>
In-Reply-To: <7b2d57ad-32e2-a45f-736f-2ac78a9757c2@nabladev.com>
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
X-Spam-Status: No, score=-24.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Alexey,

On 26.10.26 06:50, Heiko Schocher wrote:
> Hello Alexey,
> 
> On 18.09.26 13:05, Alexey Charkov wrote:
>> part_test_ubi() reports success for any block device whose first block it
>> can read, as soon as a UBI device is attached anywhere in the system. It
>> never looks at which device it was handed, so any device that has no
>> partition table of its own is labelled as holding UBI volumes:
>>
>>    => ut imagemap ubiblock
>>    => blkmap create x
>>    => blkmap map x 0 800 mem 0x1000000
>>    => part list blkmap 0
>>
>>    Partition Map for blkmap device 0  --   Partition Type: ubi
>>
>>    0: vol0
>>
>> The blkmap there is blank, and vol0 lives on nand2.
>>
>> Check that the descriptor belongs to the block device ubi_bind() created
>> before claiming it. cmd/ubi.c and test/boot/imagemap.c already pick that
>> device out the same way.
>>
>> Fixes: aa5b67ce2262 ("disk: support UBI partitions")
>> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>> ---
>> This was discovered while adding additional tests for the GPT layout using
>> blkmap, where it turned out that a stale UBI partition table gets
>> recognized on the blkmap where none exists.
>>
>> CI for this: https://git.u-boot-project.org/u-boot/contributors/alchark/u-boot/-/pipelines/1327
>> ---
>>   drivers/mtd/ubi/part.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
> 
> Reviewed-by: Heiko Schocher <hs@nabladev.com>

pushed to u-boot-ubi, thanks!

bye,
Heiko
> 
> Thanks!
> 
> bye,
> Heiko

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
