Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB7CE88D66
	for <u-boot@archiver.kernel.org>; Sat,  4 Apr 2026 11:39:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF57983B8F;
	Sat,  4 Apr 2026 13:39:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N5N6aLXk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A033283B8F; Sat,  4 Apr 2026 13:39:00 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7A7283642
 for <u-boot@lists.denx.de>; Sat,  4 Apr 2026 13:38:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-38bf47a6f02so23310011fa.3
 for <u-boot@lists.denx.de>; Sat, 04 Apr 2026 04:38:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775302738; cv=none;
 d=google.com; s=arc-20240605;
 b=FHvLvyEGA6kU0lkJOyoNQZL+HpMDjF3KQ03/ns1lgN//CxfSH9MqRsvzIC6Fgc5UyN
 R8fbaoJCvcknA4GdhqCvcg/5JSLx81ZnqWdE941YPYb7sR0DPuXX9WfuSXJYJEKnuSW6
 4I1jk7OJ9HM2yYWC9YBCdi2ivD6r1jox2tVkh2/DTxX8+oXEf02/Q9HcPhxc69VLdt70
 +2sh70b+HBbtuHuH9TI+V1tK0vRNrEqDgARzpe+hcoxPuCdZ7fMTA4YyXEPhkHfejJqJ
 9yRPV1w/hevYRqRYlbWsMSU5NRYu1XFZH9s8EQKzdLwUdcBX0jQRjvHUyVmxnAWP+Iq4
 p8Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0rEFWx7NktTo2Dy6K2v0ir6iZQI9keoeN9RrQ8MUdNU=;
 fh=V/M/ATxpHUnZwpQBx+FmQCx6fcnVq3tSpnaTtKlnrVg=;
 b=JRoVSMYxSC7y9BDE0wFc1Ty7Gt7xg/R0FJvkQ64WAUpLgSkVssVykeclcj/vMJ/nyM
 Xs+uKQUOfoapqn8hrZYEPddNy0N/mh2JkAf9h5vpO4FJA/i4q2/tabDfKlnM7Mrw4+nt
 wdyv6GVlqZmwHh7lhp8/jTn7wAnq3qKe2T+Aa1IclmYZZiNYouCJKOWT5ImUq1Oxg2P2
 uc+JLrKeVLO+IrLoT9IaFB0v7lauFbvDJbt25mKXhRiiGdqr8tarYyPPS6SVqnvTFT3N
 3dKkXl5Kaer0JkhSYR2LyB1kuLMDTOi3SBMnHINYZlkALKC4mF7JmRQvBTRbx45yXMai
 u5wQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775302738; x=1775907538; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0rEFWx7NktTo2Dy6K2v0ir6iZQI9keoeN9RrQ8MUdNU=;
 b=N5N6aLXk2LA+xESecMp5q547YAKJyBlw/4iPQi4E4I3SIdEFrqz1ONQJUYe+zR0gse
 SyG1POFEUlka0HyIMbwakjLgnzzCMc5zDoppNs26ZdqiNUeEvl3B0LUQ43TfrgQ5oiI5
 ek65gBB4fmYUw8ff/EgmFNs6OeS+E/UCjJ9tfVa7FoBTFJzLJLhY+FHxvGGn9vtaMM/M
 veIAVeF0D9jKl6EocoWbozjbSKS8a0GshantPcUqme8D6iXtLc9GKRZSicrqs3VQNBci
 jfWm+OH6z+Wtb8ga/XsEuUQ3T9UHhU77VIx3VaQxey2kn22izCkQS5wFYqj9amVHVgnR
 7fdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775302738; x=1775907538;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0rEFWx7NktTo2Dy6K2v0ir6iZQI9keoeN9RrQ8MUdNU=;
 b=qFwlWqlgj+qN4LVvcDzih2CINmR6+0se6khFGmEUnU+hm9GVcRITESoxH1QTxKGzlX
 FMu1lk209LbklBuln94U3STPUu1WgzAwg9dyUv9A3IB+rSCYa+KHA6xyKHlu5c9WaNDb
 iv4TjTGzm+3+rVZeV1M9KZqiZu4TBzHq9UD64VrAU5C9/NIeQBQ9KxPZ4WCPye+E/Tjk
 UzTEK3oweOSrk6hAecjK4pq2Qxe0jIupdqf3x7Jb4jSyoO9gvIEMWkc23iYaQHB546js
 JF6Zu7RXU8LIl3Z11br6I8OoM+g+HtInu/3NilIX6XL8j3NgCp26mXQB4BUghvCV2r14
 xvHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVUrI41C9vFTGmi6z9C10ax/XLQ+0legAGreswB3qbKwbEvjDWEWKBLxbyYHqCsOMmZbDxlwk=@lists.denx.de
X-Gm-Message-State: AOJu0YxUoTWXjIcUihqcrHSuqSruT8DgTovH8/4Hdoven1pgATCz3S8I
 Wd1py3vZ29wI1+gS+Y66wbMdAyYw+CXKDzU1KPBrJeeuTuUNYRCjXo0yLNmLbCh5xrzGKqZMfHS
 eMdERX/g8aNVuRWaQz2s/9cmmGjMz7E8=
X-Gm-Gg: AeBDiesH64b4W0uDuQG2bUqKtes253/EDlyeagmakmci0yotS0gw1S7Mw+6lEbfjYA6
 SjYd597rv5K4WzRWz9WHHkHIToOEXaRmLEIhroCLxvJ0uafrI9dzy7Sb5dg6UP5Dbn8a0/bYuhS
 Lz3TOpPJCxSojjNSzKuP0BQJ6CeFcIpvwn00D+zDBNpJTzO//Uas/FtVa3EbRzzpcFXbASYoPIh
 gTcHdsXhkADjFS2UPniTF76hEmSnnVS/hkRUijQiQjmLhQ3SjYB68XidgZjbuHWVqVNY5QgcOgs
 6XfOFV+reEhUOTt93uDnS8RzGqyx8HdFfgc834j2txJNP3oRDEMFIxEMMjVLHlWIWR4xk46C
X-Received: by 2002:ac2:4d0a:0:b0:5a2:abc3:eaa8 with SMTP id
 2adb3069b0e04-5a33758c7aemr1344667e87.41.1775302737662; Sat, 04 Apr 2026
 04:38:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260403-enetc-v1-0-e42ae28ae3fe@nxp.com>
 <20260403-enetc-v1-3-e42ae28ae3fe@nxp.com>
In-Reply-To: <20260403-enetc-v1-3-e42ae28ae3fe@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 4 Apr 2026 08:38:46 -0300
X-Gm-Features: AQROBzAHqhq3nQVV4VFAQqMvmv3RTjuPjdR4dzzJVhpX91JzCaOI_3HftopGdpo
Message-ID: <CAOMZO5A_Tg4XOYvUekNH8a-t+_0nL7WU8fM1W1LK3QcQDHTsjQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] imx952_evk: Enable ENETC0
To: alice.guo@oss.nxp.com
Cc: Marek Vasut <marex@nabladev.com>, Tim Harvey <tharvey@gateworks.com>,
 Ye Li <ye.li@nxp.com>, 
 u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>, 
 Thomas Schaefer <thomas.schaefer@kontron.com>,
 Michael Walle <mwalle@kernel.org>, 
 Clark Wang <xiaoning.wang@nxp.com>, Christian Marangi <ansuelsmth@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Robert Marko <robert.marko@sartura.hr>, 
 Yao Zi <me@ziyao.cc>, Heiko Thiery <heiko.thiery@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Alice Guo <alice.guo@nxp.com>
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

On Fri, Apr 3, 2026 at 8:02=E2=80=AFAM <alice.guo@oss.nxp.com> wrote:
>
> From: Alice Guo <alice.guo@nxp.com>
>
> Enable ENETC0 functionality on the i.MX952 EVK board.
>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
>  arch/arm/dts/imx952-evk-u-boot.dtsi |  94 ++++++++++++++++++++++++++++++=
+++
>  arch/arm/dts/imx952-u-boot.dtsi     | 100 ++++++++++++++++++++++++++++++=
++++++

Please explain in the commit log why you are adding these nodes to the
u-boot.dtsi files.

Have they already been submitted to Linux? Have they landed in linux-next?

Please show the full picture here.
