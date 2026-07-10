Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EED2AC43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 15:20:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51B6C84B42;
	Fri, 10 Jul 2026 17:20:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AFWtZ2PF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E5FF84B4C; Fri, 10 Jul 2026 17:20:48 +0200 (CEST)
Received: from mail-yx1-xb12e.google.com (mail-yx1-xb12e.google.com
 [IPv6:2607:f8b0:4864:20::b12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AE0984B2B
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 17:20:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=naveen.osdev@gmail.com
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-66766d649fdso1513651d50.1
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 08:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783696845; x=1784301645; darn=lists.denx.de;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6NZWJkLdUbaP+7z2xfadcvdZo1/QD1ONXi0tQbBi2ZQ=;
 b=AFWtZ2PFfugaY4T3pC8N4hVZFy1Z12zmtfnpoU5qqGCqYycyoDSiiHTRXcL0pYsiv4
 x5/2ivTB9fqGSH/ARXEv2ZvK6l5xC8fgbsMnMtm1Qkh3pvZK9QqwFz7j3iEA9IfhKG3u
 IFZ/8glnmPvm2pX9xHzDvDMsWhE7yaQRb0TWgyi1Ni/7SYM2aCFnuND2J4D+m8RkBDpZ
 lCcj5Z5I2qfZ8cMfVr4c+zIZ7vGGlMZN1uNSoF6nwYZwmwIwAb14bzctiEUOqe8L1qli
 HjQAxX1hnVmR4yoEIGlxRFjz9YQUyAmWUQFqD+MVIvQ8WRThQj0+esjUa0AMJuRN7KDH
 vB9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783696845; x=1784301645;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6NZWJkLdUbaP+7z2xfadcvdZo1/QD1ONXi0tQbBi2ZQ=;
 b=tOfM1SEQWZ6YzvlX4JVbqb9wf39KnkuWEgFqfkvEUmlYItM39CQm7O1lColnERffR0
 JKBZ35d7VxdNuYdKlhixmJC9Ri+xU+4vk+FhlhbClHEs4fWv4DcihBNpIOMfqtgZnY2P
 UTASZthmc60h8kFcPsUUIh91dfs40OfJa1h1tDy3F6W8NfznblF34zvbtYnTnqP2avrz
 /ehWKgc3vbzb7cA5ZZoXAmRnZ0lOCPV6qeDKAeJebIjSflCzgzvnrJcT0ToWtX+a1LfI
 ZUNY1nMQsKCe7eo8bnZ+n0m301avT9OEUvlr4kTRWkXkcs3fB7+E5MPVgX4Jqi8lnARL
 p15A==
X-Gm-Message-State: AOJu0YxkYF9j9l0iwfdqaguOuBwUT2HP6ffrnWP5bbkvcC1tGhrFSPog
 yHpWt3BDn343tWX8f3i+qcwNBzM8//q70M1rGMr5s17bYuEUd9oci2qO
X-Gm-Gg: AfdE7cntPkj6Q3IcmF+GFrdokMpfSJpL8iHw2lGLxOuRvJe6GsgdMY6rfErggT9MM91
 o5XUmP3oRZ6kaucDrVxBFMbOOT3seF3w8W3feyncbFbz7B4JF1LzM7NOcqunUOrLCnVwqLrYaDJ
 6Bu2GfDP5KwkS8b1uqvnwS9YMc+Y/UQfXIIkVJzBOZTxBVDZZAhdqkvB5Q0CdQf6Xbm4/Sq6zhM
 6Tfq8VYLWpuM3DCKMbHnDE2Jb8xbauDs3kwxRSEMoDhJeFQKFsKj/CVFqV+kkWecZpIcgf7seC3
 +CFLxUrcA3sYNXKKfzRSuJpQvTJbabXdsiZwmkQM8ute0qVxlFr6Ljxkhs4d+j/OMDVUb10GC5V
 wicj9taOIa3QG4es6vULEP7dJfzZ5CaZnGjO131u3hWmzXYsZbe6IQ20EUaALHEONSkdAno3Ohy
 JiDKlGjxU+eAVwAmG0F7xD
X-Received: by 2002:a05:690e:4890:20b0:667:c09c:4a3e with SMTP id
 956f58d0204a3-667c09c6250mr2951494d50.13.1783696845027; 
 Fri, 10 Jul 2026 08:20:45 -0700 (PDT)
Received: from localhost ([49.36.187.33]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-667879cada5sm7089378d50.11.2026.07.10.08.20.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 08:20:44 -0700 (PDT)
Date: Fri, 10 Jul 2026 20:50:40 +0530
From: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
To: jerome.forissier@arm.com, trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [PATCH] cmd: lwip: sntp: fix netif leak when ntpserverip is unset
Message-ID: <oggze2g2aloxhrxqmcnt6tqa5e2lf473vy647b72odfvahwosx@zqawezfx5t7c>
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

sntp_loop() allocates a netif via net_lwip_new_netif() and normally
releases it with net_lwip_remove_netif() before returning. The error
path taken when no explicit server IP is passed and ntp_server_known()
is false returns -1 directly without freeing the netif, leaking the
lwIP netif structure (and its associated state) on every failed
invocation of the sntp command.

Call net_lwip_remove_netif(netif) before returning on this path so it
matches the other exits.

Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
---
 cmd/lwip/sntp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/cmd/lwip/sntp.c b/cmd/lwip/sntp.c
index 608345c873b..a3659c73ce1 100644
--- a/cmd/lwip/sntp.c
+++ b/cmd/lwip/sntp.c
@@ -71,6 +71,7 @@ static int sntp_loop(struct udevice *udev, ip_addr_t *srvip)
 	} else {
 		if (!ntp_server_known()) {
 			log_err("error: ntpserverip not set\n");
+			net_lwip_remove_netif(netif);
 			return -1;
 		}
 	}
-- 
2.43.0

