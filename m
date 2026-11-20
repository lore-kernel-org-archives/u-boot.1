Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0942D606A32A
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 16:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zp/TExHj;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Z2V8o4vk
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BA13460D8E;
	Fri, 20 Nov 2026 16:18:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gUM9eXUz0E0l; Fri, 20 Nov 2026 16:18:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B3ACA606CE
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795191519;
	b=E35fb+7A0xmYPL7ekMeyxz7LiYlBxktUiB4ssGr3tRo+HiwGe9v0SKUmurB689g/qFqM
	 UzdOG9n9L5lQ+1ZVGlIMX+SgZr+kz/uXsX8VzUetV9ANhty0E8/Vh6a8el6p0L6K9GIDJ
	 XZAHIIQg/LTB0sVLRPV+WhZm3Bbf4u+lsLmJ0LpRZCqP+rJkAeZ/OJJIsHHF5uNQBYV9E
	 AUcCGwTDlANISXjFnh+CVrWUVcV1shHcab5b1RGDwDEeAQO6O4BhGb6h800eXPPy6tdXg
	 0CNzelIk0lx/zHrVZ5mtWkkYrJngD0K6h5/5OyhjKI1HZseSz7WVFbahNZ3Nrj8UrAw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795191519;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:X-Envelope-To:
	 DKIM-Signature:X-Envelope-To:Received:X-Mizu-Trace-ID:X-Migadu-Flow:
	 Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+kldGqxhFS/UyMrpZ5aeVGjV1/w8Lz6I9RlcHmLi0MI=;
	b=CyUPwPLSZ80u2fcKt4vibf6srofewzKSKKrz2IxoMaFH+lssRinP+82FiLxigcm8t5vX
	 X+b0aGcbX6YyLIwJpzvJhlmWNethzuc4QwG+yF6VJGnkPNMkuuzb35kKQ42FeIvsjZHQg
	 16FV+ASU8ESxQth0PyFV3aZEpv1c6saRKgNBdHjMCoRYQ+BWtIERRMPyMFpRZpCoOw3DN
	 uAm652F7yuQBW3QcdQl5L2Qs2h+4x0JJ9Q36RjeI6NtjbAFyVlzgexS8Yh/S64A2pikeg
	 EXJ4bMDBNuFkSZ3TPb4EZdZk7AdAv8jz9raCBo6ryX2jFLegpWowdl2a/S8LaStIvOg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795191519;
	bh=+kldGqxhFS/UyMrpZ5aeVGjV1/w8Lz6I9RlcHmLi0MI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zp/TExHj2TPkin6+9Kgy8uiEbUuwaB+bQALdV86XZfwxb0oeiqE+vKP5oqru81CNf
	 EsHumVF1EIhvtYFaXoCCWGdFsY70ZJP9UV5dLhltuXKNCX1B9QGhrdoxxB9vRXbpAh
	 TiNS82xyTA6v2bJJko7oddyrxujjqv0xfctwtfFTGgEiX46/BjywxKGE6KvcpQCRyT
	 rnNJ7T9ZY+7cfSmsAj1/TcrVL2L9GCpVt1WSzLKajv7SIB6kWxtH+Jq7o3nXOzOk+B
	 NYYucOg+AHN/UFVqISoQ60311dxVCd7baTk5VUVYEcwEaErVfCXvinDGdUQVEB0I6L
	 CLIhX1lFx4KCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B3ACA606CE;
	Fri, 20 Nov 2026 16:18:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CAE1E1E7
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 16:18:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B0C7C40E46
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 16:18:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yagMv6HFw4xE for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 16:18:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7D62340E44
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=95.215.58.197
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=95.215.58.197;
 helo=mta1.migadu.com; envelope-from=bradley.morgan@linux.dev;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=Z2V8o4vk
Received: from mta1.migadu.com (out-197.mta1.migadu.com [95.215.58.197])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7D62340E44
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 16:18:34 +0000 (UTC)
X-Envelope-To: u-boot@lists.u-boot-project.org
DKIM-Signature: a=rsa-sha256; bh=naDzNRY7HBo+3mQpoNP1Pa+AlPLzZcY6ry9dpDwieKs=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795191513; v=1; x=1795796313;
 b=Z2V8o4vkYm9oRr5r911afbEufeFr32MYZiENBVcZ9uXhTk887iX0qRodpk3LbHw4zFge5ELy
 mS0pw5+2TRW69PlGnANlbuqdeIaFtQSN7eorrhxW4U+6er8eCc4xxRlxBb6CLkCWHDydC+Wh8kk
 eF2yx0jxbIwHFATguVt1feF8=
X-Envelope-To: u-boot@lists.u-boot-project.org
Received: by smtp.migadu.com with ESMTPS id fd4a6bf3567c1017;
 Fri, 20 Nov 2026 16:18:32 +0000
X-Mizu-Trace-ID: fd4a6bf3567c1017
X-Migadu-Flow: FLOW_OUT
Date: Fri, 20 Nov 2026 16:18:30 +0000
From: Bradley Morgan <bradley.morgan@linux.dev>
To: Tom Rini <trini@konsulko.com>
CC: Josef Schlehofer <pepe.schlehofer@gmail.com>,
 u-boot@lists.u-boot-project.org, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 =?ISO-8859-1?Q?Marek_Beh=FAn?= <kabel@kernel.org>,
 =?ISO-8859-1?Q?Marek_Moj=EDk?= <marek.mojik@nic.cz>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Qiang Zhao <qiang.zhao@nxp.com>, Shengzhou Liu <Shengzhou.Liu@nxp.com>,
 Mario Six <mario.six@gdsys.cc>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heiko Schocher <hs@nabladev.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Simon Glass <sjg@chromium.org>, Bradley Morgan <brads@mainlining.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_04/14=5D_powerpc=3A_lib=3A_Add?=
 =?US-ASCII?Q?_64-bit_division_to_the_private_libgcc?=
In-Reply-To: <20261120161603.GE3176972@bill-the-cat>
References: <4B9B6E83-2EA9-4663-8A98-73BB63A713D0@linux.dev>
 <20261120090854.4425-1-pepe.schlehofer@gmail.com>
 <F019A142-D66C-4402-A174-AC9B1BF960CB@linux.dev>
 <20261120161603.GE3176972@bill-the-cat>
Message-ID: <E348D2F9-2DD1-43C7-BBE0-ADACE1504C46@linux.dev>
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
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 20 November 2026 16:16:03 GMT, Tom Rini <trini@konsulko.com> wrote:
>On Fri, Nov 20, 2026 at 04:04:10PM +0000, Bradley Morgan wrote:
>> On 20 November 2026 09:08:54 GMT, Josef Schlehofer
>> <pepe.schlehofer@gmail.com> wrote:
>> >Hi Bradley,
>> >
>> >On 19. 11. 26 19:55, Bradley Morgan wrote:
>> >> Well, Christophe has the concern, he can assess, also mind answering
>my
>> >> question about the user?
>> >
>> >Tom asked to update the common code, so v4 will convert the callers and
>> >drop this patch.
>> 
>> Oof.. (also please don't keep doing new threads, it's a pain)
>> 
>> >
>> >As for usec2ticks() in arch/powerpc/lib/time.c, a 64-bit implementation
>> >would divide by the constant 1000000. With a constant divisor, do_div()
>> >uses reciprocal multiplication, and lldiv() relies on the same
>> >implementation, as does usec_to_tick() in lib/time.c. GCC 14 at -Os
>> >compiles this without any call to a division helper.
>> >
>> >However, the overflow described in the comment is in the 32-bit tick
>> >count itself, not in an intermediate calculation. Fixing it would
>> >therefore require usec2ticks() to return 64-bit tick counts and
>> >wait_ticks() to accept them as well.
>> 
>> hmm. any way overflow could be stopped?
>
>The question is, is it an overflow we might ever encounter?

I had a quick peek, it's not something you'd just reach from booting and
praying.

But, my opinion is, it should be fixed in case. Just in case.

If it "can't" be fixed without a sacrifice, id just leave it.

>
>

--- Thanks!
