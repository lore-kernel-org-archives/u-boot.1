Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D1F606A31E
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 20:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=H4DPeq53;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rhAZos/W
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B840C6068B;
	Mon, 23 Nov 2026 20:06:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cbZySap_9wUm; Mon, 23 Nov 2026 20:06:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C6F2E60600
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795464367;
	b=qeq7DFhEyccoy3bM2I5tl2Lqe2OZzEfZA6oRkXge2OX+zjHR1SPNe5sSeYYZMapvny0l
	 gxIQYmOWVvXHVOjIg27K5xadi7zoLrQDJyR5yQdlnHM45KYPES1BoDNRi+WryCjPIfBju
	 d8PHkQ9YbizQncoqvJUnZj3hP7q9ecrTKrMS3+oHwPyWmltXOXI7xz+1F1CKa0wK16P4s
	 0SlWHFUA451BJJTNi4+omac9syHzmMDLDADtqkxdwbcgwP6ierR3DD79KQ2BqncKbIl4l
	 N5EnUTnJYQ0fDJJs8cC4ilcjpX/blLhl2B4xHGFBysiLYT2Z6ebwbOSvbun8Vd3FoDg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795464367;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=5zFABN8u71lzds8/o+dMGqPQQNBTnvrYTMurCGnLO3E=;
	b=MTBsklUzD3juCeuVBxJc/NtLbfp0GmBh85zubcKnMjCKBhMZn1o5quPQdWh/KUT25usn
	 NdR755KHH1IlRH++uof8tGQs2FrU72avRLfnVs0YNqYuD2BG/e83fHbgqJ7mCqoMEvK+v
	 KuNoqF1Dm7o3if99ajyfKKK6HNxiUG7fdpz/U9kPQcB2mI1rsM4v03ZqfP7ievGoMkb7v
	 sVPi2xtIEcGzZR6dWcCO0gkDWPRZZWkVvWiSOZWNWqemRWFuhfmKZhdYAGfu3vtX/zTf3
	 Zuc3iEOG4qg4c2yMvRLSH7qnYnhPwRO5AZSDS6wfdbObesmR4ro0To67Q3+PAlOSZYg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795464366;
	bh=5zFABN8u71lzds8/o+dMGqPQQNBTnvrYTMurCGnLO3E=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=H4DPeq532bzdr0pW5QSeJ3zKlD/nMwlcKvPlbunFokD6D382ILvBa7lmWnUhA6ecf
	 fKkxDZLmgs0OovIbyXGXnYV/yYzFKkUYTELlk8FM5MioFofcvFAQYyqzYxmBCpbg1c
	 bJHavaZ/ERT1/waGd/5xMzQSis+lv1QswLlJ1TgOD8BPnEghjusLoYFhSpUPoO4tA7
	 LND8O8BpsdDu03UqScF2EnbOpdr2QkcrHwkXntTVzSs9ZrEBZrEGN13TqBxxoPm1Wo
	 qzblPTK5C1wgRL+Xbbr1F/4dxwufcgEQa0eBTNnBAdKuvSeB3tVwhVQjN5YEXcHPOr
	 nlRubv6MtROJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C6F2E60600;
	Mon, 23 Nov 2026 20:06:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id EAF2B3A8
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 20:06:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D03D540568
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 20:06:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qBe0BWqGT7_V for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 20:06:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E34E240519
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::32"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::32; helo=mail-oa1-x32.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=rhAZos/W
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E34E240519
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 20:06:04 +0000 (UTC)
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-48eee44b908so2268526fac.1
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 12:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795464363; x=1796069163;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5zFABN8u71lzds8/o+dMGqPQQNBTnvrYTMurCGnLO3E=;
 b=rhAZos/WpXAvTwa1kYvWAU2hPABT9dS0ycZvLMPgyIkE1PSxY1t7RmUY/4z4vMsMZu
 qGEWUmVNYROHeX7YI+xDyl6djCf/ASU/KE94Ehq/mfjOpWbauNQKpYhKF5AMhwS++KPx
 T8CrG9zQwDnIbhba/bbkNqjxTyLt01+dVN4qEWkyR5BJVG3rpiZBRs/DuE48iEB/9/18
 gW7gK/Im22ualRpKEoxdJ/sAxoPGGNCzu9OOU9foGDVaozUTf5SnP+sblkcRdkLQkzD0
 zZ6BMhmS+5jeNRq4SbVLrn488vFgFrF4ElxjGb6UvlR0uk6bQ93xMB8TkHCV2Pmcng1/
 av/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795464363; x=1796069163;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5zFABN8u71lzds8/o+dMGqPQQNBTnvrYTMurCGnLO3E=;
 b=Vox0a3VoXL7gMaWUChByYgj8iG/QBd9gov8kHbncyhobihYdFWLhzFloQVRG6sgP/e
 nUa4GvJNFH/DOR4S9LlU/E3cSXgsIiHqoJ1uQFC3xbfCxjmCwMcruuAgSUhhLMXCHxNz
 F9kDzCdiVttOYJoofl153nEBzOP0ScinAg7ZDs6tHDDucJ/JdLFlt0HG9buEGLoRKdX0
 TZNQVFH1hlA5H3VZKemHyj9u5eNWrbyPY1SCPNUairsJfSL+EmjsXswneYB86WxWNo3m
 s+h5TO6jdWIbVdpiOpcKhTs6M6X5ZmL1LvBeet6ZP3dYi/ovJz6AmCasCar7ckbg3/Ht
 aTqQ==
X-Gm-Message-State: APuU4Z8QLDKykk+x40Q9cvETrmG+OKXFnAAjfipdDJm6oq0rYCej8wvX
 w8euundDgCkeCxitp0Hv8bOa4Sb3duggXOgrlqxZig2rcs7f5T7wgtMX
X-Gm-Gg: AZFdTZfeNOf+1rBNLIDA0T3B+YIG0cOC2h4L/G34nR5qQuvttpkuX5UFeuGRkbY18gB
 sR6vk3sR//Gjr3xIx/wP8EG1EL5ZnjDNZsODKgM4pqwHLopMuCjAnd5ATXgRu/8zvBsEJPVyNKi
 CfINlYNEt7x0wW1bHRWu+2x9N/uFw0C6cj5+bn8RQ487VzpgxPtf4IfxTY6DUz0Pao/5BOK+XPM
 aFMAj0OPyQgKD7V8C6fvAbH+OXMzXDWFinXINMisuNUYk7Y2ht3EAl45AFZEByujQxKg8XhPkJ4
 ZFlPB2uDDQbppYE+C9I5JsEdAwHiVVoFuI3cX28iVGFEoCWuXS6Lw5WY8Lwf0aLm6aublbfAvkO
 69orp422VYLn5nGd48RzafbpZDqCq5BFoImbGxzcZ0TMyK4KdEVZwAFcGMVfP/1lOlzhBrVnArn
 QvWipzZZ9I9z4ni0uJ0z5RI7CAIiUX3YBQxJU+lS+mDkIx/Ees9LUSVyVJttp7fogVKL5BeotuN
 cMTbNc7Z8hyfpTkM11Jsy4JYGj7D+J5Z9ocFb9RzuqkCOb8FFUF6QlNteSA8zuABOarzcIXjxT3
 knHQnV6TgFfuAKMudhLgh3kG73dE/y8FqGa7bZ/+HKjwqkQcFmgIczvN+/T0VXesruAHiOoetTQ
 6apEPSD5LI5iGYHhvWo9MXq6QbW8gLSHmafTo1KYaQUV3qJkt63nhWjTkr2n9FCwU3Sg1GoaHrh
 lxTYYl4wk0mKDZljGL3CiaYS+2M6Y38y7IPrHAzYJbPjQHHt1lv0n3
X-Received: by 2002:a05:6808:3088:b0:567:c44d:c1fa with SMTP id
 5614622812f47-57a0a60d7f3mr14635957b6e.16.1795464363312; 
 Mon, 23 Nov 2026 12:06:03 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-57a3485e3ecsm9228147b6e.9.2026.11.23.12.06.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 12:06:02 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 23 Nov 2026 13:06:00 -0700
Subject: [PATCH] net: ftgmac100: recycle receive descriptors after frame errors
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-submit-ftgmac100-rx-recycle-v1-v1-1-d2afd61f2ffa@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNwQ6CMAyA4VchPdtkLcQEX8V4YLXDGkGzDYIhv
 LsTjv/l+1dIGk0TXKoVos6W7D2WoFMF8ujGXtHupYEdn4m4xjT5wTKG3A+dkHMYF4wqX3kpzoR
 NzY14Dq1vHRTkEzXYsg+ut6OL8FTJfxW27QdDXXzPggAAAA==
X-Change-ID: 20261123-submit-ftgmac100-rx-recycle-v1-4324cb2f9b90
To: u-boot@lists.u-boot-project.org, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 Macpaul Lin <macpaul@andestech.com>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>, 
 Jacky Chou <jacky_chou@aspeedtech.com>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.17-dev
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A single frame with a receive error can stop all further reception.
The MAC has returned the descriptor to software, but the driver reports
no packet without releasing the descriptor or advancing the ring. Every
subsequent poll checks the same discarded frame.

Return the descriptor to DMA before reporting that there is no packet
to deliver. Leave a descriptor that is still owned by the MAC alone.

Fixes: b3dbf4a51f38 ("ftgmac100: support of gigabit eth ftgmac100")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/ftgmac100.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ftgmac100.c b/drivers/net/ftgmac100.c
index 5e74f976999..7d3b39ccc15 100644
--- a/drivers/net/ftgmac100.c
+++ b/drivers/net/ftgmac100.c
@@ -498,6 +498,7 @@ static int ftgmac100_recv(struct udevice *dev, int flags, uchar **packetp)
 				FTGMAC100_RXDES0_FTL |
 				FTGMAC100_RXDES0_RUNT |
 				FTGMAC100_RXDES0_RX_ODD_NB)) {
+		ftgmac100_free_pkt(dev, NULL, 0);
 		return -EAGAIN;
 	}
 

---
base-commit: d778970a189b977c14f93961d7009f404d895b5b
base-tree: https://git.u-boot-project.org/u-boot/custodians/u-boot-net.git for-next
change-id: 20261123-submit-ftgmac100-rx-recycle-v1-4324cb2f9b90

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

