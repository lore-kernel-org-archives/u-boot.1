Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B03E6B277
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 13:03:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5841B88D9A;
	Fri,  1 Nov 2024 14:03:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="j9nrD09N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E9288902F; Fri,  1 Nov 2024 14:03:20 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4430B88A4C
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 14:03:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43158625112so16623015e9.3
 for <u-boot@lists.denx.de>; Fri, 01 Nov 2024 06:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730466198; x=1731070998; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gMXmpX0jMbRGRA2QghGJmKK2hh7YPxfhl3hH0pu1qtY=;
 b=j9nrD09NC7tuzi7ucVyCU6gJVZp5OZVkLyWU7r5zIZREH+hceFVEdsdgg64y0TzckS
 rL2gh79UoSYD7/HTZQx9ZXJoaaiQy2b6gIb+EWkE5rScXVuokobyLreQECvHyIig4kFl
 +t9oYOJfH7U7MlnWMcXiH3t+c2NR1JLUTfnTkb/K/Pua/Cjyrw4uavyW5A1zC+NES+Hh
 zDIBdepM5qm3GOIdPc/nyqkMzleB1+Pu0kICsl526jI0e00f7lTYIuoTsPVAgb2ailbd
 t6yPKrKOhPe/xklVChanUBGTvxkJQsWTPTy0rj5Ulo0Fiz5G37hkerPM7XWH+oBjxl1Y
 z25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730466198; x=1731070998;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gMXmpX0jMbRGRA2QghGJmKK2hh7YPxfhl3hH0pu1qtY=;
 b=i0FJUjlvBzxR6wpEAXP/ApBCNGSssHv805Uc8HpSZUPBOJZccQ/hwozxz+2pvwEp3H
 w0CIxeNosmagDzRd2GxmNm9QPr4WfuiK1DuSCGX8HI9LfrZNB86Y9y7gBMJgXy7ZtzWe
 9XzXKsaA5ixLH1TxMW9u85iGmw5q15zqSVf/oqmBSICkNm6l9ulGgfWcU3stJKagDvtg
 4QFui8pOAUb2UglBgrnX7414SuTtRC9G7EOu76IinDPOlwvjPYtm745hP+aMu9PTBXVC
 5sOUlSaNVAGz1/nmGKhChpcBor2DVdFWHoqTjW1Rox6SsVSc6UVPuZ22616wf9ov+E6h
 7WcQ==
X-Gm-Message-State: AOJu0YznTwzsRk6SJnuSbXMKEDAuWoKiuuOA2A9P/YdHDI9eHLsXmXVL
 IsoHiy9L8aA2px/iDtUHsYG1/NVwUFb79IyRRUADVeE7RX/Q9i2fpapMjhF6BM/mvM363R8TunB
 NWso=
X-Google-Smtp-Source: AGHT+IH7+wL5zhpBArVDWcPv5IEevHkYt7T/Si9cnEdvT7dF27VH4JEw1ujozdnjrXMwfe1gWMmijg==
X-Received: by 2002:a05:600c:3555:b0:431:4b88:d408 with SMTP id
 5b1f17b1804b1-432832434cbmr28714495e9.5.1730466197575; 
 Fri, 01 Nov 2024 06:03:17 -0700 (PDT)
Received: from artemis2.broadband ([2a0a:ef40:edb:fc01:7dcf:21b3:7ed8:3010])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d685287sm62986385e9.35.2024.11.01.06.03.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2024 06:03:17 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
To: u-boot@lists.denx.de
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/2] Fixes to allow 'ut bootm' to pass when run interactively
Date: Fri,  1 Nov 2024 13:02:52 +0000
Message-Id: <20241101130254.473017-1-andrew.goodbody@linaro.org>
X-Mailer: git-send-email 2.39.5
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

Starting a sandbox session and running 'ut bootm' on the command
line instead of using pytest with --verbose will result in some
test failures. This series makes the tests more deterministic so
that they will better control their environment and hence will
work as expected whether or not they are invoked with '--verbose'.
The series starts with a small fix to the parameters of
bootm_process_cmdline that one commit incorrectly added using a bool
when it had been updated to take flags by the preceeding commit.


Andrew Goodbody (2):
  test: bootm: bootm_process_cmdline_env takes flags
  test: bootm: Ensure GD_FLG_SILENT is reset

 test/bootm.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

-- 
2.39.5

