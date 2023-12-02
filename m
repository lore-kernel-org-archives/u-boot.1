Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A75C4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 06:57:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45DBB874BA;
	Sat,  2 Dec 2023 07:56:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="U1JIcXJv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD85286F40; Sat,  2 Dec 2023 07:56:52 +0100 (CET)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com
 [IPv6:2607:f8b0:4864:20::1149])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D678187158
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 07:56:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=3MdVqZQcKBrgkmpgrxdemmejc.amks-Zmmrjgqrq.bclv.bc@flex--moritzf.bounces.google.com
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-5d3a1e5f8d6so39248647b3.3
 for <u-boot@lists.denx.de>; Fri, 01 Dec 2023 22:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1701500209; x=1702105009; darn=lists.denx.de;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=y+HUbXdKs+1/01U+vGeJvuqct5wxaVNkFRe+9VvwgKk=;
 b=U1JIcXJve7F1kIrmoyekaPg0qWui+iUC+8uRFyodf3OSkBQVEVtYXgcME2A8YXCq1t
 ltm12V48jBx78YpYx9K/JIAzuGejcDywSg0UyzU4zKkIzARSoyDiXnAqAGeH5YO3V1ws
 gG8ln6qMdarvnEoNrt1ryZLYIdc6u3aYBmYQPEih+ctmJCRWKIOOkiawesxyxxMq2SLK
 JWUVUki9qd0mbcN33wDRYYCkjHAMEBduUKtPcbnRTD3eZW6Gks4o4OUSc53z/QNXgl1N
 GenU9ZhqXrzy9tFhEgRaH276omd4kTntwR4XoRRy4BBPCEmGtW8J6HWeovyH8qr2maDk
 DEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701500209; x=1702105009;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y+HUbXdKs+1/01U+vGeJvuqct5wxaVNkFRe+9VvwgKk=;
 b=D+E2iifI6MLx6Qu8WEVR8u1obB/PmV/yCDFAgAXmzpIHEDsiWVnACWZ8V++3uX0QLP
 Qopm3VOa6KRr9KsGP7K7EYf1xUHLoD1TzZ52BoPZQIDTgacFTW4JKab3wj4KBBSGZtpo
 UDQlwqFAktlTXZfVmdlpmuzb/YCGqrcey88uugrqhpo/n5TSbekinhnrtb+beKPiFAiN
 Z7fJqMRLFBh2PrsUeIF7ZNDozdgQH28UdB7zqh67XcYvhC6s0BKT7Uw0DIlufAljVO14
 1aCj97QmZ37wpQZbg8TIT8cmfAXq6lngth5M6eOjaCH0yJMwTxCoIZzEwAxY4soGjDF9
 9OzQ==
X-Gm-Message-State: AOJu0Yz5Ic4eDh7SVCj2U0Kp4FdZlRYPGzUVw9E78CMkNLHOWVcMBVhg
 oBCd+nSZkCjvTU2Ve762C47uj3NO5gDM
X-Google-Smtp-Source: AGHT+IFUSNRrGstpd2gNeOE88QIT53lPHHdjTqyML314kvumm0A6SuwYMz0/c0NFUaP7Nnvi82vL249QK6gt
X-Received: from morats.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:d9e])
 (user=moritzf job=sendgmr) by 2002:a81:8344:0:b0:5d5:6a4c:b0b3
 with SMTP id
 t65-20020a818344000000b005d56a4cb0b3mr135515ywf.8.1701500209644; Fri, 01 Dec
 2023 22:56:49 -0800 (PST)
Date: Sat,  2 Dec 2023 06:56:34 +0000
In-Reply-To: <20231202065634.3641171-1-moritzf@google.com>
Mime-Version: 1.0
References: <20231202065634.3641171-1-moritzf@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231202065634.3641171-2-moritzf@google.com>
Subject: [PATCH RESEND 2/2] nvme: Update nvme_scan_namespace to keep trying on
 busy
From: Moritz Fischer <moritzf@google.com>
To: bmeng.cn@gmail.com, sjg@chromium.org, wenbin.song@nxp.com, 
 u-boot@lists.denx.de
Cc: mdf@kernel.org, Moritz Fischer <moritzf@google.com>
Content-Type: text/plain; charset="UTF-8"
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

A busy controller shouldn't be game-over for all controllers,
so keep trying on hitting -EBUSY.

This change brings the actual behavior of the routine in line
with what the descriptions says.

Fixes: 982388eaa991 ("nvme: Add NVM Express driver support")
Signed-off-by: Moritz Fischer <moritzf@google.com>
---
 drivers/nvme/nvme.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/nvme.c b/drivers/nvme/nvme.c
index ec45f831a3..59a139baa0 100644
--- a/drivers/nvme/nvme.c
+++ b/drivers/nvme/nvme.c
@@ -695,7 +695,9 @@ int nvme_scan_namespace(void)
 		if (ret) {
 			log_err("Failed to probe '%s': err=%dE\n", dev->name,
 				ret);
-			return ret;
+			/* Bail if we ran out of memory, else keep trying */
+			if (ret != -EBUSY)
+				return ret;
 		}
 	}
 
-- 
2.43.0.rc2.451.g8631bc7472-goog

