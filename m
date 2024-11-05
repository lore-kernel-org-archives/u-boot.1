Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4160BD1CA13
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 01:07:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 720AF88E7B;
	Tue,  5 Nov 2024 02:07:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OfxgfiPT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50FF888F68; Tue,  5 Nov 2024 02:07:07 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63A0788F14
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 02:07:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3e602994635so2690567b6e.0
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 17:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730768823; x=1731373623; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R1BmZoCXzRkPTONmFOmwPHXPnYpO40Ie1tIsJ/f2pdU=;
 b=OfxgfiPTcut+nmOtVyOjvafeUPQvzYF0plCouiakm4Vumk8SgB951dZvnfKjveN2Q+
 HlmPFyAM6HskpBQ4wu3hLoClPqO+J1dtb/qkO25I94kmnhbolAhrJk9reekraxqXyYIp
 1xoCl/jkBtScdN/T6T8wLdg92iGtRinIkIDek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730768823; x=1731373623;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R1BmZoCXzRkPTONmFOmwPHXPnYpO40Ie1tIsJ/f2pdU=;
 b=HUTKyHvXlh1K8YVBzY/6lEK14qvviyZA4Y71ieKNBSEwJSyNZLSMfylkYqhdXQjwwy
 B/SWRSNklD499G8HGYo5xec4kUoaN7CrnrwxU7jHCyBHS9jR6XhroA9BswTS0gsC0xsf
 Ktu3KCdWJBYcptn9M1sBWhIYRwIGovc12j5gQlpelGfHzUexBeWVmFbDNjo3hc75Uu2I
 T3WiZS6svRi7x0SQ86cjjTqcPqbIxvo9qf8vSndIc/htpJZyyOq2RU2GBEsWYJQNYIfN
 P7PlFTEnbIxPEMdzDC0KaKgM7RcJbfORhMvA2He4HtA88+QllycwONDp+H633Ae5Y8sC
 CkbA==
X-Gm-Message-State: AOJu0YwZbdQHHre2jPxRKxX0nVF8ulRTVYmINd932qwJQ/VG0U9ArBTC
 UpnfTZ9kydIT6la8drCbft4qOqgfA8WyAaH08MifFi60RmWkskclShTYLZ1fGZM=
X-Google-Smtp-Source: AGHT+IEmmoScJ9sonUIGRhW+9gD9t+ltXZU7X81/SYLQNvNEU4VoUTuNwjWya4xZtpJefFhDxsRoqw==
X-Received: by 2002:a05:6808:2288:b0:3e5:f4fa:5984 with SMTP id
 5614622812f47-3e66093a97cmr14339430b6e.38.1730768823115; 
 Mon, 04 Nov 2024 17:07:03 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d353fcc777sm54436686d6.56.2024.11.04.17.07.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 17:07:02 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Love Kumar <love.kumar@amd.com>, Marek Vasut <marex@denx.de>
In-Reply-To: <20241015141737.1170669-1-andrew.goodbody@linaro.org>
References: <20241015141737.1170669-1-andrew.goodbody@linaro.org>
Subject: Re: [PATCH] usb: Fix test dependency on ext4write command
Message-Id: <173076882194.3917422.4747871193468181014.b4-ty@konsulko.com>
Date: Mon, 04 Nov 2024 19:07:01 -0600
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

On Tue, 15 Oct 2024 15:17:37 +0100, Andrew Goodbody wrote:

> The tests test_usb_ext4load_ext4write, test_usb_ext2load and
> test_usb_load depend on the command ext4write being present not just
> the feature of being able to write to an ext4 file system. So update
> their dependencies to include the ext4write command itself. This will
> prevent spurious test failures when running the USB tests against USB
> storage with an ext2/ext4 partition but no ext4write command available.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


