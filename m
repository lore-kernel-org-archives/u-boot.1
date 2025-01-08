Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2829BE77197
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 01:20:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB7E58036B;
	Wed,  8 Jan 2025 02:20:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WvIaqG1/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E9E2805EA; Wed,  8 Jan 2025 02:20:02 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0E898007D
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 02:19:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-54024aa9febso17236548e87.1
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 17:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736299199; x=1736903999; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jdu8zpYGZLBfNMT72ofd7W5oFRNvkFLCXqwZ9x9Q3Vg=;
 b=WvIaqG1/hj0dbEWYaerQ4I/OqDf1Uoh6dY1PR0eEfxbdSnHMRWnweDcjMuyrBa4q8b
 GnBN+UiIxOW1g3WHILef+CMNr5l26suqyKXKDn+viuhhVU/m0W8REkvc2Uegj+3m5HkE
 jXirgOtVMI4rihQIN9b+lOjFsEaNkPHTwk/1uJ4Geuoa19JiuU2iGCNf1UwlqduxSseY
 BdorGliToB3aVBu/kQZxrYGInA3M+XJQaMmS7NyqACIwBJjqmx8ptzEwjV1ioFAHUD0Z
 JBZNYw/FQ0Wf80NT5bXi+Mug7pCtep185uQvQpHiiBwzgd0QFDprK7gtdx92lEaV0Ids
 aCAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736299199; x=1736903999;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jdu8zpYGZLBfNMT72ofd7W5oFRNvkFLCXqwZ9x9Q3Vg=;
 b=XX1IXGz6S3YkiUMHgUugQgqZuqPg52VCQJcNjI6JuhjQ1IYVvoot/SpEjGoCdpaW/b
 iddXrvlX/9gnDl5VK1H7sODcW92LVf+AIy7cjyGYMLg3I1UUHBh0k6C/mUj2ii8S/ih2
 j7p6d6pvxnBw6bG2mL8oUMaZKRf1ePQI2ubLiLtjGPetyzHB6amjaj6LeFmcL9/pqaFZ
 unsk7r3kfz1/VCFKkSfKXYavE477WCeYreSDoNPNS2aBwf5Z5914V4ZZfN9JvPebp37V
 xoXhpFH8pnTcqZJdGveb5Jf7ArwcfP/oNqq2DVwj6z2velDQU1eyclw33vpEfEfJG7Ci
 zgYw==
X-Gm-Message-State: AOJu0YzqYS5Tqs8CZEHv+8f0/Yw4tDNlOTtML4e2tKJ65t4WiR30MW+k
 /oY4i6h02jMVLKgO69bDhT1xSC++aZ+PdtqSyRR531xEAko1IDcKoR9GcgJ8/dftyJIDeG33j2h
 nQcS4aQ95sRbi7qvAxi0lO4IynzU8sw==
X-Gm-Gg: ASbGncseREVQD74bcOvyVSo6kcXfb90qRWeQyA1YrR/fLOfeGxs7vHsljMkCqCrPsdl
 QroSnfha9dcZHFibNJpMwjg7Ka8AvdgB5OOxP65ZJVy+QjRYb6I92kYvhUVqfhgOzAu/v5Q==
X-Google-Smtp-Source: AGHT+IEv8+K/OUuSKZ9vHL/yXsIwiUdajfsJXEsjA+R7wzhdD+feSNn/5qx+BNukiE3lJpMKpMQihXqxxxazuBO7X98=
X-Received: by 2002:a05:6512:124c:b0:540:2ff1:3c7c with SMTP id
 2adb3069b0e04-542845aec5emr198755e87.7.1736299198726; Tue, 07 Jan 2025
 17:19:58 -0800 (PST)
MIME-Version: 1.0
References: <20250107225616.195878-1-marex@denx.de>
In-Reply-To: <20250107225616.195878-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 7 Jan 2025 22:19:47 -0300
X-Gm-Features: AbW1kva2Ns--RITl5dzoghLFs-wyA0EJsdbWUs8l4lC1zH9Hv4nHAqP_bhwLRR0
Message-ID: <CAOMZO5AeLQBxd-ZzEKvbOEf8Dxhqvxus6_2sacGhy-rQArVrRw@mail.gmail.com>
Subject: Re: [PATCH 1/2] usb: ehci-mx5: Use regulator_set_enable_if_allowed
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Alice Guo <alice.guo@nxp.com>, 
 Mathieu Othacehe <othacehe@gnu.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>
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

On Tue, Jan 7, 2025 at 7:56=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> With the commit 4fcba5d556b4 ("regulator: implement basic reference
> counter") the return value of regulator_set_enable may be EALREADY or
> EBUSY for fixed/gpio regulators.
>
> Change to use the more relaxed regulator_set_enable_if_allowed to
> continue if regulator already was enabled or disabled.
>
> Based on 335799b7252a ("usb: dwc2: Use regulator_set_enable_if_allowed")
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
