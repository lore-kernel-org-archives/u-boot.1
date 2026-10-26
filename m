Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D54606A31B
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 22:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=r6OFQgO7;
	dkim=pass (2048-bit key, unprotected) header.d=freemyipod.org header.i=@freemyipod.org header.a=rsa-sha256 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=qJ0twzUF;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh header.b=X+r5lXuU
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9AF1D6073F;
	Mon, 26 Oct 2026 22:55:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id msIpDIhDC1rG; Mon, 26 Oct 2026 22:55:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 925DF60623
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793055320;
	b=h7DYS9/ZwVKPrVZFtWo2EjtlFtzoEBGVAdmbEcV7NbtNo+NcEOokDkP1Nsif9iO/edsU
	 Xdcn9HAzsiukQYrnxNQfsBmmwcdUSq49L62wrryFWzmiYWeDydgabqt8ETTzQAQyaPFLU
	 LOkAjz42mQ6Q/COrBC3mX01PvzvGmPNUFCY7B3kyrYyop257naI12IrUyL3soWBmTUPSu
	 APRqVGtEOUdvoWB0hLbktfN67hFlUwsUK2+e6GFaNfnkDdvdL0Mi7eLXrVZ7t4eWycj54
	 H4TefNaCRcbKj3F0J1j2jKmcmbjX43yfaEXlOqMqhotT8steqkcAJ83qVUH5mUPZyfg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793055320;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-ID:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 Feedback-ID:X-SES-Outgoing:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Vyi82xDzLbWmiArsDvxfJpLj9YFG/l4o602rC1DZn8U=;
	b=BViJOtvDtLhFNus1NAdWskYqNT7PQNsu9dGa1GVmW5+hpfLMbAcTbsvSNlpSUDcSaPfv
	 xnOx6Sf6noF6U5/7YcptBwWAD2R3hhxYFhljMk5KfeUk4D/3/w3oEZiJVL4Zqx2sj6fQ5
	 nV9z8iJcDp3s5hg1QZlOkQOPO9KsNPnVsbN7vL7SVb007Q52ldMoG9OCaXP2MNLCbrl03
	 nOs/BrvJS/yuIP2pAXo+qgowgBLCw3MmflOZYHwHYbAHSOibYdXRc5YQ4L7TzLQZI5Vqc
	 NcPBqJtgCNKU9jkx4pdOynp5r5Efbchwy8k2h0mjKe7nGmGrsaFZPQE6mmCzwjE3p1A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793055320;
	bh=Vyi82xDzLbWmiArsDvxfJpLj9YFG/l4o602rC1DZn8U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r6OFQgO7yfPw761QEGXmQsD0FSP/OSRdzYUO9//44j61m5lonSfvq7nv9tUoNp1r/
	 KxfDUwow/1QO/0D6Wv5W03fsH1FW9yCfDyBmyDq6Lc6vHbfx0lUE3zQfpZ6p2eT9r7
	 i+/dVjGaH8DhG5P3jwyxTh5otA8TC3Wv0AhxJ9gXNrYNn7zPxBkYFe0ANYXxleiOXa
	 0VlBbYtgZMG1rUD5BGOBugNlTU+B3yv1bQpc27AxkticKsmFpmlvDpEt/JuTg3EsOV
	 xX4ZX/BuqpVce+A7q7F8kMbOcW2GcZTG9uXhsE1HKmUBlxFxOiMN+UU7WdmnK5bpt9
	 UsQrfCf2UDVmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 925DF60623;
	Mon, 26 Oct 2026 22:55:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id F1F1A120
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 22:55:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D78D640505
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 22:55:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id llsFqZzzhXHm for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 22:55:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B55FB404F8
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=69.169.224.7
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793055309;
 b=NTSabpw9G6F2gIo9mRJYuwAIlnXTCX0FagC8RNjmNF+qvMhGZI2lm0pY6DU0wwaFd/aC
 l6P8p+QLM57G85B70UdRTwMpekmPqXg8rNF+JTEOIZ4aIxhyr6YbvvkEo2ait09+6xp1h
 qWfNccthB2BLthhek9mvpSQ8D1O+skKqj/XJeLUM1V0tjpvp5zPqH8sbJCNPSkv8SBwfq
 gWTc9j+vJBVciaO6dBhPeHZyVYx7V0/cw7HfxkLvs619tCd3IUqGk1GuZ71XettM/eHgW
 F9xqtx68pQdvPbIqeCxjKCgs4chRLYAW1k4KsNlHBHdeN1hQA0LYS5CQnxi/dzwG/mA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793055309;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:Feedback-ID:X-SES-Outgoing;
 bh=Vyi82xDzLbWmiArsDvxfJpLj9YFG/l4o602rC1DZn8U=;
 b=SKRLb8iq4DWRe9NtQg5YAKUW7V8X6TqRjYIr4SncgccB5R9ldUTRkGJ3UZI/BT8voeUF
 UOFp8E9NzMGIvnroQLKMoC2GPVQ3uGaAqMxIsX30EhiHWnbYlhyDvRpfsQjp+mWXQwz96
 4ke5HhUvv08lQzp3pP5vT/zwf0YISjjJ7nKJVOrHVcOv3mIDq7IiHaWRGs90nvlIiyStQ
 SSRrOQv8iFFm/59a7chJk7qjMDtYQg9VmUOMIqGzfQkjfnV2c764wg/+uhbw61c1i4bil
 HEx1EuMkRTdlAawHcNZvXqp1SH+6XpVmu2atrQrfK4JKmnsilG33igeTmCX9SsNtPVQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=freemyipod.org;
 dkim=pass header.d=freemyipod.org header.i=@freemyipod.org header.a=rsa-sha256
 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=qJ0twzUF; 
 dkim=pass header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256
 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh header.b=X+r5lXuU; 
 arc=none smtp.remote-ip=69.169.224.7
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=69.169.224.7;
 helo=b224-7.smtp-out.eu-central-1.amazonses.com;
 envelope-from=010701a17a6cb0f1-422145ed-f771-4988-b4c6-fe3e63706fe6-000000@ses.freemyipod.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=freemyipod.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=freemyipod.org
 header.i=@freemyipod.org header.a=rsa-sha256
 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=qJ0twzUF; 
 dkim=pass (1024-bit key,
 unprotected) header.d=amazonses.com header.i=@amazonses.com
 header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh
 header.b=X+r5lXuU
Received: from b224-7.smtp-out.eu-central-1.amazonses.com
 (b224-7.smtp-out.eu-central-1.amazonses.com [69.169.224.7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B55FB404F8
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 22:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz; d=freemyipod.org; t=1793055306;
 h=From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc;
 bh=p+bkyw21oC6SmTxtqQUzLPYtaigkK3O3OWcn721SIU0=;
 b=qJ0twzUF9ksdojvPMsCY8crQhrEFxOX3CApD82cmw/WHrg0rCiCbPsmz3Fei0D2d
 Ck0wFkzAX+tNjuFVD43Nepal+BAMoUCbbZwkr73FY3i0LUStNmnXT9qfpj7wOifnHrw
 hxn1aM/ZtiPf0nOhlTKlTXfUfNpqANF4AZtL5qj2Yd92hUMbsSx/lGRPHJJ6CMYkOhu
 Wauor3W23IW/CyIcrcsVIdnzFZ/HlPTSROeouWrt2UkxunTGFq/km98PqpvU4nB9JyA
 jkyF2eaFaeFWf1xHHbL1l5lNTm5Lw4EuNxTDmNjuQcPB36wsu8aQ3GUoLrMHDJsiUHP
 fm7IrJRo/w==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh; d=amazonses.com; t=1793055306;
 h=From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:Feedback-ID;
 bh=p+bkyw21oC6SmTxtqQUzLPYtaigkK3O3OWcn721SIU0=;
 b=X+r5lXuUFv8TUeIsVde4Z798PE0WarF5tczT9Vp5hGwpMnKWeci2TiwsqQGOVJqz
 EqEHzEi+MXYvbwEnSO+/lwt9dU8a/YNCkenYV4hgmAQfM8ZMUDsSgJah7w+gYO4bboo
 3MDNGqiz4BMKhjK6HuoWtfcpGivF06EmXVmEOzGE=
From: Vencislav Atanasov <user890104@freemyipod.org>
Date: Mon, 26 Oct 2026 22:55:05 +0000
Subject: [PATCH v2 05/14] New SoC platform: S5L87xx
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <010701a17a6cb0f1-422145ed-f771-4988-b4c6-fe3e63706fe6-000000@eu-central-1.amazonses.com>
References: <20261027-s5l87xx-v2-v2-0-1de63803510b@freemyipod.org>
In-Reply-To: <20261027-s5l87xx-v2-v2-0-1de63803510b@freemyipod.org>
To: u-boot@lists.u-boot-project.org, Janne Grunau <j@jannau.net>
Cc: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Vencislav Atanasov <user890104@freemyipod.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793055301; l=834;
 i=user890104@freemyipod.org; s=20261004; h=from:subject:message-id;
 bh=p+bkyw21oC6SmTxtqQUzLPYtaigkK3O3OWcn721SIU0=;
 b=dzvUYpaVLTlvN8WuiZjLLbv+UWXxc01vCr59djhUY+7vHkgQvIVjWSNlBOS74wl1egIW8AXnK
 7XITkGBVV5LDgxlAsbuUVuAmhKEx5/0NANdlSkyXUdum8hxmKAUeOAh
X-Developer-Key: i=user890104@freemyipod.org; a=ed25519;
 pk=klj5EgxMkX+YF0tPboUEB9kwBfthBgHWLhDOkwnmUus=
Feedback-ID: ::1.eu-central-1.GZFSN+SpSZlcZgoCjFtpLsnhzRcxifcxl4uaxXIRIUo=:AmazonSES
X-SES-Outgoing: 2026.10.26-69.169.224.7
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
index cfeec2a98cd..0029365eb89 100644
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

