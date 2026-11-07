Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA87B606A339
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 14:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=y7dKZbRz;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=B+1QKdFi
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9E618816FC;
	Sat,  7 Nov 2026 14:33:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jh-LSOVjSu1E; Sat,  7 Nov 2026 14:33:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 52274816D5
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794062029;
	b=NyL5YJH3zTZZVsA+XyNH2Yl7YuJHlNms6sSchOslBlTo50eHb4BQlFaP77CTqMhnLK0q
	 v+GUUq1WJaJSkp9EcdnRFJyXfhaIfKd+M5n7+yXDmXGIuWBrkSlNQf95jAjsEJrd+3HSt
	 M9Argpl0uJURg4B5PBILgSgkV92f/Rx8hTWaNFVf1QG1ttr4mhavg2r8UX5HjfCyEkxR5
	 oIlLcS/8AcNBLCZi0K3NqDLltKg04Mif4vI8iige1nYSoIkJsMyLLa7UdVmU3z8mMjUZ3
	 5iwnC0HTg5feUchs7x+PS8apjYw/hDR/Ch8CpcrhSpjcaCLOPY58MjqTSRjc63kEGKQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794062029;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=l9XKhBq9EHOSAnGQW86AmD6r2D455xrPNmMXWastEog=;
	b=QpBA5JczZM3Cm9T5TTV5SbByFq6sshUYjhdJ9NWgkL8mJmQK1WIbvPoSGIEn6ZZ2MAW7
	 PnU2rpsFYI5+bRP4VEzO60J2SJq2F8LHyY24rIhp31DeMDfLze4ElpNhPW9XV9ykvcMC7
	 ijLXspF8GDsxxkDxsV5EIbuQ5BcOR2eBnR46ya4D6Wj3wFspYkl0nbdatf9QTq8pKQYYp
	 mUWKgAlYucEqQTZhmllL6yUMIYMhu6uxpjR6440n0trkUjf/rj1x+p/l/yo7EY9YsNTjO
	 t2eQeBmWr8CVkBiPPorcvI2Ss7GcxfTgesFjlciB4KrMS8mmOMVNoP2qfznNek9Hmig==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794062029;
	bh=l9XKhBq9EHOSAnGQW86AmD6r2D455xrPNmMXWastEog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=y7dKZbRz7x3Gzrsm1mjQlF9sc8GNbCvM6dJCvAt4EY+ThRTeGUa9eK2pfsTn81Gej
	 YzFbtE2d03/KWCbxvHX9g5IgA+f+HPd3elHuk8uDmp2fdUWve5XXPhMaq5X314UZ3t
	 WHeGw9LG/bDqfn+l7X4Ko8B+sXsw6szK4fgaTAahSjhW0zxOqy9sQUzTiRp/iUssHn
	 8dnHK6vQTqc3J6JNrY/tSfP5PEpsAnAqKcapNnofty3iNyCgRzC86IWAxSA69jmn/i
	 Gwx64GubuMAPls0G4O/rc8msFS/UcfNgPpcRk6916prWFZ1t/mzptqt9j0vbuAj0jx
	 u3+/UKaTYP/WQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 52274816D5;
	Sat,  7 Nov 2026 14:33:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 91AD037D
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 77A3B400E5
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ohzUslNok3-H for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 14:33:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 919374009B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=B+1QKdFi
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 919374009B
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:31 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a2069b9710so14023545e9.2
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 06:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1794062009; x=1794666809;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l9XKhBq9EHOSAnGQW86AmD6r2D455xrPNmMXWastEog=;
 b=B+1QKdFi/gJZNGMHwfOQSQ39h3jI7nLwmTkDCGDAhmGHDEAZ+fdFromUAm5PvEjmQh
 wteYUTrskJsgGgkX1fmNxw8Iu7bErseQoKjoFfBZzILr4zmAy2R0yXyvnAzMJ/wuy/pj
 FgbAabUoyMJRsNq3wizimArkrR1jDvVH2+rkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794062009; x=1794666809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=l9XKhBq9EHOSAnGQW86AmD6r2D455xrPNmMXWastEog=;
 b=T3UodFMdEk8PEoGRN36j5ZD11xttOc8JNJ9CfFfPjzMVzeb8hzESQmqRuQbqbwcDMr
 R5o1gvScGIbV1UWrisjyv7Ytah3TkNPBS8ar0icH1ENg4agGNHCxhNDw6q3i/u77/xZm
 KP+bs0gllcDC/OVpkvwYUCp+J1GaY1Jn6h8/CbHbpK7pSb8wuRX19qTetHLJzxCqTeWM
 K5fuTqzZqZ3Pq9Bfz7HyIYH8MZpjShpke2Et7rqhPk4zIePpK0VmagK5rvHpOWBbn80I
 mbiB3ukKnfS7Qtob+flJdIAM+IwMN7MsiMcHrLBMRJkastce8YVcqNWWnps4IzaxvJsu
 rY2w==
X-Forwarded-Encrypted: i=1;
 AL+hErFMEk+ajbxqkiLKH2Ejx8AXLhaepO0thoIqEVRjRS796+M+D58SDpxw3fgwRs2ILT+2W0Cj69g=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z936YRCRRKu3u/wIeD2/nJbtvvP8zDxqJgQ8GyCT6NvQKA2qWLS
 Afof3SDKa7fvvnKbsKODyQ9agpvy2pbYY87lPB6tcfNimv0OhnCgOxaJqfBrUe304O7WHwQfrAM
 9ARw6
X-Gm-Gg: AYBFou1QYePqbtNLjugz68fiGfqeWrRUpDPjkyARJ4lnHVr9uEzPoS+d6ZzsiIpb0CO
 edkanZKqNlQwrZeNwsosB9T8wSBS0xau3kLh/1xk9Bjj02sakbLPXiX19/2rglyfPOFNvOxYyaV
 iITSAelEokPNOd1SVIcV5LFkAXy/NGm+BbK1uAkKAeLaY9ZN/8Pg4ZB2IWdDCy+QcfWMiqubTnQ
 GR1tHqXVF63f+TdTkgNLGkYC0rIG9eC+hCNm3Zu+tUTeBB3y42/Ac/sr9mutXHtuiPrgQ4bF0Dx
 1vaQ/nH5iOsLxAeuDvxy+334UJWQBouLjd9GP2Q5K9tg85o3Tf8HGc5Jbkc++e5D4LAvkj2vKTd
 iyT/bB3u2kEMnE8q4DD5gHW0zH7FKvghomsmqzOAr7V6A8IW6kmEocNGZYf0J06O/ErKrMDn5BG
 n3RWYlFUYg/TCi/AWw0kDzy0T3EqA2cVh/DBPHkyu/A25MI3tz4ngIfJQQcQ5PFZL0VthiR0hID
 fc8bCb3Hle4zxgB6rmQzEKE/ElqH98w9EzHD59zPfYQ0rNSC/RJ7D9STrWgZfv6LKJoJCBhy67g
 A7uzsi4W/ZecH1BL/xiVrt2ResfgROSqrGlepL95Thy+JXv1BJHQXxDGY0LZb0LJ1dd9bebdLj7
 3+6fXI5UeaJlUqcxI40m0lcGzxBTAxFryjEkEmIvB9Yrwf7jZg6vark8vg9akF1LWg4xfR49QWP
 N+jWJ4cWRxUPXJ3cBBu7deu0hWXg==
X-Received: by 2002:a05:6000:2893:b0:48f:f26d:c5c with SMTP id
 ffacd0b85a97d-492761d00cdmr11406426f8f.9.1794062009285; 
 Sat, 07 Nov 2026 06:33:29 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7cc6187sm10027247f8f.46.2026.11.07.06.33.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 06:33:28 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
 Tom Rini <trini@konsulko.com>, Yannick Fertre <yannick.fertre@foss.st.com>,
 u-boot@lists.denx.de, u-boot@lists.u-boot-project.org,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 22/35] video: stm32: ltdc: fall back to a panel when no
 bridge is connected
Date: Sat,  7 Nov 2026 15:32:12 +0100
Message-ID: <20261107143241.2236511-23-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
References: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With CONFIG_VIDEO_BRIDGE enabled, only bridges are looked up on the LTDC
endpoints, so a panel directly connected to the LTDC, as the RGB one on
the Engicam MicroGEA-STM32MP257D-RMM board, is never found.

Look up a panel when no bridge is connected to the endpoint. Also, reset
the bridge and the panel when no panel is found behind the bridge, so
that the next endpoint is not affected by the failed lookup.

Fixes: 35be94614733 ("video: stm32: ltdc: properly search the first available panel")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 drivers/video/stm32/stm32_ltdc.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/video/stm32/stm32_ltdc.c b/drivers/video/stm32/stm32_ltdc.c
index 267da5debe4e..7bd6724bc2a7 100644
--- a/drivers/video/stm32/stm32_ltdc.c
+++ b/drivers/video/stm32/stm32_ltdc.c
@@ -593,16 +593,21 @@ static int stm32_ltdc_display_init(struct udevice *dev, ofnode *ep_node,
 
 	if (IS_ENABLED(CONFIG_VIDEO_BRIDGE)) {
 		ret = stm32_ltdc_get_remote_device(dev, *ep_node, UCLASS_VIDEO_BRIDGE, bridge);
-		if (ret)
+		if (!ret) {
+			ret = stm32_ltdc_get_panel(*bridge, panel);
+			if (ret) {
+				*bridge = NULL;
+				*panel = NULL;
+			}
+
 			return ret;
+		}
 
-		ret = stm32_ltdc_get_panel(*bridge, panel);
-	} else {
-		/* no bridge, search a panel from display controller node */
-		ret = stm32_ltdc_get_remote_device(dev, *ep_node, UCLASS_PANEL, panel);
+		*bridge = NULL;
 	}
 
-	return ret;
+	/* no bridge, search a panel from display controller node */
+	return stm32_ltdc_get_remote_device(dev, *ep_node, UCLASS_PANEL, panel);
 }
 
 #if IS_ENABLED(CONFIG_TARGET_STM32F469_DISCOVERY)
-- 
2.43.0

