Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518D7606A333
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 15:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qn6Uw1il;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=HoaiTxAu
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 25B2C60782;
	Mon, 16 Nov 2026 15:13:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5dREkKuhfD4C; Mon, 16 Nov 2026 15:13:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 685AF60794
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794841980;
	b=XVsmPzxJNdy7BIj6TOhDH4Ujt9T24GnN06LOeB0QhrLMjY7OMFtXCj6KdiWwRCd+tn4c
	 tMf4aGw+i54OW0edGCzRprRvG3y7dmaUIgz93+fx9GWMtz+VB33f3Iso8Mow4il7+dIVo
	 e19M4gPwbR130A15s7lk7yO5hu19pZ3oP0BVHDo1oVMxlZJeVRzIHkU30Vw+SMv6zMgt1
	 3pd2YUB4Vv/kZAK6yt3kGZ5Mp75nQEn+iaXTkEUqGQ5JqOUCaJqriHTe6UnW7Kj4+afdk
	 fx6PQPnRgcJ+wApYNHMs2Bj27vw4NiEC6AVom0q/2r+iyZGqn5YeKk4xt0McGe5O7ZA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794841980;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wMYgHsdQY8FVTWtIvt8Aus3n9pdWcVwcOjx8m1Ubiic=;
	b=HJ2oSh3gcFxkgUlw/t0TApbj/bjjxj5Q9LuDHZFHPsvrhtXxbC+KbC5GT/wNzTnbEd9n
	 COKgGKqUHAL4d5eoyz2ezW4X6RPeJJdgL269vfTsMAwYhq66qpRouhG2ta+9NJNe+H1lH
	 dJCmeiliHtbeX0G5XrbNsvZUI8EhUrugiOCVlciiWL8ZiBYhd+hjQC+QmDxYxBTq8qgS4
	 qhm78TX7nsFbG+MNQgoOGhtFVsdZiuPWQzHR4vEox+KCVV47RkGjdRpJ1AZFFCw4uK7ko
	 mJBZ7KVKEv4aV8pNT6JBsNgRcagX3VElr7p62GMYriBuVeWbnPnRa9GeHxcYUq+lbyg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794841980;
	bh=wMYgHsdQY8FVTWtIvt8Aus3n9pdWcVwcOjx8m1Ubiic=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qn6Uw1ilm2xeEiBFS0m2jNFAYG28fwxuR28OPuLwowGNh1kd1XyKJ6B8oHDcfcojr
	 kY2oB3IaSx+JYlPpBJfBJ+LlFwsEH0c1U5CLn/aUy4Hi/SG/wixOBaGH+HNlMBlk5Y
	 IHNbwFbjMVB/awnXRHXDqlwtklPLdfHW+BvJmUU5dy9PB6De563y4wjrq4eKlY2NJj
	 KELYVt8xd52O1jEUqAQ2KP4OKt1xnA5jjcacdV8bJ22Z925ahiAzcdLDtC3P/hrRKg
	 +h2zPBW2YCWQcICOhvDtBv4xsmmXkxkRZk2vbGuVkDTMZif7s7Pk9Y23qAVzsJ+KZw
	 5wLwOb7iKTnWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 685AF60794;
	Mon, 16 Nov 2026 15:13:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 095AD260
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 15:12:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E3C1280F40
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 15:12:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mNLMkIZjNps3 for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 15:12:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CE2B080F3F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=andrew.goodbody@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=HoaiTxAu
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CE2B080F3F
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 15:12:54 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso22259775e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 07:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794841972; x=1795446772;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wMYgHsdQY8FVTWtIvt8Aus3n9pdWcVwcOjx8m1Ubiic=;
 b=HoaiTxAupveikq//SL71KS/FYuO7uaVOcHHFTNgpSYB+xGSatNCVuOC9yRI5psj3a0
 csVb2pi2/3shfhXv+e+ajl4HdMPzFtB+xiQxYDrqXE9ZrIcXKKIUtfC2afO5ovyrAK9z
 /PLgNGrsFmwCa1+Aw5cOJ6ZqnikLrcmloBnHrwoshWxUuwhgzXHf/UI+s7F78aOpProj
 FoJjjlx0bb9tEKg8LJWlaZRpEKyWYd+yULMAZTC36lpspErgLcfot0Rqi6kP93dsmxTd
 6/jP93B03fEnwM73jX0OsZFMhdOh1IFbLm1wRVvzaTDLeof0wSQXrHSFfH0mkzEe1m2p
 H6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794841972; x=1795446772;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wMYgHsdQY8FVTWtIvt8Aus3n9pdWcVwcOjx8m1Ubiic=;
 b=fE1ToV4c9HKx2hM47Nj6CnZcLV4h32btdN4F1RoYcQCsDOyx3gBqlUy+Pd2QoR0aUU
 NPOzhju0Ttr4ucrl/yDQuTFfM2eI32lpQSiwN29IJVwJ+eM+ryLWhbc7DmFkaazCXjZk
 xNuAd/eagZCcTxvAqWQntzVtZHwD4LJlBmHbWHiKCUXf+3A8jI3HkhqKTisX0sZ8cz7I
 0S8HcdO4giPw+4XXRyPi2U9z7P4/BaFXFn/0YmkoitG4JdiAgoEAEBgVZsONg+z0Z9tm
 2SS9nwWS73+FOi4ljH9CWK0NNKdwcHYkG8d+TzO1h9hcPZmqwICq1i0gHzLEHa6C0pLT
 IevA==
X-Forwarded-Encrypted: i=1;
 AL+hErFMk+n5D/SuwbPAACZ78R48PZaVcXTQv1ufxYMmvbqTAqijB+AGo853Gy4HT1CMxq9F9XghnAE=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+mcrJzJ3NLbAMsKL9F4wLQG8Kdzolf61uVWOSZiwwLPJt+Z5A1
 MMhZCePzjzs6ddMC81AinJYERxhdZoPInr5wTz40znAEfNwhwZghncxFlXZnApToep5E0Mn0MEM
 TR3o4Qh63yg==
X-Gm-Gg: AYBFou02PmXsVrAkZLDVUjc3B9xCyiKN3AYplf1+o+cwrTLSaPzcCsxfsgczA6dgxjs
 nrmyDwraffeIahDz60w33meIIzjNW4axLoaWOFwzjI0wB1FQJBqAYb3UeoqcIgNA+v+htsrra6d
 gk8nuXSjbiAGt6u6jFWwivuC707uDFOEcXX00vANC5ksXjxCWa8yUwNpHr4OtcuZFzDmIXzQgZ0
 qarGxUwjoPlN+nr0DTmGqJDpys4sMmbIn/sVIOHsw5BUBTVz9TbqfuDciypxIP6nCziXiXD/GuD
 eqkTPDWxR44j8FEW+50wmQ77g/Vc9gbeK4TtOJwwXzpC+kgkY2jgBfcNlOiQ66JhibJj+uwO1Ty
 7KZcE8dA4QIC/NjFiZxtf7Pa0RfXwOI+MWWtCjcESUhTp3YpBRA87K2a89lGEb8gkWaiMXFF2ka
 kh4b08YUIH5Qw2tRwCM+in8a2jU1UHEQo2QEOF78gnaYVoYVEVqAPUcBZ8ps/k3ZEcrqtjnq/vX
 GcEbthCNG1+LITpaAjN7n5dIcXQeHSaGAwrpKMxsO2jzZ1g0grnSewpJdoi0gOLxhC9iCJD139+
 j4JwOBhlr48Hhf9FnRDVU5s4HUygxNssUHqyS9WBoFLOMXe38qOaIDwOfR/J2CaPTmFvikACrpL
 u3MWnRtU=
X-Received: by 2002:a05:600c:4f4e:b0:4bb:6f45:2a77 with SMTP id
 5b1f17b1804b1-4bb6f452d39mr107523725e9.11.1794841972151; 
 Mon, 16 Nov 2026 07:12:52 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:ee3:3401:d23b:e87d:8bff:70bb?
 ([2a0a:ef40:ee3:3401:d23b:e87d:8bff:70bb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb666a3ca1sm216617445e9.9.2026.11.16.07.12.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 07:12:51 -0800 (PST)
Message-ID: <ac9aa1e5-705e-4a52-a070-d4d6d1eb8f68@linaro.org>
Date: Mon, 16 Nov 2026 15:12:50 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] video: rockchip: Set return code
To: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.u-boot-project.org
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>
References: <20251001-video_rockchip-v1-1-4933bdb56990@linaro.org>
 <cdb45ea7-40e0-4112-9544-c0eb1bc96523@linaro.org>
 <1e6b2652-e234-424b-9665-9b3b1e21ccd2@cherry.de>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <1e6b2652-e234-424b-9665-9b3b1e21ccd2@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 16/11/2026 13:41, Quentin Schulz wrote:
> Hi Andrew,
> 
> On 11/16/26 12:18 PM, Andrew Goodbody wrote:
>> On 01/10/2025 11:37, Andrew Goodbody wrote:
>>> In rk_edp_start_aux_transaction the check for "AUX CH command reply
>>> received" returns ret as the error code but it has not been assigned a
>>> value so this could lead to the calling code silently ignoring the
>>> error. Instead return -EIO.
>>>
>>> This issue was found by Smatch.
>>>
>>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>>> ---
>>>   drivers/video/rockchip/rk_edp.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/video/rockchip/rk_edp.c b/drivers/video/ 
>>> rockchip/ rk_edp.c
>>> index 
>>> 0ba68dbce3d126f8a3230435ffa0f780c1e08d61..7186abc9c6c93d05e774e61efa136bf98ff727df 100644
>>> --- a/drivers/video/rockchip/rk_edp.c
>>> +++ b/drivers/video/rockchip/rk_edp.c
>>> @@ -216,7 +216,7 @@ static int rk_edp_start_aux_transaction(struct 
>>> rk3288_edp *regs)
>>>       /* Is AUX CH command reply received? */
>>>       if (rk_edp_is_aux_reply(regs)) {
>>>           debug("AUX CH command reply failed!\n");
>>> -        return ret;
>>> +        return -EIO;
>>>       }
>>>       /* Clear interrupt source for AUX CH access error */
>>>
>>> ---
>>> base-commit: b2d5e46c67002e46ac339ef549ea18cf5adfcd87
>>> change-id: 20251001-video_rockchip-a480d9178ae6
>>>
>>> Best regards,
>>
>> This patch has been outstanding for more than a year now. The existing 
> 
> Sorry, anything Rockchip was pretty inactive last year, I'm trying to 
> pick things up but I mainly look at recent patches now, and only when I 
> have gone through that pile will I look at older patches (which I 
> suspect may never happen as my inbox doesn't seem to get smaller over 
> time :) ).
> 
>> code is clearly wrong. Is there anything that can be done to get this 
>> accepted?
>>
> Can you please resend?
> 
> I would like to go for:
> 
> ret = rk_edp_is_aux_reply(regs);
> if (ret) {
>      debug();
>      return ret;
> }
> 
> instead if that's fine with you, it makes the pattern in this function 
> more consistent.

Sure.

Andrew

> I'm also thinking maybe we could save a variable by reusing ret instead 
> of val for the two readl's after that but as a separate patch, and not 
> required.
> 
> Cheers,
> Quentin

