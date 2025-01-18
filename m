Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0145EC02187
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 16:43:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4761B80778;
	Sat, 18 Jan 2025 17:43:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="l3GPZ7Hz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E1028063E; Sat, 18 Jan 2025 17:43:27 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 259D28063E
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 17:43:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7be44a90468so364745385a.3
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 08:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737218604; x=1737823404; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XxAzciuYYLOoIqtKAX6DvW6FOPpeOXioZQjCmTrcmHc=;
 b=l3GPZ7HzxyJPssvcDr/PbYzDN7neEM6pzKnsiZvfXpkYQ1ltotY/239pOViassQh51
 olS5uPss5/vBfFrCk5f9n9RR9zQWFgH1hRedphaH+oGmvhKeGxQw0JegjudT5ylzZ9oR
 EKXFfRHh/crp0A26WvVYKcZQGsWe0cxsxGoUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737218604; x=1737823404;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XxAzciuYYLOoIqtKAX6DvW6FOPpeOXioZQjCmTrcmHc=;
 b=Murzq+tak45ndMP30Y348QKTA3NQWNW05kkruEhGSmVK/0Xg54iSiaWZSpiWFv52gf
 xuv77YNw9oLl5Yza22OTFfiaT8ieE1PxMKo/O4zPjx8OpYPOce+tipjGGCAZ5zqAwpfe
 GkqkzBMY6+7hReJutcQE+x7RP8ISeY0dmzL21JYo4Ibnqy+FdykRHnZ1XklVVsjdyIQV
 s61y5hc/A55waJ2WtKpgWBMBwOKT9wTFHO5pmgLb4OTMrJ6oVSHVE/s2m+1HxF+XdTRF
 wHZ77vhCYoKlRgotUNxHhi8VfODwOpBBuNEe7B/0+V8AIf9zQRoO9GG53LrPTTRWDPu4
 OAbA==
X-Gm-Message-State: AOJu0Yxhda57HkOJRTHwoYTEWNTPANLiRuANdXrp8qH135hqzkSZfkRM
 AUN9qnZwuMhuEB6Sajc1OZA08FVD/YPCq1yZvtVtdPItQutdN4RAr64sJn5NDnZJIKdj3gjsi34
 5
X-Gm-Gg: ASbGncsMvOFHY9aqh19uNdZSA9q6bc6n3lws7jwdIs6uDNKDlHpi0ddlMawIjGYLowE
 Kqa6GQjIX4nOHnBQD/kj494ErDeTKbhIflMbsuQD2QWF90a0BFSxMAlhA751vtByCFaAS3d3UB/
 PzvA6amO88dHBUeylo6C8zDu0DqyJY8Vsark/juvMxwrtoefpVEH5lOsTB8JcN4JS4KvrqwQG5S
 yVkPXcoyd1cwSXHTz0SgeRLAG6P9fVSuA9ihOj2FTSNJX0a4Xt4Phd9Qefl93tmQA==
X-Google-Smtp-Source: AGHT+IFOPQuzzU+WiC69dMirtiEp8yIUerD1FV8ys5iLKF2B9/E5FIEe0bBSTin6Vv7z+JshMsCVgw==
X-Received: by 2002:a05:620a:2b9b:b0:7b6:d1e1:a239 with SMTP id
 af79cd13be357-7be631e58d9mr1098634685a.2.1737218604129; 
 Sat, 18 Jan 2025 08:43:24 -0800 (PST)
Received: from [127.0.1.1] ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be614f5b3bsm241061585a.115.2025.01.18.08.43.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 08:43:23 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20241231235412.1605761-1-trini@konsulko.com>
References: <20241231235412.1605761-1-trini@konsulko.com>
Subject: Re: [PATCH] qconfig.py: Update resync message
Message-Id: <173721860317.2563206.2278355847847486850.b4-ty@konsulko.com>
Date: Sat, 18 Jan 2025 10:43:23 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Tue, 31 Dec 2024 17:54:12 -0600, Tom Rini wrote:

> When using qconfig.py to resync defconfig files and commit the result,
> update it to say:
> Resync all defconfig files using qconfig.py
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


