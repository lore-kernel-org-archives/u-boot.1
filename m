Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE7D606A31D
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 09:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wnNjkhMX;
	dkim=pass (2048-bit key, unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=U932tLmk
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CC68780F97;
	Thu, 29 Oct 2026 09:33:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hX06h7FSyiHz; Thu, 29 Oct 2026 09:33:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B7FA980F71
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793266400;
	b=CWOhwrwkWL2ml8nAa640eyYZtXvMOlrpsT7mdM6kxsmTjA2MAEyOEhDmvMfLUpUI9zbd
	 Lh//LhdgHHAcnAWtcgJB+c7ET35OuDSEBiN4/VPJBacWUKWzF6SQdCRT89t054f0F+NF9
	 fjqcMETpmwc4ue93WWuCxvBLVVY46D7Y3mxYPkqz2SrtbBd6WZPpmzexyqJ+b4M/hqsWY
	 m0RPRW3dvFa7dXjiYJx4b7H9e1ZkGbdG1VMSKt7h3K4dGalajITE0IA0l7VdhAs83y+vM
	 HrLFZoWO2V6YsE5McaH/GY33mZtzm/VDJQ5h3kNEyy91so1LVfYzv8aYUXnebbKHZ8g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793266400;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Infomaniak-Routing:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=iVHm+l7sAQhG+xREdkndARJ4XN0xdWjX3P9fTsY+J6A=;
	b=etyVVLmvN9xZZm/GFNKf1UjrbU1jBoCI+kuQoDrG71dt0TjPrK2SfoQo0Ax4V/NNIJGa
	 xj/rLeY3v02ylj799ikZOUXA04RUDZI7Ldy+qbIw8sjKfV9XK1dWD93Jym2IX3YkHCJjQ
	 KEH7U4lJTT2vLgOtn6NlQStvOi4GepC6IK+28safuaIvcz5JX3y9PfnOQqwvHcKWJmdvb
	 F5PU4ZnIakUW2MZNY6wzdRR20AknTJXNIcvOdUqNidIJyCvoufqTMPZ6Tz1HZaKVLToyS
	 OBkoXC8h6in4fFhFLrB3UeO2dQkAQ+WYSpevRRkeBpSilFj4J/9c4Nz6UkpowrjW1CQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793266400;
	bh=iVHm+l7sAQhG+xREdkndARJ4XN0xdWjX3P9fTsY+J6A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wnNjkhMXr0tRbC4t7hToE8DkCUVSdAq+TsUU8VrHilKNMl0nCs1PNs9F1E90UFWsr
	 Mt74CaXHDKpAbr2XsmV/ASDy7mpW1mPMLVmfhoyZxcqLpSwk2uNJgZHQSL8u+Ukq8x
	 5SF0ndpo/VFmlQ/Q9mS7tU64lI5GlbfKXJfzh95eUoAEk6c+tNzE2c3W+4tQxRDSXq
	 aby/DYLWMcKWGqQPh0E6HzKI9GXcPXYGb1kn9IM9QqO7UQ0UbrkIAwQrWZy41B/gDl
	 hpUPpwD14SP+6089+9m/gwy9dKj7nOdFf7c06FXVSjMdFVpmw54e8ZiC8NpWiAGVkU
	 0b/K5H6j2DnWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B7FA980F71;
	Thu, 29 Oct 2026 09:33:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3A5224BC
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 09:33:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2695040755
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 09:33:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eguniQq_6Vrx for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 09:33:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CC02C4062A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=45.157.188.9
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793266398;
 b=W6k6LkwDHRDkGCMO0wHUUwjRgOXldgmJMXS8WtTFjXNc+iYP3KznNVNvlIKFJtPYj6/r
 ADdiJyYBoBtBtVIly7uLmWh8MmCZFG31kY27xTqNsT4kZTSt5un+X+ObwqAtb3jm/LqLf
 Quxv+TxqHoXK20LNgAjLFCeSxCkxtpagiDMyo7u/TlxUlexVaF+ropNdvIDo+X4oxh8kJ
 v6A2F081/ItH6rtTr0Nb1hZ4cILeIRqUkN0adypTQ8mTN5MQojeeF/4LyCQXmM/HzV7KZ
 e4RXdl4G3bks+x+NcaQ/Faugwt88OtKl96RaAgs/mTa4nVSNeEqzi/zNGAG4DM0EiKw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793266398;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Infomaniak-Routing;
 bh=iVHm+l7sAQhG+xREdkndARJ4XN0xdWjX3P9fTsY+J6A=;
 b=D87Ttg8zRvjml0Hml81mx7cmOf3hMFE7V6ZwD1rG8/EefwGgBY52MypBPhir8O4oynIH
 LQpDHTObMFHMR9gGSn0vrdM+PoaY7oqoq2DiVdtR070goKN8E+GoeN9MH8ElwRiw0HnNp
 r+XHlEy6NHuS0vHnNWBKxrdAMl1rI/FxiB9HijgZdcFD+fgWxI8+yxlH4hx7OF7ZlRUGj
 bpotLUFHbOD+e1MYyFD25zfIw6VDP570G8tBcjO1F6AAlF6/zVpp5LTNYpxm/VWPfNWFX
 1XpbKzXGGhB87K6gYDKOMJK0ILnKF8Tk/jA8fqbaM10zSOY07oYfxZXz2xrYlXOSC4Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=0leil.net;
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=U932tLmk; 
 arc=none smtp.remote-ip=45.157.188.9
X-Greylist: delayed 473 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 29 Oct 2026 09:33:17 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=U932tLmk
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.157.188.9;
 helo=smtp-bc09.mail.infomaniak.ch; envelope-from=foss+uboot@0leil.net;
 receiver=<UNKNOWN> 
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch
 [45.157.188.9])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CC02C4062A
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 09:33:17 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jFf322KwTz1hwQ;
 Thu, 29 Oct 2026 10:25:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1793265918;
 bh=iVHm+l7sAQhG+xREdkndARJ4XN0xdWjX3P9fTsY+J6A=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=U932tLmkfwztE0VVQLzSopoUhEq9B7nPD55ZM2j41Sus5q4wY5l1ZxUL2UKzVcgAQ
 7UXN9kbfn0B1qvaxNH8+Bn9hN0qW3vRdQ55F8/JbWIrEHH2A2bne8WAXQ6Os8XdOf9
 v7+wLu5QkATRoqqtfjiCKAHdFFO5gWyDOrru4PhFGsDHKTRgocxjAXXjiAHi1BK60k
 xrtuqbH8n7PuXNyeFXfT0VOf80Kk52O7lDUasKUGylS/CFVgXFaj29TZMFgtYZNOAH
 8m5x6xVEUN32HVl+ZO74oMFu18CoFMqBJI7V+ZeOhw7B7i8cp5gmdeAz9OR4yV/Fkp
 bvRskKg3veWjw==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jFf312JqHzTNN; Thu, 29 Oct 2026 10:25:17 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Thu, 29 Oct 2026 10:25:05 +0100
Subject: [PATCH 1/3] README: update link to official releases
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-denx-de-removal-v1-1-e71e448a9c82@cherry.de>
References: <20261029-denx-de-removal-v1-0-e71e448a9c82@cherry.de>
In-Reply-To: <20261029-denx-de-removal-v1-0-e71e448a9c82@cherry.de>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

The FTP link doesn't work anymore as far as I could tell (or I don't
know how to use curl/wget to download it) and denx.de future is
uncertain. The official mirror as stated by Tom[1] is hosted on OSUOSL
infra so point to that instead.

[1] https://libera.catirclogs.org/u-boot/2026-10-28#40690089;
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 README | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/README b/README
index 7060bc5ac0cf..e4484face5c0 100644
--- a/README
+++ b/README
@@ -59,10 +59,7 @@ https://git.u-boot-project.org/u-boot/u-boot
 
 The "Tags" links on this page allow you to download tarballs of
 any version you might be interested in. Official releases are also
-available from the DENX file server through HTTPS or FTP.
-https://ftp.denx.de/pub/u-boot/
-ftp://ftp.denx.de/pub/u-boot/
-
+available from the OSUOSL file server through HTTPS: https://u-boot.osuosl.org/.
 
 Where we come from:
 ===================

-- 
2.56.0

