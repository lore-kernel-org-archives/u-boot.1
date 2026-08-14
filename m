Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DFC2C5CFCF
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 18:39:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3907C60B16;
	Fri, 14 Aug 2026 18:39:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sFp4NjzH6jIF; Fri, 14 Aug 2026 18:39:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4494060AC2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786732751;
	bh=pzeHkXVHU5/KJm79XEWPHbETNwBCY0lmIZt98ASzlPg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=phOYaGQMjFsLuvyEOM1T9JJfKNkUpGcm/dNeRfyWl2bNGGi8MnAUeW0FZY1XHFRdI
	 XORP5zXYNpqxyUw6z21oASPHBkxP1/ourLIlmJPKPW/tYrNaITYoo3UA3guLcFu8hO
	 xflmuxwWLqdCovU6pdfX51ADG5cEHhF7t4eRFbvCf0bHzdKQVYB4kyoyKna/ZbnVFQ
	 oqcP8WFG1Qc4E6j3zZE2FlcyaeulEZ/eZ52QBiRffLfkxL2Vu6ex8gHFVygABG556l
	 SNVjYj6TuANT1EWRXdZDWRHQ8VjFeGRs5nsvSPDwYODnvsXCUkRognA7gIW76YKZZJ
	 lfD4wmcFsvebA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4494060AC2;
	Fri, 14 Aug 2026 18:39:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3D98E194
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:39:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2D4D481108
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:39:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3PTGggjKk8BT for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 18:39:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::82c; helo=mail-qt1-x82c.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 3A002812F5
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3A002812F5
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=Emn+fgM+
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3A002812F5
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:39:05 +0000 (UTC)
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-52cd38ddcdfso3924931cf.3
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 11:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786732745; x=1787337545;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pzeHkXVHU5/KJm79XEWPHbETNwBCY0lmIZt98ASzlPg=;
 b=Emn+fgM+aYpSXK01HgI+bBKK5XEvj6VIivDVr4X2L3lTbrIuh8aj2CI2Ln0IiloYEf
 GeyqZIuLkMvUMqNbPLxRifZdZN35VkneRXbLWQDa6Fw0cZ+Zx/syIwVf+Zkl9S++m7Vl
 ZCz++zb6LbBHa8oD9C+Zm8EJlvCp0xePaQ6GuUv19BsV9BFxyBRFZ9wTH6sBXsv9Pygv
 Zpr0xYWz/53tyE2D3KrfbLriroLB4fW3rBbNbdb/esPl+W1KN9BLQcAfVdYi6+Hc6TKV
 k2S4G1LVHvyctd/KORXBAFto12THNyhKryM6d6jUG6xr2PZIPxcECMeX+ebu8C1VMqM5
 ptTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786732745; x=1787337545;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pzeHkXVHU5/KJm79XEWPHbETNwBCY0lmIZt98ASzlPg=;
 b=ihAv/IEULQLWrn84mcWD6EHT+cJ2GoyBJE36KDXSgcjUwNeo9V+fhJUsnHlsgyzmjN
 SovhEmDIPvBSnPZOQIucYukvOz4/RoqKBTS+yijR+kpTf6vLxYqVe3xiGd/d7x+TpYFE
 CevL0LUqK9uJsIIW3LF0d8SrK15LglDb+Alz85gHyYNOhykG80NKZQov9og13OxQBX4e
 93lpGdxO5Iwv2+08g5pLq/v/TiTNBvBsYyDaU1Uy7ujoB8Ft+ADIoq3qtcOod5vWxqw8
 JLnwTtcWawAh1Zb7a6ZrsqF9HGP6JFlCI7JsByO71ow3t5QqY+1kBi8UQN88FWGCPKhU
 Uxnw==
X-Gm-Message-State: AOJu0YyTU20puhhEDVt+bJcWiAbKm/TSvHwovWh1D6cChNTnq3mG39h6
 3jy0XtGGOLj0tkH5kwc43fBlBCHe8d/nBV5wDAWiB7XacI1wpkF8jSvCgbO7YBLdElFZIwcOERT
 8UJd6jVM=
X-Gm-Gg: AR+sD11YKT1lnfpcVaj03tXiHeeUVhw1QCpS16OLk3lh0IRx5Lh7SV/i9uEDW4KNYJK
 9vli3ns/fcpCOrScmzzWCx4nvH7ODPUKZbXsT3ccFDwzeSfxA59Pj7XImP25VmGzTiEtmKwTlJe
 wW6+4jws8/uMIENvs0+1rtGb9OLKQ12N+5NO8VLqTJ3KI28sBClHZBBzH84dWThYCkdQX0Ek3yM
 XncUMOq8WfKEgx4azv2K4OFIIZ0XUq0VHGTBB8L4u/oXZ6SdmhwdTYG5SETiMTR53llR1644bf8
 D6Hqi+QiFcVCxdA/eGfp4kKVpG875sfaKMtXpYVm275byRgBkmjRehlOov8qqhhz4l2hgq8yZTu
 bXShDYR7F5Pi+8a5tGDVsKFNitQ3NTTu7k+WnaX032nTwXF9bFbknRV3HxbwZcj/D4pP9r9B3D4
 ybF9DFL4Z2YK9oqUfQ0R5788QMmyV2ZLuhrtIbL6XzZ6ipqLDtTHemGbRUN4g4eQFfae4QEb1eJ
 wEBwvhovE3fiQZTCZaRxc3k26nJmnOFZlQovp8Jcx8cjmgK4zM8Vk+j
X-Received: by 2002:ac8:7e93:0:b0:51c:1c2c:a8bf with SMTP id
 d75a77b69052e-52d85584629mr84087921cf.43.1786732744755; 
 Fri, 14 Aug 2026 11:39:04 -0700 (PDT)
Received: from maple.netwinder.org ([66.129.139.8])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52d83f00024sm27617031cf.11.2026.08.14.11.39.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 11:39:04 -0700 (PDT)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Fri, 14 Aug 2026 14:38:56 -0400
Subject: [PATCH v2 4/8] ARM: renesas: RZ/N1 QSPI controller features
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-rzn1-2026-10-v2-4-56b6acef0439@linaro.org>
References: <20260814-rzn1-2026-10-v2-0-56b6acef0439@linaro.org>
In-Reply-To: <20260814-rzn1-2026-10-v2-0-56b6acef0439@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: Ralph Siemsen <ralph.siemsen@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Udit Kumar <u-kumar1@ti.com>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openssh-sha256; t=1786732739; l=742;
 i=ralph.siemsen@linaro.org; h=from:subject:message-id;
 bh=nucqgOLzzgd5nw7OemCu68jJaNPebxWyN/FlvwHa1C8=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgG/ALfT0jfT5dAzjFlh+rTh9j4pAiw
 vPQ/tR3mihuAFYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QO4ku+RkCPrHwuhEvnK3HjwWOBkXGOzRfdsSDj8zKIyCKsgnjGjn3OXGl+f+tdoXuVLWiUxlDWt
 0xNkFp0KHHAQ=
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

The Renesas RZ/N1 has a QSPI controller which offers memory-mapped
"Direct Access" mode, so enable SPI_DIRMAP for this platform.

Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
 arch/arm/mach-renesas/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-renesas/Kconfig b/arch/arm/mach-renesas/Kconfig
index f86acc31039..4d16d541443 100644
--- a/arch/arm/mach-renesas/Kconfig
+++ b/arch/arm/mach-renesas/Kconfig
@@ -70,9 +70,13 @@ config RZN1
 	select DM
 	select DM_ETH
 	select DM_SERIAL
+	select DM_SPI
 	select PINCTRL
 	select PINCONF
 	select REGMAP
+	select SPI
+	select SPI_MEM
+	select SPI_DIRMAP
 	select SYSRESET
 	select SYSRESET_SYSCON
 	imply CMD_DM

-- 
2.55.0

