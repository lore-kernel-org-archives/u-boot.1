Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 205D8C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 12:44:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6650588207;
	Mon, 15 Apr 2024 14:44:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="l92+fTZC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A19D68823E; Mon, 15 Apr 2024 14:44:36 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49A35881FE
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 14:44:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-346b09d474dso3052448f8f.2
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 05:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713185073; x=1713789873; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=h/blv1jhNMGdp3y04vVVIazZY+yEsnljwxhnc5rTng0=;
 b=l92+fTZCMX2IfvGEFPkZQX/8/Jnx50Xtu4d1LuMtTNhAPWcrWZAFfI5TqR+x85l6nJ
 GcJzZ+88E64CdUn09xg3W1zUbYv4/ZAZDyILJ6o2Ztc2yFipbvo92oG4QL37QSvcv3YT
 CwCZGLmk5yX2RS1NpxcIWEYTDZ31oso72LgkcYmbklfgS4YmvyAP6x7kcahj5PJWebWr
 x/zx9E0NzbNEUkdrZ/8HhGQh09Dkkd7VRzKmPjladFdjPWqmtdABS/za5V/4Vb38S4Lo
 GpdeJPUH9Wo3Kkshcy1CzwDIb+g1qo7rw5gPjPSkbFelVGevudnChxzJkHVLn3Oy4GnN
 PoPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713185073; x=1713789873;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h/blv1jhNMGdp3y04vVVIazZY+yEsnljwxhnc5rTng0=;
 b=gGy/e6VT4WRdbcNyNZPYmfT6a6PwYxcAfRihA0ldJhI0MxLrjH72NqBa+yduxVGABc
 i1O4f3TV7KAFmW6EPyrmhcqYt8Nt6ZWef1QAhh4qOy4szPtyyvc8vFogo2bfv62U9Obt
 eoVbpKxuy5N6OGTiUvNYhPJVvRUGjroyzMCoKOiRcJNk9EUqJXwAlWzriHOdpylkQBqz
 GPVjuFrwfman0GdZroJMoO6bU2/y3yKpSiXqw+M0uvRnkG3tecL8RuFCKypssbXGQ4yL
 8Gm8vSR2opO89LyAMvIPOj5ZJTRLhI0Kx9OqNx4TBLe6KXPJvh8bEeUEx71jZUedfKjf
 /6yA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDgAmBvb5RsufgU8x1BTAxTCfQfhgtoPkZTg3ruiOnhlycjaRB38Vyn8nS5ZmNfgSLgJHgKOLJlPoAKm05TMVQGgIezQ==
X-Gm-Message-State: AOJu0Yzb51arRbpadiPFAxyKuXTHBnuGYHQvyStzKXMFMYRtzI/L6CVH
 QPYowIlEoTHEOyXVCoXdFnp2RnQZDERe62yaBZIswERPvK6D6nNbN9EzGGNU9Qg=
X-Google-Smtp-Source: AGHT+IHHmME4wl9yXN2axL+4KmSgo4saGnH/YkM9Qxn6rjBtN34+G8KeJcRWQhPU8dwdAIa8iZvBGQ==
X-Received: by 2002:a05:6000:1a8b:b0:347:9e5a:3078 with SMTP id
 f11-20020a0560001a8b00b003479e5a3078mr3937197wry.1.1713185072731; 
 Mon, 15 Apr 2024 05:44:32 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 g13-20020a5d488d000000b00347321735a6sm7931517wrq.66.2024.04.15.05.44.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 05:44:32 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 15 Apr 2024 13:44:20 +0100
Subject: [PATCH 1/3] clk/qcom: apq8016: return valid rate when setting UART
 clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240415-b4-msm-serial-bitrate-v1-1-5a89f84fd9e7@linaro.org>
References: <20240415-b4-msm-serial-bitrate-v1-0-5a89f84fd9e7@linaro.org>
In-Reply-To: <20240415-b4-msm-serial-bitrate-v1-0-5a89f84fd9e7@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Robert Marko <robert.marko@sartura.hr>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=920;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=z+mdt6z8O9e9zBFdjcbWdLQu5FVirlaHaG+3os0axxg=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhjRZRb0d3LdXCW2bNdOk5/undYlPL01obZ76l8tU8/ud2
 9oSt6Rmd5SyMAhyMMiKKbKIn1hm2bT2sr3G9gUXYOawMoEMYeDiFICJaF5gZFi8MP/mD3UGx1t8
 ZmdmHM07dHf+ollRZ16fP6904G7LHsHrjAyr/Po/lHQy6m/41jZ976MPXlMXBNeZRiT/nqv3o2n
 G76XyAA==
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

The clk_init_uart() helper always returns 0, but we're meant to return a
real clock rate. Given that we hardcode 115200 baud, just return the
clock rate that we set.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/clk/qcom/clock-apq8016.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/clock-apq8016.c b/drivers/clk/qcom/clock-apq8016.c
index 5a5868169c89..6210fba87984 100644
--- a/drivers/clk/qcom/clock-apq8016.c
+++ b/drivers/clk/qcom/clock-apq8016.c
@@ -99,10 +99,10 @@ static ulong apq8016_clk_set_rate(struct clk *clk, ulong rate)
 	case GCC_SDCC2_APPS_CLK: /* SDC2 */
 		return clk_init_sdc(priv, 1, rate);
 		break;
 	case GCC_BLSP1_UART2_APPS_CLK: /* UART2 */
-		return apq8016_clk_init_uart(priv->base);
-		break;
+		apq8016_clk_init_uart(priv->base);
+		return 7372800;
 	default:
 		return 0;
 	}
 }

-- 
2.44.0

