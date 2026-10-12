Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B40ECCA9EC5
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 14:01:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 752446067D;
	Mon, 12 Oct 2026 14:01:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tEscfBqD2v6X; Mon, 12 Oct 2026 14:01:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C6690606A2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791813688;
	b=r0w7czJWmxbUqUPPotcXnPyw+++TO/lo3uVR+FG4C48zAgieuBiQlFHfBPjkMhBS/BIy
	 MWXFC7yT0xuOGu7ZZIgvzK/VCPBPu7bpq4QdUGpX3o2N4rhWSdT/1LnOzT77yh++GSMKG
	 nNLyHNkp7ARPlz3MGPreaNsXPZ6vq5VbsMDkizIKNZsiwTRPZSnumLignQw6Ov/L8CrK9
	 UdBchQVJDRj0hd5fwBTGEvhh+G7VUIf33a16EEph5zZp0kmAWSW93dvZBjHGIx0G2vuZT
	 KpdR2d7j+VK5o9GARqm+zq5lk9R3X6AYswbZFSexAvD2lHW2XRCIoumoafoyZ5/+HtA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791813688;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=vNN6SxAHPYxFU2K/d+U3lBFVdfQBtoFnQVWEgzoNdsI=;
	b=OCXbJsdtEpP+9WhlnZmU99oxM3mVK6829M6jGNM5KtndVaDJFXPPe1v6CR9f4hmpqhdr
	 /H4t99isaAD/t1Pv+D/3vXjJ3mX9Uk8ACHqSlPv5elfBSKI/QmXu2iy92rJq/RRSJX1RC
	 z8KccblwoVKPBz22f2e/uIXtPxUotnEA8Iyl7l2CV3+eYYoyU/nnZNuzoKbPcqPVcpY20
	 8FHnSSQw+PMDUeSwslWMvhQyHlNQDU/OdbZ0kzkAPUqSosPE20HKYS7iceAV2TaRIGQwC
	 jYqw2h8DFPX0TZfOs7du9SgmRqxzvRCJeIJSdXCCp3EKSiSCycbCiV/Z+RRszWHrVlg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791813688;
	bh=vNN6SxAHPYxFU2K/d+U3lBFVdfQBtoFnQVWEgzoNdsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=blIenULd1LEOuVbX6rBYWYeBHImCsT8D2B0Welki43/wQmRPi4iJEADAybLsfrtVg
	 JUWZ6laGUn2nV0eUnTQ8nP2sH/0jqi0VIBzt6y0bu0CbkyjIKYHwJOwIBzaCu6fZON
	 mLN37YHDVdRX2c+Qo72qlkJAUHKdr6cJRDjJDippkL84Q8UyHzp+9RnwcBGCxMZjss
	 b+rpSoRzXVkyyRWBtTwOvKZrpF9PAY7/dV+RTTELDNB8dzIyY+0AsL7igP+9u14F4W
	 bHTCNYQX0eiDaQg9ReGtA68c9T3TAWQZ+psORs2Su62fglaLSjD32DqPNivt/3K17O
	 jUxF+eC7EYCwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C6690606A2;
	Mon, 12 Oct 2026 14:01:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6F96E179
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:01:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5585080DDC
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:01:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZLViyVeNpQxI for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 14:01:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5274E80DB2
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791813685;
 b=oM5s4m3dmsg53uQN5ZBJwoKD+kxZa5F0G19IPWVddep9cLhVXCzcvnfcyHBupdDl+I6g
 GbPgyIAIF0vSgsF+cItiqWcEKI+gaN3IHELZd19YQcut3Qo03nYjmMD4wAYlQgEL7ilrq
 lq20BriHQfANn8H/d8Xubg5HlLqWeByNkQ2wgaqnwB8Xa04otUy61VxfiyUL5rfaF803V
 bfmX3sm9eVsuVPIWSOWkAN3hel7Q/rUnhnRZiS1XQ/CGp3Zl3/T44XWJBzGos3vkrV8Q3
 8r09EjITJHSTwl/IxDR3zPbEPQN1WFeg0fpLt7wk6QrfpuL0OCuNqLOj7X9opMSfjkA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791813685;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=vNN6SxAHPYxFU2K/d+U3lBFVdfQBtoFnQVWEgzoNdsI=;
 b=ixQvC32aMi7YNQsUYpPqcyBiitipbHxqRgMAQv35lOY0rW0rrLjqHbicYOelO6HC8JpA
 9WvxeKnon0S9xxa7jlSZyhXNlm2jYRMieGTAN+hrRPcXduyvx6ozK805LXq7zgtds4e8z
 TAqeMs+eGLLeBs+bDr3a4yUyC6jcrXv2MVPASCIOylShRoST/9KYQpYxdpDZ0rjDMQaBu
 BlNzJ+Q4k6awuaKpP1VT4m6Zqvd06O8HQy9J3rHj7SOq8o1kvgAPmxL8ylb98Hg3v4Q2N
 IXHv2G95UDYkkVO/pgM6G6+v45HvXIGgn/MLNqdHShTE3PHcs3jDdhKvT3JnH0JA5kA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=aV6++DoU; 
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=aV6++DoU
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5274E80DB2
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:01:21 +0000 (UTC)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C48E93F193
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1791813678;
 bh=vNN6SxAHPYxFU2K/d+U3lBFVdfQBtoFnQVWEgzoNdsI=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=aV6++DoUegAOH4x6Rvb5dDQ4H4BBJhfU5HsgHou6AUS/wf0SVR/7dFIZfsOYPJxbC
 23k+gat60jEqnzsphvaJT27vq0J3td0ZBVdn8+w8mblYlCzShQonvkj2TG8WpbN+rS
 COD0iPyeBtkskMDz4zHvpLNHXunHeUWWnKls4UG+SuP4mhnazohAc1dkPAuAP8MaiX
 8pGlzeK9ImL04rcO/Ed0wqGiHRINth1r5I+oyvnoEC8e7D3lTrnpuB/YfhqbJENxWB
 BILLfy/7lOmff9PrZfxL8oqsQtt649LY2MtBYr3pzbh0sRbfqIWrUh0YJxkdiklAYA
 3dJ9fr7WYFUeYlfZgor9yrXCYiLgI8IeQhI4hLEDPaa+onQQIlgBscTsMpmlqrJ5LP
 KnYh/Vv28CK2GThfgoWuUvDJCWYOq8HvzeX+Uhvz2tP7KClz9PAOAQ5R4u6zPVkilK
 0uQA0cgT81mfe8bWa4XGi+NRMJOhkCmyRw3vGD8aOsmdKwYjsiZTrGuSZN5VLC+2h9
 14hNBuQLYuwOVy8UEe2sjVEbN7TsVP97cTxof0+zuaZGoFoizS/r2CtEjz59QS9uEH
 3NTSwFgil2oDsJo4g4hXJvkSvPsHZdccCWTeYzJ+wFi/NGZXrriURJoK5sdKEkBxRF
 p52FcbdFwzvs4XJhcbjL65Os=
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a019d53f46so15472345e9.3
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 07:01:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791813678; x=1792418478;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vNN6SxAHPYxFU2K/d+U3lBFVdfQBtoFnQVWEgzoNdsI=;
 b=vq1P+8a/lQu5EZhL8OSwh2RWemI0coiLx4MQXhtbffSYon11/DWh/ynImnW3Hzokct
 CdbxcgFzart5TTTzy9iALugpC4Jl30tIo6gV9rbsaFfOyBfEvgCe2S0y1B+XramIYbP6
 PFD7irwa3IZTw+5UgvlzDlFIhPFwCh6GJRGMTgbVbQ5xfosa/OAAjibyb2sn8aab2v4s
 ypDLQqNnjlRmAx0xGjSdfZM287e6UpGdZVukdSBVsPjc5ipPlLEVCxtP0Ns+Yj5dLEv5
 Kb8ADKTFfKQASDYjLnL4KM/7YEBxrSjsHWqIu5x8V8Vj/hP09Is+c32PeIcFiRmG0sJE
 wMLg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxWVIBfu4hoKwtKeYgGiwQis8arbpg407MclWS+D0UTTOYc0iVrS+++dgpsWgfY5ZaPnJL69zk=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLrxX+5diRn6nw497rU1fmEa79vpnR9aPO4aBcfNjYNjgFl/0Qj
 gN6zB1djWU2S7W73YlUUNkDHnH/NZlwPhU9iDn70rnXvsNRxVf8wjtDmOaLPebH1WMnc1C60V4t
 oJMQZqa9aVgNg4MEOKl2B22nZ91xpTR1vUUhjKWvkavrc1HfZqkElBFYaosF7JwXKNG2+NmjeWZ
 RMekltoCV/xw==
X-Gm-Gg: AYBFou28uQisH/B8RcljK42eXld0nqtA4v6oJ2IwzwAtBCqH5AN2wkbLCmXsx9SuRW0
 hEz/sC/PIzKMfSY7689egX5ODhgAv+xROAnmHG+lSIxu5DG75KlhJhNxZ9w2xE2KOKFy/oyJfxP
 U1s080I+CYV40WI/JBbSfphW8hZ3Ejp237XCAFB45T1GsWsy3H9PcHiZYDr1WXQAGbdxin9jkH7
 GJIcPt/wm+h47gJz2LS3ekGLZV9tEcreJ4KIo7k0RL0AyUAZUjxg/SWCpLfHnbfS+e5S/e48+2J
 2QQfLbJZVPoR28IGw+pAIoilWgjbNYWgpEgXu3vMxjdnKd/cMX+JCfmtmgtvtbgN/4/lo9Tp5Qd
 EAeAnXpIT13GczAKjFc8t1gO+sMzICDuX1dIWOW9Q23uKEfQRwudjs7o=
X-Received: by 2002:a05:600c:5251:b0:49f:e772:6ddf with SMTP id
 5b1f17b1804b1-4a18e4d5a01mr178546905e9.32.1791813677864; 
 Mon, 12 Oct 2026 07:01:17 -0700 (PDT)
X-Received: by 2002:a05:600c:5251:b0:49f:e772:6ddf with SMTP id
 5b1f17b1804b1-4a18e4d5a01mr178545955e9.32.1791813677203; 
 Mon, 12 Oct 2026 07:01:17 -0700 (PDT)
Received: from workstation5 ([2a02:908:1242:30e0:468d:767c:32e6:22fa])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf15691sm284551015e9.6.2026.10.12.07.01.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 07:01:16 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Huang Jianan <jnhuang95@gmail.com>,
 Daniel Munic <v-dmunic@microsoft.com>, Tony Dinh <mibodhi@gmail.com>,
 Alexey Charkov <alchark@flipper.net>, Vincent Jardin <vjardin@free.fr>,
 joaomarcos.costa@bootlin.com, Aristo Chen <aristo.chen@canonical.com>,
 u-boot@lists.u-boot-project.org, linux-erofs@lists.ozlabs.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 4/9] fs: ext4: don't read time fields in XPL
Date: Mon, 12 Oct 2026 16:00:43 +0200
Message-ID: <20261012140048.214059-5-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012140048.214059-1-heinrich.schuchardt@canonical.com>
References: <20261012140048.214059-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The ext4 readdir implementation populates dent time fields in XML
builds though that information is never used.

Guard the three rtc_to_tm() calls with !IS_ENABLED(CONFIG_XPL_BUILD),
consistent with the FAT driver.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 fs/ext4/ext4fs.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/ext4fs.c b/fs/ext4/ext4fs.c
index 3c79a889bc2..abf4a9835bc 100644
--- a/fs/ext4/ext4fs.c
+++ b/fs/ext4/ext4fs.c
@@ -319,9 +319,11 @@ int ext4fs_readdir(struct fs_dir_stream *fs_dirs, struct fs_dirent **dentp)
 		dent->type = FILETYPE_UNKNOWN;
 	}
 
-	rtc_to_tm(fdiro.inode.atime, &dent->access_time);
-	rtc_to_tm(fdiro.inode.ctime, &dent->create_time);
-	rtc_to_tm(fdiro.inode.mtime, &dent->change_time);
+	if (!IS_ENABLED(CONFIG_XPL_BUILD)) {
+		rtc_to_tm(le32_to_cpu(fdiro.inode.atime), &dent->access_time);
+		rtc_to_tm(le32_to_cpu(fdiro.inode.ctime), &dent->create_time);
+		rtc_to_tm(le32_to_cpu(fdiro.inode.mtime), &dent->change_time);
+	}
 
 	dirs->fpos += le16_to_cpu(dirent.direntlen);
 	dent->size = fdiro.inode.size;
-- 
2.55.0

