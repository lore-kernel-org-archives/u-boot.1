Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EAC4C52D7B
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 16:28:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B54A1889C3;
	Tue, 13 Aug 2024 18:28:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TWKs6n3d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0831F889AE; Tue, 13 Aug 2024 18:28:18 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C25D889C3
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 18:28:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-530ad984f2dso546329e87.1
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 09:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723566495; x=1724171295; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3fs3ODJkWp8ZLP2YrmC9Jys1YwnxeaycjFcaE2uH+VE=;
 b=TWKs6n3dLMnMssSXzZud0RQUJh8gQROBlFFf6iYSN3lAkWfuu+C/gKxnYonqUiZ0JD
 js4fH+W47OGC8LUj8A44s7/PiSEhPsnB8+A61RbMZ9mh3W8Cvxj0OjcfT5tl43X9NdFN
 9B8vvwYM70aiGHPRxlMkHY2Vf//9SNFqAYCA4LdQs9JJwt5ZMLDSSlEsjfwIeP6sJpWu
 5qk5bCt5Yu8/bekTbmEq1WA/V9cLkwr9EFpeFeeh+358jYWSNqX5z3GHDDxCKbuygpW1
 fOMSTTqvDu4MRMmaUeJT7TEtCBWf9fctod1fG6xUTFLVFcP93iCbBw74eGKzOq5qlO+m
 NA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723566495; x=1724171295;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3fs3ODJkWp8ZLP2YrmC9Jys1YwnxeaycjFcaE2uH+VE=;
 b=aY08t0KdiNsyRzpzdIrg4UzVbVxfSUY8jxmTmMGGjjIKAwsjcFZYmvSJejA+kBbfmD
 fM7dhnUuHYRjeUvr8uBkRwe6Y4qybKIDFImWCtOpPJEkkA0mnIJmqVHrigZhUvByBDV+
 cVsVNYXXVGC7sl6C4x/1sChr7wDxr+kPla5xyGrDPu/UokwHN4AKBfq3TUwlCFrjuwku
 c0yL0R7+xFz5fd5NzObNqyoXxrtxmOOXMlUUW9nfQ4WxQEfHjoKu3ZjKDSkdzvTFxSIx
 +eJOxP+XnzzwmkvJOlNbTcOVjkAiG2MBLuHi5QDg8MPC3rH88jGvY4+oZVHzgQESB10q
 tNIg==
X-Gm-Message-State: AOJu0YwGdAga7UltduywnZMnACj3o8hsC8TiihsxdOL1iDChKHxO7ZFQ
 2xqPjrz+R27jj9CkYnW9/NHcd5drRlD0COGl0WCGytb8I2Dy4iMgt0itJ4hdl5bwWuYOyjR4IH5
 X9a/qHlP/qWSB9ZGC4s+xPeiGtMS2AA==
X-Google-Smtp-Source: AGHT+IHHQtIZPt4/mjOKOsNkOYQoORT+Z3eHx0beCNzNp3BCzDm5atHB0OehiQK1HXUVuJITOAdCCLom/pitk+DOV1Q=
X-Received: by 2002:a05:6512:acb:b0:52f:cad0:2d4a with SMTP id
 2adb3069b0e04-53215031142mr1191278e87.9.1723566495104; Tue, 13 Aug 2024
 09:28:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240809175809.612183-1-festevam@gmail.com>
In-Reply-To: <20240809175809.612183-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 13 Aug 2024 13:28:02 -0300
Message-ID: <CAOMZO5AqTwM2qGVUw9K0PBMxE4jsbg625C+GtL8jED28Y9zLEg@mail.gmail.com>
Subject: Re: [PATCH 1/2] tqma6: Convert to PMIC and I2C driver model
To: Markus.Niebel@tq-group.com
Cc: u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
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

On Fri, Aug 9, 2024 at 2:58=E2=80=AFPM Fabio Estevam <festevam@gmail.com> w=
rote:
>
> From: Fabio Estevam <festevam@denx.de>
>
> Currently, the power_init_board() function is not executed because
> CONFIG_POWER_LEGACY is not selected.
>
> Convert to PMIC driver model, which allows removing board I2C code in
> favor of the I2C driver model.
>
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Applied both, thanks.
