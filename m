Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F2F0E74ACA
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 19:39:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4E178966D;
	Tue,  3 Dec 2024 20:39:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TmqcJ8aw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCA018966B; Tue,  3 Dec 2024 20:39:23 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFA8188E42
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 20:39:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-53df6322ea7so10388743e87.0
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 11:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733254761; x=1733859561; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=n11NXlMcj0zu0knAl5jcTICmrMAD2itsUgpCyU0bcoM=;
 b=TmqcJ8aw64vDasjGf4HgfMUVVc9PxeqUxxk/g9Jk5wJbE/r/LMEfJ/bB32Wbep7XRf
 r24MpwNR7bKTjbBibf+YTuBcRg+uDBcsF2xbrkrskqPnx8lafGjGIXj7xqxxhiW8coii
 c1EsnbKLnfoBvNSTKPuCJSi/O1w04KWQj7LNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733254761; x=1733859561;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n11NXlMcj0zu0knAl5jcTICmrMAD2itsUgpCyU0bcoM=;
 b=LmLvIUQFGPCoWmVwcDz2j8TPbJr6BdlJla18PHSP5QXT4Z92IsJago/73AJcS7J9z2
 wiWIsm6ipsB/yE/GwZr/k7X0ESq6CeREcF6mWHwwviCOlvF5qt93x+PnwBAVVTJlkrQo
 zOuW2U3vHQDD5vUAM2SpKFFIWGFf9Ezd1p/b4cnVyuk90GAY+AZMRdiCJKLMh35uaoKc
 0Jcva/qgtedYBSX57meyExJ5NGWB9TTjxZrfJFJzLeZX/9lcRqAdTBMTUKv1NnumZkF2
 XqR09fXyAETF4Bhl8tiwiNXA2vGt0h4tGU7WILN8EPpFbbd88c61ngKjWPDR4x7sUMOF
 EMBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1VS+M8qwI1CrMOdm0nD3pbyygeYsWJs2k6wmb14AgYXpjrid8KPW/BeQGw5FoA9omVfx8/VM=@lists.denx.de
X-Gm-Message-State: AOJu0Yzt4gYtyp1wGG8EEaDcwVOswG9jkXNFHJcLY44gY0QET7Vz2T6c
 QLBzlzCHfT4bppqBneMxg7ZGAtJTv+bvWpVlmCsqjOBsxdnoNvMqQsw8rQbzVqHY4Fv1T9DZZMG
 g2GdMSz8AlDao2F8skQAPnuLMXe/O6JHCbKsZ2FRQoVS9M30=
X-Gm-Gg: ASbGncsbX6dFn12cDG9xTyCfcR2E6ssJF1+ntUkH3FCNGg4V4VEiBnKO2fATm+ezh9j
 UsXj10ADVIOY3VwiZBfTJ9bZvAdSb2Lk6
X-Google-Smtp-Source: AGHT+IHwBlhV+qkCdzit+L3T2uc8B0Z1n18aXMtqrBj5iSU1PLcri2jLgJK0lb6TeHLW9FkFs0koRv+II1GdQ8IECeg=
X-Received: by 2002:a05:6512:1189:b0:53d:eef7:a017 with SMTP id
 2adb3069b0e04-53e129ff019mr3888750e87.15.1733254761054; Tue, 03 Dec 2024
 11:39:21 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Dec 2024 19:39:20 +0000
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241103003322.626036-25-sjg@chromium.org>
References: <20241103003322.626036-25-sjg@chromium.org>
 <20241103003322.626036-1-sjg@chromium.org>
Date: Tue, 3 Dec 2024 19:39:20 +0000
X-Google-Sender-Auth: 9Wm1dmlkKj2-Pd8aWzJYghCXDlo
Message-ID: <CAFLszThON0yUQ9aT0Kk0koT8MTpRhOB_sXtUCUCdx7qOVe34Vw@mail.gmail.com>
Subject: Re: [PATCH v3 24/25] led: Drop status_led header file
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

This is not needed anymore. Drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/status_led.h | 104 -------------------------------------------
 1 file changed, 104 deletions(-)
 delete mode 100644 include/status_led.h

Applied to ci/master, thanks!
