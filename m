Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39ED4606A330
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 16:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YrKyan+n;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GpG2rRND
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B8D9A60B8C;
	Fri, 20 Nov 2026 16:04:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CgyrD2h2KAMq; Fri, 20 Nov 2026 16:04:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 95BDE605F7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795190657;
	b=CcTF2acsRoj7hNV3qmIi6NW9NOuxPmUWi0E32sqaa4ZXT7Cn5jAeTAKfwwfjBmGrBW/9
	 30VjlkU1i0sb9YGLejdy2CTR4HZxbCLBXp1HiIvp16n55ybewoAZMGGGinOUAQKxcFWv3
	 UvnKu6F4DMSFLAd5Tdk3XOciU+pkulKT+/VEvkKYEhZ6QAij1n8ZwlK3erIVXrHQbzEyC
	 aGi1sDBGPYT+FbX+DGHpbgyegEaDvAZXZoLK7f2Z/0aAaAWXu1EBvRVeinW95rZHkIW4F
	 ASxxcC3wUDCPEQeZ/cW+052znBleWdnRylr+y/KJ9pFhrk6rse+Ay0OyA4qD7GLJ6qQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795190657;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:X-Envelope-To:
	 DKIM-Signature:X-Envelope-To:Received:X-Mizu-Trace-ID:X-Migadu-Flow:
	 Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=aCSQhZH4V6A1sue/YMW4/16YCVt18JX19UzsFck8nhs=;
	b=b+AULszw+QW2sA6HOyefNaEOxzqeP/aYbCxbha5f3B6OcYJq0qQMAIKULKBnoj9iM0xX
	 cURxi6hOunZCm28tYp4hGYsGf3Y6gGly9tOeqJyFmbmzHEpgFXV4/HTtNiPHFvbgklEpV
	 IpwZwcJbpwuLqSsVdfZwFiSkxnYp3BzJoEAXQKXeM285ChZ2+vUPoZY6dGfIYlGcYkeBr
	 MWcITaErZx2y3MTCy03gYLx1MWlTC8q+wnb2alFahxAGmcYUvu4pFX5S1uzsG4/619LKH
	 DnlrxpNFwEuneCVmIJSCPK/unLJM/O8e95EcMNu4W1CKxuHhcnY4K6C/7QfPZdh3Dow==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795190657;
	bh=aCSQhZH4V6A1sue/YMW4/16YCVt18JX19UzsFck8nhs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YrKyan+n7d3lqmB0IZWeFSbgCjOHT/NMfT3sSFFT9IZlfkuq9FtYviAlq4iFJZI2F
	 1ABXEIUuLQi7kYPN7sq/byTPu/NePNbf+MrrJdwVMOmISYO2sJkgK1BJ7Mm7TBdu0m
	 mplloTYbLWpmDugWzetsUJs6wfgKXelSMd4/JGrMqWzR6Vt0KQblQi5QWNtJ2DfnGB
	 UyGPNvLHGKGJkEGZuZhhXtfVX1VAaclvmwZQLBr+d7dPzh2Kqpk8/WX1Wl2srwmOTE
	 AL6jHtI6AP1N7G2jcAdptmklqk6fayznaSDkFjv4ltx8Wp21Ifn51DPtR9apkyGqDt
	 K4PGIrG2B8vOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 95BDE605F7;
	Fri, 20 Nov 2026 16:04:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id AE87E15D
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 16:04:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A054940E44
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 16:04:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8dEhGIpybpy9 for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 16:04:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 386BE40E43
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=95.215.58.205
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=95.215.58.205;
 helo=mta1.migadu.com; envelope-from=bradley.morgan@linux.dev;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=GpG2rRND
Received: from mta1.migadu.com (out-205.mta1.migadu.com [95.215.58.205])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 386BE40E43
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 16:04:12 +0000 (UTC)
X-Envelope-To: u-boot@lists.u-boot-project.org
DKIM-Signature: a=rsa-sha256; bh=aCSQhZH4V6A1sue/YMW4/16YCVt18JX19UzsFck8nhs=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795190650; v=1; x=1795795450;
 b=GpG2rRNDlK7Z+3WGZPpscAvaM4BlQFKe8v3+CgAeh6HdTf5b7g/73YU+YlMKn9nbvveb8NoR
 i+3GUnz/dk9IwvsGFI+zYNWlNilOcAkeJGvTB3ySy90gP2yUD6HbKBGJgVq+Ps9o9EyFAwrhO+5
 /p/64+W18f59ZYJlAa1A8DIg=
X-Envelope-To: u-boot@lists.u-boot-project.org
Received: by smtp.migadu.com with ESMTPS id b6837903a4eae870;
 Fri, 20 Nov 2026 16:04:10 +0000
X-Mizu-Trace-ID: b6837903a4eae870
X-Migadu-Flow: FLOW_OUT
Date: Fri, 20 Nov 2026 16:04:10 +0000
From: Bradley Morgan <bradley.morgan@linux.dev>
To: Josef Schlehofer <pepe.schlehofer@gmail.com>
CC: u-boot@lists.u-boot-project.org,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Tom Rini <trini@konsulko.com>,
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
In-Reply-To: <20261120090854.4425-1-pepe.schlehofer@gmail.com>
References: <4B9B6E83-2EA9-4663-8A98-73BB63A713D0@linux.dev>
 <20261120090854.4425-1-pepe.schlehofer@gmail.com>
Message-ID: <F019A142-D66C-4402-A174-AC9B1BF960CB@linux.dev>
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
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 20 November 2026 09:08:54 GMT, Josef Schlehofer
<pepe.schlehofer@gmail.com> wrote:
>Hi Bradley,
>
>On 19. 11. 26 19:55, Bradley Morgan wrote:
>> Well, Christophe has the concern, he can assess, also mind answering my
>> question about the user?
>
>Tom asked to update the common code, so v4 will convert the callers and
>drop this patch.

Oof.. (also please don't keep doing new threads, it's a pain)

>
>As for usec2ticks() in arch/powerpc/lib/time.c, a 64-bit implementation
>would divide by the constant 1000000. With a constant divisor, do_div()
>uses reciprocal multiplication, and lldiv() relies on the same
>implementation, as does usec_to_tick() in lib/time.c. GCC 14 at -Os
>compiles this without any call to a division helper.
>
>However, the overflow described in the comment is in the 32-bit tick
>count itself, not in an intermediate calculation. Fixing it would
>therefore require usec2ticks() to return 64-bit tick counts and
>wait_ticks() to accept them as well.

hmm. any way overflow could be stopped?

>
>Josef
>

--- Thanks!
