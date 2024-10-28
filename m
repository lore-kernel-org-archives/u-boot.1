Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A2BD339AE
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 18:08:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AA4A85B66;
	Mon, 28 Oct 2024 19:08:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ThCq3N2b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F66E80245; Mon, 28 Oct 2024 19:08:17 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD144885F5
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 19:08:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730138893; x=1730743693; i=xypron.glpk@gmx.de;
 bh=9CGm9Zx6Vt1MSpfuBbxUFMD9BNORx44QrIgBBIjiREQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=ThCq3N2barR8cJTfeZxZYcWhXLlhvIs5ygUu9nl8STxyJj4ZEBZycZPvHp+lO0IK
 F6x7N7rt5XpEBO4h2/AaOMl0xDPElVDA1SqrOcILlOregXzVa2fofoVfE7z5HjqzX
 LMIs8hlWyMhOjd9+ATUz8GWBaFTEwgHdK94Spepw0G3XHDZgWCpLy2mmyCHSHyObR
 oaukiM6aRxi8t8wnXFXhuoR9eaECTzcBDfe0ya1OTT5HTf/rvduK9ubxKxz6Zfkge
 fp49eZo1pNhSN/PAf1MI9oflTTJZOAaSFTkdWIQHAL7/lpwNHr4aX63Neu/rZBMh3
 nei+h8IKBO1qv6gr6g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.43.6.224] ([87.215.50.114]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MqaxO-1tixn31UHY-00jdXu; Mon, 28
 Oct 2024 19:08:13 +0100
Message-ID: <620f87f9-5d6d-4f22-9472-217c4b53623f@gmx.de>
Date: Mon, 28 Oct 2024 19:08:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/8] test: boot: Update bootflow_iter() for console
 checking
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20241022120032.196311-1-sjg@chromium.org>
 <20241022120032.196311-2-sjg@chromium.org>
 <f5d2100a-bd30-40b1-a305-44475070c5ce@gmx.de>
 <CAFLszThm6d7WDksCBAzWT=FGq6LZLXDuAnYK166SRGAJPCGU5A@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAFLszThm6d7WDksCBAzWT=FGq6LZLXDuAnYK166SRGAJPCGU5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HL+rGtqHd2orrGEvjvUvFSyfuLyaqXYJeh3xNXL6+n+/lRjSPQl
 A9ZoVc86rqlV4hYIBVQBjiGYnuC43cQQ6w+4fhCglneI2WKshzeuGWsYDaBm1dR5/849hn6
 iBKTHwNE6WYPNxHacy9XPzbAZ+EAT+YVEmr7HFKc5ZrdwmdIUgC1JoZK9Ksw22A4GiJ4l2f
 oQOcaO/9CwgM5xo9zQ5DQ==
UI-OutboundReport: notjunk:1;M01:P0:c8FGqVRscBQ=;bavCkA2obWBmviXL50WLWKzIOm9
 n7o+77VdBNOHPmOpeeHLDxJjb6XlxDJVvxW7LnMcpbS2pMnZTmPBDgAJlntrD4PhisBh4I3SC
 k24jmMIWpHiAKBLT1H4I7anE5dFij6h9TMzl8iMcygCFU4vOIgyDBHpn6OwQyE3B/s40BbeWR
 Wj54Q8zDoRov/UsCKiJAuOITWLW3Dpcbi0leDgKwe98lyqMAIvqXLJkfOStZ+d4cDTuFaOSS5
 /zESgQdGbsrn8IhFXxCRvS3He1sOlxZfpShi6dsZqlUbz/1+JnCFodCBR+zu+xT6sD5uA5jyu
 JXJgG6vgYj53rzS6lkG3QkqF0mcxjZXlvLyqcQ5UG4dVDiP8dd/1KdAhuA3g5D7TnC4qb4LsG
 dVJkFSOZiCpCQ46/nKFiDKRFpMYoBkwv+h1ElsUKrvQYK1FIlM5hU5hHO+DcJ47OhDnn9O3WY
 oewhTxw8J3JK100toIWUA3ptpxcJXV6aKeWM7kdkAQGXotUb3I8fSZ9Xn3fM5zRZw9wdxW82L
 vV1Jz/U4kx/suJZixplyA1SX9l1w+ctsBVP5MtBsjTx7x39Dvg8JnBVEx8h5Wyc84qdPbqsES
 uGiugrYaZmRn68gQosxMYPR6VRB2gF2xAXlPwqQgrqypUStAMDNCHQXsR2fiAcN4gaoDnKFVK
 +YSfLvtnQmG9q8PICNuO/4TkscnM3Jlmm34A8F+x/zmUllUCpHx42wjW3oihFM2Vvy1C01PC7
 k2Mb/ospv3KS2fAxixvTvj8/BmzP61sEBPN0G0Fa+mpDLgZrD37KEEm1GhAMukDEZvVPeD4ks
 3BoNxiwRS+C6F/dZB76WpCHTunpzodcbbV6ltiC0oh+1g=
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

On 10/28/24 18:02, Simon Glass wrote:
> Hi Heinrich,
>
> On Mon, 28 Oct 2024 at 07:07, Heinrich Schuchardt <xypron.glpk@gmx.de
> <mailto:xypron.glpk@gmx.de>> wrote:
>  >
>  > On 10/22/24 14:00, Simon Glass wrote:
>  > > This test checks console output so should have the UTF_CONSOLE
> flag. Add
>  > > it.
>  > >
>  > > Signed-off-by: Simon Glass <sjg@chromium.org <mailto:sjg@chromium.o=
rg>>
>  > > ---
>  > >
>  > > (no changes since v1)
>  > >
>  > >=C2=A0 =C2=A0test/boot/bootflow.c | 2 +-
>  > >=C2=A0 =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>  > >
>  > > diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
>  > > index 154dea70a59..cc894e804a4 100644
>  > > --- a/test/boot/bootflow.c
>  > > +++ b/test/boot/bootflow.c
>  > > @@ -370,7 +370,7 @@ static int bootflow_iter(struct unit_test_state
> *uts)
>  > >
>  > >=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>  > >=C2=A0 =C2=A0}
>  > > -BOOTSTD_TEST(bootflow_iter, UTF_DM | UTF_SCAN_FDT);
>  > > +BOOTSTD_TEST(bootflow_iter, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);
>  >
>  > The test invokes ut_assert_console_end(). But where does it check
>  > console output?
>
> That is it. It is making sure that there is no console output. But the
> flag is needed in order to do any console checking.
>
> Regards,
> Simon

Acked-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
