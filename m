Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E533ECE582
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 09:22:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEC0988FB4;
	Tue, 10 Sep 2024 11:20:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="j+9UEGv2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B47EF88FA8; Tue, 10 Sep 2024 11:20:44 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C229888FA7
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 11:20:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42cacabd2e0so4606435e9.3
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 02:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725960038; x=1726564838; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9u3PCEu/NZJFHjelnIq2+vYbYZRLd2Pa1R6lxzoheII=;
 b=j+9UEGv2JAe2sVjldkOhEsi/sGsFhI2eRfvpGdSm2D8fx/ZmKyQqkyapDWyKeAGVZq
 BO6IwYr0ES3acX3mUw+atAgzJmXsVNi9cypYHarX4FHzvXFEbSjeJ+Yr3D1oCASCyWCj
 6WZ74LRXpxIPBC9HQ/ymjCuCJdkPE9IelWNDGRN18egyx2lxE1KJ2WrpEvm6Atpfp8cJ
 BZxtrVeS0EXQtWQyPDNp6K6JRlxCP6f8btCkSzdUYJKyiUoAUwFP3ypOa9wkkQlkq2Jm
 bRhmPV0BStq1wrtHQZghWt+WMpvpIds+XWBwktlIXqMDYknXBehZ1myYCJDhqbMi8krr
 03BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725960038; x=1726564838;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9u3PCEu/NZJFHjelnIq2+vYbYZRLd2Pa1R6lxzoheII=;
 b=MfMwbNoPgcxaPkMKT/wduNvvGLUV+Fo4sWGpP6FNnLWrrpDzjud3Ljjyf0+zCA8VUB
 N6QCUxfKbUx2uQanbFTYjDy2nNNVOAZrSXnCzb8fBqNfEvIDKtMgUIZrsUAMW9i80PNt
 9Q9YfpwUIqWMfPBk0ueGfSYm9UB0TqdvCZaJMyBmiaMdQYXaZhr9Oia/6q26pquWtXzr
 dliJ6SmuOVKMRi0E87ghMFob9hKvzLRFTzftHP/XaqNmXZfRBmYrGxHH13GAtZs4VmlY
 Jo5l7/H6/Hcpza6zJ44bOsWoasCb3hqbBUyKhxVaecCEp6tmxB2uQvlcdnlf81CAieRr
 TtAw==
X-Gm-Message-State: AOJu0YzQWdLSsYFcRmtdmBjM9orJa20+JSFwwpOmYS8r6JM/TraakQZ8
 ONTGuBOUL8Z7FMETLfocqwCLRVt6O8Flg++eb0+mYQ+BAClQEQ/uz4I9jSO45RW4KqN4lwyl+/j
 9
X-Google-Smtp-Source: AGHT+IFK33aFwOp8jaswXaDmrlYtJe6uG5wDiZTiN0HIUgLFYFxxvvXhZpBl4leVI+yUOB7NDK79bQ==
X-Received: by 2002:a05:600c:4452:b0:42b:a9b4:3f59 with SMTP id
 5b1f17b1804b1-42c9f984b58mr113192715e9.14.1725960028294; 
 Tue, 10 Sep 2024 02:20:28 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42cb099acf6sm101256245e9.9.2024.09.10.02.20.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 02:20:27 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 00/13] ufs: enhancements to support Qualcomm UFS
 controllers
Date: Tue, 10 Sep 2024 11:20:17 +0200
Message-Id: <20240910-topic-ufs-enhancements-v1-0-3ee0bffacc64@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFEP4GYC/x2MOwqAMBAFryJbuxA/hfEqYiHxRbcwSlZFCN7dY
 DkwM4kUUaDUF4kiblHZQ4aqLMitU1jAMmem2tStsZXhcz/E8eWVEbLgsCGcyh4dvHVo7NxRjo8
 IL88/Hsb3/QDs8eWpaAAAAA==
To: Tom Rini <trini@konsulko.com>, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1964;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=mPnpePlnNVOPaKDy2fp8mPI1jzQuFdMEplQUqfLDiP0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm4A9Vw4odvhjQfmIVfR/WaQpoCbTljbDJ9ruZoyaI
 5SOSo86JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZuAPVQAKCRB33NvayMhJ0S5aD/
 oDmmH+YTgXRbxrqtUg1CvCJ4vlRH6XgQWVZjAQb/lgOeVb1NZTaZyRXoe8ye25Vh+wai5ESfjheIeE
 j7ynwXRv1YbC8Twrwe/IOhVFlSUgHyp/64DqaWbB6zAXkEqroJ82QUw9VhrTTnVM9C7rt8R8/ZUdgc
 avmPfStokfyT/V6XG6hLt5Zm9WaYkVSqXaz+IkH72vJ7Z2XS7PBykZ4gvY+NqEIxB6JNQh/wTEC0cb
 kQWlH198/vdkLQKZmAdqjGFKH7rpjZtJ0x5BdsRiu9DPPsO41oafgVQd2FJzNUDDcXd4yGcLIVhrk8
 eQBudDhP1+WIhxFVIzbm8sNJO+Tf0peLaqvZ6oLQZdj7tY0CX98OlQsFZsPCRLv5RWlm/AlXv0wksn
 GDq/bxa+9CK8m3dIfaM5d0xjQcW2NX843MB5M8pp/8CuQZwy/0b89Va0ENdt9mQc9dRKIbGSqNY2xB
 KG80sQCpGthd8VN1WUWdPNUPn3SnF2E/g1Ezk8Ye20md1MznMzneIWD9U+vWajkLYEalOURiBvPCsv
 eUZYOvctfv1mrD/FW2/jNwsb0k8+OYiLR46xo+E2K7Itt8FlkGegK+Z6eJYe2byjAl4+QorOrGimdE
 izxAI4VQiZspnhIvylgJ1baIFOlftWTcrDgKSFRK9u3hjM6QXBTJ8a1n4qGg==
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

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
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
 drivers/ufs/ufs.c |  98 ++++++++++++++++++++--------------
 drivers/ufs/ufs.h | 157 +++++++++++++++++++++++++++++++++++++++++++++++-------
 3 files changed, 197 insertions(+), 59 deletions(-)
---
base-commit: ca55cf8104c0dd78aae45fa66dd8400ef1b3d0ac
change-id: 20240910-topic-ufs-enhancements-fe8ef9ce39d8

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

