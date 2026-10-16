Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C80CCCA46C
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 04:02:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D7F9A60ACA;
	Fri, 16 Oct 2026 04:02:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sVB_COG1bs4w; Fri, 16 Oct 2026 04:02:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3F15B60ACF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792123359;
	b=JydvylXgaUqbiZ1nCumfTuM/0xMLBHIzRtdgNIfo5IWX4I1GVAbx0c/RmF5FoN8q7oGD
	 ux2nzk7lMLbEZbFlDp4OMaaaHyjNeAtj4CQrSfe1lAQyH9YEMNYb4m/OUoDTL8bfmuo/I
	 Hu7M+A3LjlOVbZcJ6DaobhczZZOnoM17D4IGHgYnC9sJgYKJIQdoYIXOQ1f1YLsORY9jI
	 q4pcRnrUPW9gv81P/OPqISRy6/4uYr3jrqk2YVrIKhX9cC44kYSqx81ZepZM4XSk6aCTO
	 m8n8Zv/NtgORei/OOYVOaBog7fApSBz2JP7utFBWOedpXGdXW5DSpcUXHprhgy/hWfQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792123359;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=g011VNAuDSQQec1cujBG2KXggJEqJSBVN4U9iqYJg14=;
	b=HlqUTo/kwQ5iS6lVXyqC8gmHYrJ0hsAGzuXKb4xX4btMqkYHvFZusqPHVViQncuqJlNO
	 kzBYJcfN9ZP2hsviIp1DoueifKDc7LKrgGGGhN0JK25BsYPYoSymUUtYaN0YVBvOAUy+i
	 xKNpm1uUBTvzlEYbvn1ZY39/yDJ0UzK0ef0P3iD2TH0IQJhOULI6hCeeCiuobM+DxU9hE
	 U6TKclEi8iCS/WHF7d16NTOy4N/+dM3NdAnGu3kuwl76vJHxH8bQEglTOlV+B+wDQzr2R
	 LTtSykxfDaR0jDubV0ME5vh0LvzjyhMgweZwlsVtJb0RUE+31iHOP+rLevpxsjDHqDw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792123359;
	bh=g011VNAuDSQQec1cujBG2KXggJEqJSBVN4U9iqYJg14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=djUpQNK9c1TEqW7nyjqm5ojAyC+inDz/crmgiOaVlzjSQ3LCBNj6N9LMCROr0gKOS
	 pqeN7ZFMlivW0QQLw3VyUek8rZ7wdLVWKN+FHrVfmcbYBPnmW8GhVR7SKhfoRLxuYQ
	 1ntHhPoxLp2a1TV4M796x0aOJjnHBJVRwMRKPuLYSuTQWbJoIyLRb3tG7ad/7OT1BA
	 V9YdM46XeczHwDFixUBbdqbHJ64lad5QB63HF+7yU20D9Hk4aUXRQPefKP01d9D+EU
	 15cTl/iZpF5nzAo2YJLDhbATsTr+7I7ZH1/KUPeZDHgmBlHMXGqoebk2lVCwC4gHB5
	 VMyH+no09bFoQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3F15B60ACF;
	Fri, 16 Oct 2026 04:02:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B17421AB
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 04:02:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A426D8121F
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 04:02:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cWOYQY6EV4M6 for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 04:02:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1EA1981233
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::430"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792123357;
 b=dVrmZwSuNqIVaJGnYwoYvtUXayFlPsn5sK7CVHN0FzuK5qNmnTPGvUlzOLypkPfnimLY
 BRjJwEUwM9s6FX8xGNYu2rCrX1hSU64TdxxgaSUHVc5/xn312FAwLs/OHCw597IrKygeu
 87OW47zIKkagSDoM0F9DtLc2DBW05B1afGN54jZ82p/XNMzlQ2L/LQoGwD7BgoKmrCYdH
 IUutjx37/umYxks+9SEPrbpaQWxhcZirdgY0oz3SYxgMPQThWcrlrRBrSwgKM8RB+9aDa
 JBVR4aE/FNlcTvFnd5WRyOoZCDL8qBOscCnKDJs6KNEBhi0NdaWPbWT9cGo+8KxxS7w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792123357;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=g011VNAuDSQQec1cujBG2KXggJEqJSBVN4U9iqYJg14=;
 b=HgjxmCOithVpPczoXtsFeeb4z9HRO9hOUbMWndemw0Cg5V68WJYfBWiULbUl5HEihdCd
 nzRuJ0tqzlFYqVY6XUjmj7j68F/S+URwLGSPNTb/9x3OjJJyGxbKIrrjp4icIliuEOsIs
 bc0TQf8S3TDImwRP6BetqLSZAJ7a7fxECdgxSEqVhJ8dg4BqUVF9V9FkgsAX3Q9Y9vGpA
 nNjV+AAgOzKP50GTa/EEJ80SbxYBsCoNVrfVuyKSrWU2ug7UIAQpWE6wM2EroQ1EU3iOa
 0QXROjN1WmWlcD3zBiuT2gU5veH8wfkcl/Py5w5I8mO/imgvGs9QlufYiu5YJq6MpYA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="MK1MxU/f"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::430"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com;
 envelope-from=visitorckw@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=MK1MxU/f
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1EA1981233
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 04:02:36 +0000 (UTC)
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-89a595332c7so3306185b3a.0
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 21:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792123356; x=1792728156;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g011VNAuDSQQec1cujBG2KXggJEqJSBVN4U9iqYJg14=;
 b=MK1MxU/fypo0/EFKiHBXGiV44s3NdLJ1oJxEg+vshakIpnuBfqnZYAolrRqY887xzb
 1RY/cTVKPwoCXdV9OP2HS/lqUpz744KIW5ZzyaUp5FmJGwHnn756dMEkXSBPbJ0BdtMo
 XQAzCpXy/ioTkE3k8bEEgiVH0jzm+4yiANVbPsqP3DeZ07dheFRbrXJ09SkHMl2DG7CY
 s39P4iPSozt0NrfrlHxKLr1JZ1QLCkLmajtC7K6kLUYm81Us108X/mvhgaAs4R/ECK3d
 UKcd59tO+NMeOa+cfPS3juf8hmA5+tAEeNxLdPX+SYb1xQA23cjA4PFD8mdP75C+cJMD
 9NLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792123356; x=1792728156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=g011VNAuDSQQec1cujBG2KXggJEqJSBVN4U9iqYJg14=;
 b=hrcD4OGHdcczhL2yDHmiDR2ie+E5/TjnHyTUUe4p+PwvqAF3KwkTbeow5JF7r4Eo4b
 ZPcRZ3Dwjp8r1GH1plurCq93tkIOXLTOPYfkaQ72wG3iSI1wUZ2IKaTlJZJLTaBho3Om
 uGv18qquhd0ZLHCD4T7F7oXItou4HuTZMG4NRwTONCzM6MPsyGGLLpTn0JESGGBktZVG
 Al0qu13yFPPqi0t6HJcgdQwB+Pf7pWk7qlCzrlKQy0yhDQEj9bnlnI6CS0fNts5L9lCP
 gzrDq2H8nM6ymm0j3urUUe45d3RcZ0gE9gjzzLPTQVzQow0IS7/EDwwKoRAHggLXqVtx
 mYdw==
X-Forwarded-Encrypted: i=1;
 AKwUvByO+MpEgbH2ndN8TMcK5MgrkRRXWBxBg5/yGqF0vNWYT20h+jKGXi5X9JkuQMSUqyajsNBAgCc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYINvfRU/FCClegC8JqSx4yF5b/jsgY3NeUye6SuB6xgIXkeFzwN
 bq2Zt1ApHyrks9e+xI0D2cad+jVxFYhB4S5JppeRdmyI0Wj/FDHbUPDP
X-Gm-Gg: AYBFou3SlV8lxT09XFF7lWt2jLyuT5RuVJJJRYagYu2SUtnwKvhqiPmGjhCKBUIrjY/
 inIw9Ykx7hLV9x3B6htnmCOlKCARK8a4QVlv5k6bG4zvkOsrZaJI7GrcUPGHIL4noFfy27otSgb
 48ID/Eq4b4rK/DA8fsJJrECIqQBHiUfJQ7hDAwQMmTZ4BwoX15SIpPF5u8P7bFvgAWdzmNZHzg6
 Ta82UOk3UU2C0goycAIu+GVC9LaE923nun0HOs2iovfKs4jL+0FmJSH+hSrH20hpRUxtaGc5nHx
 seko0bDtJ/s10mx7LIKJEne9iZn6HhvdWSknuEKUJZTsUcQng7Kyl5ZevZWv+W40IcKttm0IP7m
 7rHl+J9cXUQ/fua40BgIY57rxsdQoI9PEeVwlcMrcWvMOCzMOMj16uFm0P7x8/yMz+/HUjYsZcv
 fKsFxWfJfctxqFh9Aylu4OTzKheQZGURUavBDtrDlScgNEVgqpFJD83fb+BBlxDyVW25Minedlv
 Iogqs7q/wWdO6t5rI9FxxPXHehucnx5Y6JM76ML3ZJRRyd3i/KjZsd65ammcUchTQZ+vKC0BsM/
 w8YE3Kl3
X-Received: by 2002:a05:6a20:da05:b0:3e1:3178:8d63 with SMTP id
 adf61e73a8af0-3e1d03d380amr7552080637.44.1792123355859; 
 Thu, 15 Oct 2026 21:02:35 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com
 (33.223.194.35.bc.googleusercontent.com. [35.194.223.33])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd654a249f3sm437294a12.27.2026.10.15.21.02.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 21:02:35 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: trini@konsulko.com,
	ilias.apalodimas@linaro.org
Cc: marscheng@google.com, eleanor15x@gmail.com, jserv@ccns.ncku.edu.tw,
 u-boot@lists.u-boot-project.org, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 3/4] arm: dts: lga: Enable console UART in U-Boot
Date: Fri, 16 Oct 2026 04:02:15 +0000
Message-ID: <20261016040216.3636305-4-visitorckw@gmail.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
In-Reply-To: <20261016040216.3636305-1-visitorckw@gmail.com>
References: <20261016040216.3636305-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The upstream lga.dtsi leaves lsion_cli16_uart disabled by default.
Add lga-u-boot.dtsi to enable the serial console for U-Boot.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 MAINTAINERS                  | 1 +
 arch/arm/dts/lga-u-boot.dtsi | 9 +++++++++
 2 files changed, 10 insertions(+)
 create mode 100644 arch/arm/dts/lga-u-boot.dtsi

diff --git a/MAINTAINERS b/MAINTAINERS
index 2d8ffe7887a..7546eeb3f9e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -359,6 +359,7 @@ F:	arch/arm/include/asm/arch-mx*/
 ARM GOOGLE TENSOR SOC SUPPORT
 M:	Kuan-Wei Chiu <visitorckw@gmail.com>
 S:	Maintained
+F:	arch/arm/dts/lga-u-boot.dtsi
 F:	arch/arm/mach-google/
 F:	board/google/lga/
 F:	include/configs/lga.h
diff --git a/arch/arm/dts/lga-u-boot.dtsi b/arch/arm/dts/lga-u-boot.dtsi
new file mode 100644
index 00000000000..d9f36fc2c54
--- /dev/null
+++ b/arch/arm/dts/lga-u-boot.dtsi
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
+/*
+ * Copyright 2026 Google LLC
+ */
+
+&lsion_cli16_uart {
+	bootph-all;
+	status = "okay";
+};
-- 
2.56.0.212.g129ede20d9-goog

