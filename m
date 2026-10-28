Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A3C606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 07:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ranssN2n
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D7EA460670;
	Wed, 28 Oct 2026 07:02:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MNWVi4_FCcrW; Wed, 28 Oct 2026 07:02:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 31391605D6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793170962;
	b=Q5aBjiIY9fYZRW+GG2W+5Qo4Pg41ln8QpEX+U+VeO9/9cvlIkOFlMj0YNwCCZIrnjZJ1
	 VRz/J7nxDDslRCyDbcWOWS3EoRl3zqqvVK8pWbI/nmtjx7lAJTfnq+1Gmi6KyIrncFhPa
	 xqV019TcgMj15As0MhNqiXm1woggwweeusrGcH1KqDRR1T31M0yK0A9V14vt7zEtGxPnj
	 e9Ee81SeLc3HHYyenOdxydJaRx/PrnQxvQ//rLMJ4hiybzjVFVvdnfNoZ7wN0pwEDqLkU
	 NN+k7PgIOx7ox8iJH6calZNIYxDSgwfNmQC99zczfBJuyn0AzZeMbY5My7E6L910kvA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793170962;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-DKIM-Results:X-DNSRBL:X-SPAM-SOURCE-CHECK:X-MAIL:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=aKjoA4xcFTGDD1egoff4kcq6o2c35Y5OfVJSS8XbFS4=;
	b=T35m5axP/QuJTejvjlvECP8P1Z/ma11EoGG1B0ehUY2orwf8xTKMKXunNlb7SZcoLPbj
	 GLlbJ8Uehaa6LWslvVJNCm28bCEHDKPylgA7VuR+jMyh9QYt3qnmtw7sIOi5R0joW1y+o
	 tvNfR35ehpGmvsqKdqIojnwaim+fmRo/0Z/WUQw3U2iIIATYAqHFiWBWHg4SCrHxIHNsa
	 3ZJd/xChHSlErmi24cyPeK+/JpuR2Y44/0IgIIRpl/dfroGLcuChaKZTtrsbquUvBu4hL
	 HbrtEVocXroFF5KsSOfy/RjXPKhhqhb1DRFgRt9XW8+cXcYLiuyjvMAQoFOj7iWIVew==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=andestech.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793170962;
	bh=aKjoA4xcFTGDD1egoff4kcq6o2c35Y5OfVJSS8XbFS4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ranssN2nJ+WovtSmeG8icj0d2rgBt3VOne2d9M6W/Q1lXi6VKFWRMjLR1K9Bre9PK
	 ZO1o5+/Ly1FKKIoz4fS3H91ypn/VaoQW9aSIlfmeA6Le2oHfuWc4Zmt5Usxk7al4M5
	 Quezb0XhjTzNkdmABeAdSyR1RQNAUyCEYuZ9S1dXSN7BzbjmXXc4rAzn57zouzg4Kj
	 kxIQ0CTYHATdwXBJyyR0tpdLGH7QpUp85J4pRdNErPlRSmgzBZKP3HsaPPr9mcybVO
	 +S+elHJ9IE3+uYhe4zItDqmaCt82eCvH+RJwlWdfrgcVMCdDPQ0GylJ9vRoBd6HFmg
	 mb3r4uKgF8KaA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 31391605D6;
	Wed, 28 Oct 2026 07:02:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B8B162E5
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:02:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AA65F605F7
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:02:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JXFpxTp3eXJ2 for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 07:02:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C48FA605D6
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=220.128.198.184
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793170958;
 b=T3Am1m1Gqy1YH+O++R9vjKcUud/h79XZJhOh8DjqTxQBb1GpAt+UGL74a1Su5UWRwRyp
 Chds7rRQuGVJY0GwqhkYmCRtFZXbhF8ZThNQrhPA3NwKsaBzz7k4FXZ48bsTDxrln6ueY
 KiKMifenl9OARBj6A0paasYU4vIr79DFz7j+O1eicgc50Bibwmd/78xKucMiGsXMdHLil
 WBJPK7R4X0E7YIfZMOCO0VfN8pHD2Mrpfjs53yXtKpVEI5SHBf+GZrQGRol5b5dB5eoSg
 laH7OKM703tOUtIc5z1YKUkZyWn9l7Aht2DCY5zAEEH4Ke+WEMKKWMaJEcqXytP31NA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793170958;
 h=Received-SPF:Received:Received:Received:Received:From:To:CC:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
 X-ClientProxiedBy:X-DKIM-Results:X-DNSRBL:X-SPAM-SOURCE-CHECK:X-MAIL;
 bh=aKjoA4xcFTGDD1egoff4kcq6o2c35Y5OfVJSS8XbFS4=;
 b=otG93MUc4k/oNvb9ejEaiLWsaHEFv5p9kl2wLcIpd8rywN9lxSyFkjROWf7ahOzwEotb
 5vgD5IIgkCXUN8f6v49gTUSecXx5d0sFGRk3viJWcs6AG3sRlPI0X42AR50GOF2PqegXZ
 duzeGOLHbHfdlQsbmD05rc9GzSeLwF3F5LLKdTVzPoMSf2r0M7DyhHZHmE6ZMCADB7MvL
 jLX9mUepc6Yn/l2iNpuENllq3UNtE79RwC3mnaHkIo8HBO+ASizoc2evA+/Q8K5WjMvJ3
 R/gxpc/VX07ww9ndhk3jL8JewziO6SlL/tGl/OuKc/m6MurBJisPSrRvLkRH2iIcptQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=andestech.com;
 arc=none smtp.remote-ip=220.128.198.184
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=220.128.198.184;
 helo=atcsqr.andestech.com; envelope-from=randolph@andestech.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=andestech.com
Received: from Atcsqr.andestech.com (atcsqr.andestech.com [220.128.198.184])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C48FA605D6
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:02:36 +0000 (UTC)
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
 by Atcsqr.andestech.com with ESMTP id 69S6hxGM035034
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:43:59 +0800 (+08)
 (envelope-from randolph@andestech.com)
Received: from mail.andestech.com (atcpcs55.andestech.com [10.0.1.155])
 by Atcsqr.andestech.com with ESMTPS id 69S6hcUY034817
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 28 Oct 2026 14:43:38 +0800 (+08)
 (envelope-from randolph@andestech.com)
Received: from ATCPCS34.andestech.com (10.0.1.134) by atcpcs55.andestech.com
 (10.0.1.155) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Wed, 28 Oct
 2026 14:43:38 +0800
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 Oct
 2026 14:43:38 +0800
From: Randolph Lin <randolph@andestech.com>
To: <u-boot@lists.u-boot-project.org>, Leo Liang <leo.liang@sifive.com>, "Tom
 Rini" <trini@konsulko.com>
CC: Randolph Lin <randolph.sklin@gmail.com>, Tim Ouyang <tim609@andestech.com>,
 Randolph Lin <randolph@andestech.com>
Subject: [PATCH 1/4] dm: cache: Add flush_all operation
Date: Wed, 28 Oct 2026 14:43:26 +0800
Message-ID: <20261028064329.1986824-2-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261028064329.1986824-1-randolph@andestech.com>
References: <20261028064329.1986824-1-randolph@andestech.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs55.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 69S6hxGM035034
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The cache uclass can enable and disable a cache controller, and
disable() writes the cache back before turning it off. There is no
way to write back and invalidate a cache while keeping it enabled,
which flush_dcache_all() needs for an outer cache such as the Andes
L2 cache.

Add an optional flush_all() operation and a cache_flush_all()
wrapper, in the same style as cache_enable() and cache_disable().

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Randolph Lin <randolph@andestech.com>
---
 drivers/cache/cache-uclass.c | 10 ++++++++++
 include/cache.h              | 16 ++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/cache/cache-uclass.c b/drivers/cache/cache-uclass.c
index 300e7bc86e1..b66dd500ee0 100644
--- a/drivers/cache/cache-uclass.c
+++ b/drivers/cache/cache-uclass.c
@@ -38,6 +38,16 @@ int cache_disable(struct udevice *dev)
 	return ops->disable(dev);
 }
 
+int cache_flush_all(struct udevice *dev)
+{
+	struct cache_ops *ops = cache_get_ops(dev);
+
+	if (!ops->flush_all)
+		return -ENOSYS;
+
+	return ops->flush_all(dev);
+}
+
 UCLASS_DRIVER(cache) = {
 	.id		= UCLASS_CACHE,
 	.name		= "cache",
diff --git a/include/cache.h b/include/cache.h
index 296ae3c8b48..08a820f7dd8 100644
--- a/include/cache.h
+++ b/include/cache.h
@@ -42,6 +42,14 @@ struct cache_ops {
 	 * @return 0 if OK, -ve on error
 	 */
 	int (*disable)(struct udevice *dev);
+
+	/**
+	 * flush_all() - Write back and invalidate the whole cache
+	 *
+	 * @dev:	Device to check (UCLASS_CACHE)
+	 * @return 0 if OK, -ve on error
+	 */
+	int (*flush_all)(struct udevice *dev);
 };
 
 #define cache_get_ops(dev)	((struct cache_ops *)(dev)->driver->ops)
@@ -70,4 +78,12 @@ int cache_enable(struct udevice *dev);
  * Return: 0 if OK, -ve on error
  */
 int cache_disable(struct udevice *dev);
+
+/**
+ * cache_flush_all() - Write back and invalidate the whole cache
+ *
+ * @dev:	Device to check (UCLASS_CACHE)
+ * Return: 0 if OK, -ve on error
+ */
+int cache_flush_all(struct udevice *dev);
 #endif
-- 
2.34.1

