Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6296D606A329
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 13:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YabbD8Wo;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HnWjlx94
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C7F680AEC;
	Tue, 17 Nov 2026 13:18:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EjraqhGFUabV; Tue, 17 Nov 2026 13:18:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 953CA80AFE
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794921494;
	b=T0++S6c/PdV3JMrr72J25J+o/z6HxsfmxIkdFwYKNCldxQUl0j6rH8jlddupr8dPm1KT
	 GR4r3nqjUyDF5VzSCnigiw2It93impiDK48H3tWzMzUMaFfkIDj59Wr4/UdBfdp4PVccD
	 hqOpEkOSrXDtEwNXqoqZzTAqEfII1ctFu6fPNFnqbL3hp6eWWJuPu9Q2AdCgsZj/NBae1
	 Gd1GZOOpJgkuHUyk4fL5m7jv9hp+XVvzDhBinqxOP1JBBE0GuXc1/LYEmc05BqHPpWbFy
	 +f4FSqG9xRFAqiTUxyqMfIo2J52aqQUnd9LI4UqFDQBCHifDdJpcf1XJfnf0EImRV9A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794921494;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Virus-Scanned:X-Virus-Status:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9U3beOTWQjZCxpOmJrLfGTlvMS1vZFCO3/xgXdo8LsM=;
	b=KebZHj1keLtS/Sp8Zu6nqHFJXvJRFGqhqBU1W7iyp7RQZnOGmgVbpMMWVO2/MHNZuLWz
	 LUfeIxuthglkQEAdGs0tPAt3aVmTITMhn5McRyiYFEIb8vWioTg5uz9xzQevZnvE7B7sf
	 wHcbfVaIubNw0JKnsVwGI1xTfjRdfPHW3LQy6b46ftuxVoPezIWRb6bAaoIRkAlo39H1s
	 7IJW7Q99Z+axcjXWH5v5+toAfxEcOAEG/09w3GVsMDfUd2EfG8WOY6JjR5NilloMvpI6m
	 khEzLrwKr6oOZ5pzM+52vmF+ZFaRYnKEdMxFPcT677A1Vz3ypWWUbMBBy5xdcYItAvQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	spf=fail smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HnWjlx94;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794921494;
	bh=9U3beOTWQjZCxpOmJrLfGTlvMS1vZFCO3/xgXdo8LsM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=YabbD8Wov5MT4jXZ5htNTZRqjUhala02JjNHtxOIYeL7U62lT86sWCAZ0c+bnihzz
	 TwDxKHQ4MhuqwaY4Sear+slrEIkT0mFhs9UmhAmePWDbQUK7US9tYdRk5RIGq4oy6T
	 aALIQw3zcfneHNjzNDCpuTGz2C55gYRr2hCgd78ZiNqckG4XoRz5lgVDyC6ewkb4CS
	 4hmFIJxV3DV4khpETTba7QDjQpW96xb4XmNJ9ALx368X3dvwPTvD51c03+9R4+uqKF
	 FuR64In5w97G1C4lUjtPRf46oaeLKuUBcVmr88pQ4oEhOcwJouDlKooTaEU+mlOh73
	 4x42OjpxTE3Vg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 953CA80AFE;
	Tue, 17 Nov 2026 13:18:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 91854260
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 08:57:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6E6D580F87
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 08:57:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 83gWHwzOt1rD for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 08:57:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3E3F580DF0
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=ragaprasanth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; spf=fail smtp.mailfrom=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=HnWjlx94
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3E3F580DF0
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 08:57:05 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09093847F1; Tue, 17 Nov 2026 09:57:04 +0100 (CET)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 622FD83108
 for <u-boot@lists.denx.de>; Tue, 17 Nov 2026 09:56:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ragaprasanth@gmail.com
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-cdb684859cbso3072044a12.1
 for <u-boot@lists.denx.de>; Tue, 17 Nov 2026 00:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794905815; x=1795510615; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9U3beOTWQjZCxpOmJrLfGTlvMS1vZFCO3/xgXdo8LsM=;
 b=HnWjlx94nMC5TZAaLNYjlCd8deJ+eq3KgOeHN81nnLFzJXzrjKg5NYI6eh6sw1pZ52
 TZ8LiDlSyAtdekRuh916kOc6y4i4yJxw2ASnHdKmLzNosJEmSIIG5XBiKcalDIs9qfi/
 XR4DSlMH4Io0XpHdvL2tvdyus3ZbgKxQJEK4zzlqOP0Wq9IWuDC3whJGsZP3P4CK+5Tv
 xjcPHWJfHQd+3+pJmUE6E8dynsThu7TQPZA8u2swOx8FQAkKemIeIaRbXyt3PcfNV6Dc
 zsDHu9GHaPEjwNMJc36+iTzDvTiS/2QPv+a1feVA5gdmuHPf2X9IqU+JHE4TUSfwRy0+
 BgzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794905815; x=1795510615;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9U3beOTWQjZCxpOmJrLfGTlvMS1vZFCO3/xgXdo8LsM=;
 b=aFlvFxD5TSskMshW+0gcJg6nWK7dpic0wx5E5U1aUlUKBOyvr8cheUzELGRIkTDurt
 nAqStzBoEQaPb7u5O1gEX8YNk7yIX9uMVJ5GLORKsTswLCQsi+yh9fAdHVMuRbzdAFYS
 N5mBSE26Cq4hrK8Nw+yxWrH9sX63s4PDv2kKRgjViz0QXLQD0q7BM8kb0wul1FWC0G6k
 BPeaHAJbGYFzLGv0IiQX5AYeV/AYrIxWvhyjsIDyjDS9BU1vv5RUzwhiok0b9f/sNFM8
 9gg18x748w1tqmnElU2yrssj8nndn+tWylGYAO/xSosa6AW/GXIOL/eF8ChHylE+Q7kN
 yHFQ==
X-Gm-Message-State: APuU4Z9a1t8MBv2tmzRHh5XzprY3/zZ9ujjdVZS1NH7oWsz5/NT1/xCF
 uwZlRVIRrSB3ca6N+TvdHWFo3G/zwK6a+61DOkZQ389L1XJ8oYzt9rzukS9x/Y7j
X-Gm-Gg: AZFdTZfkM2U/R75rK0JKBMQW/O4MA2JvXHiECxgVSyrjyvFa0zSCjzsWENGwbNdBCtp
 +6UA6D/huxjDkSI3gg0+oZKj55pWD/isPpLhribKAEpWi9WHJQDNOj/ELC7CE8ruYTAhX3I1w2o
 dCvj+qgelCzJh12T35MLByEDAO7xlMekY/s7vtPs9L266LA7Ms3Wm65pjCbwpkwfEQeipFKmxH2
 3J1Uh44wTvT18Zbd5/Vyqb5DyTULwWdBXdIQsl3JddFNYrFCRy1Nib8m1snefBrVD4SLw8EB0nV
 6+wkFefrxQ/CI574/v69QVPP3A+MleONNDl05j/N0OIBa6QEkt+7zsqyVfGJzuDy2vloAG4Xa7R
 lY5jv0FWVcx8+FJ8zUO9vo9Rfx9lI6CpJ9NpFmOvDpkA/WRo4Uzvcxr+I1sOhyWDNqusDAMMsAi
 akO0IOBw3Ju+FuJlRg/5DKHsrU+w7BI8kwKsx+HcdxqbogsBKn+tWt9D5einMl+rq2l6pOaBQ/i
 JiCqBsHf3NMevaFhz8z7M0CYCaotIzsKtkjRFZ/krSlF9BUCJzCKrPBSuawAK28Wjwyyz7diqDq
 aWrkyBwRaDN6iC/kE5OhgOIeA3XcUgYLldj6FTUR8XB3IPCJauwgpwQ3xP7P/19nhjAfCuthi/C
 EDCBeMs+Ucg==
X-Received: by 2002:a17:90b:4a48:b0:3b0:c7ab:4644 with SMTP id
 98e67ed59e1d1-3b1b09e6653mr13041038a91.14.1794905814436; 
 Tue, 17 Nov 2026 00:56:54 -0800 (PST)
Received: from prasanth.alps.lineo.co.jp (vpn1.lineo.co.jp. [203.141.200.204])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3ac4d98b8sm3035228a91.13.2026.11.17.00.56.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 00:56:54 -0800 (PST)
From: Prasanth R <ragaprasanth@gmail.com>
To: u-boot@lists.denx.de
Cc: jerome.forissier@arm.com, trini@konsulko.com,
 Prasanth R <ragaprasanth@gmail.com>
Subject: [PATCH 0/2] net: tcp: fix CVE-2026-29007 and CVE-2026-29008
Date: Tue, 17 Nov 2026 17:56:43 +0900
Message-Id: <20261117085645.3142669-1-ragaprasanth@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 17 Nov 2026 13:18:13 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_FAIL,SPF_HELO_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The legacy TCP stack trusts the data offset and the option lengths of
received segments. A segment whose data offset points past its end
makes tcp_parse_options() read beyond the packet (CVE-2026-29007) and
makes payload_len negative, which reaches memcpy() as a huge size in
TCP_SYN_SENT (CVE-2026-29008). Both were disclosed on this list by
VulnCheck in May; as far as I can see they are not fixed yet.

Patch 1 drops segments whose data offset does not fit. Patch 2 makes
tcp_parse_options() check each option against the option area, which
also fixes a read past the end when the last option byte is
TCP_O_END, and limits the window scale to 14.

Testing: ran tcp_parse_options() and the length handling from main
and from this series under AddressSanitizer with the malformed
segments. Main reads past the packet in all cases; with the series
the segments are dropped or the options ignored.
Also built sandbox on current main and ran ut cmd net_test_wget: no
failures.

I used an AI assistant (Claude) to help write and test these patches;
I reviewed the changes and the results.

Prasanth R (2):
  net: tcp: drop segments with an invalid data offset
  net: tcp: check option lengths in tcp_parse_options()

 net/tcp.c | 56 +++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 20 deletions(-)

-- 
2.43.0

