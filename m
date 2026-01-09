Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 334A8D26D81
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 18:13:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 979758436C;
	Fri,  9 Jan 2026 19:13:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SyAH6Obi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF2758438A; Fri,  9 Jan 2026 19:13:20 +0100 (CET)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A76C084206
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 19:13:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-65d096dd0ceso1105743eaf.3
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 10:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767982397; x=1768587197; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5FTVD7vL3dx0FyrIu0Vq+EJvgOH/xBqXB77nCCIi8KA=;
 b=SyAH6Obi1rrGZhYYqRV4D62/kQ2dg0wKVP7625+SiKQVh2dlZ+7f5sgJp+wCHfByFV
 enRDk5jaZees4NLbGS0NOTO+H5OZWF1tOjOkff2L23rzOiQTlEuyJ9DYK+mtBgO3q6dT
 ns/0u7jp6Y4gjV+R+RlDChyD9qntC9sozhB2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767982397; x=1768587197;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5FTVD7vL3dx0FyrIu0Vq+EJvgOH/xBqXB77nCCIi8KA=;
 b=vM8svDbsJas0zGrfEGQ3HAeSfyi5TLJvyKuKQdQR502G+6V4BwO6g9CPLbhI9G2TIl
 qp+AiZA5DbUoD/19HD30vldiU+5v56qqxOmn8j6Y2RSSV2j9igvFgUhpXvc1tSd9GKUd
 bGicdgOGcubeBPYH2sYhdPYx6mRHRv45/p/4gFHas3W3tr0G+wXUc8U+o63Ng3ZN4GHx
 Bb7S2M11rOWf5KlUi5amm/l6eojNSkQAF3PaFUSLUeUlA8qYcWHTlcQmSuOVk4ijS70D
 6ZzlZLp2E+ASEiFIE9YIB6mEzWO/LtR4d1p/UIoBSaozjAfPU//UfXypoo2/GJepVasF
 YGrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAHOeVQHNQY4pp9dRGFrxXIqBDm4EKf8hwzHgLWqzMwNl579XgDEHtYhFlyg3DtGpazgVyMwQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwAO4yRvw7xBOQWRw/u3wIKaoonyMsXZuo1fTFVzkftM1r0yCSn
 LDJgqSZkp4nKaPmQzAwrSeNYug0wplJkZh/h5Tu/8t8z1XFeUE1I29yMpjT+3XagOdQ=
X-Gm-Gg: AY/fxX7NLGBTcBVI2VzQZ8CLRGc4r0JjbX+QiTn2IGE7Lv+c7Zr/tTtRwdl1IAPMLjk
 EwdWLTSkiqrRzIu5CpIGW7Bf/YTs26jltkL1lNiEnVH5vWAWtUQirrLr2uVOESh2B4Av/uioUg4
 z2dmWJyejkm77C5ZDWtUNfG3BkFzXhy79RsGah0ZG87Y1TYDCkuOvB2KfCJ63+pS8lOiDDMW5ly
 W5wZDtLt1UTT6StXMztU4PNNKMYYb8tUVOOekFm5tfz1T4cE76uhbfrdsVJfWCFdmAe5KKqlV7e
 uFFQoADzU6THQh5VpHMv78DkUq/fdKvtGLaNPhzQ6n+VfsiXMZYDesllv1G71XRIUTgpCUoCbOJ
 S/7qAxScpJna26RDWAT6wmwDR7KF6sO/iqIRD910rSRLM15M0FjhOaBlyn5jI5aV4hWQ3uTrthk
 5NlKOqBJlYt3qsaKSNw+L1rUnHm66chQamEJODRcgWqhHIXpRVMWfHuxS6MDvL6VqmRsKux1qpE
 EwreJfXXqWbiMqmKDChSu7HcyeZeL/0TBtFfw==
X-Google-Smtp-Source: AGHT+IFXfKGGyBNO33XWAbuMrovzc+3z7iEDs+65bFSmtcvF9nEVTJ6oegS6XZ37HP83zi08RkKEHQ==
X-Received: by 2002:a05:6820:620b:b0:65b:250c:70f0 with SMTP id
 006d021491bc7-65f54f5fbf1mr3899146eaf.47.1767982397356; 
 Fri, 09 Jan 2026 10:13:17 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65f48cb1444sm4386871eaf.11.2026.01.09.10.13.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jan 2026 10:13:16 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: alison.wang@nxp.com, angelo@kernel-space.org, 
 Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: me@ziyao.cc, daniel@0x0f.com, jserv@ccns.ncku.edu.tw, 
 eleanor15x@gmail.com, u-boot@lists.denx.de
In-Reply-To: <20251230160651.3049301-1-visitorckw@gmail.com>
References: <20251230160651.3049301-1-visitorckw@gmail.com>
Subject: Re: [u-boot-test-hooks][PATCH v2] travis-ci: Add config for QEMU
 m68k virt machine
Message-Id: <176798239604.1451963.15375169330601431658.b4-ty@konsulko.com>
Date: Fri, 09 Jan 2026 12:13:16 -0600
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

On Tue, 30 Dec 2025 16:06:51 +0000, Kuan-Wei Chiu wrote:

> Add the configuration file required to run tests for the QEMU m68k
> 'virt' board. This setup uses 'qemu-system-m68k' with the '-M virt'
> machine type and '-cpu m68040'.
> 
> 

Applied to u-boot/u-boot-test-hooks.git/master, thanks!

[1/1] travis-ci: Add config for QEMU m68k virt machine
      commit: 6cc3d2d90f12610f57d974b3d3295968c907e066
-- 
Tom


