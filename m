Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C319CD128A
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 12:08:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B265F8838B;
	Wed,  3 Apr 2024 14:07:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RiJNzoc4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6217A8839A; Wed,  3 Apr 2024 14:07:56 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C61F788388
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 14:07:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-56c1922096cso7947305a12.0
 for <u-boot@lists.denx.de>; Wed, 03 Apr 2024 05:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712146073; x=1712750873; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oFmODt990ad8kjLTTOpTYnAwB7mre5Em7KQhg5E3z/E=;
 b=RiJNzoc43lpAeo0f5f+k6xR1WdoIHC18juJRWpvNDu+CpuWrA3XXd/kViaOkBqiFt5
 7QAL6Mfo8hoOnaOQ/oNlqd9bXIHw9N+4qbLl2jyALm2jSS6HQ9Q35hDtOYu8h/Lmyknc
 c0ksEhx8SZYWQzlPFaFr+bInqqcWuA4qVci3aIoR7BcwnfYhnTR7qzg3KgINH6DIxwa5
 uHJtahz8hbshI+t51mUhaE6Okxcx2SQm4QHp3HJgQRqiMMTofwDXPrERaF5S/4yV9x4i
 1K+btKHve7L9b49a4Yx3gKCS4AC/96P2RZsDzLaAq9a19bbU45FctAa5sMNHIIIycHcS
 WLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712146073; x=1712750873;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oFmODt990ad8kjLTTOpTYnAwB7mre5Em7KQhg5E3z/E=;
 b=GJDi+ucLgBOBAs2Kwhx4I02cDxxhKINzSRY8y/2aLwfck3+s++Z1ZBZqzlJlpiIaWj
 IlaWZvIaUm8JbAyINQfb2faaPHQ/JG6X3ieXX+yfkjjZrlKZ0O70nVOHaMrEwzJA54HZ
 LlJuphDgOfXjKe7oZGR9MuPX8LgeGE+z6UZGq3dIaC0MsePeM6Onmdx0F1fCdq5r2o+1
 vzeJHTsT4yuoC22962OXT5JL2RebNnWHy5W91RmsvvtCbGKYu7MidXLE6vkd2oWhpInf
 rhkgwt9qBwAGAqflmtnWCo3HPA6J9Z/8gzKQOe9bGD0olys4tkKNTZ5kuCr9MKjmQJG6
 9oCg==
X-Gm-Message-State: AOJu0YyOizR5F92zsghVlNNxTpaZs9+aY/GbqZ34R2q0UyTHKddK39st
 AQMLjW3APmb/YTI4QIp/S0E4i36IAMNBKsJelBzTMu8+yktyHaSi/ANHeq+E7lw=
X-Google-Smtp-Source: AGHT+IEtQWcAYHbcIpOpKu4Qj+jkybg8SchurszYXTAHp0Pqa5Toj8MZDPNKI9+yUinYqdYe2uy6Yw==
X-Received: by 2002:a17:906:1390:b0:a4e:3a09:4854 with SMTP id
 f16-20020a170906139000b00a4e3a094854mr1777036ejc.61.1712146073290; 
 Wed, 03 Apr 2024 05:07:53 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::38e6])
 by smtp.gmail.com with ESMTPSA id
 lr20-20020a170906fb9400b00a46a04d7dc4sm7654674ejb.61.2024.04.03.05.07.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Apr 2024 05:07:52 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 03 Apr 2024 14:07:39 +0200
Subject: [PATCH v6 04/16] mach-snapdragon: disable power-domains for
 pre-reloc drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-b4-qcom-livetree-v6-4-130f8f50b538@linaro.org>
References: <20240403-b4-qcom-livetree-v6-0-130f8f50b538@linaro.org>
In-Reply-To: <20240403-b4-qcom-livetree-v6-0-130f8f50b538@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=2212;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=lNaop02wGgSTfoA1P61dU8gqi6TppeaoShUOEotMpkk=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmDUaQh0TUDYxDDlWcEcuRvg+s5Pljaxsg6bg2f
 Gel6j6K9pmJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZg1GkAAKCRAFgzErGV9k
 ttSOEACUCi38xX1DWsp6y1yN0ttnZvTr/0Qw4sJ3xHKb4tgB+F4SrTtwXs2J3qwOyhePJFgx2gy
 7HTjV+O3aowzabnyinx5jDxEsjUSMR8jMj47Z7cnm/ZMummpB3bf8WBPFX1G7A2ytGPFhh/3OBw
 CwWofyR89X2bh+LX7xiSO62gby7X8OVmSzmZyP/ny8BpH/FJJ/neVAncQwmBwnULyVnzNH7ZklY
 +Xlz8PT+zg3jvudiG1YqevM6jeCjHO6oX5LHVgOu+uBDPPKBtRWrXpYvLHYZdTUkB5KCy0HuVUZ
 eLr+00kwOnLIku4Qu8f7DWCK7KEW6+faIbYg6aSr3ccg4XfjQSj098/mrnxVmd7aF+AC4FtMKlx
 tzBBjeSfc/fksorNBqOjjg3ZpQrvx1l7r4CQhoySxZiDXME8lUJmhE827qfsFnQKUmUDUqsdBTx
 G9J4vH5bkg0AXHo+reBGn8GDhReEcNWVgQaHHU6VDWmHXvjjpTiB0Zc8mXo/J7cyPoJSQQE8EWH
 CHvrQfak49w1w1n495Vj9FF/AY81pXyh9Kq9tWdYJtQFyGQii6pQnspL0H2J9BHT+D9mnRFOO5w
 KOEmRe9iCqgPGvx6TUHzBxMzaa0PsPrWb49t7lEJfcpV8obEkezKvxMRu79Hp87MKl/YeaYYMVf
 r+vM6+hRlvWVXQA==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Some devices like the UART and clock controller reference an RPM(h)
power domain. We don't support this device in U-Boot, so add
DM_FLAG_DEFAULT_PD_CTRL_OFF to tell DM core not to try and enable the
power domain.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/clk/qcom/clock-qcom.c    | 2 ++
 drivers/clk/qcom/clock-sdm845.c  | 2 +-
 drivers/serial/serial_msm_geni.c | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
index 7a5938a06a34..6303dcbf8461 100644
--- a/drivers/clk/qcom/clock-qcom.c
+++ b/drivers/clk/qcom/clock-qcom.c
@@ -226,8 +226,9 @@ U_BOOT_DRIVER(qcom_clk) = {
 	.id		= UCLASS_CLK,
 	.ops		= &msm_clk_ops,
 	.priv_auto	= sizeof(struct msm_clk_priv),
 	.probe		= msm_clk_probe,
+	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
 };
 
 int qcom_cc_bind(struct udevice *parent)
 {
@@ -410,5 +411,6 @@ U_BOOT_DRIVER(qcom_power) = {
 	.name = "qcom_power",
 	.id = UCLASS_POWER_DOMAIN,
 	.ops = &qcom_power_ops,
 	.probe = qcom_power_probe,
+	.flags = DM_FLAG_PRE_RELOC,
 };
diff --git a/drivers/clk/qcom/clock-sdm845.c b/drivers/clk/qcom/clock-sdm845.c
index 36ffee79d966..babd83119e2c 100644
--- a/drivers/clk/qcom/clock-sdm845.c
+++ b/drivers/clk/qcom/clock-sdm845.c
@@ -182,6 +182,6 @@ U_BOOT_DRIVER(gcc_sdm845) = {
 	.name		= "gcc_sdm845",
 	.id		= UCLASS_NOP,
 	.of_match	= gcc_sdm845_of_match,
 	.bind		= qcom_cc_bind,
-	.flags		= DM_FLAG_PRE_RELOC,
+	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
 };
diff --git a/drivers/serial/serial_msm_geni.c b/drivers/serial/serial_msm_geni.c
index e5c3dcffc1c6..4aa0bc8c72bc 100644
--- a/drivers/serial/serial_msm_geni.c
+++ b/drivers/serial/serial_msm_geni.c
@@ -602,9 +602,9 @@ U_BOOT_DRIVER(serial_msm_geni) = {
 	.of_to_plat = msm_serial_ofdata_to_platdata,
 	.priv_auto = sizeof(struct msm_serial_data),
 	.probe = msm_serial_probe,
 	.ops = &msm_serial_ops,
-	.flags = DM_FLAG_PRE_RELOC,
+	.flags = DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
 };
 
 #ifdef CONFIG_DEBUG_UART_MSM_GENI
 

-- 
2.44.0

