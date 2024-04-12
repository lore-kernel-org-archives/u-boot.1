Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61FE8C4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 21:19:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFA16881EA;
	Fri, 12 Apr 2024 23:18:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OCem5mRJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D09B8800D; Fri, 12 Apr 2024 22:45:54 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63D1887DD3
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 22:45:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ckhardin@gmail.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6e0f43074edso962797a34.1
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 13:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712954750; x=1713559550; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S/K2Ufg/yMYFQ8nc6KbnGC81lE/m+K+SC8nttV4KaXk=;
 b=OCem5mRJOYCC3fT/oQVjKiWlG/AL7X17OPszJwisxHDvt9O2h3LJqr6QFhfuf/R9oA
 KaSAq1dq+bRmY0YditnQqmiWVmou/pPGz0fn/c59pAY1GcP9s7T9lr6yIotnbgxdL5Ls
 V7icsPniFFbS1jg9wNZyyvF7Bw1YpKVww5cRrksGLkTwV0ZaVeDMJUJ3/N6vN4Bs/iRj
 vJVEbIRhsfUmaTFB5fJnFNVLzKhc//7RO/w/h1WDhw56s0jUQUeBOdfQGy528QUPZyEE
 kb0ypgXt8xKFQWlZL63q3kp7tGtcxSR+N1Q21e9Qn22m7akyq/rHiBj4BlnjgmkrjC5k
 X22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712954750; x=1713559550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S/K2Ufg/yMYFQ8nc6KbnGC81lE/m+K+SC8nttV4KaXk=;
 b=KG0LYx2pPxCcliFl7wL8mArkprQb+xmqMN/wU7+9I1m3moMhzfYHlXflK1p9iuXiC2
 qYR5AK8XXHPIuyDAwbl/hiq6o3AbeWx9mGail7xgQ6EfYP9Wi8hxXrfQeNywXaJzfuyN
 /YrxN41M/AXBhvtNnB1feNq7NWFB166XUMYTl6EzUZHdChV/B/duBEvqzepOgJ6A69Ff
 cEJJY3C65e9HXDIjk3vCJWCoMZIcwAZHx4Zpbt0xJ/ED3oEJnWr1Nb/3x+RZSMoJDhfH
 6MtNJyCCEeCIGr/1pElxBZ9bQlTuV3Rk5YhZZARW2Ce86A83qS6xjOfrAF/H4StIiXsY
 N4Jg==
X-Gm-Message-State: AOJu0YwqUp/mpXTnIySEYyOBKKg4z1x1BBuxmg+SDaFC8Vh/dqEGSlkx
 XvoVZXfUZf5U7U6LPOQ75TvddxUxyQNewb6Dn2hWilxZr5gaC+yoXuJtBw==
X-Google-Smtp-Source: AGHT+IFp/BZ0He7HCr5p0YZxp4y4v1h33IwA1ZrF+FKnEuBide2Ol49bAd/4CGw1T+L99hdfaklz4Q==
X-Received: by 2002:a05:6830:1e1b:b0:6ea:1791:9203 with SMTP id
 s27-20020a0568301e1b00b006ea17919203mr3374891otr.28.1712954750284; 
 Fri, 12 Apr 2024 13:45:50 -0700 (PDT)
Received: from purgatory.attlocal.net
 ([2600:1700:65a0:14f0:8c8a:e1d:21bd:eeed])
 by smtp.gmail.com with ESMTPSA id
 q18-20020a9d6652000000b006ea19aa0e4fsm823327otm.29.2024.04.12.13.45.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 12 Apr 2024 13:45:49 -0700 (PDT)
From: Charles Hardin <ckhardin@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com,
 Charles Hardin <ckhardin@gmail.com>
Subject: [PATCHv2] net: add support to parse the NIS domain for the dhcp
 options
Date: Fri, 12 Apr 2024 13:45:33 -0700
Message-Id: <20240412204533.83605-1-ckhardin@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240401191319.62652-1-ckhardin@gmail.com>
References: <20240401191319.62652-1-ckhardin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 12 Apr 2024 23:18:50 +0200
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

There is code in the bootp parsing for NIS domain and add the
same support for the dhcp options as well. This allows the same
usage of the data when the dhcp command is used in the boot
command.

Signed-off-by: Charles Hardin <ckhardin@gmail.com>
---
 net/bootp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/bootp.c b/net/bootp.c
index 6800290963..c15472f5d3 100644
--- a/net/bootp.c
+++ b/net/bootp.c
@@ -883,6 +883,14 @@ static void dhcp_process_options(uchar *popt, uchar *end)
 			break;
 		case 28:	/* Ignore Broadcast Address Option */
 			break;
+		case 40:	/* NIS Domain name */
+			if (net_nis_domain[0] == 0) {
+				size = truncate_sz("NIS Domain Name",
+					sizeof(net_nis_domain), size);
+				memcpy(&net_nis_domain, popt + 2, size);
+				net_nis_domain[size] = 0;
+			}
+			break;
 #if defined(CONFIG_CMD_SNTP) && defined(CONFIG_BOOTP_NTPSERVER)
 		case 42:	/* NTP server IP */
 			net_copy_ip(&net_ntp_server, (popt + 2));
-- 
2.39.3 (Apple Git-146)

