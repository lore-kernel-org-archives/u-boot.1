Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D28606A326
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 20:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WbdTkVc+;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=PDZCFa+3
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 19565403BD;
	Mon,  2 Nov 2026 20:44:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2tZgOgXrVr1z; Mon,  2 Nov 2026 20:44:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5735D403AE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793652263;
	b=cXdE62xlnMUTnXUYTRBUrrxJt0eRdvQVWJz62ySu810tThUnWHcgId3Yi9CAfxPCX/7W
	 B+y2+FkHFwRTS109/7ecFv13dp8iNTdg3PknTqICAxDz7dcDul/aJ1U2H2gh8Oc9jsVxa
	 kDGT1KQYf1CKpj11ObIwKetYFYlrGptQCl2dZRUF+nDlny+1N3TwM8FjZ9VhMBbGs10Ey
	 QTVJWPw03YJ8jPVEPGI9YeiyjBK4RmF1ClOG7TzSSHRC5o28lF628zIKhCG4g/X18mNWu
	 cGw1HMo5Su8Dm7CxQZKZf1eQb06FUw3lTj7uy4srfrucMK08RLt7bpqoDuo+hZ6Qzyg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793652263;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:References:
	 In-Reply-To:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=hF5z0X4ZHt1SwoVQPfY/bd0MqvgTz3SKKQEsdqUrK2g=;
	b=FgbO0ekg3Edeh3oK7+MXlJeHPnOSlHWXd3suJ1Ae2DCiK2nxAFOyo/mrmf1RrsBjVXtc
	 uE9iA4MNP4UXVhvF1WPBr0ZjJO0tmvqsXNFFMZAcCjyQOrp6Xn2FXuH0sID8QPredlT4D
	 jgv+QCGSCGXkYNA2cgxZcKp0X1VDnouQ/JGklecsZ6bFT5NDhecX+6Fmb+QxIn+h+7vgE
	 WuYXwDzxF0i98SdqBvWhyNE67YyKb1gFsfg3xfTnBmjfVEW5ItNTmIjFsMKuE9LUfKbpc
	 Ys6V3KHl2Vm+KyFftirS+ryeXyZFGr7R5TERNLyivYQXLcukgB61pLZCtPP3U6yXtlA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793652263;
	bh=hF5z0X4ZHt1SwoVQPfY/bd0MqvgTz3SKKQEsdqUrK2g=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WbdTkVc+rOUTimng42rEHfxN/3b79FV1jHks0KXkzKgFnZPWvZffNxycN85bMstIV
	 3Uvsl2uzyRs8a76Hdy+RNBXjLMfrgK1oPaqmDnBupJmiBAiKRjdrs6OCS+R57lJqrO
	 s9CA6Wrw0ye4/GDYRZv1WEMqpQXxUYiEU/J0yizzPZV1ksqBAGKAPC5Xv4DWsEhkWi
	 gnI1cQ4VpxWHvVUxGet0vKNWjhfRNeqW+DKCPd4aAwXdqoScUAICE8IRrvThTN1nsn
	 76o3///sumxz8QPTJDXykZ7CY93sh8gvTX6u4mxHKVjhsIPl0vyM+cJ9R5+n2eKxX2
	 W7vbW/EO4YTtA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5735D403AE;
	Mon,  2 Nov 2026 20:44:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 79CE9356
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 20:44:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6B008605F9
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 20:44:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IFCMh1f7rhfi for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 20:44:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F1690605E6
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793652260;
 b=lu4DvB57Myn6ouTVv5yRd1yfnzxhMSGU1n66BjDAMRXQ4/k77EYmtDP5Y2LjLMo2HZBO
 djgBNZxCxHtCLSyPPFNzk301hG9QwdG8izo432ZwG95TZYR1fKjt75KiTaM3cf8a5aj30
 6qK7iDE/SNjwAMJVJ+5YhL9zPbz0e9VwaeOZY+5Z8fmzpyfmOSe9B7xxYybnFJw45h07a
 9a2ZEESLsqRhX7ehNQuFHj1hQB491WECZiCwJocaB7fm8k0iKpYQEo7J0tA6Nds5iwf61
 bFuNswAsuq0Fis71ZTTRk4IH9DOEgCtHJYFCRbvyov5QMHTpBzvTXi2oCmCKMzRW9yQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793652260;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:
 References:In-Reply-To;
 bh=hF5z0X4ZHt1SwoVQPfY/bd0MqvgTz3SKKQEsdqUrK2g=;
 b=pWrieMGRIqyTwkU1QrvuodyQQzIBY/u9fRnoNtyFJn2o6AE/pr25u0Pf5oEEAQxKmJop
 wqfpW0Q4SUxN1BuI7mBsO1WrmeWfpWtE8cQoWOZ0kRkNYk+SQxoHOJN8aNh0mO0gCIpc1
 jZ07L0M0gZRkazfoYK4kvwGgcF8jUoV6hFKrkmClr3F7L8eqzVBUBPQRsb3bup5q5Hcz+
 L6AHHU0k4cJMzer8v6fmf+g9UFBEHBWWG+dAhEsaGCv7QFt/PQcJd9QuGKT0o2GoYmAta
 xLY8kM3ZNKqe08SwrvXWh7okMOkuuHj3tWQC2y818SVeVV6r5RsVEdHRAozdzzChqWw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=PDZCFa+3; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=PDZCFa+3
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F1690605E6
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 20:44:19 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4afe2d546f9so17582975e9.3
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 12:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793652257; x=1794257057;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hF5z0X4ZHt1SwoVQPfY/bd0MqvgTz3SKKQEsdqUrK2g=;
 b=PDZCFa+3ZEd/0W1X3Mm7V+xy/bVwZPswzZ3/hvfXx6o8kvHUYv1EOdycCJ6dbUEC6v
 hiMzI18aJlpCiBNutgQ7q2JWZDSNTHAKlS2TNRQiTM5sXoNwlffcRkoFivq0+V0tyUyo
 OvbMSwEri1rPPm+b8whV6cWzajRej8meixl678lrM14ofs8+e+ONZzXwNmRFDPZHj+Qp
 KeB7Q/ZS2uMOcBDvC3sIJJ25zNdfpkUpI9vlSdBhW/g3IKH0BFe2rCugfWa+1vAnQucv
 aZDZqXEDXAzVHkIoY7M7pcclH5ZM7TquR3TWaamf/dkwaHLgeR73NAgA+T5DkrmPMpVv
 MsuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793652257; x=1794257057;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=hF5z0X4ZHt1SwoVQPfY/bd0MqvgTz3SKKQEsdqUrK2g=;
 b=T4SVDFJRpI47N7RP/ABjdKiNQakZ8lhc+uSiOVKZ3hANIGSP8f8YYg5jX8l4e67hcT
 y7dq3l5vucee872mGQZi8k0eeTsqZz8r08x0VOUAOhGIkhRgXe+QFytL5diSJ6mHMXih
 IEJ7+7SinocbMVp5VA7PRdUqopbiJVG4K+ukpe4wI5Ze/tMziJegtTTAaadgcnPHTdla
 qcSIKm3leI8zLRrJGb32Qw65M1n82tamYWh3+ZKQPXDLlZT4OhI5Uu3bBAeJhVt9AGCw
 7BDu2fQ9jbfKTQ7jKuiNLXKnkckxdCXVZ31pFHMeIfu+QF/eyTMjuBEqO1ERo3x+OMXv
 TKlg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwpaGHjxkJJ4vVFeiby+buV1VNT4gPFqF9SYYXEZgOVRfUaKtpxhF2e5sJcwa4Uf9a13mlwGFM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIWLZVVi4nE64oM/w1ILE1XYb57iLFQrDD0sZTXaledGn6aev9E
 1Vm5C0CM4IApd5DR6PtfeM5tnPxsouVgZMPbw4mPSGZrkHoz67gbr5IjpVxoNZNbDVk=
X-Gm-Gg: AYBFou2qUOMdLWnF8LSU6k66Awx0+vZ9mD4NTtEA9JWeLjw3OCrrwaVz2xRPJF/NbMt
 ZuLGTbcJkSxA3FNMCOuzy8j6J4GOwaDA6IYs/co3N6blv/DXOIPyC8xeFAp3zxDo1RLji0SOO9V
 8BLdl2MlkDLSpVp02OTOn9deeJtz0kdY3DhBRHdtnYVqplI7jq1qcXkFqBXCwD9XOPVU1t9qqlC
 LaFs9l4386pdVmm/jrKNyQxs1mGjsTrc1Ow69YJ3D0epaaqNaSnWbX/xBQC0Geohf0Uwnt715ye
 319hphFrfUlNj4Z20wBEjPz1O/QP8woIfhBP6SSnz0nUBwo2dFyFqBmUxUVpXSR/95KknzDNAlb
 iX5TwgWX7PURpwjjC5FqIUlQZTbjNtcB0w0fWHzYkNJLAGsHN24u0I0hGJjGp6IZmDC6ebMXZfP
 iXBMUYkZXsAGz2KksTml1Icl9nWEMJ3Sgoc3jYkpGJVpbtWzpKk8evFD0z7brkFru4AfuSOVNUt
 YFbZ0R5yZxifJQBt2/qgPF/P8zBTkyrHYP5pY0xV5S+UL3jJPeFjD/Vkhl78cCOiGZY+ljdar9X
 PyNbWG2NWdTZjb9buos9wBvg
X-Received: by 2002:a05:600c:8b2c:b0:4a2:5267:3cd4 with SMTP id
 5b1f17b1804b1-4ac151a8c26mr267877055e9.3.1793652257254; 
 Mon, 02 Nov 2026 12:44:17 -0800 (PST)
Received: from localhost ([2001:4090:a244:81d0:bc85:7836:468a:a1a8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a82cebc1sm15636395e9.1.2026.11.02.12.44.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 12:44:16 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=bfa176e5cc8fd7093d521d1119d0f2c514b5fe7b72ee13c31eee920aef1a;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Mon, 02 Nov 2026 21:44:10 +0100
Message-Id: <DML0NOBKA8B3.3IU47FEXX64MO@baylibre.com>
Cc: "Simon Glass" <sjg@chromium.org>, <u-boot@lists.u-boot-project.org>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>, "Daniel Schultz"
 <d.schultz@phytec.de>, "Udit Kumar" <u-kumar1@ti.com>, "Richard Genoud"
 <richard.genoud@bootlin.com>, "Anshul Dalal" <anshuld@ti.com>, "Aristo
 Chen" <aristo.chen@canonical.com>, "Kory Maincent"
 <kory.maincent@bootlin.com>, "Paresh Bhagat" <p-bhagat@ti.com>, "Julien
 Panis" <jpanis@baylibre.com>
Subject: Re: [PATCH v3 2/6] dm: core: Add SPL_DM_EVENT
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Tom Rini" <trini@konsulko.com>, "Markus Schneider-Pargmann"
 <msp@baylibre.com>
X-Mailer: aerc 0.21.0-146-gb5c16ebe1835
References: <20261030-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v3-0-2a67384ed0ef@baylibre.com>
 <20261030-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v3-2-2a67384ed0ef@baylibre.com>
 <CAFLszTi54DouCiL-JPo_1NztwBbRNve-dyQjo-s1Od-kQCG71Q@mail.gmail.com>
 <DMKM8ZUYIQG2.J82LOEGKW71T@baylibre.com>
 <20261102171534.GD3309461@bill-the-cat>
In-Reply-To: <20261102171534.GD3309461@bill-the-cat>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--bfa176e5cc8fd7093d521d1119d0f2c514b5fe7b72ee13c31eee920aef1a
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon Nov 2, 2026 at 6:15 PM CET, Tom Rini wrote:
> On Mon, Nov 02, 2026 at 10:26:44AM +0100, Markus Schneider-Pargmann wrote=
:
>> Hi Simon,
>>=20
>> On Sat Oct 31, 2026 at 7:44 PM CET, Simon Glass wrote:
>> > Hi Markus,
>> >
>> > On 2026-10-30T12:27:40+11:00, Markus Schneider-Pargmann
>> > <msp@baylibre.com> wrote:
>> >> dm: core: Add SPL_DM_EVENT
>> >>
>> >> Add an option to allow DM_EVENT in SPL.
>> >
>> > Please can you say why this is needed, i.e. that the K3 SoCs want a
>> > spy on EVT_DM_POST_INIT_F in SPL, so they can unlock CTRL_MMR after
>> > TIFS is ready but before any device is probed. It is also worth a
>> > sentence that CONFIG_IS_ENABLED(DM_EVENT) is currently always false in
>> > SPL, so with this option dm_init_and_scan() and device_notify() start
>> > sending events there too.
>> >
>> >> diff --git a/drivers/core/Kconfig b/drivers/core/Kconfig
>> >> @@ -117,6 +117,16 @@ config DM_EVENT
>> >> +config SPL_DM_EVENT
>> >> +	bool
>> >> +	depends on SPL_DM
>> >> +	select SPL_EVENT
>> >
>> > SPL_EVENT is inside 'if EVENT' in common/Kconfig, so it depends on
>> > EVENT. That is fine on K3, since ARCH_K3 selects both, but another
>> > board selecting SPL_DM_EVENT without EVENT would get an
>> > unmet-dependency warning. DM_EVENT selects EVENT, so I suggest adding
>> > 'select EVENT' here too.
>>=20
>> Thanks for your review, good points, I will fix both.
>
> I didn't chime in, in time I guess. Being able to have SPL_X and not X
> enabled is generally speaking allowed and a feature. So it's probable
> that some symbol needs to be moved and/or some Makefiles updated, but
> SPL_EVENT / SPL_DM_EVENT select'ing EVENT is wrong.

Thank you, I think we can split these up, I will create a patch for the
next version.

Best
Markus

--bfa176e5cc8fd7093d521d1119d0f2c514b5fe7b72ee13c31eee920aef1a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCauj2GhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlPr
0wEAtQ7LTtakEXFtahfCDokHNSLeeSBwTavqG8vSdBzSEQkBAKksOBuRAAeiiIG8
zhETCJ9j9l04wIPY34UxghfggHkF
=kYc+
-----END PGP SIGNATURE-----

--bfa176e5cc8fd7093d521d1119d0f2c514b5fe7b72ee13c31eee920aef1a--
