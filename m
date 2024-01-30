Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE10C47DA9
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 19:55:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1AA28799C;
	Tue, 30 Jan 2024 20:55:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="UZ8WllAL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 274D8879AF; Tue, 30 Jan 2024 20:55:54 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 170B08796B
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 20:55:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mzamazal@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706644550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pKpT/omlVx5JaA7IiPmKX2JMOmfs0ZiCJWi7ztT22CU=;
 b=UZ8WllALLaerPdhUM+LtkAUqN+SdmhQv8xuwyVLiVn9okVoF3WbLQcLtUKxxWZDW18AV8U
 oz287YikJSoXaSV4kS/GUMx20EPvHpFZNFi/OxAQwLYpRCjTVOmykvrhLXa7OWplaycnlS
 YqcwUEcmCzrZASCttuNhKNrRGJoXOo4=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-16JY13-TNC2fPNLxj1n9GA-1; Tue, 30 Jan 2024 14:55:49 -0500
X-MC-Unique: 16JY13-TNC2fPNLxj1n9GA-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2d05c9cbc92so10734861fa.2
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 11:55:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706644547; x=1707249347;
 h=content-transfer-encoding:mime-version:user-agent:message-id:date
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pKpT/omlVx5JaA7IiPmKX2JMOmfs0ZiCJWi7ztT22CU=;
 b=YaFmqLIJdRLbnt2BKzRaX5StlLmOivv18uqjPGa6NBryd7XzMXOpJTLBUKUGsrVB+N
 YIZ4tYS8aDxGoPii4StIFAVDaI/T9TuAPlXrTBeNHHggi07cE67mDbC2rDvg760uUd+K
 uJuf8L/4mzIlUxDQwOOyclm5hhlaaX9N+d6nAAY+XeU19I0yxajcrFPAVP2cPZyMUvYp
 cj335OrDjBTDyLaY5Wgde0u5yJxqWsrYptVO6LTBg5id6rg4dOWzVOOLmtIIH7S1HhEB
 TQq04CyiMbqpYNVRiQB/OAoNV+XUvHggjIYWFFwnNCtyc1qTi+U34OuZEYRZU6YWQG4a
 X6tw==
X-Gm-Message-State: AOJu0YymM+RBl/YGhwrceP7eTimAsBMmxb8lFIIt07AMaPkFxx6WEguh
 a9GSKo2fS/ZpVAcleWtW1mN00OGj15SjOegr+RLzn3zxYSFe/8bWBWTdNkOXRRg432oY1oHEip9
 xtYn0biphSAitcRzH33HJcxrtBiYUrJHwQIrRz7F1uwImJoiIX1YQ9bZbW1yq6rnRSfIuduraXY
 ou0gZ8gdifZzaAx4woAyfsRMjE+PVHSNfMyoo=
X-Received: by 2002:a2e:8ed9:0:b0:2cf:1dc1:7faa with SMTP id
 e25-20020a2e8ed9000000b002cf1dc17faamr2043935ljl.16.1706644547552; 
 Tue, 30 Jan 2024 11:55:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGmQvw1LLXyQ1nAQU4umJg39U8uzElzXGcRd7KD0P3k9L2AkXPcsc5r7Flp9BgxowfUnwxNw==
X-Received: by 2002:a2e:8ed9:0:b0:2cf:1dc1:7faa with SMTP id
 e25-20020a2e8ed9000000b002cf1dc17faamr2043925ljl.16.1706644547164; 
 Tue, 30 Jan 2024 11:55:47 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXYE35kjB4Ala+d88k+lc+Dxe61eJjqpR9WHBUAzZdaQ9Sl9F6nC7cR+4Phovbc+b6BNpSU6NvA9gLgOGWURDg5/dkx0kv7IRvANn2qSpkIEaIRlgef7lbsEpt+B0ZkezP16fuLR947Aqtit0VU
Received: from nuthatch (ip-77-48-47-2.net.vodafone.cz. [77.48.47.2])
 by smtp.gmail.com with ESMTPSA id
 wb14-20020a170907d50e00b00a35adbc019asm2768920ejc.111.2024.01.30.11.55.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 11:55:46 -0800 (PST)
From: Milan Zamazal <mzamazal@redhat.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Gilles Talis <gilles.talis@gmail.com>,  Peng Fan <peng.fan@oss.nxp.com>,
 uboot-imx@nxp.com,  u-boot@lists.denx.de
Subject: Re: [PATCH v2] imx: imx8mp: Add support for Polyhex Debix Model A SBC
In-Reply-To: <CAOMZO5A2W4ZZBdUjNkA9fqB+kBgASM7esfcLL3RvdwmCi9qakw@mail.gmail.com>
 (Fabio Estevam's message of "Tue, 30 Jan 2024 16:31:09 -0300")
References: <20230523192155.33222-1-gilles.talis@gmail.com>
 <58a07085-3926-b942-fb8c-58f1f5eac421@oss.nxp.com>
 <877clq6odx.fsf@redhat.com>
 <CAKcgs2x1FdvW0afXN=GGRc5nb8rhZtm70xzkURFeworcmTHPpg@mail.gmail.com>
 <87bkavbo6c.fsf@redhat.com> <877cjrss43.fsf@redhat.com>
 <CAOMZO5A2W4ZZBdUjNkA9fqB+kBgASM7esfcLL3RvdwmCi9qakw@mail.gmail.com>
Date: Tue, 30 Jan 2024 20:55:45 +0100
Message-ID: <87r0hy38am.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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

Fabio Estevam <festevam@gmail.com> writes:

> Hi Milan,
>
> On Tue, Jan 30, 2024 at 9:22=E2=80=AFAM Milan Zamazal <mzamazal@redhat.co=
m> wrote:
>
>> Well, after trying both the SD cards again with fresh reinstallations, i=
t works
>> with a 32 GB card and I get the error above with a 64 GB card.  Is it po=
ssible
>> that there is something wrong with SDXC cards?
>
> Does the change below help?
>
> --- a/arch/arm/dts/imx8mp-debix-model-a-u-boot.dtsi
> +++ b/arch/arm/dts/imx8mp-debix-model-a-u-boot.dtsi
> @@ -128,6 +128,9 @@
>         bootph-pre-ram;
>         sd-uhs-sdr104;
>         sd-uhs-ddr50;
> +       assigned-clocks =3D <&clk IMX8MP_CLK_USDHC2>;
> +       assigned-clock-rates =3D <400000000>;
> +       assigned-clock-parents =3D <&clk IMX8MP_SYS_PLL1_400M>;
>  };
>
>  &usdhc3 {

No, the same error. :-(

Regards,
Milan

