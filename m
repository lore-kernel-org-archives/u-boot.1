Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 542F1CA5FDD
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 15:20:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 22D3960683;
	Sat,  3 Oct 2026 15:20:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0sWiBcQEQTSU; Sat,  3 Oct 2026 15:20:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org DDCB46064D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791040824;
	b=IYl/XjIMwvMMXzHQpRaUxiyjxh+2KyCbi362MDh741KJsRB+n22hu5OSiHlKWWwJjg9d
	 PX3nom+qIVlIwuH0QBTk/ZaeuWbcyXhuEUDSnfLP5JnUJoSFClYhSzkR/w8zgbG7W7qlC
	 iMNniKJMXBnseINgWNV1ciSmRSvQjJp3FvXV+e7JPjUrEB25whFoYi0T4VhXISSNQlQFz
	 pR7LZ2RVPLHEJdANEj+3IssqwHPu2WQ8iPUt/Xj8WU7LWeGwVJogAzNHlXRykI28dQzM4
	 D5bf7Tptljk29wU7nR0tbUehkDZ/o58YD20bTcfElkSMAkmTldCKSLAg3LqfoIEHFpQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791040824;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5S16FbZVhcZcEJW2mTEHIFmMCshne8c87yNMQOxhsPA=;
	b=oLaMPbkxyX1tFV9ylBkwGx/iYUKzty1JP2tSzARXiy8AjDtM7fDWnPHn+UTi0klE/gNy
	 P9SZVRXvozTZfRwzMClmrBTh7zYnDfLYLHVbvCaBQ2zoF6/AQNZkOF8G0IA7yJJx+S8XJ
	 KEMhoZextuYru3eCAGDNEie9XsW34RmucnbDCSxhy2fEzJhD/PCWkmsRjz5dQcxJCSuLQ
	 KIHUGXy7LCUgzSvH7JU63bPHfheRAT2vHQssC6e8unjsuKtc/9VESMAQHzqKnvDE81r+P
	 wBpaonLIQNmYiMw6rTqFMPEeDw2kuNe1Ywi1sT6VLepI1Xsi1/DYpNg3kSR7sUVB8nA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791040824;
	bh=5S16FbZVhcZcEJW2mTEHIFmMCshne8c87yNMQOxhsPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=w72aKzT3RO8jNsrBKHBEh67yMXIxPyytI0JynQitZDPhLYc2WutOzchSMiZaS06oU
	 i7CbeH7/AEteSOAR9EIro6qbxtYgDgFIdlrA3yunOvaNIzOyqyyZq50nLWkfzGMteG
	 Gowg5bMnGD4BamfEUzbaAMjP9wLkw/bJeDbdTJ9t+A66tcuyFWa4SNMqZoY2E31ulk
	 LP+M+NflrD2CCLEAqso3gydy9xWiDk5WjIS/FQxRflSGbRUPB0nwz/c0Edht5CZnHr
	 7PEWcxdniu4Z/uiJHNk193zHpIGJ7OY+9KBIE6k/lHhy6wZAeyy33ZyXTdJjNvzb6N
	 Jy6eqsCRVspNA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DDCB46064D;
	Sat,  3 Oct 2026 15:20:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4DEF7282
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 14:32:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4013780D6A
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 14:32:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IhZEnwz4od8N for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 14:32:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2FCE680C38
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791037943;
 b=C3tH4VLXu+6qhd6pTvIVb21tgfkWIqkMcI0fH5DDSZQHevsBxe07ZgdejtavlslkeAZT
 DSGboS7S4ZdmwY1Ll9gVgqmQ6jT14sTAy4MX1PRoDKYpWKQTJVPJ9RKwmzQl2UzwTPILF
 zr4YIjSWbuQPda+au3hr8I5An+qe36Il941PDBg75GXRG6X9lWa97MS1YKPrSXcUkW5lN
 Aqca67VDo3JbwYCMmfmcTbSEtRTrriQhWombfLeW02oO8bzHmTeTwcdtGmD2IwQ+HkZKu
 HxJ5Nis4jKNppGRIMN0cO+U1uY6Om0pULG0WIakMBCf6GV22qzTMM0i4DHPao7oDp0g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791037943;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=5S16FbZVhcZcEJW2mTEHIFmMCshne8c87yNMQOxhsPA=;
 b=bcsSK8prKsSKQnJVI9eRyF6HZYq3soE2xR6QM0HKKdTm7Er57AMklxlgf9RBn69LKzaq
 rHJ70kQPdQWh/lSAHjBtRdwAek6DOumxX9ezzR+l8D28i5CateL53lGdkoltkgdi5eQou
 D/ogsmC3So3lEjMdhTNW05KYXVoqD82oavz5Rh6llRx+TbRLDjiLrJcA2GBojr6bNDZC8
 MlXogz+YI43SKH2xK0rLAmQrSoWGFVA4h/qJm8GRB9iVUNBkyhC58zXsiF3HNqmLOgRct
 hpRGdo8IaTb/YUbk0GxngasR45rlea2oKZIWWYcPoRRyHNRRo7YgF8Oqje0ea8xO2zg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=iyzzNVNi; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::b"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::b;
 helo=mail-oi2-x0b.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=iyzzNVNi
Received: from mail-oi2-x0b.google.com (mail-oi2-x0b.google.com
 [IPv6:2607:f8b0:4864:32::b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2FCE680C38
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 14:32:22 +0000 (UTC)
Received: by mail-oi2-x0b.google.com with SMTP id
 5614622812f47-4c112aaaee4so198663b6e.0
 for <u-boot@lists.u-boot-project.org>; Sat, 03 Oct 2026 07:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791037941; x=1791642741;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5S16FbZVhcZcEJW2mTEHIFmMCshne8c87yNMQOxhsPA=;
 b=iyzzNVNiVQrwe1aSQcEa6R5BWbbAhIHAYWDPIXPy2ZBIjXgHIQgupS5+pUley5XfVd
 BBGGLqzu3g+k/GslQ1RUCFmrcC+/SRAndSojl/3kJCaHx8cIMK/rsQtpFFv1za0UbIWP
 mIvnwY/Nm10iC9WjDOwOBdm40JWbZoFZ1gnQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791037941; x=1791642741;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5S16FbZVhcZcEJW2mTEHIFmMCshne8c87yNMQOxhsPA=;
 b=2Qq/Pnf+LljO/ZR6L6hOWTdO7Sn8qCP6h++BDQ7K+5rbKVjiYaUM5SY3xLZZVkNHk+
 WePfxBHVe7mwZWlnIFPP34C9+4U2NoYQw0Y4fnsFkmfbNbxuX4MsMLMNKYoEyPacb+ji
 5D+8YEEHjidzl1CCYWysx4M9ag+ubBtcL5BVggYxUlNaevmAe52Ok8TQvde9h2OMkSuq
 m3kfD3Q53d92b0hr/piHLTrKlXte4Pt36QdMB80EbWVBVKeSWkjwmjjXebb9ewfl1n/N
 pmWuHOc+8HjeMFH5VKtzavWd4EWFQVtlhxlU29QifJooZFfiWo1DUq+2K1zsH4jxiBoB
 kOfQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByWT7DxiI3T8Q/t2g3PANRRbJw6Lnx8ggqaOhXRPnmDfzmtep0wTkX1AdJPX+RoTAmr/aLDt1c=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mshhHJX2D3bcIjq/ruX2i/jVyUi+20PmJqI35adAM6XP6bB3Vs
 wyPyvjHv0w84lLMVn57qioUi8a9U4hzkFz7jUiBfeBf7c4rxCjUAuD3TDtWhH0MQEqE=
X-Gm-Gg: AYBFou1gMzNRNPuNLJ6yKnBs6+v2uepzVxxi9irc4monkgzg0WOZ4tiqgI4totg22B8
 NT7Ni2TbfFWn19V17bUde+hLxt128nsAkOnQIGJULiMPedz3Zs7SWu7OzVz6tXMnZcfYesKXs44
 yiwnYPM1cRQ8Bjkib+HphZY1N+QHkFtj2RhZ+gxSOpf5LIaLHivM+i6a/OJ1gl+RsdLQpybhOoE
 Z2LaMotuuqzaZ9YKG8GKhf02v75QrAos/vL9n6mL6CgKhykmH3Ig+/uzcRwSowbYmDwPnJawWO1
 gQAvouR1MINSko+N8ksUAwY1dRwGExJ26Z5cXuzVYVSCfIuPCm8HMFPcJ0fhEednWRX0o4ZoztF
 4L8bInIrQVuAhBDheCDkwPV9tkReDMJomYuIZk+YgWXJiazhcPJ4DmJDp+WeDn4W6PVOZTzXjPB
 z6TclarzrW8IFmlg+yPPkeQ40soIF2oVCRh/Ma1owvMePIcmW+ct5zafGnIEmyRPz1Cgu/ftZ6t
 VT/tOgcsaShUIDf1ZmQhf61aw66Tf5UZw9TluT7T+llucQaPHe7rwIRo6QgXRm1YvhP7ytnOhco
 6J8bAj1lB8TOrFu/KV0=
X-Received: by 2002:a05:6808:158a:b0:4ea:686e:fe86 with SMTP id
 5614622812f47-4f52b0a156dmr4779523b6e.63.1791037941557; 
 Sat, 03 Oct 2026 07:32:21 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4f5252e3207sm4848535b6e.16.2026.10.03.07.32.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 07:32:20 -0700 (PDT)
Date: Sat, 3 Oct 2026 08:32:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Andrew Davis <afd@ti.com>,
 Alexey Charkov <alchark@flipper.net>,
 U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ronald Wahl <ronald.wahl@legrand.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Johan Jonker <jbx6244@gmail.com>, Daniel Golle <daniel@makrotopia.org>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tony Dinh <mibodhi@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Quentin Schulz <u-boot@0leil.net>,
 =?iso-8859-1?Q?Jo=E3o?= Marcos Costa <joaomarcos.costa@bootlin.com>
Subject: Re: [PATCH v2 09/10] rockchip: binman: Add support for Falcon mode
 FIT images with TF-A+Linux
Message-ID: <20261003143217.GE2658242@bill-the-cat>
References: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
 <20260731-atf-falcon-v2-9-acb97c172993@flipper.net>
 <75fbfc49-a610-414c-99f3-9b86c1b415d7@cherry.de>
 <da1e4a57-a511-4e6e-9f53-8e781b9a334b@ti.com>
 <d5fce5c1-0661-4449-aefb-dc0eb960a71b@cherry.de>
 <CAFLszTh2QLa8BpTy6QAkC3cux=RS8GFNA5BKOg_AhPhiqsjE+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ViW3j4IW/LrbG7Gz"
Content-Disposition: inline
In-Reply-To: <CAFLszTh2QLa8BpTy6QAkC3cux=RS8GFNA5BKOg_AhPhiqsjE+A@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Sat, 03 Oct 2026 15:20:19 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org


--ViW3j4IW/LrbG7Gz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 03, 2026 at 02:25:14PM +0100, Simon Glass wrote:
> Hi,
>=20
> On Tue, Sep 29, 2026, 11:18 Quentin Schulz <quentin.schulz@cherry.de> wro=
te:
> >
> > Hi Andrew,
> >
> > On 9/28/26 6:33 PM, Andrew Davis wrote:
> > > On 9/28/26 10:14 AM, Quentin Schulz wrote:
> > >> Hi Alexey,
> > >>
> > >> On 7/31/26 7:10 PM, Alexey Charkov wrote:
> > [...]
> > >> Honestly, all those concerns could be alleviated if we had binman as
> > >> an external (to U-Boot) tool, then I wouldn't need to care about what
> > >> you do with it. There was some discussions about which tools to move
> > >> out of U-Boot's scope and we started with patman but binman was also
> > >> on the table. Neha Malcom Francis suggested it could be useful to
> > >> other projects, c.f. https://lore.kernel.org/u-boot/
> > >> f697d6c6-3cf9-41eb-a833-880a892643c1@ti.com/
> > >>
> > >
> > > Just to provide some more info on the need for binman as an external
> > > tool. We (TI)
> > > had all the boot image packaging, signing, blob fetching, etc. as an
> > > external tool
> > > originally[0]. We moved all this into binman with the hope that somed=
ay
> > > it could be
> > > factored out into a standalone tool for use by other projects. Like w=
as
> > > done with
> > > the tools in `u-boot-tools` package. And like that project this doesn=
't
> > > require the
> > > source itself to live externally to the U-Boot repo either, just that
> > > binman can be
> > > used outside of a U-Boot context (not so strongly coupled to the U-Bo=
ot
> > > build and DTS
> > > files).
> > >
> > > One such use would be in Zephyr where we are trying to build standalo=
ne
> > > bootable
> > > images. Without pulling all of U-Boot in as a Zephyr module, this is
> > > currently
> > > requiring us to duplicate all this binman logic/scripting into the
> > > Zephyr repo[1].
> > >
> > > Not sure what the next steps would be in making this happen, but it
> > > would have ours
> > > (and probably many others) full support.
> > >
> >
> > I would recommend to either answer to
> > https://lore.kernel.org/u-boot/CAFLszTjeQ2mvnkPeVPsWwK7ay4Ac-+h=3D3pApf=
f6CUxaaHq45JA@mail.gmail.com/
> > or start a new thread specifically targeting binman. While we could
> > easily remove patman from U-Boot source code as there are other tools
> > that can replace most of what it does (e.g. b4) and have it live in
> > another location, binman is a required part of the build for many
> > architectures in U-Boot so it needs a bit more thinking and preparing.
> > Being able to keep it in U-Boot sources would make this easier (and
> > could be a transition phase if in the future we want to have it a
> > separate project for some reason).
> >
> > One issue I see is that we technically have only one maintainer for
> > binman at the moment, with Simon and the situation is (was?) complicated
> > at the moment. I'm not trying to restart a discussion on that topic, I
> > just want to highlight the reality of it. Alper hasn't been seen active
> > for years as far as I could tell.
> >
> > So I think we need some sort of list of issues you've identified that
> > made using binman outside of U-boot difficult. We need to have more
> > people/companies willing to invest time into binman maintainership
> > (sending patches is nice but we also need reviewers). If we keep binman
> > in-tree, we also need a way to make sure we don't tightly couple it to
> > U-Boot again once we have fixed the current issues.
> > I'm suspecting someone who needs binman outside of U-Boot will need to
> > put in the work as we are in the situation where binman works for us so
> > there isn't pressure adapting it, but hopefully it piques someone else's
> > interest and you can share the work load :)
>=20
> It hasn't been that difficult to move patman out and so far I like the
> new structure.
>=20
> I am thinking of doing the same with binman, but we would need to
> figure out how to handle this in U-Boot. Mirror the source code in
> U-Boot and do a sync each release? Accept patches in both places? Or
> just require people to do 'pip install binary-manager' if something
> doesn't work?

Migrating some of our python tools out of tree and managing them like
normal Python projects is still on our TODO list, pending resolution of
some other issues that have been taking up overhead time.

--=20
Tom

--ViW3j4IW/LrbG7Gz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCasER7QAKCRAr4qD1Cr/k
Cs0JAQDR3wEPg1wf2XwGXOqzNAERQTyUy0ovEyxUabh3GT6zsgD+LlhMpoNhIkYX
xFO/Eeytd+w6YBnXv/PYg0/zlZ5jLws=
=AEgT
-----END PGP SIGNATURE-----

--ViW3j4IW/LrbG7Gz--
