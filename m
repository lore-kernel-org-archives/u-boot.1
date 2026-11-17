Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD764606A33A
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 14:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XKa6kv9s;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Fo09x7Zj
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 942B880D4A;
	Tue, 17 Nov 2026 14:44:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cF8rylEWzUFl; Tue, 17 Nov 2026 14:44:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B1C5E80CF8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794926687;
	b=awex5lDoRkw2UqLGW/TYXKhQ2it/j+w9WgQvrmkzbPXvEFwKiNYQZc6mu3p/MnFDf1iu
	 IHB/FZeiER40v0GBlaEelmaYkVwaEeH5P2E1p6GQ5jX+YQolIMiZ/2RSlNQJzhzn5acZ+
	 iXK9r+HkZF7Kuj8+oq/luIFS1ZgD4eZVktFi1CwPbGE1vdi1dn6qsaRroox1OV/NOMbC3
	 fW1jww9BcdGl/CFceTiRcS/+3g8clV/HhvDBpbfjE/k0yBeMqna75WmfetT2v4rBpBisS
	 mCOOYjItSgKxWcD/qGtoqpdOoTfJjRRpQzAmPhoQIjEmCUEQZKEX3NlyQNAeFgXlzDA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794926687;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=eM7MMUbYfD3HQ7fHjObIDLBDwyL8krFN1JVBgYfcCN8=;
	b=GqxC2QxQzqho3z9ZKIvB0eOFTqhTks7qQ5cB0qNT1L0yAQROuaileAGKA6ar/ZqvrlZK
	 rZ/tfW8ayUa5/Gw2+OkQu3TE/m2RMfG0btt6z7mzbyitR807zvV1/EIbshY4bGV4mm81N
	 xAeQlhbrYWnTa/ZKYo+/elk+pz8deIyP11bhn3Evez+dX7WEmddNvp1drAp3CGC6UYkJR
	 mLBWn5p93gmcCzJ4fTGiOYXqhYd4CltCN7B//xjuaS89/e09Q5IDD4Xuo72vySLB5mXhw
	 JjfaqE6nv0d5uvZ0COLQLqtbpMwAhpIoJ6hlAbS4tMcf2QPaIA+w+J79N0HuvXa8Hbw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794926687;
	bh=eM7MMUbYfD3HQ7fHjObIDLBDwyL8krFN1JVBgYfcCN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XKa6kv9sbFBsa8KcniU+AW+IAlbmNUQV/QAz3kpnDlO/hJOm+Hwd3oVyKRWYbNeeF
	 oh6nebt5Tw1QwPFSHh7yB8Q6vkanuihsXf3hizz6XLEs1rYWZ7II9WL/W2XMxjEhDl
	 PwJBi0mBL8x3WARljPRuDGerN23VffrIeF641PlbXeoSv2HVhN/e3AUxM96vJEHHo9
	 GIrFCUZXJz2YciJY9tkg+60G+91GsFAbs34SHHCzBH6KJ5SL2x/p5HPFfBPU3LtxQ+
	 LmZvFOKFWDU8sY6bb4msP3W3TL/cbUSjSTMg7yZfu1O0pV0rN0KSHo9poXN/WTE9A+
	 toLd/Nh1Ci12w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B1C5E80CF8;
	Tue, 17 Nov 2026 14:44:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2678049B
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 14:44:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0C1A4607F6
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 14:44:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZbYYO6QjvpG4 for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 14:44:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3CF43606EB
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2b; helo=mail-oo1-xc2b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Fo09x7Zj
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3CF43606EB
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 14:44:44 +0000 (UTC)
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-716c0217635so1130272eaf.0
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 06:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794926684; x=1795531484;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eM7MMUbYfD3HQ7fHjObIDLBDwyL8krFN1JVBgYfcCN8=;
 b=Fo09x7Zjeshws6+eSmCgbEqX8v9SXWY7kHKZPNzUzaH+tx1d2xbpJNX4voUtM5N79S
 Ry3q9+Cv4ANyuy843o7OVBWfWka3R+8ak3XASd8SWqnXoGHW3UXGmBOrerO5AEojB/L9
 96OrDQf335h5k7mzhtrd4IIMtUzi/QQqx6oFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794926684; x=1795531484;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eM7MMUbYfD3HQ7fHjObIDLBDwyL8krFN1JVBgYfcCN8=;
 b=MSX2hSTDboiZ3PDM9L4BIasKce90pqMr3+jvJuiOp1Mw7fqCt3vNGYYrPUOjoMJSNR
 78ihzzMG0y4c0i0ACcA8SVTlvdMmHsAYOOnM4BaR7bvwb5T8pfA+MQO4ksDFe+ngXe/R
 pkQtJ2/6iamrW6ekE/SUAGEzX5Gd04u+Ka0g+mLyGNURnXjy9se50xCyLzgbptH3ZQXb
 FXTg9byb8WNnOeyLkh0G/DLScS6h3cMNla0rD8jgogTsGfcRFOfGIIJ+1N2Rxpty0rjy
 Uoi7ToeGIjQQHCcW3pq+w1gekxX4DYHSmNW1JGDXQaSC3Hb6EXM3mn+SjAy34cuf9TAL
 W+Mg==
X-Forwarded-Encrypted: i=1;
 AL+hErGDrHOr8JDAp2aW88uOLoK9VEOzVG5Ei1tCu0Xy8kaubgIG37+7Q9R7iX4iLMikB/GNaBNUs6A=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9PPk7hTw5QXNNoTI+KSC8MmZK7KgtGVo3dNy9IVRrnfuP6QM8X
 qRBNOdVkSBvV+3GlDsgdhXgjznK8oO5I16kxej8xrTknBDjJ7SHIrvhCv+hDo7YvuA8=
X-Gm-Gg: AYBFou1stlRKiD6Vs/ZCxjhZWvu/oQmhtw1MHlRh9rmVFxqBhHlhH6TBuNtWANOXvQp
 3DHsBbrXu1LzIJQtH9LZojVSlGweNm9Klq7uGsTRIOgiielQhg5WyFdHRpeGCnBPMFF6PpOpcno
 sZIliTGoaBEXnYSF+SMNYvOsTDcs0/ugA343RfmVx9wm94jTjixq246ghC1Y9XvpwW2LwxYgTY9
 ot8E5FG6esqYWBV10DWIsG5jYi/09y1CE3qcyJxK8jGlycoPuBet5BCREFwERAez+VBoM5aZ7eQ
 J0SRGQn+natq3/04De+4q6lvhe2XxiJ6GRrMWFDb/WioShRV/8EZWsNZDqzjpkdFR47d6lcqmUM
 0d5o8z7OpSdVyzh/74ExjOTwm6V3tAdwSba1jo7CinO9Gytkf52WDqBp2zb4TK3FS/L+/vWRh8i
 qSH8oinQJDWuwSPi6r2SDE0lJLNkYqSxE+OpuNeHmmIzoBiY1qet3ShZUQ0SkxXMEcl3FBxGEFp
 Li3wZ9uD+xBDBpbDpwcY/bc2YmnHHRvRv5C9uRoBXkSWvKQZKxW9avmNGZMp0dbl9ex9kTJGDus
 jDj60Brhi33jHNxE2DkhiXTC2Cr8omrSgKbUqPq4duoxgwv2UA7J8IEJTQb2UsGIjACegrMNyRD
 t8kqNzr6OJeRxZyUATHvogI6KJ70hYizLRnnNV3CJHSTx5A9KE49JAkYske4JTclIpBKO4Yfu3/
 Hycxvt2/d7D5+VzBGN9vVqOABajV1pK14=
X-Received: by 2002:a05:6820:f02f:b0:712:b60d:2ed1 with SMTP id
 006d021491bc7-71b02408a95mr1739672eaf.10.1794926683676; 
 Tue, 17 Nov 2026 06:44:43 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-71ab4338765sm11476529eaf.14.2026.11.17.06.44.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 06:44:42 -0800 (PST)
Date: Tue, 17 Nov 2026 08:44:40 -0600
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
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
 Carlo Caione <ccaione@baylibre.com>, Bin Meng <bin.meng@processmission.com>
Subject: Re: [PATCH 00/10] binman: support separate binman devicetree from
 control devicetree
Message-ID: <20261117144440.GR554944@bill-the-cat>
References: <20261112-mtk-genio-binman-dtb-v1-0-65cfc9329c50@baylibre.com>
 <20261113174852.GN554944@bill-the-cat>
 <CALeDE9PvZgwiAUxdX=-tN1fgDveNOkeM__xCCJeZrK3Di0WxjA@mail.gmail.com>
 <1b9f2a45-4ceb-48d0-afdb-b406404d98bb@baylibre.com>
 <01408c47-2928-48e3-ba37-34b835a3b98e@cherry.de>
 <f0352e86-58bd-4e6f-aa8f-5253a9c29a55@baylibre.com>
 <4adb08da-1ab4-4849-9001-f0b54065b5d0@cherry.de>
 <273552c3-9bc2-4b60-9a9d-6d6082369fe9@baylibre.com>
 <20261117143531.GQ554944@bill-the-cat>
 <aea66a5f-088e-4e17-8188-4a06357de7d4@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="r//OmPCKJ3J+kzi3"
Content-Disposition: inline
In-Reply-To: <aea66a5f-088e-4e17-8188-4a06357de7d4@baylibre.com>
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


--r//OmPCKJ3J+kzi3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 08:39:26AM -0600, David Lechner wrote:
> On 11/17/26 8:35 AM, Tom Rini wrote:
> > On Tue, Nov 17, 2026 at 08:31:00AM -0600, David Lechner wrote:
> >> On 11/17/26 6:52 AM, Quentin Schulz wrote:
> >>> Hi David,
> >>>
> >>> On 11/16/26 9:42 PM, David Lechner wrote:
> >>>> On 11/16/26 12:45 PM, Quentin Schulz wrote:
> >>>>> Hi David,
> >>>>>
> >>>>> On 11/16/26 6:17 PM, David Lechner wrote:
> >>>>>> On 11/14/26 3:16 AM, Peter Robinson wrote:
> >>>>>>> Hi David,
> >>>>>>>
> >>>>>>> =A0=A0=A0=A0=A0 > Anyone who has worked on hardware that uses a d=
evicetree for the
> >>>>>>> =A0=A0=A0=A0=A0 > hardware description should know the mantra "th=
e devicetree describes
> >>>>>>> =A0=A0=A0=A0=A0 > the hardware, not the configuration"
> >>>>>>>
> >>>>>>>
> >>>>>>> Thank you for this, I never agreed with describing these in the D=
T at all.
> >>>>>
> >>>>> We probably should do some digging on the mailing list because I be=
lieve this was brought up back then. I also disagree (mainly because the Li=
nux kernel will never agree to this in upstream DT, so this prevents us fro=
m the dream of running pristine DT from upstream). I vaguely recall there a=
re a few things that are binman-specific and available at runtime by parsin=
g some stuff. It's very vague, because I don't remember. But I wouldn't dis=
miss binman use of the DT as simply being a configuration format, I believe=
 we use some of its things at runtime too.
> >>>>
> >>>> The two users of binman nodes at runtime that I found are lib/binman=
=2Ec which
> >>>> is only used by x86 AFAICT and board/BuR/zynq/common/board.c (to loc=
ate the
> >>>> FPGA bitstream).
> >>>>
> >>>
> >>> Maybe it's worth checking with the board maintainers if we can go for=
 another mechanism so we can sunset binman nodes in U-Boot FDT entirely?
> >>
> >> That would be ideal.
> >>
> >>>
> >>>>>
> >>>>> EDIT: ah I see now reading patch 6/10 that you're aware of that. Bu=
t phew, is it really worth it to do this incomplete split? I fear we'll spl=
it the ecosystem once more.
> >>>>
> >>>> Which "split" are you referring to? File format, file location, some=
thing else?
> >>>>
> >>>
> >>> My understanding is that few boards will need binman in the U-Boot co=
ntrol FDT, due to needing access to binman nodes at runtime. Most won't, bu=
t the fact we cannot fully migrate means we need to support both forever, a=
nd then we increase complexity for what benefit? For the sake of "correctne=
ss"?
> >>
> >> The one ARM board should be easy enough to find a solution for. The x8=
6 stuff
> >> will be harder since that was all created/maintained by Simon.
> >=20
> > Which x86 boards are these?
> >=20
>=20
> This is what I found so far:
>=20
> x86 (through lib/binman.c):
> * intel_opregion.c and apollolake/fsp_s.c find the intel-vbt entry.
> * fsp2/fsp_init.c finds intel-fsp-s.
> * fsp_silicon_init.c calls binman_set_rom_offset.
> * acpi_nhlt.c uses binman_section_find_node and binman_entry_map.

OK, I can see there will be less, but not no, boards using this once the
chromebook devices only Simon supported are dropped. The answer may
involve looking at how we handled the various firmware files prior to
binman taking over that job. But it's also probably worth at this point
saving discussion until it's time to start on it, and seeing if Bin Meng
has any input on alternatives for handling this problem.

--=20
Tom

--r//OmPCKJ3J+kzi3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavxoVwAKCRAr4qD1Cr/k
CtfVAP9SJHrgBCx9Bq49EgJCfQzIsx9N7E6bjtZOTlmovxRBdwD/VXtIQCCHs9bp
NPX8GYQP5VzNONiRvynKWVj/5sMAUwg=
=mBFl
-----END PGP SIGNATURE-----

--r//OmPCKJ3J+kzi3--
