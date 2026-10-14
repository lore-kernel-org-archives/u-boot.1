Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FCE4CC6B1A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 14:07:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A6AB160818;
	Wed, 14 Oct 2026 14:07:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fkLNJUUjBMDl; Wed, 14 Oct 2026 14:07:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E743F60684
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791986851;
	b=LZ8PqXBJhe21FEWxlpzteP2lx3zgfmF9hsjfgmKWveAMYQ6Hx5y76szwL4EhUL1Nxbjn
	 szuEjlARby0QgKW1z+C4NJqDQviDY9ZrT5v4tmFsrB2mrEm1Nx4p9OrVzHPxb4nWdlG83
	 Ucm+0mdPB+1XyTFhqgQOafA4KmVpUYK6uqiaZaPVztXCDfA204ObqnaCfFPen3cKmTlIa
	 yuyqqGtJ5+neUCMba0b80M51KSvSJEFiIOnoYPijLE9mFWqjsTMEPnwe4W1BSzehm6L64
	 VDRA5lD96IhqUfvlSJlKBfm/MBMABSJx2wNIP4ttEh+iTVf0LS7OwTGNvBflmmqIFBw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791986851;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Q3qLrQjG+b4gsXpWrEcABXrUg6CXtxiU2JUwdXrBUnY=;
	b=E3lWhpCp+/sjDY+Fsfoy0pWgQDMxOTWl29SHiGEbHByraFvaDBJT46xke8A4MQ6y2xD0
	 hRIIltahSQq+JfK9EmLouraLLy3VEyPCpQtjrpOkE5Qj8ah7N1VS0H2PPHyiumV0lDrq5
	 +nolPSpJliuEPcY3n/3t4xC2SLOXyeazOa38igKECDOiVELrt4ADLjb9AEDs/oNzbFOVM
	 3Bfp9H2z35XU7YdZDtlCIkKZ0+BPACvixVGjm28iItChIY2N/vwJinR/kYFFRl8bvQHQ9
	 6/mVLyvfJl4aBE/pkQcXPgyk+/V/8/1sNfi6JfEw0So/Wk+I2K4B3WiCxIPANwFaLYQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791986851;
	bh=Q3qLrQjG+b4gsXpWrEcABXrUg6CXtxiU2JUwdXrBUnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uD7+42sl12t2bgLr6Bc3sbWxJCunFktrCyvuMWnd73Svj7UkAL9iTP8U8wtrwiYSI
	 pyq2zkhkhcZL9yl6ydWfg7NfsJDVK8uniHBWEuJLcmRXMhcfSPc3vVpQNF1OXttARD
	 goO0r3maXny0JrdMfpcKPH9eBH6GCrR7pJrj7v0vpdI68CJoXSZoUMkG1F4FIC06IX
	 RLIdnLQghEjZ0PQrDipbd4EEhNEi1bnqcRVz47lXAKwTTWE1HZVt9uzeIuTi2dIbA/
	 kevlVa4ORuhc6j30SzOei18ACaFVgla0PFvqfWZHcEk/h01HhNnKwGIJqREbU0w3lH
	 EO2J9XbMnsuQw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E743F60684;
	Wed, 14 Oct 2026 14:07:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id F08EF2A8
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:07:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E27D1400F9
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:07:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e4LqWTDi09Hk for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 14:07:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5CF72400B4
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::633"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791986846;
 b=X+Vu/DIrxsJ3y71i6TxFlJKFQItO9Kd+a9vFieYCIdEpt3udBDeq6a+Ztl1MOtCAEL9I
 CNB6U6wsryCmb0gC4Zq2On0ENkDFmzCcT06YTQl/q0k+jVk3MOpCulTr7K5Grt242uEBk
 kHdnmWyDxl4uKFkHdul7d7WY43MbgXSzlaLalj9HI7ESeyiJgY6u4lvX/xtTK6C6DA8Pi
 lq7RVTwSkIhE1LANEy5VzdAeTmdCEiWQt8iBqU5NXigAI12gU9w6KSaH7pFNPVUYGwQ/N
 4Au7qOlsl7gZ/uboRWC8/+W7UEml8EJZen2Tul/ysbRrhfXDzspnLsCJf5v5bCpaoSQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791986846;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=Q3qLrQjG+b4gsXpWrEcABXrUg6CXtxiU2JUwdXrBUnY=;
 b=tHZGrmiMfGPeon6tgMmQW5l13ybV0rnFcBn7SqyxoEe+Tnyh1X0+FN6ZvIYv1JBNAQyr
 B2tNlJgBJ2/a3VCGBRCUrZMT6FSbqPLufiJRQ3KZ5LaV6UtR1PIWtyOZtxy38FpT9KanB
 CV6+pQoejzaau/OU+SWyeAE6Fu8A9KSLQEEZ5vFWZ5OtFXaJYnd8E+Dxo/FDnUlbps6Me
 ytzRjcNrbM950m70ZGPD0o+KlpkrUgjV00W97Y31kCxP35dcR2KkC5GYOZsNJgV5odHDF
 dHT4P8RBn+oiVtGikjBLqKbMidF4ist1v0VcGKya2kh5PsroIkIHCF2Sn+8ibsohYfw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="b1NO7Zh/"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::633"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=b1NO7Zh/
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5CF72400B4
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:07:25 +0000 (UTC)
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2e8f2c3ad6bso16033425ad.1
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 07:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791986845; x=1792591645;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q3qLrQjG+b4gsXpWrEcABXrUg6CXtxiU2JUwdXrBUnY=;
 b=b1NO7Zh/0SqwvOK+POh9geoaHYJer5MT18qc5SOBMS94jRtPCBwF7GIyq+RXEU8quL
 KtedYVSWyLmb3cICECryWXVfEUW6rZzmGOEqsHPuMsM1PFypUSAw9QmIZcMEr/qtj0Ng
 4yF34d0XG8L6AGCNSTV2qNqKuSKfQMH5/04j4fxl/BCh/4+s8YNzZQl08O+onH4hEeCt
 7YOrhQQtQAOR3w8pszPiME9G31XBsvXXB/0bUmiSq55FQvq/V0h7osiYEdYf3kNjT5qG
 YgpUP8B5LclRFCtC8UaXO//QhLeeTS/EnDujV1nhaCm0OU6Tzf9qMghabtctBGG5DJvo
 vkHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791986845; x=1792591645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Q3qLrQjG+b4gsXpWrEcABXrUg6CXtxiU2JUwdXrBUnY=;
 b=S4qXuq8945M5wvaHybpOoRhI2u+IM3kuNpwxDd6HpiEN3J9l3HEF3SoMbmBKy3N0Hf
 g1R7sCm1c41/aysvg0NXqfI50L6kOju6U8bAt3sw2aY9LQtI+DNeXfwqAWNVppQ1GmyH
 T9O2ARl5ejKKF3X85l0aJR3pv252C0H0DVYQ7v6coH+TSGFtdl3nbY8JUdiSqmTfPjau
 zMdgoDy7mKrr7R/Fwk8ajJczF9d7spdOv+VlXfpwymmyrr07NoHqUjZImW5IpJkvmMle
 B7cUUnJr4eaD+mxojwIH8SEzhTFrjrfQLJMspX2xaNEBcq3kHASB+vsdn8kV5nEu1H8/
 R9dA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzL3wznYtEpTA49mvziha5gEVU78fXAyB662tblcnHwuYCJEUL/A27xP131fwih99IsfXHTbUE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJULkfYry1zjl71TWxlHhdsdweGYTpUIcm/Cjo7112o9+JCSoaf
 kdPL8+E5t36V2nWQis+jfqixgElhCcsA7yIU8X/GPLbcUtxLPM3kO3gVcOUX0WEi
X-Gm-Gg: AYBFou2LaN2n0gj0G9Wk9dgD++LgL7DusnSwOPNkQPJ02HplpNs/q3schM0u3cBCfFi
 Eue0JdNKTTvtral5r/+X4Z0fg8RNTPAyjp7aZM5/hvvsnF1WS4Aue7XETaWF+J0chQ5gEoIWOvb
 KR7CuLd1jJuH+RHtqbKfohbmC8nVMdEMK4zRH3+8mMjaG4wN5DkVKkhc8WC5+UVVr2NC/kED6eD
 I8YCGOCVihFg9ptkAJNgj9oBQB2y4XlrTYads0MFelSn/ugrgzf6hXmzI1d/pMDArFDUh+KkCsm
 o0CGRcwKLArNStViDDZ0FJwZNT+TBYZs/H/roNINTN0AzkGlSEG9mXnfgAl1VfSv+I3X5py5B6P
 V6Qylzv3/95BetXHT8XI20mRWJ1CrABW2dDiBp/QZxlz8DXsQ5vU5fGNjRhH5uJOfh1AAsZfXxx
 Z91izvE3GPbUwuHv6yS9uXa7Y7azO6xF06yM32gv9hYsNVgyRD8dYW1WnI5H3hxjmPFI40+Qe7e
 rRMmMBXi9EUE3jmlIhAan9q3n1WtrtEvCSeJWncai2Z/i3adKuiX+AYX+qVGV/O+BIq2q3yBnPY
 iWCtN10y1+wfIMXstqxX7ifD09wmiDTagsqWTcnCucKdpQx0hzR85A==
X-Received: by 2002:a17:903:1ac3:b0:2e9:3ff7:b0ec with SMTP id
 d9443c01a7336-2e93ff7b26fmr19263215ad.1.1791986844982; 
 Wed, 14 Oct 2026 07:07:24 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8422b8202sm66885495ad.51.2026.10.14.07.07.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 07:07:24 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>,
	Tom Rini <trini@konsulko.com>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.u-boot-project.org
Subject: [PATCH 2/3] doc: virtio: Mention the RTC device
Date: Wed, 14 Oct 2026 22:07:15 +0800
Message-ID: <20261014140716.1181882-3-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014140716.1181882-1-alan.tseng.cs@gmail.com>
References: <20261014140716.1181882-1-alan.tseng.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The list of supported device types still only named network and block
devices. Add the entropy, 9P and RTC devices, and note that the virtio
RTC device needs QEMU v11.1.0 or later.

Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
---
 doc/develop/driver-model/virtio.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/doc/develop/driver-model/virtio.rst b/doc/develop/driver-model/virtio.rst
index e5da9f430..211304706 100644
--- a/doc/develop/driver-model/virtio.rst
+++ b/doc/develop/driver-model/virtio.rst
@@ -28,7 +28,7 @@ queues configuration and buffer transfers are nearly identical. Both MMIO
 and PCI transport options are supported in U-Boot.
 
 The VirtIO spec defines a lots of VirtIO device types, however at present only
-network and block device, the most two commonly used devices, are supported.
+network, block, entropy (rng), 9P transport and RTC devices are supported.
 
 The following QEMU targets are supported.
 
@@ -72,6 +72,8 @@ Requirements
 ------------
 It is required that QEMU v2.5.0+ should be used to test U-Boot VirtIO support
 on QEMU ARM and x86, and v2.12.0+ on QEMU RISC-V.
+The VirtIO RTC device (``-device virtio-rtc-pci`` or
+``-device virtio-rtc-device``) requires QEMU v11.1.0+.
 
 Testing
 -------
-- 
2.43.0

