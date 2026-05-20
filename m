Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27920CD4F3D
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 13:08:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB8CE847FD;
	Wed, 20 May 2026 15:08:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PpG91sVJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D68D684836; Wed, 20 May 2026 15:08:03 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E051847FD
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 15:07:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so52476945e9.0
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 06:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779282478; x=1779887278; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fy/nDyeme7/tH+vj33142+e885GJa56qWQVmKzO9t6M=;
 b=PpG91sVJlVIRqvRQaIJ9Ge71aTwWdnUARdJ3iSg7n8CvPh9nbwOHij0ZFSZGIyCcCb
 Drzso8X97kuoV7dFt+4HO57zFCD1dCIViSCVN/5/g7TFXJKfmzceEfSZKkgySe1KIstN
 J9acj9CEx7IN21wXEq57EB2cm448uvgIkaYqcCH91EzxSx9GytOSc0I7B+kQqLlBNJmQ
 CHPiyX/WhDPnvrlCsq0kmqJguEgxL06MOEv/qKGvnFbUBNtcyWwg5tq9gCULa+CYpV5H
 MJlc1890UthFlpYLmUjG3vUnVg+HtUh/js9jzqCCYNRCssmKYgZbg44yBc7irOadolIU
 gD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779282478; x=1779887278;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Fy/nDyeme7/tH+vj33142+e885GJa56qWQVmKzO9t6M=;
 b=He+KlxpYl7hSUOYMe0rvIQCgoqrljMaGcRfOVO0yBx2wLmo9ZM2MkHa/0wwNAXauhS
 KMIeftgm2Ls34O3mOfJn4yAm+L7LQQMGQXBX/JDxfiV57ydQ+BK9u+6borgSZAiugzrT
 W0T0QWdz/1JDVlWYe9aWzHsXnJfayKCBNKLfj9Nt/1jtrUXUSArhM3bkwu12hlc1czIf
 7H/kwlNR33ufqFpDixzA1gqUoxlR04wD41oLQ0yUC61XgLXovA018WnquXY96Whgdf1W
 l/bT8g+6h1eNkRkKNSzmzM+dGmJjWTDB7FcP4qlRfDboY0pt3dRRZJVO0BflDVJYEvHv
 +XDA==
X-Gm-Message-State: AOJu0YxVqqwbLvBHUJHYZU2jmrRbIiq+fCwglGQMT8degBosEhtNCoe/
 z2mitX8FoHchHYrTN1RlNurMXVu9oO3ijOTqcsnZMuyIDyUO5WolCo9etQXujVLut04=
X-Gm-Gg: Acq92OGsi4gjV2Xk90FsO1XsGup86DglBMZRpHLrSCXsOG3LZuXDj8/VGPrvhTK01oo
 /KrB6q/6YrmO0ALRNn2H2M7QvDr7DBPPxH0W/mGmaaDcYsDCS9djkwWEMMaMMd6bbxMwDrbfrzB
 wV/K/eR9yk/uQAl2h/9P2IXSrKxAkV4DvQS0MCBECSzryj+N9KsLTWCLxKGHe62jwy0wRCHjv2A
 vfQmlMO3m/tY1ePMfFB8W5iMxTr+RF4MTvWzS1hSaRbF+qyrtGI5zSKdcQQ9QJNhlJrMHjsjVEJ
 tnwsvDitGlWm7d7bSuetclH4ybEjSl4GzrXPRirz+HnoHvkFy7/Fk7QxpCITJcnQ20sXwk/GIHH
 kMlZ8g55ludaSa93c4EeAhVrX4MFvSQECRmujAaJ4TTFAdSjnKPq+6xoi+bSUro9EqOPxJbdrkS
 OVQDGtYCUkPNSfwEWYhK6/5a2d/bXhQkkSfazSyvat1NfvpTxrzbzDtVs=
X-Received: by 2002:a05:600c:6206:b0:489:5022:39a4 with SMTP id
 5b1f17b1804b1-48fe60e79fdmr379805335e9.9.1779282478170; 
 Wed, 20 May 2026 06:07:58 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48ffed60c8esm97613735e9.10.2026.05.20.06.07.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 06:07:57 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260519-u-boot-pci-nvme-maintainer-v1-0-363593cbbfdc@linaro.org>
References: <20260519-u-boot-pci-nvme-maintainer-v1-0-363593cbbfdc@linaro.org>
Subject: Re: (subset) [PATCH 0/2] MAINTAINERS: add myself to the list of
 PCI and NVMe maintainers
Message-Id: <177928247741.3007879.4025307178137126529.b4-ty@b4>
Date: Wed, 20 May 2026 15:07:57 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1
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

Hi,

On Tue, 19 May 2026 18:08:33 +0200, Neil Armstrong wrote:
> 


Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-ufs (u-boot-pci-fixes)

[2/2] MAINTAINERS: Add myself as core PCI maintainer
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/8738feae3079b2cca39d28c4360ab89f072bedf6

-- 
Neil

