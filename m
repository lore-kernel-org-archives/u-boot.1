Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88C8606A31C
	for <u-boot@archiver.kernel.org>; Sun,  8 Nov 2026 23:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dSvgv85L;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hJG4lRTC
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 99D3880E29;
	Sun,  8 Nov 2026 23:34:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k1Ef1Z478z_m; Sun,  8 Nov 2026 23:34:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C5C7A80E13
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794180860;
	b=Lbc7ApSEGaH/3KifguXY53L7GSo+Xe4SPWVtSOxLz6vXEn7rlPgRIprcBYJJbHU6jRYw
	 uwqPOHJwMWtTmqZNc6+uSyGXnXDulavyAcpzh/q5pVjRqpganiMNbA9Jx01Br5jNKihJ3
	 A1RYsPLxVRl0pdIAvc5uNNFXx3DS2l3JVL5Q96TBcBCErAecxt/FdzZDMS9uGcf4lNrfH
	 YVdUsaGtnczkx/H/lH8b0kPQ/J85L+QtFuTziHLB3ZLjdDvEcKMkjw90NuWfj6q3yc6xO
	 MZLQQ19nft3uQ4MvOTMzLrSMmy4KfpLxs+sR0KwTflUThZSWd/tDLXFr+j3JrXeP4Hg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794180860;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=oveu8/eAYn6zrHg5uWi7YUA3ileeOE4pfwvH1zH8ic4=;
	b=OraPPOnQhSTliFyqZGCHQsIA2F0lv+ub2ymKfSIMzQfjcCMRsauAo5O10ltc8FJo0zIh
	 T1xggglydsWoB0lcc9UnGm3hEkoXap58s3QUqOxKmICVtYfcgXZpNcz5rMvl+yJIPoZTJ
	 5wuCmNMevSbeaa9hHjkLJG9BEJS2IEJAmuSbSpcjOtiHHZpiMSLGzznKGtWcyue/7d8ah
	 3Ti/I18NjyOf8HFR4AvYIZxL2mUY8fUlKxQWnSaBd5B7b4Mw7tWVuFvq1XvsO7t1jnRYa
	 aOG5/xq32JnOU+tJgAthb4UeMQ0kyIP+zitVZG16PHkLCdZZG+++GnqmcQ176uyT3wg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794180859;
	bh=oveu8/eAYn6zrHg5uWi7YUA3ileeOE4pfwvH1zH8ic4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dSvgv85LvZDsez3gnxCYtXSiGsT7qvuCjIcFZsKnQy3HFvkw1xftMKhHbuJIj1Ljs
	 P957pUW9TtG4nK/Iwtk6enEsAF9t6kPClxf6VAeRx1uXAZMW+0//DV+xTIgpp8z709
	 zVguK8VdsdAVj+kzhRvbw76cQOVYzaIR5gB0O7NNvx6FOjjJ1foYDTcyj3pGyD8UCu
	 lUlh+mSmqyQbWBNTwxQLexD0sYb25NVe3i6Bo/s1OA4vp5moQDMb8KGiqchHqPx3q4
	 iXyVu7AxV+Xxc0VFL5A2DWtJz6QYsy9n0cgM2zy1CCwn/xRd10u6BlBY/8awwCdwOS
	 60HLOG6SLtYlA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C5C7A80E13;
	Sun,  8 Nov 2026 23:34:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id CBA3C932
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 23:34:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BB86E6070F
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 23:34:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MhS6b2g44-SW for <u-boot@lists.u-boot-project.org>;
 Sun,  8 Nov 2026 23:34:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3EF426066E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1229"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1229; helo=mail-dl1-x1229.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=hJG4lRTC
Received: from mail-dl1-x1229.google.com (mail-dl1-x1229.google.com
 [IPv6:2607:f8b0:4864:20::1229])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3EF426066E
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 23:34:15 +0000 (UTC)
Received: by mail-dl1-x1229.google.com with SMTP id
 a92af1059eb24-1a2af4c8d00so744763c88.0
 for <u-boot@lists.u-boot-project.org>; Sun, 08 Nov 2026 15:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794180855; x=1794785655;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oveu8/eAYn6zrHg5uWi7YUA3ileeOE4pfwvH1zH8ic4=;
 b=hJG4lRTCoMnBKzQFKtDnuj7pZDi+NnhrLef7eHFQWyLqsRu76FCUcyEwYr3Atui9eX
 qq7PhJ1N/AgFZ19Lxqw9dAthpGhbsdsvuNR8L16hhHIMYITDsMv1hyJ2Y/4j2O61sHPO
 jeEG/b/HFpbIyWXh8aderkO2hGu0ZhqeZfWdmfPAIrSvwLzu1LfObzft8enE5zW7kyXX
 jjjrUyJCxH+orElAhYwcMwuHd68qNSpkkRRhR++TadPt0seMVaVpUvdl5/a0hnw+SryT
 EM/oVeK6/XgtRqgoHNkxw0yePRJ7WnDZ19AEuDqy1VF60pPPpCIRx7oCr70t+kbfr1Sw
 RJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794180855; x=1794785655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oveu8/eAYn6zrHg5uWi7YUA3ileeOE4pfwvH1zH8ic4=;
 b=yW8n29dwfFdLp3BHbC0wpLf6OBFJsajcrN9owE9R0kSrlVMnx9wQbanQ3A8wB6cIWW
 ixs6TsFn1ve7EfN0hdECQ3/ykV5h85fNDWNqcZl87GDNflXosSqStEc15m6WqlAFXc0d
 nciOtiEWn8dR2fQdATrInAXRk8yOnNdpEpoDIDNDatimr5zJxnHYBNKmsUlXjZLVe0nN
 a5/+Yw206SVEdC+rCfDNvn0hjj+XEVVu5xnhoTu7IE88j65EXYRrm7ERlpRxg1RxR0on
 bO0pGWjPiPbpDBh9eP/uqFBN7qmJOrmZLUCnL4Zq83KwucR1SjWLJCMZO3xyocVm4Dkb
 wH9Q==
X-Gm-Message-State: APuU4Z9DpRpH4t0lVZVdB2yH3owjYgGLEDHNog1lRHxmJxUpA8pPzbr/
 Lc1lbqTzgTEtg1Hlb4A8o7nss6eiS7okOhsXCGPeCMLM/T7hWxlrJ6JdMgLPTQMs
X-Gm-Gg: AYBFou2kuX+L43aO64HhWLj3cCPClFpRRnyLp9nbe5Gr5FFeWkRgJUFLDx+OFUFCNo9
 ztVxDzILMXKWQFKb6VxGXZouXDvf/GIYLkY5+83zvv3A40dbREjECpmhuPKNTPveU7tvZ4nrYp7
 7EPNhMsuavvEvWWNZh1TJJ1XcMtCGUP8nxzabk6mtT+1C6qnGW3Lrq71GnEBfFkbgliYqqayAUH
 cck3z93e77yv47dOZfDjI9TT5oGS4UnJKrco4JGNatF6w05ebJIsMqFKjQrMIARdF5we/Cd7bXq
 WVmU+6prXyK9zmciuZY6oEWBAwVJ5arPeD0O+gr1D3fcK558l4oURseIzCWZc8f1EbeNwQ7Mtkj
 Zx6h4NlnZvoZ49gOBq2tfjzb8iw4Vjq2To3Y6RiZ+l4kvONz4kkr9f4osQTzb/JusfRMAPYJrLL
 cQ0kHCLnW1qAemH2gwZA3mPw8/LTPbXk4i9Lq8oEiYV8frhAOtOubecMin3Oi0BLbkTUaq9Xj4q
 naPkcrdyqT+1HlQp2EE+uTfsGiuAEq6JZJNA+PUtzDuMgocGaliaPikLvVIg4gpd3ZcdGDJarYp
 OJwacBtd//kbjxBnJqU5zr4CjJZtC0fxfuD3zpzQ+Oa0Xn+fLFN1OBqneY3oF9R3fMgAOmEzcPb
 dqlgYBtUdknIA1ckZyOLW120jkMZggbImfVAk6PXK3u1GDuAKK9HEZ1wZ/6U8F5SDlGhY6Skyo4
 wYrARNLNxz
X-Received: by 2002:a05:7022:ea8e:b0:190:f24b:9491 with SMTP id
 a92af1059eb24-1b39fecbdc1mr4307322c88.12.1794180854648; 
 Sun, 08 Nov 2026 15:34:14 -0800 (PST)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b3771eccb9sm7221006c88.19.2026.11.08.15.34.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 15:34:14 -0800 (PST)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: bmeng.cn@gmail.com, bin.meng@processmission.com, trini@konsulko.com,
 visitorckw@gmail.com, sjg@chromium.org, xypron.glpk@gmx.de
Subject: [PATCH v7 2/6] doc: virtio: List the supported device types
Date: Mon,  9 Nov 2026 07:34:02 +0800
Message-ID: <20261108233410.1556875-2-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793836645.git.alan.tseng.cs@gmail.com>
References: <cover.1793836645.git.alan.tseng.cs@gmail.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
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

