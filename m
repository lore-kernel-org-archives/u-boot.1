Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A90CC3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 17 Dec 2023 10:49:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFE378761B;
	Sun, 17 Dec 2023 11:49:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="iPLkUbdD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 883A787727; Sun, 17 Dec 2023 11:49:24 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 604758750C
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 11:49:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1702810161; x=1703414961; i=xypron.glpk@gmx.de;
 bh=xEn6QiNreveIqF0fs/3ZvQe3zoI29pPKLjIfhkj8mjM=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=iPLkUbdDKuOWSQrqOx5RXa3InlROCiw7pwnz7mgo9Wi7McyGwsxfJR9EaSRscsQT
 zxzPAqJvsQQfsyHe+SL64cwHZ7knj076GFs6AXQOtDiLfgVqTMHXxTyFHAc3eqqOs
 KG1HjQuy64rD1hs6Zr/2Z5WowPuVEWK9vm5KhfEPfo/HKwJ3Efty7JZaIdgGhnzwI
 f0ekjXs00kx4J1xQxSc4zzjKLbwml6iCG5Wg3h9yWaQy4xgtywDQfYfexhIS7kwZ2
 wv0X7lpH53I1cQNo1LDclc67MDKbw4h4RA+01kNa21LVOaFt4GDezk0TujtkNUBMb
 bPR0vMuVkfRGngDmbg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M4axq-1rDAYB0bMU-001fH2; Sun, 17
 Dec 2023 11:49:21 +0100
Message-ID: <b90d78ac-212c-4050-830a-837175475404@gmx.de>
Date: Sun, 17 Dec 2023 11:49:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/12] cmd: bootefi: move library interfaces under
 lib/efi_loader
Content-Language: en-US, de-DE
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org
References: <20231121012950.156539-1-takahiro.akashi@linaro.org>
 <20231121012950.156539-7-takahiro.akashi@linaro.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231121012950.156539-7-takahiro.akashi@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Tv/FGFZ3qad0eIj0TwnotQdJjnLXzP7U4afF/+MOGIkql5LQxNt
 k9sbZ7WG/sI62Sl0wVzd4drj8Ndhl58+ExZCl/vhVrVRnCWM2kA3UglO6Za39Fzd2LSXCtq
 MZy+y8D42Oh0/RDptYR/tuo0iLsGZv2J2TaezQwKr6rx0DFijXvB1SgaZ7MYX0DiFHrUOrh
 eYdxDWm+GCwSuTxDresyw==
UI-OutboundReport: notjunk:1;M01:P0:XFJDUU4mwCQ=;oN6O27OzqoqVhO41bXqyWZl7e7M
 mJae8FyF3vjxKSamaIXKfsEvS0SYlQRWn+TCQt5w0DDWnwyFB9GiKLpRHOr6JtFEHQC9v8QBe
 2G7bCzrGN2VlCk4U8N1+sKF6cy5dx4fYKRAVyzC/Xc14rOEuFUN94In3UdbpONTRG0DG6VHOg
 adx10gSXujqsYUOJKTaLaWwhsMZfj3rIPmgCR56+poMgI8GpjOoX9NWGadOu/5/HSlc26UZ4b
 ya65eB+py8Ct7N2ulDOaHRYQbKw3QQRGKepNssNq5am9qNNlAQswMrbJwoWAkW69dMkKQIlM0
 YWOlXQeaW7vxy95mOqC/fPkkWovSkQam5b4mEIlfHv+0ExSdqdZyrnX4ey73qdZZP0d0KH3E0
 R0Zgqvlax8GS7g9vBLuEQ706y4+DQqVwAYLXEGbp0C4Q4gFmujxCOx+C2viax28Y85CcoAXFY
 LO+N7bN96jUVRbxCNUN0eADCZEzUc6nt9mnNJZ6IqnU1RfTGuNFmWmdAAI8Ww9ldZ/C7u1nb3
 h1UNOWiU7Sku93osQI4G9Agj/jtx+PmRlFzEZ0BWVNroSRcmS46BWcRzZvJvB7GjvdvOv/iub
 CirR1HheiVqd4NUZgggbAfYVcPyUwmrJETUMKSbLfWZaA1+9kEVvPDoVtOHIwN0+VATmabYQI
 yfMjY0QXVcJUYGp8uw5YSWN9ZuKIRdgpOjrpaoy58E/uMqzqftzUVCFajxNotnJz6e8Jnv0fy
 92s6j24lcpEqDHRhudqF+H85jItE3shl9Ihy8cETSTpnDg/ALZkTq5BtpynbEsVMoE7sR5qpb
 iw+VzETdMuze+FpACiuYzDvxmM50UbVWRcMzLRCpSbyEwUcG8VHVWikXb7w7a+UZjco/4ay71
 uNPPMs3pi53nmwDjMdmmhDOuYSREw9K3MBmNy2Jh7ik2ce+fgDrsVadZPYssO1Q0QE/igPiiu
 IbYu9V8BUyH8I8RT3azUCAXC0uU=
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

On 11/21/23 02:29, AKASHI Takahiro wrote:
> In the prior commits, interfaces for executing EFI binary and boot manag=
er
> were carved out. Move them under efi_loader directory so that they can
> be called from other places without depending on bootefi command.
>
> Only efi_selftest-related code will be left in bootefi.c.
>
> Signed-off-by: AKASHI Takahiro<takahiro.akashi@linaro.org>

Hello Takahiro,

the patch in not applicable anymore to origin/next due to:

1de1a0348755 ("boot: Drop size parameter from image_setup_libfdt()")

We will have to rebase the series once reviewed.

Best regards

Heinrich
