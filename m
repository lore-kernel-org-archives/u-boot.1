Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBECAC55162
	for <u-boot@archiver.kernel.org>; Sun,  2 Aug 2026 13:27:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 72ABF606BA;
	Sun,  2 Aug 2026 13:27:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tS1Y-aQdDO3C; Sun,  2 Aug 2026 13:27:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 047106069F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785677264;
	bh=27Hqh9pSe6g+BkOrA5bW26HUM81rD7YQUcGlxtqZ7JQ=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O2B1MiIg4icV5FOEaESYtkUsn10H7dZeSJyWhY8cWYfXKMEZBGlyfFOM4FDdXVgM+
	 GpW+sekKhiT0RBZKZLCLLOHL4nRimMpEkcRvjcVdjFz3MnazMJR/qSpQvT49SNtYYG
	 lvK4Ji0egb8NrJDKNFZEtPXxpj5YqfLlWdmWJSPEJ56ulFSeJ8N09H67W1mFL2mbnw
	 RHlChLSa8wN09P6oFJEHm1ntM00/+s2b870JiUvMRTLyA8gbXxWsVg5ftV/MSFGVXT
	 0Y5sJw7+kwSUaoypnUuPFKpfJD67WEo2uqtMycC7Ju2A9XbyEp+JCZsahbqEqmyee1
	 5nB6JxsYPT6iA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 047106069F;
	Sun,  2 Aug 2026 13:27:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D412136E
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 07:37:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BA18C60672
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 07:37:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 32DbY5iyXxOM for <u-boot@lists.u-boot-project.org>;
 Sun,  2 Aug 2026 07:37:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=munzzyy1@proton.me; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 3EF216065E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3EF216065E
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3EF216065E
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 07:37:54 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCE7E844F6; Sun,  2 Aug 2026 09:37:51 +0200 (CEST)
Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch
 [109.224.244.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B405A80117
 for <u-boot@lists.denx.de>; Sun,  2 Aug 2026 09:37:49 +0200 (CEST)
Date: Sun, 02 Aug 2026 07:37:43 +0000
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Alexey Charkov <alchark@flipper.net>
From: Cole Munz <Munzzyy1@proton.me>
Cc: u-boot@lists.denx.de, Marek Behun <kabel@kernel.org>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] fs: btrfs: report file sizes from readdir
Message-ID: <hTFbDtB7gXE4tGU0EwriHsWY9lutwDK1ehYABepLafBuF5IDEY1rjTUVvCFq0HOsdgpfpFHvayOonotnzsuHWxs-FnRFFsnKUKmvGSkQAHI=@proton.me>
In-Reply-To: <7bcd492f-7e1e-4fd9-970d-857ca5460ddd@gmx.com>
References: <c8e57b678bee2394655ea5e7b0678fb300705e2f.1785649258.git.Munzzyy1@proton.me>
 <CAKTNdwGCYjr+2vaBc6kArQokqTF=Gc23mF17B_22Fdcg1O=7hQ@mail.gmail.com>
 <7bcd492f-7e1e-4fd9-970d-857ca5460ddd@gmx.com>
Feedback-ID: 209578162:user:proton
X-Pm-Message-ID: b3ed00efe0c5d1a0664f85c4a95bacde0a03e368
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Sun, 02 Aug 2026 13:27:38 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=proton.me; 
 s=protonmail; t=1785656268; x=1785915468;
 bh=27Hqh9pSe6g+BkOrA5bW26HUM81rD7YQUcGlxtqZ7JQ=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=elDQs3fF+6LUNZ1VA6RqtlHavxjf3SkMBmlEFrRA4iu2vU9aNpNNhq0v1ddo7gBtf
 wnRosQ0L/CM61elIT/h+lb+tv9zm4fYDGt1Pc6nl92Ogz4cj6rirtEBIIqCTwkhrK2
 1JmPyD7EgBWqdgNb4AMtyy68VmHplw1J4un4hBXZOZdL1Nd4oujrbY9j5spyAGVjCR
 qzVvah2z90l302do8DuhJIRScBzAdbnVVRfGJku5Ywra/GDiFzi6dlU4KSu58yng2U
 w/9nHKFQlsWVAlDfuRETIsHL4VCZwfX57g1/qvEeVzxUsg4jBfFpkCNjbbidh74Kgf
 pqJ2B0jQ4qijw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 spf=fail smtp.mailfrom=proton.me
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=protonmail header.b=elDQs3fF
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Munzzyy1@proton.me
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=proton.me header.i=@proton.me header.b="elDQs3fF"; 
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

On 2026/8/2 16:17, Qu Wenruo wrote:
> The function btrfs_read_next_dirty_entry() is search the key inside the
> parent directory.
>
> Meanwhile this one is search for the inode item of the child entry.
>
> They are completely different and I didn't see why "refactor" can improve=
.

Right, the two searches are for different keys and cannot be merged.
The repetition v2 removes is elsewhere. btrfs_size() open codes the
same inode item search, and its error path never releases the path.
That leaks the extent buffers btrfs_search_slot() attached before
failing. So v2 mixed a cleanup into a fix, which was the real
mistake here.

How about a v3 with the fix back in the v1 shape, plus a second patch
for the btrfs_size() helper and the missing release?

