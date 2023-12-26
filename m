Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7487EC46CD3
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 09:52:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E658878A5;
	Tue, 26 Dec 2023 10:50:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NRXUGFiX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87E60878CB; Tue, 26 Dec 2023 10:50:20 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0DAC87687
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 10:50:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3bbbc6bcc78so170933b6e.1
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 01:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703584214; x=1704189014; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ebs+hxlwQP7BNr/3r39Z9czd/6cHHpuTT2/pGZh0qK0=;
 b=NRXUGFiXNWw+WA7se9euivDwQpjwwueji7Ao5AqOLi5xAAyTHcD4FS+o3HRJ8hB8uE
 2kXLRyV5Onh0FofJYBnPvK4zxmsphz1UtAs7KtY0uHe8920pT3F65C6fy+4UJZgiQvTA
 0Elfj5WRRqTN5PBKjtF1fysu9mCbp9zS7XiuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703584214; x=1704189014;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ebs+hxlwQP7BNr/3r39Z9czd/6cHHpuTT2/pGZh0qK0=;
 b=bMXAHZU+hQ9KarYDnPpMsI4onJuytsY1dhC5yrCsBhp+hTbbzRYWrv9qn1BpzObvEG
 qVe9zjLe79Hn1cGa68z992O87Wffq0VUZy0EURmj1WwX4gjod+LMpWTyi94U9f2rFnNG
 N5/n61SNkPqG6LKMFuLmfkBTZ33edbtghd64SKljkZfGIQ2EUROGlvjIclS7nbopOuQD
 a85ZNW6NDLNfg5AafOKcBMtI0bS8FiOiUaX6IGJa7vdlF7GSv1G0SmI29FnBYS/Fwvok
 4pxbQ8vPaN4XTkRAbnmO0DeX25VwnXMbnOMDGSpzorGxQIzK6CQjVIg1vDBW5NIAROWo
 T/OQ==
X-Gm-Message-State: AOJu0YxZGx0WbqgV/hQ7vTzK8+O001uHj0Hv+9qJeuqYcf31Zcn5OuvG
 qAgtd+63XKj9/32Yy3w1ob2TbR56Em7YwRJvqaLjcm2I1xLp1RBMg1H4y6m8BA==
X-Google-Smtp-Source: AGHT+IFbwMlru+UMDI18HTkjBndbqPXXUTSYS5Ss/vhCllpHjq/sivdzXxqtSXWeBptpiDf1VLxRE5CQwVScUwDV3WM=
X-Received: by 2002:a05:6808:1886:b0:3bb:71c5:3265 with SMTP id
 bi6-20020a056808188600b003bb71c53265mr8205468oib.59.1703584214553; Tue, 26
 Dec 2023 01:50:14 -0800 (PST)
MIME-Version: 1.0
References: <20231206-binman-firewalling-v6-0-e7fce13a6dc1@ti.com>
 <20231206-binman-firewalling-v6-5-e7fce13a6dc1@ti.com>
In-Reply-To: <20231206-binman-firewalling-v6-5-e7fce13a6dc1@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Dec 2023 09:50:02 +0000
Message-ID: <CAFLszTi2tnbHz_5Dsb7Q3H3NrB_KXq4zWL7fbYcOnF81xCv4xA@mail.gmail.com>
Subject: Re: [PATCH v6 5/8] binman: j721s2: Add firewall configurations
To: Manorit Chawdhry <m-chawdhry@ti.com>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Andrew Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 u-boot@lists.denx.de, 
 Udit Kumar <u-kumar1@ti.com>, Praneeth Bajjuri <praneeth@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, 
 Nishanth Menon <nm@ti.com>, Thomas Richard <thomas.richard@bootlin.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>
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

Hi Manorit,

On Wed, Dec 6, 2023 at 9:51=E2=80=AFAM Manorit Chawdhry <m-chawdhry@ti.com>=
 wrote:
>
> The following commits adds the configuration of firewalls required to
> protect ATF and OP-TEE memory region from non-secure reads and
> writes using master and slave firewalls present in our K3 SOCs.
>
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
>  arch/arm/dts/k3-j721s2-binman.dtsi | 217 +++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 217 insertions(+)
>

Just a minor point, but could you please reserve the 'binman' tag for
patches in tools/binman ?

Thanks,
Simon
