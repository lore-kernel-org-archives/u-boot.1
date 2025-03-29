Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F5FC36008
	for <u-boot@archiver.kernel.org>; Sat, 29 Mar 2025 12:48:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52F25809A5;
	Sat, 29 Mar 2025 13:48:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=per1cycle.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=per1cycle.org header.i=@per1cycle.org header.b="P7ob0OQ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A2D2809A5; Sat, 29 Mar 2025 13:48:10 +0100 (CET)
Received: from mail.per1cycle.org (unknown [IPv6:2a01:4f8:c013:8d4e::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDAE58059D
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 13:48:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=per1cycle.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@per1cycle.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 676B93F840; Sat, 29 Mar 2025 12:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=per1cycle.org;
 s=dkim; t=1743252485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KxN6gxjPl2REsWmk52pMutqWdkQpeuEjncWCF/NUGNg=;
 b=P7ob0OQ2TpeTv4AbjJzJVgBAtYEG1+P93NhCsmGonHSYZhxU7HmYUn5lPPX9J/b3edRelv
 jAGmIEma/WqoeszEUjHmnb+hsGcjRdrKA3C/NL1k2kydRc778QqLWCdeuCPlBo8fxc5U/Z
 WQA5UZ2qleuFUNKr7yXtxcHx+sLW+142B5g+qLmZptXtLCHZFfeDtVONW83po4BFm2pAfO
 OicQGPT46qlmnkSyyMdbhOPPwuCtcYvip1OFVGZ/9+8OKFRdIqvlG1rGGf5XXil+bRrk5p
 w+9huVeMVo9vCiX3Z1lvIUG2jx2ihHNrpiZZJ/YpdPAAkXi4LYpfM+yqLGa4hw==
From: Huan Zhou <me@per1cycle.org>
Subject: [PATCH 0/2] riscv: pinctrl: k1: Add pinctrl support for bannanapi-f3
Date: Sat, 29 Mar 2025 20:47:58 +0800
Message-Id: <20250329-pinctrl-k1-v1-0-3083d7057989@per1cycle.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP7r52cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDI0NT3YLMvOSSohzdbEPdRHMDE9OkpBTL1CQzJaCGgqLUtMwKsGHRsbW
 1AKIiCJxcAAAA
X-Change-ID: 20250215-pinctrl-k1-a7045bbd9eb6
To: u-boot <u-boot@lists.denx.de>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Tom Rini <trini@konsulko.com>, Yixun Lan <dlan@gentoo.org>, 
 Huan Zhou <me@per1cycle.org>, Huan Zhou <pericycle.cc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743252484; l=757;
 i=me@per1cycle.org; s=20241231; h=from:subject:message-id;
 bh=YKrPXvs0hZT2yGlV6LF3rdm218qupubJ/D+Ggoin5Mg=;
 b=QPi0UtUjL3AqPuwgj6ppwXAXaSuE6G1iGLmnW2UOWysektprwoVPQYVKQi9355C0qxcLfbKyc
 OTITSoZGh47BzT/CQhFltes7stsGWpZ8S1wE5K2Idse5V5CQoRgpMaE
X-Developer-Key: i=me@per1cycle.org; a=ed25519;
 pk=LfN2kXe1uCRoaEzAJ8quXuPIH4MiEnZHOCRZwGytJwE=
X-Last-TLS-Session-Version: TLSv1.3
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

The series add basic support for pinctrl for bananapi-f3
which reuse pinctrl-single as its driver.

boot log:
https://gist.github.com/per1cycle/27aa0d4de732e96eeeb842e75168e0c8

Signed-off-by: Huan Zhou <me@per1cycle.org>
---
Huan Zhou (2):
      riscv: dts: k1: add pinctrl property in dts.
      config: Enable pinctrl in bananapi-f3

 arch/riscv/dts/k1-bananapi-f3.dts |  3 +++
 arch/riscv/dts/k1-pinctrl.dtsi    | 19 +++++++++++++++++++
 arch/riscv/dts/k1.dtsi            |  8 +++++++-
 configs/bananapi-f3_defconfig     |  2 ++
 4 files changed, 31 insertions(+), 1 deletion(-)
---
base-commit: 482aaebcabab35d2867e040d08fbdca6bbbe7a0c
change-id: 20250215-pinctrl-k1-a7045bbd9eb6

Best regards,
-- 
Huan Zhou <me@per1cycle.org>

