Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71BD8CD8CB9
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 14:38:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F8A084981;
	Wed, 10 Jun 2026 16:38:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V0ozIDAm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1135584940; Wed, 10 Jun 2026 16:38:26 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CBB984981
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 16:38:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-68b3a28da7eso1136760a12.2
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 07:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781102303; x=1781707103; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CL6N+23XC5c+PtqqGv8vg6sJeWcO9b7kYvRm83/q7kk=;
 b=V0ozIDAmXZX/jKGHat5p6B5IV4eE9Qi2t8cFQcq3vmE8j+FKrgpOo8YQEb+v6c1N6d
 2MPuF4DWEc46BVN6glE7TTItcWzYytbtR96cVTvO0jt0Dofsry7T6Sdq5Zn8A7OVKZmK
 W9akhS5bhxZOFLypASPMErlP6/FUFkelKgQ7efWVyhXejEck8iphziZNB/2QsdTDoPfY
 0icMlOH5qhv+bVnlaNHdu2NbwFl8XGrpt0P32rHYgdGh6uJepV2QuOql3y52LJPq3T0u
 MhyCct2NFFgfYJKodnkYlfT34oFCdoJtpTdZFgD7k4q1NsKdD8+84AuKNvoWh01U4DSM
 D5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781102303; x=1781707103;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CL6N+23XC5c+PtqqGv8vg6sJeWcO9b7kYvRm83/q7kk=;
 b=V+QkKMViHkj9V+PF1FyJA0GW0A7W1ftT5nptctGE16vsd+Sz8Y1ApxETCMvnRs/5Hs
 M2aZnznnpxMPaf2rju647aDL/mWhQV0kYrVQOMujezrAStvxXKqrT6KGFnV/kBQmSOZL
 LcuQM/dKqbBh0fDRiwL5t2LJtirkR9JNyVkYbS3sgRrRTL/k27pLlN3a2d0Xsu0sQv07
 YRIRy+GNr+L3nqc6NX2aAmwlFtj8/dQSdaDlY0eQ23B5RKNszNwxh2iAM0DRrI2GL6mZ
 gpDUDP0oVeYI4eI/w1BJzP/fmQgcK+7nWrTsT918JckslKC5bxFbzTMC8BDMs/HmLAaV
 s7ig==
X-Gm-Message-State: AOJu0YyY/Sk+OVoWgtjbTmrPO4lMV8XsfbsCwCCzQ4RGorNl3YBdC4NQ
 MzDTz8JjL7msDlMNSyH7CfHJGuUBpS8Qsqwt3+IYyAsgCigSng2PZV4F
X-Gm-Gg: Acq92OG3z65jZfxIGeA4AXaareMGZ0xtQgc5UamZkNVsGnNNiay57r6lw3LyAX2mncw
 strk8c4Wy7cxKnCBzD1UZXoR/vCcYAZljaaJKoAHnX7d+yk+wg8CJfDfTwDUCr2qzXHcwRxS7sY
 52iT7atvoKGzm+4/b4uiKN3c+WymQqmmwc5ovZzeT1xperfpIu9gO6MKFqeKC3wDtnmLS6O0puD
 FsS5DMkfbGUO+FA8/NR5LDWwu1X9y60tr2U+y+6Akk6RGVFBfck2U3BvhDGsS8BF1Bv4OIkSwz+
 fN8Wl8dgsl6hk05yzW6aRlJ/0AmF7/o/SSpBit0ahZFEFs9gaIkZXKHn73S6GKqe3VVGZsOqRvX
 QpEwVENPbSMvixvu38otU3iKGDL+0gHW+KlFjeU0n3UtYi1cDWnAHwA6W+o+pzcufofxSETkLS6
 FvT5J0N31JHZ/i2VxgTh7kxrKDuHGJJXsfAFZVNJA8ed141iDQYGTtz0Qdz8+vN62n8z+DfJfY
X-Received: by 2002:a05:6402:4312:b0:691:ace5:8ba7 with SMTP id
 4fb4d7f45d1cf-691ace58cdemr3997959a12.5.1781102303338; 
 Wed, 10 Jun 2026 07:38:23 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68e65b57c66sm9877290a12.28.2026.06.10.07.38.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 07:38:22 -0700 (PDT)
Message-ID: <baced9b3-0ea4-466a-bd5a-9bdfb749400e@gmail.com>
Date: Wed, 10 Jun 2026 16:38:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 06/18] Kconfig: fs: restyle
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
References: <ef462dea-69aa-48df-9f7c-af2e6c54e52a@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <ef462dea-69aa-48df-9f7c-af2e6c54e52a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Restyle all Kconfigs for "fs":
Menu entries   : no space left
Menu attributes: 1 TAB
Help text      : 1 TAB + 2 spaces
Replace '---help---' by 'help'

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 fs/fat/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fat/Kconfig b/fs/fat/Kconfig
index 9606fa48bbed..aa1218448448 100644
--- a/fs/fat/Kconfig
+++ b/fs/fat/Kconfig
@@ -36,4 +36,4 @@ config FS_FAT_HANDLE_SECTOR_SIZE_MISMATCH
 	depends on FS_FAT
 	help
 	  Handle filesystems on media where the hardware block size and
-          the sector size in the FAT metadata do not match.
+	  the sector size in the FAT metadata do not match.
--
2.39.5

