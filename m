Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C78B8C3ABB6
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 23:36:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5A3A82998;
	Tue,  6 May 2025 01:35:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RcpIWItN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFE0A82A4B; Tue,  6 May 2025 01:35:38 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 590318295C
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 01:35:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-606477d77easo3000822eaf.1
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 16:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746488135; x=1747092935; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8hEVzN1HHgLknsnGwluHBW8righj45nMFAZ84aa3eNw=;
 b=RcpIWItNqD6dXMWfxJE5C5QIxUGVfHkgMGnMTUMpUgQR+ChERNiwf5ef5gbiwUm38h
 VnnkEfKajhq1lC56OnPXbG0EXJoRzLiliR6Gj1rnKhbsc69h4peC9IjJd/2DMFoUYhC+
 yNVhve/6mEqrJYsJ6X23gMaqbgEPBMJngDaaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746488135; x=1747092935;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8hEVzN1HHgLknsnGwluHBW8righj45nMFAZ84aa3eNw=;
 b=hbLb7/B5VWFGYHyzdVbyLJWEknZLYXq/fYg7p/llKANliburbn02MLIiTdEYj50cSj
 N7W8cV91ne+3HCmqOZ88MohsHqigPouQH24vO+jGB2iigvux640XCydC85801o57xQcU
 Hf8Sb6K0V+C4gMqAHNGm36aZ4sWU3IQ9d4luaFEaKnp84vyyeJuGlOTJB55tYhQrRwEY
 D6IVOGVFVDV7JzJHmjjsebC8vOuy3l3QN7xxPz37ezbn7/S6sGPMIMfUbVnCDkXc4Mlz
 AfuI7dSvKlB7cnZU9e1sz2WdO8WVmnSkKBzojObbNLmSeCgUqGcTh+WzcK2OaI6pCLik
 ODhQ==
X-Gm-Message-State: AOJu0YzP4ittVdIgsKJmWkBVthgx6SxVQA7DeRQl11Q5UwqGUJrorB3w
 R0Pwrnd+Cr2SvBdFLNae+BbgIu6x/QyaHc2iA9BtgnyEyjlMmAT6vEV563RIezA=
X-Gm-Gg: ASbGncuqB708xHRcQ63kUKrv9mpCV8dLsbjPzO882kgVHEbJHLCyq/RXNR5Fx5d9OT/
 iwGhNEccEmezYuPTOXAZB/XAKAIAh6jJlZrGY1nLf3DrIPa4sj+8NIne9lxdU6XIkMIsBj92/hx
 9pAMrgydq9w/FWystASNhEOg0HA8d+yVYb4WDJQmBLl/lwV1lQ+RP7E+jQp3mpdfmwvxnyfXcxZ
 FGr1CuzNvi+9Hgdiss/xZwdimkLht3pf/5L81UbGMok62zQ6PEeGnaLCoayaJ31gjoR0XkS4LS7
 cEwLHPtYtEWMwGC5e0ZN84dTNDYroSRv6eCRsRN9YAdVYuBrwVncmtpY9pCoH1xm/ERChcPaBgr
 I
X-Google-Smtp-Source: AGHT+IFM8zuaSpDLyTJcyrmBMVKZ1jtkHBuLxy7Qkq5Fz5ge2ThnU2urrAIC6GOuYVvKgSATgEvmRw==
X-Received: by 2002:a4a:a544:0:b0:604:ac85:abe2 with SMTP id
 006d021491bc7-6081d9f3c0fmr905139eaf.3.1746488135133; 
 Mon, 05 May 2025 16:35:35 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-607e7fe85a4sm1913408eaf.39.2025.05.05.16.35.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 16:35:34 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Udit Kumar <u-kumar1@ti.com>
Cc: nm@ti.com, d-gole@ti.com, n-francis@ti.com, vigneshr@ti.com, 
 m-chawdhry@ti.com, ilias.apalodimas@linaro.org, c-vankar@ti.com
In-Reply-To: <20250429171440.2524557-1-u-kumar1@ti.com>
References: <20250429171440.2524557-1-u-kumar1@ti.com>
Subject: Re: [PATCH v2] firmware: ti_sci: Add Initialization of dev_info
 head node
Message-Id: <174648813382.69658.11353457032435322704.b4-ty@konsulko.com>
Date: Mon, 05 May 2025 17:35:33 -0600
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

On Tue, 29 Apr 2025 22:44:40 +0530, Udit Kumar wrote:

> On K3 devices two drivers ti_sci and ti_sci_dm are supporting firmware
> functions. At run time one of driver is used.
> 
> Driver ti_sci already initializing head for dev_list in its probe
> function, but it was missed in ti_sci_dm driver.
> 
> So add head list init support for ti_sci_dm driver.
> While at this, move init of list before usages in both functions.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] firmware: ti_sci: Add Initialization of dev_info head node
      commit: 1c26f91a224b7ce222314b38c068acd1833599f4
-- 
Tom


