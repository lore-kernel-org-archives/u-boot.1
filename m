Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4864C606A31F
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 20:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Rw8dNZ7y;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OgRH9YOR
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 158FF60663;
	Mon, 23 Nov 2026 20:08:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bc4v_dW4adxu; Mon, 23 Nov 2026 20:08:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3ADBE60678
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795464493;
	b=AqOBDTtqhuFWWZsVM98o27ieoHoyNrAJL2YDXPtfdJnsnlzHDd2+Mn6XnffbuIc9/afV
	 vbNQNrLNkOHBN8JdIYaZxdswag7B/jJsdwFUn3TZKDDXYm0V7k30yIvtdjBpfqrJZQBrR
	 XN03hgVsgIXkPdwiFWFquFPHbUADJn18mZ0k+B3KDLQItLXyaQ2BCSecjRkbG4Bdcql0f
	 j1h/GlcK7rYmepUKo6lOTItDRg1MVaear/B6ZYiFr881cpawFGQI/QmS4X6UMoeLhFtyI
	 hLiNhD8VlmNtK5ImY1KXMc22XR1IAl/9BA4ysDaP0nWpP1wn/evU91uyr5HnStNvfcA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795464493;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=KEAPYZXRhAflXYoXok3luasMQGUKdI5RN8LjnTgkkpc=;
	b=f8PX99hB3TwYMR/qPc+aKxOW0NLDvHFxTbnIn4YBKjn7W69K6Ds9luZkYdeVprplETGr
	 DSiNUi3TMTUuAjIEnyZXpypdvDq+uaH3YmcVWbbDFftYgTNcOwA5r5Me+Wk/gI9ZdYHf7
	 tsQ9CZDr4lHvd738A2owCATuEtd4KRX/lN1wYDLRPybeIuj8tT/AddPV5DE4K+0eR24z1
	 xjQr9aInhdkAJmDSEo2w7tDNSIbpzI2aHpLbT/pfw5jXI0jLCJKp13+phAz/wwUyYrSOx
	 9l5y9Qu2ytto7nHtvjU7B4dufmJjk3dMDkyMhfZJ4s2wT4mh9kKSIr9Je83zByGb5Lw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795464493;
	bh=KEAPYZXRhAflXYoXok3luasMQGUKdI5RN8LjnTgkkpc=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Rw8dNZ7y/Ij2iBPyqrOqqEzCO+kbOmrk40L2zdnibqVVzQRP2m2Vk4Kd+AEd7OXzY
	 KNxwbS9iuy7591SLX7sJsTcAcfjA25Smhi4FsRjRtVbZWwwKAjzDiET4O6FIb8Gru9
	 aM3+qZw0Z4ZWxIF84DENGzXQ1/3BxbCQdzaYvI7DeY9RGxb4nB2b3to2I/trmCzjd7
	 OUTMhUIzt6OOXGODMbM2mhabf6mMh+5bvdEXrvOghTgb1UW3NcKi1S50lowQtmV0EE
	 MS2y9a0tD70+p3my8okXtGK7UrhnZ/5+R9/qkJS/vKBqkT2Fl+6k08F8CUCZpNTVVi
	 iUCeJAVEGdYYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3ADBE60678;
	Mon, 23 Nov 2026 20:08:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B9F5D715
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 20:08:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AB71D4071C
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 20:08:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rx8-lX8Ln-wm for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 20:08:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D5E7E4070D
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::331; helo=mail-ot1-x331.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=OgRH9YOR
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D5E7E4070D
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 20:08:10 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-86298f9267fso2075516a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 12:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795464489; x=1796069289;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KEAPYZXRhAflXYoXok3luasMQGUKdI5RN8LjnTgkkpc=;
 b=OgRH9YORYrerRI9HmBzMfmjXXwbhmClMiHdXoozYPMPKpqnyuF5pbZILgKG6SKarWJ
 f9odULTKaDU0H0V3CxfZex2sXJ1HuBJA5YSgnmTSjG92BuRNn0l3j2qUw1Bjlw5rLd+l
 VcgqncIiN8SfcPyC+iaDHhdGUcG8qeLjtF8U00RtHqPv3sk4eo6hdiO9cChluUJ4bYng
 u6KqnJoVCYeD6oTt9ZEAtDGDh1COuSdFhSyZVwGLC/Vs2Qyi2ui6XO83sejV2iDy62ZA
 1bZElPOPuFJHKDmCs+5HDUPmBsZq2fc68AH5m+31CWpJ1+v/+saDRsM8Y2Y2CvmjWip3
 MVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795464489; x=1796069289;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=KEAPYZXRhAflXYoXok3luasMQGUKdI5RN8LjnTgkkpc=;
 b=aqDxMM7Pp9tV8I2gt2vYoBEeNghpsNGJne+1iftKUBkJgq06vQGA1iI15tk0ld3yV5
 o4JD54OiWwUvLl5MaD9c0pYRQaJ913C4Mi9KRk2clvuCZHDrCNQs72esh9QOg/+o2L82
 dMsR1iCzgB1DIo2x/43KqwYlfIlE0Eu5e5wJcA50YXzKn1PKbDs9j1XNHZArPx9UPFUq
 qTwSuXXylaLXtb69TFxxfUqlDuyURjMVgJs0l0He/ULlQNtDM5rDCjor7JLDbd479nmB
 2k7KXSitffuNSGjJQkEFc4X0KHo8TP3voPvFpZFCFWyUjWiH/Je0iTpTjq9QYgQepgnF
 J0Sg==
X-Gm-Message-State: APuU4Z9l54JVvv4mPjpx3IS9mqsTL4jatg8b88anyhuFkWozD9UoWIGN
 nx0ewtjbQOv6rxpvihd/DBUaI26KDNLa0HxyXJH8ov/db426E4DkgWyG
X-Gm-Gg: AZFdTZc5EOvrsKPC1s61a1z/njCPSbrk3BxKJBlF8udfeK8USbUwyLneznMFdnKL3HX
 gR4MAAuNnhKACYv0CiBDkyDHE7p+sf9qAxfJF8PHiGOyTsOqamzkkqsqtH7ZP4W3k1gQFMVqFwg
 T054Qbww5eGiuopF4Y1F0wMO9yvHI7+DLMCS1jwKY0VL8BLQJAr32ekPofWGuMl3mfG3rdjhlUk
 Llb65kF/G9OuWfeLYYwjJirwPMFpG//qvE4RZX19/gUyVhm+lphKpTM5enlabmA6hmvf4olXcsk
 XDkyG9Ct4NEDymhL2PvmVG4ZO5QC80M+1Wn0yaAmvmwq+dE+9g9CiVY/wcZyqQjN9yatm1oRS9w
 2VT90bWGOIgbfy8koAVScdIKw511FVm7/71n8I/n1gx+H4QQXEoXU86udn3WgTAECublbzOjozM
 jvJQJFflSpVuGgNSqqUvNbpdNCEKhIfujenuvZUajqvG77lTVHzNHVIwTROyWF1TBqzBbC9Bb67
 AxD17+uq1XDf4A5RRzW0AWHGiUidq74X9AKbiclare+jfJ9Qvaa8qxuJWEVbx8ZZpyy5aT37XEM
 8+YJ/LBz4CeXpG/l0X2OV2DrqKZwFEc2HoJkUGSnjWWs3C5Fd0gmUxveVwk+m3BwgDGqa2/7Y/F
 JtK0kH1dA3U6zEiwVcRf7PDKAt81Gm3Clm/04o0d816NblXFcj858DsGPaSPbOuvNNNUb86gZFQ
 uWPZ2m2qGHBKiDHHEdTOUmK4uR+mZyMm+Fk6C65v+RrYv6PhbGdsgkjg==
X-Received: by 2002:a05:6830:4490:b0:861:57d6:b2d8 with SMTP id
 46e09a7af769-8631590289emr13462377a34.15.1795464489181; 
 Mon, 23 Nov 2026 12:08:09 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-86322db2d1asm7799063a34.4.2026.11.23.12.08.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 12:08:08 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 23 Nov 2026 13:08:06 -0700
Subject: [PATCH] net: ftgmac100: receive Ethernet multicast frames
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-submit-ftgmac100-multicast-v1-v1-1-bea28ecbd8b6@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMzQrCMAwA4FcZORtouh/BVxEPtaYzYqc02RDG3
 t1Oj9/lW0G5CCucmhUKL6Lymiro0EC8h2lklFs1eOcHIt+iztcshsnGHCI5h3l+msSghgthoD7
 6Y5eG1vVQj3fhJJ/ff778XYMHR9tT2LYvhpiPW4EAAAA=
X-Change-ID: 20261123-submit-ftgmac100-multicast-v1-a15c274f6305
To: u-boot@lists.u-boot-project.org, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>, 
 Jacky Chou <jacky_chou@aspeedtech.com>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.17-dev
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

IPv6 neighbors send address-resolution requests to a solicited-node
multicast address. The MAC accepts broadcast and local unicast frames
but drops multicast, so U-Boot never sees those requests.

Enable multicast reception when starting the MAC, as the DesignWare
driver does. This also covers users of the legacy stack, which do not
register their IPv6 multicast groups with the Ethernet driver.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/ftgmac100.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ftgmac100.c b/drivers/net/ftgmac100.c
index 5e74f976999..139e1292db3 100644
--- a/drivers/net/ftgmac100.c
+++ b/drivers/net/ftgmac100.c
@@ -419,6 +419,7 @@ static int ftgmac100_start(struct udevice *dev)
 		FTGMAC100_MACCR_CRC_APD |
 		FTGMAC100_MACCR_FULLDUP |
 		FTGMAC100_MACCR_RX_RUNT |
+		FTGMAC100_MACCR_RX_MULTIPKT |
 		FTGMAC100_MACCR_RX_BROADPKT;
 
 	if (dev_get_driver_data(dev) == FTGMAC100_MODEL_ASPEED_AST2700 &&

---
base-commit: d778970a189b977c14f93961d7009f404d895b5b
base-tree: https://git.u-boot-project.org/u-boot/custodians/u-boot-net.git for-next
change-id: 20261123-submit-ftgmac100-multicast-v1-a15c274f6305

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

