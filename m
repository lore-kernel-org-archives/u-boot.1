Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2535CDE001
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 14:26:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50CB9847C8;
	Thu, 25 Jun 2026 16:26:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="gvF4iSDw";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Rnh34syn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F1CA847C8; Thu, 25 Jun 2026 16:26:39 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED11084704
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 16:26:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+usb@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gmLhr5ZRMz9tqT;
 Thu, 25 Jun 2026 16:26:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1782397596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=rm4biqpOrLOguwwCvhyE31x86AOvEOAosdjdL5svPVg=;
 b=gvF4iSDwYKbhaPPJs+l0RCSnM+Tj6TAd0u7o30/Hqb9ylJTdUgd7UNzn9Ihpj7WHhkSlwH
 qTD7SzqCmDQvLkjctNduAPGwDV32G+6XFuoNcPJfLw97o2rz0P3rKqK6I711F5Zpl3dzDG
 plAzX/En6i3/RWojp+iYOtNZfGEd0LTjO+GJdJuACWNazzupXR7N+E9PSCorhfYjmrRSyW
 PqTekKjQ9/oacY3aj5X2D44M4vuk/kJIidk+S4Ase7XMdtYYHrQ/swgZrQESqa8L0YDgfm
 BrJ+FxfdlBI2oMd8O0bZ6LxYqD1ZicZjzs7lpNl92wg6sQTzF5+QWkQixhcsIg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=Rnh34syn;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+usb@mailbox.org designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut+usb@mailbox.org
From: Marek Vasut <marek.vasut+usb@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1782397595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=rm4biqpOrLOguwwCvhyE31x86AOvEOAosdjdL5svPVg=;
 b=Rnh34synhd8qBl4PvuqNTG1RwGQKBL57+Y/J4IXocZlroats2y4E8oDygPjfaPlppZ8/Li
 gQG0PAh41dR0MyAtQm65LS4lvoQhKE+6kdpmIRtTv7iRDYkOSyRGsWhUDcilEbNcDEnLo6
 jo7VY8LeDEoVMNdhcdY0PSnJLWb+X30zCv55TsVKxDBI3DunAGvG0xQEjwHNk0jVztGqdS
 2ulsl5fRIAmfc0HfeW+iwRhLYLYSRZI5wr9P901vZrDgKGlamPnWJB+EdS0tqyiE8S70GO
 /iITAX4eQqUZW/SIX7LnvkSwkrtD6Xz+TnXziwidfGNy+0VQzYplGB12X3/9pg==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>,
 Alexey Charkov <alchark@flipper.net>
Subject: [PULL] u-boot-usb/master
Date: Thu, 25 Jun 2026 16:26:13 +0200
Message-ID: <20260625142625.18375-1-marek.vasut+usb@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 1zybqckbtmffdbso9xuwf3oupcg5jk4q
X-MBO-RS-ID: af2c3ed7791e925547c
X-Rspamd-Queue-Id: 4gmLhr5ZRMz9tqT
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

The following changes since commit fcda974e36033ad5331a9b4a4a551af4e141ad7d:

  arm: aspeed: Fix AST2600 SPL external DTB alignment (2026-06-23 10:41:25 -0600)

are available in the Git repository at:

  git://source.denx.de/u-boot-usb.git master

for you to fetch changes up to f519a74a32b076e548f2637e9a00b8d3110d8bfe:

  usb: onboard-hub: Add support for Corechips SL6341 USB 2.0/3.0 hub controller (2026-06-25 00:06:47 +0200)

----------------------------------------------------------------
Alexey Charkov (1):
      usb: onboard-hub: Add support for Corechips SL6341 USB 2.0/3.0 hub controller

 common/usb_onboard_hub.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)
