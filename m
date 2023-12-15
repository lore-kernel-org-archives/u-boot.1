Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F239C4167B
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 21:06:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0FA987C12;
	Fri, 15 Dec 2023 22:06:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mUTqxagK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56C0887C4B; Fri, 15 Dec 2023 22:06:28 +0100 (CET)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C644D87C10
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 22:06:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-42581f9c0e7so7515621cf.2
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 13:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702674384; x=1703279184; darn=lists.denx.de;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=inuIfhkqmRbZdJO3B7ODStmTql6VhqgopTVMHYh0LnA=;
 b=mUTqxagKur5tz1QE7O0YOSlPDEXhFbfd6l3+vKprrFoC6jCamNOLZAxtOT29SQ7pu9
 3TDpINBvbHedKPu0ThBfVN9szp3rrpvgOgn9A5SVatR1tHtOtxzknLmrJyYNaOpq244u
 qT+mNJSldgKa0vX0AVM/mIBo//zlcQSznixJxROVuVMFfHw5mMONnlRbZrHZTd/9ephS
 +P2fFIpLSTIu6uBHeMHA7f2vsICDId78cm1EfZxlt1zkMT6pc9WDob8urSB7FEodp40N
 iNEnBTw204gVpFGL8b+xHMhv0YeLCFIyBaeDlY8VjJEpJkN+vdjwTaC1w/CsfWYFwII8
 QPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702674384; x=1703279184;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=inuIfhkqmRbZdJO3B7ODStmTql6VhqgopTVMHYh0LnA=;
 b=XZRe4fvjSFhUFoxyvDU62x7q1k+Rs2g/IKoWSWv14SDrKknm2NFkhkJPAOti2+ihQC
 ETX6aWLB4asfh8aypBLxD50OjxozTHHhr62LYJ+KKDBJnspBuM1rAFxPQ56i8/A3axCN
 Cy3HeULVX0d7Ydxda1IhbZZxoNdi3dW+NEEwCOeSuxW7UkRR6MhNtIQA45xh3P7fjfU5
 XntcGHndiRjGl0ASRCwmSIOqPpgARtmQY/3+YwPxJDXwkjongPlHo8F4I3ii8aLPiB1a
 DUZ85HQfjKgCvWs+fy751tLDJ+g5Vh3gA+Xb64foTWhIQ4PQGqYqhmKH505h/QOAKzmE
 pJxA==
X-Gm-Message-State: AOJu0YxwwvGjeLBOv4NpN1M9PvR2j3QKPlPVWrbGGu7yxaZY211K4RZK
 u+fpCwcsldHns2OdZsHJS4y6xNL8aBTSRA==
X-Google-Smtp-Source: AGHT+IFB/6uONUeaz56sRBA23it8tjERNdu6J9MDiu+oemc9wQWX1Mo/8tStlqtMn/HVUL8ZPOo88Q==
X-Received: by 2002:ac8:5bce:0:b0:425:4043:765e with SMTP id
 b14-20020ac85bce000000b004254043765emr16554135qtb.134.1702674384602; 
 Fri, 15 Dec 2023 13:06:24 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 g20-20020ac84694000000b0040399fb5ef3sm6975310qto.0.2023.12.15.13.06.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Dec 2023 13:06:24 -0800 (PST)
Message-ID: <09b2e060-35a4-9509-145f-d1e3080638f7@gmail.com>
Date: Fri, 15 Dec 2023 16:06:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Igor Prusov <ivprusov@sberdevices.ru>,
 Yang Xiwen <forbidden405@outlook.com>
From: Sean Anderson <seanga2@gmail.com>
Subject: [GIT PULL] clock changes for u-boot/master
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

The following changes since commit 3ac22891cfc0dc6d8eec25d2b0fbdd2eb8f3d3ed:

   Merge tag 'u-boot-imx-20231214' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx (2023-12-15 08:22:31 -0500)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-clk.git tags/clk-2024.01-rc5

for you to fetch changes up to 97d65b32d76cb3b8297cd8aa2c1f0caab5ab6c57:

   test: dm: clk_ccf: fix building error (2023-12-15 15:30:12 -0500)

----------------------------------------------------------------
clock changes for u-boot/master

This has some clock fixes which should go in before the release. It's a bit
late in the cycle, but most of these have tests to go along with them.

Signed-off-by: Sean Anderson <seanga2@gmail.com>

----------------------------------------------------------------
Igor Prusov (2):
       clk: Check that composite clock's div has set_rate()
       dm: test: clk: Add test for ccf clk_set_rate()

Yang Xiwen (4):
       clk: check parent_name in clk_register to avoid confusing log_error() output
       clk: get correct ops for clk_enable() and clk_disable()
       test: dm: clk_ccf: test ccf_clk_ops
       test: dm: clk_ccf: fix building error

  arch/sandbox/dts/test.dts      |  4 +++-
  arch/sandbox/include/asm/clk.h |  1 +
  drivers/clk/clk-composite.c    |  2 +-
  drivers/clk/clk-uclass.c       |  2 ++
  drivers/clk/clk.c              | 18 ++++++++++--------
  drivers/clk/clk_sandbox_ccf.c  |  1 +
  drivers/clk/clk_sandbox_test.c |  1 +
  test/dm/clk_ccf.c              | 22 ++++++++++++++++++++--
  8 files changed, 39 insertions(+), 12 deletions(-)
