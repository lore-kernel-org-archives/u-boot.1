Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65EF7C56208
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 11:12:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 31E4460809;
	Thu,  6 Aug 2026 11:12:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PNwSRRcieKt7; Thu,  6 Aug 2026 11:12:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1F34B6070D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786014733;
	bh=3p1Pjz2FTDGYLc/vQK6NOQWxHj4iQnOZZrL1KhOd1jY=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pOVdN08ebqEWlWXwKQX9Co9G+yDO8lBlkxuxbWMe/NLb0SAmHN8Gc1H4Z04vZl2hP
	 FhgAO5k8rdPPB2L9r74a/SHO3N/08xx5cRbqNfYOMPmqsIxLZOQMT02O/+AWhErc5l
	 sVOXWGR7RfDmqr9v/mIQvNbBHBqtlgZzBo7jUAeoXEBdIxSXYw0bBQlHadjXiP2J4S
	 irxCnrOTWid4HuSMGwo/sIwNiCQT+yDESAZ+ktcw8xJ3Sim09Kk7Dbk0aSItATaa/G
	 rJOm5iW171MIuKLuRrnmotRJTLAcZhCsCIvlwhGxLPFu55Yv1rMUMpnwWFLTQz3npW
	 72X5o+z/qAsTA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1F34B6070D;
	Thu,  6 Aug 2026 11:12:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7C3F3397
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 11:12:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6E4FD40265
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 11:12:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ojBb5Mp7ZCk6 for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 11:12:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 8DA8840262
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8DA8840262
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8DA8840262
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 11:12:11 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6a18d89e4d9so176578a12.2
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 04:12:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786014729; x=1786619529;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3p1Pjz2FTDGYLc/vQK6NOQWxHj4iQnOZZrL1KhOd1jY=;
 b=Ap0dgvm1QzdfxtIAMhfletVDOVhMWR2cJmmEHQ1vQatjO6x45pLgULJqRLKStmkqXF
 Ul/NWi4WC5U6iAA9s3Hq/bRmh12TLMb5RktF4I3QSogKE6E5q6LU6QP3v6rqq2bfxkSl
 BY39tK/Y7wu2ogYe6X72h4vma1cnpiCC1PnS22+KOK4ItrUrVUG8OVkT3LwCabVWmD1z
 /17LWhPV/ndJmHF/FFiAihOzqXg511PB+xuh+nuhMO/MOWylkrwPRMMgTjVDs1kPxW29
 dl3hZ+Gt6Hp3MffOg05cLpnhuEFsnAtAGAYbm3ktdfCY/ISimnE87+kOF93Qr88LUL1l
 1djg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrn2NAC9a6UTM99teDhBMU7XhUZ//7/vz0xdzYEaHEmaZtxn7ExyB/T0p0h1slb9wbUTTMydek=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yzopz2czVh+DgYUrXMzqiCnFdIa57HXucATX7U1Hi+IlKqC/xC5
 tcs48XzOMIE3DmLwKuR2tms58QEmXX041Niq5thwDK2Bgf+nzGYsnSFp
X-Gm-Gg: AR+sD12P3z5TFpFahTJLdZd6GQ9Ea0ArTxE3hlg3zZ8Gs5uSynw/guc5V6m9uT3PJpm
 IZ36ITgLo5pxFmBxgHd/wP//6YK+X10Ci8w9fhROxvz43cp8lUCQrd3hYA4hHe73VQoWAWvxhSM
 YuFSnNBRMEr66FhJ5IBq6/8japRyF6xH5dvjC8SwdeGfwR7tWjbr+3V6rDWRPec/akbjUf+c8UN
 1BjrXhQ66v69iw6lfydhPycqlxUmYy/mQ/JOhV4hAEbN6LhPEZol8f9O1GcjU8hj01iQV0DjQ1E
 0ufG2eWhlZSZ7VHbj60MgavKyTQig7CteYZWKgdTepnW66WcpuvfkhnDrq58RIOkdwmC0DegkOP
 20uyijkRPOfLFUiksEvw2r/FE+PLcWPLUbempuQx7/F3fVJSvrRAR2zKfwA+rrenh6odb8YJK8A
 1TnCuHD2Uh51zWKtcW3HH1UaDxAg1Hq+blyS+zv+3JB6IaqbRgsJjabmU+zfC0mQMAFZdanzA2e
 BSdgGafjuGSYr5nJV5zJlmzQxk=
X-Received: by 2002:a05:6402:5416:b0:68e:4c0:f59a with SMTP id
 4fb4d7f45d1cf-6a14f126702mr3509023a12.2.1786014729463; 
 Thu, 06 Aug 2026 04:12:09 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a195b5c96csm729465a12.17.2026.08.06.04.12.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2026 04:12:08 -0700 (PDT)
Message-ID: <53c6506a-c81e-474e-9a6f-33d86242e066@gmail.com>
Date: Thu, 6 Aug 2026 13:12:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v5 7/9] rockchip: tools: add comment section to rkimage.c
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, eddie.cai.linux@gmail.com
References: <0ce61246-3191-4ce2-a7ea-8ab3c02cfe80@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <0ce61246-3191-4ce2-a7ea-8ab3c02cfe80@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786014729; x=1786619529;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3p1Pjz2FTDGYLc/vQK6NOQWxHj4iQnOZZrL1KhOd1jY=;
 b=HJR9vAyatXwyoG0e7j2bnaPN/y7w+MKBbt32HApvqs4q7/wnziaPRW6AhCCtuNeozG
 0ZskHlEIngGeDVKEype0sN+14CaVxBPw2dvBwmHArSb8cmXVexKA9wYxemi6dDABbpeL
 fZK/v0GaUo2HqocB9vKCH1l6Q6oFb8bC+3jt/jUNhaYDUIEf2LUEWIXXpLf+xJwz2Qtp
 CHceLczrG+pniptGqNt3Ri1m3bufpOewamQ9wCSO0tkusdBUBNaM4bhosKXjuYWWa9VT
 zBZwiVWcltEPe1ALqzPsfHJSd9iAs/GUI6x4WMV1V3wmy28RXvLDoUDJlRx+duNWoSij
 hxng==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=HJR9vAya
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

README.rockchip must be removed.
Move the rkimage comment section to rkimage.c

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 tools/rkimage.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/rkimage.c b/tools/rkimage.c
index 1c5540b1c3d1..0cabdf2f6723 100644
--- a/tools/rkimage.c
+++ b/tools/rkimage.c
@@ -3,7 +3,9 @@
  * (C) Copyright 2015 Google, Inc
  * Written by Simon Glass <sjg@chromium.org>
  *
- * See README.rockchip for details of the rkimage format
+ * rkimage.c produces a SPL image suitable for sending directly to the boot ROM
+ * over USB OTG. This is a very simple format - just the string RK32 (as 4 bytes)
+ * followed by u-boot-spl-dtb.bin.
  */
 
 #include "imagetool.h"
-- 
2.39.5

