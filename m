Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A96BBC53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 06:55:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 72D4F60826;
	Tue, 28 Jul 2026 06:55:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GAfL7K8eP7So; Tue, 28 Jul 2026 06:55:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6131B60825
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785221755;
	bh=PABxkVelLgrHFvT8wrDXUsTDKttZGEAiuWrnfIeLNRE=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o7qldGXXujuUSjhM+PKTVkduTAuqhHbuoxWZDypjQb4cJSlJOy5oOIxkCnTIKg9I7
	 ZmX+XvGwjIfTyK8x/CSBmMuztJn4LwndAwsoF08A1YuYGFU4aDKE5d8ADeuLiFPLXs
	 rofjnaUyYYXDD4lRjT2+5mXjEVfxXOmIaeqxRGFC693HlECl+3ziHbzxCdFBPq30/s
	 YvtQJKo8TkPZXstnvTJYt56llF7YrgYnZga/4N0aedZbIZbqmV7R9rvz+iBGcFjKab
	 VxC7aurIyoCKJPtwcDszcWMwOpYciNRCsSnZ+ldhtydUDUYbu9gpdOtInEZnFXW463
	 JU3mm8ZOrgTlw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6131B60825;
	Tue, 28 Jul 2026 06:55:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7C4FE2E5
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:55:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 630204089A
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:55:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CohnuJqJROsO for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 06:55:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 673A24089B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 673A24089B
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 673A24089B
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:55:52 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c082647cd0dso26625366b.0
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 23:55:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785221750; x=1785826550;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PABxkVelLgrHFvT8wrDXUsTDKttZGEAiuWrnfIeLNRE=;
 b=ilbfX7EzlpedicPGxsKwhwIXfN887ed34C4BKTgFukOT8OqZX93lxDHlDD5YkQMhGY
 QV56twWDWCbL7Lp9f7uI9IswVHVBMx2EtmVGP/gxqr6KJmcjecHRTcjRDeTYS0fVst/k
 UWFjiNE4Mj7EsrHkxjVIcdQxwAhM5A13rR8HTE5FMmm9JayYguGimHXtF1B9ct6Uy23r
 Ezru0gtR4DjvLYeZdLbXotAxYIwMq+/LGjDZLRaFXWU7KyPAXk+KnO20E/s1Yv8e5O4X
 VpN+nOYxv2bwcKWaHP4kJmBDIYT+8eZqWpaHXUK8f8BVDEAa5ztQRn1IMRglPLU/jm+7
 ZA0w==
X-Forwarded-Encrypted: i=1;
 AHgh+Roq3m6AroWGF9CdGQgCq6lHHfquli+cnj6dbGSkkMIdWDRQHujEKUuvAnGndgoXcEK7zo+QT+g=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzHYI1dM0A5y74XOhKw4ScrDIbrhnYfznbaFLb7dIe+c177KMgf
 WWa4zu+tQnFrIaP98PiSIUjSUIu5mH/ftNfTAhT6C/VmPO1nVY8wiPsXg7PDzA==
X-Gm-Gg: AR+sD12s0wkCbdEDNS0hi3tvo97HAcnt5HTLm3J+nCQcAtwcu/yYZSJWvU9/CGPdIvY
 dV2hKfIPXl5DbcSBm0y2LVZ5WqJ7PoZf7xHuFPN1ggKU6EhS3CwY0oPmcjWbDmenYej6zzEOxjt
 rofTE35+DrIn+IPC3cvRi2UyzJ0IXHYqTFZ1h/lYh67fEKpVvBtJafo3/THqUjCS/EkOhGOS5m9
 eGBJ+r3aQmFnArQTnEnf8R3UNzzi5a3dZTvvqkhW3fLNOb9aYShORfmguW6HCHWluFP+qg5TPXr
 tVuTKx4HhosOob2UYfi1skXPGW+13zWoLabBvzu6WiQqGp5xh80XFUchM8XQ+rL5BVITMOqE3Ug
 GBvR/aPSDNMTReRlGD4JWgFJhbXjcaKBc2CH5+TpolQuznFseNWwa0Ji9BWKCZ8tsj0NtGg4IaW
 nuv9G8lIeaNK8OzaRv7ftGig9DHbTJ+RIMdFn3ILve
X-Received: by 2002:a17:906:6a1e:b0:c12:2aef:af2b with SMTP id
 a640c23a62f3a-c1f724fd954mr26124466b.4.1785221749887; 
 Mon, 27 Jul 2026 23:55:49 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1c32c90788sm717117766b.40.2026.07.27.23.55.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 23:55:49 -0700 (PDT)
Message-ID: <5d5c8f18-ebad-4d85-b0ed-2c5a9c0a3d27@gmail.com>
Date: Tue, 28 Jul 2026 08:55:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 06/11] rockchip: doc: add more building instructions
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org
References: <734d54aa-6523-4c2b-ba3a-a51b063a340e@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <734d54aa-6523-4c2b-ba3a-a51b063a340e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785221750; x=1785826550;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PABxkVelLgrHFvT8wrDXUsTDKttZGEAiuWrnfIeLNRE=;
 b=fdFKHCOFxt9JqK3a7kU0OnkN0VglB1qhSxgzRp0UTsaVvuDKi23WBFTsFXlS3tKvOc
 g7LzOClhal83qos6E1jMivLoxFLWCZxq2ksptFKnQIZjmZzeHa3oHDva2O9vraCnOuUQ
 8x9i34Sv848rUJEsYYvuMlUsvbpq3zmwGHbgEzDxa3mw5ZvmxrcDuPe6oZXOqc0X6V+I
 XC3SU39AF91Uu3fqDzd4R3nWHqV2LsQ9ByZ9lqoFiYWPrGOj9vQUIWagg5bAacNLZw10
 T8xcov1MqLLadslqH9OTQChCXQv9m5oEYvctriOg76mCZnlRfDH2W2RmEb1tzmLvy+x4
 TmjQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=fdFKHCOF
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add more building instructions for existing SoCs.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 doc/board/rockchip/rockchip.rst | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index c3fd74c9cc5e..e6c4815258bc 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -240,6 +240,13 @@ To build px30 boards:
         make evb-px30_defconfig
         make CROSS_COMPILE=aarch64-linux-gnu-

+To build rk3036 boards:
+
+.. code-block:: bash
+
+        make evb-rk3036_defconfig
+        make CROSS_COMPILE=arm-linux-gnueabihf-
+
 To build rk3066 boards:

 .. code-block:: bash
@@ -247,6 +254,27 @@ To build rk3066 boards:
         make mk808_defconfig
         make CROSS_COMPILE=arm-linux-gnueabihf-

+To build rk3128 boards:
+
+.. code-block:: bash
+
+        make evb-rk3128_defconfig
+        make CROSS_COMPILE=arm-linux-gnueabihf-
+
+To build rk3188 boards:
+
+.. code-block:: bash
+
+        make rock_defconfig
+        make CROSS_COMPILE=arm-linux-gnueabihf-
+
+To build rk3229 boards:
+
+.. code-block:: bash
+
+        make evb-rk3229_defconfig
+        make CROSS_COMPILE=arm-linux-gnueabihf-
+
 To build rk3288 boards:

 .. code-block:: bash
--
2.39.5

