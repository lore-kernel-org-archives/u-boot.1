Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03191C02185
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 16:41:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75B0680761;
	Fri, 17 Jan 2025 17:41:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="w/+Bsbzl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22A26807B3; Fri, 17 Jan 2025 17:41:13 +0100 (CET)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02CF38076E
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 17:41:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6d8e773ad77so19652476d6.2
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 08:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737132069; x=1737736869; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/RMqhEn8bWWXmUCXOPw5yZm10kGPLvMhSh0jpuXE6KE=;
 b=w/+BsbzlV8bQZPuqjL6p2tG3SNfmRpVwEopCrpkKcPEWxsfpyIrLC9bmGi2Ze6SzAU
 JfAYTeHXDMbsl4J2aqpt5gtcDsTS6YmfemTvNaByrFay/QMINoer5Vy/m/Vm735oU9zK
 sK8WW+QNhBXN9t2Yss5BQigcDJI4e2LetrOfqnzvwvkzz8v44a29aGQZU2cjK6Qs0io+
 bYMtp55jFpvXxqMQUVOoHUiyYefCVEjlf/VCAxInE69UtRtNa+F9N6tubdx8rCg6Jt7b
 yhQbYDQnGSnf1z/mAesKA8WX0+t6BMcgp5KBbGDIU69UunZi92mu9SJ9LYbyJz7hfvv2
 vdHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737132069; x=1737736869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/RMqhEn8bWWXmUCXOPw5yZm10kGPLvMhSh0jpuXE6KE=;
 b=wmLFAl28dIrc8Q17fWtooQQbxhCQkWPcR2/rkPi83C30p80v9zH5fKJxLqhtM0ZVia
 i0Sl6x8mV63v14iQ2W5DXqWQ2nCsRQHWOQv6HzdUX6D2Qkmro3rQyvRQDFg87h8Wym8C
 CCd3Pm1mWW1JpZiEBejQjivFxhLM5eOQlAnKUMCprigr5m309t+gl4VL0gvs3VnS+L0W
 4NAqk+JdlTcmaffbLrJ8m2iKAHNdEbkCb0yuBXN7/4AJodJxjlLEEcBRSBCO7HPrcYit
 cVHo+D//Vm+B3yFstdt7J6ICY48Jj/qCPAQRbB2XMxx0uQMFB78QtSZz2PN7b9lJPWBn
 aOyw==
X-Gm-Message-State: AOJu0YwXlPp0LxTOCWGwnwH/z6+G0ZXgSjfn0BXq1asrUVpfrKjUcLE/
 At/JmKaWUZE7PUG34pEnJpy+zSSQf9A29i/B33Dnxo4HqFkQfFBoDNas9L1j0bj1IGgShltVpnS
 Jh5g=
X-Gm-Gg: ASbGncvB72dNX5uSKZQEIov05sAL5l6wHFEYpMCzY9GIhkWtd+kbvtMeDRtxjPlVRsc
 etq4zfZ20xhpI4I9joMV3WPbS63E7C4o+3MTrYIgpXjTPWGF6/HECJPl7HsraJ+iA38q80A7mak
 grhXavMU7ean1Ngkx8vmBoStvNlBCaNEh7RlKw7wnam1mKkLxgVDYnEHCCITXai5wb2SiPiYCmJ
 5YKoGBC/+jAOMkVosNNKHKmFkKfRr9OoW4ynRMUhkaQTIiybey2QlaYJglL80+LApb++fPMsvPq
 Ue25ogXprTDbzna6EnqHdLyASmfFmloHxx5OqUrP6V9AefZixCAX0wQ=
X-Google-Smtp-Source: AGHT+IF8vpsko9h1ZXU0VBAki2XRUn3vIOGHcCJFs4DI7W1zoxr1rCpMhawasrqZD2TjGXwZ2dhP7w==
X-Received: by 2002:a05:6214:cc6:b0:6e1:6a90:43ab with SMTP id
 6a1803df08f44-6e1b2168bb3mr38009726d6.6.1737132069593; 
 Fri, 17 Jan 2025 08:41:09 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e1afbf3887sm12867746d6.9.2025.01.17.08.41.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 08:41:08 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Tim Harvey <tharvey@gateworks.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH v2 5/6] tpm: PCR allocate during PCR extend to disable the
 unsupported algorithms
Date: Fri, 17 Jan 2025 08:40:28 -0800
Message-Id: <20250117164032.88942-6-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250117164032.88942-1-raymond.mao@linaro.org>
References: <20250117164032.88942-1-raymond.mao@linaro.org>
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

During PCR extend process, if any unsupported algorithms are active,
try to use PCR allocate to inactivate them.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
changes in v2
- None.

 lib/tpm-v2.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
index 0e497b2c2a..4995ddc9af 100644
--- a/lib/tpm-v2.c
+++ b/lib/tpm-v2.c
@@ -344,7 +344,10 @@ u32 tpm2_pcr_extend(struct udevice *dev, u32 index, u32 algorithm,
 
 	if (!tpm2_check_active_banks(dev)) {
 		log_err("Cannot extend PCRs if all the TPM enabled algorithms are not supported\n");
-		return -EINVAL;
+
+		ret = tpm2_pcr_allocate(dev, 0);
+		if (ret)
+			return -EINVAL;
 	}
 	/*
 	 * Fill the command structure starting from the first buffer:
-- 
2.25.1

