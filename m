Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F53CA5FA1
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 00:22:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EE8B54057E;
	Tue, 29 Sep 2026 00:22:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RJSJ863ZBiim; Tue, 29 Sep 2026 00:22:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A1D7740580
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790641330;
	b=Qu3S9vYPlr2tyO7YTg3/eYHjdSorC+uRcU33ox7Dv2hdgDuizQaSmjPB+IM+mUpHjwo2
	 D+HW/DTzNRbvV5IKfN9e0REqYhNZ4X0uErpavwOHsC0g7G0gs3723ekGb47AJASFHjUzy
	 RhZOWha7BV8X23Jt+fTFGck0dxX8FeCJicnpTpHANt93mvZ30hX9vaeWcdrfhqZJQohhH
	 545o3ZbTCPSdcTt0S9Dh2o/EXZoMeP4vkYMyapxZg+p9/hhGaMHzQ0o1NVEn4/LNelrf/
	 s12VL8WrtBLvqc9vp8F4ojJfIior5HbwmT+uegdJSSgrbhIRneDS4QK0A+QRqRyIgng==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790641330;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=JubcqXUDaCpQouqiTEGEPKTpZESsXV2B3UO9SR/UFAQ=;
	b=iDsSo4BqThelQ5kNMyVVrqzGD3jBRwOlkHI8W29Xpi0TDAh4JdaX4I/YDDXz01IgltBf
	 XIkJ3pGDPQ5kVq8Ux74/tOhV2o1BHnByxzjb+KPk/H/BPkQ29LqxxHICZGtRMhBzKPune
	 JEz77cLUSskdNKT4U8gtAb8kDm7klPGAocdWOlI2bQQi1Eg90XnnpPPxLqnjU0JibopFH
	 ZMo+mBZswbzlx1N6+cakqog+LHvyoXWXwzMp2uSF111urczMab+8jDJ+ovpmtnYISUqP1
	 qBc3L8VQ0HwVhYdHUPL/j2gQT313R5z1D1/Hamz80vyosanYB83fhQjhh2on52PVCuw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790641330;
	bh=JubcqXUDaCpQouqiTEGEPKTpZESsXV2B3UO9SR/UFAQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VCgkTO6PQ7Ij/GlzuQvYOGZH0WMIqfni26MQBoaDL1cWTRAM0QK3V+Fdu5a4qiOVU
	 GlnVlCQYNxIZmW/E4Pz+rCEMiXZn692H2y16IgjF2SaQ7Nr8iXbMXBCeNDUq9RihpV
	 HBET1sTFGRCfABvQThpbFaEyQ+uiKUoPHiLwEyYtD91AYiW/DVI9/i6z/RkmjPsb/r
	 eKOhLp+fyAzarpH6LPP76OZqHwHqqN+0r/VQEsgng9l1cyy0HntqXPPFNWbjq9jes3
	 sMnEqrcHIqO3GfGVbdZJHdZ7e/vfi5V2eYZS5c0CE2V4MQq+aXeG05gBfRCmvdbciB
	 /ysvShfE6qj/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A1D7740580;
	Tue, 29 Sep 2026 00:22:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2530A335
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:22:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 09B1260740
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:22:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e1_rkHIpezIX for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 00:22:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A44F56072D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790641324;
 b=EMfNWFdEEgWjEiVsMNvdF7K1gTMP+q2gtEUip3gVnDRmFboi0ckkDvHGVaAiWeqezAMW
 f0H5N55KV1xZ//dwIS95SJSwGmLszbMJsCIyXTSBd4JjKcD83a62LqYJl11YJ7HbEXxYi
 qc/F2KNBiAVMjiFm3b1yQNYwkjrZzgaek9WiH9kcIeAEDpGal7YKveHSK0P28eh/zzGmM
 LdSfaqYb1TTuSLQ94esSyzEEdLquTWuyOX2LJEX6OOqkzrqlrL6hGEgUV3FWVxI+3f/Fp
 lzI7quBwq13IvF3b5p6CZDeeE8eEvKdI7MAxLc0XZsO13kx5NJob7pqiCbqS2zf/aZA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790641324;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=JubcqXUDaCpQouqiTEGEPKTpZESsXV2B3UO9SR/UFAQ=;
 b=dVzqHpmv0la0DVNQpHOgN6zMGW36ZDbU7jTho8hXqqlqY8Xy12kXDj4wtFk3wqWjk0r8
 siFbFgEF1dQtZrM4U2rQu4K+C3DImM7D6yAzplIM+LVeh5e6/ZBJjkkNdY1g8Iwq/Rvpj
 61nQ5LyE1+vymDEvUJR1VB5r/q2h/b9RvPE0UD5umWYVA8S29yooSo1W6/jdd35rQGyJR
 0w+UGt8pBL2hMYZdOIFLoV5JMa2Ox4IwMXuaomGq5ixMyH1MDdBvi6CAEbETdsp6GkUnd
 00CxtpEhJdJf5yjPlCxDO/juo9O0NEug7ByfW+qoT/WnvjnyNmfRCFuvzTdFKSlFkIw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=qb+D1N9H; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2b; helo=mail-oo1-xc2b.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=qb+D1N9H
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A44F56072D
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:22:04 +0000 (UTC)
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-6d821901872so503523eaf.1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 17:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790641323; x=1791246123;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JubcqXUDaCpQouqiTEGEPKTpZESsXV2B3UO9SR/UFAQ=;
 b=qb+D1N9HVFPSdUE+t7poxCWg2dgYAM4YZZgC/Z9YusluelLkzsDPnQsFCbWf7d6QVu
 0dpI9tk02ObcCSZi3i559cahQ+kC6ToolkC2MjCrb710hwEqQf9c1/g+MBtK9fRB5LYQ
 oB9zAcZi8H7yqoGodBfQcICy1cx79rDpit/E81crJz290Jm/2TsduBQhIGXUN06QPILc
 8h9GbJyeAbpChI2PlXHHso1S/+5P4B3LRmMhXU3T+OSNg8i2h0OiWabTw5AaMH9N9dpZ
 6OXSjkzxK1kuFqUVhf5Ysh24eWLeEdVGxi9mmpP6MaZsltjCte21IAXjuBrjsCRMEy9U
 8i3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790641323; x=1791246123;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JubcqXUDaCpQouqiTEGEPKTpZESsXV2B3UO9SR/UFAQ=;
 b=ob8oOGQ4XAGnd2QZV025a8SnuktPWsHQRZ1V1xAPHirwQeYHbOtOjMrlLyixzDSNwY
 APToBAry+s9VNbBW/6PIy3i0V7eEpWDJazf7ufgT25dNZH3IGlOCOw0a9bDCQhoFyiRo
 /dPW6uZGMaDfgHx7BrpltyzpFKDHuyHHu0ota6hBFuXiCUNqTNkKWwqchykkrPOJ8acy
 jmb1axe8z02KKFPaF3sqhiDaJdeNBVfZrrGn1YAxlDDsRrRFhOust2O7Qxbn5ASPpBhy
 Qqqhl7gWR0lj6coIlDNMFsIvXhyQhZaAvvpA9mjKpNmqaE9J25LVZUbzNESM4N5Q22Le
 +pKQ==
X-Gm-Message-State: AFuF++kWtzbAmwa2vje7oh5PN8Q3eFKzgB2S9VJezxClHy2FjN03OPGr
 +4ZKstJPHcshTd1JQcTPz9gFB/q1CwkThDgFhfZom1mZVT9ccxgzrwDo
X-Gm-Gg: AYBFou3uzXBoEDPqmPc4qOGQnf4k4WzJbX8dtTcfuVAOSO9g/NtJMeNIiA+JljvdAAw
 sAMljV4nd2KVujACEVl87rHHS5QDeohAJLLdjDOhrNYoEv5PRlEmW4DekVdz/E2o6cuHOCsyR2D
 iUtAqsTNXOXuz6kj6Zuyivw90vKZv5Es52jJAe/OziIX+aC5+8BWCzaoqpUM2cddQjt60X7vJaB
 DnJWb/tHLJt3ukr5I/sR5xfShEevVdJ9fbKCylL95pG1cCDgEC/HNFRbvLpMbx0oWZV1cNSEcYG
 ofvqNwU/h0pZV550D2uNWn+Xyinrb4PrNT6eWij9i1H3OtPqG5dgji6UoLh7Lu7HPIFpyOB9lDO
 B681/MwsN/T8z+z/9WbANKI9YByeM/2XMNBBARfGbMFSnx0FSJVVSPz4FXkpkwvOt1uIOgrAP9+
 TWAvdlmHJJ3QBt0hK2NfOfd76V4eMgnH9gzMn7l8PhefyRO7fg65zRl+fVUsIzYrHU1okOR594K
 x13LCtSB1wPzLllzRXA3AAT9tyxqtenyasY0FREo0wHH7i0jMn+nPWKdbstFVI31ssTDjrIk7IT
 HbR2Z27EguREE+uXomyUhf1pHmfOklJmgQKlY8unbdKF2P34LQ6eqrBkN5ZnP5WlHk2aqEeo2cs
 gMMfyZTekg7087st5AZP/
X-Received: by 2002:a05:6820:f030:b0:6d7:892e:919f with SMTP id
 006d021491bc7-6db1146f983mr566685eaf.2.1790641323034; 
 Mon, 28 Sep 2026 17:22:03 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-494877590e5sm8175688fac.13.2026.09.28.17.22.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 17:22:02 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 28 Sep 2026 18:21:44 -0600
Subject: [PATCH 07/20] test: net: exercise lwIP DHCP boot option handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-lwip-dhcp-v1-v1-7-2060c7365b0c@gmail.com>
References: <20260928-lwip-dhcp-v1-v1-0-2060c7365b0c@gmail.com>
In-Reply-To: <20260928-lwip-dhcp-v1-v1-0-2060c7365b0c@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Michal Simek <michal.simek@amd.com>, Johan Jonker <jbx6244@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Francois Berder <fberder@outlook.fr>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Peter Robinson <pbrobinson@gmail.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, 
 Heiko Schocher <hs@nabladev.com>, Pranav Tilak <pranav.vinaytilak@amd.com>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
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

Exercise real DISCOVER/OFFER/REQUEST/ACK exchanges in sandbox,
including overload and concatenation, rejected replies, explicit
filenames, signed offsets, fragmented NTP addresses, and maximum
outgoing option lengths.

Validate replies split across chained pbufs as well as complete
Ethernet frames. Check that malformed replies cannot publish staged
metadata and that absent options leave the configured defaults intact.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 test/dm/Makefile            |   1 +
 test/dm/lwip_dhcp_options.c | 408 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 409 insertions(+)

diff --git a/test/dm/Makefile b/test/dm/Makefile
index a15f8333d07..00e2e52af59 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -54,6 +54,7 @@ obj-y += lwip.o
 endif
 ifeq ($(CONFIG_NET_LWIP)$(CONFIG_CMD_DHCP),yy)
 obj-y += lwip_dhcp.o
+obj-y += lwip_dhcp_options.o
 endif
 ifeq ($(CONFIG_NET_LWIP)$(CONFIG_NETCONSOLE),yy)
 obj-y += netconsole.o
diff --git a/test/dm/lwip_dhcp_options.c b/test/dm/lwip_dhcp_options.c
new file mode 100644
index 00000000000..eeb273da964
--- /dev/null
+++ b/test/dm/lwip_dhcp_options.c
@@ -0,0 +1,408 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright 2026 James Hilliard <james.hilliard1@gmail.com> */
+
+#include <command.h>
+#include <dm.h>
+#include <env.h>
+#include <lwip-dhcp.h>
+#include <malloc.h>
+#include <net.h>
+#include <asm/eth.h>
+#include <asm/unaligned.h>
+#include <dm/test.h>
+#include <lwip/apps/sntp.h>
+#include <lwip/dhcp.h>
+#include <lwip/prot/dhcp.h>
+#include <test/ut.h>
+
+enum dhcp_reply_kind {
+	DHCP_REPLY_BASIC,
+	DHCP_REPLY_OVERLOAD,
+	DHCP_REPLY_EMPTY,
+	DHCP_REPLY_BAD_STRING,
+	DHCP_REPLY_TRUNCATED,
+	DHCP_REPLY_BAD_XID,
+	DHCP_REPLY_BAD_SIZE,
+	DHCP_REPLY_ZERO_OFFSET,
+	DHCP_REPLY_BAD_NTP,
+	DHCP_REPLY_ROOT_OVERFLOW,
+};
+
+struct dhcp_options_test {
+	enum dhcp_reply_kind kind;
+	unsigned int discover;
+	unsigned int request;
+	bool requested[256];
+	char hostname[256];
+	char vendor[256];
+	bool chain_failed;
+};
+
+static bool dhcp_options_chain_check(struct dhcp_msg *reply, size_t len,
+				     enum dhcp_reply_kind kind)
+{
+	static const unsigned int splits[] = { DHCP_FILE_OFS + 4, DHCP_OPTIONS_OFS + 3 };
+	err_t expected = kind == DHCP_REPLY_BAD_STRING || kind == DHCP_REPLY_TRUNCATED ||
+		kind == DHCP_REPLY_BAD_SIZE || kind == DHCP_REPLY_BAD_NTP ||
+		kind == DHCP_REPLY_ROOT_OVERFLOW ? ERR_VAL : ERR_OK;
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(splits); i++) {
+		struct pbuf *head, *tail;
+		err_t ret;
+
+		head = pbuf_alloc(PBUF_RAW, splits[i], PBUF_RAM);
+		tail = pbuf_alloc(PBUF_RAW, len - splits[i], PBUF_RAM);
+		if (!head || !tail) {
+			if (head)
+				pbuf_free(head);
+			if (tail)
+				pbuf_free(tail);
+			return false;
+		}
+		pbuf_take(head, reply, splits[i]);
+		pbuf_take(tail, (u8 *)reply + splits[i], len - splits[i]);
+		pbuf_cat(head, tail);
+		/*
+		 * Exercise the application parser with a value split between pbufs.
+		 * Normal packet delivery below still exercises ACK acceptance.
+		 */
+		ret = net_lwip_dhcp_ack(netif_default, netif_dhcp_data(netif_default), head);
+		pbuf_free(head);
+		if (ret != expected)
+			return false;
+	}
+
+	return true;
+}
+
+static u8 *dhcp_test_option(u8 *pos, u8 code, const void *value, u8 len)
+{
+	*pos++ = code;
+	*pos++ = len;
+	memcpy(pos, value, len);
+
+	return pos + len;
+}
+
+static int dhcp_options_reply(struct udevice *dev, struct dhcp_msg *request,
+			      u8 type, enum dhcp_reply_kind kind)
+{
+	struct eth_sandbox_priv *priv = dev_get_priv(dev);
+	struct dhcp_options_test *test = priv->priv;
+	static const u8 server[] = { 1, 1, 2, 2 };
+	static const u8 mask[] = { 255, 255, 255, 0 };
+	static const u8 lease[] = { 0, 0, 0x0e, 0x10 };
+	static const u8 size[] = { 0, 42 };
+	static const u8 offset[] = { 0xff, 0xff, 0xf1, 0xf0 };
+	static const u8 ntp[] = { 10, 0, 0, 1, 10, 0, 0, 2 };
+	struct ethernet_hdr *eth;
+	struct ip_udp_hdr *ip;
+	struct dhcp_msg *reply;
+	u8 *pos;
+	size_t len;
+
+	if (priv->recv_packets >= PKTBUFSRX)
+		return -ENOSPC;
+	eth = (void *)priv->recv_packet_buffer[priv->recv_packets];
+	memset(eth->et_dest, 0xff, ARP_HLEN);
+	memcpy(eth->et_src, priv->fake_host_hwaddr, ARP_HLEN);
+	eth->et_protlen = htons(PROT_IP);
+	ip = (void *)(eth + 1);
+	memset(ip, 0, IP_UDP_HDR_SIZE);
+	reply = (void *)(ip + 1);
+	memset(reply, 0, sizeof(*reply));
+	reply->op = DHCP_BOOTREPLY;
+	reply->htype = 1;
+	reply->hlen = ARP_HLEN;
+	reply->xid = request->xid;
+	if (kind == DHCP_REPLY_BAD_XID)
+		reply->xid ^= htonl(1);
+	memcpy(reply->chaddr, request->chaddr, sizeof(reply->chaddr));
+	put_unaligned_be32(0x01010203, &reply->yiaddr);
+	put_unaligned_be32(0x01010204, &reply->siaddr);
+	reply->cookie = htonl(DHCP_MAGIC_COOKIE);
+	pos = reply->options;
+	pos = dhcp_test_option(pos, DHCP_OPTION_SERVER_ID, server, sizeof(server));
+	pos = dhcp_test_option(pos, DHCP_OPTION_SUBNET_MASK, mask, sizeof(mask));
+	pos = dhcp_test_option(pos, DHCP_OPTION_LEASE_TIME, lease, sizeof(lease));
+	if (kind == DHCP_REPLY_BASIC || kind == DHCP_REPLY_BAD_XID) {
+		strcpy((char *)reply->file, "header.bin");
+		pos = dhcp_test_option(pos, 12, "leased", 6);
+		pos = dhcp_test_option(pos, 17, "/srv/root", 9);
+		pos = dhcp_test_option(pos, 40, "example.test", 12);
+		pos = dhcp_test_option(pos, 13, size, sizeof(size));
+		pos = dhcp_test_option(pos, 2, offset, sizeof(offset));
+		pos = dhcp_test_option(pos, 42, ntp, sizeof(ntp));
+		/* A trailing NUL is legal and must not become part of the path. */
+		pos = dhcp_test_option(pos, 67, "option.bin", sizeof("option.bin"));
+	} else if (kind == DHCP_REPLY_OVERLOAD) {
+		u8 overload = DHCP_OVERLOAD_SNAME_FILE;
+		u8 *field;
+
+		pos = dhcp_test_option(pos, 52, &overload, 1);
+		pos = dhcp_test_option(pos, 17, "/srv", 4);
+		pos = dhcp_test_option(pos, 67, "subdir/", 7);
+		pos = dhcp_test_option(pos, 42, ntp, 1);
+		field = dhcp_test_option(reply->file, 17, "/root", 5);
+		field = dhcp_test_option(field, 67, "overloaded.bin", 14);
+		field = dhcp_test_option(field, 42, ntp + 1, 2);
+		*field = DHCP_OPTION_END;
+		field = dhcp_test_option(reply->sname, 17, "/fs", 3);
+		field = dhcp_test_option(field, 42, ntp + 3, sizeof(ntp) - 3);
+		*field = DHCP_OPTION_END;
+	} else if (kind == DHCP_REPLY_ZERO_OFFSET) {
+		static const u8 zero[4];
+
+		pos = dhcp_test_option(pos, 2, zero, sizeof(zero));
+	} else if (kind != DHCP_REPLY_EMPTY) {
+		/* None of these candidate values may escape a rejected ACK. */
+		pos = dhcp_test_option(pos, 12, "poisoned", 8);
+		pos = dhcp_test_option(pos, 17, "/wrong", 6);
+		pos = dhcp_test_option(pos, 67, "wrong.bin", 9);
+		if (kind == DHCP_REPLY_BAD_STRING)
+			pos = dhcp_test_option(pos, 67, "\0bad", 4);
+		if (kind == DHCP_REPLY_BAD_SIZE)
+			pos = dhcp_test_option(pos, 13, size, 1);
+		if (kind == DHCP_REPLY_BAD_NTP) {
+			pos = dhcp_test_option(pos, 42, ntp, 1);
+			pos = dhcp_test_option(pos, 42, ntp + 1, 2);
+		}
+		if (kind == DHCP_REPLY_ROOT_OVERFLOW) {
+			u8 root[255];
+
+			memset(root, 'r', sizeof(root));
+			pos = dhcp_test_option(pos, 17, root, sizeof(root));
+		}
+	}
+	/* Exercise custom options before the message-type option. */
+	pos = dhcp_test_option(pos, DHCP_OPTION_MESSAGE_TYPE, &type, 1);
+	if (kind == DHCP_REPLY_TRUNCATED) {
+		*pos++ = 67;
+		*pos++ = 20;
+	}
+	*pos++ = DHCP_OPTION_END;
+	len = pos - (u8 *)reply;
+	if (type == DHCP_ACK)
+		test->chain_failed |= !dhcp_options_chain_check(reply, len, kind);
+	ip->ip_hl_v = 0x45;
+	ip->ip_len = htons(IP_UDP_HDR_SIZE + len);
+	ip->ip_ttl = 64;
+	ip->ip_p = IPPROTO_UDP;
+	memcpy(&ip->ip_src, server, sizeof(server));
+	ip->ip_dst.s_addr = htonl(0xffffffff);
+	ip->udp_src = htons(67);
+	ip->udp_dst = htons(68);
+	ip->udp_len = htons(UDP_HDR_SIZE + len);
+	ip->ip_sum = compute_ip_checksum(ip, IP_HDR_SIZE);
+	priv->recv_packet_length[priv->recv_packets++] = ETHER_HDR_SIZE + IP_UDP_HDR_SIZE + len;
+
+	return 0;
+}
+
+static int dhcp_options_tx(struct udevice *dev, void *packet, unsigned int len)
+{
+	struct eth_sandbox_priv *priv = dev_get_priv(dev);
+	struct dhcp_options_test *test = priv->priv;
+	struct ethernet_hdr *eth = packet;
+	struct ip_udp_hdr *ip;
+	struct dhcp_msg *msg;
+	u8 *pos, *end, type = 0;
+	int ret;
+
+	if (!sandbox_eth_arp_req_to_reply(dev, packet, len))
+		return 0;
+	if (len < ETHER_HDR_SIZE + IP_UDP_HDR_SIZE + DHCP_OPTIONS_OFS ||
+	    ntohs(eth->et_protlen) != PROT_IP)
+		return 0;
+	ip = (void *)(eth + 1);
+	if (ip->ip_p != IPPROTO_UDP || ntohs(ip->udp_dst) != 67)
+		return 0;
+	msg = (void *)(ip + 1);
+	pos = msg->options;
+	end = (u8 *)packet + len;
+	while (pos < end && *pos != DHCP_OPTION_END) {
+		u8 code = *pos++, size;
+
+		if (code == DHCP_OPTION_PAD)
+			continue;
+		if (pos == end)
+			return -EINVAL;
+		size = *pos++;
+		if (size > end - pos)
+			return -EINVAL;
+		if (code == DHCP_OPTION_MESSAGE_TYPE && size == 1)
+			type = *pos;
+		if (code == DHCP_OPTION_PARAMETER_REQUEST_LIST) {
+			unsigned int i;
+
+			for (i = 0; i < size; i++)
+				test->requested[pos[i]] = true;
+		}
+		if (code == DHCP_OPTION_HOSTNAME || code == DHCP_OPTION_US) {
+			char *str = code == DHCP_OPTION_HOSTNAME ? test->hostname : test->vendor;
+
+			memcpy(str, pos, size);
+			str[size] = 0;
+		}
+		pos += size;
+	}
+	if (type == DHCP_DISCOVER) {
+		test->discover++;
+		/* An offer must not publish its metadata when the ACK omits it. */
+		return dhcp_options_reply(dev, msg, DHCP_OFFER, DHCP_REPLY_BASIC);
+	}
+	if (type != DHCP_REQUEST)
+		return 0;
+	test->request++;
+	ret = dhcp_options_reply(dev, msg, DHCP_ACK, test->kind);
+	if (!ret && test->kind >= DHCP_REPLY_BAD_STRING &&
+	    test->kind != DHCP_REPLY_ZERO_OFFSET)
+		ret = dhcp_options_reply(dev, msg, DHCP_ACK, DHCP_REPLY_EMPTY);
+
+	return ret;
+}
+
+static int dhcp_options_check(struct unit_test_state *uts, struct dhcp_options_test *test)
+{
+	char * const argv[] = { "dhcp", "2000000", "explicit.bin" };
+	char long_name[257];
+	int kind;
+
+	ut_assertok(env_set("ethact", "eth@10002000"));
+	ut_assertok(env_set("autoload", "no"));
+	ut_assertok(env_set("bootp_vci", "U-Boot.test"));
+	for (kind = DHCP_REPLY_BASIC; kind <= DHCP_REPLY_ROOT_OVERFLOW; kind++) {
+		bool have_ntp = IS_ENABLED(CONFIG_BOOTP_NTPSERVER) &&
+			(kind == DHCP_REPLY_BASIC || kind == DHCP_REPLY_OVERLOAD);
+		ip_addr_t old_ntp;
+
+		if (CONFIG_IS_ENABLED(CMD_SNTP))
+			ip_addr_copy(old_ntp, *sntp_getserver(0));
+		if (kind == DHCP_REPLY_BAD_NTP && !IS_ENABLED(CONFIG_BOOTP_NTPSERVER))
+			continue;
+		if (kind == DHCP_REPLY_BAD_SIZE && !IS_ENABLED(CONFIG_BOOTP_BOOTFILESIZE))
+			continue;
+		if (kind == DHCP_REPLY_ROOT_OVERFLOW &&
+		    (!IS_ENABLED(CONFIG_BOOTP_BOOTPATH) || CONFIG_BOOTP_MAX_ROOT_PATH_LEN > 261))
+			continue;
+		*test = (struct dhcp_options_test){ .kind = kind };
+		ut_assertok(env_set("bootfile", "default.bin"));
+		ut_assertok(env_set("hostname", "original"));
+		ut_assertok(env_set("rootpath", "/original"));
+		ut_assertok(env_set("domain", "original.test"));
+		ut_assertok(env_set("ntpserverip", "9.8.7.6"));
+		ut_assertok(env_set("timeoffset", "123"));
+		ut_assertok(do_dhcp(NULL, 0, 1, argv));
+		ut_asserteq(1, test->discover);
+		ut_asserteq(1, test->request);
+		ut_assert(!test->chain_failed);
+		ut_assertnull(netif_default);
+		ut_asserteq_str("1.1.2.3", env_get("ipaddr"));
+		ut_asserteq_str("U-Boot.test", test->vendor);
+		ut_asserteq_str(IS_ENABLED(CONFIG_BOOTP_SEND_HOSTNAME) ? "original" : "",
+				test->hostname);
+		ut_assert(test->requested[67]);
+		ut_asserteq(IS_ENABLED(CONFIG_BOOTP_HOSTNAME), test->requested[12]);
+		ut_asserteq(IS_ENABLED(CONFIG_BOOTP_BOOTPATH), test->requested[17]);
+		ut_asserteq(IS_ENABLED(CONFIG_BOOTP_BOOTFILESIZE), test->requested[13]);
+		ut_asserteq(IS_ENABLED(CONFIG_BOOTP_NISDOMAIN), test->requested[40]);
+		ut_asserteq(IS_ENABLED(CONFIG_BOOTP_TIMEOFFSET), test->requested[2]);
+		ut_asserteq(IS_ENABLED(CONFIG_BOOTP_NTPSERVER), test->requested[42]);
+		ut_asserteq_str(kind == DHCP_REPLY_BASIC ? "option.bin" :
+				kind == DHCP_REPLY_OVERLOAD ? "subdir/overloaded.bin" :
+				"default.bin", env_get("bootfile"));
+		ut_asserteq_str(kind == DHCP_REPLY_BASIC && IS_ENABLED(CONFIG_BOOTP_HOSTNAME) ?
+				"leased" : "original", env_get("hostname"));
+		ut_asserteq_str(!IS_ENABLED(CONFIG_BOOTP_BOOTPATH) ? "/original" :
+				kind == DHCP_REPLY_BASIC ? "/srv/root" :
+				kind == DHCP_REPLY_OVERLOAD ? "/srv/root/fs" :
+				"/original", env_get("rootpath"));
+		ut_asserteq_str(kind == DHCP_REPLY_BASIC && IS_ENABLED(CONFIG_BOOTP_NISDOMAIN) ?
+				"example.test" : "original.test", env_get("domain"));
+		ut_asserteq_str(have_ntp ?
+				"10.0.0.1" : "9.8.7.6", env_get("ntpserverip"));
+		if (CONFIG_IS_ENABLED(CMD_SNTP)) {
+			if (have_ntp)
+				ut_asserteq_str("10.0.0.1", ipaddr_ntoa(sntp_getserver(0)));
+			else
+				ut_assert(ip_addr_cmp(&old_ntp, sntp_getserver(0)));
+		}
+		ut_asserteq_str(!IS_ENABLED(CONFIG_BOOTP_TIMEOFFSET) ? "123" :
+				kind == DHCP_REPLY_BASIC ? "-3600" :
+				kind == DHCP_REPLY_ZERO_OFFSET ? "0" : "123",
+				env_get("timeoffset"));
+		ut_asserteq(kind == DHCP_REPLY_BASIC && IS_ENABLED(CONFIG_BOOTP_BOOTFILESIZE) ?
+			   42 : 0, net_boot_file_expected_size_in_blocks);
+	}
+	*test = (struct dhcp_options_test){ .kind = DHCP_REPLY_BASIC };
+	ut_assertok(do_dhcp(NULL, 0, 3, argv));
+	ut_asserteq_str("explicit.bin", env_get("bootfile"));
+
+	/* Maximum option values fit; a larger value is rejected before sending. */
+	memset(long_name, 'x', sizeof(long_name));
+	long_name[255] = 0;
+	ut_assertok(env_set("bootp_vci", long_name));
+	ut_assertok(env_set("hostname", long_name));
+	*test = (struct dhcp_options_test){ .kind = DHCP_REPLY_EMPTY };
+	ut_assertok(do_dhcp(NULL, 0, 1, argv));
+	ut_asserteq_str(long_name, test->vendor);
+	if (IS_ENABLED(CONFIG_BOOTP_SEND_HOSTNAME))
+		ut_asserteq_str(long_name, test->hostname);
+	long_name[255] = 'x';
+	long_name[256] = 0;
+	ut_assertok(env_set("bootp_vci", long_name));
+	*test = (struct dhcp_options_test){};
+	ut_asserteq(CMD_RET_FAILURE, do_dhcp(NULL, 0, 1, argv));
+	ut_asserteq(0, test->discover);
+	ut_assertnull(netif_default);
+
+	return 0;
+}
+
+static int dm_test_lwip_dhcp_options(struct unit_test_state *uts)
+{
+	static const char * const vars[] = {
+		"ethact", "autoload", "bootp_vci", "hostname", "domain", "rootpath",
+		"bootfile", "timeoffset", "ntpserverip", "ipaddr", "netmask", "gatewayip",
+		"serverip", "tftpserverip", "dnsip", "dnsip2",
+	};
+	struct dhcp_options_test test = {};
+	ip_addr_t old_ntp;
+	char bootfile[sizeof(net_boot_file_name)];
+	u32 expected_size = net_boot_file_expected_size_in_blocks;
+	char *saved[ARRAY_SIZE(vars)] = {};
+	int i, ret = -ENOMEM;
+
+	if (CONFIG_IS_ENABLED(CMD_SNTP))
+		ip_addr_copy(old_ntp, *sntp_getserver(0));
+	for (i = 0; i < ARRAY_SIZE(vars); i++) {
+		const char *value = env_get(vars[i]);
+
+		if (value) {
+			saved[i] = strdup(value);
+			if (!saved[i])
+				goto out;
+		}
+	}
+	memcpy(bootfile, net_boot_file_name, sizeof(bootfile));
+	sandbox_eth_set_tx_handler(0, dhcp_options_tx);
+	sandbox_eth_set_priv(0, &test);
+	ret = dhcp_options_check(uts, &test);
+	sandbox_eth_set_tx_handler(0, NULL);
+	sandbox_eth_set_priv(0, NULL);
+	memcpy(net_boot_file_name, bootfile, sizeof(bootfile));
+	net_boot_file_expected_size_in_blocks = expected_size;
+	for (i = 0; i < ARRAY_SIZE(vars); i++)
+		if (env_set(vars[i], saved[i]))
+			ret = -EINVAL;
+out:
+	if (CONFIG_IS_ENABLED(CMD_SNTP))
+		sntp_setserver(0, &old_ntp);
+	for (i = 0; i < ARRAY_SIZE(vars); i++)
+		free(saved[i]);
+
+	return ret;
+}
+
+DM_TEST(dm_test_lwip_dhcp_options, UTF_SCAN_FDT);

-- 
2.53.0

