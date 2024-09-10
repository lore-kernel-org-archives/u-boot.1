Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C289ECE564
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 09:21:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5CBF88F88;
	Tue, 10 Sep 2024 11:20:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vr8XgASi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B55188F7D; Tue, 10 Sep 2024 11:20:40 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1673788F83
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 11:20:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42ca4e0299eso28522275e9.2
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 02:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725960033; x=1726564833; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Gb0PkV2QOViT6B2gcnzaIs4IGKO1Z8HfdQrV/Um4OaQ=;
 b=vr8XgASiS1YdHCI7upoiCJRNFQxtpRfflCT82lNzS5dWeuDTdjBRB52Bs+m+kzrH1D
 gRr0XtmCy3B3E131vmv5s+McUPoBdvNvUtamSiPBEscLHyUhfjnWREHMuZP5bbn8spFH
 w4nbUa+Zoat3oraT833UyN86aQ9yLRMyCjyPzm4K0r/UzEwIgn8btFGxdoENKHk4qmBC
 gs1+y3XzbwcNvpYSlO1Yj2VqI4JaKPEhAsGGWPIt13B7zmP+L+kztck6An1HVHZ8UfLg
 Ukfk73HjuxvOJh7hKnFwlSmuZZtMeOkOmpDelOiss8knwla9c7ABDa7Eg5NsLu40iJHt
 9hFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725960033; x=1726564833;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gb0PkV2QOViT6B2gcnzaIs4IGKO1Z8HfdQrV/Um4OaQ=;
 b=meIHAUejUGkdUpT5XMKzB/c6VXXiv7DNmzkOhd5McA/OTtH3wTDatt5frMsKTwXBRR
 HzJT8LCA0zU2t6OK3ejDOH4MUlw/b7ki/18oJDOqDPD2OMYg50l1NKFPeFhhRA8ceVDu
 CFuzmeMBvl8FJFpWu/CBIMLEDgZh8TS+on6+EohvSBTU9WtRBmfrDxdopOznjcEWcRDf
 HuzZXwNWfr7gUNqw3PV6h9IOqj7T6HfFpBaZAEQfT8iml8xz1JO8Ll8rd5KAcrWAKm6L
 1r4f6HEGiDI9A0FarWuxfb+DUqPMz6oRUPyl9C+KvecF2bOYfw6bAHldctOzHeu9DJxg
 xVFQ==
X-Gm-Message-State: AOJu0YxGF17jNsZfTL1A9HSNVn9YpYcM+QE46FZi4ULZ5uR+eR1bkVql
 /tcP0IxrwIG630Hbdoz4FzbVk7zFtLpQ9VkHmmwOAbKmtp5IeAFwXDPo5A6JyG4=
X-Google-Smtp-Source: AGHT+IEW+ezLQYVs+af1/qJV1TfFJgo/sNUThgShKD3ihjL3xyAu8iHUMHvHgO4qSe9SH5pZqBIVgA==
X-Received: by 2002:a05:600c:45cb:b0:428:1608:831e with SMTP id
 5b1f17b1804b1-42cad76a0b5mr76602065e9.22.1725960032910; 
 Tue, 10 Sep 2024 02:20:32 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42cb099acf6sm101256245e9.9.2024.09.10.02.20.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 02:20:32 -0700 (PDT)
From: neil.armstrong@linaro.org
Date: Tue, 10 Sep 2024 11:20:23 +0200
Subject: [PATCH 06/13] ufs: Add UFSHCD_QUIRK_HIBERN_FASTAUTO
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-topic-ufs-enhancements-v1-6-3ee0bffacc64@linaro.org>
References: <20240910-topic-ufs-enhancements-v1-0-3ee0bffacc64@linaro.org>
In-Reply-To: <20240910-topic-ufs-enhancements-v1-0-3ee0bffacc64@linaro.org>
To: Tom Rini <trini@konsulko.com>, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=913;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=OW1BOfb9J2JCSQ+o+aNgKOU5e1Bne+zLUtmpxqp0jnI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm4A9YmaBGtI59t0o/zu7x5DkVJbiHlvvSjqTs7LPB
 SpvxACKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZuAPWAAKCRB33NvayMhJ0f4UD/
 0ZnFx77ghxKxiOudBJKuknEQX07KTN7dsuPa6wIs+cIWOvmcDaTFUnjrvEWGxrfTOE1LajIyckBc9t
 khWNnAEMCj/rAR3WCXKAU+LE/YjRSk9cKKFGdAPNbWTh+h5N8gaCFfjhGRHgqQkbWGyuFsIix0rYmU
 wuIYyYp2H9M6rz0WYe0R9kpMb2rdSva3sCwvEd3dSv2iZwzmuaAEgpCp0rwzvpP4K8M9FU8iOrDhnD
 WJ0FTUkKISWnXrHax/8CQrZ66yvxi+T8lacj8B3v8HbLpfy3y70cYQuAk+sdqbIFAIdLaCyphhBAZD
 3vT1jIdN/hhoPKgh3ncg5y7lyjD5gxdvklqsjIc4IJUk/UxsQntlbQG/+RDZXP9xQHle1WeeiWgC5q
 Wkqy3UHrqH+0BQ33pxAtimVJg0++18opp9k8EulIH4RLStF6axjucZ+JMMwH7gW2nP8Ecc4pzS8zpi
 YlCB1E8FUmURxgEeFSZGW2E2Q5cJwnDCAIaU81vnDyuagfGm7xt2SwBHLHiR2DuEtC8q4lM0Iv5BYV
 DWyNMPWNd3IszxjGg91ocfLNR3cMYKwO78USy48qTlv1VToIY1lHFdYH8orH53/BXgJikgOWssGTpL
 AtHfn5GAatHoAVu0IWwpgtoWtLO437KBzuWxWWX8YLNvrQMPa06X2hK1mQtg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

From: Marek Vasut <marek.vasut+renesas@mailbox.org>

Add UFSHCD_QUIRK_HIBERN_FASTAUTO quirk for host controllers which supports
auto-hibernate the capability but only FASTAUTO mode.

Ported from Linux kernel commit
2f11bbc2c7f3 ("scsi: ufs: core: Add UFSHCD_QUIRK_HIBERN_FASTAUTO")

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/ufs/ufs.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
index c92f47d82b5..b55c4a9e996 100644
--- a/drivers/ufs/ufs.h
+++ b/drivers/ufs/ufs.h
@@ -738,6 +738,12 @@ struct ufs_hba {
  */
 #define UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS		0x2
 
+/*
+ * This quirk needs to be enabled if the host controller has
+ * auto-hibernate capability but it's FASTAUTO only.
+ */
+#define UFSHCD_QUIRK_HIBERN_FASTAUTO			0x4
+
 	/* Virtual memory reference */
 	struct utp_transfer_cmd_desc *ucdl;
 	struct utp_transfer_req_desc *utrdl;

-- 
2.34.1

