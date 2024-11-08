Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B7ED5C0C8
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 13:57:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FC3488AE8;
	Fri,  8 Nov 2024 14:57:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m98Eg5Au";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A63C888AAC; Fri,  8 Nov 2024 14:57:22 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8428688AE8
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 14:57:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-539f72c913aso3721716e87.1
 for <u-boot@lists.denx.de>; Fri, 08 Nov 2024 05:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731074239; x=1731679039; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j/qRvoDyd7FZfmFEuHav8tHGT8WmEFSqQQE2WRZtlvE=;
 b=m98Eg5Au8NXOI7d7zvu0FDo1O4qpIR/Z0aNnMPDueFRAoKlUTuMrNNjvxxD5Mt2g2T
 wbyyHKPEtpn3M5x1MBNGrfx3nXRCj5B/F2a5q7OPDiSfH+yQr8bxI02MvtGU/hIUAGrs
 yFSkuMsO9TkIC9buEWkCMvId3MhEAMn1lhibJUSfqbrAPD+A/Ef/nyNWz3OP7Qn7uyJ0
 oM9f9XisMKd6rjABW2l7xFZTJ1bIIgMJgb0+fi0oV9GBGSSqKKsv/5Z7KHtkk2ntS3zT
 i46XRXPr2JxZR0Qb84ZWhQS/uGZg4V38aYkj+bVW2ORzi4MCzIGF0wFEstKwx+qwfcBL
 rDRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731074239; x=1731679039;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j/qRvoDyd7FZfmFEuHav8tHGT8WmEFSqQQE2WRZtlvE=;
 b=wvhIGONmiX9E+e3JNzAFN1VtQzLSZnlSkfP9McP16vQqMtJhZYTP42RHdrkaHB3QRV
 LICdm+tMi+ciJrj5jJ2hooHPSQ4fHlCKwLEGYgg2U63LQiUpQAF8eYscI+CzxlCOv+6i
 iAmfi4dfHB5PeyGNehJiwpht3x8QM1i/qQhIxCAn3HG++3Aim6vl58pJsl4pfVwOndNG
 ryp9vCikZv/ydJGFHyTRq9qH+u7aAnF4JwSHUKi6rEzf4bFJv0K1csfX8H9QdVJgzOqC
 NjYiuf1HC03AzwRoKD1rpw6npB3LlKxRZiMLV5pPPVsvxRLrrilP/l0wMaKVlNsQQjSg
 zEeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUobg87FlzB9NOVAMzueOnxbFTeR7iYnTh60v8M9/2yU4PZv6q5rvCstefbImUACHd5+gowIFI=@lists.denx.de
X-Gm-Message-State: AOJu0YzrQJmDf3EzY23kpbGravF9iI7M48MBqOMud20fTn1BpvS3amgz
 CyJs92LhfmNtm0fHFxbLX65egDtVpAfLPfiPHsqVbutCWbkAn/mhitM0Gu4i3nKyPjZrj4tJpqm
 7s/8sfsISoQ+/MuKhXYRBc7kGuJqG6A==
X-Google-Smtp-Source: AGHT+IHy2Ylc+UAR2mB9+wtuZ84xCp7QfH6KwC7xhGezEO9b7fdH17sOJteJCXLj0PeaOqWLzzCooQzYIIjUhXLKfw0=
X-Received: by 2002:a2e:bea8:0:b0:2fb:5ac6:90f0 with SMTP id
 38308e7fff4ca-2ff20307759mr13789441fa.34.1731074238619; Fri, 08 Nov 2024
 05:57:18 -0800 (PST)
MIME-Version: 1.0
References: <20241108111052.4-1-ian.ray@gehealthcare.com>
 <20241108111052.4-2-ian.ray@gehealthcare.com>
 <CAOMZO5CPT1o6Fba1HNLoAXdFrKNSRczmdRVTuBs+eS_DikcvBQ@mail.gmail.com>
 <Zy4XwU-nFavp2lyQ@f642ec5a18a7>
In-Reply-To: <Zy4XwU-nFavp2lyQ@f642ec5a18a7>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 8 Nov 2024 10:57:07 -0300
Message-ID: <CAOMZO5AkHg_qZ=NgaMbf+Eqhm-DoZvqFkEarXn7_ESpUimOPOg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm: mach-imx: imx8m: re-use SNVS init routine
To: Ian Ray <ian.ray@gehealthcare.com>
Cc: Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Fri, Nov 8, 2024 at 10:53=E2=80=AFAM Ian Ray <ian.ray@gehealthcare.com> =
wrote:

> Hi Fabio,
>
> Would it be ok to reference 723f8359c144eb29f0fb07291f9a2294bd2a3fd6?

Yes, that certainly helps. This commit has a well-written commit log and is=
 very
useful.

Feel free to reference this commit and even copy/adapt parts of it
into your patch.
