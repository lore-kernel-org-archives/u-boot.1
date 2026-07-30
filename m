Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C078C55165
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 13:35:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5BBF981000;
	Thu, 30 Jul 2026 13:35:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 34ZBHZjuAdY6; Thu, 30 Jul 2026 13:35:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B59F180DB8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785418552;
	bh=9artrsmgWtIMnKJpg9n6C1X7vOMINTo0CazPm2oQ1Y8=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fw3V79MzmlBjdP+6LrdICWjSfE4gwrFUGqPc8q67//DxoB82jGvqf92Cb8DSO8kYu
	 A1T3p4q6k7M9bKqkzMGmRVlJ39Voq6FRYJ65D/aP2HXeLzSaWSLJjWF4qOjNWTv/dQ
	 sWA8QZOsZgIMp2xIj3dPCmSS5D2psl5lPo9xTPXfm6b2Wy4IWI3ASfxwih/yQm5RPm
	 xfyi2knaq3OBYy0EizZghb1F5ca1oittxYhDEy+a+Er5MEJXSaTo5llWD75+/QLrQ5
	 I6cXMuNBUcx3nG4aHhSLR7xVfLEZ88bTiUhpVK7GXdbEuYvYTU+ZlCQQ4ztXydsclM
	 3Z/8rnOSNAHtQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B59F180DB8;
	Thu, 30 Jul 2026 13:35:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6895E27B
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:35:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4E99240AAF
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:35:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kzq9GRAd7opn for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 13:35:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 5C37640A98
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5C37640A98
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5C37640A98
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:35:50 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-698aece3d7eso334035a12.1
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 06:35:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785418548; x=1786023348;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9artrsmgWtIMnKJpg9n6C1X7vOMINTo0CazPm2oQ1Y8=;
 b=ltpDwmtNhoAhNCFihWbhk8Ts3A49e89VT2oKfiXfR4WHwJ3SxfQcTLZ3o/1QPjooQZ
 TPi/RSA63tR+ihrt8oHsSADkg2UST5aATBjDYhsyzpPwLL+6uvHkaVdGRU2YeKqy//iY
 AVhRIxy3ohAR1gGUO0GF4MWo1gGEo/p02VsRVh0MsnI6ORW6dXtdFGB8K9j4TyzCbpr6
 ynUi+jtaeP3IAkbu0vCei+i8wJtxRRo7pYbr6q0nSY6SSztkAX78gaHsgxccMqUWEYsU
 o1TQENma1LQ2rWwgpXDTdWFNzYpVwoK0jDGJP1OPgUKm+y0TxfDJjzED53Ku+23Wy9sn
 EivQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr5rnD9MRJwV6T3dIdQR1EpQ6tj7vD5Yl+Em50nisq5L2rKuKflojoaAoLPLJx4Lg0g5FDqJZs=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yyqh64B8A4UgvfhnLHS25h1WunrbftSnpAb3vUNZ2lYNGdlHKTt
 abJlDc4HQhsmY7cgL3nYoN5qPO/JuNqQKVzYVzxsg/peWqHnA5eyadlb
X-Gm-Gg: AR+sD12if3QLdLJOX48udAUpMVNk846uju6wCjW7Q5T/9aCUKk5ESd1cmApLfcm82/1
 +tpMA/GrPEmSsbTPWqXTW1pmzPOXM8txA55UsxsZF3dn1HNkidZbj/eid6YnjVbz8oXIONUFLKP
 9AOgXlEluLhDaPNupxZXzN31/LpNRaU/qKI2PfaK7TbLpW+ejErsEzMSeZvIJm2HFLnVzqQqLZT
 VfPgJZWUvvhlat3ToxeDhcGJWW9RgtUO2ypSbyA2gOTHH0CE+iODyA+YrTkLAjG5bRVWlcqaBax
 72eE0pwZIhWQc0k/1TCnQlTLNUUPlkJvmprziyP3gk59gzZt63XTBbgx3CyGRqwunmgX5ckveJ5
 GFt/LmUy2D1K+kfTJaE/8fMpip4mufCWxfRxKy/7mZtDALPVkfzTk/6jIBM1eaGTTU7/ys+6YD2
 yoN83Toz/PHC/uVD90xofyp99hhlgemAmv2cYio4pXJMzaC5feycSDvD9iFeBwl2HfMbZ0WZvLP
 IyqWKsvHiYWG2UUvcYLODF9QJM=
X-Received: by 2002:a05:6402:4349:b0:6a0:4e35:deaa with SMTP id
 4fb4d7f45d1cf-6a090d62d0amr205449a12.1.1785418548113; 
 Thu, 30 Jul 2026 06:35:48 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a07d4a4a05sm584360a12.29.2026.07.30.06.35.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2026 06:35:47 -0700 (PDT)
Message-ID: <7a16f953-9379-481e-828a-0e60670de983@gmail.com>
Date: Thu, 30 Jul 2026 15:35:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v3 10/12] rockchip: tools: add comment section to rkimage.c
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, eddie.cai.linux@gmail.com
References: <5aed2a27-bd7d-4b71-a6c1-0b46b41f3462@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <5aed2a27-bd7d-4b71-a6c1-0b46b41f3462@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785418548; x=1786023348;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9artrsmgWtIMnKJpg9n6C1X7vOMINTo0CazPm2oQ1Y8=;
 b=o/q882OIVAwxp/dLtxgAPEOTHG9wDLZ2dqLxtrQ35hCt+n5PYvfHuTZ8AUqwr7BPK8
 UBDjviQYI8KSGHBkLPY2qxBmGl12WlSdci4TaFHHEadYDbbE/hulc6+JM8mXRsKCZ90y
 Kq5eMd1qlyGwGCSpQ0wUeAAMMBldTnHqiLk1s2xbNlxKnT2OaQCXoENlmAGR94nvNOUg
 eZxTrLgvLz3BrRjsMObo39uOsylIQyu6W/oRYXKswBZzJlxVr/UH1JPNcrAc2yqkfnJw
 yggYh9Gh38cbcaeTm6GKhSIEDhQ1mMagpueFnTMJFIdUztBPb0nLqT3KOgt6USoHUAGh
 xE0g==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=o/q882OI
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

README.rockchip must be removed.
Move the rkimage comment section to rkimage.c

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 tools/rkimage.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/rkimage.c b/tools/rkimage.c
index 1c5540b1c3d1..0cabdf2f6723 100644
--- a/tools/rkimage.c
+++ b/tools/rkimage.c
@@ -3,7 +3,9 @@
  * (C) Copyright 2015 Google, Inc
  * Written by Simon Glass <sjg@chromium.org>
  *
- * See README.rockchip for details of the rkimage format
+ * rkimage.c produces a SPL image suitable for sending directly to the boot ROM
+ * over USB OTG. This is a very simple format - just the string RK32 (as 4 bytes)
+ * followed by u-boot-spl-dtb.bin.
  */

 #include "imagetool.h"
--
2.39.5

