Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7ADBC25B74
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 14:10:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D391A88258;
	Mon, 27 May 2024 16:10:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="K7grsBd7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D080A88361; Mon, 27 May 2024 16:10:30 +0200 (CEST)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97F72881D7
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 16:10:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-681a4427816so2478761a12.3
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 07:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716819027; x=1717423827; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Jlo9obTUX3UWkD5TV20A0zJr8lN3EBgSps/3P2mcOc=;
 b=K7grsBd74Y3pGqw9vI9Ngv8Q9+XCpzVCHZ7rfeEZXOzQKlSQQKfK7QjuB/2EIUxBJh
 CH3E0MYHYnitxCkfOSUgZUhcR+i2ymi67LXFOFVoXxpYPcno9OuLfzhkiuxeT2V/OuRL
 VyDbVzcoTrj5N1c3Td6v7+VEWzUEbhInRQbU+gVOFsSpqh4qS9hPjHk9ow9Iofw8fxon
 m9/cp46hYpzLstKCW09k8+VyjCGbqk3PzWGpLS36zHT5UtcV4PK54vBLzarxj+Y/zvss
 sxzqCZesNigYPgGxjAN8ke5QTWADAlz4Bg+AJBQGF/XPa3T2Ydutonu5eSKs0Ml3Dmj8
 fRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716819027; x=1717423827;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6Jlo9obTUX3UWkD5TV20A0zJr8lN3EBgSps/3P2mcOc=;
 b=WcGXvyYBrTiosxGwOixR534zgM412ZjBLF3Er6cWe3+idkJY8ylYHm2CDgpZZuB2my
 s+yAEoHpymffAOd8of+CjO3VyrDS5pCJQEUjBnFXzzOI4it/M2sldWWSjviy5fkmOwq+
 EzTezf2vkIIJsY6rS9shUPpa0eIQJfYkCT2uxgqdvk3Ney76aXJr1sPCLQBplQS6M8wj
 4Nbw9L31YrazPTG9yOzetTfasTBx0veSF7O48DkieOQQFL9zrjt1a79S3dOs05WfrMWX
 +4whY1JtScWodrtaseb+7iQ392PfZGuq+xil2B3JNXA/zW0dYMvumG6FzeGQ57y9IJRc
 W2XQ==
X-Gm-Message-State: AOJu0YyHvKk97mIzUCgLPFbCEmUypMqcY5EZFg7rbQ4ivXUhTQcIChjY
 NmRQFsJYm3MyZMPezKperqggTJk6tkWLdS1C5r5QBz7oL8Y8KRgon6YMdvo4eQDRJrHKWcfU0BN
 nyAABkacuHk8EvmcErLyPqzKd5qAO453/HrOUdw==
X-Google-Smtp-Source: AGHT+IFICkxOsbiYIfFwrKCWNefRtjqkThrWPZAfWQ5xuefX6heYjawGa1Mxdf3+GnjVdI/7Fz1wH3pfNqzwJmWky2Y=
X-Received: by 2002:a17:90b:1bcf:b0:2bf:cf50:593e with SMTP id
 98e67ed59e1d1-2bfcf505aeemr2318919a91.11.1716819027074; Mon, 27 May 2024
 07:10:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240527061504.19822-1-ilias.apalodimas@linaro.org>
 <CAC_iWjJo+2wQBw5+a3PJRf6X4X2akTuW_EuC+0_A_NsSmoMzVA@mail.gmail.com>
 <20240527140822.5df66c3a@xps-13>
In-Reply-To: <20240527140822.5df66c3a@xps-13>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 27 May 2024 17:09:50 +0300
Message-ID: <CAC_iWjKB_8kqvqAJA=OUC9F-y8kSqu0fekd+ew2xDvt3HY8DVw@mail.gmail.com>
Subject: Re: Pull request for tpm-master-27052024
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, tharvey@gateworks.com
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

Hi Miquel,

On Mon, 27 May 2024 at 15:08, Miquel Raynal <miquel.raynal@bootlin.com> wro=
te:
>
> Hi Ilias,
>
> ilias.apalodimas@linaro.org wrote on Mon, 27 May 2024 15:01:10 +0300:
>
> > Hi Tom,
> >
> > Don't pull this please. Miquel added his r-b tags in the meantime,
> > I'll queue up a new one
>
> It's okay, I thought you just merged the patches in your tree,

Yea, that's what I tried to explain on the original thread by 'queued
patches to Tom'.

>  but if
> you already sent the PR to Tom it's okay. I'm fine with Tom pulling
> this version of the PR.

Thanks and apologies for pushing this early. But it contains a fix I
want to land in the upcoming release.
As I said this was on v5 and since no one paid attention by then, I
didn't expect any other r-b tags.
In any case thanks for reviewing!

Regards
/Ilias
>
> Cheers,
> Miqu=C3=A8l
