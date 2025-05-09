Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8001BC3ABC3
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 07:04:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5586A82999;
	Fri,  9 May 2025 09:04:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WOWQ9bsg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47CCD82A46; Fri,  9 May 2025 09:04:10 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23AD382935
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 09:04:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-30a8cbddca4so2085203a91.3
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 00:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746774247; x=1747379047; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dgMfkdgLqHC+2fPzeFxZ+n2SHAqv1jNZcwm4TeLMFbM=;
 b=WOWQ9bsgoYTL9OufHxw6tqkg3cCdX2+WJkaHaK6rdOOi2uLXCpTt4kROH0GamEF78v
 vntaUVqz//YYGZxMdo1bdMSueUoiMauKpLa3fz4T2F3Sy0TnKKv87z2t7z5VnQRT07kU
 fNPAWElGOQiyP17/4Di8HBhoqmvCHSC4m0sTvNO+/INkzE8kvw+ORO6wS/RmO0BG1c4G
 Dgu3PA0tj+t+zGUHYALK8FB5MES7tNIS9BGp059e3/GjPqU56NjdPF4v7EKrK2N2dryw
 y8tvOJ+UweSf3fAizbFpqm9pZXpNsE19stO3SuvyJ+A6Q6KVdCyftJkXsYlaGdrRxs5+
 CQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746774247; x=1747379047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dgMfkdgLqHC+2fPzeFxZ+n2SHAqv1jNZcwm4TeLMFbM=;
 b=HpkiJ0s1bK0txtORoqamGJ1AGKOBR7QBfPL2iCEpFW6MdEXb8YE7TK0NJk/APk1IUO
 ig+A31+IHMUEtmVVXnUzzzbMzGlAAeRafOTMf2gb6ObKYReIw/7ojEaHNCL9wSQLQjRt
 yFU7EbKZFYHOr+GAkkb5nvZ6ouoTc6vGMhB/MjevqlI/4Z3wxbIqJHH/+W075aajbAmB
 kXNbD2gvjZpuVyFNUywgV/LMNo2jGZS0qtfYa3xiEZCwslG967KXXZmW70RuJzjea80y
 5X59V+5JDahktNvtb34qXBHrjamAdVEqZeEj9RGxtST06K97IlyzF3duRIkhGdb/A1sy
 DVfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZZt4FNOns5kh4OzJ2CBtI+G+IdNM9vFOfiHPgJ3InWU+NbIpL7r/SjJXuLVeWZfE/ONwd+Ow=@lists.denx.de
X-Gm-Message-State: AOJu0Ywh/gXoFCQNxPHnyijik46xAKbGjJ8VVaeDHw+BmtT0tHom5vmd
 enPzcpPMPGOiM9m+xzF8/OiSVY3K36MEfSDe367hBPGnK2Tj813J
X-Gm-Gg: ASbGncu5UzTYDODhSxJ1e8oPCcPY3ATa8ZBtAvtN932Em7/yNUzSamGi09Ic6AhdafJ
 L/V6pPtQnw6dWHFbzqBd8QwkByl5fBx3/FZLmON1fiUXqZIPOSFHIYxTQVkAsrfkRVmKeWWbecG
 eSyKu+GSFF1+cDGrxGcTIBFupx4gicqvpVYM40L+5fuxFr84ws06xyXkSM4FQFR8i/wI3MwIzcw
 A1rHTpAWoY979V/2IZixpkCNkxCjaqOkAeNIPbG7dLts1yN6iA5QmkS3OnM3bkKSZgn+RH7Jrkv
 k21xWzVQAq8En9NIEiHcGQUqVdwgKFe9bVoATBsdpl7FqGo/B5kdl2wbqCMB6Eg=
X-Google-Smtp-Source: AGHT+IET/t+zdgixEszpVTnmEhLl0J+ESwCyvCzL6R+qq1qmzFp/UFSD4gRDcfmhjkeIX6LEZBoUkQ==
X-Received: by 2002:a17:90b:4acb:b0:2fa:137f:5c61 with SMTP id
 98e67ed59e1d1-30c3cefe24amr4530276a91.12.1746774246628; 
 Fri, 09 May 2025 00:04:06 -0700 (PDT)
Received: from localhost.localdomain ([45.112.0.38])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30c39dc8aeasm1173932a91.2.2025.05.09.00.04.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 May 2025 00:04:05 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Tom Rini <trini@konsulko.com>, Beniamino Galvani <b.galvani@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de (open list),
 u-boot-amlogic@groups.io (open list:P200)
Cc: Anand Moon <linux.amoon@gmail.com>,
	Wayne Schroeder <raz@chewies.net>
Subject: [RFC v1 6/7] configs: odorid-c4: Enable Oboard HUB driver
Date: Fri,  9 May 2025 12:32:11 +0530
Message-ID: <20250509070258.5077-7-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509070258.5077-1-linux.amoon@gmail.com>
References: <20250509070258.5077-1-linux.amoon@gmail.com>
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

Enable the onboard USB HUB driver to power the
Via labs VL817 USB 3.1 hub on the Odroid C4.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 configs/odroid-c4_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/odroid-c4_defconfig b/configs/odroid-c4_defconfig
index cc3d7fc7484..3c5e53828a1 100644
--- a/configs/odroid-c4_defconfig
+++ b/configs/odroid-c4_defconfig
@@ -64,6 +64,7 @@ CONFIG_USB_DWC3=y
 # CONFIG_USB_DWC3_GADGET is not set
 CONFIG_USB_DWC3_MESON_G12A=y
 CONFIG_USB_KEYBOARD=y
+CONFIG_USB_ONBOARD_HUB=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_VENDOR_NUM=0x1b8e
 CONFIG_USB_GADGET_PRODUCT_NUM=0xfada
-- 
2.49.0

