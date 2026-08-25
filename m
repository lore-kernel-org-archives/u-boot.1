Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1066AC61DB9
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 19:45:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BEE6640665;
	Tue, 25 Aug 2026 19:45:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ajoBtJxe0yuH; Tue, 25 Aug 2026 19:45:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787687139;
	bh=sAlKgwaWd8csqxm+JSJ+Y8Az04o93ztsEXxl94a1EpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tqEW/Z9uOblzdPzsTKCXQYwQxfy2HEP+E25DQ80xKiW3y394vlJ2BKZvKE51xECF3
	 OqCZvfnVLuCBkXepF+B3JKoV5XlMbf5/LuTTD2XXUlDfUe1iBwtXQ3XyTbJIfNJjUJ
	 98p+8PzB4YobIt/9g8QRV2QV/NLCHD3xu8hlafXC3vgXft/rsCtSGErD+1Xrts1Kcq
	 FRKulSbvhnoGGIxknPvg0u0WTKsyQvzeXgCP5FKAAcGpD7RJvJXkjGmpZDdT+1vB6h
	 oORGXNWuMCr1gK2RLh8TCghLc3+2jLPrglsJgukZA0H6270vrvcm+ReFdwpdffJJVw
	 9jUb00VE5td7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3736A40606;
	Tue, 25 Aug 2026 19:45:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 64B73334
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:45:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5643960712
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:45:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AYxA1hxoVJgg for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 19:45:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::5;
 helo=mail-oi2-x05.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=T2UEebWz
Received: from mail-oi2-x05.google.com (mail-oi2-x05.google.com
 [IPv6:2607:f8b0:4864:32::5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 28EE96070A
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:45:33 +0000 (UTC)
Received: by mail-oi2-x05.google.com with SMTP id
 46e09a7af769-7e9db59c430so66076a34.0
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 12:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787687132; x=1788291932;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sAlKgwaWd8csqxm+JSJ+Y8Az04o93ztsEXxl94a1EpM=;
 b=T2UEebWzu7pr9akH2M5Wuf4ICU8CEW+YuDDo7EhU4V/6zQjDXHNX1LLd9+N+3GqidM
 ryL8qxR/KKt3KaLLaIrpWy6C+mVWxUfAD3WGDDrWer/sVGIW3qW5qtUu8a1gvA+th0Jd
 LWn7SWgHZ4vDI7QWP7GVFfecXNkfI4xR+8Ki4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787687132; x=1788291932;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sAlKgwaWd8csqxm+JSJ+Y8Az04o93ztsEXxl94a1EpM=;
 b=NG3SRuQJEiqr3qIY2Q6Zk/0/SQdmBY1OL/9tWbiR/3p0W87dhvMVRjUnbH/CmaHz5L
 UlToKG6Zq9wJ+9I3BU1vk0wvYAODu8RMLxSctYd4WyQ2w05l0/oS8oSJnrYpUMlPvF+Q
 Jnx0v9xFusPfmDQF6MV3ejPblVpvW6oTfSRNR/dxrQixoEBQzBFkrWtXXXjGxl3qaavk
 qk9Ax0F5aJ6pW2pE+HvC0Cmoj1AVkrKo6FFO8vGRXrs7UdFyZyp7KdncFnvJ++KYkwp4
 gJSgV0SPEVWn1VDxS6dbIJoQ80xzP4ZoNdNHw6QvIw09DUhGGeaSWQDkzefndNXX2UVL
 kz7w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp57UW5MYRXIVQgu2wsZR3WvNcoHY51xpGnXU7GQ44wRF56KU4aTIh/wzDILFd5GyNGUvMbgsE=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kTjgrCxkrwqPcH5r1/WJWNwsKkq+lxsdnWnTUsXXXoyLGH1XcB
 eZEny6nXTTWlkS8l3mTdpb3DntFxE/G8gA06O3pfGTXcolCimzESVDb9bS+XNN6p2LE=
X-Gm-Gg: AR+sD11eVV1tt++poUhqoz1CqeFlq5TW1oxhX+ese3ntjS+P5NYf4EF/2UirpO8xBPT
 Wimag/0am5zELCaAon2uBkpU2Tr5eHywWXf73ONeM3ATRJbmtX8rbOJPmtfyo9QMcCpHuc8/Qje
 n7rqQU7wDCwR8bMkj3PEzALL8TicHFlq8+LZLg3+YZFLO3pj1888qRKmPfKvbojuYVSZHjb2QOH
 7Q1A5X8GIOE74PxPVy3/d1ylxHJlRG1rQ3HyLx1/HFsgHAKvyeHBZ34kOZjiKwcdk+vBBhvRn/I
 rHnmT0u3NHXQ876jyqhpvKQmhNhNzBOCht6KP1+RXCVHN3zpXnNGyCemlEOUpjifB1/4BVFTrgJ
 XhH3EjhG3I+WzXK82CGYoQU4z/Yy+Khw7dOAbg+UHHx0sK+ZoGmIYbYWASIVpzyCYfjRDM0WKOQ
 9A9iFCt7f5G1MnTLiXUmFu+tM+qVdz4K4RZA3VmYVD/L/eYt1nTd6L8alXi0Fau2sJ6J3berDNi
 9OJFpF7JjPKYLxgLpmSixH3eENC5eSP6JABcJm163oJ8fXYRlanL1Hv12kDBmu8dpXmTxr9wE+G
 Cpjd5dxrMA==
X-Received: by 2002:a05:6830:7195:b0:7de:5bad:ace1 with SMTP id
 46e09a7af769-7f4c502d4a5mr1087185a34.12.1787687132616; 
 Tue, 25 Aug 2026 12:45:32 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f4c42116fasm389131a34.6.2026.08.25.12.45.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 12:45:31 -0700 (PDT)
Date: Tue, 25 Aug 2026 13:45:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Alexey Charkov <alchark@flipper.net>, Anton Burticica <mouse@ya.ru>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Simon Glass <sjg@chromium.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Jacobe Zang <jacobe.zang@wesion.com>, Jagan Teki <jagan@edgeble.ai>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, Jonas Karlman <jonas@kwiboo.se>,
 Suniel Mahesh <sunil@amarulasolutions.com>,
 Klaus Goger <klaus.goger@cherry.de>, Tim Lunn <tim@feathertop.org>,
 u-boot@lists.u-boot-project.org,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Subject: Re: [PATCH 3/6] disk: part_mac: Fix stack corruption on devices with
 large blocks
Message-ID: <20260825194528.GB523975@bill-the-cat>
References: <20260731-gpt-4k-v1-0-a3f1f16b53ae@flipper.net>
 <20260731-gpt-4k-v1-3-a3f1f16b53ae@flipper.net>
 <cb50976b-917f-4843-8b0d-dc2a32e59d65@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ueMxLOqeJUiH8LuK"
Content-Disposition: inline
In-Reply-To: <cb50976b-917f-4843-8b0d-dc2a32e59d65@canonical.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--ueMxLOqeJUiH8LuK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 09:37:43PM +0200, Heinrich Schuchardt wrote:
> On 7/31/26 14:40, Alexey Charkov wrote:
> > part_test_mac(), part_print_mac() and part_get_info_mac() each declare a
> > single-block buffer sized after the descriptor struct:
> >=20
> > 	ALLOC_CACHE_ALIGN_BUFFER(mac_driver_desc_t, ddesc, 1);
> > 	ALLOC_CACHE_ALIGN_BUFFER(mac_partition_t, mpart, 1);
> >=20
> > Both structs are 512 bytes, but every blk_dread() below them asks for o=
ne
> > block, which transfers desc->blksz bytes. On a device with 4096-byte
> > logical blocks that writes 4096 bytes into a 512-byte on-stack buffer a=
nd
> > corrupts the stack.
> >=20
> > part_test_mac() runs on every block device during partition probing, so=
 on
> > sandbox with CONFIG_MAC_PARTITION=3Dy this crashes on any access at all=
 to a
> > device with large blocks, for instance:
> >=20
> > 	host bind 0 disk.img 4096
> > 	part list host 0
> >=20
> > Pad the buffers out to the block size with ALLOC_CACHE_ALIGN_BUFFER_PAD=
(),
> > which is what part_efi.c already does for its own block buffers.
> >=20
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
>=20
> Modern Apple Computers use GPT partition tables.
>=20
> Gemini claims:
>=20
> Because APM was functionally obsolete by the time Advanced Format (4Kn)
> drives emerged in the 2010s, Apple never updated the specification to
> establish official compatibility guidelines for native 4 KiB sectors.
>=20
> If Apple has not defined how to treat 4 KiB sectors, we should not try to
> invent a scheme.
>=20
> Apple has already deleted the documentation of this outdated partition ta=
ble
> format (http://developer.apple.com/techpubs/mac/Devices/Devices-126.html)
>=20
> My preference would be to remove this driver completely.

Yes, this is another case where we can just drop the driver and if
someone *needs* this for something, likely emulated, they can bring it
back.

--=20
Tom

--ueMxLOqeJUiH8LuK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCao3w1QAKCRAr4qD1Cr/k
CqZOAP9MGw7/ykK1xvnrejdbZa14qZsLnTnbDKF3hR9JoTG/yAD/dEgF6Maiisjg
0Z7gRom9kOTZ5anNHE6pkEUBdsgVwQ0=
=NCyH
-----END PGP SIGNATURE-----

--ueMxLOqeJUiH8LuK--
