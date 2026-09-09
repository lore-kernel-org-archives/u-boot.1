Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75948C79F8C
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 04:37:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C814B406DF;
	Wed,  9 Sep 2026 04:37:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O5VNWwrP4Bnv; Wed,  9 Sep 2026 04:37:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8F626406D0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788928672;
	b=bBOlyOVxjuHjEMsfV2NfM8g6vQ0K0ylOglvshscP2OqmaE7yACfKgXknh3Uvnx5aXg6f
	 ZMTJ6xg22m41SsOpufJIWTn2PKB0PwgSresjwrybHRLN+H5o6sUcEeTvhpdmBRSoMO8eL
	 Ggegbd7bRdOit0zGi20zx8i9SAqbTM4AGQZlt+QYvKY7YbwYKPvHlT6zb3jPbk1ztC6UV
	 Uvk/HCQmSh5ApgFzkJmnSbV2m66gfzrecnpPt/0MAMonHxk0kcO8Tw1Pjwef303etemuY
	 K/Hk0eIXDGz5INl1mz2pdVyev11vzWxykd8aitW9TwKDuwQvJCKfDFLchAUX9DbEwAA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788928672;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=oBHUydiBoaCZZzWrW2DlbntYOPfCNE96X0U4efTD/e0=;
	b=K4Ub2X/eQb4Nts+sXa3SSnLyaCjzcDHa+dheM7haFSwEBIj20Y7awL/frEVh6aWDe7g7
	 3atDS3cvHIcKsebUv7aah+xEaB5vhTwwED21q9LdSLwOYoeGiTBMqJX8GG9AOIaN4A/s0
	 6SLeOVSHlH0ZiIOwOjXqeuJrzhrbc1seMTYjIW9pqNe1O4tfTDaY//TSWWfzlNwMe7yUH
	 E00SZY8byWWiQMbdodFWKmcBNg4O7xAKh2rpM3OgcoxquufT+rRx/hcxiMva7ubjVHH8z
	 tTYFgTPN6H8dvGmjTo9vEHfEtYKhWVG2IETy5cDMa7bZsPqOe97rUttWFqKiTVNwvsA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788928672;
	bh=oBHUydiBoaCZZzWrW2DlbntYOPfCNE96X0U4efTD/e0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mS/8ME+hcOXRVYQmAa7pHNjF35HzcQDo8KnNKrS9FJ9ScfkzWVpB9mMdlYdrqTjxG
	 TRrLb0/fznPOakbEqfjIbrkgoTICR+sUbTtylJ1OI83sqLbYSbfuI2We7MffqHgeUn
	 Tm28Vq1rGCM6cSufIEgTcA0Cbw2beuiBc49hrW9lbBRZSMdItDmcXwU7b5vY76zt+l
	 09U3FG4wehtzWwV6VAZtwtJUy2I1dxLUrnW1onO8hijEH4fGNt8SiGgoWK/pAZKTkM
	 OhOHVUuA/8XcfgJYGC1Qi936IuJqeYYc9qx55yMkWuppCyWqg/VmAU6KLSRovT1UxU
	 Mz4Uua/WmS1uw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F626406D0;
	Wed,  9 Sep 2026 04:37:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 843782D2
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 04:37:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 66F556075F
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 04:37:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BfQhRzsLVFYe for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 04:37:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org EC37260703
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=80.241.56.171
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788928669;
 b=Ub6vVraI9/F7jMmRkIQZaIdijbaXSCJfB7WeZXxyk1svkbBpFQFm4ZFcAQrE5u/V6TEm
 tCWBi9l9VKZtlSh2qwqZwY8JBmvXE9Bnp1mUDQyX8x7uJFzApPE3hgeliz15s+zn8E6xy
 9kinZqFmJgr9+MPMHXRjYGl4EaBR3zDjYK1Sc7A/JdQeTfjg+VmxLMDDitKevnHDZtDsP
 EaBox1XaONaWrP+8Yju4SI7DdM0xn/ijkRtE2NE0c/TE3hh2Qs22a3C1KM++csqIbNhVl
 tDQ7w19+Uii5QQfpdHcia6siqhM3PbAtMZ6cog4ABXgHLUT1Lp4EW4VbjbSafkHMEig==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788928669;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=oBHUydiBoaCZZzWrW2DlbntYOPfCNE96X0U4efTD/e0=;
 b=sl5n7188AnCXQ2q47KgPw+GH+pEZuZuSkq2S711yZz/6Nnkw3CceqX/T11neaUVOUzY7
 040KC/9cOEKxVc5GS8s06d3J9gzszZmdATxBMSylx17XPbYRojft/DSuUfDK1FMrcqK1z
 3erxQOKJ9qI/aNd38Zl6SiYDMhiq/Bd2I3hohh5hJ5/CFzvIBlNaoRr6s/dVUNpgTUhdV
 mHovw/e/7SjPbTyyDLOh7cZ0oTJM/kKyPn/5awqnxc2hmcmowQKuWTtUjCxR7kNGeufPv
 +6pzRtiUHFiEP5Ye6Lgsuy8URK3A4uHi98FUWrIwSgZ52Y0jS6FCskr9dlyWEWAdJDw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=kbsaikZd; 
 arc=none smtp.remote-ip=80.241.56.171
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.171;
 helo=mout-p-201.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=kbsaikZd
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EC37260703
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 04:37:47 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hfp2H013SzMlBF;
 Wed, 09 Sep 2026 06:37:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1788928663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oBHUydiBoaCZZzWrW2DlbntYOPfCNE96X0U4efTD/e0=;
 b=kbsaikZdWl2C8CSQGrrQ8B9PsQ1FYlmyRebD57BqI0iL6HVJc+iRv0gmf1w3m7ghmNsxlH
 2cH8w++fHRz4rXcttLypPhzuaHOebj24StIwVCkeJHH3yr5ZDN9Ir4TV0q+GhxzuMW5aRr
 lRw1rIptgHbMyRmCSVE0uEpf70lRKkR1vWnnajlTBv7RlMCD++Ya8dDSLPNLsgVktQrJ5W
 ckiz1K2+q/AHHbgsegPH69wBEnPnUkwwERhrFEsKwNquuO4WaKMMsX8jugyMsfMsKVwKkq
 52ezNJJ0A6WEZxXr71pIE8sUeZH24qOQLx5bKKqOAb9l/4ASr8pEZyYH0BqPZQ==
Message-ID: <f5107afa-7202-4116-b02d-29accb4d7617@mailbox.org>
Date: Wed, 9 Sep 2026 04:20:50 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/2] usb: gadget: mass_storage: add SuperSpeed
 descriptor support
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tejas Narendra Joglekar <Tejas.Joglekar@synopsys.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Tom Rini
 <trini@konsulko.com>, =?UTF-8?Q?=C5=81ukasz_Majewski?= <lukma@nabladev.com>,
 Dan Tran <Dan.Tran1@synopsys.com>
References: <cover.1788488867.git.Thinh.Nguyen@synopsys.com>
 <0103125b2e7e1a942202eea2c7222ab00d6857ff.1788488867.git.Thinh.Nguyen@synopsys.com>
 <8d741110-05eb-4861-94b9-19ef27c9ce2b@mailbox.org> <aqC8hnAHrQ8Cv3iR@vbox>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <aqC8hnAHrQ8Cv3iR@vbox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: ef4jnzgxgixoi93rgfm6kcawe1wopgh8
X-MBO-RS-ID: 62114b7f56ef8ae4faa
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

Hello Thinh,

On 9/9/26 3:58 AM, Thinh Nguyen wrote:
> On Fri, Sep 04, 2026, Marek Vasut wrote:
>> On 9/4/26 4:29 AM, Thinh Nguyen wrote:
>>
>> Hello Thinh,
>>
>>> @@ -2709,6 +2712,27 @@ static int fsg_bind(struct usb_configuration *c, struct usb_function *f)
>>>    			return -ENOMEM;
>>>    		}
>>>    	}
>>> +
>>> +	if (gadget_is_superspeed(gadget)) {
>>
>> Nitpick -- you could invert the conditional here and reduce indent:
>>
>> if (!gadget_is_superspeed(gadget))
>> 	return 0;
>>
>> ...
>>
> 
> But wouldn't that deviate further from the original Linux
> change? See:
> 
> 4bb99b7c82ba ("usb: gadget: storage: add superspeed support")

I think we are past that point and the U-Boot code did already diverge 
quite a bit, but if this is pulled from some specific Linux commit and 
you want to retain the code similarity, then please at least include the 
aforementioned Linux commit reference in the commit message.

'From Linux 4bb99b7c82ba ("usb: gadget: storage: add superspeed 
support").' or something along these lines.

Thank you !

-- 
Best regards,
Marek Vasut
