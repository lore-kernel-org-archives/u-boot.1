Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26FB606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 02:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Hcyv92w7;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=BDIJGK4u
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EED57409D4;
	Wed, 11 Nov 2026 02:55:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mUgSeLztP9Ri; Wed, 11 Nov 2026 02:55:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 21A81409A3
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794365710;
	b=fEMv94kTIOAW/9tvH8rwLW4yu7yaYKgraLknQJDr+yJ6N9JNsvZl6RBPigkY3RQj3lmO
	 IhSTuG2mjFseGONlxrkbUu3WRB92JGcDTA2MJjFD5SsYozjrSw2soOmjL0IX67iWtoYc2
	 mrYJEVyYMO1jUZgEG67u1bvoXQBiHJWsJiJyeSh/UjjM6o2WQ3143hGzu0FkO9kKc+mIS
	 9eV/+1Yl3gAfZVEmKNIYuvsQocOEvedcplGlTn7s7/JmeijMo/P2wGOoEXv+3x3OnFF9P
	 gPjW3elqRTacy78Gt/PnePK3Fo9UJvX6ro4OLbKYexqp+4fvL4Ls9VEy0rBO4/ohEPw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794365710;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=OyDD1gKyyaC7TTdJRulqsdgMtG2pWCjFBkJZtGYziig=;
	b=Juz9fRVtOVKNqyA15fFTBH78urg02lhxLYKMHBpYrOWvaIxh/IKxh407MPj0ccdFc0jT
	 o6kw9pfoD0XzmYNVyIIQQHXjNr/vyJbDJX5inRslS8un0q9yo3Tbxd4xZk+aSDts/LdDK
	 w2QqYUciwCjWwdmYvJLX0wRA7DC3Dd72kwM4tTi/MFn+hukM7sGZoXM1tvfyz7W5mdH5h
	 ZlPjUg/KANp0EGTRaTL7IAixeL0839CxMXL2VpNH92DVFPS7/0DlNFttONepOdj5gpPZ0
	 qfXAIpPZH/EZatBKBxvnRT+XYzTjNFqnIyWMQEx3b/xD/mJ9IyQ8pvffeuhqugUJOYQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=freeshell.de;
	dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=BDIJGK4u;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794365710;
	bh=OyDD1gKyyaC7TTdJRulqsdgMtG2pWCjFBkJZtGYziig=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Hcyv92w7yKS5F7r7wrU+SCf2edyLIkHxrzrrYLEtZN+ybAO1rIE6lEOexoctojy3K
	 8yEfAX6KqzVJkJbC+Oz2CNItDambeJSpNixUHRt5l/MqF+pG6AK0x6tklu+Vxbu3No
	 vAO+WZAH1PJf7cUmYD6/iUrApm8O+nvFZE49Hbu34KWoXN7sjA9SCO09q9/MottCNx
	 lag48bG+dEWkoDnOR/U79WOkUvsSCkOOxScTDXfC6RhX972tiNwlvIqxb6u5jrO2mM
	 4O/6U3vo0S0XrjZpr5+yomWRzkeS2VK3jDQZbOT/tTf6CL8ZWMZ0QGTAtKTtl4NfkG
	 8qxlAirYKTjsg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 21A81409A3;
	Wed, 11 Nov 2026 02:55:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 619AA731
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 02:55:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4AFC2409A1
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 02:55:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id enfzjt8Bcg9V for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 02:55:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D01A7407F9
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=BDIJGK4u
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D01A7407F9
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 02:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1794365687;
 bh=OyDD1gKyyaC7TTdJRulqsdgMtG2pWCjFBkJZtGYziig=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=BDIJGK4uk0dRP7wAkPMn3N7V13JIHNX0BwQN2hUIDSv0sDB8RXIaoFlWU7SqfQ2IE
 m61TcMr7oR6/z009QMluHMzaZCN7g+uja+tXNbGv2fohf+LAS0l6AM92uOZTeyQscb
 4SoKqVop7rZs6v7pBrzydkaiU40VivHNepg/03UeZ6x0rbgHdG+NOJ4Kjb/M8EBcEz
 hU0pVFD+YnpYCvab5SQUxUmucQRAfkSxXUtHsi9Y3ebvTDKdWI6DFcV990NESVSROC
 tUuMi4RR0gdyD+ixatzVHiw9EteesS5M0Hgc2CFPx0QlAWWRN/rcDOQx2eMgvECp/P
 TaHBr5E8AZYyw==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id C520FB221B2C;
 Wed, 11 Nov 2026 03:54:46 +0100 (CET)
Message-ID: <cae8d4f7-faa2-43d9-866a-cf2ee5d07efa@freeshell.de>
Date: Tue, 10 Nov 2026 18:54:40 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFH] Writing a project Code of Conduct
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Tom Rini
 <trini@konsulko.com>, u-boot@lists.u-boot-project.org
References: <20261103172036.GS3309461@bill-the-cat>
 <xhkdbcxsdvux2.fsf@mkorpers-koolstof.csb>
 <b415d946-eda6-4ac8-a8ec-4b00a379effb@gmx.de>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <b415d946-eda6-4ac8-a8ec-4b00a379effb@gmx.de>
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/10/26 07:12, Heinrich Schuchardt wrote:
> On 11/10/26 11:32, Mattijs Korpershoek wrote:
>> Hi Tom,
>>
>> On Tue, Nov 03, 2026 at 11:20, Tom Rini <trini@konsulko.com> wrote:
>>
>>> Hey all,
>>>
>>> Getting back on track with project administrative tasks, one thing I
>>> have talked about the project needing for some time is a code of
>>> conduct. In my mind, the best starting point here is, are there code of
>>> conducts in other projects that people use and they feel would be a good
>>> example for us to adopt? Thanks!
>>
>> Have you considered the Contributor Covenant Code of Conduct?
>> That's the one Linux uses, see:
>> https://docs.kernel.org/process/code-of-conduct.html
>>
>>>
>>> -- 
>>> Tom
> 
> https://policies.python.org/python.org/code-of-conduct/
> is another reasonable code of conduct.
> 
> Best regards
> 
> Heinrich

I observe copyright license violations as kind of status quo for
embedded vendors taking U-Boot code and stuffing it into SoC BootROM
without adhering to the copyright license terms. Writing down rules for
social expectations is not on my radar until the legalese is well sorted
out for the code contributions. We must not set impossible expectations
on top of undefined parameters.

-E
