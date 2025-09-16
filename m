Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B0FCAC592
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 18:14:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A3A681E13;
	Tue, 16 Sep 2025 20:14:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ljambDIv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D3798309A; Tue, 16 Sep 2025 20:14:47 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14780803CC
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 20:14:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-31d6e39817fso8313864fac.3
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 11:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758046484; x=1758651284; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=auDmNXoZ2ZVt/D7tnh7iKH/edHpIa3q0Mjl7pcFPTok=;
 b=ljambDIvBSyza597V4F24hVKyT68YpKIXTj59rm4+FnrpjxRdL83m7PkT+Ntu2WmWq
 z+qRJYTzEaoa5cMptmyBGxePRnAUForGTt+QsA8L64c8iv2M+3aNDi2jMpT77a/3NYzP
 4svt6C8c0E/FE9NW7aF0c21g17Q4/Bo7PJp1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758046484; x=1758651284;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=auDmNXoZ2ZVt/D7tnh7iKH/edHpIa3q0Mjl7pcFPTok=;
 b=XgyCA35DDhjI9/TE81d8SqFRrNxWytgCy0PJaMDHHHkguWV3rFglddC61N11DNTzcw
 bVon5he8Vx7DbiX4d/SmH+ErwKRqnHWgi2V27RD7my7JVCvErH0Uht+kKfaetqMrZ4p7
 qT1NnV5wlNS68W63boVVmGP4F6Zbvqk0trH+TDYLfdjA3b4tUWtRyHrhGeBRGZQwAnbU
 tczZFj+ARUogWeFneV5ZtGX2Q2YL/so4I9tOZ+lE7rfx91184T5IKyXfl7EZ5QI/oBKh
 rs8HgWWft1UNUe6ysp8F6nsceGV621mhltdi8oHc+gcJf+sOZxQOlWzSV8LVCRszhxGT
 +x0A==
X-Gm-Message-State: AOJu0YzVmQHltAkuuwasUCpJtiB1wKGAOSvrMZMfKHNE2HHF/xf4+qlk
 ShCgAe3c0eNjixkqRtKiYL64X+gcKjBvB7SiKEPgT79s3qei4tQ1Q1ZRMHNiaesgl+ewBjFyibz
 6lm6TCEk=
X-Gm-Gg: ASbGncsmJjJZXKGuvqIVRol0Bb4s4te4tA1JgTi6/PYv6TI84Vi8h/JJ0VcUd+CM8lI
 PM51OLv3xkfWizYDsMDRrGL6e2m71PGecKpnlJ0m30H9Q0F8dRCnbJDytqFOSeNaOtLZfaR+Smj
 gXkpJCgbND/tPiVJbah7h9pUTuDRN9FfTcqLTMq5YO517X3CwM8IqzNHvDKRV+m1Sq4NHZZkQaP
 7jYUfvDgE/EOiWrXcrRMqmmdUPm1EwNNkaTpKjh2GQ7vXJ+nughGdZp03VUzeyHcfUcYEm8qNDw
 1197S9DTxOqrZgOWQOYHr8ZypTNC+EXgVxDvl6UZcy8j9RXat3pBMa19VNQl6AFVwVkkqC92giq
 0yxTKoefMuilYcEnGGWVpgL0S0TqbqCYw1Hbd00SsRNxZ5RZiZbYttcX8tehKLUZi2A==
X-Google-Smtp-Source: AGHT+IFr8bBPD580GN+cVRIPGcLlf/4JartBSno4ZJslbXrVaNOTPZAt1faQ0NTBW1fWOLz49g9eag==
X-Received: by 2002:a05:6871:738e:b0:315:9347:9260 with SMTP id
 586e51a60fabf-32e58144acdmr7877659fac.32.1758046483755; 
 Tue, 16 Sep 2025 11:14:43 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7524be79747sm4242139a34.30.2025.09.16.11.14.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 11:14:43 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Minda Chen <minda.chen@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, E Shattow <e@freeshell.de>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250903020715.682143-1-e@freeshell.de>
References: <20250903020715.682143-1-e@freeshell.de>
Subject: Re: [PATCH v1] board: starfive: visionfive2: deprecate mixed-case
 product ids VF7110a VF7110b
Message-Id: <175804648274.612966.12377353497424618494.b4-ty@konsulko.com>
Date: Tue, 16 Sep 2025 12:14:42 -0600
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

On Tue, 02 Sep 2025 19:07:06 -0700, E Shattow wrote:

> Per recent discussion [1] product IDs VF7110A or VF7110B from EEPROM are
> sufficient to select for VisionFive 2 1.2a or VisionFive 2 1.3b boards.
> There are no VisionFive 2 products with mixed-case product IDs in EERPOM
> so factor out the unnecessary select case conditional.
> 
> 1: https://lore.kernel.org/u-boot/ZQ2PR01MB1307D97D2C9566B8EE443812E6062@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn/
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] board: starfive: visionfive2: deprecate mixed-case product ids VF7110a VF7110b
      commit: b82fa9d752b025d3b5305b5b07debe6808a5d027
-- 
Tom


