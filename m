Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B53A5C369C2
	for <u-boot@archiver.kernel.org>; Sun, 20 Apr 2025 15:07:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9554682045;
	Sun, 20 Apr 2025 17:07:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="flCp0ZGn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF02181FDE; Sun, 20 Apr 2025 16:40:34 +0200 (CEST)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9267F81F44
 for <u-boot@lists.denx.de>; Sun, 20 Apr 2025 16:40:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-af579e46b5dso2077566a12.3
 for <u-boot@lists.denx.de>; Sun, 20 Apr 2025 07:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745160031; x=1745764831; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JVf+AG+LnUe4dn3WWNl9OYpKc/bUAuaq9P2l+TAE/Zc=;
 b=flCp0ZGnHMdgEB6Ls96FXj2xV4l/2kjfa9qH7dHpBoyYUKZv4i2qaoeP4kfX6AORlo
 thbpkIU4f0nwenwvr6lgzLQMjFF68ZTl/DvSfkAcDmmSufoH/MAKcMST9FjroIGzr+Bj
 Bx7ukY8mLtkPzmlMNb+gYb5DcCCkAPSOyONCR7RjyruQEvse/+Jyp6OCvGYnbcFPvFyt
 mg4U7jvWD2TqjBZ9gvwrkYNrEAX9tWmtPKFyobzLLPt5cKYg1OZKxzTR7N95SMOuj95g
 aWgq2JXmrnUl1wcInEwQ0REf+PmTkK4Rj/sbu5yMxe8aETLaNxh4Cuh6EMph9zb/F4Mv
 DWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745160031; x=1745764831;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JVf+AG+LnUe4dn3WWNl9OYpKc/bUAuaq9P2l+TAE/Zc=;
 b=htKgR22gDyUenB55sPMYdGme4r/aimNGnZk035XO9YcwXZW+AJ1zaICfxlUcbmK0cL
 bBnV19o6N5QMMga0J8F0WFv79qOUmKvvc8yUHHyVOJEhk0PrOcf1cx9EPz/UVPQ65/zM
 sLESgXe+IPIrw6/swlM/MyTIhUvOlhhYoidnizCN/A/v61f45hF+N+KrpGcklP9v/puE
 EbzZJIF8HQBMGAdxlgnjBGgwcjcTSxZpR083QcQndUrEjzK/ZpFfv4fZbMFaMJ2fMPIg
 hIjtNx5QE5bXVoiq2hxfj04LVgUYgCOguPO2zxH/GNM5kvuPrHqlJet1hcCt7CIIiab1
 4pdA==
X-Gm-Message-State: AOJu0YztQrWNluQ0+9IJBvwce9cutSdeo4iNKISagP+QoZpdZE69RcdM
 ZlZKizVhuLL3QNj7/rrLIVlkNqiicZQLBDAWh3cEnU/EMDBB3+ECW5NWpU1/
X-Gm-Gg: ASbGnct3fP/CbIc8XHDwoj0z8VyTZnHKxlJh+XmnJs0MMXAkHYw6hGjjfHm7HnGPrUf
 1VZbNGPHbKS/NAa4nD6NKn7XdLjlwYqKOHU/rDRw2Zv8ZaQi6MB/L51mQ4vmmHObZ0miGXuNeUT
 WU8pG/fm1Rql9IKAZ2IoViyq1X4MqWaeA1bQxLJR8ytlocrXIWKZ7+XIjMrKY+mymUZrtfjqEyu
 6XD4EDGtldf7lDxnhv89Tjo/hbFKDn2NtGUI6EfFgDJM1cKnixq1cjdfCW5dHH32uoaFnVJBAO2
 HG52YfyP2DKlgaBDHehKOY2+9/2mw2F43KNjQuii4QMnhE8j1p/EwGI2eHepctkQuJe5njr/WUl
 a+ElamWbr/hWiPMJY
X-Google-Smtp-Source: AGHT+IEvPkELmIbHzZto0eCCvCIX7F9as9OGH3WjWD9q18lGMtjTNyaJoTUa5yofD8V9eqhHYaddrg==
X-Received: by 2002:a17:90b:3a0c:b0:2ef:31a9:95c6 with SMTP id
 98e67ed59e1d1-3087bb56439mr14938800a91.14.1745160030598; 
 Sun, 20 Apr 2025 07:40:30 -0700 (PDT)
Received: from aristo-b7flip.. (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087e0feb37sm4781479a91.31.2025.04.20.07.40.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Apr 2025 07:40:30 -0700 (PDT)
From: Aristo Chen <jj251510319013@gmail.com>
X-Google-Original-From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: aristo.chen@canonical.com,
	trini@konsulko.com
Subject: [PATCH] doc: remove duplicated "commands"
Date: Sun, 20 Apr 2025 22:39:41 +0800
Message-Id: <20250420143941.300903-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 20 Apr 2025 17:07:50 +0200
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

The "commands" are duplicated, so remove one of them

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 doc/usage/cmd/md.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/usage/cmd/md.rst b/doc/usage/cmd/md.rst
index 9a9919f9ad0..1eeaa824bf2 100644
--- a/doc/usage/cmd/md.rst
+++ b/doc/usage/cmd/md.rst
@@ -21,7 +21,7 @@ format that includes the address, hex data and ASCII display. It supports
 various data sizes and uses the endianness of the target.
 
 The specified data_size and length become the defaults for future memory
-commands commands.
+commands.
 
 address
     start address to display
-- 
2.34.1

