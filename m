Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5058A606A339
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 13:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sEmvwVWW;
	dkim=pass (2048-bit key, unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=i70eqG3C
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 233D780D9F;
	Thu,  5 Nov 2026 13:58:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pEq3gW_-08bD; Thu,  5 Nov 2026 13:58:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7663580DA8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793887108;
	b=HRLVN9xhQ1IhJ+U8rlfxWqj5K5yovHjStwOv0cgSRcoGUCBrzQvM0YESRFiUQ6K/CkXO
	 zM7sAUE5+3uPjxwyBMhdF1P3HsAB4mWsSGNl0znR5x7SBgn9VytFXQgKA5DZIJls3aNPO
	 mjJmfWzKj1fqUOE4LJiyveZit/8UTMvQTXIzEjVLOQbFjvQe3hGFU3uu/CnFmsceTvcSl
	 t4TwxgeSrVwMMcze11Rk0DIxoy21stupv1Oi1F3fVzPieJ6j5HYCzOaxRcl7AoyAVM/Oh
	 ZZsN9b325cd7OolF3IkZZa9t3HIv7N4iDnqWJPFZ+hk87MudmjtahO6FPpS1TPNvSVg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793887108;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Virus-Scanned:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DNMA4+ieEIIIFtziFxTEl7vy7p/oNdBmpMZtD+c8B50=;
	b=WhEP6FACmvsOmOwSCKLACu7jPOpbyigK2uDuKUboBirV9MANvZTjgh2zwB+stsILk9+D
	 WniqABxNfDaiTdMLhcnAMrr7JW3DI5+lTGW1gkhwXe2XqmVfH/Dj8Pv7FoyUBGHY4mFlS
	 IZKvqIhKMdWRKDvKUqV92dKtSQ42pJzmXOGr/lTh3pViA01RTLKhSIqWKPQ4621GML7q1
	 +mIvpXRbwnYqg+uspsa5eIm0GAxNXxqSPhyXCbZFsCxOAevaJ6uMl+0Ikwg5AoG9JFHvF
	 10n0/K6A0VdxYdHdnIjt+eUmcUqVkWsKf7HqevSU28YtyzWCLblbvMd84zlvlp4r1EQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=ew.tq-group.com;
	dkim=pass header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=i70eqG3C;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793887108;
	bh=DNMA4+ieEIIIFtziFxTEl7vy7p/oNdBmpMZtD+c8B50=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=sEmvwVWWXTYiv+WbeABWicrN00CaQHBNuze5HkbIfz+8jDQ5KH0hmEezQBH4RNlxG
	 /o1DcU0w8KSo4Vk/ovGa6xToxwg8L04pqv/RSdsvZAmTuHO0qxmbMj+m0TO7BQ64AU
	 phzfKaRXl3hJiBe5ylcmgzefV9P0tDBVQd72vZW/f5lBftiyRmYFUwq7kQXvmYAk4j
	 zLq07eB4U1c8HMrxjz+8hKfdriqylgQeL7XeYWgJ0VywXY0VZbghKdMDNKG5fQZOPt
	 8JfjBPl8E3QkHManrcU+KoHy5XQE1keX0McOlLfKltiofuHiQHHZNUWYdEqsjmnhmR
	 6qVxpMMIhnC2g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7663580DA8;
	Thu,  5 Nov 2026 13:58:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0A4AF52B
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 13:58:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 06F0B80DA2
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 13:58:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yewWt_-beKhq for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 13:58:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DE40C80D9F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=alexander.stein@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=i70eqG3C
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DE40C80D9F
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 13:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=DNMA4+ieEIIIFtziFxTEl7vy7p/oNdBmpMZtD+c8B50=; b=i70eqG3CxmiFjiAKenpMJFjAaO
 Dgbig1Zl5xilgirDoAyipzHCaBKohx8r0N34hu2I5f7gX+EwdGb47QfrhmprRTf0YpEwTmuFxhO9D
 TnilU2o/UU+zQhaNOGuJvGTphKxrYhtIV0/Sq8xK7r6Jk2fQTAYQb564YHA7jFMr9R9K5d2icflvr
 oq9e6ATWTs7vm0SDL6W7j/sO7eHS5no1HREGMMEqFsu3xVwoJnXyXW/DWWOsA+jW3c+0dzuLmQ/4N
 RLOMJsbetEJtfpWsCC2u1NqtuVS1aXE+t6yRkm6XukrofKThlplPv4/6qf+Lwl7c2vx87twcKMtYS
 p7hBds1g==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1xOxyw-0008UK-36; Thu, 05 Nov 2026 14:58:23 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy07.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1xOxyw-000CD0-2F; Thu, 05 Nov 2026 14:58:22 +0100
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Tom Rini <trini@konsulko.com>, Jerome Forissier <jerome.forissier@arm.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH 1/1] net: constify enetaddr in eth_env_set_enetaddr_by_index()
Date: Thu,  5 Nov 2026 14:58:06 +0100
Message-ID: <20261105135807.2812078-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28174/Thu Nov  5 07:26:24 2026)
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

There is no need to require a modifiable source pointer. Make it const

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 include/net-common.h | 2 +-
 include/net-legacy.h | 2 +-
 net/eth_common.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/net-common.h b/include/net-common.h
index f1f670dbd8b..0abaaff5e3e 100644
--- a/include/net-common.h
+++ b/include/net-common.h
@@ -214,7 +214,7 @@ int eth_env_get_enetaddr_by_index(const char *base_name, int index,
  * Return: 0 if OK, other value on error
  */
 int eth_env_set_enetaddr_by_index(const char *base_name, int index,
-				  uchar *enetaddr);
+				  const uchar *enetaddr);
 
 /*
  * Initialize USB ethernet device with CONFIG_DM_ETH
diff --git a/include/net-legacy.h b/include/net-legacy.h
index 0f3f70a17f9..f2945148d8c 100644
--- a/include/net-legacy.h
+++ b/include/net-legacy.h
@@ -87,7 +87,7 @@ void eth_halt_state_only(void); /* Set passive state */
  * Return: 0 if OK, other value on error
  */
 int eth_env_set_enetaddr_by_index(const char *base_name, int index,
-				  uchar *enetaddr);
+				  const uchar *enetaddr);
 
 /*
  * Get the hardware address for an ethernet interface .
diff --git a/net/eth_common.c b/net/eth_common.c
index ba57d836b0b..d6d1191018a 100644
--- a/net/eth_common.c
+++ b/net/eth_common.c
@@ -21,7 +21,7 @@ int eth_env_get_enetaddr_by_index(const char *base_name, int index,
 }
 
 int eth_env_set_enetaddr_by_index(const char *base_name, int index,
-				 uchar *enetaddr)
+				  const uchar *enetaddr)
 {
 	char enetvar[32];
 	sprintf(enetvar, index ? "%s%daddr" : "%saddr", base_name, index);
-- 
2.55.0

