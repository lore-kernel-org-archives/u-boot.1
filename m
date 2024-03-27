Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C6EC54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 11:15:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE1A8880B9;
	Wed, 27 Mar 2024 12:14:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="CILKq/8c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FFEF88058; Wed, 27 Mar 2024 09:11:11 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B42887BAF
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 09:11:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wefu@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711527068;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aOce0SUk1qPhfFfeubn/8p7kqTJUFkazIDFqviQW8/Q=;
 b=CILKq/8cwLlx5yqnXzIsG3W1z7lQFUe+R6+S4O7PTUlOxv2Q0qKsELxAnUQORalz5E3g6z
 Z+n1K8SRQH7AeO+LqePCI0HtyI7CMr5iZ51+GxqImEZd+bbF2P2FGcayflo1EVDq+/D+f/
 cz7nFc9PfWl9AOm5NXaSlUfS34UXhc4=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-CSKFZsm7NhiCX-lhWBSvvg-1; Wed, 27 Mar 2024 04:11:06 -0400
X-MC-Unique: CSKFZsm7NhiCX-lhWBSvvg-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1e08039b8e7so5181325ad.1
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 01:11:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711527065; x=1712131865;
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aOce0SUk1qPhfFfeubn/8p7kqTJUFkazIDFqviQW8/Q=;
 b=ZwsHj0ivqg7xzJVOJ4X37TrwuM4wGudfg6uRTKkjzvY2Ctj2qf3nWcnpiDDwJp091n
 Tmu/5VVEXoZti6kN6LP+UQK6aEa6l8ceVfPDBOx7O5WqHl+GIvjzNA2jHE5PR8vkRy74
 gsnks+qiWdEQ5Fa9Gsa75wRDw9/OtpK+Y5tc/C7R/2U82Ec5e0VKgBI019PIQnmQFWfv
 2dRKMbnHYkshJ1nIOJUoBDrPtk/UgfNdOAanizjeIUuyCR0NRsSBuqDSl+8z4QXBI3FY
 BooCqm0np8HqFtBYNyET8eM+bGZQr9mEOkIsHVJTQqNveC+lBc2BPtHv96gCUDbv8/aQ
 dIkQ==
X-Gm-Message-State: AOJu0YxBR7KRMMlgpnqOPBFuR/vDTvdSOlnicTJRKuC65+/joA44JXLo
 CHReoSnRt+JY33bFbwQEuMSEzPNoLm3S1sY3WeKcvlMGkp5gGeLCcUh+jFoTLb4lGUyNDw4QxdH
 77yPmDI+WweR8vgzMy8TFjQyBGf9hgiuDknZrfUSY9xAWhd1TPnwVYmFfwNpiwFrRYHjD1HJxcs
 4mG7C7ER+yCVTnDnyFzNK2lf2FX+12eCbFr+I=
X-Received: by 2002:a17:903:120e:b0:1e0:1f53:a164 with SMTP id
 l14-20020a170903120e00b001e01f53a164mr6055396plh.0.1711527065300; 
 Wed, 27 Mar 2024 01:11:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8wnyW6pqCLj9hvtIBjI4A5wEIg1Arxi8V6gf3IEIghu40Gr9DIdLk9NVLH3l86AlKYxnq7w==
X-Received: by 2002:a17:903:120e:b0:1e0:1f53:a164 with SMTP id
 l14-20020a170903120e00b001e01f53a164mr6055346plh.0.1711527064846; 
 Wed, 27 Mar 2024 01:11:04 -0700 (PDT)
Received: from localhost.localdomain ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 n15-20020a170902d2cf00b001dcfaab3457sm8293709plc.104.2024.03.27.01.10.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 01:11:04 -0700 (PDT)
From: wefu@redhat.com
To: u-boot@lists.denx.de, bmeng@tinylab.org, rick@andestech.com,
 trini@konsulko.com, wefu@redhat.com, dlan@gentoo.org,
 joe.hershberger@ni.com, rfried.dev@gmail.com, ypron.glpk@gmx.de,
 michal.simek@amd.com, randolph@andestech.com, seashell11234455@gmail.com,
 peterlin@andestech.com, samuel@sholland.org, wiagn233@outlook.com,
 jonas@kwiboo.se, seanga2@gmail.com, baruch@tkos.co.il,
 kever.yang@rock-chips.com, sjg@chromium.org, gilbsgilbert@gmail.com,
 ycliang@andestech.com
Cc: tekkamanninja@gmail.com,
	tekkamanninja@163.com
Subject: [PATCH 3/6] riscv/dts: add gmac node for lichee-pi-4a
Date: Wed, 27 Mar 2024 16:07:24 +0800
Message-ID: <20240327080817.44501-4-wefu@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327080817.44501-1-wefu@redhat.com>
References: <20240327080817.44501-1-wefu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Approved-At: Wed, 27 Mar 2024 12:14:56 +0100
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
Reply-To: wefu@redhat.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Wei Fu <wefu@redhat.com>

Signed-off-by: Wei Fu <wefu@redhat.com>
Co-authored-by: Yixun Lan <dlan@gentoo.org>
---
 arch/riscv/dts/th1520-lichee-pi-4a.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/dts/th1520-lichee-pi-4a.dts b/arch/riscv/dts/th1520-lichee-pi-4a.dts
index a1248b2ee3..29f990c7be 100644
--- a/arch/riscv/dts/th1520-lichee-pi-4a.dts
+++ b/arch/riscv/dts/th1520-lichee-pi-4a.dts
@@ -20,6 +20,7 @@
 		serial3 = &uart3;
 		serial4 = &uart4;
 		serial5 = &uart5;
+		ethernet0 = &gmac0;
 	};
 
 	chosen {
@@ -30,3 +31,7 @@
 &uart0 {
 	status = "okay";
 };
+
+&gmac0 {
+	status = "okay";
+};
-- 
2.44.0

