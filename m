Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACA3606A325
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 07:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SkG1qVTA;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ymBK4BNI
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F1BF7810F4;
	Sun,  1 Nov 2026 07:01:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ipm3m7jpI6Pu; Sun,  1 Nov 2026 07:01:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 36E91810E0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793516518;
	b=KbPGXE+Y26TePJ5RQE4fJM5KsKzcT4ggtSbbQSkWNQOFc/2mHg2+ZSXthr4eaht0e9Bk
	 5kt6diX1mg+YVPYnNmKWy2kbw3hKAa33aKudfoS8V+/5j8NOtEpdan/JSVRL7KHNnM9+h
	 PpkDFq7Nu8wKmH0H8PVjd2uqTh4rrl9Jfq6m3boebPwr583X04DpT6P88xoXiJYtTg3+1
	 8YDEGGnAqhqVo9eeeE2lUkpzq+NPy1OP+vkp7wtzVl3QV4ZG7nYS/n2xA6iushtPtNl6X
	 S3yq1Nfqitbmugr1HXNrYC+tRr4/Ndki9cO02Y6qWNIs67OOqkWZb1jWUOhYoJgP8uQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793516518;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=qrAR8lJ4imukpXjrW4CphDMWtiygvgmxq3C6YxdCJwQ=;
	b=VYkRL8j0GY/2CzT23cBDwQbAio+r3tvvTVXaRjWBU4y/489SLx/+3j19l3qbBQ1g7prO
	 eKXbTXdEwDJYsh8cgkTM77dIgiz3SZoRRvEMAz+pdxOfu/j13oTPZeDBBJRPiWJuGxLhp
	 zvGCOMoR0W3T9C1g9ovr2acLK/kLw0Vp1oxZpA0rcdGLp+RU2Yz6YmgEjDLaeLbry4ecL
	 lmj3PwHNRi4JObqCI09qY+jLgRbRWjDAmbg1FZAiWgEu6ZhOoLchnAZc5fKo/pYLfdK3F
	 G/1gF0GpJI/z0aOdvAL5Wcv7AGVCbSKKSGPCYOWF9RBQeYJBCQtegrggMJwZFjyTslw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ymBK4BNI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793516518;
	bh=qrAR8lJ4imukpXjrW4CphDMWtiygvgmxq3C6YxdCJwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SkG1qVTA8EA2D5qcAeQzK4op86w8cR7N5CHy0yzYN4t8HzMaRydyRZOhmk6FQxwoh
	 +9NECC4qEQu7yT2UWmdRemWNoKszcNscrySIAOnUyRfDw4vTjOq6x4pT1rLIeoUVJB
	 vnRuJ5JpE1bRuHJyHNs+7joJrt7MfkUE0AV7jO/ec6+8DfC+T1uag6RMw0igxnnTgC
	 ID1JMxYptCi2aTav+1+Jdxwq5OSWp8AYg/GjQmmV8d1wUV7lQ+LchFJOIXcuZY9W5r
	 jI0czvPnqGZCJVYUmY/RRf1ZWjbKZHoC6olrS590Hc5FcOPigvIgG0uzJ4xXdpsqDi
	 0QSnutZFGDAKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 36E91810E0;
	Sun,  1 Nov 2026 07:01:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9D688380
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 07:01:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 839A0810E0
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 07:01:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jhT027zLsJ7F for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 07:01:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A5D4C80EBA
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793516516;
 b=MHGIRwPIEEzkM2xqEbQJ8RxC436fR/lWcK9UESC8AZ0CKEi8A4bnUuSHOvllj23IpmMQ
 vc/g962SqUO1tIDAqqMa5/IiOIqeBr/VjXloj2ZfCJJ7vwzUm6AHA4ICRaUVASaDyoW+6
 Bd7fpS4BJBDucFC9qquU0Ya4ANpqX13tz370jm6Y83mDwW7oVA/fY8srLYqFn5+PsIl/f
 LfSOaewvh93alhYhcFDTLvi3Mw9FpqC6Lc+kqfIA6aXo9qUo9NhwbXuTzW2hHvbNnBsaI
 epW2sG12Q8oNAOOwWRq6tglhn+gUCALuZsHYyxqzI4pM/nRPNTlf+qdJxY1c/KfOJpw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793516516;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=qrAR8lJ4imukpXjrW4CphDMWtiygvgmxq3C6YxdCJwQ=;
 b=LmuB4T3S77XsL0aIdWn/mzlakF/C/85mIKYEFBavaG3eZbrWFy2O81wPtdH9QwJIKrUO
 reD9Ym9jBP6YhOPqSQov9TXXfqozDWyktm+uJBH6aZmkIy1VuH6hSQD3DK/g3uyJCnxKN
 MaKat9hvPzYSZ7J6HL0P89wQBgTKaLibcEu6Cwv59PzBks4UeGtrqlo9+/cyZJLFNxsde
 EOMTByxE6nhLncswvQR5VP7esSUAA/47P5RtN5U9wQ0+jFDVEInAIOgGIz/GXiN2sBK6B
 PzYhr+/8icYgRTNGcmMuf/YvTDMgqEGJUT2jIuyWrX8dYNkR5XPJaYCWfSwV9tz6o2A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=ymBK4BNI; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=ymBK4BNI
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A5D4C80EBA
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 07:01:54 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso20454995e9.3
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 00:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793516512; x=1794121312;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=qrAR8lJ4imukpXjrW4CphDMWtiygvgmxq3C6YxdCJwQ=;
 b=ymBK4BNIy2q9kPLUBsuSDgUSIrYnhVlMo6pZTwLzTbXLx1i1K7hfpKVn65MSw/vpez
 eAcE/2OuQ+BrxLl+w/7+N8P9/Cmy6SOZ44B5QO2qUHUVfidSpuHS01NL+zB9SVLz6VNh
 rpbJL29XQdxbeFwldecNLCMpU3jwLGV+he90NVhJ9SrEiLZ8Yrd/o9HWbWvhwr50Y86z
 8JCAVgRn0BFyE++b2OyXVNwdO0hfHkdKFwF9biPc4Lzmhgb5kwGqeKZX7iMPy2O40MXe
 wtIbmty9H9H8TvYavBCdowYGAS4VKnYbLU+506coeOxP6CQ1OiUohermtK7usu0pOGMO
 r0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793516512; x=1794121312;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qrAR8lJ4imukpXjrW4CphDMWtiygvgmxq3C6YxdCJwQ=;
 b=goK74pWqqPCDwDwGCyaQlLWyoNsYyx+YHjW2txvg+7cUJwh3+XRxPSMWCgnHQKo+3h
 tvRK2Lt7bLK07h9ljlila+Y49DRwhds5I+WLpYtVgI7wVLMqHCRKENYf/BQ6jvr8oeXy
 3yxjDG/wjIbtwDz+KQLIn2XXR1H9yTO523/OG96xQ9ocdL5PMjobTJRzmkVSf8vEBoeF
 bfu0Mh/aqsAXk48X8zxzN8RJfFUo+eiKHx0KxqYA6uuxbtL3jE5b0RXAJN2qXFtroUN5
 +gcX12RTsIHmS/oXgkJPtbls+ixYbnZfzNic6b3zdBFvC8aZp80frk9GMK0mX7fuUXko
 9/Ig==
X-Gm-Message-State: AFq9FYJOHVfyXLc+dlzA4Gl9v63PweVX9RTFo4DlrwGQYKXazguDIhSp
 ytPJdrPa9sG8LPg5BPnr5mALXAUoHtB7YWKb+dgKO0tX7wJLMTMQGey3
X-Gm-Gg: AYBFou3k7BJCiKJhG6f2Yh2/cpFZeWgDyKkbfiaSzipknviJLraOMofT2w91kZomwzL
 USV9uq9RHE4EtBi/QuHUFfWlYu64v3iLKh2bhZaw8zwml47BkK7JwhA1aBEP4HRlQNl5GxWlxWz
 CsRygGwBuIlr30j8e0xDgeGcZryPjatcMN7pH1oFrYzZO/LgS7S5BcdHAlEY+gYaC/vL+mFdWbk
 hgmudJuv7MhgwqoUIvUJmfx1rCiOOiUNoG4tobgx0rsX7COPdKrvKxfv3jJSunZTuyy5D9ot0GT
 +xEu5AuY7NmEw3CxxzCjxagpSpDU8XlnV2P/Kg37mMou08FwkIab3QX10ft00mYl0awBPW9jyKk
 uTDjdcRo7jwuNf3d4dgIbP1d7l2h51dGWNDuwEdrE1aSg8x153J7aIkoEZICA4uR7PA4MNeSBMz
 I6FSrwT+A6WypLQwuQG2usmISokBwzY8Z1darfGcYVxrpkiGCv9vdW1cex7slp9GIxb9f6YbcxX
 /pbr2QoWgUAI09KjOOuhh8kXSFGnh7Q/BsOhvJ0cCm+UK4LwqPxLoDLPuGnGDe7GLWBaADfcsDc
 P2ZJ4y8qft4a9WW2G/XoEjZ/IMIbwW4=
X-Received: by 2002:a05:600c:1d07:b0:4a0:23f:8b0d with SMTP id
 5b1f17b1804b1-4ac150b229cmr161614405e9.2.1793516512235; 
 Sun, 01 Nov 2026 00:01:52 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ab69b54742sm369997375e9.15.2026.11.01.00.01.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Nov 2026 00:01:51 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v3 03/14] usb: storage: Fix the capacity faked when READ
 CAPACITY fails
Date: Sun, 01 Nov 2026 07:01:50 +0000
Message-ID: <358ffb02-1b24-4312-b7ed-992604598c38@gmail.com>
In-Reply-To: <1ea4ecf3-70d8-4469-be94-1943ab8e3337@gmail.com>
References: <1ea4ecf3-70d8-4469-be94-1943ab8e3337@gmail.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
Reviewed-by: Simon Glass <sjg@chromium.org>
---
(no changes since v2)

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
