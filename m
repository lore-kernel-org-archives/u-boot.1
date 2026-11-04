Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591EE606B2EE
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 21:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zCg8pQh7;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=HpQLxzTL
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DA24240988;
	Wed,  4 Nov 2026 21:23:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4O7whwYBi7sr; Wed,  4 Nov 2026 21:23:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DDCCA40981
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793827422;
	b=mZ9BvB+I2nkUTwCJYfvDtwt0dDsgTHPsWNRLSPAJom1TzmsGYzUOkMv8knF2jvm1rDDQ
	 dFkCszvDvg12DU4/Dm4l2cTtc4dZ58oryl7jVVibhA14qUsEd0j1N1/1c2fjEPKWQELEz
	 cbxnUCxDdKY8GwCochhjmHWRwlk+Rqb14doEdUypi98vtno4u+1QqjHWmhdt6LWjcktOS
	 nPan6rv84uUn60bxlul4A5G/oOhFt8p4QpoTn1uxriynx6xHCM8w9mQNxdS7NBObhRRpC
	 pAbwTw/7eTIys0PqlPEYTzGK/OOJR/Lo9F7C5wwV2kLcWZNwDPdU2FMix+8ZvTn0xSw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793827422;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=JqXLHca+GuXl/vMVdb9sZUmszzkctpGX0kZNtbArk1I=;
	b=FKje7m2hjbKagHUfvbcShiNAyMaru0GquHU3F5NReYVdRZW1PVY9l0PQ0G/FuNk7McrF
	 JGdriuWqlUrJmXlXh/vcunmO9XFfUY4j8oX19hGGKIZhGdAy6UEUTf9ZY1x1lWETmqmGE
	 JaFOyDM7OT3vJDvb4jEqqqh2aHkXJKfIXgEpSzBmAaKXtwgjrCqljLGz9YMCYtRp7+r2n
	 V3tIZCjkfhGT0Xob3jGJ6QBWnWvo5Bfxe8SKYTkC9+IXpdQfPhXCNhWjWtNmMD29yOM9x
	 Ku54B/WSKH6r/N+aI1ODDea16GqsG1akWjkBamJX1OKU64fMq86KTOqwOoMFRoaIOjg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=HpQLxzTL;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793827422;
	bh=JqXLHca+GuXl/vMVdb9sZUmszzkctpGX0kZNtbArk1I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zCg8pQh7Bz5J+7JgwGnF3n+hVAAHp1Ki3L46YT5cosGQAZ/BpBzu01fFooNwc+47/
	 gnNMExSmrsxH5wrJP5lNj0WhirwRH0OZ86G7yidxZAgfUpAp1Gnp9CbWKlQ5DrAkjn
	 Sz3rYUW9MPz7kcCMvLk6xMJVNmjQXY7uNj6c3go0GIASGCEbe961Pxm2MnNMKOsVsH
	 4SUgIPgsbOZM47jJdgL8niTEps1fq7oJuBODfgi7j7DOnawpjSCiRgT77AZwwIqlIH
	 cP9bc4lZx4ALfOWQEAw0Y9cdCCSv2B/eXUypOAsh8ckzU4+8gi58zImvmuocxaKsn5
	 k1KSphPUw9zOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DDCCA40981;
	Wed,  4 Nov 2026 21:23:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A668BD3A
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 21:23:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8BE1C40960
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 21:23:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u5w812zw4WsY for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 21:23:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 00F2D40963
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::332; helo=mail-ot1-x332.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=HpQLxzTL
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 00F2D40963
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 21:23:38 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-8451a619da7so792411a34.1
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 13:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793827417; x=1794432217;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JqXLHca+GuXl/vMVdb9sZUmszzkctpGX0kZNtbArk1I=;
 b=HpQLxzTLm7tOOdfSsfVAdp3uGMEADjxNGk7j6NrnHstK44a22rQ1buWvYSLrImpfdV
 JhcNzzQjQTVNuE3DFqlZRJz69aVSg40+rM/TnkkLFVfq0XgXtFBJM4EFm30R1LuQ92xL
 YZZigCBaTAWstLiZxUfYYUCV5ObcdpU2/9W4aJ95gK0LBkanr4zW0Axv9v0jalVK3t1s
 p5GN0rFrBQibikAeeJXF2VUgGmzGsS/NgMLRz7rXzrz2trocVk8EjBjBQPeJxKNfmyUc
 4eIbJdcuMg+FRoQZPhv1poVB2Q2aKzzKN0V96ppmh8lai9sMZEHKeeoNB5RuL5ePDBwL
 AP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793827417; x=1794432217;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JqXLHca+GuXl/vMVdb9sZUmszzkctpGX0kZNtbArk1I=;
 b=XlZaJ38+7jTwcAAzNvH66I7X9SSXhQFmQHgUE+FzhW2Qhe02v6fqZKsYzJ02+sJ6ba
 BX711Bfj1aGydOmMFhKVn0lvuvsVfSdtFtYVe6yTGykK9pG3P77Rf5h/1Czd5sTXC0pl
 QuyDWMrUl3k93Dz7UaN3DlHpP8FcEVHFvMzT5PvHaMUh+dCM2arglI7dBbnjOLJQzDw/
 hHFXjX81CttCelXYp435JImKEl6w8MFUj9XkhqrDbR1F+/vJsDSSa1j6OOiBNs3eY1Yn
 cfoTmN1PiadL1ErH+W9PNFkvCHWRCmr6lNhNyEce2eU6EwlZDpxCyOIQAFm+43F9RhaW
 19SQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxprzV9heZDoy8eABhFcdV/LD5QYqJLnqvyPf4GGe++dfAEDA4Q23H6sR7SRi8Ea0iPs6klbRQ=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9VMVOvIGJ68kLbuwrrrDUHi0iyqQeWhJgIgj23/2J/jGLgLdh+
 MQ0v9wFr3/pQq/Eu6Q1pfuAGwEzzLm9YfcYrQ4/tkmpoyIrutEGWztZ+3W5FbYYaIIs=
X-Gm-Gg: AYBFou0X/WnIotj6Um6e1gwp51vPF3PSCpKbumCAy19GKz+kaq2vwu3HmJKpmfLeU0o
 7EtX9kdFbYY9ki/C1/ZOfNLvoR/Y9i/4ytiDuyP1scpqkMOQrcKL8M0Q3RqWSY4J30vNcnnYKY7
 d6sarHSWRn3vo9aE7JrUbY/FyVC5K64Ru0u6SalXuPuQuDmg5N2NSSq8QXYNYpRSyO9YhdEVOpA
 QA4lptQ/gzQfYFeQA8RR1l6HZl0v8AySrq6ZF1M4Zi6VZYDB82g2o0DhaQWcIhJEiMttj0/AESI
 1POZryGKnsWxIal0iAfdebH0QQwtzUta4nalR9QTS5pCEkByjsl35AbwO3Ev45OjhfU2sPo8E/4
 LlxZpxmkEsBIuqD+/HSizY4UKpGfPISN67OxANr2R83ItWbo18UJ48fMQG21+xyTeqWTvpA6FTv
 zmUvJRwvDXM21GLHukiRKqpWjBE+14DP0sP+ZJvMm4LvzR0TzeWErEeOQ6GaS1Hp6l5Hqpb+h0s
 Yiad+29am/MM2IOfZJYiKf/xSut4/MJQ/TMSQyq7u21VmJdIkvCuI5E5g0IJ96RPwcG4IuCdZz1
 lP+AAy81UPTBt0OkFOWYnCXFnpViclpF
X-Received: by 2002:a05:6808:1383:b0:4d5:27da:a496 with SMTP id
 5614622812f47-5640dea5a02mr13005508b6e.48.1793827417352; 
 Wed, 04 Nov 2026 13:23:37 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:f563:d5d:661c:51ed])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4ad6840797dsm845548fac.9.2026.11.04.13.23.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 13:23:35 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 04 Nov 2026 15:23:08 -0600
Subject: [PATCH 1/2] bloblist: align the used size before adding a record
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-bloblist-tl-fixes-v1-1-477121908257@baylibre.com>
References: <20261104-bloblist-tl-fixes-v1-0-477121908257@baylibre.com>
In-Reply-To: <20261104-bloblist-tl-fixes-v1-0-477121908257@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Raymond Mao <raymondmaoca@gmail.com>, 
 Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>, 
 Carlo Caione <ccaione@baylibre.com>, Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2777; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=Ot9XjA/6yzJRPT0PEF3/AWRON5Rcd6LTw6dhx+ljXb4=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq66JF4y8K/EquF8EleiDS/tzXIqUIn73ACDrmw
 BToMnzWLjGJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCauuiRRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Ap/cH/2e+pNKaVUB9VhuBynrhQcb8ALz64nJEVCJ51Wl
 Q5PnFrvC/gj5XgOaEhr3pZbIkw0ewxbUWXK8fxsz+gxByvKtQncpHHcFdUow/Iw99IWJ3RE5FzS
 qCOYVNAH23arp62BTPnMI9HnPEo/6n/8HR7o1IXScQiiP5fK4XL92+cCBOFJqLlNaN7wxW/M1YK
 HKdYzNTTXpoK96gWoJOJEkxzUKomU6PSR7qeP0Zt4G7H5SlOTG0wmRBzSdQNPBzfqqMOeqFfckN
 ZDGhZpEtxd47pC5feC1tjpXgrNf2dJi5Q4hMPHZ1zZs89n4S2dMToSqa7mirpCxjXradoMkUJnR
 ZjHs=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Adjust the used size of the bloblist up to the record alignment before
adding a record.

A transfer list from another boot stage can have a used size that ends
with the data of its last entry, which does not have to be a multiple of
8 bytes. TF-A's transfer list library creates lists like this. The next
entry still starts 8-byte aligned.

With such a list, bloblist_addrec() works out an alignment gap that is
smaller than a record header and tries to fill it with a void record of
negative size. That call sees the same used size, so it recurses until
the stack overflows.

Fixes: f9ef9fb033d5 ("bloblist: Handle alignment with a void entry")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 common/bloblist.c      |  6 ++++++
 test/common/bloblist.c | 25 +++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/common/bloblist.c b/common/bloblist.c
index 846c8047f74..4ddb4a56944 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -169,6 +169,12 @@ static int bloblist_addrec(uint tag, int size, int align_log2,
 	if (!align_log2)
 		align_log2 = BLOBLIST_BLOB_ALIGN_LOG2;
 
+	/*
+	 * The data of the last record does not have to end aligned, but the
+	 * next record starts aligned.
+	 */
+	hdr->used_size = ALIGN(hdr->used_size, BLOBLIST_BLOB_ALIGN);
+
 	/* Figure out where the new data will start */
 	data_start = map_to_sysmem(hdr) + hdr->used_size + sizeof(*rec);
 
diff --git a/test/common/bloblist.c b/test/common/bloblist.c
index 797bde27025..ef410ca62fc 100644
--- a/test/common/bloblist.c
+++ b/test/common/bloblist.c
@@ -360,6 +360,31 @@ static int bloblist_test_align(struct unit_test_state *uts)
 }
 BLOBLIST_TEST(bloblist_test_align, UFT_BLOBLIST);
 
+/* Test adding a record after one whose data does not end aligned */
+static int bloblist_test_align_used_size(struct unit_test_state *uts)
+{
+	struct bloblist_hdr *hdr;
+	char *data;
+
+	hdr = clear_bloblist();
+	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0, 0));
+	data = bloblist_add(TEST_TAG, TEST_SIZE, 0);
+	ut_assertnonnull(data);
+
+	/* Another boot phase may end the used size with the data */
+	hdr->used_size = map_to_sysmem(data) + TEST_SIZE - TEST_ADDR;
+	ut_assert(hdr->used_size & (BLOBLIST_BLOB_ALIGN - 1));
+
+	data = bloblist_add(TEST_TAG2, TEST_SIZE2, 0);
+	ut_assertnonnull(data);
+	ut_asserteq(0, map_to_sysmem(data) & (BLOBLIST_BLOB_ALIGN - 1));
+	ut_asserteq_ptr(data, bloblist_find(TEST_TAG2, TEST_SIZE2));
+	ut_assertnonnull(bloblist_find(TEST_TAG, TEST_SIZE));
+
+	return 0;
+}
+BLOBLIST_TEST(bloblist_test_align_used_size, UFT_BLOBLIST);
+
 /* Test relocation of a bloblist */
 static int bloblist_test_reloc(struct unit_test_state *uts)
 {

-- 
2.53.0

