Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD0FC47073
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 17:43:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69EA387B6B;
	Fri, 29 Dec 2023 18:43:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OtanRbvz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49CA887B6E; Fri, 29 Dec 2023 18:43:09 +0100 (CET)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED9E887A3D
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 18:43:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7818ab57d7dso63082785a.2
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 09:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703871785; x=1704476585; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KybC7fYdUe2ABPOFjI6zqP6WTDKbHH7A53I4IMTXOuk=;
 b=OtanRbvzusgOuLPCCNb9aPessaNGY5dNNmT2FwiMiAeGlwLPPnDxRRZm2t4n8xlyG4
 Nzd+/4Ge6qBQsqhDad/xscATei4b2E4v9m9JyCNsK1v7Y6GZt64g//PYFMCPRXyf2HhN
 0/hIQOJe81vn7iAud3nAjboIhHNYxKPDIVBY3Y0ymQ5FBI4voAaaLf6wujaSU6TwXcH9
 UBxDKHfoGdCbTzuDh/Y0eAZzQKMIYY0LRLH/PvGOLGKBfZ8/YGmw3mNUa521R4AP97KE
 IAgXQaQkmIiofKtwBfw+YjaOo0QFGPDXmcAqqVLwUwvcSRWNpocNDyHR7tURavnqGcHN
 nHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703871785; x=1704476585;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KybC7fYdUe2ABPOFjI6zqP6WTDKbHH7A53I4IMTXOuk=;
 b=lu6n2CyNI6tyfEjr7b3olm48ZUMYf7439vDsvwIXCA6zEJmwJHVRp1SmaYrd5ruUJQ
 +ecVPD0w2jIZlUMoHozG0oLifAnI6DZaVywimsz7GLOvkJgpsvebd15mO/P3qmZa9pJk
 YOsjGAVy3oT3o8ij7vzfHG5dH0RdlwdghKGi5GqRPKUslFnASyTbRtdBO+Om0gTGafQ6
 QRfKWKzDwi+7vnHYZ+iY4mAjtt2+qhNf3zcYkw16vHwKHqofYCwT08rega1Fv3wZG+3V
 QvEYnAO7Z0YOTXNpcz/6fakac0cWE3L6ZBfs3MKUdWqHjnTFGVgT/KCzM3rZyWsck0pz
 LXrg==
X-Gm-Message-State: AOJu0YyKljqO1wG4dXUsoKP8l0cWkhFAhinLyAOnSWD0ns1fHuMST6Al
 wB8dBn5WGT+0WdiaPpEg3tUfSleGrSY/j3tgLro5WqJnfLA=
X-Google-Smtp-Source: AGHT+IFlSwtQqpCwTuUM4VDkImka4U/OugT8YyVLrZ2MjfUAkMwcZ4NxzjnbnrIYJwtPIafZ/Dm21Q==
X-Received: by 2002:a05:620a:28c3:b0:781:56b0:d102 with SMTP id
 l3-20020a05620a28c300b0078156b0d102mr8287808qkp.149.1703871785403; 
 Fri, 29 Dec 2023 09:43:05 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 v11-20020a05620a122b00b007817084e7basm1545849qkj.99.2023.12.29.09.43.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 09:43:05 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH v5 00/11] Support Firmware Handoff spec via bloblist
Date: Fri, 29 Dec 2023 09:42:32 -0800
Message-Id: <20231229174244.892818-1-raymond.mao@linaro.org>
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

v3: The implementation from boot arguments to bloblist and how to
load the FDT from the bloblist are moved to a forthcoming patch serie.

v4: Patch #7 and #14 from v3 are squashed to other patches.

v5: Patch #6 from v4 is squashed to #8

Simon Glass (11):
  bloblist: Update the tag numbering
  bloblist: Adjust API to align in powers of 2
  bloblist: Change the magic value
  bloblist: Set version to 1
  bloblist: Access record hdr_size and tag via a function
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

