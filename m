Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD71C83F17
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 00:39:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F125D836D1;
	Fri, 11 Jul 2025 02:39:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Dr+Y7T0o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC7DB836E7; Fri, 11 Jul 2025 02:39:24 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 533AD8341A
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 02:39:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-2f77591f208so675600fac.0
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 17:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752194360; x=1752799160; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ak5SZnRd/iSLuocofJ993ZfEv+gjElrE2jQfooPdsi0=;
 b=Dr+Y7T0o0svVu2eQDpb1dG2taRdx1M7lfWmJhN+Gb8/X8puuq+LXkVvc67UurCZx9j
 /HbBGfzJi4oHaWGD/2Lg32H+PEvKjr1UK7zcZV6XFeLlwFxxZKxt47fBwZhRdGCZA17F
 rJete+cve1DRMfocsFmetr7nU53de2RQonfJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752194360; x=1752799160;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ak5SZnRd/iSLuocofJ993ZfEv+gjElrE2jQfooPdsi0=;
 b=ISnTIpL0rwabww8XVMaZkRQVcDLwte5tXu+naSraxpHY9h8JZUtSoClzeEFVcZMJQn
 gOi/u4uoXIJXgfGm0JIbu1M+TXlMx7Xztl84WZgCJN9fKSBiLpDis0H0V4DJQhHSBdMs
 9T/a9c9Trvf0LGxh2UILNG0MYLvSHUi4FOcrkNheWeWlKN19ROLPo/eCRXdlUvPtTp0t
 1b5873aT9mz8h4VjZ+8q1JXc0IQ3tern40iOk6xibAcExtQ2qYvF4IIBcEWf7U6Mf1s/
 3VK9A9r2p2vdxsDqqODWgOgy1T5HtQxXQmdBb9AXkVMIIrTSlUDkb8hNC7ljV/2uEPcv
 roJw==
X-Gm-Message-State: AOJu0YztpNNFA20kb36rtnQjM+qMnooNlM4EIhtgvKqpfC6q21gnpB9a
 KmgP7uqmwqDHuUG7zaqaQ6/alVzJ4yKPCB+dbb0P2L02bWHjauN56D5+03uNuZJ7tbI=
X-Gm-Gg: ASbGncuNn0nHnCusHPW1TnpyITq8R4C5wuvaPW41fmBrEXWeLUPUejEaC14vbfXi5LL
 TtEpnvMEWXh6ojm/oH6QDKEZ1xZBcKHEM7ppiaqiHhpNWYrm2f784qMEglQf0zadwukUkBE8wq2
 bNJNqmm743s3aB7Fqn9RPp2J+I/1LjIEMCbPtouVxom2boylqAu3YNuImnbSDBavoedcR69sLFk
 PmgBx8SksHIQjzbHp+rBLq3E9msIMhoQOObGdRcRTOkMX7d7K21q0rNW41zZjzjNMAwhZRj6upg
 3EZi2v5Y24g+4DFE7EMa56OBJmSI8JYm7BDlzAZJiAf3voc40RtelhAh4PVrvuet9cM+wywFB5f
 9GRV7x4fD0DzOSToZcWVRmXDR8Yylvujhzy8FqcZHZAbNaXk+5t5Q+LlbAZPGDZFnfw==
X-Google-Smtp-Source: AGHT+IFqR16qYSJ33ZdzriJbzwK4xMy5vhWm2cih+JJl4zG//0ynX9XNzwF2BQNYOG7K2jhvsyiHuA==
X-Received: by 2002:a05:6870:46a7:b0:2eb:9fe5:d06c with SMTP id
 586e51a60fabf-2ff264081f8mr1146536fac.3.1752194359773; 
 Thu, 10 Jul 2025 17:39:19 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ff111c36a0sm533644fac.2.2025.07.10.17.39.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 17:39:18 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Magnus Damm <damm@opensource.se>
In-Reply-To: <20250710191548.711070-1-marek.vasut+renesas@mailbox.org>
References: <20250710191548.711070-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PULL] u-boot-sh/master
Message-Id: <175219435814.2132824.730390080807064519.b4-ty@konsulko.com>
Date: Thu, 10 Jul 2025 18:39:18 -0600
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

On Thu, 10 Jul 2025 21:13:22 +0200, Marek Vasut wrote:

> - SH Ether clean ups, RZ/A1 clean ups, RZ/A1 Genmai support
> - Gen3 EEPROM DT node clean up
> - V4H SA0 BootROM compatible binman etype, SCIF compatible SREC generation for Gen4
> 
> The following changes since commit 344e1798059ba65769272be3145736685bb25a7e:
> 
>   lmb: add missing fallthrough in lmb_alloc_mem() (2025-07-09 10:39:37 -0600)
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


