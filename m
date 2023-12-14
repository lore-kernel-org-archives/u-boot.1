Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA142C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 13:51:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5163687A81;
	Thu, 14 Dec 2023 14:51:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="chUuGY2J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CE0287A42; Thu, 14 Dec 2023 14:51:49 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A421987A70
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 14:51:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d34a6b3566so12138105ad.2
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 05:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702561904; x=1703166704; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+0j2/31GU6QT/wHSqzTKTNE2vio2VHGOKx6OYIgJzZs=;
 b=chUuGY2JNjvoFCybZlJSNzTNlTjLeiwJutBLXTUZishgWa6sJ/Nf0VK0wOORmMOavc
 5drzNWwv6I2d89zEq7mRLKOaiUFjQRIVIAyQlQlUw7N81GmVwuwG+dYqBlW50Tj1RCkc
 M/k5HeB/MouyhIAgetaae7+Na3WzcBYIKNV2HfwzKyGJe+9Vm3TtBq2TD/Lia97Yvqgq
 XhAwipSRo3qVBJHfz15MPVhiliJcfNFSl4NQgkhJYF+DWgDxpEKtPWXd3q2+r7Hlyk7S
 TVQ3Ox7ZPOWDcQTMTPAMJ3NJ957q+Za+UCjyjghT8sFQEREzodz94HY3aNdMDGj+/BiE
 VTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702561904; x=1703166704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+0j2/31GU6QT/wHSqzTKTNE2vio2VHGOKx6OYIgJzZs=;
 b=p4tIQb1BVU/AxVsIu7KkScfijeMwx41kGzaOKMfcLIkK3YK0oPlBNZTqREXd8HeJOl
 1ZtsGi8T0OCqgOFIX6j6KhFTocTLnWIAultYfYyfb5ZGNP2zk8/vvik9ylPD6bZEpKf4
 QXuW8d7oUYWG5z9UXrZnOxHaoGJxpmeEC88PDFU+gq4s8cJ/D9CTH2XsCLBgZF7xPJ28
 U4B7LIRBDHZRT5wSBaORqeneoSMhROTxDfXpUyiNKYgtn5VVToVotX7rero4ixWUcA7k
 GIpFxkuwejqtWdN3w347He/vLwjZfQSKV9N85/Ag6raTnVZfJUMkvLenFuoGEbmT/t+y
 wdrg==
X-Gm-Message-State: AOJu0YwLk+IOms/+hESLPvmkqCw68Dw6SYpXWE/04yMKq7MfzhOTggPw
 3IzNxsQxGxMgtQ9wDN3J0Ky9UY8GrqjBY+VR8FbqEQ==
X-Google-Smtp-Source: AGHT+IH+aLeip+56aFJkGFk4eYCPQZohoZLDWKFRkh2eE7di2zRbpByB8bUpx7N+DqSSoGdYAGhJ5g==
X-Received: by 2002:a17:902:8301:b0:1d0:9e5a:e886 with SMTP id
 bd1-20020a170902830100b001d09e5ae886mr4491848plb.127.1702561903680; 
 Thu, 14 Dec 2023 05:51:43 -0800 (PST)
Received: from sumit-X1.. ([223.178.213.6]) by smtp.gmail.com with ESMTPSA id
 j3-20020a170902c08300b001cfc68125desm12474956pld.203.2023.12.14.05.51.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 05:51:43 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 u-boot-custodians@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech,
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org,
 b.galvani@gmail.com, xypron.glpk@gmx.de, michal.simek@amd.com,
 seanga2@gmail.com, rasmus.villemoes@prevas.dk, peng.fan@nxp.com,
 jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH 1/8] Azure CI: Exclude devicetree-rebasing subtree for CONFIG
 checks
Date: Thu, 14 Dec 2023 19:20:56 +0530
Message-Id: <20231214135103.1606605-2-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214135103.1606605-1-sumit.garg@linaro.org>
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
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

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 .azure-pipelines.yml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index d6f3fa423c6..f100c4493e6 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -65,7 +65,8 @@ stages:
       # have no matches.
       - script: git grep -E '^#[[:blank:]]*(define|undef)[[:blank:]]*CONFIG_'
                   :^doc/ :^arch/arm/dts/ :^scripts/kconfig/lkc.h
-                  :^include/linux/kconfig.h :^tools/ && exit 1 || exit 0
+                  :^include/linux/kconfig.h :^tools/ :^devicetree-rebasing/ &&
+                  exit 1 || exit 0
 
   - job: docs
     displayName: 'Build documentation'
-- 
2.34.1

