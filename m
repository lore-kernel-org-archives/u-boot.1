Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D8BC28B28
	for <u-boot@archiver.kernel.org>; Sun, 16 Mar 2025 00:02:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C9D5805C8;
	Sun, 16 Mar 2025 01:02:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UdqnZ2f2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 319428091A; Sun, 16 Mar 2025 01:02:07 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8F598058A
 for <u-boot@lists.denx.de>; Sun, 16 Mar 2025 01:02:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7c0155af484so466232385a.0
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 17:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742083323; x=1742688123; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=H0V79IRHOBUZBBk2SbQm1r/8mtEujWSccdYxMv5WvZs=;
 b=UdqnZ2f2g2QQUgI5l4jeNsyFQdMAjgdj/5ZwUWt5hQWMfilsRMYeP3vce3mr0DTv2G
 Di8bGi9Bb27VIU4aD7dSTZJZdR6jCLe2j6kvpHlOxxPn87U9m9JvoiDnf6ELeyIohv3E
 xsUOLbmi5SYZzhuVLuHUm20YhNPWMSyf/fIoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742083323; x=1742688123;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H0V79IRHOBUZBBk2SbQm1r/8mtEujWSccdYxMv5WvZs=;
 b=E7SVjgm/lrLxL4xscx4RzrkljtOYrFmA8zg6FCBayjEZAyRu0izGH5/HcnNECFnV8Y
 LdkjQo2tAFT+YoCqZ3Eite+sBrVYmKW4qneARxLFsqt+Oq5uELIirZJ5xNxmewBmmeVn
 Uu2c88Ra3FLa/vbM2VHgE4sJ+Q0K4ovB/VRQyhq3BnQNrGCjCDIOcqJj/MTcF9HZzaV6
 iyHM3UGg5mnaLeNv4iaJwK1yof4E65fzRTa71N7aq5dhwrK4eg1qGEZ9kMExFloNZ/ZB
 8QC+DkqNouLd6TPG9YPAX9VWrVaAGhJnUDxe8vU32N6gaNCJwZwINwqr3+pQSv9rngYk
 LEuA==
X-Gm-Message-State: AOJu0YxltY2lVKC7F7NbFluTWhGHomV9sQg1Yxce8IYonXJ6+kSp9MD/
 olB3EtFL7nTvNfxOuZN6RcC5L4pqnXZixVhr3eWU8rlj54//iDkhpA1erAjdD9avOuj7ncIfGeL
 j
X-Gm-Gg: ASbGnctSeWaKAOe0k2mEFksVTqe1dCrN205Q+0/9vxqLi7xohIHOn/dFiutmKXeKwDe
 ksT10GHrqRmjOC9663ZU7v4d8Mnj9PIV90cHzINfbEEoiVWf6e0XmRLmH8qJA4Cmt0HEAx9nawi
 /xyfdTYl0y6m/8ZzmuCOc8a+Zb4DvJJiPQdNZ5FhRpbIwcDmsfqP06m4AwMQbqQDWP61vGKuK4M
 +KCmmWiqRhGkFCvsSbwb9afvQaYCQo+rhXfoiL0zzu9Pbwg5fHN8f3VEZbTghrG3AdCmRx7HXMm
 r+/psYCzLdM4BjtQ/rwx02jLu0mH24b9IgJ3eHPKyl0F
X-Google-Smtp-Source: AGHT+IGN0I900m6ls9TTNZ+VnTN86s+zVLeN7aPDarkdfez5teCRurKVfcSH7caBfQ7gIbIOQ4KNVA==
X-Received: by 2002:a05:620a:6608:b0:7c5:658a:e580 with SMTP id
 af79cd13be357-7c57c923747mr1401922985a.51.1742083323586; 
 Sat, 15 Mar 2025 17:02:03 -0700 (PDT)
Received: from [127.0.1.1] ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573c714c0sm423735585a.40.2025.03.15.17.02.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 17:02:02 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
In-Reply-To: <CAFLszTiy_23MXgSB4U8P5WyDxM-AKu6wO=4G+u1Wv6P6YpPvPw@mail.gmail.com>
References: <CAFLszTiy_23MXgSB4U8P5WyDxM-AKu6wO=4G+u1Wv6P6YpPvPw@mail.gmail.com>
Subject: Re: Please pull u-boot-dm
Message-Id: <174208332160.492921.17691637688430954228.b4-ty@konsulko.com>
Date: Sat, 15 Mar 2025 18:02:01 -0600
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

On Sat, 15 Mar 2025 12:44:50 +0000, Simon Glass wrote:

> Here is my attempt to get the test-rename stuff landed in your tree.
> If you would rather do another round of patches, PTML.
> 
> 
> https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/25171
> 
> The following changes since commit 00dfb7038ea4dfe9d9667143bfecd11c05cab6fa:
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


