Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A7B1C79FB7
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 18:42:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E435940BEE;
	Wed,  9 Sep 2026 18:42:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6a5JdFlqRLtW; Wed,  9 Sep 2026 18:42:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4821D40BB6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788979342;
	b=SRHwb/TEAoNkXc8ASvTXK91gPUSQt5v6K462slvL37AJikyylGxFysLr3xviIaFlC+fw
	 EV+Nhrvbo1vj6ExeXSdlYVI9OqH6BAD1317OTyOi/Vo0s7P6uYl3w+K3VPH+AvitluAFj
	 o7SiaOqrsGQIFwKwy+C+/NYhkZaL4bAErcUdQFjGexXxrJfI/WUiM+gGbQBggTJh3ZBd/
	 cuOfXN4OdszaIxWmgGtZ+5OypoXzuuLEAXwql9lhwfNHbyZxLy0lpMFua+Js/LVeFonXz
	 awsRmC5o5brtVe2LkDmN1sOZG/sMBG/Mp2THbKJ9Z1c6YXbbqAXJI7LCL3TOyLTLbEw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788979342;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=jiwrssESYMvKtli/VRdmVVsAzKsAxqLeN62A8cTHgtg=;
	b=rwgp+EmiqqypRH6EBySXCdf4YOcQvKRI7UozzENMQwMpE1cDFVl8mBlGPYpg4qvW9Aty
	 jhqE4QGX9MxGK4/Tx59Ol03/HumhDt3cqejkBBOpKQVzqlcnUIOvpQGjTPU2h1c7h96MX
	 wKUnpBn27Qy25tO3oVIEIiWZw3ClDxnfMbKSI4fjltuzPS64bbI2mLzr4ui8q/LLTvgtw
	 /+2oqvH1s8TsnKXdvFmbS3XhQu+rgWWL1GmiGqaQEIlpIF4ZknhCfthVnogY0eM7Ptpt3
	 MR8JEXVcXU+1GY2hUyJYh1HuVb+Hu6ctF7JPW+z8NrH44KR6Q7Y+NqGWFC+rrAjQMnA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=R2rOa1H8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788979342;
	bh=jiwrssESYMvKtli/VRdmVVsAzKsAxqLeN62A8cTHgtg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FfW11J4neIO2AQ8nYTQciXIAdisNx0M+W/j9sDc8RI/N6boKm4kbj2ZFC5mjT6eQ/
	 VFnqf32ExYdxbphBvS1EbTjaWuHUuQ87rfvPniAk1xMYjveFZcLxxBLpVPYe50L1nf
	 QqnMKN33GPO2gnPX54Wblri/7P+ueM/WC3rQeBRn1tmSoBn4PalMrQUFi+JFtTOo9i
	 WpUaiMUR8Kd3zOw/C1zb1ItVdq5Pupvl9J0lxAkLVvkYVUw8PvxQyiFNWRSfFcgAjp
	 NGpV6k9lgRSH9eKHsnufPjUB35TbJmZWdw2lxuYdTnU8VhA0soqm+VJGxDxiuBhnDQ
	 YqVGkbK6OYoBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4821D40BB6;
	Wed,  9 Sep 2026 18:42:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 60D7B528
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 18:32:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 49A1E40BAB
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 18:32:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id txVL-6UeEp_x for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 18:32:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 67B9440AAD
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::433"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788978754;
 b=rYMgd2/jtM3wAMB7mYvQoLmnNLkqSmrrFgR6WMk/U3FtJ98xs4uR+uGmQzd74lQsptyG
 6VOCDzGeeAagaYFUXA2SGw2hUhc7GCcTLL+OO9XOScqt0hiZEV3HUTNZb12sN1UpiWdFP
 YNIhYBEBq/v7TiHnt8++vsKBVjcLzdailN6SK02eV7jTHyH+MXDZIvGhoqc05ZYlMaEzw
 MZDpG/iLKVaDyYpYbqwhKEGbYneX2G4S8jHl5RCpi+BwUVTc+13rrWKhCLQuFFQAtlwct
 nmmUd2tKCI1P2Vnu7dPnu2okmTEjgJ1+b24118gZfIE79dsbeaHx+bJF6LgBHbpr08g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788978754;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=jiwrssESYMvKtli/VRdmVVsAzKsAxqLeN62A8cTHgtg=;
 b=euaRoCDhWzQ2kq6mwgIwJL73uUEDmGW8lTALXyJBclC+yk/BnlsBHnQRW2upUzvm681R
 5msiSz1wXhoc5XFvDoPYME+dWqggYWV8iG8dFjtdf+4so9jOMzqANZ4hS2glUI/I2ni4t
 X7LL1b/DvuC9DPJH+IEWunR93zMJBwFXn7yf+N1ej9+PxBDpx+r73JOk+P8/f57Y+VO3y
 NPpvpy18m4cCMo9Z4pFVpCnzfifyN3j+SNL54TjtO9PvvJMeZEiWxOR3VXZN0zzaKVNDi
 GJSCHFJeb9VpMWHvlqps/I+mvrzx6Mi+ucHtmL9ufQfNviJBUO2yLKoIwQ6eo0ZhWrQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=R2rOa1H8; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::433"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com;
 envelope-from=petr.vorel@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=R2rOa1H8
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 67B9440AAD
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 18:32:33 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4843f205a5bso4147144f8f.1
 for <u-boot@lists.u-boot-project.org>; Wed, 09 Sep 2026 11:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788978752; x=1789583552;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jiwrssESYMvKtli/VRdmVVsAzKsAxqLeN62A8cTHgtg=;
 b=R2rOa1H8lA3zbpWxWs6YApKofhy1vFy9v3DTZ892qZn1xPNFiFTtjhdSXTjmtXkrW5
 MUAnstR2155t3n2hnLaM4UlhciFGBDXUvnooCquZUDyGDGqbEtM5LH+5hGo2TtWSvntY
 N5oyIgvQWmHyNKk/Q6POuuzW4kwRHMekQHziwV1mpjBMSbMFy4E7W54uK9ctPtmkBQP+
 5AFZsBwHdNfoQSA4NQQhSIkKA8XHbimVxnZgjBbWWkpKhcUByYvEckHBFQ0HA62KdT9T
 cQ1zwqwwjgrJvPj0DH1cyYiO38lYcxquBQnsmiC1BwFFoRwgR9nv1mK1CO3Ds4YxnLiF
 A16w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788978752; x=1789583552;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jiwrssESYMvKtli/VRdmVVsAzKsAxqLeN62A8cTHgtg=;
 b=NB31TkIW8Vdp44fDVB5X4JHz34nxaQ3+MOT/LuCSFcmOVfA9hye2jT0zbNAyeUXmYb
 NZxywjyLrs/QTmT72aJvf6tgy8JNBVbUx9+8mhDf3XGtCo7YXM4cHh+lGS4lrVQC4I4F
 HCq80hYUDiIkmSZttzcJju3Cgy8PoGLS455CfLam5pH/PhpN+oBQYqs1k1dRPIrmM4Se
 IAQVM02/cUxPNPpj3C+nDifRBq5ORkbExHNTbhMXp9nZ2Rqud8CxsYRobJsq6GXFv2nB
 8gN90r5xg3U9TN1Ic2E2QnwSBsXIbhufyWclxBRIE9wn+pdFwSEcrQyCwgyacILT5wYu
 /8yw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwYPQDJUMKYpvbsPR0vve3zk6UYHX1VkvFW5jDoopECYPBHaHO2Nl+pXPL2cpZxpir04hLZEl4=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nqe5EphGRrKaTouUhxtR2LWcAjT6PNbqqYxZhY8n3N3GaYt3Yh
 aXtX0PxYYCjFpLfBuXtVgpcFfUOTxv49pZKqRdi4Wh/R/IITr4gMyROA
X-Gm-Gg: AYBFou3hQgkQuAQImcxztQrC3GpnFeyA51pla1Zi+KmIGMgxdTFV8AREpYC2iJp+O21
 oWntt0NxX1mWbeR0zG4W92v0hisZeiS0NRVR55nadGsRZfxTid9jcv1fxKxS8KvVxCF9uJrUej6
 FnAvme1TV+xXpNy8PnTQ2PenziHvlxwg0VlUSPwI6Tor8vAWrRM2CEhldzQx91WBwBwnSx3X1xk
 jLBHpi5ES/5FYFIXsTXD6iqDWi2frwBXysxwe5hd4hRX+vNHlaFL20WV1XUNd6y3S/sDRXCZOm+
 kUxF569kuqWlM0GFyLcoOxU/NPmNlVkzTgoH3j2/0VLpHHmaitFkzVDR4SXii/XJbOXS5AZm0s+
 z4Q+DJ0mL5di9YbB2xVuoM8DKgnU8X0WEm0A7HU6VdZXJyy4vMnaP8rixUioWMPXBN5oYR0KPNw
 AeGftdqmp+t7z5ISDA6UVPOoMSg//ngVG7lldmxYGFYUzho/alUhG+n2gH+IAr3PG1vcDVIE+wd
 4JF1s6DISOYpSLncckwr24bgl4Wiv65rmlL71Me3bx3
X-Received: by 2002:a05:6000:25c7:b0:485:8a46:b3ba with SMTP id
 ffacd0b85a97d-4858a46b4edmr40216832f8f.34.1788978751866; 
 Wed, 09 Sep 2026 11:32:31 -0700 (PDT)
Received: from x230 (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885b1320sm44359708f8f.27.2026.09.09.11.32.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 11:32:29 -0700 (PDT)
From: Petr Vorel <petr.vorel@gmail.com>
To: u-boot-qcom@groups.io
Cc: Petr Vorel <petr.vorel@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH 1/1] doc: board/qualcomm: Fix kconfig formatting
Date: Wed,  9 Sep 2026 20:32:22 +0200
Message-ID: <20260909183222.220855-1-petr.vorel@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 09 Sep 2026 18:42:21 +0000
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

Fixes: d9252fcde12 ("doc: board/qualcomm: document generic targets")
Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 doc/board/qualcomm/debugging.rst | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/doc/board/qualcomm/debugging.rst b/doc/board/qualcomm/debugging.rst
index 42821f6546c..fb6b0d397e4 100644
--- a/doc/board/qualcomm/debugging.rst
+++ b/doc/board/qualcomm/debugging.rst
@@ -18,6 +18,8 @@ Newer boards (SDM845 and newer, those with GENI SE UART)
 
 Open ``configs/qcom_defconfig`` and add the following snippet to the bottom:
 
+.. code-block:: kconfig
+
 	CONFIG_BAUDRATE=115200
 
 	# Uncomment to enable UART pre-relocation
@@ -42,6 +44,8 @@ Older boards (db410c and db820c)
 
 Open ``configs/dragonboard<BOARD>_defconfig``
 
+.. code-block:: kconfig
+
 	CONFIG_DEBUG_UART=y
 	CONFIG_DEBUG_UART_ANNOUNCE=y
 	# db410c - 0x78b0000
@@ -56,4 +60,3 @@ Open ``configs/dragonboard<BOARD>_defconfig``
 	CONFIG_LOG_MAX_LEVEL=9
 	CONFIG_LOG_DEFAULT_LEVEL=9
 	CONFIG_LOGLEVEL=9
-
-- 
2.53.0

