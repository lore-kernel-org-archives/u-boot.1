Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 286B6C87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 01:29:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 370D783A48;
	Tue,  5 Aug 2025 03:29:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rczsMJW/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2A7E83A8E; Tue,  5 Aug 2025 03:29:33 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8466833ED
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 03:29:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3e3d7b135c2so63349295ab.1
 for <u-boot@lists.denx.de>; Mon, 04 Aug 2025 18:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754357370; x=1754962170; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UNNnbzcPCUIk3IpNMZoiaECX351v3OoZbj+giIe47q4=;
 b=rczsMJW/LtuOBfzyMB6j9iYIugvDh7phlM0qrsnFYvafPmO4feIacP7GATmBI0uZhT
 dx5C/oGMVMHtMgzuGFV37Hpaly/xveoHGpqnsVQwgthDLHsT5MJnw8sEXAnkASSUHu5w
 Of8SqWFBX9JeJQkLjq+1ClTALpF0lQ8zp2Z3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754357370; x=1754962170;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UNNnbzcPCUIk3IpNMZoiaECX351v3OoZbj+giIe47q4=;
 b=qAAT+cqhSOCHcLw6xJZApKDkpOPbMR8DhY91qf3um04x1J7NUWT6/ijis7/At6dL4E
 Resvpi+c0z4A48J7aAc/hxmZMY2UO5DvSWbZ0W560xa50YZXzP7Y048cWAHe/4G3aaaj
 22qYVIsCYj6JxQvnpU/COjlsBhgpkmgkjX2KqW//ceNXU222slAkrW8VORvckdgJ+QZW
 U0ALVUYTP3pJGj9elW4j7x7bYKP+NMOr5cukUvaBEJt+ZJizysbFeDYFK1IptyjZa/dy
 QcJvRfkLvpfvwr94CeFxE/nRBNAaZX+iiCmxdHo50uNUjWayWTdxXbAMYCs826nwtMFx
 sncw==
X-Gm-Message-State: AOJu0YwsCWFBF2BcghNoSIC2R2Rj/IG9sPbJiZ1HFzUjEElg6j8LaWDt
 b5jNlnnqWkmFXA8HxS5Jqk2251iO5cMjjulXeg8eBywpao4Grqk0X2HHIcCbvBWa3wY=
X-Gm-Gg: ASbGncto2SYqNU2n+vIn/f+gaNJ+MUldKVuO23TijkdsEUuJLNAoGs9MJuIdvWNZwfg
 dV74q60gn5OtD7b7TZbEk5BIwLNmbLWzVkSoSXKTqsFL/1NKiAbxGe+MdgjEdaqv55C+pFDYsxt
 yR50uCQ043XbFlsMTF6Ms20X0Ef6rgul1e/f+6HaQnVpW1f0OyX/dw2dVCgJhH9YgkE4zquWMev
 aKsc8ANUoWZqIjUYBk6HL8bCN8biF3RXm1oCw8bHogeQdewZdYsKnw7rdjILWd6lCGfB3LNrxBI
 g18iDyORfCtCGP9XGAL4QIBGVz9wlP9hHnmfx7bKSmM0NQHet0P85CbQZ+y98yr681pJqttR4fk
 XVyTgl38c+H3qaKuQt+yZ67ViWw8/sRYknHFt7nxFjlz8IFKXWXoR4o4=
X-Google-Smtp-Source: AGHT+IFeOWdvJWB2vZ8AUB1gvZLzaH+1BUROQ9IrehL269lzDCWlE3emz5MtBhhAZ4Moek9abeaE4w==
X-Received: by 2002:a05:6e02:3d81:b0:3e5:126a:d9e2 with SMTP id
 e9e14a558f8ab-3e5126adac4mr11762025ab.15.1754357370355; 
 Mon, 04 Aug 2025 18:29:30 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50aae78b8cbsm539506173.21.2025.08.04.18.29.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 18:29:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, git@xilinx.com, Michal Simek <michal.simek@amd.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>
In-Reply-To: <4aeb0244949ec18393e8b8d322f8a1809462f3ab.1753773172.git.michal.simek@amd.com>
References: <4aeb0244949ec18393e8b8d322f8a1809462f3ab.1753773172.git.michal.simek@amd.com>
Subject: Re: [PATCH] cmd: bdinfo: Fix showing correct IP address based on
 current device
Message-Id: <175435736919.1435425.5872363383331020845.b4-ty@konsulko.com>
Date: Mon, 04 Aug 2025 19:29:29 -0600
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

On Tue, 29 Jul 2025 09:12:54 +0200, Michal Simek wrote:

> Use the same logic as is used for MAC address where bdi shows mac address
> for current device where index (idx) is used to point to correct IP address
> which is read and show.
> 
> 

Applied to u-boot/master, thanks!

[1/1] cmd: bdinfo: Fix showing correct IP address based on current device
      commit: fcac9bfbbd20216ecf6a79c2fa239bda1bff77ef
-- 
Tom


