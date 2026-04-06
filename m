Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF307EF4EDF
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 13:04:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 416F28352B;
	Mon,  6 Apr 2026 15:04:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=permerror header.from=rootcommit.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="key not found in DNS" (0-bit key; unprotected) header.d=rootcommit.com header.i=@rootcommit.com header.b="WgmqZZsu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72EE883A41; Mon,  6 Apr 2026 11:57:27 +0200 (CEST)
Received: from bee.birch.relay.mailchannels.net
 (bee.birch.relay.mailchannels.net [23.83.209.14])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E162F83936
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 11:57:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=permerror header.from=rootcommit.com
Authentication-Results: phobos.denx.de; spf=fail
 smtp.mailfrom=michael.opdenacker@rootcommit.com
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id C1853823AD5;
 Mon, 06 Apr 2026 09:57:21 +0000 (UTC)
Received: from fr-int-smtpout21.hostinger.io
 (100-121-30-206.trex-nlb.outbound.svc.cluster.local [100.121.30.206])
 (Authenticated sender: hostingeremail)
 by relay.mailchannels.net (Postfix) with ESMTPA id 7286F822C75;
 Mon, 06 Apr 2026 09:57:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
 t=1775469441;
 b=05JbMY8sLLVTs81vYB4wZFm/1J+RC1J4v4BM7fl9KS40VaTUr20tHHWWXqzqosoFcKlrmp
 wXxmX1iwyaYn664PmYTajPzHzSfKKLE3+sioSt9w/3kHjrMpfBlu21uYFQmL3awRrE+XMc
 +JPSsKem1PZEMr0AH4VsUJ4EPddtLUKq42lqlKmMM3+WvTGIR2d590rTAsjnli4yipIJDH
 JXXv6vEi20o1OchzhK36Qf1mlidyOSKxL+08NJwyNxap62PMmvv+v0SGh2iFBKxMKs+gsG
 7goOvMkbZ7u6Po1LZ8Z1PVfKkQ575eDguG6SUswIXHL2VcCHZnSXGSNlUT6p2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1775469441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:dkim-signature;
 bh=LsCGV6xNHO2+bnsLfT2JDfUd7xYjBnxKUSOjosW9LWA=;
 b=v29oYLR7teyEQ1TW7479Qt/DWw88jhPWgNMQnRv3MAMclYw3NN3SYky6Ox033ujc3spAaz
 h2BQiy+2pCF8l5Pf1FrAV+6YdL0fuxIYm+tE7ePRSu8UzA0vq4oIbLiMo+B9HwsNcvy7QC
 obGDp8AW4GAHlU3RLZZVIyzQ3HRfh+2DLE8DptVSfJLZ8B9frFcZ8Ey1e1VBdmNnz5mWdz
 JsPHxQMrZMNGNVP4wAMCN0/YmQr5bH8l5kYXhBw2WuNSWD03wAkL6sznx4gdkc8Nij2/9T
 +/WdWxk/MIGVjcEKEDoR0kSv6sCmdPwIm8WhgmHEnzXY+yGrMfyeY9sUDI3ywA==
ARC-Authentication-Results: i=1; rspamd-7d86dcc447-bncfm;
 auth=pass smtp.auth=hostingeremail
 smtp.mailfrom=michael.opdenacker@rootcommit.com
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MailChannels-Auth-Id: hostingeremail
X-Company-Oafish: 17fcfb61275a0d2b_1775469441429_1208300787
X-MC-Loop-Signature: 1775469441429:4248968491
X-MC-Ingress-Time: 1775469441429
Received: from fr-int-smtpout21.hostinger.io (fr-int-smtpout21.hostinger.io
 [148.222.54.33]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.121.30.206 (trex/7.1.5); Mon, 06 Apr 2026 09:57:21 +0000
Received: from a8.lan (unknown [IPv6:2001:861:4450:d360:4b27:58de:a98b:969a])
 (Authenticated sender: michael.opdenacker@rootcommit.com)
 by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4fq4W247n5z1xtF;
 Mon,  6 Apr 2026 09:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rootcommit.com;
 s=hostingermail-a; t=1775469438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=LsCGV6xNHO2+bnsLfT2JDfUd7xYjBnxKUSOjosW9LWA=;
 b=WgmqZZsuwIIaCtOC/eVh2vnHVjGHQW8gkOVD5+zrn8lFuHHzJFqfVyt0zjEwzszmc4n0uj
 Yh//DtZ6jwHHnKksKFZzpPL1OvdvG1KcnF9bnnirrvgPddP+FnOY8MStgLccS705nwGMev
 eeKFxjsoPu9trN2ngwRLy+pHjeEF79LhTfRl88mP7rryCzcj5FS+Zw45jqKeRKLZlHt6tR
 e/joHpIUAlOfZOrUN9PuqX4YHZcbkzCt6/PHGGFcwksWjO8nahZp7bVpYs8KGEkM6ntLrw
 ELM0aAVJXjDtOl0w5WJySTg7P28AtZbG3r6OV9oMU/FyEimiLZ0B+Lps6+rLZA==
From: michael.opdenacker@rootcommit.com
To: trini@konsulko.com
Cc: michael.opdenacker@rootcommit.com,
	u-boot@lists.denx.de
Subject: [PATCH] doc: api: bootcount: correct bootcount description
Message-ID: <20260406095705.48379-1-michael.opdenacker@rootcommit.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Date: Mon,  6 Apr 2026 09:57:18 +0000 (UTC)
X-CM-Analysis: v=2.4 cv=Gq4Q+V1C c=1 sm=1 tr=0 ts=69d3837e
 a=3zDuGFV/+L4c4FtOV/OD+g==:617 a=xqWC_Br6kY4A:10 a=d70CFdQeAAAA:8
 a=lehcmS9YP0pJxNI8ujgA:9 a=NcxpMcIZDGm-g932nG_k:22
X-CM-Envelope: MS4xfAyNAvoNc6pNzeIE4iSC2gF0LH/t3bf0Rer0O4vLdRkEF+5DxJOjly0g4LVAB7jMldTX5Uwv93IyEou+FmLh1rQhstsE/3/E/jau/1mYOQ/f8R6aBxCL
 DssUgNEnXJWkjmPPqWwAHsOTP28LaVlSZsWzhqG/4nAUzftNK755bc6FqPtCPz9U1lQ3Of7OddqaD98T/9xkOnjUnho6ddrg4+2lo7glQXPliMLt0E+uRi0T
 XTDxrSOPb2SnaOS7iPSlx+rFpoZ2uFwKb5z2naGJGlLgmrN+x1UkUdHInyRMxdDXmrEBN1xqvWCjld5GjhE7TVbQCyF2R89gBXLYYgYbUgY=
X-AuthUser: michael.opdenacker@rootcommit.com
X-Mailman-Approved-At: Mon, 06 Apr 2026 15:04:07 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Michael Opdenacker <michael.opdenacker@rootcommit.com>

The bootcount variable is only incremented
when the upgrade_variable is non-zero,
as implemented in drivers/bootcount/bootcount_env.c

Signed-off-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>
---
 doc/api/bootcount.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/api/bootcount.rst b/doc/api/bootcount.rst
index 968c679c3c6..f3c10bbe724 100644
--- a/doc/api/bootcount.rst
+++ b/doc/api/bootcount.rst
@@ -8,7 +8,7 @@ This is enabled by CONFIG_BOOTCOUNT_LIMIT.
 This allows to detect multiple failed attempts to boot Linux.
 
 After a power-on reset, the ``bootcount`` variable will be initialized to 1, and
-each reboot will increment the value by 1.
+when ``upgrade_available`` is non-zero, each reboot will increment the value by 1.
 
 If, after a reboot, the new value of ``bootcount`` exceeds the value of
 ``bootlimit``, then instead of the standard boot action (executing the contents
