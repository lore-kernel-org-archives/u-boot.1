Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B84BEC46CD4
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 15:49:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDCD587910;
	Tue, 26 Dec 2023 16:48:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lLKLAa5N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27276878FA; Tue, 26 Dec 2023 16:48:46 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21E568760D
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 16:48:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-50e67e37661so3693020e87.0
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 07:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703605723; x=1704210523; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gahorcfoNv+yyzQwl9V0XMJNPRbMhyFuJjPHNmT7iCA=;
 b=lLKLAa5NxOtWp3Vx84zMRbPKW1eQ8YZD7EQRSIetN3+L4UDcbZdF5ZeRUz4oeSwkuL
 W5EZd91yFWxJxIz2891wjhULh6YXbQ8p4SBQYdGt56Tx9flPNyEIdhU4Eol3jVJonuXV
 rFH19Vsd84Gx/2j/FPVVD4In44jLce9sItToerUzX6s6TyzwdSns8U/EU5GszBD2fBM0
 6pBF1SHltZExYcohAdT6OBUbhq0QlK2lbPN5AFP8MeGUWZfqTnZ8AKBNRiFI99AxKFiR
 0Yiz9ym/AG5FhTdnuFyzZvSvcEePKndTGjVmqw9q/oB2bkyL1N1AO49ZJJZibsrRN4Fn
 FOlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703605723; x=1704210523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gahorcfoNv+yyzQwl9V0XMJNPRbMhyFuJjPHNmT7iCA=;
 b=ogPg81FIPzx/jw/WnILZy9V5cV6Uo8fd/hevD61kH29/6h6ZImoSv2t6BMP7f1YSxW
 ysTkZ11c8DplEgqSnRjhJVUT8qiJ9dtpv0WaJ05nYroRwTuChOEQGxaAOr/PgOvkN1ZQ
 4D7w+Q4Ypcnu1WaP9v57dLFiIMPAx0WyxzKJKPFQSeel35PWUyGQLSrE0YBzm1sjhI5a
 yoeRoSKSEgr5rNU3TvrBo9rb8xLj8Uvpk/9dQ4pYo4vBCssKLgQ/zsLt7r7lq/9caiRz
 Eprl0CJzCUi9l44Kv8QBVlFggr1xYQUEeKnNO4/4q8f0fS/l0DC91IgcoFQWUmDWCTvS
 VomQ==
X-Gm-Message-State: AOJu0YwR4hQKTLlE1s/6ZkDHNWrLnwykC2veyVsxkI+/7tB6ZfDbbYqM
 JPcIOg0vU+1XyM3/Yb6Ttal5RgA/krGZnquIVL3rB2aIm08=
X-Google-Smtp-Source: AGHT+IHgVOjF6pdoPjULMmP43thywILZYX5mgaTD1KzvAu7m1pFfVucYKLZh3WWa4wbEKn4VKcRN2Q==
X-Received: by 2002:a05:6512:61b:b0:50e:76e0:9ef7 with SMTP id
 b27-20020a056512061b00b0050e76e09ef7mr1294208lfe.99.1703605722629; 
 Tue, 26 Dec 2023 07:48:42 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 d25-20020a0565123d1900b0050e743b0b2csm1089336lfv.34.2023.12.26.07.48.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 07:48:41 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sjg@chromium.org, joe.hershberger@ni.com, rfried.dev@gmail.com,
 bharat.gooty@broadcom.com, rayagonda.kokatanur@broadcom.com,
 trini@konsulko.com, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv3 3/8] sandbox: eth-raw-os: successful return code is 0
Date: Tue, 26 Dec 2023 21:46:14 +0600
Message-Id: <20231226154619.5071-4-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231226154619.5071-1-maxim.uvarov@linaro.org>
References: <20231226154619.5071-1-maxim.uvarov@linaro.org>
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

all network drivers return 0 on the successful
transmission.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 arch/sandbox/cpu/eth-raw-os.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sandbox/cpu/eth-raw-os.c b/arch/sandbox/cpu/eth-raw-os.c
index e59b96be5f..92c35aed95 100644
--- a/arch/sandbox/cpu/eth-raw-os.c
+++ b/arch/sandbox/cpu/eth-raw-os.c
@@ -256,7 +256,7 @@ int sandbox_eth_raw_os_send(void *packet, int length,
 		       strerror(errno));
 		return -errno;
 	}
-	return retval;
+	return 0;
 }
 
 int sandbox_eth_raw_os_recv(void *packet, int *length,
-- 
2.30.2

