Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D75CEE348
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 18:07:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71AD483F82;
	Tue, 18 Nov 2025 19:04:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SyXdagBo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6157483F87; Tue, 18 Nov 2025 19:04:21 +0100 (CET)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4617983F80
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 19:04:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-3ebd1b07919so719725fac.0
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 10:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763489058; x=1764093858; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=heUesR0v7UQ7a+X50xrYlP8eM31tWusbkY7uB3r8WmY=;
 b=SyXdagBoKt01AwljhFFHmN7BrIEmOWsA3HnU0W/9PkI1wi0/aOGPUVQLK3qKP9EHYn
 oMv/Z0OYZ/UeT2Pc77TJqBw/dMBoAxThRPVeyYRRdWALAWOljhlIPJKI08gRoKeFMGxd
 WCT7ulGy9dVRn9JER9wHJku+bUTBfvoSKl7jk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763489058; x=1764093858;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=heUesR0v7UQ7a+X50xrYlP8eM31tWusbkY7uB3r8WmY=;
 b=E4mGT7xJNOfGyBrQfAY9k74rgnvUGJLpDjZV8sYj0/BH74guBndf4gCWy6KSBWlcdb
 9/grHW+DkFM9ZIfFK70AjNemeUZjKKlkGOhrJtZureeiEcUd3xSgUEplhj4IrcN9ozmz
 vBCS6rbgasRmLNOgDAIMMwR3hj+328qR9PwaUtrKgzpwo7bYUox/gSq7Gq/044GmPYJ8
 C1p7+asVNQV/FqLECf1KNkTwxgbNsH4sbXy5CmxU7dNbb1wrwrnYZIlvbzwRWibvYz7k
 y1jk9orLlCqVooGOVZDptn0N7LepLFoi7L/07G45DfKyz1mYm9greunSZEwwytrVQXer
 aAjQ==
X-Gm-Message-State: AOJu0YwThgzh6sOEzcM1qty8bw31fapP1BXysVgmdLp15ntPLhPAB/yY
 /4RjOhsRCg/d5lPkRo3rIX7jcnuN+ziqPhvGTSctZ+3q3tbRoWj5FYsLAj0+CKxy+NiNXPGOBod
 A/5ogAvxo6g==
X-Gm-Gg: ASbGncuISt4DQf0B3YKew8yJeAKBZS9rvBDvrYDrUXXOrMjlVOhXBsBgzA4UYwBelyN
 86Au4U6fYfdmatmmw/0pEqsBOzZO354smzc+tZ5a8SCC2dfNI32n2bGBO4Wkb4yGvHfZNALj6Wg
 EmqjhMosu31th0PZkVFUfNbJXMq8onr7NrKogNfyV93Y2FNeI26kqoI8P8isOgUUtGueirVsVO3
 lvziiM8I6RI+asTL98vhFJIPdRF2hrCmJ46nL6PzKA0nXOPMR3pWOmus/ZWVQW8ZjD9Ip4zruE4
 0FlSn9enyzuTVTO+RVCD695my0MokT7z1QXaoFmzJCZhCB0HI0MXIEYFSnIl8GwfQvBqY79jJc5
 MBXZXxcZIfjcfyfnJ3XPqnDFP1OWFJtXb5cHUMCDzqWBfN/L3OIP5qAlMRf6JVhwjEWQts6djNf
 1UuSt9yQgrcYAo3TtAM4sRpK/UBWuGBoD8hHQcQzc0hf8lRUSoMjwslPgwWyIC9eg=
X-Google-Smtp-Source: AGHT+IGihmrG2K46qIZWC2JQMz9TW1uQKh6JxW/09ELY1e/F1GQNPaEs6uxWMCpnNguSWxkerYF2qQ==
X-Received: by 2002:a05:6871:3608:b0:3ec:3ee9:3aa with SMTP id
 586e51a60fabf-3ec3ee90a11mr3925982fac.20.1763489057986; 
 Tue, 18 Nov 2025 10:04:17 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e851ffcdd8sm7373579fac.3.2025.11.18.10.04.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 10:04:17 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] mx6ul_14x14_evk: Stop disabling device tree relocation
Date: Tue, 18 Nov 2025 12:04:16 -0600
Message-ID: <20251118180416.591255-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

Remove setting of fdt_high to ~0, which disables device tree relocation,
from the default environment. Doing so prevents U-Boot from correcting
problems such as having an unaligned device tree and leads to various
failure modes in the OS.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
If there is some window of memory that must be used for where the device
tree is relocated to, bootm_low + bootm_size (or often just bootm_size)
or bootm_mapsize are the correct way do this. Please see
doc/usage/environment.rst for more details.

Cc: Peng Fan <peng.fan@nxp.com>
---
 include/configs/mx6ul_14x14_evk.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/mx6ul_14x14_evk.h b/include/configs/mx6ul_14x14_evk.h
index 203a037e3423..e5f8d736900c 100644
--- a/include/configs/mx6ul_14x14_evk.h
+++ b/include/configs/mx6ul_14x14_evk.h
@@ -34,7 +34,6 @@
 	"script=boot.scr\0" \
 	"image=zImage\0" \
 	"console=ttymxc0\0" \
-	"fdt_high=0xffffffff\0" \
 	"initrd_high=0xffffffff\0" \
 	"fdt_file=undefined\0" \
 	"fdt_addr=0x83000000\0" \
-- 
2.43.0

