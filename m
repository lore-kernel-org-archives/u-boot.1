Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06118C25B75
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 17:38:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D07088607;
	Thu, 23 May 2024 19:38:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="d+RnWeQV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 261AC88600; Thu, 23 May 2024 19:38:23 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EAEB8811D
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 19:38:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-56e69888a36so13199447a12.3
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 10:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1716485900; x=1717090700; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DeD6c9O+VM3ae5xauUUcpq9LqvI/Cx1Euv5Him3gl54=;
 b=d+RnWeQVa++Y+oBzvoQv97BZKJ3rfTsvG+eynfSHq27/j6Pkt9g1AvvooSvTQQvuP5
 GGiDWPxQcSSsPnn1lshYz3/KmevYbTvC1ITr6H8AdmtNSmzojJvyZVrMOSuWe9TkAQF/
 74y0rObVakSKcHKiE6VzGgAQdIxxOgnABFoGd0GTZhYE6XPnNTBDREHIZ8lbLIcAjWgQ
 fd3u+GGa2ysK9fRh+0yFSZv+EBDEFNRs0ELb7pcSr6eDn9G5B+6XhDPT1lk7uvrNMHdZ
 FOuXS4AlQyjj4Z74nj0DtwX4tuHPKEkHmgpfDcKaxwlNX073Ro+JQyBKBhQ4spEGvOmO
 MPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716485900; x=1717090700;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DeD6c9O+VM3ae5xauUUcpq9LqvI/Cx1Euv5Him3gl54=;
 b=IfmOtEuhpvm9kYSb2V0T9SshZr/mK2btu77TZyLPWWCx1XuSc/ezWZoD2ZbeK3U3OS
 2k1nIzn+1DiOl6rII2WMuvrbyEZAdegEkXMCKRWPIr8CgqTkHqjxoVv/pbtPw1Mpjprp
 1ilLf4bu24Zb5mjVOd7hw+e6BRAkB/c/fObAjjWxWyTb91MZcURJmpkSYoiAgzqqXxZc
 bo+ERsAljmZ7B0+RdeW2dl3IvnMAunYixRioUhfYZNxSxAEz23rNLvhzt2enQFQwlTth
 DIn4HavA+OIUZbedklwK90xefS5js0Iwqk2RLhKEKHZQXKu/RY2hJ7ZUTqNeEgd1vPjO
 X4oA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3btSbQoo20w8wGETC6bIpMPdE1Wpc5v7Mng2JXynEFsnY0/XGwZ9YzwV/oBQsK/tkxcZTptUthT1Fw0OgzeHwnHDptw==
X-Gm-Message-State: AOJu0YyzFqlXlWsvFi2WVpnNqu+r8Zz25IeQDQRvz0OJwAWRvZO0f57R
 TG4+mBvqJpMAglFvRthxkEVq+YWrTaU7vRlGyiPuI5JHTXYLz9IN0GtqkaHk3JQ=
X-Google-Smtp-Source: AGHT+IERsmgV9UerSq9Qe00HDoXfqTpqNRDEVA6b8PndrP9i9sKnhWzIRWUxaVmRLejrv110sEbFwg==
X-Received: by 2002:a05:6402:270e:b0:578:34d5:27c4 with SMTP id
 4fb4d7f45d1cf-57834d52d03mr3827169a12.41.1716485900461; 
 Thu, 23 May 2024 10:38:20 -0700 (PDT)
Received: from fedora.. ([188.129.47.65])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-574f5a5b029sm12430366a12.7.2024.05.23.10.38.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 10:38:19 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: trini@konsulko.com, caleb.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@linaro.org, lukma@denx.de, seanga2@gmail.com,
 joe.hershberger@ni.com, rfried.dev@gmail.com, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: j.beck@linefinity.com,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 1/5] clock: qcom: ipq4019: add ESS clock
Date: Thu, 23 May 2024 19:37:25 +0200
Message-ID: <20240523173815.63628-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

ESS clock is the Ethernet Subsystem clock, so lets add it as its
already configured by SBL1.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/clk/qcom/clock-ipq4019.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/qcom/clock-ipq4019.c b/drivers/clk/qcom/clock-ipq4019.c
index 0492e536e7..e416c9cdb0 100644
--- a/drivers/clk/qcom/clock-ipq4019.c
+++ b/drivers/clk/qcom/clock-ipq4019.c
@@ -125,6 +125,9 @@ static int ipq4019_clk_enable(struct clk *clk)
 	case GCC_USB2_MOCK_UTMI_CLK:
 		/* These clocks is already initialized by SBL1 */
 		return 0;
+	case GCC_ESS_CLK:
+		/* This clock is already initialized by SBL1 */
+		return 0;
 	default:
 		return -EINVAL;
 	}
-- 
2.45.1

