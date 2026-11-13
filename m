Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A20606A321
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 00:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0XNsTQ4G;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Ixkcm9WS
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 39A348167A;
	Fri, 13 Nov 2026 00:28:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GUmO5lPIe4oT; Fri, 13 Nov 2026 00:28:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 740A68153E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794529736;
	b=KdCjTVPlekg3kwZgxEe3fKrsWtVq4LGT0iS8jAp8dK/tATgIYxrAGTDoxCUsUK2YGyQp
	 BhQFeQy6JHMcAcckOzQZ0MIR+Lzts3IAwGn4IXkIdU9Ajz4m5j013d1uNh6LJYpAtjEcG
	 0IBmbEAH6wBqcRPAfcxs+tkZw0s2CvAPFnQE60i3sb+1+DZr2mK1RMca25JvfbPdo3QTa
	 nr2a1xxzFZQKE6f6mVVz52Nseg2ig8EyHHGMiAnics7bv0CqNlUPt5quGP7GcrocK8CkM
	 HmGv6l5S+l0CpyhVHfpXZcptY1NrhBNglf9T1PNH79xCCRrsP1AC9Tcf9TEPEwQtHdw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794529736;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=yYiyDltBIGY9AB/GyrK6ychpC7X/bua3/RvGKLGVeXI=;
	b=QkauO/4GihFl9f9Wo5dMA4hoZOBwTyzU+TWkaAcmx3ygsV9TNS7objs4X6dKT5HLp7pI
	 mVMWzqNCU6X8K9lnhs7qvtHEoS2wNbwZ4wwL8ozFhhpPHmBm+AORXtcSrQ6gAXssf5DJA
	 inaqSD+K87nZqglHGVai68sZ8AKOVrA5Os4x9MNKYbrI4XcSapX32Qux35lRdtmkU6C1u
	 UK0a3wK+bMMaww634iCI16fLNrrBgeT26EjMRiQ1CH028CazY/8CGazMFQC5oIOQR4AxA
	 eNyTbtAP10JYkQF4q/2CVuBHazMGKy8J32oYDbuD3V/IvdOOBeaYPEq76X+pOEzNB6Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794529736;
	bh=yYiyDltBIGY9AB/GyrK6ychpC7X/bua3/RvGKLGVeXI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0XNsTQ4GH3rtPTr/xpeqiVKHD+z+nGFk6k0HQwObrjE273RcTK33qJfGj2XX1ISxB
	 ChQ38y/kavBaJRGNfGQ+unfv5YeUG3/vBkZaDikFPxGbTNZez75nwCDrOjGj4fqIgI
	 Fs1c+Z/I2d4OoMig7baCAFX3lxhoQHpL0vPc1IVzhtAk8KiUY3N/aC3pnC7vPiL66K
	 K11ZC0UeuxAdPW2vaYIQqkSRXtTKoWYclwTVxXknppPIK7PVF7ThWpLjA4gxtMydbs
	 u00WAc2vCT93E7ngu74iMON8frlwiR1wf0s5H6zrRjTdzCv0jBQsXli/DoUMPC2zMI
	 27KL10zDRekTw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 740A68153E;
	Fri, 13 Nov 2026 00:28:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D3B85F46
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 00:28:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BA01E607BA
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 00:28:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lkP775tJ8ZX1 for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 00:28:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EC741606D3
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::7"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::7;
 helo=mail-oo2-x07.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Ixkcm9WS
Received: from mail-oo2-x07.google.com (mail-oo2-x07.google.com
 [IPv6:2607:f8b0:4864:31::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EC741606D3
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 00:28:53 +0000 (UTC)
Received: by mail-oo2-x07.google.com with SMTP id
 46e09a7af769-8615a493e0cso148935a34.0
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 16:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794529732; x=1795134532;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yYiyDltBIGY9AB/GyrK6ychpC7X/bua3/RvGKLGVeXI=;
 b=Ixkcm9WSX65hLEaeB363tN/AIhQN9BijYA6Ym99zZeBELN9/F+Jh7I7UI6FmyRWpEu
 U3BpMB5SUfO0adeaT63x4tHOmJxWbkHIsU2xrNmSYIgzpNuJRM+KNrr00pIG6pqm1Qn7
 FCk3huq5K6h8FK9AK0NF0SChOfAJZiK0m5Fys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794529732; x=1795134532;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yYiyDltBIGY9AB/GyrK6ychpC7X/bua3/RvGKLGVeXI=;
 b=UQFJPHt/f1y/JAFtSqGMpBdB+R8K9pQhCG1cBIiP+U1uVe/8xRxJ6io4wcmg2DFT/u
 tp7N60c/40aq5EHMRNmfBKAG/BaiFSbuMtvPkVgs5J7Zlit+q07aRCdGEgfDe+XAnMdU
 rCZ+cQ7HpRiQaKV3bhj6MUpepoJYyI/NqYRHgwc1Xc5gRwFXU6pTOB6aAaPkWp6uJito
 4uxCqacs5I83t9K8Zm0QIETSOhrkuKORh4ZW4PI2Ef0v5kwKsw+cWeF2Xt5Ocsk56zUE
 SZ+N0x7EGqy7U7352VKMAMsW9J5A/Fsf7KjlNpY3nHcbgaufsmGby478RZaB8/hXPwIL
 B33Q==
X-Gm-Message-State: APuU4Z/KjESY/i2iTsAt+GLLHBw1MzsVcjuSMe4wpS54KA1vAOMok5Vc
 sWdWZiwsE7KIVVHODitp56YGcB/GnDaTwhXI0BxXZNB94hxXB8sCbmSYPZmAiWolhRI=
X-Gm-Gg: AYBFou1PDoid1VuWDuClZ43EA1CE10nZFbgsav/RKc16qiogY1LoDa60uTjMH7EMbj1
 POZKT6R/CJyecBJCbk4oGPHfbDTze/1MRhllxRatM3E4s8YDNehTaT5vEuUwtHzjeua5NKXDb1T
 8y81KiPCtpJrKh1UVxk/lkpGzzkd2VB0hcYGnjQyhZX2S3Bq+zLw7TQcgrn9c0NX6Aw3/nBdAxu
 Swo4alBKKpBnbirQun6Hn50UL/XP/N2yY4W5vx+8g/unDk/hAUIpWNdOKRH7QK0OHatRp2nK05t
 6/bFBgd3dQu5sCwb+IrclL+aMIksxhBRl21SiI7RxrNtyyjkOU2apTdhsSB2UfgQCA47NxGRU4b
 xVs+gd2jM3aDqTt5/8ubbPb67BVUmvAWCxurxmrRnVir6KbEV0fybZr/eI4QJ5JkuKAxZN8bf2u
 Jr8a5pDTnlmLDCVNOnR2ce/ujJoVsxyQtd7KFZqarRgY4EqIOMUaAHi2ZVm0+JyT5YZlGadilM7
 +oFnlpPWzRJJSBo9BzKZ3Rl9VWCWr8YVYb7Ni+XxJsrtlC+fcJ6efAgeZvf8q10MSU8ILjbsVqy
 za2mL5KeSoUQQ6QdSwbf070h7uDDmsFC7M88JzSiMhH9J8LipF84FiXCbXLeSwjg0MpsCqrtzZf
 DS1FcmAaKX4WNXIjenYwz1VjaI6p8hO1VPueZUNX1Gqu4ekUirJ0E02GS2pqtCBgik7FL1F9I1P
 9ryZRRDlFFOLXH3+UsOXNxz/ytFLjRdrKLPdrgEseiIRUu6UoPAvE=
X-Received: by 2002:a05:6830:230f:b0:85f:2e1a:f416 with SMTP id
 46e09a7af769-862898b6feamr799578a34.18.1794529732333; 
 Thu, 12 Nov 2026 16:28:52 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-862881a907csm1036450a34.24.2026.11.12.16.28.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 16:28:51 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Quentin Schulz <foss+uboot@0leil.net>
Cc: Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261029-denx-de-removal-v1-0-e71e448a9c82@cherry.de>
References: <20261029-denx-de-removal-v1-0-e71e448a9c82@cherry.de>
Subject: Re: [PATCH 0/3] README: improve links to releases and mailing
 lists
Message-Id: <179452973084.1021268.13474800505420897790.b4-ty@konsulko.com>
Date: Thu, 12 Nov 2026 18:28:50 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 29 Oct 2026 10:25:04 +0100, Quentin Schulz wrote:

> - Update the official mirror to OSUOSL instead of denx.de,
>  - Update instructions to find the official Releases in U-Boot's GitLab,
>  - Mention the lore.kernel.org mailing list archive,
> 
> 

Applied to u-boot/main, thanks!

[1/3] README: update link to official releases
      commit: 749e33db486bc9ff1c4f2adab55b34c9847729b8
[2/3] README: update instructions for official releases on our GitLab
      commit: f452eb440a6f734c7e1985275c74d40fb205eea2
[3/3] README: add link to lore mailing list archive
      commit: 68f88930a11672ab3d5fe5beaec02787ed4dee82
-- 
Tom


