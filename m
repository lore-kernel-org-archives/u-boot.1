Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 471F4C02187
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 14:43:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D10E3806DD;
	Thu, 16 Jan 2025 15:42:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N/ysLzEe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDAC980708; Thu, 16 Jan 2025 15:42:57 +0100 (CET)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C91448022B
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 15:42:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-3061f1e534bso11113941fa.1
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 06:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737038575; x=1737643375; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4hWK9I0KX1XS/122NlLnlZ/3m4YJAiwkMgimapyg/Bk=;
 b=N/ysLzEeq6Sxe4MAVzP2j2WUXWMtfZSqVFtUEHALDtb0gfwg+ZZApIxv1xQ36bEl8l
 tBXC+lGgS7kgVWLzPIJyA1ClL/1bqYpQYHq5y9ekUdQBufwyWfAnNp9WoetjKl/EcawQ
 lieewbiJQVHj5F3HAvc4NymvuDTJEp9m4fqB+gj36VI2TEcHSWNQkxmcM77jvICPI7fa
 cXN0HHSmua/zmedV8GUj8psDlUaQcUKeU+RBOB6yq+SYPmDCSO5JszUXu9n6rXUEnBYq
 7mibF0BfLbIZNkHy3MTswv5uWqaOUowX+M04CltZRRiq8bch2u6vn66mIbxkHHx/VD/q
 JC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737038575; x=1737643375;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4hWK9I0KX1XS/122NlLnlZ/3m4YJAiwkMgimapyg/Bk=;
 b=qeL+uW+sy00tWgfwT8QYcZF9A0MYDD0Ha+pRYpKnJQI4qMKjAM9/2pUd7I0riqYHat
 /MknvbHgl0SiRidtVCnSOOExaI54d8DKknwNOUDF7iJtHtiSx3toLZ7FkTBB5jCn3iYC
 1Tt6lA7CxirrQv4D0tJdNI093tuT629H08RcOiiXjghK275EoxeZM7CnH07Vz5Tuskic
 0USGxPUUACa7bnrpDxRTEkEd+87hyRBbqyHhtfk7hQoWL6jwd0Il4VaGM+Umg+LZ13zI
 PTFXinmw48ClwY5g8TjkWc9FCEtMJbJeMno6JndPT9aaQH9PBx8Sm1Dhsl9AOfzrkBqr
 Y7rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWi+eHhsG20mUW4Bdt7lsMU1aQkXcvxpi8YgUtfaZXOsD1oHxMisT4znf8XVDKRTM/60CMe6f4=@lists.denx.de
X-Gm-Message-State: AOJu0Yy4vCs/hoHKqKNbNQGT8XptR8hcBlM74UfBc4U4bckxithRVK+4
 MnbX0owoR/vIa8lsHUaEicSll3jvWLINLAK9mQplNQmz1ykZTQQwGtkjqIBHQpA+MEuHg9CIfdZ
 3p6cbAWHOuXHxj4jjZCdY7+j7ViM=
X-Gm-Gg: ASbGncvruYwA90Effxrbm0NyaEemjGeuCaiXYSr6bmS569SXFQrBsEOgy73VsWvI5Ke
 v9hfa2vq3e+GrCAOkGtWa1Wov9iaq+zLnZzyRefSHrYKRqn1DmAFMjlCVhHFEK7M97Aqo9Q==
X-Google-Smtp-Source: AGHT+IFcaAM2Zf9cPKERturRrj+bt++tB0EqnOmhONbUvSv9zVwLKhD+DOCXQsaCQZdM4NYClTHqyixyyeNGl/abkwU=
X-Received: by 2002:a05:651c:221e:b0:300:15d9:c625 with SMTP id
 38308e7fff4ca-305f4587489mr109977321fa.14.1737038574901; Thu, 16 Jan 2025
 06:42:54 -0800 (PST)
MIME-Version: 1.0
References: <20250115-imx93-boot-dtb-fixes-v1-1-1723b4216e71@armadeus.com>
In-Reply-To: <20250115-imx93-boot-dtb-fixes-v1-1-1723b4216e71@armadeus.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 16 Jan 2025 11:42:43 -0300
X-Gm-Features: AbW1kvafjallbgQFE4wZ9LUGmx1E7rsfkoLYbCGiP2ZTAgjEuLYFGsH1iByqyK4
Message-ID: <CAOMZO5DphBMfK52nz3EWk4x=rg4Gd3DR+x2iKsx41xcHvecwqQ@mail.gmail.com>
Subject: Re: [PATCH] imx: fdt: fix cooling-device property corruption
To: =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>
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

On Wed, Jan 15, 2025 at 12:41=E2=80=AFPM S=C3=A9bastien Szymanski
<sebastien.szymanski@armadeus.com> wrote:
>
> The function disable_thermal_cpu_nodes() corrupts the cooling-device
> property.
> For example, booting an i.MX93 devices with only one A55 core (IMX93x1)
> with the cooling-device property set to:
>
> $ dtc -I dtb foo.dtb | grep cooling-device
> cooling-device =3D <0x08 0xffffffff 0xffffffff 0x09 0xffffffff 0xffffffff=
>;
>
> Linux shows the following error at boot:
>
> [    1.715189] OF: /thermal-zones/cpu-thermal/cooling-maps/map0: could no=
t find phandle 1083699869
> [    1.723977] thermal_sys: Add a cooling_device property with at least o=
ne device
> [    1.731285] thermal thermal_zone0: binding zone cpu-thermal with cdev =
thermal-devfreq-0 failed:-2
>
> because the cooling-device property in the device tree passed to the
> kernel is
>
> $ dtc -I dtb /sys/firmware/fdt | grep cooling-device
> cooling-device =3D <0x4097f29d 0x00 0xb05aef9d>;
>
> The issue is because the wrong variable type is passed to the function
> fdt_setprop() called in the function disable_thermal_cpu_nodes(). With
> the variable type fixed, the error at boot is gone and the property is
> properly set:
>
> $ dtc -I dtb /sys/firmware/fdt | grep cooling-device
> cooling-device =3D <0x08 0xffffffff 0xffffffff>;
>
> Signed-off-by: S=C3=A9bastien Szymanski <sebastien.szymanski@armadeus.com=
>

Great work! Applied, thanks.
