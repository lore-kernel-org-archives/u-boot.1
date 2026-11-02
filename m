Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B962D606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 03:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=e6dzEl5Q;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kXqT7Xdk
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5625F40535;
	Mon,  2 Nov 2026 03:04:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cW4fZnNjbNoL; Mon,  2 Nov 2026 03:04:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8CB2940508
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793588693;
	b=CJKsQECRq75HYQwqA6gIvTiPHPB8s1sV9mQMRJmTGdeGyjhn7TsVVF/jTlM0yTmTyz+5
	 yPC+ZhaFtrRWx0TbHDQSBDYHd9dx+o0AFptwa4hHvZCm2FWi0novQ+mYmQZOIt+B4dKWI
	 HVL7FXpc02vmGUBaa16qdNMlGpwavzfREx6f3RCYhyPIQp1xZa6ESQmvGTPoSgraszQin
	 0MxqO4YPeUyU2VMrgdpTVQ2FjqLIGnheQMRr3Akc7jiW1fQuz1AdE2VuqnmhV7SvmhDd2
	 pb3Hgh89jfU37W+vycAgT0b5sr7HIoOdo9CqKYwJz7qUKurb55VISDKUVah7gRr+FZg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793588693;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=oveu8/eAYn6zrHg5uWi7YUA3ileeOE4pfwvH1zH8ic4=;
	b=R0/ZSsXeIVPvkR6/INDu/WnXoS5NNX0/f6nr87hH9NBHdDfWR3QaubB0VYjQ3UbvoPp2
	 twRw/IEUCBCwiFScWfZN9+IGtTtrqc9NxM0aAcSsOA3+YlPNjVIqD1dO1VB/Mrk/U8CEE
	 xrwwlnhxxtOeaQQqcZ+GyxNmdv15GV8sutFVUS6uri2EgvWQCnx9sg5BIUhYLlhlhakNi
	 pc6OSCmHKoFU4RHhoNxjtem8wcQMQPWDJDadYNFc1CXDyrpt6DE7Z+NSOps5SPEOc6qrn
	 pGh29v6f8Onc+QBmOgc6TkfJeQ+1sdTE0/o7HLUxTdC0wRApIjJ4OOBgWDHyozEju0w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kXqT7Xdk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793588693;
	bh=oveu8/eAYn6zrHg5uWi7YUA3ileeOE4pfwvH1zH8ic4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e6dzEl5Q2DVAzjnWnzt3hqUdEhUkM5OfRyEBYjYMDLOi94uYo9LPWK5wnFYh2llhf
	 uabjd0Gg2wRum/u0pK3c7E+bYSQ4T53j+6FRbqkcwBOQASA0M++5QuzWzF29+ZAu5a
	 xki8twrRfW0pCW8Rn0XM7BeRML/f7SkYfN7mAsM1ZTwYgMVAo6YzbO2oL2GY6BTSdq
	 x0yAZOtg1kCZNDnLQIJv4+RCI/TVtrH/LZTkP/cVTZq3qqq+bL5PjrFpzB1VlRc0IT
	 lrFmrvn+heu/DIuAxZSnszXSc5sEMaXsVCoJM9QSxTBAtb4hTRZNTJUU/MXfyTUCpY
	 PtDk3gN89qaTA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8CB2940508;
	Mon,  2 Nov 2026 03:04:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D7F35323
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 03:04:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C9FAC40508
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 03:04:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EyRdIAlWwcXK for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 03:04:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3285840506
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793588691;
 b=qrVNCcHtQ1MaDyN5MvRpkfnIEJv0zSrHXjltzZhmer7Y/wPNz468ZmiN8/olGnsi3c+U
 Rjl5wt1TFU0PzPQQ57ba5Ij6KvmdHOoCM5fSFR6pYx+F74J3YA2sCUj7hLTFvGwHD/pV0
 wv99rk8nvvuGlXGJc9nY7C3TmWfiXGGPzzVCkKGeyCbsbUXDTJZciGthIEaZvbr2AF3cE
 PM4y+R5k9UsR6AyXFdCvpSdNXcBWAOQi8UbL7f811go6gyWKxIFDrwcUMiF9M/Xcp3qrN
 FaUXFLbDLv0JDs3lg7pfl1Tx8B3NLBASswFZ0CdW5NQ6kI1aCFdhNGHj3lP+UblnAkw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793588691;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=oveu8/eAYn6zrHg5uWi7YUA3ileeOE4pfwvH1zH8ic4=;
 b=KvWyqPI2Cp3MUZRfhnjaz1HRia5DqxAIa7p1JK/Ng31Jqyn4eV2UiH2uICib8SJyPp2L
 wUliupnXwHmyIXq/vxwS1VtKW/h9untCuc+TnxBg4x0mE2gaTNBd8zITjO71M7UuPj3y8
 AzAQrTzqpeiMd3BiVQMS2U+nW7twDYqthWpqGskyCR74b3fmjvFmhxLKANqN/4awU+EBk
 OLbJraumu2gmXPxcofa2nkFWQbddQWvqBmgrZl1csjUIP55WzL9DLUB2JNgYPNUn7Xfv3
 HOWdz6dvAj1pnv5uJtiUCrGMH7jze7yWHIOg42qNdcSWpwH8CTUjzw3nX34GzekpurA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=kXqT7Xdk; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=kXqT7Xdk
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3285840506
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 03:04:50 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3ad41b47541so1919750a91.1
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 19:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793588690; x=1794193490;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oveu8/eAYn6zrHg5uWi7YUA3ileeOE4pfwvH1zH8ic4=;
 b=kXqT7Xdki9oqRAH1eXqMRdwwbVxlaMYwwrwNwYvuxAB6i7aTWpQ+0s+PEumZqZIK5X
 WAWeEDeegkpQVPpKKTFEpJVxjab+qhqhe8hu2Rj4GEx6GdS9MYgUWS80Wrl2/6Q3b8bG
 y+XtQqP2KlOVw4w/wQS8p86UX08ns2bR6Qmz42wxydwqzfFIVU2qeR5A/MoObP860pLD
 BEfPkXNZyYALT7uiT0wXV5P66zvr2j3+8Wz9NxNyMOxo2vM2z6215FmGPzeu58NheH99
 8LpHJv+r+TLJ4ieCCTf8AexfHTfZ5n0y0us6dKxPB2QZhdxDKdZi57Wf/qXIM1UtzpKV
 9uKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793588690; x=1794193490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oveu8/eAYn6zrHg5uWi7YUA3ileeOE4pfwvH1zH8ic4=;
 b=KYaAe0XAvDKvoEYfrSxWrujwJsQ80Ckz+4bmlt61QoXJ7B7LsNoD0gPsBm8niQpvbr
 J+aHqeQD+9BRqvsldK8QuCQeOP6te20S3eM/xeSwaB12qK+yN2/WVKxJnEBOFspAYWw4
 ZxALMJuJc1uIbyejc+gaYgthLvC2FDsER2pe5Wus4LvqOLWaMBxVFJ2cMlIKaCj5FI1F
 0sMmtDiRm6jrKW3F9CQ76qmNTcgYyPgNgZKa84yqNVpDTmN/4VSwyNjm84Djo8fjxiI/
 jNKqYqNX6qwg5cDKQnxSK6WR7EM8SiRQ//A1+a2DnqXauNWk83HRcQp6nk4jwizSrmYQ
 VYCA==
X-Gm-Message-State: APuU4Z+uJD3SI6aCcX6tcN56bOJTTG+OTBJ4X0tmHkS5Le4CNggtwWeQ
 L9EyejtL3M3sj/P9/cajC2VvEA6ZkBjDdbSFN0bLphB+OM0ifelWsp2ZCHEI/F08
X-Gm-Gg: AYBFou2ibJeMnYG8tw3+AXQ3NVj6qxsBt+GOSn+YZYL6SXosVB0BYElw3kfz0a9QS2c
 B/k3hFtVoB8aB/YSjelkFwn37oCw+yu4/URhodlrNcNC6sTzsdh7b1jmAP+nyBUTjGpX+HUDhB4
 DiPRix3QQqO7D1VFZZR2ycRrND0nKlDffbD3l1zlPSWc/kLykJzvyuXDWoLavRVBe8ZQ0PLDKJK
 kFJEPYG5+SwmtIzCFx412+HZAJ1f3bkA3uVHhNBTB+KRsG+F6abqlRqZhlVj60Sn+cGxyYC9aOr
 P3EW9ENA80GgrTd8jV65HjY2VHqZ5HQXpV/ZiidUSf7K2UQfSARlb+PlSYVse+pWs58Ki9b7QLy
 ryz3iT0iWKW1UzaGCI/bLYumhZCcGl5ztuFSaisNRnHnXJzDAYTSh5luehwct22LP+RgsfQgQxU
 atnoUbzp0nHTPnQ4gRVSvzlBAXVkRWEByVccTaVUXrjw12tC5wwLFc8wNsdPWkf6bE1HR3GO0WC
 GTdXOgQ04RawgDC9fgMUQEJD7gx8/B+rVad1Z+sNpeNc/yZIoXhEy4KMTtzRHYDZ/0+JncjWQsY
 VGImpelh/Iiet8+dUqRF+4opTn24DSEYVvqlDaLR+SvFqHepI02tJMkSp0RccD5aKIm0yumJfPi
 YBbsQ9VO4g8f5Kr+55qYq488bd6trjgMauj45ITjmGOD2/gxj1V619LsqfclHnzAE7q9bHEnEoJ
 InwbIwa7+zIGy1qZS/Fgh+9lnDlxHmzA==
X-Received: by 2002:a17:90b:2248:b0:3ad:ce34:f63c with SMTP id
 98e67ed59e1d1-3ae8974abd8mr7156819a91.30.1793588690172; 
 Sun, 01 Nov 2026 19:04:50 -0800 (PST)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae845432e4sm11995159a91.3.2026.11.01.19.04.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 19:04:49 -0800 (PST)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: bmeng.cn@gmail.com, trini@konsulko.com, visitorckw@gmail.com,
 sjg@chromium.org, xypron.glpk@gmx.de,
 Bin Meng <bin.meng@processmission.com>
Subject: [PATCH v6 2/6] doc: virtio: List the supported device types
Date: Mon,  2 Nov 2026 11:04:38 +0800
Message-ID: <f11010ca239ba3b326633d7811a7ec4ce48fce4f.1793588058.git.alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793588058.git.alan.tseng.cs@gmail.com>
References: <cover.1793588058.git.alan.tseng.cs@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The list of supported device types still only named network and block
devices. Turn it into a bulleted list, which is easier to extend, and
add the entropy, 9P and RTC devices. Also note that the virtio RTC
device needs QEMU v11.1.0 or later.

The Development Flow section repeated the old list; point it to the one
at the top instead.

Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Reviewed-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 doc/develop/driver-model/virtio.rst | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/doc/develop/driver-model/virtio.rst b/doc/develop/driver-model/virtio.rst
index e5da9f430..30df0e944 100644
--- a/doc/develop/driver-model/virtio.rst
+++ b/doc/develop/driver-model/virtio.rst
@@ -28,7 +28,13 @@ queues configuration and buffer transfers are nearly identical. Both MMIO
 and PCI transport options are supported in U-Boot.
 
 The VirtIO spec defines a lots of VirtIO device types, however at present only
-network and block device, the most two commonly used devices, are supported.
+the following devices are supported.
+
+  - network
+  - block
+  - entropy (rng)
+  - 9P transport
+  - RTC
 
 The following QEMU targets are supported.
 
@@ -72,6 +78,8 @@ Requirements
 ------------
 It is required that QEMU v2.5.0+ should be used to test U-Boot VirtIO support
 on QEMU ARM and x86, and v2.12.0+ on QEMU RISC-V.
+The VirtIO RTC device (``-device virtio-rtc-pci`` or
+``-device virtio-rtc-device``) requires QEMU v11.1.0+.
 
 Testing
 -------
@@ -246,9 +254,8 @@ So it's easy to tell which device these functions are operating on.
 
 Development Flow
 ----------------
-At present only VirtIO network card (device ID 1) and block device (device
-ID 2) are supported. If you want to develop new driver for new devices,
-please follow the guideline below.
+The supported devices are listed at the top of this document. If you want
+to develop new driver for new devices, please follow the guideline below.
 
 1. add new device ID in virtio.h
 
-- 
2.43.0

