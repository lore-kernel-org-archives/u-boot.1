Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4033F513ED
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 02:37:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6884983F8F;
	Fri,  6 Mar 2026 03:37:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cDeshat0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B2DD83F9D; Fri,  6 Mar 2026 03:37:07 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86101839A8
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 03:37:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-899fc9853b7so68970276d6.2
 for <u-boot@lists.denx.de>; Thu, 05 Mar 2026 18:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772764624; x=1773369424; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mMecNIGwwIFkrvghiGTISWnaq3Ku25+rXm7IRA18quM=;
 b=cDeshat08qYYWmk8bbMPg1FilFmN0PiEk+BBME7fWOyaAAuDryBNzsByqFn3rOBgVT
 Nr7pOKO3olrQo4i7zMZUFC31bHocgVBBablCLbm5ZmDc4s9LTPHPpYRDVSayhY3hlKog
 BJftLoxa2UQ/emFzhoBl5ATrOOCkpqwx7lS5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772764624; x=1773369424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mMecNIGwwIFkrvghiGTISWnaq3Ku25+rXm7IRA18quM=;
 b=A6HwmTnkzwdLS7CfxHG+uWei8h/A7+YeHkq0tLYfNsa9Kk3ttVOxlsiN//jhUD5tYv
 NES9SUDt4l6XnwyTlp44TufvITGmYxjrp1QYnyx6lRe979x7jw5X/kKhM4JjyyetvUgG
 6leUgE+Hutzowl9mp8zzb/1Pz1ciAHgvzFruPROybJIReBNzx1wGJMe4jCCNWH2ltjj0
 8PGisQaxjYwCLnPTFfXLK0dc1l0RToHKwFcc+BH/N/0A/hIekN8mQgKk3OZNTqN2vK+p
 MgJNorGz4o5owbmRJ+70w3SEBkiOvdVXymCUicq9lhrPYnBJNwTbeBotFf8O/ECJ/yHr
 8LSg==
X-Gm-Message-State: AOJu0YyyzQeJSj39Y8p+eJbg4yOEnyqHaFDKtS8RRwKATKEVmh/9iYhl
 +WAyCuc3hYw2ZQFqsxYenClDpJB9wFsGcXtO4fOAauLzUcPXv2t7Z/kdW6IQoiPyc66NaaaMvBG
 1tBw=
X-Gm-Gg: ATEYQzwS7zxapx7V3yYid5iBuhNKoqxNJKJxYk7dI6xEtmI2udnSB4PM6ammEo/bSYQ
 PQCAJr8KkK+w2AH3d7JAKlsdH1bZdhqRV672D8CaleHGCPGcoJ9TCV9X05N/QheE+TUFSb2t7dS
 9xfB7tisK9EBAdOPUGtAWyap3WD1gi8YXup8Cru4F+bbPkGB+93semmTlt1pgYhWUr1nyN8f4TC
 v/UjBnTwAvK48DHvJ3xXkKXVrCb/4ep/LCCoLm8TEskGMX+X8eqdfONWjZ2YepJ92EJOOirQ+fm
 JTX0oSMZilbeVK+15LHkCodF+V5fT9v6d+XkoKXZ5CzQrZ1Z0ZwDoMJ6j/sU25PcapGT9oCB6sl
 gj7f7J0DpeKOZlgug7QE3PGWEqJjtG1vvi/pahINCpnr1L1leBjzvFx8rvu8sfdUHAn1Z0dcLfx
 eD3ZeRXT8iturkJxyUIw==
X-Received: by 2002:a05:6214:1d06:b0:899:fad1:64e7 with SMTP id
 6a1803df08f44-89a30af1ca2mr6204776d6.47.1772764623830; 
 Thu, 05 Mar 2026 18:37:03 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a316e8eb2sm1063436d6.35.2026.03.05.18.37.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 18:37:03 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Marek Vasut <marex@denx.de>, Pavel Herrmann <morpheus.ibis@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 02/17] dm: Remove children when parent is removed by flags
Date: Thu,  5 Mar 2026 19:36:11 -0700
Message-ID: <20260306023638.2678886-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306023638.2678886-1-sjg@chromium.org>
References: <20260306023638.2678886-1-sjg@chromium.org>
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

From: Simon Glass <simon.glass@canonical.com>

When dm_remove_devices_active() removes devices using specialised flags
like DM_REMOVE_ACTIVE_ALL, a parent device may match (e.g. MMC has
DM_FLAG_OS_PREPARE) while its children do not. This deactivates the
parent but leaves children activated, an inconsistent state.

Later, when uclass_destroy() calls device_remove() with DM_REMOVE_NORMAL
on the already-deactivated parent, it returns early without touching the
children. The subsequent device_unbind() then fails because the children
are still activated.

Fix this by dropping only the DM_REMOVE_ACTIVE_ALL requirement for child
removal when the parent is being removed. This ensures children are
removed along with their parent, while still preserving other flags like
DM_REMOVE_NON_VITAL so that vital devices remain protected.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

(no changes since v1)

 drivers/core/device-remove.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/core/device-remove.c b/drivers/core/device-remove.c
index 03ef49c4db0..557afb8d817 100644
--- a/drivers/core/device-remove.c
+++ b/drivers/core/device-remove.c
@@ -219,10 +219,19 @@ int device_remove(struct udevice *dev, uint flags)
 	cret = flags_remove(flags, drv->flags);
 
 	/*
+	 * Remove all children. If this device is being removed due to
+	 * active-DMA or OS-prepare flags, drop the active-flag requirement
+	 * for children so they are removed even without matching active
+	 * flags, since a deactivated device must not have activated
+	 * children. Preserve other flags (e.g. DM_REMOVE_NON_VITAL) so
+	 * that vital children are still protected.
+	 *
 	 * If the child returns EKEYREJECTED, continue. It just means that it
 	 * didn't match the flags.
 	 */
-	ret = device_chld_remove(dev, NULL, flags);
+	ret = device_chld_remove(dev, NULL,
+				 cret ? flags :
+				 (flags & ~DM_REMOVE_ACTIVE_ALL));
 	if (ret && ret != -EKEYREJECTED)
 		return ret;
 
-- 
2.43.0

