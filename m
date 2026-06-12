Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E283CD98CE
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 11:51:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE7128056B;
	Fri, 12 Jun 2026 13:51:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="UnJwzOVc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD875846B0; Fri, 12 Jun 2026 13:51:38 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 883E58005D
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 13:51:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-45eee266c6cso783022f8f.1
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 04:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1781265096; x=1781869896; darn=lists.denx.de;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OlRJcK7Mv4SwhuV++9MqilAsUa0gfhts+ZLxkENkXb4=;
 b=UnJwzOVcNM9fLGrzr8h+FM7f3SXysjSfKPVjs+Wpw9ajmrYXXpewFvWbgA3Jt7ORM6
 uy2rwZfxQSMbXv0mvGgDH9nXMpSq3NWM9e589lSCKCsX/zpta0owRlREZHT+Mmfb2Sji
 EakZCutf5qRLbDk3PwTcxkn0Ecj4s9d0pyXYea/6ZgcUn/Gb1WfJaK9Tg/47Vn0X2PY1
 ciMl4wvx6AufkmVNLZ2rWn8SXvXC0dM9xYDo56tEfbktmnpT/WeR9C/ciLsOZqG0kBNd
 4MsaBhM1fi4U7YrYZIebgH/pjwhcjZ3vmCXVJ4sVV8RBMuyghddD/U1LFKhI1s7pxFgB
 oNDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781265096; x=1781869896;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OlRJcK7Mv4SwhuV++9MqilAsUa0gfhts+ZLxkENkXb4=;
 b=jHMEeSiHPX9djo/ZmDQSWBhxS95DbTer8Swqy7oCwZKKYDpipKc5So2urMBy3aSXKY
 z+glh96KhYF4YgAvT1fcghVD2zswdeJagQEvIpVI3520PGoffmeQX4YAfDdTtZnEE276
 XOMMUOf87vXu3QU0QEei8saZ+sITAJdTUD/jXmBk06L8VF8sPNfmaorSXC9gfdTheNdP
 TD5w+9xTsiRiiK2YgjKZ6eJl76WWctBxN1F8yAMnne9Gva9D1K4tec5KZXY2g98+U1Da
 uxz3/aH1q/Uemx5qD6SHrGqWbnTd9pa1g2wWdAQ8xMhwhL0ovGbuQSJUDFBeyNaLb7tw
 JlFA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/UEmhJ4TeNqg9WA/BCqMG0RVtFk/sXdtXm/1EzsXy0q+Js2qQfA1G6fIlldqrLnwgd8SBhQXM=@lists.denx.de
X-Gm-Message-State: AOJu0YxV7tcl46xvXOsUvJKWwVh5rjpdEcjacWiUki4tcTCEkTFfO994
 6IO6a7+sx1gegN64zR4dZKQMm1ueQAMquj9LuHtrJsGV4zPEewaGGe3mgWEQ2p2fZGw=
X-Gm-Gg: Acq92OHkX734OLq7CvAUTG50K1bpWTPPH/63GgHhw6WrMD4GyZVtsgR7OE/uUqoVdey
 7Kgt4RVx6XZdUI1tp+xXIJaAk9vFgbqJOgKvcHTZYEZ8wNKNYUJwzyfvJWCMlXu1QlKV5MW2LbF
 zr1iW3x7xHbi7v7FJX18jLJzsTjYVFwrJpf8k5qIlGv9vD+4cH5TwGnGpSjVacQiqF8ddYkqsLj
 fUeuuawtA6NTxaLiunqxpCkLbKjat1+ZAdocc53JcNsxpO8HCAWj2Lwtj4M7MskPZ/RSIT8WrHC
 Fk22ODuCR9TlD6oB+B+G7lAhcV3LZh0rLr+LZozXFF4anIjpAIdoaWQIltSNLAvpboMV1qGXAOG
 wNrNmpsyroeMoXlhym7HJKUVYlBOBD3GxE5taqCWLHhTsvYkIVCc3dAm9C//KYRZ8Wmlm/LuQgs
 TfDmXW3r/oid6z9C41hcONZfPGPOAg
X-Received: by 2002:a05:6000:1847:b0:45e:ec18:f207 with SMTP id
 ffacd0b85a97d-4606db9a69bmr3987050f8f.25.1781265095743; 
 Fri, 12 Jun 2026 04:51:35 -0700 (PDT)
Received: from localhost ([2001:4091:a245:857c:229:71f5:91db:9ccb])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2c473bsm5198497f8f.28.2026.06.12.04.51.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 04:51:35 -0700 (PDT)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=cf6ba24669d9128a78f72b54b80c5adbd3dd30f071d4f5d4d8d064a2c286;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Fri, 12 Jun 2026 13:51:24 +0200
Message-Id: <DJ71RUV8QWDN.4QHDEL6ZHAU9@baylibre.com>
Cc: <praneeth@ti.com>, <vigneshr@ti.com>, <bb@ti.com>, <b-liu@ti.com>,
 <afd@ti.com>, <anshuld@ti.com>, "U-Boot" <u-boot-bounces@lists.denx.de>
Subject: Re: [PATCH 0/4] arm: mach-k3: Add DM firmware memory fixup
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Paresh Bhagat" <p-bhagat@ti.com>, "Markus Schneider-Pargmann"
 <msp@baylibre.com>, <trini@konsulko.com>, <u-boot@lists.denx.de>
X-Mailer: aerc 0.21.0-126-g9e77103592fe
References: <20260609181006.460401-1-p-bhagat@ti.com>
 <DJ57VBSU0GI1.1WEU7NE9FYE46@baylibre.com>
 <c329501b-ae4a-4fd1-8fb3-0489a7f269a4@ti.com>
In-Reply-To: <c329501b-ae4a-4fd1-8fb3-0489a7f269a4@ti.com>
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

--cf6ba24669d9128a78f72b54b80c5adbd3dd30f071d4f5d4d8d064a2c286
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Paresh,

On Thu Jun 11, 2026 at 8:14 PM CEST, Paresh Bhagat wrote:
> Hi Markus,
>
> Btw Had a quick look at series
>
> https://lore.kernel.org/all/20260609-topic-am62a-ioddr-dt-v6-19-v6-0-16af=
ba97fbe0@baylibre.com/
>
> I did not know this problem was for other devices too.
>
>
> On 10/06/26 13:42, Markus Schneider-Pargmann wrote:
>> Hi Paresh,
>>
>> On Tue Jun 9, 2026 at 8:10 PM CEST, Paresh Bhagat wrote:
>>> This patch series addresses DM firmware reserved memory fixup for AM62a
>>> and AM62d:
>>>
>>> 1. AM62D is missing OF_SYSTEM_SETUP config, required for FDT fixups to
>>>     be applied before passing dtb to kernel.
>>>
>>> 2. DM firmware reserved memory region is insufficient to accommodate th=
e
>>>     binary. Analysis of the DM firmware binary using objdump reveals th=
at
>>>     the resource_table section and .stack section occupies memory from
>>>     0x9c900000 to 0x9e608000. So increase the reserved region size from
>>>     0xf00000 to 0x1f00000 via fdt fixup. Add new configs in Kconfig.
>> I am wondering why you chose 0x1f00000 and not 0x1d08000?
>>
>> Also for am62a the firmware linker file says it is shorter:
>>      /* DDR for DM R5F code/data [ size 27 MiB + 364 KB ] */
>>      DDR                         : ORIGIN =3D 0x9CAA5000 LENGTH =3D 0x1B=
5B000
>>
>>      https://github.com/TexasInstruments/mcupsdk-core-k3/blob/k3_main/ex=
amples/drivers/ipc/ipc_rpmsg_echo_linux/am62px-sk/wkup-r5fss0-0_freertos/ti=
-arm-clang/linker.cmd#L175
>>
>> I am wondering what is correct, the linker file or the objdump you did?
>
>
> Yes apart from the objdump output I noticed a gap between end of=20
> wkup_r5fss0_core0_memory_region and start of secure_ddr. So intention to=
=20
> fix the bug and use all of the available space.
>
>
>>
>>> 3. The existing fdt_fixup_reserved_memory() used a delete/recreate
>>>     approach which corrupted phandle references to DM node, causing DM
>>>     initialization failures. Fixed it by updating nodes in-place using
>>>     fdt_setprop() to preserve original phandles.
>> I haven't looked at the code yet, why do you use a fixup instead of
>> fixing the devicetree?
>>
>> Best
>> Markus
>
>
> I had a discussion with bryan regarding the device tree fix approach. He=
=20
> pointed out that firmware and kernel versions can be updated=20
> independently which can lead to unused reserved memory. So bootloaders=20
> should dynamically update the reserved memory based on firmware=20
> requirements before handing off to kernel.

Maybe I am missing something here, but isn't the firmware distributed
together with u-boot? u-boot gets the devicetree merged from upstream
every major version. So isn't a kernel update independent of
u-boot/firmware/devicetree update?

Also do updates to the memory regions of your firmware really happen
that often?

Best
Markus

--cf6ba24669d9128a78f72b54b80c5adbd3dd30f071d4f5d4d8d064a2c286
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaivyvRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlPo
qgEAp2jVoZSIl1DiEslIBQ20xxSpp+BdytcCzCMGmzc6qK0A/1VBygFLXJrjak8H
uqrjLYXp5kaDF02qiWo+STa1ZiQJ
=Grye
-----END PGP SIGNATURE-----

--cf6ba24669d9128a78f72b54b80c5adbd3dd30f071d4f5d4d8d064a2c286--
