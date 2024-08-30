Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2501ECA101A
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 23:30:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C37AF88D35;
	Sat, 31 Aug 2024 01:30:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Op3+aonO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BBF488CC9; Sat, 31 Aug 2024 01:30:21 +0200 (CEST)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51D2488D14
 for <u-boot@lists.denx.de>; Sat, 31 Aug 2024 01:30:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7a95efbaf49so642985a.3
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 16:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725060618; x=1725665418; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=i+pmOtDNpVmGkgq4dhZOSrt87r+Unza79IOZZzCAOrk=;
 b=Op3+aonOPO0QPua20U/mCfMq2kIEPlHmovlLfI1cbsMov/ihKmGN4P3+E6zJi5bYjZ
 umax73LAnOiTs9PIhdSmOR11cIJwzrakSH26aOgn2b9uJo28ZP+I4bRRfLpcDHAVaXC8
 yvcnnVdH+/z+5EpkQNj3M6cm/WWUNSijFQn5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725060618; x=1725665418;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i+pmOtDNpVmGkgq4dhZOSrt87r+Unza79IOZZzCAOrk=;
 b=MQgO4WJoYKSfoHoA7JCu8LTtuxhakDj4OhaXMTyQoCaXC0b0YdDl5kXwStEhcXg7B4
 UskolVeSeTzw4x1N/WzqbEEtqeVYx3UkP7I72s/3kEiCVJVWpWtjbNxaAahHtcDXMe7b
 7aDCQ8oTFXeYM5DZlLq+d8a3kF5Fx8vrN4o07EaIPN9hC2U76t9MizdHnoinRLnDd8+Q
 ijVAC623uwARhc0rJZ3++6HrDQXFKX/bT3/KZigl+KJk/GMN+BCcho05YsDBtOjqYKW1
 pTG1p8NXfPqbLAOyWHkkhbi3CR5D6qvk2NLFhCRbV9JqPUyfBZ0gge1ADQEV9NnpbkDv
 rP6Q==
X-Gm-Message-State: AOJu0YwJ3tDcl5QFoAve7ldolQaEuab9qtVmfCInLbDWo5hVKsnSVXmu
 fTEG8hUI3qQJm+yCBFF6GKgaFTPqtxkoVv7r8b0LIdFQWWEc1zx+iAosa7XFWLkTxNO9R3bM+8C
 YyLI=
X-Google-Smtp-Source: AGHT+IHBOlv4GKK2GKLC5ROzFcGanN+qrMPKLltWg1oTVcvkwBi7aCkVRPKy+gm+zRdELNflkSJnJg==
X-Received: by 2002:a05:620a:410f:b0:79e:f9aa:870d with SMTP id
 af79cd13be357-7a8042876c3mr848462285a.69.1725060618044; 
 Fri, 30 Aug 2024 16:30:18 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a806c1f974sm193224085a.37.2024.08.30.16.30.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 16:30:17 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tomas Paukrt <tomaspaukrt@email.cz>
In-Reply-To: <GK.Za7R.19AhVTpFILn.1cpWy1@seznam.cz>
References: <GK.Za7R.19AhVTpFILn.1cpWy1@seznam.cz>
Subject: Re: [PATCH] lib: crypto: fix ASYMMETRIC_KEY_TYPE dependency
Message-Id: <172506061710.3280213.1639235709078669021.b4-ty@konsulko.com>
Date: Fri, 30 Aug 2024 17:30:17 -0600
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

On Tue, 27 Aug 2024 19:38:09 +0200, Tomas Paukrt wrote:

> Fix the dependency to avoid a warning if RSA_VERIFY_WITH_PKEY is enabled.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


