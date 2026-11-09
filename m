Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D8C606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 22:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=1KnqQS71;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GEkFXjaS
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1E423407C7;
	Mon,  9 Nov 2026 22:36:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eg3H-WBr3YhW; Mon,  9 Nov 2026 22:36:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 92C8F405A2
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794263774;
	b=q0E8pD3K3pkB3CJPcc0jDq2lpDcAIUuIKs4zVnrr9AiT3hPIvQvIdFz7/o6+f0BZOuBi
	 VR3js+yRU6t/Fw4S9nXRHxvut4YhrmOWYDB2uQ+nb3f5T5IC2x4TUdkm8WqS1fBVzd/e9
	 zhK/WTmVPBFNI5e+PR2+xGHfgaJBjnlWH5retlBixUTrpWNPyVApbCrIdoPUHD226wVmd
	 5TobGR6+EOkBxr8ZaGMpr8KqbnAsp8IH9OZ3MlSWdSaP0a21RbRVVaAiEDXRwd/AayW0t
	 ZnR3bbwVJeSwrMl0OufA3LFRfUbBWWBbP3DQebSgD35A1bQYWGh2C4CO+Kk/SduccTA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794263774;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:X-Mizu-Trace-ID:
	 X-Migadu-Flow:Date:From:To:CC:Subject:In-Reply-To:References:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=frVcThTVxKdovAFHH90e9Hwci75I8ZRMZmi87kKJOG8=;
	b=Z9HGLUOb7N5Ii3ZlM6gN4mdlJhszSVE4QiUTawpzqvfGE5naxnoXlxfTZFdaGZXzMQwa
	 PUAhQuA6eYfPy84w6R0WO3opN54kEBZ/TuNpWWqyG/p/AHdUx3yZqxg62yQSSS5ruSKD8
	 4Xy5KSXXCW/ZCkbTmyEU9RYKYQKvyp14jdu9oTWQF9XD4XIEuuv38sQTDr7TsWY9WLPxP
	 MaLsukqHzZAj0zISIDXTDik+d5teOf+dGnv/EoILWe44D0aNACWBXmFG0YFrqciEBDQWp
	 MWt6iAQVHxhsaKZvWzIeXF1tU9MjXyGCsBwjSjuqxojYeQTm0PmHmmZ8i5autYUuR5A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794263774;
	bh=frVcThTVxKdovAFHH90e9Hwci75I8ZRMZmi87kKJOG8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1KnqQS71Nn/8Rfd50/CFvyRAiO3ByggDgHHR4tsTRLNOzScaqJbrbNgOL/Va2JdyG
	 xt+XfUB/pAgDd2WzCBiWwzSVE+CSedItCQGRGyQRrUGD76iwOyeii8PaWv1rkmYj08
	 KVReDzpxliXZXMgKWSEQAZ3Zk/B0Z3qBXusQW/jBPXnqAr/WHMMa0EVHGN33oG7Y5p
	 GEUz3gwthV++vi4BVuwyKONFBSzf5hTwIkAJ3NAd37fC8akGCeXnatSM0lo2WfSDct
	 UgmkxHjH+hmZMwYH/THqsKBq7GqP4h7CqCzg2i/xhi7NLNzAKqLq2OgdJ0d2N8X0ck
	 SXY/znQoSwNYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 92C8F405A2;
	Mon,  9 Nov 2026 22:36:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CF4F3235
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 22:24:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C0E40607AB
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 22:24:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mkd9ycVHujHy for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 22:24:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8F73F606F2
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:41d0:203:375::5b"
X-Greylist: delayed 62 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 09 Nov 2026 22:24:43 UTC
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=GEkFXjaS
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:41d0:203:375::5b; helo=mta1.migadu.com;
 envelope-from=bradley.morgan@linux.dev; receiver=<UNKNOWN> 
Received: from mta1.migadu.com (out-91.mta1.migadu.com
 [IPv6:2001:41d0:203:375::5b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8F73F606F2
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 22:24:42 +0000 (UTC)
X-Envelope-To: u-boot@lists.u-boot-project.org
DKIM-Signature: a=rsa-sha256; bh=frVcThTVxKdovAFHH90e9Hwci75I8ZRMZmi87kKJOG8=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794263081; v=1; x=1794867881;
 b=GEkFXjaSq+gcFXhl1TVJj+H/nxz+SPvFZkHwA2uDD8Y4XlUJY3XjrOYsDzsm9pTDHh9WPJbI
 xS3G9ZRNI1I5s5gNo1wjGiIQ+WgQGRXpC6h1xxumjtC8kniSgmjc18tI63rv3YCQe7uLFGb7jj2
 aLPfr2FIXvVnAl6ok8gk8oLg=
X-Envelope-To: u-boot@lists.u-boot-project.org
Received: by smtp.migadu.com with ESMTPS id 6a43d8d2d76bd38e;
 Mon, 09 Nov 2026 22:23:37 +0000
X-Mizu-Trace-ID: 6a43d8d2d76bd38e
X-Migadu-Flow: FLOW_OUT
Date: Mon, 09 Nov 2026 22:23:35 +0000
From: Bradley Morgan <bradley.morgan@linux.dev>
To: Josef Schlehofer <pepe.schlehofer@gmail.com>
CC: Bradley Morgan <brads@mainlining.org>, u-boot@lists.u-boot-project.org,
 trini@konsulko.com, kabel@kernel.org, marek.mojik@nic.cz, peng.fan@nxp.com,
 priyanka.jain@nxp.com, qiang.zhao@nxp.com, Shengzhou.Liu@nxp.com,
 chleroy@kernel.org, christophe.leroy@csgroup.eu, mario.six@gdsys.cc,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 hs@nabladev.com, holger.brunck@hitachienergy.com, sjg@chromium.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_04/14=5D_powerpc=3A_lib=3A_Add?=
 =?US-ASCII?Q?_64-bit_division_to_the_private_libgcc?=
In-Reply-To: <20261109222037.73759-1-pepe.schlehofer@gmail.com>
References: <20261018083516.49229-1-pepe.schlehofer@gmail.com>
 <20261018083516.49229-5-pepe.schlehofer@gmail.com>
 <3CB2A762-EDFD-4258-A4C4-73082EBF4DAB@mainlining.org>
 <20261109222037.73759-1-pepe.schlehofer@gmail.com>
Message-ID: <B3611024-7467-4EBC-AE27-8D7F9EA5CF2F@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 09 Nov 2026 22:36:12 +0000
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 9 November 2026 22:20:37 GMT, Josef Schlehofer
<pepe.schlehofer@gmail.com> wrote:
>Hi Bradley,
>
>thanks for the review, and apologies for the delayed reply.

That's ok.

>
>> What's your source? Maybe cite it?
>
>The implementation is based on __div64_32() from U-Boot's lib/div64.c,
>and the copyright notices are taken from the same file. The comment
>above them already mentions the source, but I'll make the attribution
>more explicit.

Thanks.

>
>> Could we clarify that better?
>
>Sure. That comment also comes from lib/div64.c. The algorithm first
>divides the high 32-bit word, so this step is only valid when the
>divisor fits into 32 bits.
>
>Regarding 03/14, I don't think a separate MAINTAINERS entry is needed.
>Your POWERPC entry already covers arch/powerpc/.

Hmm. Okay, if you end up not getting CCed, I'll CC you in patches to that.

>
>I can send a v3 with these two updates and the tags I've collected, or
>you can make the changes when applying the series. Either works for me.

Hey, could you do the V3 cc'ing me? If that doesn't kill you.

>
>Best,
>Josef
>

--- Thanks!
