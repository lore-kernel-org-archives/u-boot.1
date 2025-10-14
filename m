Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF27CCD192
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 14:19:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60ED783327;
	Tue, 14 Oct 2025 16:19:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rHX0KV5N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 540B583303; Tue, 14 Oct 2025 16:19:24 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 443C3809A5
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 16:19:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7bc147fd11bso3835731a34.3
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 07:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760451561; x=1761056361; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JlpFCG78voL3TClTiXdynptzL77KhljWvxt094iQTwc=;
 b=rHX0KV5NjBjaPNfAZX3YSiKjxcIYCGrZnj8KsbiijUo4JPfg9TDjgoKEqKTh+WcTQF
 +INLN+KB39mu+uVwj5rJRUhxhEKCWki3kgn6vgg1JmItwiSXIAAMWu1x3vf1sOmBjnxB
 fFIZnBgDWGZdrt/CulxcAGEJH5xqsNLNCuqnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760451561; x=1761056361;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JlpFCG78voL3TClTiXdynptzL77KhljWvxt094iQTwc=;
 b=Qw6jMfv2KSD9A2YUuzm1uyflY3RA0GXZGKKWGWqNJScZTiJ7k7CSo5mrunc5nMEZ8r
 U59LdSUfDK2NE+5qNRA1MXC4cF90G8OUQam2mnCxLERPRCXItFPa/dsiVDXNgEAnR+fO
 o5sGGT4gqiZUIN2/wNTeiSyoD5h3wtRadxSjPPXiMq5mscNk2PFrYxO4St0MZ0Zm5//s
 7QfNmBUWBEFwPkDuuD0BghUdZ0umcTU03NXdMir5kG1mVx3keK8GSGsY752ArJGTSmXS
 SrdJSDR+1Ui5/80NfVZynls1jLe16rDCfpT2+1ijoGjxj11SPML6kp8ulYVGZW9tRIJI
 qCnw==
X-Gm-Message-State: AOJu0YyY/8qrQrAkvOl3WjnOWh3V6HDqPHpaIdQrsVlTvbpFQaUU5o4H
 oQhVLO1SO0B5d+jBgXiiivygDKvKaELJXnoT+R6/Tl0MwDfDl8yrai1q4yJF+kBa0z/+tKJCdo/
 VzR5ItHQ=
X-Gm-Gg: ASbGncsmp40VPcxby3DJ0ChWsyHqvbPkLEEZPywUAswhahouaUEychGhpXzfdqJJkdS
 Vs9wI6kj4fsFmNJD9k3W+9PuInHXMATG0lJzLBHHLugBYaD6mYcULzL7uWMdMdiBI73Fnpj2pIc
 36BiWEKH+Hc/iciLdraAPqtk4tJWn/T7diiPUoMQPVi3JxPW19fyKdmIyxtoqciH4Fy/CnUumtE
 a9jY8l/FDeMoTGLlxckx+FtqdhUxqfEuHWmHj6NEDXpZPJrhXEwJ2UlYyoq3Mw+ZIW6b10VKPzE
 GMmUMwbo72RHeFu8KDOt5H9P6/hrm+yDZK6bijk7FGeM09qsLgUIgJVZYjnCmFP5s9U8yajql4g
 SBB46T4MG1nCgXxYebRy0kG9hbLV5sHEOnulr7W8pHtsJ5107HYQB6tpnpEety4RXHHJOB8n0pv
 PkWRcjj9rHjEKG3Q==
X-Google-Smtp-Source: AGHT+IGvTYPRl9WruQ5m6yhtGEn2VHBDJkQPAz0ywLTL07DZRm9Vsz6cfXv5cQbtFs7nnUh8hWpqKQ==
X-Received: by 2002:a05:6830:264a:b0:7b2:3b7c:c44c with SMTP id
 46e09a7af769-7c0df7da42cmr12879187a34.36.1760451560816; 
 Tue, 14 Oct 2025 07:19:20 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c0f8f18f29sm4531663a34.0.2025.10.14.07.19.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 07:19:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20251009222353.1010313-1-trini@konsulko.com>
References: <20251009222353.1010313-1-trini@konsulko.com>
Subject: Re: [u-boot-test-hooks][PATCH] labgrid-trini: Fix logic in sd-mux
 flash wrapper
Message-Id: <176045156015.284418.3261834075725921212.b4-ty@konsulko.com>
Date: Tue, 14 Oct 2025 08:19:20 -0600
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

On Thu, 09 Oct 2025 16:23:53 -0600, Tom Rini wrote:

> We need to pass the normal first/second argument to the raw writer from
> the labgrid wrapper that controls access to the sd-mux.
> 
> 

Applied to u-boot/u-boot-test-hooks.git/master, thanks!

[1/1] labgrid-trini: Fix logic in sd-mux flash wrapper
      commit: c8ec3582abfc1477d6edd0220b1df3a65c367e3b
-- 
Tom


