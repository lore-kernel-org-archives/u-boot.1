Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373C5606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 21:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vOj3ayWr;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=vTMqLGsB
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1206980996;
	Mon, 26 Oct 2026 21:33:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Aw-HbDvm9j6f; Mon, 26 Oct 2026 21:33:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4610280A87
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793050430;
	b=A6v2Tz48szDTjC1QIPgZ8paaSRNKnDY2H8O2Yb+znIFy6zGIAuqHZMxjt0KsI0SvTLGn
	 qcbvpjAYfi7Cw9ZApJbh3PZ5ZL1748xcrnB/1UOSWAo/u9rXMU4ZI1CuZSMe0uEOIy10n
	 hPbrBSrqVjLM4tqu2Xb0d9st0++EHCl0uU0juN4IrILpqCLbj7/7CEd2v6IC9266Vu0Mz
	 9UDOzaXmBqnGlHTz8eXa2+txOiS98+I8Nc2PSYyn9zK3rvyHUf+09452ozBGUC6K65zYJ
	 z4YSb9iCEepeKa+XYDyelMbw7GmMCTDhBvKF85XRVIW92JXbEhd465f2faifyZTIOkA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793050430;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=iZYHokdwF1HvXCdhMgN6M8RWYjrUCjoFYij5ju2+SsM=;
	b=RDV7ePD/x9lVAtzofKD9J65t13tj9Y4v8de7qINV2tPQ3YT7X3rMnP8bLpyB5PfvEvKN
	 F25MuL/CTC050WBhz6+N6EBBIpnTmftTnRL9RzWEAff/YZBMYIhyc7QWIJ/FX38q2ecie
	 SENyIIFVKlCUhnf6QElr0PXiys32RSdz6Y9YwptHLtUUYrHmWXlbSzBiCw+lOZ9kX4yW6
	 z+r/0ss4u88cEG7WZT9hWsyg+8uQG1exOwxa+AHbjNsue8XgoUTjenuz1RFua+bfyr52I
	 nHXcGkeg0jBqDJQWw3F9M2YFXVAnXlhmKzl1vfjxmLr6cDqrE3gqH1BMt3A6OzV3nnQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793050430;
	bh=iZYHokdwF1HvXCdhMgN6M8RWYjrUCjoFYij5ju2+SsM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vOj3ayWrYtTfdiZuoLU5ezNEahabRBMvwGZKMGnhlNUtmUjxl+kNwpXSNv1s4urBD
	 MWr2CqzMaPzOYHe36X7lYMQajkvZvZrdWRisu2gmxLsRIgFib9ZaUFyTwFOvOzXuB9
	 iuW0WJQgHvdL6RINdGcp2Q8aiTXJIPr2x0aEhv7qt4yeOcTnNUiFIOPYtii5XRKvKZ
	 TOnYq3NHCdqRdq6Mz1uEFawYTq4bVD2AZYv4UE/wAoS7T/4sy5MsN72kMjT4h2Pxdw
	 YmVIaNzEhtgK9sPsat7DId4UbSXtOqXzPPAE3jr0hchxIhRzV8PiKr9hwc+vO136T2
	 PdbS0olkDwMCQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4610280A87;
	Mon, 26 Oct 2026 21:33:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1D47A3422
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 21:33:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 03988606FD
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 21:33:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S02Mz28CP23y for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 21:33:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E30DE60661
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=80.241.56.151
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793050428;
 b=XpSQzr5ELzkYw0Y0kn/riRHEKHWeUKfrU21943zLOGBk1SQ7+NOUBuimkOPGpXWxMYkJ
 /tPNt8CzWheSU2rSTVme9MTGT6xsMdAVdPJqBd+sBeB9fk4xPbv75rs2l5XyGxteTBjyo
 ls4yh3usqZCQRNuwaDVjUO8mb1t3Znq3R+G5vtY7KxUOy+zjtFYciObwxJpnSrUOUoulw
 5UtAT+0iyLqubr9WRHezQ4Z0BJSta4W8FVWS11sdvJ1uY/xsAI8lS7DFXpwO8OpIr17q2
 FXNEInoWbZIUBykk4cu3LJ508De2Kfaq8exkig4VSnKhW09LiZZQjB2DR8BuUwxVDtg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793050428;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-MBO-RS-META:X-MBO-RS-ID;
 bh=iZYHokdwF1HvXCdhMgN6M8RWYjrUCjoFYij5ju2+SsM=;
 b=VBet94PdjRUWxDEzowxtaL9tt+09sQfSdPNbYXYToRLnhs1yNF92muxRcxD7RCI6KVVC
 OCIsp347DrpjXjx+Okzr1wDgWqSSAaagIhqXBBls+icxYedmaToaw5HVnBFxWAkVnRpW9
 LLFXK/4C7OpEFLBT+qRR1CL99KNotknAe8wiQ53EAiJ5qGN9fBKdTX7xkPiYVxTyg0v0l
 +U4swexLG4Dx/bVvR5y9jJds00QWfi1+UDK08ImZflEI9dPFTkWDzBF0Ffe1cCSvbBQ90
 NgviyUBsLTgbpaE+/tf8cqOSgXQpKBr3Y9aoI8JznYOdrIKvQs01uHUHwK2UZjtpfCw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=vTMqLGsB; 
 arc=none smtp.remote-ip=80.241.56.151
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.151;
 helo=mout-p-101.mailbox.org; envelope-from=marek.vasut+usb@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=vTMqLGsB
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E30DE60661
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 21:33:47 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jD6Lv2kw9z8scj;
 Mon, 26 Oct 2026 22:33:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793050423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=iZYHokdwF1HvXCdhMgN6M8RWYjrUCjoFYij5ju2+SsM=;
 b=vTMqLGsBG1mfFiLAfI/2HFWry5c9+rwaCDDqsvfEo4+yEIV3lQ4P2xgCwFIfV9o19PGWHs
 0AvvPgQP+PuVnjcY6ej4r8EEL2jECDRwVR5vs2CtcW4uBYZ3ve4Lw6M1I+ahdPuT4n8diT
 GXQH7XJqLfZqetXGgEayQ/IyVYJ+fJ9JOYY9c9Hc/o+Cy4zikmmTqUXgcc6oWfU1L5/Xgv
 9g1KjoBgsXUQLqcn4Oc9RNxZy375yTSL4ltW+pb+5/cKeAnWwj89hKXBOm2aHbPE0WsvFn
 53u63vzxMjzHsadIi9OrrQJNZSLFgMZmo7tE3cGS0chLUzJw2eUu3kDdPzVtFQ==
From: Marek Vasut <marek.vasut+usb@mailbox.org>
To: u-boot@lists.u-boot-project.org,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>,
 Jacob Procee <sn125164@gmail.com>
Subject: [PULL] u-boot-usb/main
Date: Mon, 26 Oct 2026 22:33:21 +0100
Message-ID: <20261026213333.453568-1-marek.vasut+usb@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 33x16qep3r6m33w7npgxtujfhn351c5z
X-MBO-RS-ID: 850a4a8e7388a829379
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit 8649a54d301a4d0ac526324c7a7ad2574939ff27:

  mtd: spinand: winbond: Clarify factory BBM offset in OOB layout (2026-10-24 08:24:15 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-usb.git main

for you to fetch changes up to d610f703f937ebf7681e5cc36905586666e7ceb8:

  usb: xhci-dwc3: Add DM_FLAG_ACTIVE_DMA flag (2026-10-25 21:35:35 +0100)

----------------------------------------------------------------
Jacob Procee (1):
      usb: xhci-dwc3: Add DM_FLAG_ACTIVE_DMA flag

 drivers/usb/host/xhci-dwc3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
