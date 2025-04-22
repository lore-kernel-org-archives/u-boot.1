Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2563C369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 23:39:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CD62810EB;
	Wed, 23 Apr 2025 01:39:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hvkATFlV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA9B280F9C; Wed, 23 Apr 2025 01:39:45 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81CB280FEC
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 01:39:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5e6f4b3ebe5so10561281a12.0
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 16:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745365181; x=1745969981; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=uJV9Aj9Vk5+wGZntinc5u1XMxWMNocXCYwwBzEBMJzM=;
 b=hvkATFlVq32PlPXOcHZnQXiZXCcWlIK6qlHGiviyI0FodVVcukmfDvfsCOpEXTSS6l
 6plnqhYtTjO7sNJZaltF+Ptd+9WemFzfSEDznVgfng3FhWupycEJORxVxEheVg25mwkB
 M94WDBFdtsndfR0kBPVdgR4KB4CKwwrXciTvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745365181; x=1745969981;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uJV9Aj9Vk5+wGZntinc5u1XMxWMNocXCYwwBzEBMJzM=;
 b=Dq+7MFeH4eMY4uQFvk/a9+82FD4EDZ3m7uyBuo07jHBPpEvuUk/yqPuwJ8n67stnEW
 wWR6+bp5PF6W5YI+MLDDjaeYr4ow96YkvZnvClc4a2usZrn8iIDoBnA7nLVaztnt5KqV
 gqCMkVWBbLj2Wg7dzaid3RcswV4Pg4XMX7yCNwvmWponCOvqKZfVzo9urpS6ANkvKiB0
 90a+OTS2Am9Enh3D3Uez+o4wXc0k1VOzIA/vqael34WRxK7dcFux03cQIRCl6AZgoAeV
 B7JHjvmNDqTwR6nYucM0CaqmrRMdLvpsMZzPAwxtttpUzOwHqCbjYjZDrBQbl/oT73w4
 JGgw==
X-Gm-Message-State: AOJu0YxrIV0SCmpU1+Au6iZ9f/FzfUp8eAm5shJOzELuHrPEuhxR/uRm
 dm5FAlRlBOVNcNJ8Xntvh957BjDEqOXuFcDEpf9N+I2+J0AAQyVquxVlARdrtxme/KPu8L1gFkb
 G0ntuIvKoW2lpVQ7yt5IHFbVUw32Z5NREv+M3lN+/tgX2PBDDJg==
X-Gm-Gg: ASbGncsVtMje/2MjuIxYB+9Sv4EAxpkpftrNrieD11VLxbppOVDtRe1SeFy/T3sl1Lw
 4DBQVWAWytnv3Fv17usenD52Tv5wF0pgtBA+ryOkpJShAFVK3uPzsYADvm+Ambc8lC94sP+A65b
 daV4swEvm2NU1IykE1vd3xmxI=
X-Google-Smtp-Source: AGHT+IHisYqgis/1ZT7ceDVshZAV1TWxmxfgVAOVLS7/vcpOigHnHLrFf3JkLKYLpOg/2hrctLJHI3jIxDFu6fvntuo=
X-Received: by 2002:a17:907:d1b:b0:acb:34b2:851 with SMTP id
 a640c23a62f3a-acb74dbf387mr1660279266b.44.1745365181389; Tue, 22 Apr 2025
 16:39:41 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Tue, 22 Apr 2025 17:39:30 -0600
X-Gm-Features: ATxdqUEcHFtt52fDmrNxe3VytwTpyEA0Rn8Tc54I4z-VgcL4mH8uUMpEQrZ-9FU
Message-ID: <CAFLszTjnXQu3bwWt3Do7S_Vu0UO5si4HRUeW9bv0981WbUn_7Q@mail.gmail.com>
Subject: Maintenance of Python tools
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
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

Hi,

Tom has indicated that he would like Patman to move out of his tree. I
suggested on another thread[1] that I maintain it in my 'sjg' tree, so
here is a new thread to discuss this.

I have already done this for the qemu/efi/coreboot scripts as Tom has
NAK'ed patches for those.

For the other tools there is going to be quite a bit of churn, as I
would like to resolve most of the many Python warnings.

Given the shared source between the tools, it would be easier for me
to do the same for buildman, binman and qconfig. I am thinking that I
might try a move to allow Gitlab pull-requests for reviews on these as
well as the mailing list, if that is useful.

For tools which need to sync back to Tom's tree (i.e. not patman), I
or Tom could do a pull request every now and then, omitting any
changes that relate to pylint.

Please let me know your thoughts. The timing is good as I am going to
be sending out a new Patman feature in the next few weeks and it is a
few thousand more lines of code.

Regards,
Simon

[1] https://lore.kernel.org/u-boot/CAFLszTg7-yM0L8uuJyN7Jpsb1LbvOYO76cUWj+H719mfc97mMQ@mail.gmail.com/
