Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 676FDD1D493
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 20:29:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DC1E842F2;
	Thu,  8 Jan 2026 21:29:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NBedrbkV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B3048415D; Thu,  8 Jan 2026 21:29:00 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 829FE8415E
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 21:28:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b736ffc531fso689339666b.1
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 12:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767904138; x=1768508938; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9AWM9yHkkvHoxvhpFMt1WFWjb4X4H636+0Zawgv7vtg=;
 b=NBedrbkVEQnsmC4jtcHWfhVWxMQ00hdu5HcYGQyhS/yAZKGU55RL56wWVE0ysZF/3n
 jcP8PS/k38wtMaOdDJWSokW9fd0p00AT7NCfnrpyKXspTnh6fr1wgOHxQsEkggkSlxOi
 LoHZVKZgoCBLs1+9RyzK4l+FxbI7HFD6+WmdgzwGRObhg7wUsJcLZgN10k9uDjku+lGz
 RmobDpcNJzgWRRt+hHooFkBA1Azi0w3xQKM3Dyp1AMkgpJB10DJqtgHX5551agRjh8Bz
 HN4d/LMqL+43wHijuFCjOeErR1to0z6x7/b3O4I4eARxc2kmo0Ycsx8ryTJ7NFmnepny
 t/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767904138; x=1768508938;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9AWM9yHkkvHoxvhpFMt1WFWjb4X4H636+0Zawgv7vtg=;
 b=Ijm18KZ4NKSvJZlcuSAZAccygqFHYPRSNGfbOun0RHVrN+He36UtOZR6+qxDHUcbUs
 JTulu2C8dYhOnwdxY+21IshykWMHrmqL8WIwLOl+jwmvCpuuNtcNNZ4sl3iSX0Q+Orav
 YzQebvlMiuncRNAG6C6XugxrxQarmdJ4Jl9GUe6wYX/0q/gc4nCePd2GnsfiP8PR8q56
 enBFKWJMBkXMgaZWT6uOCTfSdCP+5ivvyfPmqmzzlU1chzz4+KYmMi0X3bIpngHJkT/g
 S4OhW+DdYZVR7C2Rj3XXx7ZuDMt02LU7Vf9W3MtZL1ewcbcs1aZFFO0gUPK+Wc0Qx6bW
 FUhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgnagfLtKkpYHGFILoISUcRGwn6mVdqMFh5C+UVnBn5dbWJxh+I0E8HubqbVoEAL3yu6v5DiQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yzj+ZyGB5D4nK7/IHEZS4GIaoy9SHFNS08YNE72dpYvPUqomnMF
 2o95VrEBha1YyOck5hvmCpSadQTNZja5lARas3Hep/dCKjerzyVgsiuKJ5Brd0DSamQ=
X-Gm-Gg: AY/fxX4xMFaeHL40SvACHo+1dzrptEAgRc0ISoSwRHS3vCTdxkOV10TCzcecEtJPMpF
 z1+kG+1/seAC23avIklURzwWiiV8kzmZPpWcWKHu6gQN94WqO1j57pleIDbfF20+TpOU9cyN6Mz
 bzbiMBQMi8LzMdHhdMGxacILur9skC/BNDXLL+neBERK7exBC0MCWHBO/7P6Xa3W9u0wGK29y/q
 MNx45zAMPAAI+CFq6Pu9iBdVmAIBRXRHSQxeo3NiPGtJG0KPdaXwV05w/uIv8DPPbx3k3Nh4rMF
 0H+3BITUK7qrl2H+hKuPw1QjoSvvOzsm3s2pywlSd/yH/ntmvPggZ/yR+yvCLFQ/MpdCvgqNuFI
 zvv2/h4Puo3ChI0akZuXzdoLbGqy9rrsgV6Ss/g+jZNCdLCYBS/fPZSIM/AZhhtVG/d0MBltxUU
 9myzBuHBCBGrFVLpYhnpA+fsuxoQztyGANdXNeCVtPlcyBUQnnVsJFMA==
X-Google-Smtp-Source: AGHT+IEEc9upCmNHOPM99EE8bxvOibo2dWwTrGWwGpC70U9hE/QE16dP8WQxh5G/lgvmY8zW8Ec3fw==
X-Received: by 2002:a17:906:ee82:b0:b80:117d:46e5 with SMTP id
 a640c23a62f3a-b84452066edmr679062066b.29.1767904137942; 
 Thu, 08 Jan 2026 12:28:57 -0800 (PST)
Received: from lion.localdomain (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a564e05sm930264366b.65.2026.01.08.12.28.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 12:28:57 -0800 (PST)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 08 Jan 2026 21:28:43 +0100
Subject: [PATCH 1/6] soc: qcom: rpmh-rsc: reclaim the TCS to avoid spurious
 irq in Linux
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-rpmh-regulator-fixes-v1-1-d1b5b300b665@linaro.org>
References: <20260108-rpmh-regulator-fixes-v1-0-d1b5b300b665@linaro.org>
In-Reply-To: <20260108-rpmh-regulator-fixes-v1-0-d1b5b300b665@linaro.org>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15-dev-52d38
X-Developer-Signature: v=1; a=openpgp-sha256; l=1348;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=iZqMeQ2FWWaCrc7z4i7RafjSDFuqF2auNuNa8cJ6G98=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhswE4XZ/6bCdO9LWJh5V/uLyef7smVsfZqxz9QybeodL2
 7e6+R5rRykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZjIZAaG3yyLO6eKLa1w5/9x
 R+6fgi13oErvl8C1zrv/1OubMJx4y8/IsOoao2nE2UVq19+6Fzj+FvtWfk03Sqf71clFHUfzP0z
 +GA4A
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

From: Neil Armstrong <neil.armstrong@linaro.org>

If we don't reclaim and clear the IRQ bits, we might get a spurious
interrupt from this TCS in Linux:
WARNING: CPU: 0 PID: 0 at drivers/soc/qcom/rpmh-rsc.c:451 tcs_tx_done+0x98/0x270
...
 Call trace:
  tcs_tx_done+0x98/0x270 (P)
  __handle_irq_event_percpu+0x60/0x220
  handle_irq_event+0x54/0xc0
  handle_fasteoi_irq+0xa8/0x1c0
  handle_irq_desc+0x3c/0x68
  generic_handle_domain_irq+0x24/0x40
  gic_handle_irq+0x5c/0xd0
  ...

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/soc/qcom/rpmh-rsc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index aee9e55194ed..bc0c3dd005ac 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -399,8 +399,15 @@ int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg)
 			break;
 		udelay(1);
 	}
 
+	__tcs_set_trigger(drv, tcs_id, false);
+
+	/* Reclaim the TCS */
+	write_tcs_reg(drv, drv->regs[RSC_DRV_CMD_ENABLE], tcs_id, 0);
+	writel_relaxed(BIT(tcs_id), drv->tcs_base + drv->regs[RSC_DRV_IRQ_CLEAR]);
+	generic_clear_bit(tcs_id, drv->tcs_in_use);
+
 	if (i == USEC_PER_SEC) {
 		log_err("%s: error writing %#x to %d:%#x\n", drv->name,
 			msg->cmds[0].addr, tcs_id, drv->regs[RSC_DRV_CMD_ADDR]);
 		return -EINVAL;

-- 
2.51.0

