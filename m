Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1724C606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 02:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=v7D5mItz;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=Ynd1j6ql
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 87D8A60ABD;
	Sat, 31 Oct 2026 02:58:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YQ9tcCCdiK-b; Sat, 31 Oct 2026 02:58:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E6286606A9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793415480;
	b=RmwoG/bYpRChvVFZgYjCBZvs1hsVeYAswE0U7AeE5N9/7vezL8Rb6KtG6GP4EzO5LVTm
	 vJicHdvur/+FQ+TkTjkXYmx/SbMN2d8JMqlS62FUjezotlaI2Ynl8o8KW5GdNXowpxe17
	 3WvQP8J37yIkwDzAXw/7hgAcsfPa5IutkOH6rIUlWB8h1A08h2zIA59S2GJ+OFmF3a+XB
	 rF8zS6XAscqm0lf9gRXS/lAT9xbV2S/V7iU/jDWoDABCOLz9sI+eq/GK9JVXwajVSsi/U
	 1UteSG7nfx6lUg8smfLLVr8FXvDB/6NRUcVPDGzEXjaErnjZ/SP1cwhupCVfm1/a41g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793415480;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RaRZCvnLb6GupQGOZtQFbxqancrOUzFSzN4D4NzTSqk=;
	b=nyWNCOm6qI9Dz428X1NjOkFGOca/4fqlWvzuxSeFlx420rYPHzF6NJRLWOaIUYI+vA0g
	 WwjZqRUhwHVNsHb01a9WaflYPAdh86albzVt5riXm4ekGmxAhcT2IISxqz1AQEKyjshpy
	 yJ5+/8j/2zqF9gV0lVagxPWR0IremjBanJgT9O2c1/84Jiden7HkegQtwSn6kSVJv92PE
	 bkjiOak86x5F8fTzl+j35exoeWeylNVN+Ji0GcIF08EAq0xAy/NcBUz91WrL1T8ToCRgS
	 WhDhCUFvGjp23jhiJyl4CcxmmNmIzWg7OvcZECyuCOhT4at/Dxn+RvEYWmUAa5Mkfkg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793415480;
	bh=RaRZCvnLb6GupQGOZtQFbxqancrOUzFSzN4D4NzTSqk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=v7D5mItzjTwQINJTyEqLLFSYJCmNQ8lcAAxoybqeXUFiGvnfWRXwXh+qO8g3RSDy/
	 AAjpHGxJsX18MdVcjIAlwrkgCFqbvgyKfYGbd4U/5wTQ/Ds7+xFv1uXMqZkaqx4MD2
	 mtNZouhASjse/mSNq1HCGUKONvBvzI1mY5CxiZ6n9oZiNwHPCKly5WzwC7drrcmL9Q
	 JcF8b3yv43dcdDF01EQByrRFRBe71HwnepJFHsrOBXiupN/iq+/fWTRg4DzKLv9yGZ
	 RLixLbnPuk9wpSr77qBcdc2p3jV+blEAvUFFXoaP1krXcmabrLjpkOBz2CgBVhBfh3
	 IGTjWmgIs77fQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E6286606A9;
	Sat, 31 Oct 2026 02:57:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DDABB529
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 02:57:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BA55081117
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 02:57:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZQ-5I47cg3te for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 02:57:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8AB2781116
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793415478;
 b=girMGCv33746595ckCy858vNl9v2QkuV3MY2qYXeubrpL/mPas0O9byS7zyYZtcXZ4mu
 nesyXZRVAnB1wfHPxJevYxIVBCc7m8vrkjeNm1g8a/LxcAss0Bj2OwEQg5Nd8smrg+OPq
 0uqLEJNRCOsDGZdNC19Ak4XjNWdSQtC8oGdCBhUvXBr+fQNItxMBBB/JEhMD7G86OmJDr
 mZoa16EIGvT50ZVXrE2XvxXEAbc3QHlsXOiEVzY13P4Z8KW5icvwTxG6H8xbSmyqHNoaQ
 8B052dwkqpIE2LvHcHUe1BpdLKXTEzP2+y9njFw027X/SIKICwxhxkpeCZEC5CgKREA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793415478;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=RaRZCvnLb6GupQGOZtQFbxqancrOUzFSzN4D4NzTSqk=;
 b=mfEWXfH+lxMoak+s3AP4r94BKlk4n1487kJT0GnlkbFQGEO+3K4126lxbMpVIC6sDzxv
 mfVwRLmCxGbRKEBsK4GRihlH9bIv00I76hECor3v741I6MBXlRk1RQmsYAHeDOz04IIZM
 yTpicz8/b8HclgEPLhJ7s5baa/SvxQoAFU4laMph00AG9oK0d1xN1X68l4qt6nKESDld8
 3hYgKSt6VtOMFb9X80rE3kfA3Bdf6A3KAcpE8/+QvlB/WNjNDJZmwN8qmRArKkO6NKvbp
 E9nf/SpYpCCJ1DGAnO+Y1yclf7MeS1BAnMODALBOv1L/NcRUGpGtDcmbtu68yb6Hv0w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=Ynd1j6ql; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=Ynd1j6ql
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8AB2781116
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 02:57:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CE16210986E; Sat, 31 Oct 2026 03:57:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1793415469;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=RaRZCvnLb6GupQGOZtQFbxqancrOUzFSzN4D4NzTSqk=;
 b=Ynd1j6qlgyDv0gJl0C8+RxNOFOJL4aV37k4QxVOh5kebfrfwfODFrybvdvgrP+1eYRQMGL
 hFVB903Fs3fE4w6XE3/kUN4ZMkGDwzjqyItOYr6HocS2Dr2jkhWtU4/neDJbGtLRH6QHZy
 go2ANtAAtUvXP+FNjPDKn4sX7sZXCdgRIj9tdgX9p9T8XEXpbVsNZvtN+/seHEhXOWLtul
 a6AD1FvhJMTJdd0O/ghrqcPKr2CIfPZUomvG4Z1h367gfJSawDJHag5p/sTRCuzsx44l36
 4SwLSoFheZmH6URG3IPB6Y2bw19UBraeaLF/fJ1QJduLRWkhazb744XdsZLugA==
Message-ID: <320cdae7-6f59-48a8-9821-575a2825a777@nabladev.com>
Date: Sat, 31 Oct 2026 03:57:48 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: stop generic OHCI and EHCI at OS handoff
To: khaliforce <kforce@gmail.com>, u-boot@lists.u-boot-project.org,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
References: <179128521948.5.12131679420803093421.uboot-usb@gmail.com>
 <3ae0a18e-0fa5-477d-bf5e-89072b9634ba@linaro.org>
 <20261006155833.68374-1-kforce@gmail.com>
 <179339930697.12710.14888890033364215367.uboot-usb-v2-ping@gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <179339930697.12710.14888890033364215367.uboot-usb-v2-ping@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/30/26 11:28 PM, khaliforce wrote:
> Hi Marek, Tom,
> 
> A gentle ping on this v2 patch.
The plan is to land this in 2027.01 release.

Can you please send a V3 and use your full name in the patch authorship ?

Thank you
