Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B35E606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 16:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=P2ECh/18;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=kkvOVFmq;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=gy4pQINi
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BCA9B81DF0;
	Fri, 30 Oct 2026 16:08:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mSx9L0GGgR0B; Fri, 30 Oct 2026 16:08:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9E8E881BB2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793376499;
	b=PCHTgVgx7D0ZfB1VXGnSNhtkTf3Fn6hZSzKIo45i2SjECHTMdPWP0MN8nt0BY7EQqX+O
	 pj5/8meYc7dP3MqNcHGqZN/3uvYEuf6I2nK00L66d2wcv6CtqltN/enSDCsAilTWAOBr6
	 V73yLlqI7h1TLFZ43iKZK+KGmSf1mvf1m0KtcjLdZh3Zompj7e0Rubu2sAZr1Um5ZWIUv
	 BlJ1EeRtWs34a7D4BTLUCjpP6AR7/j7DZ2mneVVRhr8bvyXgm7GCp2fv2VZGcxNM74uuO
	 msQ0OLSmOOZvuY0S6CboZpXm6OGvgRHp3c2BUcAHuexrz22NEV5p/V1NEdKWi4QDSmg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793376499;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=yEnnMOqjcdOtFs5R/xZPWNSyHVB7MdVZK/SNYPNDUts=;
	b=PLYk1h+Vod2KFF6/DFdHAar6p7FWeBSPjUdbW1EEvfXstP3G9QOnciSSE8dfSamHXRuD
	 lmu/RJjdXlWeOGy/4GaHG+NIbrOZyN2Ljuiu0Es5j70bIknHeqUdUdmSlCKvdlP5j5jyT
	 S55T63JT54X3MyjcPHyJX1B5iYO32rCy7CvMNQUyLLurAukXKVwblc8XsfIf1q/n0tEgm
	 0o3/aT3jGCIhsIJKmOh4ed+YBid9nzYF4Qe4mn6YYNem5mK5V/LChvjSXornQgcsBUOMg
	 CqpFbrODG9rd1p5uyWeuiPFTcVVxAY/ZX6WSCWRYGY02h/udoRXxMf92x6NbhL6ocLg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793376499;
	bh=yEnnMOqjcdOtFs5R/xZPWNSyHVB7MdVZK/SNYPNDUts=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P2ECh/18HuTg/2diHn3AYfxKclZ9GpcRNGBgS4+eV1cPZTxSxI/cwpZo8ep+PnFKR
	 h8VY3QNRTDpgJJl4BZ3ax93CgINUPsT7lsiW4zYARgkCeytCaoSFNUc3/wW5/QqBel
	 AENrUeQEtOZhuxnYUdi3OdCM3djeSN9xgVcQn7oNevQ/9uvaZZc1kT9EesBPTu0u5U
	 OeODf3hGH7664EkiJxnhcnV4m5LcYY0ktJOdpeEWfWpgVhv0r/xaR9wjXczvet/nhu
	 meR1MK93DKe8ajpAt38N+0KhGqmUze9GYVcLEbfYmRH1oZAnO0d9lu9gb98hmQ6fML
	 uvMHQYJomJfbA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9E8E881BB2;
	Fri, 30 Oct 2026 16:08:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 94A98529
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 16:08:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 919D960AA2
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 16:08:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rt1ebP8A7KBh for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 16:08:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E84D7605D2
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793376496;
 b=V1NQQDjMYKLaJURP8HgZHeEoxnoXf8gdqyFyo1UiOmdXZ5Pe1d1MIG8GQY7pOks62S6R
 zxDVT/2K8HaWFDTIDnjRiTlkOHm8IhOwlGge7Eoawn/gr7lyZliHGg8g5adSXq2tG2Jjp
 erO9v/pfC5FOI3A9tj4oiZ5jgTr4VO4k+uKT3gYio7Y1llqd8QnyJSgLmLQwyYpJC8fA2
 2JoM8Y3XJSQ78y+J6XmjQRKP/suNi3VxIyUUleXjANPZcRkHriFPLsBsvRFrs+DnEO3kt
 hIv34f3Vw1luLkzLrHidjLOlrcKormgLDcxljMDxnCzrlMRb5T+XN4fBchgxCn5gQPA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793376496;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
 In-Reply-To:References:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=yEnnMOqjcdOtFs5R/xZPWNSyHVB7MdVZK/SNYPNDUts=;
 b=NBA17InWZPwGbYsp6UC9bV7pUV/37rpSnVlmGf6/2Y4EikDm5SumnzZDUj+OurH8ggO+
 2/d7JU0cYucdtcbvBpnafvNjL8AQW5P7AQ8j+E0vNYbG1UziK++uTqlQP/9JiFrbrAyYp
 p0yLL9AOJiyjkEvZGUvok6kA1GnvN4sQOKsblPNQJ2L9JdYPYF6rQaP2gpoZmD6re10bQ
 TC45BHRc8KYlZWs/6bQBdxf1b6ZMSYjd4Hn9/O2MEgMh3AmboEqcq6K/GVJzLn1j9wpym
 oLUr8m7o//dX0WMdfjYbBgIKx1nCy9+NCAiLuNMXko/XIG4kS4DyAKzPPos59IGobCg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=kkvOVFmq; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=gy4pQINi; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mainlining.org
 header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r
 header.b=kkvOVFmq; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=gy4pQINi
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E84D7605D2
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 16:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1793376483; bh=yEnnMOqjcdOtFs5R/xZPWNS
 yHVB7MdVZK/SNYPNDUts=; b=kkvOVFmqasgdTJ2deeLvIR+673bU9zYV46ZjqrafyKfulHWEjD
 ALkuNjrEuuFB0OfcDWP6AA+wDEgBHgNsSUKTLQjJ29RTVSYp3NNu8yceMRyn39HdMuxavubczok
 F5nu8S558Lbct5d0prCSB5Bq6LZ+CV4esC9Y4dWL7TS6I/qrRoRhI0iVI3qtKvc9KGeelNM040N
 5wuhs6P7/V+l97ljl6NN6NrLGNNs0PVynFwHM4w7Brqn5yBJUmawKx3+fakdcOgNDDziwm+bnd+
 iRMtQSTk3k/CZhAjDL1GNjhSeYrj7CLF57B621Ot/h7bA9m5wO5KcvS3wV8Uz8qdR+w==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1793376483; bh=yEnnMOqjcdOtFs5R/xZPWNS
 yHVB7MdVZK/SNYPNDUts=; b=gy4pQINiDxJKY+SoFd8P2R+WyMwXl8ZqjDKCvOfCTHch0KD8PH
 OGdvoQgGEuSJiphDhhJnMAk0vrYNywTA2PDw==;
Date: Fri, 30 Oct 2026 16:08:05 +0000
From: Bradley Morgan <brads@mainlining.org>
To: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
CC: u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2 0/4] doc: arch/powerpc: add architecture documentation
In-Reply-To: <3e11589e-bf81-4172-9bda-e079a1ada057@cherry.de>
References: <20261030020832.26572-1-brads@mainlining.org>
 <179332641005.29622.13964170083166836926.b4-ty@mainlining.org>
 <20261030142436.GK3011578@bill-the-cat>
 <17235E63-E2CD-4B0C-873C-79418E350EE9@mainlining.org>
 <3e11589e-bf81-4172-9bda-e079a1ada057@cherry.de>
Message-ID: <754120A6-EB26-4533-A815-E75EF58A8727@mainlining.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 30 October 2026 16:03:35 GMT, Quentin Schulz <quentin.schulz@cherry.de>
wrote:
>Hi Bradley,
>
>On 10/30/26 3:40 PM, Bradley Morgan wrote:
>> On 30 October 2026 14:24:36 GMT, Tom Rini <trini@konsulko.com> wrote:
>>> On Fri, Oct 30, 2026 at 02:14:08AM +0000, Bradley Morgan wrote:
>>>> On Fri, 30 Oct 2026 02:08:27 +0000, Bradley Morgan wrote:
>>>>> There is almost nothing in doc/arch/ for powerpc, so this adds a
>>> folder
>>>>> like the x86 one, with four pages:
>>>>> 
>>>>> - an overview: what the port is, the cpu families, the boards, how to
>>>>>    build it, the config options people ask about
>>>>> 
>>>>> - the mpc85xx boot images: the NOR, RAMBOOT and NAND layouts, and the
>>>>>    CONFIG_SYS_MPC85XX_NO_RESETVEC and SPL/TPL knobs
>>>>> 
>>>>> [...]
>>>> 
>>>> Applied to next at u-boot-ppc, Thanks!
>>>> 
>>>> [1/4] doc: arch/powerpc: add an overview
>>>>       
>>>
>https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/e6a37f4dfeea
>>>> [2/4] doc: arch/powerpc: document the mpc85xx boot images
>>>>       
>>>
>https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/3287ff140823
>>>> [3/4] doc: arch/powerpc: add a PBL guide
>>>>       
>>>
>https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/b74d2c1efaac
>>>> [4/4] doc: arch/powerpc: add a booting and porting guide
>>>>       
>>>
>https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/0851db824add
>>> 
>>> For non-critical changes, please wait at least a few days. I'm hoping
>>> that for the documentation stuff you're doing that Heinrich will have a
>>> chance to look at them, for example.
>> 
>> Hi, don't panic, I'll drop them if there is issues.
>> 
>
>I do not review patches that were already merged, so you guarantee
>yourself at least one fewer pair of eyes on your patches. Dropping commits
>you've said you've merged should really be last resort, and should be
>explicitly and publicly communicated, with changes made to their state in
>patchwork as well, otherwise we are going to lose patches and people think
>some patches they found on the mailing list were merged.

Understood.

>
>There is almost nothing that requires merging that fast, *especially
>without reviews*. And if something requires merging that fast, a lot of
>eyes should be on it. We've had a case like that a few months ago with the
>critical vulnerability for FIT image verification for example and we still
>didn't merge that fast.

Ack.

>
>Merging without reviews could be seen as a way to introduce
>vulnerabilities in the project. The contributor rules still apply when
>sending patches even if you are a custodian. There's some grey area when
>you're contributing to some area where nobody reviews or maintains, but
>usually Tom eventually gets to those I believe. PPC is one of those grey
>areas because there are so few contributors and until now no active
>custodian as far as I understood, so I'm not sure what we are expecting as
>a workflow here to be honest. We'll figure something out on the way I
>guess.

Yeah, no reviewers sadly. So in in a hole on the ground here, hmm, maybe
another guy could be reviewer too, 1 M one R entry.

>
>You also sent a v1 at 1:49pm UTC today, then a v2 about an hour later, and
>merged a few minutes after. Please wait a few days between versions so
>people can review the latest version and the ML doesn't get spammed. If
>you found issues in your v1 and don't want people to waste time on some
>parts you're going to modify anyway in a v2, you can answer to your own
>mail and specify what you're going to replace (i.e. doing a review of your
>own code).

I did a Self-NAK.

>
>> Also, remind me, is Heinrich the Hitachi guy? I don't remember.
>> 
>
>$ grep Heinrich MAINTAINERS
>M:	Heinrich Schuchardt <xypron.glpk@gmx.de>
>M:	Heinrich Schuchardt <xypron.glpk@gmx.de>
>R:	Heinrich Schuchardt <xypron.glpk@gmx.de>

AHH. Makes sense, cheers

>
>Cheers,
>Quentin
>

--- Thanks!
