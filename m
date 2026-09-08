Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B800C79F9E
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 15:03:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A9292405E7;
	Tue,  8 Sep 2026 15:03:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YhTJ_zYrTaXZ; Tue,  8 Sep 2026 15:03:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B7DBE405B1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788879803;
	b=cYrs2DVyZKgXybzmYemKgBY5T3mzyxpJl4/CJBzNTiLpBmZz+VMHWhvSSjJ7rdOe0xRU
	 Hf6diN+LkffD5ix5pJjxgNxcHERvlkeOhZI+JMuVetNWA5H7Tv7qFWqVKb+V5bAoT3glo
	 SAiOnMJBNUajJ4uwMjAG781/iGGNhwua+tw2k+6FP3zlyl14Pqaq24UU/ylYOnnLQJXAu
	 i1Xy3byonq2fOS2hLHx8yjd8JyA6jh+rA1/j4WKHqIB6Mp9AzXhdAgkeMLgU/tj8Vuc+x
	 PRvITcPTjwvJ6q9/2+dZ2APe12tdwNbkpLtfKh2Oy+jvHXarOHpRJJyGuuGVR+rvm8A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788879803;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Baivz+NtZupCldoNjOt2NPBIqTG626iOjJO2D3URKhQ=;
	b=Q6vXiag39+8RddZ+Edfg+2eMR8k3Zw2Zjep52vDfqzVtanPL4BJsCmJfh6ynW7j/iVEP
	 zvas4QqG3R3Kp8vubG8UXK7I5yCHldAfzUoq+xMONReOB0Yh3quU2C8J/nAdz05W0gDMb
	 VvyxBQSGg69JkzLasJVW1CmKz1NE2QBA2q+bdtaqTsGHxsNjQsz9tJ1TPQpcUDXHB+J8c
	 +jMJRGogUkMlCBK0s0bHZ7MeI71Cu7Qwj4im5s+01MDRg1J5J9U0VeRJW0vtmH8gfgcG7
	 59aZasY8/KkOq4zgfFgN45+Qpyy9Me6VawP/JqAdpiNjmyHAgRM/Klq49WQzRzhgBig==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sbemII2c;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788879803;
	bh=Baivz+NtZupCldoNjOt2NPBIqTG626iOjJO2D3URKhQ=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rEqJZULLwvKODGXFgvAJz/R8XRx+z3NDS23YlJIiAiqrbFJF3IknDWzadvooyejyB
	 +jYwRHoYK5DBcvs4IdXE2FkT4btvF3nLu6WLtH41CHZT+3zc2W66PnbPf32CUQhM1w
	 G3uUkMADX9xYrXVII03hVOhPSRdq4rIoaf8RrVKkEUNnB+UVLqK5dY/q+dZQLlLX6R
	 3ad9jKj669V5i66pPP3v8jX7oHi6cj9KzriGSCs3l1Iw8rHHWhuTu2eI6wu26+B5vl
	 LKAO0sogp9gyHHpQ0Z7BtvatwlnZbH7jalZpmwoVIzvFsSMAR2eFprCSyMHp1Sp6tz
	 FRxvEBjhg+0PQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B7DBE405B1;
	Tue,  8 Sep 2026 15:03:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4FA18372
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 15:03:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 35536405B1
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 15:03:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7wgkXLTofvJU for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 15:03:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E3B14405B0
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788879801;
 b=J93fSR7LW/VVxsk4hFP86a8R7wwNQgptEII1DGGpjzLddz/92G0zosXRJqeXkA/T3/lX
 nqnkgQHCACteB/7cjlEANEk4ADZZ+/HHug4oiZw5LET5zJAGyl+TogXun4uXwY/hS0nN9
 0suephVShcpB8HPxV/z9CZ6MpeT+UhWraBcs+FnS5nfiktW2ME2zZ66Dd1M6SdzRPX4xR
 rFBdwAJXQyZAOBZpWIgxmW2bVJ4MiqkOhQ8yQVzFtydEJSKHNiyHfb354PARWg6vUnFKP
 /2WSmImEji5YcrOKjUFarhRLNhCtIQycuMR3kPo4ycbqXDgFKDBoG21FO3jdI6Ht6ag==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788879801;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=Baivz+NtZupCldoNjOt2NPBIqTG626iOjJO2D3URKhQ=;
 b=kkAD+V3RDpERYzHn6rpQjx+g1zLHk0hz30hMAHVp16YfL+RlCe+PaCUz0JeqpzvBbFSH
 7NDEW90wF0pyN30YVB2o2aYvD9iuHSokyU+nDQNWC2j6bfx36/10JDPLkmgcfp4ZBzyd2
 QQ/qH+UPplZP+LHAeqbMXeGZOMnhlrolBL77va7INqokRXcBPqpOBMdPHnQmC94Av29vR
 hgagBfOy4DP1R5hGEqMvo314nT3W9pS48BKOoUjynXlLSv3XUpxOEW5I+ffsegYQhqDDj
 BP6CYnxlDRSucc0ikFZZpkqSEKHaIk0ICY5KT0dyGJjrLC6wqxCLmbeGyC2PXNVoXgw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=sbemII2c; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2e; helo=mail-oo1-xc2e.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=sbemII2c
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E3B14405B0
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 15:03:20 +0000 (UTC)
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-6b1b9c3af5cso3878567eaf.2
 for <u-boot@lists.u-boot-project.org>; Tue, 08 Sep 2026 08:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788879799; x=1789484599;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Baivz+NtZupCldoNjOt2NPBIqTG626iOjJO2D3URKhQ=;
 b=sbemII2c1fT1SM45uPoMyTdfDZlz42ngR5PtWVKsl41AmLjsWKTrNBaTr7wM+ME4wt
 45NMc2UYobIhrsV3Hpupb5kaK/Kdajm8FQg2jXLp87TL7ll5+I7DbE8DV0pt1D4wJMKH
 YFu/Fd8lWeRU82CmfWIR2gXKwi4ETPYarrULUfzncpV2BOkWKtEY/DRkE3Ae8tw6g0Ev
 itJi1eCEdj0GRlHb1IZFZD55EypBk3tQd1ZyEjKms53/LReC7EMV0OLfaFNeFwMLzGU3
 azOJ7N5DHJu2XtAyam4P6CPrIRO4QnK+iewNZqswAgTdsddkcMZuuYi6j7aUTqf+1/zt
 L1Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788879799; x=1789484599;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Baivz+NtZupCldoNjOt2NPBIqTG626iOjJO2D3URKhQ=;
 b=sLAeOEPYOZsrFwDwyJ+aL79VE5KTFxivKfhS8hxtIIvduaGnwg0+i5z/IxRQff33Kv
 Gu+1EfNy0xb8zo0N74pLV8lOAzDxk+lYp1dWWe0iSgneGawm6NDDwEvGwdnLCB47uS7b
 f+A1cR4k9eLwaRbHgofjQq+eY9t1lbU/fZJzFXYQ14flzn/2/HIppJTn40ht0zKeCB+n
 v8gcxQreKw+5jr+ex1KDhg7I5LSXHwhhA9/zvaxJmCasXww+6yuL4THXc6n8ic3Onbeg
 sYymwVJjC81dRS76aS6q3cvVMj9urqdGO2LAjBx2sqIwuFLVl2CaBK6b2IVjeHEmk39y
 qqJQ==
X-Gm-Message-State: AFuF++lmKdkPTf9qAfugXLDjSCwQYAzdlBesQu8lyx94iwXzj+n7QCKO
 jcFZk5qYNyqhI9YtD14ZetOizrtEVeHLARIQXVdkCXwkmQPGPjiGCztpMDwp/4D7qMo=
X-Gm-Gg: AYBFou3BBxOL/zXEu0YF65HC8Jf7uN+NgMsfsiN//7qsh2ibMBbDJcECPsHxZmD8xOS
 yQhzfE8oeWzActDuRe1A8H3gujN51mjN1AIv0rO6kOW5cccW8YfnhyRcp9kipj3evw70Ic/Ayaa
 QHN4vn5JKSWkHNIXZbJCJeIPqiaW8oVgFbm6MCyoa/fWI+JiRIHb0QjoZaJBAbciKxKcTKFTsKX
 lg3ShNEtzsxe8TC7fE4eNzaKzMLyGDV1QXGg0OfHfAeFJSQtQtd67P5hDa2gBWQqwGb9pgIKEvz
 InO3DKrwXOrAaQ6tYiWxCm++ieIju00bCBXEB6EN62hoaCxEXOfn9n6h7wy8hWB9gqSA4hbdz/q
 1WynQIDPAbUOVNLbSF9+YalDO4WDtL4hBMRNcFiJhzgl/v3kfGzqI/m9/x0OxhOdNwC1Z4b5s57
 ZB2No5K821UnpIp50QX0LSJop65eOfADsGJ9G2iT86scPNthhQPR1TY2QYKmWVV1cqGO5xJikCA
 8PUZ1dmJn+/KT4Xjb7i/+wxi8IyI2qmgXodxempTevo2ua2XRU3B71K
X-Received: by 2002:a05:6820:f004:b0:6b0:5233:f69a with SMTP id
 006d021491bc7-6b6fdbca26emr17519612eaf.30.1788879799129; 
 Tue, 08 Sep 2026 08:03:19 -0700 (PDT)
Received: from maple.netwinder.org ([66.129.139.8])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5308a706823sm41976231cf.24.2026.09.08.08.03.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 08:03:17 -0700 (PDT)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Tue, 08 Sep 2026 11:03:03 -0400
Subject: [PATCH v2] dfu: mtd: probe before get_mtd_device_nm()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-rzn1-2026-10-mtd-v2-1-6a99d054d61a@linaro.org>
X-B4-Tracking: v=1; b=H4sIAKYjoGoC/32NQQ6CMBBFr0K6dsxME4q68h6GBZQBxmhr2kpUw
 t2luHf5kvffn1XkIBzVqZhV4EmieLeC3hXKjo0bGKRbWWnUBo9IED6OIBMQwj11cCgNmrJvLaJ
 V6+wRuJfXlrzUP47P9so25U42RonJh/f2OVH2/uQnAoKSDGuqKttpPN/ENcHvfRhUvSzLF83RG
 rTDAAAA
X-Change-ID: 20260901-rzn1-2026-10-mtd-856065fbc00c
To: u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Ralph Siemsen <ralph.siemsen@linaro.org>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openssh-sha256; t=1788879797; l=1697;
 i=ralph.siemsen@linaro.org; h=from:subject:message-id;
 bh=M9CTdtTn4DuwJ9idu1S7I6/PTz3Ch6y+aMVEuV2k3aE=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgG/ALfT0jfT5dAzjFlh+rTh9j4pAiw
 vPQ/tR3mihuAFYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QDJ/G2z6IxtyeNpybIn3XG+77h4Wl4g2jC4KjTnUrv78B/0vxEZBfHFCAlbFm43P+AE61L2b4y5
 K1MMr0Xrbdw4=
X-Developer-Key: i=ralph.siemsen@linaro.org; a=openssh;
 fpr=SHA256:12SQdavZEBUxPbBBtqQJgZ9F8vSvwTB6kFlSNgb4IcM
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

Parsing of dfu_alt_info depends on matching MTD device names, so it is
necessary for all MTD devices to be probed first.

This fixes a failure of the "dfu usb" command that occurs when:
- dfu_alt_info contains SF devices listed as via MTD
- there is no persistent environment stored in SF
- "sf probe" has not been executed prior to "dfu usb"

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
Changes in v2:
- Add R-b tag
- Rebase to 2026.19-rc4
- Link to v1: https://patch.msgid.link/20260901-rzn1-2026-10-mtd-v1-1-516e2177cd20@linaro.org
---
 drivers/dfu/dfu_mtd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dfu/dfu_mtd.c b/drivers/dfu/dfu_mtd.c
index c36ac09189f..da19bc21492 100644
--- a/drivers/dfu/dfu_mtd.c
+++ b/drivers/dfu/dfu_mtd.c
@@ -289,6 +289,9 @@ int dfu_fill_entity_mtd(struct dfu_entity *dfu, char *devstr, char **argv, int a
 	struct mtd_info *mtd;
 	int part;
 
+	/* register partitions with MTDIDS/MTDPARTS or OF fallback */
+	mtd_probe_devices();
+
 	mtd = get_mtd_device_nm(devstr);
 	if (IS_ERR_OR_NULL(mtd))
 		return -ENODEV;
@@ -324,9 +327,6 @@ int dfu_fill_entity_mtd(struct dfu_entity *dfu, char *devstr, char **argv, int a
 		if (*s)
 			return -EINVAL;
 
-		/* register partitions with MTDIDS/MTDPARTS or OF fallback */
-		mtd_probe_devices();
-
 		partnum = 0;
 		list_for_each_entry(partition, &mtd->partitions, node) {
 			partnum++;

---
base-commit: b4ac71db13a33c4e6532c60a781ddf34b7f4375a
change-id: 20260901-rzn1-2026-10-mtd-856065fbc00c

Best regards,
--  
Ralph Siemsen <ralph.siemsen@linaro.org>

