Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 063D8D3F074
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 15:20:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4426383FD6;
	Wed, 28 Jan 2026 16:20:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="st6w5q0p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3910D83FD9; Wed, 28 Jan 2026 16:20:46 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB88A83FC6
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 16:20:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-45f0dbe7dafso260766b6e.3
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 07:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769613642; x=1770218442; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u3Ds+NqhFSkfOZpHry1oitHM5FUTUYhcMNSpKOQbkYQ=;
 b=st6w5q0ppu5wlRHdRTwb8xhRiqYVDo3/+e3NPc61k3VJ0lse1dWTkrHHwy3LmAWqPr
 QF3FlVVAU3rR7lqL+wNNgn8oBpxuWhdJ0tRM5jBFZKthD5LvXBBBdOk9fZKcoGAnZfAc
 uqZ927dBzrpJI1fxdjHHexr2MWCQ6IMZ8HeCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769613642; x=1770218442;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=u3Ds+NqhFSkfOZpHry1oitHM5FUTUYhcMNSpKOQbkYQ=;
 b=bPTzbcZz7LoomkS5fSt/FNI0DTGT95x4X1PT9p2Q3l64mN1vQaTPvwacnd3n3xzBNA
 Q9lx1KIEwIt9MMcqDZQgwv6aCcKDwg8Xc+75ewWZ/vZ3varrQnR4SMcxTthYuVemVOsB
 bMDl76+rGGbJjBF/2BTBF3hKvQrERR8Y6K9eKggM8+8l3dj/Vga23LfaKbk8DXEASasI
 SgDiL0zaSPbp1Wa64V3nNwn6WZaDNn3Fw6s+Zaib8idOjnlSNIUyCF6vBaAMee+2nwUV
 Vtm0pYgxnt/m+gwY3blC+47SViugWGqfmBxPTu+23mbl5+0RVKSLiXgCObd+QnSt27bp
 jq6A==
X-Gm-Message-State: AOJu0YxmsJEwJN/mP1BqYyeqt6rJp3zxImJIZRsqkgNlSF5SY6AUzFrg
 IzSzK11Yy99WMHw9+f0OpCkeTj3l2HphLgsICPGYZPUk5mDA/aLldGmDxej4DjxprM3RUg1gWTa
 QLsG4ZaU=
X-Gm-Gg: AZuq6aKnc29N0PGF4Gs4nIT75p1whqO0z0ehjqxkSVvwuFtA+Mad+GCuBGbhpuBcZNn
 pu6fl84UIjjKuz1FZwudBi61aderJWNtAY+/Xe0qDCT2jrIQon0cM0iW6vDZwBYMdBWKKJGvAwT
 JHOo/Ar1n9bN6369nQ83qmDogbFCkMyedb2aOKcB4EWGuV1DhM+66XJp+H1L84268UoynpSbR5/
 DWfokrK1ILv/47FivcwqZ8lVuJMWR9xo+1KGkHExJng+tyQdmffETMMDpBoCWh4laq3VYXF1E2I
 CIIr8DqaK1hSt5kybItpArGrLurE80JlTJYGx8+czAogJxMmThrjsbJW2NPAl5kJUlRxIS8uFnV
 DM/JmjT2RH6oQwpF2L8GVUI9u6iWpcn6cU2mq34qO8IEVkhdsc/WA2N4p8JmRdrTBc4vpadlcF1
 S/eBJlQSqbuSn+DxdDgUugFeq2mzLIazuAeNqCzkwjl0yvRwzdbzffBxURK0AlIuw5XnW+oL/bz
 QdcQrOVDZ5wwyIHSTfWqUUKKaQI7t7SoTwaag==
X-Received: by 2002:a05:6808:1909:b0:45e:a57b:b4ca with SMTP id
 5614622812f47-45efc5f4612mr3206665b6e.17.1769613642440; 
 Wed, 28 Jan 2026 07:20:42 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-409570f1273sm1976935fac.5.2026.01.28.07.20.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 07:20:42 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de, alice.guo@nxp.com, mateuslima.ti@gmail.com
In-Reply-To: <aXm6yY-uf6rpXsu_@nxa18884-linux.ap.freescale.net>
References: <aXm6yY-uf6rpXsu_@nxa18884-linux.ap.freescale.net>
Subject: Re: [GIT PULL] please pull fsl-qoirq-for-2026.04-rc2
Message-Id: <176961364172.1657136.2956085734075579536.b4-ty@konsulko.com>
Date: Wed, 28 Jan 2026 09:20:41 -0600
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

On Wed, 28 Jan 2026 15:29:13 +0800, Peng Fan wrote:

> Please pull fsl-qoriq-for-2026.04-rc2
> 
> -------------------------------------------------
> Rename freescale to nxp
> Add CPLD support via IFC to the ls1021a-iot board
> Use scmi_clk_state_in_v2 in sandbox
> -------------------------------------------------
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


