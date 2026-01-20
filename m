Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A3C4D262A7
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 22:34:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA67383AAE;
	Tue, 20 Jan 2026 23:34:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ET7gs35V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB88683AAE; Tue, 20 Jan 2026 23:34:12 +0100 (CET)
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C0F683A2B
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 23:34:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x342.google.com with SMTP id
 46e09a7af769-7cfcebf1725so3758810a34.1
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 14:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768948449; x=1769553249; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=zpWLIy5wi/8q+h4L93UgInh0T3BEg5iVSLyI9Gf3k2o=;
 b=ET7gs35VnMLYrm7Bn1HTWbsW7TsTDR1jojS3Cna/kg6D2rGLvqWz4/C+qXWdd0AxY3
 m/b8xasN//eDzwP9rI2iY3kalXL2a9iH8HFzPjeyh8fsRTpxiHP4K1X4OsRsCSIeYgyQ
 U65pgnfNUB5jrBXiR6MFz6bb1msjnrU9na4T0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768948449; x=1769553249;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zpWLIy5wi/8q+h4L93UgInh0T3BEg5iVSLyI9Gf3k2o=;
 b=oZdfoyzfFaSTb1NwB/HMUpA7yBPTHsbLZny6mGclzmCBbgkx4w4Kzn5lwQomJBY+If
 /QAbpXWicfIUT5eyjzzTV7BVY4SqI97Vl0Ml0WPpeJiWbSFob2GPfzWtwHauyVjygfQ6
 rhzUPCNBuCBdfznhjCwBNKjXKhwh6LBvdZT+YaV7aHPbZ0ZAUCdYxviIyVWTQglSg7Vh
 M+lsksVDP17mpdVwrbIIx9aHfJaE06x2QVT4M0AvK5E0wYOftALceS/bcgKwhglbxMzi
 /zySAsNjLZRhVqvrcBeuUY7IXkouHVNKzo+qK54cGQ8orvVjuiDtdTI32xB6UmUelrp9
 jUHw==
X-Gm-Message-State: AOJu0Ywe5JU9D2qPjXWSjS5DurOE75WzOPQsE1XDVRW+pHiTY527xgFl
 mcBOmTJRlHJYLACraOChOz7tLMAd45AO/jbgwI6V+a2SwU70xuomRDydSv1phLKud4fbZ2oR46A
 TQSXvcsDTxA==
X-Gm-Gg: AY/fxX7v2ud5GfyXyi2fOTZiyjQZzM/xIrGLp0C7Z76/I0y6jvQivh6gh4sgVWs29/a
 ePKfBHE6QAfV0EiWlCOyQB/RAso+bRqxNdWWIioK5EWICSvAxqdFBEMj4VIaP6EBrRkd97uoRZF
 6Gb81W4VpiT8k5sNvYGeKec/jEbJsKDWF84tjKz+zLp00vAh4SEckzAhcJ3vOIyligYLbE3ww1q
 zlV0MXGORRp8R01v4zF2MoXkQZ05HVvDZ/pMk7ml7ysYJnuvPn3BgPOnEXUJJEtR7VXVoKNXD9N
 Bza8Tu5W5Bjh/Ta9gKIW8R9wGMtrWSUn1k6VNixDLRcx5PTeXJ7Ly97r7gxfHwq7/gUwU1ZD8g3
 oL+Iza0VTyj2MopzyI3GgKgng7H89v/uXW3o474wTUAh2//7KO+2o6w9v2yBgvWt2c8brrzb3MW
 oFtf6CAjKtCO3T45AWFAzhxzmlOy6n8Og+LgXOUCx6wRd2+KaY4yiflRQkw2PGf0W+0pA0tmD3s
 oFJkR5PXuxAzlS4yzVDpArSNxy3C1xpf6aUMfKvZA==
X-Received: by 2002:a9d:7993:0:b0:7c7:6479:38ce with SMTP id
 46e09a7af769-7d140aae713mr1373465a34.18.1768948448917; 
 Tue, 20 Jan 2026 14:34:08 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cfdf2b59e2sm9705687a34.30.2026.01.20.14.34.08
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 14:34:08 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 0/5] doc: develop: Document b4 for custodians
Date: Tue, 20 Jan 2026 16:31:41 -0600
Message-ID: <20260120223405.469050-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

Hey all,

Note that to apply this series, it depends on
https://lore.kernel.org/u-boot/20260120201327.451872-1-trini@konsulko.com
for context.

In order to more easily document using b4 in the custodian workflow, a
few minor changes needed to be made to the rest of the document in order
to make it easier to add another section and have the content flow well
while reading.

-- 
Tom

