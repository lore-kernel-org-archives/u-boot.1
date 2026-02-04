Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2982EA7941
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 18:42:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B094083A36;
	Wed,  4 Feb 2026 19:41:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VW1PjMS/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE8DE83B32; Wed,  4 Feb 2026 19:41:50 +0100 (CET)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBF158063E
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 19:41:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-4042905015cso84894fac.0
 for <u-boot@lists.denx.de>; Wed, 04 Feb 2026 10:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770230507; x=1770835307; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qIQCvqQRsHPkPHWb+7y+lYJZmCm9CDWuWyfRbqaPeJU=;
 b=VW1PjMS/IzvUdV0CMxQUvmW3qVPOMTJgRO9oxDKPDa+1/7UDer617KIZnzy/6kKFto
 WUj3kcCcCtIrIzlc2V53+5hDlhqXM5BpmRwFUHoCtX7m01XzgrvNy5XGLCQNItjPKHCO
 9+LW8+yUJyWRaUz8hHqQIchjbGkLbiMSX7kJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770230507; x=1770835307;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qIQCvqQRsHPkPHWb+7y+lYJZmCm9CDWuWyfRbqaPeJU=;
 b=FwIyf45V05VlYeMlNMIcklVwQibQ0u3xAena8sNXIoyL3UkRtnQGTxDDzGqQ4ja1GC
 jUMP5WUmPoXth6GGNZpVnKWgLHRsHWjTEyBQlBSlglllccBsru7uVG3A5nfKpYdpfmB2
 LTOTiWrHtL6a6cpdMZCPG5S1rPONQeaUXqyEkBj/G8WcoySwS2W16xs5jVWATjxXuI51
 H3iGtD3lz2AxXmR1e3piLyV10+t0CZkcALbIVinFU/TYnkuu+Z/yPAQS0G6WUfHta7iQ
 bgnr6/FCh1VL//1v/Itc5z+vfXx47rYJgJ1F8ErRywVdEagoM03SmTd1nlrz9cSPiqgY
 Z/IA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU74jTnpPBDlXugiZ3DT/ulK6AXJBbSHlWIOyfLKKKrjwds0OkJIIdQjeWOgjCrzPWC8ydQSG0=@lists.denx.de
X-Gm-Message-State: AOJu0Yz8n9jUms0xWy/3qEVi68F8CCGaBaqyBbap2gvDSmrZplt/+tSF
 Outv6ESuz6+tDaZXy4oIo3c+0FLOW/ScACSAGKaqSVFz1PlOsGdCPosU2IK4hIN7OyQ=
X-Gm-Gg: AZuq6aLOHsxsoU72czecBG5T23uNDX4h0K4O6Y4icaEb80zPnJii7gs//zCYNhD3Uak
 apkhj465EATxEFkgQt/Y+pYuyhzlQV/BR0kiJ6ZBU5hf58bEaViUGZroeji4S50mw8WJFbyUQiJ
 hu5Xbw6bW2IM4RDavyMdswXJ3KA8HiOtQOESrmrRp/hUxa2Kz0CkJsnT17ROikfDiDpC4gNY4nm
 1GnKi2gu6yPwaM4oUkjnuR1Hn0cJQjjSMbi5saNWPc5NbmABOztAr9ozPOgK6TGg39SL84wMvLB
 UcDJ+/AUG80hqgR43VBnZTrHU13FDRqybzqa8XtU5YBinD0lPfR22uC1Q31l2NgVSCjq/NPEmmX
 4Ua9gKuaDCAnhwU4HoXonDjKy9rPZ2pn1QscfcxDDWFWF+lz1Vt1+zfMaOHtEVmNUuNg4LGg7Ko
 VyoQla8l+ETFLog+IPgBB0BE8/LnC7H0cAnZPjPkla8HblrtlpML1i+MEkQWMTZ48TU8e2VIGMz
 iIxyly60/ZQN4Ykd+pBdbEQVfDd2Uui45t2O62PzImR/OnO
X-Received: by 2002:a05:6820:460c:b0:663:859:c41e with SMTP id
 006d021491bc7-66a23a07fb6mr1611170eaf.71.1770230507684; 
 Wed, 04 Feb 2026 10:41:47 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66a32bb1049sm1785776eaf.2.2026.02.04.10.41.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 10:41:47 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Alexander Graf <agraf@csgraf.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Ion Agorria <ion@agorria.com>,
 Simon Glass <sjg@chromium.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de
In-Reply-To: <20251231141344.64052-1-heinrich.schuchardt@canonical.com>
References: <20251231141344.64052-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] video: menu "TrueType Fonts" depends on TrueType
 enabled
Message-Id: <177023050643.1801114.17056220350766042284.b4-ty@konsulko.com>
Date: Wed, 04 Feb 2026 12:41:46 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Wed, 31 Dec 2025 15:13:44 +0100, Heinrich Schuchardt wrote:

> The Kconfig menu "TrueType Fonts" should only be shown if TrueType is
> enabled.
> 
> Put all TrueType dependent customization within one if statement.
> Remove `depends TRUETYPE` clauses.
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] video: menu "TrueType Fonts" depends on TrueType enabled
      commit: b5213bbfdcb1812be510427857827ee8becb9f8f
-- 
Tom


