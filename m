Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9DD5C83F1A
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 23:12:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32D8082F8E;
	Tue, 15 Jul 2025 01:12:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Qi1eLSYi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 579BD83043; Tue, 15 Jul 2025 01:12:08 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4ECDB83013
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 01:12:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-6120049f09fso2334243eaf.2
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 16:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752534725; x=1753139525; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OFZJmkvZ4zi1OJBPFdQNblQ7zHQ5HEmIUcxVbO8SYWo=;
 b=Qi1eLSYiqKAdHMltmHcY6xbry1vK+HQHFD1WWoOlivyzQgP9nQ0hP5NRrT5fNQsOMS
 YM1QstcwugzzII4yvLljgSGUW4QaO+ouqOxKf9D4/ZmZR2N6IlVskHsBCYqVduN5FE71
 8Jb/k3Zbq6Vf5AihaK9dEs/nPcoestqS3bncM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534725; x=1753139525;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OFZJmkvZ4zi1OJBPFdQNblQ7zHQ5HEmIUcxVbO8SYWo=;
 b=iACOPr8JpWXIEnzUk9aawqJD4vKeCQHXWCQdhlQQ8joKJ+a/hF0qH4PEqoFNMP89sV
 AadH6JVEahf/fiBhzQP2gHhRZ+kI6Wz0rJYWqIDGJXAV0Nteu1tCGmfMCHnB+aj2OykD
 ux5v/Lmz6cm5lilpboaUcdM4qbm5MaaTCUFcLl6kONbNVIpKRAsHzqc5lbB8rFZIk8NZ
 vKjRZVaz1PErtbbYAiovWuthTvyOw8iTDlMo0/Mya901RwACm5+o8qdAevf54W3r0yBm
 Ua3oVhgMCY0do67UujNVI8gQOzqzS6ZN4EWJBy2y85D2YeuOXphEHelX8Ao4fxcof+0a
 xHjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4KpFVotsSK4yj0XNg+ivPUPy5UfVeGBr3IE++TgrjUeBbUFepSatiL11ItzYcZyvacDCJZZY=@lists.denx.de
X-Gm-Message-State: AOJu0YxNWor3RtYLabngtGqFzDcU3NKgeBGPVFBLSFGya692uu6gfqtz
 vhkHecvHPoo/fD9LONgz+oP4X4ozlKIoumN0SbrTR5/yCyYGDRbll4QSN3CVEcer/jg=
X-Gm-Gg: ASbGncve94ALhwHwSRfEdoehDv1m+v8kYzQPTx64eXK0H5m+lxq6xSmXcQKY22tW+TM
 RU4ws4WBL11D9QDGTEJtyMwqRsCIxnIrdaepxWWfiFJ1O1I6agn1QQfDUqtM0wvPLFI+ZDyQXJL
 rlgCg6EkAD0XwPRFgGYqsG8820XdYG/jDb/7F/JmVJBL3t2xcmq1PPq77ufQ6UXaKQ2RqoB/iMs
 Q6YZ7uJB80bEMV9/Ln9iaozrUFVoL5P+uJ+2V74arH4qc2FVXU3k+4JCZSo8fzUHkwthjxqZHq+
 4eEDWfve3aMyW3E0KYbglZmYUI/cp6wKwXBvZ+BipOOY2lpSHqGfWxMcYJTOv+gAoB2dMpFigrE
 +7okBNzgJZ6pTGl3eNCElChgbCa/UvwrjTq3baTUtDVkpj+7HhVoNEhs=
X-Google-Smtp-Source: AGHT+IG+4S+e6qbE8sO57SJi6pvapFhniyCqB3WDZWD8R+ZPzqoM3sx3pH2zGCHa0X5as92tItcwWQ==
X-Received: by 2002:a05:6870:a103:b0:2d4:ce45:6983 with SMTP id
 586e51a60fabf-2ff26ea52e9mr10134252fac.10.1752534724992; 
 Mon, 14 Jul 2025 16:12:04 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf108af60sm1729410a34.21.2025.07.14.16.12.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:12:04 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Maks Mishin <maks.mishinfz@gmail.com>, u-boot@lists.denx.de
In-Reply-To: <20250707112803.103895-1-ilias.apalodimas@linaro.org>
References: <20250707112803.103895-1-ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] tools: ublimage: Make ublimage_check_params() static
Message-Id: <175253472422.280771.258203803997930390.b4-ty@konsulko.com>
Date: Mon, 14 Jul 2025 17:12:04 -0600
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

On Mon, 07 Jul 2025 14:28:01 +0300, Ilias Apalodimas wrote:

> This functions is only used locally and triggers a warning when
> compiling with -Wmissing-prototypes. Mark it as static.
> 
> 

Applied to u-boot/master, thanks!

[1/1] tools: ublimage: Make ublimage_check_params() static
      commit: d2a5bb2104cd34497cfd36d06c02487813d9a3b5
-- 
Tom


