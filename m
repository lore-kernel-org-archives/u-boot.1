Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0427606D819
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 16:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rv0g+2e+;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=vd//7F/x
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B6A758196E;
	Fri,  6 Nov 2026 16:35:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VoNDO8cScns2; Fri,  6 Nov 2026 16:35:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CC9588165A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793982936;
	b=ZtiSjj/WSbLMKVMTITkBa4uMf2dzaA7C5TNRsBMe5jkMGTIMcR7w78LDax8TEOYcmeQS
	 zuv3+rtcayARUZMcrPrLwV95v1MbO7AvuAMF+Kuz9bznZRNCxQLPf7NNutmmz3w6EHZYj
	 EQKY05CeGKYMcuyANdJKpbfZPWEd6JJ4d7RYBDLPKKMnonydhGklB9AQrshk5upzjiC2/
	 rTujO9yBSAdtY3tXEvbZjigcEhyMKlJ6QZnZXtYg58kKLEHrQiV9esPgGLncmogr5+C88
	 cRb39lWmUubncFhB7nQjhY1gGf/WGhaEslydxvunXhM2aldhMCDuHfycGVG2cox0g6w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793982936;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dCvWKm6tTRJmRMOekSj++64CI7wsSJmHzA2knAiwlpg=;
	b=sUsj3W7lxo5ge4juVUPUE64qG4Mw7byOjWBCjCOH2qP4P8UaZGuhXzI4f+SZibQ8vHkv
	 7NhLiY1lALk+Bka2SpGkk+P1rQVpqy0QtdLQxyGFx/7Vvk7gspYJJNKcRTwMFWzvzN6hL
	 ew9mM0Fh4NyGugjam2HNovFTNd4ok3xro76np5c6ou6IsJxX8eM3WteE7QC8bREU+xj4y
	 a0stnKpy5A9y51QbFr9S3pauAhq3YdzgHL6eSJvEch+v2wMVejQZ3sVRUcLeNIWnl4S3n
	 f4mdasjpneKJmeWam+0YTpasZQwlbNnRxFshFWKiMQayKqbzovthfq9FmNdlfs7hi2A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b="vd//7F/x";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793982935;
	bh=dCvWKm6tTRJmRMOekSj++64CI7wsSJmHzA2knAiwlpg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rv0g+2e+PVSGw6IPTlvcsklTZze2b4impd1oQRpl/LNqyFu4b4m/0FmhK/x19TRsz
	 dZEstRYZM68sddraca55LU+42hRPiWhh9ZVDQUQWWO9aaJjdMAOajxUVEpt230XqLw
	 Vm+g3U4TMvQsrdXeGYPMxSja/6VtJBiwVySP4PvnDSh2G3MvCnCyML6eTMzrJbPzvy
	 O7TZVGzUXMZ+id7tJpx8sky9gWacpf7u9sjuJn/fBf6+s27kDIjGFBOpSsy+ONxwvu
	 sEMRbzxuGqFCsERLWB+1CWdjpK+5W9o98jLb+spx8IymnL4dVU8xm354ExZy9mmfc4
	 TuXSKnXPEftjw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CC9588165A;
	Fri,  6 Nov 2026 16:35:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C27802AC
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:35:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A7A4A8165A
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:35:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bnPu6DCf33pB for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 16:35:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5CE5F81270
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=80.241.56.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.172;
 helo=mout-p-202.mailbox.org; envelope-from=stefan.roese@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=vd//7F/x
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5CE5F81270
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:35:31 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jLlCh1zNbzMlCx;
 Fri, 06 Nov 2026 17:35:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793982928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dCvWKm6tTRJmRMOekSj++64CI7wsSJmHzA2knAiwlpg=;
 b=vd//7F/xfw8k9ulAetOUpY33qMldwjqChoj+MgOlBa7B1cdyyL9IHSBF6dCWT0YCQtggr7
 yDVVzFUIGmYM0RHG2Na2p3G662184s92agx7loSAh62Ac9ZuNXTUb8j5SdGtEmpSj/uyQG
 OSqjhFHEkLu9P+ufPRHcyuWQGelk+P6n4MaUuL7kdpbditByoLDqK7cN9AP2GEsPCxEUPc
 Up3RdSTVZ3Y7fdgWmdU+ZfpOyH/9dz9cT/tZGYfC6hiKil6yJ4C9xIAWTPXgCjDJygp873
 C58ocjbEMgKsSxWBhZuDaMYfYgfOdHTUcQsXmflqpbg7A+Jn4ZBI+hRnT3LugA==
Message-ID: <44d06665-a5e6-4054-b6c8-8d961af8a147@mailbox.org>
Date: Fri, 6 Nov 2026 17:35:26 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] ata/mvebu: set up each Armada 388 AHCI controller
To: Igor Velkov <iav@iav.lv>, Tom Rini <trini@konsulko.com>,
 Aaron Williams <awilliams@marvell.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Chris Packham <judge.packham@gmail.com>,
 Robert Marko <robert.marko@sartura.hr>, Baruch Siach <baruch@tkos.co.il>,
 u-boot@lists.u-boot-project.org
References: <20261003-ahci-mvebu-windows-v1-0-e382f73fc299@iav.lv>
 <20261102-ping-ahci-1@iav.lv>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <20261102-ping-ahci-1@iav.lv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: d6i1t19qbxndbqmikcj5zsjd4mim76md
X-MBO-RS-ID: 3a3d21308d4772dd1b9
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Igor,

On 02.11.26 19:20, Igor Velkov wrote:
 > Hi Stefan,
 >
 > Gentle ping: you reviewed both patches on Oct 5.
 > Could you pick them up?

Sorry for the delay, I was busy with other things. Both patches are
applied to u-boot-marvell/main now and will go into my next pull
request for -rc2.

Thanks,
Stefan

