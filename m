Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F5C606A322
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 09:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Zrrcv9sT;
	dkim=pass (2048-bit key, unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=HeYskEj0
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DD07240763;
	Thu, 29 Oct 2026 09:42:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hjxoxSXl6nzn; Thu, 29 Oct 2026 09:42:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E356B40755
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793266969;
	b=LvVMw8YEGBZESczG5GK8YBXJae+iYzOPO6QHXfI5e7wXHPfBTBOiH9JX0MgYYNfFQ4yp
	 vD62B/bjQXMIR87GUASmYjur+n7AjbkSsobEqkj93cMF1QnDbVxUJoQBB7nrXnvoLh3cl
	 XRNriS8eDVdw53CdN/B5FrnUUih/A0H/g0HqR7CicWWTz6KqeFMlxxQ8b9EPZ6ijFA5U1
	 kZJRjwAyElOkxsNOpji/2MBmG0RiQv7AKnx8DJLzwi1UN6eJtAvUetvksj0LCoEx3kbv9
	 O98TPO6Qcil1i1aI74kyMZK/Kv/kNoSRLtGMPiVXb0uz9f44v7hIWqdep0FjXaZJYng==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793266969;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Infomaniak-Routing:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=UNIDVld/E4pswvXduzhl/EaIfhM0Umh4yotvuaqzwHE=;
	b=Kgvj7LT+LONhhWA3bU2qtyMwwJGeeE6BtFpZ8evBSGalzuJY1T+IpFOx5sVgr24Ovy5+
	 TchQbCIlmAXKixQvjFaAfERuTkhbPUfYg5bc+jcrof2agtDc6gX4DFMqKF51fwJUXyOHk
	 kTEh/Vp6B3cNbpPsZaQg7iSjWh6egSr71iPtGQ1IuFCHtWCTzq0OplcQCGSFjGxXKJvRR
	 icZ6JnjeFbRJ3vsRMaJPlZCRjVFFbZODNHHASIQHDowQBwVYR2XxsyDrv+WX2Ts42He65
	 nNSYthhgx613j4w4R4XItzoQsjrCf4DTPP7kCNMbskFqL+c55Mvw5+fLpZwesaH92nQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=0leil.net;
	dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=HeYskEj0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793266969;
	bh=UNIDVld/E4pswvXduzhl/EaIfhM0Umh4yotvuaqzwHE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Zrrcv9sTKhbiPUL4jk/+mVdg4IPS22qLJWKj4psVFFvcE8JERftcpbRxezW97Kbpu
	 Or1DrBTXswiP9eC88w+Nqfkuc6syLWLrM/TFkI7D8dOalXFJdFeWJO8LUgVPBnAEWw
	 GQJ440cwJOpBSNoX66fSym9j/aJNDiO0iaMWxIq4e3sGjBLG3l4+LNWlhiuZBIU0bS
	 fDnv2b/JMrDVtjaUdNpisdvvPvQWFSOxixJM/N8oyAY0Up4wtBZxnNrEZDoZenn4m6
	 fOgFOlEiBXOkcOJEFX467XYgQxIPNlyMXoZHfy3ldPAS45IzX3kxBsCgy5d2zLI3yX
	 LrWoItRi/Yo0w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E356B40755;
	Thu, 29 Oct 2026 09:42:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E83E5380
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 09:42:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CDB3340755
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 09:42:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yADLZwxhfLQ6 for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 09:42:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 74E9840638
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:7ff8::190e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793266965;
 b=sNW08x3PfWxPwY2CLDtryzfXWWP8ukLIcb/uxrAAduYgqGJWWLT+SDdf41/DuK+O/8ls
 5XvrRejZdI6E+vsd6edbc3yMatk/GpIUZH2YrLU2tCbFMaNghVyb6V8yCobNjYMO8m1pV
 1rygFFNWeaqFFY5SFK5p8n7OutYiqsGq8m0cj89481oNRCmIDBfLJXZSIV921Fn+0vOC5
 JV53pEArghRpu5GbZn0evVDamLFT/R9Oki5+/y0ByLYT60goFyliZ8dNwD89zk1uh/HHY
 r42kmP9nx4TU/QHCn1iQWkjLf8mtR51BFIfKtFnXZ3q6hvDw1FZn81AVKShKcSTS1Rg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793266965;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Infomaniak-Routing;
 bh=UNIDVld/E4pswvXduzhl/EaIfhM0Umh4yotvuaqzwHE=;
 b=PwmC1H/JZ6+OchI81X8ypa3ogieozyq9KZ+KlFF0BPq9Xzh71WDh+gi40NCkTOfq8EAB
 rFNNgOsorFxG2HKeHm4RYgfnilVKvbJK/oKHH+dlRfZ38cx3tyaoGBASmWpuY7jUwrujP
 oAhbyANUfjyz1wBAr/GK+fuCL6XjRsUc2QU/gc8zE2HhXzZd1LaS2Q8TD+ILa8S6NsL+r
 L7Jue2TJsoUg3KI1mDe/lSplGg5JJZyTV55Qu1PHNDCgt2Nb+pVdQYfz6vxBHz655smpx
 rNoLOwQKVGzTtOmQ6Y0tXFBlTDhqPILB7VoWh/gK/jEvIW9WJUma7Do6vcFvBzGS5vg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=0leil.net;
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=HeYskEj0; 
 arc=none smtp.remote-ip="2001:1600:19:7ff8::190e"
X-Greylist: delayed 1042 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 29 Oct 2026 09:42:45 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=HeYskEj0
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:7ff8::190e; helo=smtp-190e.mail.infomaniak.ch;
 envelope-from=foss+uboot@0leil.net; receiver=<UNKNOWN> 
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch
 [IPv6:2001:1600:19:7ff8::190e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 74E9840638
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 09:42:45 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jFf341zfxz2XDf;
 Thu, 29 Oct 2026 10:25:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1793265920;
 bh=UNIDVld/E4pswvXduzhl/EaIfhM0Umh4yotvuaqzwHE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=HeYskEj08rp98lRJdGn04EcvgZ/8O33kqkrYRRA3nXNCpY9oZWWgBlVbTVz5zckkX
 P11wflIBJtj359mapmSnLX8XxGIxRSFoV6zZ/m9qZy7SacHWMwIcaw8uo79Oj2VpPm
 /FM99vpPvo6G3/m1FHKlDQOST0B/4Y65ThkEiKyoJ7iSBr9FcPsk6MkkrJyi9yHiJo
 /2jvLnMi+7WEcjR9KEPtKtGSuzHJaCxMaQR4ET1E7s7/i1/L/rQCeLrxOktuuhHo+u
 rV3r/x4oysTAvikiGk3vTUBPCaghqpWoe+87SxWjlmegTqm5GHM+mOYZFzBPKrWzk4
 BkAy8bOKTxQUg==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jFf330mHLzSDq; Thu, 29 Oct 2026 10:25:19 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Thu, 29 Oct 2026 10:25:07 +0100
Subject: [PATCH 3/3] README: add link to lore mailing list archive
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-denx-de-removal-v1-3-e71e448a9c82@cherry.de>
References: <20261029-denx-de-removal-v1-0-e71e448a9c82@cherry.de>
In-Reply-To: <20261029-denx-de-removal-v1-0-e71e448a9c82@cherry.de>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Quentin Schulz <quentin.schulz@cherry.de>

lore.kernel.org is an official mirror of the original mailing list
archive and is used with the b4[1] tool. I find it exceptionally easier
to navigate and search for mails than the official mailing list archive,
mention the mirror in the README.

[1] https://b4.docs.kernel.org/
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 README | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/README b/README
index df9fc9b96f2f..080274f28d39 100644
--- a/README
+++ b/README
@@ -47,8 +47,8 @@ In case you have questions about, problems with or contributions for
 U-Boot, you should send a message to the U-Boot mailing list at
 <u-boot@lists.u-boot-project.org>. There is also an archive of previous traffic
 on the mailing list - please search the archive before asking FAQ's.
-Please see https://lists.u-boot-project.org/pipermail/u-boot and
-https://marc.info/?l=u-boot
+Please see https://lists.u-boot-project.org/pipermail/u-boot,
+https://lore.kernel.org/u-boot/ and https://marc.info/?l=u-boot
 
 Where to get source code:
 =========================

-- 
2.56.0

