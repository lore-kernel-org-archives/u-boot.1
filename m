Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A624606A319
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 09:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Y795tgh3;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k5GxrVqH
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 55FA540930;
	Tue, 20 Oct 2026 09:26:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LcjeGiRrkuxO; Tue, 20 Oct 2026 09:26:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7267A408AF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792488381;
	b=iQmYXRVeuvQImNnIQIMJHDTURLWezvyfSZ9Xpho8Z+Us0plQ+WMm30m4Frde0+i9UVVM
	 yvV2VY45/SJVy2jm9T2nnfxwdy+bTKyemROZtAYO3uXYwFcJWtQ0JK1GK5RUHwoLHmHNx
	 k5AkwJPI3TpTZykyXrcLkp9I6lEHrzRNUukIMR3BKcoOwjz+jRG7T6SV5sP5GkjQSDwKU
	 JhCpK0g+iaAmkChjL9Nm4n87tyKVKKGQhADRJwUjoaQoJ6eDCLOA3ReJ6Ti7plGODwpN+
	 08Tp3h0WQEZ9SoeqnwD936p+UScHl2fOBU/pxom24UVXHQUcNKrwSmT/4yw6zPv66Cg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792488381;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xiY12g6Nz7/AwhKIPtp/KFaIqCrHzTif+z6dyoA22yo=;
	b=jl7RLwsAUn+5n/GFXA88Fo677cblffMULSH0JdLNNROMXzBB4PDHV6HHm/Dqq4+RpUXy
	 mqUCJj0u3Lk/OX7PXTit+QQ+ZPU1KsFQZq2q5sjwEdamG9TIHe3d4myFtV8EGm3BuJmfF
	 LNiNRlUf2kKJDn/grdPmLu8+hfjN3aPqFECBEuvfeP77B+Or15siPUKtjn8PAQvOCkB7d
	 orbC4mX/HGYxU8gSjhqBR/OxyI1VOpXjgSTnRTwU76xeZFuuZF1BMRSZE8j648N8Auyzl
	 kXmqaRCNhlrWwjS1gw+dQLppMTMw9+6pMfRl2VWWxWP7CPQ2FPCOhBQOcQYsAq2hkvA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792488381;
	bh=xiY12g6Nz7/AwhKIPtp/KFaIqCrHzTif+z6dyoA22yo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y795tgh3VlPCHOX7x2dKqau5nT9O4UnbeUI32fsmB8IQWRjGSK8uQQWY7raIxuyUZ
	 oMKp7wxNap0GMo2sBBIYehDrGensQ+osvTj37J+MV0HiMZMsKWMpgadmGTNOa7+Cg9
	 yVxaZiyY2Xw8dBdHsunOYVr1t2TkhBM+Vo5XEKpMe8GFCSe+a3Fq7iGq+SJzJzQizY
	 zHXCq5FtlLeBHzDRC4tCc/QvDDgpzQjrRYbYMe9d8AqsZyT/Auet7rVEpaq2EDk1bZ
	 zQ9M9w9/u6DyNZfL5XXtAGEPgtJsAPnLdDnt93rt9GjBDLX3XJq/p6lvAZSPhyFiQ1
	 gqFkrmo2d4Fgg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7267A408AF;
	Tue, 20 Oct 2026 09:26:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 50CFC769
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:26:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4C3F06083C
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:26:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RW3RkgvDSolv for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 09:26:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A42BD60830
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792488377;
 b=HHiJZYN7DIheE8pfjt1c2pbSySDPrToDRu2KdOT6UTfKmczI/zgfz9DLJeW8wVbyplRF
 5ademrYZmtc/U7X3jEHC1JQjOGaEhoCbqzq9Zi6IWRvRAZRYo+sx6h5dDEau2+hXN20M9
 GbIye0XOGOiBpV9JvstK91AiQtitf9Owseb4Hd4mme3eF2B9pVvCxd0kVL+laZzM/moPS
 y9f3fjCPHBM6HxA6/vpjqxN9J+QosJSVmRGSgSkTF1o7zEb09CzGuzutrbFFWBgrlqusr
 1q3+orX+oibpNBbj/UzJQpm5/KiZUOdhafVYJxcwod4Ji9tBv/8n/D6bOIohOPlxbEg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792488377;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=xiY12g6Nz7/AwhKIPtp/KFaIqCrHzTif+z6dyoA22yo=;
 b=XlzfMRdIk6dwBZs/C9mCYi0r3PfnQlFWzuZgnO7ulfD2MD0z7xDpHRpyLMhLwK/Wak3b
 G2jNd+6NzAN3yN3EBle03xNZ3H83wmlZoT0g+iyV1qsFlLByqxXSulGD7RMf6uBux+rWW
 QW6Ezr2v3fgl375ibOOZZeWw3Z0Qa3UatniMx4g+UH3dWx4QEmKhce84DANLjy82Adtvj
 sR/qDHKYmJeJcc4qRZBXpdy+yuoPf+NuUQDW1vEZYyz5/HzMmQjqUJU87h52bUKJk/II/
 eC78CP8Kv+BuVwP/r6QvGaLLQhWumQJZwWufTJN/4T4Gui3ghlEn2ZPsWKd3MH72V8w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=k5GxrVqH; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=k5GxrVqH
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A42BD60830
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:26:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 54DD0431D5;
 Tue, 20 Oct 2026 09:26:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6BFD1F000C4;
 Tue, 20 Oct 2026 09:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792488377;
 bh=xiY12g6Nz7/AwhKIPtp/KFaIqCrHzTif+z6dyoA22yo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=k5GxrVqHXnPVOpmHZ+5pE1NV9H8C8D2FityyHzqzh2TLI1oWee1YafSQs04nkHkYC
 RNhWAxl7eJ3Zjs6VXgj2xRKGlW4lkJkcxMiY6D8QaioGStg1TA76jFPFd82KqycebL
 Kxa1HUj8zPSxIMjiegyGwhQ6TU+38pUBxJWTsY4neH3Co2q13Pv13sFSObKGQBHqzD
 fiVJq7jNKPVra2Gbubk64AduFHFHoDlpOMcyzdWnRcKCtVxa17/kor+pZ8AgL3X0kG
 0lOeNlZU3T3JFs4WU1t6hxUI0NdW3eH3mgPp8V0OzeYRXjlI2ewniIiqWUDmV3CxK1
 31JeNpCUa+zFg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Tue, 20 Oct 2026 11:25:52 +0200
Subject: [PATCH v2 03/10] test/py: android: Drop verbose printing and
 unused return
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-test-avb-fixes-v2-3-997f8f04fd3f@kernel.org>
References: <20261020-test-avb-fixes-v2-0-997f8f04fd3f@kernel.org>
In-Reply-To: <20261020-test-avb-fixes-v2-0-997f8f04fd3f@kernel.org>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Jan Kehren <jan.kehren@emteria.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1315;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=GylgGvK/P2l33YpB/pQxxvB59L8UakLJIFWiG/jKa9o=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq1zOumuSGScWbAxDlb1ak6l3GgFG14R1fib6mQ
 X9/8D54nRKJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCatczrgAKCRAZDR20Zk4Z
 NTwRCADBKVeRrjPgLy4JOXeczBMamjKXJtT4AqYH8pLGrtO053sOWMtf7lby7ZNTh5/e1EjfliP
 zVQmnMli5KHAMExYKsCK9CPQZREQsvLqTDdIeNSyCw4j0qHZ+eOzdQ8uyQ1HrX/GJQ53sEw3tz5
 1d/R0gfoQoYH401A42FVp8+5iscpmIGyONFOCbyaGiZ2q7TDvx5iQyKWCIVbVZPo20QdkyrDvEs
 Qk2v9N0Cjl9SfqV5Sm/jSEBtHZynk1kKEJZmZeJ/3nBKiAG4PaNjkb4hoyz5mXHagAENtc/WZ1O
 taRKNLQiuYOFap8+LHf6zGGgLJM+tiSOobHB8x9blUCfkDu0
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The setup_android_image() is only called once. The callers does not use
the return value.

Drop the unused return. While at it, also remove the verbose printing.

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
Reviewed-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Tested-by: Guillaume La Roque <glaroque@baylibre.com>
Tested-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 test/py/tests/test_android/android_image.py | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/test/py/tests/test_android/android_image.py b/test/py/tests/test_android/android_image.py
index 3bea311586bf..8b536754656e 100644
--- a/test/py/tests/test_android/android_image.py
+++ b/test/py/tests/test_android/android_image.py
@@ -81,8 +81,6 @@ def setup_android_image(ubman):
     with open(fname, 'wb') as outf:
         outf.write(disk_data)
 
-    print(f'wrote to {fname}')
-
     mmc_dev = 8
     fname = os.path.join(ubman.config.source_dir, f'mmc{mmc_dev}.img')
     utils.run_and_log(ubman, f'qemu-img create {fname} 20M')
@@ -129,7 +127,3 @@ def setup_android_image(ubman):
 
     with open(fname, 'wb') as outf:
         outf.write(disk_data)
-
-    print(f'wrote to {fname}')
-
-    return fname

-- 
2.56.0

