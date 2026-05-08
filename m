Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA2BCD342F
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 09:43:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A49EA84AF6;
	Fri,  8 May 2026 11:43:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="kMdU/xBT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 538BA84B02; Fri,  8 May 2026 11:43:15 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3334D84A63
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 11:43:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=alexander.feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=tbD8bEEcv9uXBABJ7OAac0VEgDQ7gvxf2x/xcwkLxI4=; b=kMdU/xBTpIqaZ7dkfMoitHprHF
 zzQtuA5cPBAkUH7rxPH3O/zMu+8BWuussfFSN10MDQmm639i7uGZZcyg0wV3uqzCCFQjc7Ys7ZC9Z
 T+LGZw0Xzc+FTbTWIl358QKvVgsK6PkDEgDPkZ0LNdSzvmel0KVDh8Mhb/cLg45wpm30NMk/QEJ0g
 dVK+FSJHV/nXyHfwBu8nD6goTJUPv4/Jf2ImQZpBc8IWnM1uvp4MgCov2zMvK/bEfYm0bnLcZGaTh
 xpYiwE/HahFiFLK4UddwwpuBrfF0k2l+dB1OxXaiE4CIDiHyLUW0EyAKHRU26DAWUoeYjQ5xbBKI3
 D/Np09pA==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <alexander.feilke@ew.tq-group.com>)
 id 1wLHjj-000Ily-33; Fri, 08 May 2026 11:43:12 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy08.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <alexander.feilke@ew.tq-group.com>)
 id 1wLHjj-0002ZV-20; Fri, 08 May 2026 11:43:11 +0200
Message-ID: <3be78585-84d2-4e7f-b6dd-d9d0feb5dbdf@ew.tq-group.com>
Date: Fri, 8 May 2026 11:43:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] sysinfo: add sysinfo_get_and_detect() helper
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.denx.de
Cc: Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>
References: <20260508084834.45637-1-Alexander.Feilke@ew.tq-group.com>
 <20260508084834.45637-3-Alexander.Feilke@ew.tq-group.com>
Content-Language: en-US
From: "Feilke, Alexander" <alexander.feilke@ew.tq-group.com>
In-Reply-To: <20260508084834.45637-3-Alexander.Feilke@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8
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

Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
---
 include/sysinfo.h | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)
I missed a silly mistake in this patch. This should be the correct version.
Old CI pipeline run: https://dev.azure.com/u-boot/u-boot/_build/results?buildId=13173
New CI pipeline run: https://dev.azure.com/u-boot/u-boot/_build/results?buildId=13175
diff --git a/include/sysinfo.h b/include/sysinfo.h
index 54eb64a204a..976144fd4fc 100644
--- a/include/sysinfo.h
+++ b/include/sysinfo.h
@@ -373,6 +373,27 @@ int sysinfo_get_data_by_index(struct udevice *dev, int id, int index,
  */
 int sysinfo_get(struct udevice **devp);
 
+/**
+ * sysinfo_get_and_detect() - Return the sysinfo device for the sysinfo in
+ * question and runs its detect operation.
+ * @devp: Pointer to structure to receive the sysinfo device.
+ *
+ * Since there can only be at most one sysinfo instance, the API can supply a
+ * function that returns the unique device. This is especially useful for use
+ * in sysinfo files.
+ *
+ * Return: 0 if OK, -ve on error.
+ */
+static inline int sysinfo_get_and_detect(struct udevice **devp)
+{
+ int ret = sysinfo_get(devp);
+
+ if (!ret)
+   ret = sysinfo_detect(*devp);
+
+ return ret;
+}
+
 /**
  * sysinfo_get_fit_loadable - Get the name of an image to load from FIT
  * This function can be used to provide the image names based on runtime
@@ -438,6 +459,11 @@ static inline int sysinfo_get(struct udevice **devp)
  return -ENOSYS;
 }
 
+static inline int sysinfo_get_and_detect(struct udevice **devp)
+{
+ return -ENOSYS;
+}
+
 static inline int sysinfo_get_fit_loadable(struct udevice *dev, int index,
             const char *type, const char **strp)
 {
-- 
2.34.1
