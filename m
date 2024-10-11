Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D617ECFD347
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 23:45:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 683BB8942B;
	Sat, 12 Oct 2024 01:45:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="jChg1M9P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 378F189426; Sat, 12 Oct 2024 01:45:17 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38A6A8942C
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 01:45:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1728690313; x=1729295113; i=xypron.glpk@gmx.de;
 bh=q8lbXTuvMfD1SpK8smpqQrMGdtLlmdVRja4qtcqxE/Q=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=jChg1M9PSsggdUrm6GFj6BFtgxHHOLWWf8iwZrY3nX4+AcjhjC98MjCNzMTF8pu8
 qNt6Cy43kvI/NmhpOHfbo+5GbngnC2Sc7knCt6rRdO/qyT1LUefLwaWJIGYId75Ym
 rrkZRYfhHImXjapJjGhbNHrJebEFJ2TAi4U4zCt/5eVsCbNjnYMz6TlTTMcAICIW0
 N55OuiVooofo8JymRSVz0lxbU1YupS+fqnl7/5aKUKEhLxtRE/lRhMBiKPAU9CATf
 rPQ50TdaGmzBqDS8N98YkvmtvejU5t93EvlqpTpvriQtge38FupJk4xPoxd6072qh
 AmfqoP7jeJ+CKJAsVA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([46.114.104.96]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXGr8-1tTfex0d7m-00UCW1; Sat, 12
 Oct 2024 01:45:13 +0200
Date: Sat, 12 Oct 2024 01:45:10 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v6 08/12] efi_loader: Disable ANSI output for tests
User-Agent: K-9 Mail for Android
In-Reply-To: <20241011225438.GA14210@bill-the-cat>
References: <20240926215950.1265143-1-sjg@chromium.org>
 <20240926215950.1265143-9-sjg@chromium.org>
 <08596845-c0b1-4557-9993-cde57420560d@gmx.de>
 <CAFLszTiGHhU3LgUu7bv-oYd3b-4Y5-OY=LZhTGcQ4vvpu80r2w@mail.gmail.com>
 <20241011225438.GA14210@bill-the-cat>
Message-ID: <64416580-3AEA-448F-B625-51195B08D1EC@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tBnYbO1UnQwWQOwblhPFt3LZNrCbWPRfOr7GIxv4LYNjAfZ5FRh
 5Fmfxvssa3gDR0I9j2j5TqHef9umGNx4yXnSlqF+ecIlH8IOgBJ+d4gIwGteihi+CDW+jP5
 lYVlHQqXtvLJ8HtK+8bkMPphnTi6/zVHcqM7xae2sz07kB1QVpRgis/pg8mtMWFzMUM+pUp
 HLLlprVIwE8PDzTXovfbw==
UI-OutboundReport: notjunk:1;M01:P0:GOvd7iyNri8=;cf697wAD+HLHTK6mDEq6cgAzMn/
 9S0uFHwkUkfVlQDrwTk155XspZPVQKlZj4bXMBTDGseR+v70szCrCJjn9GR9MDWDn/1IIy7D8
 lrs+CGXin4WOGaQpNtoa8Yd3pr2pSRrUmOb1s7Gk41R5W/ycM2b0p6DlRnyQCfZUXUC6Lp+GR
 4MyHxfCwSuvwAbtOfHdH51d8lMdgaF9wjBOXEuPEs9ei3kDr559134ahjsY4c+VqFNXbmXdln
 I+Kek2Gk/qshiTI5FUSQ0MG9LnT0QDUvMfDCVF6ReJGdjV2fSwwUnk3TgGUqpHTxlNxe3zKtG
 g58+jq0bCYSGBTqPWdl35nNC0m6E28923Js+S6BDlDd5Bib51TdK1Fit+9Agz/gdLqyZBruC+
 xGr7SoUxaQ73CzmIwyNHMlrhEKMSqN4R56BKWzBc7BQ4GmEUXKqfHnio+bGOiHbOOFsD9uTTx
 FIDKH54XhIbMcejoU2xw/LqEUZ9zhpFegVK3sY77KzafXVa2jUVLUgzXY0eoeodiLYOoggKtx
 HctyGDgwfkuTnBjPTiHAxuQjTB4nWzVnxdHkzwTtuP2l88//PeNAltG6S7qgMEGAmOnUFKMZF
 4H3/oDTCSy3sLGphKHbOjradU8oelRw6rxIE5axRvfg3BcBWIoPL8HJuclPZPUGWzH53C1jUp
 LcR8KGFo/j3Gv5Nr1EzO08JeGiswa1pC69D4ngkeRmf3f4k1u3sjQHqRPxKaUNZwL3CJ63SB4
 XeEEa2SFewYISd2wBrS4+l+POkVx3EHmhOcgLSqwfW1yqVvBvNnBqg0qJ2dd8e6xsRSyyI3BH
 gCuro+/U4PnxKcNCoHbUCIVQ==
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



Am 12=2E Oktober 2024 00:54:38 MESZ schrieb Tom Rini <trini@konsulko=2Ecom=
>:
>On Fri, Oct 11, 2024 at 04:18:07PM -0600, Simon Glass wrote:
>
>[snip]
>> No other subsystem generates ANSI characters when U-Boot starts=2E Why
>> are we creating this problem in the EFI implementation?
>>=20
>> So please, I very-much want to have a way to stop this output from
>> being generated, not to filter it afterwards=2E As above, we should
>> design U-Boot for easy testing, not treat it as a black box=2E Please d=
o
>> seriously consider this as I believe this is an important testing
>> principle being violated here=2E
>
>This is, I think, a good point=2E Outside of user-facing interactive
>code, we don't use ANSI sequences for printing information in
>U-Boot anywhere else=2E Why are we doing it in the EFI_LOADER code outsid=
e
>of personal preference? And, can we just not instead? It does confuse
>matters (as my example showed) when problems do arise=2E
>


Tests should be executable on any U-Boot instance=2E I see no virtue in a =
sandbox only hack=2E

Best regards

Heinrich
