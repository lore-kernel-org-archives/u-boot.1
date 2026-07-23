Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 258FFC531D4
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 14:53:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CB5F460A35;
	Thu, 23 Jul 2026 14:53:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mCQK5OkwOWKp; Thu, 23 Jul 2026 14:53:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 06FA260A3D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784818436;
	bh=FAVjcYS/IJuwbZ7mNFvYpa2GX3qSlXax1nuognQwYPA=;
	h=Date:To:Cc:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KLIgWe1TGVLmaL7D9KQSh7VneGPYOnsOSf+J9BZbc4F4u137LlQ/mB8Czb/xFcFaH
	 hsYApU8wkNqhbFX1w4u1V+NSbUWFmaqsX2MJSaKa4uRc470SxyvZXoEGiMhpLuZ+t9
	 7VMf5BE8W5B26TbjtT2+mtBtEjaIm7/0+DSSqWn2JNnK5DC6ikNef5tmnBmY0OOpbn
	 x+v0Um6udqwb5QSk4xRBjn0ClnJc/EB4mgYSmZaL+zBxUnHQFq0Dw84c49QzPJxwuj
	 7mYj4sBCdclUK0FZosAgaq2dcuSVH085lunOaSWVRl2dlz++ve9D4ETODYCA8Um8CK
	 yJUXFjfkuUFkA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 06FA260A3D;
	Thu, 23 Jul 2026 14:53:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7605C390
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 14:53:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5BF7360A3D
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 14:53:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HzXP_Fm_thBs for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 14:53:53 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=ghidoliemanuele@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 1E25F60A35
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1E25F60A35
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1E25F60A35
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 14:53:52 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 700B180287; Thu, 23 Jul 2026 16:53:51 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B1C480087
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 16:53:49 +0200 (CEST)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-47ddf7b09e5so812170f8f.1
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 07:53:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784818429; x=1785423229;
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FAVjcYS/IJuwbZ7mNFvYpa2GX3qSlXax1nuognQwYPA=;
 b=REOesSONwXS+bXmQ2FHpPoZgyijW2M8YqbesLyUmKsZygAdHn9u3x3rohV23vS/x5W
 Zn9Ii8r0y1oi0zhb9YhkdVnX3gfWDbwaSUAid4Q/rDJQJrIkYm1OBheVUFJ3ZPXsZC1L
 nOr68CFIxG3vqqnP27ZLa06tk+gi1G4beWbnO/2j8mg+jxLnmIXaaoK7emQvbod6lkWj
 swSQ7nwZ1U66QLB5RvKA7Y3cqYItf7IdZ1qCXyljXr49hZ+i2x2JgZZH0lXNzEm/i7N9
 q/RCe5q0oqXx8xb9BLwutKEFD+CmWASJsypZKAgVZ8SuY0q6FWrTqBQWJtkTsHfcKd29
 nmHg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro6idLhZ025bABs/zQOgGXm0fpnueTXaa2vFYzoHB+LTypdjCnGzuYVHO4/XksYYtv+SMNqEZI=@lists.denx.de
X-Gm-Message-State: AOJu0YwmxBQWrNR7lUK5d0JrfHlHB8oRVQLR9GQ+bFWTMIanwETHGG4E
 IhXUBfZauZK0EqBW6QB2Xuu0bI5hSAZyCCHg3u6D7m+Kde3qum7FFKs6
X-Gm-Gg: AR+sD136vml3aCCckTcNEB4W2NmkOOg7BhJVPkzzepnIGqu0wnDSXt3pz0e2C5bJQf+
 8MQCPwmo+RVSH/uPExYNfshdiD7KrAVWn/Q8z+xGCZ0mCbxlXYvTpGzjWlDxPB3Li1hl5llZ3sj
 +LKeqi0i5i3UzzVtFwIpk6P6HR1BkXIROxCe9zH6UJVtX+vUIJsZ53W6ZM90ZTF8FDSItwOTZ9H
 eTpcp1xcxHZOySLrrYxKIPKaGZ67R1MXSI+mO5a7GHAThxdusQW1eI9PbODQRFFHO4afAeKdheh
 ROYFHV+xk09HkiRjg2cbq6vjWuBzKcuHs1tnuJRDWecd4gLxi/yuxIrVH/e84ajKzOBMVHFqY9f
 I1In5a3U6zcMzRv3AcZ6kyUxoe6iejotstGuzj0qs1UUgp2vVDlyy77tzjA2Rb9iAFPITEcOmOt
 JTb9V3subvkoA73GvQT4/bdPT7xV1xHF5Phsw5dHbF2NtfnDsMwUljD2vXiMs=
X-Received: by 2002:a5d:584f:0:b0:475:f100:35ff with SMTP id
 ffacd0b85a97d-47f8dcac544mr4041103f8f.60.1784818428838; 
 Thu, 23 Jul 2026 07:53:48 -0700 (PDT)
Received: from [192.168.68.84] (host-87-5-153-198.retail.telecomitalia.it.
 [87.5.153.198]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c63678sm14846847f8f.29.2026.07.23.07.53.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 07:53:48 -0700 (PDT)
Message-ID: <27d77997-2651-423f-ba1d-652d5a133e39@gmail.com>
Date: Thu, 23 Jul 2026 16:53:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Stefan Roese <stefan.roese@mailbox.org>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Subject: Regression on colibri-imx7 due to commit 9c1b13b3fd27 ("cyclic:
 reduce get_timer_us() calls inside hlist_for_each_entry_safe()")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784818429; x=1785423229; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FAVjcYS/IJuwbZ7mNFvYpa2GX3qSlXax1nuognQwYPA=;
 b=czilV85ydk4F9EZZmR/3SebVUWj14TSWRHTtUo+MTeo0+dhATicrGjJuQc1j3IQZ0Z
 gBf3iHvvuiZUlG9yV0QXC+PP6no1nkqqUbP+lxJvzWesDAGwVNcTeNpwWOcZbfX32F9w
 fXMcyEQxntPIZ/IMgqG6mb7edwzrAWrV0yekKNZSBlaUYPLXSpp01w+cnGc8ppOyApQJ
 zDX6/g9jBzp8FGwCtRor5Ggsu4kMhQbkzhvWIhwenIwF+fWffGLOwxZJH7CHBQam5iy6
 1VkIhVHuYxCJw16DG+upgsn5CvVxOEGpAgilp7wXWqUT+3lOFneznreWJXrbjpb0GqC+
 ERXg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=czilV85y
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=ghidoliemanuele@gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="czilV85y"; 
 dkim-atps=neutral
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

Hi,

I found that Colibri iMX7 no longer boots when commit 9c1b13b3fd27
("cyclic: reduce get_timer_us() calls inside hlist_for_each_entry_safe()")
is applied. Nothing is printed on the serial.

I bisected the issue: booting the parent commit works fine, and
reverting this patch on top of current main also restores
boot. It's not yet obvious to me what in this change causes the
regression.

Would it make sense to revert it until the root cause is found?

Thanks,
Emanuele
