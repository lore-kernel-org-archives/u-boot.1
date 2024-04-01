Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE0ACD1288
	for <u-boot@archiver.kernel.org>; Mon,  1 Apr 2024 20:42:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5C988833E;
	Mon,  1 Apr 2024 22:41:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LQVlYaen";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D9CD8830B; Mon,  1 Apr 2024 21:13:37 +0200 (CEST)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BF7D87DCD
 for <u-boot@lists.denx.de>; Mon,  1 Apr 2024 21:13:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ckhardin@gmail.com
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5bdbe2de25fso3281899a12.3
 for <u-boot@lists.denx.de>; Mon, 01 Apr 2024 12:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711998813; x=1712603613; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vv38qOlzGrbhqjQMQd/4PHb44Qe/bcThVmJdezTUq/U=;
 b=LQVlYaen/ZgO7gKxMb7H8jCD3xOG9Ggd1+rMUhwVV6pkJ84wKuiobzPH1EWwOTZEs+
 z1QS7eh7wOeE4nH9qHoMBxi2ArNHCWf8hcOpVPRaSMOuhUJqfDuibX/poa97DMBjW/QB
 B5/O+xWZFlvdgmOrl+ntfaU7veCcQJFleAP4JX1gHxRV2hP5YvQ+a9mic5+zI2yngxTS
 yPTnu4TtGPK7kW5ahYF8nraT//od6+8Kdl2vbqD6VCCRIqX1vG/99xeMOtNbkjUtVIGa
 gBDEt1N2TENYrvNXKYqcp3b/wYbx+q9930fK1/JGvVaKl+tL8CGoJ5N6lFElUkCWfph6
 RD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711998813; x=1712603613;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vv38qOlzGrbhqjQMQd/4PHb44Qe/bcThVmJdezTUq/U=;
 b=rJ3Eb2vNbQMu0BKesm5ud7zeeC86tgyFHqcu5Qgd/nPct+9RewPUHrVA3Y6Uo02RmS
 LH3yM5qVOK8WItBIgjX4W6fgE/ZYF5PaJEri/j7ZM3cxCTIM2dZRwueedg2nQtNJXiwa
 2DqYHQQh1STekue9aOrfVtFve1yupTRU9YUbekbdei5R8+8/nK6ADdoqAnnGosV3RaEj
 RI5y6XY/3XjoW2AzlvxSCyYyMYUT1e/4JwSna0BZs/+faK+oeEILJTeQ6B0fpIfqxokk
 +iphP2U6b4UMz5/yjHqnARRmdFBvDEgaePiTldKSoJgXUgUIV/RJRVnc1Ok14eeXc508
 NwPg==
X-Gm-Message-State: AOJu0YwxYzq+qXhLsYOVsQjhW33trpGsz5KseiYy7QsU3ZeeD1APHK6b
 mtFl0c+krHW335MMxTm+kIk3jRuT5dPviXUh/turjU8Y4N6ZhQoLfPOts2ND
X-Google-Smtp-Source: AGHT+IF8Fp58toSb3BXCLtY+x83vgSiJkPLWTYEUek/YFf9PiFOliBN8kC4B9Zx9iHGFvu9IlxEBgQ==
X-Received: by 2002:a17:903:120c:b0:1e0:280b:8387 with SMTP id
 l12-20020a170903120c00b001e0280b8387mr13897323plh.40.1711998812643; 
 Mon, 01 Apr 2024 12:13:32 -0700 (PDT)
Received: from localhost.localdomain ([12.125.190.90])
 by smtp.gmail.com with ESMTPSA id
 h15-20020a170902680f00b001dd6f305a81sm9472740plk.293.2024.04.01.12.13.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 01 Apr 2024 12:13:31 -0700 (PDT)
From: Charles Hardin <ckhardin@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com,
	rfried.dev@gmail.com,
	ckhardin@gmail.com
Subject: [PATCH 1/1] net: add support to parse the NIS domain for the dhcp
 options
Date: Mon,  1 Apr 2024 12:13:19 -0700
Message-Id: <20240401191319.62652-1-ckhardin@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 01 Apr 2024 22:41:06 +0200
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
index 6800290963..046caf3685 100644
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
+				memcpy(&net_nis_domain, ext + 2, size);
+				net_nis_domain[size] = 0;
+			}
+			break;
 #if defined(CONFIG_CMD_SNTP) && defined(CONFIG_BOOTP_NTPSERVER)
 		case 42:	/* NTP server IP */
 			net_copy_ip(&net_ntp_server, (popt + 2));
-- 
2.39.3 (Apple Git-146)

