Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 724E8D68BF5
	for <u-boot@archiver.kernel.org>; Sat, 16 Nov 2024 19:07:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EEF189171;
	Sat, 16 Nov 2024 20:07:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hrGBJdrs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B4138932C; Sat, 16 Nov 2024 20:07:04 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 201188914F
 for <u-boot@lists.denx.de>; Sat, 16 Nov 2024 20:07:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a9f1c590ecdso319734866b.1
 for <u-boot@lists.denx.de>; Sat, 16 Nov 2024 11:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731784021; x=1732388821; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=N2qq/WYpnBMazFtbP2PWvwKp4oYURYw2yWX3w2mz4NY=;
 b=hrGBJdrsdfqjwqC1rzFjlzB04Jc0QndxHC7V1PUp1MXXwcJf6aQxLjks1GabxuLAWV
 Rcu7k5kyIRirbqPRfsT5xO1u82HrW3NiQSm/vEXSBvefJObkDd60Poa/F0X9KlhacOXD
 j2dP7/bMkDd2/zVQx1J95SDyZTEMK5oHb8j04J/kVV4E9fC+ahrtzP9bgiC3tTty4Rb+
 xuDTg4pF3kR7RDZ3gl+UdMEmSuTadzpqrwjtSwXxTMRvG9RFYmbqJfTDQtBYewsAHNPt
 CtDPEAgXbLnO9Gaihzeh0oPD6LHA/fN7fWAOWim1wJ3ce/14w3eh7m5LBbdx1jqpesO6
 o7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731784021; x=1732388821;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N2qq/WYpnBMazFtbP2PWvwKp4oYURYw2yWX3w2mz4NY=;
 b=kEaiWfYxc3yQ7f8lAjdu7EjNJS9FFoeDgKoltB8oN+qmS0SWRESZEQgwa40xkK9mUL
 /i99vwoSTXadYNfkaLBVF0ta+M+NA+zJiBf/+fapJCwcCrBmYeElXwDxaxd13HqkboQZ
 153pXki1OZOvkArZOxeGc/4d0RLX9PhyyrMtVm9sge9+et1zsqczzHSbEhelQt1lvKhm
 4X3UY3TSvemKIAXk0HqJ/DzZCj36ICwnccQwraw2iWawMLYsaavXSeJLJ4oYQY8BBb/P
 1j2jTJeEOWpJOuWL2J9uYcV3APu7d5QeBNJHy8XvUivqvbXihIUexKgbu7Z3oLAIoBPr
 XWTQ==
X-Gm-Message-State: AOJu0Yx5JidMDB+cVRt4bvzYdI/X63bILLA6gdj9ABpv0i5ycflQQQuX
 Q6I45htoGcV+uDQB7d/KC39JlHyM5AGl3CEGonuJcZXqp8mzVxkEFPAg8GjACb8KL415pY2v+6b
 p
X-Google-Smtp-Source: AGHT+IEo6vETplSzLn8al67mgtuauytPeEVLgDWVKy2ZS5WQA/HovS3AUECDDtmdzylVJhsgp3wrmA==
X-Received: by 2002:a17:906:7315:b0:a9a:f82:7712 with SMTP id
 a640c23a62f3a-aa48354c91fmr682002966b.52.1731784021428; 
 Sat, 16 Nov 2024 11:07:01 -0800 (PST)
Received: from localhost.localdomain (ppp089210064034.access.hol.gr.
 [89.210.64.34]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20df56b1esm335947966b.71.2024.11.16.11.06.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Nov 2024 11:07:00 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de,
	trini@konsulko.com
Cc: xypron.glpk@gmx.de,
	ilias.apalodimas@linaro.org
Subject: Pull request for tpm-master-16112024
Date: Sat, 16 Nov 2024 21:06:58 +0200
Message-ID: <20241116190658.112452-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
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

Hi Tom,

Not much for the  TPM subsystem on this cycle. Just two patches from Heinrich,
adding missing tpm libraries to the maintenance list and fix for a coverti issue

The following changes since commit f39199e8096dab68fe4a8e15f8ff60026a5fe491:

  km: disable CMD_JFFS2 for all PPC boards (2024-11-15 13:11:51 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-tpm/ tags/tpm-master-16112024

for you to fetch changes up to c0231ede0f555b098dc7418926a8f9b407cc9928:

  MAINTAINERS: add lib/tpm* to TPM DRIVERS (2024-11-16 19:23:11 +0200)

The CI at https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/23393
worked as expected

Please pull!
/Ilias

----------------------------------------------------------------
Two changes from Heinrich.
One is adding some missing TPM files for proper maintenance.
The second addresses Coverity-ID: 356664 replacing a mempcy()
which has undefined behavior with memmove()

----------------------------------------------------------------
Heinrich Schuchardt (2):
      tpm: use memmove() for overlapping buffers
      MAINTAINERS: add lib/tpm* to TPM DRIVERS

 MAINTAINERS  | 1 +
 lib/tpm-v2.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)
