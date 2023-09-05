Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D10C83F33
	for <u-boot@archiver.kernel.org>; Tue,  5 Sep 2023 13:50:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 419B4869A4;
	Tue,  5 Sep 2023 15:50:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1693921828;
	bh=biJtdZIQJMMYA/USHg5e+nuze7erRAplCsR2ocfmq8A=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=T9GmycJxSjM2mWLMCXZEeynxWenxLebCk8hJIM2+VyKHHba2VidxnzB/ib07TqpLm
	 0TA1CJ8Fsj6OIFDNj5/v4y5mVB5t/SrI8mdQJ5on6AkJCgxsu7V5ASn0Qeick9lsdB
	 MM9rBkIR38ImHUtE0ngygmMYYOoa+0coMkneicSbzSyZSGl5cI1xZnGGCl48pn8SRh
	 oJolI3KsYQQzya41UyDZkxturw5HuNpeTsb1OogQ7XdEr2EqMOfDNuw1qtpQq/C3bj
	 mR4J1h9AhAXe5dfmqS7W0fEY4LecaskzQkyeQmoQZ6eHXce4L9dr0rXmq+Lg2eJKUJ
	 oW1LMiBQ+5p0w==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 84EAF86580;
 Tue,  5 Sep 2023 15:50:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1693921827;
 bh=biJtdZIQJMMYA/USHg5e+nuze7erRAplCsR2ocfmq8A=;
 h=From:To:Cc:Subject:Date:From;
 b=nmMKBd82GlRinVGl1srZhn538mar9YcBUyfvzZ6V5eM4UPECZiWgopijp9YYRfNDY
 qJmA/UnDuE+7iUaQ/ko4/nlCNHFoZW+Qt32nG/t/8D4XGzi4Qpw5UZUBdqxH7tkkOD
 w9e0l7eZdRcZc6/onrOrkZe3PDI7YxWz+l2dxbbJfFg6b7QP8/XjoBxGIfWnCEKlrH
 LGPvS/L5cmcguBUOshsn4ba4d1smqeFwVkEdnWqPC91l/r2QVwVAhCWvHYGRP1IR6t
 bMf/6CciapYu64CHOUa3/6Ozu1OPUs30ZyyQIf8mUxxhzhD1Qvxppz1O5r52QHJNdj
 sI+LUy1xkuuQA==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>
Subject: [PULL] u-boot-usb/next
Date: Tue,  5 Sep 2023 15:50:11 +0200
Message-Id: <20230905135011.15535-1-marex@denx.de>
X-Mailer: git-send-email 2.40.1
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

The following changes since commit f2bb6d9ffd9ba0d0d89c00445a70cf81327a7af2:

  Merge tag 'doc-next' of https://source.denx.de/u-boot/custodians/u-boot-efi into next (2023-09-02 09:08:34 -0400)

are available in the Git repository at:

  git://source.denx.de/u-boot-usb.git next

for you to fetch changes up to adee3ba577a6d5902b5af6c2368faf5f509003c6:

  usb: host: ohci-generic: Make usage of clock/reset bulk() API (2023-09-04 18:25:20 +0200)

----------------------------------------------------------------
Fabrice Gasnier (2):
      usb: check for companion controller in uclass
      usb: host: ohci-generic: Make usage of clock/reset bulk() API

 drivers/usb/host/ohci-generic.c | 92 +++++++++++++----------------------------
 drivers/usb/host/usb-uclass.c   | 36 ++++++++++++++++
 2 files changed, 65 insertions(+), 63 deletions(-)
