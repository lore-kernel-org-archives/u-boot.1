Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4764CC87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 15:46:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8C3B83890;
	Tue,  5 Aug 2025 17:45:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eQFLBo2E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2D85838D2; Tue,  5 Aug 2025 17:45:53 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3771838BB
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 17:45:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-459ddada9b1so19227815e9.0
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 08:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754408750; x=1755013550; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6SVVu3jW0hlLAN/LZLapahGE3amVARgUKFHuGAONITk=;
 b=eQFLBo2EOtWA8zcOGGiGiS5VHUsGDWqk1mdAYjUqpj72bebgXbJcCGIkVH9DNVJKLU
 cBtmvld8jJuPpe6s9zWb25InpAxV9GKy+mkp+bSXqsBd1T9lt5fF1wkk4+itCZJ8oPW+
 3j/nlix1bgeYh1IcaTe8V/6VBsWVG1W5bEDDCDCureHO0GDBK6YW0DrtINArY5KVZkqD
 CqVmNCK74bOQN4x/JtuPs1JenbMH/l1mCtfKfrBHfFzHXHl+uZu1dIssdirrysxV+pAN
 NAbHBRgYheNfMZgftLdUkkc/pV0h6YR8xeiZcoK1ECL2gZI5FNELSePglrELnK+Vuai8
 WLOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754408750; x=1755013550;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6SVVu3jW0hlLAN/LZLapahGE3amVARgUKFHuGAONITk=;
 b=iUyoU50REIykKTzE1NzF4MD6qkmfwM5co6MnZAxYrx+7WUqYtUxePQwuOnWybezRrA
 OIPT8WPTIoesgPyiOqS2wbL9w6FQvRxiu1E1QbSSml1nMEvdSPtzF9Ga2ssksVTsbT5h
 GhNKILI/cVBBDlY1rI41WU6cFENb7ifILxkNbajsexXNm/C3xgiEvHRiQPi4aARrSq69
 DhUZgGZjtYszksH4oYX/H07Z/I6jfSZGgO+0syy9Hm/AItP7768LiU6Vb41LYHiTuqnf
 JfwGWmixECWM8tK/ObIfLULMbyCUrNz49uALJc5qHYvYPV4nUSdauM7fW5ms3mYio11D
 sR9g==
X-Gm-Message-State: AOJu0YxrjRBA/v7Y/jsLNZ7k557siruhhvrg+O7gHkDDzhuFHTUTI9vT
 i1NGk1eZ/YmYC8QVnMerSWOjqv1Yr9y88Dh2ozd5D+YBjWHyK/HD5B3W7LZK57yCeIk=
X-Gm-Gg: ASbGncv7rIcP31K8ZFRWG8Ofji3jWbBunE3qzgunbmVvjwPi73Fb8/jK4JFy8Fo+Aqo
 O3iNcmpJmjagH0wTvh7cSuVL0EzT3N37+MUPltcsnLeG4ZOY/zydrRoMSQpC9s8EaxBu4OSPa1h
 teJGDjORJrjKCtOx2QXQWytl/BBh+DK2XhwlquEC8cLGHuyl7Oj60OOhDsq8bHaPX1vPaHcCnCi
 q1lgI3Wr+tU/+hzIkoqANvpBZjf1f3z6TfoWbdHyf9N5bvcV904ZWwU7hWJGXt8ZdaKBAwCyfEZ
 hxIdO8OkcIKETQib/X2ukseFueyt675WCVpPKkbgteZY6XW9ERhcdjN20xnl4zgXkkTsj1zkxCZ
 4NSZ/gWvpHRZPx5ei7nfo/7gR1BjtVImjY1PEpKLwQOo+51Uj1uVR3vBqJvQ6UA==
X-Google-Smtp-Source: AGHT+IEuqZRYrGTGKB8eJNjDKcrP+ZgyZPXMuOh1cerEXB40ULus2at47tmWmf49dYKlbIOUluKoqQ==
X-Received: by 2002:a05:600c:354b:b0:459:e094:92c2 with SMTP id
 5b1f17b1804b1-459e0949526mr36245615e9.27.1754408750340; 
 Tue, 05 Aug 2025 08:45:50 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:60bc:24e3:6dcd:9f35])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e5852e28sm9007255e9.9.2025.08.05.08.45.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 08:45:49 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 05 Aug 2025 16:45:47 +0100
Subject: [PATCH 1/3] net: octeontx: Remove unneeded code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-net_octeontx-v1-1-637095d82265@linaro.org>
References: <20250805-net_octeontx-v1-0-637095d82265@linaro.org>
In-Reply-To: <20250805-net_octeontx-v1-0-637095d82265@linaro.org>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

In nicvf_rcv_pkt_handler there is no need to initialise err as it is
assigned to immediately after. Also the test for !pkt will return if
true meaning that pkt is guaranteed to be true after that code block and
so no need to test for it and the redundant test can be removed.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/net/octeontx/nicvf_main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/octeontx/nicvf_main.c b/drivers/net/octeontx/nicvf_main.c
index 27d0327c88a..8021cd752b5 100644
--- a/drivers/net/octeontx/nicvf_main.c
+++ b/drivers/net/octeontx/nicvf_main.c
@@ -232,7 +232,7 @@ static int nicvf_rcv_pkt_handler(struct nicvf *nic,
 
 	size_t pkt_len;
 	struct cqe_rx_t *cqe_rx = (struct cqe_rx_t *)cq_desc;
-	int err = 0;
+	int err;
 
 	/* Check for errors */
 	err = nicvf_check_cqe_rx_errs(nic, cq, cq_desc);
@@ -245,8 +245,7 @@ static int nicvf_rcv_pkt_handler(struct nicvf *nic,
 		return -1;
 	}
 
-	if (pkt)
-		*ppkt = pkt;
+	*ppkt = pkt;
 
 	return pkt_len;
 }

-- 
2.39.5

