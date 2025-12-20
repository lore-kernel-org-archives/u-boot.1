Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C39D3E668AE
	for <u-boot@archiver.kernel.org>; Sat, 20 Dec 2025 13:55:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 472E8803F5;
	Sat, 20 Dec 2025 14:55:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Z/O4zWR+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84534835B3; Sat, 20 Dec 2025 14:55:26 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6589B80325
 for <u-boot@lists.denx.de>; Sat, 20 Dec 2025 14:55:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7cac8243bcdso1823140a34.3
 for <u-boot@lists.denx.de>; Sat, 20 Dec 2025 05:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766238922; x=1766843722; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DLvHVRiJ3j1M6Jfl2Vcv8EUS2TACRn3zx2dRWGJ4I9E=;
 b=Z/O4zWR+HxzocaaKUL2n2L4n9PMEQ0J5pbM5inf7UFq2f94B8f72bHM1CHDAlcS5RI
 7maBwxmui+VE8kv6GZV2LYSCAy6yL5l5gnnjjutqtExzMtdL0dBgKnpNNKzDGpVKnLF/
 CT2G6uOenanfxGzIlJbd7BrsSsZqpZhkQTZH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766238922; x=1766843722;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DLvHVRiJ3j1M6Jfl2Vcv8EUS2TACRn3zx2dRWGJ4I9E=;
 b=NDuixTnXMrUsWOR0KBdgpr87xdpa6ZNYselyH26CeV648RGC3EgKYmqLbZR3tO/Chp
 /rApv4Le/ZJk7carjxmggODdoFibDGFmH5VUtUoMe+DOzbjo4aqpWo90yExwdZlbyVZr
 rErSHBqKYuRoKgdiE/M+FT/QOhLXaEMRttxLvoTczfQBTvgGB4/2M8V90/TFEc5wwJ1O
 7dUeZIk8e4IIT/Vf6WdcsIDehZP2PohPlZPnznvDPWDDq4wKowbbmc7u2iFOWMSlfpNI
 RPCYBIHnM2DS/aVhvfKqcQTric+aK1a5lxPr69/4HFsQYG3or+y5CU78bzhvevcbdksZ
 LFvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1KF+07oM/b/8rTy1LyIe9/eFO1MqLRAAxt69GFbTwDTXHKKom+NDAjBKa2tlvsc8Df2rEoys=@lists.denx.de
X-Gm-Message-State: AOJu0Yy6CFFWA4dC2D5EMTzDvDeSJqPQTYk7Q+EAZ426TSa7MMPhCSYK
 XEJtqJEWAlCiqiwzJ1f2WwnoYoWoJiRnEdy7RYvZdElzpFRaOduV6hLy4HY86bW7QAo=
X-Gm-Gg: AY/fxX6dyLCjuHu6ww0VhtCNtBlv0oXw76R7PDsO2lRTUIylluL/bULFFXF9fCFeFsS
 l3ros9jQ9G006qKrEwblsmfaC75sx0ejpQGB3uCgCHEv9xrZozMFvjD8So8XVVXAPug5O81YJUc
 3HUm73VP3wtYYKYRTWnoixRQiD5xuMAlqX5FEXc0nkkd7I+RsxsC7++ab0RByv9PsRbOOg9S7Ln
 NPLE5VoGSYFskJZjEvqZ3YpXr+7GOLlNwyreMMToky0uyaltQUSswGscHMopLa3I9ZNCo63Ihho
 2zEq5msdMsvEQySdEhEb5S28AU++CJXeEmmluUI7ZlsaRjgg6v3m9TQc241uQAPt4gUF+OUWrHj
 PnOwzyRMhfg4HckmDrFVXbOGh783LK/xAt7XxCTq8ru+K8Y/SzIP48djNjcoDLGkq/0G+R/zFoE
 jze/VskWTlZfPUHwqy4FxbVGMMF8WtfD3gcBLJnoQQ4z2gdtX8VQ==
X-Google-Smtp-Source: AGHT+IFzkG/QA8oULmGa3svrEvgdWFNluFIkp8wZ9hfKY0jpEBgkyf+EvbOkEhqK9tMEMLR2fOj6RQ==
X-Received: by 2002:a05:6830:448d:b0:7c7:6752:2d8 with SMTP id
 46e09a7af769-7cc66b10171mr3311086a34.32.1766238922315; 
 Sat, 20 Dec 2025 05:55:22 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc667ebe98sm3717031a34.21.2025.12.20.05.55.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Dec 2025 05:55:21 -0800 (PST)
Date: Sat, 20 Dec 2025 07:55:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] lmb: always enforce CONFIG_LMB
Message-ID: <20251220135519.GV303283@bill-the-cat>
References: <20251220083343.10060-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="F3jHEIkefrv7x+3w"
Content-Disposition: inline
In-Reply-To: <20251220083343.10060-1-heinrich.schuchardt@canonical.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--F3jHEIkefrv7x+3w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 20, 2025 at 09:33:43AM +0100, Heinrich Schuchardt wrote:

> We don't have any platforms left that build without LMB.

We have a handful of platforms that don't enable LMB:
$ ./tools/qconfig.py -f ~LMB
22 matches
amd_versal2_mini amd_versal2_mini_emmc amd_versal2_mini_ospi
amd_versal2_mini_qspi xilinx_versal_mini xilinx_versal_mini_emmc0
xilinx_versal_mini_emmc1 xilinx_versal_mini_ospi xilinx_versal_mini_qspi
xilinx_versal_net_mini xilinx_versal_net_mini_emmc
xilinx_versal_net_mini_ospi xilinx_versal_net_mini_qspi
xilinx_zynqmp_mini xilinx_zynqmp_mini_emmc0 xilinx_zynqmp_mini_emmc1
xilinx_zynqmp_mini_nand xilinx_zynqmp_mini_nand_single
xilinx_zynqmp_mini_qspi zynq_cse_nand zynq_cse_nor zynq_cse_qspi

--=20
Tom

--F3jHEIkefrv7x+3w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaUaqxAAKCRAr4qD1Cr/k
CkLyAP90hC0+xC7ruC5vYvW1+rj/o//eFT+sNnGEgJK1R6ueAgD+IFxt9lKlEAhN
UR0srXsIdE8YhA1+dFUT8Ytf6LIUtQU=
=Cy5p
-----END PGP SIGNATURE-----

--F3jHEIkefrv7x+3w--
