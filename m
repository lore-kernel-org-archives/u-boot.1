Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC48CD4F54
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 22:47:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D00A28486A;
	Sat, 30 May 2026 00:47:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oPQ7lhie";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 652AF846B4; Sat, 30 May 2026 00:47:00 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7D7780087
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 00:46:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-69de237f0a3so2220610eaf.1
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 15:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780094817; x=1780699617; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vUAqh2wIG16V0n/byZEsjUOJZBBlEkuYFpDM91ksptk=;
 b=oPQ7lhie0sM15aFjOoOcDETEN/ll+1CuLP0w5yMgr/CV5fBdrrZh1bNpyN3Oz+O06Q
 0G49HhySfvNSKNQhD+PMl4+GrD9NPd0MxUiAcbcmv8sIAH6I2JcGpQWPZ+s0B9N7GzLs
 phUGtkZq73wxmBVwkaLoQxi6ZjtfcJDdvprCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780094817; x=1780699617;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vUAqh2wIG16V0n/byZEsjUOJZBBlEkuYFpDM91ksptk=;
 b=aiD5b52aW5ttXRGsjPKhcWAKN44vfnpoETEHIjPi5QMTcLf/23//6BxGhNPlm3WOFp
 IBJ9LkTN3EVJvw3hD0Zc8Un1WcLhcYp2GgoB9Q1BNCchxWV1t/GrHTn36Dfgc8kfavwa
 4lDh26QBe1jj/GFa5szY/5UhnXwpTsAw9hVr/TIxapi3A0nioC4uubD9jL3JtJ864qU6
 GPbaZ3XjHp/aJc7P6fDn2EBpKGCn4Be6fzCjyv28YyRV84fCTdZiNm20qy3MynENtN4x
 J97eTSl2ET/ffrs3nROGVSbiGctauHpuiVUKtfKqn2z1XjrH3/NIBKqNhENWeRUQGGfP
 Rr9w==
X-Gm-Message-State: AOJu0Yx9K9b3DKiVFujN4CM8qeKS/ruIg0MDu5Yj9G2rEjujERZt3BAz
 njrSmmwjgp+rmZG6nucHsLNOztfUr9fcS24PDLIKzWb/19No5PwUAxjsIdtTYTEJ985/Ct9sCAB
 M1HrkDGk=
X-Gm-Gg: Acq92OFEJxKpfBJoOB7xtfSjB9HOrOSmyW/7SMm0vQfkPNhZllT6LNB5J8ZOdNe3/ya
 CWr6pOpQo7qdcOYnaSFu5ZVxGlZcmL9ynulLH2VTdRO6/YJcYWd0Qm0ntyidGp3TTVyiEGsizLU
 4KzpvCasSJXqDgjEMJBNocsniJjO7pvULs4aBNQ0mgJY2B6CsriWNB0hvSLS+aqT7qXs0QNfJx1
 zlPNK1gOWSIECuNqaXw1xwzdHS+YO6DOH+CAPhHLMXsnEpDD64e3EAD48daxk1rHcO/P9SlHAqD
 LWwx+a3tFotPRHcwKSE2Gxqm7OKVA1U8EsLG5ZBIoARicAeTzG3WKh5/V4BHjDXz/+H10NAc8Pq
 eHP43xzRTpNBiL+VN83pO2xBqCQ4Dxb11xoJN3s2x+K2QwmrAR4ZFfU7fqtLjc5zvtR250jdmdk
 5trGG7ScjmCPte5hAHF+O3hCx9V6/83RUN2tf5PZemmnETg0o/qYzIj45pEqBmKSXtEeUmRpj7k
 f3gp+P69ZeSxGc3MNim1+wfZouFeSAnhbp7O2bQK/U4WfnOuOB3nkc=
X-Received: by 2002:a05:6820:162a:b0:69d:e478:b7a1 with SMTP id
 006d021491bc7-69e102c9ab9mr679048eaf.6.1780094816649; 
 Fri, 29 May 2026 15:46:56 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69e0696923bsm2112441eaf.11.2026.05.29.15.46.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 15:46:56 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: d.haller@phytec.de, peng.fan@nxp.com, jh80.chung@samsung.com, 
 m.schwan@phytec.de, Wadim Egorov <w.egorov@phytec.de>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de
In-Reply-To: <20260513071905.83522-1-w.egorov@phytec.de>
References: <20260513071905.83522-1-w.egorov@phytec.de>
Subject: Re: [PATCH 0/7] board: phytec: Update rm-cfgs, env and docs
Message-Id: <178009481583.728062.13837728271053859889.b4-ty@konsulko.com>
Date: Fri, 29 May 2026 16:46:55 -0600
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

On Wed, 13 May 2026 09:18:58 +0200, Wadim Egorov wrote:

> This is a small updates across all K3 based phytec SoMs.
> Update docs, rm-cfg yaml files and drop rauc environment.
> 
> Wadim Egorov (7):
>   board: phytec: phycore_am62x: Add tifs-rm-cfg
>   arm: dts: k3-am625-phycore-som-binman: Enable tifs-rm-cfg
>   board: phytec: phycore_am68x: Update rm-cfg
>   include: env: phytec: Drop legacy RAUC boot logic
>   doc: board: phytec: Fix typos and copy-paste errors in K3 docs
>   doc: board: phytec: k3: Document boot flow and watchdog
>   doc: board: phytec: Document DDR size override Kconfigs
> 
> [...]

Applied to u-boot/next, thanks!

[1/7] board: phytec: phycore_am62x: Add tifs-rm-cfg
      commit: 6edb2e1ce24a59cce2f1237a7c02274d0e5deaed
[2/7] arm: dts: k3-am625-phycore-som-binman: Enable tifs-rm-cfg
      commit: c2edb9cb2bb3a59d4c01beb8dc0e33ed5b357bb0
[3/7] board: phytec: phycore_am68x: Update rm-cfg
      commit: 68532aab6d37260bf74dc8b9035012e84f579e6f
[4/7] include: env: phytec: Drop legacy RAUC boot logic
      commit: ef5b4a7eae278afd2fa173f886159983a81db096
[5/7] doc: board: phytec: Fix typos and copy-paste errors in K3 docs
      commit: 86f4f05ad871e8af0f021c3614802875d6521f3e
[6/7] doc: board: phytec: k3: Document boot flow and watchdog
      commit: 14ba26ebdda6bf003eac5b18d59ccd3808345fa5
[7/7] doc: board: phytec: Document DDR size override Kconfigs
      commit: 6e8d82b9e9bd3418614a884a1cbc2dbda6ca4e64
-- 
Tom


