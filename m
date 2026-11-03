Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE29606A327
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 12:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aFLCq08l;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Gm1CwkMI
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8C4D560816;
	Tue,  3 Nov 2026 12:40:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ec3q5TJ7nEyX; Tue,  3 Nov 2026 12:40:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D2F69607AE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793709636;
	b=F5p+akCcvCVPb/LX5bhwIaPZaVprMCBXa9DIp9IAkDnepC+tBHShsfPP+6cYoZ79yWM1
	 zSYvGdL+gLUIwe1qEmqdp21je1Ne67o7pFgS3qjSzBrHK1A/6nei3/uYzeIqO7nr4aU6m
	 qvXHpfATS2RNsfMBLugUULS1H307x72Mfbd3brUCDcx48zXvIP3eP/2mpA5mNfAldgrPV
	 3KapU5Bo8rT4ZrVrLCkiJxHjoQHe+GY7oNqA8tHnVOOnsjHQdadumI/I+Kox2T7g3W0eF
	 XrCMYccF1igtnzJjE8bApLW8dnP6lgUnylpuWeoJRRVUq/koODNEpbUM2M81Emqruuw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793709636;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=aUiEAe0Fri/Fs2BKkEEo0Nz8y0S57uEwr47g8bZZitU=;
	b=GN/VjNlGrX/eLXLfWC6ePDyUl2LOaFtsPXDxoXRYQGstXU8ZJom6JdXzzMTqfU77CGQm
	 FX+7+jHsjPUzqOiPvfdZ34BrnXfv9qCYaSMHwHBfXau0BRMSzOtrMUD+S75kljXL9fMpg
	 I+q8/pb3sGORWa9LfNc65abKcX5R6HOlUJ0vxGc+naGo+5g6rXYQCKjPDfJNn8V6UvfIO
	 b4mtwqjFQRe19JU5yoV9p7htc4LdKo8+hT6/gM7leXpCICWcK+GkQfouDBRP2bJwLMlSv
	 QvDtQbn1sa9+9FBI72XWCIHF2p/w5ZS+CdE1KMyqM0wWCSlf3f6vTBEnuyPifewt2Wg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Gm1CwkMI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793709636;
	bh=aUiEAe0Fri/Fs2BKkEEo0Nz8y0S57uEwr47g8bZZitU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aFLCq08lcMXXi9xWgvmde5+u2acLKv6/h7OPyce32GPjRLXgryJz4puxL3bnobWBX
	 b1HyqJ/Paxn4coRAini6dDS1eCO6w73koJEi91NhvOBx9yIgrXd+zDlisv93O307hy
	 I72f5/puBJRjqmBqkG7mrLofAqAdtttdGpXQg0kXvY5q/mAY/wV9PUfQhBLMJPDHuF
	 8HyDEOQRbfmjMaouxj0PJ73MkWwrsunhZ/g0XgNi/QEL6OE7sumG5WB0JOX5seAypi
	 aZeV8hRA4/e8DOa+4VqGtaJPSWcTspEneNc4ND2X0LupGjTHamd3N9TSvySNiYRzRg
	 pdyFO++PmPDFg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D2F69607AE;
	Tue,  3 Nov 2026 12:40:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7B3D5235
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 12:40:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5778560663
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 12:40:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2qhuWGvg8LVA for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 12:40:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7B176607FE
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793709631;
 b=nWXp7wafhNaVzQdbdsEjxT/J3vV0PO2z0JbRgmef6zSeO5aLhdpK3+0ePty3o1dcANuj
 X+mY//4JlCcRVqRvE7fyokqyyFnAvpZI+FouvNXxMshCgx5kx4kqcs4M/RrdOuf4aqNwA
 gnXM1stBX+Ne8airMYNugXc6hGiN0WNH/UzuFG1ynT98zr59TGKE71y7Z3TKxjdcdBWCk
 YIec3JC53DI1AG8y1vM6HKWafHfTswMy1YR+NDAQWJ6zRvn7J0Kr7Ulqp1r3q1uNkIH5l
 3/0UGDM8sxtk0rMmUxv+OYdxiTKr2DKYAr6bA4MxL4+1fosgjAZfGiV8Hk9tccM5iXg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793709631;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=aUiEAe0Fri/Fs2BKkEEo0Nz8y0S57uEwr47g8bZZitU=;
 b=TLu3r5IN+nX+vTc2lWfJYenEjQd68Fk7KoEGG7e6b7LpoRbe5oUZMdzl/M3di6o0mti1
 TQdvwivCisTVE7XvPWNo7RqFOWlzMFlDvbQxIz2uBPAow+up6xruZQyZUF7AvpbiMD0QG
 +V2SxP2RDi4H0gu0EpYGhc8kkDYfEibpsdSsja0mowonbdtSsvHc1h4G0r65T/jWPyNo8
 cy3bMuJQGE+9THZga8xR8DRsSqyLEWIV0W9MaNX6k43PGI9NUtZiUP+BLqH5Rl5VIsVDy
 yPQew4+x1iqyzvbfp25vZB/mwzf/2xdJZURnVPcA/fWx/xS/1Eci1fJ0TlC2reM5B+g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Gm1CwkMI; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=ddrake@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Gm1CwkMI
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7B176607FE
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 12:40:30 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4afe2d546f9so25144195e9.3
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 04:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793709629; x=1794314429;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aUiEAe0Fri/Fs2BKkEEo0Nz8y0S57uEwr47g8bZZitU=;
 b=Gm1CwkMI1NSjWfDYoax6Yye00YKeUSYbLIiSLYAGecIr9ZDL9/JYrYnMg0ITg6F0ej
 ZTB/whbGqOTPk28WwvXA/hP04kImXQQgLUJz7P9yrVC7NgQ0nECKlTGi5Qei1bdwNM7m
 zJLDNINDkU+b6EKkVTKDLDnpmHzs+XJt2fNe8dJVXSeZPNwrCGL0NFEY4PEd5QRHThQD
 5K+wUn+UFN6Hqwo6m4sklNtx47KQolSd4ysNFwuH/aanlCE6skTG4QrVQq1fMGNhSb3M
 znJJfh7tG1Wb9Te4EX180Mqd7iyE7XSL4QITWeSBu+/U4gm5DyJOFkiHIBEFB3k9udzo
 Tvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793709629; x=1794314429;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aUiEAe0Fri/Fs2BKkEEo0Nz8y0S57uEwr47g8bZZitU=;
 b=fzuhqg8C/tJ2arnAPnVEJlgEtN9G47W8l+cdcYMBdH15aZbjbIkexWhBrwV25kONAm
 J25a2+jXdlXAWI5sauDWHZ9eGyPalwnLYbbXyXhZV5O/CwhciBh+4RqTA3Yttp76RhRe
 Ts8tx7v0TkIjtW8veQ4e2mlpeKxj9ayfisjkuH3MCCqVgJPHQX19dPr9zGXh8i6jsF40
 ncM0ByBHa5p2VRzVQ3aMrdV8NZX/IRudoJRrE1SEfnznLmaZZdORtixu62vHrAKa4iQ8
 CNSFKP2rrr78qWbndNgRzDfpY+Otndy9V8ttcrlrPCVnl0vOPZqfknev57t58m59rmry
 D8Eg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwyC5qLd+JVsOP6SzgEVlyeF8n95uQTbKXHOsPVWjbYvH3s7sSOuj07wzBO1cy2KCnhu5I4dDs=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9L2q9OaFHHC9TBZrzlXIcq5QNxLwv5uG1Y5T7qhmXUfo666zZd
 eddtMZUDOmhqUI41D8nykB9KuKO/etedVxlXi7vapVASHIAonSIvwJQhfX7vRZh7eS3MJPo6kK1
 ofuWfrx4=
X-Gm-Gg: AYBFou0o+yg/Q7BoP4nThqckq8AAvE3F77AlXnMwOOS71MYPXbsyTTp33tD/zsHi+Zh
 Gp/v5wEvh2kEav3lmVVSUYWj2SN6pF5+Y6ajjPbdlpknjy8vluDDGJcec7OydHwtpf+cAQa0cYq
 7PIJP9F1ANZWmh3NJ81X0Mun5TXJnwm//4NVdO3ZcQiR998i9MOfO/zBClTOlLO9GYut0Ow+0+b
 fp5dqhOMLGde7XLkhVfDJ0f8BJuRzZHNXSVpjvoV2MmYjNICzT7RyB5QM6KTyf00+l5Sa8iJzSd
 4MpV0eSYcdHbIyhxmTjbVQI9W1eHtlWGYO8+ifmU6nSHR+EMptvqv9pOWlCYNs9XuGATx6Yk2WV
 llvepxgy9srsYVnhH3KI1Retu5ljGjgXJ58QQodXYDXoypnAL5u6TwsNIk5HpC3/PV3CY/JCUy3
 8eJ48u4wZWnttDZ78TAK/JXDrawtfPVHvqV3YSv4/0eUEi45S3dZTz/Y4BSU0Xr2TWRy/fQTDai
 +4ZDw7TD4mK2mGmFcNMIc77zWEdjiCOUUvbBMqs02UK4ReF85ZQbUWRP810qL0buER1IPpI3hm/
 tBMBLRdYM+aKUBRdzLNfPBTMdXc7KctMSBO2jw==
X-Received: by 2002:a05:600c:8b0a:b0:4a1:777b:8a12 with SMTP id
 5b1f17b1804b1-4ac1709ae4emr318378535e9.14.1793709628899; 
 Tue, 03 Nov 2026 04:40:28 -0800 (PST)
Received: from [192.168.1.123] ([2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a555e59dsm60369835e9.0.2026.11.03.04.40.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 04:40:28 -0800 (PST)
From: Daniel Drake <ddrake@baylibre.com>
Date: Tue, 03 Nov 2026 12:39:24 +0000
Subject: [PATCH 3/4] board: phytec: phycore-imx91-93: use common USB boot
 fastboot handling
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-imx-usb-boot-fastboot-v1-3-f3a918d55a20@baylibre.com>
References: <20261103-imx-usb-boot-fastboot-v1-0-f3a918d55a20@baylibre.com>
In-Reply-To: <20261103-imx-usb-boot-fastboot-v1-0-f3a918d55a20@baylibre.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 u-boot@lists.u-boot-project.org, Christoph Stoidner <c.stoidner@phytec.de>, 
 upstream@lists.phytec.de
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Daniel Drake <ddrake@baylibre.com>, Ye Li <ye.li@nxp.com>, 
 Simona Toaca <simona.toaca@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Mathieu Othacehe <m.othacehe@gmail.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Torsten Rupp <torsten.rupp@8tronix.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Marek Vasut <marex@nabladev.com>, u-boot@dh-electronics.com
X-Mailer: b4 0.14.3
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

Common i.MX code now handles the USB_BOOT case by prepending fastboot
to the default bootcmd.

Remove the phycore_imx91_93 handling which is now unnecessary.
The common code has the exact same behaviour (only the console message
differs).

Signed-off-by: Daniel Drake <ddrake@baylibre.com>
---
 board/phytec/phycore_imx91_93/phycore-imx91-93.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/board/phytec/phycore_imx91_93/phycore-imx91-93.c b/board/phytec/phycore_imx91_93/phycore-imx91-93.c
index 2605a3bd09e..e41e1451098 100644
--- a/board/phytec/phycore_imx91_93/phycore-imx91-93.c
+++ b/board/phytec/phycore_imx91_93/phycore-imx91-93.c
@@ -41,11 +41,6 @@ int board_late_init(void)
 	case MMC1_BOOT:
 		env_set_ulong("mmcdev", 0);
 		break;
-	case USB_BOOT:
-		printf("Detect USB boot. Will enter fastboot mode!\n");
-		if (!strcmp(env_get("bootcmd"), env_get_default("bootcmd")))
-			env_set("bootcmd", "fastboot 0; bootflow scan -lb;");
-		break;
 	default:
 		break;
 	}

-- 
2.56.0

