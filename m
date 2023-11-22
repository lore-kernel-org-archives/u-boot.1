Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BCA0C61D99
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 23:53:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61AF087678;
	Thu, 23 Nov 2023 00:52:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="Riup/8D/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F51587675; Thu, 23 Nov 2023 00:52:25 +0100 (CET)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com
 [IPv6:2607:f8b0:4864:20::114a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77D618765C
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 00:52:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=3MZReZQcKBgYsuxoz5lmuumrk.ius0-huuzroyzy.jkt3.jk@flex--moritzf.bounces.google.com
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-5ca61d84dc3so3859567b3.0
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 15:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1700697137; x=1701301937; darn=lists.denx.de;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=MUzDhbS9UB/VjACWjNN+LRg72E8lkFA9p0toY9s00ZM=;
 b=Riup/8D/GqSs0kuuE2lLgMXSXr5VPNflUQmJuNQVZeIm2+2BygGZEMNCRgQ7q4B+kM
 aB8w2WNlPpCPyAz8ksRv2r9+3B9K3pzznnKrp3/EtRqPOciRCFgoboSefo/P3v3+xO8r
 Cgia4PhYX5oI6D0k/014nnVTNHrff3X7kSnkmMYl039lW0gVwriWDNITvykIQhu6gOwy
 Ig4abYZfBzWsICn3+Ne7I1/DEV+1lxZAVbhNPmmZmGmV2Kcvq5Ee74B8HuIz228rblad
 b4camOCqegrO8LCaL1Z3Dty3IApB6JVixOPgPoRCmibmeZIOsQgK7of4azlqtIdqClBI
 gBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700697137; x=1701301937;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MUzDhbS9UB/VjACWjNN+LRg72E8lkFA9p0toY9s00ZM=;
 b=n8I0QsZODXFZ/3M7SIvpP9U1iKOK+GlQQowhXngU8SuR/7LJ7sgHT8DWxKlOBXeC+L
 r5XBXg9FUD+Y7MAzZeBsSJKr+k6335pOwU3hKO8HYWKEQ5jv4ZhEFcGWe2ov/RCQ8TuI
 sPQGsWPlHtwpMQ1qk5X/0LIHz0j5ufig5zVF4sP6APbaIfzXZ5kYazkHVHtszOOGCZU8
 XqjxHe+Vj3HpJiyfdCddxnvEEcSHZ3LPBZMfvN/uY6Gz7oN1uiZmNgcEN/kkIPHgg2Q8
 JvtaWNm9CCqt7XbejVzZT51sS9r7ADxlMkQQPxMj59FVS9NPEqpr49SShCnMRc9yNX/D
 idow==
X-Gm-Message-State: AOJu0YwJX0Qp5QkAqDF+Ivu0OF8TvxhU/YSPzaVTjPy0CtsdztXtk3lf
 Q96ZvgOrSGltDrP0anZyD0WHiFYaV6N2
X-Google-Smtp-Source: AGHT+IFiA/ZUM3QCJuxLKjkdSvBKa30NwvRbwTMCocmVc8j1Ykzh9X9ARXqOblVAxZTyoOcOIiWTdzE5vvcn
X-Received: from morats.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:d9e])
 (user=moritzf job=sendgmr) by 2002:a0d:e2d7:0:b0:5ca:936d:8991
 with SMTP id
 l206-20020a0de2d7000000b005ca936d8991mr113220ywe.6.1700697137123; Wed, 22 Nov
 2023 15:52:17 -0800 (PST)
Date: Wed, 22 Nov 2023 23:52:01 +0000
In-Reply-To: <20231122235202.630114-1-moritzf@google.com>
Mime-Version: 1.0
References: <20231122235202.630114-1-moritzf@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231122235202.630114-2-moritzf@google.com>
Subject: [PATCH 2/2] nvme: Update scan namespace to keep trying on busy
From: Moritz Fischer <moritzf@google.com>
To: bmeng.cn@gmail.com
Cc: zhikang.zhang@nxp.com, wenbin.song@nxp.com, u-boot@lists.denx.de, 
 patrick@blueri.se, Moritz Fischer <moritzf@google.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

A busy controller shouldn't be game-over for all controllers,
so keep trying on hitting -EBUSY.

This change brings the actual behavior of the routine in line
with what the descriptions says.

Fixes: 982388eaa991 ("nvme: Add NVM Express driver support")
Signed-off-by: Moritz Fischer <moritzf@google.com>
---
 drivers/nvme/nvme.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/nvme.c b/drivers/nvme/nvme.c
index ec45f831a3..59a139baa0 100644
--- a/drivers/nvme/nvme.c
+++ b/drivers/nvme/nvme.c
@@ -695,7 +695,9 @@ int nvme_scan_namespace(void)
 		if (ret) {
 			log_err("Failed to probe '%s': err=%dE\n", dev->name,
 				ret);
-			return ret;
+			/* Bail if we ran out of memory, else keep trying */
+			if (ret != -EBUSY)
+				return ret;
 		}
 	}
 
-- 
2.43.0.rc1.413.gea7ed67945-goog

