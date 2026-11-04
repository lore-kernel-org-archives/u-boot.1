Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F736606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 04:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vVd52JS8;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K6XqDd3Q
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3E61D80D34;
	Wed,  4 Nov 2026 04:48:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IHWEk6iRKHxp; Wed,  4 Nov 2026 04:48:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5B12F80D6F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793767705;
	b=RQl37ipO4RFvqZhEL6B7KJX5AGQBohPpJglUEZlG9NTFVdhr5nCFrNYMk5yS+TFLGPLd
	 UIddf6maebBg0KWrUVIoKwuj8nToHsg8mGjxz4Gu2SamiEBljlGQagXkpvqxwWqfp0urx
	 ymt5jJeDvK3WmgiFH1A1fG+KUuOrIAOUlDXkAMtRbIBIe8G1GqMV9d5AwNXA1/quywR8D
	 44oFBU+c4AQktEs+9IHrIOsC2Y7F76G92lfFoymG5J45gYvWoSwXPyMgkncsoNvUt7nnU
	 JvEM4nQYHxhvFSH+mg8rOZuKlxXBHLj+I5eqC7mAcE3m3ItxMS5NYui2fYpNRvmhuew==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793767705;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:From:X-Mailer:MIME-Version:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=X7ui5cyWM8acpgCSEzszRKTLhZOPyjGaw010y33ErRo=;
	b=frgLa/WwfPTKJcXKOFPTvJcp3e0kryOhbSge+1lrCYQqFN4IKeyaZiZahUcherve+wrF
	 UTO8CV+X/hdbSGSSReHJr0YsUTPMows/qZvzuUFFM/txAsZcRUC6veTdAQ4m8hsCD8b/T
	 uWgskJD6aAGTfHS60/ecxK+hWz82Px2P6gKuw07U8oOShwM/kZmVjii0k/gRedSF99ley
	 AhqVMYZnLiTbkspeaxLKBog8MBUZz5SIyHUM9Ct5UghDoicSTzAuzCDbAJIBbeswdaYnS
	 s4kBq4i5/OAVd6l0LMPe+orNhIGuMLkTnCC+Tg5U2Gkbl+EjW48LdHvnjPZI24YvYbQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793767705;
	bh=X7ui5cyWM8acpgCSEzszRKTLhZOPyjGaw010y33ErRo=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vVd52JS88usHr1SjzCvWz2LPF9DOSIeWtD9LoQZpz12KYrT8QkzbnhV0z3dpypGgp
	 z8py6XPACFDWCFhq9BRG5+gTf/c8Cxy8FZloba3JODifb8IvvtFMQ1iPV5D+LFSBTR
	 PJ91jiGZxhF5by6hJ3mjl0VG9DWGgiErmjZRhn6acRlZRixc00OGI9WcGC+F9iWlS1
	 i8AGPEOvbYxYaE4fFgO16tZ2A6LBHee287soCUCBe8Wxs/4JSOvWFMYsPr4ay99eGk
	 YFiTx2I57Wk7qHAyRET1m6j/IH0Qr2672zVnSh8NwAH8fXOeTYLiK3IwILqtJBf+OI
	 ODBTpiE71Yjiw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5B12F80D6F;
	Wed,  4 Nov 2026 04:48:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D1529C4
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 04:33:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3ECF760698
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 04:33:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cVBUAEpXG3I8 for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 04:33:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 59EC5605FA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::82d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793766797;
 b=TLIvKGAJiLH0LS8eP89DbQXCtq4Jk/nujEx2jH42jC1FyWyz2zn1fRDOdILOfNjZ9XF2
 1oMR+MXWlzOBkuuWYK3J/1oe6Y7TNh3tzwr1VVzsPaHqi1wxrUJ7oouCxgRr+9mlDXhmr
 +IeuD/3Hzh2bp4Xuj2dGBVoFuS2YATSvtNO1AwH7/gkTPDOrWJtZNdyk60axLHgI7ISy0
 q/Z5CJuQl7JxOaJMvTdUGx2GImWJS5mmq5u40dDJxaDZMP1LrWhSToIdBimAbWEmMdz4B
 2c4zrtcUoLMXYPlD4L4os3jVzaa4YNM/Rfv4VIi9UrJYQN6YOhlOduP2Mc+h77BpUPg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793766797;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:X-Mailer:
 MIME-Version:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=X7ui5cyWM8acpgCSEzszRKTLhZOPyjGaw010y33ErRo=;
 b=NVgzDTaa/9vvWse5gt9iy/pVbJzpcjpEDKoMD/uAvzlUIRO6/eW6KGaPb67oHWYt/JDv
 Rl5ECWioIktt3JT1lpWtbeiEhmnCQEFQKBBiJqFjLGqN2nrX95uM+ZDoMEqZlyE+axlE/
 vq6yZXPFF+z9ZzjTD2fewrCZ71LhMwjeTxSk0nSusJNYIXB4VyGv8oOmRQpX8OK3JcwQ8
 Tb6b9fX69RptPDGDQkyZP7ae7deKhhnCVrIPJnSd+dmErF9f5pF0fJTVkIpNGW7Wsqb3D
 PD7ts0D2iOAWezfZzWfeDGe3Z9ORVEtykOhlmQJrG0zZ1DbX94pqmMkSpZglcbp5NFg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=K6XqDd3Q; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::82d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::82d; helo=mail-qt1-x82d.google.com;
 envelope-from=terryzhou05@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=K6XqDd3Q
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 59EC5605FA
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 04:33:16 +0000 (UTC)
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-54465f79af8so2113701cf.0
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 20:33:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793766795; cv=none;
 d=google.com; s=arc-20260327;
 b=f4nZjcAj3/4agiWWs7zBTS5GevVdYIE/Kk6Qu4VKOHXjR5XTWomqdvbXYkDqJhff1f
 i7ZydkBykmgD30Yds08nt7EQlCGI04Xwzpw1qCq2mx9g02jjfHNqlNS7vOrs9FETrG7q
 RYi/YCBGJ0vPzEN/csd8yWiNy0rUTJ+INGxhJrJXfVowZku81R2O3H1toQvd383RSnCp
 c+qzbS5JO5CePMAVpcwLM006xvBoWWltJcBsB+Gpe0XfuK74O2CqzNMbB4jWM0Uk24NJ
 eq+fAa2v9fUGkwIxoZxx2hmaBmo4LvZxVskcfcssO3Ai8gcYT1x/6JFiiAas9eaqo3Qu
 p+ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
 bh=X7ui5cyWM8acpgCSEzszRKTLhZOPyjGaw010y33ErRo=;
 fh=Y3MsZH0cSWeGYWzA5SrfTMETvEcmDvw/86LY6+22Rek=;
 b=mYNPqW15VIn5EnwzxYF0mFKkXKnGXnqPuUhS6Jw8BdJpDFiDwq4Pp+Rm+3OYcXvkWo
 VZC574+ZfKXF3YTEEm60k76XKlKZhQkpJsJV4UWLpAypxybyceq2+1U04Oxv7OgNZj4h
 N7mN2zJReRAoFnJj2Tg1oz8rLY94GBPmKH4m2NYouYAzuubrJsBcSlW0tv/dWQCUOMny
 uHCjjdo0RpEunYpOz15O86ke8eby6prxdCSrFTfr+uOJ3yJ8VDkBwCCOAwJkm9gWoAvD
 JOCL8k1kFHyVI9D0WkXZZS+/afF40kbbhH7IOFfPcwweK8QBo4scdmXnbx2NYMdD2j9Z
 t1hg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793766795; x=1794371595;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:mime-version:from:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=X7ui5cyWM8acpgCSEzszRKTLhZOPyjGaw010y33ErRo=;
 b=K6XqDd3QUrLWuKypWu3sJ/rEPjI9Y8ovODkPBBkFU8yjVUsP+JdOO47Wg9/qnDuXu3
 X2leXuN0KzMcm6rrdUD9IRg3Z9awomH0oQYhMdXb/LKzas84yRyhWMBNsY7AUbib2O8t
 aMUrVwK80SxUbL0y0FbRKnczCuyks+NZTOeZDGBJebx5kZ1XacRxsBioJilwHX4kTVQI
 h2EQ8+2yP1vv+ee3ciOTpnnfrLDLJIXEcM3POevQ5r2qmHnvowSbuhogxFqXJSja3DzS
 u6mQ9p1wKMP24jisdfBgUzr4ye/hAHkIb5gI4nFLoOUYBKHSCq2PSO9JNFG7lOEMjwZK
 xUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793766795; x=1794371595;
 h=content-type:cc:to:subject:message-id:date:mime-version:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=X7ui5cyWM8acpgCSEzszRKTLhZOPyjGaw010y33ErRo=;
 b=gmEfvwsU5Q87sScTOtV6ZY3kEdG9OCNXaUCS26ZKXXJw4qT0WXjyd06MB8lK4HZEqD
 YT3Tl1xd4qH8iKXKDJhz/Mq+nbup0YGjHOkMbNCmju9Z6lxDLWF0P9SkOjx/HiRwPtDw
 I2joEz7gLHj6btFtPdJjcHqZWYZHt2vSmwE27iDAKT4I9PeV+5MlNI67rizUvjJJXWVS
 vk71NB+60w1z4AVuNhJRwVpZ/CUhDp4oGQSMnxFkfnGTjPoFkTtCCUrH4IfbPkw1EBFn
 MDHb4mudKGbvII+ytmdkTFfOczWUtCqnY1ap5K3BJE7D99wNTvzjFeSJMlIY6Q1ggvqL
 Gb2Q==
X-Gm-Message-State: APuU4Z/Cp43dbGaWiqVyjULX72crlaFWrqeT3CrOJhg2peBn4UIbby+5
 DBzQGwpIKdO3mu1/liT9hF9ZA2rERIlbnNYFXk5scFVt8c8XvLZtPONCotqYxQsuBoRhtOeje2Y
 jtFJtzLp1ivCPV2h7Z0EvqEGFgcpy4wGsirOr
X-Gm-Gg: AYBFou2kTyifaAVVgi/nBxOuV60OvBedQUH77cV/ANg8TMvlXuwh0jXnwkTZaMPojun
 ffoE0UJfwZ+h+U9cXxhwqHfD+2ip3aJABlLMy1V02J+i/qOwCPoj3r6JR6ch8gDEXuC9Y9yOsLi
 pivqcmxrRw/z9XMWVIEWAm2hOXeoGdxrDGx2pKJPEomUPWoyy0L/UtRVbAADumKbPUAiWsnL7nW
 b3rs4IHXl//5jjbONIX6YNWzXJyTOJu+5xDDlOB9s5Ioo9dUiejpBELYe5uQe5mtz/ZSNpaZVOa
 ZPDhFN/PE0nZCwDoYOnratqJi7BWjOxZbMGmyxEfNV57YRAttl1EGKTtauEH1EW+CoJeemWk7pD
 KEKXTB+SojWHg2tS4eTfnxAPcQ4M7rrlMSDq91bSXVChdpO1MkO1jt0l6cg==
X-Received: by 2002:a05:622a:1f12:b0:537:deab:afe0 with SMTP id
 d75a77b69052e-542b3e68d89mr211434271cf.10.1793766795359; Tue, 03 Nov 2026
 20:33:15 -0800 (PST)
Received: from 274731240883 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Nov 2026 20:33:13 -0800
Received: from 274731240883 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Nov 2026 20:33:13 -0800
From: "Terry Zhou (Synaptics)" <terryzhou05@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Tue, 3 Nov 2026 20:33:13 -0800
X-Gm-Features: AclHuK_Fe2eEql4NhTYMWlbQVrK5BFFAH1WX3uEbLcqoUpd97xApoMngD4pylxk
Message-ID: <CAMPWMbox-ZOjndykUunWoB48yPS8CGchCJGnFS2ZEQ218Ykq-w@mail.gmail.com>
Subject: [PATCH] i2c: designware: pipeline multi-byte read commands
To: u-boot@lists.u-boot-project.org
Cc: Heiko Schocher <hs@nabladev.com>, Tom Rini <trini@konsulko.com>, 
 Michael Drobot <michael.drobot@garmin.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 04 Nov 2026 04:48:23 +0000
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

Waiting for each byte before queuing the next read can split transfers
on controllers that issue STOP when the TX FIFO runs empty. A TLA2024
configuration read returns 0x8585 instead of 0x8583.

Pipeline read commands, reserve RX FIFO space for outstanding reads,
and issue STOP only on the final command.

Based on the multi-byte read fix by Michael Drobot, with RX FIFO
accounting following drivers/i2c/busses/i2c-designware-master.c in
Linux v6.12.

Signed-off-by: Michael Drobot <michael.drobot@garmin.com>
Signed-off-by: Terry Zhou (Synaptics) <terryzhou05@gmail.com>
---
This issue affects DesignWare I2C configurations that issue STOP when
the TX FIFO becomes empty.

Validated using downstream Synaptics SDK U-Boot with a TLA2024:
- VS640, VS680 and DVF120: configuration reads returned 0x8585 before
  this fix and 0x8583 after it.
- SL2610: reads remained correct with this fix.

 drivers/i2c/designware_i2c.c | 31 +++++++++++++++++++------------
 drivers/i2c/designware_i2c.h |  1 +
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/designware_i2c.c b/drivers/i2c/designware_i2c.c
index 8d290acefda..2a4c3f8a398 100644
--- a/drivers/i2c/designware_i2c.c
+++ b/drivers/i2c/designware_i2c.c
@@ -12,6 +12,7 @@
 #include <pci.h>
 #include <reset.h>
 #include <asm/io.h>
+#include <linux/bitfield.h>
 #include <linux/delay.h>
 #include "designware_i2c.h"
 #include <dm/device_compat.h>
@@ -467,9 +468,15 @@
 			 int alen, u8 *buffer, int len)
 {
 	unsigned long start_time_rx;
-	unsigned int active = 0;
+	int read_cmds = len;
+	int rx_outstanding = 0;
+	int rx_fifo_depth;
 	int ret;

+	/* The RX buffer depth field encodes the FIFO depth minus one. */
+	rx_fifo_depth = FIELD_GET(DW_IC_COMP_PARAM_1_RX_BUF_DEPTH_MASK,
+				  readl(&i2c_base->comp_param1)) + 1;
+
 #ifdef CONFIG_SYS_I2C_EEPROM_ADDR_OVERFLOW
 	/*
 	 * EEPROM chips that implement "address overflow" are ones
@@ -495,26 +502,26 @@

 	start_time_rx = get_timer(0);
 	while (len) {
-		if (!active) {
-			/*
-			 * Avoid writing to ic_cmd_data multiple times
-			 * in case this loop spins too quickly and the
-			 * ic_status RFNE bit isn't set after the first
-			 * write. Subsequent writes to ic_cmd_data can
-			 * trigger spurious i2c transfer.
-			 */
-			if (len == 1)
+		/*
+		 * Queue reads without waiting for each response. Reserve an RX
+		 * FIFO slot for every outstanding command, including those whose
+		 * data has not arrived yet.
+		 */
+		if (read_cmds && rx_outstanding < rx_fifo_depth &&
+		    (readl(&i2c_base->ic_status) & IC_STATUS_TFNF)) {
+			if (read_cmds == 1)
 				writel(IC_CMD | IC_STOP, &i2c_base->ic_cmd_data);
 			else
 				writel(IC_CMD, &i2c_base->ic_cmd_data);
-			active = 1;
+			read_cmds--;
+			rx_outstanding++;
 		}

 		if (readl(&i2c_base->ic_status) & IC_STATUS_RFNE) {
 			*buffer++ = (uchar)readl(&i2c_base->ic_cmd_data);
 			len--;
+			rx_outstanding--;
 			start_time_rx = get_timer(0);
-			active = 0;
 		} else if (get_timer(start_time_rx) > I2C_BYTE_TO) {
 			return -ETIMEDOUT;
 		}
diff --git a/drivers/i2c/designware_i2c.h b/drivers/i2c/designware_i2c.h
index 049976e8a23..20332191af0 100644
--- a/drivers/i2c/designware_i2c.h
+++ b/drivers/i2c/designware_i2c.h
@@ -139,6 +139,7 @@ struct i2c_regs {
 #define IC_STATUS_TFNF		0x0002
 #define IC_STATUS_ACT		0x0001

+#define DW_IC_COMP_PARAM_1_RX_BUF_DEPTH_MASK    GENMASK(15, 8)
 #define DW_IC_COMP_PARAM_1_SPEED_MODE_HIGH      (BIT(2) | BIT(3))
 #define DW_IC_COMP_PARAM_1_SPEED_MODE_MASK      (BIT(2) | BIT(3))


base-commit: ee9fc27f2a2a43f253a6fe18d7a6f7c4eb0cda3b
-- 
2.34.1
