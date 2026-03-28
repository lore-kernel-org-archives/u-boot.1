Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3EC810BA424
	for <u-boot@archiver.kernel.org>; Sat, 28 Mar 2026 07:05:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F395783DA7;
	Sat, 28 Mar 2026 08:05:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BhiHUbtK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5346583CD3; Sat, 28 Mar 2026 07:01:50 +0100 (CET)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2A6B8394E
 for <u-boot@lists.denx.de>; Sat, 28 Mar 2026 07:01:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ngotra27101996@gmail.com
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c70f91776fcso1199128a12.0
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 23:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774677706; x=1775282506; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Y54kjWbPNj4mesjavb13zDlObH5fkYExJIr5CqwAHH8=;
 b=BhiHUbtK2zAaQaPU5muSRMHvAE4d+1n9fuUUZgGOyjRhNDN+zNl9IEXOdu/ayOJGu6
 2RigRtgxcRmHKcQTdWU6nzkCdm+jt2bPz+Kr/66NNPejy60Q0l0MBmcWYfSYVvSrQVa8
 jVO/lwovtseDy1ckf9RvYSQ0PoyMpwVEgYxK7bKZUulNuG3eVPf3RdDa5KNF3NCpoYBI
 0cN1j5t2P7y/l0eCvsoxzA6P5I0TbBmX5W9+wsgouTVGqTdsb5v2F4JaeTkdiiR6wc8g
 ixUZz0JpfWVDqhrs7dBZ61FY0f3EuZsGgTmxhit74R7C0lRekhjc5OFIHek00AUCKlXE
 YU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774677706; x=1775282506;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y54kjWbPNj4mesjavb13zDlObH5fkYExJIr5CqwAHH8=;
 b=m7qK/BoFNPut+xMCjPsqamv5WzM68hR5e+BDZc9/ZmY5hxnfyXb07GfNTg1a5vekXm
 tcprGlHfdWUIXhq2rBISHKQNXb4bFhIyGiJuFptJCJD3yVkWIkuJ2VR0VKGbLSm5w5Nn
 nLeQvEwi/ri3IsB0I2+x6G6JFtYEtbbIqX7Py1WNw8z4TA5V9nyIbniT5iFM8k3xKw6o
 MIDoz8M1loqsx1krhjgzZ+/Xhy5bgLM8d4+x7quwUX6e8mHJwBdAB1zScWwel1IVP+r2
 9aHdo2K9GeZTjnntx/eWAy8a6Al5apQKIvd3meuXc2csbgD3X1wlCNB6oQFt2xsb2Cej
 02hA==
X-Gm-Message-State: AOJu0YxX/OffxCOi/ChnbNCUWX8EVA7GJ/Bh1pa8mdSNnlzc0A2VAw0n
 yoPSd/Uh6eeM5ydOzehAu9ri2d+PuSjHRDn7OmFo2gEFM61mYOT7T4/Kp1M8WB7i
X-Gm-Gg: ATEYQzxKwSAFkysqJvjwTCI86FtCKkDXnTrpteVvwyTfRdTp7UL0ssmbMqcly2AZy/f
 DpwFheDbs5p7B7k/Ms3005PpgslGj0PMU7D2ct/RqshdKhS5mbGblsMf84Cksgvk4+ujpQwQGBL
 W45ZO++bBZfdjLWpUB864evFzEqHYG1spns39HX67iZ27Z/8X4TjA7Hvwon5K0M7yHd3KdpV61t
 eAhGMW0YJw769H06raGeKL+SpRUmKSrZnvlrkc1QHx6zGS7Vaci8Qhe6HljociAXuFEfNixXIq3
 SwSjOj1eFsDQwbLxSb46LzBdModRW5rMMY5iK3qkCNxnMwFu3+LcdamSBP2jIPeQBENG1TwKid4
 qND96s84vbqwi8PjZP77A8tIdo4e9khPkDMIWP3eqEBS+n5P3nV3E0OkvJkw+Wt2PHwjHKVAwp8
 xpEt/WrrBIe6+kt1wRY0OH4At/Ths9eT0kT6rXOHlXxMLXIbYwwPcp77uWBcjffdI=
X-Received: by 2002:a05:6a20:2447:b0:398:840d:39aa with SMTP id
 adf61e73a8af0-39c8798c90amr5773623637.29.1774677705643; 
 Fri, 27 Mar 2026 23:01:45 -0700 (PDT)
Received: from localhost.localdomain ([171.244.188.41])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76916d26dbsm902635a12.13.2026.03.27.23.01.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 27 Mar 2026 23:01:45 -0700 (PDT)
From: Ngo Luong Thanh Tra <ngotra27101996@gmail.com>
X-Google-Original-From: Ngo Luong Thanh Tra <S4210155@student.rmit.edu.au>
To: u-boot@lists.denx.de
Cc: Ngo Luong Thanh Tra <S4210155@student.rmit.edu.au>,
 Minkyu Kang <mk7.kang@samsung.com>,
 Przemyslaw Marczak <p.marczak@samsung.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/3] board: samsung: fix set_board_info() board_name buffer
 overflow
Date: Sat, 28 Mar 2026 13:01:31 +0700
Message-ID: <20260328060139.63221-1-S4210155@student.rmit.edu.au>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 28 Mar 2026 08:05:42 +0100
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

Replace unbounded sprintf() with snprintf() using sizeof(info) as
the bound when constructing the board_name string from bdname and
bdtype. The previous call had no size limit and could overflow the
64-byte stack buffer if the concatenated string exceeded 63 bytes.

Fixes: c9c36bf56e4c ("samsung: misc: use board specific functions to set env board info")
Signed-off-by: Ngo Luong Thanh Tra <S4210155@student.rmit.edu.au>
To: u-boot@lists.denx.de
---

 board/samsung/common/misc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/samsung/common/misc.c b/board/samsung/common/misc.c
index c134a9d70e2..6718f607875 100644
--- a/board/samsung/common/misc.c
+++ b/board/samsung/common/misc.c
@@ -104,7 +104,7 @@ void set_board_info(void)
 	if (!bdtype)
 		bdtype = "";
 
-	sprintf(info, "%s%s", bdname, bdtype);
+	snprintf(info, sizeof(info), "%s%s", bdname, bdtype);
 	env_set("board_name", info);
 #endif
 	snprintf(info, ARRAY_SIZE(info),  "%s%x-%s%s.dtb",
-- 
2.53.0

base-commit: c704af3c8b0f37929bce8c2a4bba27d6e89919c7
branch: fix/sys-cbsize-overflow-series
