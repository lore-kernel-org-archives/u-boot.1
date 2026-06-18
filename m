Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD78CD98F0
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 22:37:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDBC2847C3;
	Fri, 19 Jun 2026 00:37:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="H8PaZ4Ey";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E4D3847C3; Fri, 19 Jun 2026 00:37:10 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 349F5847C3
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 00:37:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-43fc82b52afso995955fac.1
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 15:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781822227; x=1782427027; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HIj6YLeP5KiJI0zN5ticKJM3hCzHf6UxPG1Uss98B6E=;
 b=H8PaZ4EyEQXA2gpJ20d8JNP8fnZKFagYQdfIR2FrIrWV+6OWkxBKtD0BVX548NG9IO
 bUBKebaYuzm6tzFWwNyn5WdatSooRzPttwSyxoME1yGBKQdGIh9ff0QnTn7z5w+3/x4i
 /u4Xxji49dPOngrt9n6UYnjkRnOcXB/p6eiYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781822227; x=1782427027;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HIj6YLeP5KiJI0zN5ticKJM3hCzHf6UxPG1Uss98B6E=;
 b=KNyWwDzUkWQ4nFy1b1I5YPKc6sIC209UG4ZV7VdMfvUiJ+MbvETorzWObPDfv/5JKH
 M3NxA4M+Q+JjX8UU/h7pDAdSvlcC4V5aGqnoV0yBHHgZiMumAZ+iOPexxmoFrckMxPaO
 IVh3cItVmkKl+3BXk0wAx52SKAZcIwk8es/VqhAovx+xibgH8JnGcRgZrUqgHyXpk+/S
 AzYRqRxdhj5G+5MKGZbovF0frWAgoAG79LNNBJ7q6ZQn6PtKNUMQZ0Ti6u4hBW6Tt01o
 MY8JokI7x9ZN0TkuIy2hNtEg9HaZhTqONlm1PcH+z7Evoxc9IsirmwGeUL1Us/lluGt6
 z8iw==
X-Gm-Message-State: AOJu0Yz/Zy1wbLAye3Qc2s5I8w76npvJ0MABgyKJ0nr/DVsR5HznfsbV
 CopBDWIyCtJGL3ByclGEy/9OHDx3iihX8hEANB5bhXMUmccS2h6Fa49ZrSmSUssftVFXYlTXtJY
 YAs8Kwuc=
X-Gm-Gg: AfdE7cmq/udJtpPV0NolN0/OQS7fCGI6CEBxYBHvEaxtu3J5kWyyOsUgspn1S1YHs/9
 /SFr5kN+nDWs25OKeTEC433QF39K7a4hV3PR5xfmKFarbbM5KXrwCHrVf6XVzWK+6ocg3alJfX4
 vKHNIrYHUbUTmegSWhkQeZFyG8Tuvtxx/L7inkbm9tOWllZDalJ1d0KjlAuzyVxF/tVkScoAngL
 6pyGNlw+Qo1bNtfK8GwDBMxlH/PwCx3zT5xzkJDdumanlKpfYpVZmxU8LtfZ6RQOA1hEQmajidV
 6LOZ+dNLhN1H8Db47fQooEYP9gDxnLZ6LTE4idmJhZ+DLTYzvsaQgDv34RamskjI4Hkrcl7v6Yo
 G4louhMcrwOY0OtWtUvMmpdECfJXVh7otMzmCqcNRyrn2ZIYnP95SPAwzIdcnVs8jyF9yANb+Uy
 rZU+/Ee5eBo07I2i1oLgUpwh9598rBIWxcK3dSewLkJ9Z0YQ433flaz+VmNU7G3XFKR4GgFYFe7
 TUhKPmiH/hbn3Qx/c6Z98rwSGHAEXyBwArfXh8=
X-Received: by 2002:a05:6871:29d:b0:43d:5d0e:fa4b with SMTP id
 586e51a60fabf-447072a78e7mr1253205fac.22.1781822226934; 
 Thu, 18 Jun 2026 15:37:06 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-189-154-245.totalplay.net.
 [187.189.154.245]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44709d2ee07sm700520fac.7.2026.06.18.15.37.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 15:37:06 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Peng Fan <peng.fan@nxp.com>
In-Reply-To: <20260618171352.23873-1-marek.vasut+usb@mailbox.org>
References: <20260618171352.23873-1-marek.vasut+usb@mailbox.org>
Subject: Re: [PULL] u-boot-usb/master
Message-Id: <178182222625.2736082.10995763046892135083.b4-ty@konsulko.com>
Date: Thu, 18 Jun 2026 16:37:06 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Thu, 18 Jun 2026 19:13:41 +0200, Marek Vasut wrote:

> The following changes since commit a7830e87555abfb81cc69275cecb2bc0fbde5b28:
> 
>   Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-sh (2026-06-16 17:39:13 -0600)
> 
> are available in the Git repository at:
> 
>   git://source.denx.de/u-boot-usb.git master
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


