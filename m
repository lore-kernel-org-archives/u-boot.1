Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB9E2C021BF
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 13:49:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E97F080FF0;
	Wed, 26 Feb 2025 14:49:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="O4MfOO10";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D0B180FD1; Wed, 26 Feb 2025 14:49:22 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E03F880F56
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 14:49:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-439a4fc2d65so67105885e9.3
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 05:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740577732; x=1741182532; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AcsINHS62qfPYYKlG+9MpTD4HT/XSkvhdF0PnK6Met4=;
 b=O4MfOO10yk4oCp0K0u5h2eGtZbhQMABtgvIGdAE0UhKxtarDBxwtsCJB/4kNgGs4li
 ktJp311GMbrDMfverePtFqjv8k8GNK2SfK3EhtRtDyP6LYCT1HtaayZZmADoToo0k3DK
 OvfA/1R6h4Gqt4WhO9d2cx/LF1SBbBPL4NDrtnio+xsxul+lwCTIDSgJgKXZA5WUpNYs
 bC72xDZO6OdMcEa/KmOokFwdgzGaDk3VRTdOnpiYHD1+7Cdvt+4LaYUYK3vbGI/YQF7g
 UlLBGLk8oPCtz0BBi4vanrI66LeyTO1eTeatsIsBa4lo4R63zecjFiiYv/OsHCcOAa6K
 vsGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740577732; x=1741182532;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AcsINHS62qfPYYKlG+9MpTD4HT/XSkvhdF0PnK6Met4=;
 b=nTGnhDIGog47WtEORTiLk2Gv8fkbbCRk++qlpbiJvNb4U7gVYBpGos3b74fsBA9jfX
 Wz56Abu6VHMh9zI6YsnyJo7VHjEEmKAV8PwS7uTRAk2gcHBz3QQkCLxza5OtaX9r/mkj
 wKpnV1yVBbA6QLNZjj3PHS3GBIsYFGUw/TIkimcKHw6KWR/CIWtKMMjzuEEX3ViVrhfk
 kThcD0/DPCpOfd5Y5t/p47EhBsl7NAOf84pT2tNioXo4tdrqD4kekleGO5/ypiR7h3Y2
 tBu4zinnl/RZGu1KBfDzVZ6yxewq7+Lu2u8gIYtBqtb+092s3DkY0IbnOe9PQmADiUdd
 2ymQ==
X-Gm-Message-State: AOJu0YwUP8pzE5VBwzjBgqEmeWq9QGaYHwEz5RH9AAj4Qcpz6g8REZEn
 Zc/PLwVS1k//T9hYswaFeNMTdxUtTxLvaWQyMsRXrHGlE45yz5tMFDQzDKo6G/eFLAC8vw8TOcl
 r08c=
X-Gm-Gg: ASbGncve0LC80E+sO7hNKB9KanUPzwAWPKD8RvSjTCz75fU2N9VY+Uf4Xp/RMLUgOAV
 U0clsovnGwwKGBstiGFMQ5ttZWzyKowoZUgM8pVAw3PiWRL3yj9tdaLDaTjxCBt4lkm5v7Vaukc
 gcSKO+e0ZIRKNkQD3dHPGjsI2ie/wHpJ7IBEvK0LChe+hAP1/HDMB8Ds4P+I79nE9UWLsoD16/h
 Qe2NmcjsAxlg329pf/4SezgKvwmbf13zCaSLT4FXxkb2g8oWgcH5s/VEi8QwIwXWZ1Sc4DgE6XF
 Ym0n+JaeHtX8JPX+0WTCh10pTZTu6y6L5mpgZ20XsUOCQAnlERVvu0rSXO7BsA==
X-Google-Smtp-Source: AGHT+IGBauZJL+aNOLNok3fnQzaA85j3gRhDa9CRiHko5OCs+yLo03hPpslOH069HbCIKz8RIeqMrw==
X-Received: by 2002:a05:600c:154e:b0:439:a0a3:a15 with SMTP id
 5b1f17b1804b1-43ab0f3c907mr92682045e9.14.1740577731663; 
 Wed, 26 Feb 2025 05:48:51 -0800 (PST)
Received: from toyger.caleb.rex.connolly.tech
 ([2a0a:ef40:1d11:ab01:3b78:3dbb:221d:d3e2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba539450sm22106625e9.21.2025.02.26.05.48.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 05:48:51 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>, Sam Day <me@samcday.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250203-ufetch-vidconsole-colours-v1-1-a9e543ef4cde@samcday.com>
References: <20250203-ufetch-vidconsole-colours-v1-1-a9e543ef4cde@samcday.com>
Subject: Re: [PATCH] cmd: ufetch: use 3-bit colour ANSI codes
Message-Id: <174057773076.26167.15654271156475532150.b4-ty@linaro.org>
Date: Wed, 26 Feb 2025 13:48:50 +0000
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


On Mon, 03 Feb 2025 16:42:20 +0000, Sam Day wrote:
> Currently, the 8-bit escapes are being used, which aren't supported by
> vidconsole_escape_char. Since the current usage maps directly to the
> 3-bit equivalents anyway, let's use those instead.
> 
> With this change, the fetch output looks as fetching in the vidconsole
> as it does over serial!
> 
> [...]

Applied, thanks!

[1/1] cmd: ufetch: use 3-bit colour ANSI codes
      commit: 6267ce556595e0586aee3a7d63042d105dc3fa4e

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

