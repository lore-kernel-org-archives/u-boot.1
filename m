Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 418A1E7E638
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 14:24:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68B3386E3B;
	Tue, 26 Sep 2023 16:17:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="Rkibns+B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39C5586E3A; Tue, 26 Sep 2023 16:17:00 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57BED86DEB
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 16:16:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5046bf37daeso4898651e87.1
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 07:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1695737817; x=1696342617; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gHLahIhVy+gr/E2nvBddjRdhSDpQjh4VUz630IdjNrk=;
 b=Rkibns+BKU8WVlewra6eKYz8ca3lmQ8tigsGpqLJqiA2Fy27gDe/PzKhnGeF+0ZuRf
 rLfqOZ3g5YslP89bVuj0D+OxW9OSyMPlFD4UwfEr8/hDeR14LfVsDgPrRvLqiz3Tm2zW
 o20s9LbV6/PwkKsU6D2KMcVk21iFpp3iOmVK+alql5mt0MftDioXi268OPS3oMXg3X4+
 R5Mlgh00za6bcNSnKBGflQnYNQnSVlxghpY4uWph6WxGkNPdwhDFDSoHJn+8lxUaZlpa
 qPttDROBK8WnGvCBiPwGAXmzEBUmnOKINbw6C+E5x4+hVwDFz6K9Tu1sI+OTga3dh8y7
 m/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695737817; x=1696342617;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gHLahIhVy+gr/E2nvBddjRdhSDpQjh4VUz630IdjNrk=;
 b=kLo3m0iAN6Yi1yykmr0w3MfcLJO1tMdaX81NXifaNaClrCEMMqLzDe8zsYWdiXPBga
 bTFeAq1pGSgT476xtwqrVf52t6Q5MPjinGksGZbjIeDBVRs7D4j1wKCs2+im+Cuab2G1
 PiWRyqP3A9grNTbBCCGeokYeFFfT3g2Urd+4Jca9RCP2m1/hENSzapMZ4siSocjZ1BSH
 rY7Q2fhPSFAwql/flYgitnhkToVDcJeiL3ccNhpP2SQVLBKxFvxsadlE8UQl/pOaoX9H
 aHhoa7zvgtavHM91MXIKIcZP/I/p1+KmzZ72F2j8CUCJ3aO3tfOS1+6WY3IzKnc5YM41
 7ARA==
X-Gm-Message-State: AOJu0Yx8aq8whePGBfEBjmAshMuf5Yz45JrniOU0C+GM6Llz9I8KpPzs
 ZmmDDUZPEMoGdD1Q7rwi9rYwY7KtKU+2QpaakSRpAA==
X-Google-Smtp-Source: AGHT+IF+D2E1N4l82io4RUACmOL6uIbSjUeGEhLct/0ARuPi/dwj7jlR4NJEIHcuE5vT+1I20x4GRcw6K0i4SJ/FCCI=
X-Received: by 2002:a05:6512:39d2:b0:500:7f51:d129 with SMTP id
 k18-20020a05651239d200b005007f51d129mr9159263lfu.34.1695737817342; Tue, 26
 Sep 2023 07:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230926112443.4190471-1-u-kumar1@ti.com>
 <20230926112443.4190471-3-u-kumar1@ti.com>
In-Reply-To: <20230926112443.4190471-3-u-kumar1@ti.com>
From: Simon Glass <sjg@google.com>
Date: Tue, 26 Sep 2023 08:16:46 -0600
Message-ID: <CAPnjgZ3gGZORPUg1xnvRJtgnUfU7yxXgnepUWF02JQr8U1aCZQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] test: lmb: Add test for coalescing and overlap
 range
To: Udit Kumar <u-kumar1@ti.com>
Cc: nm@ti.com, vigneshr@ti.com, patrick.delaunay@foss.st.com, 
 sjoerd@collabora.com, trini@konsulko.com, u-boot@lists.denx.de, 
 xypron.glpk@gmx.de, michal.simek@amd.com, dsankouski@gmail.com, 
 kettenis@openbsd.org, sumit.garg@linaro.org, sam.shih@mediatek.com, 
 mark.kettenis@xs4all.nl
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

On Tue, 26 Sept 2023 at 05:25, Udit Kumar <u-kumar1@ti.com> wrote:
>
> Add test case for an address range which is coalescing with one of
> range and overlapping with next range
>
> Cc: Simon Glass <sjg@google.com>
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> ---
>  test/lib/lmb.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
