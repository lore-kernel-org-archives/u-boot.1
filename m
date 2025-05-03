Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E7CC369C2
	for <u-boot@archiver.kernel.org>; Sat,  3 May 2025 16:31:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAA308272A;
	Sat,  3 May 2025 18:31:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cxwKcaw3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB4A482937; Sat,  3 May 2025 18:31:36 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDCFE82836
 for <u-boot@lists.denx.de>; Sat,  3 May 2025 18:31:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-72bceb93f2fso2480909a34.0
 for <u-boot@lists.denx.de>; Sat, 03 May 2025 09:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746289893; x=1746894693; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vKfdsr/2E45Ldv00EXNLuHcgXJjcheyfNwQvW53Nh2g=;
 b=cxwKcaw3gAnzOF3UfTszkI3woJK2pKuCL3huVEw0KmEZG3ifg5Hm9TPXA1idAi1V0u
 zvKxXLzq9FwbnTCAcmu/ZX3T6XPlowAH5GyewU3v8hKlPkb73RTi2gFLeSFNSZzDEL3l
 eq8dXe54iSGyqwmD2vzRMy2fPO+waHRcxv3A4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746289893; x=1746894693;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vKfdsr/2E45Ldv00EXNLuHcgXJjcheyfNwQvW53Nh2g=;
 b=tCTZqwZhkdW/ixjDEkH1R68dARkui53+MoXUcmTxN4wFK1kB8hqpvi7/LCbAUANNdt
 MhBKK0tAKWHih/a0a4yKBSobWpjQiu4+xoCT3v90KYZHHF9GWD8thv2qMZ3C4xVPy9vv
 lJEGZJ63nlDwzHO0LYA0hLxoLwFVP+qVHuk0r1mNGGjWufU84aChmd//hg7HiI83SPb9
 x+y3IMzCrCak1HFHxli0skSIMSMZvMsSv8fdkvT64IvdpT9Xf4DSYGAteKu7wuN55U6A
 XKAP/ekV9ocpJIDqWOcaIEBq4CF5E4K2/r2WDBR3EzfqKbQshM8PtsrobJWRERL0wE1M
 Wlxw==
X-Gm-Message-State: AOJu0YygwTngurXmlhD0p9AYNHU1cwjpQnP3Vopgo+o1fMgBtPEHMskc
 SZ3rH6ExdN+EMlZne7R+K7kO+m/VBCvfAdVnDFRSGYlVmo0QQSYO3RumtaZ62nA=
X-Gm-Gg: ASbGnctwmOdxM6DgGuMlKa9S7s7vU9GFc6eShXAKBuqejpai8NiJvMqkfdQwz0VyWBX
 zfSNl5bRG9c84AzeQyTjNHbwRzAu1uvl+dIdAJ4ol2NJnQLWMjaKoS7pSqk+n1IINOzbc8XbWu2
 HQ/FLD+7TJDxWfNT6dfv7huvgejfl0bJYJA0ANGyj2kFvzCk8ZrhjILK11Lg795cpyVg+9IWkxw
 Ww8SkkHznuDkjlCC2vNLDWTcXKklu30ywpB17SLqtGClz024xXEL4x8k2oTH7ZXgsuEeyW9dvm1
 dFtiqndOH8K5zixtJmciDLc0FLplXtHFAnI36t5HQIKG3GhNtfEDX3ifMH6KEQgkXLSzO6H2mPC
 5
X-Google-Smtp-Source: AGHT+IGiQ9rKTMKlTWYgHB5OylaCvnGGqoNdYgbRKouPLWeZJ/3YIHaFFwQk2sjAxleTzCmTvP56DA==
X-Received: by 2002:a05:6808:f0a:b0:3fe:b27d:2681 with SMTP id
 5614622812f47-40336019653mr5981963b6e.6.1746289893530; 
 Sat, 03 May 2025 09:31:33 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-607e7db25f5sm970991eaf.17.2025.05.03.09.31.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 09:31:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Neha Malcom Francis <n-francis@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, 
 Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250425225403.861034-1-afd@ti.com>
References: <20250425225403.861034-1-afd@ti.com>
Subject: Re: [PATCH] arm: dts: k3: binman: Fix DM firmware selection
Message-Id: <174628989206.1571566.16568662878783123246.b4-ty@konsulko.com>
Date: Sat, 03 May 2025 10:31:32 -0600
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

On Fri, 25 Apr 2025 17:54:03 -0500, Andrew Davis wrote:

> Just like TF-A and OP-TEE, the documentation states a custom path for DM
> can be provided at build time by setting TI_DM. This should then set
> ti-dm-path which updates ti-dm node filenames in binman.
> 
> Two issues prevent this from functioning for most K3 boards. One is when
> then DM firmware name is inside a blob-ext node instead of a ti-dm node.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] arm: dts: k3: binman: Fix DM firmware selection
      commit: c492a55fe40cb9d86b0e99c160e21e5f8f4edcdc
-- 
Tom


