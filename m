Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A1BC5DF81
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 07:41:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3144560689;
	Thu, 20 Aug 2026 07:41:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WozxnT-0j0qS; Thu, 20 Aug 2026 07:41:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787211681;
	bh=uQpfD8EY0eyZS5CPI5VAo9JKYD/fRSyjPZb/QlTFhxk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Ic5BagsZw6CdJxIRkEiDAgSYVfGM7PBxda9yaj4yNMfNLL3ZOZxI/HaIzTqKYP2vY
	 DfiitpRKEGVGzkBiaJNqp3SkzYe/9L5RSXFsBcea5FC9fYOcOQtIXZl2jLlo1v/McM
	 4jatIwWortKpZy7Q0RdwB+uTi38BgiKsCGZN8egWqfnEIhGLreETNNiqj67LAkQzGr
	 o6xKEkT+vH8utL/Q4/5Ndo7CtdWy9rFZ4hpCI2fL7nwFjwtwN7mmhpfpc2846gjoIO
	 BiHEcZhyQnBANvAadyCx7hOMk/oZalQyx6x1I3R+cVY5y2FVJ+mmrsEVK9sNzZSDRK
	 Fb59o5GItMJUQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5D09160671;
	Thu, 20 Aug 2026 07:41:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C240229B
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 07:41:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B45E840074
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 07:41:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ytHHSOTV9gtO for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 07:41:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=Pp3jqBkp
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C806740055
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 07:41:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C897760AA9;
 Thu, 20 Aug 2026 07:41:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAFE61F000E9;
 Thu, 20 Aug 2026 07:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787211676;
 bh=uQpfD8EY0eyZS5CPI5VAo9JKYD/fRSyjPZb/QlTFhxk=;
 h=From:To:Cc:Subject:Date;
 b=Pp3jqBkpLGvG0D/X2rgliGaloK83U320P/F2LVV/T0gGxy0ZOwls0wjY7XuJWk2Q8
 KwBQoqkZHyj+BpqtuYjuo1hIShMSrusW5JEti/a7mRjNr3em3luJgX0dIvPKtaOYl5
 8cruGpaDB0Pz7cGo6EwnhdshjWHxTQzckmJdL9GZlXIAOp2Hr0PFT7+ba8CIVIW5VE
 mKoLJn6I2Wl2KWwyP3+bMGvTUg+unjH3yfgLMPSEe/A394+Yy59gPj3XL3lzZ++3L2
 ZXuzuEH6jhwAaLGSLCQiS/vNqk65aMmA+27MgScUM03t9favyE+ZKaGhqTTkHQEihn
 dSKrT9CnxzhyA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@nabladev.com>, Igor Opaniuk <igor.opaniuk@gmail.com>
Subject: [GIT PULL] Please pull u-boot-dfu-next-20260819 into next
Date: Thu, 20 Aug 2026 09:41:13 +0200
Message-ID: <87jyplgrxi.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Tom,

Here is a PR for next with the following:

Android:
* avb: Make the AVB root key source pluggable
* avb: Add OP-TEE root key digest provider
* avb: Add board-specific root key provider
* avb: Update docs for root key source

CI:
* https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/pipelines/1016

Thanks,
Mattijs

The following changes since commit 36c377b9859ffb53eb1e39ea31e8d96d1e0fe1e5:

  Prepare v2026.10-rc2 (2026-08-10 16:43:34 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-next-20260819

for you to fetch changes up to c22d53af6344a6313042f70d6e55448e1562dd80:

  doc: android: document the AVB root key source (2026-08-12 09:44:24 +0200)

----------------------------------------------------------------
u-boot-dfu-next-20260819

Android:
* avb: Make the AVB root key source pluggable
* avb: Add OP-TEE root key digest provider
* avb: Add board-specific root key provider
* avb: Update docs for root key source

----------------------------------------------------------------
Igor Opaniuk (4):
      avb: make the AVB root key source pluggable
      avb: add OP-TEE root key digest provider
      avb: add board-specific root key provider
      doc: android: document the AVB root key source

 common/Kconfig       | 50 ++++++++++++++++++++++++++++++++++++
 common/avb_verify.c  | 72 +++++++++++++++++++++++++++++++++++++++++++++++++---
 doc/android/avb2.rst | 37 +++++++++++++++++++++++++++
 include/avb_verify.h | 19 ++++++++++++++
 4 files changed, 175 insertions(+), 3 deletions(-)

