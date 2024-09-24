Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 713CFCF9C71
	for <u-boot@archiver.kernel.org>; Tue, 24 Sep 2024 23:40:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7ED7B88A0D;
	Wed, 25 Sep 2024 01:40:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rG6t46Tw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 299EA88327; Wed, 25 Sep 2024 01:40:53 +0200 (CEST)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7D1788AA7
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 01:40:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-4583068795eso54108151cf.1
 for <u-boot@lists.denx.de>; Tue, 24 Sep 2024 16:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727221244; x=1727826044; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lgGz0XT7wyQCiWaDPK+bkwbOWwr/QDp5Zuw4RpR3ZlQ=;
 b=rG6t46Tw2To5fote9SmBgHC1VpsfK6Cv5FAgQ5ykwvREIJ/9B2a5qwhiTFQcVBuCyJ
 2oeJqmIGmnGQxAktmb2kg3THMCDBdL3he/ekARDtkCgEdx3Avc6o5oc0cz1jvBZbixzn
 okZYLt6I62igmN5mfyMqivft6/KMp/StY71n0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727221244; x=1727826044;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lgGz0XT7wyQCiWaDPK+bkwbOWwr/QDp5Zuw4RpR3ZlQ=;
 b=pHUn9OujcPg4U/0fdfBZ2T0aBi64QW/vlKTkV/z473bBEmmReUFUpUFI2P/M1nzApM
 BF9TwJeQYlF+vWvBSN87jB/yJ9AqOtnuDvXTVxU6YtoTy38Y3Pk77F62XlOGRf+RlE0p
 ztdflV+V36e6C15igijFxMQT5QZTx9FUItqBdSRxm6xx4mUFuKh14h0u2+WnKW0FloQ9
 oVNTztobIM2Ph1oGNSmjGxg+CB18Y7H7UDrWX4WXc666TRze8yGHUhMBCanLkLWg3sR2
 kmDpnRVNkKQz2DCblmnRAd0HqIj+rclCe2I3yidHDgHvfYORgdhbbI/eR9v0kck5j8UJ
 4toQ==
X-Gm-Message-State: AOJu0YwZmQEo63RrPBDt27sqrcaX2wTsJRoqSrq46UN+sWO/fIcFQlRC
 2v0z8G5UtvYRakgj5ZUDhAujl1ONpJcAbXuEWY74w98gpzjT6Lwgjn27MVTXZAM=
X-Google-Smtp-Source: AGHT+IHQFvvmYATYgGnFruyk+sPrc6AGZn3X6jNG36xOD/wjRWfXIMz5uVBH4+mJpeGf8hVGnwIv/w==
X-Received: by 2002:a05:622a:1a1c:b0:458:34ee:3a61 with SMTP id
 d75a77b69052e-45b5dec77bcmr11954781cf.9.1727221244584; 
 Tue, 24 Sep 2024 16:40:44 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45b5257698esm11147141cf.26.2024.09.24.16.40.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 16:40:43 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Love Kumar <love.kumar@amd.com>, Michal Simek <michal.simek@amd.com>, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <20240828225610.3081635-1-trini@konsulko.com>
References: <20240828225610.3081635-1-trini@konsulko.com>
Subject: Re: [PATCH] test/py/tests/test_bootstage.py: Combine stash/unstash
 tests
Message-Id: <172722124274.127252.17449504962317922417.b4-ty@konsulko.com>
Date: Tue, 24 Sep 2024 17:40:42 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Wed, 28 Aug 2024 16:56:10 -0600, Tom Rini wrote:

> When running the bootstage tests currently we get a warning like:
> tests/test_bootstage.py::test_bootstage_stash
> ...PytestReturnNotNoneWarning: Expected None, but tests/test_bootstage.py::test_bootstage_stash returned (37748736, 4096), which will be an error in a future version of pytest.  Did you mean to use `assert` in stead of `return`?
> 
> This is because the unstash test will run the stash test and fetch the
> addr / size from that. Rework the test to be stash and unstash and then
> run the unstash command at the end of the current stash test.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


