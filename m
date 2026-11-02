Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03C3606A327
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 03:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ETWEr2eh;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PgZxlazr
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AAB8160705;
	Mon,  2 Nov 2026 03:05:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0yDA8VObduh2; Mon,  2 Nov 2026 03:05:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CA3A860769
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793588703;
	b=ceRUPdrl5cc3s6WlVk62ZdjIbhHcmTnisvQ+M9RKG9dv4LlPPwX3iYA5nNge7SO/sDya
	 wAE47nVDq/tDTCXiUQQevg0hHF4PaMCsxx0tBpB+Gm+BnxxN9u4XfQalpls/vvWF57Dve
	 /nbbqLKzqn4NnN6VbHfuraQPJKkDhn6IIY2acSKdLhNMvkWE8LCOr0ltLCTgFKUDNTtUQ
	 ntepjKAJcHgSDa8goYEd6QiJAuV6yPtZbDPlloMc4JCgY8KOp2zg0N7E6pmSx5g4VW8Xs
	 QBqsBdeU6UjBjGm0yXHfOwzGIP6zVvPEGUVGgi3QoQ3mghMudfm/ZO1eMs9TO4gMIBw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793588703;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=b1kLaL0pMKNK6dZKHhBr+W57+LUnRECBn06H0tS/2V0=;
	b=BolIGUrKhUQXYK/J0D3AoKWflBvz6wevQ4PP9kpmrO+Fu3gvaS6wOVGndgBEpedhbLjK
	 kIGP9+RLyqwR9FXoG4rrv9NItgPHEvYQ2dh6eYIfwQmBlAeBE9j0BkIgyTLVCzQawBKjg
	 62FCjuAOB3OiLcZgmY4oe33M/oYJGwE/xPGr2+c6vjcoY5bhPNLgK48wR/5wC+RmeTKs2
	 f2DfPAXVrSqb9zxNtJZJSc1IttieHoAq3jiwuLWYCqj8G94Ous6yRwFGQ9BoJaooGSm8u
	 MLep1KngLvrBjsKrNJMazg+IYxV3Zvfh4TS1oxe6G7QfexcER5YEuF2fB4QXVp2RaCQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793588703;
	bh=b1kLaL0pMKNK6dZKHhBr+W57+LUnRECBn06H0tS/2V0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ETWEr2ehbBTIlvptW/00NT++0Q5cXnpm2RBDc8G2Jrm5PSUdnCoiWtF3N1al8t9M5
	 L7H1PMoM6tzS35EfspNXJx1SNjpMvGFvNBjSsWsfGcNV5onBAJR7pAuFxl+oOpZAuO
	 RN10C6TOcEoO2q6G3alhJWjTJnZX4olACebO07XjTucjNrL7ME1rkHli7BVtkXCwlJ
	 ap1ZHCe4iENzLgv7uiNXQEDKe4cRHbCkokaXZuTZpon7Q84gflmSEQg7at+fGWfqUe
	 U0zOapRPe4NABG82Ko2CcLYrIByFs333DhoQkMC7T8dBJXV5cC4O5lNUjj6hMc5ZsA
	 cJ4C6stgD3Mxw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CA3A860769;
	Mon,  2 Nov 2026 03:05:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A97A1323
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 03:04:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8F38A405E2
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 03:04:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3020duwyCVOM for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 03:04:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E8E3440508
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::52b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793588699;
 b=rRPxI8ozWFTXQ7Zahpw0hKR/WA6sDURzdb7DRhpklH4SmFEjgaDYjPyAdmqO93qcbPZV
 7N/FEoWeDzEZgg6G32gHAZfxOds2M5IA0lyoe07ti6nxS7lPGeJcPp6tjpVB75uSlYpUh
 EVviR39SdivU6/ySh6y4wUS+TYLS2C2Q4PqLr41HG3eGKiLealn3K0jyFoMOyTy+4qyZ4
 FUotM0RcEFwpEt3Olw6z6cAnzHRfhgawfBVLlkYhKv60G2YWi6G69B8TosSPO60QaLYaN
 3KD5kklTFxOeDlM+M9zreyM3OKFydCa+m5cMLWJGpbi8xhkJqiTglqCEMj5Na3WluJA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793588699;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=b1kLaL0pMKNK6dZKHhBr+W57+LUnRECBn06H0tS/2V0=;
 b=bp1QjserrWZvaX6FcIcLDnnpci7zuVHEYv8bvf8A+i+dGJnJZCBGReKO3SS4T8rtAG3y
 +HB+ry9xtWexlkQ1jvQceSVOvEHHg2I0DSXYaLq1WgLg0gK1hVZwdkYEY/ir2MlF4fVi8
 oNEiGyNVryIouCUkYG+VSmBGw+PMF3pdMPMv385Atw8M+iIJLx8LLRF1boF5VpsG0OaLU
 dD6TILe7r9Q389WKBR27+S6Z2DW5NH9xeSX1sniP21DGiIHolxqYWx27spJz1nClQb20u
 LMhAtx1eOkZ7xWIGHdLtuMcGg184L4jmBA68aEjnJT2yexJAb21pKP6/Q0mZiukVLEg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=PgZxlazr; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::52b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=PgZxlazr
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E8E3440508
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 03:04:58 +0000 (UTC)
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-cdb15cd8558so397593a12.2
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 19:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793588698; x=1794193498;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b1kLaL0pMKNK6dZKHhBr+W57+LUnRECBn06H0tS/2V0=;
 b=PgZxlazrzIfdqx6BqQcJ10Sgo5+mEJSv0D+angaVYy3gPvGcv3RD2ljG4qv199d8Z1
 OQqoyV3fxtSJJIy6d8/v5rqSGPlcbvwyUp9uzlZnNtZ9I8M61y1/eDbEaLAf9AvIE76d
 1lbdz/58BiudEUHv+K2YR4iDHdcBISgTvYvBunrbnHwljXL4EL0oZMZUauB05FGDkBB5
 YvuCE2u4zPmuxihHWLwBb4dKJZvljgB3LNAzCIvhEWlPAAZ8G86LRrG58fHRqUMD7/Xz
 6mbcM6zuC/3X7Cc64s6T08dM0N3MGc/7G6OHGsyqpxUfvdAwXjKWrG/R8H6cBdnioKSX
 CtHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793588698; x=1794193498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=b1kLaL0pMKNK6dZKHhBr+W57+LUnRECBn06H0tS/2V0=;
 b=EWJk3mESNATaDfgbpTBabw3FD8jzWgk9ZF2wa4M7MYdvRf910IYwg+QHxvAxXdGCHV
 DCGyVmF8KS0D3NkCIyOLnXEIbeQ7myFpNto07qbyosLxTEiaS4uKTQNOwZ7fUsIeq/dA
 QLmTLDLDJBHekyBQHJwQ9JAzPlMCSMzeoiAgGtk9/KCn3kCpSu125Ovblu+X8LdDtY9D
 unhGfdnz0KVi7IfqfzhSXzbNgEFKMskDgJ4cRRast9d8rIGUR+y+0+lEFrhV+VAKD+qj
 1ILkZc+96XGFyW2fESMQmo2WIJV8yUczC+FfURlrB3exdSo/tDhg8rd8Lfef7LjyH6QE
 vFOg==
X-Gm-Message-State: APuU4Z9f+d19cPvGFZ/7w/G/N0MSXVFR1zbkF0fU/X9XFLks7BwkOg9f
 THFUHOeUqftKzf4LS/XeXEBF51aF2KHEa3mpxQk1goCErCSFJpr9BRRC95R3a5Ek
X-Gm-Gg: AYBFou0LJiUBUMsgFTr22bq/wtk2V48Hmp4osq1W3OhtB7CjNt9TVwaGtWzo3IGhOHH
 haggdlHt+yMwzLmFeC9rBygJdEcU94UYbAhsMK4SiDWs01dk6yQvp+Gt5t0n521meHsIwhwz3Vm
 AAnJC2e17FHfx3yDi3YQk5UxST2TgAbaUbMFt8uLKGSW4mGbHgJFbokhg+sBSowD0syiJdee5iY
 4O9k90dywAVith2VQXE8KwHwPEgW7QPxv7DoEq+MEVdWsDd8pH55kmksRvfSGGMIttXLp3nhi0V
 kH5ZnWxzDQEnmCL02DGfj4BPO6VaeDOjIAV7sXJaajHEdwcOtoC5N65+AdDJG+nrsjMvt6W4qpn
 x3Z+I6f1zK3tuEQDtQpKwWanVw/wXEwVBrYUrtTnFhmO/WP7EPS2MfzrkIroTiBkM7yTI+/5HZ4
 SDKZbRAFBm+Xi/8r0WxttDNfitRQmAX68tW3cKuVncIvN0O24iWM9sezJX2GnCYQkgYk+YGmXJg
 0Q6w3Q5lS68WYHJLIRCCgZqK+FMu0zF+5854E5y9Xd1WYp1fUm4MXin1SaKSL48/ruu8sOWUb07
 Wn3pF2kfwubx12qbdJiJ5cdsLuy92zDuLKE4UPUIw8ds7lGOgqwt/2bIaVbavV5Obwbkds+slB2
 lA53VK5QB9An694mGMDMsOXRBWbK/fNAVGDWsDcW+mYntOUCpy5+/XYh2PUKXu1mBqrAfhfXrpD
 sNWIBo9PPw
X-Received: by 2002:a17:90b:51cf:b0:3ad:818f:3da2 with SMTP id
 98e67ed59e1d1-3ae8982cc41mr6161869a91.63.1793588698016; 
 Sun, 01 Nov 2026 19:04:58 -0800 (PST)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae845432e4sm11995159a91.3.2026.11.01.19.04.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 19:04:57 -0800 (PST)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: bmeng.cn@gmail.com, trini@konsulko.com, visitorckw@gmail.com,
 sjg@chromium.org, xypron.glpk@gmx.de
Subject: [PATCH v6 6/6] doc: virtio: Explain how to reach the virtio RTC
Date: Mon,  2 Nov 2026 11:04:42 +0800
Message-ID: <80c59fb264f9f2c8b325bd792f0a20c172394e59.1793588058.git.alan.tseng.cs@gmail.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The date command only uses RTC sequence 0. On the QEMU ARM, RISC-V and
x86 machines that is the PL031, Goldfish or MC146818 RTC, so date never
reads the virtio RTC unless that driver is disabled. rtc dev does not
help, as rtc read reads raw registers, which the virtio RTC does not
have.

Give the virtio RTC its own section and say this there, along with the
QEMU version it needs and that x86 needs DM_RTC.

Suggested-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
---
 doc/develop/driver-model/virtio.rst | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/doc/develop/driver-model/virtio.rst b/doc/develop/driver-model/virtio.rst
index 30df0e944..b9f05f3ae 100644
--- a/doc/develop/driver-model/virtio.rst
+++ b/doc/develop/driver-model/virtio.rst
@@ -78,8 +78,19 @@ Requirements
 ------------
 It is required that QEMU v2.5.0+ should be used to test U-Boot VirtIO support
 on QEMU ARM and x86, and v2.12.0+ on QEMU RISC-V.
+
+VirtIO RTC
+----------
 The VirtIO RTC device (``-device virtio-rtc-pci`` or
-``-device virtio-rtc-device``) requires QEMU v11.1.0+.
+``-device virtio-rtc-device``) requires QEMU v11.1.0+. The driver needs
+``CONFIG_DM_RTC``, which QEMU x86 does not enable by default.
+
+The ``date`` command only uses RTC sequence 0. The QEMU ARM, RISC-V and x86
+machines also have a PL031, Goldfish or MC146818 RTC, which gets sequence 0,
+so ``date`` reads the VirtIO RTC only if ``CONFIG_RTC_PL031``,
+``CONFIG_RTC_GOLDFISH`` or ``CONFIG_RTC_MC146818`` is disabled.
+``dm uclass rtc`` shows the sequence numbers. ``rtc dev`` does not help, as
+``rtc read`` reads raw registers, which the VirtIO RTC does not have.
 
 Testing
 -------
-- 
2.43.0

