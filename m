Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE88C4707B
	for <u-boot@archiver.kernel.org>; Sun, 14 Jan 2024 12:47:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34FA187848;
	Sun, 14 Jan 2024 13:47:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="eq9TjsPQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 953B387849; Sun, 14 Jan 2024 13:46:59 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E61218743A
 for <u-boot@lists.denx.de>; Sun, 14 Jan 2024 13:46:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1705236415; x=1705841215; i=xypron.glpk@gmx.de;
 bh=DwHXUXUvS6oJcT+jMwmDne5LkZutc7kvAPAP05QDFSA=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=eq9TjsPQVw3eUp6PZLebw+OLBZnJjO3WjA36gwQ4kO2ps9FqFWhTeUU+l0Y8mLk2
 k79eENcRLq8YrkkhOWmrbnbC3pP3hoMa1xlUVT0Wi8uCr6c4JTLMiI0nnEvcvnVbf
 A3XGnaZV8fgxOVChjsA8FrDihjdfWLQO5gze9KpsS/80PsPDPAkv+Z8UB9BMROMsT
 GEFiDDouLjIfEBzlKteXCQtZ/b5K92AFKNnzHyWjJ8xhn+7dzsvX0edKjWlEQY1++
 iGkuUGAaFWSoygVmzhrJmbE8JaJGwtSrtOyiTN523imRPcxFaw22I7k9Gq9JDdIdR
 O9Nlk3KlKefNin52sA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mzyyk-1rC7Mf1CmE-00x5Nv; Sun, 14
 Jan 2024 13:46:55 +0100
Message-ID: <1c42a17d-1043-4449-93c2-9020c1ded71d@gmx.de>
Date: Sun, 14 Jan 2024 13:46:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] efi_loader: rename BOOTEFI_BOOTMGR to EFI_BOOTMGR
Content-Language: en-US, de-DE
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org,
 ilias.apalodimas@linaro.org
References: <20240110011637.174710-1-takahiro.akashi@linaro.org>
 <20240110011637.174710-3-takahiro.akashi@linaro.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240110011637.174710-3-takahiro.akashi@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LyxvTnW9edmCVggpcw9f1SpcK021fkNR2Js1JakPBM5xX6ekZl4
 M/xH56tYY8uXdzc1h4Mc354QCpqX4pmnP5kuTUcxZuvW02P2oHjHVoZcXdPUmxIyOR3JXWE
 l2uXrGQka+tdM6iPfRKoLEYLC+oLTm7cppkiA3xYNQU3zmedjJ751Cx1MrqX2UBYj5j7XvW
 BK8AMqZ+JVfzDUNz4iJdQ==
UI-OutboundReport: notjunk:1;M01:P0:3NoBl44rf0o=;2hx1uVYqfj3+14+Qa4ixYloXXbO
 Lrp95BK181Fag7exoTP+CUXpd87s+zz+15KN4meWAdzL/FsYFT09gSnOxC3bdBUpRjJ1Y5uEA
 gr3dzCZpV9DlryIRbH+Q32Qx3v/d5sQGhR2+ZEX9Di53I7sy8jaAdi+2Wg+ZJzt43ShyiPYMT
 jGt1c8MLzZ0bKxDnRsOF0kofNHl/RkzMCQr3jDinle0w9jj40+yG8kdg1kRa/ULrznO5T8MXL
 QRr+2/82vOzWFDeTjXV+yT0Pm/rpaZ38FrOBgW0/AyLwgqAh0sQD/EdSKqs9R0q45jERrUOx6
 7kaEflhsPLRV4cnDQ9Vx21oJm0Fz2ObLDnYPfTn+12BIPkw2U8xz2fnzAQD16dpCSss7Al1Xv
 m8RwRQ6cxyE1M2V2E//tsAH+kLHqaYTQEmd/CZ0/Ti827MD7Gjsyc6pyoI9uRapopZ0RR6F69
 RI9XylDLWEk44kyrnaO2UbzWDOBGSLb2AcSKO7rcpg+fkaJmdqviusnvF1oE2BIzl7lSe7Hye
 A7HbdVK5DoDdk5NY9WT3hhGZfgXb5HdQCKEo+Wu4QHhEycPuh6VN/jeV0T5OdrajVImsFgQec
 vl9m3cvQxBw1D0mohsowy6mTZ+TCy8gB1catQiJQXogK98AiOe8j94yMGNYaxZXxeE6aWwdLb
 k+f/HEG4dOXj6OY6aXYchwjLvBA0xnWxinFE/PBy88ufA5GcOGqLbOcjHK8tp02CAXL8RoDXX
 HF7Lf5p3nZqzw62AxA+HRqVNCJM3Fhk9R2uIhNamUUgIbXvbSytl7PvH/dK0MBWLKP1FMVARC
 7OY7GTmQSxmmkl+WbKOacJ+pxh8YXlMLbgdsKtm4J8cV14GYfWcMk+O2+HohlguJkhIz5b9/e
 8ZdxKFivUowafaG+x7nXv8J3IeGx22Vdfk1c59tKhlJHGo70zW3WjcRPS7accDMRyaB3paJVI
 uGLdq2tIvY6KwlQSQo3znJWIMr8=
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

On 1/10/24 02:16, AKASHI Takahiro wrote:
> At this point, EFI boot manager interfaces is fully independent from
> bootefi command. So just rename the configuration parameter.
>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>

This patch breaks the 'bootefi hello' command in
qemu-riscv64_smode_defconfig and other QEMU defconfigs.

Best regards

Heinrich
