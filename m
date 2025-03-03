Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B26CEC19F32
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 00:12:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C70B1807B1;
	Mon,  3 Mar 2025 01:12:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="bninrGYZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBE2C809A5; Mon,  3 Mar 2025 01:12:50 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7291E806FC
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 01:12:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1740960766; x=1741565566; i=xypron.glpk@gmx.de;
 bh=bfSYTBrWOc+flIkIl5yNSImYodFQzQQ9RNfuoDAS9iw=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=bninrGYZfY9bauKeeWPxd9llMwNEBZrxAMdptKnyEsskcQShBuTO22BtD0njCowJ
 cqL7ZyuuRSe5VV0wJKjaOjv1ILaSuUo4zRzIWOwHtuCUZsDF+ZSXlJMq7PdtcRrEH
 3KYRvmhpQfTGaPdMz4GGeLuPhKo5DByFME1wiIiKtOt/9qhhkeEP/7bpCyeYRo33z
 kqAepJ0hIBU6HPaJROC+b2/P3kLXN77sTM1lspT+kuVW5g3Bz6h4qo78228D8UREs
 0G+gMFJIJRs4gn+3nHX5Q/WyA+vaMTKHLD4gbfUOUeaSFypWZ472gWr+S7Dej/v1L
 nnvZIIwuR9JB+QEHZQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRCOE-1taVnV3WvU-00LW8C; Mon, 03
 Mar 2025 01:12:45 +0100
Date: Mon, 03 Mar 2025 01:12:42 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Tom Rini <trini@konsulko.com>
CC: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: Re: Pull request efi-2025-04-rc4
User-Agent: Thunderbird for Android
In-Reply-To: <9e777fab-8183-4938-b578-cf0f26936f18@gmx.de>
References: <9e777fab-8183-4938-b578-cf0f26936f18@gmx.de>
Message-ID: <38CCE958-BF87-4BE0-9D0D-9E3ED8C3D16E@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1rUnqGbUbBTCIUuKPSSRYPhJwG/tzK8q77zUFicmgGPySbSwy7u
 WvECDmA120aAM+OVpFgnlbVAZX9rUERSlUzvBxdGRLvvHpKzz5aRgONaAAJlswN0jQcOAxA
 6Oh4azbg/i68/atH0RC7XCesx1+5Q2VgJ5wM8V6NbAVM5nLbcbN1qk09Fr3fLkvicWGCgc5
 Ed1AFWkeRSX95II7I5rjA==
UI-OutboundReport: notjunk:1;M01:P0:uyOtm6mgrHo=;wHH0UJkt82TAeGRU6Vlbn3wbWys
 eulWrpTLsJGCt3qhrx0ndbPjswrmsLFymdDFdTD/sKvdQY0NBJNmT1Pn1kKWDVScjFg+cn4st
 te3p1MjNkbR4W8U6RqyrzGT0nHdnMhKAJpj3NnpqfG612MpcSpT3ta7OYR4ov3BwLap2Ecwmz
 TaMSMvLUwp2DBW4LXuaajmxfrwdQauwV+FQTF5Tz3H3+DSB9MAZcO5Sd/qys2EnbmqcfVRmOo
 K0HCzmHYZyt1bSw+bh2FiCG39TTwHwSiR4xjGHXeRqQPJ8Q6VjipmLoYQnUTYRPRUChgvvRcQ
 xH5BM4BoOn6IqiaGh9qbcR3qwNLISJ1k1hj0XWvMOuON+0u+ocqJWsVy91o3M0sCqulh4IU5o
 gej4VbjVrylgFdICwHQZKRuIWOT8Evp334UZKB6whB0TnYJ9Aozo2yciOAVZlEZmsQhaM3tZR
 Yb8+9wg7rrBJt0iuyl2kofqQBo5c8NqqqgZImzg+4Ly0lmVqKTiX0AamFbD9m3i6G0opSUEZ0
 9UBu5ETMH0S+QApo+zLbi5kFEqeOxa5fF0XIslJ6UebVKjhuqyTUpM/F6RSDU33tNutrrCQFM
 Kt7eHHO5e345BGWAc3AmIEmDo9IeVRcR/8Uj3PNb16iAzyOKFyYB5Kt9RJaEVL9qedNGv9csw
 WnD9HHgWa1kr7fgijsIBQJU310FbcuqcsYdYHB0DaoZk3zGzUHk877JV+ssGlDiYjdjyiwd+Y
 LI72GlAJzLivyyLLhSQnRdYaM3e3et64VoV8E6agJnPidX7aX4uIpGOlCSXWBFKbWydbNs1Ks
 BH0afQR+S5/dD2zFiDqEh6t9q0UBtLaq8FRn5TjfC8ojlgMYTD9n7hq+RvHTfMwKr4SFpNCnI
 hU70DINQDbFCe2KYelLhuvRiKSr0ho32Kzk1LocYCZG0Yu/RtbD47/2LjhDCZJnuk170uXHJV
 haV6FuSQkQa1ynpmsmQ50GS8WY8S5tGGqpwn3u6H4EFHNGDWnzgHiBqUfIO9oau3/VJVsgppQ
 OfDiBvHot+Oy2loG3nMkj37uTKfXdhvZFtc1Tf6JT6VwouMtqGYXYThqatmgrFfGWBHi+Is5J
 VLysb63r7vPYV6/I2fyqUqQa+M5k0WbHWmK7JZuNFNcklZgAgZ6YgQORsu8yLTh1EObt6Lg6A
 j+g1N8Qr9HNuikpZreA/MsMu3mZfqZyTWpUiRNuB5stALsmUIkoZTk636QZLUaz8CpmyBBQ0f
 YBtFeLib/lduLQsFPSwWp9UObQms65mp0jUYSdB9GPUyKngzi5QDfUcx80o5ButDbEispPELA
 N9p/ZlhxRoHaRONKzh6rtQia9Z+/JxhFCZs0mpQIE4Gp0YkpuwtuqmduvqVlqEedvXEw+gamQ
 bjYbuon5mImj3CWE4HAo3GcKFhj0kIZOswtWgoD7ixNK6pHACDLtuNyYTa
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

Am 2=2E M=C3=A4rz 2025 09:11:34 MEZ schrieb Heinrich Schuchardt <xypron=2Eg=
lpk@gmx=2Ede>:
>Dear Tom,
>
>The following changes since commit b78f8677cde8b1dde31b66f5b780f2e9b62fba=
7f:
>
>  arch: arm: dts: k3-am642-phycore-som-binman: Add custMpk to overlays
>(2025-02-27 08:07:38 -0600)
>
>are available in the Git repository at:
>
>  https://source=2Edenx=2Ede/u-boot/custodians/u-boot-efi=2Egit
>tags/efi-2025-04-rc4
>
>for you to fetch changes up to 32a6c5eac0004bcfbb75d7ff9e9d627aca0e2852:
>
>  legacy-net: wget: fix wget_info handling after new tcp legacy stack
>(2025-02-28 15:26:05 +0100)
>
>Gitlab CI showed no issues:
>https://source=2Edenx=2Ede/u-boot/custodians/u-boot-efi/-/pipelines/24904


Hello Tom,

these bug fixes shold go into origin/master=2E But it seems you created a =
branch for next (WIP/02MAR2025-next)=2E

Best regards

Heinrich

>
>----------------------------------------------------------------
>Pull request efi-2025-04-rc4
>
>UEFI:
>
>* let efi_net_set_dp properly update the device path
>
>Network:
>
>* avoid buffer overflows in wget_info with legacy TCP stack
>
>----------------------------------------------------------------
>Adriano Cordova (2):
>      efi_loader: efi_net: let efi_net_set_dp properly update the
>device path
>      legacy-net: wget: fix wget_info handling after new tcp legacy stack
>
> lib/efi_loader/efi_net=2Ec | 61
>+++++++++++++++++++++++++++++++++++++++++-------
> net/wget=2Ec               | 18 ++++++++------
> 2 files changed, 63 insertions(+), 16 deletions(-)

