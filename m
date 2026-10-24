Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748AF606A320
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 14:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LNJKWSj0;
	dkim=pass (1024-bit key, unprotected) header.d=saper.info header.i=@saper.info header.a=rsa-sha256 header.s=Sep2014 header.b=RHLFZLSg
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4CB2B810E6;
	Sat, 24 Oct 2026 14:47:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QRs0dAGpMfHv; Sat, 24 Oct 2026 14:47:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3587C816F5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792853228;
	b=ZQFrHYlIizV7MvK8M/g9L1SkkD4XNtkzltWihhpryk1W+gJUJyyKl0K+kAPnhvl4+lEN
	 HhXSAPATm+l0+iy/bN/yVmbeiz7VpFGgBpgf3spRYOPYAL5aPLojxp44SY8XQoA5yy1zj
	 Nhy2FoZKEvu+/6m7OaZz80KJ2QC+UN1gjfsegZtWwFtfsBjo3ZmTmywJt8o+51A5CWNfB
	 5lO+KIg7vjECHtABmAz3yJTOaYaApzu2p7RfN8iBp+sY6CPRPQfYDYP+Bs/N324bg1GgQ
	 m6Vbb79OjmVlps5E4W02+ckqyBuAbI66gnMPas6sRb/xeg341pMOvmzPUCeucM5C6vw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792853228;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:Received:X-Authentication-Warning:Date:From:
	 To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=hREa+kSJH7mEclbjLCkSQaIZqHikJuVpBqzR2HZfBwU=;
	b=n7wpgT4SzAv8T3vGbqPwY+oMyAri/vd0w7d4G+3ahy25ie493P5cvyuhse0YuvGZ7qYU
	 LfdmnmLtfrI4jPCQB9mTEX3RUrW0jtWcWrhIOb2u6KHhbDcGzoeeQ/VsgKtttlyfYFiuW
	 hDUMIy4+JMsF7sxu6lNlBIRp+kF9RQcMDEKadJWZPzYnG44vEmIb+DMr0H2DmFRgl/tv7
	 D4QSHS2l91gXgjAg6E2eIEZApguwAMA8Ye/lFwheQ3bxndAudxsKpC0YTxREOKW2VIUYf
	 XCwPSn/HpwrpdTdVY/da3t5I9sIMTmGEBBilJMZ5s+SMsNo3QVIknOQ2CDYnDqBY7Rg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792853228;
	bh=hREa+kSJH7mEclbjLCkSQaIZqHikJuVpBqzR2HZfBwU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LNJKWSj0ReOshBv8aNyFUPL7L7PU59wBWGTrcvX7+awubKQli6VHQ9OxBmm8zEeg2
	 E9ugPkjhzEWH+yjOvbqorxTCBVB8qA03OhCH5agABMmUqztRIzMONMVll4ifUgSshK
	 MQ23BFaQ3cf3qX/t5vwySSm1RzRL5d6WF2lhzXkzuqKZs5RcWlwB2oLTjLM+PmAdON
	 bqwbgGkj6hQ/DzrXFl6Mm5QRb0zyefEorV6U2ibDkI7g8ildA/D+u8qQHl1KAAEe3t
	 Qr4RzkY4TLzcD3qDExXgD3I9+K3uOYhdhXghHdXxmJh9utKUuI5eVywzwWbAcYlKNF
	 tDILu9EcEWLAw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3587C816F5;
	Sat, 24 Oct 2026 14:47:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id EEB60380
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 14:47:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EC77840967
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 14:47:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HKaN07g7JR08 for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 14:47:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E233640912
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2605:2700:0:2:a800:ff:fec7:5c61"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792853224;
 b=lCUQ098SbHCemN6pMXkMx5ojbqvU+nncP+jaG++xi0sDbmAHNjGKvnd4f/mhVWwDDVkL
 glRleQAkbBmsZF4vZqTRqVzawOB3W5xvkYN26nfEzS3sFmQmwzUKTxRrrpnnmnaUUlbL0
 oFhKfydnmdW1gWgZibGb9hXFnVMO/zwU8aHc4F7VzldtBhFlVQKZjldRvsgNlZZu8GOe5
 DOp37OTxXWVgF+kCWKVjtYsOcgBOxSha1rMa3rz0XZUPD33u4PuloWsPxUD/rt+IE4WOk
 McZu/YR/pqZLOxGFFbo++1euJEA2TmpEk6mzj2+S/GnDdQDQldlFpLXd2rYEKeIhIHw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792853224;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:Received:
 X-Authentication-Warning:Date:From:To:cc:Subject:In-Reply-To:
 Message-ID:References:MIME-Version:Content-Type;
 bh=hREa+kSJH7mEclbjLCkSQaIZqHikJuVpBqzR2HZfBwU=;
 b=cynGjcdIVj8xf0+Y8KYnSMRIIABpRzPXB6WB8olZqvaXZYXFhd/olFJxiJmOMQWOBulH
 IAJ8hDrMW5B0SRY9W3pfEWMWF+4iXKTShzWBxp00nPry+BcDyXcww6Fyc6QwBEQSoga/c
 VjvOoZ1HIbAMzUER0cDHILt84ZmuSjN6zszQzeimHwd5KNIh+5cEbvYtVVLvQIwC4EuGb
 L9sIRm1kVV3OgGExNhYTIP9MnWdAZurF6wjEakPXBnyMTESPktPXSrF8ggzm0GmWE33Yv
 V0SZEKkYkwDvBOg1kD2npRgex+hQ/kh/SoAk80dXSt1+1Jwe/muFfv2f/LpGkSMnsRQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=saper.info;
 dkim=pass header.d=saper.info header.i=@saper.info header.a=rsa-sha256
 header.s=Sep2014 header.b=RHLFZLSg; 
 arc=none smtp.remote-ip="2605:2700:0:2:a800:ff:fec7:5c61"
X-Greylist: delayed 847 seconds by postgrey-1.37 at util1.osuosl.org;
 Sat, 24 Oct 2026 14:47:02 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=saper.info
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=saper.info header.i=@saper.info header.a=rsa-sha256
 header.s=Sep2014 header.b=RHLFZLSg
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2605:2700:0:2:a800:ff:fec7:5c61; helo=q.saper.info;
 envelope-from=saper@saper.info; receiver=<UNKNOWN> 
Received: from q.saper.info (q.saper.info
 [IPv6:2605:2700:0:2:a800:ff:fec7:5c61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E233640912
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 14:47:01 +0000 (UTC)
Received: from q.saper.info (localhost [127.0.0.1])
 by q.saper.info (8.18.1/8.18.1) with ESMTPS id 69OEWmT2033209
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
 Sat, 24 Oct 2026 14:32:48 GMT (envelope-from saper@saper.info)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=saper.info;
 s=Sep2014; t=1792852368;
 bh=hREa+kSJH7mEclbjLCkSQaIZqHikJuVpBqzR2HZfBwU=;
 h=Date:From:To:cc:Subject:In-Reply-To:References;
 b=RHLFZLSg44EclFm7AodLpnr/fzwd+3gzdHYAZKaKcyWcLTTn2wvFDbLDm9zS/WLKX
 AquSgeMMZeWY8GD+t1N/vJbburID6RMfg1YXsxcvq2Qwqpec4gP0ef1/aMpBXwhurC
 NirqsygoQ0uO+GWwWFDUt9o4WDbH4+wOdM+g5DXA=
Received: from localhost (saper@localhost)
 by q.saper.info (8.18.1/8.18.1/Submit) with ESMTP id 69OEWmZS033206;
 Sat, 24 Oct 2026 14:32:48 GMT (envelope-from saper@saper.info)
X-Authentication-Warning: q.saper.info: saper owned process doing -bs
Date: Sat, 24 Oct 2026 14:32:48 +0000
From: Marcin Cieslak <saper@saper.info>
To: Simon Glass <sjg@chromium.org>
cc: yan.wang@softathome.com, trini+nodisclaimer@konsulko.com,
 sjg+nodisclaimer@chromium.org, alpernebiyasak+nodisclaimer@gmail.com,
 marex+nodisclaimer@nabladev.com,
 philippe.reynes+nodisclaimer@softathome.com,
 paul.henrys_ext+nodisclaimer@softathome.com,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 0/5] binman: Add HSM signing support to pre-load entry type
In-Reply-To: <CAFLszTjVm0ApA=N-9ATAVd-ZvUu-NgCGJ3iUyOUP25h-ivNHRQ@mail.gmail.com>
Message-ID: <57391ss7-n128-qpp5-o60n-onq09rs12noq@fncre.vasb>
References: <20261012104805.17297-1-yan.wang@softathome.com>
 <CAFLszTjVm0ApA=N-9ATAVd-ZvUu-NgCGJ3iUyOUP25h-ivNHRQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 17 Oct 2026, Simon Glass wrote:

> Hi Yan,
>
> On 2026-10-12T10:47:59, Yan WANG <yan.wang@softathome.com> wrote:
>
>> The implementation builds on the existing pkcs11_tool btool: a sign()
>> method is added that drives pkcs11-tool to perform the actual
>> cryptographic operation.
>
> Binman can already describe a PKCS#11 key for FIT signing: fit,engine
> set to pkcs11, with fit,engine-keydir and key-name-hint, which become
> a pkcs11: URI. This series adds a second scheme of eight properties
> that works quite differently. It would be better for users if pre-load
> followed the FIT conventions, e.g. a single PKCS#11 URI property for
> the token and key plus the module path. Then both entry types would be
> configured the same way. What do you think?

I have another idea, not directly related to this patch (this could also
be used in mkimage) - would a two-step asynchronous process be acceptable?

First step, binman calculates byte ranges to be signed and provides
a value (possibly a hash) that can be fed to a signing process.

External process talks to the HSM via the interface of choice
and provides a ready-to-embed signature for the actual binman run.
Yes, this breaks the notion "only run binman once", unfortunately.

That would decouple us from the openssl engine/pkcs11/whatever interfaces
and also could enable enterprise-grade workflows where signing
a production image involves approvals, n-of-m or whatever additional
protections might be needed.

Marcin
