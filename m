Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6412E7716A
	for <u-boot@archiver.kernel.org>; Sat, 14 Dec 2024 21:33:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CBEA80073;
	Sat, 14 Dec 2024 22:33:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="gxyg/2qi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F7E18007A; Sat, 14 Dec 2024 22:33:30 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A00658006D
 for <u-boot@lists.denx.de>; Sat, 14 Dec 2024 22:33:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1734212005; x=1734816805; i=xypron.glpk@gmx.de;
 bh=KrsAu4S+69Z+VUZx4ETMY7oI1OBdhWVCnY2r2uiKLcA=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=gxyg/2qitXTYzwfhzu9CF6R9yMqLLSvRjuzS5lfKLiSiCRDXTj4Sgk4436RDDGbV
 RiBPid8E5ku0dROuTb0Qg6G0teK2vHEExUGGQXjeaPqCxHVFz8FOWciLjA9F0OB7U
 pJltdls1J31DGYTMg5nDfy6ftqU5bdRRj/8Zk8ynbaz+VAETiYLLlELeQgz5z0TUX
 kVrNobCKiH9AyJbMOtYJ4kPwBjo178zvfBChkzwlmQbmzPJUSlGtrkABunHbBZRyo
 pczlPMfO+2UuSvUDEyFR4pfMIT6U12FpL/WafjUp1ciRO5764lGn5PuZ67HGYMwAD
 MoxcaBSauw3RfBnKUg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([46.114.106.118]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MAwbp-1tSr9R1jAH-001t2E; Sat, 14
 Dec 2024 22:33:24 +0100
Date: Sat, 14 Dec 2024 22:33:21 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Leonard Anderweit <l.anderweit@phytec.de>, u-boot@lists.denx.de
CC: ilias.apalodimas@linaro.org, trini@konsulko.com
Subject: Re: [PATCH] doc: cosmetic: fwu_updates: Fix formatting
User-Agent: Thunderbird for Android
In-Reply-To: <20241213102024.174888-1-l.anderweit@phytec.de>
References: <20241213102024.174888-1-l.anderweit@phytec.de>
Message-ID: <20B95A3D-F191-451E-9515-C7966F6C7D59@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QC8KXXcep26nWSasnHU+bzWiRAE1ylZ2uMwCXI/EFC3xj2nURa1
 gNkHEvGbtIcPMjL4vPZxylctA6wBtEEkXCXejOtY0329qXuxhVePZoQa31NSrCvP1iexfmQ
 MhetlEI4nHgXCzkBZGGevr5jhAgEU+wXoosFHl4GQYaHZi13IEMTPZwaC6wFFwZn090vzww
 37L4EWnhtqa08X/hpgFcQ==
UI-OutboundReport: notjunk:1;M01:P0:2kbaGBLBBlo=;rENoyMvAioQoFs5o1gp5xPMzRL9
 HDhfl9kcau54xRoLQ+AXkaf2Ae9s80ACSwZ5VqzRRpt+ic0lQzjm8Cs3elI+99O6eCD9oKP3Z
 M/PXf9GO30qf9xdkM+r//JcV/irtseC0/FTFPIZEt8ocG2CDYcPjMHEKf3aTlkbHSCop7N2cA
 dYvb/gT1XTIQhQkH9lHrEvfXCvEDnj8T9Ep8TjFRvYfc29+KUaFT5ef6fNuFk+D1q4UQaFIgS
 J4NohRMv1gISxEcq3ttNKYBwxesD3GGVD6RknK5Qn0tw9C2Bh+6CMADJFpWBQILTvf/zBoh08
 mjWLbih4pPZVNyL/fiGEvFDMVct0lfBbTjldbVaApl4tZp94d1aWDo9wSCKIc4+H4QTD8Vkhv
 qkqWB0NCXV2B30/UmIX5Nt6lXNGK3XeXTTsBr3jCQam3OnJ9vvXMkBm/XIcwu0OXZXpPADOym
 F3NBi1scclWze994rtjPlQM5P0SBJ8IiUmbPT25JZm7EUAZbhimDCdT2cJFOfonhK13Te0VuW
 kG5bs6V9IG9ngr1yIL9B7YobHeUZGeFWfCvXt+O2g7mnI0Y9GDbNnwFrWPDtj6/jRnLKbQyhS
 ZmNZeN1a9+zY8W872w1K0sUU1r3kGZIZzVXstPqmlXRCvRF+fp6sdmHBrcr8ER/E+YzpBANS9
 IXinCzfaVckrbuUDKv26ftWzhsvPLugveAzkx32wSRcGE5PdUvLptbKowheQkhXFIQH07qqgU
 cOtHd0W7LO3nzuVnZYU0v9t3YvvMFraWNSlCH9GF9PJgCDWaLNctoDiInFgh0nsg3g4Pb/D0d
 6iDZ3OXgIJXYRDS+BaMItM8JEkDCGnDru05dyEuwwabl+to91rGduwPqYCZAe+nkv7+6weja8
 mbwTN6p68Fo71HscN2U/QUTps/eddEicOwJprOnqP9JPg7vCW9Wm4xSFClOnbu+a50emKQuTq
 Rvcpv80f1/WaizD9Y+PYvpB9W/pT55H5yQGjl8FyPxhJ6OiErUljst5Y7I7ePrxe2gBgRX1H4
 vHKYEHG2ozlFalwEpV/8iNsh1ve2AVrd/TkMYjZoT2dnz1F4i1f/uQ0JO5Ey/WF+fVLEel//E
 ov8wPutr9zZXeNuzb8HBj6f9O8GySQ
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

Am 13=2E Dezember 2024 11:20:24 MEZ schrieb Leonard Anderweit <l=2Eanderwei=
t@phytec=2Ede>:
>Remove one of the double colon so =2E=2Ecode-block is used for formatting=
=2E
>
>Signed-off-by: Leonard Anderweit <l=2Eanderweit@phytec=2Ede>

Reviewed-by: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>

>---
> doc/develop/uefi/fwu_updates=2Erst | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/doc/develop/uefi/fwu_updates=2Erst b/doc/develop/uefi/fwu_up=
dates=2Erst
>index 51e8a28efe15=2E=2E847135814590 100644
>--- a/doc/develop/uefi/fwu_updates=2Erst
>+++ b/doc/develop/uefi/fwu_updates=2Erst
>@@ -170,7 +170,7 @@ build the tool, enable::
>=20
>     CONFIG_TOOLS_MKEFICAPSULE=3Dy
>=20
>-Run the following commands to generate the accept/revert capsules::
>+Run the following commands to generate the accept/revert capsules:
>=20
> =2E=2E code-block:: bash
>=20
>@@ -180,7 +180,7 @@ Run the following commands to generate the accept/rev=
ert capsules::
>       <capsule_file_name>
>=20
> Some examples of using the mkeficapsule tool for generation of the
>-empty capsule would be::
>+empty capsule would be:
>=20
> =2E=2E code-block:: bash
>=20

