Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C709C5DF8E
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 13:11:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 751A640545;
	Fri, 21 Aug 2026 13:11:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1lA1-IWp5Ag1; Fri, 21 Aug 2026 13:11:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787317903;
	bh=+EVoh8XxOEFKgm1TTfgZtymBd7LymCMMMb5c9KyxQVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uwmse+ewFg8RVpwMQKHUhKfaTkj7V3rhCTdlgoO/uM/eaHKa7d0J0BiQoCybaLuRj
	 SV7kS/xtVewt6qqMxWQD3sZZdak3uYLYi87qAgOPbH+wutXKXs4oIpDpYAJjK/sXX3
	 YT7H8jQaSCb/O5zMWUxvqf8cF6bNd/FjHsRrPsyTGuZrSXHcU+fZIdyWQdLHZhwoUB
	 ta7Tn+uIB90HPk+NmiAfrrc28V0I53AGERf9zn85V9uhuWCkQiL3W5tUVuHMlrUSOH
	 /SMEoVwzyz1HqzFkTcaQRs0Wiya+4H4XfJZihh6qKjHfJsA02QdMp81JcN/6aGxok3
	 Awwbxw8Hi7VuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9F4014053C;
	Fri, 21 Aug 2026 13:11:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B6FD71B8
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:50:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A8E7C40071
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:50:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qeLCcrwqURs3 for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:50:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=HXCkW5O4
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8BC8C4006A
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:50:53 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6a18af264f9so185107a12.0
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 01:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787302251; x=1787907051;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+EVoh8XxOEFKgm1TTfgZtymBd7LymCMMMb5c9KyxQVE=;
 b=HXCkW5O46HfTq2MaQlhstYunq5DoBlEev7NvUiP1cE/1Y9kOudUfTJ5avjBbHiwkzd
 81jGipJWvbwQrAP/pyioa7wWa1b29sYRDP1baUsqSbtoQEgE8SH0rxbziaXZd+U5ox56
 atqfxUn5wDnWVpwZK9HLZeq73VHMMU+7RJqKA1498DIllrfkrZK9PLrBztUw0bfs3vvN
 3l3q4bc4mr1c2tkhA1ln723vjLxEF6+J/yVHccv72wmWr/kxCR8oPzRctCFwxc0kzdN5
 vMvDvqJw9TQzc2f319lcl74/X680iEk5nZcDoRrw7Y67WAGmKjR/YyNvt1tS3i4VMIFo
 vxsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787302251; x=1787907051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+EVoh8XxOEFKgm1TTfgZtymBd7LymCMMMb5c9KyxQVE=;
 b=MEc5phrpbbzZapqvPY5MwQNsewfe3IY3gBJw15PUS6GXp5n72oX1Y6zbVC0iX1HVvl
 QsaxQIGX2eV54EndB560RLmu12/2WZ3FOQUXMThOL0BPkWLCARoT+SqMgJVaICRVKBIK
 AkAXAYIBl6gooYxmicmx7WxD83OZrc/ZRpn7z2VUYaeKYKzoijgmugv78AaOGyf1jL9g
 EfqWAYOypPnSbAZs0l9PSo/cAp3oNdRW7+FwTNO1FeiO27j6vEkn8IkZ5FBnfMZztcsv
 PYKeXsVe1jMMy6AFN0GlsPcuRjQofVuZCHeSG2RCLDfuUTfkNEx/hyxK7wn1yq6G6S0h
 +tgw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpi+lD371QoEvfcM3dnFenLRWRwJ7RO35isrEa1/jBs4nb4RjEZQdsN86zBpmDwyU7Yu+j4Seo=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++k90d7aknY6mz8BdAz7hgui+XEScWafyaZC43yCG2F5qJsmaMHv
 335GBUJsXdVcUvbx0D5iCWHpJiS2E6vlU/vhyL8hS7LVIyzRIsTMzu+jHNaXect9FsI=
X-Gm-Gg: AR+sD122nmJqGGHQJ2ID17tSC0SRivs4pXtGgsa6lBFLy5jCiM94VtqGqLtTyYTrVuz
 e+KDZkFI9k17mSMQpFZ70seqbcl6QLOQpsBI69cua6ub3oVNwtkHxXqauc7L9PfIwLg3/5Ytq0m
 UvsmNIi3ydafTBeqCj2BzIWyyk1MOHwKdXxzL9sw18ztLKC5K4MEMjOgPZYV2vtr96XStbIGVBx
 ajeh0iAdt7GlIRNhFvO2HMAsnjcRoU4OkXRYwsXUtb3Demf0AnPhrDp93O+2hYICOJrLc+KNTPz
 qC+zIO5w6PKKjtyhaVJZYKcUnP7FZXLHTrSGuPhsF3XHTmcZyNWsPKVOkDB8vBbWgZCw/kCnQeA
 pY0cDiOD0F/KUmiGk0WZWKKOnwjhMNH/7+WBRY+x6sedGU/wbuEucqzDg+pEjLQeZl0pC/DQyZm
 rGx5CgCi6PecluqNVx/QxFKhorsFdzJYdoy1cVe2pjkVmIMUy/UBhGfL9PM3zfUbgAGOK5AH8NM
 a+CG9Prm59MNbMZGpFIgVEy+wbZleqWnCI=
X-Received: by 2002:a05:6402:450d:b0:6a1:f95b:8cfa with SMTP id
 4fb4d7f45d1cf-6a42f1b47d8mr2935625a12.1.1787302251293; 
 Fri, 21 Aug 2026 01:50:51 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3feeca188sm5586862a12.6.2026.08.21.01.50.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 01:50:50 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Jens Wiklander <jens.wiklander@linaro.org>, Simon Glass <sjg@chromium.org>,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, u-boot@lists.u-boot-project.org
Subject: [PATCH v6 03/87] usb: dwc3: import from kernel v3.19
Date: Fri, 21 Aug 2026 10:46:39 +0200
Message-ID: <20260821084829.2070426-4-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821084829.2070426-1-anders.roxell@linaro.org>
References: <20260821084829.2070426-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 21 Aug 2026 13:11:39 +0000
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

From: Jens Wiklander <jens.wiklander@linaro.org>

Sync Linux kernel dwc3 changes from v3.19-rc1 to v3.19.

The following files are preserved across the import:
Makefile Kconfig dwc3-meson-g12a.c dwc3-meson-gxl.c dwc3-omap.c
dwc3-uniphier.c dwc3-generic.h dwc3-generic.c dwc3-generic-sti.c
dwc3-layerscape.c ti_usb_phy.c

Skipping unused files:
debugfs.c drd.c dwc3-exynos.c dwc3-haps.c dwc3-imx8mp.c dwc3-keystone.c
dwc3-octeon.c dwc3-of-simple.c dwc3-pci.c dwc3-qcom.c dwc3-qcom-legacy.c
dwc3-rtk.c dwc3-st.c dwc3-xilinx.c host.c trace.c trace.h ulpi.c

Note that this is a raw import and doesn't build.
A fixup commit at the end of the series fixes that.

List of commits: git log --oneline v3.19-rc1..v3.19
Commits imported:
39e60635a015 usb: dwc3: gadget: Stop TRB preparation after limit is reached
ec512fb8e561 usb: dwc3: gadget: Fix TRB preparation during SG

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/gadget.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index f03b136ecfce..8f65ab3a3b92 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -882,8 +882,7 @@ static void dwc3_prepare_trbs(struct dwc3_ep *dep, bool starting)
 
 				if (i == (request->num_mapped_sgs - 1) ||
 						sg_is_last(s)) {
-					if (list_is_last(&req->list,
-							&dep->request_list))
+					if (list_empty(&dep->request_list))
 						last_one = true;
 					chain = false;
 				}
@@ -901,6 +900,9 @@ static void dwc3_prepare_trbs(struct dwc3_ep *dep, bool starting)
 				if (last_one)
 					break;
 			}
+
+			if (last_one)
+				break;
 		} else {
 			dma = req->request.dma;
 			length = req->request.length;
-- 
2.53.0

