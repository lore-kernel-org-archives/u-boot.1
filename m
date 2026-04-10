Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 546E7F45A08
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 19:57:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 411E884106;
	Fri, 10 Apr 2026 21:57:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CkbHPnVe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6876E84118; Fri, 10 Apr 2026 21:57:45 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7298F84099
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 21:57:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5a2c9c5ff87so2599452e87.0
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 12:57:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775851063; cv=none;
 d=google.com; s=arc-20240605;
 b=iZ2Ia8t+eHt//ZLf6SuVro+1X6W0tiv+1UMBVmofwMb4zsaB8c6AMYTobNheS/sEUi
 i77WFbTock3KRGc8F4La3K7LkHqOBMSh3hx6ZuElpEM+FGod8KS9OA0APuvNfWLwHnQH
 67+duErhjd/sPwyM6UgIGAGPfkKYzIi9hTuyKetsE0BX7vPZELfPGqFt4KozwzdacEMk
 w2GCyaVLOJCs3ZfE4vW6hnFUccILmHYoTEWanfomEsAGjI0LmVKVsarKEJvoi7j8AG6+
 iAhMY+5qKi1dfJIz0146CRWnJIrPgUKeUObyMASYNeN4suXr8gAu/UUpjjMvViuxHwJP
 9XtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kCpdDZ2uRLIO190/1md0Jt+45QHWEv3VFww+tRv1ns8=;
 fh=2FLmbSrPDvR2nY8bfRP3LQgw3xuJcZzh5P+LDuiXRZM=;
 b=HqSdjRTpU/bbniO64BYHQxryDOxeqwIjgaQjCx+QS14oQklHI3Ud1b/f5V4OQILMz+
 Cxequ3xh318/2eKzauVqzDDYqx1CW78T7DRd2aw3DMpp4iTU9w/NvY51kRzXeLv66R5V
 tftkm3XGKH3e6vaRn0WQOMj0PxfQJJB4qUk3yHvxV4nVJ3iFCOzZeZ196N9QjzNMIUXc
 6RpdD/SMmi0mrKecNGbntW7J6SAkmN4d8gS5zitY6FlE8sVQUE/PC45+OqcC82585nqm
 UCt3vAN4Ogzw0GJYPA0hKcu5kHdhJ5MS1f/FBbzVoP6mD1JzIxduWmtaxNLana31QpB7
 yNZA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775851063; x=1776455863; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kCpdDZ2uRLIO190/1md0Jt+45QHWEv3VFww+tRv1ns8=;
 b=CkbHPnVeaiU4vy91kllgnFhmGCSRhsfYZ1WNwl6W61csChlm0YGUzV/QUi2urJc4iZ
 Ae91jOhcGzdknKKoqJJX5vTFvnKVdKn+lkLQDETWnCBFbkvCz9yj7csNVlyAPPfBOvqs
 qb+TP2mtYBNa2wR9nhQsEgObIrqjLD3BCGPeo+6upkyVQhmRjtLFxfb/eu+ktemRRACI
 fJckzlcuzJe3Q8UAMKBbZCsUZKiSOUZ6UxaVK/a6oxKS14iazUN9k3wqCBtSmc4CjJlz
 MLkRPF0EStT+AYGZEoKPAm8LG1uGf7LbIKVKbhZp4p0FU2/FRmu6djVvpxLDcVr+YKeU
 Cnrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775851063; x=1776455863;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kCpdDZ2uRLIO190/1md0Jt+45QHWEv3VFww+tRv1ns8=;
 b=NmW2vMYpRdlhPIDbyNkfZTYQJpYPSjJFvfA80wMyVWNtrwPzekIRGP4GqgUmwfleqR
 vkN6fdIfziTtDUZbX7ywkR5eeOQU/eX7k+DXAbuk1DnSZbORU4spkMJV7ga3qoj+d5DZ
 O9tN4u8KxY2PsijJPRjMGmMnfC5GfexOamrNTMWAG20vIlxT4bKIVl7hz9Thm7bGXhub
 1/oNhfZcafZxyjED01bOdpJ2tGYF1etqt9RtoZqdhUVscqIpen+ZSViZRmFjqGpijU0G
 eJK14vroL35t6WaA1g8W5vBrQekT6QdLA+/U323XG35R/fleZcbRUMcHGpm0OTFkEYwZ
 ZA9Q==
X-Gm-Message-State: AOJu0Yz/1QxFka8IuHL8zlhddbzDFEvmAAOWT5jSZz+HbMktfeM2mLEw
 HbLV5Rcxo8d1QbGb+uN13W7UeB7Ptsg3i7a9IYiVbR5OryEfaUCkGGIm6MuyKAVXHe22CyXV2Xr
 2mAfCnDQ0R1e1+H9CrqJRaUKLRsj1W6I=
X-Gm-Gg: AeBDieuKwScBpaYCzxi1LAu2CGZna+gJpyysQ54Ltlna4V/FGHIXWexDWU+Sjtjr5ZQ
 X6YUKC6WUIwHW/+lvyPh5BL0Ja+kxwnpjQs4HbQ8DPyT5RTKBagyPmvgeNQviuQCF+B5EVmEc2V
 4LbGWeQB5mBohk6TL+E9SO9eakrMyXXkXHHvjJI2EOzNvnPc8s0s3RdG37JHZGJKi4v0jkay1lM
 Fejlt6fNqBP4inL6AY3SQyiOGk8Yl5whBtSV9r9svbuWIMn8CGFgyg7JSeT4fF/lvd6wUSd7MKr
 4nFNrKhlAQngJRf7c2vDhop5wJXtoc/ix2EhbL6m7vS79CujznFW++OmTtLAA25xE5xdcS2p
X-Received: by 2002:a05:6512:3d88:b0:5a2:b4c3:d88c with SMTP id
 2adb3069b0e04-5a3efb43b47mr1577493e87.15.1775851062283; Fri, 10 Apr 2026
 12:57:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260410-topic-am33-evm-oftree-v2026-01-v5-0-4b9c7aca0e3e@baylibre.com>
 <20260410-topic-am33-evm-oftree-v2026-01-v5-12-4b9c7aca0e3e@baylibre.com>
In-Reply-To: <20260410-topic-am33-evm-oftree-v2026-01-v5-12-4b9c7aca0e3e@baylibre.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 10 Apr 2026 16:57:30 -0300
X-Gm-Features: AQROBzC8Cu-hdM6p1tigUwbIq_FyRs257cD4_UxbnWEEBns_2_atRGHkRdO4Cx4
Message-ID: <CAOMZO5A7EG1KUV3jebrX0jQ8CvJ_QJxS4dTk5KQH0vLHk0_3VQ@mail.gmail.com>
Subject: Re: [PATCH v5 12/12] configs: am335x_evm_defconfig: Switch to
 upstream devicetree
To: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Cc: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>, 
 Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Kory Maincent <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>,
 Parvathi Pudi <parvathi@couthit.com>, 
 Basharath Hussain Khaja <basharath@couthit.com>,
 Paul Barker <paul.barker@sancloud.com>, 
 "Andrew F. Davis" <afd@ti.com>, Simon Glass <sjg@chromium.org>,
 Anshul Dalal <anshuld@ti.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>
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

On Fri, Apr 10, 2026 at 10:34=E2=80=AFAM Markus Schneider-Pargmann (TI)
<msp@baylibre.com> wrote:

> -CONFIG_DEFAULT_DEVICE_TREE=3D"am335x-evm"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"ti/omap/am335x-evm"

You should also remove arch/arm/dts/am335x-evm.dts as it is no longer
needed after this change.
