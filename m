Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BBDFCCF2C4
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 18:46:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 48A968115D;
	Sat, 17 Oct 2026 18:46:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F4VgQZvtqkgz; Sat, 17 Oct 2026 18:46:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 91279812B9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792262796;
	b=HHBRQ2hrqWgWYp5+1QiVXbY1p8SXgLVKimdEyBRQLjqMzpBMa7jbw+6us9LRuGHJfw/N
	 TA2h860u6MHDFMhsvOKh4MKlNQhMkqqdB+RwM6bWz2K6ivyoTHb7XrPOim5F98FSBxkRl
	 KfOvxjdfaZ0xEZJPuIO7Q9pPC56dyC23SZyYf+0lF/EJ7LzVJL7IKxrZ5P9CiXKN7BzaT
	 XyWUKNJK0ej3gY/VCmVx/4VrgTW6DJV21AkLXbd8/1hezNG/s5VHLOSF3htmcYk4G/QIR
	 Zxg3gtbAfNHb+Ky726bWfYvWDWTc5+qGxoOPnGUOVQ2eQ/Bl2LpMTnyhDUs+0psKUQQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792262796;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FWmm//3PTb7sLNylBdlYtxLLLEm6w0kpPs6X0UjlWxM=;
	b=nivlmXSz/AFGEKWCk0Vt3UAle9xtt63reHyk54+RopQHvaGvoUA4IXGmeH6dhjwNUQik
	 uPsD+dS/Hs/MVT5/6CQiK0J5S1C3lxbHYl1dp4RcKma5dZmjbqMJyjyj8aPpLtAr4Df2E
	 reCqOhHMJxAL3K3ItClHR+y3cwGz8xP8WlQ2ETHRKX+RnIu/dEt16Ly8ZOlvTzJJCxM2P
	 fCw2juxxxUhw2JjvkeubVNGJNTe4zjv2p3AuPF+kItW0msNSrM4IiPzVHNO6iVK9wfyRf
	 Z8J4L6G3oDQNZ6h4T1nV7/XPzbF+LQ8/loFARfS/8CRfx4TijknIVy9g4tQupw8rEuQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792262796;
	bh=FWmm//3PTb7sLNylBdlYtxLLLEm6w0kpPs6X0UjlWxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TTWfir5jEQrgzOrKRYxA19RCYPPotVHfJeIcdSn4iikz6g5w0943jalGJnyIEvB/0
	 /uGxIpzx3nB161U6UwJ0dNsj+hr1qLt0BaDNsb4ZBOCsJfDUrMdEAIJYQ/QB4uIQA5
	 DHv29+PFa1WVbN1uzjE2Tdvd1JQmkoIwTMXlTJFJwT6YeVB+wHrftgdhKyMJ1ic+KW
	 Htlt5asO5XNP8kD5AGXsIGqWj1yDBIJUMq8qJkZIsNQV/ECmYLw1wZ1l+GkpCDW93q
	 lP+m397YyeEhvkmnHHN4z7C7ubHW9EJP/NLQE8I5R/8ijPcSDzejWSkkrfLzPIXlEa
	 siMUHXgtF6LBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 91279812B9;
	Sat, 17 Oct 2026 18:46:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3E28A1DE
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 18:46:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 24D14400DC
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 18:46:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 32j8xfYZbIqH for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 18:46:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5F9A5400D0
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::132e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792262792;
 b=mE6CVZkwXK2WxFLeYR6WIFAhCYf/vYfmQd9Cfua4VexW2lxByheKNu8sJmTOk3BaabR3
 FCCFFKyBiuJVrHvX/HZgYeqg4I3//6kz/IZSZXI4AU5YmnrY61yHAaQ13i1l90/S/vu9/
 7ve5q0mkzsGaIMPZzEYlNVzheAXzK4jz57T2V/BZb3Qs4V/TbJzBnUL1i/n/LFYWevp+s
 wIJFG3ta8Uw6tdkW3+shtE8b1AZn+MqZD7EkbQwr7GUc/AfmVLyIBNffaNKQqEqqPYfcB
 AcmO0vB89YqOqhboUoB/Xq4LGFuUzLG78nWPlIsI/ks5ocqoLxPMgJjqnEYn0OtlHug==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792262792;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=FWmm//3PTb7sLNylBdlYtxLLLEm6w0kpPs6X0UjlWxM=;
 b=n+7YWgVFj5q7n5rc7BPt2ITA0GL7B9Q8VNcHQIB2sy9BmfrHtHBECRunromXkiXGxDq3
 uDu/Qv2sm1a9fNP4mofyJb7zML/685aQbzr+H6Fv8oCA4oBjVXWx8u0VBZcSVZ9CxCrE8
 L9dFz+yvA3ovL+hfVxXHT2zuQjVW7hzyaGRckajG2s2a+XlI+mssiAE9htZg57uMGHsTu
 sHq+7x9jfngrPlcA1tx0d9EGX3SbTwsCI/yfoiNvHKT5qwleViN/zYZbpZUrYfn0w39JT
 DqXdJ03+mBXXr/BD1UfmB08doPVtkW5GiqpEeH5NzQWLDxrkw4JMlhYPhgqej2qzWtg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="ry/jEAPq"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::132e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::132e; helo=mail-dy1-x132e.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ry/jEAPq
Received: from mail-dy1-x132e.google.com (mail-dy1-x132e.google.com
 [IPv6:2607:f8b0:4864:20::132e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5F9A5400D0
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 18:46:31 +0000 (UTC)
Received: by mail-dy1-x132e.google.com with SMTP id
 5a478bee46e88-353804b591eso1476169eec.0
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 11:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792262791; x=1792867591;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FWmm//3PTb7sLNylBdlYtxLLLEm6w0kpPs6X0UjlWxM=;
 b=ry/jEAPqvQEt2o6un5ICtEgve1MV1dtTLleHLBY1gr72nYMaEQmuHzrd/BVd2pyb59
 MYuek/A4KHlC9R4p0HmnQmTgDfJO+1woCykMUR9NEn9BrFxFU3MJzHJDhrUO6bn/8uso
 D8O4ISlIsrTdlh2wsoP+VlL8ctraYKwIUJbb4FPLI8xBJmBSkTZGKL53hyhpt7NUMXx1
 c6koPnQclze0lZ+3OD41X06mQDsmUXY5hjcmybsTZxEVrtYl2Vm/ywlSM0URp7m0sLp6
 rmoczTyvN+oErCVeAwdP8QAj8HLUgNh9xahWVPKE/rgV7OMFCcstXjvmHPW/w2vIZ1/Z
 jAPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792262791; x=1792867591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FWmm//3PTb7sLNylBdlYtxLLLEm6w0kpPs6X0UjlWxM=;
 b=Ej4j9Da//vxvELtTvlMloV6dlkv/vxjJCXhrrMGo3NRgIyU5TK+vPJ7Xq3mN7sYbMV
 h6o2uZKy/VumssJ/VLKYmGZWTRVNCxz3EHfPqBoTjD97zR4U+dOoBXtlJHS4ySaGYwrC
 PYnRQ/vMAOfa2vZam1+S/22d7YQvWIof5Hx7hcqw0fzn1Br7jmZl1K5TPrVUq4dhFcED
 Ogb+eyQZW6DHX/dp94ig2/my1jG1NtHh6pX9kz4EB2WXLnlRQxQyi113Z35VysHoF+1Z
 9ypLaztdBoGqa7S4lamDp4xtTELVvvqGxYDsHZFKYi8DuSisqj2xTl41In5I3Cxg4AId
 ALRA==
X-Gm-Message-State: AFq9FYL22UFQn5Mj4YIOKX/f90dcaFOzky31rgbYHlMPCK9RSd9MR9+S
 +spUWo2+pmxgPfy3HYLNHeos0NsDbOQZeSQa5PanfaMnSIWOpfdxK2e5RtB2Or+P
X-Gm-Gg: AYBFou1QNKX0bAHQUWaOnwZF2kG0GVmiiFabSBc4gDg8kj5aaat/ah4Y5Cbf1NT9CcU
 FuYGRYs3R8cGS3Nb77znsxr5gnAo+wSj4hgAHxTwKjU6SP30dmbk/N5YfVMLQ19G7EOFTeNgLJo
 pLcs9lPMRpPzyL0GSDmT6v7W5PT4hjrbPBSNJWHXL+W0h+tZFz1Sio0OebfGavWx2IP2tUbAWoo
 eQiIHXnKy4F6JLn0N+aEIH5ruqNol0RqYe8carAt48xbEAeCB+/c6jGsUHCORKLqUOnAtI2reFd
 H/UsADf2N762CeDHEq+F1ChBkY++8edaDIF/2An/Ta6aLjy6vx7jvXXscEjekeSsE/wD/iQdpe7
 mHlWeio5555jaUXfPaUfzJBwgwsowG8WQYp481ltA20kTvn86Sie7tvxNzbFvs2f28MRraWET/o
 OSzbwUapbmhXFUM/F0UaAYb87xgSdbcAiA5idsAvH7+rbmyBlxrhSlZ8ybVIqGRHOFSwJVI+6qN
 ZqkIc1vICqhuX2Tp6uBNNsIKczkZ4aMdPc5d1mVrZAxj+Ceehn0KGFlV1RqAERBkh7k6UXQkWxO
 0HKWOVQ9/YG6X0n8zFf4VqB8bBYlmeIMFzfupctD9ehzZoIgO3HBng==
X-Received: by 2002:a05:701b:2807:b0:14a:d8fe:3390 with SMTP id
 a92af1059eb24-18512e25175mr4388791c88.32.1792262790741; 
 Sat, 17 Oct 2026 11:46:30 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-18314b1722asm17228401c88.1.2026.10.17.11.46.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 11:46:30 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: bmeng.cn@gmail.com, trini@konsulko.com, visitorckw@gmail.com,
 sjg@chromium.org, xypron.glpk@gmx.de
Subject: [PATCH v3 2/5] doc: virtio: List the supported device types
Date: Sun, 18 Oct 2026 02:46:19 +0800
Message-ID: <20261017184622.3925389-3-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261017184622.3925389-1-alan.tseng.cs@gmail.com>
References: <20261017184622.3925389-1-alan.tseng.cs@gmail.com>
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
devices. Turn it into a bulleted list, which is easier to extend, and
add the entropy, 9P and RTC devices. Also note that the virtio RTC
device needs QEMU v11.1.0 or later.

Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Reviewed-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes in v3:
- Retitle from "doc: virtio: Mention the RTC device", as the patch
  lists other devices too (Kuan-Wei)
- Turn the list of devices into a bulleted list (Kuan-Wei)
- Keep the Reviewed-by tags of Bin and Simon, as only the layout changed

 doc/develop/driver-model/virtio.rst | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/doc/develop/driver-model/virtio.rst b/doc/develop/driver-model/virtio.rst
index e5da9f430..7b2f31b3d 100644
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
-- 
2.43.0

