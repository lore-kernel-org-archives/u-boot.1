Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C38EC0218D
	for <u-boot@archiver.kernel.org>; Sun, 26 Jan 2025 23:58:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 921C080FC8;
	Mon, 27 Jan 2025 00:58:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rcQg7HTs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8016E80FC8; Mon, 27 Jan 2025 00:58:49 +0100 (CET)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5013580F85
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 00:58:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-467a6781bc8so33421291cf.2
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 15:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737935926; x=1738540726; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UqquPxq3GbY+HDo7itBTVS9oeLp7dwp7X6jBZSUiYHM=;
 b=rcQg7HTsh34c8f9QMrRGTuSYmxxMCxRRboliXGj4aA9uUA15uv+4gT6fjnzS4J53SS
 /HjIJnSxo++EWpgO2vf9iylZ48Pp9Yr4+ktszEqcbFi8Kz8pH5MLhlO2UjJdfYkiOf/T
 ZN2QsTizW+wVKTW0iAzPHzZPrAUY86s3Ot7yo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737935926; x=1738540726;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UqquPxq3GbY+HDo7itBTVS9oeLp7dwp7X6jBZSUiYHM=;
 b=NcRaU+lXRyyzfxW1Jaj0r4NygxwcKfnf80nUjuKOBXA0YoNbLs/abegfg45tOV8El7
 m8+n+yZAp2KAaOFSu7677lPcR8YLWfHxws2o5H46MSteQ/SWaKWqpX+iTdr+9UZ2zbEO
 P1D79JulAODw87tFZf5Gm9aYDO5rPmexjij50ON5qXtv3+LygHei3budqAkYS7laquLF
 ZFIAAW7Py9rI2j+6h446nkkpS7koIXJL5li+UNximKrk6xqBFyGSMRZLm+rcO+5Ta9VX
 BV8GPYFPHA18PavqqDDIotzrlFbj1B80IWzPsp1Hh7ZzK6xbfJoQpIoS/4kSOsbtWyA7
 0eIA==
X-Gm-Message-State: AOJu0YxVUpUzYW4RY8p+VGpxisSEWoRRIJf+D7UvMDmVFIknJJ3R5SBg
 i72yNfvpVb/xPX9t3h3ZKYVnlBQP1X9xsuVc8IY2CACHklH30FoBLg+PIhVp2Obx0DjfFIAMIqp
 w2l9NLg==
X-Gm-Gg: ASbGnctXDtecsfMDJGX1n6oYaOPcC4HFuJI3Ck71bUL5lTEH0cJMTfHc7lH245uNAB0
 OoFZaHqJf85ITZnBMLZ/4womNO/BIpAUVnaaPHdXIQDp95VOhk0sEQB7ynAS+kSSSfCeheX008s
 MOJhUxkvCohH8wpKyDKtfR37YBFIfE4KQ4qu4vJucE/CTvbbG5lSnKX/g1fR+sgmsilOXj7HfOL
 bf8vB4sybv54fbQXCc0zw1tQbs4hOinu0BmdgQWlYSKDCqfvTPczOSroTOowdEnvVcGAYiUT7k6
 A5E=
X-Google-Smtp-Source: AGHT+IGFS6Qoa1eOulzDSkt0y18B9z8VJxEA7D8cweOC0gEGkqj+99YWctvNSbYwV50uBe+UEHEzvg==
X-Received: by 2002:ac8:1204:0:b0:46e:2a18:93ab with SMTP id
 d75a77b69052e-46e2a1894b4mr381589161cf.52.1737935926271; 
 Sun, 26 Jan 2025 15:58:46 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e2058c3332sm29367206d6.111.2025.01.26.15.58.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jan 2025 15:58:45 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Cc: Chris Packham <judge.packham@gmail.com>
In-Reply-To: <20250120015941.1849667-1-mark.tomlinson@alliedtelesis.co.nz>
References: <20250120015941.1849667-1-mark.tomlinson@alliedtelesis.co.nz>
Subject: Re: [PATCH 1/2] drivers: rtc: max313xx: Fix setting years
 2100-2199
Message-Id: <173793592428.1408499.11733280785516779343.b4-ty@konsulko.com>
Date: Sun, 26 Jan 2025 17:58:44 -0600
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

On Mon, 20 Jan 2025 14:59:40 +1300, Mark Tomlinson wrote:

> An invalid calculation made setting years 2100-2199 impossible.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


