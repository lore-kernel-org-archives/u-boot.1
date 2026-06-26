Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F940CDE008
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 03:49:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D5218496E;
	Fri, 26 Jun 2026 05:49:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k+XHn+tK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8717A84987; Fri, 26 Jun 2026 05:49:24 +0200 (CEST)
Received: from mail-dy1-x1330.google.com (mail-dy1-x1330.google.com
 [IPv6:2607:f8b0:4864:20::1330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E6B68495E
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 05:49:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=naveen.osdev@gmail.com
Received: by mail-dy1-x1330.google.com with SMTP id
 5a478bee46e88-3078e0dcd67so919019eec.0
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 20:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782445761; x=1783050561; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lSQcOB0hf6OUtGFQVWD9gSBxAyIxPZJuEiH82oVFdbY=;
 b=k+XHn+tKK5hBxpx4DMNO09J8T08/TWqKhYyeDwllflhjwo0nSE+ypInLa1SWSv/9YG
 8Kxrin+iaaU/5VLGk6vUdqg1+prwFmPzZNvN2LHv8oWddF0QAJ3dUnOoTwFoNw7V26Ek
 A7DPI0+0pbnRiXvCgtgZS9HNFznr//wPMpV6ussjgewvfs6uBvQ0M272FVdGnVgFfFGZ
 XY8Ck69hgn4NZOWbZMpB4VON9dZd05meAoxg1kFO50qTk+Q5dy+r3VuXhh/J7UES4CGk
 D4YvTRLODU5aXZ5A5/vFnBcdcpA6sEZvFD7xvMzvQueF3amD2wHv9q/B8AidLva0MpNw
 HO4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782445761; x=1783050561;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lSQcOB0hf6OUtGFQVWD9gSBxAyIxPZJuEiH82oVFdbY=;
 b=KckKZ6IxtS1AhtWjTOm8SdnXmoGcQkOPyCabH9fqrz3x2kMcLO48YBlf5/vstyr+/4
 YZuCXKQyFd1+IGYL70/HUp2AtcjRDPt7Hxv/xY3yWwM6FyvlvJx7Fxer60rldM48/xUj
 hKqfADAfCtLJOmPBNoQlFsSzoLQ4ui50r1Ka5xovGpG09PAxVbnuagV6KAfnHxljggy4
 yVryG19wp4bm6u9ZvknpQ4Zf6xu0QjHVj++g7jUt5lYfulGnsOaJwmCwmGJ+9oW2XU7g
 bRi8nXs93mA+W/rzf4NHHw/FG2GghLuFR3+Z7wEfkwnNg8aQUF3wWEaSmlrridZDTpFd
 hydg==
X-Gm-Message-State: AOJu0YwXYGJvsdt/rqgI0a3GFrqRXs5pSy14WOQV9wKr8vW05uSR2fbX
 7KboeLv46YackxDBB8Cekyyd4N+7GbwNGaLzaEoaIbwQCU9xFvBryW2lVGQFSRSO
X-Gm-Gg: AfdE7cmOcWL+S99xk9cd7EAqPzWq1Fcc/1xy12a0GrYiLJLRnBLi7LgRC9FykzBz5r1
 egGo1X7b/4+p+oEApkGjWM/Aq4JuANyJhYUPkF6XdfKy/67FVnVgQLN45THwor4Rnt9SShvG1nq
 AMmATJHHrNubuPbwCmSRiVV76xKIS5l8dPe1HSwFHZIpLcmdTmiHiqQT0MzFf3/eFUojz0XxTOt
 Y2mjh77vvK2spJuPGFL9PDGwfEfQmaACMchbDJ6sHurYRECcMSG78mrVBalm4c/t4mI7QWIkumg
 QYvO/T28lx3NhxrS3aJdrj3JCOQaA0dcr5FSsn6kXkJLoPwy0D6yO6WoSV8rvWCr97zaDiQynxY
 EbFVurzvmL5UhBFj/zJY8xXtaEidr85SqkqB0lxNwUlGTC2oG5xagP/EHwjvGo5DQcTk3fnGbak
 vSi4TLNuU2WustlWqzMEZIAKp0
X-Received: by 2002:a05:7301:2f8f:b0:2cb:4b8f:b2bd with SMTP id
 5a478bee46e88-30c84b1d6f7mr5608999eec.6.1782445760593; 
 Thu, 25 Jun 2026 20:49:20 -0700 (PDT)
Received: from localhost ([2405:201:4027:a919:e2b2:8560:26ea:4d1])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8b1a80sm13154878eec.18.2026.06.25.20.49.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 20:49:20 -0700 (PDT)
Date: Fri, 26 Jun 2026 09:19:18 +0530
From: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
To: sjg@chromium.org, trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [PATCH] cmd: upl: fix off-by-one argc check in do_upl_read
Message-ID: <du4aieuv6qxikfsii4jlactmin5verpehbdwrescc7xyx56736@lrv6wnhukn63>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

do_upl_read() guards against missing arguments with "argc < 1", but
argc always counts argv[0] (the command name) so that condition is
never true. The function then unconditionally dereferences argv[1],
which is out of bounds when the user runs "upl read" with no address
argument and feeds garbage into hextoul()/map_sysmem().

Use "argc < 2" so the address argument is actually required.

Fixes: 264f4b0b34c ("upl: Add a command")
Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
---
 cmd/upl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/upl.c b/cmd/upl.c
index ef2183d8528..be21ec258cb 100644
--- a/cmd/upl.c
+++ b/cmd/upl.c
@@ -93,7 +93,7 @@ static int do_upl_read(struct cmd_tbl *cmdtp, int flag, int argc,
 	ulong addr;
 	int ret;
 
-	if (argc < 1)
+	if (argc < 2)
 		return CMD_RET_USAGE;
 	addr = hextoul(argv[1], NULL);
 
-- 
2.43.0

