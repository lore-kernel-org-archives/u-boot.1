Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA84C531CB
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 08:17:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5E96A60758;
	Thu, 23 Jul 2026 08:17:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uNWIRIzKxNLS; Thu, 23 Jul 2026 08:17:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 78BC4606A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784794660;
	bh=UyuVra9IajfiQK+d9o6sHynP78xceLnHhbEpEFiDEbU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Zbg1ybjqilJnz3cAxQiRWzYAfle/tFV8ZtoOvLj3/usdjMg2pzhKNZgNaJdy9fI2w
	 cYw9fXoxDaYijDuv3MHSni4wWS7XeqrEFxeYqvC4hvZA7i7tmaacjGefebguTHg8n9
	 M3jwny8wOOUxY+hm7o/nB+PH5qERXx/ULyCFZCM34IR8Fcs08jLnzPjQBM71m5k2jg
	 yYf7u/rNrzsHXLyGKojB2K9jb2Ou9V8tEkO/ifQ1oZZ0+HH4xjDRD5B8eFXj/9thR8
	 B2rH/TaWvqEaVS9rWaHhA4Fi4mLfihVIBiAiCoVIgf9Dm8aOL4RjkJe/gHefP9SO4Z
	 XggQ4ZELEYXyw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 78BC4606A7;
	Thu, 23 Jul 2026 08:17:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B6C60EB;
 Thu, 23 Jul 2026 08:17:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A898F407B7;
 Thu, 23 Jul 2026 08:17:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DGGwRbkFbFhW; Thu, 23 Jul 2026 08:17:39 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=rv@rasmusvillemoes.dk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 50EF540744
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 50EF540744
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 50EF540744;
 Thu, 23 Jul 2026 08:17:37 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E49C8494B; Thu, 23 Jul 2026 10:17:35 +0200 (CEST)
Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch
 [79.135.106.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 052A2803F6;
 Thu, 23 Jul 2026 10:17:32 +0200 (CEST)
X-Pm-Submission-Id: 4h5PB12VBWz2ScQ6
From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: "Tom Rini" <trini@konsulko.com>
Cc: <u-boot@lists.denx.de>,  <u-boot-board-maintainers@lists.denx.de>,
 <u-boot-custodians@lists.denx.de>
Subject: Re: [ANN] Updating branching scheme to use "main"
In-Reply-To: <20260719182219.GX749385@bill-the-cat> (Tom Rini's message of
 "Sun, 19 Jul 2026 12:22:19 -0600")
References: <20260708161945.GU749385@bill-the-cat>
 <6Gj1Y6OOdIdgCJf5wjWfs05a4oMBaE4SbAq1kA4kDy9JfVvj0hy8nMNW8pmrEqonR_dM4pL5L1HaSINcbciAWA==@protonmail.internalid>
 <20260719182219.GX749385@bill-the-cat>
Date: Thu, 23 Jul 2026 10:17:28 +0200
Message-ID: <87qzkuqfvr.fsf@rasmusvillemoes.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rasmusvillemoes.dk; 
 s=protonmail; t=1784794650; x=1785053850;
 bh=UyuVra9IajfiQK+d9o6sHynP78xceLnHhbEpEFiDEbU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=nOWBcAUkcGwSAr0xMaUlkjwzLmRcb/nXUcbUywYIU3qaEAisGvbULjp7gdc3r31IH
 oELW3zSZXpewENAr40ATMsGgDN5RLgNHmWGUmyaiNbVEZdCvDIJmPN+tc+shmYFBgm
 l4QVNa65qGv5j6h2daTfVmhKS+zOqf9xcb65O68zdbzY/P9PrrYTb28HPLsUgiJ8/N
 h2SsYACGp9BlaT45ZKc5oQXvyLqoOU4VZLkVitjTE7RSYoQnAyLZ8eHFe5BsigH773
 Nm9ZxYDVMckS57akgNrMv7KSCbkTIdueajO5k6QFUMmF+xprS2rtn0ORtyt0CKmzB3
 BtdTd6DyNE/mA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=rasmusvillemoes.dk
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk
 header.a=rsa-sha256 header.s=protonmail header.b=nOWBcAUk
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=rasmusvillemoes.dk
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=rv@rasmusvillemoes.dk
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk
 header.b="nOWBcAUk"; 
 dkim-atps=neutral
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Sun, Jul 19 2026, "Tom Rini" <trini@konsulko.com> wrote:

> On Wed, Jul 08, 2026 at 10:19:45AM -0600, Tom Rini wrote:
>
>> Hey all,
>> 
>> As part of migrating from source.denx.de and over to
>> git.u-boot-project.org, I think it's time to change the branching scheme
>> from master or next to main or next. Since we'll be changing the URLs, I
>> don't think we need to (and I'm not sure we can automatically) have a
>> period where both exist. Thanks!
>
> This is now in effect. The "main" branch on
> https://git.u-boot-project.org/u-boot/u-boot is up to date, and the
> "master" branch (per Marek's suggestion) is on v2026.07. The GitHub,
> Gitlab.com and also source.denx.de repositories match this.

Tip: If, like me, you are heavily relying on tab-completion, you will
now experience that

  git log up<TAB>m<TAB>

no longer tab-completes to upstream/master, nor, as it now should,
upstream/main, because both exist, so it only ends up showing
"upstream/ma".

You can easily configure git to ignore the "master" branch on the
upstream remote. First, delete the current remote-tracking branch:

  git branch --remote --delete upstream/master

Then in your repository's .git/config, make sure the remote.upstream
section is something like

[remote "upstream"]
	url = https://git.u-boot-project.org/u-boot/u-boot.git
	fetch = +refs/heads/*:refs/remotes/upstream/*
	fetch = ^refs/heads/master

i.e. add the negative refspec '^refs/heads/master'. Then "git remote
update", "git fetch upstream" and similar won't create that
remote-tracking branch again.

(Of course, replace "upstream" by "origin" or whatever your remote name
is for the upstream repository.)

Rasmus
