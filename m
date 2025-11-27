Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E68CFD2F6
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 16:56:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8CB284462;
	Thu, 27 Nov 2025 17:55:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cIKLt18Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCA0C84462; Thu, 27 Nov 2025 17:55:48 +0100 (CET)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A94C583B27
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 17:55:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-3f0c93ecf42so851598fac.0
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 08:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764262545; x=1764867345; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oR/MGbOleMxTomSQSQJzkh2PysIR4F1JiFtffZm3uPA=;
 b=cIKLt18ZDworyCmqhPJm7r/ALB4qdmph/lmWkvF83t6xb+z+3xmdtK1ebPILcAS6Xp
 oirz2p8zCB+jol8v9UYBvWRR0/lcUoqJ4jr+g6vpswTlEjlWOyYqcsfnhRPeob8P6trP
 YfVHwarl+MwLYIn2cyI0wSwP3LK4t3jImJOlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764262545; x=1764867345;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oR/MGbOleMxTomSQSQJzkh2PysIR4F1JiFtffZm3uPA=;
 b=eybixG6j6koVhNHmSxMzFdLjDF+qbsC4pM5XPTvTYIBz1sROZOwZa+BqzsZjUX2hWN
 wGNrDspx5yNU2+xmXE4Dveu6v5DSWhDcAxJhC7F885fbFsQZW5dD/6mbxqnlUJ9ADrBu
 X58Zub7E9EsTkKc6eQKK6ym8jjJDc2uCt+8FglD/SGZD0aZ/GdKTi/9h8DRUm1lydgOF
 a7vbNt/o4ed1tqPxssupgrN1Ljt/UKoAS395k93UgRQDlQf/FtSEfUkSbrx3e0z/OkCw
 mkZtjDiuKaJjb5yvU97kNa2wCnzOzLBefhgR1AQzOnDu7mQ1i9Uvpf/qAB+xgYL3H5IK
 tGrQ==
X-Gm-Message-State: AOJu0Yw1ua7npGbK6x3k5CfITs4VXz5s/xhk5FjZTT9Zhx4chX5R5qIK
 kAqZRlzNI59VDfHPNUjtNk8dQal1JQ+j0ClMoMrPJ6E7c0OZ4QvtDyuPR2in6OHMJefIrFJnCnT
 gXJuTHQI=
X-Gm-Gg: ASbGncseakLNrYDZnSJ0cJtXYJnxoQmoyDaNfFBXaxU5lNe0HxdbKlwoE3nz1KzL7iY
 8R6yWicmGcV9lPVumqewkR0ybs9oGwlCYzrz1298lvuODFYXJctoP5l0ywHtypRAIjnEBNnORc+
 Ghaq+I6Fd1LirHzFFHeh65zAZAzSEu4HU10Z7OGkiQbI71ZYnMdIAOibK4N8SazslEmll8HRnYY
 yDAvQOYlCPBArBZuSMokBvf2tH/AuDHUaNFnaohaUY3QvmsXUMeDlTDoiYxOiAL+ubhmbaNeZCt
 Oea0pKj/cle5DHMx2RdL/QRKt/XbXZ8us9qUk22e/SakQViNI4ltPQCcyFF4xe4AuNn1z9T2egD
 9zEEnrTI7K2ezybRzkSq6t8CntdvjMlRJ4eSqGWJ5cM8FiQR6JxqfSQoboV3c1xkmpfwN689+mU
 dIWIGWk3EvXUGTOsDVXD8VB8gDvr8Z/jMwj0Q3+22fxw2CfbYK
X-Google-Smtp-Source: AGHT+IF9zAUIrhQbAWCcRXXYP5WvuwBbwc0E1UqVI+7O7lQkJHbNSXVktAVWBvFBky930UhZ72/IEA==
X-Received: by 2002:a05:6870:a40c:b0:314:9689:a467 with SMTP id
 586e51a60fabf-3ecbbe338f7mr11628718fac.23.1764262545465; 
 Thu, 27 Nov 2025 08:55:45 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f0dd05e0afsm741584fac.20.2025.11.27.08.55.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 08:55:45 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: jh80.chung@samsung.com, peng.fan@nxp.com, afd@ti.com, m-chawdhry@ti.com, 
 u-kumar1@ti.com, t-kristo@ti.com, h-salunke@ti.com, 
 Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: u-boot@lists.denx.de, srk@ti.com
In-Reply-To: <20251118122055.1972591-1-s-vadapalli@ti.com>
References: <20251118122055.1972591-1-s-vadapalli@ti.com>
Subject: Re: [PATCH v3] power: domain: ti: fix ti_pd_get() to return after
 verifying transition
Message-Id: <176426254450.4117678.14321544737968554197.b4-ty@konsulko.com>
Date: Thu, 27 Nov 2025 10:55:44 -0600
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

On Tue, 18 Nov 2025 17:50:52 +0530, Siddharth Vadapalli wrote:

> The helper function "ti_pd_get()" is responsible for powering on a
> domain if it is powered off. In the current implementation, if a power
> domain is determined to be powered off - no prior users and the PDCTL
> register indicates that the user desired state is OFF, then powering on
> the domain constitutes setting 'PDCTL_STATE_ON' field of the PDCTL
> register.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] power: domain: ti: fix ti_pd_get() to return after verifying transition
      commit: e3b7dd93d39e1c0a6bcf95d13b3ac4e8035c5db2
-- 
Tom


