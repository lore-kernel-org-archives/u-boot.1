Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F672CF6499
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 12:44:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87CD788E4B;
	Mon, 30 Sep 2024 14:44:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="G/Tx5GVv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 098A488D9B; Mon, 30 Sep 2024 14:44:34 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0B8F88D9B
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 14:44:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42cb2191107so34903015e9.1
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 05:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727700271; x=1728305071; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uRL4zvhzzA3K5lSrueir/ymWsHnxlt7p/AQ8zEYXF2o=;
 b=G/Tx5GVvRAnTzo5maUHptdZK/KgOPBiIOzNoEZdcQdDvDI4A4BuNugoCWXcJSLnk9p
 vG9u1MY09ObnocFHd0yTrCa/byfAArX2NaTG9MzpgKGL9zJDaom1kDyZzZqJjHLsarfG
 oHtX2Fjoc6x0GtjPRGbxIBwVluj+vtvLE5BY3jawzlc9ANHXEqNe3hjbg/6YTsS6+SdJ
 bTKo30+/DEvMRT0qae1+7n2zazKczq7YXtDwjT1oTDGEPzV6AHbB9i1uFTj0hJuYQcsn
 wnzq3Lc8OCyfpBSYBxLIkOAaBlH+cCXCtNKOnr+hOUCy8Ct7a6S2knwTW0neLgzjs25e
 q+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727700271; x=1728305071;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uRL4zvhzzA3K5lSrueir/ymWsHnxlt7p/AQ8zEYXF2o=;
 b=FJ/4fo97g/FJgkI9j6icZ1o33tYYe5NVUmECshA2x+A3sR3iSAYxhxveCIINdjoRkA
 PVsrnGprXk1+VaeC24fsUAR4PPp23ayorj1APftDSNhu3t9cSfZ1fUqK8uafCKYtqdMm
 ErZWbFhgoh1CF5w4pfxwuJJfeXnSgwXj+eNZVWUPj5mqoIKCGKJP5s7ovr3prAc87qxX
 EfhNlPX9H2b2+WU8ERhyhjQSR0+7y7tALMpm6VjzJdt7/z0vWDyi4MBAz+fblgSj7bFK
 ETza7gK6w9lghMocqERKgPUi7LjAR8mV1fdZC27bcvwjUqbkHb+VIVc1+Kg2MJyOUWQy
 xZDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKA7A+AJrceJ3ebP+4f7a0R1fBfZOiP8QBTEZHzzGiE/L1bkHxZILxoKhaniXF1QX3ymlofis=@lists.denx.de
X-Gm-Message-State: AOJu0Yxs4wgkwCR9R5IDtuPmHHi+hbYXH4un6G1lcHNxpD7Y2n6oHQyt
 nx4/ePvU+dx5MfZ0MdwgO5Ib+G4GoF0R0V+FPMv6cbJQOrZy69PwZJFOtS4Ki88=
X-Google-Smtp-Source: AGHT+IENfamxJmwDWFE5l+vSwaFdywkcoskRmSieDqb0aAS9FvTUlA0ktpmqP1dFJe6VbtuRJVXZ/w==
X-Received: by 2002:a7b:c5c3:0:b0:42f:310f:de9 with SMTP id
 5b1f17b1804b1-42f5b906496mr85595235e9.15.1727700271023; 
 Mon, 30 Sep 2024 05:44:31 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e96a36597sm149362745e9.31.2024.09.30.05.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 05:44:30 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v3 00/13] ufs: enhancements to support Qualcomm UFS controllers
Date: Mon, 30 Sep 2024 14:44:22 +0200
Message-Id: <20240930-topic-ufs-enhancements-v3-0-58234f84ab89@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACad+mYC/4XNQQ6CMBCF4auYrq0pLSK48h7GRS2vMIm2pMVGQ
 7i7hZUujMt/MvPNxCICIbLjZmIBiSJ5l0NtN8z02nXg1OZmUshSNIXgox/I8IeNHC4vGNzhxsg
 tatjGQDVtzfLxEGDpucLnS+6e4ujDa/2TimX6l0wFF1wB4mqtNqYqTzdyOvidDx1bzCQ/HPnbk
 dmp9hpVgYOC1l/OPM9vMH9uMAUBAAA=
To: Tom Rini <trini@konsulko.com>, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>
Cc: Michal Simek <michal.simek@amd.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, bmeng.cn@gmail.com, 
 u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2773;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=3ZxUyYFfECS9SFI9LAuVBXgTYRNuxlMThshcIdQ0VB0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm+p0n7S0D7Z5LNdu1LLgRjHOCrGIuuGlHFPPMX8ql
 lZVvlUmJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZvqdJwAKCRB33NvayMhJ0YDbD/
 4t2pzmuAbqejj9bml4BBPF9aBkyXIPinU5cOuNzyOnedDmUSB6X2TcgaNTg0n7Q+F0lV89U6D0NLb/
 cqNhIMTyMdyoa392dHGvQNP2/YbVXbjdcfRoK1M2vnpMEn/qGRDaMi5OYRl6qwwpd3uFZhNybLQ3dk
 Z4/F575cvwZi2368Et9ld82xdEnMUpVRZnN1mtx2ALXtjPNpzcy4ZdLBQiGibt4UnAOD6S15FDqrp1
 +0wCic0cX8DgBdc8aXaJYSD1WDTAL1Z+RtpJbj3iBKaQ7sFKk+rOLCeEskfbGc8FWSVzbWNg5Eu1uI
 fnoAm5NouphIt19ezuYes5wdhp4V/gV6pDqW0P1u8h8LPd9eAzlM5HbEZCCfY9jhUnWTrsgp/4efpc
 tHUpwFlYQty+2FeiPwAu2gVcZmVwIktRmrintL5tIKXxF0uZgAsqe27CJSuCefemy5n6RMH2xEfT6z
 NZLm8xZYRqPBxRMfcFr16CnW25q7I6Mkci+JejJlVuGWeGbkj1AImEeI0u9WuCK5BWC194Cx+0egha
 izsodujgPVWuxbu8iMWcuMv4A2PQh5pOVXviUe18Ch152PwaapXjCTCPQgh+QjT7jZgu20MPgHOtW9
 hFlbXIKAmcxkBo+cmOtdyUg4mMfOvyNTouZT/UQMm3LlBE9H3HR35ReOQsWQ==
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
Changes in v3:
- Fixup patch 9
- Link to v2: https://lore.kernel.org/r/20240920-topic-ufs-enhancements-v2-0-65ae61e73eaa@linaro.org

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
 drivers/ufs/ufs.c |  98 +++++++++++++++-----------
 drivers/ufs/ufs.h | 203 ++++++++++++++++++++++++++++++++++++++++++++++++------
 3 files changed, 241 insertions(+), 61 deletions(-)
---
base-commit: ddbcafeb53e7093c58488596bfce6d8823777c3a
change-id: 20240910-topic-ufs-enhancements-fe8ef9ce39d8

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

