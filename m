Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A88D1D887
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 16:08:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24EF088753;
	Tue, 15 Oct 2024 18:08:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729008532;
	bh=uJnNyvxc9iX213xqNEfkSY/CRizN+Q5AvquekKgQ0t0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fWD39ISi4u7vmaAXNLxaH9GYqhYjqzaSU6wPozi+ebHVZqwCsMIK7mID6NRKqvk7b
	 f08m9Nf35cdP+lQZRt4r8KikqSzWLXGQrdEeHlirieHd+hbliqx43qxmwJTNbIZfX+
	 1giKKG1QlW2k+anYGhltDshQcBMdB/rBFE//yM1fDyVuFlEpTy0RP5EuLp+0DN6cT0
	 jXjtRnUCOqtrVV+luqcxVRdAKxD5eiVcfVXaIj/9fdIGlvyfxel92wN4LsJnpS2lSP
	 bk7gsEscYPruArhHSdoEpWAh+VdxMwOLekZOg9r3sAMjSUBVNjfaZPixwz8gOAPZ8v
	 0SMUu5wd9Ms+A==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id B6CC488770;
 Tue, 15 Oct 2024 18:08:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729008531;
 bh=uJnNyvxc9iX213xqNEfkSY/CRizN+Q5AvquekKgQ0t0=;
 h=From:To:Cc:Subject:Date:From;
 b=MeCdL/nHICGYhUnGQOYxDr5f6OoxUQLVcNfYKAw+OAFNk2KYxjYz1NRKhQj2MQhgC
 2stppyPVrD3r7+sgRL0Z9YXXA6SFYEvVT1Oz98DQh9KXptmobnmvWiB8Ic8BVSMCG8
 1hZ6ZlkRMnPAo4QKH6MFF2jQZjPkzK3VTvJO7lxYMmZ39IlDDaeOkJwrjQLabs5BKp
 KLhJIrAL7NNsgudfnNHS2++KzTs8BIJValBChy33YXYzIOGg2gMMd6FYQH+WTYPkRV
 Ye7omXBO16qFdKYKWVtcl9gq18yUEFH4yIRzAWV6rkabMT+Go3y4THuqVb5FVrKFCp
 sBpyxK2+YRL+g==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>, Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Godfrey Mwangi <godmwan@microsoft.com>
Subject: [PULL] u-boot-usb/master
Date: Tue, 15 Oct 2024 18:08:24 +0200
Message-ID: <20241015160834.11017-1-marex@denx.de>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The following changes since commit c7aafb20ce9937f1e178ded46d8f22742f54c982:

  Merge tag 'u-boot-ufs-next-20241014' of https://source.denx.de/u-boot/custodians/u-boot-ufs (2024-10-14 08:15:15 -0600)

are available in the Git repository at:

  git://source.denx.de/u-boot-usb.git master

for you to fetch changes up to 3794bbf9e0e7ce2652935514cbfac49545c329a9:

  usb: xhci: Define 'XHCI_MAX_HALT_USEC' macro only once (2024-10-14 22:17:51 +0200)

----------------------------------------------------------------
Bhupesh Sharma (1):
      usb: xhci: Define 'XHCI_MAX_HALT_USEC' macro only once

Godfrey Mwangi (1):
      usb: xhci: pet watchdog during transfers

 drivers/usb/host/xhci-ring.c | 3 +++
 include/usb/xhci.h           | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)
