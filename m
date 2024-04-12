Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34502C4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 02:13:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17F7988216;
	Fri, 12 Apr 2024 04:12:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YX6m/rcY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B86C38820E; Fri, 12 Apr 2024 04:12:44 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAF0C87F77
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 04:12:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-78d5751901bso31325185a.1
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 19:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712887961; x=1713492761; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k0PlbQXwVjlqV05MucI7ecNC4GCc/A/CgzBtvi+Q+c4=;
 b=YX6m/rcYCOC4iQEa5+L5Zz65rDyr6ZqvzwYKglxHXoblC45e7CRGPAcuwR0WVOR3/s
 fk+cPeJOx82cyXoLnG6nPWhoPcSMTh25KiEhKvj27dWlS7bJFtNI3LL9uVN5KVVe7BcS
 YgbGx+sdYmT+Sns7f7f0XxQYgeGXlhXGKX+ic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712887961; x=1713492761;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k0PlbQXwVjlqV05MucI7ecNC4GCc/A/CgzBtvi+Q+c4=;
 b=Cea0IXrCXhAidZp1j0nkVevrmOQtqzmDr5OCD/XCpIk4gv1RK+FlfFvzhzhxTx5b9I
 8kXWZ19lI7an2iiHSqxb2aN4JouKD7AtmyRmpnFQ8EFsf59H7wfPKZqBHEGD0JcgJFf5
 aQiQkt7+tAG9ncihncBhu+7BZme5r/DQH2S8C2XZVqNTZPGQmQ5ipZnYakW6+aKH8qwE
 Cq/kGu8il3e2f2UkI4OjwYMwxJiak5t/obgJZScHkSOSWrupJXEBEgsM/Bz8kLNgGRU4
 JrtiziHYrH7xSfYTJYgeMjAhmwSro3XjkbBetUeRTD6NnYySMrSOn/vT6CcQtIsq3Ga+
 1H9Q==
X-Gm-Message-State: AOJu0YxhPPHV/RN/7tg99RjqcHfgAz1qu1DIw90XOS4Kena9RlgemqDp
 owvzLABZdVtViVLCKT0k340fzflV/h0DL/PBR9aUTrwxqICps6OIbQmUMOKcG9I=
X-Google-Smtp-Source: AGHT+IFAHlpKze1eOniaB8IrL8LdQW5xoFjc0dS7ZIVb+0NaMtLpwge3VV8ORN12vvnmRABjALiziQ==
X-Received: by 2002:a05:620a:344:b0:78d:73f4:d100 with SMTP id
 t4-20020a05620a034400b0078d73f4d100mr1554396qkm.27.1712887961612; 
 Thu, 11 Apr 2024 19:12:41 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 g13-20020a05620a108d00b0078ec439a9a7sm1348922qkk.62.2024.04.11.19.12.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Apr 2024 19:12:41 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>
Cc: u-boot@lists.denx.de, Vignesh Raghavendra <vigneshr@ti.com>, 
 Andrew Davis <afd@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, 
 Udit Kumar <u-kumar1@ti.com>, Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20240326-b4-upstream-jtag-debug-unlock-v1-1-720d8635a4f4@ti.com>
References: <20240326-b4-upstream-jtag-debug-unlock-v1-1-720d8635a4f4@ti.com>
Subject: Re: [PATCH] binman: ti-secure: Enable debug extension for combined
 boot
Message-Id: <171288796021.897536.3389089210066652359.b4-ty@konsulko.com>
Date: Thu, 11 Apr 2024 20:12:40 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Tue, 26 Mar 2024 13:37:06 +0530, Manorit Chawdhry wrote:

> To debug using jtag, ROM needs to unlock jtag debugging on HS devices
> and it does that looking at this debug extension.
> 
> Add the debug extension and enable it by default.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


