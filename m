Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4804BE74ACA
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 19:57:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B127489634;
	Tue,  3 Dec 2024 20:57:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Dwzxemk1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4D6989662; Tue,  3 Dec 2024 20:57:11 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC4BB8961F
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 20:57:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6d8a13444fcso23125746d6.3
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 11:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733255828; x=1733860628; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HeoLIGOnn9YBhsyI3hn9gCMHJhFTbbDdVxuVzKY7e9g=;
 b=Dwzxemk1moRiRoIe2B80MwJChb89nBuBtyacncAftkO+iGzpgBvKBrYUIgyeeKUdCZ
 gr/cLXW86ghDeCYD+MD5pu0Wt+UhMLpYBakCEVYHFGk4ZHUgEq/TZVvpD3xuSNUVDRcb
 gu6vmE/7zmDLfgJgUWKmI5y8WZ6e+4pYHvk4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733255828; x=1733860628;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HeoLIGOnn9YBhsyI3hn9gCMHJhFTbbDdVxuVzKY7e9g=;
 b=hUPojfxCK7xjXwC4SmyvBXUVTgfy4mD2ifsEEdIfYpYjFdmhE9Zwb/Pd0YgVRX/VuX
 iHf6O+koreTjp+urHU8lK9rFD/tCvweoi1U3kYeUw/wwHEA6yxS+4l0tFu6dwjHQ8JGe
 ZI6NNUfe/wWWmsok/PB/164yo4FKJmIL0fHjv1AeRqj/nPWVFOfN7vywvU7ZNFQ7Vq7j
 hXkXLdcIjvt0D/kOvGtmc7LPrD9g26uXBhm2+7LHl4kpxZUeMQR5Wm8UjuH1yu9/Lb9K
 o+AKrMmuDCjjvnwdTfpmyRwiWKjeVqy1xqPNOFgZFOvWj+/QXFe2toaUxcNn+ZHMmzx8
 2Qbg==
X-Gm-Message-State: AOJu0YwvvgnF/F03PES5gRG2InwzDqOHbGxsCjS/HV1MkhcmTQxlW/Uh
 1B9b7ERTs7vNUcqLR2jD9cUR3lr/F1IxJArMOePhzn71Vg6E+yT9drqU5n1yk4tuAMZykKXNfDc
 vctU=
X-Gm-Gg: ASbGncsECis+3QDWVXtohSkDSKm+TITmMHpPvqttRS9W30mXYWRhFdCyNeuqxzAoP3D
 V5g/yk9qeC+vkYr/I+QVmXIEVn4dbljL0hiYjUkuQu+ONeGN+u/zC2eghIXGqiMRiV33ZZAxmYi
 jJrHjKtWr7PSQM/9VcmJlYqIB59wQUjaF8OQTPZmHzXZzhsg5kEiMwFvPi1Of0w2Tz8KG55qGAr
 DbSa56/eZ4queb54a+Alo3QDPU7dnVYeogL/kjH4pw1rnp7
X-Google-Smtp-Source: AGHT+IEifweTUL8J9AklY7M/mBFbuUnkpUScvj2TLUlpWUXjkBvd4Wj2O9lnXWDo/WELzEhiTwZ8Uw==
X-Received: by 2002:a05:6214:ccb:b0:6d4:22e9:b8b5 with SMTP id
 6a1803df08f44-6d8b747b678mr58317996d6.46.1733255828614; 
 Tue, 03 Dec 2024 11:57:08 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d894bfa138sm42801556d6.99.2024.12.03.11.57.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 11:57:08 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241127172247.1488685-1-trini@konsulko.com>
References: <20241127172247.1488685-1-trini@konsulko.com>
Subject: Re: [v6 0/12] CI: Set up for an arm64 runner
Message-Id: <173325582729.4022967.77115780606088509.b4-ty@konsulko.com>
Date: Tue, 03 Dec 2024 13:57:07 -0600
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

On Wed, 27 Nov 2024 11:17:18 -0600, Tom Rini wrote:

> Hey all,
> 
> This is picking up Simon's v5 of the above-named series and making a few
> more changes so that the follow-up series I have leads to arm64 being
> supported for almost all jobs. To quote Simon's cover letter:
> 
> All gitlab runners are currently amd64 machines. This series attempts to
> create a docker image which can also support arm64 so that sandbox tests
> can be run on it.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


