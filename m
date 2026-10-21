Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7313C606A333
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 11:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZWYkiU3J;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WKlRkecz
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 22CA9810F3;
	Wed, 21 Oct 2026 11:07:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OzDFyL2MdWXA; Wed, 21 Oct 2026 11:07:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4CBA0810F4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792580842;
	b=DlO9N51ctUtPP+AarnVlk3QjZ4U29ZM9B87VVDo/g3wD7fv8bdUNfaD6alc2PJoId2u0
	 p4/GYlO7mqvj8yAuKgqqMXgeOtgI1VnxZ1UUWvyWNPELU8IjqhQjwyi0jNxkL/gOsXP7B
	 tZviptxedlq3sQeM52fkWoJv24ehTWiAzPLOcch3Tc+hY32N2X+VQKZ4XPuAl87b3Qv4T
	 k8p/q99VaxpfB4+F0Jn5ACd1q39WDZ6/eY4RS8l/VEG2V3//rec0aBi5zCRyWsGaa9Hb4
	 I4RsLo87duCLN5AOBFnukGQuQRj9FLbMddTIWpF9cEQ7TqjZNwbIzqtKMSmXNbvvneA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792580842;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=y2RJWtmXnOSZRpF7OTcDVpCGuBpSOYy9ha+YgsQgj5w=;
	b=Xxv8mOn9UXEXAAE/gkAQz1/SXiEadaHp4IXze/5tL4OKm6k9zMEvmMpQjC7tbg5EdoDi
	 jZ+OQvbjGS0Wo+hN0C4WVZeXNnvOQ48PGyak8RsFzogS5mj5KvzhENPBxBU42aDfU3Pe4
	 UInBnv5yEW60Ygbzq6lX68JxW08IJbI2UkL9aIQHUyaSu14jiuj4ouqEX32l+W1iKwTMP
	 kH4yljqE+ELKjs6bWOWqQjRZVmNX2H0503Q57zbEgnLdDb8u8NKUjkrAhWALW/u7eGbfo
	 dbsImk6CUgmenEk0E+BpsYcMUpkcRr+SneymLN/2x0IDtr3RWx1mpbQqJCRQOOoGUWQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WKlRkecz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792580842;
	bh=y2RJWtmXnOSZRpF7OTcDVpCGuBpSOYy9ha+YgsQgj5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZWYkiU3JNnXX9mnu1fSqxBOOFqeytSiRcNuDqriiPr8V0NEiTI2wDucmw5D5iTsQ5
	 q3z8zsyw7Lc9kp2qa9e6hBq3RLjRssmIz5RszgW224Wk7RIzZfZ4kQ7EOZQKm+vdXY
	 QvtJIOLK+3YSWVU4Zt8saMX8mnlEiw0eaLfGQYKZJKKGu5y+38JJt0SDUVzyL060+D
	 h73wcRsextfdNCSOR7t7SBHc00KGyCqryGh9+Wspei9u2hsciCPVlnHUpPftLnB2J+
	 pYOYVbiukI3ZXne5sFlhdNZAOjej37hmBDBRzpVJ7S4AFPQkwRv1ejkp5szCIGJMUm
	 K71mVBT7JDKxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4CBA0810F4;
	Wed, 21 Oct 2026 11:07:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 73744380
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 11:07:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 653658100F
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 11:07:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1GxSjJhXqX0h for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 11:07:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AE9B7810A0
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::52d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792580837;
 b=EeUHDq+JNKJdUPZquWusH8DTBdxmT6CVhKGNs0MZIVDsARFNtv09B3ZUIhaKks0Abegc
 8ZylwhdDTDTy/LspQjVc5e5ussBUCWqbhl86VSF97UBCwUbYkkWFjIFLgGgLtl9ak8Cdu
 6UdSXjMBVDdIyQlLm2iDbGmbJQTLZLQps6BjODJOOEogVTidLBGETZiapbVEShr9AfQih
 qcdya79No5ixdV0/Uk2qH5wRq1X+oduxSYfwHmtyvkCc8el4wIQRW1raky3JSg0um+ilp
 sKU/vNQWlRVkfBmkooduPOkBg3ar2MfsU1DhtgnqGQsgFS5/00ONaXtQnyLmXwi63sg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792580837;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=y2RJWtmXnOSZRpF7OTcDVpCGuBpSOYy9ha+YgsQgj5w=;
 b=ak0kulsIIJiAFJSsxS84k0HSpNxeKadYd6jGi7vsghK9bS2CLWVO/PJiUrpW9Kx4vYd1
 0Uy7vpsqVwmTfEsXUaYJ67Ev1PUI+UDh1jQswf+uuRzfp/SvI1METNugNO8RnsDs/QrQ3
 /a1t0tt23/KgMXZtydLXCodbt8EriqEL+haq7uJdzKxxIjBquIw9lUnVUnd6dPAlQZEz7
 VXM5JvAYB2FiYXufztq+xXq7Z5YimQgSpj8X984d1yy56ZviihMtm4U0zux/4cRGMFASM
 1P1/NxHcN1dpbr3EDtj/EzqZVy3igr6k2KuqmycKWzgvm6Q4H8v3j21nwEcOnvlthxA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=WKlRkecz; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::52d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=WKlRkecz
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AE9B7810A0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 11:07:17 +0000 (UTC)
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-cd6028ff33fso174940a12.0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 04:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792580837; x=1793185637;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y2RJWtmXnOSZRpF7OTcDVpCGuBpSOYy9ha+YgsQgj5w=;
 b=WKlRkeczHyoqnNqLQOMmlKywtxsQ6XeEmbH3JvUI8v/sjVTDpaa3T9mKGsIWMUmeWJ
 4XXHBTyUZTLrf7P54odVww+GP/NNbFAPEhPb6qqzSSdMseuz+IEmM3aEYE2eelyJYC9z
 D9049IOWhPPgL0wHNyy563avyecLObHhKmZdtD14TgMI1+VkqtH5T6PNsZZP9thmvVtJ
 HdbDkMvVw3JYVMandhBsXV4ul1IpBoQQAEe6zKauyehhd5AVfJA2pNTJh11cXsnh4Xwk
 B6RjHaU6QTUwKopHUCEIEU4gpsYBYI1Si6sCh0PYEzLHXmTzTSiGznjtkUTLY7oPtsbQ
 VxKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792580837; x=1793185637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=y2RJWtmXnOSZRpF7OTcDVpCGuBpSOYy9ha+YgsQgj5w=;
 b=v2OBMnvt42mIdwmi7E+S9uxh0UjC3DomCyau+j76ZX4u4acl0Ax4M/+0zwxzsINEtQ
 GWO3BgDKJOQ9lJIiLD/sb5bBruBPF2yBjSXEPMJic1QjCbd3Jryj+T0zM8R8NvjJ44tu
 QA9C8/BM6CN0CTA18DIMMPl2Duwy12UBXXZylEUUxrak2lr9Pp1zcZF9Cnjd7878uWUM
 kkQnAINUVMcUI7gh5sO8RHx5gJr8piUkpoVd5melQt/L9sx8PnJQFQTEuEbg9qA0twAu
 aAZlz0RN6zMebjmZZv+5XGcOjE/EbnEdc99In+y2hk52/DC7WuQLHRBCdFXWiWiCZs9L
 DD4g==
X-Gm-Message-State: AFq9FYLEb1wAF4p+CYcgWKmusM6tEv2xU0fBhbrv13Na91a9XNnDrt97
 on1+L+v6roHCvmN91KM/Oe0Ei/kuaw8qmBAzuuK5CeWSfLuxzJDfS4uYJjce65sJxeg=
X-Gm-Gg: AYBFou3e4wxVcgFHV9IVi69r/WvgY+7SKol6LLDfCO0c6c8xhLvV+hQNlAFvvwLVxCP
 +F/3OS7pTWGHml7IyCSG06rE+/vTpeN6i9cxb5vqPXuvWYuSycVN4I5cT8LMiRlE2JKml1iw914
 ybA7mEw+S52XXjyKneqA2TNRNnYnharUGHRIQOZTHwsnsx4QeCMybqpvYr0l8WlPsbYl78cOqp3
 7C3L9TzjVxA7BUnZEpUboNGY9enw3HaefQkQGZA5CGo8cvGaRlu0lRRdGtsRKKftSLMs3JGVuOe
 B4yXD8yo/zUF0pbDkS0ZE5JxXBTX9JgGOXsmpqWO1diK/HIMf6bEFbyIuD6lLtFHBYjajvTFrfY
 /aX0Y75fkqLBXBCoUjuyNO5/XVkZVKCELFu5f8dj7W3TY8aDurOj4S2DRF9dPVhwliH6yNI8MEr
 AV+N2NxucqzSf9E9hLLcVopYtcF/U4fh4E/uI1apRl+Y6NqsX08iOxxsQdUf6pm+th13Z0RIo77
 5FxHmxyEEheu4jhp+bQ5etwh5OP4/icuWV6Wi3N/Z4sHpVoRr99DODrq4FxNrCEQa12gCnlfC2z
 aJNvotCABlv94etuHIYDiX5SYnwLuGOiSLti9lrL9tn9E91ofsoLdjNOy/pfwJ4D298ygEDYodB
 tHy69O13cn1Kdll2LJg5lltA4f3Fdwveawoo=
X-Received: by 2002:a17:90b:224e:b0:3ad:6781:da6b with SMTP id
 98e67ed59e1d1-3ad86cd6d65mr1455291a91.62.1792580836824; 
 Wed, 21 Oct 2026 04:07:16 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad7ffbbba1sm4029380a91.1.2026.10.21.04.07.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 04:07:16 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: bmeng.cn@gmail.com, trini@konsulko.com, visitorckw@gmail.com,
 sjg@chromium.org, xypron.glpk@gmx.de,
 Bin Meng <bin.meng@processmission.com>
Subject: [PATCH v4 3/5] MAINTAINERS: Add entry for virtio RTC
Date: Wed, 21 Oct 2026 19:07:04 +0800
Message-ID: <20261021110706.2947351-4-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021110706.2947351-1-alan.tseng.cs@gmail.com>
References: <20261021110706.2947351-1-alan.tseng.cs@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add myself as the maintainer of the virtio RTC driver.

Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Reviewed-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
(no changes since v3)

Changes in v3:
- Add test/dm/virtio_rtc.c, which this version adds

 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 28d090d3c..2ce94d7f5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1872,6 +1872,11 @@ F:	include/virtio*.h
 F:	test/dm/virtio.c
 F:	doc/develop/driver-model/virtio.rst
 
+VIRTIO RTC
+M:	Hung-Chun Tseng <alan.tseng.cs@gmail.com>
+S:	Maintained
+F:	drivers/virtio/virtio_rtc.c
+
 WATCHDOG
 M:	Stefan Roese <stefan.roese@mailbox.org>
 S:	Maintained
-- 
2.43.0

