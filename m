Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C112CCD193
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 22:57:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97F33835B3;
	Thu, 16 Oct 2025 00:57:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UZB2MOSK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6275D835A2; Thu, 16 Oct 2025 00:57:30 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A591829E7
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 00:57:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7a7d79839b2so83676a34.3
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 15:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760569047; x=1761173847; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0XyaHwB7PdeIKHQsu92fRFGsNlImaGfdKU+WX48Y2ao=;
 b=UZB2MOSKAqqd+RFawZij5mP8hCeEQ2HxFqcTxDv6qnmFGSyfTK6nEtVJSUYP9Fe98c
 2YyrQFacXIvcybDH5raBHTpKU101t+O2QHeaf7EDQoJ51rVvau6qf9tweisF78mupG65
 abe0ymMHlA5Qq6DwoHSOf7YWNuUpQD/+i+Jxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760569047; x=1761173847;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0XyaHwB7PdeIKHQsu92fRFGsNlImaGfdKU+WX48Y2ao=;
 b=p2YC3xsWhEBeWWUtT3dBkaY0ZC5dx5pDBZAFVQZad/ql1CGR4473+xJhedRbz7N9xl
 6BHQPTyBGTDYDdzTpeSrw7FIyoTonxcHQAmUdi1k5jpySlOh2zt8tVqWIbBwxtqnjPx2
 mjOSi8NiPHXzj4FWs1wIIyT0CrdnH1DdiSxYGAKGipYam1Fw85lZ+e5yxEdlOmJKxBot
 fslZlgCNcHDoPC+K0cCWwE431KMVAZPLmjeIZh5ub44Li7btt9Wx94Ph7AjMWFWhvfpF
 mFKmmTyS6IFwvYYxk11+8NnIvFe+yQA0LtDzP5FZAWgtOeNarqlmrbHZ7robYbz0tag0
 sYlw==
X-Gm-Message-State: AOJu0YzN5lENMVGHcvyz+GbNFF9AsQPnNdo5Jl1XIi/NGLleYJ2Q1c8l
 Czb3q5G0l9Z3/f0vb7cROfBuN42vBOtFrnvMlgrO/K4KJg45U1DmoqkY0A2V5OP3KXw=
X-Gm-Gg: ASbGncti9d4El5ihXLujnZVRocnYTlTpsYfITfziaXvgHYCYpbN2H751SkRIInm1ZV0
 GnK0IEEYpYANji2DUVfUSLlhVmOLi6iRN+R/3bQEMR2MgHMPRsCeelwhG53/T/jKNxgVGWpnoJV
 N06aLEYqCF1iaTrvr+kunpMlnrzDSKb9amU2xkh4IqrRog3iG28jfxKuG9nrGwWZPzYdcuGp2R/
 WkzIrRh+D18dYpcNLqNGPdl8gt8S6SvucyKPMUba/sSMjDLYHkLK0lHjZW2R5wnw+jEHWgn10J2
 BZyVS9XPJGP6jHE9EdwXAQLMSjV3q4VwvzdnQE56DGiV1UUkWzI4sKUqeFGIWRRPsW244Hvkfho
 7bj0x+U0Hj4Q8xjFRqQiWkI4iTSE0eq1ONznVhHncy+IujbOg8sOE5A7Xy1tXSuLV6Wilj1sFf1
 Ba3J5+Nql4JXZgT5HU2mCrJrjoa1iCkfhyvRT/wg==
X-Google-Smtp-Source: AGHT+IGDzIt3yfWhhJhonq9kOzTxiV0Kj734ROtny16XmTi7D2eHVtT9jbgiegajrV+p1dbct57eeg==
X-Received: by 2002:a05:6830:350b:b0:74b:a74d:8d2e with SMTP id
 46e09a7af769-7c0df7fd774mr16103456a34.26.1760569047023; 
 Wed, 15 Oct 2025 15:57:27 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c0f911af78sm5774854a34.29.2025.10.15.15.57.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 15:57:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Simon Glass <sjg@chromium.org>
In-Reply-To: <20251006-test_main-v1-1-51954a6e9ba6@linaro.org>
References: <20251006-test_main-v1-1-51954a6e9ba6@linaro.org>
Subject: Re: [PATCH] test: Remove not needed null check
Message-Id: <176056904603.760819.5881670306598571688.b4-ty@konsulko.com>
Date: Wed, 15 Oct 2025 16:57:26 -0600
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

On Mon, 06 Oct 2025 11:54:56 +0100, Andrew Goodbody wrote:

> In ut_report() there is a null check for stats but stats was already
> dereferenced on the line before and is again dereferenced later in the
> same function. Also the two places where ut_report() is called from will
> have initialised the parameter so there is no chance that stats will be
> null. So to prevent static analysis complaining of a use before check
> just remove the check.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] test: Remove not needed null check
      commit: aebf3a98bffa80c3e8f38f3a768bcd78ccbf401a
-- 
Tom


