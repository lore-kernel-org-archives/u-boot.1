Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6467D4662F
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 23:04:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0B5C8388D;
	Fri, 16 Jan 2026 00:04:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="draNbjgO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F17B80077; Fri, 16 Jan 2026 00:04:10 +0100 (CET)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3832082BF2
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 00:04:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-6610f407959so407878eaf.2
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 15:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768518247; x=1769123047; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xlmPFdtV55R8qePnZZXqAVnatUuWheXJKh5G/LqEsLE=;
 b=draNbjgOcUpjCrmK35LudvruQ3Cg9I9yNR3jjOvgpafgHmpEIfUx/Lq1qjnCad0bT0
 BkFWxX7EwBy23dRgswkcIRCi8Cq7iyGsm+z7sIwTTQBy/tM/qFYOoyjHxURFhL2LUKgU
 pQjtZQEk8uJrsW9kYo4GJiD0eHcERjrOeCWBBcPdi5NYguFAllkDtHP16zKgIgNYCuxn
 pFRvkIOd9S9hQDxajv0vVXkuF5HwywA0MwYngoZkJmXqoSOgIs2bFNy7XLhorcBvc/q3
 d2ejrcxTa3EGiiGBSE8+JbOMPN9Do41NRpfs9b0oGel3dWOKCDsSmDS9hvDvvRGt+PPG
 TuFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768518247; x=1769123047;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xlmPFdtV55R8qePnZZXqAVnatUuWheXJKh5G/LqEsLE=;
 b=jXwOIEKpryMOlfi2GVMvYoOxwr2Wg8sP8RMj5tT55XNb7B34g3QbI1ogEi4NtPbpMg
 8WGtkA9ZI4B+H2QKV3D/uT6Rd3kYqKeRufQbjxfkyl5Iy9pV+AFSCy2tEPM9FigS0W99
 kD0FTJ6Zzzsu46ru+l4j2V2r2omSSaRdLqB31Qam7xpbSXXl3ZBtHxL2r7iHGVIUrSrm
 CL3rGwexVgVwj5HYluiw5Sr3ucdLJ05YACmtJE/KEiD+Bpmy7Bt8OWd/7zqHHRVTPHnA
 5zpH8yhbu7fxGtEyQ63WBl/mpVVKy43UwcYM9yk1kKczvI53EFwyOXBgFrnv4N7f6Osq
 CF/w==
X-Gm-Message-State: AOJu0YzU9S3kRkUbbPqwB/ZggHt3BB+f+oCIWyozY/mDMeb7OgqiIGwV
 MQLfci5HWGwa3YW9bZ679PuMmabYX4zvl1BmWC+0jyRoJtAX6PsRwg2GLuAciA==
X-Gm-Gg: AY/fxX6ujkIKpd0bsBQurRWf6dlGb1ulIevzvCy4IJ3g0l/fyQ1M9huccyRspROEwpD
 Ym/T3UtQa71b9uF/W4diPbcrMREbauGm5Q7Kl/aTb+cjhKSuXiZ3V9pWkbXFd6xsrdS2uLmsrpU
 BQOUjfrfzORMbzsgjFsd0Xeu5Pv3JxRRCMitzZD0t/de1y6ijGWroOT50AAJtsuWGuOK2zfFLF6
 3sMs3xfMhylLZeglyItc+ZPcsA2QTV9t0rt+S/Vk7iRtVS4xDLUe5TzFtB9FHf5iGvDwfX5qgKX
 o8CFYeSnK2Ztsk06Er8AM8kz6l6iJd24qDMbjw/n1d0cyoJSDoQr9eu9e7XXNy1I/3Y0EF9q1B3
 6xLqDgKBrmbyxDzBMu0qxHVUAjbPapSpGrh1qiVxCY8HcBlnbFMfLNQyu1n4SEW91bujFXkGA0O
 dTOT93qJY3
X-Received: by 2002:a05:6820:4811:b0:65c:fdd9:6f54 with SMTP id
 006d021491bc7-661189b68a0mr281274eaf.69.1768518245373; 
 Thu, 15 Jan 2026 15:04:05 -0800 (PST)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-661187a0000sm394787eaf.14.2026.01.15.15.04.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 15:04:04 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: thinhn@synopsys.com, neil.armstrong@linaro.org, quic_varada@quicinc.com,
 felipe.balbi@linux.intel.com, mkorpershoek@kernel.org, lukma@denx.de,
 trini@konsulko.com, marex@denx.de, macromorgan@hotmail.com
Subject: [PATCH V2 0/4] USB Fixes for Gadget Mode on DWC3
Date: Thu, 15 Jan 2026 17:01:31 -0600
Message-ID: <20260115230135.183158-1-macroalpha82@gmail.com>
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

From: Chris Morgan <macromorgan@hotmail.com>

In order to get gadget mode functional (for fastboot and ums) I need to
pull two patches in from mainline Linux. After applying these two
patches to U-Boot I am able to use ums and fastboot on my Anbernic
RG353P device for testing purposes.

Changes since V1:
 - Take the existing dwc3_core_soft_reset() function from the upstream
   Linux core.c file. This necessitates including another patch to add
   support from upstream Linux for the ip and version_type field and
   accompanying macros and functions to initialize it.
 - Specify the timeout changes made in the gadget driver as part of
   a separate patch and note the change is required.
 - Remove change in dwc3_ref_clk_period() as it was not intended to
   be included.

Chris Morgan (4):
  usb: dwc3: core: Add ip and version_type support from Linux
  usb: dwc3: Increase DWC3 controller halt timeout
  usb: dwc3: gadget: Don't send unintended link state change
  usb: dwc3: core: improve reset sequence

 drivers/usb/dwc3/core.c   | 92 +++++++++++++++++++++++++--------------
 drivers/usb/dwc3/core.h   | 60 +++++++++++++++++++++++++
 drivers/usb/dwc3/gadget.c | 20 ++++-----
 drivers/usb/dwc3/gadget.h | 14 ++++++
 4 files changed, 143 insertions(+), 43 deletions(-)

-- 
2.43.0

