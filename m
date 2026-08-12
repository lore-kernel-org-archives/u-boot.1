Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C5E9C5B56A
	for <u-boot@archiver.kernel.org>; Wed, 12 Aug 2026 07:45:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 714D16088C;
	Wed, 12 Aug 2026 07:45:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RizCGw_9YnJy; Wed, 12 Aug 2026 07:45:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 92EF260823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786520704;
	bh=kgg7Gwx40NyARU7IBbnpUCBgS4BpwRzaowe9HOZvev8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bTQ8+sE3fb/Oc8B7JIZCnxfkgWI16TrmRzWXczpVooz+DLbLqxHXOQD0HzMUGg7GH
	 ZPO9YCAOGPQsY1Zv5EAx45Y62bG5uYxIsqT62O2PzB+9wO2B6iNJS9ZMAmXdaitxGD
	 zEztw5PF3YPEar6ERLpPC/se+vpyygJ6J+mQy4F2iljm6akouutcsPmTb69ZSBnQ+8
	 piXVXeFf3qlYYk+2ClPT5x1QlpvN73sVQil5rp98UOuMs6iLcRt+aARvSbMEucNd66
	 Buxbp+Q5ivbhjMjfwHcuasuUBMNzu39BqppgR/0JlhGvUbiLQUB/9V7sYH3oy9R9Du
	 silkZ9o0giMyg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 92EF260823;
	Wed, 12 Aug 2026 07:45:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 36A083A4
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 07:45:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 33FC0403A9
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 07:45:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p4cjeOjChS2U for <u-boot@lists.u-boot-project.org>;
 Wed, 12 Aug 2026 07:45:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 707A3403A7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 707A3403A7
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 707A3403A7
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 07:45:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 35FAD43AA5;
 Wed, 12 Aug 2026 07:45:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74DA91F00A3A;
 Wed, 12 Aug 2026 07:45:01 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: u-boot@lists.u-boot-project.org, Igor Opaniuk <igor.opaniuk@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <20260727-avb-root-key-pluggable-v1-0-7e27b2b92cc0@gmail.com>
References: <20260727-avb-root-key-pluggable-v1-0-7e27b2b92cc0@gmail.com>
Subject: Re: [PATCH 0/4] avb: make the AVB root key source pluggable
Message-Id: <178652069921.239003.320032105460822758.b4-ty@b4>
Date: Wed, 12 Aug 2026 09:44:59 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1786520702;
 bh=kgg7Gwx40NyARU7IBbnpUCBgS4BpwRzaowe9HOZvev8=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=NG8r0+8Aco2ofNzWC8jjBNo4IipPvtVza2zvEUMJ3ItNJdFG4uP2n04h71MazG+08
 PbEZ4843VnTZ+kYnosb7CXbS9/hSAgLdbKC5QkvyYehpuxT8/sv5LASzpWcQcfzPN9
 oIQ+XUwnn9jbQW/7OFJnGhB86kt/Gr9batHAsMAP5hmaBSQOkSuApzn4hj8VzKBWi5
 4F14rSfweE866Bcek61bpufOZqwOkv4OsM/h0IfdsVAmrkv7ecWkUtQvFRuPiIF8Hu
 0Q285LDHE3pRRnHsESG6/QMUbtMJlnTBNbY5i2ZZ4uW2TieWe8BfNwdAPlN8c0NQiD
 2YHpjSECMjFJQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=NG8r0+8A
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

On Mon, 27 Jul 2026 19:14:12 +0200, Igor Opaniuk wrote:
> AVB's entire chain of trust reduces to a single public key, and today that
> key is hard-coded in U-Boot as the AVB reference/test key -- whose private
> half is publicly available. That is fine for development, but it means the
> root of trust for a "locked" device is a key anyone can sign with, and there
> is no way to point AVB at a real, per-device anchor.
> 
> This series makes the source of the trusted root key digest selectable via a
> Kconfig choice (CONFIG_AVB_ROOT_KEY_*), while keeping the actual trust
> decision -- hash the vbmeta key, compare against the trusted digest, fail
> closed on any error -- in one place in validate_vbmeta_public_key():
> 
> [...]

Thanks, Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)

[1/4] avb: make the AVB root key source pluggable
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/83f12ac9d6355b4d843b64f5a92c933da4c94f64
[2/4] avb: add OP-TEE root key digest provider
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/b842aab3e2a2a195278239628429b35df112542e
[3/4] avb: add board-specific root key provider
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/d57dbfa61be077382f15b2fa70bc7937d514408a
[4/4] doc: android: document the AVB root key source
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/c22d53af6344a6313042f70d6e55448e1562dd80

--
Mattijs
