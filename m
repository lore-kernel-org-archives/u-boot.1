Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15EBDC2BA18
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 14:54:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E80488402;
	Tue, 18 Jun 2024 16:53:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="si7s/A1I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0595088363; Tue, 18 Jun 2024 16:53:29 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A3DD883DE
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 16:53:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6f96445cfaeso3069965a34.2
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 07:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718722405; x=1719327205; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cD1Y4htAhyYsiFTmSD/s9pFmhnXLb6NVR+O/3XEQwZM=;
 b=si7s/A1IJBMSZAIohqihsBPs/6AbGW7waUMl6LbT8CySrOYzMC8F6zAuKfkFM7yWx9
 7P4yYTM7IWfIjB1a0QltsQa6bsQ9QXIwzFxEAQGVabSYkZwDYr8Ycykw1iBoNUil2kGn
 oZlCGin9huGoDxCEqOuJUMUd6PPCxE0EPKDrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718722405; x=1719327205;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cD1Y4htAhyYsiFTmSD/s9pFmhnXLb6NVR+O/3XEQwZM=;
 b=sNjU+1u+JnU/8U6say98IkxGXgHCMUELfb4o9kmXg3T7MoespIl/67TQVjND08hHBQ
 11m5YlpD1lM9qAw0MJ2Jj8u3T/DKEsGWmLP0lAt4KumNxiGlToIxPjpT2XVvScsFgTWs
 Mx/wQ4jNTjIc1e+mqGZSZ4hKLLpQ5YZ4MAX15pVNhdpLpQo50NW7PAKSwF47Bw22ipke
 zGAmVmu4YLl7uWgj5LronE5m7Dro5kAQpReyvWS9Z9LDUmsy5UWGqQd12GdXMrwwIuMz
 E1j7siyvdo8LYd+VkFCMC9bjXo4R2YvuHo8Tu3MXjQFSTj1cWxVdf2r7U4WKoDH2Ox13
 Wr7g==
X-Gm-Message-State: AOJu0Yxy5J9T1CUtPBMW7HNSTwEBMdCphUpon7JwPVBLS5TjLoOcSnmH
 Cr7Thqgg8HxTxg+dbe8ZsKXEDpAhitR3xAO2SwljJVvS7f95HrwjLojAsdPQaf/3nacZzqqDxHA
 7R1uzjw==
X-Google-Smtp-Source: AGHT+IHAUP4uiDyn7QhFhCZo5PF2WZ7x8Vta2uJ49IQR5Wt/+HuOg65LTQc8DiZg53RviH64TLLzpA==
X-Received: by 2002:a05:6870:e2d4:b0:258:3159:f489 with SMTP id
 586e51a60fabf-25c94986cc8mr12449fac.9.1718722404852; 
 Tue, 18 Jun 2024 07:53:24 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2567a94b7besm3202888fac.6.2024.06.18.07.53.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 07:53:24 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de, Nitin Yadav <n-yadav@ti.com>, 
 Dhruva Gole <d-gole@ti.com>
In-Reply-To: <20240607-am62q-wip-v4-0-3900cdf25721@ti.com>
References: <20240607-am62q-wip-v4-0-3900cdf25721@ti.com>
Subject: Re: [PATCH v4 0/2] introduce basic support for TI's am625-lp-sk
Message-Id: <171872240403.3307069.8251972450938475277.b4-ty@konsulko.com>
Date: Tue, 18 Jun 2024 08:53:24 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Fri, 07 Jun 2024 17:06:11 -0500, Bryan Brattlof wrote:

> The am625-lp-sk is a variant of the am625-sk showcasing the low-power
> features of the am625 SoC Family. Because it's essentially a board and
> package spin of the am625-sk I've inherited the am625 configuration and
> overridden what was needed.
> 
> This is a new spin of Nitin's original work which has been updated
> significantly since October 2023
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


