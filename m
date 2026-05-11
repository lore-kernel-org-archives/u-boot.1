Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5140BCD37BE
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 13:57:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D04EB838D7;
	Mon, 11 May 2026 15:57:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="c3JlLJ+d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF54683DBF; Mon, 11 May 2026 15:57:55 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3E998394E
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 15:57:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-67c2b4809baso8632170a12.3
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 06:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778507873; x=1779112673; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=u8dwkCnD+Jui0RrldDTk6SyvZfJYyhdYqNsasZalyb4=;
 b=c3JlLJ+dKjuxbZyQ5UKnNrymlk+YUCPlczgQTkOYJq7BzwnvH53EeFYLrdl8JFMwqI
 0xQTYGE1ph00/dxr36V+z0PTjC6qtZi2+Og8JbYWMd7ysClMIL1hNRycTmkTnh13kxT3
 rKXODuJiCDXEA6App0qJz+nNV7t+93tG0mq8tBxmnXx1amSa02mU0kzie/jtExlz8GD5
 paeIFZxWkJnEBF77Jliv6+iz9X0XvUQU+S9jbg/7mpQddBPdj0BVUeLk0I+jIRWwsocy
 sXf82y+ChK3Wg2AyfiN4L5frXBWVV59T64bLUMwGH6n+K2lQBIGj7wk6vyogJETQLmxU
 BLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778507873; x=1779112673;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=u8dwkCnD+Jui0RrldDTk6SyvZfJYyhdYqNsasZalyb4=;
 b=JwHHp7ejTVE1MqYXUKwI+PjuwyNb+8AdzFLefhBRly4X2lXIBRnC2DvZF9GHmiw2CE
 fpfwft75RSzzw1XQi2dwSCNbzYGw0uRx27OgfR0NyXumer3rV9yZXvLxGZm/nNdwEaIP
 N19FvWCS35Uj2YU++DjGxTKD4czCjpl0DAYq3uHVtjSs0G1KHAJVJZFUhsmXJh38NV3I
 gIkGjiXZGAhoFcDzRmJ3HxnvD10DoHFOyRrs5tIRTS+ehzZI/8SQ3uXzirMxBP5xiO9/
 AKTh3lypLlcP0Tk37ne753l84kvQixYH2XM7X1lkP05QDENRbp5hGoeRccgRjASPqv4f
 PlPA==
X-Gm-Message-State: AOJu0YxIRnQnptByR4hL8RUqwS/AlFyyZm5HUU32pUBpmZMIDrSTH6JN
 YvBcfaD4MobnoQHmKKnrlDI5v574BDC1oWLxRZ9+gNlmyVO4m+f6xJk6EgFU5w+vTLI=
X-Gm-Gg: Acq92OFr9WnSjpAxXmmOhcxtS2EjQKmPjXVsgjSlpQUZP7uWweGkX8BgCx+Sct4axtf
 zffCC0d97NrAWToYIP8jCL4d09uP3l9pme21hxlLm5Ncl8ziJIzEoGh3Ksm7BwpCaZGQZ1WNDYY
 xLmbk4Ay1iCUNvMH4np2tOvPnuJqppNSJOvDXit3fM9g/Q/ySodbCWHF4CKUAgSH7PnTDLn2yMI
 qXA/8AF2JAwqdmX0eGPghcUwFzBkjvq/mbfLykcpSb2NrQy/gM8ZVWWdBCmpT1sUXes12KiLbi9
 e0N2z9yqX1R0zZpvt7WFV4wHYK3yjCJwR53Pxiv/g50Edj6pwGSaYoXyCkZcTbdIluVMfX9q1h4
 IWoZo5jCAJmRuJOie2lsEdSA6gUJRbwFzXKCmEzl5gPtJaPMetcE0ap9oOKheb7qwD/eo5SyTnU
 w/6JuaGNyvuZM2KQW5vYBmnUX5Tgl9l3epvmNTxqylxgSMmxDGRQz/QufsPEi9bwbg6H4n
X-Received: by 2002:a05:6402:3488:b0:67e:2498:dc7b with SMTP id
 4fb4d7f45d1cf-67e2498de0bmr9888000a12.10.1778507872827; 
 Mon, 11 May 2026 06:57:52 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-67ef0dfd34fsm3805377a12.14.2026.05.11.06.57.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 06:57:51 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Mon, 11 May 2026 15:57:43 +0200
Subject: [PATCH v7 1/6] config.mk: support vendor generic includes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-b4-qcom-tooling-improvements-v7-1-0c06346e79a9@linaro.org>
References: <20260511-b4-qcom-tooling-improvements-v7-0-0c06346e79a9@linaro.org>
In-Reply-To: <20260511-b4-qcom-tooling-improvements-v7-0-0c06346e79a9@linaro.org>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1223;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=8OA/z5d3U06OCmMNL7DuEVNpvNOCZ/BUIerGvHNNEho=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhizGBzFNz+ydJeZ3bpQ9cyxb5a3AopkSghZHIib82hdzN
 HnFR2bZjlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjCR/+8ZGSbdmzytgMO3ZGlm
 38HdcQf+hR4/u/E3w0p562O3WJzNX71jZJg2ddr2ffknHmd4RpYleRjvyLS79n1XWYPtBqYH3ss
 EkwMA
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
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

Currently only board/vendor/$(BOARD)/config.mk is supported, add the
additional usecase of having a vendor generic config.mk for adding
functionality like platform-specific build targets.

Additionally, fix the ifdef to correctly check for $(BOARDDIR) rather
than $(BOARD) since that's what is actually used in the include path.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 config.mk | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/config.mk b/config.mk
index abed9cb65c6f..22c21c0d3b2d 100644
--- a/config.mk
+++ b/config.mk
@@ -46,17 +46,21 @@ sinclude $(srctree)/$(CPUDIR)/config.mk		# include  CPU	specific rules
 ifdef	SOC
 sinclude $(srctree)/$(CPUDIR)/$(SOC)/config.mk	# include  SoC	specific rules
 endif
 ifneq ($(BOARD),)
-ifdef	VENDOR
+ifneq ($(VENDOR),)
 BOARDDIR = $(VENDOR)/$(BOARD)
 ENVDIR=${vendor}/env
 else
 BOARDDIR = $(BOARD)
 ENVDIR=${board}/env
 endif
 endif
-ifdef	BOARD
+
+ifneq ($(VENDOR),)
+sinclude $(srctree)/board/$(VENDOR)/config.mk	# include vendor specific rules
+endif
+ifdef	BOARDDIR
 sinclude $(srctree)/board/$(BOARDDIR)/config.mk	# include board specific rules
 endif
 
 ifdef FTRACE

-- 
2.53.0

