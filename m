Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F200103E18F
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 14:45:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2544D840A2;
	Wed, 18 Mar 2026 15:44:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="pZ7KAjVa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93CE884142; Wed, 18 Mar 2026 13:47:05 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C11A58422D
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 13:47:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-662b5bf4b10so12577565a12.1
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 05:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1773838022; x=1774442822; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VTOipSMZSpH4gEOZfyaDIAy+tVJqhReYHLZvyNlz2vM=;
 b=pZ7KAjVanflSdrtrqlj3b+1pPSxyVxVNY2ULvnBLm31nYd7AD+W2olhcFOjYc91wD8
 RDKm+G8cKJ6a5PXHQTLuK1XVA5245p2Gf/qTlIFqaYYCNHSbaXBe0dmXFozaiZjeTwEZ
 FCuPN5ifpL8z5fBFb57kMqoD9MV+ZRX5lhfhst1HuUuJnYMnN5kq75KOvREwhn35ObUo
 F/x4snJCJycqspM/g52r/8Lo66UZgMwXI4myShP3VzVua0AauUpkbdqAPNX/z678cB/0
 dzkL/96id+fwdVChLabUGhZlAh9d6OGzJ7tibMRd5S0MJSIJm6k7d5azeZUR/d7XYfAg
 kVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773838022; x=1774442822;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VTOipSMZSpH4gEOZfyaDIAy+tVJqhReYHLZvyNlz2vM=;
 b=G9EFjXGdh2yVByrqDSZ0xV9BPUUzA3F2fcXfPNCDYtS9/LjWa4J2ZWEgyzeBwMvkHM
 uWOLQPCB+KaJn4v5BmZzH3UspTNO3Z4gTrCIOFCqHzYnmMh/MGpAisKx/qQFe8lGaojX
 qn7Y6I1BaK4IEhwA4tO/VdXfkoFPNn3rHxw0GtDm7aPt0BVJlLSw+F/K6whfHigi93qT
 ygP4sXIFSC8FUm8PL3murU9R+dkpd377q25XGZuUVAGBqmNzyUikH3UJ6/a5TPOujukF
 dOsfuY0cz6O9+bbl1JFBNcnO/PhPvlVe+YbJ+bZLRzG/rxIhf2LqxJzVHFLU9Jc0Xcn8
 lwRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqKLKkNtSAIONnURDOLqCcsdg/6gZAbZQDss8MiuoOEFTHCI/JKAz45/9KDEHsuWRSKnXkqF0=@lists.denx.de
X-Gm-Message-State: AOJu0YzThNleNnDwmsOT4WYiFHxPJ+akP5VHK31VXryBrbcvyNUjvQch
 yWXTagUsNpmyuQnfqxhIWEKmQkBXGUSfMwaEdfzGs9KQ9ebU3a62W3JrC7e1JYt1mCc=
X-Gm-Gg: ATEYQzyy2s7vTTPJVRJpZsOD+dt8l76EH2bsleN0H07AFsC71RU9wkGJ5O1N7ECgZrb
 oCJL+rRLY66oN72O7pDN/1Xtgjv1sWjRknMJ2UEDUWs8yaZgCKy8cIRNSB9XLFAUDJzSfUiUtGQ
 nRdu9gs48ZQgYB68dazjd/UZTnKfJ6D1haNH+Urb58lzWuuRgI1mqiHqs4xYVkbMTvrmH2YFBdR
 R4Bvy2XJpgpq2KN/W4ZhrvfvrfuWFGcTwpFIjFuFjGEQ70rw+DfYznSePqglNSU3N6xgyUGKmIk
 /GLhAmRHJJiDH2jX4H+TwFLCJV7ZU+j55XMRNWJ/vh9YKfA4t6xMWaKUI+QnCvgAVZKmHyn7r1S
 f1PcPqSDXKb+4yMJjrZ53W3ZNHptvy9EykFhwzLyJgFB5kew0dS4UMgIzaEgO17Bxy4H8KmD2/r
 w04FRQVCkV7YATbjHggZ3JRRDoH9HIu7rEBlYQUQi7zo2QVpDUops9UKs9R6GEiRYyz2MJQzcL6
 v2qmQ==
X-Received: by 2002:a17:906:2509:b0:b97:a128:926a with SMTP id
 a640c23a62f3a-b97f4abc711mr165091866b.44.1773838021558; 
 Wed, 18 Mar 2026 05:47:01 -0700 (PDT)
Received: from [172.16.220.101] (144-178-202-139.static.ef-service.nl.
 [144.178.202.139]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b97f142cf16sm206080366b.20.2026.03.18.05.47.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 05:47:01 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 18 Mar 2026 13:46:32 +0100
Subject: [PATCH v2 6/7] qcom_defconfig: Enable Milos clock driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-milos-bringup-v2-6-650b91dd75d8@fairphone.com>
References: <20260318-milos-bringup-v2-0-650b91dd75d8@fairphone.com>
In-Reply-To: <20260318-milos-bringup-v2-0-650b91dd75d8@fairphone.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Danila Tikhonov <danila@jiaxyga.com>, 
 David Wronek <david.wronek@mainlining.org>, 
 Alexey Minnekhanov <alexeymin@postmarketos.org>, 
 Lukasz Majewski <lukma@denx.de>, Aelin Reidel <aelin@mainlining.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Rui Miguel Silva <rui.silva@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Sam Day <me@samcday.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773838014; l=645;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=TinT6abh0KyzVbsDmU8R8o4LKUDxNj7xjfPw4DGXzEU=;
 b=ywIXM0d7RvXJInYZpi9CjfkOECMaSiLhGYiH/Hdq1td9f21JwaT58U6l0zIMXUo9BbtP1M8B1
 7DpzSFRTDdnBtBgFv0oXdsrc06IBOEG1ErrhNc+63iZga6BTQoLZisc
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 18 Mar 2026 15:44:14 +0100
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

Enable the driver so that Milos devices can boot with qcom_defconfig.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index fe5880de1fd..44c1cef725c 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -56,6 +56,7 @@ CONFIG_CLK=y
 CONFIG_CLK_STUB=y
 CONFIG_CLK_QCOM_APQ8016=y
 CONFIG_CLK_QCOM_APQ8096=y
+CONFIG_CLK_QCOM_MILOS=y
 CONFIG_CLK_QCOM_QCM2290=y
 CONFIG_CLK_QCOM_QCS404=y
 CONFIG_CLK_QCOM_QCS615=y

-- 
2.53.0

