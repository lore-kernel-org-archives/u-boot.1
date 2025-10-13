Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E5A7CCA476
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 04:20:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 943A183971;
	Mon, 13 Oct 2025 06:18:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.b="Y7LRwK1Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A36783700; Mon, 13 Oct 2025 04:24:50 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF5E9836D2
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 04:24:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jimmy.ho@sifive.com
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-76e2ea933b7so3440224b3a.1
 for <u-boot@lists.denx.de>; Sun, 12 Oct 2025 19:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1760322286; x=1760927086; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4q8mcZtK5vigM9XrSEBFR3n1JnPOkloSC7HTSBQLDoM=;
 b=Y7LRwK1QLq2M2J4BZZPr/CKmjUI3ZnxcvQczhIhTESYoEUV/XvT+1fg/om2nYt6DTR
 6gl5UFGFM1mwpDX7uFwJjmJ8KnsO9spRXF1w3dBPpt6VOc6Yq0sMScwvIyJOQDFALkos
 ODcq7/lDeGTCPcoWfVQuGMuBZiGYCa+mp4hxhQuliP9Ryqwoj9ZnmyLlRGSEJ4PNY1p2
 C7neFfre6Cgkmc/LILIcX/wgdRKv1Gu5+Q6pG8V6h0wfqjDZmS2gXvrEh5S6JT7Uf6rY
 ZGTgT/lsevrwvIkw668kQG02kUYS7sL/OVH0Us/cGs/eCUHHvQLTM14Xhf7ZWMTatcJU
 HGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760322286; x=1760927086;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4q8mcZtK5vigM9XrSEBFR3n1JnPOkloSC7HTSBQLDoM=;
 b=EcrqDtvb0OJJhGNHoFhRd/qm+RrBy9BBAWDJAo9sw6t3dM16RQgVDo9SphOC8/SLlE
 wJjzPf/XaLCy+rPDNShhWiMuQaO5Y0GVgH1yIJr4oLMjp86muDnmuzxdiEABN5pZOGHx
 NcxPnkHpU9YiGcCnQPg1E+gooeL5UAca33tGR2MZ7b8SqQI6pBw3Y2hHX8Le3BlBkRUv
 3wBojmddwbqna3o3qGO5TbvSlAWH/65gF8o/KYNFRwHPnzPVgCmkrUCyzaFnOlV4it6x
 07Bu2ooZ9ShDs+PHq+zda0KifCNDnuR98+UCMLKbXgMvYx7sqPXetvuEnb10gdOuVSHd
 5j3Q==
X-Gm-Message-State: AOJu0YxzDAORognr2JoW2IqpynftUT9+CmU7Bs1p+x5jChBxGcqyo9qm
 0IcrRsVQ7cBM0C1SAKFeF33AaFvqQfaEC1h/R6OTFKLbS5tGzuR+KpYk3UsHFEBgqfBrAcJgrV0
 VM6N9ac1nqhVEfVowy0/D2jVFaxlcLEduaRGf6G2K5cpiw+nFvfJnWiEjB+ONBlMXXri+yyoUmR
 +FfjHK+zDJg7mWtYgFIoDBTGh4tbB8MIDL4FAQoIy+
X-Gm-Gg: ASbGncsAcWis9YSSsDO9+ZaJ6r/qopcU7fcsz/EKhgL+ABWXkAlAXPizV0bEDV3vuoV
 ujrnlI+abcJPaFf5A/TsJm99Krseo4SKI7DmP+n/QSAdu0USAcxfi4k7QlW8YR4BvA865A0Jf4H
 bXuJvczza5pabOWlUja0CgRhTfIF4HrxLynUaKBRV7HuroqjBonI1NgZYcPQT+1E/mBdGEJwriP
 Y9fg1wGfEODCrLG4qK0Ci77Kzrk4MbLnESqxu0UD0Iz5ZMV4bZk8VTUusEtOFbarH0SjWllda16
 jr0SDzp1JJMaXlYINcGHIU5l/ztllXnEkXw4iqsC9lbxvDXdJp/AOzbWBXq/XgvqgiCRZjYjsIG
 lmc39qncDFiZ4XtJ7NZZuMLbQmL6MAiwO1oiw0j/RekfZAt64InZtp+PDVq6DcaZZ
X-Google-Smtp-Source: AGHT+IHFZxZTWQ4ACJqQ923z8ni01FnZh0KPmY+I+H8OgIMH+sbkwMesJ9Rh7Hi72WQHh12dtaf9cQ==
X-Received: by 2002:a05:6a00:1701:b0:78c:a3a6:a1bf with SMTP id
 d2e1a72fcca58-79397b19445mr21988331b3a.7.1760322285849; 
 Sun, 12 Oct 2025 19:24:45 -0700 (PDT)
Received: from hsinchu01.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992bb116basm9766676b3a.30.2025.10.12.19.24.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Oct 2025 19:24:45 -0700 (PDT)
From: Jimmy Ho <jimmy.ho@sifive.com>
To: u-boot@lists.denx.de
Cc: greentime.hu@sifive.com, Jimmy Ho <jimmy.ho@sifive.com>,
 Vincent Chen <vincent.chen@sifive.com>,
 Wayling Chen <wayling.chen@sifive.com>, Max Hsu <max.hsu@sifive.com>
Subject: [PATCH v2] timer: sifive_clint: Add GHRTv2 compaible string
Date: Mon, 13 Oct 2025 10:24:25 +0800
Message-ID: <20251013022425.1650-1-jimmy.ho@sifive.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 13 Oct 2025 06:18:05 +0200
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

The current sifive_clint driver can fully support GHRTv2 clint.
Add the compatible of GHRTv2 clint, sifive,clint2, to sifive_clint_ids
list.

Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
Signed-off-by: Wayling Chen <wayling.chen@sifive.com>
Signed-off-by: Max Hsu <max.hsu@sifive.com>
Signed-off-by: Jimmy Ho <jimmy.ho@sifive.com>
---
 drivers/timer/riscv_aclint_timer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/timer/riscv_aclint_timer.c b/drivers/timer/riscv_aclint_timer.c
index 35da1ea2fd2..175956bcfd3 100644
--- a/drivers/timer/riscv_aclint_timer.c
+++ b/drivers/timer/riscv_aclint_timer.c
@@ -83,6 +83,7 @@ static int riscv_aclint_timer_probe(struct udevice *dev)
 static const struct udevice_id riscv_aclint_timer_ids[] = {
 	{ .compatible = "riscv,clint0", .data = CLINT_MTIME_OFFSET },
 	{ .compatible = "sifive,clint0", .data = CLINT_MTIME_OFFSET },
+	{ .compatible = "sifive,clint2", .data = CLINT_MTIME_OFFSET },
 	{ .compatible = "riscv,aclint-mtimer", .data = ACLINT_MTIME_OFFSET },
 	{ }
 };
-- 
2.39.3

