Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E37C2C35FFB
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 03:17:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 864A081951;
	Wed, 19 Mar 2025 04:16:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=nubroad.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nubroad-com.20230601.gappssmtp.com header.i=@nubroad-com.20230601.gappssmtp.com header.b="l7tBsyN8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A3EB810F4; Tue, 18 Mar 2025 17:49:17 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA6EE800B6
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 17:49:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=nubroad.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vijays@nubroad.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22423adf751so103526745ad.2
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 09:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nubroad-com.20230601.gappssmtp.com; s=20230601; t=1742316552; x=1742921352;
 darn=lists.denx.de; 
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:to:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=l7tBsyN8aXNCqNywxhsGDRd5AsTu1kwJPbK9C0UmkKXGSpFT45om5xXsKguyx4V7TX
 G6G0FazYdy+BRnGqUHoWlnXvyKQJlS/egL/jAHgaKLiyXEBn6RHN84FJ3kjisr/zR7p2
 uJ5jR3EYt6GVLPnY1M2ck2dohgti6TQVrMDUhe67HBryOFNEe8dSxQJXLtiCffqNrZmG
 hFOew6rpbqqxYw4Nmk9R/NJ7Yynfj4v8LYXwAcsY+k06in/Rn7O139Dfko5K1gcigI5z
 TeCAdO1J/Og4hPDYJXJguZPjYR34OL8/iOa+ZC1IO+IlPO9kFKxq3nD8c3UVb35nwDEi
 EnFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742316552; x=1742921352;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=eHszJ27UsF2jBIUheCalhsg89v7ykRAG4TDtijUgBm7frsq4LGYzwKJgKygyPn2Dq9
 T6MHOxx6jVm740JM5fn0tr8isGcGBuj7YPh55DBdS+VSrCKq3MXoIh2KnYEwhdi5G3/f
 rEf1uneuR00vgKxCRFYw/y5qe+roNh3riGt865c7BIIqo9RucNkJ4wZOvD2Mi5lboVns
 6chmtaxNPkm05rA0jiQ0KnzqSf66rqFfeSH21F8gfOgBlm7GYHz6t7lPORS2HnEKAfKG
 osxH4Y2dmI6RW0JNdRmVCLKWyUm5OTze9vUlqNZ2SsIftRIdtv0uWdYToU6FV3+Eyc6Q
 woSQ==
X-Gm-Message-State: AOJu0YzpE8dtg+iFtYWZcRQyoIUYUULLbIKfNSuyaHNhATMK4/OPVNPV
 GcACzbMiU5lYZZnu5IPgE60x1pD3VcmJa/8g2j6QFdHvKF1ic+JoAlFEm0HOl/gvgVU/wN8cBNl
 s
X-Gm-Gg: ASbGncuv/OOqYzwRt0OWraR3w4QvjP7vc1UnKMBh6PvlpCuEaVZlgzSlv+x6u9yogtS
 tLAi59a8zxkyKbDnKMYeGNLkHLkOXwi2Pp4B48G1cLhwXw66tgByXw4ptg0VQCcr9efGuV1jdkm
 B12m45E6eMQIJCCqNxNe8zx7a76SCJISDDpBZrn3I9nXXXLHMkSAYcK0sB5WCJffJCcjWNp0eLR
 UiD3RKMXcgpM6ewvEIqnajNbZwOzwway5mIR52HDZa2WCU0QDbSb0tnpVU2Og2zjVnCCfBOj62P
 vv+xUzyDm14olBC75hsDga8fzqTZPbDA7o035bBSzoz+BlUbkomG8lx8wbTKES+cYGs6GpvvDxS
 HuJ7AaV9CgTNG9JY6
X-Google-Smtp-Source: AGHT+IFpwHcYS8cPlfjFRw/uxaT+yIYkoQ8jLoUcnMbPWMIMESGVBIQStiG2I9DiSi5f3pEU2yExmA==
X-Received: by 2002:a05:6a00:4c86:b0:736:a540:c9b5 with SMTP id
 d2e1a72fcca58-737224726d9mr20486826b3a.22.1742316552344; 
 Tue, 18 Mar 2025 09:49:12 -0700 (PDT)
Received: from MYSTIC (c-73-93-73-191.hsd1.ca.comcast.net. [73.93.73.191])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56ea7bd6asm7739546a12.50.2025.03.18.09.49.11
 for <u-boot@lists.denx.de>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Mar 2025 09:49:11 -0700 (PDT)
From: <vijays@nubroad.com>
To: <u-boot@lists.denx.de>
References: <mailman.1444.1742249864.725.u-boot@lists.denx.de>
In-Reply-To: <mailman.1444.1742249864.725.u-boot@lists.denx.de>
Subject: help
Date: Tue, 18 Mar 2025 09:49:10 -0700
Message-ID: <047601db9825$acd7b030$06871090$@nubroad.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AduYJZgamOXasvGeTaiKTxtKk7BkCw==
Content-Language: en-us
X-Mailman-Approved-At: Wed, 19 Mar 2025 04:16:48 +0100
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



