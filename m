Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A22BFCD98F2
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 17:14:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1C3080287;
	Thu, 18 Jun 2026 19:14:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="XB+qAZQO";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="U/+pB6J/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDFF38056B; Thu, 18 Jun 2026 19:14:07 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9003C8005D
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 19:14:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+usb@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gh6lJ1Xgnz9vCX;
 Thu, 18 Jun 2026 19:14:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781802844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=nJFdXMJMo5jYeq8bieFSJUqaznLAIfHIBPP6UTKAoZk=;
 b=XB+qAZQOsdlh7yS0nmLpoLk/nv91N1LR13XkZA6ao/ZpWnEUAJPsPWHVRlLClrFzv4PPO0
 jqgvYyuXc+SRWlVqBU0oUE4Cb1pe1ZISojcZnQky5g7bYghAdOlA45UeYITd7f+W28udvA
 6LbN//fIAbFODHblUZmVV8F4rZidyXnqDVcPC6N7MGGFGI6BMsc0J4S7QQcG9UIKdJMOdJ
 BgGVEgOXCxTcYg1nyMoqoVgeAY+Y2y9j6ESnpFNyl6QLBEF9XhlbnFlAcyzz1sJ5Gsnwx9
 j+QiTcre671O7j3wZTd6df0nDrVeZGnZOAUYYSKau73h2FviPGTSuh8fTBIjcg==
From: Marek Vasut <marek.vasut+usb@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781802842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=nJFdXMJMo5jYeq8bieFSJUqaznLAIfHIBPP6UTKAoZk=;
 b=U/+pB6J/e6wIfNE1xqdjyn5Rv0ylmGprExVp10QzHO+qrj84/UvRQTJhu9eeBdzb3gaBW9
 Sdncv2ERYDo0DpFvH+EcpXX9uWpVhrxlmUlFSEG1S70m/RHsGbWNykSuBQdi03gcWzqd8R
 aYwLw5hDy8DqXf4mM3EMSXAjunM/EWoiEHQ5NN6R1VgEbRJpcd5Bz6G7mVQIECj5q5KcKY
 FyorByA4tZTnWEaFy3T7dIZHL7zsCbp1o9KG4IU0qXR2U3b+8g2Jdf8JgWIMZW/kKwZuOT
 z+Mg81pPbHukKBHgz0MC++tMPVUIHu75KiREd1JXj+jQDDXNX5EPHW7De8Pwog==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>,
	Peng Fan <peng.fan@nxp.com>
Subject: [PULL] u-boot-usb/master
Date: Thu, 18 Jun 2026 19:13:41 +0200
Message-ID: <20260618171352.23873-1-marek.vasut+usb@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: db3c5fefb53f0ebfd63
X-MBO-RS-META: zndb84dujtrtui3zyios7wf1xqrzur3u
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

The following changes since commit a7830e87555abfb81cc69275cecb2bc0fbde5b28:

  Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-sh (2026-06-16 17:39:13 -0600)

are available in the Git repository at:

  git://source.denx.de/u-boot-usb.git master

for you to fetch changes up to 78d5f8cb50090a2888df284564f43f4ebfbf663c:

  usb: tcpm: fix inverted poll condition in tcpm_pd_transmit() (2026-06-18 16:48:16 +0200)

----------------------------------------------------------------
Peng Fan (1):
      usb: tcpm: fix inverted poll condition in tcpm_pd_transmit()

 drivers/usb/tcpm/tcpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
