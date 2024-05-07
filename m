Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B33C10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 14:03:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8493F88786;
	Tue,  7 May 2024 16:03:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SN4DCsWx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C3B688786; Tue,  7 May 2024 16:03:01 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 411EF88719
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 16:02:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-23d1c4c14ceso2069977fac.0
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 07:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715090578; x=1715695378; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sDUq9nt5K+A49geMDxTqYNNdJGaqTQP6kNOWKs1Qqi4=;
 b=SN4DCsWxkNvcysIlRSYgTN21FQoHzl08m3tGxeq8uU4OHZ+fMdtPJJjMiNUDGykOKG
 Fm6DrsJgr18KWkqBJJHaLohe8SJD8deRArIMI+BNWj6g6DSZz4XrV+C31jfOaazBDqtA
 fVFfL3KAR618NvgPT7xNXmKmuUEOv67/sdEQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715090578; x=1715695378;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sDUq9nt5K+A49geMDxTqYNNdJGaqTQP6kNOWKs1Qqi4=;
 b=QmeYBrc8LTCwDdLAO77L/Od8Ueq5qJjSPAw6FLfUrwWuDDUJCYnzteBhqz2qxNkSmj
 SqNmOHXGsAFrQf8H/Dja6R2nLjQ4ABFbpn4/8YBc3MBWsQlFsUCvfzVrRAd7BcHBwQTB
 wbDL+6qc6xthvaQhpL8xJZNT81jRr2Fc82RQTbpQyp0Ydw+T8KJjWZMevi0GRtOMFrL2
 AZtHTHlpzo+ZwFXqbLjLjp0RQ0GF+Y7CKHzWSHyzWqBSdUwzLwpcxsfdsqetaltom4UO
 Z78YVVziPWH32mPdMNVqfgmaE2fgQkH0jlGtM3OJvpPBJnUtBAc7DGSkg1dO0xBg9t7R
 hRYQ==
X-Gm-Message-State: AOJu0Yz519Dd4XeqwtfGGn73tQAgJaUnhuCXH3l4YEUuVceoCdu31/nK
 t6Dgtyppobwpm1MCWl3KEBZLj6ZVQ8naYPbCPzk9S2WMJ69POK+U2CQjSPU4O/8=
X-Google-Smtp-Source: AGHT+IG26vQjtcE+N+fEEsySZ1N6L7J7NpBBrJpl7/CXRuC2gYYuJgwnOr3bUVF+4mmgMF+KiE3PJg==
X-Received: by 2002:a05:6870:b295:b0:22e:4b5a:5ac3 with SMTP id
 c21-20020a056870b29500b0022e4b5a5ac3mr14553893oao.58.1715090576989; 
 Tue, 07 May 2024 07:02:56 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.98.216]) by smtp.gmail.com with ESMTPSA id
 ge16-20020a05622a5c9000b00437543e5307sm6460400qtb.40.2024.05.07.07.02.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 07:02:56 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20240501024316.1767971-1-trini@konsulko.com>
References: <20240501024316.1767971-1-trini@konsulko.com>
Subject: Re: [PATCH 001/149] global: Make <asm/global_data.h> include
 <asm/u-boot.h>
Message-Id: <171509057626.3014396.13726251537720936232.b4-ty@konsulko.com>
Date: Tue, 07 May 2024 08:02:56 -0600
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

On Tue, 30 Apr 2024 20:40:48 -0600, Tom Rini wrote:

> This follows the example of RISC-V where <asm/global_data.h> includes
> <asm/u-boot.h> directly as "gd" includes a reference to bd_info already
> and so the first must include the second anyhow. We then remove
> <asm/u-boot.h> from all of the places which include references to "gd"
> an so have <asm/global_data.h> already.
> 
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


