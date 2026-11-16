Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D042606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 18:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HsXGWhdb;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=ZYPt57g5
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0A22460793;
	Mon, 16 Nov 2026 18:49:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8cROYWMIHaQh; Mon, 16 Nov 2026 18:49:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3EC7560739
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794854970;
	b=WNpK4mE+oEKUxD3WoTXaAkavRXXQaRik0ACYGzWTnliLb/zSPsmWvlrz9s+jXaEJnsaW
	 cunmM8TRVpXsAh4NOPpYsCMYPA/pvuuepjECsItF5fQ5i0J+7ewIL8ZF9Km7X5TMEWq7v
	 Yv/2gs3sD7cLGCjpcQIR46S7QfgpkAEk0o7Rf9itRv474Lyc41zMAlWvI1RuHcp+2A607
	 /6C0BgPwVlxm5VXr+nRXJH57a4ib44ramNlEShn8NnRqDWjvHIdKOhZ75VO6G/jxcCnRm
	 vD+uxcBfobRcgRcPUEEod97I77FVYAT9mSooxkL3/gFtw1BatGkGDM3ppdv1KiRKzug==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794854970;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=MGn99kgLnYgz8E8qnROvseFhfx+2z5N9I4RZkxuaGyw=;
	b=BMl6YoJLr9LbcSV2/B6ubdfaKeAgILfHUz9YhJjjV+0hmikfQE8XPAH79RHkN/0/aURZ
	 PXNpgoIL/YqIj6ht7PFQ6B4m+75C3l09dzv0X1/+Sq9CdBLtDehoHJRhqs9hCH+qYj7wR
	 bhXiPXZfgoUaidYcWGTTF+17IIff50EdQ7Rk7I7F14LGlc8G+tn4TJ6+Meifp+l0iD/no
	 +F3/R42DSTDtHdLFm3ZG4VhQhloNJJuKKGmx8HaIO22h3qm9LBpTStepZejaXsWsgGReO
	 WKuAY6KpOnAcIxGMa3nD00CPVm+jqTdK5G9hfxp9LehuXKjN4T+oDRZhgOwCLVHs5gg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794854970;
	bh=MGn99kgLnYgz8E8qnROvseFhfx+2z5N9I4RZkxuaGyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HsXGWhdbGYi8ZRpGCOLCfbZ9/rURwVZdbq3sF4BcTZ0/LL6SD0z2q7FbEqo56l2Pt
	 1k8d+mexDT5sO2QRx6mx5cTqkoSH0PEa+OAn19yjCO7UUa2RqdCA4BebX5zr6pWnTN
	 wgegfU42hEaqxTl+OARTVuuU0ar630LPxVHNf3AkWuMt7698Dz4GEFQgW1GtJ9z/Mp
	 HFjn2NHRXMrQ2YAsPMvCD0AdC+9QpuOq1h/piCl8EthL2ZINSGON+tsA837jjngd9z
	 edWxTj8r0QF84/I4Y0xx9uvLRhKfEArMi9d1msP9mwSetSz+v6eqa1Y8iei8e2s/V7
	 bqJJtEnmzD67Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3EC7560739;
	Mon, 16 Nov 2026 18:49:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D350728C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 18:49:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B983E4007E
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 18:49:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0eNGlfbnbgkr for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 18:49:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 055184007B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ZYPt57g5
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 055184007B
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 18:49:27 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-833e671ee9fso4902018a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794854966; x=1795459766;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MGn99kgLnYgz8E8qnROvseFhfx+2z5N9I4RZkxuaGyw=;
 b=ZYPt57g57i4GL57SLQM86iaedS5b12yn+A6hxzpeasugPtPiPSaGW2Hr31DSq6hvaW
 VLL9+x0K0mqW5UZbip3E1G1upZ8F6eatOHKNYn6VOJDxSeaAC/LTwU9RA2vSAQfvuQy3
 Us2ksT+WmiEHIYhZ8pPS6l70YyiMfXySzoIPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794854966; x=1795459766;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MGn99kgLnYgz8E8qnROvseFhfx+2z5N9I4RZkxuaGyw=;
 b=RaLJIhrxWi99l+t2QkuBUTHx9B+AZlqaGd7Ojt4tzdtEJo0tDpU8axxAgdlaK2xIzA
 WwKVdqhJmiRcpntksxmsQZPQ5R2ncI3V0Keuh5hyoKmvD7alpa7ts/H7EpZ0l8MyWz26
 w93llKXbVuBEeHSd12fkh0s5vKCvQQDf8Os/BrCW/FI7ro2dB7gSRgfBvaboh9/WTnHa
 i+BaOlBYGBFyx433KodaZTJToNJ2ddYgrilKC6H7gr4i/xuuXBAFo9qG8R144nANlgAf
 4nA5TMvEikCqgp0Lqx+SsXp/j5+Cjo1lKRJ7ZXee29KoAXHgHnmP25ElHXaC/ExRjtX1
 PcfQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHAPfMxqZSwdYH4oBCkpfGw+vL9ffiiwpx+lZE2SWjonErgO0vY2LmxOWGVQriYJoMmbDQeJ/o=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+vEjsulwGRf8rpzpFHCc2SULiviVYxrp5q0MmVvCzEcBG8Q17v
 6af/2ZrpSJv5KudUt2rryJRKrHXt2ETukNxC3H5rUcJmHO7QMjzgBTzqogtcReH56fo=
X-Gm-Gg: AYBFou0wJ4TUMsETjElAm9SXeCNIiy/DjlYagrkUGzNeOkkZfd7tRWI8NCsqSrYHnuT
 8oEISw90t425IdJ+4JDyR41aHcJbkWYyryKEQaOln2eJFO7p7s31YgBRoY9n5t68TRGTLqyjqbU
 hf50SNOxJ8v8F2MaI3fZ7u449B18WesK9G91ldPV/NNy6t/0hVarmmpGJVp9cu0Lhe988u5w/fB
 p6cD612pl/YRwKNa21I05X6Bq8eyt8lW5FReQjvPwrkZp7vpypz94qgujy91jRujDCFjdldkJe2
 TH7dVGf7duoM44yjLwWXapkkZSh7EffpXO0eVnLc8xcGC/o7sYXCH1i9/r88RQO2PoUIN4J8N7F
 efRWA7TV3+y46K4InvuRQjg/xbR704G1IMupiwFYL/5ZkgVcxAedjsl8I/qHORYz8kGlTQGpXRR
 Bz+/vnkYmUUVo/zkA/kXeLdu/J9nmuDSp6TQH8p6JdN9RWm598gDu24G45psh8TxqQ/sfuL0sU5
 3i/YydOoGlRU3d7jKP+tb8hKOoNCBcE/j9HVODfuO+Ej90j4ZN9auvVe2r650cFlg2/cy4i/zar
 qchKTYiV1qMKBkglOCKfc9vtgbmTKGlLaOSb9l/v4uAAeaF3mkGgi8dZuhiaYo0+0A0wZGMfXyk
 C9ac5kSDTTUEjvf2P8fQ27BD4jIeNYoiqtGiHTlYzUa5nLr4YTDYf94FIet/Yn3FHWaRE9Hasmk
 dKpHqyYEAQUSBYG9hHHbkNVOAfFqXFzcI=
X-Received: by 2002:a05:6830:2649:b0:862:a48e:24d3 with SMTP id
 46e09a7af769-862a48e25c0mr8125112a34.18.1794854966475; 
 Mon, 16 Nov 2026 10:49:26 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8628813346esm10569924a34.17.2026.11.16.10.49.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 10:49:26 -0800 (PST)
Date: Mon, 16 Nov 2026 12:49:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: David Lechner <dlechner@baylibre.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Macpaul Lin <Macpaul.Lin@mediatek.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Michal Simek <michal.simek@amd.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Carlo Caione <ccaione@baylibre.com>
Subject: Re: [PATCH 00/10] binman: support separate binman devicetree from
 control devicetree
Message-ID: <20261116184923.GH554944@bill-the-cat>
References: <20261112-mtk-genio-binman-dtb-v1-0-65cfc9329c50@baylibre.com>
 <20261113174852.GN554944@bill-the-cat>
 <CALeDE9PvZgwiAUxdX=-tN1fgDveNOkeM__xCCJeZrK3Di0WxjA@mail.gmail.com>
 <1b9f2a45-4ceb-48d0-afdb-b406404d98bb@baylibre.com>
 <01408c47-2928-48e3-ba37-34b835a3b98e@cherry.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gD4CMmM7VP8POG7a"
Content-Disposition: inline
In-Reply-To: <01408c47-2928-48e3-ba37-34b835a3b98e@cherry.de>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--gD4CMmM7VP8POG7a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 07:45:15PM +0100, Quentin Schulz wrote:
> Hi David,
>=20
> On 11/16/26 6:17 PM, David Lechner wrote:
[snip]
> > >      My more direct concern with this series is, who has some review =
cycles
> > >      to step up and co-maintain this tool? It's already been privately
> > >      suggested to me that we could drop the lofty "one tool for every=
 project
> > >      to rely on" goal since most projects continued to develop their =
own tool
> > >      for assembling binaries anyhow. And that in turn reduces the sco=
pe. But
> > >      it's still an important part of the project and so needs some pe=
ople
> > >      looking after it with a more global eye.
> >=20
> > I might regret this as I am as overwhelmed as anyone else with reviews =
these
> > days. And this is my first time touching/using the binman code so I don=
't
> > know much about it yet. But it seems like this is relatively low volume=
 and
> > I know Python very well and this seems like pure software so I don't ne=
ed
> > any specific hardware to validate it. So I could try to help here for t=
he
> > time being.
> >=20
> > As a fair warning, I do tend to want to be a bit heavy-handed with my o=
wn
> > changes when I am the maintainer. The current binman code looks to me l=
ike
> > Java written in Python 2, which I find a bit painful to read. I would w=
ant
> > to "clean it up" with modern automatic code formatters and linters as w=
ell
> > as add type hints to make it easier for me to read and understand so th=
at I
> > could maintain it with less effort and also to find latent bugs.
> >=20
>=20
> Please be mindful of the minimum Python version we should support. I think
> we still support OpenSSL 1.x for example (also by the fact that it's the
> interface used by LibreSSL I think?). I have no clue what version of Pyth=
on
> we want to support, but we're typically supporting stuff well past their =
end
> of support date.

To this point, yes, LibreSSL needs to be supported (because we support
the BSD families). As to minimum Python version, I think 3.7 is our
current badly documented cut-off, and that might need to get bumped,
depending on what LTSes out there in turn care about as their version of
Python.

--=20
Tom

--gD4CMmM7VP8POG7a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavtQMwAKCRAr4qD1Cr/k
CmglAQDGKkKfxloqMTNSxf1SqTC2Ls2yqonwIVirlGRaG27RywEApn8sIIpL7j6d
oqncu7d3XKpV8SaZ0Ws/tWiEbB+40Ak=
=1DLR
-----END PGP SIGNATURE-----

--gD4CMmM7VP8POG7a--
