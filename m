Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB41C4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 07:10:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26C2B889D4;
	Tue, 23 Apr 2024 09:09:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="oCDgmlYu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62041889D7; Tue, 23 Apr 2024 09:09:58 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 681C7889D3
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 09:09:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 08C6C3FE51
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 07:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1713856196;
 bh=cmpBTizH+SaB6NI2Q8QdFr+8CCsA3d9XQe7HZa+MrFA=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=oCDgmlYuNxaockWbiLcoZHcW6UvKqKiCdF/NBf9JpabZz22wCT7OZ2KhkoB4a0Hjk
 L5H7oze76nSUJE+yUwsz8M1mTZ6L8itiiI2fxnEDy1tACFG8GwNgBMzrzmaPomLZKx
 mIb5o9I2r5s9KLvPv+6IzChDzHgCcT1KnEuJzUlseqh+ckAlBNxA6ck+wEEG34WMws
 clZPM1BcHEJs2OYCX6vcDfN9vH7TizjRve30l/blCUDX5w2IuveSiktJrXpUXaA1Te
 DJxHzFBjGk5Yb1DkLkViXhXqH8haD1UB6iW/tYtTk65Mtod3pMmRoFVDd4AelG3LGi
 qMsjHQLDoT1ug==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-34b5bece899so503795f8f.3
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 00:09:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713856194; x=1714460994;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cmpBTizH+SaB6NI2Q8QdFr+8CCsA3d9XQe7HZa+MrFA=;
 b=FhB+3v4dAuBtCSbWOIp5+Ae22sP3siKzu1iaUvmbKKcTfTXXDXTPertcIRX4prQPll
 +dm4uHAn17wG8IOBFE0HMQhWng8EfDPhRd041nF49ZuQoXluvM2ud+Xw1IwVSFIv5EKp
 JchdWsso2O4ckJwo/eG5r8zDf6C3M3kmn3SFPDMODHhBire8e4Cko2vXRbMkNAnH9b/v
 WsqPa9PDuVYjUboMsngiJx01GCQUfnVrnS4pBH3cqzaAuVrz+6+xy/60ogdFX44l10fv
 qMTioRCwZNE++p9HpMFV/V4zzLf+WHXYgl4g2HawYxktZD/p27iEQXnPKJxHkkyMXR3p
 RRiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBIwkLN462YY4w/hM5CjJHYIp/scFrSgBxk8siI++kGQIg0qsBRDnZSIgdE9/dfjacRIxy+JikmpRwOY07wxnH8Ydr8g==
X-Gm-Message-State: AOJu0YydazgIyyelZt2rXIHl05e+ICCLQbCdenIgEiVDvVrWzH/MLWdF
 DIX0UfrgKDVHdPhXjUY4kPsgCf36dqrp/7pyhTRjBkrcBMjoTVUjUZ+iEFMhEsuBGzy+r88npP5
 JCqZeK82CLg67Ru1X+kHkgJcc7nsHgej5N0vozPkv2gBi2+uUuspMfujgV2iVz9Kh9vo=
X-Received: by 2002:adf:cc8e:0:b0:345:bbf8:5587 with SMTP id
 p14-20020adfcc8e000000b00345bbf85587mr9517010wrj.8.1713856193743; 
 Tue, 23 Apr 2024 00:09:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8g07x0ZxBT++V9JTFb1NXG6AfFH26y6it6HoP8UZ5o7TotvUaeYEG5UvePj/CL8KK6EaeKQ==
X-Received: by 2002:adf:cc8e:0:b0:345:bbf8:5587 with SMTP id
 p14-20020adfcc8e000000b00345bbf85587mr9516986wrj.8.1713856193335; 
 Tue, 23 Apr 2024 00:09:53 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 d9-20020adfe2c9000000b00349a5b8eba6sm13823348wrj.34.2024.04.23.00.09.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 00:09:52 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Sean Edmond <seanedmond@microsoft.com>,
 Charles Hardin <ckhardin@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] net: consider option-length when parsing NIS domain
Date: Tue, 23 Apr 2024 09:09:44 +0200
Message-ID: <20240423070944.36526-1-heinrich.schuchardt@canonical.com>
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

When parsing option 40 (network information service domain) the
option length is in variable 'oplen' and not in 'size'.

Addresses-Coverity-ID: 492765 Uninitialized variables (UNINIT)
Fixes: 8ab388bfdbcf ("net: add support to parse the NIS domain for the dhcp options")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 net/bootp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bootp.c b/net/bootp.c
index c15472f5d37..86c56803c76 100644
--- a/net/bootp.c
+++ b/net/bootp.c
@@ -886,7 +886,7 @@ static void dhcp_process_options(uchar *popt, uchar *end)
 		case 40:	/* NIS Domain name */
 			if (net_nis_domain[0] == 0) {
 				size = truncate_sz("NIS Domain Name",
-					sizeof(net_nis_domain), size);
+					sizeof(net_nis_domain), oplen);
 				memcpy(&net_nis_domain, popt + 2, size);
 				net_nis_domain[size] = 0;
 			}
-- 
2.43.0

