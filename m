Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9165CD5BDE
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 04:39:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26B22847C8;
	Wed, 27 May 2026 06:39:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CZ2ACF+F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8098C847C8; Wed, 27 May 2026 06:39:35 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DCC080433
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 06:39:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-bd22b2abaa4so1803030066b.0
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 21:39:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779856773; cv=none;
 d=google.com; s=arc-20240605;
 b=k6ezDr1AvaYrcskQzNw3ugXzyB2Goc5nudYl0iVfWcbie9dpmMTwT9ZPpkWm6Mltl1
 GUa/NUxqmesoTQ0zt32ttmPPoWARDwocxQyKM6DcMiTJDN6d9/sUJMSbDmj/CwVUIQRr
 mKtEksIKxY4JSQRAPN6I9or5SEr6ro/cVT83/0I19oMV0JYqHXkh6kYD13H2rPwHUGcY
 1JCyGLnlWV87H9f0OF0uyq6xwghrYfLrRWqxocmiXd3TecngxvsNfC4xzNIoGeSK+x5T
 m3S7gbX36RAiDpxOX09nKarIRnzwbVvouszyGUt/CjIp7SAr9Nb16k3o9AFB5dgjGben
 dxDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vwuG+NIEWIZNl/d05QOQvRLpJJRJG5dy47C6YQAYCvQ=;
 fh=7IjvY/51cqAEXrTdD2DGzrmZRD7iLf3/P1psa30JT0U=;
 b=FB/9XvvuZ7hagtLKFKxOOca+HoTmaeKatlCSLT9ponTPTU6vEwYuboLwXto5UVBXHO
 otJbVbIpOvZVmPTI7F4+QxHFevLT37hJx021h+vUukRtbh10BD2asodgU2PLbx/NcPlZ
 Gr0Th5yLInfev46QOs2YQMJyhfdG9hn3xjLYc/wtFgFK9MvBuZ/ZRGHeZzT0IyvpHb/9
 QSWf4KVr2SQwVw+Pv94ho1cnQfAQ4yEa5FYRm7IxQS0XauOvP8qHJbGV1f5IiMyD1EMA
 UIzNtv/49zu10Swj1TM+V/Otlkp7HwGzjxrR4o47+Yj90uIiqYAGdbtVDS32KOy4MSui
 MHhw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779856773; x=1780461573; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vwuG+NIEWIZNl/d05QOQvRLpJJRJG5dy47C6YQAYCvQ=;
 b=CZ2ACF+F/W7DbanaMVJ6pT6+/Whu+JbrvxCZ7gThniLoj0XwY9tyL66gds6cCDujmD
 jGHe+er76WjHKzWWYD+iMR8H3ZHGDrbRzW1+Z9LYfJH0RgqwgHcBlzsN/zP9F5g3WHz5
 or30I8dpOny6pca3UiVfobMycmOJlB4YFqThA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779856773; x=1780461573;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vwuG+NIEWIZNl/d05QOQvRLpJJRJG5dy47C6YQAYCvQ=;
 b=Mz5gNqYT559aLxDAm1b0G7KYxa2cuy0QCwbbRUWD4mUFpRILuDejhypVkk/sX/zQwh
 lvN/ZYYFIi+xqoX6l/t33QUSERTHCcVktCttI580sSFfsdYMCz6d9MXi72GGngLZW7f5
 1FAJoiufOzZQAthGoqGeT/aPocpmRrL7vCzkbHV21HYvbaZMBW8Pmo4MKDKxLN28QZq5
 uzPQIp442fvzD0jyDuY775lIs5OImKowuPZtS46V+JfY6SvdQAZsiPH5cv96XM+ITxNs
 xqRQ7L7Lrc6NfwZyBy+wm7nB0ehBLwz6NLyPYvDoKMXSyb9hnGsY/WgX54dmZM/IEOzV
 AoCA==
X-Gm-Message-State: AOJu0YzibK0bC1R4T3cpBsG/DjuJjePbC9VtIEW+kRTN8VrPzhwvroob
 rhyjfk1idUn1FbxDNcmI8qv6r5/esrKcOVEoCgbSZF/cP7NxqD0KD7hm3dC652KR0NPJ5AtecU+
 abgUmtu5bH0XsSp6RjYbgeE23ziP8i6vEwS3YmVyG
X-Gm-Gg: Acq92OGxWhFw1DrlY/oMeZmxf+r6VKyrthzt7dIywrgLv/XDuDqzI3Vg7lM/bV26zpQ
 IDLscoxp7c5xgxn25fKq5IUqp8Jjc+OFviHEE1CYM6s/e6AX/BbyZALO1c14fXBz0gKuWTksugE
 Z7evbIySGXr60qI7+GtOJ6IoA/kUV+o/+Lm0Ii/dpW+apmQpmR1zBha2W6ef00lFMKDSisSlTrO
 affqxunV1iYwOxVJJG92L/eBJV9eVNo/nNlPruiW2yFbsrff+7yQuJQsZmuxRz2pnWXcvqxNp2+
 IC56r17hvif3sKfH
X-Received: by 2002:a17:907:988:b0:bd3:6a05:459b with SMTP id
 a640c23a62f3a-bdd27cc7978mr1141920666b.34.1779856773105; Tue, 26 May 2026
 21:39:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260213112717.1256823-1-aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20260213112717.1256823-1-aswin.murugan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 May 2026 23:39:17 -0500
X-Gm-Features: AVHnY4IUrYAysQUZ5ba7B47U65lLAx-emKzt5CujXCipoS_wC3Ymlhj4FuX5JPQ
Message-ID: <CAFLszTgPMCKNdkxarDD8YEFng8N9KEjJQ8G7hcpiJ_D0As++jA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5Bv2=2C0=2F6=5D_qcom=3A_Add_NVMEM_bitfield_support_and_re?=
 =?UTF-8?Q?boot=E2=80=91mode_integration?=
To: aswin.murugan@oss.qualcomm.com
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Aswin,

On 2026-02-13T11:27:11, Aswin Murugan <aswin.murugan@oss.qualcomm.com> wrote:

> This patch series introduces bit-level granularity to NVMEM cells and
> adds complete reboot-mode support for Qualcomm platforms...

I see there is some discussion about stack-smashing, so will wait to
see the resolution on that.

Regards,
Simon
