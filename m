Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE7FAD5C0C9
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 13:50:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 168DA8907E;
	Fri,  8 Nov 2024 14:50:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bv4ev2Mb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28B6C890AD; Fri,  8 Nov 2024 14:50:52 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3ED7388B1F
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 14:50:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-53c78ebe580so3358747e87.1
 for <u-boot@lists.denx.de>; Fri, 08 Nov 2024 05:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731073849; x=1731678649; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8bes1HS07N6dO5cSP9+y8ncn0NuA+U2oCQdE0tHeqUE=;
 b=bv4ev2Mb/2DtVygKd1duNXGBG4sTa6s1KhBWLKq3XX5SyBdNWwet/enT895nH/47EQ
 0VP1yMPDJhm+LRdyH5MJsu7tLgON96fRcSnp2IqRpTzqEhRLXJNglB9YsAA9T/sEoWaR
 eUarITu9TIaqG48++A9lSs7hsYgvcBr/zVzRbJlBPgJHoLxWu2pMWy4MoUZQTmUOV8bv
 9OxNgvAOZ4dDFlDQjbhYAoDkEgDC7aHYPrzAjnSTOJ1h9fyLrY1sCU9GVr5dFyBriitM
 5expOyCrVD0A28LSHQUqlvNlJpS7xRJSma56NDTho0/9IoYVHiD3C1p9PPaUPHV9ruEC
 5zJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731073849; x=1731678649;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8bes1HS07N6dO5cSP9+y8ncn0NuA+U2oCQdE0tHeqUE=;
 b=OL+7neZgiUmqDGRq07OuWEfTI3HR1Wf5xnrZ/UoY2zDkgitbC7jikSQ5VzxqW7sWPV
 hozdyQKsA1dFqnOpkIVToGBc9ipS1RZv0Q3uWd3lgVVIa6Vz6idSl854OvgzJg/LlZt5
 UC9lm5eCqaQoiUCVVQU/Z6DPAswSmXRGvoJzzot9y8BoMSwlXGWyuIondiWP7ZdRpBwC
 wsf/m470csHYpBV0iLZYvPk6iE+RySrIVcZC/MKoOmZ16IcBV7/9/sDsn+f95/TOtrAM
 NQ/MYY3VAeI03jqxrV4fqSdD7YjbL2IRjjXncyH6narqlE6OvRRp8BnIfyPfji94fPrb
 dOqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpElXuVH9WQcGpGeJecY+fRTEIyew1eBHABNVJDtWMQGGegYtQxjDoLJG7Guz2yRy5S4jbN0s=@lists.denx.de
X-Gm-Message-State: AOJu0YwKHVlK5n5D5xqfprDRY4E7zh06n5/y436Y+1QQX6tGUTAy+JhH
 LGHJLY+dqecGloKukmb2ygJLqYbKLRzaUUqPezhZuB1/kaeFqVuQYgvZWSvAcLDnxKAgrmlDRoq
 RCiiXI8w59oF7fPCpLIDcdLt4lK8=
X-Google-Smtp-Source: AGHT+IGI9zN+/4ORsEOphmWhRlHcsOkVZCx2frwL9B25DBgef74GS4K9jaLuSaLznvx2vDuA1xncK/XSO0WmOS9PA9M=
X-Received: by 2002:a2e:a58a:0:b0:2f7:5ca2:6d10 with SMTP id
 38308e7fff4ca-2ff209deb79mr10908391fa.15.1731073849189; Fri, 08 Nov 2024
 05:50:49 -0800 (PST)
MIME-Version: 1.0
References: <20241108111052.4-1-ian.ray@gehealthcare.com>
 <20241108111052.4-2-ian.ray@gehealthcare.com>
In-Reply-To: <20241108111052.4-2-ian.ray@gehealthcare.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 8 Nov 2024 10:50:38 -0300
Message-ID: <CAOMZO5CPT1o6Fba1HNLoAXdFrKNSRczmdRVTuBs+eS_DikcvBQ@mail.gmail.com>
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

On Fri, Nov 8, 2024 at 8:11=E2=80=AFAM Ian Ray <ian.ray@gehealthcare.com> w=
rote:
>
> Allow unpriv access to SNVS LP for imx8m and imx8mp.

Please expand the commit log and include the rationale/usecase.

Explain why you need to allow unprivileged access to SNVS LP.
