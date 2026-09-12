Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A0A4C88E56
	for <u-boot@archiver.kernel.org>; Sun, 13 Sep 2026 03:04:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BDCD980EBF;
	Sun, 13 Sep 2026 03:04:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VTNtII9QaIld; Sun, 13 Sep 2026 03:04:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AA61E80EAD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789268681;
	b=Ia46bGQd1ewaV7o5Y9kzb214kYCuaOmN4snCP81BbXqWlAzkl/ibjKygiMn1yzkrBRUz
	 tS7gPMDSqfHgduaiGTGdQ0bSa9Ec+N2yUL9rlX0pMI6hNmUn8KwGeSteQkYh3qdTGBDln
	 OYJJFg8MojAiqzXECQKfWytPeuj9G59X33ebysENBYlQu3gHYtrJdNbjXNLBOeRggCKUV
	 7+Q1dtH/5WKyOfzuyckHN2dzygu4mnXLdMJz+703ihtPhe73p1c7cR5MTTTk0w6XOuTXn
	 b3iqOV1iZdbYjlWxAh1nTwvx524dG2FU+fN2K+QOaVSv/H/4jN7QqSiqEc8Kyotp5cQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789268681;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=U3Fy6oWBJ5BDTpXS+35ozCia+kiD9Z4zjbe2lKz4UDU=;
	b=ZSK3yMXRUNYP1HooVVdYQFB4TGjiUiZ03+HzhONIKJcipJamGqK7ehoNsAqflO3YcqTc
	 4PQ7SFebUhhCPnwKjimpiXbklnxqhjZ1LlItQevGLQ+nLOmK6V/2t8JQiOiD9kywTH1Ds
	 TOAnk1VY605JB7F4U30W8VDMV5ItY+HasN3X8bH4NkaQM3vnA/rOYBy0bxtWoWK/J8TLV
	 2oo//6jcRpgZGA6srffq7jHs6/Vf/8tLjFwRTKh0dPFNNRvTx9K/RZN8ydekVjN8vTmb+
	 74MxkyAI769P243drkBYWEAVjy8QYnIo6+IPMB6j/knNF6j4JGC0lZhAPYrx0ACKxQw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789268681;
	bh=U3Fy6oWBJ5BDTpXS+35ozCia+kiD9Z4zjbe2lKz4UDU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sBWfZDA1wf98Wt7yKaZSprDpM9qNb/9g1L3TZ2QyVi//6rs1U/rbjBtRIFOXnJGq8
	 s6Ag7NpDeTZdn7zDUauB3a8/oYGLAZKMeD8SUUPonnutNi1B3dcKAEuuNamcjungne
	 oiQkqvg5FKMuZQGaVK5jsnsM2rtToCU/a+ZCDr/e+qzPxcWoxTPe9G6oy7STihK2Ru
	 HM4LUkktSA/ZnFYxp3zBl0c7HCLAA9ieG9+kEhlxnRUjwIEGkban5kHbwHgsaKSEjv
	 QO9IhH5MNI64kfgMNa8Oldee+tC0iQYJIBkHc14Cp3y27FyxrCDz8HvcCqF+TOwqGP
	 XQTRRA7gjKuNQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AA61E80EAD;
	Sun, 13 Sep 2026 03:04:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C9679E4E
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 03:04:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 974F8400CB
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 03:04:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gw_ZGq-hKT8z for <u-boot@lists.u-boot-project.org>;
 Sun, 13 Sep 2026 03:04:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org DA93E40049
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=80.241.56.161
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789268673;
 b=W0eHVuw5Y3iguiCUPPuhTsN8ySksqlpga5U/m4FSJ3aKEvXCnTMKot542XjjGwIhup+t
 n+E3Wl21ATRiNIoXwkFqQzKGU0oey4JfsN4++8IsYz14MzuHl06Neyp+miqdnLuffwFzM
 mY17nBF5GRHUgLhh048Gmsq0Dlh/isFnEmH41cSPbM5eNSV942zQu/oAyKcJwZ0wluld+
 4q+TJBLODxX9Sb7kSxHusiyZmwfOXHGHlz0/ZJLRx5j7pUPKh55Fs3LNX+uCjfAN7nhGm
 s9+vtGzKQ028DRbY3gul2w5GHxSbwfFubLXwkTEtya8BF/dT8BOcWmC6ZdSuQ1jFf9w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789268673;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=U3Fy6oWBJ5BDTpXS+35ozCia+kiD9Z4zjbe2lKz4UDU=;
 b=bOWw9PdwpUysVFrMUR4gtNwc/7qOcww1jdY1sqcI4WfjhxBhImt3E3Cw/gwULjObgS8C
 0+fzjW2GKcoDARMqfy+0AMJje+0GTkiVQTJGMN/zK+jMbJlmkeAH5OnW7IuE+SF5fGJsz
 9/ZoM75kTIGbZWI5CU0qPbF3jirf5MIew2Q++qSX1sU3JiN+0k0hzTgk1RprKBsA3Ohsa
 t4KVga4IuzU7qQ1a2tqhIAqQ1LFR/6ToMEsYStdpgXQ/2zslNy35Wt8uvOnbxFVLl9sTl
 SWKuSyX0fzM7Yzf8nePShc1KuXwQmoWEH2H4mXtfU6PZYF29HZXOYNsygsdkey3jE3g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=pwuH5Z5d; 
 arc=none smtp.remote-ip=80.241.56.161
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.161;
 helo=mout-p-103.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=pwuH5Z5d
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DA93E40049
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 03:04:32 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hjCmr1J4szKmV8;
 Sun, 13 Sep 2026 05:04:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1789268668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U3Fy6oWBJ5BDTpXS+35ozCia+kiD9Z4zjbe2lKz4UDU=;
 b=pwuH5Z5dtiqvRF1MX7v8Vss4hMVZqVhW8Mq6KxgvkSXV2q5bbS0SJVXtD+DSqB7hgrfVc3
 OKr6wVSAsH/OGNGaZQjlZzl72W6nAAzcWNlTA5wOQOM4xu6iJexXjE5v2tJIETQAW+L7ZY
 5k3ZTtVksiVpWKrcA1FmOO7Hh63sga9igY24KrrXchBr+iY29l19WZvBKpW7xMyPre4Okf
 RoFTBPQ0GfgfgrcQFYtUDVs1GWF7hWWEBh16aPWLTQs2AY93Ic9ifi54wGmD6n0MIHbg3S
 UJ5pSlRqu7sELhKGL07iZYF8zY81NlTKwGPNiQuZs2t84fO6Hahsvedid/3PrA==
Message-ID: <0eeea483-067a-4ad1-a528-138d2a00e8b4@mailbox.org>
Date: Sat, 12 Sep 2026 15:05:36 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] lib: lmb: return -EFAULT for partial bank-boundary overlap
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Randolph Sapp <rs@ti.com>
References: <20260907-lmb-alloc-addr-efault-v1-1-7a5b73c2318c@oss.qualcomm.com>
 <6e0b7172-b3c5-455e-b00f-370d43083b2b@mailbox.org>
 <e34d629a-214b-4ee7-b5b6-ee01372ea3ed@oss.qualcomm.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <e34d629a-214b-4ee7-b5b6-ee01372ea3ed@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 8cn84e3fwn1hpx7ggzqsdhmz8to89ghi
X-MBO-RS-ID: 68fcdf1c0d4feb0b519
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

On 9/12/26 2:36 PM, Balaji Selvanathan wrote:

Hello Balaji,

> On 9/7/2026 5:43 PM, Marek Vasut wrote:
>> On 9/7/26 1:56 PM, Balaji Selvanathan wrote:
>>> _lmb_alloc_addr() returns -EINVAL when a reservation overlaps an
>>> available memory bank but does not fully fit inside it, and -EFAULT
>>> when it does not overlap any bank at all.
>>>
>>> So for the partial-overlap case, it returns -EINVAL and
>>> boot_fdt_handle_region() in boot/image-fdt.c prints "ERROR: reserving
>>> fdt memory region failed" during boot which makes it sound like a
>>> serious error.
>> The commit message does not explain why do you think the overlap is 
>> not a serious error, and why it could be ignored.
> 
> Understood. Have reworded the commit description to better explain. Pls 
> find v2 here: https://lore.kernel.org/u-boot/20260912-lmb-alloc-addr- 
> efault-v2-1-0a796adfd99d@oss.qualcomm.com/
For future reference, it would also be good to include the reasoning here.
