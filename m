Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 141B3FC72C2
	for <u-boot@archiver.kernel.org>; Sun, 22 Mar 2026 13:28:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A303840AB;
	Sun, 22 Mar 2026 14:28:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EsNcL8av";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4337C840AE; Sun, 22 Mar 2026 14:28:14 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EDBD84065
 for <u-boot@lists.denx.de>; Sun, 22 Mar 2026 14:28:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5a12cd0bcd8so2921415e87.3
 for <u-boot@lists.denx.de>; Sun, 22 Mar 2026 06:28:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774186092; cv=none;
 d=google.com; s=arc-20240605;
 b=FV1Ds8KJW+3qyxSxf8wwBRZ6m04p7XVaSJrEpNvDYMFi+/q221F27k9xcx50tv2mtr
 ktj/LxEjdcTnory2VkUc2wMiqKSm6Jfv8xa6NT/jX83C5UZfENllqKDPOzmASEBkM7N6
 PXhG1e2rqdw44zFUDNHy2zKDENOF2tGrC2dP3V8zwyvIWWUJECrXpJ56GjXlIy4kLFSR
 rPvhGwOhIwfUO/rOVfAdTk0smgaNYn9GLmHBkIFP/dLUDBxz7MFXxTdK+Rbimrbxualq
 yl4ZinOHJBQvoawBlWuQVAro/Ho8tSix4CeTgNIeYi4wFf/MTNMRiLSCtrGql+Sm/LCV
 WSjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lV5smtKM4tXKDGAOCtKYzswnHDOSnu+bgDdxO48ocos=;
 fh=P2nQOsgHXi2YO0MKUzW/9eVqemt/fXTTysg0HlJnyXI=;
 b=RRqJg2UulBg93flXLGddQ9zHcufHC92bhD2T+3GZF1v33unrMWdyMThRp32QlHCMgc
 q1X0ZX7CUde2C+iatB4FuXi0kGxovc+NUPHo1dHhuH+w/0Hir6hMA3ErO2DUgapg8wj8
 IyiaVaVKTcCKK7dValZv2JGo006t3KzV6bp87huW7QKU6FWfifiGETVO+tqZW2RdkwYg
 aM/j+7AVfjpSPpxtynMtvYiLKkzLSckEC+iL9XqLrIWT6YAHWTvhTrkVwe5eQ+hf0tka
 OMki/fsvaYK4EEe7YgEaZgnuNE5uuHIEqkLVjn64tGmZ/DBvb3pp6xuLdeu+pxnRqm1B
 6xKQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774186092; x=1774790892; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lV5smtKM4tXKDGAOCtKYzswnHDOSnu+bgDdxO48ocos=;
 b=EsNcL8avd/cxJjFHpRBuhrAeR2O7CzQMX42o7YtqMYsfBsHP9QyFNuBXJJ2s12x6b7
 FhmUTiq8qltzFi5VNpu089cRMnUVplNEMycgA7WTMoTwSkKdSMRosY/RRQAreTTY5kw6
 +gJKsL3LwjoTsWjUc6r+GoyPfQRil3xHSGLT6JHnrjRAuyauzziEmQuee/PdDHqahzNY
 HUa96W1tE7SPmTMi4KbpmX3EqeXTe2gBehxF8gYAKbhgqc+vA6lswO0Z9cY5QgFIVNcn
 JG23dCHK4VjFoZVI8sGyhsmooma9zT9tZZKm1IfSbBnidQGypyzbOxc5DewgKh7KjU0E
 PrTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774186092; x=1774790892;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lV5smtKM4tXKDGAOCtKYzswnHDOSnu+bgDdxO48ocos=;
 b=R4NQsw4DI3Svd5rgZRjc54h6gAA1BnuPmmgnN+roeekTi5uSwiVAVG6xGwF4CLO4TQ
 5TJWAsl0/yjeRNZUPDyaFedLBGvHiHsh13tfDVm8WDVAZeog3bR4jBaHR5q7iwtkWmzs
 n2PblihQq4d4RUxdWXdrLkahnAiFu6sHF3eahjtrptWVE18PmZWMZUWYUROs/9fu1zxz
 JSSksWRTM0Sv9bBIKQQc3p3UlCb4NV4Saknk7A5tBM+fP0nqAS53VPtM8TizsQWDiDue
 jcvXeQcwpl0vnE5GGH4hiB/IQnu4OdSnE9LDEakitKsXLX6PPoz86hR47ZTvT+c5CImK
 7KVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoBV5P28Ijsc16vG7ZhVeZUqN1JwuldI/mk8Kcw8JgNZjt+cLNdUn3OIEMYUY6U4ewqYBQGwo=@lists.denx.de
X-Gm-Message-State: AOJu0YytFHW5EK4eD2LKS/2BG7OC9lmDrWAluQMMNjl59cnNO0yqNU6H
 hnx3aT4QaQX6bFREaC9wSSUfT9t+7ufKO3sE4N7aYaqwuHJhSM+2z5L87AEAKjn45YOQCpE5+Z7
 GBNfcn3HeDoPDUS40eOTJSCtE21OExqSlxtdE
X-Gm-Gg: ATEYQzyEMuNvONu5OlFuAb2JDYeoKngm0tolOLVsbrjvCkVH2SQliH/3Ca/GCGuwgN6
 rLBf7kLj9yNm8Zw46KT6Kw35KcqgGHbDTBgxrKrVw0rNfi0aH9neE0g2GvUzYwVYo78ptXLMwEf
 spPeDyYb4855MEaD0knoVMItz4kiAUb2abJzNeog3nxgep6d15EognBGSJWcMphPXaeBGLMat9N
 zpPUhpPM8FI3BySDl+i6CpyQbK0Tcl3Gqu23axfMXuCZV+u98kfW0/lygOcxYT0qfqogyqhghQy
 RBXpek1At34mmyP0K6LzeSZHKpI8SvlW+BUHFZLixS2lEYK6Wuqe+AvHwMBLcIr8CZ8r2Ck=
X-Received: by 2002:a05:6512:3ba0:b0:5a2:7ab9:e138 with SMTP id
 2adb3069b0e04-5a285afd6e8mr2617092e87.11.1774186091489; Sun, 22 Mar 2026
 06:28:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260312095711.3219756-1-Max.Merchel@ew.tq-group.com>
 <20260312095711.3219756-8-Max.Merchel@ew.tq-group.com>
In-Reply-To: <20260312095711.3219756-8-Max.Merchel@ew.tq-group.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 22 Mar 2026 10:28:00 -0300
X-Gm-Features: AaiRm50k4W7Qv16vislDSdj-sZEnEAVRx-gdsOQKk9hnIcvuotLm4UTq0TlYJ0M
Message-ID: <CAOMZO5AzYESXpMVTRmyC1xc_BMOzaKEhk+=iezfuqJiRWG_=OQ@mail.gmail.com>
Subject: Re: [PATCH 07/13] configs: tqma6: change to include tqma6.h in
 baseboard headers
To: Max Merchel <Max.Merchel@ew.tq-group.com>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Mar 12, 2026 at 6:58=E2=80=AFAM Max Merchel <Max.Merchel@ew.tq-grou=
p.com> wrote:
>
> The SoM (TQMa6) can be used on various baseboards. No modifications to
> the SoM files should be required to use the SoM on different baseboards.
> Therefore, the SoM headers are included by the baseboard.

"Therefore, include the SoM headers in the baseboard."
