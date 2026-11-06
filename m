Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D353B606D815
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 21:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QeLR7f4F;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZcOj4AIz
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AFFA281202;
	Fri,  6 Nov 2026 21:04:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mtIR4bj5B1Pk; Fri,  6 Nov 2026 21:04:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 85C7D81134
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793999070;
	b=a+BN3qOaK/MwxArdGqPrRghEgbq1rXpEgvmZ9xKoTH+VD5SVc6z29lYBWFnNkW1L5Itz
	 ON68aSRoKKwdqRQF2QViFUwqdNKEsUvS3a48kxBxdCU8+lm5L3T94qpSbEjBkSDoC0OhL
	 8UeFCNY2pu1z+BmkjbcF+E0vGF8bPUG+WV7kWNKYXe4DuXBbvWYMjXyoZYobs7IchbRkM
	 zdq86JqWUUiA/K0I4pPhVBYIYI0IdK7ah9ScBoE8Oy3Q8xFulOwhw7VfYPKABJ21qUGce
	 hGWvYlvRaEtHQCLrARbZpZJOae3GWJDLBHbcXJDPHU+XTt3tghfobMg0gjHh3CWrLbQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793999070;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bO+q7QZ//i/MtcC5RVdhpw/+1IcgC06qrtgPvdE17tg=;
	b=XlCMr5L7EmKzPUzEx1970RshnM/c+BZwtClotMnb3QYD/Y1hRb3Joih6wqHaLfcDUeFQ
	 QaKPzGrLIAYJJ5nZP+B07I/K/0itwnvI6nBYqDwMi254IVTz6dgXU866sPHr0ydmrBQUU
	 gkdJFxUGPoVM4RKKSKWSJJy7OFbw/3v93ceTgNUMydrgrPsOJ4InGPv6tDnUxF1k/wvdL
	 ENtZuDnrF+VCFxs2iPKoCsqMdkEKvhilIrYl5+NUPERvbE1gfi5xVyknhBiyRYM+ZKAXt
	 lg/gUlsN4diVS0+FiqUskLDteH+3xvsICTg55EHFs/Uh91WmnyuGbYAA71KaHjLP+RA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793999070;
	bh=bO+q7QZ//i/MtcC5RVdhpw/+1IcgC06qrtgPvdE17tg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QeLR7f4FsDcb/INRmfrGZhoqYr6SKesvFf1iac1WjD6dq/j51h6Z6/UGdCZ/o+huW
	 NGnFx0x0qBNoNDee4xAAiNocJxpbgesP8SxWkaXRMHpmHAaTKJ5gCyeudIgJzVm5CL
	 6TXND6MSpRf+SUqqIzj54w/WQ9Z9PJuAUF5+BWAHS+bWy1xp3Ypr8ctN7nUG5SuIhX
	 wi/Jj3ZTDDQ3zOpm+I0517tY0dxKGzCHLI4TOAhDOxoc0RromzfoWqQguDFkoZDabQ
	 uxpDxZyVQxlQaywdb32sr8LSSlrLK09H8vprsn5/3wI4qR4ch6V3NcGHPGAjhsN5i7
	 u6Y6JoEC6s4nA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 85C7D81134;
	Fri,  6 Nov 2026 21:04:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C8A162E5
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 19:46:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AF80E606EB
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 19:46:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VQo5lywtNXi3 for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 19:46:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0A05060890
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::82f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::82f; helo=mail-qt1-x82f.google.com;
 envelope-from=oss.patchbox@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=ZcOj4AIz
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0A05060890
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 19:46:36 +0000 (UTC)
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-5364648ae07so9147991cf.1
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 11:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793994395; x=1794599195;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bO+q7QZ//i/MtcC5RVdhpw/+1IcgC06qrtgPvdE17tg=;
 b=ZcOj4AIzdtTYr+eXhxcm12vgpBGKtMsTdNGHrcvijkseqoDSdWOZrPzDG6PrIPgq7+
 wY1OJtOYWdfwvIreX0EPcdY/Xr32BsaLsk9AfjdgpZvjQci7R6jS6oowJ5JMHOdaZzLi
 F2gSJ1j9Qf4odkI/NriSNEm5nCecs652CFhevVYcax45zbxCEQvtvXGRs2fW5au8QxSw
 1EepT5N6X9dBcbDChaTSOmQ6r5NJexJUdYEMx1FBSRAu5X275MVv56OsxTPOEugPGihK
 jiJDuGIdxqpOWTNdwhjS2jDs0Z7lyaJyPLfn/DZqWJImN6dP/7Aoz2rhwsTMMI0rbENO
 JT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793994395; x=1794599195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bO+q7QZ//i/MtcC5RVdhpw/+1IcgC06qrtgPvdE17tg=;
 b=IM7DEuIuUpnQ3lhl+XWAK9RSXVMg68g7t15NGyuuknnF+Ql6XXMSyeQHNURwiYCZDx
 k70MifjTCvb6FDMyZDa1QD+ocRjx3iR0zpl1Y1rWeSEusV0wxgdv5HGBkidPkdyM7+kG
 3lYrQGcCVz/Jhwf1ZTQqxFhfwP/hRKIM7YTEnQFBeORto0oJqxlVFzps+YcKfkjuS3tn
 9e9NNXVGLit9QiQXD+ABTlqSQEgsf5bYY5JtPElB14fuKGFLZGiYv1KPCzApPLpAMnPU
 j+Wx9wTIZOoipW6ua2YGLKZX1JPEYa8td1iP1uVG1sTpclwb93g6DBxwaugESrjzIXuD
 DkhQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBywJuenDkqOsZKfFXzE7ZMd8nPmc8lHdI9J5z5vZ4f2RzUdrXYTQ3UqtzMUCsbn4G565lNtkbM=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9F6h8B/F/Sswds//WIFuJy17YVNSolcJEqVs32zXWCV27Kt3YD
 Ca7zr1yniB4FQysGqO7i2ro+zadI/9a7nrIxrEq+kgo9KY2ghFpLZFLnh7+8Hw==
X-Gm-Gg: AYBFou1elTN3IdQghv/nNaVNxBbrqiu5dF/5eJteUjb60/qa8d47zw12ylSQT2IlThZ
 YTFD7nSKXib+5KoTvTIx8DyAug/q+zQqSx00oeCxOs1XvoR0YwIirn/AGxAY8HXChI6gNrK8/Ud
 RZEoExDmw6mNcMW2kWRHM8ae0JHDzFSC1QyZJ2UBWLcE95V9CTaVdpi4nfljb9geJ2rAb/8Z0nm
 2fEs08LQTXNVGioTfOvcSZES6vY1x8tkR7Qa+Jb+nZaIk9A5kUHzrTjqQnX+jBBI5gyRucWv+nO
 8DBfkCyt5MwTmSHKLexVSMiwtPQoVC3nBYcVyYXXKPGy1fl0dHU4fMwXG65DSSqJQsC/iJo8gg1
 Y8zMB5Q/X5BJxbbbGIKpb69zZI1XY2v34Kpzd5dtOhZJAYnS281MUW9Me7M5npP0GDWrbOTrp5z
 aNjFVovoGwfFufXV+IvcvMI/03X0OC79jZuLMSOqK9AtBvf2IF76qUUie2efGU6N8Zhjx+BbK6R
 lVBNKxzqW6EnQpALg8Tc0GCy0iPOMQmFwOjbBTT5PW2Gw0xh5inT0j7+8xdAfJGQFZ1Egcao42j
 UOoWcVBRspPjpw9ubwKyeIr5Bq3G8TxWtq6SzS6Ltu1mU2v0QqEi
X-Received: by 2002:a05:620a:4611:b0:93f:53d1:54c7 with SMTP id
 af79cd13be357-945f362b55amr560674385a.70.1793994395152; 
 Fri, 06 Nov 2026 11:46:35 -0800 (PST)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ea867655esm25303246d6.37.2026.11.06.11.46.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 11:46:34 -0800 (PST)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Stephan Gerhold <stephan@gerhold.net>, Linus Walleij <linusw@kernel.org>,
 Greg Malysa <malysagreg@gmail.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>, linux@analog.com,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH 5/6] usb: musb-new: ti-musb: Free the controller if the host
 probe fails
Date: Fri,  6 Nov 2026 14:45:57 -0500
Message-ID: <20261106194621.510146-6-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106194621.510146-1-oss.patchbox@gmail.com>
References: <20261106194621.510146-1-oss.patchbox@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 06 Nov 2026 21:04:15 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ti_musb_host_probe() allocates the struct musb with
musb_init_controller() and returns the error when musb_lowlevel_init()
fails, for example when no device is connected. The struct musb is not
freed on this path, and the driver core then frees the private data that
holds the only pointer to it. Each 'usb reset', or 'usb start' after
'usb stop', probes the controller again and leaks another one.

Free the struct musb when musb_lowlevel_init() fails.

Fixes: ae6acf9fe2c8 ("drivers: usb: musb: add ti musb host driver with driver model support")
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
Build-tested only, with pcm051_rev3_defconfig.

ti_musb_host_remove() does not free the struct musb either, and the
PHY stays powered on after the failure; neither is changed here.

 drivers/usb/musb-new/ti-musb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/musb-new/ti-musb.c b/drivers/usb/musb-new/ti-musb.c
index cc6c3b94a65..5a93708bc75 100644
--- a/drivers/usb/musb-new/ti-musb.c
+++ b/drivers/usb/musb-new/ti-musb.c
@@ -168,6 +168,8 @@ static int ti_musb_host_probe(struct udevice *dev)
 
 	ti_musb_set_phy_power(dev, 1);
 	ret = musb_lowlevel_init(host);
+	if (ret)
+		free(host->host);
 
 	return ret;
 }
-- 
2.43.0

