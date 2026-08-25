Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 480A0C61DBD
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 17:00:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C81060741;
	Tue, 25 Aug 2026 17:00:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vT60mchdEh6g; Tue, 25 Aug 2026 17:00:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787677228;
	bh=dNXoSgF+0cCQv+ZE/WcIOX3Dewt8V3rqoRXdiiA1wSM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hD7b/Slr9yQFqBjm+jQRaSmDu88aDmrb7pb5adof6ho4zZ4ZiencvYP9onKzTd8he
	 K9auRy5GlDqThzMHbkXXAv0ZJf+CCyZUPSiqXcVM/roIoojqL92RkPDtTDZ2dLTaAa
	 JAB5Cu1j9qXxwr6Wf6183xCiP1eEMAX7RMRBifg9EMhs+s2dAXITB+ZkbzW6i8T11m
	 uF3tlRrnYKWMH8xUASwbBaFw0VojIT7K/kf2GX0baukpNLzv8ID7fqzO5SeFt5guGa
	 FMhp2JN7UO/R79lURUlJbW+ZJeokd8DKKFtwfNbX47W6sg9Kmxt0cHSLeuVZIUcjha
	 hNPtWe3PYjKoQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AEBDC6074D;
	Tue, 25 Aug 2026 17:00:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E0E7F3DA
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:00:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C6E8A6073E
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:00:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2URw7DwxukJl for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 17:00:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:5550::190c; helo=smtp-190c.mail.infomaniak.ch;
 envelope-from=foss+uboot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=ism10Z6u
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch
 [IPv6:2001:1600:19:5550::190c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 55AC060729
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:00:18 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hTv0W3c0CzkGn;
 Tue, 25 Aug 2026 18:50:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1787676619;
 bh=dNXoSgF+0cCQv+ZE/WcIOX3Dewt8V3rqoRXdiiA1wSM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=ism10Z6u0mZeGx98+oCvZJR2kBXAx9XmCXKOFFAqlzY13AeLhNvTEm6Kn+HCISZ9i
 9jVVjBav9yhrZpI9LA+N1+Ks39kcIPVwNDAodw5XqVw8uU/orePwnNxxPaLx6hHvQF
 Jj+igGyJi0Xl1PdqUHM+aI1iQzo1zceaW5TG6i18YEwxPqj0XkishJo7hBQsEGBqjS
 yFvqWD8M3gvYhB991/S2wgl22BjLYnPmLhZz68U0XFR3C2mvG6tckBJXaPqQa+lxPw
 umF9M0drkD7osGZt3D88lV5oMy3EiAMsbz8UcQjqMMtt7qM7+fYrIbyFXCCNAlaMNx
 nfTdemWSvVXPQ==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hTv0T6pSGzXMF; Tue, 25 Aug 2026 18:50:17 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 25 Aug 2026 18:49:47 +0200
Subject: [PATCH next 10/45] doc: arch/x86: manual_boot: update links to slides
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-linkcheck-v1-10-ee7573fe3a4a@cherry.de>
References: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
In-Reply-To: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
To: u-boot@lists.u-boot-project.org, u-boot-amlogic@groups.io, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Viacheslav Bocharov <adeep@lexina.in>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Soeren Moch <smoch@web.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Le Jin <le.jin@siemens.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Peter Robinson <pbrobinson@gmail.com>, Sean Anderson <seanga2@gmail.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

I'm assuming those are the appropriate links now. linuxfound.org
redirects to linuxfoundation.org. The WHOIS returns the same registrar
(1API GmbH). The Updated Date for linuxfoundation.org and linxfound.org
are 18min apart so I'm assuming they got renewed around the same time.
No guarantee it's the LF that's behind but that'll do for now.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/arch/x86/manual_boot.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/arch/x86/manual_boot.rst b/doc/arch/x86/manual_boot.rst
index 87ebda2e3dd4..649aceef6081 100644
--- a/doc/arch/x86/manual_boot.rst
+++ b/doc/arch/x86/manual_boot.rst
@@ -272,5 +272,5 @@ and change CONFIG_BOOTARGS value in configs/minnowmax_defconfig to::
    CONFIG_BOOTARGS="root=/dev/sda2 ro"
 
 .. _here: https://en.wikipedia.org/wiki/GUID_Partition_Table
-.. _this: http://events.linuxfoundation.org/sites/events/files/slides/chromeos_and_diy_vboot_0.pdf
-.. _that: http://events.linuxfoundation.org/sites/events/files/slides/elce-2014.pdf
+.. _this: http://events.static.linuxfound.org/sites/events/files/slides/chromeos_and_diy_vboot_0.pdf
+.. _that: http://events.static.linuxfound.org/sites/events/files/slides/elce-2014.pdf

-- 
2.55.0

