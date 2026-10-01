Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C92ACA5FCE
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 21:24:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DBBAF810A6;
	Thu,  1 Oct 2026 21:24:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HHW6GBSQKX5y; Thu,  1 Oct 2026 21:24:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1E60181094
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790889885;
	b=RDMNbOudMPG7l7kvsRrKpQJ8FTEzO7CWneXxScv0CUYIArPuGTgg34jGZlAsQRVlaR52
	 pgtzjZbXzdKPQu2A6NhWMUHnmCUenv5ds+6ULtQQr3rNzQg/xYlL0JaPzJDyChtUOg/n2
	 XHHS6zlPg2FdCBXayqeDhOy64gqsf9tc9vwZUpHCDAWcbhnVYJViUjgFiDYGWfeD7B/uB
	 PMvIWSmRX+Xte8HjvOw/k9rAO0NfZ5IlRN5yhfNsGK7dYZPc1aVswjjFRcOJi1tM/UidW
	 kLY/FTOzZVra2r05SlGAiHqdNnXoTLIX4q/tuJlPEFHE853BJMKN1bXz6UQlNeXFRYA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790889885;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=GCWd6IXtnObWe95IxyGZQqtrnKblQDnCjMLlVdUvQ9s=;
	b=e1J9JoZHX4FBp7QpmkEJ5BroZ9X4Kvdqir+86i54KwHMU3t+XVwfke6pPKE7++31WbS1
	 P/YJRV+NmrjcTA4/x1XofIK0zwn8ppn9dV6zOZxoSjCUfWgD8R0lYO2f8iOE3GpNA5SUU
	 Yf1YbDMt8J9syk+Rq8Ng+NNWSESHJJVXjnLnhxTJji1S3cYwXZr6bb2NVz599o9DyecSc
	 gSHn896S37niML5MpKaNX2Im0K8XinxubcDS+TCD4oeNVQEm+t+1umAk7vh6UoZYilxRe
	 bmJvkzgVXym+cSIsVPJPVEcu7CpVCK/ZLsYkFWs+evmj+oFZ578vvPnK0rG7Meyu6fg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XoxSNj9y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790889885;
	bh=GCWd6IXtnObWe95IxyGZQqtrnKblQDnCjMLlVdUvQ9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LURtwtZ66JvQ/U4Sp8uPlYu74hgIC6g4HgWiW2TgDqiuBk6vgSgAnv4LMXsY0YMUT
	 Q/6YX6/MJ2Rm6438Yku5mlZjWASfnCPk0vduW8wbIawkOi0R1YpXR3aq45nwZjYn9t
	 4YZTuF64foveltcuPet9UkJ3K6cRrKoWSqE8Y0fkB76j6s7R9J9LUy8zryAMnF4i5P
	 kywYWxUWcaY9bGn4reVTT/DvqXrQDlqvMzqG+en65+pNH2eWLMxAcC2hOr1oB9W/kj
	 LNz0+ay8XYzibhCvR2SXCEN6p8f31s/rhugbq1OVe9s9BopIMuzn2yu3Bwgm7pQCXU
	 lpLi1soEAz5Yw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1E60181094;
	Thu,  1 Oct 2026 21:24:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C163122B
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:45:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B38EB811D4
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:45:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IY_3HC3SujoG for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 20:45:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A481F810B8
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790887508;
 b=F7o1oaNcIDF2y+ixK8jJ9Pt58cDmkD8bxzQiASLEmWcmteuHZOpYX7x5wj+LNHTgz9KB
 f/uNkbJswnVfFuCklJS5yHJ5CAPDBN4DPOsTiosWWEnGEpfJ/RO4W8B4LvXTJnCR3nRK6
 Z3u1/VuKJ7uDpiIxFVQ8CoVDOWqS+/yFVi9ZoB/eAhX1QvqlvqycF2+uGdt6OC7n4E0gy
 Mky5P8vCXJBaP7r+KzoEo5J9Mspj4nryfG6GxPMBRBdlUiaPnQYAJwhULgrE0tFUNa29o
 3zhQfR/ZglZusgZlYujxXL51mBSARnbK2X1HViPy09r7cX3jZ2NZSbSqYE4dU6J7IqA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790887508;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=GCWd6IXtnObWe95IxyGZQqtrnKblQDnCjMLlVdUvQ9s=;
 b=R6mYSGbuOEzu2GNiJxl9k+7oYR9J0nGzXKWmsazWu4F0t+WoCIKwB5fo0TM6RuHXiKiQ
 X9ggW1hiPLUxmCyT1xZUHAk2nefYYkLVX7PbYNJh9fEsjHdYyaZzNOQk7BM/jTh0sHICj
 RNoK2AgWqqnJZ+7e4jOO14CI+qml8eswaX4Pr+wnf/em3z2Q/4iJKgwG790TTf3+/44hP
 V3aTg2yjGk4uXgQXkK6ViIjOAcIpGHarYvYiQzO8RYxzKsV/ZlWOLlY7z3VsDYNez6Cod
 YKCI+w/rA/3Og48ZeH+Hi1mweLCkirpislPdTwPOvYMOKEAoXPJmhtiQHiPrXx3zRWA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=XoxSNj9y; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com;
 envelope-from=lqing2013@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=XoxSNj9y
Received: from mail-pj2-x11.google.com (mail-pj2-x11.google.com
 [IPv6:2607:f8b0:4864:39::11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A481F810B8
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:45:08 +0000 (UTC)
Received: by mail-pj2-x11.google.com with SMTP id
 d9443c01a7336-2d747eefae4so17969095ad.0
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 13:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790887507; x=1791492307;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GCWd6IXtnObWe95IxyGZQqtrnKblQDnCjMLlVdUvQ9s=;
 b=XoxSNj9y5nm3WoffKmOQMFESaXfPNlli2jdblJ7pnmewCI44f9VSvK5NiHhyRhZIOq
 gegLNB7N9ok+/XIjDqRcDpqvmSbrdjS04OYh9U8YcYGnmGRu2/IQeWp6OVP1V3IeiplB
 HikSrypjeKyd2L191JDFC5udCKN8JZNAY3dEXVQXcefacBTKBvSVYMk5fcnF0vMbVPGe
 GgqpZIE7pmnCvYmvsn9bGdArsCqdjlOEzkACjMEujZi5U2HhwP28xwkswbFz8WlsDzJZ
 CuZgbyjzs2WXcz2j3LGQjuX3NiUFbqrBVzZnyoWgYBUdFt1epdwDR2BYlAm0W0Bnv+7U
 Izlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790887507; x=1791492307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GCWd6IXtnObWe95IxyGZQqtrnKblQDnCjMLlVdUvQ9s=;
 b=j8nicIuVMWBwsN6JyQmqgfkQJM3y3xa43XXfHWKq/G7k4yCn8jnXc2Lwy3LelSCabH
 PHAgT0Mw8vgjEfR273mJx/RmfwtqagvXK7fWpFDGVpPJzi99uV8fUEzrEuLYz7e4GCPO
 yp1tFRZE8irG8AVB8nb0o40PD8OA5enpas7dtCwkPLSu3qPyWa3d6qouXU7lHpWcHY1z
 2c8KAQdZrxbGF3f56iTDFOMvN/xQCZdwxm1aBn5gXUD/Yktibp2XlneGF+j9bS8VaSin
 nTdxBxg1r1A114dLl61CkHiM8fG5qoLLCObkq8huKcgLS/diC0sB2VGEYWuVSRLr/6pp
 d5Dg==
X-Gm-Message-State: AFq9FYIVRK6gXrgWHwojAcbg2RRvCH30LVFr37bdmNMpt1aSGPJHUnnr
 6xAvwjopsjTQxpB5Y76Dr+MflwVwXB8JKVqYaJBARqGsw4i3pgZP1feUp15AY0jAh7zTmR/K
X-Gm-Gg: AYBFou1JMy6PKJOuJeAMdMRT71kKlgSv5mzWgQmITSjZwOiCPLdnVzg3yfsdw3hTNUB
 aUSbehDmfIwGEYeWMiSGTryvvLDWsZJlatFHC+Z+kgG5TVQ0F5UzxbopxcrdRmahGEg9h1jzSRv
 4k0y2rHQXwauCORM5v5P51tnFZ2UUeTDfU6sdPvqjhpYtI6qeSq7EgS6R66ZltqaBGdJkyOsMT3
 9qDn8hvaakjmxZdKyMqIUcuRs7I7PC6P0WU53K/htb3FbajAZSWTvFuZTohkimbYUxBxpqJtRJY
 sjFn7jEEH6Y2SCwJGQHlGJzD9/bSMRJYqC1wK1LWkk9NNV29eicVMvxHPPpFJrNc9JFswUOlMU3
 aBpm3pDBED1gOWE6v4ev3rwGd9o4Wx3oDqchHxroK78VoM+HtkdToFE24y/w/uO0PM2W+JyO8/V
 garbclelYIKzcJl9za6vLyF2C8y8bHFfFztEyVG0Cn/mDgzm2fYCBKwSxm2addSLYwYFngFEZ9M
 AxnEFYj2DDTJd0DFJrrLEYLflm+gR70xpBr3g==
X-Received: by 2002:a17:90b:3ec7:b0:3a0:c20b:2ff1 with SMTP id
 98e67ed59e1d1-3a6cec1edf5mr401309a91.28.1790887506950; 
 Thu, 01 Oct 2026 13:45:06 -0700 (PDT)
Received: from localhost.localdomain
 ([2409:8a30:2e86:1710:20ae:2ce4:794c:d830])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a6cd634734sm883877a91.17.2026.10.01.13.45.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 Oct 2026 13:45:06 -0700 (PDT)
From: Qing Li <lqing2013@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Qing Li <lqing2013@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/9] usb: gadget: f_acm: zero-initialize stdio_dev
Date: Fri,  2 Oct 2026 04:44:45 +0800
Message-ID: <07344b8be2c8caf85ed0b1beefcde311495a2ed6.1790887323.git.lqing2013@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1790887323.git.lqing2013@gmail.com>
References: <cover.1790887323.git.lqing2013@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 01 Oct 2026 21:24:42 +0000
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

drv_usbacm_init() fills a local struct stdio_dev and registers it
without clearing the fields it does not set. With
CONFIG_CONSOLE_FLUSH_SUPPORT=y, console_flush() checks sdev->flush for
non-NULL and then calls it; on Xiaomi crux the uninitialized field held
a leftover pointer, so the first 'go <addr>' command jumped into the
splash image and crashed in console_flush().

Zero-initialize the structure so unused callbacks stay NULL.

Signed-off-by: Qing Li <lqing2013@gmail.com>
---
 drivers/usb/gadget/f_acm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/f_acm.c b/drivers/usb/gadget/f_acm.c
index cf16ca83c12..f756aa087ae 100644
--- a/drivers/usb/gadget/f_acm.c
+++ b/drivers/usb/gadget/f_acm.c
@@ -675,7 +675,7 @@ static int acm_stdio_stop(struct stdio_dev *dev)
 
 int drv_usbacm_init(void)
 {
-	struct stdio_dev stdio;
+	struct stdio_dev stdio = {0};
 
 	strcpy(stdio.name, "usbacm");
 	stdio.flags = DEV_FLAGS_INPUT | DEV_FLAGS_OUTPUT;
-- 
2.50.1 (Apple Git-155)

