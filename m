Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F62CA0FED
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 18:32:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31A54832AD;
	Tue,  9 Sep 2025 20:31:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JNRxMoll";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DC338318E; Tue,  9 Sep 2025 20:31:45 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B09B583290
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 20:31:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-406630d3b17so25477185ab.0
 for <u-boot@lists.denx.de>; Tue, 09 Sep 2025 11:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757442701; x=1758047501; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TOYV+w+nyj5lstCBmIpll207zTqL1srvAIC6WXltiL4=;
 b=JNRxMollAeGAcouqSr6xSxqzzdYqSaMbX4mT8owBAjmGCJXI0J4XGXhppoP8SP8TvV
 NviQE+SIKa5lRAxyHZflSYqD6hyCejLo9+XNIVlpfl30lH+f8XbsER3srmK86lahSpRL
 uiAr0JCdgKlZOMyf8Wa2yfloi29OmJU62QQtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757442701; x=1758047501;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TOYV+w+nyj5lstCBmIpll207zTqL1srvAIC6WXltiL4=;
 b=TMd5m5AeCl6JYuK4fTkqcbd8vjZ9sfOIxM4I4WpMhYdt9qRb+Q6klUUySg72sBBwSw
 DxNrVtnYGvGfC5MvuYWf8u7H7sZ8exGiXJinOH5DGDiKv5Ld96gZp/CoIZ26OlxQKltD
 KgZEELOuMa+CyVcL0YdGY+A/LbkOsO3EhCvqRd7PAn/6NoxyAKQ7kY5KRPOXt1Ay/MG7
 gWmHhUD8v6gcLzPJAj++Z8JPpO+YQsTFO4D66VtIbAyws2hXs1zr4lbxpgTh/YXqhvUP
 usMzmAhL6JV9+vTPlT6FdoPOdIq9I4m/l+stQaw0ZrIOr4Blc2LnDUZdn5VgynQZg029
 wJAQ==
X-Gm-Message-State: AOJu0Yyvxs+cCmbs5Fn8EByQLgMGVjEs7IAzPHn6EQZSf62P0hwGLpbC
 8O4+3qy1CfmImdhoBCi9kevz5hCPm+z/z+OQQCc33sK9lZNQo0Wn7lPK1WV9TkihSWg=
X-Gm-Gg: ASbGncuy5/QYYEJd4kp2srenKJBSudRf78aVR1LTLkXZLGFp+pcQuwowU+DHKM2igWp
 gjs8SdpfrTz39i2u3cRsYcdMP49iaGfIGpRTWiwQRGohe0C+x4v2c5Rkl3JES296+CyDACMfZcr
 WRULOnWrFBugayPirHANVE+xISdyw2uTkKMxsofffCKkOhxBn89ALKB4Rd2lQmSCJhT4hrz/dbu
 P1t2pmdYvxdZTZ8vV+iuFm1BJjo9YPduaUWpqiYGe89qBwTnA8vv7y/hBYoHwKM0FILC7Q5qAoc
 0haeEDqkdg+JGAgTJIZ2iQ6v5eeP0CtH1mt2xf1xCz7crd7W1EXqlyoYgLtM+THeAj7n2dBQbb0
 gXjnhHCJObzsD08oK5j2sjnnbJpWc04L/wPEE0NuEcKIR9tdA+rUc0a92TMWm9ETDEw==
X-Google-Smtp-Source: AGHT+IG3XVgnIQf+UFvNQLUSn/Tv7wxLha04nHwxpKM4ARrdjOTnxUW6l9f5HQ8y9Elkale/sXflqg==
X-Received: by 2002:a05:6e02:1d92:b0:3f3:42ba:5b2 with SMTP id
 e9e14a558f8ab-3fd8e990f89mr189506005ab.12.1757442701425; 
 Tue, 09 Sep 2025 11:31:41 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-403c8eb8884sm32715295ab.33.2025.09.09.11.31.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 11:31:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Mark Kettenis <kettenis@openbsd.org>
Cc: j@jannau.net, maz@kernel.org
In-Reply-To: <20250823140356.11344-1-kettenis@openbsd.org>
References: <20250823140356.11344-1-kettenis@openbsd.org>
Subject: Re: [PATCH] pci: apple: Fix use of uninitialized variable
Message-Id: <175744270036.1809471.2258595111043830196.b4-ty@konsulko.com>
Date: Tue, 09 Sep 2025 12:31:40 -0600
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

On Sat, 23 Aug 2025 16:03:56 +0200, Mark Kettenis wrote:

> Replace use of uninitialized variable with the PCI device number
> in an error message as this is what we use elsewhere to derive
> the PCIe port number.  Use ofnode_read_pci_addr() to read the
> PCI address of the node and derive the device number from that.
> 
> 

Applied to u-boot/next, thanks!

[1/1] pci: apple: Fix use of uninitialized variable
      commit: a5b483a52a5561030ab3e50923a215fbed49d006
-- 
Tom


