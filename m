Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F46C54ED1
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 19:08:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F2B4833C7;
	Fri, 23 May 2025 21:08:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="b273Sy/n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6757E833D3; Fri, 23 May 2025 21:08:14 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 493048338C
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 21:08:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-73502b47f24so81930a34.3
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 12:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748027291; x=1748632091; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+paQB3H49KYy/l7L0al6v+nLbvQn0DH6FD/OI2LEkJw=;
 b=b273Sy/nxEfymRO1PdQ1OlbzPDwCNRah8ekzlxNEupjEaVuSLw064PlBGzSfAGchTn
 hTUzTZ41eFClk8r2htdceVkcGXl5w+G9RFVvdelBW1ucN7uMz/tsUfbcmlMwsoIeiI79
 xtOpInrf9SSVDoqV5b9SP0PdScfdtSG+8fyPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748027291; x=1748632091;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+paQB3H49KYy/l7L0al6v+nLbvQn0DH6FD/OI2LEkJw=;
 b=ISYlpdPtYpfcX0xto0Ketj+kioAOqMHZuXEcKTZ6qYlv8e75Vv7/SaYLiv+SfUUl/g
 91gd+tk/G1I0z+M/fInRIR6+ykWsz/KUg6faDVuaSMNdQg+mKowDN5Agl1TOzvjMRYyQ
 PQj2DKuXqSI1UdedXKoEJ9Tew6sV44o+nN4SzRXt+dM2hdHPnykIUfCrTSOEKdgFfkMM
 WaS+8ml1FyySsoIjs9hcZL8ya3iFzHSjdRfQU/Ks41x16NpA760ejMJqsigrZtEaEjpP
 I66G1si9YQJM38CMC4GDdwMgFP4F+FlvnxRapBuU+QsYVajaeMBaI7XTB0CGF7j29+zx
 TyBw==
X-Gm-Message-State: AOJu0YzoLPSvrmhsuwpSFY9P8mA8ey/rr9R5EnvoZarleMNXmMU2EUho
 ImVwcVPLOE5ocjwzzZ3WEp36z+9tS3EfpujVDQUlgbNYned2dkGSrcX0h0nJkd4fB2s=
X-Gm-Gg: ASbGnctDyyy43JXDdh5J14pt93Nhzd+xb+8CEf7U851OG0ONkcytXKqYs0P15sisBNW
 dg0W8nMRzaaW8pd/IOLR9o6Ble+PEwpNK5yxy6s+jA/wYKHDmdhpwAWOKu0mmBIQtGVma4X/7NU
 QEuO8vBNen30giNIPDLvj2ROpWZj7MAUxwKrvmNO9Fsc2f3QUl8fDG+Ujb2jFGJ1RWYJmeIcXC/
 eOKQffOa/YKVQQ9XAMobltnDOcri1NTTfDOkd7baiWC30Ur5bzJxQh1BU7e3t3VQQfg221YTH27
 STdhE7xxBe0ZhxPXOJcceNyLhWc5/uxicxbhFCq61FirBShFEWNwvBB0v+FOM0Vi7h9njPB0MQD
 oJ6NSd8M7Nko=
X-Google-Smtp-Source: AGHT+IFB4RTLZqxh/V9PNe12iamTQkk1XwrqqKZFCbJ3vDq3kl/6hOXxOhUmftGm1gtiOBdga1JHNg==
X-Received: by 2002:a05:6830:2908:b0:72c:4032:76f with SMTP id
 46e09a7af769-7355cf4668bmr583510a34.12.1748027291090; 
 Fri, 23 May 2025 12:08:11 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734f6b6062csm2966004a34.64.2025.05.23.12.08.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 May 2025 12:08:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Tony Dinh <mibodhi@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <20250523050201.22442-1-mibodhi@gmail.com>
References: <20250523050201.22442-1-mibodhi@gmail.com>
Subject: Re: [PATCH] ext4fs: Fix: Read outside partition error
Message-Id: <174802729012.2324752.17913463403407958079.b4-ty@konsulko.com>
Date: Fri, 23 May 2025 13:08:10 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Thu, 22 May 2025 22:02:01 -0700, Tony Dinh wrote:

> Use lbaint_t for blknr to avoid overflow in ext4fs_read_file().
> 
> Background:
> 
> blknr (block number) used in ext4fs_read_file() could be increased to a
> very large value and causes a wrap around at 32 bit signed integer max,
> thus becomes negative. This results in an out-of-normal range for sector
> number (during the assignment delayed_start = blknr) where delayed_start
> sector is typed uint64 lbaint_t. This causes the "Read outside partition"
> error.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] ext4fs: Fix: Read outside partition error
      commit: df2ed552f0b05591090369a7fe7ddc92439dea5c
-- 
Tom


