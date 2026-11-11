Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AB3606A321
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 20:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tRFlbLug;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RGTOw3m1
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3110E60DF7;
	Wed, 11 Nov 2026 20:11:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 38mU-BjLwQre; Wed, 11 Nov 2026 20:11:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D1DFE60DFA
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794427888;
	b=REPo9tO8PQy4uCs/hjJatto0PmY2acYtwnLVSNP0Z0NDSDOQgHap5S00U5SNJChBaxzJ
	 hU+nI9SVjtsfqu6R7WWjANDVZljWbUWbs6mGtfm82zZwcz/2lOjsPe9w1Lnld3/FReRj1
	 mx8xT57+SHRBfUMUYP2ol0FeqR6uLwHowFqUNrZkA3vZJgtXlniUDzedY8Gz/oIsgV49W
	 n48D4BQNvn2lbzRS5+zDM1V86R0pmu11H3LRo9D/ZLt8LypL0I6lAs5K59zWLGaz5tvgD
	 7RpauJVz7zmI2+ag4zJwvlnbpeHXvAq8p+pjfLY4Ow9tCGtL8AhltUiQMwEatYKzhnQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794427888;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xFDdqt9dBqwKpmApG0mhQUwprMvG0RAGolPDxnvhBhI=;
	b=nauNXq7BP35Mf4Jb191D0AtYgtP1yduXYHxg+Nm616INhQTS+Uk+dVWLvgv8uwXwaSrK
	 mvu4KQ9fb1ZGp4gXe/s+qycj6Qv6vHnh4pLDIi1qJJZR807AmlEzKSiH5uM7Mtwsykj24
	 kYo+O2k2QZ5xvtn3KgNw2uRbbInFLEdL1sraB/++iDrRD+9wSyhJnxfqnwGU3E4uuhTQx
	 eGG53/YJ9xnXdCJiCpRrII7UTGOalUwUifNRCPh1CgTKtHm0KmsOeYAqopXOX6vi2UslZ
	 I+3xhgzKBLxpcr4/VQrkxdONCq++2lgsJBJirTaEavllFYhByUGo2A+HCqLNgyrKlFw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794427888;
	bh=xFDdqt9dBqwKpmApG0mhQUwprMvG0RAGolPDxnvhBhI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tRFlbLugWy2b8/kg07f/xVrmS7RFNO6a9Znl3p5BdzbGX0sslScv6Y5BgqiCuNrmJ
	 M7zLGz71r1z6Tgm+xBIHl8AdxW0dbOABbCWUQOt7H3GXOfzL4hwghFyrgHuGDLeNpZ
	 Oof2uUEpuTZgfNeuia2seIwnMyndiZs9aH/OoHZdUt7AKdA1qSy6RURGfY/jYOGklh
	 /9JEq2DYLn4znxBXoswPdmsyZqfMsxhmRW8pEaKokOL3cl/LG1KF5CxI/+KiD0OQrt
	 +/yfRYwE5Pr1Vb/Zh1RreMf3btTHEAS4mdDJpWEHsEtFqL17VbgJiEgXjpsnqzbGFl
	 4lSrwsJxOSUcw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D1DFE60DFA;
	Wed, 11 Nov 2026 20:11:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 31055EC3
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 22D8540931
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rNKG9qGMLx-m for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 20:11:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 51E73408F9
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22d; helo=mail-oi1-x22d.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=RGTOw3m1
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 51E73408F9
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:21 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-4af173320f9so2072427b6e.2
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 12:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794427881; x=1795032681;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xFDdqt9dBqwKpmApG0mhQUwprMvG0RAGolPDxnvhBhI=;
 b=RGTOw3m1TAw300UbpsI13/4R1coYOoaYDr2ljYwB5IDkrUJg9smzehSRjIVSIB7pST
 jsfF4AY5iPYu552Hv+lmevtxaCIkz/7+yo1m7EucPHTA4lUGFRsY8Lgwx7U/XjDTW7J9
 //Ypv1aIEw4H2plGvymLk0DggYx+6cTtNGqgTbqpOvcg6E0iaD4aiMj1WtnhlSe7EWeS
 WBgIX4QO/8fknCOoK2uxnit3Gpxaupe3IHWGJJ9YM9XcUGf7Wr8Op5FfSaCq8Ah24+eo
 Kw8Tu67WWPyJyNCRf11sG8lKJRPapo3tcYqZLHI/OVd/SGjrryj41GPL7q/D/obwVInj
 4GdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794427881; x=1795032681;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xFDdqt9dBqwKpmApG0mhQUwprMvG0RAGolPDxnvhBhI=;
 b=C5fL9JvAQczyZBP40H+JqY4YXP8UUuM8MdLmhlI+6DnVPX1k0ouTqIXjNBXsv7/p62
 UNi6dO35ijqul5ukktk9Wle+XzJRB73f5hd9BRL2sdas91VNl6Qd2Rq7ecKSBKoGGLGc
 XKpJg6yH1wfH94ta3RavLLpy2wh46fFjCoM7uZXvQByKiaLC+smWxlO0SQd4ShAxfECr
 3OngLgea2ulZVyvToFgOfghEB3SZBKHITRLYqX68O6z66RYMsKzjXCubybLKVqT+DK6D
 3Kq7h/AOehWzW05NRQk3ffgt2I27D25aY6tze6tZB3kkU/Iq9uHh5yQpVAVxy4YPR41w
 +7rQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHtmCuS3ghFgh6qe9CiQlJ0bDyOkIXup+Q2LZglvLvoxsK/QyppFO13Eskj9Ro7V/EhD+az7Wg=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/hHliotNFzO86v8AgYgbCwQXpBdm65tIi/bpEGhB/Jy2gLqqA2
 xEvEWoxwgnFZfxjZt/TT4ihENwD9nSlCaAHto2shzm19FOJM/bDmIEkM
X-Gm-Gg: AYBFou00ktw2OE2DgsUmGincA6OTNF9gOHBS3I0dLG67BxIgVXKussNAWfLrsYKXsYN
 mPPLc3G+YyGjN22JTubhoQWk7xNplwT1732Fo/Yvg3MqEtsXNo+EIZqzM+Y6LGfvnjg/kLMCNmL
 JIRAXV07Zd8EkBzSoDQNvZTHQVkAQjy1/U+SpD+ma2uP/TUK+kWXZ4FaBCoJ84299jX7Pv7XGOe
 gRYDjLkAcGYA7+uKTyDDcUFYu3SIfGO0EIqBd6nl/gCANIURRVhSDK4KOn0K00dNQvrUNudRIKW
 x51+7S4Ve47gdxgDxd7fk2JW5UVO6JyawoZJdjs576rjeJqsIDOyfi1mpxi/Ha6ldTyg1Xvk9id
 ipLSbR52woYSvndd03TFtwVq8zawSDzTDm22YiVCNxVex4uAVyo3yairb+J8O7Hmt92XIq91JW0
 BVJuWDO++FVDzDNZM/inpYPOf+hA693O3XmJuPKr5rhwldlKwv3G5mY8v/+shDnOf9uUsCQo1yQ
 BLxtnPIsl66W+eicLPDeQ2L6DF/+cP3juMeDdQOKJxXbtgkobi1ciGnQrZAaPRuj18jRNIJU7TV
 ZrL4vSYmafiJeqD4h0G0H8PRSkc1Mk+ATfk+6la2BRguu3oSKSQHwhjm1L4M2mVVLzT9rt4A58c
 5Zd6tBVtsUi3znkS6A7S22KvPR3SsW5xCtKlyc6J0UV5BLjOdbBL/7bcI54j9fl2deTJMXeyay1
 PioXvtBpzJqnWAhKTrGhuA1vLguZHUoTJAnoQBTUZ/KRmtaAjeA9Y=
X-Received: by 2002:a05:6808:1583:b0:4d5:295c:a82f with SMTP id
 5614622812f47-56b97c173famr3137259b6e.60.1794427880670; 
 Wed, 11 Nov 2026 12:11:20 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-56905d3bab2sm5863446b6e.12.2026.11.11.12.11.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 12:11:20 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 11 Nov 2026 13:11:10 -0700
Subject: [PATCH 03/19] cmd: wget: map CA certificate buffers before copying
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-submit-lwip-ipv6-v1-v1-3-eb0ee8f8da1a@gmail.com>
References: <20261111-submit-lwip-ipv6-v1-v1-0-eb0ee8f8da1a@gmail.com>
In-Reply-To: <20261111-submit-lwip-ipv6-v1-v1-0-eb0ee8f8da1a@gmail.com>
To: Jerome Forissier <jerome.forissier@arm.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Igor Velkov <iav@iav.lv>, 
 Naveen Kumar Chaudhary <naveen.osdev@gmail.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, Murtaza Munaim <murtaza@saramena.us>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Drew Kluemke <ankluemk@microsoft.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The cacert command takes a physical load address, not a C pointer. Map
the input buffer before copying it so certificates loaded into sandbox
RAM can be used for HTTPS authentication.

Clear the stored pointer and length after releasing the old certificate
buffer. Allocation failure must not leave a dangling certificate pointer
for the next request or update.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 cmd/lwip/wget.c | 17 ++++++++++++-----
 test/dm/lwip.c  | 23 +++++++++++++++++++++++
 2 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/cmd/lwip/wget.c b/cmd/lwip/wget.c
index 531e886e986..c29b30ebe59 100644
--- a/cmd/lwip/wget.c
+++ b/cmd/lwip/wget.c
@@ -4,6 +4,7 @@
 #include <command.h>
 #include <env.h>
 #include <image.h>
+#include <mapmem.h>
 #include <net.h>
 #include <lwip/altcp_tls.h>
 
@@ -47,12 +48,11 @@ static int _set_cacert(const void *addr, size_t sz)
 
 	if (cacert)
 		free(cacert);
+	cacert = NULL;
+	cacert_size = 0;
 
-	if (!addr) {
-		cacert = NULL;
-		cacert_size = 0;
+	if (!addr)
 		return CMD_RET_SUCCESS;
-	}
 
 	p = malloc(sz);
 	if (!p)
@@ -102,11 +102,18 @@ static int set_auth(enum auth_mode auth)
 static int set_cacert(char * const saddr, char * const ssz)
 {
 	ulong addr, sz;
+	const void *p;
+	int ret;
 
 	addr = hextoul(saddr, NULL);
 	sz = hextoul(ssz, NULL);
 
-	return _set_cacert((void *)addr, sz);
+	if (!addr)
+		return _set_cacert(NULL, 0);
+	p = map_sysmem(addr, sz);
+	ret = _set_cacert(p, sz);
+	unmap_sysmem(p);
+	return ret;
 }
 #endif
 
diff --git a/test/dm/lwip.c b/test/dm/lwip.c
index 4dd4a562434..d152294d6f8 100644
--- a/test/dm/lwip.c
+++ b/test/dm/lwip.c
@@ -1,12 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0+
 /* Copyright 2026 James Hilliard <james.hilliard1@gmail.com> */
 
+#include <command.h>
 #include <console.h>
 #include <dm.h>
 #include <env.h>
 #include <lwip/pbuf.h>
 #include <lwip/udp.h>
 #include <lwip/timeouts.h>
+#include <mapmem.h>
 #include <net.h>
 #include <time.h>
 #include <asm/eth.h>
@@ -25,6 +27,9 @@
 #include <lwip/apps/http_client.h>
 #include <lwip/priv/tcp_priv.h>
 #endif
+#if CONFIG_IS_ENABLED(WGET_CACERT)
+#include <lwip/altcp_tls.h>
+#endif
 
 struct lwip_test_eth_hdr {
 	u8 dst[ARP_HLEN];
@@ -490,3 +495,21 @@ out:
 }
 
 DM_TEST(dm_test_lwip_restart, UTF_SCAN_FDT | UTF_CONSOLE);
+
+#if CONFIG_IS_ENABLED(CMD_WGET) && CONFIG_IS_ENABLED(WGET_CACERT)
+static int dm_test_lwip_wget_cacert(struct unit_test_state *uts)
+{
+	void *buf = map_sysmem(0x20000, 8);
+
+	memset(buf, 0, 8);
+	unmap_sysmem(buf);
+	ut_asserteq(CMD_RET_FAILURE, run_command("wget cacert 20000 8", 0));
+	ut_assert_nextlinen("Could not parse certificates");
+	ut_assertnull(cacert);
+	ut_asserteq(0, cacert_size);
+	ut_assertok(run_command("wget cacert 0 0", 0));
+	ut_assert_console_end();
+	return 0;
+}
+DM_TEST(dm_test_lwip_wget_cacert, UTF_SCAN_FDT | UTF_CONSOLE);
+#endif

-- 
2.53.0

