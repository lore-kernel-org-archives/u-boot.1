Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB74C36008
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 02:24:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45D9E8070C;
	Thu, 27 Mar 2025 03:24:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mkJJRQLP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 040AB81A0C; Thu, 27 Mar 2025 03:24:32 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47FC4806D8
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 03:24:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-72a0a9cb29fso367034a34.0
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 19:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743042268; x=1743647068; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AhGFTHFwkCGglqQwHmi8xYPEDL3YAhWO2xi6iasyVcA=;
 b=mkJJRQLPvF9fnSKghG4TOKR5WXUTBGTGYFDHcTOwwYFv5t4fHUT70skXkNqMQ8uQn3
 hmql6z9DOt3Nge50NeBI8cv6A3OXwLZhcULOGp6lxFngfW8Y0kJA+bcvUZDLM8r1HeX/
 prt0NUuJv+O3JyAhP49+gyr4BtIfwg5EPmrkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743042268; x=1743647068;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AhGFTHFwkCGglqQwHmi8xYPEDL3YAhWO2xi6iasyVcA=;
 b=X5oRZ0km4XOcHT7uWgsZNaC33y/BpsVvhuMz1b1LaHNQeUCM8zEkSgUHJdD8DUWeSV
 O01sduvRxsxmJR2zC2QcXiZbMEP98+JAs0kfsWc5/owwrXYjVzBH01WDM9256se3io1i
 4bGPiDwxHMVHw31+4E8YaCY2H5C+j4W2O+5dOA/sm98WBPDnoX57n5l87sAx7emMXL8q
 a5k5bHa6SgkKs0T6i7HLLyrSX6CKEIJA1yzCDK9v15KkLA0ac/YVNrzD0teLuPdV6TSK
 y59DokVRddnYyrsryZUyg90HnSR7e7T/p+kY7P/rFWRrQmF+LMGxhnHYJ4hS7IHjz8gf
 /Fhw==
X-Gm-Message-State: AOJu0YyoMpGRvo2EjoC9Qh1WlEnMF0/NJl+3rknbXZGr1xoxyQabC5Nb
 pAl4e3aSb7rDHOHI8Zk9gHC7jONtU2vOwJYVdaGlDo2HswyGOF+oE74n2I4m9CI=
X-Gm-Gg: ASbGncviEQaH9thJHvlhgJctdCjy0/LgCR9IwkIONl1PqIWBGE/ryHNiuvqquLOjriv
 AXhqjbcAUdNihWPs+xOxCPM1v1FbPDSDMQwc7eY8RWlenrLGULSXb1kTDqloxUSfIsAyYNbUtv5
 QsUBpA/qI40D6fANHCU8idPPsv/Bjeih3epgofsI/5UOPsWljH2I7dYdVIwj+ML6C19RjwIgxpS
 9cRAWRF4mBfnfGtF1FEmnDLYO3xD+WAEs4mYIGPy/2mNKn9azJx5C/pCAm6MIv53kZVlO00iaeD
 8RhkZnziKyAv0/cmjCeElNnHoB1DP6r928Zk/pWjm/ZUprxcp1MI6aPgkv4khaByos8kLFd62Y6
 riiqv
X-Google-Smtp-Source: AGHT+IFakhvvkf3Gaj8+c5reXeMznJVXbDc+9vubpgbbOuOVzT/+pXwk7Lmd5eSYfIqM7GEU/eY8vw==
X-Received: by 2002:a05:6830:3689:b0:72b:946e:ccc7 with SMTP id
 46e09a7af769-72c4c85db83mr1494370a34.0.1743042267738; 
 Wed, 26 Mar 2025 19:24:27 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c0abba258sm2558974a34.23.2025.03.26.19.24.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Mar 2025 19:24:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: xypron.glpk@gmx.de, Anton.Antonov@arm.com, sughosh.ganu@linaro.org, 
 tobias@waldekranz.com, pbrobinson@gmail.com
In-Reply-To: <20250326145850.918186-1-ilias.apalodimas@linaro.org>
References: <20250326145850.918186-1-ilias.apalodimas@linaro.org>
Subject: Re: Pull request for efi-next-26032025
Message-Id: <174304226609.589015.7831324620770173561.b4-ty@konsulko.com>
Date: Wed, 26 Mar 2025 20:24:26 -0600
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

On Wed, 26 Mar 2025 16:58:50 +0200, Ilias Apalodimas wrote:

> An interesting series that allows us to boot installers and live images from EFI, without any
> distro-specific quirks.
> 
> The following changes since commit 042c8f0cb1ea5f6988e8633799f7b550876f0ae6:
> 
>   Merge tag 'u-boot-imx-next-20250325' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx into next (2025-03-25 08:57:38 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


