Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C69ECE582
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 09:21:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 146B088F8F;
	Tue, 10 Sep 2024 11:20:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sx88d2oG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D47A88F9A; Tue, 10 Sep 2024 11:20:41 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8EE388F86
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 11:20:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-428e0d18666so48344705e9.3
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 02:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725960035; x=1726564835; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pXv5ZgubOL3yjfLM9ECp2Jx1KLJbtiMwclsA2KmrMo4=;
 b=sx88d2oGVrLUvxEdFcK3rDA9E03jP5cTLQsjD/4Wna86s9LwdKk+gKRwByUpfrYRhH
 MPazQaVog3wA8QoHpm1gGqKcGHDubLrIaI2h29Y/O1fYU9W28b73EIG8VTy9r7EhfM3j
 q9N6Gj+a0zPbKZoXzoxntMWCGE3pe782c+biTCJErC12IrErhN3FQdZx3nnlOHmBYBik
 +l00s8ccWrxNgA9mBiZoPX2xnJ7wazNXfkVxsAgsDznWpwlVsUTRGylSOwEk6AZUJW9q
 Ukoz6Ku88SkWegk5ofja946+lBsbMxZSEXkObW54j4uUKPuRXtmEXVKFLS7ud2ud0IXT
 Q0Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725960035; x=1726564835;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pXv5ZgubOL3yjfLM9ECp2Jx1KLJbtiMwclsA2KmrMo4=;
 b=SCuS5RzWCQ5ouhbv+1lZjfJChyaiyYHrJAoGRQXYBzy/DXr3YOEc/OoPcn+ToKVCq3
 u+AFdYUVZAA0Mch8PQ5B0YBoRP2hcxvVdODSqM8OR3DNAldq3fz8Jrdvn5Z9Th3hnlwe
 x3Z6WgziEsb95VlrBesx4r/dnLXqG3YdXkDa7NIEJ5PVobyVEIwPL8J6+BOTBCzIdUNn
 LFr0+sbOVv2C2VOfGNdzNYQehztF34iAmev7SjuigswxiKmnu+BgdO9iMJKyOh2pyPAY
 wwZUbAn88CONgX3xOokzG02mBqPVcZxbhUjUHFVPm9LC4ba+e0fFcG3bGPzHLlltXijq
 Yl1Q==
X-Gm-Message-State: AOJu0Ywm6JkcaV6y9PUBkcfri36xprLY1gdMtCyCs+cwH16hD3XmlA9Z
 547RECmIyAkBJ+BkcZp+8VXflV2KJHs+nq+h38Em/ngODmplas3q+v7mqy1Ni8zEGetRJAeUBP+
 x
X-Google-Smtp-Source: AGHT+IFiWx0uPcGbTSuBshMMiY6U4+H2z7bcNyZDxiYaKcj0b81j1dw5OyAwu2UuLWsvkdgzd36mAQ==
X-Received: by 2002:a05:600c:3c8d:b0:426:647b:1bfc with SMTP id
 5b1f17b1804b1-42c9f9d385emr98631195e9.30.1725960034596; 
 Tue, 10 Sep 2024 02:20:34 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42cb099acf6sm101256245e9.9.2024.09.10.02.20.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 02:20:34 -0700 (PDT)
From: neil.armstrong@linaro.org
Date: Tue, 10 Sep 2024 11:20:25 +0200
Subject: [PATCH 08/13] ufs: Clear UECPA once due to LINERESET has happened
 during LINK_STARTUP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-topic-ufs-enhancements-v1-8-3ee0bffacc64@linaro.org>
References: <20240910-topic-ufs-enhancements-v1-0-3ee0bffacc64@linaro.org>
In-Reply-To: <20240910-topic-ufs-enhancements-v1-0-3ee0bffacc64@linaro.org>
To: Tom Rini <trini@konsulko.com>, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=727;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=zS0wWmluBSs9D3MV9MEogWQo9jfQBO7Fvm6JkMA7XQ8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm4A9YiqiTELH8pKi5tTUq2w9sk5mWmQbb5kCys7aN
 6+r1j+OJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZuAPWAAKCRB33NvayMhJ0SH4D/
 9HpVAshxTVrcMD7xuXz5vbKKrmXqktPkB3d+3sqG6MCqm1H5w1i6Rj828769vD6DLkugiXbNdGFGQB
 9zQOywB8b+Z8WVuM2jWFUXVtthuJpbNZyvvY1Y9HlKHX+frAz5ONyDzsZ/545GAjWuyRttquFPj+rB
 6hn6rqfQBi+zWiEW0l12QmhpCZFVcAnGU4GfLoerbuIo7uy772EICTI7T6Jx8VXalnqK6pbNhmDfM2
 VSj94h4KpSStgjGYsbHsZUn5XdHzlyIW6YpgwubG3FaWhuhZYJB/nH45khSVZgShmUZxaW4MPLmdOO
 TqnpMoDGTlWeVvdDieoEZb380Uy/ffEWy6jZYhPoAc8kThm96FJ9D6oKDuuOho+QTyGVAHwEMPD1M/
 unQDhn8G/k7Slpmus5sY2WCQDo+2wECKyWn0tWPzvhiPAEPrXuayUjyexJHe3kOjL4dg8fAFjFp7/T
 kJhlQeObGDTqD8JJX5H2bDpCbuUXUYDmpcFp/EUPRXRCOeQF/WkkkweAnnn5oHZFqlbUCrKfTV85t0
 7hblavDGlN0Idti2a5RR0za5dNlcOjyxzOFjLLKgNlAaNQqzUvwJZbjt1rMoai8dmyTn3inR0NfRXR
 VQgFPqYotRfvYuYrsZjDOAdPonJnBfUWeJIdpvaH5wdBbSCJgmGHG9wY3Sjw==
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

From: Bhupesh Sharma <bhupesh.linux@gmail.com>

Clear UECPA once in u-boot UFS driver due to LINERESET has happened
during LINK_STARTUP. This makes the u-boot ufs driver behavior related
to UECPA similar to Linux UFS driver.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/ufs/ufs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
index d99dcdef7d0..565a6af1404 100644
--- a/drivers/ufs/ufs.c
+++ b/drivers/ufs/ufs.c
@@ -504,6 +504,8 @@ link_startup:
 	if (ret)
 		goto out;
 
+	/* Clear UECPA once due to LINERESET has happened during LINK_STARTUP */
+	ufshcd_readl(hba, REG_UIC_ERROR_CODE_PHY_ADAPTER_LAYER);
 	ret = ufshcd_make_hba_operational(hba);
 out:
 	if (ret)

-- 
2.34.1

