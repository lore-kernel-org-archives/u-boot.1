Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A1DDC982E1
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 18:03:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7E50839B1;
	Fri, 16 Jan 2026 19:03:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FizL9gC+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43C5E82BF2; Fri, 16 Jan 2026 19:03:15 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8D4E839AC
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 19:03:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-64c893f3a94so5923106a12.0
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 10:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768586592; x=1769191392; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=D/8ef6h07FRcZWroeW6XAVwSID+NoRtNSV12CCeTR8k=;
 b=FizL9gC+26IRN7BSoynn61ZAZUBXE+a8MU2kVzcJszA1bwZy8V2I/YDs+Xa3dz2DcJ
 0m/rHDZJ8+Ye2bFq/jzhhYpPUuZ/T9AYT5MIkpdPv6qzuUSJg5xUG272y3nNWhVO1w7T
 9EmbaKdF9SRbQsQ3koIl/b9Nbqog2iY9V3K1YjsxuETlJnj4LN5+80A+Rz/EyCJskP+/
 pFoHIv4tF4LNJaIJJhcWv2RPp5ER993xz8nyKhCIzJ+e+3AXE5AKmqMBPNFVDILRSsIM
 0jjfNoQGYO+cVYebZGzpDO/5OB/9T88vCLg5YMdF0677OIPcIjbSnzTFoLLQXGzNCnVL
 12DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768586592; x=1769191392;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=D/8ef6h07FRcZWroeW6XAVwSID+NoRtNSV12CCeTR8k=;
 b=G2MhvlgFpx1ZgTfcz7fz//tBZn/z/ahWrDtWtkZUKf6v2D3ov5s3z5nA19x1oTM4Er
 /kIVm/3qSB8GvT4VkrErLXDJeWyihX60Zs0DojCusNG1wLlWlrm3L7PCLTvmHNka6Bs5
 7qS9mVZrmExg+065JTSwZK/bDfcWhRcsUslillbyCMkQO8FetUwEogttmvILCePckaiF
 3rsTdmQTPqk8Tq/njVvNPPOdZcVvvqoWjMy711z3i3oda6cx3YCZtkxOFcY+ykrGw8BM
 pbS6vbQNdLBfNqV0oPN2LCHtj3StpXZ0IUutxG1TUuTLksWPGfVfZmbq5noNm0hJWSci
 yeMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsAYtmGl9culLO8bYZtYS+zFGjuGJllsIXFaZ6uzt8DjIY/PJBuwveSBcA6tBtoUzxCctkTUE=@lists.denx.de
X-Gm-Message-State: AOJu0YygcytVM87qreGkZi4nNq9ret6zqtW2aq6/ho9NLUvA/rOLFfLo
 pvc8nwuRWzHuJDtLzkryT71S1ydQFaoP5y56ki/P1BRsTw/O/AUjoazcbCnE/zP3wV8=
X-Gm-Gg: AY/fxX6yxUXugpNLt5fj0x4w38cJmSWOm4nVBG40dATUuh/GaPQO7cSYRNvA/zIualR
 Lx8iE6DtOyv/oY7P/FN7sytY615tuDtZBXm10cpYmsXiSTzHpKPaSB3rsWMuOxCkVfK0iie0+MR
 rXmLZE3U6gxK+VNdgshT2M9leCBYMJUleDAhLJinudQhCu6UI/0BU9NqTMHI2qJz1dRftfsPTGE
 AZMM+qQXQo3YsKEMHaJdLRuqi+bTayRw+bO0hpVqIUW3XTWRSa5fFiidBEGiPAVHdt8FBeK5jyj
 8pbuhyI9p8kCJgLCyBBlii1SpLRsadmjS5r9z6PqrTYugmvAhLmVBLgM3UndUUofAPVLcsEHVMH
 Db/2URHYWd/yLhJB6pUotVNkitT8WP6dWlVpwYGVLKOm6DWj45g9SeVWzeCcmJZPfYdr+jRImeJ
 jYPXFZ8Pl9gHwngcrwZQGdFxf/i56ZPUMsyQopNUE7NKPJf16FW1DbMg==
X-Received: by 2002:a17:907:971e:b0:b3f:f6d:1d9e with SMTP id
 a640c23a62f3a-b8777a0b163mr677394066b.6.1768586591847; 
 Fri, 16 Jan 2026 10:03:11 -0800 (PST)
Received: from lion.localdomain (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-654533cc5e1sm2932712a12.19.2026.01.16.10.03.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 10:03:10 -0800 (PST)
From: Casey Connolly <casey.connolly@linaro.org>
To: jh80.chung@samsung.com, peng.fan@nxp.com, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, trini@konsulko.com, luca.weiss@fairphone.com, 
 quic_varada@quicinc.com, u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20251112164204.1557934-1-aswin.murugan@oss.qualcomm.com>
References: <20251112164204.1557934-1-aswin.murugan@oss.qualcomm.com>
Subject: Re: [PATCH v1 1/1] regulator: qcom-rpmh-regulator: add support for
 PM8150 PM8350 PM7325
Message-Id: <176858659054.3399278.1992629537791902380.b4-ty@linaro.org>
Date: Fri, 16 Jan 2026 19:03:10 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773
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


On Wed, 12 Nov 2025 22:12:04 +0530, Aswin Murugan wrote:
> Add the PM8150, PM8350, and PM7325 regulator data found on Qualcomm
> platforms. These regulator tables are imported from the Linux driver
> to enable support for these PMICs in U-Boot.
> 
> 

Applied, thanks!

[1/1] regulator: qcom-rpmh-regulator: add support for PM8150 PM8350 PM7325
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/07e66ed61918

Best regards,
-- 
// Casey (she/they)


