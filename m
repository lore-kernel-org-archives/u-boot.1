Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8281E7717F
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 10:48:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 266618005B;
	Mon, 16 Dec 2024 11:48:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GM2X3VFj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7418880104; Mon, 16 Dec 2024 11:48:40 +0100 (CET)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 694F98003E
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 11:48:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-30167f4c1deso34314261fa.1
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 02:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734346118; x=1734950918; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kZCjLSl7my5wc/EYM8ifFJ0pADStzDZJVzQwJTVr42k=;
 b=GM2X3VFj3cLhvy+S2IVWLFlf6lG7EkU873iSpjdFTta/dRZqHGFRaaB5b37PxkvVob
 63wAW8x/utgbxKfNHmbGDM6pCzwuvl2z0EsfECwvCJ+M5aM5VqriYOrqizb2gX0iV7Vt
 E2kUQ1wqguFArF/hslQHIw2LQzQ/rdN2ojbXp9zP1U0+AEgwjNqF6t6nchB8imivmSEY
 iyRG7Xi0b7zglF6LLvNzzOxAHB5ExKuEu143ZeWqIhoF72BBJBu7FaC3sIGeiIgblbms
 hqHaxyhXer/PYJXhit4xFWq9Mq/c1JAaz0o9xxy8GHJyt8OWHVhb90LtLYKQkaQyjI7t
 G5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734346118; x=1734950918;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kZCjLSl7my5wc/EYM8ifFJ0pADStzDZJVzQwJTVr42k=;
 b=nq2LpfvHZQw3vJqzm6xAw/VZopFuy/9wqhmxb8uM30EFgNkqNJpHuVC5LXhecdbyLL
 kDZZ7GdSuvkici1sSbDYiLJpbG2lp+II7uhRSF6h7CeJdy5DDtD0HeVoUgqWR+a+LASQ
 azAB08HnKwbnOf5WyIsA/kObrmTe70u8Dk/POO4cagxxIs6HSTWEGP0nKPPj2A8yKq8f
 f7YhYWu+otJsTFpNIJusj8qGjpQpVlZaK80rhH/XxeaPxqSeDHOBNBuSeJFP4SSg2uCz
 895j/dApxjJTwvm2JherU59aoaNEMGej9fqBqqcmuxbuP8cGj/nQzHxlfIqokHrfMvJe
 hi1w==
X-Gm-Message-State: AOJu0YxzCU69irnwSyzbkj/M1YgfckW7dnATCry7wUUir84wEMsAVgz+
 e1iXWX7yfr6cUkSwDbSpOyaCOjrqZP+FdMl67Njp3d26+9CCh23G6gRhW4f7ac3RTMXZeT+xO1R
 /fPshumFF5D9Ne0JWFD9WK4qQNZc=
X-Gm-Gg: ASbGncsCXAnRoA0CyZ3e7dJXeOMEPUNiG/zJyIUYaIfHovhAQxcpxeAbu20SL5AUrc4
 9Dzx0cAFjQ/tG8R9X8o80jxAABNHPaQ8k8wS3xIQ99xSpbLInlKyHsM8DnQE6YjGoYc72
X-Google-Smtp-Source: AGHT+IHOnMM1FKufgz24Y5p2hghMTt3De3m7oufkprPYwHUMDoWjgwnseTB1DfXV439M2Timgboczg3vCJd9ynWnyKk=
X-Received: by 2002:a2e:94d6:0:b0:2ff:c027:cf5c with SMTP id
 38308e7fff4ca-30254464008mr29661601fa.16.1734346117353; Mon, 16 Dec 2024
 02:48:37 -0800 (PST)
MIME-Version: 1.0
References: <33e7b95383c1e5dd20f4cd2e30b88391a09e0858.camel@googlemail.com>
 <CAOMZO5BezDHXphjvX+Kat6rFq5zYC5yVucET2NzTHdFYnYTqXA@mail.gmail.com>
 <01420bb81265f69bbcd56dbe658fc0528d94e87f.camel@googlemail.com>
In-Reply-To: <01420bb81265f69bbcd56dbe658fc0528d94e87f.camel@googlemail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 16 Dec 2024 07:48:25 -0300
Message-ID: <CAOMZO5CZ2cnAozFUnybUYWQUQ4CyvuDWWy6pbVq8SnbBe_RXdQ@mail.gmail.com>
Subject: Re: [PATCH] imx: hab: fix srktool -c usage by removing spaces
To: chf.fritz@googlemail.com
Cc: u-boot <u-boot@lists.denx.de>
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

Hi Christoph,

On Mon, Dec 16, 2024 at 5:27=E2=80=AFAM Christoph Fritz
<chf.fritz@googlemail.com> wrote:

> thanks, looks great. Do you want me to adapt the patch and resend?

Yes, please send a v2 and I will apply it.
