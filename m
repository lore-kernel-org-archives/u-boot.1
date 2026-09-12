Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8ADBC88E5D
	for <u-boot@archiver.kernel.org>; Sat, 12 Sep 2026 13:26:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AA4274075F;
	Sat, 12 Sep 2026 13:26:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W2xN7YZA1gkY; Sat, 12 Sep 2026 13:26:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1A7CC40722
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789219605;
	b=MB2v+N02iqMqM6LCmqqvEYxd10vqiHVkQm5k+H8Q+biNSuGKOFhrFoC4FpFIqaRenZh8
	 ldIjn/QWkITDUk+wu5HkhUBICdv27lMeRjkwzzwLXa0XGEHM83p2DZqgYXNU0Ej89qsAx
	 LTGVsujAcYQG3VUvNyRW3Ir2Zqgt+FghFdYmpuwSIhuFeSO+xakk6wc1wp7sOzjWKFujw
	 xpQLWEei4opluTmUs8XPuDQJtnkTTTuQd/67WqncBRFysGKpshuiOwjwpgrY7smo/GfZ1
	 9DVy5F994hw7hsSdNQHy+v23JJFBfJVFADe3eGQecUHI5PSizJXU8rpdyIZ1x6A2xkg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789219605;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qkNcxYDJgvVZ7mhKn5h2UVw8T27MNf/masta0kCMW+Y=;
	b=lrxvukYel2aQaNkZXwT/tE4HxODOo2cQUByGtHja0PWoqTD373FKGa2OWb0t8YzTqQ6Y
	 cf9pBw1BIAnAd/yeOxj5/lPaKHR/MTC71Y9jSvEfGuL8vljbHzjPQaFCNv+K9s8pt0ubl
	 zfsWfSfhCZ6Bf4YFLYiWCsSGoZZlRtqBHuxNgUvAUqLAfIg5z9shl3OYoJo/2h8uv8qBR
	 lV7VWbptHsE60UlyGOXBSpJfDt0GxkATrMQhLvBBpV42moCl6TvRz9Yxwxh9F+ITkn1W9
	 FJJYhYmD/6Ynn+UpoD46++uEx/2n0AZm+FjhCmOlfRf8aJKvMKmlRBkn7EimDgi0rLQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789219605;
	bh=qkNcxYDJgvVZ7mhKn5h2UVw8T27MNf/masta0kCMW+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=isB+Pn32mBmDXSIy7qGAOTUQQ/AzFt0CHJr1fTkptvDwqktB43EYlYE/w7XgoPC5x
	 ynaPq74V/As0StggrlS2vrinp1/qhiLtz0O2KapTkIuOA5DsAuW+ntK0RSljmr/Zsg
	 9Nh3sF7xapuwRpc5XEV//sW0t5XPriie0/sQw/7kW4eJDCgVa7W5Gj+5QA+rWyK9Ol
	 YsP8roWsRxvZeAcTyqZvP2gXEL8d4XqJRDkVnN4Z0wj0Wdsc6PKyvVCjtYuhorwY28
	 yszTAa+qVIG6XM6spMSMDQuiJcX+a0DqNOJya0RjOVTscFIEbQSXqDJj3EtUj+s99v
	 dwzl7ztiUH+NQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1A7CC40722;
	Sat, 12 Sep 2026 13:26:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7998C23F
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:45:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 601564009E
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:45:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QP1SNbQgoO4q for <u-boot@lists.u-boot-project.org>;
 Sat, 12 Sep 2026 12:45:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 6854E4007D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789217115;
 b=UdEeuYMxAuy2n+WRmoxa2niTHgsfwd8PsLoDWekXvJOD7FueHt2lJHSbiMggvutgO7O8
 HOhM1DmkCBJ4ESrFHVdy6rLNMdYqrcUWTmiyBk7mFPsoyHcf4s5e9vLsX0t0znXTo27VQ
 tQV+SF4d53OSpv3kGJzpMPl8dcvbfdjKAb9NQu1wt6XwIS1ZtFxC+4hzXdcd1mLOUyqF8
 afAGZHQoeF+1qQWUjiIygUh+ZM6OyPwnz0H02Ipyi1DXUwlYRs/w6DfOEYvj3adyV3DaF
 oskZMGEGaDYwN+yiE8OBjSQ19T7ilpjsUrSNdZ034jJl1NVVgfvg7kAaYKxtDKC2dUg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789217115;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=qkNcxYDJgvVZ7mhKn5h2UVw8T27MNf/masta0kCMW+Y=;
 b=sK1bH94G1OqNFbg6mVQzKU6WHibVChrasfAuq0vVSRMx4lf9hxvlnZL02NKZw8jqQc2b
 BsxOefbbbPiEwwNHlzjbKZmVhGyliaXFQDcUjB0bJ6G96ASZYN9XAjvTVnELPU6tMX5YE
 3PCGgRNh8fTM8mg+vPSocmeIwbzO8WOok6OJKWH8z0QcIkDOFt7JS0usIEbtw/G2nNiYV
 Tur2i7ysULJp8UfB+FFX1QYjsNiryqhPZWAKqsu3IPU516NQ1uIeKVeUDAQ6ZLtZZfvK7
 w9vVDa0X6Xbiuh6vjXH5wPI90w+eott/kci7qCxE6ixwhfedfBAq157Z0rZEN5YXtbQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=ILJGwqyw; 
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=ILJGwqyw
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6854E4007D
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:45:14 +0000 (UTC)
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EED343FE32
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1789217113;
 bh=qkNcxYDJgvVZ7mhKn5h2UVw8T27MNf/masta0kCMW+Y=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=ILJGwqyw+9LlZ7u7/xhhUXclN3nF1EMgmcrp2XOoZq0L1gYzhDtWkRhkKwSyvwhsB
 5vqG+qN0u7ObnwbyNYOw1aaxPh0Ezhz12c19D6Vat7s+8m1Syd9KoDJLenJA6VjvlR
 2tqvfezmfdz3pvK83GEGlaJUX4u24t9QctKhlcfByr3dxW0fIVnYsJddCV18IPE8l3
 iGuLLg80pmzlWQ35n3QrdgK9fe3Dy98RPPCGol903vx/BKI7kL2UqjjPYmAnP84BVD
 QqDnUJZZdMcxPDcIDAAyt+8ef7JYMPthOAOoRDAsDcwuujB+zgfZ8RRjezssdqoBIv
 EwQRUPDC4yCmZfrNoTMFWsfwZtzc+jxcmA4dyV0OmK/OUIQD2jtDbZpv6lJPpujSTW
 V8BZ3JTu6QW2/vIWUyrovm+D2xC6iYO1Sqlj0JYQhLFZD8mJDoMsoUL8jKAz7zpmX8
 BsEuGpSCherSfUvHITdPnXuYI+jXaS03g8cmlj70E+3VOogtmYdHmGVY7nKbTl/BzA
 3FckmlW9oBSLJ1NlEcfuapUFftLPI4rSbfwcjZpUP2XIs0jmjRJt7sTvhvR/iLoIl3
 J+BPHSoPEZxB1aJTCApuPhBJMw5N2izhiFT7rwPT3RcJpIS0jlZp7cACpFZ4pvKSzU
 sabB1Rk8EQFsK327tUgvWK0w=
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-869b8d63e28so2162852b3a.0
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 05:45:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789217111; x=1789821911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qkNcxYDJgvVZ7mhKn5h2UVw8T27MNf/masta0kCMW+Y=;
 b=cmnpfhNxo72sz8m4+JbQFM6chYkDLwe5O65xJhgII77StXcX/rBTlaxigAm8Rxul0n
 bscLZdojQ18J8f+Cko+TQk2yeHMfTXqf4fJ3wXGB0hMgpa5wX2Fsa8+z7dHhXx/z7plk
 MwvPJQ4GLFDuGtP6d686Q+a0WspVuBG9pteADsAy9t1hICIAL04oFITaGDwDp72agoe3
 utpPSKD91HLf0DN/BpTjDYFvRhKcaPknEDZuzBQSWyqYR0ad8JEIH9IaGc2MlGU+evLO
 lL8bsaB/zFC9lwhzDAutklMgMGE5TEGd3EK9lmSry5WkcOvCeHcGENz68rLQmTvIzxOF
 lbKw==
X-Gm-Message-State: AFuF++lXHYZ2qd57ueF6OP6SlqiYTgg4KpbBiCSMJ/7kpEanIm9jPyb7
 6+uN7kZ6UCIvHWGnNYO0oZcIFepYWXhzANbHTK5uGQzRRRfiaKsBpBfllIilw/7k/j3dDDEKfPg
 cObuBndbt8+pPV2NgYax8qiXyyeTvRaUNlGhxJ8jVvWNiUklIprIY3sPtAGiBkPSSqhNtOLm6Y7
 UNn+n59sO1gj8sXX6Kzw==
X-Gm-Gg: AYBFou2ymn+JvUFACQh+HAFAv0RZVzS7/m9Z+D3Jo25s1eGF+zCTXS/upd7ng+GPe2Q
 n+7loLKpZBoawuU7jeOqdc0Ci2RFE9i0ubsWaIqNCsWMgD5jXsetTJHuXwBgdxHY/rDTWpb8Y1n
 lDg5szElFjKemagbkzkDbjJR9WBzxNhp/Xac4jrSyD3lG2v+gAh1GGQ4Xl2emagj8TMV26NZO0g
 luvCMhCgQWWYlcaVfFydVB1Ep4cxDyw4qn+AX+zpv15hrJbu4+uuAzFFesfXFB4+T74uXF9vWXZ
 +yQUHk/nOjo9x1v4eQphpGhBpmCr5dhhAHNwgp6duv9/hVZcgZntxTSiRabTtTagXtaeeJaW3ba
 PIdfJD8H2ZqOsxNJ/dSkCSBR/SwFqrRehlvMeRACfGwSs9rHac1uuLXTndjKKSFsTug==
X-Received: by 2002:a05:6a00:148a:b0:848:2a71:a48a with SMTP id
 d2e1a72fcca58-86b32aebe34mr12764488b3a.13.1789217111402; 
 Sat, 12 Sep 2026 05:45:11 -0700 (PDT)
X-Received: by 2002:a05:6a00:148a:b0:848:2a71:a48a with SMTP id
 d2e1a72fcca58-86b32aebe34mr12764415b3a.13.1789217110896; 
 Sat, 12 Sep 2026 05:45:10 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86b291c5e8dsm2272101b3a.32.2026.09.12.05.45.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 05:45:10 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Daniel Golle <daniel@makrotopia.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 2/5] tools: mkimage: resolve image-data references between
 FIT images
Date: Sat, 12 Sep 2026 12:44:48 +0000
Message-ID: <20260912124454.13578-3-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260912124454.13578-1-aristo.chen@canonical.com>
References: <20260912124454.13578-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 12 Sep 2026 13:26:38 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

An image node may carry an 'image-data' property naming another image
node under /images whose binary data it shares. This lets several
configurations load the same payload at different addresses without
storing it twice, as described in the 'Shared image data' section of
the Flat Image Tree specification [1].

Resolve the references in mkimage after any external data has been
imported: the target's data is copied into the referencing node, so the
later ciphering, hashing and signing steps see a normal image node. The
property itself is retained in the resolved FIT as a record of the
sharing relationship. When mkimage re-processes a FIT that already
contains resolved references, the node's data must match the target's
data exactly.

A reference is rejected when the target does not exist, when the target
itself carries an image-data property (chained references), when the
node's existing data disagrees with the target, or when the node mixes
image-data with external data properties. Since encryption happens per
node, sharing encrypted data is only accepted when both nodes use the
same algorithm and key together with the same iv-name-hint or, when
neither uses a hint, the same explicit iv; anything else, including the
independent random IV generated when a node provides no IV at all,
would produce different ciphertexts.

[1] https://github.com/open-source-firmware/flat-image-tree

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 include/image.h   |   1 +
 tools/fit_image.c | 286 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 287 insertions(+)

diff --git a/include/image.h b/include/image.h
index 11af6f1d522..4d621815f59 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1180,6 +1180,7 @@ int booti_setup(ulong image, ulong *relocated_addr, ulong *size,
 #define FIT_DATA_POSITION_PROP	"data-position"
 #define FIT_DATA_OFFSET_PROP	"data-offset"
 #define FIT_DATA_SIZE_PROP	"data-size"
+#define FIT_IMAGE_DATA_PROP	"image-data"
 #define FIT_TIMESTAMP_PROP	"timestamp"
 #define FIT_DESC_PROP		"description"
 #define FIT_ARCH_PROP		"arch"
diff --git a/tools/fit_image.c b/tools/fit_image.c
index f7d11904472..de9f73ace3f 100644
--- a/tools/fit_image.c
+++ b/tools/fit_image.c
@@ -1169,6 +1169,287 @@ err:
 	return ret;
 }
 
+/**
+ * fit_props_equal() - Check whether a property is present and equal on
+ * two nodes
+ */
+static bool fit_props_equal(const void *fdt, int node_a, int node_b,
+			    const char *prop)
+{
+	const void *a, *b;
+	int len_a, len_b;
+
+	a = fdt_getprop(fdt, node_a, prop, &len_a);
+	b = fdt_getprop(fdt, node_b, prop, &len_b);
+
+	return a && b && len_a == len_b && !memcmp(a, b, len_a);
+}
+
+/**
+ * fit_check_shared_cipher() - Check cipher settings of images sharing data
+ *
+ * Two image nodes can only share binary data if their cipher settings
+ * produce identical ciphertext: either neither is encrypted, or both
+ * use the same algorithm, key and IV. The IV must be shared explicitly,
+ * through the same iv-name-hint or, when neither node uses a hint, the
+ * same iv value; anything else, including the independent random IV
+ * generated when a node provides no IV at all, would make the
+ * ciphertexts differ. A hint drives the encryption whenever it is
+ * present, so in that case the hints themselves have to match.
+ */
+static int fit_check_shared_cipher(const void *fdt, int node, int target,
+				   const char *name, const char *ref)
+{
+	int ncipher, tcipher;
+
+	ncipher = fdt_subnode_offset(fdt, node, FIT_CIPHER_NODENAME);
+	tcipher = fdt_subnode_offset(fdt, target, FIT_CIPHER_NODENAME);
+	if (ncipher < 0 && tcipher < 0)
+		return 0;
+
+	if ((ncipher < 0) != (tcipher < 0)) {
+		fprintf(stderr,
+			"Error: image '%s' shares data with image '%s' but only one of them is encrypted\n",
+			name, ref);
+		return -EINVAL;
+	}
+	if (!fit_props_equal(fdt, ncipher, tcipher, FIT_ALGO_PROP) ||
+	    !fit_props_equal(fdt, ncipher, tcipher, FIT_KEY_HINT)) {
+		fprintf(stderr,
+			"Error: image '%s' shares data with image '%s' but their cipher settings differ\n",
+			name, ref);
+		return -EINVAL;
+	}
+	if ((fdt_getprop(fdt, node, "data-size-unciphered", NULL) ||
+	     fdt_getprop(fdt, target, "data-size-unciphered", NULL)) &&
+	    !fit_props_equal(fdt, node, target, "data-size-unciphered")) {
+		fprintf(stderr,
+			"Error: image '%s' shares data with image '%s' but data-size-unciphered differs\n",
+			name, ref);
+		return -EINVAL;
+	}
+
+	if (fdt_getprop(fdt, ncipher, "iv-name-hint", NULL) ||
+	    fdt_getprop(fdt, tcipher, "iv-name-hint", NULL)) {
+		if (!fit_props_equal(fdt, ncipher, tcipher, "iv-name-hint")) {
+			fprintf(stderr,
+				"Error: image '%s' shares encrypted data with image '%s'; both must use the same iv-name-hint\n",
+				name, ref);
+			return -EINVAL;
+		}
+		return 0;
+	}
+	if (!fit_props_equal(fdt, ncipher, tcipher, "iv")) {
+		fprintf(stderr,
+			"Error: image '%s' shares encrypted data with image '%s'; both must use the same iv-name-hint or iv\n",
+			name, ref);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * fit_resolve_image_data() - Resolve image-data references between images
+ *
+ * An image node may carry an 'image-data' property naming another image
+ * node under /images whose binary data it shares. Copy the referenced
+ * node's data into the referencing node so that later steps (ciphering,
+ * hashing, signing and external-data extraction) see a normal image
+ * node. The property itself is retained in the FIT as a record of the
+ * sharing relationship.
+ *
+ * If the referencing node already has data (for example when mkimage
+ * re-processes a FIT it produced earlier), the data must match the
+ * target's data exactly; anything else means the FIT is malformed.
+ */
+static int fit_resolve_image_data(struct image_tool_params *params,
+				  const char *fname)
+{
+	void *fdt = NULL, *old_fdt;
+	int new_size, size, extra;
+	int fd;
+	struct stat sbuf;
+	bool found = false;
+	int ret;
+	int images;
+	int node;
+
+	fd = mmap_fdt(params->cmdname, fname, 0, &old_fdt, &sbuf, false, false);
+	if (fd < 0)
+		return -EIO;
+
+	images = fdt_path_offset(old_fdt, FIT_IMAGES_PATH);
+	if (images < 0) {
+		debug("%s: Cannot find /images node: %d\n", __func__, images);
+		ret = -EINVAL;
+		goto err_munmap;
+	}
+
+	/*
+	 * Work out roughly how much larger the FIT will get, and skip the
+	 * rewrite in the common case of no references. References that do
+	 * not resolve are left for the loop below to report.
+	 */
+	extra = 0;
+	fdt_for_each_subnode(node, old_fdt, images) {
+		const char *ref;
+		int target, len;
+
+		ref = fdt_getprop(old_fdt, node, FIT_IMAGE_DATA_PROP, NULL);
+		if (!ref)
+			continue;
+		found = true;
+		target = fdt_subnode_offset(old_fdt, images, ref);
+		if (target >= 0 &&
+		    fdt_getprop(old_fdt, target, FIT_DATA_PROP, &len))
+			extra += len + 64;
+	}
+	if (!found) {
+		munmap(old_fdt, sbuf.st_size);
+		close(fd);
+		return 0;
+	}
+
+	/* Allocate space to hold the enlarged FIT */
+	size = sbuf.st_size + extra + 1024;
+	fdt = calloc(1, size);
+	if (!fdt) {
+		fprintf(stderr, "%s: Failed to allocate memory (%d bytes)\n",
+			__func__, size);
+		ret = -ENOMEM;
+		goto err_munmap;
+	}
+	ret = fdt_open_into(old_fdt, fdt, size);
+	if (ret) {
+		debug("%s: Failed to expand FIT: %s\n", __func__,
+		      fdt_strerror(ret));
+		ret = -EINVAL;
+		goto err_munmap;
+	}
+
+	images = fdt_path_offset(fdt, FIT_IMAGES_PATH);
+	fdt_for_each_subnode(node, fdt, images) {
+		const char *name = fdt_get_name(fdt, node, NULL);
+		const char *ref, *data, *tdata;
+		void *copy;
+		int target, len, tlen;
+
+		ref = fdt_getprop(fdt, node, FIT_IMAGE_DATA_PROP, NULL);
+		if (!ref)
+			continue;
+
+		target = fdt_subnode_offset(fdt, images, ref);
+		if (target < 0) {
+			fprintf(stderr,
+				"Error: image '%s': image-data references undefined image '%s'\n",
+				name, ref);
+			ret = -EINVAL;
+			goto err_munmap;
+		}
+		if (fdt_getprop(fdt, target, FIT_IMAGE_DATA_PROP, NULL)) {
+			fprintf(stderr,
+				"Error: image '%s': image-data target '%s' has an image-data property itself; chained references are not permitted\n",
+				name, ref);
+			ret = -EINVAL;
+			goto err_munmap;
+		}
+		tdata = fdt_getprop(fdt, target, FIT_DATA_PROP, &tlen);
+		if (!tdata) {
+			fprintf(stderr,
+				"Error: image '%s': image-data target '%s' has no data\n",
+				name, ref);
+			ret = -EINVAL;
+			goto err_munmap;
+		}
+
+		ret = fit_check_shared_cipher(fdt, node, target, name, ref);
+		if (ret)
+			goto err_munmap;
+
+		data = fdt_getprop(fdt, node, FIT_DATA_PROP, &len);
+		if (data) {
+			if (len != tlen || memcmp(data, tdata, len)) {
+				fprintf(stderr,
+					"Error: image '%s': data does not match image-data target '%s'\n",
+					name, ref);
+				ret = -EINVAL;
+				goto err_munmap;
+			}
+			/* Already resolved */
+			continue;
+		}
+		if (fdt_getprop(fdt, node, FIT_DATA_OFFSET_PROP, NULL) ||
+		    fdt_getprop(fdt, node, FIT_DATA_POSITION_PROP, NULL) ||
+		    fdt_getprop(fdt, node, FIT_DATA_SIZE_PROP, NULL)) {
+			fprintf(stderr,
+				"Error: image '%s': image-data must not be combined with external data properties\n",
+				name);
+			ret = -EINVAL;
+			goto err_munmap;
+		}
+
+		/*
+		 * Copy via a temporary buffer since fdt_setprop() moves the
+		 * tree, including the target's data, while it works
+		 */
+		copy = malloc(tlen);
+		if (!copy) {
+			fprintf(stderr,
+				"%s: Failed to allocate memory (%d bytes)\n",
+				__func__, tlen);
+			ret = -ENOMEM;
+			goto err_munmap;
+		}
+		memcpy(copy, tdata, tlen);
+		ret = fdt_setprop(fdt, node, FIT_DATA_PROP, copy, tlen);
+		free(copy);
+		if (ret) {
+			debug("%s: Failed to write property: %s\n", __func__,
+			      fdt_strerror(ret));
+			ret = -EINVAL;
+			goto err_munmap;
+		}
+		debug("Resolved image-data of '%s' from '%s', size %x\n",
+		      name, ref, tlen);
+	}
+
+	munmap(old_fdt, sbuf.st_size);
+
+	/* Close the old fd so we can re-use it. */
+	close(fd);
+
+	fdt_pack(fdt);
+
+	new_size = fdt_totalsize(fdt);
+	debug("Size expanded from %x to %x\n", (int)sbuf.st_size, new_size);
+
+	fd = open(fname, O_RDWR | O_CREAT | O_TRUNC | O_BINARY, 0666);
+	if (fd < 0) {
+		fprintf(stderr, "%s: Can't open %s: %s\n",
+			params->cmdname, fname, strerror(errno));
+		ret = -EIO;
+		goto err;
+	}
+	if (write(fd, fdt, new_size) != new_size) {
+		debug("%s: Failed to write FIT to file %s\n", __func__,
+		      strerror(errno));
+		ret = -EIO;
+		goto err;
+	}
+
+	free(fdt);
+	close(fd);
+	return 0;
+
+err_munmap:
+	munmap(old_fdt, sbuf.st_size);
+err:
+	free(fdt);
+	close(fd);
+	return ret;
+}
+
 /**
  * fit_handle_file - main FIT file processing function
  *
@@ -1234,6 +1515,11 @@ static int fit_handle_file(struct image_tool_params *params)
 	if (ret)
 		goto err_system;
 
+	/* Resolve image-data references between images, if any */
+	ret = fit_resolve_image_data(params, tmpfile);
+	if (ret)
+		goto err_system;
+
 	/*
 	 * Copy the tmpfile to bakfile, then in the following loop
 	 * we copy bakfile to tmpfile. So we always start from the
-- 
2.43.0

