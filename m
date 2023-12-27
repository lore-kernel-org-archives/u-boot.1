Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A97C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 21:07:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87975878FF;
	Wed, 27 Dec 2023 22:07:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FsmQKnYa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5A1087945; Wed, 27 Dec 2023 22:07:30 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DCFB876D7
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 22:07:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7815aca9a4eso72832285a.0
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 13:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703711246; x=1704316046; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Lrp4RUIsrkEydcqzZvebYp7OC0qfzTSmnr3MmFasNAU=;
 b=FsmQKnYa5K7kLHBR5oIevG87ceD3dFKTRjaxSO5IYMwRWKLFd7BWBIq1yEocp51ozO
 Wme0fC0/EjIljOMN2fTKeMeURAdCXvckVpFoZ6dyehuvN1AAZ7RQl9o2QwCdJ7GYSzjN
 FQm9CBFKBiIfRxSqZB4skFGY+1KgVfWUsX0/aEHgemBsHmOrbvGlSfiVwia7Sl7Ld2PL
 qW/jKuJFhD7poAxSYvA/18C7gEAAvTF0g9F5oa18kahC0hH8WxJIKl9aNclIdCCA2/hY
 hJSOUnUeZCP4JLL4d/vOh58QFdMhhFwBX+go/Mg6a6EYk0H+IoAZTdSEaoheQhqNc9b5
 SwRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703711246; x=1704316046;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Lrp4RUIsrkEydcqzZvebYp7OC0qfzTSmnr3MmFasNAU=;
 b=SRsGYevHCKqrR+e7YJl8kSlXZw+sJI6TIJOrNzU5TYLtLfkbHartywIodTS5VRjkUl
 KHD/sR4cY+TwgBLaFyd4cIM1hBOCahWaCkjymunQTSczB5j955w0UK4GIoc+5O19zFjB
 Raktit2HsWkRz7Bp0qnMVxJ7P6GiTTDGBH3i/tSICXXs9aXu/H7De3l0DndhKsP9MOpo
 Jr8gVZD78GPUbB7MsW3bxNmOzGR0F46yDizoBqdPaBljGx0E10rUfEfTrnEY1bq4ZwlP
 y6S8NA9/KkFNrObNiSo41dLVKxSDqBQsbh2m+AF3PBnUsRTgZr5P0Jj94hwHyWFRuo4G
 +lvw==
X-Gm-Message-State: AOJu0YxFJ3tDrXwws+8iw72v02M0veprSbGGM/Pake9g7DLnUwEEWPOo
 WCmOgO5vOWKOwRAVmH2SV9zhIUkGnHkTCsQTw9Z5UU8h49c=
X-Google-Smtp-Source: AGHT+IFwXi01eftbXm1aNbc3/3L1XgNS9dLp50E5U5igjhiOM7dTo7M7wsWKSbGvYmjtzKM+4BdRQA==
X-Received: by 2002:a05:620a:1121:b0:781:38f6:198b with SMTP id
 p1-20020a05620a112100b0078138f6198bmr8673317qkk.39.1703711246616; 
 Wed, 27 Dec 2023 13:07:26 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 c27-20020a05620a11bb00b0078161897afcsm637107qkk.109.2023.12.27.13.07.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Dec 2023 13:07:26 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH v4 00/12] Support Firmware Handoff spec via bloblist
Date: Wed, 27 Dec 2023 13:06:58 -0800
Message-Id: <20231227210712.712937-1-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
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

Major changes:

Update bloblist to align to Firmware Handoff spec v0.9
(up to commit #3592349 of the spec).
(https://github.com/FirmwareHandoff/firmware_handoff).

Includes:
- Align bloblist tags with the FW handoff spec
- Add an explicit alignment field in the header
- Update bloblist magic and version
- Use a packed format for blob record header
- Change the checksum alorigthm
- Use a void entry to handle the alignment
- Adjust the headers of bloblist and blob record
- Align the bloblist record data section start address

From v3, the implementation from boot arguments to bloblist and how to
load the FDT from the bloblist are moved to a forthcoming patch serie.

In v4, patch #7 and #14 from v3 are squashed.

Simon Glass (12):
  bloblist: Update the tag numbering
  bloblist: Adjust API to align in powers of 2
  bloblist: Change the magic value
  bloblist: Set version to 1
  bloblist: Access record hdr_size and tag via a function
  bloblist: Drop spare value from bloblist record
  bloblist: Checksum the entire bloblist
  bloblist: Handle alignment with a void entry
  bloblist: Reduce blob-header size
  bloblist: Adjust the bloblist header
  bloblist: Add alignment to bloblist_new()
  bloblist: Update documentation and header comment

 arch/x86/lib/tables.c    |   3 +-
 common/bloblist.c        | 205 ++++++++++++++++++++++++---------------
 doc/develop/bloblist.rst |   4 +-
 include/bloblist.h       | 166 ++++++++++++++++++-------------
 test/bloblist.c          | 105 +++++++++++---------
 5 files changed, 287 insertions(+), 196 deletions(-)

-- 
2.25.1

