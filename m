Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C192C282C5
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 04:42:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6AF680F70;
	Mon,  3 Mar 2025 05:42:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="VCv1jpP+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30408807B1; Sun,  2 Mar 2025 19:28:36 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 159F08058A
 for <u-boot@lists.denx.de>; Sun,  2 Mar 2025 19:28:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrea.porta@suse.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-abf57138cfaso214188966b.1
 for <u-boot@lists.denx.de>; Sun, 02 Mar 2025 10:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1740940112; x=1741544912; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NwEI0f0l0vmiog65iIFcc+EUG/N3flB8fbhZg8SAvcA=;
 b=VCv1jpP+1zvkhUxWFU2OS+MejwrGTmBoC9J2tUYgWbIAV4t7lkd2211ZFbG7Sb89j6
 17yaCbk2kXCqwtBiovQPwft19gmFmt/iUOooqMtEhsWggsIxyoouSzuwdrYDfsH3utv2
 rAjIBeDpe2/Jh3cerXlfh0ssVLKW7adrxseI8wIYLhv+BU5G7rJNU62U79srUaKtp/Y4
 Phsk01TIcB7yy5p5XzqY8f+aw4M/IHHtbUgKRMYrbuThmBNX2TGM4PLKyw2SQUz8iDvd
 GB1RJwpeqeMnqtaCD1sHMV7t48KSdJXrS2VjxkP2BKuexdueqJ71I8yQLBXLcI1qlWiN
 B5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740940112; x=1741544912;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NwEI0f0l0vmiog65iIFcc+EUG/N3flB8fbhZg8SAvcA=;
 b=YyqNuvgNe5JO/41IpP3fGFEEOyhIfcJJNphBOEt4Z73sbtMWgoWWFL8hF9QX8yrxv6
 Qit7vJ2DpI91bkhX9Gj72fzP5EGdoPc1AfNd68bfm2OwpJxlDm7oaLi9HXK+RMuI1uXF
 8689EniAHc7R7Fr3BduRB8NqQrEI5/KVU8cbajIWt6hGPMYqbOiifKBNZ0uhXDxDr7Ax
 ZiOwh5cFL61P3liL8fZV1QSXwb2j7CGn6C8D7ovnwHv6n7hlfVx/E/ItC4pbyIl7NSSi
 e0BRtGrKTzQ23xbwnAYs4eE3tcYPBgSptw5Nj9ilGYaQOKCJPNZdBvebqOpY4aqPMuFF
 OKfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9g9IF1YKyN+FnJ4s5HryH8rTNlGdDJFDJTFREJYS9RjkFk21/JRG7VI4uBuTpL5nctojyd0o=@lists.denx.de
X-Gm-Message-State: AOJu0YxsbbLubQiYtF1n9jPhaKhc2ql/o0NRmTNN1BsN8p1fqiB3bgDF
 fFK8nyF5LCGSul63u/T+AN7vI7Gp/r7E2wACGymJZs6+AqvYjBRdbCgD16ENOOg=
X-Gm-Gg: ASbGncvSERLNt5MvT9rpnTEdilkuM16pVYDYlpGBxqnAEYOlqnQbzWDZOgkqQ3AHg9s
 OxmUNWK31dRhnAEw8QjKXYBglPg/N4pSwUErG/YNGx6x5SupOzCRvPYh3gHip6Bj+HhFKFeEsdQ
 HO+iaREqP5wwMgYrBJhSgAJDpKkJsgJlOZVWtd8Hc4DCoakU6NviV9le1hm57UPUOtk94miTI+e
 lqICUIxWUIEiPj8pICbkOrWzbyRGZCVYvdKuY3pj07Zu82a86VTnE5vROx+1tpMG0OLgtcz+BTl
 Lf8dAZXBKH1bROxLd/44u1HFcU3B+euWXzbmSLxAfUw3fx5JeL91ZAGHCWJ76QvZ2gu+4twX/E3
 SMKtqNpMUqA==
X-Google-Smtp-Source: AGHT+IGqNQKpIALXYeZkVaNx+tVQpxUetBAVmsNyUfw5uzxkOTw1164pahHUbv+OOz8+EErcsgrITw==
X-Received: by 2002:a17:907:728d:b0:abe:f72b:b3b7 with SMTP id
 a640c23a62f3a-abf2683d64amr1484714666b.54.1740940112308; 
 Sun, 02 Mar 2025 10:28:32 -0800 (PST)
Received: from localhost (host-79-16-5-252.retail.telecomitalia.it.
 [79.16.5.252]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf599604cesm285087966b.126.2025.03.02.10.28.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Mar 2025 10:28:32 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
To: Joao Marcos Costa <jmcosta944@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH] fs/squashfs: Fix memory leak in sqfs_size_nest()
Date: Sun,  2 Mar 2025 19:29:31 +0100
Message-ID: <20250302182931.15519-1-andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 03 Mar 2025 05:42:45 +0100
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

In case MAX_SYMLINK_NEST is reached while determining the size
on a symlink node, the function returns immediately.
This would not free the resources after the free_strings: label
causing a memory leak.

Set the ret value and just break out of the switch to fix this.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 fs/squashfs/sqfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/squashfs/sqfs.c b/fs/squashfs/sqfs.c
index b9314019b1..ac5b1cda3e 100644
--- a/fs/squashfs/sqfs.c
+++ b/fs/squashfs/sqfs.c
@@ -1700,7 +1700,8 @@ static int sqfs_size_nest(const char *filename, loff_t *size)
 	case SQFS_LSYMLINK_TYPE:
 		if (++symlinknest == MAX_SYMLINK_NEST) {
 			*size = 0;
-			return -ELOOP;
+			ret = -ELOOP;
+			break;
 		}
 
 		symlink = (struct squashfs_symlink_inode *)ipos;
-- 
2.44.0

