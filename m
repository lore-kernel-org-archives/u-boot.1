Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825D1606A324
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 18:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wSrC8n+e;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CADIGGRb
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0FB3C814AB;
	Thu, 19 Nov 2026 18:55:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8FnNR_UavJH5; Thu, 19 Nov 2026 18:55:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 657D7813C6
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795114556;
	b=LkW+5dH4jrBBQO+HtMcxIQiZtTnD+6XbgU67WrUeBQ5j2UV26fO6+onOJoMyxW/mMNkM
	 1IS03Dk3lQkiGaClfBJ/sY96cha14lLE4EMCX9FfhwZYGCTdVYiWBDrmSYeQsg+TtOUcI
	 +JYOaJJtmUUnewSjm9aV+mBJgIGQE0Hs3Tv6hRlE6mxAv4lf53d3Bkld24eDR9U8jIrng
	 KM85Gn98wdcqd3DKnhxsRKpXMdKdblMijgzvzmkbTMeP//1XGgBLD8GVsyupk0Z0Bj+hh
	 pUOfz27vwq0wvO6NgPcGtDDFi/k3TtisgTXzRsHtlEtHRZUQa6cgcvzzcrSYLpPCAWQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795114556;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:X-Envelope-To:
	 DKIM-Signature:X-Envelope-To:Received:X-Mizu-Trace-ID:X-Migadu-Flow:
	 Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=UJB7DfprgK946I0C7CWd7WjaXhyTGsQBiMFi4nKY8KI=;
	b=VpmQXwdR+7CQna0klju0n8oA1VwneKzLXm6ya/SncTJP9RYUSpe7EbwJ87l55RKxD860
	 eBcLM/JGCoR3Je5AGqPjJC0ZwYUlV8qb1ZyOPBZB8hYbRDqxZ5dsxbHEVGFNMZI+IGBAy
	 FwszYBHsSQG784BpU6WYzamy11FuAbvt9INUsdB0crjXO4VnBlTpOFczcIC1WSG1+MLIl
	 6wO8B/udrJ8/l5ksXPJpo7UX2WzS+BayoCgH9pumRg2nSEs57wO2GN6YNRLUpm3yGxb1/
	 7/pgLu+sE0IPE+lPPBMrxY1qvibWqEu+/VxtzPldWPsKm1ndF9dByUV6gdmkrsw0/kg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CADIGGRb;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795114556;
	bh=UJB7DfprgK946I0C7CWd7WjaXhyTGsQBiMFi4nKY8KI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wSrC8n+eDp5qi2kMIK05llGKP/2QYZIUC0X9xrMfEsy68aAZN9IhCwV8to6KNUptS
	 tCzXyGhl86cHzWrLNBWfKjOydd3sXL/Y8OonbQ53+fBHwuzno2NYiSDHIUz6iU3gDq
	 bKXVtZbt+AZRStSixQuSNWxn1NsmwgMwvF8qL76cMV/xb7DPL9fDEi7XeEes//hTpa
	 ZFNH6mtu7nZB5oK7DOd3jtOTM4Bo2Ro32IjaT69yplgs/69Y+jMxuJ9mRcjJAhNPNV
	 DR8EODI1RPeqaTacD6mQuTirJIHQEFJgWgVcJbBHN1WSHJDchL+6D2cBsez9oeVO3m
	 JZBMDRthP3x8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 657D7813C6;
	Thu, 19 Nov 2026 18:55:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 715F13A8
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 18:55:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 56ED8813C6
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 18:55:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zhTK9gb4nxsd for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 18:55:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3073E81311
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=95.215.58.105
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=95.215.58.105;
 helo=mta1.migadu.com; envelope-from=bradley.morgan@linux.dev;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=CADIGGRb
Received: from mta1.migadu.com (out-105.mta1.migadu.com [95.215.58.105])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3073E81311
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 18:55:51 +0000 (UTC)
X-Envelope-To: u-boot@lists.u-boot-project.org
DKIM-Signature: a=rsa-sha256; bh=UJB7DfprgK946I0C7CWd7WjaXhyTGsQBiMFi4nKY8KI=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795114549; v=1; x=1795719349;
 b=CADIGGRbxUNf6AJttoj1U9EFmaOY8jOc9vbFwl9K2DQSBurvBJE9UvgIMwwtntgv/RkaGSfw
 eQTkoTDKsIROV/9Dt1bNUizum+zZ3MDAhivugb/Agqy8m1rTiOkHSYMAZArpTD6huRxeMK7J3Jp
 ssLsg5uOlhROE/1DSs2f27ic=
X-Envelope-To: u-boot@lists.u-boot-project.org
Received: by smtp.migadu.com with ESMTPS id f3f8a2ce26babf0c;
 Thu, 19 Nov 2026 18:55:49 +0000
X-Mizu-Trace-ID: f3f8a2ce26babf0c
X-Migadu-Flow: FLOW_OUT
Date: Thu, 19 Nov 2026 18:55:48 +0000
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
In-Reply-To: <20261119184244.68936-1-pepe.schlehofer@gmail.com>
References: <4EDA2004-7420-4BE7-BDD2-B71240E69107@linux.dev>
 <20261119184244.68936-1-pepe.schlehofer@gmail.com>
Message-ID: <4B9B6E83-2EA9-4663-8A98-73BB63A713D0@linux.dev>
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

On 19 November 2026 18:42:44 GMT, Josef Schlehofer
<pepe.schlehofer@gmail.com> wrote:
>Hi Christophe, Bradley,
>
>On 19. 11. 26 17:01, Bradley Morgan wrote:
>> On 19 November 2026 14:21:14 GMT, "Christophe Leroy (CS GROUP)"
>> <chleroy@kernel.org> wrote:
>>> Why do we need __udivdi3() at all ? Can't we just avoid / and % on
>>> 64-bit operands and use __div64_32() or equivalent instead ?
>>
>> Oh yes. That's right. What's the point OF using __udivdi3()..
>
>The division operations originate in common code, for example in btrfs,
>squashfs, and mmc_berase() in turris_1x_sdcard. All the instances I
>found use 32-bit divisors, so do_div() should work for them.

Listening...

>
>I can drop this patch and convert those divisions in v4 instead, if you
>both prefer. The downside is that another such division added to common
>code would break the mpc85xx LTO builds again, because patch 5 replaces
>the toolchain-provided libgcc for those builds.

Well, Christophe has the concern, he can assess, also mind answering my
question about the user?

>
>Josef
>

--- Thanks!
