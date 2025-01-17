Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5196C02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 07:29:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B1218073D;
	Fri, 17 Jan 2025 08:29:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hxzE/vMl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2578D80713; Fri, 17 Jan 2025 08:29:09 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19769806FB
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 08:29:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ab2e308a99bso381565766b.1
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 23:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737098946; x=1737703746; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=a098rn07bafUQoOrOknghtO4PsdjdEX8zvztLuTzW4k=;
 b=hxzE/vMlFKasSyI8qwBIeP2P80soDFZYj3RghW6nevLON9dRA/J+TNBG+PUvgEfdcy
 1Q2EtsXfOdEPK29EvYd5HOmQOwCuVJ/v4LblUrgGQTq5lXo0doRlveMpDAUpNFJ7Smra
 zO9FJjKRAXYx4K3eLHLXnd+FRzOnZKeayA99j9YqlwJ5rJmS4P8vrYj6DR9aNBCn411p
 OupFTrleE6Kr5mNjm10QFtbeTzVsqV2RhfDOVtF/pT+Tvsrz2dnGdtw7T0W6JBQ0X+X5
 C/Gc8DOfuLHDyGdTyenKDQVmTsQk5jqgjFNi7LKYI4gHzf2SFLdUOKNX+V4PhyyjJC7F
 D9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737098946; x=1737703746;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a098rn07bafUQoOrOknghtO4PsdjdEX8zvztLuTzW4k=;
 b=OoYXTzQwpSzEIMNGn/32Wyl2Ewi/Zt+2H3ioBLFr+IeNKYUzsW1m/52J88Q4SGd+QE
 Fz8s0nxv7tR+SitfkrN45z1JfYuBBUadYHyKKn2KvDg7Ezc8iVs2zQLxfgSfa4q50xpP
 5Gd92Yx4YdTCeND2RYAEeVnmF9F0+hSeJezrg5se/rfTgrk1g+W+snh9ZlSn8v0FakVc
 /0wllZ9r4+FNT/rRd+2sxswmUmYZWH02ekDCzoqd0qDgTwxatjWw5aHl+rflsN4vE1fo
 IDRhUBdznjJYd3iWSuxqKvlZ7Xliocmxg9Eqxcqui5opIUcI0Eaa4TfkX7JGGrP1NBKI
 32Sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMzi7GUt/O35UnqoIVXBevpKBewc6cVhj2BvY9g2kz0cf9eJwEInFvJJoSiKJ/NpL5JQWxS58=@lists.denx.de
X-Gm-Message-State: AOJu0Yx7bIVzp7S0w1cOY8q9RINs1CPgJW0Bo/6JJkAqSp0Ej/660K5l
 NGYG9J2DUGwF1lMhh8x4RQHRWKeGa4PcF6Q7wS01NhXUhjWDpVegy8v66t4lHSjMCCeMI1lEDWr
 x
X-Gm-Gg: ASbGnctOKAbdJwL/u0CyVLOQweEcOer8+Ut69Vnjc7AG7vqUJffAjl6FmEriZxCU37O
 2W+qtFkovJXqFcYt0JXZ2ossJiBujKp/+gNt0o/vM/WBJFzZgv7ru3C5dVMbLOghgNjYRhEXOGv
 4nKXu4Cb5vywzKfjAG5ve21eC22VYG66U0yDFigQ6sv0LJGoJ7SNm5HJZNb6Ux6LXrc1Ejs50/H
 l84g/QUiZkItXHpxgU6L58v1hYiP+Ku2RtMoGQAnMa4IiwBYAtPa47zYQgUau2bMdh83x2Gl3w=
X-Google-Smtp-Source: AGHT+IGcc3pC3QZLIQGUYdXy3hZPESA6RsPsNbpWbJdeVzfXFIGwQHebo4gEVoV9QIqlPusnODtmBQ==
X-Received: by 2002:a17:907:c22:b0:aab:f971:1f73 with SMTP id
 a640c23a62f3a-ab36e406aa8mr626069666b.22.1737098946459; 
 Thu, 16 Jan 2025 23:29:06 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384ce2105sm125404866b.67.2025.01.16.23.29.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 23:29:05 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 17 Jan 2025 08:28:56 +0100
Subject: [PATCH 1/2] dm: clarify DM_FLAG_PROBE_AFTER_BIND behaviour
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250117-clarify-probe-after-bind-v1-1-273f046ce5dd@linaro.org>
References: <20250117-clarify-probe-after-bind-v1-0-273f046ce5dd@linaro.org>
In-Reply-To: <20250117-clarify-probe-after-bind-v1-0-273f046ce5dd@linaro.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Michal Simek <michal.simek@amd.com>, Stefan Roese <sr@denx.de>
Cc: Marek Vasut <marex@denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2522;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=fPoeRBee+3X5MiOwmL0n69Ri/ZQat0sWzHYgb6U7/74=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhvQutv2ZM5RPHNko9lA60j0pnMW4JubF26Prlr2zmMvSU
 Fmy2ONXRykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZhIzkGGf9p7XPbueXGze23D
 2TUf/i3bOzWl86BfxIrtfTuaq5+45nAy/C/RizXd4iXGPmnrq7L2Vdd3PlwUmnviCFPpkhuBoUX
 vlcoB
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

The DM_FLAG_PROBE_AFTER_BIND flag only makes sense on a per-device
basis, however recently added documentation as well as some confused
drivers imply that it might be added to a driver definition, this does
nothing.

Clarify the new documentation and expand on the comment by the
definition to point people in the right direction.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
Anecdotally, I've spent several hours being confused about this flag,
this information would have helped me greatly.
---
 doc/develop/driver-model/design.rst | 6 ++++--
 include/dm/device.h                 | 5 ++++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/doc/develop/driver-model/design.rst b/doc/develop/driver-model/design.rst
index 92f638a02047..30093737200c 100644
--- a/doc/develop/driver-model/design.rst
+++ b/doc/develop/driver-model/design.rst
@@ -842,10 +842,12 @@ steps (see device_probe()):
       cause the uclass to do some housekeeping to record the device as
       activated and 'known' by the uclass.
 
 For some platforms, certain devices must be probed to get the platform into
-a working state. To help with this, drivers marked with DM_FLAG_PROBE_AFTER_BIND
-will be probed immediately after all devices are bound. For now, this happens in
+a working state. To help with this, devices marked with DM_FLAG_PROBE_AFTER_BIND
+will be probed immediately after all devices are bound. This flag must be set
+on the device in its ``bind()`` function with
+``dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND)``. For now, this happens in
 SPL, before relocation and after relocation. See the call to ``dm_autoprobe()``
 for where this is done.
 
 The auto-probe feature is tricky because it bypasses the normal ordering of
diff --git a/include/dm/device.h b/include/dm/device.h
index add67f9ec06f..678cd83c2716 100644
--- a/include/dm/device.h
+++ b/include/dm/device.h
@@ -80,9 +80,12 @@ struct driver_info;
  * e.g. for clock, which need to be active during the device-removal phase.
  */
 #define DM_FLAG_VITAL			(1 << 14)
 
-/* Device must be probed after it was bound */
+/* Device must be probed after it was bound. This flag is per-device and does
+ * nothing if set on a U_BOOT_DRIVER() definition. Apply it with
+ * dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND) in the devices bind function.
+ */
 #define DM_FLAG_PROBE_AFTER_BIND	(1 << 15)
 
 /*
  * One or multiple of these flags are passed to device_remove() so that

-- 
2.48.0

