Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6626FC83F17
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 23:13:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BA6B830B5;
	Tue, 15 Jul 2025 01:12:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="b1ML/yAn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3EF3830F6; Tue, 15 Jul 2025 01:12:13 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCFA08300B
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 01:12:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-2ebb468cbb4so4300692fac.2
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 16:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752534730; x=1753139530; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bPnu+azeGz6QbLduiUZKRN3ErsVmSfYjvfODhGetkiE=;
 b=b1ML/yAnXMAcnDrFmox2bCdGAcZRec7yk0ZTMfFc1+edjCiQJF7uAZjCxo10nby+qQ
 SHYSoDn7azxrKjaQz6mmxE1Q1aLN8SnQsi+9Gl/nxZIQAKmp5FnfG9e1SJOWjN06dJlp
 e5TZTv3Hx18LbJ66KKuojHAVPpj17DM+j9fU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534730; x=1753139530;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bPnu+azeGz6QbLduiUZKRN3ErsVmSfYjvfODhGetkiE=;
 b=osG96KImrEqz+pybEvqGb1px3JLO/+QDaxNhaVGWnJuDjmqmi7DCAMFj0ZYzSeb9ez
 uFmfF4sC85Gflgp40+JUDqlyFzPP7cwPnuVO4+DOAuW896zdZ+qFZ0ydTMR3QikSDxJa
 c0h4awQXdUoQvMaVpc7aP07mMEDNt1tOhktpF2gmWK72bMQHwZI/5aiTX167rgRauoBn
 aaX3XVFnYEq/t87aqFJd49dif/6V/Kb4eBkEAz5HiCrceBzMdFgTRdbSBWcqCoAiqQJR
 qjskxO5gmgSwTt/UegxVfsrrmKzvpTU2B/k4S6RsbjRed8zeYo+xpeb6BUCZGkKpgdBU
 Uf0g==
X-Gm-Message-State: AOJu0YxiZvn5bNC3O0l9iUD8DHOz8JuhPMvIoV+wCBQ7NaBZKu0obQkU
 XIQOf7OdMukxCkasJqmv9EwGoxo8em3UgUOmPA1dMbhJQUf3XIkto2blEQ1oTeRKv9ZZiimxiap
 /r6sEndw=
X-Gm-Gg: ASbGncsBxaMvoLuKf3WvIvsn81zlFbSeWJb2qvLRpKITEb9Odma2/bE5QzdaCB8R21i
 BYDjamOdeQYGYTe2Py3Ynd1MU+9rs1TeKRa0R6E4lNt2GMcWtFd628IyulBV9d3FcfcSdzUhAN3
 WkkZ3BAdoIX7GXzFiAtbX/ALjQPv2WzstopbKrlimTq1r2qnTQAFwGNCoH5bkuaJoljiRRnG7OV
 xwK23vfCU6jUyrnQzuwinpuB9PfDWiGUWXRYdYS/hc68dxQ3cxeiCPSqsgneT8w0Ld5Dj5Gj0Ne
 9MeAyI4SNJviYi6F3lDdRDuEmzgRmBKTmCSNw9wLpbiT0ujoidFMrBJFhpzMgG8xB+gKHRqgWa3
 yTCwYmGMFd4GPxb59ck7GzDrJa2Mwt235o+Ryu9vPopvrsbSU+7FNDD8=
X-Google-Smtp-Source: AGHT+IEu9bNQ8FaopLe01E+/TalezMckqgecg8xPjkOmDa6MgdICTMP9Cxfak2Kl2sTUwapyOy22JQ==
X-Received: by 2002:a05:6870:1191:b0:2c1:44a9:fc16 with SMTP id
 586e51a60fabf-2ff271b1a58mr7617180fac.38.1752534730471; 
 Mon, 14 Jul 2025 16:12:10 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf108af60sm1729410a34.21.2025.07.14.16.12.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:12:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, David Zang <davidzangcs@gmail.com>
In-Reply-To: <20250707002201.62932-1-davidzangcs@gmail.com>
References: <20250707002201.62932-1-davidzangcs@gmail.com>
Subject: Re: [PATCH] Fix autoboot countdown printing wrong
Message-Id: <175253472974.280771.3738510642595969013.b4-ty@konsulko.com>
Date: Mon, 14 Jul 2025 17:12:09 -0600
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

On Sun, 06 Jul 2025 19:22:01 -0500, David Zang wrote:

> Originally when bootdelay >99, the countdown breaks. Setting bootdelay
> at 101 or bigger will trigger this error.
> 
> 

Applied to u-boot/master, thanks!

[1/1] Fix autoboot countdown printing wrong
      commit: 5f70be08b015a5dc2296ea0073ecc8165fc48588
-- 
Tom


