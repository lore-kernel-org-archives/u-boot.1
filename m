Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48152C5DF7D
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 20:07:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0EF24812BB;
	Fri, 21 Aug 2026 20:07:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ag8qTb5CeMsB; Fri, 21 Aug 2026 20:07:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787342852;
	bh=RuSffF5Qh8exsRff2z6InZwpWQ7gbMYMDn9S4tFGs+c=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=psHk/QIotzP7DsQNOUW23jG8WokNBuzUMuCeo7xbfC7imv4Wjb3vmKI81HdDp/6Gk
	 DZEGKYc+XTKoGjopYYM0nvyE4OCxaZwXEqIQEVbof++YsUcyIoWxZejox+C8QiBSN7
	 3TGScZvS1nNo3SYzn/wD5KLzY8UAB/a18Q5z93kqjBtr4d7AdFqd+5Y3XZOGrrwJzr
	 Jt/PpO6wsaikGkdYh+sNX6on9j6e/E0svjgrklyzihupNTHSje6A3YuL/scYgNctYO
	 UTTkgDXXHV/gSwYN3yv56NKeAay0qZ3hXnltLl0sXUlbb6NPrRP19Zc37fN6+KQY/u
	 5o1pGipCIWMiw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F2E9F812B5;
	Fri, 21 Aug 2026 20:07:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9831D4B8
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 20:07:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8372960A96
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 20:07:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GluNAppcr5QS for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 20:07:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::32; helo=mail-oa1-x32.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Xil9fFYW
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C01AA60A87
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 20:07:29 +0000 (UTC)
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-4563ac048f4so1327538fac.0
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 13:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787342848; x=1787947648;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RuSffF5Qh8exsRff2z6InZwpWQ7gbMYMDn9S4tFGs+c=;
 b=Xil9fFYWXuGB/Vh9uQ9SmVmFE7+f0EJ68hlraCfM+RtSBSytpaetQ/SrQsPbwZXgBX
 3ElOgzmDIc/8EPYV4EI4CgaBq+/7Fbr0teHO1T3v7JudKXq7HkaChFVXeBKV2jy9HpOO
 +cUD7a7qpu5EOUAQAa9E+lzbhzpF/GkBnuNG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787342848; x=1787947648;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RuSffF5Qh8exsRff2z6InZwpWQ7gbMYMDn9S4tFGs+c=;
 b=XhDuDBxOEoKMQgAstj05M1z6Iz7aKFmxV0s7cOSGGDzlH2cMtQ0yKhiJ0JWKfcYAQ8
 lIAXzjZyf9/BzGlxDEdYPweHiKyzmZSWUbMfTfJ2T4oPsRuqL9HPQB2M4pHQp4YAIIqU
 mo5A//T9M0xq7GzAkiBrmfPyb2bH/r+Y0OjSsH6CGnOaWb25UU7GmkjvAgwPPf5kSkTt
 YByv5QOKjfwevMRdegs2j7zt4sXBvewbDaMtuXBj56WSWBEEyRqk2Y3/4G/emPdnPJ9O
 f7MYYvA3gRwHZMMi/Y2bST041AYX0FcSZzWofp/plhSku5Q0+cOVdQ1FoTXfCheY7u30
 Iv/w==
X-Gm-Message-State: AFuF++m8WmvGNUW79gTFeW3i3/51lrv6YQYfsB3wfT4GgPfwRy91ZwI+
 Ofe52vegwHXB/P1MrqcQTkq/uVtyeITgfhQmPhy1+WzPz2P9gb3/hLMhrKu8CE+mBOF9opbrmhR
 z0u3ZlfCBLvxy
X-Gm-Gg: AR+sD12/fMq0b2nPHgc0QTCA4lD5k/ZH/L4DSw836GnQhsMcOQiZ97weS1USpkpiE9O
 J/JWhoOpkSOr6eOXFzvgUpVSaT+l+Muf2YdjQZyrb9KyN3fhv0ymVElaA6De28p+avtZBCSpRBg
 xEXtpFT+ao3mkyfKeISjtrMp8J9qoE6K4i2eXMGwpqv+ybTgk5IU5Z6Jp0D5JA85t196HJ6iplF
 5u+xPC2EQ98xNxQC9i1aoZic/u3/ETo1ruFdb2nVsHg/NV9MsGJUlJImKVDQ4wpIJlO1Y1otvKd
 NUNXhlkZNGNoM3EDcmFxyGu51hMZVtDBCTTjyFyeQ+rYlV23xYBoye5SJ+tGMBXesE+ohj8xW4Z
 ygPd4m86oNOx+MmY4g4K3h+soCNLeZ/i+DxkDDdQqZ/USaajc1aaIbLzijHdsfjkJoz8pJG+vpM
 UMthceF2nlqnZ/xZWoFESCFswNGcg7/L1HWxhoSLil27oSrv2UbvM1BBJOwTqNlYn0f6J+4iQX0
 197vAiJRkmGU18tapNQsz5ww20JxuQPVqqqMrNAclzvm+xUQTWgZAz0F74WqG51jwBf3ap4I0cY
 ZSygp+0P48aQLfRFRtE3RQgQDI4acemQJQ==
X-Received: by 2002:a05:6870:46a9:b0:409:5241:8abc with SMTP id
 586e51a60fabf-463515d6c1amr9744682fac.20.1787342848481; 
 Fri, 21 Aug 2026 13:07:28 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-463831b4f5bsm296436fac.7.2026.08.21.13.07.27
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 13:07:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Subject: [PATCH] MAINTAINERS: Drop reference to non-existent
 drivers/sysinfo/gxp.h
Date: Fri, 21 Aug 2026 14:07:26 -0600
Message-ID: <20260821200726.3903737-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

The file in question was never added when the driver was added, and
isn't required. Remove this line.

Fixes: d44c3a7bca77 ("sysinfo: add HPE GXP sysinfo driver")
Signed-off-by: Tom Rini <trini@konsulko.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 451958ec1145..f5ec830e4a33 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -340,7 +340,6 @@ F:	configs/gxp_defconfig
 F:	doc/device-tree-bindings/spi/hpe,gxp-spi.yaml
 F:	drivers/misc/gxp_eeprom.c
 F:	drivers/sysinfo/gxp.c
-F:	drivers/sysinfo/gxp.h
 F:	drivers/timer/gxp-timer.c
 F:	drivers/spi/gxp_spi.c
 
-- 
2.43.0

