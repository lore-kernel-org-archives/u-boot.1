Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA9BC36005
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 17:32:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0461D807D7;
	Fri, 21 Mar 2025 18:32:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="m3yZ4pog";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4775C803DF; Fri, 21 Mar 2025 18:32:41 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2683809A4
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 18:32:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22349bb8605so54363185ad.0
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 10:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742578357; x=1743183157; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VMaY4+lD8wxQmHvBLoP2sEvypy2748ajELVm88/9xrk=;
 b=m3yZ4pog6T06LKMclM1Vg4F9hy3UQghFMbPQev2yPSjR9CF9L33eRUghZRGyNZ0QqV
 qOTgcFmTGrrtKXj8cIX57XT0CxueATvKEGUIXIliOGNUc1YazKGMXuKyV8pLj4J85eWi
 E2Yf8FJ8QF0pyybL93NqZrMx28MMGtJ9TnF+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742578357; x=1743183157;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VMaY4+lD8wxQmHvBLoP2sEvypy2748ajELVm88/9xrk=;
 b=CKf3wME5eU+rIwmbAcNjCsMrGUi5axDn7X4XILmnXzD//tVkNH7dp3MWsfDIdRy1D9
 dwM1H9eejfFl7mEwpmhuXE8SAO4Xq78kby9EDjJohxpbgZpSyhbytvQeIETIpSzlJ/c8
 PoXWP/bqwum1Eo43tPGX0Grsx1pO0UhbRC/Ccsq+P474Mj6uTyNtpFceFUs3L9g6xnhl
 Wp/hfTNynUsGORtv8Jc1gMme64zLBVYdbtO0hK6zFYT1OUAIihPOTGwzc/jcU8L8VozH
 V0No5RSF/Z+Iq+mdP9bSJdslbkOUuwlNYgysvt9RvkUlGoSgbH11iK5rkkYd/j3F1xJ5
 qqCQ==
X-Gm-Message-State: AOJu0YxdyOXsvHCjBKqJO+xicL9cZvnNsld+YqVEc+UpBfak8B3DFsYA
 lNorCGS1wByez2CripCW48dcg6Vah+lgPClRuCibQGL+b+XpW7idZRS3o4H+Lw0=
X-Gm-Gg: ASbGnctyVvJC8479t/DuMiV9TBdpfMY1TxYkzFdXQc3WI6rfiNRXqfkYAKSNuE5fWWK
 L8MlA8QTHdamBubB/dJ3bK17/dzhAUv/sIO5TeEIoOjyahFTpXYr9lxvIKT9ZxG/EjYb+DrWpzB
 rJqz14qAC9qVya3b2vEIr0dHbCiiop/yomQc9a1U8xXy00s1kP0IT3OjoEaxya1ZUIE76qEMynD
 Fjez+ruzDrQpOW8q6DHpRoKRZVeJwoe+wftEoZTke4dUtGzZYUQ6csue3voAsyAvA0eSCdSYy/2
 qWdoqcMe/sDPb3vshK19R3DyGnrLDAE64Eu0mC0+FXpZ
X-Google-Smtp-Source: AGHT+IGAYm0lC8WWTzaTClBIvuB1IXf7XBiwwPtZ/s8k0OvHqdub85boKxzwi7HQHRXWG22KG15Xvg==
X-Received: by 2002:a05:6a00:2384:b0:730:d5ca:aee with SMTP id
 d2e1a72fcca58-73905a2529fmr7339683b3a.23.1742578357029; 
 Fri, 21 Mar 2025 10:32:37 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7390600bad4sm2231346b3a.77.2025.03.21.10.32.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 10:32:36 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>
In-Reply-To: <875xk2frr3.fsf@baylibre.com>
References: <875xk2frr3.fsf@baylibre.com>
Subject: Re: [GIT PULL] Please pull u-boot-dfu-20250321
Message-Id: <174257835550.2184927.4090662057030295692.b4-ty@konsulko.com>
Date: Fri, 21 Mar 2025 11:32:35 -0600
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

On Fri, 21 Mar 2025 14:16:48 +0100, Mattijs Korpershoek wrote:

> Please find the following fix for master:
> 
> Usb gadget:
> - Fix NXP UUU tool compatibility regression with dwc3 gadget
> 
> CI Job:
> - https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/25275
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


