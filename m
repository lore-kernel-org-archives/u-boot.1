Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EA3606CA4A
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 17:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PN/UCHOi;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=KWX/VIk1
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8601880CD8;
	Wed, 18 Nov 2026 17:33:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9CJ01-uKYC3X; Wed, 18 Nov 2026 17:33:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C94AA80D3E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795023226;
	b=lQVIsl0tU5eAi05xbxP0IodUNtr2E9gU3HQ/maIlfodUmdDURnJxJkR67ZCLXoGw8De2
	 JLx1smZdkWMF6R0IhSRaiclFlTiHXBkf+voUdhXb5s0X+lHb3pIQTzqXQ1mEdFi83gdeG
	 gMLEsUpHk7tkEr/CxIRmFMKssmUk6wrmMMJJWtI/kzOHAZ7PvZb8n3hldJHaFt59NaCX1
	 nvd2kNXFgm0oeBdoS83HZ/KYT8EMzoxZyIsVNOlFYOXTJt7voOBMOsc4GyhkZeow7QTkJ
	 Ux4UN8R5nEkd5DIF+1MoKBzGYbEi7N6Lqe7mtfiIXm8WuuKItT+g7QXvn596FrGIwwQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795023226;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Sj04cTjSHqH2Q2drdN1ZkrxA8i1HSkcgWBEllR79UnU=;
	b=IspaR+uKRdS9LN/FyFu3a7kARWl9gfd/T65mvNq36l7+leVettJQ6tBwKsUJXaS9LzUD
	 uuAcdwyqamL3Eur4893K269cW9TkVYFGQLZktM1GrUaATYziMGqE4wrXxa34VQhMV6QDc
	 OmXYxew4cxZBAdLCN1pe2Q45CyEtB4+Lt61teE6do6je4hjnlkwXlC5Cp8UM5ur/bXDdO
	 mEInU9K09PdWk2r1w7CSMmNQo46UhGqh6KV3oQZ/feMalLS13oXuOqY9vYNOyzgZgzqey
	 nuMqcr4LfsCkjZ89445LrPRBxMUTUvhYQiBcqteNMDX7KqHlxtj67clkypzCB/MdcgQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795023225;
	bh=Sj04cTjSHqH2Q2drdN1ZkrxA8i1HSkcgWBEllR79UnU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PN/UCHOiFdAgUQo+nE9X/XtZe6AwbaGTNMhH922XEKHzvgDUAk7CUFnKuVOWLhiwE
	 wL1nuZUio7EUG6d7+/MSQZm8XbHLPNhHL6fvO1zM8Q2swstlWq20wvlFQy9/648+p8
	 62jEI1E8aFkfFz7KkVTWdvTbk+ArIJAXKeKQo9ek8yUwuER3swO+GpAjvYRUhFyxRi
	 eol+1sGnA3VReOyrUyo8iEjt3mksIs2XOXJpmeiufzK7xO5B+wkdKxoT6E0HBnEjNg
	 c5BI9/SCJ7t1xisg809Kw4q2z8TY1v/6AGhjymp2Ovfq8lx7IcTtLmwAoSFnIHZLos
	 f9PRRdgkTHgoQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C94AA80D3E;
	Wed, 18 Nov 2026 17:33:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3FCD649B
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 17:33:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 31E844009B
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 17:33:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zfjc1pYNBXnR for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 17:33:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 66B5440095
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32c; helo=mail-ot1-x32c.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=KWX/VIk1
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 66B5440095
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 17:33:42 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-8629fc8ad64so688212a34.1
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 09:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795023222; x=1795628022;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Sj04cTjSHqH2Q2drdN1ZkrxA8i1HSkcgWBEllR79UnU=;
 b=KWX/VIk1lRx0RbFZaXKtXwNsG7Mz+YiFFJolSPQPOdHxvGc5OeH+ljYyuViUQHW+bf
 V9EV+2okxoNtYMaBdmWKSD5CLUUbq7zyVs4QQxIwN46WSKjfx4L3O4lSQ4I611JHBphS
 ypibXQyV/6nGc2ExJYX50SX/UA4yDZBgl9eNpVgGZoF72bD/45Z+woFYQAKP2SYIqk/6
 fp+V5uIKMr/0K3AnnyFBVn2wCXSf4wNRR1RsAo5ujoPAz9srqKXnrqjd1PMMtBoI+i+j
 A9Fug9AI0y6oMxNgQRx6bcsf40DHpJcMpMjRWl6mBg6orFVRMxJOVFgCrYpxwinBhaM+
 9LOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795023222; x=1795628022;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Sj04cTjSHqH2Q2drdN1ZkrxA8i1HSkcgWBEllR79UnU=;
 b=ha3j2zebtPJCr/F6RV9Of0QM/X/SJ0mA8myxpmTcQa8Bz9mKa7Y0IJ9v+gtYGt14uP
 ykgKQDq1+C3fIQx36FD+Y2oKdAPMelfGhNiGmYSo5EnsxUmmokHZBcBmAaxsPTSHYg2O
 ieAiM5hyP3pq0bqFPwGLr3IiVM+p6tQJl/2yW7LafDZj3gBcNuIZvapJnw1XziiP2AYp
 yKzmPe1g+M8kRL4gcySDRg9VHGR3s7ARDrJeABTdslLn6Pu97bJgQ4TuGDoKEyqUQaxf
 Rc3wp7AYchEvmmqgljRXfQYewxJOX6j3TKrkyXm6c6GCr+2Aq2bZzz23sKVTKykF71Vs
 881g==
X-Gm-Message-State: APuU4Z/QWVy4nBGyi+wszYba9yulkLxm+VommcBUQAb9+u6PGYa5wfiG
 ch7z0jnTba7p1/i0lbo6oLorTenPO+BJSgBEMbM9eoY1Bf1FYKLOLLZ+VVJLD7gWBrDeIDSlaOa
 G/Vq6LTk=
X-Gm-Gg: AYBFou3i9hm/LcPVvna+66suBjU5iFEQQp4odxIiV5QixX5yihRijCV9WEh/sUsJknX
 kRxpEAPsGk1PnmKe0Lqh6P4x8AhkbukPfaHvcv559r6eoC1ryJMJwOhZf/dmcH8HY8DzZ2FnNAQ
 WcNsEm3/evoqOiG7hK3qSXLfpxsqAGxlH/NWlQ+rwSQMU/6TkDD2AfLmGHFnuwqZ5YlXdgmI/xp
 SHoBEHRkLVQqbcI1P/o8H5448ihVGpJeBrOeXBF9K+hkgpYpF57xa7vl2N04eSauEhIk+8xwPsF
 FwxN0Ll8y+fBSMPYbIQUBiigZJA5rnxBn9V8IHMJ1SqVIfhJ7Q+SvqIsa2nPiU1n9Z9Y61xvTbE
 DMOEzfpKx+EOWUlDFq5RRkVq+rIeKXv0CFVhow3yoKHAMSLeRf0lM+fzKQzR4XLXCbBTCiyTFmG
 xw7PvsJTsec4X1WVmm2/fRTXoRIlo1Vw0zciI27spYOUSKD3k1UTdcJFW2P8FH/Tw2B6t4PUQkG
 NQ36ci1rg+FTOAolrArzKjZMQ+wWjaovYSJt/1492FidTYZN9QXKEDZIaW2FfBIUhBTB4sFYHrH
 WqHuMVcl3waq20iDq7b3RIaJjggv2UvM/9NEssoScM6jto17FR5+kA==
X-Received: by 2002:a05:6808:4f06:b0:576:4595:9822 with SMTP id
 5614622812f47-5773f052829mr3959627b6e.24.1795023221708; 
 Wed, 18 Nov 2026 09:33:41 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:9834:2835:378c:43f])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-5777ae93f99sm2193865b6e.14.2026.11.18.09.33.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 09:33:40 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 18 Nov 2026 11:33:10 -0600
Subject: [PATCH 1/3] fastboot: spi_flash: fix probe error check
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-fastboot-spi-flash-fail-response-v1-1-98c2a4748bae@baylibre.com>
References: <20261118-fastboot-spi-flash-fail-response-v1-0-98c2a4748bae@baylibre.com>
In-Reply-To: <20261118-fastboot-spi-flash-fail-response-v1-0-98c2a4748bae@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, 
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1519; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=+FEdyRJrKyaHoBLvLaHSeC8a/xChkRrvepsMJxht6nw=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq/eFdb55EV/k8HwV4asETz842Pgkg0iPGBRAQa
 rjNG/urknmJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCav3hXRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AJ/sIAIEv5oGS74fJKiM6eNO7GZIyvFJgHYqVTbH9WvF
 so0D7nVtUtUsrZNmkwBMznGA0bqSBNaDiSQH/SPbB0hmL4uKh62mAwhm5ujwRe17tmFdxVsMbvI
 m+Wzte1fsb6ZZuz1G7v2Z2D8mRh7rMqkmHCa/UKR5l2oGtZrWg8hFHMaT4xwaORtNkv1Vm0Ssxr
 0TAR8SGiQa3joLQsXhNUi5FNmwCI/yt8KGf+zLMvayzBxxFc2uusqYWvzXVvx9Ij4fLN1tw1VYt
 a0rN53S4X0O6uLsFCdgc0ZDUwkf2CUXeZqifQutUKxiyR82mMgmw1sIC5SSGXyk1jI2mFnvan2Y
 LxNc=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Check the return value of spi_flash_probe_bus_cs() instead of using a
device pointer that a failed probe never set.

If there was no device at the chip select before probing, the device
pointer is uninitialized when the probe fails, and dev_get_uclass_priv()
dereferences it. The error message also printed the return value of the
earlier device lookup instead of the error from the probe.

Fixes: afca60620ad7 ("drivers: fastboot: Add support for SPI flash memory")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/fastboot/fb_spi_flash.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/fastboot/fb_spi_flash.c b/drivers/fastboot/fb_spi_flash.c
index 691be7c7ef7..37da1d203fd 100644
--- a/drivers/fastboot/fb_spi_flash.c
+++ b/drivers/fastboot/fb_spi_flash.c
@@ -12,6 +12,7 @@
 #include <spi_flash.h>
 #include <dm.h>
 #include <dm/device-internal.h>
+#include <linux/errno.h>
 
 static struct spi_flash *flash;
 
@@ -69,14 +70,17 @@ static int fastboot_spi_flash_probe(void)
 	if (!ret)
 		device_remove(new, DM_REMOVE_NORMAL);
 
-	spi_flash_probe_bus_cs(bus, cs, &new);
-	flash = dev_get_uclass_priv(new);
-	if (!flash) {
+	ret = spi_flash_probe_bus_cs(bus, cs, &new);
+	if (ret) {
 		printf("Failed to initialize SPI flash at %u:%u (error %d)\n",
 		       bus, cs, ret);
-		return 1;
+		return ret;
 	}
 
+	flash = dev_get_uclass_priv(new);
+	if (!flash)
+		return -ENODEV;
+
 	return 0;
 }
 

-- 
2.53.0

