Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC19C88E75
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 19:25:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 684AC808BD;
	Tue, 15 Sep 2026 19:25:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dA9bV48uF4PQ; Tue, 15 Sep 2026 19:25:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 82399808AE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789500302;
	b=A9oTZQxC/CFXsebQVxGN1203K+OiZp4/caeWJD0kPKVzhItwxLq7tpg5M7LsSQ3J4t3H
	 BWLFmm5tDUDpxRqFG2+0I32nOL9cYrNb4GUiOQW4tLbhuTmjqfBWOhSu7OG2hQjPwVknu
	 seHkEjAVrSxZMf5/05RqqemV7aF3fRs/iL+nSzGK8uo8XWm5RleVmPTDsjStuF0776wwM
	 yCcu7Dfd11iW6PiQwlqxXEWxPHcxQXZuFcL77VR/ycuwvF+Fke49Y5gkdJwGCHG2kYyN6
	 RkdE6yMYXtef481VfjwyNQSgp2RP2nyNdaNKndms3huKpmgl4enJJFxVfZmE0+uxkGg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789500302;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bS674kiDlYJkI2I+IcdMnygRUXSfcO7pFs3jmD1yVFw=;
	b=e8EBpB2eO9xUbNWcbg17WkW3PrFt0zuTMU8705j3LyThfCPUflVsdXBoaCz4xK66gVjV
	 4/zStJPNo2mOrS1VyguqXYQUanDAZ75330PxIRD4hxd1kpN3ytqQ51E3uv/cyeD64Gc5R
	 xdiGcPovEoWnoZKzemP5W/rGkQaA+B16G9gtkLRPh21LC1tZoeatbfHtgcUYVaePkCnPN
	 JqtSxxUP+84q4PFD7M0mDjGgPqwMR2IM+/E2Q9DIQcSF+9Nnko66V2dkgD0+S8hDDMQ1l
	 xt0gfKTwdwxPuSpYZxwVzNWjgVGP1A3DcEWE3yoI2AOh4fn7OJfgFd6ojZ/Mk7hYjkQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=pb1rt8Dr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789500302;
	bh=bS674kiDlYJkI2I+IcdMnygRUXSfcO7pFs3jmD1yVFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DIr2CLydbi32HSqcXKtDJW18BWswPhNbfOPdRirQ6J0Rn5rNHZs/WgqQE+4BkdrRl
	 wA32pv4/CafGUC1byi3m4pfpiBEssuxlof4YUDoSmKy6lSngyTVpXj39NwkKb4cRjz
	 Fc1OAIi4pm+Ka3fXuO8VuTS488TSbk4qwNIYZv20iPZwm4yH29viuyUQ52HeTib2qj
	 7rd0CMlzmjB0UmA6KeUqmi4JGkBc9/VrCmMiiHM6bg+UA2dzBd0BM9lvXF3yNF7Bfz
	 h3yV45QvFWw1pMIbEYshv3UGtyyiHIwY1zP5rkhk8sUx16L2Or+lWWwwybqgVFWf08
	 mfsB1FNDpPZjQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 82399808AE;
	Tue, 15 Sep 2026 19:25:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3D654352
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 19:25:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2209D808AE
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 19:25:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4XTP4vf3U_dz for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 19:25:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5E370808AD
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789500300;
 b=iqbLNtZWmq5dGOOCEAeF4RwufQRk3MSnzHKqG9dY9fWEJK04WH1vj+DI7+KT0jxd+RDf
 romk6zZmZGbNxyCj7rAuYYbmoWjF0+OHJG4bdLYzvfqWqGNlZqgfU6O0lu+GSdq0vUkun
 nvGnrt8GhUvH/HOCAkwOt9QmZ5UYnEtmsj1xT3P/qTKyXWzJDbRAjYLSfvTTed8VPpjyU
 dI3JZbOlPlmY3i+IZpl1qdTxgOHCuP0J4hou5+zcfefIlWi0p8j+J1UMCzPFdttLszkFR
 mfCCiklSrTCGh4WVEzRVcksynrEZZrC4Hq6HAqU+IoiE1ig1t2WAES9QgI2OuTpemHg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789500300;
 h=Received-SPF:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=bS674kiDlYJkI2I+IcdMnygRUXSfcO7pFs3jmD1yVFw=;
 b=oJ27/X8obAKOXdlq7NgEmiNxt7HnR0s++ykqzpdgecL83Jr/xQ0/OT6gS4gqVxdJmtFe
 cJsPKxg/pZqdOIUxKUUyoucfeP12rJUHHUeQ8loTcimZvuDzDdZgYQfJdHHsUNBrpmlGI
 yE+90lDRl39u/v62eTa8N+NwzHWY+fnd6UsZwQv6zvoxFzNL0Lu5nsTZX8LIG/WP1p54M
 CG/b5ew51s1bdS4siG0v/GGi3+ZuGHwOgiLDU3CWi5lZWxwSYj+vVKgrO/+Dady5QeDnF
 SIyoMpYZ+HtPCoDcPKoXUwroDENEKo0MO1ojxBUqHGdjpuR0eKDW/6ck6VU8GJLSMNA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=linux.microsoft.com; 
 dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=pb1rt8Dr; 
 arc=none smtp.remote-ip=13.77.154.182
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=13.77.154.182;
 helo=linux.microsoft.com; envelope-from=sriramsriram@linux.microsoft.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=linux.microsoft.com
 header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default
 header.b=pb1rt8Dr
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5E370808AD
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 19:25:00 +0000 (UTC)
Received: by linux.microsoft.com (Postfix, from userid 1251)
 id 8230620B7169; Tue, 15 Sep 2026 12:24:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8230620B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1789500254;
 bh=bS674kiDlYJkI2I+IcdMnygRUXSfcO7pFs3jmD1yVFw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pb1rt8Dr1FkrjK8crb3KOwqLKSJK86vlpRBUJ1FMQZnKGEW23LezdNAzq9joFlgkg
 4mLpyFep13fnJIQLK92pE8Qq+P5yEiGR8WSHP2rA8pKsH/TdmR6gzk+nEz++ccyPlC
 Ua6wslMqS+iQeC5nsj3WBg7OT/6HADp2vSaaStL0=
Date: Tue, 15 Sep 2026 12:24:14 -0700
From: Sriram Sriram <sriramsriram@linux.microsoft.com>
To: Michal Simek <monstr@monstr.eu>;, maarten.brock@sttls.nl;
Cc: u-boot@lists.u-boot-project.org;, trini@konsulko.com;,
 ankluemk@microsoft.com;
Subject: Re: [PATCH 1/2] board: xilinx: Use strlcat() in board_name_decode()
Message-ID: <aqmbXo4nLvq+EGOO@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260909192047.217421-1-sriramsriram@linux.microsoft.com>
 <20260909192047.217421-2-sriramsriram@linux.microsoft.com>
 <2ec7a375-ef8c-4ecb-ad1b-cfbf3ce12b96@amd.com>
 <GV2PR05MB1194135296D564695A241EA6183BF2@GV2PR05MB11941.eurprd05.prod.outlook.com>
 <905a8de9-8c62-437a-ba4b-0c8b4ef8fe00@monstr.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <905a8de9-8c62-437a-ba4b-0c8b4ef8fe00@monstr.eu>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Thu, Sep 10, 2026 at 11:43:32AM +0200, Michal Simek wrote:
> 
> 
> On 9/10/26 11:30, Maarten Brock wrote:
> > Hello Michal,
> > 
> > > -----Original Message-----
> > > From: Michal Simek <michal.simek@amd.com>
> > > Sent: Thursday 10 September 2026 9:59
> > > 
> > > On 9/10/26 09:56, Maarten Brock wrote:
> > > > Hello Sriram and Drew,
> > > > 
> > > > It seems to me that the limit of 50 for MAX_NAME_LENGTH is pretty arbitrary.
> > > > If you expect it to easily overflow, why not make that larger as well?
> > > 
> > > do you have a case where your board, carrier cards will require more then 50
> > > chars? This has been designed for Kria SOM where you have name in board eeprom
> > > and carrier card eeprom and it is never over 50 chars.
> > 
> > No, I do not. I was just following the logic in the patch comments.
> > 
> > > -----Original Message-----
> > > From: Michal Simek <michal.simek@amd.com>
> > > Sent: Thursday 10 September 2026 10:04
> > > 
> > > On 9/9/26 21:20, Sriram Sriram wrote:
> > > > From: Drew Kluemke <ankluemk@microsoft.com>
> > > > 
> > > > board_name_decode() assembles the board name into a calloc'd buffer of
> > > > MAX_NAME_LENGTH (50) bytes using strcat(). It appends CONFIG_SYS_BOARD
> > > > and then, for every detected EEPROM descriptor, "-", desc->name (up to
> > > > 16 characters), "-rev" and desc->revision (up to 8 characters).
> > > > 
> > > > The length check runs only after the loop, so it cannot prevent the
> > > > overflow it documents. Each descriptor contributes up to 29 characters,
> > > > so a base board plus a carrier card already exceeds the buffer, and the
> > > > data being concatenated comes from the EEPROM.
> > 
> > To me this indicates it is very easy to overflow the buffer.
> > 
> > I have not followed where the result of board_name_decode() goes
> > and whether 50 is a logical bound there. But since it is locally defined
> > without any comments it seems an arbitrary choice.
> > 
> > And if both these assumptions are true (expect overflow and arbitrary bound)
> > then it is probably a good idea to use a larger bound.
> 
> It is used for DTB reselection to described current board setup.
> If you look at arch/arm/dts/zynqmp-binman-*
> the maximum amount of chars used is 37. There is still 13 chars left.
> 
> Code is prepared for covering board, carrier cards but also extension cards
> like FMCs by simply pointing via nvmem alias to whatever EEPROM in the
> system. I am not saying we would need more space but as of today I am not
> aware about any usecase which requires more. In any case if something hit
> that limit panic is thrown and we can extend it but extending it just in
> case make little sense to me.
> 
> Thanks,
> Michal
> 
> 

> I actually got a path (c&p below) for the same issue some days ago
> internally and also reviewed it already. But unfortunately it wasn't
> sent out yet. The difference is that it is checking len at the end of
> every loop to get out of it earlier.

Please drop my 1/2 and take Pranav's instead.  It is the same fix with
better failure behaviour -- detecting truncation inside the loop and
panicking there is more useful than my version, which truncated
silently and only caught the boundary case afterwards -- and it carries
the Fixes: tag mine was missing.

I did check it against U-Boot's strlcat(), which returns
min(strlen(dest), size) + strlen(src), and the per-iteration check
holds up: once the buffer is full, every later strlcat() in the same
iteration returns 49 + strlen(src) >= 50, and every append site has a
non-empty src (the "-" is unconditional), so the truncation indication
cannot be lost before the check is reached.  A name of exactly 49
characters still passes, as it does today.  Happy to give it a
Reviewed-by once it hits the list.

On the MAX_NAME_LENGTH question:

> It seems to me that the limit of 50 for MAX_NAME_LENGTH is pretty
> arbitrary. If you expect it to easily overflow, why not make that
> larger as well?

That is my commit message overselling it, sorry.  "Each descriptor
contributes up to 29 characters" is the theoretical maximum of the
EEPROM fields (name[16] + revision[8] + "-" + "-rev"), not what real
hardware puts there -- as Michal says, the binman configurations top
out at 37.  The case that actually reaches the limit is an EEPROM whose
fields are filled to their declared width, which is a corrupt or
hostile EEPROM rather than a board that legitimately needs more room.
Panicking on that is the right answer; growing the buffer would only
move the threshold.  I have no case that needs more than 50.

One thing neither patch touches, which I am happy to send separately if
you want it:

	board_local_name = calloc(1, MAX_NAME_LENGTH);
	if (!board_info)
		return NULL;

The calloc() result is never checked -- the test is on board_info -- so
an allocation failure leaves a NULL destination for the first
strcat()/strlcat().  And that early return leaks board_local_name,
where every other exit goes through the error: label and frees it.
Both look like the same typo.

Thanks,
Sriram
