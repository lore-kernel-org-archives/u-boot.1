Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B3CC61DC7
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 19:54:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 573B780F1D;
	Thu, 27 Aug 2026 19:54:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KulQcOg2_-p4; Thu, 27 Aug 2026 19:54:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787860468;
	bh=fTnKgS/H8x8pN4AfRgO4cy5AcQvFlAp5t+33DL/het8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L1cQpM31vVoSaCoUd91uddSK81LjZ0sAZa/JyYJbP+cQ/PP2bCKGZ9vIXEiYnP6ou
	 5UnG1BpmGYaUa/Or/tZju9I0W5O5rf9FH29K0qltg/e8zYj3aheJAIWNn/JDkOGO4W
	 SJTosrCFbSb2M0fDIhJYmE6jYbyyCOOvqdY130RefSwjxwNO6rmM3eJMcEn6o+d934
	 vWq81KyRF9mpXxob0wd7WJQRw22zMhL3We4W6B26labd6HJvBl70iiUioA8VsajdUS
	 9wFHoG3yMEb24eTMm83pchlY8AQcR+tUaGIA/xNLnVXlevfzDTQSMypSSyBD4nZaDK
	 nmb17ru85ZrIA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A1C1D80EEE;
	Thu, 27 Aug 2026 19:54:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 87D2975
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:54:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 697E240843
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:54:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZsOeawsv7tb8 for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 19:54:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=83.166.143.171;
 helo=smtp-8fab.mail.infomaniak.ch; envelope-from=foss+uboot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=neuIDQTq
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch
 [83.166.143.171])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5AB094084E
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:54:12 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hWBzh6Kbpz1FR;
 Thu, 27 Aug 2026 21:54:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1787860448;
 bh=fTnKgS/H8x8pN4AfRgO4cy5AcQvFlAp5t+33DL/het8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=neuIDQTqH7j8pWthYtllQS+eqdKU8E5/6pd4vzbgSoB/fF/MulGxF3/K5+317bk72
 jTDdOHy5FKZCd/hzqV45XqpJ0XYCupsJZmqjaQHAIM6mE67COnlIKsDYCyPet+9Fet
 FOjJ/3eHRQZG80eBofm2u+AVWKyOQIenWW7IyGAMQrfyKzUdL+XK47vKVt0v9sWAAd
 GmFTtP2y5kQcyzcmaKHRX2sZ7vPlUQD0Iq6wcemDqMBOIAo06/80HD2iXENFCEu9VC
 T6n1VbvjladaOHueoKD6qUBY+qD7QZP5fYu3TWGoR81vEREpbPdxy3uJdOGnKqmtdi
 LoGAw8z8n+uUA==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hWBzg1MYjzRKC; Thu, 27 Aug 2026 21:54:07 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
To: u-boot@lists.u-boot-project.org,
	u-boot-amlogic@groups.io
Cc: uboot-imx@nxp.com, trini@konsulko.com, sjg@chromium.org,
 neil.armstrong@linaro.org, marek.vasut+renesas@mailbox.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, adeep@lexina.in,
 sbabic@nabladev.com, festevam@gmail.com, smoch@web.de,
 alpernebiyasak@gmail.com, le.jin@siemens.com, jan.kiszka@siemens.com,
 iwamatsu@nigauri.org, pbrobinson@gmail.com, seanga2@gmail.com,
 bmeng.cn@gmail.com, lukma@denx.de, mkorpershoek@kernel.org,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH 40/45] doc: develop/sending_patches: remove mention to the
 test mailing list
Date: Thu, 27 Aug 2026 21:53:08 +0200
Message-ID: <20260827195313.129994-19-foss+uboot@0leil.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
References: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

We don't have one on the new mailman and Tom said[1] it was so rarely
used it doesn't make sense for now to set up one on the new mailman,
thus drop it.

[1] https://libera.catirclogs.org/u-boot/2026-08-25#40371346;
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/develop/sending_patches.rst | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/doc/develop/sending_patches.rst b/doc/develop/sending_patches.rst
index a1e80eaff14c..ca30c6dde1b6 100644
--- a/doc/develop/sending_patches.rst
+++ b/doc/develop/sending_patches.rst
@@ -142,10 +142,6 @@ General Patch Submission Rules
   like wrapping of longer lines etc.
   The best way to send patches is by not using your regular mail tool, but by
   using either ``git send-email`` or the ``git imap-send`` command instead.
-  If you believe you need to use a mailing list for testing (instead of any
-  regular mail address you own), we have a special test list for such purposes.
-  It would be best to subscribe to the list for the duration of your tests to
-  avoid repeated moderation - see https://lists.u-boot-project.org/listinfo/test
 
 * Choose a meaningful Subject: - keep in mind that the Subject will also be
   visible as headline of your commit message. Make sure the subject does not
