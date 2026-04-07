Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99134FF513E
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 20:41:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7616840B0;
	Tue,  7 Apr 2026 22:41:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RQbqUOpC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1FD284105; Tue,  7 Apr 2026 22:41:25 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32DA0840AB
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 22:41:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-8a032383008so73170836d6.1
 for <u-boot@lists.denx.de>; Tue, 07 Apr 2026 13:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775594482; x=1776199282; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=32pibO1dzSsH85HL3ypsTdeQL9R0ObG28dJn2W01gG4=;
 b=RQbqUOpC0NU4nEBw/i7aVcXH3t97HjtSr1Y/iWdPSPRTK0cu0oWlce6cxq/qOwGL3c
 FTuE9JIPLmGndwbG2v1WPTUtTm0cjrftZ57hB62B5FptRP4RjOxwkTVI0Kp41s85CNGq
 9CebsxDjwajGbWdY4IWvQ8iJrXaxjdO9OCu7PVn5uzhzuxM2KsCJLdPIxQaMuu5X67oZ
 sWoI/ctUd4z/ylugwM/+fofYDjbS5vO9J2S0D9zwB1aG64Hpk+qv34tzm9onc/dQ/Cdm
 qx0cvFOw2c75LA3jV4ZOHI06uLl3cI9xgYTQjByoZ4WyNWhAoLUHh2ubOxiWoDuPEf/T
 yVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775594482; x=1776199282;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=32pibO1dzSsH85HL3ypsTdeQL9R0ObG28dJn2W01gG4=;
 b=XuNFCEUuGTijNA4d0iqbFYrBUR7U+tNf73jLFS0PC+Vs1QAC8BFCfoD+l40uS6wePb
 ut0AH1pU8VgGNjJvdwY/J5Gzp0mZ2I0ksBBagBdllJXpm++7AEb16PSGAOFOeYpHGVM8
 R0nobNQxnc1dB4FlQdwTcpnEi90F18VgI18+SxkTfle8Bf9M0TxV5HAd/CA1EnS61kZ8
 euKD2AcHti+Cz7d79B1feYeCRCw2a4yR7GFvqD/8YCyKiHsUTl8V3+Tk9g8KGfpMAVDt
 jFEnRI8clMwDp6P1xVESlYBhbpbcKfNgr68Gy18k06qB75YPZmsPX5P3EEX5nnELE1FN
 QtGw==
X-Gm-Message-State: AOJu0YzlrCe2Z2noQ7FqjOba/VgUm9mba0Y9zWy/lXprIaukbyOnt2KY
 gv/FeOFCqE1+qsk8CqxI36QklY3kxIVd5SYaEpIDZpOPkJIQ/KTgyl6IXNceFg==
X-Gm-Gg: AeBDiesp85OJzj/ego83ceG3ZhcFALsE0mPm9ShzxwprKLADSchlnKrgDzDkyXkoC48
 H4E/JhhblbwfLe2YTw897bvHkJ1zxnzW7JLqESMPFWRCcdRJ+dUc3kiQ9SeNU0VweUqYsYChSNk
 0a1Dx/GQsrcZ5Xc426qBoUjOTlMaYQKJo0UMdioVthWyM1Mc8wKc5uVHwCt+MB3tpYyTkhT+wmu
 Hif3ROIHqtTBvfzoWo8Oz8cYcIAv+6JuIMGKg6DZAtvaciwnkIJFbc4RNKZT0hgJERaTaQrOGJs
 YXul1X2ZonLUr1gssYDyv6Ji2T0UYN7KLlWMN/EBDqaUzlz7cR9kyakWozUVqS5UPDEykK76q/Q
 fVFHk6CzNF/Ccb6e3LL760CtV9WyYUVlKbhZ757p5r38z6wO+fdHV5ZyE+FKnD5dFXe9fWF2A9w
 S/Bx7eWj7cANtp8+21KY4DLBPwlUpott9sKMxI6tn7Be+LVhMYbUAX3bjjsGQwHb3bn0umuDIEt
 fqnD9zKyQA=
X-Received: by 2002:ad4:5bc3:0:b0:8a5:fcce:4c with SMTP id
 6a1803df08f44-8a7043edff1mr311168776d6.27.1775594481718; 
 Tue, 07 Apr 2026 13:41:21 -0700 (PDT)
Received: from ubuntu.localdomain (172-97-209-197.cpe.distributel.net.
 [172.97.209.197]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8a596e03dc6sm180970166d6.34.2026.04.07.13.41.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 13:41:21 -0700 (PDT)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@riscstar.com>,
 Raymond Mao <raymondmaoca@gmail.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH] smbios: Add an explicit bounds check for Type 9 length
Date: Tue,  7 Apr 2026 16:41:09 -0400
Message-Id: <20260407204113.3102785-1-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Raymond Mao <raymond.mao@riscstar.com>

Fix Coverity Scan defect on Type 9 length.
Type 9 formatted length is built dynamically from peer_grouping_count.
Although peer_grouping_count is a byte, the resulting formatted area
still must fit in the SMBIOS header length field (u8).
Add an explicit bounds check before extending len, so the size used by
map_sysmem() and memset() is guaranteed to be valid and consistent
with hdr.length.

Fixes: a8442c226635 ("smbios: add support for dynamic generation of Type 9 system slot tables")
Addresses-Coverity-ID: CID 645487: Insecure data handling (TAINTED_SCALAR)
Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
---
 lib/smbios.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/smbios.c b/lib/smbios.c
index d5f18c8bd69..18c48b15d2a 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -1093,6 +1093,9 @@ static int smbios_write_type9_1slot(ulong *current, int handle,
 	 * TODO:
 	 * peer_groups = <peer_grouping_count> * SMBIOS_TYPE9_PGROUP_SIZE
 	 */
+	if (len + pgroups_size > U8_MAX)
+		return -EINVAL;
+
 	len += pgroups_size;
 
 	t = map_sysmem(*current, len);
-- 
2.25.1

