Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4ED6CA5FE2
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 05:13:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7A64940687;
	Mon,  5 Oct 2026 05:13:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JOYQQyloG4Ro; Mon,  5 Oct 2026 05:13:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org BC3634069F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791177192;
	b=U2A5uVv6ymqs0Uh7myoE+OQLlqDWjQ7kfe+q+R38UiEW7BxwkFPnxzc7W2FQjnfYTo3h
	 itcdvZV0+Af3SyFyVyWhfjvDNJlz07IOXO0yUlnr44J0+6y7QKovTPW7eO1VdBJdWZ/dN
	 giQ/hYv7dB30JNpdkM508WZlflbC5cK3v/4fgbJy41fap7Ykhxtf9j1CBgrvGRLDelFJF
	 QHPInj4SKznu9s6c93gLuSVYNynAuY11KevkoNwxFabi3ASB0s+oVCNRsDuF1RPexAKl7
	 MQfHnllx1KJ4Y97525O+tkpCUd0z6+RF/uGil4x1Y63JAT39AvtSYeTTRMZbrFWsk2w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791177192;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=PeG6/7IULiBDPfnj1nSLXt21bhSq9oPJgWugWdGj/ok=;
	b=WWF1qER5oJucT5MK1MEKajxAaUy4V/RNeD6fnkvn3QANDSwVXcw5/elQN43beE6IksXp
	 ZcR+f/T3ZpiyZaArj8LMPHhbUZBGyY5TuhlCUNMQ/JIN1pJuacWGwe9OlmntFYHhICQQL
	 rw3qWHO04ERhwXDwI7G5Kh+EvHIDNkYrSLjaVXwTYzsWg3ewoZNRl8aT1e12/+K19wT6i
	 YOsfh1pUjP8Xlkqdqe9bjtWV3JEumM8y2jASaBZcpd9obnVTwHa8txLqtIfmjL8YTWiIT
	 HIHYkA1G32pODNDYJKk1fhKZah5VNwMW4sqjf37HJKwr956V4GvTUrEtQeDVw5cz3qg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791177192;
	bh=PeG6/7IULiBDPfnj1nSLXt21bhSq9oPJgWugWdGj/ok=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=CtgrxZMDgOU/Iea8HQYSr21dYlqGiroYyHQOplLcM5Ls1b1uT3jMpfdu5/0uLzQto
	 MtCuMxxRna0PxJDGVys5YQfQeKdVWLKPZ3TQuLpYs7wLnrCHrNx5qfNqcIrTmobbAI
	 ekwxB/srIv5LFO8k7tImOJw5lad80oRItnW995ea3f9+tFdDPpLr/mn4+WeK2Vp+T9
	 Kf91pC6wdBI4edzX3oweM/SHTzNr/C2zPIQO3e2zmKteXtV51/zwers5UbH9P72juJ
	 mGblX5EfnPlDIf9G+2z3HLayPN2r4DYMAcfv+t9G8OOBwZ3l4Vn2JrDJ3UNRP1ptyB
	 0LdjCh+1WsZcQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BC3634069F;
	Mon,  5 Oct 2026 05:13:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9E035323
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 20:48:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 841D840049
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 20:48:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 26nn_KRewL9M for <u-boot@lists.u-boot-project.org>;
 Sun,  4 Oct 2026 20:48:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org F25D640004
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791146918;
 b=AoKzYqgHFCbTUDwyDGg2h/UqzpxNrtJrXMhT3MqqKlI+o1584go8u2IKVNUjzEFimJOD
 RIUtZDuwGpiILQc55OMB4hmkKA41NFqsiNE7ssbnqsM0Uzr3ki93ANPyAJK+SxZt+4iDM
 FK7WzHow00j8qK6m1OKcGYdI5yhfFMgM/Vacj5BptTExGWkuHbpIwLAoXX2LWXCQQuvCa
 +I93JBam/6wC445iUm3MbSwhsAPmfqsnrmpoyi3JMhQF0r3eUApPSPfynwz52YG3Sql4N
 Z4H27FD2dQUJO0LWJOwNGIwWrr5HDNFGmiIxa1k/5DxN/TS6mmZaparL/ToeiyY3guw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791146918;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Subject:
 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To;
 bh=PeG6/7IULiBDPfnj1nSLXt21bhSq9oPJgWugWdGj/ok=;
 b=DtDPvodIz8xxJo2uJlgSN3XdlklfuzAicAlHqkCID0tD9B59XvN1vHy/Bpiar5yaKxrK
 Puh/HYLbaJuWFbZ0kjMKnyUjhNqSeRP3m9m33/GGo/tnsRXoEVCCzZJp8tIG6G2cd1SQv
 956crioK8ecj2/R4xXoa5lgcGQhrxWmHxJyt/m3AXrh7vu3lwQO0m2rgO0hVBIEJGSQzZ
 ZCPP0hYcFZwnV1/R4NPB+P2Y6d+ONRpx+etc/nzZccI6mTOLo2Tek8nyVrdg7erB4GyuA
 smja3WvA2p1b1SF/xl/Z6HTYZVfa0SxdjWGwRhT04MmZ3dUOEKK7L/FDnpFCeLpex2Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Lwzbda6d; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=Lwzbda6d
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F25D640004
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 20:48:37 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 83CEC43E3C;
 Sun,  4 Oct 2026 20:48:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57471C4AF62;
 Sun,  4 Oct 2026 20:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791146916;
 bh=SeSaCm/2K8fRX/CYHdjFrFXfiD5aBGwC79FXh3F++Fk=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=Lwzbda6dfZzhNMRorAfU2RlGHu6u1cNAa4XTOO5a11Q+HNJx3BipLS3+cO5glmtfa
 BI5cgpaM1VljKEMNQ09+PF97MIH3skUTPf9w8Z/P/M1F1ls6NHRHR/fUn+CyJH1SIY
 v96xcwHFWExwsy1BHTgpbEivoG/WPjyq7pRyw2OTY8eh3kT/dsZtYVq2LF/zayQyLh
 /UEFdI1Na5LWHR6uEoRdXQ2v+KvNWw8eblSmOQtvbfXmM6w561Qg4CWpZ0wsADMGIM
 9RD2P5qo1QbHaddavwNFBAEWZOBmLmzRN13yCh2MtTpcagC9YlzQxn3cZAF/29tTD4
 ui11T4l4OK2ow==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD60CA5FF0;
 Sun,  4 Oct 2026 20:48:36 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Subject: [PATCH 0/2] dfu: expand env references in dfu_alt_info, export
 kernel_addr_r_size
Date: Sun, 04 Oct 2026 22:48:24 +0200
Message-Id: <20261004-b4-dfu-alt-info-env-expand-v1-0-700eb0e54b61@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMSwqDMBAA0KvIrDsQ46fiVYqLmEx0ioySqAji3
 Y3t8m3eCZECU4Q2OyHQzpFnSchfGdjRyEDILhm00nWuVIl9ic5vaKYVWfyMJDvSsRhx2NTV2+i
 isJVvIAVLIM/HL/90f8et/5JdnxGu6wbjE5jGfgAAAA==
X-Change-ID: 20261004-b4-dfu-alt-info-env-expand-8657a233c5f8
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Sean Anderson <sean.anderson@linux.dev>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Antony Kurniawan Soemardi <linux@smankusors.com>, 
 Petr Pavlata <petr@acrux.cz>, David Heidelberg <david@ixit.cz>, 
 Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791146915; l=1001;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=SeSaCm/2K8fRX/CYHdjFrFXfiD5aBGwC79FXh3F++Fk=;
 b=zZkb2OzRsf4psOGHs63bjaLzdXOKSPPjIQZBYibtBorKDUkibdoJ+QgUivVDN6Kc8Lysb/niF
 DFDX7OLu/jeAZ3o0/ZDdBr69wYMAqsIjuilonrxj2UloQbTySFP8Y/r
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Mon, 05 Oct 2026 05:12:03 +0000
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
Reply-To: petr.hodina@protonmail.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

`dfu_alt_info` is read via env_get() which doesn't expand ${var}
references the way hush does on a command line. So any board wanting
to point a DFU alt at an existing buffer had to hardcode its address
and size separately instead of referencing the real env vars.

This adds the missing ${...} expansion in drivers/dfu/dfu.c and
exports kernel_addr_r_size alongside the existing kernel_addr_r on
Snapdragon so dfu_alt_info can reference it directly.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
Petr Hodina (2):
      dfu: expand ${...} env references in dfu_alt_info before parsing
      arm: snapdragon: export kernel_addr_r_size

 arch/arm/mach-snapdragon/board.c |  1 +
 drivers/dfu/dfu.c                | 16 +++++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)
---
base-commit: 71433ebf2aed1be5fbd2b1d497eae670ab9b9962
change-id: 20261004-b4-dfu-alt-info-env-expand-8657a233c5f8

Best regards,
--  
Petr Hodina <petr.hodina@protonmail.com>


