Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F46606A337
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 15:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=W+lyNtIy;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=R33cMSgF
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0BBF9607F7;
	Fri, 13 Nov 2026 15:47:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LLYbym5QdfbU; Fri, 13 Nov 2026 15:47:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0A7F1608B6
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794584829;
	b=StgntwKipn2MeBYXaXj6ICjm8nY5E/WT/ziOoX7TIveLdEk4lq+ICbRf2R/cSezQq1xD
	 fz2/DnxBgMNqxjgVhM6vObzFb0E6+X5wyxmpNlaVarG57GF13c94gddLtANtInyC9XFRO
	 /IXlkdhV/xvOtuEO6/BEj/0vyb2o9PcWghXSO1KfSwp0zA0Vr9bMoDtK+K/G9Z+a+LI+9
	 LQpkXT5orA2L6NgfCMfLEkor7brNbiqLWlHNqWGYszDgA8rAcbyDEsKLhbTxaYfqos3ZY
	 b+kbiQQFlpmDZyD1wIoYC2P9tZeivI1TVIFDOWTCJ/BJmbUC90qw3TNv1wQgtXgoS8A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794584829;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Infomaniak-Routing:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ic/T+zOMGuxWsvzjmG1xB1GjtoVilWzj2d0r4EUMGMc=;
	b=T9DvT3naSAmjgPd98ibVFPQEtfLuOjg9jMefji47kBJNacI7LSD4epfylCqJtDWCXQO0
	 OvUxsBYRcwqP+/jTSwgtrJnFqzbZnOsBA2yT8vlSBMhTFkK1TtD014chucY7yMV42YP/Y
	 BZxhOxrjkA36ZZGk2vMYgqOMAchud/woiucBRA6x1QEzEg555QibbD1KX2GSTtdCbEDB3
	 h2dxYTwl2t71Wq4Rs/Y9gtcRRcR7kMQAlPvwPjrDLM1z4/G2fWx+x25gWUvmGLNLPZNmZ
	 lA+YHqLcSLGc3CTaOZj4M8sc1DPcJ5HILVGZDkQ852zZHnptupAqkut3eNkgzinZhZw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=0leil.net;
	dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=R33cMSgF;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794584829;
	bh=ic/T+zOMGuxWsvzjmG1xB1GjtoVilWzj2d0r4EUMGMc=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=W+lyNtIymx71cC2zA8jKapmJ7bzlHZpVQ2NJLpSJNL6FEwqViM7rW4Z+l+RAjI6nN
	 WsiLG8Lk5oG6tUTjZWY2XWehWrw8WmV+oVdS+FJtAsD+FLsLGYEzFGgMqebRrkGOow
	 UY8JUkBVHtR15AoUqp8XNTK3eXr0uLlsi4M74yqPS9Lw+td6CefDMrjFqMrPLZ7mdr
	 xaG1wgaZK3oQ9oZ3wKarr8g/I4A9l6Ya6ColQEMRog0uDegMo0PlAx28g6ya0xAbFS
	 o84NlGYngaCka++opURsCxNcycYSC7fgo42kMuNAvKLPNsKmW3+OhxObQSwZ8hs77G
	 cYWYikAFOYtrA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0A7F1608B6;
	Fri, 13 Nov 2026 15:47:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5D6831790
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 15:47:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 42BB360678
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 15:47:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PyqrYIxyYRRy for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 15:47:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 724C4605F4
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=45.157.188.8
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.157.188.8;
 helo=smtp-bc08.mail.infomaniak.ch; envelope-from=foss+uboot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=R33cMSgF
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch
 [45.157.188.8])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 724C4605F4
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 15:47:03 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jR1pT4bQCz2Cd;
 Fri, 13 Nov 2026 16:46:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794584817;
 bh=ic/T+zOMGuxWsvzjmG1xB1GjtoVilWzj2d0r4EUMGMc=;
 h=From:Subject:Date:To:Cc:From;
 b=R33cMSgFDl6zGptD1dqCiUTsDTY3UOu03kHxQlG+KukGn+b4jFc1nxGmd6jjo/rpM
 TgQjo+7KmE9lttHsRaMLMHdVeqLv/M612otwgyFbNJWoir4freOCLbkADbwqkMQpCy
 HIthAoldbVABTl/NzGq1JWpzR9/JQLimoyujeL1wZXeQxRKGnecZiyuvV8YnxLzvEX
 +xDAZVN1S1tCuL/T0oSrorYx0gDUtYpmaMunZPEodf6UEKyQnvbWpnoQXx2fx4lJW4
 8HueIRVfJndOMYCYV0RsFvCBLY2hN2L48uuOoJXE8THAl2A5nG5cpVOyy5qoBMnQei
 8vCjKxaIY8ngg==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jR1pS4lFBzJLh; Fri, 13 Nov 2026 16:46:56 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH 0/2] rockchip: take over maintainership of Simon's Rockchip
 boars
Date: Fri, 13 Nov 2026 16:46:42 +0100
Message-Id: <20261113-take-over-rk-boards-sjg-v1-0-4278c885ecdf@cherry.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yXMwQrCMAwA0F8JOS9gKk7tr8gO7RpnNlglmUMY+
 3dRj+/yNnQxFccIG5qs6lpnjMANYP9I8yCkBSNgOISWmY+0pEmormJkE+WarDj5OFA+l1PObbh
 cC2MD+DS56/s337q//ZVH6Zdvh/v+AYEypw97AAAA
X-Change-ID: 20261113-take-over-rk-boards-sjg-b7d5bb6289d1
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Quentin Schulz <foss+uboot@0leil.net>
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
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

As suggested by Tom in private, take maintainership of Simon's Rockchip
boards to make CI pass.

I don't own any of those devices (yet?), so if you own any of those
please consider officially becoming a maintainer for it, otherwise their
support may get dropped in a few releases.

Signed-off-by: Quentin Schulz <foss+uboot@0leil.net>
---
Quentin Schulz (2):
      rockchip: fix MAINTAINERS entry name for Rock2 Square
      rockchip: take over maintainership of Simon's Rockchip boards

 board/firefly/firefly-rk3288/MAINTAINERS |  2 +-
 board/google/gru/MAINTAINERS             |  4 ++--
 board/google/veyron/MAINTAINERS          | 10 +++++-----
 board/radxa/rock2/MAINTAINERS            |  4 ++--
 4 files changed, 10 insertions(+), 10 deletions(-)
---
base-commit: ff8a9bc41e4e5bdd3406932af5abb4c18064e539
base-tree: https://git.u-boot-project.org/u-boot/u-boot.git main
change-id: 20261113-take-over-rk-boards-sjg-b7d5bb6289d1

Best regards,
--  
Quentin Schulz <quentin.schulz@cherry.de>

