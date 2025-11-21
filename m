Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 233E1CFC27F
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 13:53:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C379836CE;
	Fri, 21 Nov 2025 14:53:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MrIajsPJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3850C8307F; Fri, 21 Nov 2025 09:28:47 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1756480433
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 09:28:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6419e6dab7fso2476830a12.2
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 00:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763713724; x=1764318524;
 darn=lists.denx.de; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qHN4qBhQlDsCrTKg8rcZrq9PmIHeDGzlmkYstcDWt2c=;
 b=MrIajsPJClOzdjdGwHxrSXJLLmZRWniqdT9MKYESIsjwpzL1C2osvO60ArmtPB3btT
 5RTM6+aReQYFBuO7rmX+S+TI0n1tF+LD7+/9cJTaHUb3fKUiHlS5oT7f7Bi7OJGZrgCz
 Q4+j9IYwBOCevJ4hUnNZCqUXjbNEXFa14Djl+Io5NCoEFKovt8hMkZ3Me4XJOAf1LMLt
 4+Pn24LS9t7UOvc9Uui9zpKWQZQLWAH0gW3wWyQ94tXQ1SjHPLbC4FzVcCaqQYdUnBOc
 3t7Urzn12PdtOowLXVrHcMpp0/bCI4iCq1cNnu1+fJDWssc/ZSELd0logP9FAP98zLFt
 XSUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763713724; x=1764318524;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qHN4qBhQlDsCrTKg8rcZrq9PmIHeDGzlmkYstcDWt2c=;
 b=vn6DV9aREJ2WShMhDS6DqQBqqRN57GyjvXasU5aiQKPFoheeWwZAmxycZi3gzEqDLu
 DPkU3t78of0QUaF7NbsK6JmPyfxwieUFIl58uQ+C3UzT1FN+iBHk6uFdJiYIWGSqUeWt
 tHdsmtn2GelVc3dusQZ/GusbjqSug+ETdPmWZ2OpTn6Eu34N92LRnaee5Ni/c1PmJP2u
 xyJagjYxr9H+uV6BBwppKMwvCoTzr+cNIsIrgzvSyXo7E75LdgGxB8FqP6gm2s7U14LY
 z0fl8ElG5rdQ43+GjSjpRBaBLLqdjgNnRT8GqA3a8GY7QXnUI+/9zkC5kxvEdB3begzn
 15dA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQ/Nt28kYBZL6LNfOiwft29v8lgC9Hp+fjvygf6GCfXL7b47LkHIFzE9+GuxjeQpNJqVV2fZ4=@lists.denx.de
X-Gm-Message-State: AOJu0YzSXNKRU/nkvg+Mz86m6lp5EdiBPZzrdPopZKgEgdMD+Gnv1G6g
 ZsAlYDM45B4Y1qnqMSTE80y2LCUNszl66bHH9U71/KPCUR/josiZ2k/47tIJwrtN9kw=
X-Gm-Gg: ASbGncsI5WDT/33MiJ3LzEuInGgT++Cg/G5AY3pDNkrZn7oJO6MiBI2V4jPXWqb0evg
 aIFtY37GNA7vf71GxQS+7/aEufpq5jI1q49CpM30ocCYqN5U700DzbS/1+1elmN0gRDKvqlAnse
 xHs2TGq6CP63DfKhZWqYuF5MT/4pMA3+H1jzCaDJ4PmmETXlS3IZ3PFT7oDfUOog7FRwHw26SFI
 IzfFYXVRNvMekkeMr+K5SVl3NvobBr9lpDHavsvnKQCxY5Nd7FhcTfmQB6ZYeVJYOsD7sSmAHSS
 rrwWIt1O8Nc8mtkAusYxMFF9pDaw4ytjzX/gi6+HrL7UyCp1qROBEoi05gEkvN+lBqDFjdGPOAP
 xKOTc6nMbfq1xDobbXpuO9C0VSBhmBx67urWaXsuvSIt9vXBZ06ixTq4jirEIkPsvmT5IBQasJW
 6BYKuS
X-Google-Smtp-Source: AGHT+IH+31fMxurlwfwuWhlkWD6klM5LjAaYsE291I8+h9nlW4ZNtkABtGo4UwFYfcv/n4Ls2i6Kuw==
X-Received: by 2002:a05:6402:1e90:b0:640:be87:a862 with SMTP id
 4fb4d7f45d1cf-6455469c0f5mr1370732a12.24.1763713724447; 
 Fri, 21 Nov 2025 00:28:44 -0800 (PST)
Received: from localhost ([62.246.248.122]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-645363b5e97sm3940771a12.9.2025.11.21.00.28.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 00:28:43 -0800 (PST)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=9131b4c9e36ae3c0f34f5f1a64c56ba5fba375f48aabea58d816f6669e29;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Fri, 21 Nov 2025 09:28:35 +0100
Message-Id: <DEE8BZBDYO08.1SX1UEB750S25@baylibre.com>
Cc: "Maarten Brock" <Maarten.Brock@sttls.nl>, <u-boot@lists.denx.de>, "Kory
 Maincent" <kory.maincent@bootlin.com>, "Rasmus Villemoes" <ravi@prevas.dk>,
 "Rayagonda Kokatanur" <rayagonda.kokatanur@broadcom.com>, "Tien Fong Chee"
 <tien.fong.chee@altera.com>, "Alif Zakuan Yuslaimi"
 <alif.zakuan.yuslaimi@altera.com>, "Casey Connolly"
 <casey.connolly@linaro.org>, "Tingting Meng" <tingting.meng@altera.com>,
 "Peng Fan" <peng.fan@nxp.com>, "Quentin Schulz" <quentin.schulz@cherry.de>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, "Liya Huang"
 <1425075683@qq.com>, "Romain Gantois" <romain.gantois@bootlin.com>, "Simon
 Glass" <sjg@chromium.org>, "Jaehoon Chung" <jh80.chung@samsung.com>,
 "Miquel Raynal" <miquel.raynal@bootlin.com>, "Mattijs Korpershoek"
 <mkorpershoek@kernel.org>, "Andrew Goodbody" <andrew.goodbody@linaro.org>,
 "Anatolij Gustschin" <ag.dev.uboot@gmail.com>, "Sukrut Bellary"
 <sbellary@baylibre.com>
Subject: Re: [PATCH 08/15] dm: core: Support multiple drivers with same
 compatibles
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Marek Vasut" <marek.vasut@mailbox.org>, "Tom Rini"
 <trini@konsulko.com>, "Markus Schneider-Pargmann" <msp@baylibre.com>
X-Mailer: aerc 0.21.0
References: <20251118-topic-am33-evm-oftree-v2026-01-v1-0-91ce13c661e2@baylibre.com>
 <20251118-topic-am33-evm-oftree-v2026-01-v1-8-91ce13c661e2@baylibre.com>
 <20251118140804.GR2125796@bill-the-cat>
 <DEDGK9KKB61P.1QY81TPR5JLNY@baylibre.com>
 <20251120212909.GQ2125796@bill-the-cat>
 <0b9e2a8e-1ab8-4a6e-899f-4ae9fd43b68c@mailbox.org>
In-Reply-To: <0b9e2a8e-1ab8-4a6e-899f-4ae9fd43b68c@mailbox.org>
X-Mailman-Approved-At: Fri, 21 Nov 2025 14:53:46 +0100
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

--9131b4c9e36ae3c0f34f5f1a64c56ba5fba375f48aabea58d816f6669e29
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Marek,

On Fri Nov 21, 2025 at 12:23 AM CET, Marek Vasut wrote:
> On 11/20/25 10:29 PM, Tom Rini wrote:
>> On Thu, Nov 20, 2025 at 11:42:53AM +0100, Markus Schneider-Pargmann wrot=
e:
>>> Hi Tom,
>>>
>>> On Tue Nov 18, 2025 at 3:08 PM CET, Tom Rini wrote:
>>>> On Tue, Nov 18, 2025 at 11:40:28AM +0100, Markus Schneider-Pargmann (T=
I.com) wrote:
>>>>
>>>>> Currently once a driver matched the compatible string of a device, ot=
her
>>>>> drivers are ignored. If the first matching driver returns -ENODEV, no
>>>>> other possibly matching drivers are iterated with that compatible of =
the
>>>>> device. Instead the next compatible in the list of compatibles is
>>>>> selected, assuming only one driver matches one compatible at a time.
>>>>>
>>>>> To be able to use the bind function to return -ENODEV and continue
>>>>> matching other drivers with the same compatible, move the for loop a =
bit
>>>>> to continue the for loop after -ENODEV was returned.
>>>>>
>>>>> This is required for ti-musb-host and ti-musb-peripheral which both
>>>>> match on the same device but differ based on the dr_mode DT property.
>>>>> Depending on this property, the driver is either UCLASS_USB or
>>>>> UCLASS_USB_GADGET_GENERIc. By checking the DT property in the bind
>>>>> function and returning -ENODEV the other driver can probe instead.
>>>>>
>>>>> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
>>>>> ---
>>>>>   drivers/core/lists.c | 62 +++++++++++++++++++++++++++--------------=
-----------
>>>>>   1 file changed, 32 insertions(+), 30 deletions(-)
>>>>
>>>> This seems like a big generic change (with potential performance
>>>> impact?) for a rather specific case. I assume the linux kernel simply
>>>> doesn't have this issue by handling OTG differently. So is there some
>>>> other way we can handle this here?
>>>
>>> I didn't find a nice way to do this differently. I did have a different
>>> idea to do this by overriding the compatible of the parent node of the
>>> usb devices. But I didn't like that idea so I proposed this solution.
>>> But I would be happy to hear about other ideas.
>>>
>>> For the performance part: I don't think this reduces performance in mos=
t
>>> cases. This will only add overhead through additional iterations if a
>>> driver with a matching compatible has a bind function that returns
>>> -ENODEV. In all other cases this should not add any iterations to the
>>> loops. Grepping through the code a bit, I don't think returning -ENODEV
>>> in bind() is widely used at the moment.
>>=20
>> OK, thanks. I guess barring someone else having a better idea, we can
>> try this direction.
>
> I didn't fully grok the discussion, so please pardon my ignorance. But=20
> isn't this matching exactly the same problem that is already solved by=20
> Renesas RPC drivers ?
>
> drivers/mtd/renesas_rpc_hf.c
> drivers/spi/renesas_rpc_spi.c
>
> Look at rpc_hf_bind() and rpc_spi_bind() implementation there, which=20
> selects which of the two drivers binds to the controller and which does n=
ot.

Thanks for the pointer, this is using the exact same mechanism as I want
to use. Is this tested and works? Because if I look into the current
code for probing and binding:

	/*
	 * Walk through the compatible string list, attempting to match each
	 * compatible string in order such that we match in order of priority
	 * from the first string to the last.
	 */
	for (i =3D 0; i < compat_length; i +=3D strlen(compat) + 1) {
		compat =3D compat_list + i;
    ...
		for (entry =3D driver; entry !=3D driver + n_ents; entry++) {
      ...
			ret =3D driver_check_compatible(entry->of_match, &id,
						      compat);
			if (!ret)
				break;
		}
		if (entry =3D=3D driver + n_ents)
			continue;

		...
		ret =3D device_bind_with_driver_data(parent, entry, name,
						   id ? id->data : 0, node,
						   &dev);
		if (ret =3D=3D -ENODEV) {
			log_debug("Driver '%s' refuses to bind\n", entry->name);
			continue;
		}
		...
		break;
	}

So if I understand this correctly, the returned -ENODEV will cause a
continue in the outer loop which iterates through the device compatible
string list, jumping to the next compatible of the device if any is
given. It does not continue in the inner for loop that iterates the
drivers.

Best
Markus

--9131b4c9e36ae3c0f34f5f1a64c56ba5fba375f48aabea58d816f6669e29
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaSAisxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlMK
NAD/TIHO/gKGAl3hfq+8QY5LxYNzKH3g4dmSYMNbzDzyY1MA/iBAE+tH0irAADKL
gPVzRhI0DR4TtGw1al778o0its4N
=1d0e
-----END PGP SIGNATURE-----

--9131b4c9e36ae3c0f34f5f1a64c56ba5fba375f48aabea58d816f6669e29--
