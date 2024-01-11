Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC582C47077
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 23:38:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95D738749F;
	Fri, 12 Jan 2024 00:38:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lRcnAZB6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 323A786844; Fri, 12 Jan 2024 00:38:56 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A348386844
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 00:38:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-67f83812a32so25318696d6.3
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 15:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705016332; x=1705621132; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IeX8Rw9OBaMmy7fkgJDzrz8smLfna0SsE8QX1Wf1BNs=;
 b=lRcnAZB6sIziYN+IoM2Gx7l9ZJT/JDL1AD8hHmYVqS2uU2Aa23DugtD290oDyKcfSw
 OS9GsHbYMTCh3hFaoJd3EHq8aroMyeiZv6QRSuc/UUOS49Y19vYalFqbs/lIVl6HcMlX
 /+5kydqR6MKgIqhLZO9X23sRBIlxv6LY9FoKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705016332; x=1705621132;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IeX8Rw9OBaMmy7fkgJDzrz8smLfna0SsE8QX1Wf1BNs=;
 b=EDDsnV6dWWkaNu7Hzi+eO3mtxgogLHrDX9n4mvQ4RdbAHwsvh1XOblfbozq6Sg17GH
 TDFNBV9bK4JHT6CqZGMEUC11ouFCk7PJt8bQDl1dtwLu2ewBCuvYoQ6j70b+wY+KDTQd
 fmj0kig0ACy9BND2E0TGADmsx9oTgJ9g7MMzB2DbZrWUAfHixl2VmXQci/Il9mg1teHD
 f/4/DR7DW0pM2KubylPDPKzLEJrF4mZ2ycWt6cn/yCmT7KBgKQ8N15VL9hOjgBuo5n2H
 ji3whjr2IUnoxpaqMgTNK4+iyQvQRFGj1JqThRJWGUqQ7WmNYfzn8S0RHyaf43PaDKhx
 jb+w==
X-Gm-Message-State: AOJu0YyM5ooTkpbFuvU6Spm30VhUVHzooOTme6sXdoQUctC8s9rjMvSA
 iI5vtwiYWXazQMxhVW5qe10bojH5a+rXfw==
X-Google-Smtp-Source: AGHT+IFB5OyDoyEu0+ozPajII2/CrUmX7XmF+Dt75UNb62MimmESoDu9AA/+iN49bHSDTY/ZAdVGNg==
X-Received: by 2002:a05:6214:4019:b0:680:fdda:cb30 with SMTP id
 kd25-20020a056214401900b00680fddacb30mr19467qvb.63.1705016332320; 
 Thu, 11 Jan 2024 15:38:52 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 ej8-20020ad45a48000000b006810b4fa71fsm644535qvb.136.2024.01.11.15.38.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 15:38:52 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com, 
 sjg@chromium.org, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 bharat.gooty@broadcom.com, rayagonda.kokatanur@broadcom.com
In-Reply-To: <20231226154619.5071-1-maxim.uvarov@linaro.org>
References: <20231226154619.5071-1-maxim.uvarov@linaro.org>
Subject: Re: [PATHv3 0/8] net fixes prior lwip
Message-Id: <170501633138.215467.18369328568485115701.b4-ty@konsulko.com>
Date: Thu, 11 Jan 2024 18:38:51 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
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

On Tue, 26 Dec 2023 21:46:11 +0600, Maxim Uvarov wrote:

> Add small net fixes prior lwip patches.
> 
> v3: - some small review fixes.
> v2: - rebase on the top of master tree with descriptions fixes
>       suggested in review comments.
> Maxim Uvarov (8):
>   test_net: print out net list
>   net/smc911x: fix return from smc911x_send
>   sandbox: eth-raw-os: successful return code is 0
>   driver/net/rtl8139: remove debug print
>   mach-socfpga: do not overlap defines with lwip
>   bcm_ns3: use device specific naming for variables
>   omap3: use device specific naming for mem_init
>   Makefile: add dtbs to clean
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


