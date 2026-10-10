Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA1FCA6017
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 13:15:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 08B20812FA;
	Sat, 10 Oct 2026 13:15:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zxzvxdgurfX7; Sat, 10 Oct 2026 13:15:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AAE9481393
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791638103;
	b=G0fZsE2jUbxzOxwXEJXCeDulFuPDT2wexY3xwB6NLxxt70MDHq6UbXQSmZy1IEbIADjJ
	 hRcbvtyNzyeQ+IU5EGrv1TAz+YHNsvBpF4yIyT3W1Gu25w9RZVh6dGrOseOtTXlkthuzI
	 39k4aO+FchkOdNvm4qMzBgzrkrwzpjpayfdO6e9HlaGkFEdEMuQVe3gUf6ZMoEN0xIZhd
	 lY4UMPhSTpV6f3dSSCNQi/q8LHkyoomA6V0+y+ef2bqoaxN5xiHfN7XEZFnNI1DqWDdyq
	 q1uW0feHD7OatZ0uR/wqH+9mbqQCgOyGtemS1LBnr/1mPAiyp6dzcIcXUaL7kNlboOw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791638103;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=e0xBFDKoEaQRyohJ3reP/4XzdYNxun9jxY2MVi+CEpo=;
	b=Ka6AvMJuqyIgfbZwUQoYFRpSt4Uu3EuwhkahFqIgdmfzkVeRf3we+ToTSlOg4XjLcNZn
	 Af19xFJbMX1QCF18RHFRWy/fLLuNpu6E8LuZQgFXhg4nLZskDMK2qqjMzEjwCRTnvtjsm
	 5a8Ab/NglKIglRY0P4t9/7eU66eTbCSBXtambB4bdoKrwKLZN3O6OMuh5vF1fbeVTYW/f
	 Z9etqfTEuUa0Ymmu3WofRgKTtm7ir1UIZzkJ9MqqiuUwrbe61yHJQFc6S/xGAHZfL5Zd2
	 +zDAgKtdaiGYXCKSdU2clQbUsZOgWbG88hvIAILbA3C6sfS8X3poQIMv2YjlYEnsRPg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791638103;
	bh=e0xBFDKoEaQRyohJ3reP/4XzdYNxun9jxY2MVi+CEpo=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=AKUZbipHH0aE94zvd9tgzb4JS1JNf6UCg59vClsECWDZeOOcwPjc11JrrQ7Wjyomt
	 TH9+pvi8g0OSksbzvvLMnzxPZ6jbBgO2tNMHuh4QOIqubG8pkA8Rcu9CR57/Epqjyo
	 Pp/JEOR8IemieES7uW+VCz8LZGyqZZuKcoTgOmBn3nndr/t2nnTRuFG0pTTH/oInbG
	 +PqWu2jY9b06NS82pPxpFZnpggwcsYveU8o3SyFy7jb3ENY7hnVO4lYaFy1BzOzeC9
	 2ov5GfVpfHgG9FZFhl0Yi8WpzXTYT7Mh3Qa8sMP+edkiDjJzDM+T9aNd2TRLekW2X7
	 YH5iQvVmOljrQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AAE9481393;
	Sat, 10 Oct 2026 13:15:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2113C22B
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 12:28:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F3D1940061
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 12:28:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yjBU6pXdoroF for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 12:28:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 155B34010A
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791635302;
 b=igG7fRaohOy1CBw3UI2QKJtNk5QeytlA2BbfqnM5tvje9EBRGzmMWJi5yf+KhrTewe0c
 RpoI34GvYYCarGEEnUEufkxL1QNbTmVNVDPlYHFvnm+gNM99jjQkoU3HxdjHJTYTKifLj
 UiYSCSMMTM3Q7bHVnyU5Qkqnc3ZGr2YZ3WK7GUBYKXmy/V/RRis+r/vegk0op91vz+tV4
 r4Qo6DDPgNy+KOlxbtPpWb6U9K2i8zSZmEbWJ2P++KCgMu3ve6nx/tigajzoQK9j1nSF0
 DuH4chyOhnb/oYRDEoBFmekwEttV11nv5RN5Dlv0QyNNbWLS3mI9xzD3k9s4keYxMVA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791635302;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Subject:
 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To;
 bh=e0xBFDKoEaQRyohJ3reP/4XzdYNxun9jxY2MVi+CEpo=;
 b=WSPI0Wxz0iwEkHeZmFXRTe3Ggvu+ed0hMvC8oB2QQec+ajAcY8xGEky++R8DKyUSclnp
 FRbOOL7356IYbVQm44Ic5KoGQaZ/zJJFSkjHYValrJz+8EibRxM6hY+2vZ+DfxJbI6+Za
 +puAp4xrQPduCgtouVPtP1V1r5O3YEKLo+6vdjmxAAoPdVPDbu4xAgE1juYdIEH8Eh7So
 jyd6NvR3fdlR2gY/W0L3yl0TJbF8qyv+HjSN19LqlA1AUWkgEZwQi4FBJ2/ya5qVrMJ06
 icH2yUCrCIGujirZ7v0Of8wuIfrL+DL5Og2r8f6LxE2U8A0NTvRbXI/mjxoptSgg6KA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=AduYlW8m; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=AduYlW8m
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 155B34010A
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 12:28:21 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A139C60211;
 Sat, 10 Oct 2026 12:28:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A860C2BCB9;
 Sat, 10 Oct 2026 12:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791635300;
 bh=1LQfVsgm+hZoA03oCSkgKiJqmrPzLuZNQnEW6UVJDQI=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=AduYlW8m5kNHVsk8pct87nwcM/vSs8ENA381sibB8Fv1VH12MVRGrK5xuqEleRvsA
 FjEsSPkQWq63eQSblHxRW2rcUagT2XE2e0Yc3xP8jdIcsNxCh++4KdRHrSloriGny3
 jUZFdlbcjpt9X0xf833YGudHnIcvmZBEmv1I6FtjaI8iX+cWeeZZue0ScDjsaJ36qG
 ok/+uBPo6pB5djy7Oth3rwfq/LVN3K2XCXMvokvPyUl4SFjpDibt7BR9fejT24Fxzy
 ZG+pYxWYiwA+PF2VTG9dHJcoZBI7av2XceHe0L5GRIILhndZJULfN7ZQDjqU2ygLwz
 Nt4O6jVJK54SQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 17CF9CA9EBE;
 Sat, 10 Oct 2026 12:28:20 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Subject: [PATCH v2 0/3] cmd: button: add live monitor subcommand
Date: Sat, 10 Oct 2026 14:27:51 +0200
Message-Id: <20261010-b4-button-live-monitor-v2-0-004f47a4a7b1@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNwQ6CMBAFf4X07BpaSEFP/ofhQMsia6AlbWk0h
 H+3YDx6nGTem5V5dISeXbOVOYzkyZoE4pQxPbTmgUBdYiZyIXmeC1AlqCUEa2CkiDBZQ8E6qCs
 lqq6WpVaSpfHssKfXcXxvvuwX9UQd9rfdGMin4fsoR757v0jxLxI5cJCtuBQlVrxX3W12NllTS
 +NZ24k127Z9AKw53gnTAAAA
X-Change-ID: 20261002-b4-button-live-monitor-87b27d864cb6
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, David Heidelberg <david@ixit.cz>, 
 Simon Glass <sjg@chromium.org>, Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791635298; l=1306;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=1LQfVsgm+hZoA03oCSkgKiJqmrPzLuZNQnEW6UVJDQI=;
 b=Fa8ytRsn5eG5DTfk9a2STDCDwb7ezzL/5qH+PQkkc/tB7SuYwxGh9LsUUsDRNX8P5iNPjKDVh
 2VKoV6EOZUhDimWWe4ebo+Yjk3mMNAvBqftZQmhei6ddZ7gQqmyIIHP
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Sat, 10 Oct 2026 13:14:42 +0000
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

'button list' only prints state once and exits so verifying a
button mapping on a mobile device is not practical. Therefore 
the new subcommand loops the input states and prints it live.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
Changes in v2:
- Add Ctrl-C handling. Timeout of 0 now runs until Ctrl-C
- Use ANSI_* macros from ansi.h and plain \n instead of raw escapes
- Share state printing with "button list" (on/off/<inactive>/Error N)
  and probe all buttons once before the loop
- Match "monitor" with strcmp() and reject an invalid timeout
- Add documentation and sandbox tests
- Link to v1: https://patch.msgid.link/20261003-b4-button-live-monitor-v1-1-6a2934e71fbd@protonmail.com

---
Petr Hodina (3):
      cmd: button: add live monitor subcommand
      doc: button: document monitor subcommand
      test: button: add test for monitor subcommand

 cmd/button.c                 | 104 +++++++++++++++++++++++++++++++++++++++----
 doc/usage/cmd/button.rst     |  16 +++++++
 test/py/tests/test_button.py |  20 +++++++++
 3 files changed, 131 insertions(+), 9 deletions(-)
---
base-commit: ece349ade2973e220f524ce59e59711cc919263f
change-id: 20261002-b4-button-live-monitor-87b27d864cb6

Best regards,
--  
Petr Hodina <petr.hodina@protonmail.com>


