Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE7B3E77180
	for <u-boot@archiver.kernel.org>; Sat, 14 Dec 2024 14:24:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9140C80083;
	Sat, 14 Dec 2024 15:23:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EvJdrQkS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6A6480092; Sat, 14 Dec 2024 15:23:51 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CA6980083
 for <u-boot@lists.denx.de>; Sat, 14 Dec 2024 15:23:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7b6eb531e13so119303685a.0
 for <u-boot@lists.denx.de>; Sat, 14 Dec 2024 06:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734186228; x=1734791028; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pXL3ypEgpuCMh3y0yrO9GH9JhfppMDVFWRXNviB2yMI=;
 b=EvJdrQkSD0Q+9wWQpR9VAZIcuVcnXQ4KOObvheQf6kv0N2eq5WIwnv5/cvzQyb6ZEx
 0yQBC0jO8KorRd7Wra5dmJ93EMyc2HexN6px0Pian1E41uFYbTQE9AN/TaIwPKBFgC9e
 VjaY3oAIBRpMibuX4ao0Lohgw/luvIi/u74gU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734186228; x=1734791028;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pXL3ypEgpuCMh3y0yrO9GH9JhfppMDVFWRXNviB2yMI=;
 b=qdkxNVlf441Zuoo9ktrqEzghgZhR0PIO4l2jky0nGN/5UdV1occp0F8xeNYDAzYUW6
 IE1G0n3ouzLPjoPbNqBbGf3ks0n8llUQTc1wWHG1Iac1SmybrbeI1tKCS2nHI+WXhTRA
 rg2XyHbRGmb9FemlxBffRmI4z68eFKyad5L7z1l2ye12wd+Fi509cerepn1v8zZInW9W
 uWdmnwY6yYFFmwV6MwR3Rw5A7H3JTRQg+SQHlAdy96ln68EA1/39k1VgXG9SwvmRstrM
 Fz5PQ12AEtxFa8r/LQ2RAB/AtnF/sbuAw2cAJxb3mpUbpUsQ3vhqviB56jpUvC1NTIvj
 3jdQ==
X-Gm-Message-State: AOJu0YwKsKlOjcmKuAlYhuzrXCoZ5z769v3jo9d+L0Xe+2rViynYSlEq
 y96MyjWQdZWXVkqsewIhqzzqHsuQimnubCpBZ9FuhbOVH03n3r/FFmFxQ/olTQI=
X-Gm-Gg: ASbGncuFFK8r51xuIu4f482Qp9WFhBKT1ExYNu6JqJ/v7DCzDiNMFZv7FdFZWFBVDVB
 /r7ipExWYQypCTv66yDu3RzbdtcNXacPBz19CQzyfZsIdf3P5xWbRgsdEkfBeBT287m4cmgImRn
 Vk5KPKpdEpJjuc020qthXjkzWoLYvW19yRE+uvfZEOVNBN9xtQC+IJBHzrRX/ndpmkI7/N/WNwg
 oOJpId+IIjG+obJW6UhfhqaotjwznxSEPcfV6pUt4ISwyxLJPUzvaU=
X-Google-Smtp-Source: AGHT+IGlZjCMwyxVJb1VFJofWCHFCqq0EKo2+XDMU4hotQQ8u2BCorEGh4HbBa6JXNqmNGE6qs762w==
X-Received: by 2002:a05:620a:2983:b0:7b6:79c8:d036 with SMTP id
 af79cd13be357-7b6fbed371dmr900074985a.3.1734186228428; 
 Sat, 14 Dec 2024 06:23:48 -0800 (PST)
Received: from [127.0.1.1] ([187.144.29.192]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b7047aa729sm71973385a.12.2024.12.14.06.23.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Dec 2024 06:23:47 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: afd@ti.com, bb@ti.com, w.egorov@phytec.de, vaishnav.a@ti.com, 
 hnagalla@ti.com, j-choudhary@ti.com, a-nandan@ti.com, nm@ti.com, 
 sjg@chromium.org, a-bhatia1@ti.com, Garrett Giordano <ggiordano@phytec.com>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de
In-Reply-To: <20241031162103.2835289-1-ggiordano@phytec.com>
References: <20241031162103.2835289-1-ggiordano@phytec.com>
Subject: Re: [PATCH v2] arm: mach-k3: am62a7: Provide a way to obtain boot
 device for non SPLs
Message-Id: <173418622618.1834185.15824150077121991669.b4-ty@konsulko.com>
Date: Sat, 14 Dec 2024 08:23:46 -0600
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

On Thu, 31 Oct 2024 09:21:03 -0700, Garrett Giordano wrote:

> Introduce get_boot_device() to obtain the booting device. Make it also
> available for non SPL builds so u-boot can also know the device it
> is booting from.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


