Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EC4606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 00:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=o3GspRrc;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=d+Lmjf6G;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=eM+a2HB+
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5740440383;
	Wed, 28 Oct 2026 00:33:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RoAXGr9IFGTF; Wed, 28 Oct 2026 00:33:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6B4F440317
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793147627;
	b=n3DyYwZpGtL4smpmna3unoBkw/3mNaHMLzKYeIpj/tuz287hr80a6F9+5k1mZbYqlhpw
	 mlhgZXTAQGaHwJRNKcb2WUiEPoSsERHnTC7Rxoub31Pcnw2Tb9lw4QiWXEC6g+xnVkora
	 SrxiTjppQspb+9BGTKHWD7KUh65PQ0KnI2ZZLwUbwaEQuWTKHSA1jb0B1N6KkgVL1ho0b
	 r2iTUhtnaeAaCke5eTh7v8LAphV1zHbz3kh4IEdtZzX3auK00c971VFmgb7bQkkJGQW8A
	 nBwwRjRfBGmsdJWOBCTQdN1n97+saFVwP7otdtp76vB7A2N6akdFtq4jNKEmGSBy1gA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793147627;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vNobv2jEro2XOIFYKq7qAjGOI3DM1BjMhVthz034Kq0=;
	b=Y8R1Q/t6hYAEKmWUS+FejB5Jg7HbbI54Kh3m2rXLeh0RnZyliwCkuju76MP6PHi1agNu
	 LLPpFUGP/Pv8QbNLmO7WKIfqpUoSMvA9TTX1LczTxZD5wKZc+kMdAqouz+WbVSwLfX8Hp
	 54HKXwO7bGID2mvE/8oN3LeZ7A8ktE1yXXlnWE3sIvVSVeLY4GDrZS2p+tHKv+W43iyWv
	 78PovwWkbCff1Z0n01A1+hqBJRVke4Zar7E10v4lNosGvhtv23ShTliKdgoOYqY56mnNI
	 a96C0YarcQqTlrMV5VIlX2wrr3aZsvoO5SdjsqhtS4qsiXROsDcJce7QIY1Z8PDgc1g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=d+Lmjf6G;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=eM+a2HB+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793147627;
	bh=vNobv2jEro2XOIFYKq7qAjGOI3DM1BjMhVthz034Kq0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=o3GspRrcivJ/XuLhzRhveHgQhwJ7aAISRbGE/SpWsbm2LO5A6KUEjQz76cZJVUgLG
	 nVJCuXJEtBn0kGgwzb4xxlvc1P68wqkn7BVP8yxDpJ1IZbVH24Wbv29fg+NN3hqrgD
	 5h1h3ajJbbic2DM/0tNs54WvseZBsPDaLi9QV197c/ppvl+yYH9D6A6fMwc+ydnLxq
	 B7rBXfFuOO1fNlX1idt0fVNWM8sYgKrgopGVL4rw6wLj3lpbUrY6gP34O0a75mC40O
	 2FubobNCHTV8Il2BGgogkNp2tXnsVrpg1M4Wa+f5kUTirujQsnOzo4ZnUMyGGXE36z
	 CGkhImHtzkWjA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6B4F440317;
	Wed, 28 Oct 2026 00:33:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id A12EB529
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 00:33:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with UTF8SMTP id 47F4C402BC
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 00:33:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id KyccF2W-kbpA for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 00:33:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org ED1D740589
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793147625;
 b=DzgEc3xjg3goMZmZ8+Z4VfJ6MaDcMjOyHHEKizw5sX4eDC0EhMD+IiUuy5YN6V6m4Qh/
 Y2so5l0opGdMc15Ry9RL2WVLcrjPPjjuDtU+p7YcqFI/bLHoJWpxX0wdc99lVwbSL0QDl
 ZxBkpxJ9tRxylzilzsT5nLHpwCifw0b1qMvjOMFL1RUvWm4SP/BX4UY57U4hCqzeGPcOw
 p5lVKsc0vCEc/O4eVuHGRsw8WnCt5dOindTbAQz8UrjbBKHPc2YQcJFrTeCjXBNFcFK+6
 sAYWz75YQu+Nc3kyE7gZsm5NQqdwJieZU3Vq1zXoZmci+aBGo4rbaCjkQphRZQy5PYQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793147625;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=vNobv2jEro2XOIFYKq7qAjGOI3DM1BjMhVthz034Kq0=;
 b=juWmIAgbH5qpoDROxw56TwwGKUnWtu5ZKEheJykSrl11Gfg6teVbNmCNUjI1JFBg5SN/
 4FeBdzbt3IGoSWpvWUnIXqcWu/2+Q1A9Ukp5i8YYlq0N6EPt+J6GSKGtB7BgTnpyfJuQT
 OsYAfxFa0bRr5tKx7RNr96f5zP7Oxk02p5f6JXRTEr78h8+Xkm1EWsLCEyaYQ2hZd2aZm
 A2q3vIEwEhLzIKTH68a27YvemlDhcr44cxyrAIMukNpoxr9FZeQoUk0TbyTl+fIo+T8hM
 hMcjJSVWCQIr95ZwFxMecyKm5YogRjeGLC6WAInyZhThSQt4hF0bjKHggjhdnWplo1w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=d+Lmjf6G; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=eM+a2HB+; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mainlining.org
 header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r
 header.b=d+Lmjf6G; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=eM+a2HB+
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp4.osuosl.org (Postfix) with UTF8SMTPS id ED1D740589
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 00:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1793147617; bh=vNobv2jEro2XOIFYKq7qAjG
 OI3DM1BjMhVthz034Kq0=; b=d+Lmjf6Gp6bnw6AEtTLxlcCrHSzLDKL5JxSD62cOTqroBeLYUw
 e7GQd4SVmCz0FUu+zxgh+c5L+In1bEngBsfIBc8Vxj9Do6mPTfvMvNiRidfDEl7iWPEef48gdn+
 UpoStG4ZSPP7VYqhUutEJ0mrIecS9KR1r6SpmO2aojd7Pe4hIqneXabZ23tDFoUNip+QC3xav8t
 kflVxt8K8TgaQcnXKHUlUMPhO0WpFkrfc3IRcJXQkrTIvsBa9mBgdTu13JH+RpZW0RQ/SqETreT
 AOUoAPMovXo5hFXd+t/b3S4msxgYEmv6MBz/Hv7P5OUxg5W/uyHLwnUAijKn7oyy9lg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1793147617; bh=vNobv2jEro2XOIFYKq7qAjG
 OI3DM1BjMhVthz034Kq0=; b=eM+a2HB+CjTQq7GQxgJ+gz6DKUpO7PbCJDNvdlu4oboot722B1
 DPxCqAnczR+qEAr51pN2bUrElHO46d0pGbAw==;
From: Bradley Morgan <brads@mainlining.org>
To: peng.fan@nxp.com,
	trini@konsulko.com,
	u-boot@lists.u-boot-project.org
Cc: Bradley Morgan <brads@mainlining.org>
Subject: [PATCH] MAINTAINERS: Add my tree to the POWERPC entry
Date: Wed, 28 Oct 2026 00:33:36 +0000
Message-ID: <20261028003337.15936-1-brads@mainlining.org>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Now that I have a custodian tree, add it as a T: entry for arch/powerpc/.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3a62c1a8db8..ef32335f9a1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1440,6 +1440,7 @@ F:	include/power/
 POWERPC
 M:	Bradley Morgan <brads@mainlining.org>
 S:	Maintained
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc.git
 F:	arch/powerpc/
 N:	mpc8
 
-- 
2.47.3

