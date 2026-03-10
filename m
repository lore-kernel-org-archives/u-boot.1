Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5819FD2D9E
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 14:16:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B9978400F;
	Tue, 10 Mar 2026 15:16:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OVdTIsBS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9964E8401F; Tue, 10 Mar 2026 15:16:47 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D43783FE9
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 15:16:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-4672076355aso530959b6e.2
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 07:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773152204; x=1773757004; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IaMWFSt9apyFSFml1uOKpM7H66woIxCNNmQYYfXcRVY=;
 b=OVdTIsBSp4HmkSe3PIa6G+rHq/4w3KsSI1Tiwqo9+yGXNMdKcdunM0nzyu4wql63O7
 ZZKVJNTDOluHi09XnWM4xAPN1+7b7YNPj157E7v5s1do/nVKjy7bPxyWhiGYZ+JgKfeH
 fNdJ/zWg31tRumtga5wNtyzDNmrFXV8sjeC0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773152204; x=1773757004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IaMWFSt9apyFSFml1uOKpM7H66woIxCNNmQYYfXcRVY=;
 b=N9JPjl+VSx9OQXtblc+MsP9qhFHXkuGj1vBt3TGM2z6s3bi/d5T9pqRNjXWoTs57mv
 zqFY5qCkHbO5rZLP/s5YTwuasuSR9gRQf8NDQpFL8sVtnd4kDEAgdHuLamHy1swrlmPT
 y5/EuukSwScb6KS6EkTNp1MspwCslEGQ50349PVxO1YYPYWxzGWoNG+r6LD1I6XxU3CC
 qNfPm8iv9h5BKBu+lSSG/NOISzbt9+X6qZzlGdvvQ17k7HfXyIRsmey+J2R7GgxN3bI6
 P/lksYWmHyKYbo8mjygXWEDhfsbPAYg7mOWzxFmQXwjbKs0AQQlrhnIyNxZADf5u+ZJR
 4UMw==
X-Gm-Message-State: AOJu0YzxDMytmML3g+U4ru2SOvp9Pk7kBFQ3xV1yYBE8ogOjd54CkBg0
 OYo4bxOnpOh0cWy34GWwaT3JfEMk+N88XxR+WspwKAeBmNIuaf3eMuv4uZjm/0hG3cbZTadYDg4
 SSEeyh9w=
X-Gm-Gg: ATEYQzwbdE8DxZrp+gVdd0l32Sp8TFJySDuRVVkFPeGZNz6n91w54pykYU6xmHv2Pjw
 hC9hJP5KAQGX/CC4g/mithZN1Qjd6K2W+5OphHUfhqhQ+RjFH9Lpe0D5QbaoT9jLenp2X1dVG+q
 ISQDmLETvZRgzIsbrXkq2Gk5M+DMSFWX2eSK6usQWEhxgWq1qBqcbP7aOG4olU0owRcKkxxknaf
 cpoFkGkegU0RONQGS5my6gAU5mJm8LElL8amMqr9BJwfD/WHqstoLvUyuV/XOIrbgQSBJWilw1g
 CKQPb+iMaMQyWvy3lQe9C/lyWXWyHty2Jx7adOJ/oUNASolZXcPl2BtxRn829kK/5PfwoA6asih
 9EcBDl2srTXzBwqtkpOVkrzzG5sypMrpL9OxfoBT8pKQFyKgKRvIBKs7bPVrxOITHUpXYuy4m83
 i4Wf1VkOUTxDd5j7FrNQZbN3pZ5+EpvwKoUXa0/GLtdjvrK0eNbteF8zef6ULz4nUyfBJGTEi/F
 6rMZXi7PrIjhPcoSLolkGN3YrpHF6qd1WCWMrsR74EOfv8b
X-Received: by 2002:a05:6808:6713:b0:462:dbf2:514f with SMTP id
 5614622812f47-466dca56ff3mr9056269b6e.23.1773152203968; 
 Tue, 10 Mar 2026 07:16:43 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46718c843e6sm2430562b6e.12.2026.03.10.07.16.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 07:16:43 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Christian=20P=C3=B6tzsch?= <christian.poetzsch@kernkonzept.com>, 
 Adam Lackorzynski <adam@l4re.org>
Subject: [PATCH v2] virtio: Fix virtio initialization sequence
Date: Tue, 10 Mar 2026 08:16:42 -0600
Message-ID: <20260310141642.1122025-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aZR0WCHAC6KaJfH1@kernkonzept.com>
References: <aZR0WCHAC6KaJfH1@kernkonzept.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Christian Pötzsch <christian.poetzsch@kernkonzept.com>

The virtio spec clearly states in "3.1.1 Driver Requirements: Device
Initialization" the sequence a client has to follow after device reset.
Because u-boot resets here again, it also needs to set the "acknowledge"
bit again even if this was done in virtio_uclass_child_post_bind already
once before.

Signed-off-by: Christian Pötzsch <christian.poetzsch@kernkonzept.com>
Signed-off-by: Adam Lackorzynski <adam@l4re.org>
[trini: Add VIRTIO_CONFIG_S_ACKNOWLEDGE flag check to the test]
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
- Update the test to expect VIRTIO_CONFIG_S_ACKNOWLEDGE being set as
  well.
---
 drivers/virtio/virtio-uclass.c | 3 +++
 test/dm/virtio_device.c        | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/virtio/virtio-uclass.c b/drivers/virtio/virtio-uclass.c
index ac563991b90f..c36e9e9b3a77 100644
--- a/drivers/virtio/virtio-uclass.c
+++ b/drivers/virtio/virtio-uclass.c
@@ -292,6 +292,9 @@ static int virtio_uclass_child_pre_probe(struct udevice *vdev)
 	if (ret)
 		goto err;
 
+	/* After a reset we always need to start the init sequence again */
+	virtio_add_status(vdev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
+
 	/* We have a driver! */
 	virtio_add_status(vdev, VIRTIO_CONFIG_S_DRIVER);
 
diff --git a/test/dm/virtio_device.c b/test/dm/virtio_device.c
index 53414e4d3a47..c2cd0630d973 100644
--- a/test/dm/virtio_device.c
+++ b/test/dm/virtio_device.c
@@ -40,6 +40,7 @@ static int dm_test_virtio_base(struct unit_test_state *uts)
 	ut_assertok(virtio_get_status(dev, &status));
 	ut_asserteq(VIRTIO_CONFIG_S_DRIVER |
 		    VIRTIO_CONFIG_S_DRIVER_OK |
+		    VIRTIO_CONFIG_S_ACKNOWLEDGE |
 		    VIRTIO_CONFIG_S_FEATURES_OK, status);
 
 	return 0;
-- 
2.43.0

