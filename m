Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86FF606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 19:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xlUCWKan;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AMCS7sUC
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9B11A80F32;
	Tue, 27 Oct 2026 19:43:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s5VsZNvNdTBP; Tue, 27 Oct 2026 19:43:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7F08380F70
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793130190;
	b=DqAeEGoeU5jvnBPzqADbAbgQ1BJgSBjNAXl1Y8MuWapgj+jYXLZxZNiKJdJ/6298Il+Q
	 GcQ7V/yxR+Sb9CmF9z7Jy0kklVs5TbdhldsDEHU11Rsw7uhz9fr4GW6KfCuH8Tpqq98x3
	 nE1KZ3xbKg2YgMblIDfOOwTNYPZ3jxPd1khaZUgxJBegde/70fRPU6dexGny+WVPwHYfb
	 +YcFtrSRNs+7MJARMJJVF3W8DFmTEOhbj55ywwdBNsyk8rhW874wkI0HMOaHzjjuCMvBT
	 fhAtK3+BuCwep0jW7D0zxJULOgRsYEEBA1U7rhVuw05cyZ6XRtm79ntPwFY1KrInuug==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793130190;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=u5UnuwRY93Qsw9My6QpuIu6XEeXY4CuoLxZA/abC2sM=;
	b=Ld/F4LpwHugk2N4OGaAnzwu/zfwFhmoAqalJtrSkZlB3dLErRJ2eBp4uFwmlUtf0Avb1
	 Znn+AlQQqKbh6mtrceHxuLYTKmLa7NwK3KPAgRNs6i2A7zMIQJ333oRbxeb64my1dwRfj
	 /qz5XjwGagGrFHKywiy6EA1FzvQxqQYejyPiVBiGJoS8zEz4w0CcP7y7uvBl1xGgJ18mZ
	 WeLizwfWHwUcqK7Rc7dJNW4wHBKrxhXUTIQcb48dywHFh4PKOMk6YJ02YxRD55xRpgWDY
	 CItOH0/mNa23tXHrti4SAGeeyFrl/MsfcMbmsZq74CBLJZ+eyNJ+/rGw/bPJuzERwxw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793130190;
	bh=u5UnuwRY93Qsw9My6QpuIu6XEeXY4CuoLxZA/abC2sM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=xlUCWKanHI0eR80RQyg02GIubVduDm382P7oWuitKX39Us545LuKxNLzC8IQWV7dk
	 djOhu85/C6nZ8JKXRRQacp2KpmROMCiraIWjl31OFsuoR9V9I3XE7A70NZFbi610K3
	 hgcmU8eOF+DNgIKUeSBwKXZ15nCiQCf6wgN0SL7VWXgFt0XRaf+yZgj6a9ySJU0MyO
	 cdX4pqwtJhLQeOO1yJIr9hK5IDw9El9VHHb1JWFLlgwlPsfndc80txUooeWihMWJje
	 Qw1PHhy7Cce08hGFRFpByPNH4W/wEAIZKFu5vJupM89+K7/lt90/ZzMIHV5BI1SksN
	 Cl9AgRW0oIJeg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7F08380F70;
	Tue, 27 Oct 2026 19:43:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id F37554BC
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 18:53:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F0BE9401A0
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 18:53:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SxwRQa7AH3i7 for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 18:53:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 124404006F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::f34"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793127223;
 b=iCHxLptYgiuGpavMTJz9JskxpB0qgfZ7weu8BIIVAYr/qpRMIU3ehsHCjWS+s6gqxFHR
 Ovgqak5GVnFrMszsIQDiSBN4Lop+htZeU17Jkw7nxSYk8AidFI/jWdKWwT9jjBnDwnLr9
 vRfwe8FzNbfyk+v4KTJTZAWZFMjt7p+FE77a2804llgIhbY9gloo5bUSlC9zExEpx41oC
 luV88l+GhL/Oh5T2qoH8aSFSeM3f+d0aGolWL891jR4LCSU1kEy9Qh5EooY2eXcGmOK3O
 1Ob9cMmfGlxfvm//IOQ7jeAXeX4ETkA+RroTJCRciMwUIltEvi5YS3tIjFI7OoqXdAg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793127223;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=u5UnuwRY93Qsw9My6QpuIu6XEeXY4CuoLxZA/abC2sM=;
 b=aXEfs5HfBv5+i+MUURt/vwj8IhTeap0yzh+0KwJkj7E60mfpVxgkew2NPBfONnZQm3Zj
 2Xoy7nhezg+u7MKqjznd/KDVFLlj0SdCVd0TWXpCXM11PeaSDcSC3zAfrwCnO7JLZ25S1
 ah/dxIQDrobgWWU+UNa40HDIpkouDoxURFfjIYf36QwijhMFNQyp3kqgTXh/woXcRdAw7
 9rmMXLMdn364jx8q3HlBVEFnSVG3eRIAVN+SAX3OVX67B6YvUXPO7IVMr93orM9dAjdTV
 P9+RqAMb6GsDWAqbHyrY8SND3n/E0ABv8+JatZi/Fca5vtX69VKaApawIJmBqdmDkDA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=AMCS7sUC; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::f34"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f34; helo=mail-qv1-xf34.google.com;
 envelope-from=oss.patchbox@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=AMCS7sUC
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 124404006F
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 18:53:42 +0000 (UTC)
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-91c79a9a739so2780656d6.1
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 11:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793127221; x=1793732021;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=u5UnuwRY93Qsw9My6QpuIu6XEeXY4CuoLxZA/abC2sM=;
 b=AMCS7sUCTiKNqNr7DIkAy5ydkDoLUmpHjluu54tIRdU6SNlQ8PP1kkdzk9gNoPQNCz
 7EsEqUSg1DJIG9hpJpEOOwyZNKaGyOHtloje63wOyB03gD+BbcKU3NS3mQm2aGnZoJmf
 FK4KAoJrH+U5ECBR7IHeTxgw+tRmPHZFUcy/Ize6CpwKAJuyhOSFCi7CozSHw/CxjRen
 MREBArJe04qG5FU8b8+CN4D+x1mwV0nNdaddU/y64dAshtA2OAzywTM8aOdWDHlrnr76
 j5qNs2LIQQ0rK5gL4OPdG+RYgsAuNvHH/hFUvQJxlStdATCAc6QT4O9h4fCF41EOMnxc
 jVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793127221; x=1793732021;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u5UnuwRY93Qsw9My6QpuIu6XEeXY4CuoLxZA/abC2sM=;
 b=EJIZ+FG7FLD4pKRfaKg+DoJh9LPEmw6Ep6sM0FLE/+YTCb0JyfiPZvRl10jNu7uXto
 smsYWXwXGY3rgAr3P89nDWeep6sWI/J++SWI3TuBkYmnSM7uIBe8L2GYbai2sCEyjrly
 UriNgOjPNAsbABnUkhsaFl7NzfsWoGftdvk9fC8lFCbMUwV5f9flf11WMINhnDdzBPke
 SjHFRqcumoz2gfo5rLIa37ilZYnxY4Lz8JLLsBzWe2rcQeXp8N9n0Mrdvt3WgLnSF1Co
 NxyEqsQ8RkTdcHHndg9BrzJScIuMfDbh71LYKxBAbvuSZBOLKUBXosfalBat6KRG+3bj
 lk4w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzQnv87KA/1WHMCbnQRfPe3BXbExQWfvvT7+MulSQ8CIGeMQh1mjWrt6/RHeB6nLXsHEVnVQZ0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLbBjh0nEA7MgKqc+nfdXj46StEQhvFoD4NNL/c3ImeIcoyWA53
 kqpBEhbgjCYgQMJn7wDSNadBsUnEM9Hvrd6TtdYhpwgiJqEPEJkpctWa
X-Gm-Gg: AYBFou3jfkiBM7FSlIThUU+v8+g72XpG1RHJXj59pYc443itjqDVC1abDubCZMI5Yoa
 Tx7x4Vp7SezNCEQV+3g3Tb2CXH3g1cRf57jq9HIy6BBLLY5IUTnr/8RxbjyOUMMTmQVhAhzqyWn
 XV25nkveyL1mmqoxxtwKxBbp4eOg2ugTLb0QlOBZyTaTiR70tczJe7YXgA4OfhaB3FWqtYVlmXQ
 y0iQktRPnbexJyHbxNBp0UCAPNx+VnfHhxrl6i8ctLTdshzY96WSiaLLcFcuKzdDhoODNBruh1+
 xoY7o+KPX3wP2okLh/gdtOJReFPxsCMyFMrTETbWZa4iQns0VCEqzpIb4aoNmmHDrL8t3QDHEW3
 il+aNJ+8BGcCXrSnSIrHMjtPYe6JHeTCvp7JZjscuuKCs8XfDJUuRZDO3G+fE4aWOs2WRPeKB04
 xDlq8PrLvwVzBkC9YyQa/RW9VCSYD6sPud9t3/YSrCHPQgYw/zeW81kwFPmqx6yTbDhoAleuHQf
 p1Hm9u2aNQM3i/CCfyVRXROF0JclrtF6fvhUvkjl+6chcx/mSHaMMLlWkEs8JEe04Q5U7qJkEqG
 Gxs=
X-Received: by 2002:a05:6214:f2b:b0:91c:7246:2d4a with SMTP id
 6a1803df08f44-91c72462e58mr45868386d6.35.1793127221216; 
 Tue, 27 Oct 2026 11:53:41 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c6bc95b66sm40710356d6.43.2026.10.27.11.53.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 11:53:40 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org,
 Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH] virtio: free device name when the driver is not configured
Date: Tue, 27 Oct 2026 14:52:31 -0400
Message-ID: <20261027185337.51168-1-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 27 Oct 2026 19:43:02 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

virtio_uclass_post_probe() duplicates the name for the child device with
strdup() and passes it to device_bind_driver(). If the driver for the
reported device type is not built, device_bind_driver() returns -ENOENT
and the function returns 0 without freeing the name. Ownership of the
name only passes to the device through device_set_name_alloced() after
a successful bind.

This happens on each probe of a virtio transport whose device type is
listed in virtio_drv_name[] but whose driver is disabled, e.g. a
virtio-9p device on a QEMU target without CONFIG_VIRTIO_9P, or the
virtio-blk node of the sandbox test device tree, as sandbox_defconfig
does not enable CONFIG_VIRTIO_BLK.

Free the name on this path as well.

Fixes: 8fb49b4c7a82 ("dm: Add a new uclass driver for VirtIO transport devices")
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
 drivers/virtio/virtio-uclass.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/virtio/virtio-uclass.c b/drivers/virtio/virtio-uclass.c
index c163b2fd7d5..e745369b257 100644
--- a/drivers/virtio/virtio-uclass.c
+++ b/drivers/virtio/virtio-uclass.c
@@ -239,6 +239,7 @@ static int virtio_uclass_post_probe(struct udevice *udev)
 	ret = device_bind_driver(udev, name, str, &vdev);
 	if (ret == -ENOENT) {
 		debug("(%s): %s driver not configured\n", udev->name, name);
+		free(str);
 		return 0;
 	}
 	if (ret) {
-- 
2.43.0

