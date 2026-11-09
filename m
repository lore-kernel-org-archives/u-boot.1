Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDADE606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 14:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VK6L0vye;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=VQr18fuU
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 42F4240775;
	Mon,  9 Nov 2026 14:29:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tuUUHwgEvI0M; Mon,  9 Nov 2026 14:29:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 644FD40766
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794234569;
	b=H/stDyF4W7pyQQVaaz0bON1kHZzZwj5YytKyaFlCU16mbUCGjWoOhPL4mxBwmXvrSyXO
	 yBLAnVo7Ehj8Tce1NVT2bbTKf0MOhI4aT9gN3L5lGp3+qX3uSj3fRdcZlJ5rT5CDAAxUi
	 cqHyzcTS4CwgzOednnou1Sj5CVGqwhHpdF/QLrsAN3WJibNK4QughH/Ubn7HGQsKUL0BQ
	 ZRHJG1hrN6jT63b9q86xLWEOyxekTWtO2c8eoYrgj2YKFfq2BaLrW6rM89wjjwrJfG05E
	 ffHbOKu815VEKYw4WEZxAuIsnwUwRiqLlOlqWPMYt456d+9OYe7u6zPhJN1IvDFzztQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794234569;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Infomaniak-Routing:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=maq5CbYKiTCryLKhut07gzcWwkJb8neqhgOJA6zw7+A=;
	b=H7RNipSXBAAo3sGgfnAc95FKf3Humm3rN3Zl1Qp/FRLoPINDG3rZIS5WB/7rBwKTNXJK
	 RdPH9Eeg7c6Sp7Czh6WL2oR6be5oB9L2IQPlLtHlMZqtsmMjJJFfOyB3zqT5zRM+QBJd7
	 ETu7RHzs41JOymayuEXyFuuSzwb2dxstSh7wP2RVlHfoXZRuWu+ePlirj1Z+7O4KOVmrH
	 Bn+PPBA3WWBQDs4Erv5tHAKPcs48sOlKLvYfb+nJ+QSf/Vmswt7vHassYmhHFtIqsH/qb
	 9CZ45hCND33ygNmRItJXQUsCdmWrjDI+4x7CzxV8GKRfRwhEw8LxVH9MeQ0IS1HtrgA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794234569;
	bh=maq5CbYKiTCryLKhut07gzcWwkJb8neqhgOJA6zw7+A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VK6L0vyeHapErCE+R1Ih1cKVWCV4XOPrmxA8L3VGR2JHdEPo8hHTt05FikkrWOBmp
	 A+0uC1Xeb1+u+IGgwGl/xGVn1UGM5hxQ3d8ohwnMn6MsjauVQECkq5uOa+mLxCIQm/
	 AYxGoHuvDitVJLr8IbwtAmI0PT54qt3gMhGtmwdvP4pAQcklnm+EVWug51Ug1Zb8Up
	 SC+sA8QGaLgD9LN0sCZvpZLpEqOgELCOQZDm/l0dkcEqBxrq/HcNyTp0BCbCftsSu4
	 JFcqbKc4VZlySOtjkZUIxE783t9LEQwO22TcPJU+Oq2X2HF5qjpfVJbnFj8iL4eoBi
	 e7iYxNk/oXJdA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 644FD40766;
	Mon,  9 Nov 2026 14:29:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id CF731235
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 14:29:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B52364027C
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 14:29:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4KapgzIiG_4m for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 14:29:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 19BE940087
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=45.157.188.13
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.157.188.13;
 helo=smtp-bc0d.mail.infomaniak.ch; envelope-from=foss+uboot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=VQr18fuU
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch
 [45.157.188.13])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 19BE940087
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 14:29:24 +0000 (UTC)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jNX7L1rDWzgQL;
 Mon,  9 Nov 2026 15:22:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794234174;
 bh=maq5CbYKiTCryLKhut07gzcWwkJb8neqhgOJA6zw7+A=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=VQr18fuUshQADGiX3HKIFarskGy4IAJwUDfhWElyWmtBue/5TKXmvtHU2lu/T7kCC
 w+PVaFU+NJmgPots5JnB/9IZTKtIm5vvzrebYlP5VKVEl6S4ocyXR+MOf4bqfHMurp
 Y8FzVTn9GLC3VUZfF0S0t/KdYSptUAjWlHNxR1HD76WQ+r7t8uUEdQjy4d/H1Vhm/v
 a/+dOePeedyf1VcFK+II7HtuEo6aMcNtWmpl8Npw/S2MQuF7kHExQnR5n3NwLVH4Fv
 BBNWxMKzF/a4L8LGxSr/+kAh98mmWZFuIW1LWMrwNUA+D8b5Itk85tmwDD0TfC0tvG
 HYvw0iy0OQ6nA==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jNX7K0tdXzZCl; Mon,  9 Nov 2026 15:22:52 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 09 Nov 2026 15:22:28 +0100
Subject: [PATCH 2/2] MAINTAINERS: remove Simon from reviewers for Rockchip
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-rockchip-maintainers-update-v1-2-d8f568818a1a@cherry.de>
References: <20261109-rockchip-maintainers-update-v1-0-d8f568818a1a@cherry.de>
In-Reply-To: <20261109-rockchip-maintainers-update-v1-0-d8f568818a1a@cherry.de>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, chenjh@rock-chips.com
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Quentin Schulz <quentin.schulz@cherry.de>

Simon is not part of the community anymore, so remove him from the
reviewers for Rockchip to reflect the actual state. Thank you Simon for
your Rockchip custodianship of a few years and the numerous reviews over
more than a decade.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index adea20d5f36b..9bd2d684d370 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -547,7 +547,6 @@ F:	drivers/usb/host/xhci-rcar*
 
 ARM ROCKCHIP
 M:	Quentin Schulz <u-boot@0leil.net>
-R:	Simon Glass <sjg@chromium.org>
 S:	Maintained
 T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip.git
 # Exclude from N: px5 matches

-- 
2.56.0

