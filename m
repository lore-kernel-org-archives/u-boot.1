Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D30606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 00:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=07d4HI5+;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=PDDS7kFk;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=JzNYVxwU
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C239B605EA;
	Wed, 28 Oct 2026 00:42:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1QblSwJnu56z; Wed, 28 Oct 2026 00:42:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 04EE860611
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793148146;
	b=O7PseqylppSrMs6at2ITofC1XOx8H8pSODaK6sGa8MLZC3F2yY6TqoTwE4h8J5lsuaVS
	 01OgOgfDm/BitG57VMVMT1gJqariJVtDEImmxW0TENQf/I8mdB7RfCKo7ku9w2rwpC4yw
	 KSrqSSGn2Ew7I7JUAAOfD4lTMZdJkDVnt6eH7qhqxrIEfnt3riBoKT8CbmnqAvl93I940
	 68KJJ+BFolDBYcliHc/0JXdkg/fw/2v79TdtfjnmF9egr7mr1etnV8wb1bhdKKwBACU1/
	 HmI5H6M+MsZmk+7kT2A6Yi2uvrYKXDKvPthmvybdZu8fyr78N+MgbTWYjmj/4+ZMKXw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793148146;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=YspVMe147Luzk8dv5YiMkd7O2UDvxcWf3D86FvYN1bM=;
	b=EJetSg0wavFojd0YF1RP8io/xRbnOijgjkL8JrKw1P5nb/mLWCvDD0kX3E8LCrDBA+uB
	 jZjlwhAMTz2jQkOvhASCdNMVaiw/2FUXjJOkZrD0O8nxTaf5sLD8DcKTspslOcdSSEE09
	 /r/u7dIpaAhdVeubHg0vd78y7qLCPSfdpcJlCVBMt/2GX4ARgkdXqSxoVm7IvwzQCQ25P
	 QtM0VJFwD72RlYG/DdlHWVa5/8cRbSBy579FzQx7cP0wRtrYx6epvCAilPyElHJ5116lF
	 6BzX08LHr/O1zMihPofLgCsbAlayNwAzhyZjA4XQWpWMEkhy97ERARBab1p95HhP9hw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793148146;
	bh=YspVMe147Luzk8dv5YiMkd7O2UDvxcWf3D86FvYN1bM=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=07d4HI5+FqPDJrNrU8xFQ5CtCrSAEN/Y9w6aSrZJj2cWJ8y+pHciWcTzV67p6s7Hj
	 6UPBvsyjKy4JI+BqCt7gkArvFd4gXJbyezq+NCKKzU8tE+GS4uJdIvUJyNDBMrYg9B
	 +bYBELuXWDCyl9HzkDWYiOQGeQlKr9PQp0Q1Lfa9yhyAiK/g1qZjmNUtv1+Rl2TH7F
	 zLtvZULd5RO4Q7zog8m6PgB3e7dtz1dGNNKCahfui7WI7AoM/h4KFkSPX3oNMgRc2n
	 cJj1MrTjHNr9eL9y26hvYQGIt9Rl0x++bX5ooN6BjWpmeUwmzpvnW5EkskJjkzAJAX
	 nmTvmuzBq8ccg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 04EE860611;
	Wed, 28 Oct 2026 00:42:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id 4F626D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 00:42:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with UTF8SMTP id 3D819401DE
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 00:42:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id xemVp3Gn9LFE for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 00:42:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D67334006F
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793148144;
 b=pVBLxw5K69WLw8YGy/ePLhUeuI3EUkAlBi8sQMQvKm/ZTYPclhZQlgCgTIAqnK+eHZ1E
 ftI7S75THdtvsGx9QtS4J8LcfbL5IJ64Cb4VCtFQ+qFgH01ZXPumnySZg8NlBV1x2aMQ8
 T6q5rkx7LByjHWXu1auD4FhykKuBcsGzp17gWM0ATipIc3/PKY8gpwclDkgIXkKEf7ggt
 Y3oVPxhlHbTrX7HYkQ6ktzOf3bhrItMHEWWA2mnUsYuIuRXZnxoynQDcKL9GzavhQmVqZ
 z6KsgpOhbRuxuXmk9BKLNsCtsoi+RfmhsHHdshEH6wR7uSippBhu1lg7VnQdGTmLaVw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793148144;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=YspVMe147Luzk8dv5YiMkd7O2UDvxcWf3D86FvYN1bM=;
 b=Xj3IaXA/ftcY7R5zwdrmPvyjK0LMFu1UE7HhWLzvpyOoZ+pXbJnP836ncvLOqdeRwK0E
 1mE9KvEU3/lfz9DCZTPKKuhFhF+AxfPTpUo9aqFBOwOCFjxsEtOlKys6utb+4SSac1oHh
 vhmuTi/LS+j+t9E/crYx1YY2WbA+LTeZtvfLADidLfphC8026oiRP9GJ3oxRIs7JyEpr/
 cErFJHniP+n4qoSk3s4Zdf3I5v0TVnTtppPfFTv38pCXk016lk5j5Ril9/adhXKrxvjXi
 l87LQixZl32Yf45lSmYVTCtSA21OdcmJexyQuYDuKFUoXceRCHBZIondEOf7Q7u1NgA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=PDDS7kFk; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=JzNYVxwU; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mainlining.org
 header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r
 header.b=PDDS7kFk; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=JzNYVxwU
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp2.osuosl.org (Postfix) with UTF8SMTPS id D67334006F
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 00:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1793148140; bh=YspVMe147Luzk8dv5YiMkd7
 O2UDvxcWf3D86FvYN1bM=; b=PDDS7kFkqMiTY9ayy5o7N+z/sw+AkciSLC1JWuP72cN/ISQwQy
 fKzh7Hw/xyAoIFpTgRi/Cih5HG/DdITJ6vd9YpVCWzKJ3FF7E5UawRxz1Lwzpsk+In9RaTAVGjZ
 TY7z+tF9z+Y1DcKRwTGhnd0Poy05N/N6Aj6p27/JrdEcg1EqO/Q1vjKUw9jsMODPlaGtObTOSuo
 O6tqQKt9mPTakyK9Jqar0EYhqsxCJvEzp3V0AtNgm8OY6m+tDJymqKrferfZ6APS4G5/31oeKG7
 96qbrmK6AwDIV7tuaqOBI2MzfbcZGzJaxeFs33dZiTOP3HtTnGTZj/GDcBK+ztQ2pSg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1793148140; bh=YspVMe147Luzk8dv5YiMkd7
 O2UDvxcWf3D86FvYN1bM=; b=JzNYVxwUAowomMG2ia/aVe8Yl3QEq1lHGxUKGYzmDFQsS7fM1o
 x2qKJMIi6w5kvZ2Rwk+4+0uhjCySluDXnjAA==;
From: Bradley Morgan <brads@mainlining.org>
To: peng.fan@nxp.com, trini@konsulko.com, u-boot@lists.u-boot-project.org,
 Bradley Morgan <brads@mainlining.org>
Subject: Re: [PATCH] MAINTAINERS: Add my tree to the POWERPC entry
Date: Wed, 28 Oct 2026 00:42:19 +0000
Message-ID: <179314805088.21446.2683316718116223518.b4-ty@mainlining.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261028003337.15936-1-brads@mainlining.org>
References: <20261028003337.15936-1-brads@mainlining.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 28 Oct 2026 00:33:36 +0000, Bradley Morgan wrote:
> Now that I have a custodian tree, add it as a T: entry for arch/powerpc/.
> 
> 

Applied to next at u-boot-ppc, Thanks!

[1/1] MAINTAINERS: Add my tree to the POWERPC entry
      https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/206b4f5c7488
--- Thanks!
