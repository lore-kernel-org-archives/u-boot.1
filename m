Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E793E606A68F
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 18:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=r1xSmdke;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=EhpfFeCk;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=IEhcZQDN
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7D099405C9;
	Mon, 23 Nov 2026 18:31:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ELL_PSpmKD3D; Mon, 23 Nov 2026 18:31:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 390F3405DC
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795458664;
	b=gLgcWADNS5akPc9yFP3DhcDSROhM0fyhGsg5sjuw7O7EgjMLzjeLKjlqzqlwXLaZkMFS
	 u5sH4BGh3VwTWdDjgRkV1aC+f20KDEGKI0wgkjEuHXMSXgfA+0zz6+T9Gogf1P45DeSup
	 AcRn7tvxmzMHLsZhS3ilw2uOzQF/o+KLacvY4cNklWFgDna/9o9T5ZC8DBSj4JSCg0JoD
	 mXQbumofYjZy7kgz9aIzxle08TnQq49X7lfPWeaWNPI4o1sRFRwI9+KW4Vxmltwh6IZ0C
	 KJ86yaGuMS+9Py2D3ew6QS18/n+RQxRzc3OM2vrZq9w/mWDXq9fC72dzFUNRDptq7zw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795458664;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Correlation-ID:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-Source:X-Source-Args:
	 X-Source-Dir:X-SGantispam-id:X-AntiAbuse:AntiSpam-DLS:AntiSpam-DLSP:
	 AntiSpam-DLSRS:AntiSpam-TS:CFBL-Address:CFBL-Feedback-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vbHphYn0wOXD1bHpMQYwNwNBjpv9p99tZs4VPUHzLXE=;
	b=DACnfIt8J+wqT1Di7jpWYF1rV8OnSKuqmvgxMpbgWCo6WU4sF8+kASgmjNIQ0F6j9gxu
	 FADM7OdIdbNbL1j7B9JKot1nwSNAAsVt2WgopA2JHextwFF+kPFBDI07j/VPOxW5t/Ela
	 fq2lQiOHZ0UOtXiNn3YMuekEuUz3qZgAhpkOh+8pxjhEF7aN1i6d/paY7vswpj/v22gY/
	 StLzbaeWXY3w0FcVcGvk3HK4k4YwgqwxTkeoc2XVCe2tdXzqCaPUH3OzVSfFQm+8ObsD6
	 NiXTeAdhjibSdReyY97Pn6dCmwGik0W7D+0zSuniugY+jFflccdYgET60EHA6oxfUmA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795458664;
	bh=vbHphYn0wOXD1bHpMQYwNwNBjpv9p99tZs4VPUHzLXE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r1xSmdkejzIlGskuSIXP1CS2xTDnblyug6BIVE4wVqqZuv+Kj01nnKNZP3YU3I3aF
	 5SeOVTfuIue+carq+NHW7cr/KsujKDRsenQU9Pg1zDiD2lvz+/uk1poXWxQ7cvMjhi
	 WYZ/DN7PLblUg3rf5Zgz12cvYqRM0rQIh8Qfw/r30IaXXNQjU6yh2M1CD1+QSUgOZM
	 fSCyxu9EWzc2K1uFtsv2u7ghs5y726OJGG7qnXlAmxUjp/Xvpuvhqf1gOoU75VkS+w
	 G5w2NlYRe17H+C7BADvy44ec/PXdgqHejuD7mhFBdvsxoph4JPIh10riZ8W6lm4kFn
	 mJsvD221EFNKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 390F3405DC;
	Mon, 23 Nov 2026 18:31:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A1F67499
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 18:31:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 933C080DD7
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 18:31:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TX1j6sdnQgeK for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 18:31:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D694280CE8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=185.56.87.12
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.56.87.12;
 helo=delivery.antispam.mailspamprotection.com;
 envelope-from=francesco@valla.it; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=antispam.mailspamprotection.com
 header.i=@antispam.mailspamprotection.com header.a=rsa-sha256
 header.s=default header.b=EhpfFeCk; 
 dkim=pass (1024-bit key,
 unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256
 header.s=default header.b=IEhcZQDN
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.12])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D694280CE8
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 18:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Message-ID:Cc:To
 :From:Date:Reply-To:List-Unsubscribe;
 bh=vbHphYn0wOXD1bHpMQYwNwNBjpv9p99tZs4VPUHzLXE=; b=EhpfFeCkOcfkmTKEv8xTl6zK3v
 GmahhinsmaN+TeTwZpiLB2JkzTl9091R1e1C4z0nKa60oZ7tNy2k0szYYpD+G1lrLlPqgCym2LBvW
 v14LOkhfTsw5vv56yg034s6Fq9AnJe7v1deFlFSnMdge3DCBultiKvvlatwWR3mRKbN0=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-h034.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <francesco@valla.it>) id 1xVYob-00000008NKH-260h
 for u-boot@lists.u-boot-project.org; Mon, 23 Nov 2026 18:30:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=vbHphYn0wOXD1bHpMQYwNwNBjpv9p99tZs4VPUHzLXE=; b=IEhcZQDNwhZrA4GOesVNvVHE1u
 1SsHW1H1Zn7pysPRj05qfqvkQo2aUbi/z0bDh4GOzCt79YU0VL+yfmC5l1ruKEV0/QVXtKfYF2a6u
 zvZ3Srp0Qf8EmuaZm06aEsZ0TtWnsc+LzYQSk+xcYPoy3+Jv7wMCKduBxyRvqMGBFqsc=;
Received: from [79.28.115.6] (port=60039 helo=dummy.faircode.eu)
 by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.100.1) (envelope-from <francesco@valla.it>)
 id 1xVYoW-00000000MPI-3cuu; Mon, 23 Nov 2026 18:30:52 +0000
Date: Mon, 23 Nov 2026 19:30:49 +0100
From: Francesco Valla <francesco@valla.it>
To: Robert Nelson <robertcnelson@gmail.com>
Cc: Andrew Davis <afd@ti.com>, u-boot@lists.u-boot-project.org,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nishanth Menon <nm@ti.com>, Chintan Vankar <c-vankar@ti.com>,
 Anshul Dalal <anshuld@ti.com>
Message-ID: <0a5e7afd-16e2-41d5-ada8-26d7319d1a3c@valla.it>
In-Reply-To: <CAOCHtYgFFK80kwayuDi-bUw21_s0+7qwqUSJT0ChRu3Edd=zLw@mail.gmail.com>
References: <20261123-am67a-ethernet-boot-v1-0-94520ed74c90@valla.it>
 <20261123-am67a-ethernet-boot-v1-1-94520ed74c90@valla.it>
 <df5e2301-787e-43a9-b7bf-4081b0267133@ti.com>
 <CAOCHtYgFFK80kwayuDi-bUw21_s0+7qwqUSJT0ChRu3Edd=zLw@mail.gmail.com>
Subject: Re: [PATCH 1/6] arm: dts: k3-am67a-r5: Fix DM2TIFS secproxy thread ID
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <0a5e7afd-16e2-41d5-ada8-26d7319d1a3c@valla.it>
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.u-boot-project.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: eb49e116b3707a1bf03759de1149d3a7
X-AntiAbuse: ID - eb49e116b3707a1bf03759de1149d3a7
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xVYob-00000008NKH-260h-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-h034.prod.antispam.mailspamprotection.com; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

23 Nov 2026 17:17:49 Robert Nelson <robertcnelson@gmail.com>:

> On Mon, Nov 23, 2026 at 10:10=E2=80=AFAM Andrew Davis <afd@ti.com> wrote:
>>
>> On 11/22/26 5:54 PM, Francesco Valla wrote:
>>> The DM2TIFS secure proxy threads for the AM67A R5F are 28/29, as alread=
y
>>> fixed for the J722S EVM in commit e25900438256
>>
>> AM67A and J722S are the same device (family name vs market segment name)=
.
>> Content of `k3-am67a-r5.dtsi` should match `k3-j722s-r5.dtsi`. I wonder
>> if `k3-am67a-r5-beagley-ai.dts` should just include the latter and we
>> delete the former.
>
> I agree, best to use a shared k3-j722s-r5.dtsi over a unique k3-am67a-r5.=
dtsi!

Sounds reasonable. I'll send a separate patch set and later
rebase this one.

>
> Regards,
>
> --
> Robert Nelson
> https://rcn-ee.com/

Thank you!

Regards,
Francesco



