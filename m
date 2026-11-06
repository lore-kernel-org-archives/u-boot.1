Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7AB606A330
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 21:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XRK7UeMr;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CZZKoD/t
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 255F9608B7;
	Fri,  6 Nov 2026 21:04:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c4AEPwJZBPpB; Fri,  6 Nov 2026 21:04:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 24276608E7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793999062;
	b=pJvSu2IWTnj9leWoYiNVNVfQJISXnLri05FAELPCfDTabPTvbnc4hZxA0h48VoQfRjrB
	 iWWlE0TMy9D2nDibG0P+jbOrLrtBB+5fOtLb8Yo3TPTmU8+XSZpCw8TcFkEhfr3z3xBQg
	 mxtjOeFtKL4xbyQtnU9RCUdpM7owJRDsxPzqSnrDEW2xIIHkJa8QhAwKjY/FVAFyszmSW
	 mtS13JufE0FJDihL2MbCmVxwI4UPuvtHae2d2zJAmLIdBz1ArN0wymyA5Y4KZfFpkvPOS
	 6JHchLMr97WprGmmUM2IO99q6A23Sg4w9QGl5/rUVrKZj4TxT+a1z0tIC3I3Z4BiwiA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793999062;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=f05JSUdRuvSw3zOi09GfmHiyyYLyFQBC+YjWTi6lG08=;
	b=G0a+o6FGW00A8e5amfwguCvWz9m1KeMkHLxgV7KwMW4UZ/eOmVn0O/xub4Q6i01cE0pr
	 SjsWecJzmnk7fZKfW9CCa0Q/islKH92sm1JgOL/+X640/TuPeTORaTb0e0MX7cwuR0aAF
	 PA4uU3PhOreO46ZVs5mrWfhJzvOorLEK519panOtBoplCRex89/CtbhRAXnsXMqT7nfr0
	 Y22H9NXNV9VVHrwDs+xabwr9933nCxsEheZFopHn7v/XNo2EZcy7t5QIrSycnMg43/fcs
	 a+VxQApM/dmg2NjwdRI535c6P+v5HYNRiV1zMJl8gYKYAVv3V3E/3CEX/nlH8DrepGw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793999062;
	bh=f05JSUdRuvSw3zOi09GfmHiyyYLyFQBC+YjWTi6lG08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XRK7UeMrFRebXDee6OBmiP+rzcySMEiGfbwMlvQb728H0dPSd1LlGrtSPnMXaoy5L
	 hr5by07AGb8rl37RjLNfpbFsqoqxmxcTxs1KUW+vy2g7mV08nRSKybB41VQwe6gbnb
	 Zgd0FfmIEQRBl9HgV4J2WtXZ1BXqrmq3av/zmj+V4OwWW4PtsnLjGV6Uh4MvqeWIdC
	 wUVvixsK4cRcmDW3oiJ5PYwk61na4HbpcwJLTzSINhcipqFDHmOW1N0P+OKDyidKzT
	 pkqntg6cr0fGigRrSwukyL1FW3r7VqCx0Cfc35+Q0g/YRJm5+odn7FQb1/hUttTn2n
	 ZXg4wJ/B0+0og==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 24276608E7;
	Fri,  6 Nov 2026 21:04:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 95BCF32A
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 19:46:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 93237400F3
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 19:46:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uJozowwabdsA for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 19:46:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E083E400A2
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::f32"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f32; helo=mail-qv1-xf32.google.com;
 envelope-from=oss.patchbox@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=CZZKoD/t
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E083E400A2
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 19:46:30 +0000 (UTC)
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-91c9cfd8b1bso11461086d6.1
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 11:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793994389; x=1794599189;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f05JSUdRuvSw3zOi09GfmHiyyYLyFQBC+YjWTi6lG08=;
 b=CZZKoD/tx0RIYkaHIbgFBDIW/wvTOmaQ7HCdg0FsRTv2qMzPrrgN8GeFoD0NE9n17J
 xQe142zry+BA6XOgQtrgUGHWVpZe274wMhw4ieoszZ8VdTm3lU+OGeAialQsYLceLaou
 hicdh3DCO50mlNTxULizL908qhJlFKVpevgn1xP2ENzF0VSjyP4Xz47DCArY0cQa3Fec
 +pzqgMVi//T06rgMx6De9WozsmdHjm62E3eVo4Uux40JVZNq3GeWFXRj+vfgDaHwXX5V
 c7Px5k2Ui0xWpEbhhMfcRuZISDfGvBfFrLofyG+QJutHhSb8dvOiEChXx5r3Hmm4XX/J
 YfiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793994389; x=1794599189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=f05JSUdRuvSw3zOi09GfmHiyyYLyFQBC+YjWTi6lG08=;
 b=ly7Xr9NUkK/4ev/n14T/6M3R1lTiDQFYiSupfjxaduZDGWs9S3IWTlDM3HVeF/6BYz
 JplnxLThI14wSKO5jzD3/U+NmJT8l+PU+bJdGsF9eKZvPvlMPeJtB8aBBYw67ti1fhA9
 pN2VpwvS3P47CqVp0GHWqg9foz7mQI/jqpl9EVYSszyJeCDReoPG9bzfmw9kfXIJd5NV
 XPK27hO1FBFk8qSVwS6Wdf6bm2yyPhlwnKUooBF1B8smxRu0q0G/gnkVeG8sfjS7yxlk
 XyZ5GjcBzHZQU2tIqkdXSvBLRT4OPPVpIJr/CrZ7PPwtmK9PzbxznvIPVFnsqSr6hCQe
 rVGw==
X-Forwarded-Encrypted: i=1;
 AL+hErFkF+GRhj44HjWxMMtZQvEy5cAuZWddssrNOLZex3SGO5qH9eYykNpfCUYuczXJo9FcZwKoEdI=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9qO9/At1dqB+yRBqrw5YE922hbwwNZILM7Vsze2Qc6PF5mNUZd
 QmWFwVNJ+rXJoxrbuFcGVpWpDvl0lTwQEunSGFPx0UuV6dOSO6xcrVsZ
X-Gm-Gg: AYBFou2LBGFPUflBknRcRMvDKzkwhZ4N+PQdCbeTSpKjbNGI63X5K9730QiUzMvd1qh
 OrYy7/RVhbEtMFWx9zVbP0YvFtQ7i9iRETB3ywnTwiakIaBRituzHYH0rLt3GKWMGqZ9qYJqxxX
 nzMtgA2n13NqojPCEmlMI4hLVLIt9LIMVHxrz5Is2TdYUiE1KgVVgEj31h277P3xF+iM+2Vpheu
 +3mb6sCXnuWBNCNqGdMl5CdveFQMwbHL/y01NTtwouiFI54Qw3VZnRFg0oSrLbkQx0ubCUBcFQp
 ESfWDo8Phm4NwQwGOyJHv3VtyEaY35mqpWeUWpMFaRCli8YMePyKMXyEPNlXoQXey5i/KbEfdEh
 ZBj/fRdH5OIYMw4BzZOscf4spEz66cx1kqznprXcqw9HrVed7X84PtllOpkME9tYEQZvNeYxEIw
 07EoJDpUSLEWqP5+lvrUM0oC7PA8zw8VhOevIiKt8Il7gXwD9WrLxenNXJrKEGDvu8X+KqAUDQh
 TpvKIsGZWGDKo9kpYfAwXIy/D6MZggl0Onu0sqqvC8/uhlMDpZXEt4duMiRo0tczIVK91XxP7uI
 qVlG40qwB+C2TIN7G9Kdl0QZFj1skq6eWFu3g9EdfKZbXP9xl8Rp
X-Received: by 2002:a0c:f207:0:b0:91c:74be:97ad with SMTP id
 6a1803df08f44-91ea97f1defmr48335686d6.44.1793994388960; 
 Fri, 06 Nov 2026 11:46:28 -0800 (PST)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ea867655esm25303246d6.37.2026.11.06.11.46.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 11:46:28 -0800 (PST)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Stephan Gerhold <stephan@gerhold.net>, Linus Walleij <linusw@kernel.org>,
 Greg Malysa <malysagreg@gmail.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>, linux@analog.com,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH 1/6] usb: musb-new: ux500: Free the controller if the host
 probe fails
Date: Fri,  6 Nov 2026 14:45:53 -0500
Message-ID: <20261106194621.510146-2-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106194621.510146-1-oss.patchbox@gmail.com>
References: <20261106194621.510146-1-oss.patchbox@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 06 Nov 2026 21:04:15 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In host mode, ux500_musb_probe() allocates the struct musb with
musb_init_controller() and returns the error when musb_lowlevel_init()
fails, for example when no device is connected. The struct musb is not
freed on this path, and the driver core then frees the private data that
holds the only pointer to it. Each 'usb reset', or 'usb start' after
'usb stop', probes the controller again and leaks another one.

Free the struct musb when musb_lowlevel_init() fails.

Fixes: 845d9cf61c3a ("usb: musb-new: Add glue driver for ST-Ericsson Ux500")
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
Build-tested only, with stemmy_defconfig and CONFIG_USB_MUSB_HOST=y.

When musb_start() fails, as it does when ux500_musb_enable() cannot
power on the PHY, musb_lowlevel_init() returns without calling
musb_stop(), so the platform init done by musb_init_controller() is not
undone either. That is not changed here.

 drivers/usb/musb-new/ux500.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/musb-new/ux500.c b/drivers/usb/musb-new/ux500.c
index be0085f403d..c38faa24582 100644
--- a/drivers/usb/musb-new/ux500.c
+++ b/drivers/usb/musb-new/ux500.c
@@ -123,7 +123,11 @@ static int ux500_musb_probe(struct udevice *dev)
 	if (!host->host)
 		return -EIO;
 
-	return musb_lowlevel_init(host);
+	ret = musb_lowlevel_init(host);
+	if (ret)
+		free(host->host);
+
+	return ret;
 #else
 	pdata.mode = MUSB_PERIPHERAL;
 	host->host = musb_init_controller(&pdata, &glue->dev, base);
-- 
2.43.0

