Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B7F606A32E
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 21:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dIqYEXzX;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AA23iD6t
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7B80F81250;
	Fri,  6 Nov 2026 21:04:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b174b-Kn230H; Fri,  6 Nov 2026 21:04:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BA9DB8116F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793999064;
	b=ou/5CDPKR5r89W6lp7enpt6M6aVqYjUxr4xcBIG/+TjPw3cfa3QZr4j4gUMzc3gfkb1R
	 MhwpBOqLSro3nvVUPJEslwtj++qigatqFYYN5KQnuSjrAsycJvpjpGtRDYLps7dz6fpQK
	 f0LUACcLdaOWTOlKQb8WTb9aD0ugWaxpLI4gxOXplZ7cKSVQAYCcEjvxUSrVNtxBRiEX8
	 AzeX2EL11elDNltgMaQKFnpY5A7sk3aGjmerQpnis9VnJvmnsGOtJGKsn6lr40vwTzCN0
	 D37/AHm3yGmntFeAuVruQ6fLJ4iareXFAv29o2V5rBHAFiRvdJdcleb/fZLOvCR/+wg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793999064;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=k6tFOrfcuwpBEPpz2ldWEYXP/cgabryK/zrxWh/Bk3k=;
	b=AJY4cgma7AIwlsxjPlR/toAyQ8PXXWfQGiQ+MXP310seAdc32sXpxLKIZqPNG0tCBFBI
	 xyjmajTLzB5ay8rmRnRSMWYHnib61PGnheF74WC0XMcnQ1km6HPCTLfCsmD0312BPZ3ws
	 DZRXgIk6ipvjlz68sw5Q7IX4cMGybNO7omRKAUdBVWU6iGI3deBCHSZ0j/Un0PQZHfdkK
	 FfXPd0LyS+aXzIzCIN7zy7pFjBbLiHcgkCrJHXU2OM7k/TEw2Q9v9vw8Cns7zdfWa1D6N
	 P9Filxl68allLvRwnQfNtp+gddxCfcsJ+o4Z7TEI6gKlvDNkjIaKt39GeYYJ0Tw/Rlg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AA23iD6t;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793999064;
	bh=k6tFOrfcuwpBEPpz2ldWEYXP/cgabryK/zrxWh/Bk3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dIqYEXzXDY1OLChCkA/UrZip9S6ZR65dJKFAau+1Ejo1bQc6+10zAAUhPK9btx92P
	 s246EqVH9pIDyV38n4ISolkpu4DQWsT/RqF9hVUDAyQXB5cY8ZTCwyWeYc9K2gR3KO
	 mP9eDDVqRi1LSlqEPx8D9ARIFf0ZjTFDX5aztRfH4PpMzHZvCZiroppeyLcpmapo7F
	 P1IVA6Hk2WRMcu0qPbI1x1O3W77NpHuOcMYnYAXkYvFKRy22iuXOIxbaxGT4ZSE53l
	 /Cs+ahD+rwukBRCOf0xdnio2Q4xW75z2KAPDFnlR8IkX7sHVg6PmvVoqSPZQOm/NCU
	 wFDLtPhP0m4Zg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BA9DB8116F;
	Fri,  6 Nov 2026 21:04:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 97696362
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 19:46:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7D8DA812F1
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 19:46:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dZ3IyAwY5itr for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 19:46:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AF08280CF2
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::f2c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f2c; helo=mail-qv1-xf2c.google.com;
 envelope-from=oss.patchbox@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=AA23iD6t
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AF08280CF2
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 19:46:32 +0000 (UTC)
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-91c1f548f87so14551576d6.2
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 11:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793994391; x=1794599191;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k6tFOrfcuwpBEPpz2ldWEYXP/cgabryK/zrxWh/Bk3k=;
 b=AA23iD6tNEbzlDJEkjbOgNp+VCjQFeN0czqcftplS3yG6B1D1luifwrmPNfAbkEWz3
 Cm69XM5CtId3llo/pJUfYsiIeQu0Akmm5LJEV10/C1fdtpGmVP0gRxC1I63/9loAhg0W
 4uXlVO3gYoXVFcPGq9kicLMFuYh58AktyfVEeRRwPTt2vgPlnUJ8BbD5xAKbx8mJoYFj
 6RVYziZoTT3+QWLeviFgzSSz0rr0PxpMQur+x1fHRNVQ7Ta+auHRomX+aQ0XanlgKisV
 PnJ3WI8PQq1CzwrK/04wU5789KRsHJmcJ29R6SXAa11UgRTLDLQhWoZryROyjaGX29e6
 Di7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793994391; x=1794599191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=k6tFOrfcuwpBEPpz2ldWEYXP/cgabryK/zrxWh/Bk3k=;
 b=sFu2eV3Y/PWTeVog+Jq8f6rZMn0u4bioT95vKr35paSbRRJ8O+9NBN2n1IMvpBvKgA
 raH9WWZr9OgL01RFyhYW/LqqD+m5mO+frVus2FpIZq9qtu+yXZiUDzDVR9HCr0696ZTP
 eKJ6cIpsDTciJgveV2YhWQWxdFAKhgE9d0HcihcxqGvDqfIBLVTJlvow4hOuR2kKZW9W
 834iiwcsoUFsYbMIJfvq0/6koLmlxwx0o58WflJPuxRKBl0Dh+wFPphjdfn+4J6hB1qm
 9lPuPpbyYCxMS2YD5EIBgK1mbDgwQRMtC+suyr6Z3GDxcRUf5mbezwN0OM4AMqPULmgI
 3AmQ==
X-Forwarded-Encrypted: i=1;
 AL+hErF3xToXCWzc2hFTicBpBEPOhU4G5jo7dIb9TZgb4ABvrWuB9WJvg5gLjD9qQK2SsoaabcjM2PM=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8QWo+cFBbuLBftihCNrrvcdeejCCDR7d65Xx8Otv7olEYqL3jX
 835CMvAm/yKOlwo6jY3PoxJ2prVOvJ2VedXaKMLpIKKFIZglAucVId0M
X-Gm-Gg: AYBFou0EyruvfuyZFRKfhQobnlrraqOfvoauFAHv32Bsw4AozS2VWoIsdNU+HVRtcPa
 GbuOUv2fU/tz6dbgUwc6MquAgL9biWBEm/zXPPJRvnuMuL/lY8QTcC75+r3CAR4s5F6MRDmhsYj
 bOxLo9w9cP6CjkqktP1gNvLGSXdx5HJOPFQZ99nASOxSfEMkjvjg6pg83Wj4D3hzUR1dxEmyDA4
 lJFiPPNMqw6HHp4VxWYOmohXTyo77sYgpgYRpTHO+0HruDtnacRJzF0HiRgxDgdEz2+t4j722tb
 qB9GpIbuFQtyA9WMK6w8RUxhBdrWLet3rnMZqE0ZPZ0rKJDSdjwynZwPDShkS3SYBjcZ63eggsT
 WOh8hnabLm5R1DZjfF2I3QcUSGKnpNBBDqlwSlxqp/RcJPIgMVJ/KmGM5fNrNP0LhoywpqEy9/w
 wwc+2zo48BRrx6JHGmT4ErMPp2pbebipSrBKeQQYhwhFUVnoPVEPDsROVkp82TSKXAwgy1h5HW4
 4aMQ3RQqcqjc6f6I28ZZ7SPm+59MsACxXH9zrYjchvGNI+x3aUU4qeB1qAT4zfnLwzF5hUIjBoH
 Q472C1j77qwHNK8NTeVJIgtmHFcYrZgbpyCBmWOrnXs8NIBuKmyG
X-Received: by 2002:a05:6214:3f91:b0:91e:771d:20be with SMTP id
 6a1803df08f44-91ea984a3a6mr51904976d6.32.1793994390748; 
 Fri, 06 Nov 2026 11:46:30 -0800 (PST)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ea867655esm25303246d6.37.2026.11.06.11.46.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 11:46:30 -0800 (PST)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Stephan Gerhold <stephan@gerhold.net>, Linus Walleij <linusw@kernel.org>,
 Greg Malysa <malysagreg@gmail.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>, linux@analog.com,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH 2/6] usb: musb-new: sc5xx: Free the controller if the host
 probe fails
Date: Fri,  6 Nov 2026 14:45:54 -0500
Message-ID: <20261106194621.510146-3-oss.patchbox@gmail.com>
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

In host mode, musb_usb_probe() allocates the struct musb with
musb_init_controller() and returns the error when musb_lowlevel_init()
fails, for example when no device is connected. The struct musb is not
freed on this path, and the driver core then frees the private data that
holds the only pointer to it. Each 'usb reset', or 'usb start' after
'usb stop', probes the controller again and leaks another one.

Free the struct musb when musb_lowlevel_init() fails.

Fixes: 2f6a86a61256 ("usb: musb-new: Add support for Analog Devices SC5xx SoCs")
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
Build-tested only, with sc584-ezkit_defconfig.

musb_usb_remove() does not free the struct musb either; that is not
changed here.

 drivers/usb/musb-new/sc5xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/musb-new/sc5xx.c b/drivers/usb/musb-new/sc5xx.c
index b1765abe827..c14ba821a2e 100644
--- a/drivers/usb/musb-new/sc5xx.c
+++ b/drivers/usb/musb-new/sc5xx.c
@@ -165,6 +165,8 @@ static int musb_usb_probe(struct udevice *dev)
 			return -EIO;
 
 		ret = musb_lowlevel_init(mdata);
+		if (ret)
+			free(mdata->host);
 	} else {
 		sc5xx_musb_plat.mode = MUSB_PERIPHERAL;
 		mdata->host = musb_register(&sc5xx_musb_plat, &pdata->dev, mregs);
-- 
2.43.0

