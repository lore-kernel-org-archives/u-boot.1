Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135F3606A32D
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 12:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aTpOsg9S;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=IweiFakR
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AC96D406D1;
	Tue, 27 Oct 2026 12:59:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o-X9-frL6ucl; Tue, 27 Oct 2026 12:59:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9B804406C4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793105965;
	b=Ytl2HLYo6XGddESjhMjgXk6Ap6UNxY6s+sjIBD/lH7hSaNPQX2Y8x7q0uEhq1yZ3GCpd
	 T6OFSg6QuuIM6/AEGIIX5FXQTkwPTVG+o+zyFRI+voVNjyTTgSoRjngsR8SlL9mD8kvTg
	 3ppHTWdFpEvGghLegiV5424MgdQfpt3pMMKEbqnTQB2M0kXmVQ75FFJ4LtpSRpXriKUTT
	 MMEe1gcv+s+SFZKKcjaMcbXXw1/a/qF6Jgoyjz89dy4Ghdce+9uO7TGNZUPeYvf5e8BO8
	 XnH9HvLvM4y5Hk28JftZdz/WWWL49zFc1qk3RNJJq6cMAlST0g0jOyb6b1nVqU6GhSg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793105965;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Content-Language:To:Cc:From:Subject:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DhHRL9ehPIWT06NKnfmJhf9v0QW7tIpMJwpr8tZuiOg=;
	b=E5sBUJJ4iRZnCrY/5vNsFhSqeSCJagUAYnaBQxKn0YGlKCu0nJvhrTZCxTxhYOGqEW+P
	 viUBsPRuGE0/bmuc+/2GVIfhtEDKg88S9pmIHvvw+sJCNCyPWqdIHKp2ZzCTuhxx75zN+
	 HeGXLSTm4sPqTnvPHVkDP6YeP1L6GBKGLryyr9Lsd2ZkA2I4kx4X1ioz4Hzfbgtk8SYxa
	 FWUNldgJjhtPmaErsKBnLQTngWcliiH5l11kAmfHFgLX5X4OxqPovyCqsJp2OZu6KxCHs
	 Cl1qM4N23LHVkCb7H1U/17oH7s1JymxVUlnH8ZqUjXfG4URkz98Zqp5f5MCBgnaFXPQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793105965;
	bh=DhHRL9ehPIWT06NKnfmJhf9v0QW7tIpMJwpr8tZuiOg=;
	h=Date:To:Cc:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=aTpOsg9S9t5rn9qPudonaRswMZURfaMgSKMzbzipo8j1+H/QRgN743z5BCmwm9ZO4
	 rAeZISXYeENkfnwRTjqE6DKgSj0NvAUfOZGZGlElcQyt4gB9jtkZt/5Za7ZsJCuB0x
	 Rk7OgUfHm4DAqy+HHfqskXKFWclWHv1BbSpCLbfmCtGoxCJoffY8UGQOlv2mMA18v4
	 e5vx0W+QtWnOgi2pLxAllUw7IyzwIOMn5tSa6YvatJcVDk/VSZN59BaiwbI3joPCfu
	 GtaSlnLuGE5jiR8HAdn48qYmUaF6Esa7kdbHMDiM9b+vBx0w8dk/97lUefqfpTTGTZ
	 +ReUsI/7CDfGQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9B804406C4;
	Tue, 27 Oct 2026 12:59:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B3A543D9
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:59:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 997DF40261
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:59:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m5ZUTznbvP1S for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 12:59:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org AEB2E4007E
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793105963;
 b=EgajMPWfqNWKVX+2fFgZyQ7El95n/ErsMldrcxF+4E3fXs3QXx6YaXV+xiZmLQF6wkdv
 e/YyoHzoN2tdhLLZhrbXA+wLHmGRsAu26tf1lksgp5kuMgcmbAAHfXGXhBVeir0OUrCNu
 UgH73XHlkpFa38eyp8t2rCIGWG/3ARvCL9ypankZJZRC8hR1spT+e0jJkWd+933BFayjn
 X7EFQDD7gSc1C8CMX4eEyyQX7jFhPUrpycqabKW35xcjp3sXSMnLGZXDpVKeCpDvdWEEh
 CZ44IR1pTSkmER8F82wIH0bPoN7uyAeD8GyR+2IUEJxU3Xp1Mwf+eWVUTDF6DdK6McQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793105963;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Content-Language:To:Cc:From:Subject:Content-Type:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=DhHRL9ehPIWT06NKnfmJhf9v0QW7tIpMJwpr8tZuiOg=;
 b=X5ctr/+ic16mLXmH/ZNo+9mK6LDlayEDZ03t6oueh0cx8OjboGSXw8FES1iawAbPQyly
 0/4aaM9PecHpWyHk3Hv672vjUuV/YZ/InlJCXGW6C1fCl3rObKlRBffQk6fMKnRgu+6hh
 E62/9RVduvpMw1oIKolQ7CNbXdJuVqJpfIhAUdp1SDwdhj+en6PzsgdDd+k4k6cGiUTK4
 ECRiSJTafjgVgzWXYhRVdEsWB6sBGlJqWI4fuGgXh4OZuMsxg4cKZAVfTtA1rWXVBxnQ3
 iObnI6MjUqmtkiAzDjLbOax2LFRRz1oZhLP1JRg5yyqEvISOhJXl3dA3aBIqigwoxnQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=IweiFakR; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com
 header.a=rsa-sha256 header.s=dkim header.b=IweiFakR
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AEB2E4007E
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:59:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D92FA106B60; Tue, 27 Oct 2026 13:59:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1793105956;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language;
 bh=DhHRL9ehPIWT06NKnfmJhf9v0QW7tIpMJwpr8tZuiOg=;
 b=IweiFakR7RhGAxceP90jRlLnaY4iKiZIyVsESM8Qy0aJ/PFb6TWZf1XSJvJaxYXzTWNbDs
 KGv4Z/4NozJHvHJweFF79EzgnZvvsRtD41A82CINv0a7+o9ck5vgT0A1NIGhAWQ8qJ4RtN
 MlxRJd2k4yjkHOgxFoTSKzqq33SjCFnP/gIppmE8CLWo463WbyE8zznUFgEvqUqjS7swlB
 jFncf22BYD/0ILzIeRX+/QRiuar6Hwik+IOZKGThY2Y4z58DL8/mBTA2AtrJSxEDdmcMuY
 OLeCMWFfAiMPsheTCXJWlMg62vgm88k3irL8Gs8Ae9Q9/Pk+8IAzqyGMulMy0Q==
Message-ID: <d7da7b0b-8420-ac6f-1f92-5c643563d045@nabladev.com>
Date: Tue, 27 Oct 2026 13:58:27 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Altair Bueno Calvente <abueno@airzonecontrol.com>,
 Alexey Charkov <alchark@flipper.net>
From: Heiko Schocher <hs@nabladev.com>
Subject: Please pull u-boot-ubi
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Tom,

please pull from:

The following changes since commit dfcfc4c9f78d1743f490a497082a4ec8e058aae8:

   Prepare v2027.01-rc1 (2026-10-26 18:21:37 -0600)

are available in the Git repository at:

   https://git.u-boot-project.org/u-boot/custodians/hs/u-boot-ubi.git tags/ubi-updates-for-2027.01-rc2

for you to fetch changes up to ede4c80c159acfd6038255c88922993fbde16d93:

   fs: ubifs: resolve "." path components (2026-10-27 09:02:52 +0100)

----------------------------------------------------------------
ubi updates for 2027.01-rc2

- ubi: part: Claim only the block device UBI created from Alexey
   Fixes: aa5b67ce2262 ("disk: support UBI partitions")

- fs: ubifs: resolve "." path components from Altair

----------------------------------------------------------------
Alexey Charkov (1):
       ubi: part: Claim only the block device UBI created

Altair Bueno (1):
       fs: ubifs: resolve "." path components

  drivers/mtd/ubi/part.c |  9 +++++++++
  fs/ubifs/ubifs.c       | 10 ++++++++++
  2 files changed, 19 insertions(+)

To merge into your 'master' branch.

Azure build is fine:

https://dev.azure.com/hs0298/hs/_build/results?buildId=221&view=results

Thanks!

bye,
Heiko

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
