Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13037C5AC7A
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 11:25:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D2D2260905;
	Fri,  7 Aug 2026 11:25:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X6pQTC81lr0U; Fri,  7 Aug 2026 11:25:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 03443606E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786101952;
	bh=HeAiBMPw/OTvdin5k479Kp5Yscj3g+KePLvty73Pu4Y=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tzi+9QdfIxVHDviqkqXRfIM4okDeLSWefsJW/fEG3ZXtMZZJU2QvXcNLnU4jcjcao
	 TkI2DbAcHwh9QacoAHixoTs4M1nNGwyaPkZXkUghl0PZB5TKhp8REWE8nqBZqAeIY3
	 y7cQRjiE3mPUonsDhTz2VVcNtkX2j+jOksra4PXPPd97cW9n9brKHM1DVr83UOtuSS
	 o56zxUFFHnMokq3XoYgu5zOiscxeI49blwOZgaL2CebI6arR28PNH8HP6p/0uRY5tm
	 PPkO+9X9sqPd6Q8TkuqqRfbh7k/28G0fqw4lPe1aqS2X/IOz94N/tCGEwRwSEgy69S
	 GDA2jVks5SkEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 03443606E3;
	Fri,  7 Aug 2026 11:25:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 364EA10E
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 11:25:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0FE7C606E3
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 11:25:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tJ6cfJjcdidd for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 11:25:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 9E06E605FA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9E06E605FA
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9E06E605FA
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 11:25:49 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-496bb7cdf51so37879115e9.2
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 04:25:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786101947; x=1786706747;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HeAiBMPw/OTvdin5k479Kp5Yscj3g+KePLvty73Pu4Y=;
 b=GCnVbiLDSAQw05dvWYF5qR38vlVPjbCwKXk8fvJh50iVmgAZEY7mRP1YTKRwPgeWKX
 qDapjPWtVMfzAi7Ek4B/68/1A0NpKV9nBbnfUyWIw3gBK3ZeOi5FpSe81OVOfkDXhW6a
 qDTB9MareWHSSMZZkl8HHgAZvYGxgxYR9Caev2xbFbGmfEyzsJRgUFyK8QESBA2LVI3W
 f5CP5gTxqiUrkL2ydTs0QIm2WxwTIAoDqcqeICU+umyQEcH3+FpL0jQ+QZsgM7zzRn9w
 ths9SaATEnuc9Bf+f2cUGn7PJf9Nh5C3A8JN8g1PtANqpG7d7AASddTWgo3MiN22P+ai
 N9zQ==
X-Gm-Message-State: AOJu0YwJ7w/9TWc960e9KMZpCMRM4PJLilM8na4GDtI2SuVPJH6YhiyX
 0Hlob1pw4H3zbJDWvXPRRRpYhLj4AW2CPY2XYT5hbbWnQx+kHlX3vmNk96nYhr73
X-Gm-Gg: AR+sD11vBIYzESMX5rOmApCRf/kimy5XxNLS7lOtHXI1UfOSMlT/BbuEc2jMcor8oHN
 nlXHoBGJOSkaHK+mRpoHPz8k0vvBh8mMJloPAg1GLhcUDTqpc4LDVG+t9Oon1UP2zGHn+5F9iJx
 NyILDGIqHM1pPW22IDgBQTYqNymgpcvIduh2YD9mkyLtj8s0GQGRXAg2K8fRkEAFiADm88rjwfE
 j8sah90S7vU7eI1dG/b7uk9/E89WvbdxX2QB3b1cDb/pR0flC+mDQWpCXrA+NPcyyqa+KDdQfzi
 gzXV0wtShTx4f4NIxZ2ZRDGLsgxN4ZAShsxdcgs4ilZxry5ibycTvAH3j199JZ5YBp5Jt07XwrX
 dmcEC0JHX6SW3FfGolOcpB9uxLG503yBXywB8JKzBrmrPUq9E1FbljBiDjbkkLib8bCTk5ijOJO
 TEINnt9m8dhct4jhPkWUWlXD3ncJ8rXK3CHS8gwxvjANerHOKFp0pgbRpqJoREqbaWYuQ=
X-Received: by 2002:a05:600c:4692:b0:498:162a:dbda with SMTP id
 5b1f17b1804b1-4994e714b73mr275081285e9.5.1786101947354; 
 Fri, 07 Aug 2026 04:25:47 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499542853f8sm139853815e9.13.2026.08.07.04.25.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 04:25:46 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH] toradex: select EVENT for TDX_CFG_BLOCK
Date: Fri,  7 Aug 2026 13:25:45 +0200
Message-ID: <20260807112545.1883789-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786101947; x=1786706747;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HeAiBMPw/OTvdin5k479Kp5Yscj3g+KePLvty73Pu4Y=;
 b=ntPlJN5RE5uqspIKhNknvRYUqoRUTKm9iuByJD6x/WzT30k+O2sXFu8AqnyB2NMpbM
 bb7g75y+IlrUkNkRTYCAGqlTT2tCLYe+tBAdZc/bwOYcwlgAL2CG00h+paKfkxI/Hp55
 bfUT2Bgr3M7fzA3GdAOiquT35O6hkDZKyqXXvJ+g7UR+/14OUOX2r2PtyCuvn85pA1lF
 hog08K+igAAMK0tJL1k94STeNLrctgyEajBapAHagxXS6+5GVqQZzGRbBWx3XrnJN4V3
 NnnI0hfDYr8Ja8SfMQprIPo8zUR8VjHFsRnheQ4L+jV/Ywlcjb0K897rMMt5cM9k1wxA
 huMQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ntPlJN5R
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

The Toradex config block is read by settings_r(), which is reachable
only as an event spy:

  EVENT_SPY_SIMPLE(EVT_SETTINGS_R, settings_r);

board_r.c does call INITCALL_EVT(EVT_SETTINGS_R) unconditionally, but
with CONFIG_EVENT disabled event_notify_null() is an empty inline, so
the spy is never reached and settings_r() never runs. Nothing else
selects EVENT for colibri_vf, and CONFIG_EVENT has no prompt, so a
defconfig cannot turn it on by itself.

The effect is that serial#, ethaddr and eth1addr are never populated
from the config block. serial# in turn is what fdt_root() copies into
the device tree as "serial-number", so Linux loses
/proc/device-tree/serial-number along with anything deriving a MAC
address or a device identity from it. The failure is quiet: a module
whose saved environment predates the conversion to the event framework
keeps the old values and looks healthy until the environment is
rewritten.

Verified on a Colibri VF50. Before the change "printenv serial#"
reports "not defined" and no "MISSING TORADEX CONFIG BLOCK" is
printed, which is the signature of the spy never running. After it the
banner shows

  Model: Toradex 0013 Colibri VF50 128MB IT V1.2B
  Serial#: 03135809

and Linux finds /proc/device-tree/serial-number again.

TDX_CFG_BLOCK cannot work without the spy, so select what it needs.

Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---
 board/toradex/common/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/toradex/common/Kconfig b/board/toradex/common/Kconfig
index b85893ab44e..05f8341e4c3 100644
--- a/board/toradex/common/Kconfig
+++ b/board/toradex/common/Kconfig
@@ -3,6 +3,7 @@
 
 menuconfig TDX_CFG_BLOCK
 	bool "Enable Toradex config block support"
+	select EVENT
 	select OF_BOARD_SETUP
 	select SYSINFO
 	help
-- 
2.54.0

