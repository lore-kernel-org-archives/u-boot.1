Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DDC4C531F9
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 11:39:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B1842407DF;
	Fri, 24 Jul 2026 11:39:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WB0O-KZvgVZ5; Fri, 24 Jul 2026 11:39:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C5C94409A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784893189;
	bh=0zRRMuuhOiMKdVlXvkBG5H9+gCNze8050xemlTmM3cc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cQ5vLqgQL1cLkvADRS4830yKj0cWkx+Dd8WukVXfojESThqPLtHGD5G/GuPLAGS/v
	 BcYmR3lEhIu0y7D38ZoXE+LuqC0MRxYxJQgGdPw/+35DWVlNNToPSZ1XjGwCWWFK7i
	 X2DQ8783a7NQHneveZweXplrCHC2JgK/TbrDt1HG04H570B0aTwiFRCeUqoBU7+hqo
	 xDp1ByWLwCLMNc7RdPjA1tUl3LQSV30rMigfIij90QDJUncdk3tNU1qfM4MfGignPq
	 SFUvMD+GCDiaXHvDy9DSroahn0lyATcBkzNInuTupF1VpLiwA8RzT6A67FjEl9QiM4
	 7TIVmK0RJqjXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C5C94409A7;
	Fri, 24 Jul 2026 11:39:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9DD2DA47
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 11:39:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 84126608CB
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 11:39:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l2IERoWHp3z0 for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 11:39:47 +0000 (UTC)
X-Greylist: delayed 464 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 24 Jul 2026 11:39:46 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 0AF0160B0C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0AF0160B0C
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=95.215.58.182;
 helo=out-182.mta1.migadu.com; envelope-from=funderscore@postmarketos.org;
 receiver=<UNKNOWN> 
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com
 [95.215.58.182])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0AF0160B0C
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 11:39:46 +0000 (UTC)
Date: Fri, 24 Jul 2026 11:29:21 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Ferass El Hafidi <funderscore@postmarketos.org>
To: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ferass El Hafidi <funderscore@postmarketos.org>
Subject: Re: Mails to old mailing list rejected
References: <bd1ea941-a8c7-44f7-8d99-587e702c6163@cherry.de>
In-Reply-To: <bd1ea941-a8c7-44f7-8d99-587e702c6163@cherry.de>
Message-ID: <tiog0q.sgud5ojm2xxy@postmarketos.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
X-Migadu-Flow: FLOW_OUT
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=postmarketos.org; s=key1; t=1784892719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0zRRMuuhOiMKdVlXvkBG5H9+gCNze8050xemlTmM3cc=;
 b=kpG38sZ5dq7ChKPknSDIOTfauzpynEIfGmV1/pB4q1Q6D1QGqVzOahWAGFlSRvOGaj1UQw
 dwsTatx7LkRPv9f6+zn9V5RhkQ4SDbRcX6Q8BKCgXgAnAmxhyih2Ymkux3cX8NQRC2SekY
 yqGZcB+1DUiyNwMaEED1kmdFtSMFicfOie3ljurfqf7/bNgvKkIsKmcIQlGLW1WdW59ELL
 nCY4D0vsBt2z64k6F3n1xLgCuez/EyaR1NGock3ngWb48ELbESI9n3rUDkF3WT9Yg8sYko
 E0bBum7KS75goD+ZotP/HH7F1c9IVKcOrHjL2eACml3CXLske5pP1oBRzqBkZA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=postmarketos.org header.i=@postmarketos.org
 header.a=rsa-sha256 header.s=key1 header.b=kpG38sZ5
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

Hi,

On Fri, 24 Jul 2026 10:10, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>Hi,
>
>I (and at the very least also Ferass) am hitting an issue when sending 
>mail to the old u-boot@lists.denx.de. But only with my personal mail 
>address (@0leil.net).
>
>I think there's some redirection/forwarding in place from lists.denx.de 
>to lists.u-boot-project.org mailing lists and it does it incorrectly.
>
>Ferass nicely sent a paste 
>(https://ircb.dersco.re/uploads/funderscore/a9b0c0b1-f_-paste.txt) of 
>the mail he received. I essentially have the same content. I believe the 
>important part is:
>
>Message rejected due to: SPF fail - not authorized
>
>I weirdly don't have this issue with my pro mail address though, and I 
>don't see how it's different. This tool shows what the SPF entry is for 
>0leil.net, postmarketos.org and cherry.de:
>
>https://mxtoolbox.com/SuperTool.aspx?action=spf%3a0leil.net&run=toolpage#
>https://mxtoolbox.com/SuperTool.aspx?action=spf%3apostmarketos.org&run=toolpage#
>https://mxtoolbox.com/SuperTool.aspx?action=spf%3acherry.de&run=toolpage#
>

For what is worth, @postmarketos.org email is hosted by Migadu
(https://migadu.com/), so it is not self-hosted. Migadu also hosts
@linux.dev email.

If there's something not working right on their side I can probably pass
it around.

>What am I supposed to do to get this to work :) ?
>
>Cheers,
>Quentin

Best regards,
Ferass
