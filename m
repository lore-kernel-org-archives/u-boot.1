Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C94606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 10:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ja9CyGDT;
	dkim=pass (2048-bit key, unprotected) header.d=embetrix.com header.i=@embetrix.com header.a=rsa-sha256 header.s=rsa1 header.b=ZWYd+opc;
	dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256 header.s=ed1 header.b=HzYptVR/
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CE5914059B;
	Wed, 28 Oct 2026 10:46:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mGI4JWolTKvR; Wed, 28 Oct 2026 10:46:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B34874057D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793184393;
	b=VOceKc7jWFQT4ZhtvS9nrS+dXSzn3tyb/nKwLgHp1H/FKkkfux+299lgogu7mZnWQN7/
	 anlVwI5leWKDFAR25tEeJuua0KwllbjD7SpeW1l7dkPoLsMVHae7pHeHrnxfPcQjhdw4Z
	 Vs/79C0+0dvzGyjv8AhKoli135TQaTkZI+zJy7dqH6jy1WXMMIXOkTSS3d1ZSsCgO0SYe
	 1bf2X9Ec8jodDX+wOxxuWtIjLV78mvIDsbcLv+bibkSe06dE3/OUusjIo+EUWFgpTbA6I
	 cluZsPiWwt7Z2Gobr2EwneERCuyHrjcxa13Gc0f2WiXnyFUwhdX/rjooB9Nbf+iI42g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793184393;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:X-HalOne-ID:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=kRHS/y7cuRINKZHXk+jU1D9PVUDQo964i78QLtphj1E=;
	b=nRwAlhqs4Sd+P7volpiZReA6x7GVgzD5Ea5Ue0YGadiSh2KTVU0IksXOC9hpL94oMKCr
	 BVTo9skaBfLBORsPRajde6UeT8zmvaQ//ZeSDvzlcDg1wE7Fvt5KyRfICbPApRrkAn3s+
	 0+OFUtASSfRn61v24IJiHyJQ1HQvI0vqbpYR1nnKlyVB+SEK890y3RUeJFDLFEOMuMopm
	 BXXeZQohVxrIMu9VlrlDvjS7eat4MMPZ9jLUlqkZVuUGBwnzj8BgXnOkYjcWuFJNgg9OU
	 BYZBwxZMjK8F63OIRkroge7lQIh/nwQtEJStQ84+h6Xw7R52A2E5hz87MJOCcTGGMJQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=none header.from=embetrix.com;
	dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=rsa-sha256 header.s=rsa1 header.b=ZWYd+opc;
	dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256 header.s=ed1 header.b="HzYptVR/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793184393;
	bh=kRHS/y7cuRINKZHXk+jU1D9PVUDQo964i78QLtphj1E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ja9CyGDTh7Z2DociPh1+OdxJmqk7GoYyz2d17oeOfWV8BKIBkVA7eI2ehjvN+5V64
	 8aHo0cx2U1MrL08ZUJfGglQ9CUNomybOIcLkW0ydazwHWE7jXEUVs23ohMcWifmv4c
	 PaHD9zRGAy8jspaLNlW4oB/zoz61BePzXVGKmacj/9fX3bqoAkppBQjM77EbWyU0tA
	 eZx5Qs0ZLSunuDBrH29OF7ht4j4/J3lNak8cqTGLNo90sO140Kb/nkH8OWADxe2pGU
	 vhzkqkx1mMPmfbCbOPRQKVe4udTGeMnHmPRdd+AuswBlvTL7zrxf8CRBoRWoj7t8UA
	 sp7jemQ5vTtEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B34874057D;
	Wed, 28 Oct 2026 10:46:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8D8B51DE
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 10:46:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8A51E4057D
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 10:46:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GW-oX55WF9ck for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 10:46:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2D9044057B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a02:2350:5:505::1"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793184391;
 b=V2KQ4ABmyOLyBf9uIgcbIxzjy+jbj3vtlgU0A1IRlBcxKBRwzFN2p92x1fRzeY5Cn39f
 ssPWAkwUOihYTCTBv2Xg82+b0D/L1aUI2MoF9DDp9yRJ3sJXNKTX0vMCnok2IQzs6rEP2
 RmoprVqZkAPPAKaBNA0d2D3WU2oHg0uha7mF3YrxkHUucW2U/1pgr5UmhpZCEXTmh27/F
 25cTyFqped7Z+Pqr7TuBtccA+C2BAljOmWQuetbwv+VwmxCkRAXzLJ6OABLnJHjciGbL5
 Vq31z2aj408n30RoT/GDgwMnC70BRBxd0+p3x2R9ZMECNSqG4WrASQw7lvJz+Zh9WCg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793184391;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:X-HalOne-ID:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=kRHS/y7cuRINKZHXk+jU1D9PVUDQo964i78QLtphj1E=;
 b=YzLL2OfioTZ3DWPcKenMbiPLYY5H+ljuTAMzHk/uOzv+SkssxN7H6eRx6FstNgnhb4HW
 z/tex69jzsVDUFLO1VTz0vo2J1io13Q/5WgNmx/nvupC+v4ZC0j7TAtEeOy0n4fqu1p9e
 Myw1mRnlnR7C/tWHSQ4MY/atpWlDQrfEG8kEvejt+Gow6mGIZJ3x3hcEYOGAhwsAw/6/Z
 8NaYSu39fWThU9Sr6CNAfeNdTCg+Qp+mowU0hyWQ65/gkJRCD8EMP1mNOKuC0ylSIkW2Z
 Ur9QSJzUJAM7hEVMScDbuVlP8Ej/+Y/gSPB4UB6RswEd2V/ThSe8zpDaI4W35SY6UyQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=embetrix.com;
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=rsa-sha256
 header.s=rsa1 header.b=ZWYd+opc; 
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256
 header.s=ed1 header.b="HzYptVR/"; 
 arc=none smtp.remote-ip="2a02:2350:5:505::1"
Received-SPF: Pass (sender SPF authorized) identity=helo;
 client-ip=2a02:2350:5:505::1;
 helo=mailrelay-egress18.pub.mailoutpod2-cph3.one.com;
 envelope-from=ayoub.zaki@embetrix.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=embetrix.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=embetrix.com
 header.i=@embetrix.com header.a=rsa-sha256 header.s=rsa1 header.b=ZWYd+opc; 
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256
 header.s=ed1 header.b=HzYptVR/
Received: from mailrelay-egress18.pub.mailoutpod2-cph3.one.com
 (mailrelay-egress18.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:505::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2D9044057B
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 10:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793184388;
 x=1793789188; d=embetrix.com; s=rsa1;
 h=content-transfer-encoding:content-type:in-reply-to:from:references:cc:to:
 subject:mime-version:date:message-id:from;
 bh=kRHS/y7cuRINKZHXk+jU1D9PVUDQo964i78QLtphj1E=;
 b=ZWYd+opc6WMaspns3IdWVqKC/AXkRvJOfaf28XrD4zVzl6FmjtjvCQdzUNgZOMdBEOwy9XzuHrIsh
 KMmd5B4XVtPxcItcOwQW0ri5mB/MO3nAGlNWwWEfzrhkaiaaU5vjp/Af7SFujrs7ZzsBiQaEU6j7z3
 CV8qiNckJR4JBlqBOZGa4NQQjfpmFVwcxNSmwY+Xbv8oua6PjaulX75joCrsjqjh1Ceann7dKCGMMe
 GMkT7tBJ6Fa67CY0Zf771wZRygPSqlxjV7n0fKH71TYVwBISgqjXzCMU7Dk8Z05hW2F4eO9zafUwSp
 oPCAWDa5jjMIamgjd7VG88uhAbyXVLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793184388;
 x=1793789188; d=embetrix.com; s=ed1;
 h=content-transfer-encoding:content-type:in-reply-to:from:references:cc:to:
 subject:mime-version:date:message-id:from;
 bh=kRHS/y7cuRINKZHXk+jU1D9PVUDQo964i78QLtphj1E=;
 b=HzYptVR/nfvM/YEcLRT6i6fnoxabq5wYKmKi7ghWLcUPWPP0euAWuScjaiMNs6FJ6GOVZ+5F2hSXM
 vCi1sWWCQ==
X-HalOne-ID: d2fbe430-d2bc-11f1-8243-1db1c303b0c0
Received: from [IPV6:2a02:3102:8c10:1ae0:c98b:5300:3c35:71e4]
 (dynamic-2a02-3102-8c10-1ae0-c98b-5300-3c35-71e4.310.pool.telefonica.de
 [2a02:3102:8c10:1ae0:c98b:5300:3c35:71e4])
 by mailrelay3.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
 id d2fbe430-d2bc-11f1-8243-1db1c303b0c0;
 Wed, 28 Oct 2026 10:46:27 +0000 (UTC)
Message-ID: <b69631ed-8621-4d8c-9497-846c3f0caf36@embetrix.com>
Date: Wed, 28 Oct 2026 11:46:26 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] crypto: add FIPS 204 ML-DSA verification
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 mkorpershoek@kernel.org, sjg@chromium.org, marek.vasut+renesas@mailbox.org,
 pbrobinson@gmail.com, dlechner@baylibre.com, hs@nabladev.com,
 xypron.glpk@gmx.de, heiko@sntech.de, raymondmaoca@gmail.com
References: <20260918172127.66014-1-ayoub.zaki@embetrix.com>
 <20260918175345.GT858934@bill-the-cat>
 <f550f27d-55ba-4d10-9b1f-d3712b6967ab@embetrix.com>
 <20260921202435.GC858934@bill-the-cat>
 <8953c3f1-929a-43ca-8708-712a45db9c77@embetrix.com>
 <CAC_iWjKDX2FdzrpW0JxJ-tpj2PksNY0gDyoXz3_T_QRrjaoyRQ@mail.gmail.com>
 <40b6ce4f-ac70-4d37-a3b7-c784c9c75471@embetrix.com>
 <CAC_iWj+ofe4fbY2yVc3qzZmxwBprLem-urjepKtVg8ORtiT2Fg@mail.gmail.com>
 <CAC_iWj+hJHKrH+owS8s99iBYAQRVZ+zvjt-rvA-0d657=SpK-Q@mail.gmail.com>
Content-Language: en-US
From: Ayoub Zaki <ayoub.zaki@embetrix.com>
In-Reply-To: <CAC_iWj+hJHKrH+owS8s99iBYAQRVZ+zvjt-rvA-0d657=SpK-Q@mail.gmail.com>
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
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ilias,


On 10/27/26 13:01, Ilias Apalodimas wrote:
> Apologies for the late reply.
> Was waiting for some announcements to settle down.
> 
> What I found out was this [0]. Comments welcome but I'd like to see
> how this plays out before making any decisions, since we use mbedTLS
> for https as well
> 
> [0] https://lists.trustedfirmware.org/archives/list/mbed-tls@lists.trustedfirmware.org/thread/YPIGCB7WN6GCHOGEGKOJXUYAP7OK527W/
> 
> Thanks
> /Ilias

Thanks for checking. Should I address Simon’s comments and send a v2 of 
the Linux based ML-DSA series or hold off until the direction for crypto 
integration in U-Boot is clearer?


> On Thu, 24 Sept 2026 at 13:36, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
>>
>> [...]
>>
>>>>>>
>>>>>> Well, a problem I see is that this is something that needs active
>>>>>> maintenance to stay in sync as we don't want to miss important fixes
>>>>>> here. In theory, we get that with mbedtls (even if we're behind atm...).
>>>>>>
>>>>>
>>>>> Agreed. Importing the Linux implementation means taking responsibility
>>>>> for tracking upstream fixes. I’m willing to maintain this code, track
>>>>> changes to the Linux implementations and bring relevant fixes into
>>>>> U-Boot. I can also add a MAINTAINERS entry to make that responsibility
>>>>> explicit.
>>>>> The goal is to prepare U-Boot for early adoption of post-quantum
>>>>> cryptography in secure boot, particularly FIT image signing and
>>>>> signature verification as some hardware already ships with PQC
>>>>> capabilities.
>>>>
>>>> There are zero doubts that this is necessary; in fact we are already late.
>>>>
>>>>> The intention is to switch to Mbed TLS as soon as it provides production
>>>>> ready ML-DSA support and the required SHAKE functionality. That timeline
>>>>> is not clear to me yet so I’d like to prepare U-Boot in the meantime.
>>>>> Would this address your maintenance concern sufficiently to proceed with
>>>>> this approach?
>>>>>
>>>>
>>>> I can try to find out more about the mbedTLS roadmap if you are still
>>>> interested in going down that path. Arguably most country legislation
>>>> is looking to enforce PQC by 2030 so a month or two won't kill us.
>>>> There's another benefit apart from the 'less maintenance' when using
>>>> the external library path. IIRC, there isn't a single algorithm
>>>> acceptable to all legislative bodies.E.g, CNSA 2.0 does not adopt
>>>> SLH-DSA while most of Europe does. It would be much easier to use a
>>>> library and select the desired implementation (even stateful vs
>>>> stateless) instead of importing and maintaining everything.
>>>
>>>
>>> Thanks, any clarification you can get on the mbedTLS roadmap and the
>>> expected timeline for production-ready PQC support would be helpful.
>>
>> Will do
>>
>>> Separately from that U-Boot currently uses mbedTLS 3.6.x and moving to
>>> newer 4.x involves the split into TF-PSA-Crypto as a separate submodule
>>> and incompatible API changes. That migration is work to consider
>>> independently of PQC support.
>>
>> Yes last time I looked the gap wasn't massive, but it's there and
>> indeed frustrating.
>>
>>> Let’s revisit the PQC approach once we have more information on the roadmap.
>>
>> Will do get back to you!
>>
>> Thanks
>> /Ilias



Mit freundlichen Grüßen / Kind regards

-- 
Ayoub Zaki
Embedded Systems Consultant

Vaihinger Straße 2/1
D-71634 Ludwigsburg
Email    : ayoub.zaki@embetrix.com
Homepage : https://embetrix.com


