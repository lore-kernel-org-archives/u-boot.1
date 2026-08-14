Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0994EC5CFC1
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 18:29:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AC41240CF7;
	Fri, 14 Aug 2026 18:29:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j1bOkmDpGxZ6; Fri, 14 Aug 2026 18:29:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CF0C040CD0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786732140;
	bh=xGkVFflJGm1Jbi2OpEEtXcYGxso51++ZQUibUW5tRLA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ej4w2QLKnb85Rs7beoZ41giKKVJGA82OhiSIujDG9kWo1CG38vHRCvD8aY4aWfeux
	 1uM/12k+pXIuvf+eyGxFYZSbi0bs5ttktS71JWY/5Whn8suRgGCPjLF0/TzhmWi1r4
	 k8yPR83M7DMe5N+dEKbB3hNbz4L1Ji6JrAsLZnwWfZlISJ6yIx36e0Znk+GuL5eMP7
	 IHN+8N/gKCtWFqFiShTQmc2gt2IXZmSl4U1QfTj76ifqUevk+jxJjj79TM2wdsEBM+
	 1WvTxJJRk2gc1cKDxu0ZBYJrVpudrhv+1HIzFtvYAun1UVryQJzd2TqDb32s5FCsKM
	 knZLk5SZKlyvA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CF0C040CD0;
	Fri, 14 Aug 2026 18:28:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9AB1C3A0
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:28:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 817AA40AE9
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:28:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aihevRZ-FKdr for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 18:28:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::72d; helo=mail-qk1-x72d.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C2E42409DA
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C2E42409DA
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=cMXFE/m6
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C2E42409DA
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:28:56 +0000 (UTC)
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-92e5b048375so78172685a.1
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 11:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786732135; x=1787336935;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xGkVFflJGm1Jbi2OpEEtXcYGxso51++ZQUibUW5tRLA=;
 b=cMXFE/m6DplnzgPcnMogeCIG25FheIXoYG8I3DZ/cOxD5+4sutWy9n0vEzKGBbjQ/C
 5J6Pz0qGFM7/iWi4bwaI5DPkHVWmK9PD0GSv1m0lnm72QE+DsZMl2KiGRzTEhIsiC+lo
 ep8kM8lKSnO9iL2IDnYJSEFOMolpi5Nn4n4rUDAHTohJsWz+iPb6E7C8PUEW/xQ86mSD
 qMC4ak5kT13V8V4w8vlXi3wURQ78fSn3as29uXzELmL9dZzpovW1YTdtj1SAFvhZn5yw
 HhkIUMZ3/wHji8h/fLdbG4pjm7jN5R+fyt4EjncstMJ7uv9QYbEwyCUivx210mWOSaaJ
 y73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786732135; x=1787336935;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xGkVFflJGm1Jbi2OpEEtXcYGxso51++ZQUibUW5tRLA=;
 b=IfmfRB9sZRrJTsD4u7RKzzRtbq4TrQBujyZv2hi1S4LICOlBLsWrxpxpvwjvwPPNdy
 n1enlxJfZ1iaPfADteIj9gdRYyas+0sY3LWIeqJQWDgsZFfexJe00F54jPuOvZdGSK/S
 /Iup7qR9QYmzXS3HKzfAF+vI9qBHD03TDg8nEt4S2XNDWR76qqA5ZkkISHZtNGwG6EP4
 voUV8AMt3OjUDZ5S6qJLzJPRgQRTa8l/pph2DwJt0lA9GtjDQw1vUpe+K8chNnRftDqR
 LBtVd1EounmLvkVOzhHN+JAiwfZXbK2B50d+n5ZYUu1wJ9HuzsufeY/cmMQyEKGeclC5
 F1Og==
X-Gm-Message-State: AOJu0Yxcg4CIXKVw9ScXpX1YZUGitDx4I8TBLXEk2ROSYMY8LLbKOJkx
 lcmVGF4LwaJgCyRWhP+qDGCQ0pLZXU5zewQ8Tz0G1tnLnQK4W23hXmdKmL0cRsEOfUg=
X-Gm-Gg: AR+sD12IylvQbSuomZDmMGP4qnZz0d9iI25qBMKjIHIjOHiBmB5mgP05TfZIGZ5mfiK
 cELWOPzQgKBLXQz7xRBKNDlCTvicf4gkAI0asuMPFEgja2c/UXzJZRzl3Pb/0rm3yga61MFqnUD
 dSqNIm/ZL46/QtsF6dCOLx7YuXSDB8Oz80mfyXgVLgcyjDCwgYAFOEnHlka0VWDSf1FQNzGOMR3
 BVCIv1ek22B+uentCTEAII8FpcR2/cUNXR81NfHZnY5rTf8FuaTvU/7OAaucWJ7Y2KMN2HqyCQu
 1kBkn2ytC43+2oO8ExMsWi9AF/0KDYAUiAHosRsZDoDu+yj1EmAUlD8YpddmmT8iPFvVUXvctLj
 r9h8ehCZM1Tcjz2FMqtNm0aXDJIlUVmQ6k4kRIpX2jF01GMwZLjU9dPH8WHUL97dYoNclhGFdhJ
 1D8ewIpvEnARdVp/nY3F4jfftehViEor36D/N0fs3Mbk2e02s+MyZ1cnhNYUod673TXcnaVJx7y
 2paFKRIN7gTuYXiuPmsg6mZEagMoe6VyPZhRQfRBVnjUOp6fBi/u2Kt
X-Received: by 2002:a05:620a:3bc7:b0:92e:6c8a:2a1a with SMTP id
 af79cd13be357-936d227a067mr650390085a.7.1786732135424; 
 Fri, 14 Aug 2026 11:28:55 -0700 (PDT)
Received: from maple.netwinder.org ([66.129.139.8])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-936ce24564asm336071185a.40.2026.08.14.11.28.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 11:28:55 -0700 (PDT)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Fri, 14 Aug 2026 14:28:50 -0400
Subject: [PATCH v2 2/3] spi: cadence_qspi: add RZ/N1 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-rzn1-2026-10-spi-v2-2-973d5fa092f2@linaro.org>
References: <20260814-rzn1-2026-10-spi-v2-0-973d5fa092f2@linaro.org>
In-Reply-To: <20260814-rzn1-2026-10-spi-v2-0-973d5fa092f2@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Padmarao Begari <padmarao.begari@amd.com>, Anshul Dalal <anshuld@ti.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Johan Jonker <jbx6244@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Ralph Siemsen <ralph.siemsen@linaro.org>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openssh-sha256; t=1786732131; l=754;
 i=ralph.siemsen@linaro.org; h=from:subject:message-id;
 bh=5LICT4zxj4ArD3hif8J/acBPF1hbXaJZZqRebcmYq/w=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgG/ALfT0jfT5dAzjFlh+rTh9j4pAiw
 vPQ/tR3mihuAFYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QDnr/+VcVPybqcMbe/uMmDYfmG/wPJabAF+AdiUtMCp+R68utZSQwiopRFOkaxj4MknKhHKC7Hb
 NQTRTmzYSxwQ=
X-Developer-Key: i=ralph.siemsen@linaro.org; a=openssh;
 fpr=SHA256:12SQdavZEBUxPbBBtqQJgZ9F8vSvwTB6kFlSNgb4IcM
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The Renesas RZ/N1 contains a QSPI controller based on Cadence IP.
Add its compatible string as per linux commit
2b97f5cd1a95 ("spi: dt-bindings: cdns,qspi-nor: Add Renesas
RZ/N1D400 to the list")

Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
 drivers/spi/cadence_qspi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
index 0f70493dea4..12ac64c9e08 100644
--- a/drivers/spi/cadence_qspi.c
+++ b/drivers/spi/cadence_qspi.c
@@ -505,6 +505,9 @@ static const struct udevice_id cadence_spi_ids[] = {
 		.compatible = "xlnx,versal-ospi-1.0",
 		.data = (ulong)&cdns_xilinx_qspi,
 	},
+	{
+		.compatible = "renesas,rzn1-qspi",
+	},
 	{ }
 };
 

-- 
2.55.0

