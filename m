Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9EA5C55182
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 19:12:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 730136069C;
	Mon,  3 Aug 2026 19:12:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0OnDhVVcJEq0; Mon,  3 Aug 2026 19:12:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A3CD66069F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785784356;
	bh=VwGHJeYA6yf/4z6TDQFWriYRCrjiVPPVgU+YkuYt0Oc=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ET//s63+pRfiVu8w2adMT4jpm3XqTttLcADKK+0nFVDrirNvQ3c6WMenivEft1EYb
	 GqdKIWHkL8g4zxShG0gb8lmCzSjPuGcXtqiEDWPpMChLfTUf9fMWBi8W+JKMnAOKfe
	 ljPwO+LAffAa1Lvi9yluAaKPb2IJ1VLoldCTH7x+AK6puE7PXDj5jC7RsKWmTiK5jO
	 w/ZFBccTkfBVXMF/ZOkjuahMR2xzR3rs7EiN4IfxGObOo/LuhwALjmNqpexUdlY1be
	 XHvnfYGWCkf+Xm2Rec0ErbD1e03IN0AD99oGSm3rLMy4BnKvEsyiVSnrgzXwTHQA+2
	 PRmBD0bINSYEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A3CD66069F;
	Mon,  3 Aug 2026 19:12:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 739E52CE
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:12:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5A91E6069F
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:12:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gl9A_aTMqiu6 for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 19:12:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 646F66069C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 646F66069C
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 646F66069C
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:12:33 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-69a33fb0031so697629a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 12:12:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785784351; x=1786389151;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VwGHJeYA6yf/4z6TDQFWriYRCrjiVPPVgU+YkuYt0Oc=;
 b=CpZNXSYXM5itaf7jv+KfwrgwloyFmTyKQV+28cxS0PpmOtULb/loE3quo490MIQUEG
 HIsmKpv9PtOyQ+zHxCna2ESWM3txfQwj70HLRdQMJiknnV3dTjzBYQhEqt8gBmA3YNEm
 MLh87UMsqCVG9OOwkR5ZOmSknTWx4Xar4hKPRgRPqRpOP+lC5YYRtvA+EBRKwVsRfES2
 pNv5EW4rqN3MI/cjG0iH3taEysBcj8ryp1Pq8K4c0X5tvba2REN2amkL7Bsxv/3q9hst
 fXP5WgmceLOZ0uUHFlX4Ig3t5YSkI/reNW/1Uij5rr9ObSrds7HqZdfOAnATWrwZoVVS
 TLkw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq6J1RxWgp2qJ5L04/9gIcl6ohXzhdKDYOS8UvbfQaWvdAsGBlMmXh9dfVdEuT7luCkpM/x8mM=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yxxm1r17uYZZOagiQUxGC1Wt9bFwnhLZo9ga06nOKgBTwSFznEb
 5J5BtIvYovucWGFKA/5XUyx4SJu0rSpF1xJ8YWUdcxIwCEeBlIjk8Ixs
X-Gm-Gg: AR+sD132RCtkimaGollU7Z8HRaHlvlgrDvYJ6tU/hHr4F05VlIvnUsEzZ+htzWCrY3z
 TXmXY0QPeEP0z8eVAOEJWj+ghedDBi7HUpu6IohpRY5mw3CfKzuwChzworflVabTpgsAQOSPzFM
 kgHFmfQLaMQb/UZY6o3GBsVrGKBGoy+g5WnfCYFsbQ/kHvOpLge8JZqjleGgZBjTgP+ulK/3ani
 L8vABo8F0PhjPwnd+ph+mz05DQEGg9ggwC/CEd0lSZci98cKCnQcXPtQqqNx2gABIZ/05BXa3s0
 7IOCH/hwB+k0xyf/aJV3NB2OhwnivDJRF4d+4k+CQpHl85xjiDW++1SE2kkiJqnL/R14gQ8z028
 fwgyDQmyD9gpPnpW1rvrvZx3KAxswCWQAU+XDn0i5sSU4wC8yvsPmI4F+MyWB0mI8rzzhCLEKnm
 rdYGWw5j5I36JcuSvUIAhc+SkAMDUSMFK6l9ryrSA2ohK150kh84RTDmW/fGAF4/iII0XrQqhty
 3tJsugP9hvpY9t1DpC94WZUJ/E=
X-Received: by 2002:a05:6402:3607:b0:6a0:a4f4:bca4 with SMTP id
 4fb4d7f45d1cf-6a0a7c8a58emr4914844a12.1.1785784351139; 
 Mon, 03 Aug 2026 12:12:31 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a09c5b0c0csm6088235a12.7.2026.08.03.12.12.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2026 12:12:30 -0700 (PDT)
Message-ID: <9b80da12-2dcc-48fb-a796-debf17fec234@gmail.com>
Date: Mon, 3 Aug 2026 21:12:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v4 4/9] rockchip: doc: add more building instructions
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, eddie.cai.linux@gmail.com
References: <d15555b5-e57b-4567-ab70-56d48fd4b878@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <d15555b5-e57b-4567-ab70-56d48fd4b878@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785784351; x=1786389151;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VwGHJeYA6yf/4z6TDQFWriYRCrjiVPPVgU+YkuYt0Oc=;
 b=fv0CAYnierkC5Es9/whrHfmMSMbjQmnP+dDtGNeMoh4y7PFuqypjUcJjwGnrrvprdB
 o0maiVb0E3abqu6nw6vcnPuhrasLHKD2wjLnZZHHlfpC7yh0S5u3Al7z9jpypmBmg/+S
 qUmdkCSy8wwMccHfdSbtryT+nrSlh+Ud+eWhfMcp+If3PWbXJ5mLzeCKjH7poogE/JxO
 LgurSlujSrJfYjR9Qb8PTEYWErZo5JmWIkW7KMtvOtoKXNzVDoWDWuENjoBvPLbL7R52
 BkXLLDhQQdb0sCPcU2Ja7ORAALC45MubiYT7wbpJjmYoHdBq7NHFUDf5Iqb6AwEqbrx2
 ppzQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=fv0CAYni
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
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 doc/board/rockchip/rockchip.rst | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index eb8772c5132a..f211adcc0e87 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -241,6 +241,13 @@ To build px30 boards:
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
@@ -248,6 +255,27 @@ To build rk3066 boards:
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

