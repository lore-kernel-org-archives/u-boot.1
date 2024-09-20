Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D8ECF58E7
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 08:00:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E69C893D2;
	Fri, 20 Sep 2024 10:00:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yhx7sAWg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D2E2893DA; Fri, 20 Sep 2024 10:00:35 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23A9488DA0
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 10:00:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-374c1e5fe79so1162508f8f.1
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 01:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726819232; x=1727424032; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7APgh6cVg/6D/TSuXoPJT3I5GNJwng3a2IQy0swNBYM=;
 b=yhx7sAWgxs3CHF+o6MeY8U+Cx4uhzM2g1WnLKxQYSOresfuFmMcPKwQg5QWSuHeG50
 EUUEOW6IQb6t93EBoXWjjpvKgnQckeVS6u2fXQVhMB4f5b59nmb/OWGjYiViF8sPG987
 xq6IpXtEbFcbFeSjSpJq7YD2Mj98m3uHR0COjEDLAox5E40ZOQw/55iXO4QXrLfYLWEk
 isiYrcuwObmmXGqDt7xQvbLUrMDOMPSxP5opeegmCd9ZxEZM3yM3ac1iiGQmIfSppZn0
 cUQqGacxBl++S5f8KbjpHnWKaNfElqKGgh3WPPB030KqB3FDQEPQsp0xcM9FgGXaCVkY
 qZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726819232; x=1727424032;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7APgh6cVg/6D/TSuXoPJT3I5GNJwng3a2IQy0swNBYM=;
 b=V9m8bGxVpRwW2BNs8dDGs/Rw2HmpQmvC+VRgHl3xN2V9ZNUQk12zBt3cKc6yworVb9
 Yt5MjAp8fHlCyRVXzVtHBWlELd5vC/7Yn60gtKKnov9pkXlHJnXldXb7QBTpkZUPjjtu
 PFqtOQvKUX1i7MkFMEDuqf5dS9gilS5Fu6TOCMNemnNyE7V7EwjZdlJBhBX072zs086Y
 zAdPzyQph5sD88iv3ZX/XAUFnzxTr2TUUWEY6DGSWKIGrEujQ/l13PbzRzE6qpYMjMLm
 u/vtgBclBjGIkw3nP4r5AQhhVFPdd+P790p2afUHbHA3pa3QVGz0EN4f0u+OfYBbP9QM
 Dlug==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCZkVxcdkNCyYaoOR+V6jOUhqKk7ped/hPHSvaobulOJ8cHbToDvkJxSDreVLxFT4tHRihLGs=@lists.denx.de
X-Gm-Message-State: AOJu0YxalQ9SL/t1YwqrWUzoc3n1E8gZj7QuODJd/KwWYnuHXtAiFI4/
 3pjwHKnCM4GbewOahVKwJvJ9PII5B0o0S+FTk3oBRonhl50mSUky+KRHNbAOiUk=
X-Google-Smtp-Source: AGHT+IHfIgFOlkuhnEFqTXW1ZEFN6TtpJqPlcrwQ9a5LIyEJtB7L8LVEjaNDOYiyD5Td/9s7MPeLKw==
X-Received: by 2002:a05:6000:1942:b0:378:8aaa:9cd6 with SMTP id
 ffacd0b85a97d-37a431be2dcmr845727f8f.49.1726819232432; 
 Fri, 20 Sep 2024 01:00:32 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e7800313sm17059497f8f.88.2024.09.20.01.00.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 01:00:31 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 00/13] ufs: enhancements to support Qualcomm UFS controllers
Date: Fri, 20 Sep 2024 10:00:21 +0200
Message-Id: <20240920-topic-ufs-enhancements-v2-0-65ae61e73eaa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJUr7WYC/4WNTQ6CMBSEr0Le2mfKTwx15T0ICyxTeIm2pMVGQ
 7i7lQu4/CYz32wUEQSRrsVGAUmieJehOhVk5sFNYBkzU6WqRulS8eoXMfyykeFyweAJt0a2aGG
 1Qa3HlvJ4CbDyPsRdn3mWuPrwOX5S+Uv/KlPJimtA3a0djLk0t4e4IfizDxP1+75/AaFPOjK9A
 AAA
To: Tom Rini <trini@konsulko.com>, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>
Cc: Michal Simek <michal.simek@amd.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, bmeng.cn@gmail.com, 
 u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2637;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=98NLoG2cu2+NGxfDhWbLu7Y0L3XLZC6LQJiBsKQGXKQ=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm7SuYFKa6lbu0TEKFPrEkgZTRYbDGouo65as2TUWS
 zfkmfreJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZu0rmAAKCRB33NvayMhJ0WB6D/
 wI8pHR+/urOaV//TGqK2lV3vZOegK717q6oRgxm/5AZ9vfQooculoYysm/dYQz3LzEPVhlH7Zgr2CA
 2I+WQt2eAJYTWeTmHDAH5hofLf7JIphi1ZzQRQ5Ek3EMDOLg2y06WHKZL3y2l8v6JOitefsriRcl8e
 jYA9h7ZnI7tqNEVwYtyAXceHJhUV4rCmd9gKwqG+ug16ko50mDWtpuycbBxS+DYSvz2SZq1U1NcNg7
 eI2wd/RXHekqmdZdmY/yQ71j31PgKpAe9dvn0Ii+UlCHx7N3+Ld33dWFpfoplgBDhIV6wNQiD+TfhA
 dHRyfNHgkvsTw9o8Jfm8kp8+Kx8gylWxGErT3Y/g4NZgVeCPk0kQb+5FmK4XL0qUM+7uLkHMzP0/o6
 9hWr9jCMTAoB3/DbJlRvVrN7zuQdZ3V0dfAC/PkI80LwKyOwry2xJTI8KiA4f6QO4zj/0QwQlybGSf
 ren0cM+r7ezGx4VE4rb8My+iFKu0xO87ToiGzIDJIHNuIFkAg0kinUpjEolthFE6TRmeQB9pXbCRj7
 gvc1yd7gn+hIEZju/ZLWluWYAMKV2vbxqOWZHq7BbY+s5YP0b3sRvsUBAK3OAaE70n8z2Ei+gi0Nex
 xhW11PE0q6MXQP0uywvSALc/aN1xlwrY9fJDhgB/5Ex1ZQPoc2n8G4OzOU9A==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

This serie regroups all the fixes and base enhancements required to
support the Qualcomm UFS controllers in U-Boot.

This syncs headers & defines from Linux, and includes 2 set of
fixes that were sent separately:
- ufs: core: remove link_startup_again logic
- ufs: properly fix cache operations

Without those 2 sets, UFS cannot initialize on Qualcomm controlers
since v5, and a numerous of Cache issues makes any UFS controller
fail to initialize.

Since UFS core hasn't changed for a while, and since UFS is core
technology for the Qualcomm SoCs, I volunteer maintaininig the
UFS subsystem if Bhupesh & Neha Malcom Francis are ok with that.

It has been reported to show regressions on:
- TI K3 platforms (j721s2, j721e, j7200, j784s4) [1]
- AMD platform (amd_versal2_virt_defconfig) [2]

[1] https://lore.kernel.org/all/38f599a8-7094-4a04-8ff6-96fc8b9d168a@ti.com/
[2] https://lore.kernel.org/all/SA1PR12MB869713CA620F99077B75EF0E98632@SA1PR12MB8697.namprd12.prod.outlook.com/

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Added review and tested-by tags
- Updated patch 12 message with more explanations
- Synced patch 9 again with Linux 6.11
- Updated patches 7, 8, 9 and 10 with informations about the origins of the changes
- Link to v1: https://lore.kernel.org/r/20240910-topic-ufs-enhancements-v1-0-3ee0bffacc64@linaro.org

---
Bhupesh Sharma (5):
      ufs/ufs.h: Add definition of 'ufshcd_rmwl()'
      ufs: Clear UECPA once due to LINERESET has happened during LINK_STARTUP
      ufs: Sync possible UFS Quirks with Linux UFS driver
      ufs: Add missing memory barriers
      ufs: Fix debug message in 'ufs_start'

Marek Vasut (2):
      ufs: Add UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS
      ufs: Add UFSHCD_QUIRK_HIBERN_FASTAUTO

Neil Armstrong (6):
      ufs: allocate descriptors with size aligned with DMA_MINALIGN
      ufs: fix dcache flush and invalidate range calculation
      ufs: split flush and invalidate to only invalidate when required
      ufs: use dcache helpers for scsi_cmd data and only invalidate if necessary
      ufs: core: remove link_startup_again logic
      MAINTAINERS: Add myself to the list of UFS maintainers

 MAINTAINERS       |   1 +
 drivers/ufs/ufs.c |  98 ++++++++++++++++-----------
 drivers/ufs/ufs.h | 199 ++++++++++++++++++++++++++++++++++++++++++++++++------
 3 files changed, 239 insertions(+), 59 deletions(-)
---
base-commit: 24961c0e0444d3ed534ffc6a173e6ea636ca116b
change-id: 20240910-topic-ufs-enhancements-fe8ef9ce39d8

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

