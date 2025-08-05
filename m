Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959AAC87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 14:24:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13969831E0;
	Tue,  5 Aug 2025 16:24:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ROQthXjv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F3BF83753; Tue,  5 Aug 2025 16:24:35 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2C7483045
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 16:24:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3b7920354f9so5060448f8f.2
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 07:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754403870; x=1755008670; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GVK9yNm3ETpSJwi5V0nueDR3ygaM4iTSg7aFz+36fJc=;
 b=ROQthXjv7GYrXVuFY+/abyo6WzYxm0LH0r2eyQykl2FVD2mtyoiKwgpDTR3EcYGs9v
 sLodR5JSEuZjdR0BcOM6cFrnSeLLVhk0VqZoGSRCJNmwvPOmQUqTIbPak2U4afPACgVo
 0PMFoOU1Pm70pqtqRLXjujLvkY2T16G2YZUDNyhawZzg4VVOGz+7AfypEYBa6PCRbmav
 TAK4kKojTqOSXByXlPG0/1Sp0bc2BkyI3uo3KSyLobHGYaMgQzlgUtl8QdSsqYI61ZLl
 jI4HxUMpzPde8EBW+n4IUbQJnHvRZbOg5ivON8LlfBI4Sjvkh2VoBMrW4un6HOuGGiCC
 8ICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754403870; x=1755008670;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GVK9yNm3ETpSJwi5V0nueDR3ygaM4iTSg7aFz+36fJc=;
 b=CHRN+ei8GgFvNtF7xJ3MYVWhalYtj5IPJGIR6cZMegHLanSKPHWIy6UwFFdUnAIcdF
 +DmeswqHs9nTcozSmyf8noJCDats1QZUePVkEgYmSZy6d1sn5imT1ZFtyvxZqzQBPXNN
 xkmqOskAw4UTGnBlHq2ujDvO6C8738dUWH5Q8RhK5syWESGe50QAWWrsbRV+YgMJctxZ
 E39enPYySpmKf7kv42o6Zfc+q8ZknIYkfCfmGJIZRfETLVyhN6qI1y4vzCRcN8xZjP+E
 v+TO+m5hdIKYEXDG648pFEFj2h1i6eEa+RUrg3zWHh3kFoO/pkYQrehthDrkMOLQ1WRD
 CI4w==
X-Gm-Message-State: AOJu0YwWygOo/NXojY9TPOn+yNoLV2kbCE3wjvYJusflfk89eLh+7SHU
 WJX/L9Eq9YmPQ56rxbIHxdYfVIvQU10XTtaLQIs6Y0LnwedP+QJ3Wo3HbFmhSya8GzU=
X-Gm-Gg: ASbGncsMIiHVPv/1obGUyLhpa1ZkpJtWEoreBKBljYD5jt+C5JCvbe/LqnjnwOTtjQm
 yfxIU7+zi4ny9X1PiB58ruRQU2KwDYqIq24xNy4OmqyC3DB0YmQkMxOBxyxtKdwUPgSEBIY2Ux3
 YSozAWOZGY6irIBotC5SLpbYqodvqYJrG3wlmqM9DLm8Cv3cHn7KZrFot4rWjlqfTplD9qOMLQW
 VICrxbMYNfgfpkQ9FpgdDA+xfuBFHssgdJhm0TAo6quqaqchURGZvxgusQrotpiKKPBwDyi9ZDP
 fePtTqh+j2E43s1fmKpB9jMOOGeVZe445ct4AL/2asGIPhek64U7EIpCxsbrB//JdhILelzZ/nc
 kEVp0GYKsTOa6wCa3bLYYtBxRYWaU115/OnNR2G9Oj0vudENIx6s=
X-Google-Smtp-Source: AGHT+IEsPg5ylfYhdRIlX0NoIjbFnVImwJOOz7B8+vLz/gk8KN5gT1I1iJAMqyFZRDYUxBMdv47HEA==
X-Received: by 2002:a05:6000:430a:b0:3b7:88f5:f0ad with SMTP id
 ffacd0b85a97d-3b8d947248dmr10703887f8f.16.1754403500532; 
 Tue, 05 Aug 2025 07:18:20 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:60bc:24e3:6dcd:9f35])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c4534b3sm19307801f8f.47.2025.08.05.07.18.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 07:18:20 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 05 Aug 2025 15:18:18 +0100
Subject: [PATCH 3/4] net: mvpp2: Cannot test unsigned variable to be negative
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-net_mvpp2-v1-3-624ef87cadb9@linaro.org>
References: <20250805-net_mvpp2-v1-0-624ef87cadb9@linaro.org>
In-Reply-To: <20250805-net_mvpp2-v1-0-624ef87cadb9@linaro.org>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

In phy_info_parse all uses of the variable phyaddr are as an int so
declaring as u32 is not useful and prevents the test for an error return
from fdtdec_get_int ever detecting an error. Change phyaddr to be an
int.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/net/mvpp2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mvpp2.c b/drivers/net/mvpp2.c
index b68d305a0dc..3a3510f603a 100644
--- a/drivers/net/mvpp2.c
+++ b/drivers/net/mvpp2.c
@@ -4734,7 +4734,7 @@ static int phy_info_parse(struct udevice *dev, struct mvpp2_port *port)
 	int port_node = dev_of_offset(dev);
 	int phy_node;
 	u32 id;
-	u32 phyaddr = 0;
+	int phyaddr = 0;
 	int fixed_link = 0;
 	int ret;
 

-- 
2.39.5

