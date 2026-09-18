Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F8BC982DC
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 12:14:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2BDFB40BA8;
	Fri, 18 Sep 2026 12:14:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K3jPNu-0eBPB; Fri, 18 Sep 2026 12:14:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6C1FE40BB5
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789733665;
	b=UbGpLUFMzPh3BmScCwmS7RhIB+a0xNsp4pqCJtvKka3bFL3tkkZfUkPt7c+qbS4B+7T0
	 AqdjY5lMyCwg8i0GCSoXJ83rPLVY//zcomIbIE36Ku0GiBMQ3bwLLAkjSdXwMkrCXdX2d
	 4pstluc9Hjxw8XjCvWEyIMrFuDgYzfj6Jnr8rDUh6yOLKskPFQQ7EwJKaTyCl0IntNgX6
	 95MpQLY5q3Qg/ZctfFBzVjbV74hsAM2JldYIjWUksVkc9BQrsUoVGcE32xehq79OIMoJW
	 YNzfmPcR4cN7vpg7AxMyJNlMU3Sv2Z8oWouSnT6Xdc2NWMy4AqTgYox5XsWfJeHUl9A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789733665;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bUfF+SXp8QHGflztGdCFBaru3J+V3o62Gt48IdAfJSg=;
	b=UDA8vZjRpPajxiK//J7RJ0ULXoch7Lq34OPDx7SgfL7O6xKgHVqOnegREV8jVz5X7X1A
	 45zRYMivXo2wl5Xl9qow8czy+lOLhC8wtGhnYx8Ai3wPBdNA/R12JtFEy6tuJSNRZSv1R
	 cW2g6fTBtRARhuKJsAa1R38lni4YozHufP1w1hZlAzo7ZbszPlXfu6Xr3wFGEcZCUrTb7
	 oMUuKZwGsUaYgAMsLOWSlBpox7oE3lI4ExMctcoIk3ZZvrq3DpjfJn0KPpcu6AUIt1oWZ
	 JE9Oq5beBt5UrSfV8BGfq701w4Sbj4boPQQBZ8ztuqiIqPA5gkO2m9msK7rOI8KwwQA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789733665;
	bh=bUfF+SXp8QHGflztGdCFBaru3J+V3o62Gt48IdAfJSg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cpus1sdm4BD+UV17K7/lUXhxiZaQOsR9wv+045EF1MaTnwn8V6cSwJTb7H+1MxFzs
	 nHuejxiltaD4eFc4aAoYz/EG9nfavS6enaUFyjLbsrlBj2YLv48KDvdjNQR74Io/zY
	 IYiO1Sk+qFRmnChQKk9dcUK1IJALG8s8z9secwQjbLw030lbp+Q1U3s5TnVHEgegm3
	 92wpHKDRv5TcaEVvIBABXIYhe0opTTbFLa6AMl/qJAaNnlcXnsZ0Kob46xNq5ZAkcA
	 EXgoTIQV5qdqXjKYUA+Z/xBAcQH4UniTQE2x8iMEZzl9BhNlLvsFaWMX19jmvSLsAl
	 2jR8D/23//icg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6C1FE40BB5;
	Fri, 18 Sep 2026 12:14:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 463B8279
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 12:14:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3478940049
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 12:14:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HUCNR3FrQGs9 for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 12:14:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 4F23640048
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789733662;
 b=JI5gDUd09k9CU2uKX2q6GQI71Gskf3zzz0IpHGU/XX0k44EDLr5wM3N67ml7FXz7X8RF
 VXo3NxUDnNNEM3JiR5cLmcqcNMXVPlsYgKDv0u8sigyEjbP/B8m2vCnyUC2RAstFGKmE0
 E0dxCtcrGLEuCuT2Ow3D9L7HIDuneXbMDDkGuvbbFSk43qzPNER5GqOad4lrOGSJ+3Wns
 FhXQehAmYqfUn6yizzBXE1z7Lg+gbv4Oqa0yACWRoTgYUwb04O6we5ECNwJR14sL/nGVU
 Bm+60WCMnIg3EGLMYKQhKx++HibVzBOTm0jT83KWbMQ9FkXwYlyf9aZ2Ol+04Munu0A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789733662;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=bUfF+SXp8QHGflztGdCFBaru3J+V3o62Gt48IdAfJSg=;
 b=BvcNSeFeURhS05OODMnMeQtgSf/S4CDocy6rD8X2taRCaDMcnfeLYdyIYshy13XhCBJX
 GquVv73RRu1moiHP2SAs7CaMZ32mMmv/AETM8LHHtgfRoA0pjxhnJhkrS3iPavyxrkyLj
 9Yk3CsTxXRnxqSlw41iXYMNfVk3VKA+P472UQY4kq43sP9F2M3viYgTTk/Qs2fw0uPeHA
 dcBQnjhmaAHcYvzQc63rzqCrequELHBd/vfhvkaTNhN1FaGEk0yr9xWXiKFgaZObJzUa6
 Pr+k2k1NQAju5cboTYNucyhahBj+ADbSEBz6q5OkugfGNOUSdMmMHVbAlsmcisvwmbQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=XTx8YS7O; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=XTx8YS7O
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4F23640048
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 12:14:22 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49d1fb0cf5eso5107135e9.3
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 05:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1789733660; x=1790338460;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bUfF+SXp8QHGflztGdCFBaru3J+V3o62Gt48IdAfJSg=;
 b=XTx8YS7OAS1PKPqWebSNTUMJ2uxeEEqva60d0EUpoO4b4o+/NzJyEtTP8+zOPXRp/w
 pnXattKWMagS7VQIGw76tVNYr6uNgcaOXAFZjSCrlyCPpbwkuY7Jlb8jXX6azUmcBxNb
 dLA8IvWN2zNVpcXR1pGp/wpvEra/F22S4Sk7l/tciPnh1SsfRdjno+DHYalGQRTuZ/lH
 V0m8mvQdEz/b8mLf8od7v8DZaWEIsvbIbhbOiN/6QBjzZmocpE0r5qk73qQB4ymRIL8G
 mv2T5hxi4+lBwvsUvQEy35fWAX2PVDp45m9q1XkvyNqcx1Ph9dYZOtqmlNwdLz9Wy/J0
 z2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789733660; x=1790338460;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bUfF+SXp8QHGflztGdCFBaru3J+V3o62Gt48IdAfJSg=;
 b=Y+C2s2KxxfkvY8rIfDkTnPVbO6At1VZ4FSnhyY/O0hUSTHtGEQL9XHcvkL2U8jotce
 lonY/cnpOj/R6UEHbxjQ5TW+/PuryFmUjms/NBmV1WRFWjmkVxkD3uIIiMrmUSidxAOd
 PyTAMG4nRVRpbyPSBDZXcG5NXAApDrryfLBjfXVgrFvx1ssGkIwtLqf13t/MnPaQIdTu
 v3pLhuiwW/OC53MH9tYHc2WPMW7aQa4gf4zGjkQnksSRWyuibBA6jmClyQ1Ask9ORlL1
 53eCGovMX67UgS22QaV/hDv9kDk14FDLNrrbuJygh8KTlLaTUUt6f3VNTNRFJpzaouAt
 qROA==
X-Gm-Message-State: AFuF++mDRkJSHWz9Bdgyumsa4eZIKJjRhFJ+/Bhm3YHLhGmDWc/KT9/W
 yRlYWp5hvGCGtbunpcE1+Z+0B1sJEQu5cvxGa0QxA2HOW5qPbgHC8/kE0P/CTzojI0UqMOGg4y4
 in3z1
X-Gm-Gg: AYBFou3e96zainSiqcinYaICaYsG7vF+x8U85Bu0NL2MQUY8ZablzaFQfaofcEBHVYy
 FdznrbvD0F8o8hB797BVjSr+Yk9YnUK9bMbrNubbVqqRqcpsZ2Sw/mPCBp6/H3xiaV06luBQoR2
 P+lPUd809VX5jqQTby0RhgespkgSba7WHwCLEJ4GTd9LmV3CUK0S3dBlZX+ovg5L6awk9EinKwu
 SmGSGnDyAJg+qXauCBRIcEbi8lY5wUF129TsvGlzIR5azyLItS/Ia3XyBCrfbpp2ygorfAmDajy
 42I4jphSFNzGaQzCMIxxYxw2jFNyr5XT+3VrVVsZgOciuLqYRgeyWMREz1b7D8rj8EjTdClz47p
 EyTkeGNARrgzwi/H6ShXDitEUwOzn+ewEMeAKn8fEJyUpm1JluJHVJyG8KnIZlHzzjCbwADKbX8
 RnZJockhkfBJd6M5VobQ6WOKkF45Jx6TAeBn3AvposZnqDtfh1iBBusR0fMaZnhPWwqJwEYKv/0
 znbW7EQdLTezy/lckO82/lTDLl0gaIt5YuWxH1Znxnx9+hfF0g=
X-Received: by 2002:a05:600c:4e86:b0:49c:d52e:d0ea with SMTP id
 5b1f17b1804b1-49fc566e6efmr29080235e9.4.1789733660286; 
 Fri, 18 Sep 2026 05:14:20 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc59286b6sm42755035e9.4.2026.09.18.05.14.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 05:14:19 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 18 Sep 2026 16:13:55 +0400
Subject: [PATCH v2 6/7] test: py: gpt: Bind the disk image in
 test_gpt_write_part_type()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-gpt-4k-v2-6-daefa4792e9f@flipper.net>
References: <20260918-gpt-4k-v2-0-daefa4792e9f@flipper.net>
In-Reply-To: <20260918-gpt-4k-v2-0-daefa4792e9f@flipper.net>
To: u-boot@lists.u-boot-project.org, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Alexey Charkov <alchark@flipper.net>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Denis Mukhin <dmukhin@ford.com>, Simon Glass <sjg@chromium.org>, 
 Paul Burton <paulburton@kernel.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1545; i=alchark@flipper.net;
 h=from:subject:message-id; bh=vPKOWbxaes67b+WZ0i64n1guXVxa+sY6CD4xEwh40KM=;
 b=kA0DAAoWsqLYjxBZ1KUByyZiAGqtKw6hd/YEbOE6YxUqBIMwgstJzDSXXBDNBjRCPOjOmcBC9
 oiRBAAWCgA5FiEEnfakPZUyDpq6SEj1sqLYjxBZ1KUFAmqtKw4bFIAAAAAABAAObWFudTIsMi41
 KzEuMTIsMywyAAoJELKi2I8QWdSlocQA/jSRMn28G+0wjbFg0XhNg5JRMZ0KC0GHXg2E2jYRdYr
 HAQCXDz5N4fLHCvB41yheDRaB4Q62V7qDWRzxwI+TRZFFCw==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Unlike every other test in this file, test_gpt_write_part_type() never
binds the disk image it operates on. It has worked since it was added
only because some test that ran before it left host 0 bound to the
image this fixture provides.

That breaks as soon as a test which binds something else is added
above it, and it means the test silently depends on collection order
rather than on its own fixture. Bind the image like the other tests do.

Fixes: 7a598e633a53 ("test/py: tests: gpt: add test_gpt_write_part_type")
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 test/py/tests/test_gpt.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/test/py/tests/test_gpt.py b/test/py/tests/test_gpt.py
index e6d8792ac1fc..fb4c8ba67d48 100644
--- a/test/py/tests/test_gpt.py
+++ b/test/py/tests/test_gpt.py
@@ -338,6 +338,7 @@ def test_gpt_write(state_disk_image, ubman):
 def test_gpt_write_part_type(state_disk_image, ubman):
     """Test the gpt command with part type uuid."""
 
+    ubman.run_command('host bind 0 ' + state_disk_image.path)
     output = ubman.run_command('gpt write host 0 "name=part1,type=data,size=1M;name=part2,size=512K,type=system;name=part3,size=65536,type=u-boot-env;name=part4,size=65536,type=375a56f7-d6c9-4e81-b5f0-09d41ca89efe;name=part5,size=-,type=linux"')
     assert 'Writing GPT: success!' in output
     output = ubman.run_command('part list host 0')

-- 
2.55.0

