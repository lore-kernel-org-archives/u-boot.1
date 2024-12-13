Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB0D2E77180
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 23:17:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 620D880192;
	Sat, 14 Dec 2024 00:16:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="h0svvMod";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFEF8800C8; Sat, 14 Dec 2024 00:16:55 +0100 (CET)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBDA28020C
 for <u-boot@lists.denx.de>; Sat, 14 Dec 2024 00:16:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-46772a0f85bso20948041cf.3
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 15:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734131812; x=1734736612; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QgDZqtwW3jvPpXgP3d9OTVpmXQuXmxL7s3O9TPNmq5o=;
 b=h0svvModO5CEynMQmRs/zRFkx4RGMVGSRh46tOBCAWCWWeCmOuiFNhDg01bVOdzmE7
 aEMd6mtpV0p50dAHbx5Os4DNGAeQ5s5xsh8inZK55jeyG4k6tzzGhkwlWVphA0mk9jx2
 MdsV/gNfYVrFMfP046NPxT1k+pJuwOjZWSKMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734131812; x=1734736612;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QgDZqtwW3jvPpXgP3d9OTVpmXQuXmxL7s3O9TPNmq5o=;
 b=jel2gogDhU7XTfjrPB/f9XYM6MxAPkcSwJlI6GHJ06VRzyEdPu4JDoxkfNI0JWTFXR
 +0mTKb8cqteaCgooQhA+jGfh6TBkaokQKwE3BdjykAbJt/dozPzQizaQBDq5xVQG3+Nx
 C/DU3Bn8HGa6ji3OMXn3ug9uTs6t3ciaYn4nMgqOkmqV+/7Dq0pWYUgo1nR8auwvK4Y/
 0rsvhxPLq2jS+6Q1TcBg+wvDJVijw6zho+IgtAhyZ21ejtYAImoVi2AicijtgapL4QvZ
 8YliubpNsbhMKWVDaObo1Z7rjzt2BvqBSeixsIkAIhBYAyJKLYKRshOtruZ5deOxIAJw
 Zo1A==
X-Gm-Message-State: AOJu0Ywud9HTgFE8TphSsLJNvU1+DnnB2vQItu9IJpHAIhcp/18o8uxx
 2xq6/iVZZz+SCHmF0ED92ZIxXdJY/wenctWJ0kNTLow+AAI5Dhde/ANt8vTh07g=
X-Gm-Gg: ASbGncvbCd1XzcMozjeQeGbl8SN9vTL9i2FkGPduV+76gWyGdEMYHrcZs3p+GxZpNND
 fVavj/pzBqxW5bsuRisx6fza5j50FXDNi+2hP3VzgQnGXpY+ymXlFMcR+BSFn8Anivj7BN0DWiL
 A5oi71k4kaM6qiLYPPxR3B4/76+zwiPi+wEyneBcPxvIEBsTN9xQXXAxbiObA2UX+CDwujxtdKC
 KE5EqrOC+xUSyxmvBMWkMlofd5OqKAYTqQBj8BKDAZdCnCFea9kD/4=
X-Google-Smtp-Source: AGHT+IE4/2Pfq4ySEJaRUj47kxK5lZcwRRaEHxTleq/Q/AxTw6ZlG6fpFLXZ3k90bNBAqyu2QRzhOg==
X-Received: by 2002:a05:622a:58cc:b0:467:5da6:8096 with SMTP id
 d75a77b69052e-467a583dd3amr90766341cf.44.1734131812747; 
 Fri, 13 Dec 2024 15:16:52 -0800 (PST)
Received: from [127.0.1.1] ([187.144.29.192]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467b2cbb69asm2690171cf.39.2024.12.13.15.16.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 15:16:52 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: n-francis@ti.com, d-gole@ti.com, afd@ti.com, nm@ti.com, 
 d.schultz@phytec.de, Wadim Egorov <w.egorov@phytec.de>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de
In-Reply-To: <20241127121736.1525948-1-w.egorov@phytec.de>
References: <20241127121736.1525948-1-w.egorov@phytec.de>
Subject: Re: [PATCH 0/4] Enable EFI capsule updates for PHYTEC K3 SoMs
Message-Id: <173413181111.1760624.3987029525963504874.b4-ty@konsulko.com>
Date: Fri, 13 Dec 2024 17:16:51 -0600
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

On Wed, 27 Nov 2024 13:17:32 +0100, Wadim Egorov wrote:

> This implements capsule updates for all our K3 SoMs for
> eMMC, OSPI NOR and uSD cards.
> 
> We can use capsule updates to update the bootloader on all our
> supported flash devices.
> 
> Wadim Egorov (4):
>   arm: dts: k3-am625-phycore-som-binman: Provide capsule nodes
>   arm: dts: k3-am642-phycore-som-binman: Provide capsule nodes
>   board: phytec: k3: Add EFI capsule update support
>   configs: phycore_am6*_a53_defconfig: Enable capsule update
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


