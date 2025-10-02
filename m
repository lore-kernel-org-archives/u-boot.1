Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA78CAC5B0
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 09:29:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58FBA828A2;
	Thu,  2 Oct 2025 11:29:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ulfAx8zI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC59B8328F; Thu,  2 Oct 2025 11:29:18 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53ADA80107
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 11:29:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-4060b4b1200so691989f8f.3
 for <u-boot@lists.denx.de>; Thu, 02 Oct 2025 02:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759397356; x=1760002156; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4eoZKphYlQ9TPMxpqMVHXSiy1bjtSp5xbDr5Ee1Abpk=;
 b=ulfAx8zIRqgVr39DKQJWlM1l5tUi3xAZp/7dk6Gm7xF4BaA0RLd+bCYgmhUNhK2tfd
 nv+hE8mUs0CzHF3wpAfxbWY1JKZjLUjkSGxz7QJ1A+lMxH6uDtTd0Byg/UhwLTFlQOym
 UIOIvRHKbh0B+a6G8VyjEmX443aLJclhc80eBXzBgz+D597ZyGA2erfKENa96TrDdJl4
 yb50GX7BbQCbayjiMDgC5GFNmZUHW32pKxwm4JrMP4G6bkpeKvdg7XJAcQlELzAuLZH1
 Wi74PvVYCaHsEhyB2x/w0uz/xBng6dIo6GMibjhiEI152ewoKIaKAh+N09cXtAk6ycpk
 0UOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759397356; x=1760002156;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4eoZKphYlQ9TPMxpqMVHXSiy1bjtSp5xbDr5Ee1Abpk=;
 b=isNMkLRvCdaDZRUP07erlr5hgwFj7I/zfH4JUYt7Kpf28Y4SKsJ88qS/aZKwq+buoZ
 id6uVRRClYiXnvSgOEgqJgathxrxk3Bay2NsHMX20Nvg40qtmWVo6ThloCZ4yTE8pgyN
 ULOQvBGvnvSeRYQ9vpvpxIlWFXSymjw2QDmaA+KVPoHTbxngkD+ltziimw5dsMyCbCAT
 GF7AYJF5oon5hIoo11AzfEOE+dUbPCGZhcdIbWv6gtbqXKyPVg4kC6tq/ODV6lWozJnL
 HgWh2PeKnmJOZGvD6a822WjB7Kv57IG95b99gC+m8WEEwxTTFWaAijbiBbkKOhr+4iJq
 VAVQ==
X-Gm-Message-State: AOJu0YwU8tweklC26uj5DIQYKV+wc9ZH5Ho8r5nZN2M1pMGGWSSx2dV1
 rYNOTK0fH5MN8ZK1/B4StZp38ey43bUh0dNEomy6yIISqy+PrLU9pbtKt+CNF5r+ZBGLCI1IEXk
 Z5d6I
X-Gm-Gg: ASbGncs+3V2GwwPDlnXVe9huL+y6Lw17AHuYfCYhQMdQeyrfqRryTusKpoNEKcURzTn
 KiInzz5tQJXkldH5KgedpcXpVbmaExXiTudNH7Iqlvi9udsmcFg7U4VgnGFs9V+J9zfm4msS7o3
 s1amStciihbufj4KL0czjnqB8+xA/XrOJKDnP+ou3O+hBKiSen8z554Pkl9jPikFHS9p66eN6iB
 E5GYuBlAHKdEOAP6bs6QQJpcZ9H+ykE1jLbNhjgVVHT+gnszOANiRQUfBkel3JCIOuB1HhXpsMP
 ewVkHpr8md57zXc5oDwwag8U7UETkJQmWp9fGt62SmeimmBcNIkFcTmo52C/tSlb5iCSpgDAQHe
 YvcAK5uPd4tA0y+Rt6l6ZrntEPMULIoYVEPRzzM95rN7Bl3U3Obhnn/Ow00P5oVgKjB2ifM2+7K
 F5MqPIKl2QOwlLFQ==
X-Google-Smtp-Source: AGHT+IEDAvdQJ052Vkc6Gns39/65ODI/hH2ZYhSKxS5O7sC4Ii21nxPmCDmCmZVxAqLqB6j3mfFvkw==
X-Received: by 2002:a5d:588b:0:b0:3ec:1b42:1f8d with SMTP id
 ffacd0b85a97d-425577edcdbmr5306297f8f.10.1759397355716; 
 Thu, 02 Oct 2025 02:29:15 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:ebd:e301:a21d:c610:1e27:3706])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8a6b77sm2844016f8f.6.2025.10.02.02.29.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 02:29:15 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Thu, 02 Oct 2025 10:29:14 +0100
Subject: [PATCH] fs: jffs2: Remove always true test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251002-fs_jffs2-v1-1-d53365c53f8c@linaro.org>
X-B4-Tracking: v=1; b=H4sIAOlF3mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAwMj3bTi+Ky0tGIjXWODJGNz88TENBOTNCWg8oKi1LTMCrBR0bG1tQA
 uW2kLWgAAAA==
X-Change-ID: 20251002-fs_jffs2-30b377aaf44f
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Petr Borsodi <petr.borsodi@i.cz>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.2
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

Testing an unsigned variable to be >= 0 will always be true so remove
this redundant test.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 fs/jffs2/jffs2_1pass.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/jffs2/jffs2_1pass.c b/fs/jffs2/jffs2_1pass.c
index b5f74d65017a08615db25762b41296a172bc9563..137a9585b0b73cd8e4bb19d7799a54bcf66a359d 100644
--- a/fs/jffs2/jffs2_1pass.c
+++ b/fs/jffs2/jffs2_1pass.c
@@ -994,14 +994,12 @@ jffs2_1pass_list_inodes(struct b_lists * pL, u32 pino)
 				}
 			}
 
-			if (i_version >= 0) {
-				if (jDir->type == DT_LNK)
-					jNode = get_node_mem(i_offset, NULL);
-				else
-					jNode = get_fl_mem(i_offset,
-							   sizeof(*jNode),
-							   NULL);
-			}
+			if (jDir->type == DT_LNK)
+				jNode = get_node_mem(i_offset, NULL);
+			else
+				jNode = get_fl_mem(i_offset,
+						   sizeof(*jNode),
+						   NULL);
 
 			dump_inode(pL, jDir, jNode);
 			put_fl_mem(jNode, NULL);

---
base-commit: da47ddebd16a7e1047da8537fbf01558d2a89fcf
change-id: 20251002-fs_jffs2-30b377aaf44f

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

