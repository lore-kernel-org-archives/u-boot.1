Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2494C3DA42
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 15:13:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3608C8876E;
	Wed, 17 Jul 2024 17:13:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="RtzLSpTq";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="TeUaF74Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AA2788756; Wed, 17 Jul 2024 17:13:12 +0200 (CEST)
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com
 [103.168.172.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7452188464
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 17:13:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute8.internal (compute8.nyi.internal [10.202.2.227])
 by mailfout.nyi.internal (Postfix) with ESMTP id 8512013800ED;
 Wed, 17 Jul 2024 11:13:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute8.internal (MEProxy); Wed, 17 Jul 2024 11:13:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm3; t=1721229187; x=1721315587; bh=rd
 eP5oljFB0kYMqH8aFqVuvSN2vWi5nj1jFYZgug5/o=; b=RtzLSpTqnZLketGPpw
 C0Wrj4PMbTzHguNLPyHxgzAIiEFNkYrWa67qmO7no7F54pScPABTG6LTIL0YFH55
 7F4Dlz5Sdea5URTb3J4q5g87ZTKgH9MW4ub/Gxb0GtN8BPEd2ATlf96qML9rZfu1
 4k6N/RYjjGb1DwiItKCHFub3P7jXv7tp7Huh/CHT00C5Gc2IkULyoElUz/GUH9Re
 eGnNcx3Q5RKLG1XXRy8YVP7oWbmo0BjeKO+vCUzgbF740F74QMXU6PWr8kM1A6s1
 WVTfOg2nhiOYcNqguveieZRYl8UqKjUfo/SoWTSpGoyry/7GpW+Wn1PgLAqC7I0q
 cPdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm2; t=1721229187; x=1721315587; bh=rdeP5oljFB0kY
 MqH8aFqVuvSN2vWi5nj1jFYZgug5/o=; b=TeUaF74QPTvPgNhKx0EFsLck8LfGy
 6kkcAMqR/Vb+VwpGqR80ftoboRXf7vAKe8mAet4LnuvPIvxEbO3T8QrH+b2SH+Jk
 c2DQEcge04NaXJxUlaFJx4jB4bkb5RrT73faAJ0e6QpAilfrZ7bTQPh6y2CPz2Di
 twVbZZcc7hW3B/2voEZZLxgMVHr9UJxG+uYvyoPWOwL76BbIFUS+a6t1W9rtB808
 xAX3S8fBP6yvh3J8IeVuSmF3qs2PsjPkZD7HW6L0H26oHHweh1pBfwVvt+Y2bLjn
 Bp+ZQINIZgzr9KFD9dzeW6/To+XMcDdmKn9ea3GWp5Jd8oiYfcAROD2Ww==
X-ME-Sender: <xms:gt-XZu4KpNLu-5s-Ogu7M00sr_OzzM0f_l8eJXgxrc8OXBL08UM_Cg>
 <xme:gt-XZn6XCNFpaTxCQH2f0A9UtfLNOwAOitlgENJyuR3LQEHOBuWRfKTipHGmq-XlJ
 SuHXHAYGauUgLBAMz8>
X-ME-Received: <xmr:gt-XZtcMTJyKG5ZBk600UpBlegkjtB0c8H4Z6s0DQ_RFoC4VA6XpTSr_BfQ9MzxG34F6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeeigdekhecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhfffugggtgffkvfevofesthejredtredtjeenucfhrhhomheplfhirgiguhhn
 ucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenucggtf
 frrghtthgvrhhnpefhffegjefgjeeiuefggfdugedvkeffveegueetteegjeevieetieev
 vdffheelgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
 iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhl
 hihgohgrthdrtghomh
X-ME-Proxy: <xmx:gt-XZrINAm2ArJ7-msSNuTsIrgG_q0YTm3bq2wtMA98H86TJ5r5KmQ>
 <xmx:gt-XZiKFiXqNgh0FYu6wxMKNy-P6GSQwsUIOcO76L_s8vn0ORpMiZA>
 <xmx:gt-XZszXaHJUCunGCLMMDIqxqaZXF3YKi0FoIeamXBPs98Wk7pldow>
 <xmx:gt-XZmK7MjM3r4ZT_kJFQ4MepHsNkEbY-6uROzotkwfkJ4dqrJfvWQ>
 <xmx:g9-XZu3qr6cASUwWsjM6SMumSXh96jMbRvl61DqXCksMl81N6IC0JKar>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jul 2024 11:13:04 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 17 Jul 2024 23:12:59 +0800
Subject: [PATCH] b4-config: configure `b4` for U-Boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240717-b4-config-v1-1-0bc9e80ef582@flygoat.com>
X-B4-Tracking: v=1; b=H4sIAHrfl2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDc0Nz3SQT3eT8vLTMdN1EIDcp0dTQ0sDMRAmovqAoNS2zAmxWdGxtLQC
 lfPFsWwAAAA==
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=989;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=t8Rpd8TIlcaV45MqUTroV1FpvwD0DuiKQ1qa90ZQT3c=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTp9xs0zDr9T9vc+7cgXjm2QOT4xw2/L4nWRYgrKnlf9
 9LdEnS0o5SFQYyLQVZMkSVEQKlvQ+PFBdcfZP2BmcPKBDKEgYtTAC6yleF/VKJ2y8W1FYLfF59S
 XuweFbd68c5NazepLNb0jrBjnX9VmeG/v/HN+99tj270OtzAl7v4XuCsm6q6q59Jr6pVlOQ61/e
 DFwA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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

`b4` is a commandline tool to make patch-based development easier[1]

Provide a .b4-config file to match U-Boot's patch preference so it will
be easier for people to use b4 with U-Boot development.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
Do we want to disable git for get_maintainer.pl in auto-cc-cmd to prevent
annoying people? Please advice!

Thanks
---
 .b4-config | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/.b4-config b/.b4-config
new file mode 100644
index 000000000000..6ba10cf9b50e
--- /dev/null
+++ b/.b4-config
@@ -0,0 +1,7 @@
+# Configuration for the `b4` tool
+# See https://b4.docs.kernel.org/en/latest/config.html
+
+[b4]
+    send-series-to = u-boot@lists.denx.de
+    send-auto-to-cmd = echo ""
+    send-auto-cc-cmd = scripts/get_maintainer.pl

---
base-commit: 902d8ee94ce29a088a325da6e69eeb1a25f1fec7
change-id: 20240717-b4-config-a717ba519064

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>

