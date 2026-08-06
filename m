Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FC6FC55ABF
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 11:11:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 677E280A96;
	Thu,  6 Aug 2026 11:11:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FipDVHPJ1k6T; Thu,  6 Aug 2026 11:11:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9D1A580A67
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786014704;
	bh=VBQrbN5H3IKzOWC15kDgDkKfkd/d84qDFNBeOadNlJ4=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IMzyQ0k7DORyNrYEZQjorUIJdgY2w3uP/wvJAi1sq5grvq7jc5KjuY467bwpr2lYy
	 HXgNMHH3gnli9pBYO32mssj8T283UNK/w8SsDV3P96Zg3N4yb5ZrC0HDfPapA+Do1g
	 20auQd9RKpTkt9ROBI1Hd5MQ295DaEQs7SZU2qS/Cq+b0pYfe1jUZZUM8Wtb72U65c
	 OUK8YmT10XQ6oVAG+SqK4P1avzDjJcHANgNZbVSm51WwTCDI4SIh2F/Qey0yKq3UOr
	 8K/tX/wIqNQJWH5pbB4RBxnuq96kQWJ4FqLu2k2zKX1+DK3mWMqFLLkrWpth/l8Zeh
	 aYhUAeTsPRayg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9D1A580A67;
	Thu,  6 Aug 2026 11:11:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9CF59397
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 11:11:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 82EB080A92
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 11:11:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mdscg4-ZPtv3 for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 11:11:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 913FB80A6D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 913FB80A6D
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 913FB80A6D
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 11:11:41 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6a18af264f9so269196a12.0
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 04:11:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786014699; x=1786619499;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VBQrbN5H3IKzOWC15kDgDkKfkd/d84qDFNBeOadNlJ4=;
 b=sZZ0+xGre7HceMjEHIlajPWV3GlkKMLtbCqCGbJV5VMFCF6srpXMGxYJnNkAOMFM6g
 yFr6kRYpB32WrObDipssVmn4DH2ZPbWeaDKUaBXfB6WmQoudD3ZMZlrgupQZoYbbxpBT
 OIroLAK+GF67d4dUu3bMB1r3yV9gzKAD1Uk2t+E0d5T46n74O3EsVMhny5Px6WGar8ip
 WKCUucmaCUICPEssjX8wwxAOmO7KZ9+MXhFxcmSyUrDtVuNTyDi2HPnRiGKRVHOubA48
 d+aHCTRSgxBxLjlaYKNvL6rCL0N1zwlHchbxbd8ZTJZlobIDqgQ/VfjqwxQfjpKFqO4z
 G2fw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoDMjBdzRQ1cb6Pgn7/aLLOXI21pLkrobbp2fVpvFefJs76GEAjFvylbgI/ZqU0a+k8f5d5h4Y=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzqIfDpZaLLdji9MvOCNuIxUjuPjGIRWo4eRk7w/lOEYT5K3Ov1
 946ys0eKYBfYAm3lFaXc0IiWETAPvIinLZzRtvJRXZsZ2ld9Wbf5VCUD
X-Gm-Gg: AR+sD130KMQJMPei3w5cLVFfkU0k8SuOK1TAuu+kNKY/3lPlIdXj563vJjilGaPmFqR
 SE2I/P4I41au2hvJvh5OcbDzSnzPEsiVWci2r2O3IGTnI8m4Gcdq5aCxOUK7Leb+yHy1EYswpaf
 oD7cZHfBAtxrRBSqSFC9i7rjpkYz0cjhMlQW3GgMgRO7CQarb9VW2x52irCPq0W2kITRh6Fpkes
 m//uBfkg4JHtkegorgnYE27R9ctaEfnZvrw49NQf36TkMQ5U4qfkurJufEp2bpFYoLcTMxBQTPS
 PozDkBS7RY/NrOSZQ4GBG8JQCEW6ciqnKF3yKIMYmwz4KjZ53HyvYgIfAGbzJ4KD+LqSPrESQWk
 tvSK2AXUcAsAXXMXZGvkcbN236CAn6HKLstYIpxCbedN0V8yi7yKxUYR1CPMlj3ZIkVFNyR4UO6
 Byy+jVu3AFHbY8jtxtUFibwxBS6VNBs6m8vz96d7D9qIhTA/sHgAl9Sga9C67GkUUbZK7K8gD8S
 UCn2B8ocO3XcrP452O44hmp8OlVb5er95hfxg==
X-Received: by 2002:a05:6402:28cb:b0:6a1:445f:1f3 with SMTP id
 4fb4d7f45d1cf-6a14f28502cmr3610407a12.4.1786014699473; 
 Thu, 06 Aug 2026 04:11:39 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a1947d300esm715363a12.12.2026.08.06.04.11.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2026 04:11:39 -0700 (PDT)
Message-ID: <7c8d4fb1-ba0d-49f8-90a0-6a56b8ef002d@gmail.com>
Date: Thu, 6 Aug 2026 13:11:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v5 5/9] rockchip: tools: rksd: remove reference to
 README.rockchip
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, eddie.cai.linux@gmail.com
References: <0ce61246-3191-4ce2-a7ea-8ab3c02cfe80@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <0ce61246-3191-4ce2-a7ea-8ab3c02cfe80@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786014699; x=1786619499;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VBQrbN5H3IKzOWC15kDgDkKfkd/d84qDFNBeOadNlJ4=;
 b=Qj1dvPATrAeJ6Zjcx4104nXsYZ8VOVtWeGM/1fIzMuhIwubO3mw8+7fku/k7zbYfEY
 G6cAEBhrvIim7Yk2HTb9bGsGgMGm+KN8gC2sr/Ji0qFoCOsZlkedr03iyvXiJoXGvnvC
 1T2QJv/CNZqSKL80hxB8FuGVK1DUzXE71m84Qox758/vY4G/2FfRCm6MNBoO89GDwfwi
 fN97udRBmt8ngJlGr0H+p6BnLy6QhHujxJwn3KYzo9Ouib/789YyjqbzfvBdzYECA289
 DQb2K5x+7+cOLZnFIUwM1Bq7YfKfO2Gu0rqIcvqqDq1k4mVOH+oxWgMSG1yKGX0L6FOn
 fIXQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Qj1dvPAT
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
Remove the reference to README.rockchip in rksd.c

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 tools/rksd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/rksd.c b/tools/rksd.c
index 7d46a1b07b3a..bf1b3737b72a 100644
--- a/tools/rksd.c
+++ b/tools/rksd.c
@@ -2,8 +2,6 @@
 /*
  * (C) Copyright 2015 Google,  Inc
  * Written by Simon Glass <sjg@chromium.org>
- *
- * See README.rockchip for details of the rksd format
  */
 
 #include "imagetool.h"
-- 
2.39.5

