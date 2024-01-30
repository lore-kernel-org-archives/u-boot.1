Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A91ACC46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 04:37:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA68C87D03;
	Tue, 30 Jan 2024 05:37:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BQyAADMN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23F0B87CE2; Tue, 30 Jan 2024 05:37:39 +0100 (CET)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C70B287BDB
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 05:37:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-42adb5f806fso804061cf.3
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 20:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706589455; x=1707194255; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pJR9U6bwbOKWyNQMXtV2WXmVduOabGrskV9I1XCSdrA=;
 b=BQyAADMN/TYoWuaHZHvs/WR6RoKmE6sQIfPJCR+dUG/7b19s4YfClJhbHIwDERC84x
 CjRIj7vBzA2mq/FMQEddIR8IQl8FwnaawavYLc2azyzYEazvapgkSk0+zss+N/GJfBeM
 Eo6Sxj90JQsahCEGUgocw2Ne7EySj0yVy7iQ9HBgAsow6+0EAnay5BxJnvaHj8oo8T5A
 cxRM2oKBalS5ipPpldcBEZnKogREvWLT2G+0ngYUCnbCuMZ/yQEY7wo4JmpQYExqm/F8
 +I1hj5+qSoN+/nfKiiLFrdbflDRjeL0X2uKhtWi46M3Ny0pzYYRHDktfGJZXLczA4qv5
 eNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706589455; x=1707194255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pJR9U6bwbOKWyNQMXtV2WXmVduOabGrskV9I1XCSdrA=;
 b=ovNohqqFSZVBAri4O2HJnleb4uqLLuqWCfklLnJVQLsS3cjjNUJClT1BNzOwy0e1hm
 M6pJoK2onTrDakvVugOLiTcgg/kGCV9LH6eJ/Z4oeBrFeHKHxsI2FzZ5pA1PjAJ1KJiD
 EyQNsE42qjlrhEZy9kcgMu/QJgIeLH3i6V/kJ0Os3Apo82FAEcV8rP3O5kgiGV2Ec7/Q
 3cbomo+yyBPDccIctXnDfvKpfY3szKI+3D+MgVg1HQ4CXm7UFtSfI0lyvvjdFGRS3AbZ
 D/6r2GUm/9OUN4Y2zCAQFN9DHwFOe5Zgsud1sD82oHmnOG2KTuz1bXilFngqxS7w/uC+
 xrLw==
X-Gm-Message-State: AOJu0Yx6YaYepgcwLj9YKM7t/PwxdOsmbrTzoOBXvUtT5Pq0r8HSFgC/
 c1ehwyOGj8G7n4v4DVPr0qLsQuSt9XYYNhAARpPY6+1I0bf/GLEh
X-Google-Smtp-Source: AGHT+IERvAhsbJ0dQBPiYXZYK/f1zi/xf0ut21N/hu7n1Cn3XWXKpvIYYG0EuR5bymG58mxGcRr6cw==
X-Received: by 2002:ac8:5a53:0:b0:42a:7e99:4a9 with SMTP id
 o19-20020ac85a53000000b0042a7e9904a9mr9281529qta.7.1706589455566; 
 Mon, 29 Jan 2024 20:37:35 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 cj16-20020a05622a259000b0042a8e9d27b2sm3193290qtb.0.2024.01.29.20.37.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jan 2024 20:37:35 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: Lukasz Majewski <lukma@denx.de>, marek.vasut+renesas@mailbox.org,
 clamor95@gmail.com
Cc: Sean Anderson <seanga2@gmail.com>,
	u-boot@lists.denx.de
Subject: Re: [PATCH v3 0/1] Fix clk-gpio driver
Date: Mon, 29 Jan 2024 23:37:30 -0500
Message-Id: <170658777077.694990.1517631053895008087.b4-ty@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240110160956.4476-1-clamor95@gmail.com>
References: <20240110160956.4476-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

On Wed, 10 Jan 2024 18:09:55 +0200, Svyatoslav Ryhel wrote:
> Existing gpio-gate-clock driver acts like a simple GPIO switch without any
> effect on gated clock. Add actual clock actions into enable/disable ops and
> implement get_rate op by passing gated clock if it is enabled.
> 
> Testing current driver implementation shows that it is not fully capable
> and lacks gated clock manipulations.
> 
> [...]

Applied, thanks!

[1/1] clk: clk-gpio: add actual gated clock
      https://source.denx.de/u-boot/custodians/u-boot-clk/-/commit/a8dc4965f09d

Best regards,
-- 
Sean Anderson <seanga2@gmail.com>
