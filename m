Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D58C5AD49
	for <u-boot@archiver.kernel.org>; Thu, 29 May 2025 17:57:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84AB182E8E;
	Thu, 29 May 2025 19:57:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mzQvWKeP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31E0E83010; Thu, 29 May 2025 19:57:29 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D053282B34
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 19:57:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-735a8be4ea9so340676a34.0
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 10:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748541445; x=1749146245; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M6txzIUV3YWWMuZCsDvohDu0Rr6wIGA0OxmkfhbVU0o=;
 b=mzQvWKePXRvzh77YcsGJMJDRdsVRtRinZ+sZIkonYsucm2Qty0J1XCASAGsasAYvFd
 GmM6ccAMws4C6fAxLxwD7UzQgptmgMJpBKtY2TuQtkLUVuay93OYR0OE58d87DVGu0M0
 MDl6egbyw47rE9NozbLvOJhY3JcXYQ2Vfm1gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748541445; x=1749146245;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M6txzIUV3YWWMuZCsDvohDu0Rr6wIGA0OxmkfhbVU0o=;
 b=TJcn+Psjzimvi8SIFcutRut1s4r+tYfsVzxo+MaKARrAiG/Qh8LTGLx87+e6uwvm9C
 QviS7mJ4FXt7tpOY5DGMZF/XsTcCqIlnzuq5xWFxBVt7po9gH2CWAyz4R0ti7tuoiJnm
 b6Z4XdBfuaPUsYS6Mib5xTGdYeHPepTOL6qhCPsuHZFQmMAGLwQE31aFn4ASR5Jud+2K
 kqoCj42s+ISURxAgxQb8XrIeCAV6DEjMZu/O1KXRP4HfqJ8Xf/b1SgGpaiDrW/umTA0+
 WBPS9o9oUIj6CtfcXHwK8RMnrxBxlivldK3ed9oADRdIAkFTaC6O8AAXu90iZb8I3DR1
 mQvg==
X-Gm-Message-State: AOJu0YxLdCqQoe4LZSa5Ue49nfidIUc3hTcd9uPAbrD5fWe2uYpVy74P
 hEpUKHw6vYJbPmYWmWGmt2hDt++Imp0hNeH8QCrw1SKP6XC/lH93MGayFmHIVC6hEk2G7F9S5gb
 +8npjof0=
X-Gm-Gg: ASbGncsFd4yJfK/kfpO9n2W1DtIGZ1owJSZgnU3enRWvgC+Vf5s5Y+VTIgfq5OCjH48
 BOQlQkSqkUhEUXqXqHOLqzo5+eIzOC5UOybAqY7INrgKCEt4xmtlCjYLCa6Opn0PXQlhgDo7cVt
 EXmlcEyNn+8ZVOU/MNwBUz+zx0zIsHLC75nAD3aX+M55WLXaweipCxffSArBy7CFbkEVlwxoSG8
 3fzyu2pY6K7EEItFlkYscRQtdlwbRCrvLPTmY9yDDWgM2ReYmVhVoYd4l4C9ZAmQvI3413VsG90
 +xDYNJlm5Oe+ThbUmzLidaU9ZL7B04tyaGzR91560TEAwbeY/MTp6VAIAo7vXt+xWG5M8lxqxU/
 7ooM+Uc2VqTvveGORfCj3Wg==
X-Google-Smtp-Source: AGHT+IEiib5U5jrkKXDSw12tCrJTr1/n1N94jbqYvQqRBF/EZ4JD4xS+1Sq3E0CGhZZw+7T3nYIu9A==
X-Received: by 2002:a05:6830:6f4c:b0:735:af51:5ea5 with SMTP id
 46e09a7af769-73670a64237mr202647a34.22.1748541445586; 
 Thu, 29 May 2025 10:57:25 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-735af9ef2b1sm320085a34.59.2025.05.29.10.57.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 May 2025 10:57:24 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
In-Reply-To: <20250529033008.109416-1-marek.vasut+renesas@mailbox.org>
References: <20250529033008.109416-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PULL] u-boot-sh/master
Message-Id: <174854144467.3918188.488093050233398950.b4-ty@konsulko.com>
Date: Thu, 29 May 2025 11:57:24 -0600
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

On Thu, 29 May 2025 05:29:50 +0200, Marek Vasut wrote:

> The following changes since commit e04d137231f2e9e14708a32448c879125b8e308f:
> 
>   Revert "ext4fs: Fix: Read outside partition error" (2025-05-27 10:09:12 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-sh.git master
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


