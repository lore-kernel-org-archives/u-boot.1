Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8ED606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 05:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=M8+99C9w;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QpwcJ6Zx
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7DB58606D4;
	Wed, 28 Oct 2026 05:51:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id faKW4CSOfYQq; Wed, 28 Oct 2026 05:51:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C9B5F6072A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793166681;
	b=XJjvG8Iasc4csB3HOwqoxOg8SMZdjhZjLyOqIRLXosqJgXM4ceHaZKFKXra0neviAc3/
	 aVd52gZ/6qHdd/g9ebZvKeHR9ll65VPxAYP1ytPKEAUtYphi+QrDCivF53JIwAfAS3+9k
	 eiWgTT7WKpxVKyqNI00G3aCqjDpQBOxrJl+2oxiBlPQIo3pqsTJXbO7jHmOVF3YfNXPlc
	 LEU5SmeExkyZDncMUAFMR1QCyV9VeYiZt/oD2sRL2sYxmeFpeRXMr8MnYjTjGX+J/1bL8
	 7RlIPtARXVLaNH3zEVlzZtEBriU3FqYtMTJluUov3kldHM9W/RhG1daWHINh3wJXacg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793166681;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=rmu1uPUtu+jFr10CQKnQUcCZnEe6noe6ldaMlcnQkiE=;
	b=b1TlfHASKiJB66GQD9fm4DRkRymbL48A8cW2+rSmnsKiuC1iYP0F2PSadYZJDOD5+tm2
	 pRGCwzKULNJ361/IpUdtU9WW35BR3Ysd6XIvxhcW2rhqD/gRRSBzUUZWE2cw5K7q02cop
	 W1plQwPYqlZ1qDMIVWm/WXEPQhRq1NdWAo48lOyuU15bH4WhNotdHNx7zQul/SVv3F8vD
	 gOXI0olF1qfy/mphpRAmYsbVHUrzdf6m6P8mF9CQJ6+xNRRCT2WXCIAj6gtNbatvMSFwd
	 RXXqkzLiPkMeqL5CusNnoxpWSaedubOyfxnJGIgF5VUdfD5UMgFNEjuLbgeLVzmJdgA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793166680;
	bh=rmu1uPUtu+jFr10CQKnQUcCZnEe6noe6ldaMlcnQkiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M8+99C9w4M+f634wb+krRWGp69pOGRFv71Q/IO2UYtRSMa4s/3rDQWbGp4yDuuRJ0
	 CUWKeL6VM4bu8rhIRX00IIcO98AWtfT0YOk+98BtvzW1OP4J/A5YG/eu7D+zcZavx/
	 GKBp9EUMBMb7k/5mk+lx6CiBfqSVWSW8AUAVcllKN3r7t7cPlNUQXyi5iNjyEEvdZ/
	 jtYFw+gCT89mpIn/2B3hvGz3VLYyUYAN9wTWT9T/AnJz2njmCUe4gvSkMvpZjAtmdC
	 6UIJXpeZWtoOKaL/hzXnXow8BliJxuvk9xcCOTy4yyz9WgsfPpy3mwOK2q6mhxLs7M
	 sHdnwoer1fhqw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C9B5F6072A;
	Wed, 28 Oct 2026 05:51:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 851354D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:51:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6B9AE4016B
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:51:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VTX1z8HSldEp for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 05:51:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 974214006F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793166678;
 b=gZ2ABWlvybMwJyoxVSGP9QFBPnnMU/hy75K4cuoi2jUMmgusBpLJL7vBeQixxkkIsaKy
 zkuBAKF8fZOKbJGmxbcmqkmLLJ1wmqCi1F8bUp+K2Tj+VEdf/Bx0Ig1uGsGGtYxpFQPMk
 IRKCMd80H9UhjGkNl/RruB5+K8EYYHUATdwuqo4xaKdAfJca1ZP6CLVAFwqP/KNzoz7yI
 putgiBM5PpCWCa4Gu9C0cB/C5yCRa5RiiovGyS+l5qz+4U/QSiEQb0mtRfDBIQOI1M34B
 N2OCsRvyF/JiGdGC4vS4zjakd9l7vs3vgwVvOwK4udjfcQYYVQy5yvNxyo1jOReI1Pg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793166678;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=rmu1uPUtu+jFr10CQKnQUcCZnEe6noe6ldaMlcnQkiE=;
 b=cFp8onGzc3QMt8K6G+PkodObqh2UmyCu1Q+CzOblrdTgcTYnD+Sq+flJYeLKHax1njcG
 TBGzzM/jJsh1nK1F5Av0yY9KicWMycbghIK/B7o6FdcfoMcAeW5doExLnPisP5nssxCrr
 0judt3IXCYEti2BbFllPZ3kVhYJt+8SSyjw0t4pjCIh3vrvZ4b/OPBVFj/lCQbiZ9MdXu
 gmHgMzJi2VYua7HDyU9iG8qVrJcSK382C1Ol+N9D9+p0b4JHwxTqjlCvYzR1pta8MO3hM
 Bz4zMwCkGt7qaRpK7GapY76uSU/f8Bpb2jOmi/2QVOO/hAZd/IhCJHw+JR+f5ZQdFwA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=QpwcJ6Zx; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=QpwcJ6Zx
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 974214006F
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:51:17 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48dfaa3fa12so1211474f8f.0
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 22:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793166675; x=1793771475;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=rmu1uPUtu+jFr10CQKnQUcCZnEe6noe6ldaMlcnQkiE=;
 b=QpwcJ6Zxk3uu7NeWUU3nPPfyH39yWy+A/HHkLzt9u2DWgX5y8TyRgxmJPbL3LrRGM5
 gDCfKZABLe1RwZmyIFNVw8GKgCPbzEt2vWIca2OHgNw+Mvbmov8UG55REkKRhjxOk+AK
 9CGa+OYQ4AJiQanOWPdEgN6HG4brPYddoMf8xP9rjKNAhQR4r8emJWDVimevrj1kpajX
 jLD/3We16p1TWnw7EA84sMhERtQyJiYqkQH7cUVj7tS1CfcYnGpu+eWMTSFuNEU0uZEo
 XsGMRsqxjq85nwskTj5asMnDBh6BZmwds9uyFhfqic8SeR3vIx8aZ/ZEOch+BWFQ5bBo
 ulnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793166675; x=1793771475;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rmu1uPUtu+jFr10CQKnQUcCZnEe6noe6ldaMlcnQkiE=;
 b=xTtGlChB+7JjwAwMKw63QK4ykO4EN4Xsjd1jfextdbZ6zMKijXSW15MXkb0fNpg2bJ
 lKg4PFfLiyTZ3p9M9GadFZkfTkSzaPzwgpfAfu1RjKd72SoMg8/dO+0dyeS3OyI17XK2
 xj+UDN+kiaibLbzB3Z/lJbZkwCOdcihg2vh4fRb+fea4SadbKOLXBWwY57BPUB0FmWuS
 mBRdHzTzZ3cRd5AB9wJISPL54rOxUyK09muCp1X2IPfC8jMxBkdFiM0b2WDdkEhOG1PA
 W36Lgw04ysr9sFrrhczNeEG7tCZH8UY0mMxwi725UkrtJ4ITz9Zk5Y0sLK3WYtHs3+2N
 Cjfg==
X-Gm-Message-State: AFq9FYJUJl18iAPcSmBRPDtFojliojV9S7gsfeTbEE8eoZsAAG7Ixlom
 14tx5LBjKq2Rnx1FxERP+PWfjqFNAZ++s78wOQKmYwako5JbXurWbHU5
X-Gm-Gg: AYBFou04vTa8XeqWXUZgIM3V2J8yjRuCoWwpKF+ELIl6F9VHcAvG2HCAWtAzxvSAYc+
 ryF8xZ6qr/xL4/+19FV4mpZvZH1ja81VkXUaOI8K8eM6MsPBjmPLz0BuUbF0ZmE7MlY4g0XtQkw
 lEEWMHmYimMRcKfFghtinwHB37MhY5/UX7bpNeS8s4woPxFXMNjpr8jspJ3YM1ITvQdmtvQEzdB
 M6o1dlqalSbQv1VN8FI3KUU3bP79DNEJhI1RzXtk+KJmjclA32dAg1DAC9Vo028eebqFQ3MINq3
 1vNtYLzNyWu37ru2v5Bi96bWzRAjHl7+27j8wbF0YZnE4b3QMAE5fQ2pMnhwzvxasQ4yinoUQ4I
 mdvd5Yf4gntka1RDf8ozMEkTvWsVREeB3i8yOeMKBZwwtt3hzJThhQQlLGO/8OzfOBoJV7dQvej
 kwaNvKoKD7astbBEpaOelhLAmtHoMisi+3z0DrmzV3ZTEraGiLwh9JCFbuG5G5T8nStGbzfCjXs
 6nB3zsFFIDcfy5oIOAmSJ6+1lPoLeIrDiXno+0FoC4Gf7tIohFS1bZFAtMMzVf2aoy3xxealR3n
 X8s0KBZI9C+KinVML5yHmJW1ck5n2UQ=
X-Received: by 2002:a05:6000:46d3:b0:48e:5d06:8b66 with SMTP id
 ffacd0b85a97d-48e6021e903mr482717f8f.19.1793166675384; 
 Tue, 27 Oct 2026 22:51:15 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebd4bc5sm26425708f8f.34.2026.10.27.22.51.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 22:51:13 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v2 03/12] usb: storage: Fix the capacity faked when READ
 CAPACITY fails
Date: Wed, 28 Oct 2026 05:51:11 +0000
Message-ID: <4c2d8a04-3030-4c9f-80c6-0d49a6900ad1@gmail.com>
In-Reply-To: <01ba3f81-06b7-428b-9224-bd887c35e1c3@gmail.com>
References: <01ba3f81-06b7-428b-9224-bd887c35e1c3@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

When READ CAPACITY fails, usb_stor_get_info() makes up a reply of its own
for a 1.44MB floppy, 2880 blocks of 512 bytes. But it sets the values in
host byte order, while the reply is read back as big endian, so on a
little-endian host the device gets 0x400b0001 blocks (about 1G) of 128KiB
rather than 2880 of 512 bytes. It also puts 2880 where READ CAPACITY
returns the last LBA, so even on a big-endian host the device gets 2881
blocks.

Set the reply in big endian like the one it stands in for, with 2879 as
the last LBA, so that such a device has 2880 blocks of 512 bytes on any
host.

Fixes: 149dded2b178 ("* Add support for USB Mass Storage Devices (BBB)   (tested with USB memory sticks only)")
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
Changes in v2:
- New patch, split out of v1 patch 2, with a Fixes: tag (Simon)
- Give 2879 as the last LBA, so that the device has 2880 blocks (Simon)

 common/usb_storage.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/common/usb_storage.c b/common/usb_storage.c
index ac331f1c1b0..f7c96195b59 100644
--- a/common/usb_storage.c
+++ b/common/usb_storage.c
@@ -1496,8 +1496,9 @@ int usb_stor_get_info(struct usb_device *dev, struct us_data *ss,
 	if (usb_read_capacity(pccb, ss) != 0) {
 		printf("READ_CAP ERROR\n");
 		ss->flags &= ~USB_READY;
-		cap[0] = 2880;
-		cap[1] = 0x200;
+		/* a 1.44MB floppy, as READ CAPACITY gives it: last LBA, size */
+		cap[0] = cpu_to_be32(2880 - 1);
+		cap[1] = cpu_to_be32(0x200);
 	}
 	debug("Read Capacity returns: 0x%08x, 0x%08x\n", cap[0], cap[1]);
 #if 0
