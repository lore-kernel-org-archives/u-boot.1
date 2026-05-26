Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A42E7CD5BC8
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 20:22:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBC2F84855;
	Tue, 26 May 2026 22:22:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Kc0/DJEm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1591848DF; Tue, 26 May 2026 22:22:26 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5EAF846DF
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 22:22:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7dcd689829eso9055891a34.3
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 13:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779826943; x=1780431743; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=38sJmddhVLSAneb6Yh8DOm2otF94uR3J9V7Wtvy90DU=;
 b=Kc0/DJEmHD+qMjQXKZInCA/wqn0w2nH5xM/AHZpnD0gf0KFUoLnIL7Ut+AUT1RKEK5
 mMUhJIftsCH2vuT7iAOG5ielmQ22xnP3FgJrAP5KrhuJXFKAXZt7CC4+7ma5OBSUYzHg
 rRnFcBJPygsS+x7XrDVDrY/41PfqITEuerOI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779826943; x=1780431743;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=38sJmddhVLSAneb6Yh8DOm2otF94uR3J9V7Wtvy90DU=;
 b=WieRMuepm4BSzOkut+RcvkFIrZLMrnoSNw/Uz9WtqN8eiJryruO0YNAtaND+l6CAeB
 7IbR4JvgQdeo7FzkiJmlG3AKa5naxbbWxouwt32/xLV1i3GO6bBTbWkESDtOHrK8oRE6
 RnraC9/vKRv3Whv2ICfaU8+6VjQF46KowwocnAUhLhb7aVv5N99zxgyETlVttd8E359A
 9REGO9Wnf2+CcHjBLhSWiHUlXaHhfuTj5w+gGKISUnfnaE/PC/n8RDaqaA9sCtBp9ZAA
 JFcd48VvqL+JwVyjtSm2YSlaN0k5zqANakCMtfk8FBq+fCXQ0ne5u4cYaHtXNjEnZVpL
 pgGg==
X-Gm-Message-State: AOJu0YzzEH5vHLU7kS6J51vjJcnA9sl/S+ZHAW9bFepiBFtWR0ic/y6Y
 +x8vrBvOz5jrNt+BhJw2ywDy9N/22UlnaRGpugEXVVM7xfmN/LLNgC0Bjrwvkfpp+53w2mSewzW
 1rRNdqTA=
X-Gm-Gg: Acq92OFXC7NeI6XWvwX63q10k2OO+oyua92zy4ZvzGAGiDiu20NH+wSv0W2tmp0AcmM
 FBZ4be2Hjk+BrMJDu1KamOGf1K47VWoSmX5eCHPf2oIYuEUi7jkUPYqXrtqfrOnNYOyNn5XMHbu
 6ClOgWGIe3o2rkaiKX4zr/Ni2IIrDFIuknsJJZIixxf1kifogu798NyFU93JeCaIsXxIt/VaoiI
 zNlv4Wh1t6O0OeMSk53o/m83bA/ERzTg648w9G+Y++z3rB7IjqmEJH5th4E0IKRgo+304XFXnlw
 tD/4ES1g4c69iB25GPqX/c6lpLNIOoshOdiW1/ehanUD49sUSPRrQ3/PUjX4b1tNdGw8VaEF5aT
 m3ILclmTrEKMysGFOPjBI+LWVUGJcMb/SagyYoqgl7yKUTQ2fg8WGM9n64bUjM1nwS9jlb1FumQ
 M8aiCaQ1VFAaDUbRWkLNSVganlrKYgpnMddiDaBL8tM19qyCn+E69ok5kNCEQSgP6ynw9BV+D5G
 Ycg13X1uMD59VYVrqqVnh/X9jn9+VVwoanjU6OdmOAUSoxN++vOhp0DkuATjEYmLK4OCQ==
X-Received: by 2002:a05:6830:4414:b0:7e5:68d0:462d with SMTP id
 46e09a7af769-7e5fefcc53fmr12786700a34.19.1779826943519; 
 Tue, 26 May 2026 13:22:23 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e60663a2cbsm10593685a34.19.2026.05.26.13.22.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 13:22:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Anton Ivanov <anton@binarly.io>
Subject: [PATCH 0/2] dtc: Resync fdt_check_full function
Date: Tue, 26 May 2026 14:19:26 -0600
Message-ID: <20260526202218.4004070-1-trini@konsulko.com>
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

As part of the resync to dtc version v1.7.2-35-g52f07dcca47c from the
Linux Kernel, we missed updating the fdt_check_full function because it
exists in its own file in upstream dtc and the kernel doesn't import it,
as reported by Anton Ivanov. This short series brings in the upstream
fdt_check.c file and then implements our size-saving option, but in the
modern way.

The size-saving portion will be upstreamed and I'll update this series
if needed based on upstream feedback.

-- 
Tom

