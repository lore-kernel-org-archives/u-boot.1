Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECD0606A32E
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 16:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QTLMKEPj;
	dkim=pass (2048-bit key, unprotected) header.d=freemyipod.org header.i=@freemyipod.org header.a=rsa-sha256 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=elfIu//J;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh header.b=ogkpmmD5
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0E1CB4096E;
	Sat, 14 Nov 2026 16:21:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 30jnjz6lCUBO; Sat, 14 Nov 2026 16:21:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 666DA40945
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794673315;
	b=m1LzEW6+Hm4R42lCWK89nOUdHBg23gXSMu5lRRv7uHZy7eYSDMo+ZrsyUXOB1dD80BJh
	 YeMFihjT+bRwNPydwjqSlv7q6eIfKrlTBtHTBcMft0LKGANgeoQXY9mkBFUypLStfVAwg
	 G8o0k2Hno4qSZAMdcZfv0EqgveiaSgvMQzg+bzI6ip2Lqgt/sff0NjEQ7HCx5Yctz8mRO
	 Ca8mLXhiX3JLRAr6DQ7TVG5w/WiKznOzX6tA9nHsTxDxSQkF1eAMrV83pIUZ/MnkgN9S6
	 sS68Jfj7gnlgGHSSpIGo+DAmpj3VT7JOv5sG/6XLVQEcsr93q+uGx+CYaY32F+MQYCg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794673315;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-ID:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 Feedback-ID:X-SES-Outgoing:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=QSST0eqWWY/mpBPupbIuaq3wINCsaIlBGCOmb66Cu6g=;
	b=EbIVb4dIe+WPJ/7jTR4oZWW7k8wtYbwCgFyWGWgWqwvjy8J3tIEPbRczChkT0JDohir8
	 X/7z90apXB04qMRpBN2xSIRHGKX5IBL2wlq8L/x1s7gDOlWzYEFw9wIoug50+E/5JAOWE
	 HqolpPhyZEdW10BktusG4IcmA2B6hcTzLF40NwvWW5G4vopyNB5ggMNJtvwh0+PaPB+Q8
	 8Ou7FE0U7xGwurBZd1c5xnAL9fW5iBSm1JNdtqCDoRucVSx+kihMloYWoAnB4se7fQG3c
	 xV3w+QC4iWbtv0fkcbXtYg+JomoaeVU0TshAvi+foKytdtIauL2e9JCYMEu2y/n7R4Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=freemyipod.org;
	dkim=pass header.d=freemyipod.org header.i=@freemyipod.org header.a=rsa-sha256 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b="elfIu//J";
	dkim=pass header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh header.b=ogkpmmD5;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794673315;
	bh=QSST0eqWWY/mpBPupbIuaq3wINCsaIlBGCOmb66Cu6g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QTLMKEPj5EEZtxw7VD9fq/JCTN/wfWPenJ3e5icOEPO8fO3OVri+DQxWRoN1w03sR
	 W+VwSBsuTrXKS1vft+TychXYF7RgCa7R0Q8rV41Yggy+SLd+xiqFIINeXTF2Qmm0Q4
	 IT0aI6ki8MlvC7cZyZxL7hNdFhiPlC3+btJwbazFIkZy1AbXUTF3MT/eIlks6I+EMK
	 PObFOFvOoT+8GwX+byHFswIec3FoEobFXeLkw82p0l52mQgOKtx857h+RQptYl5xI4
	 JBIdHs2rwO9j044L/kJEaNs8Rfl7a79wZrlA05vHp/LH/NBKHZmSe3nOyBto1pSGrM
	 KKqPgcr33LR2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 666DA40945;
	Sat, 14 Nov 2026 16:21:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 78C9B28C
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 16:21:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6A57840807
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 16:21:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NpQgC7BwhMyl for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 16:21:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6AB66407E4
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=69.169.224.12
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=69.169.224.12;
 helo=b224-12.smtp-out.eu-central-1.amazonses.com;
 envelope-from=010701a1dadd6861-f09db4c3-c003-4808-8f44-a03b868ed957-000000@ses.freemyipod.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=freemyipod.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=freemyipod.org
 header.i=@freemyipod.org header.a=rsa-sha256
 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=elfIu//J; 
 dkim=pass (1024-bit key,
 unprotected) header.d=amazonses.com header.i=@amazonses.com
 header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh
 header.b=ogkpmmD5
Received: from b224-12.smtp-out.eu-central-1.amazonses.com
 (b224-12.smtp-out.eu-central-1.amazonses.com [69.169.224.12])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6AB66407E4
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 16:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz; d=freemyipod.org; t=1794673305;
 h=From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc;
 bh=phFv8zBd2ivmrWDtmUeC3ViXAzXHcBYxAdwrg9QZdUk=;
 b=elfIu//Jm6hfQ3xRtTuFXniCr6x9dNHFtQNXdX2GoycF9SO/k5FWz4uQQR++ShUz
 0Bk76fch3oTkqaRCb2KUyIqkY9E94RZ6/L1LuXrHJBpksTrthMCt+keU0csoudqMpcK
 CnS6xRGIzhkamaKFpw4wgiJa+rrp2zRngECKXd0QnTf4V5YjuKF1fQTS5PiG3R9Xe+k
 Li/iXdIrSZFM+Ck5bogi2vI53TDDmzpYDZHK5PRwQdT0EmLZT9SqVDkfIcY9epvELqu
 Y7fKvuJWc0UbLmL02+51tZ4lJf2eQ7Gg9goCn2lKKYf7N0lm6x6XbIJe77kzOWmUntK
 ggfwc2I8SQ==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh; d=amazonses.com; t=1794673305;
 h=From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:Feedback-ID;
 bh=phFv8zBd2ivmrWDtmUeC3ViXAzXHcBYxAdwrg9QZdUk=;
 b=ogkpmmD5WelqkAXakZiIH4wDwpw6Z5dR3gML5SuzN0NEtpCxDmBSjs0wlbBkbTSk
 p0eKZ0NwT51AdMdDdi9pIOZZONs0LLGHQapguis6TXUVguxkRKvHXeH+aAPixhN8aKF
 RqitIEtTQvUFvvrGAJuK8NtJhfZjxVhmQ3nkIDts=
From: Vencislav Atanasov <user890104@freemyipod.org>
Date: Sat, 14 Nov 2026 16:21:45 +0000
Subject: [PATCH v3 04/13] New SoC platform: S5L87xx
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <010701a1dadd6861-f09db4c3-c003-4808-8f44-a03b868ed957-000000@eu-central-1.amazonses.com>
References: <20261114-s5l87xx-v2-v3-0-083bd20d8ded@freemyipod.org>
In-Reply-To: <20261114-s5l87xx-v2-v3-0-083bd20d8ded@freemyipod.org>
To: u-boot@lists.u-boot-project.org, Janne Grunau <j@jannau.net>
Cc: Vencislav Atanasov <user890104@freemyipod.org>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, Johan Jonker <jbx6244@gmail.com>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marex@nabladev.com>, Michal Simek <michal.simek@amd.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Honbo He <hehongbo918@gmail.com>, Samuel Holland <samuel@sholland.org>, 
 Mark Kettenis <kettenis@openbsd.org>, 
 Stefan Roese <stefan.roese@mailbox.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794673300; l=834;
 i=user890104@freemyipod.org; s=20261004; h=from:subject:message-id;
 bh=phFv8zBd2ivmrWDtmUeC3ViXAzXHcBYxAdwrg9QZdUk=;
 b=l50uOHQAz/nlbXT2ItkYAXECpZJvv5qJhDynkxj/c03Q2ekX+dcVNWHy8KbiFQwuC3MH/tTGg
 HHrnOjvR5+TA7UD6wmA8VMVgH/c4xcPh7qSLiIwkQlkOKI9x6Ka1m2l
X-Developer-Key: i=user890104@freemyipod.org; a=ed25519;
 pk=klj5EgxMkX+YF0tPboUEB9kwBfthBgHWLhDOkwnmUus=
Feedback-ID: ::1.eu-central-1.GZFSN+SpSZlcZgoCjFtpLsnhzRcxifcxl4uaxXIRIUo=:AmazonSES
X-SES-Outgoing: 2026.11.14-69.169.224.12
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a Kconfig entry for S5L87xx so that it can be referenced later.

Signed-off-by: Vencislav Atanasov <user890104@freemyipod.org>
---
 arch/arm/Kconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4b05a4d561b..aec410811ab 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -746,6 +746,16 @@ config TARGET_BCMNS3
 	  ARMv8 Cortex-A72 processors targeting a broad range of networking
 	  applications.
 
+config ARCH_S5L87XX
+	bool "Samsung S5L87xx"
+	select DM
+	select DM_GPIO
+	select DM_SERIAL
+	imply CMD_DM
+	help
+	  Support for Samsung S5L87xx SoCs. They are used in the Apple iPod nano,
+	  iPod classic and iPod touch series. All CPU cores are 32-bit ARM.
+
 config ARCH_EXYNOS
 	bool "Samsung EXYNOS"
 	select DM

-- 
Git-157)

