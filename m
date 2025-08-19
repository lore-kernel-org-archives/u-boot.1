Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09348CA0EE6
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 11:02:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 640BD80FA1;
	Tue, 19 Aug 2025 13:02:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="btwzKdeu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 908F582E05; Tue, 19 Aug 2025 13:02:48 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E13F802C1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 13:02:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1755601362; x=1756206162; i=xypron.glpk@gmx.de;
 bh=yxBM7vcxoA9mNDCYdWcM3Kd3N3PH8MH1oCHJa4Oh5jM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=btwzKdeulBhFUy0o2oTfTUAxl1p22LnfJQ6wq5th/eijuwL1D37vbgBoidWT1JUv
 La1SMTBmJg5SeU2RWegOHXhWa6Z5UULHFr35LW+cwXzYFl34yOpobRzF/HUmlMYXY
 WDuP1IEZDSNk3P4KPysKltOs1L7doBZYfAIFxIwk2VWie9dcuCj58vNOVUTXdDlCj
 F4ZuHSiSBc3ht1mvpnxo/gBqeJaoFstpkoTDzO9XQw+7HmMFrXHC9VVPdyL/IPT/Q
 jGKcauwrxXWJ22kEf7SoTvnSeI2CXe4D3vEY7iEInB/h7eeGBFLCR8xH+GzoFJXTM
 KYbAzZdTKIbkxVxqOA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.116] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRTN9-1v9PjL1Wir-00OcDR; Tue, 19
 Aug 2025 13:02:42 +0200
Message-ID: <f80c123f-edf2-4fde-b6b6-93e9c035a15a@gmx.de>
Date: Tue, 19 Aug 2025 13:02:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] common/spl: use memmove() in load_simple_fit()
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: Tom Rini <trini@konsulko.com>, Sam Edwards <cfsworks@gmail.com>,
 Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de
References: <20250819105554.3067982-1-ravi@prevas.dk>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250819105554.3067982-1-ravi@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Kvw7r/wdq8aBwOvL0o5+h93qGQoVTRVTz9COx0VXLe8vLVmH/xA
 1finZ00eerHNaI3AR0GIettL8nW/Zry7t0FV5R1dIwzj902txJS9GMs3oZ7/1Q9rQpjjNCE
 gO21NgIPefzAOukBSvCCDY6ud8mgeyLb5iADKjPCrIuAzkLjunu1nmnrMVHSDZrrvqiAtE9
 aq4GhOEbQ+WYe8O99uDlA==
UI-OutboundReport: notjunk:1;M01:P0:RmLv5gLayqc=;iG74wvCzZ0RYCSYDV+mite7bAeZ
 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
 TixI68nRuaCvGltnVW9ifkn5/jatm/4/PdLGI
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

On 19.08.25 12:55, Rasmus Villemoes wrote:
> I had trouble booting some am335x boards (both
> beagleboneblack and a custom board). SPL would start just fine, and
> apparently load U-Boot proper, but it would hang when jumping to
> U-Boot.
>=20
> While debugging, I stumbled on this memcpy() which from code
> inspection very much looked to have overlapping src and dst, and
> indeed a simple printf revealed
>=20
>    calling memcpy(0x8087bf68, 0x8087bf80, 0xf7f8)
>=20
> Now, it will always be with src > dst, our memcpy()
> implementations "most likely" do forward-copying, and in the end it
> turned out that this wasn't the culprit after all [*].
>=20
> But to avoid me or others barking up the wrong tree in the future, and
> because this use of memcpy() is technically undefined, use memmove()
> instead.
>=20
> [*] That was 358d1cc232c ("spl: Align FDT load address"), which has
> since been fixed in master but not the v2025.07 I worked of by
> 52caad0d14a ("ARM: Align image end to 8 bytes to fit DT alignment").
>=20
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> ---
>   common/spl/spl_fit.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> index 25f3c822a49..746c3d2fa28 100644
> --- a/common/spl/spl_fit.c
> +++ b/common/spl/spl_fit.c
> @@ -353,7 +353,7 @@ static int load_simple_fit(struct spl_load_info *inf=
o, ulong fit_offset,
>   		}
>   		length =3D loadEnd - CONFIG_SYS_LOAD_ADDR;
>   	} else {
> -		memcpy(load_ptr, src, length);
> +		memmove(load_ptr, src, length);
>   	}
>  =20
>   	if (image_info) {


Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@gmx.de>
