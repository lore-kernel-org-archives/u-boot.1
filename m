Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC592D69113
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 14:44:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C18089D08;
	Thu, 28 Nov 2024 15:44:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SiPFEztt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE4FD89D34; Thu, 28 Nov 2024 15:44:32 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E49089D27
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 15:44:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2ea78d164b3so740418a91.2
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 06:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732805069; x=1733409869; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dFNkCHLm7UuV/cXD3F21045xWP1O7oSi+29pQacXOlo=;
 b=SiPFEzttHlaKfn4yIiJtM8TC87WtBKLaXmsCdTVgrmof87kRfjXYce0NvppX4Vikhf
 kDHYLyU8FX8UuPUnw79xI4VRYjAT1UOxtKohs+okjyEUnY4poisOpFwvXrOl8AVAkCH9
 nSwX2Kqs6WEnP6ZxAo/2d58ok93zRA1NiBhxW7kXYKTqN93RGgw8gVhOKknAEDGt9Ea5
 eeCyOkMyU91lml9RxyEIQaVQloGNg07S4HuJHtgRg/xlauUiIPupgTtoC6DKAU69DR5v
 UANxQ45jQx2Gi4atVjlG/jUsVkxKzOL9gzgeXz0BiJxwJLa3o25IimWw/RaLkLn3usmM
 0Rvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732805069; x=1733409869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dFNkCHLm7UuV/cXD3F21045xWP1O7oSi+29pQacXOlo=;
 b=aP+HvX42/ThQOweBaK8F6jj1fsLcNLsexCJI9/hsvRFonCcX+i9OFS6QT331TwBZl0
 idtkZBdh0axtBQXA7pgLIXYq1fJ4aHqr8VuKmHVNXQEA6q+9sqQ0LsEHljbdVVvV4iX7
 Rq1WCcQbanKbroEUj0Splpp5C1MuFE+skmviINNJ0fIMbyUFU5WlX9+KGayAZZzxoZnM
 6DEFMrr45VaAv1hAp0+qTxq+RLQh4L0oGjFFh15dDp5m3PgGnYmuvJzGTARa/cTNPwac
 6o9qBEA86TmEGkGZXRUvIVVHkG8EBKlrW3Dd/VHcX0ZnF4MAaRAJJDafCVTXOpKqrUP8
 j6Sw==
X-Gm-Message-State: AOJu0Yw1fBxXqROt+EA8oGgOJkL7wjq9WDKrWu2GBLFnm4cp6quEXPCl
 RBz/9LkLV1VYoEBCWQV4YXk7NDO+55kIfw4YupNtmoBE5N1v+9cKtRpU+1WPpZI=
X-Gm-Gg: ASbGncvDx4zq+51MI3ZWYebNyKAfkh+ShmNLIf/zxHhNi4LQEFuhB8lfnhukfHocD+U
 GoU7fTtZYn3DDVUNqtoA/O1fs4p1EaHPu15VPoKYbb2BfA11J7c3G6Ai8ySSgN6wBEmq+jp7y/+
 QVt6Py9AyZ4foZbq/+KNLjombP4CiK9LMEfCx2NJDo+qgm9gqcT/XaQe0Nmnwp7pJxx2YGabTn8
 g8V59nlFCGfoFdrGo6jTbXa8PMkpbCedPBmjykt2o4=
X-Google-Smtp-Source: AGHT+IERQsMm7x0xAOab1tA8Y0WhN3EcE0yEeBBi/F80/MqmxlEVIToUk87CN+EfUGIEjCy3KKvhrQ==
X-Received: by 2002:a17:90b:1b47:b0:2ea:9bdc:8f96 with SMTP id
 98e67ed59e1d1-2ee097bb2aamr9561423a91.30.1732805068942; 
 Thu, 28 Nov 2024 06:44:28 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ee2aff1b77sm1532202a91.11.2024.11.28.06.44.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 06:44:28 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v6 03/14] efi_loader: device_path: add efi_dp_from_ipv4
Date: Thu, 28 Nov 2024 11:44:05 -0300
Message-ID: <20241128144416.604126-4-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241128144416.604126-1-adrianox@gmail.com>
References: <20241128144416.604126-1-adrianox@gmail.com>
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

Add efi_dp_from_ipv4 to form a device path from an ipv4 address.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
Changes in v6:
- Complete documentation of efi_dp_from_ipv4
- Return NULL in efi_dp_from_ipv4 if allocation fails

Changes in v5:
- Add function description to efi_dp_from_ipv4
- Allocate ipv4dp in the stack
- Make efi_dp_from_ipv4 static
- Remove u-boot log messages inside efi routine
- Change (void *)(uintptr_t) to char *

Changes in v4:
- Fix memcpy mistake

Changes in v3:
- Remove some unnecessary void* casts.
- Change sizeof(struct efi_device_path_ipv4) to sizeof(*ipv4dp)
  in efi_dp_from_ipv4.
 lib/efi_loader/efi_device_path.c | 47 ++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
index ee387e1dfd..6fcbc91e0b 100644
--- a/lib/efi_loader/efi_device_path.c
+++ b/lib/efi_loader/efi_device_path.c
@@ -974,6 +974,53 @@ struct efi_device_path __maybe_unused *efi_dp_from_eth(void)
 	return start;
 }
 
+/**
+ * efi_dp_from_ipv4() - set device path from IPv4 address
+ *
+ * Set the device path to an ethernet device path as provided by
+ * efi_dp_from_eth() concatenated with a device path of subtype
+ * DEVICE_PATH_SUB_TYPE_MSG_IPV4, and an END node.
+ *
+ * @ip:		IPv4 local address
+ * @mask:	network mask
+ * @srv:	IPv4 remote/server address
+ * Return:	pointer to device path, NULL on error
+ */
+static struct efi_device_path *efi_dp_from_ipv4(struct efi_ipv4_address *ip,
+					 struct efi_ipv4_address *mask,
+					 struct efi_ipv4_address *srv)
+{
+	struct efi_device_path *dp1, *dp2, *pos;
+	struct {
+		struct efi_device_path_ipv4 ipv4dp;
+		struct efi_device_path end;
+	} dp;
+
+	memset(&dp.ipv4dp, 0, sizeof(dp.ipv4dp));
+	dp.ipv4dp.dp.type = DEVICE_PATH_TYPE_MESSAGING_DEVICE;
+	dp.ipv4dp.dp.sub_type = DEVICE_PATH_SUB_TYPE_MSG_IPV4;
+	dp.ipv4dp.dp.length = sizeof(dp.ipv4dp);
+	dp.ipv4dp.protocol = 6;
+	if (ip)
+		memcpy(&dp.ipv4dp.local_ip_address, ip, sizeof(*ip));
+	if (mask)
+		memcpy(&dp.ipv4dp.subnet_mask, mask, sizeof(*mask));
+	if (srv)
+		memcpy(&dp.ipv4dp.remote_ip_address, srv, sizeof(*srv));
+	pos = &dp.end;
+	memcpy(pos, &END, sizeof(END));
+
+	dp1 = efi_dp_from_eth();
+	if (!dp1)
+		return NULL;
+
+	dp2 = efi_dp_concat(dp1, (const struct efi_device_path *)&dp, 0);
+
+	efi_free_pool(dp1);
+
+	return dp2;
+}
+
 /* Construct a device-path for memory-mapped image */
 struct efi_device_path *efi_dp_from_mem(uint32_t memory_type,
 					uint64_t start_address,
-- 
2.43.0

