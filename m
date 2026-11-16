Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C966606A8B4
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lYoQmyio;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=sTdTeidC
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E174540810;
	Mon, 16 Nov 2026 17:52:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1AxzVoOqrN0Y; Mon, 16 Nov 2026 17:52:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B2DE140808
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794851565;
	b=QUtTfYm37oW2TqOM0iTYAqTLYjqbd02Dg8rdCRw8K3YzwfJSyaeA2qUr0XgnRmJrfKaV
	 iWAnMJKSj7GPDaDTtT2qbTCNdJFVnw8Lb1W5YLwCpdu0RZnKS8TX5sMUWf711U5vRSKsG
	 CXxEmUmJcWoFxyUmbRJXcp9zD9pJqqofNVSXltohQC+w+/vhl6l0oiz3U9IXsHr/h4vR2
	 +Sc/1G9o9n6lAAc7DHM71VVQ8CEwcedlAg/imtOt+Jcl6222aUHK+tX4xMrFiT8arvW9B
	 GnoOjt7WK5w2vQ4lnVdtLQZaE302M7L8GmbJtITQ1bXM7DxAaur8J+yH6sJXn5rYfqA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794851565;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:X-Mizu-Trace-ID:
	 X-Migadu-Flow:Date:From:To:CC:Subject:In-Reply-To:References:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=XPoIOcSTlHyVWITzPZRGBnV0S/Zz2xes1rUB/6K8ZaA=;
	b=RjziUOkKULjEb/Z/kI0b8Z/g33PB/7ERhjWMAPnLre/+4f/NybxU8+hshl9VkXzF4Ses
	 IeNO0AgKjmyHCgXBg5Qy+XY3l7mVL04Ud5xbSmzI+piIpGfVbm3PhlUzesOiOBrL3DNAt
	 dTh8gwcvZvJxkPR0SqBjiZWqW5GjvbCraxzH1hCqeaszhJIGDfNGp11NATVYITLFV/s+M
	 HEz3CRAR756ikGSkvhuW9IfOdwGmwb67qcyaWdW1QadlEM1qjH3H4lMVZGi/D+GOcUs00
	 I+95nGpVwkjpZg6dWtAq8IU5I7MJ5byyimC5Hi7xXrxgtdFufmIbk8vz+gYhf4BBRGw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794851565;
	bh=XPoIOcSTlHyVWITzPZRGBnV0S/Zz2xes1rUB/6K8ZaA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lYoQmyioXEVtzWHricI+tTY7rmdIbRTKuiI+C8BC7kZ9ccTSdhuT9gwUsUcXZP3rZ
	 i05lyiAJFuLNo7qbA4cGY9jGOHYdAafaKpzw1C6LNdM5AkWnIxdesayFVy3cqvUsIj
	 lVs6Yq24M5duXyxeCPknki6jfoVPEvnet7NJHYyeFzmFZqvbRiPVEaUwHq1qWYCeXG
	 vCldwY4INvo/Q6Wluvg6YNAmzHbHg3T4XkNrHcyGop7FN6WLIg4eDKNqxv3yQbLutp
	 O23z/MRQWzVo1tL2WLrTGuupS7p8Fj2cb9FhQ8X0aYv3HG6lTt/fKjtd+OrnWlRPKV
	 qR3nl35TUCHAw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B2DE140808;
	Mon, 16 Nov 2026 17:52:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A1AB0176
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:52:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 87F9B607B2
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:52:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jw0WMri-g1-4 for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:52:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 94C6560763
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:41d0:1004:224b::19"
X-Greylist: delayed 216 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 16 Nov 2026 17:52:42 UTC
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=sTdTeidC
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:41d0:1004:224b::19; helo=mta0.migadu.com;
 envelope-from=bradley.morgan@linux.dev; receiver=<UNKNOWN> 
Received: from mta0.migadu.com (out-25.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::19])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 94C6560763
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:52:42 +0000 (UTC)
X-Envelope-To: u-boot@lists.u-boot-project.org
DKIM-Signature: a=rsa-sha256; bh=PuBiiNYx2NYnnaQOelJjt+1fhu1XYvyAiWrKVI0ZkVU=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794851559; v=1; x=1795456359;
 b=sTdTeidCjZSDkuv0k8I7Xv+1NASSYt6W7/dqifOGTIPwj1oAVFFXyGKIN2+kNtEpCJzMn26H
 mJFwRM5O8Y1S51RUdXPuBcjWTDsK7yUFCZsDKM/MztdGAVo6DWz+DQO4IEsWCi3v3gLSVRCP+fy
 YUBLnnkGdL28ko3X+n6fskIY=
X-Envelope-To: u-boot@lists.u-boot-project.org
Received: by smtp.migadu.com with ESMTPS id 51cbc3b7291fc240;
 Mon, 16 Nov 2026 17:52:39 +0000
X-Mizu-Trace-ID: 51cbc3b7291fc240
X-Migadu-Flow: FLOW_OUT
Date: Mon, 16 Nov 2026 17:52:34 +0000
From: Bradley Morgan <bradley.morgan@linux.dev>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.u-boot-project.org
CC: Daniel Palmer <daniel@thingy.jp>, David Lechner <dlechner@baylibre.com>,
 Eugen Hristev <ehristev@kernel.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Hiago De Franco <hfranco@baylibre.com>,
 Julien Stephan <jstephan@baylibre.com>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Leo Liang <leo.liang@sifive.com>, Mario Six <mario.six@gdsys.cc>,
 Max Filippov <jcmvbkbc@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Tim Ouyang <tim609@andestech.com>, Tom Rini <trini@konsulko.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Yao Zi <me@ziyao.cc>,
 Zhuxu Ran <zhuxu_ran@zohomail.com>
Subject: Re: [PATCH] sysreset: Constify driver ops
In-Reply-To: <20261116174340.3488324-1-marek.vasut+renesas@mailbox.org>
References: <20261116174340.3488324-1-marek.vasut+renesas@mailbox.org>
Message-ID: <961249DD-CA92-4401-8B07-BD925B44B540@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 16 November 2026 17:43:33 GMT, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>Set the ops structure as static const. The structure is not accessible
>from outside of this driver and is not going to be modified at runtime.

Acked-by: Bradley Morgan <bradley.morgan@linux.dev> # PowerPC 


>
>Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>---
>Cc: Bradley Morgan <bradley.morgan@linux.dev>
>Cc: Daniel Palmer <daniel@thingy.jp>
>Cc: David Lechner <dlechner@baylibre.com>
>Cc: Eugen Hristev <ehristev@kernel.org>
>Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
>Cc: Hiago De Franco <hfranco@baylibre.com>
>Cc: Julien Stephan <jstephan@baylibre.com>
>Cc: Kuan-Wei Chiu <visitorckw@gmail.com>
>Cc: Leo Liang <leo.liang@sifive.com>
>Cc: Mario Six <mario.six@gdsys.cc>
>Cc: Max Filippov <jcmvbkbc@gmail.com>
>Cc: Michal Simek <michal.simek@amd.com>
>Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>Cc: Sam Protsenko <semen.protsenko@linaro.org>
>Cc: Simon Glass <sjg@chromium.org>
>Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
>Cc: Svyatoslav Ryhel <clamor95@gmail.com>
>Cc: Thierry Reding <treding@nvidia.com>
>Cc: Tien Fong Chee <tien.fong.chee@altera.com>
>Cc: Tim Ouyang <tim609@andestech.com>
>Cc: Tom Rini <trini@konsulko.com>
>Cc: Weijie Gao <weijie.gao@mediatek.com>
>Cc: Yao Zi <me@ziyao.cc>
>Cc: Zhuxu Ran <zhuxu_ran@zohomail.com>
>Cc: u-boot@lists.u-boot-project.org
>---
> drivers/sysreset/poweroff_gpio.c           | 2 +-
> drivers/sysreset/sysreset-ti-sci.c         | 2 +-
> drivers/sysreset/sysreset_ast.c            | 2 +-
> drivers/sysreset/sysreset_at91.c           | 2 +-
> drivers/sysreset/sysreset_cv1800b.c        | 2 +-
> drivers/sysreset/sysreset_gpio.c           | 2 +-
> drivers/sysreset/sysreset_max77663.c       | 2 +-
> drivers/sysreset/sysreset_max8907.c        | 2 +-
> drivers/sysreset/sysreset_microblaze.c     | 2 +-
> drivers/sysreset/sysreset_mpc83xx.c        | 2 +-
> drivers/sysreset/sysreset_octeon.c         | 2 +-
> drivers/sysreset/sysreset_palmas.c         | 2 +-
> drivers/sysreset/sysreset_psci.c           | 2 +-
> drivers/sysreset/sysreset_qemu_virt_ctrl.c | 2 +-
> drivers/sysreset/sysreset_raa215300.c      | 2 +-
> drivers/sysreset/sysreset_resetctl.c       | 2 +-
> drivers/sysreset/sysreset_sandbox.c        | 4 ++--
> drivers/sysreset/sysreset_sbi.c            | 2 +-
> drivers/sysreset/sysreset_socfpga.c        | 2 +-
> drivers/sysreset/sysreset_socfpga_soc64.c  | 2 +-
> drivers/sysreset/sysreset_sti.c            | 2 +-
> drivers/sysreset/sysreset_syscon.c         | 2 +-
> drivers/sysreset/sysreset_tegra.c          | 2 +-
> drivers/sysreset/sysreset_tps65910.c       | 2 +-
> drivers/sysreset/sysreset_tps80031.c       | 2 +-
> drivers/sysreset/sysreset_x86.c            | 2 +-
> drivers/sysreset/sysreset_xtfpga.c         | 2 +-
> 27 files changed, 28 insertions(+), 28 deletions(-)
>
>diff --git a/drivers/sysreset/poweroff_gpio.c b/drivers/sysreset/poweroff_gpio.c
>index d9220024f47..ca695393136 100644
>--- a/drivers/sysreset/poweroff_gpio.c
>+++ b/drivers/sysreset/poweroff_gpio.c
>@@ -72,7 +72,7 @@ static int poweroff_gpio_probe(struct udevice *dev)
> 	return gpio_request_by_name(dev, "gpios", 0, &priv->gpio, flags);
> }
> 
>-static struct sysreset_ops poweroff_gpio_ops = {
>+static const struct sysreset_ops poweroff_gpio_ops = {
> 	.request = poweroff_gpio_request,
> };
> 
>diff --git a/drivers/sysreset/sysreset-ti-sci.c b/drivers/sysreset/sysreset-ti-sci.c
>index 451fc5de735..2674d6f07c5 100644
>--- a/drivers/sysreset/sysreset-ti-sci.c
>+++ b/drivers/sysreset/sysreset-ti-sci.c
>@@ -55,7 +55,7 @@ static int ti_sci_sysreset_request(struct udevice *dev, enum sysreset_t type)
> 	return ret;
> }
> 
>-static struct sysreset_ops ti_sci_sysreset_ops = {
>+static const struct sysreset_ops ti_sci_sysreset_ops = {
> 	.request = ti_sci_sysreset_request,
> };
> 
>diff --git a/drivers/sysreset/sysreset_ast.c b/drivers/sysreset/sysreset_ast.c
>index 4e15ebd53cc..021359a86a7 100644
>--- a/drivers/sysreset/sysreset_ast.c
>+++ b/drivers/sysreset/sysreset_ast.c
>@@ -46,7 +46,7 @@ static int ast_sysreset_request(struct udevice *dev, enum sysreset_t type)
> 	return -EINPROGRESS;
> }
> 
>-static struct sysreset_ops ast_sysreset = {
>+static const struct sysreset_ops ast_sysreset = {
> 	.request	= ast_sysreset_request,
> };
> 
>diff --git a/drivers/sysreset/sysreset_at91.c b/drivers/sysreset/sysreset_at91.c
>index 457042c7aae..6e865e1e9e6 100644
>--- a/drivers/sysreset/sysreset_at91.c
>+++ b/drivers/sysreset/sysreset_at91.c
>@@ -51,7 +51,7 @@ static int at91_sysreset_probe(struct udevice *dev)
> 	return 0;
> }
> 
>-static struct sysreset_ops at91_sysreset = {
>+static const struct sysreset_ops at91_sysreset = {
> 	.request = at91_sysreset_request,
> };
> 
>diff --git a/drivers/sysreset/sysreset_cv1800b.c b/drivers/sysreset/sysreset_cv1800b.c
>index 74ba2c2bd8f..6bb4a285cf1 100644
>--- a/drivers/sysreset/sysreset_cv1800b.c
>+++ b/drivers/sysreset/sysreset_cv1800b.c
>@@ -63,7 +63,7 @@ static int cv1800b_sysreset_probe(struct udevice *dev)
> 	return 0;
> }
> 
>-static struct sysreset_ops cv1800b_sysreset = {
>+static const struct sysreset_ops cv1800b_sysreset = {
> 	.request = cv1800b_sysreset_request,
> };
> 
>diff --git a/drivers/sysreset/sysreset_gpio.c b/drivers/sysreset/sysreset_gpio.c
>index 47018844a51..bb9d285f5d4 100644
>--- a/drivers/sysreset/sysreset_gpio.c
>+++ b/drivers/sysreset/sysreset_gpio.c
>@@ -33,7 +33,7 @@ static int gpio_reboot_request(struct udevice *dev, enum sysreset_t type)
> 	return -EINPROGRESS;
> }
> 
>-static struct sysreset_ops gpio_reboot_ops = {
>+static const struct sysreset_ops gpio_reboot_ops = {
> 	.request = gpio_reboot_request,
> };
> 
>diff --git a/drivers/sysreset/sysreset_max77663.c b/drivers/sysreset/sysreset_max77663.c
>index 8febcf8de6c..a4ed763f743 100644
>--- a/drivers/sysreset/sysreset_max77663.c
>+++ b/drivers/sysreset/sysreset_max77663.c
>@@ -41,7 +41,7 @@ static int max77663_sysreset_request(struct udevice *dev,
> 	return -EINPROGRESS;
> }
> 
>-static struct sysreset_ops max77663_sysreset = {
>+static const struct sysreset_ops max77663_sysreset = {
> 	.request = max77663_sysreset_request,
> };
> 
>diff --git a/drivers/sysreset/sysreset_max8907.c b/drivers/sysreset/sysreset_max8907.c
>index 6f62af9bffe..ac268dc5e61 100644
>--- a/drivers/sysreset/sysreset_max8907.c
>+++ b/drivers/sysreset/sysreset_max8907.c
>@@ -26,7 +26,7 @@ static int max8907_sysreset_request(struct udevice *dev, enum sysreset_t type)
> 	return -EINPROGRESS;
> }
> 
>-static struct sysreset_ops max8907_sysreset = {
>+static const struct sysreset_ops max8907_sysreset = {
> 	.request = max8907_sysreset_request,
> };
> 
>diff --git a/drivers/sysreset/sysreset_microblaze.c b/drivers/sysreset/sysreset_microblaze.c
>index b81d82f046b..031b6cd72e0 100644
>--- a/drivers/sysreset/sysreset_microblaze.c
>+++ b/drivers/sysreset/sysreset_microblaze.c
>@@ -20,7 +20,7 @@ static int microblaze_sysreset_request(struct udevice *dev,
> 	return -EINPROGRESS;
> }
> 
>-static struct sysreset_ops microblaze_sysreset = {
>+static const struct sysreset_ops microblaze_sysreset = {
> 	.request = microblaze_sysreset_request,
> };
> 
>diff --git a/drivers/sysreset/sysreset_mpc83xx.c b/drivers/sysreset/sysreset_mpc83xx.c
>index dca49299f77..4aa1707d4fd 100644
>--- a/drivers/sysreset/sysreset_mpc83xx.c
>+++ b/drivers/sysreset/sysreset_mpc83xx.c
>@@ -203,7 +203,7 @@ static int mpc83xx_sysreset_get_status(struct udevice *dev, char *buf, int size)
> 	return 0;
> }
> 
>-static struct sysreset_ops mpc83xx_sysreset = {
>+static const struct sysreset_ops mpc83xx_sysreset = {
> 	.request	= mpc83xx_sysreset_request,
> 	.get_status	= mpc83xx_sysreset_get_status,
> };
>diff --git a/drivers/sysreset/sysreset_octeon.c b/drivers/sysreset/sysreset_octeon.c
>index c16223720e5..c08243e7c0b 100644
>--- a/drivers/sysreset/sysreset_octeon.c
>+++ b/drivers/sysreset/sysreset_octeon.c
>@@ -32,7 +32,7 @@ static int octeon_sysreset_probe(struct udevice *dev)
> 	return 0;
> }
> 
>-static struct sysreset_ops octeon_sysreset = {
>+static const struct sysreset_ops octeon_sysreset = {
> 	.request = octeon_sysreset_request,
> };
> 
>diff --git a/drivers/sysreset/sysreset_palmas.c b/drivers/sysreset/sysreset_palmas.c
>index 9e3aa403488..e80c78ca482 100644
>--- a/drivers/sysreset/sysreset_palmas.c
>+++ b/drivers/sysreset/sysreset_palmas.c
>@@ -41,7 +41,7 @@ static int palmas_sysreset_request(struct udevice *dev,
> 	return -EINPROGRESS;
> }
> 
>-static struct sysreset_ops palmas_sysreset = {
>+static const struct sysreset_ops palmas_sysreset = {
> 	.request = palmas_sysreset_request,
> };
> 
>diff --git a/drivers/sysreset/sysreset_psci.c b/drivers/sysreset/sysreset_psci.c
>index 89b4f2dcaec..1bf6af0821b 100644
>--- a/drivers/sysreset/sysreset_psci.c
>+++ b/drivers/sysreset/sysreset_psci.c
>@@ -30,7 +30,7 @@ static int psci_sysreset_request(struct udevice *dev, enum sysreset_t type)
> 	return -EINPROGRESS;
> }
> 
>-static struct sysreset_ops psci_sysreset_ops = {
>+static const struct sysreset_ops psci_sysreset_ops = {
> 	.request = psci_sysreset_request,
> 	.get_status = psci_sysreset_get_status,
> };
>diff --git a/drivers/sysreset/sysreset_qemu_virt_ctrl.c b/drivers/sysreset/sysreset_qemu_virt_ctrl.c
>index ce15e776f8f..cd693eb55e1 100644
>--- a/drivers/sysreset/sysreset_qemu_virt_ctrl.c
>+++ b/drivers/sysreset/sysreset_qemu_virt_ctrl.c
>@@ -45,7 +45,7 @@ static int qemu_virt_ctrl_request(struct udevice *dev, enum sysreset_t type)
> 	return -EINPROGRESS;
> }
> 
>-static struct sysreset_ops qemu_virt_ctrl_ops = {
>+static const struct sysreset_ops qemu_virt_ctrl_ops = {
> 	.request = qemu_virt_ctrl_request,
> };
> 
>diff --git a/drivers/sysreset/sysreset_raa215300.c b/drivers/sysreset/sysreset_raa215300.c
>index 32dfcb0aec8..17cb35c4e9c 100644
>--- a/drivers/sysreset/sysreset_raa215300.c
>+++ b/drivers/sysreset/sysreset_raa215300.c
>@@ -47,7 +47,7 @@ static int raa215300_sysreset_request(struct udevice *dev, enum sysreset_t type)
> 	return -EINPROGRESS;
> }
> 
>-static struct sysreset_ops raa215300_sysreset_ops = {
>+static const struct sysreset_ops raa215300_sysreset_ops = {
> 	.request = raa215300_sysreset_request,
> };
> 
>diff --git a/drivers/sysreset/sysreset_resetctl.c b/drivers/sysreset/sysreset_resetctl.c
>index fbe3999b960..f06382956ce 100644
>--- a/drivers/sysreset/sysreset_resetctl.c
>+++ b/drivers/sysreset/sysreset_resetctl.c
>@@ -21,7 +21,7 @@ static int resetctl_reboot_request(struct udevice *dev, enum sysreset_t type)
> 	return reset_assert_bulk(&priv->resets);
> }
> 
>-static struct sysreset_ops resetctl_reboot_ops = {
>+static const struct sysreset_ops resetctl_reboot_ops = {
> 	.request = resetctl_reboot_request,
> };
> 
>diff --git a/drivers/sysreset/sysreset_sandbox.c b/drivers/sysreset/sysreset_sandbox.c
>index 93179f90bbb..a9fa187945d 100644
>--- a/drivers/sysreset/sysreset_sandbox.c
>+++ b/drivers/sysreset/sysreset_sandbox.c
>@@ -95,7 +95,7 @@ int sandbox_sysreset_get_last(struct udevice *dev)
> 	return state->jumped_fname ? SYSRESET_WARM : SYSRESET_POWER;
> }
> 
>-static struct sysreset_ops sandbox_sysreset_ops = {
>+static const struct sysreset_ops sandbox_sysreset_ops = {
> 	.request	= sandbox_sysreset_request,
> 	.get_status	= sandbox_sysreset_get_status,
> 	.get_last	= sandbox_sysreset_get_last,
>@@ -113,7 +113,7 @@ U_BOOT_DRIVER(sysreset_sandbox) = {
> 	.ops		= &sandbox_sysreset_ops,
> };
> 
>-static struct sysreset_ops sandbox_warm_sysreset_ops = {
>+static const struct sysreset_ops sandbox_warm_sysreset_ops = {
> 	.request	= sandbox_warm_sysreset_request,
> 	.get_status	= sandbox_warm_sysreset_get_status,
> 	.get_last	= sandbox_warm_sysreset_get_last,
>diff --git a/drivers/sysreset/sysreset_sbi.c b/drivers/sysreset/sysreset_sbi.c
>index 458191206b2..c4a71363e62 100644
>--- a/drivers/sysreset/sysreset_sbi.c
>+++ b/drivers/sysreset/sysreset_sbi.c
>@@ -38,7 +38,7 @@ static int sbi_sysreset_probe(struct udevice *dev)
> 	return -ENOENT;
> }
> 
>-static struct sysreset_ops sbi_sysreset_ops = {
>+static const struct sysreset_ops sbi_sysreset_ops = {
> 	.request = sbi_sysreset_request,
> };
> 
>diff --git a/drivers/sysreset/sysreset_socfpga.c b/drivers/sysreset/sysreset_socfpga.c
>index a07b0f4fd55..8d979ff7333 100644
>--- a/drivers/sysreset/sysreset_socfpga.c
>+++ b/drivers/sysreset/sysreset_socfpga.c
>@@ -43,7 +43,7 @@ static int socfpga_sysreset_probe(struct udevice *dev)
> 	return 0;
> }
> 
>-static struct sysreset_ops socfpga_sysreset = {
>+static const struct sysreset_ops socfpga_sysreset = {
> 	.request = socfpga_sysreset_request,
> };
> 
>diff --git a/drivers/sysreset/sysreset_socfpga_soc64.c b/drivers/sysreset/sysreset_socfpga_soc64.c
>index e1267ac118a..5e4fcf95b6c 100644
>--- a/drivers/sysreset/sysreset_socfpga_soc64.c
>+++ b/drivers/sysreset/sysreset_socfpga_soc64.c
>@@ -76,7 +76,7 @@ static int socfpga_sysreset_request(struct udevice *dev,
> 	return -EINPROGRESS;
> }
> 
>-static struct sysreset_ops socfpga_sysreset = {
>+static const struct sysreset_ops socfpga_sysreset = {
> 	.request = socfpga_sysreset_request,
> };
> 
>diff --git a/drivers/sysreset/sysreset_sti.c b/drivers/sysreset/sysreset_sti.c
>index 110b7e23afa..862b9411392 100644
>--- a/drivers/sysreset/sysreset_sti.c
>+++ b/drivers/sysreset/sysreset_sti.c
>@@ -65,7 +65,7 @@ static int sti_sysreset_probe(struct udevice *dev)
> 	return 0;
> }
> 
>-static struct sysreset_ops sti_sysreset = {
>+static const struct sysreset_ops sti_sysreset = {
> 	.request	= sti_sysreset_request,
> };
> 
>diff --git a/drivers/sysreset/sysreset_syscon.c b/drivers/sysreset/sysreset_syscon.c
>index d853830d5ae..2b485963a30 100644
>--- a/drivers/sysreset/sysreset_syscon.c
>+++ b/drivers/sysreset/sysreset_syscon.c
>@@ -35,7 +35,7 @@ static int syscon_reboot_request(struct udevice *dev, enum sysreset_t type)
> 	return -EINPROGRESS;
> }
> 
>-static struct sysreset_ops syscon_reboot_ops = {
>+static const struct sysreset_ops syscon_reboot_ops = {
> 	.request = syscon_reboot_request,
> };
> 
>diff --git a/drivers/sysreset/sysreset_tegra.c b/drivers/sysreset/sysreset_tegra.c
>index 10bcd3a1873..d498aaea73a 100644
>--- a/drivers/sysreset/sysreset_tegra.c
>+++ b/drivers/sysreset/sysreset_tegra.c
>@@ -29,7 +29,7 @@ static int tegra_sysreset_request(struct udevice *dev,
> 	return -EINPROGRESS;
> }
> 
>-static struct sysreset_ops tegra_sysreset = {
>+static const struct sysreset_ops tegra_sysreset = {
> 	.request = tegra_sysreset_request,
> };
> 
>diff --git a/drivers/sysreset/sysreset_tps65910.c b/drivers/sysreset/sysreset_tps65910.c
>index 98da56661c0..957c73f04f2 100644
>--- a/drivers/sysreset/sysreset_tps65910.c
>+++ b/drivers/sysreset/sysreset_tps65910.c
>@@ -43,7 +43,7 @@ static int tps65910_sysreset_request(struct udevice *dev,
> 	return -EINPROGRESS;
> }
> 
>-static struct sysreset_ops tps65910_sysreset = {
>+static const struct sysreset_ops tps65910_sysreset = {
> 	.request = tps65910_sysreset_request,
> };
> 
>diff --git a/drivers/sysreset/sysreset_tps80031.c b/drivers/sysreset/sysreset_tps80031.c
>index 50024fe4e79..1a0dc2adb16 100644
>--- a/drivers/sysreset/sysreset_tps80031.c
>+++ b/drivers/sysreset/sysreset_tps80031.c
>@@ -29,7 +29,7 @@ static int tps80031_sysreset_request(struct udevice *dev,
> 	return -EINPROGRESS;
> }
> 
>-static struct sysreset_ops tps80031_sysreset = {
>+static const struct sysreset_ops tps80031_sysreset = {
> 	.request = tps80031_sysreset_request,
> };
> 
>diff --git a/drivers/sysreset/sysreset_x86.c b/drivers/sysreset/sysreset_x86.c
>index c2f28c65280..51eb16bc551 100644
>--- a/drivers/sysreset/sysreset_x86.c
>+++ b/drivers/sysreset/sysreset_x86.c
>@@ -144,7 +144,7 @@ static const struct udevice_id x86_sysreset_ids[] = {
> 	{ }
> };
> 
>-static struct sysreset_ops x86_sysreset_ops = {
>+static const struct sysreset_ops x86_sysreset_ops = {
> 	.request = x86_sysreset_request,
> 	.get_last = x86_sysreset_get_last,
> };
>diff --git a/drivers/sysreset/sysreset_xtfpga.c b/drivers/sysreset/sysreset_xtfpga.c
>index ab71ea11a0b..2165a1cfdcd 100644
>--- a/drivers/sysreset/sysreset_xtfpga.c
>+++ b/drivers/sysreset/sysreset_xtfpga.c
>@@ -25,7 +25,7 @@ static int xtfpga_reset_request(struct udevice *dev, enum sysreset_t type)
> 	return -EINPROGRESS;
> }
> 
>-static struct sysreset_ops xtfpga_sysreset_ops = {
>+static const struct sysreset_ops xtfpga_sysreset_ops = {
> 	.request	= xtfpga_reset_request,
> };
> 
>

--- Thanks!
