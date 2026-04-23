Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD2CFF885A
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 20:32:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0A0584099;
	Sat, 25 Apr 2026 22:32:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LdMbe8l7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD09A84099; Sat, 25 Apr 2026 22:31:59 +0200 (CEST)
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com
 [IPv6:2607:f8b0:4864:20::e2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9665783FF5
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 22:31:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vs1-xe2e.google.com with SMTP id
 ada2fe7eead31-6058ac0ebceso5454366137.2
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 13:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777149116; x=1777753916; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wATnMTkrQ6FLdAHN/1ymheNqVYtGDRzqq5wxSbNcBk0=;
 b=LdMbe8l7mxbOnx2tqIzNrKvtu9ja5e3zWcybQ8xefpkbNHwes7apxhrO6UuE6t0v1+
 DqEckGXyp0ShnTANbFBWIZqn74sGCMX3sGRpCiFayKnmolaJ/jBIVjNTWCsV/qQ8LsAK
 KcQ09KvqjuB5uC0NbAC0Gnq68utZWdSMoR7Fs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777149116; x=1777753916;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wATnMTkrQ6FLdAHN/1ymheNqVYtGDRzqq5wxSbNcBk0=;
 b=CrU50FxL0ph1VjpEzMThhtVI7xY3kpP7QnaOpSfTuruEPAXKsXdB5SzRbC4Jd6672d
 MEck6P4Jpic2t+XaTyPQW5USjxz+GuEQdBOCrOsykq6WLJzq2TSjZUq+f29XpKhJsowb
 CxD6q6+6fqzMt4MSeDIVayqAQgAx/FX1p6YlxbcInDYpM1n6+vtiZEMuEIOXkxw7MXKN
 nNQXmLATZ46UcTAcJctKHoMJb6ECiixp6tykY18Dm9CGBp6yDOOPAvRgs8t0JdpCKQ8H
 YT6zrVdltqiAsrPNoZYXO1ga+0VRTfUd4ls7EkFNYmeOGE5q64Iyg7DrRkGx4KKR0L7g
 rgog==
X-Gm-Message-State: AOJu0YwahQAiHJWPmScMqyHkiEyuEGQCNs0vXLNVBJdf/V0cMa752wMF
 2P/xLE0d9KkpmXBgOVle9UN+9NaHRajfEC8l3txbAueWKyyJTmQ3IeQ4xRZKkMDhokkE29+o478
 nW9rm8ePGMg==
X-Gm-Gg: AeBDieurepJnx+b2F6JcaGJ2RM8jHgv71Kw+/lA2dp41jtVRdLKhmT0N4R1asE8ynrM
 G63af9SHhbgvYUern6IsFA3DKtvv1BsWp/l3yiy2MV0UrMcgncd/MQUhq2lkSDpU00oXhK3JhB9
 f5IWFn33aKTk4Xan5YCYtaNLotRSm4Tw656nyoLP94e6C3Y/ELEbz9MP8F6DRdHq09r4XyjZFnw
 IPTZ+/J5GdqNmD9fgRWZcEqIWAFEGs2RaGahrKUz66r9d8+c1N8JDCETuniuMVDZr1vJNYq+42Q
 ZhTohU1xq7Uz56nFLBaP/vFvvvuZl8Ma80BY0PsUF/rJqZfMWw6tlvEdB9kdQG4qjQ4UDA9xyye
 u9jQN9na4KdXeatYnF24Q3F04suRmTHyvI7Z/ZxPumT560E4t7/bzgpbk2VJe77g8KiC4Mpe88y
 UiAS9v4X4p8jihUC0uPZNX69pvAWpa2q9gYMRDGwDeSRjaOa7MIXMGNJ5zuQ5K1fakOpzFITbwX
 +3TeGa+hMDAqfmbWFZ6+vo5IkQzgTI+BFTlUJ1hvTCDlzFCQhPTi2bCsg3+DmWCgNfD3Bs=
X-Received: by 2002:a05:6870:b2d1:b0:42c:24e7:f074 with SMTP id
 586e51a60fabf-42c24e8cd37mr7466881fac.17.1776909750532; 
 Wed, 22 Apr 2026 19:02:30 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42f090b1de9sm5587967fac.6.2026.04.22.19.02.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 19:02:30 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
In-Reply-To: <20260413130007.1987326-1-sjg@chromium.org>
References: <20260413130007.1987326-1-sjg@chromium.org>
Subject: Re: [PATCH v3 0/8] test: Refactor FIT test for clarity and
 extensibility
Message-Id: <177690974962.1999178.6083237812778038477.b4-ty@konsulko.com>
Date: Wed, 22 Apr 2026 20:02:29 -0600
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

On Mon, 13 Apr 2026 06:59:51 -0600, Simon Glass wrote:

> This series reworks the FIT test (test_fit.py) to make it easier to
> maintain and extend. It fixes the buildconfigspec so the test actually
> runs on sandbox, avoids unnecessary U-Boot restarts, renames the main
> test for easier selection, adds a missing-kernel check, fixes Python
> warnings, converts the test to use a class, splits into separate test
> functions, and adds Sphinx documentation.
> 
> [...]

Applied to u-boot/master, thanks!

[1/8] test: fit: Drop the fit_signature buildconfigspec
      commit: 863446256b0b03a1729c697dc694014c74cbd0be
[2/8] test: fit: Avoid restarting U-Boot
      commit: 1cd07d900c59dc8df1a59cf5c2a2b3c87fb7fb8b
[3/8] test: Rename test_fit() to test_fit_base()
      commit: 875ebafe448b4ad665f131fd19fea07970af0027
[4/8] test: Add a check for a missing kernel
      commit: 55aa0c5acc4f6a0133b93bd3e91bf25367e14db7
[5/8] test: Update fit test to fix a few Python warnings
      commit: 09a9dd3780c782b48cc3b9995c066d242eed5199
[6/8] test: Convert FIT test to use a class
      commit: cd6e1f6dbe45f39b7aa92107826b9ad88a859b28
[7/8] test: Add fsetup fixture and prepare helper for FIT test
      commit: 06b12fba0ce89c803440f3f113e6548343b648e7
[8/8] test: Add documentation for the FIT test
      commit: 65c036eeecb9c2c2f991ee10dfd31c7bb24c9ff5
-- 
Tom


