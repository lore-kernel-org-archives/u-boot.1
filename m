Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 645B6EE49A5
	for <u-boot@archiver.kernel.org>; Sun, 20 Aug 2023 17:49:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7A7086A0F;
	Sun, 20 Aug 2023 19:49:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="N8NXH7z1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88D4786F66; Sun, 20 Aug 2023 19:49:36 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1385B86EF7
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 19:49:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-525656acf4bso3305690a12.0
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 10:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692553772; x=1693158572;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=aVOw7ayX1j98g68MjyGH3YKnGmlg1un2pZM6e8WEf0Q=;
 b=N8NXH7z1TutV5Tahm2lJuhkufwTNFLuMA+iWRg11Iha0ibDRAMhPYJ/SXLJuW6ndFx
 RENoTkggUhYTP/vTZMoEQ4P7DhLXTWlPX9wSF1Gprf9HPRo5an1NzxaDlLtPZHtcI5sl
 MWuf9Ck9kSqsK4oYr2dZMdkw7P/B1kOXvrShQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692553772; x=1693158572;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aVOw7ayX1j98g68MjyGH3YKnGmlg1un2pZM6e8WEf0Q=;
 b=Hh+nJM3aJLpam2+i0dO+h0R3DP8pyzaF/4sjWxnZBtqd+Se6jTW9tjPOF0rmA+f/8E
 c/wrOTh/kypKifQHeOpodAI/CvHjVTIbBB8FkU6q9aWfvjVG3tYg9Gnru3sxeJJk30VS
 Dwt9GqgFaY4oKJlWkKvAFc38gWvgKDdw4fbgZM4fG+zPcYIzGsN6FYCE+pV38i4Q8oKG
 uU/zCwcSPCizUWvQhDd4NYbfquxq6sIL+a4nCnm1f2wJJ1lRmkZOZ7/CTQkZsEZ6XWF+
 UgNvuCA7wFOuxBE5y57vQiCrTk2VPo+nidp4yKyr0Y/vcjiTCGqclRwGn6NHVIPgut9o
 uR8w==
X-Gm-Message-State: AOJu0YxJ/5ErsDW/3ALbZMtOZTbhjkYWIZ10gjzLPYGKjZbz1ROkAQLW
 MJb3uQWJ828zVgZ8aUQIbN0sKax7zhLlF2ck/V8JmouLmBEhhdeogk8=
X-Google-Smtp-Source: AGHT+IFN5hZfm07gEDMKbkeuNcmiBe/0w3tehY32x1RX/eVVLpM8qkFnxgOLooFftoChZeA0FaKxRf6PhIUw844m34o=
X-Received: by 2002:aa7:d14d:0:b0:522:2af1:1ffe with SMTP id
 r13-20020aa7d14d000000b005222af11ffemr3295119edo.9.1692553772327; Sun, 20 Aug
 2023 10:49:32 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Sun, 20 Aug 2023 11:49:21 -0600
Message-ID: <CAPnjgZ2jMCpQbBGUx5ZnX1cDNJy3G8+HDMzk92CSwRVCE8TDjA@mail.gmail.com>
Subject: Dropping CONFIG_SCSI
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Mingkai Hu <mingkai.hu@nxp.com>, Andre Przywara <andre.przywara@arm.com>, 
 "Andrew F. Davis" <afd@ti.com>, Mario Six <mario.six@gdsys.cc>,
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi,

The deadline has passed for the non-driver model SCSI code. The boards
below still have this enabled:

$ ./tools/moveconfig.py -f SCSI ~DM_SCSI
controlcenterdc am57xx_hs_evm_usb ls1088ardb_sdcard_qspi_SECURE_BOOT
ls1046ardb_sdcard_SECURE_BOOT ls1021atsn_qspi ls1021atsn_sdcard
highbank ls1021atwr_sdcard_ifc_SECURE_BOOT

Please can you take a look at migration?

Thank you,
Simon
