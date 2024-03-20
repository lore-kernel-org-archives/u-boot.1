Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9114FC54E67
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 13:25:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 089B488013;
	Wed, 20 Mar 2024 14:25:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="NxyII+AE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E27988013; Wed, 20 Mar 2024 14:25:46 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26FBC879F6
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 14:25:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 51AED3F5D7
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 13:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1710941141;
 bh=HhF+7+fELdZ+ZhuhJAnDKTSOzYAyM0MK+kV0VJB2kuM=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=NxyII+AER4eqcAxZ2FsLdaKBbOxUWGJLBy+qll0ATC4U2FE7xRb6/a+IN8Ue8DYg0
 +YdY5zvMIFJheWOm9od5PXJxv+u12z4R12ieMIpnFeTEcIyGgivoH/2/qoyL9Q9y0o
 p1Uc3JKoIZAne1EKqCIGm806YUCSISgRLPKWIpgW6EDMc+/BY/3u+UEC6+cosu8SdN
 gpLG2dg47kfuPeVo6AVILP0RskunAh5lIvv1pIo2tmLZG7ekvzH5Ic9DNCXMIbIqH+
 FRfBgpPohN4yhTKgm+6FuKLWi2sQflSYJg9RR/zh80Bp1S4+P8GfDh0vJRR2Vj0cH0
 tIHbnmc3nBXOg==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-33ed2f873b4so2816599f8f.2
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 06:25:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710941140; x=1711545940;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HhF+7+fELdZ+ZhuhJAnDKTSOzYAyM0MK+kV0VJB2kuM=;
 b=Qaj7hS05kdlfQ4GLrgd9FY5QaYS+2e8LuHLSdn7DDGi5FaDvepG2vyL+zIpY0e1bYY
 vxeOPG8sWyAifzpDWjf60pUg+1ln7TNuQaTyPy9woX1UvO9IhCIvqEKQ0hfkNUJ0v6r1
 CsVKqjfOV2YR8J6/eyPfa+qe6S0fY0i6GIT9u0F0nh9nivymFlStB18N0/k+w456Kfjs
 pDqbC4UYCurvwMEe/8vtSgcliTp76v9LXxJbS0gVmv+wewUQDziFyLjPBwXkc1y2VlbL
 nSiLFgWbc3oYv0hDarPSjsB8Zzu8scqSnRs0BLRfUpN/hnmiPtaKyVyC/G54heG2h1+K
 G1FA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqY/kshHxOxiiSqDoeI/fy//tcASPNwN6rU4Fe3K6iZIjCo75r4vDbR1I5e+oS3RkmzMYKYoiiH4WMBoVmGkPu/Aejgg==
X-Gm-Message-State: AOJu0YwxsCHoRvNhOGJlvSCq9vyho8hm7T43dwkvIKkQtiJzgNLzl0TG
 fpSGsbv/ZQGpDS37HJ/+9iGVqnThGjgi1vu8cKWKLsSak4oZgwHyLiI2sJWI32jQuo+f8JIWXtb
 riUJOoYu2djP4iK0SZ/FmwmCGRxpSvU138RhueEy1vwcpjm4mZ78CNsvW+ztDlJKNfTU=
X-Received: by 2002:adf:f5c4:0:b0:33e:7f51:c2f8 with SMTP id
 k4-20020adff5c4000000b0033e7f51c2f8mr12406439wrp.36.1710941140487; 
 Wed, 20 Mar 2024 06:25:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzHjyiYv2BGhWh2vpQWmat1v5BbNr4Rvf7Zm1HmwNiWJmZFOtntNRqw7elG8tSdnimTVzmSQ==
X-Received: by 2002:adf:f5c4:0:b0:33e:7f51:c2f8 with SMTP id
 k4-20020adff5c4000000b0033e7f51c2f8mr12406416wrp.36.1710941140131; 
 Wed, 20 Mar 2024 06:25:40 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 h2-20020a5d6e02000000b0033e91e53e8fsm14820899wrz.24.2024.03.20.06.25.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 06:25:39 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
 Sean Anderson <seanga2@gmail.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] fs: ext4: all file paths are absolute
Date: Wed, 20 Mar 2024 14:25:25 +0100
Message-ID: <20240320132525.46259-1-heinrich.schuchardt@canonical.com>
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

U-Boot only knows absolute file paths. It is inconsistent to require that
saving to an ext4 file system should use a leading '/' wile reading does
not. Remove the superfluous check.

Reported-by: Patrice Chotard <patrice.chotard@foss.st.com>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 fs/ext4/ext4_common.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/ext4/ext4_common.c b/fs/ext4/ext4_common.c
index ea9b92298ba..9eac6beef3b 100644
--- a/fs/ext4/ext4_common.c
+++ b/fs/ext4/ext4_common.c
@@ -765,11 +765,6 @@ int ext4fs_get_parent_inode_num(const char *dirname, char *dname, int flags)
 	struct ext2_inode *first_inode = NULL;
 	struct ext2_inode temp_inode;
 
-	if (*dirname != '/') {
-		printf("Please supply Absolute path\n");
-		return -1;
-	}
-
 	/* TODO: input validation make equivalent to linux */
 	depth_dirname = zalloc(strlen(dirname) + 1);
 	if (!depth_dirname)
-- 
2.43.0

