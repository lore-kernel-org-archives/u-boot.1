Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B2B5D6AAF0
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 16:36:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA1EA83F8F;
	Thu,  2 Apr 2026 18:36:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CrtFPz/C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4B7D83F8F; Thu,  2 Apr 2026 18:36:34 +0200 (CEST)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E8ED83F7D
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 18:36:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-38cd00b3b12so9909461fa.0
 for <u-boot@lists.denx.de>; Thu, 02 Apr 2026 09:36:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775147792; cv=none;
 d=google.com; s=arc-20240605;
 b=Jn4fXl0HNORX0Kay7jGN9Zt8iCIMFnHG4xBHs7zVpYb7kDkfuK4Nva2QGGpvJdy32T
 nWB/YN7yixu32W0PA40hW28dfse0nQVnx6mKZCowsxi1CwtJa56ZKDoNICj3vGzK5lns
 ZTiT9RUg5akHnK/yiav3P2JfKafwbNwSRlDyxHypSdR4rHIaAfuQ6uICHmlpkgjsIQMi
 g2AyYwofpVWUGmWbtijwCNRt0/mph19vWrFALA43j57WP9Sw4GFkIdUq9eL+/AEHEMhj
 5DL4On4Jgd/EOrtc0imXmdd2rW7WEH3DDNuhHAqS1HQDW4Izfh1HVNwkEk+LJom7pz6+
 9Ugw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=UAXdcQWEZkZK6arP9P3iPwsaaixm29BC4Gu8H6fC14M=;
 fh=srAziRprDj9yNzW/Ae1CHsxziWLZm2lXzDVKtcXEyS8=;
 b=OKi5t6g2tBEkBm9o4BdzRgH9fVtx3NDruZJQgVRMZYc78Mq8DF0jJL30R2UUtX2+2/
 FKrB6PHP5VXInO8a3sDo3o3ElYWOTAkTT1dS2Z3wG2B7fVv9e6lfqMRf3sjosW3jSCb0
 3JSYxHp/0IMliZoc8LG5vdF/8xvbyoYVwjW78CH7PJKAkolr2xqYJyMD1V4WGStQNFd4
 zTMiLzjRMmpCxLLopBKoKnyU9PgX83ahbTFeARmtchfQyEbIupcKqnw+PtrdlB7IzOYH
 t7PEnn5J5FLemi0YkcWSumhKlagSJg6Z4MdVwXw1YkmoWzOQQovUQlfv6OZiPU3fIfPA
 x7Ig==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775147792; x=1775752592; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UAXdcQWEZkZK6arP9P3iPwsaaixm29BC4Gu8H6fC14M=;
 b=CrtFPz/CgVvskJZqKp8kFXhUXyZYrwWppOkGaRsdG3fklLVym8T3iPKqWLuwkRHrFl
 ydgoiXUQ+qxkeuMdKvS877Ex4hSOHvYM3Y5a3ehjNe03o/LBOelJNmkrMDYmzJ17Bi21
 xKrW5rsyKFiDmdewqRZBmV00TcfyIM1St5Oi0iPG/KQh6vzRx3dOxAcguWzy3FhPzNi+
 RTLgrGkzYQftc9/FnhL7m8qO0lmu7fbvRsay7K7Eia5YXybNMm8mGMik6+P/sRJ8R3e/
 x/5Zeeo0m3NgmHwc+TsaZjyHu3YswXtzFN6IPes3wcY7flsWhx3WxeW5Dvd7J5YjcyY4
 Kbjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775147792; x=1775752592;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UAXdcQWEZkZK6arP9P3iPwsaaixm29BC4Gu8H6fC14M=;
 b=gK6bD+lhw/Uzgk4wexhSz3Lb8dqsAZ8JB/+3WOCxfbBdo4JC3o83qDlDtA0SAGpSFi
 xhnI3ydhd8tNFB5aM12AcZOIxzZP2LyxNaVcQy/TeHKqxGwlqyFo9gk2FChKsw+UbczV
 JGs2vF7MWbGamPQJ0PVETCu5Oj2+wtKuAROvHcaUzXUd3C5P5PEIwGl/LfjBXbIV1TAI
 yTqKbYEynTJoeW3R6COmaMfoAoTlmUxR6TuCgKcJodLhy3ysMijhZFV+rjAN5DFYV2BC
 8dqMDM9lSJl4VH1pf0MalXOcW2pgkXEDXsIIHh4vbfiHLer9KL3V9djoB/ng9oKC9X4e
 NvFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4MrEYZniophHqoZsjEbX4klqTOK2W37+iWh7M7S9cJmwB+bAJZHdclUGv5UIbTyqpMBAY180=@lists.denx.de
X-Gm-Message-State: AOJu0YycJ1Kcu0vaKcO4nEqTdmfNcxut9dIS8DLMcm6wbr9hR886w6lp
 uqCgqWBUbVmtffuBM/51Jmi6fsBQG80QF5sUU8jbc6i89xzBJx5+qwUle/7+wxD+ziVDR6tZfPR
 zynhGt7iM6UXCpENzEguwxjED87KU/xz/eHzB
X-Gm-Gg: ATEYQzw4g/3lndc4k8io8KP/e/b5Iyxb7gqbaB4O13Voq8okouKH+seQeXfLhUn/aKD
 9GW/41NN8nwTZ1PJFGVOMYZCNqvxXtkwV/GKL3ix//FJieqdhAwAgpOa9/OEKipxUNTmJL7ILhc
 JJXhQW4t/qDsyr/up3y43EojfTyKpZkm7Q2NQirAV/IqAFN8Q8QYMh60kGvdU3jKuU1hnGxc7Mc
 +25w2DBXpEMQA/EFavOue0RtLMjZhzIFgcaq3G23IJRBiWLTR1UtnkJbyBhEZB1cWWz9Nxwg6LA
 TpD8xfdgJ11UTxOPyy50E+Kac5wrVgN1w3Ytxz5VipB1qAZH50UMlHiRoQTX/bjkq07d/CN7
X-Received: by 2002:a05:6512:4017:b0:5a2:879f:cc07 with SMTP id
 2adb3069b0e04-5a2c75fcbc3mr1616524e87.0.1775147791433; Thu, 02 Apr 2026
 09:36:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260326091136.709342-1-Alexander.Feilke@ew.tq-group.com>
In-Reply-To: <20260326091136.709342-1-Alexander.Feilke@ew.tq-group.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 2 Apr 2026 13:36:20 -0300
X-Gm-Features: AQROBzCKBAZi7zDkhFwMZVqxiLiyCcDF9GFmkqYH08Ij1jNWhC49cm5NZKQ86oc
Message-ID: <CAOMZO5DiHkQfjthe1Yyur86vpAX6-zNZZH-JcKADXNRhfZxV5A@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] Add support for TQMa7x
To: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com, 
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
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

On Thu, Mar 26, 2026 at 6:12=E2=80=AFAM Alexander Feilke
<Alexander.Feilke@ew.tq-group.com> wrote:
>
> From: Alexander Feilke <alexander.feilke@ew.tq-group.com>
>
> This series adds support for TQMa7x and is based on the preparations for
> additional TQ boards series [1] and [2]. It has 512M, 1G and 2G RAM varia=
nts
> which are detected by the SPL by initializing them in descending order.
> It can boot from SD, MMC, SPI and USB (SDP). SPI however requires an addi=
tional
> prepended NXP header image which is currently unsupported in u-boot.
>
> The i.MX7S variant boots but is not being actively supported.

Here is a warning while applying your series:

git am ~/Downloads/Add-support-for-TQMa7x.patch
Applying: Kconfig: update build-target for MX7 with SPL
Applying: board/tq: Add common SoM API
Applying: env: add env_set_runtime() helper
Applying: arch: arm: dts: tqma7x: add u-boot device tree fragments
Applying: arch: arm: dts: tqma7x: add boot phase properties
Applying: board: tqma7: add code for u-boot with spl
.git/rebase-apply/patch:337: new blank line at EOF.
+
warning: 1 line adds whitespace errors.
Applying: configs: tqma7: add defconfigs
Applying: doc: tqma7: add documentation

Please make sure to run checkpatch/cleanpatch to fix it.

The doc part does not pass CI:

https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/1418796

For v4, make sure to pass it in CI and send me a link for the CI pass.
