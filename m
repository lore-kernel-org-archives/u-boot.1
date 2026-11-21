Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B97606A320
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 12:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yKxXz1WL;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=qK1VT/iQ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3515660653;
	Sat, 21 Nov 2026 12:35:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zsq78EvbUgRl; Sat, 21 Nov 2026 12:35:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 80D656065A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795264520;
	b=KqLgNUIospBuWDcNSDO9ZtzVE1i4B0oPQ+KjscQEUPLQmwB1el1vDSlMw6430mV/ogYf
	 8fuu9Ig2e7ZBapZ9bo9nQtTaT5G4BBWB32EunbrQGsAn+OSJxZX9YJR7y+YCJIYnDodDa
	 jJU3UUkgmgsg5sAUZ02sneRjbH6bxZ718yLnJ686jldw5L3I5YZvSHCNmjQtK4GMo/vH2
	 s518vk9kKZRgGm34YxC6ThWzw52Q+YTe1UY4eYQVWEtgLVhhzWl4dGHDFPCrvgrD6eC9Z
	 o2+h3TqVwI5vcCs2VIV1JJzQRpuVk/wpPHiqVI8dm6vKkKd/1LkgmWQIDb8cqkjFTzQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795264520;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8WCpex+dmQFPopCYF/D/Xdmg9WbaWfoQwH+UHaCfYFM=;
	b=L26lUaWV4GLUTtfD6waG+Gm1LC3/YghojjbIWsLtPmz+exsVrdL5siR2436+jzqxhBH9
	 mQ9o60btXF71joBm9C7uR+XrG4vgCAcFWmdKW2HuxHVTVJApeuQpIzUPCw6H6UrSrsbgl
	 3ZU6IBcLmyDKq+LMVNG5tE9BOQ7hO+OO+z5Fw0IjAIGNU3O4OY8vtDOkT1Le0c4En4SPN
	 kzPIdIlDrIkWbUxQ6lEYpKClcuZcTANANTfUP0ObAwrmAGU2389B9VKoQhqPq10TD2Vn3
	 CdfjN0pH9pUFgBwioBNJSsNiuqk+hRjcVjDFVjWWSllCXzckUBKW933t1KmiTtF0yOw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795264520;
	bh=8WCpex+dmQFPopCYF/D/Xdmg9WbaWfoQwH+UHaCfYFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yKxXz1WLwkkSL83RpOXM8J9tq4PE/EXLpRYEGihZ490z8WEUIKgGfLRooty9CNgHy
	 NDWI+v9auGIF5+vx3vSRrf5Ja/pelCsMqcVY68gq+tomSvIRaNp4zmSgQVYIVgrfdE
	 FRM7bvyxNP6Ua/NGFwSWccZiTSHiM8QxkFdwyTo6AzP0c0mOX0DzvZhCw0T2nwrBJO
	 ba2LzIpCTKPQLDx/oxuOXjcPG+lETAYPn+7vgHkW2+mRleVcIbI9nr3Rj8C5SMYvUH
	 nd6+QlFQI5bx2hw/0Eo85ENHnXJivbXsB5U+qQM5aIUHXCjPqYJr2d+9e6zt7yHFid
	 5fuMPToCIrB7g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 80D656065A;
	Sat, 21 Nov 2026 12:35:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A873D9C1
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8EFBB40070
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E7qD34Q8EEWl for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 12:35:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 99E7E40012
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=qK1VT/iQ
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 99E7E40012
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:14 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a2000d5fb1so9792185e9.1
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 04:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795264512; x=1795869312;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8WCpex+dmQFPopCYF/D/Xdmg9WbaWfoQwH+UHaCfYFM=;
 b=qK1VT/iQixNvKcdr03Emj9Q1My5HFRXQYgqGYjX0e95lL8r3a0AG3OT7ce198U78x6
 hYX15a0sB6D6CqQu+mSTbaRSDP2xXBcFWcBQqY3CfJHq2kSV0ZxdusiofRFaSrTLTOqM
 YFo3a9hIzaksx5uLh7CY6QmtFSzOVjorQPhNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795264512; x=1795869312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8WCpex+dmQFPopCYF/D/Xdmg9WbaWfoQwH+UHaCfYFM=;
 b=yf85cWByTzdObTJuw4RM11mTk1B2QeUry5nRkKxuzpHSAkpOlHJtl8zXtl0cnWNAh/
 9GNSTqGRwMa7VNNGv+mL+0uYGWK+IJMeY3qYifauQbRM7wUxE/4D2MHhy7rO6Gd2F6LW
 Mm1/45DPyhqKtA46O3vcqrWir61x7dtoiv2sH/H8FjBgLpecFAGvKGQURe8rw09k0HUe
 UrIQZLkMh0RarFp+1ANv9kVfIh9jbd9hV0HQRibsd1SluMaWk4Por6ITfc2Lt/nkqkfn
 m/9Y2ONdcsjlng+dd241ybkpFD+MIvXatUZSJbEuO7rnStlLnR2FHNDAxA0spMShp2sm
 FVYg==
X-Gm-Message-State: APuU4Z8QMqlx15UUnjfAh0xeWwY48Q4acpT3Q9J0+tfaGO1LYlx8V2qf
 7XSyncK138zPA235i6+BLPPV+G8vl1e0Tb3nXOGNJ2iBuIfA3ZvRQTLLvZJyzFeKON5cE5jHf4s
 n1/lS
X-Gm-Gg: AZFdTZeAGzwVpUZl1MwSgNMkQFJ0su6NfQkrldTtXwrMLb+R6TeGYrhHli3bPoNm0K8
 PP1NI8Qy8p1q7WcVUj9+pBtJEKB7bEJFBIA18QzSOcJvrAVOtpkWZ5D/hr8gJ8hmXbGayuMoXNs
 2RC5PrXgx4qo00eJYptdgKJpvC6K5GgQzZh8ecT2GdbBGSOtxQAxhu7TJ2ebF0sO1mN2PfqFXXB
 Qfy/OkOlHz1GYivGye6tzf1h2EjTUjZtMv2tfrdit7boK2NicKS2D1F3N14opK7XeQLZPvm/AzU
 LaYzOpjrK+/SVCrM0eIEJg99vFGL8JDIclaRgdaFy1j2EYEY3zBEDQMqzkIkIiZI0lyW/IXLH0R
 H6+tN12SF+CjqBT7sN2a17YFzNeX0WBRvOOXQlwkENtfSF6mxxnK84HwIrflXEmyVmQufuYz6xo
 +OLvoJB0ofm/pwqYStg9LHVuqRRhdPxjomVOQMHINBsbGbl86bd6sNAT/KamYAyS4wHde/1ipUi
 bQNNOr1rYvjvSm/95csgfNGyDDiV/tmJwXdhijMRxhnkLOsKrksZgMYHn3hBuSsI+tKIiRI9fwv
 Lal1kfhYQg73SQh20wpAW1f2HVdI5GUP2ITu83iWkS+mbN5kAAIJhKALmgxcnVlnw4cMvopyeXc
 h8lJ3wLXvnn+TsbtZRP4vh8j88fo0KEVE3MDNUMeqip9sL3PVEd2wH2147p1HpW2ED0+KJP2/c7
 6uRKNX7F/udAb1nZVfujg5p1fqQA==
X-Received: by 2002:a05:600c:470a:b0:4a1:d459:db4b with SMTP id
 5b1f17b1804b1-4bb8893071fmr132839885e9.24.1795264512251; 
 Sat, 21 Nov 2026 04:35:12 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d1bsm11720564f8f.8.2026.11.21.04.35.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 04:35:11 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heiko Schocher <hs@nabladev.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, Ye Li <ye.li@nxp.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 08/25] video: bridge: Add check_timing interface
Date: Sat, 21 Nov 2026 13:33:58 +0100
Message-ID: <20261121123451.2471185-9-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261121123451.2471185-1-dario.binacchi@amarulasolutions.com>
References: <20261121123451.2471185-1-dario.binacchi@amarulasolutions.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Michael Trimarchi <michael@amarulasolutions.com>

Add new interface check_timing to video bridge uclass. For bridge device
who may update timing needs to implement the callback. So host device can
sync the timing with the bridge.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 drivers/video/bridge/video-bridge-uclass.c | 10 ++++++++++
 include/video_bridge.h                     | 20 ++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/video/bridge/video-bridge-uclass.c b/drivers/video/bridge/video-bridge-uclass.c
index 1b8aa12b9e88..599090141e4d 100644
--- a/drivers/video/bridge/video-bridge-uclass.c
+++ b/drivers/video/bridge/video-bridge-uclass.c
@@ -59,6 +59,16 @@ int video_bridge_check_attached(struct udevice *dev)
 	return ops->check_attached(dev);
 }
 
+int video_bridge_check_timing(struct udevice *dev, struct display_timing *timing)
+{
+	struct video_bridge_ops *ops = video_bridge_get_ops(dev);
+
+	if (ops->check_timing)
+		return ops->check_timing(dev, timing);
+
+	return 0;
+}
+
 int video_bridge_read_edid(struct udevice *dev, u8 *buf, int buf_size)
 {
 	struct video_bridge_ops *ops = video_bridge_get_ops(dev);
diff --git a/include/video_bridge.h b/include/video_bridge.h
index 00e9804565c2..132de740706c 100644
--- a/include/video_bridge.h
+++ b/include/video_bridge.h
@@ -44,6 +44,17 @@ struct video_bridge_ops {
 	 */
 	int (*check_attached)(struct udevice *dev);
 
+	/**
+	 * check_timing() - check if the timing need update after the bridge device attached
+	 *
+	 * This method is optional - if not provided then return 0
+	 *
+	 * @dev:	Device to check
+	 * @active:	The timing to be checked and updated
+	 * Return: 0 if OK, -ve on error
+	 */
+	int (*check_timing)(struct udevice *dev, struct display_timing *timing);
+
 	/**
 	 * set_backlight() - Set the backlight brightness
 	 *
@@ -112,6 +123,15 @@ int video_bridge_set_active(struct udevice *dev, bool active);
  */
 int video_bridge_check_attached(struct udevice *dev);
 
+/**
+ * check_timing() - check if the timing need update after the bridge device attached
+ *
+ * @dev:	Device to check
+ * @active:	The timing to be checked and updated
+ * Return: 0 if OK, -ve on error
+ */
+int video_bridge_check_timing(struct udevice *dev, struct display_timing *timing);
+
 /**
  * video_bridge_get_display_timing() - Get display timings from bridge.
  *
-- 
2.43.0

