Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FAA9C44536
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 03:33:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 958E08341A;
	Thu, 22 Jan 2026 04:33:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R+e91dBu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC0AA8341A; Thu, 22 Jan 2026 04:33:34 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89F5C80077
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 04:33:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-59dd7bfeb8aso570736e87.0
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 19:33:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769052812; cv=none;
 d=google.com; s=arc-20240605;
 b=kl8tqvQqwzmaqRZwF6Nk/UK9HyA/3lSe8ad+wc8UGmo40mpWjkG91SX8PWEU5Jsq8f
 JE3N8Og7b75IVMvnkZNMjlau8o9yUwnZDI+fWq7RRDlE2iJLWiKFWVNVDptqm1DVU+DD
 T4ZnkZhGyOQUFoRXbxO87CzpUZOCkJDldexWcMOh/YIdL32NO3j7CxUBgyVXmmE2e47m
 cj0aqofXrkH2/G++T7zVFWTdQQefrwgyr/GNDlZu1Moud8AkW9r0QnWfxF1rpcdHkQmk
 JdJavOXJiWAKAE2xaYYszLHTk6221LhcP1sdu4se2x6pHewvALm1YKFeaGKkeB8tkyhh
 30Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=B3wRO1fvxyGc35jmVwANrhLZds9xsi/sZ5SQlvicFNU=;
 fh=JyVYAqOQ1ckqGUG7bs/mZLOy/LfusYtfrFTH5a5FbxI=;
 b=klGbw0Pvd27KJkGTglsM4/ij/M6Ygxz9ooYT0G9WGMpIrNTvsNBu4vDHsWfTOa0thG
 gc8FWqF43UId36coTJePqi0ghZpF9g0L5Z/3o8wirkip19CgddSdmurEr2J8pccsezh1
 KWcfOpA6OsquSXTW/eqtZNmJxVXJOY7LrlZORCg5uIlh9nKkXKvNDIdCOcagScMQdeIk
 oMtFLCYoy1T4jypv53BA8R+F5O9dZtH9pycpkoKTLn9mOdYdA5fCd04Or9fDAmjRO4cu
 VaUayoU+7B93BPBhvrdJCrfNVEySi3OwpyXhaygaqmSqZuNdihVtLBMLHPr9JbPB7SAf
 pgZA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769052812; x=1769657612; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B3wRO1fvxyGc35jmVwANrhLZds9xsi/sZ5SQlvicFNU=;
 b=R+e91dBu4mJ2q5aG1PbA5FJWoOZMsE9IPhRQHcNXwIplRUOH/fS2UzwUD9WoBvcJJS
 NlpIuDnOFw442uY57+QBdsJOASx5+gkvKZG+nL6JeYEmjErlEftvS0QrCm2827VaH+1g
 w78Jk54cEB/c0zhBrRqqD5eXlPPvK31q8+LUHpDQgYmkWDQN8BP2HB0TjfDoNigUtGRh
 3baIpYZwjmX1k04692kaH9l4Jv+qo2YKCS2C82FiLmRD7L+F5WsAmqQxSDBzUBXszqGp
 mQ88SsG73sxurnTMrApQ4KrNZyZ1d4uNnhbiMMWu6shSHnzVizKplk5dSAINcUoJPTBo
 ESCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769052812; x=1769657612;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B3wRO1fvxyGc35jmVwANrhLZds9xsi/sZ5SQlvicFNU=;
 b=GIF5DcU4pCu5KMnGY7oKHGNsWKruK8MpJAYQrHzaQA14jQnwunJnEctKfd4W5/p9Xy
 XLezS3dk4Dd+qQTS6mrgKM+aHuu4oSGWWVrdJoPtpGW3wV6CInzIHi/YWgmHBDY2nXYk
 cbUlw2IpQ1J0bUCBKXMRjKHKyw8U/cO6DboMGV6BtTBSB8H5hIkd0e9JMqBuKUQkq7Qh
 AXwZaKkAYBzCbrqlN1NST87veL0v5dbnAuzma1WhrrQoshzTOKiTQ5j7sSfHZEY/5NCW
 wF2iYP5KYHw64gmKrnKivB545Ky8DjGT+SKgFDJautry/5QN3zCw3T/NkPTS0+HcrVqD
 Bw4A==
X-Gm-Message-State: AOJu0YwrS8kURBFDkHq7NlsJdaYffB+XCNp/5hAuyclHsWlAGbq76PvW
 7nkbEANTFx3UHg6RjO/rK+jM2BlGWqZyjXAQjaWReaLx5MAdPImKR0KWkrGPjCu7l9CmbDL6uSJ
 VNqCUXSIR7Ud6jHKqJ4X3fprsGNBsmQo=
X-Gm-Gg: AZuq6aJ3QMxpn+G8pl688w3cPWncDCUQgm5q/15vu32jeKawN0ABChw8W/SyfjNq+DS
 SXhjUDUzoMNsSr73y2Lb2XU3t+Lnl3MRPiyiAKnBmiDz7Dc00nLcgq7X5eUXFEG3L+FNJnWvxBw
 OccH7sSCLiYThCr4fzpzl/ZHwtQ6f7J2Yb/vX0WDsR7Smi62NmOyZKXdmj7/twH+s8TjE2cp7Zm
 RxANviRaCKbH/sR3rMZoSzgupKNQBG8FsD01G4WxUaNRMIAQ/zHbgoTXO/gAtBKLuEslvT+Qo+D
 GB/r0G5JlPrvvFL/gQ4qtXvs
X-Received: by 2002:a05:6512:3b81:b0:594:253c:209f with SMTP id
 2adb3069b0e04-59baeef8a4fmr8004581e87.39.1769052810513; Wed, 21 Jan 2026
 19:33:30 -0800 (PST)
MIME-Version: 1.0
References: <20260115222828.3931345-1-trini@konsulko.com>
 <20260115222828.3931345-3-trini@konsulko.com>
 <CAOMZO5DZNJ+=AP1spWCv7Ar6etf03H=DFVU=mXZcC7QFTGoh_Q@mail.gmail.com>
In-Reply-To: <CAOMZO5DZNJ+=AP1spWCv7Ar6etf03H=DFVU=mXZcC7QFTGoh_Q@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 22 Jan 2026 00:33:19 -0300
X-Gm-Features: AZwV_QjKI836-aWUy-i1KgS7U1JT1obqPJ-KeMJkDkXhCGL58xtUC4FY1B_gIZg
Message-ID: <CAOMZO5COTa3ykhF8XZyzmJ0QZNotK4USo0LrH0XBJLogatfXFQ@mail.gmail.com>
Subject: Re: [PATCH 02/10] arm: Update linker scripts to ensure appended
 device tree is aligned
To: Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Beleswar Padhi <b-padhi@ti.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Adam Ford <aford173@gmail.com>, Andre Przywara <andre.przywara@arm.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Eugen Hristev <eugen.hristev@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Joel Stanley <joel@jms.id.au>, Michal Simek <michal.simek@amd.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, Stefano Babic <sbabic@nabladev.com>
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

On Thu, Jan 22, 2026 at 12:08=E2=80=AFAM Fabio Estevam <festevam@gmail.com>=
 wrote:

> RV1108 is also an ARMv7 without SPL_SEPARATE_BSS, so I believe it is
> also affected by this change.

The change below restores the boot:

diff --git a/arch/arm/cpu/u-boot-spl.lds b/arch/arm/cpu/u-boot-spl.lds
index d780a5060774..fc2b7fcb969f 100644
--- a/arch/arm/cpu/u-boot-spl.lds
+++ b/arch/arm/cpu/u-boot-spl.lds
@@ -40,6 +40,7 @@ SECTIONS
        .binman_sym_table : {
                __binman_sym_start =3D .;
                KEEP(*(SORT(.binman_sym*)));
+               . =3D ALIGN(8);
                __binman_sym_end =3D .;
        }

If you agree, I can send a formal patch.
