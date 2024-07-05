Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4119FC3271E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 01:05:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 713018851C;
	Fri,  5 Jul 2024 03:05:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=bade.nz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=bade.nz header.i=@bade.nz header.b="gRITvi5p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A2BD8851C; Fri,  5 Jul 2024 03:05:48 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC0738892E
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 03:05:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=bade.nz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=leith@leithalweapon.geek.nz
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5c47b8c662aso542082eaf.1
 for <u-boot@lists.denx.de>; Thu, 04 Jul 2024 18:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bade.nz; s=google; t=1720141542; x=1720746342; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=9svVTZYYKihYln/y+0tFCqoy2MkTGyiqk2xKxdlVNoc=;
 b=gRITvi5pGcuVVVS34kZJBkxJfiLiR+JbIFll6s5jEPLowrpCGEfCZEsA1gSfTmj771
 HhDAvEfPkgnYwXre3w/zoQEee0g0SoElLpzue+Fyik8nRtVYnaMMIbb7d9adKF8QpmWQ
 IPvXV+FqeOPDEjdOX87vP40ZboAonzYDhOxAJUQJdEfYr5k86tNmYTWDqe+SiM1z0vnB
 XJvFbyw9oVqjDKvPJhD5OvR9gvuO2fyO79Fph/sZpvoyqtJ6xPTn6+piBSVUfO5pswDv
 yul570sZn6C3loQOiBDAIgiB7sdn3ZsLoHUmK/TLnRm8AMrDAKdiPbglekfRXHjGLdA2
 28Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720141542; x=1720746342;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9svVTZYYKihYln/y+0tFCqoy2MkTGyiqk2xKxdlVNoc=;
 b=Z1LLfBFr+dvskmGMHgWOpica9sHK8qr00NocDibnXTi9KHA84eRDExBIm+rIZXKRLY
 AvgpNoK7npqX4viwaxlWBP0hMbE/gDuaso3LirKxwfmZhCRtz+GI5D25+8srci7YmdFv
 r0tKncJL3vjLdrs+Pq6lWnBNJF+UdvDuikbF7Xz21Aga4mlGfk+PJIptrO93WYBqbUSz
 K1yxovDa+Bfga8tCBjjvldJYWrAtzaqa0OvfLJobIHGL7IEYo0ZSwxuDJ51N5hl92Cgu
 damVhWj0rfpNk9DH7yKv2mBioO3EMYTsuCyq11MrMRbfkeLhDxuZ3rfLbuva2xmqzASF
 Kb1A==
X-Gm-Message-State: AOJu0Yx/qPOjIst9jo1XvoJ4KJZeVHsOpywmhp/WtWha02Mzc1qoxFGK
 We+ggs0qYE08lNt/X8+03OsUkHEJ6opkDte9RJDuiXnPWTSgPxROYgUZK87jMlvzcV5RACY3bnh
 7+lmWh57Cx7oIaP1vekHHFISmfdq0AHzTNUHc5PIxnK3QevDAySzFJKE=
X-Google-Smtp-Source: AGHT+IGYiIhZqjKi/L0VF3ZQo1Oe7iJeG4XBgYzP+AjxqY8Alv/yHmEIVJhOlcJQPaAQUYXNgbIodfilDYgDNkIytSQ=
X-Received: by 2002:a4a:5509:0:b0:5c4:7aea:5160 with SMTP id
 006d021491bc7-5c646e41c0amr3727194eaf.2.1720141542205; Thu, 04 Jul 2024
 18:05:42 -0700 (PDT)
MIME-Version: 1.0
From: Leith Bade <leith@bade.nz>
Date: Fri, 5 Jul 2024 11:05:31 +1000
Message-ID: <CAPDEroVSDDqQwqGCn__V6TkAP-WH1uiezLeW6dW+uW7EkNnbYg@mail.gmail.com>
Subject: Missing eth1addr for Banana Pi BPI-R3
To: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi,

I have been investigating how to stop the MAC addresses on my Banana
Pi BPI-R3 from changing on every boot.

It appears the ethaddr and eth1addr environment variables are used for
this purpose as they are randomly generated on first boot, then become
fixed after being saved to the environment storage.

However on my BPI-R3 I only see ethaddr which corresponds to the
MT7530 switch device. There is no eth1addr for the other Ethernet
device which is the SFP port. Thus Linux keeps generating a new MAC
address for the SFP port.

How do I get U-boot to generate eth1addr and assign a permanent MAC
address to the SFP port?

Thanks,
Leith Bade
leith@bade.nz
