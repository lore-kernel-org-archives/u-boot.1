Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 331C0C10F05
	for <u-boot@archiver.kernel.org>; Fri,  8 Dec 2023 13:21:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB2BD874FB;
	Fri,  8 Dec 2023 14:20:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=fjasle.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BCDC8743A; Fri,  8 Dec 2023 12:48:18 +0100 (CET)
Received: from mail.avm.de (mail.avm.de [212.42.244.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8CB186C8E
 for <u-boot@lists.denx.de>; Fri,  8 Dec 2023 12:48:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=fjasle.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n.schier@avm.de
Received: from mail-auth.avm.de (unknown [IPv6:2001:bf0:244:244::71])
 by mail.avm.de (Postfix) with ESMTPS;
 Fri,  8 Dec 2023 12:48:14 +0100 (CET)
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
 by mail-auth.avm.de (Postfix) with ESMTPA id E5B0A806A5;
 Fri,  8 Dec 2023 12:48:13 +0100 (CET)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
 id D707A180C63; Fri,  8 Dec 2023 12:48:13 +0100 (CET)
Date: Fri, 8 Dec 2023 12:48:11 +0100
From: Nicolas Schier <nicolas@fjasle.eu>
To: Simon Glass <sjg@chromium.org>
Cc: linux-arm-kernel@lists.infradead.org,
 Masahiro Yamada <masahiroy@kernel.org>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/2] arm64: Add BOOT_TARGETS variable
Message-ID: <ZXMCfVw7kwvfGn/i@buildd.core.avm.de>
References: <20231202035511.487946-1-sjg@chromium.org>
 <20231202035511.487946-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BSFSRSoXpjCiBLZV"
Content-Disposition: inline
In-Reply-To: <20231202035511.487946-2-sjg@chromium.org>
X-purgate-ID: 149429::1702036094-2FFDDD82-4CAFAB7C/0/0
X-purgate-type: clean
X-purgate-size: 1914
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for
 further information)
X-purgate: clean
X-Mailman-Approved-At: Fri, 08 Dec 2023 14:20:38 +0100
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


--BSFSRSoXpjCiBLZV
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Fri, 8 Dec 2023 12:48:11 +0100
From: Nicolas Schier <nicolas@fjasle.eu>
To: Simon Glass <sjg@chromium.org>
Cc: linux-arm-kernel@lists.infradead.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	U-Boot Mailing List <u-boot@lists.denx.de>,
	Tom Rini <trini@konsulko.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/2] arm64: Add BOOT_TARGETS variable

On Fri, Dec 01, 2023 at 08:54:41PM -0700, Simon Glass wrote:
> Add a new variable containing a list of possible targets. Mark them as
> phony. This matches the approach taken for arch/arm
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---

Reviewed-by: Nicolas Schier <n.schier@avm.de>

--BSFSRSoXpjCiBLZV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEDv+Fiet06YHnC6RpiMa8nIiabbgFAmVzAnsACgkQiMa8nIia
bbjzLhAAnGc5zZlSZDcS57dXbgC5jj4DDIk3UsSib8BJO/mrvy5NV1kot35nOlCv
ITg7qaxJZGZhBIP730+qieDixLLAWCB9ybHnjmqMkmm9GYsPHSpAjTpuWzeyNBxu
Fu7k3nHjFMOlYM8isC51bifmy3M0+7oogWGYj/JtmKnQDAHnOzGwQxeJJvgAHkUw
RP8RGHngI/BGjMuyuofQ8zNba3k3RSJQREBwZ/Onu8FaYof77PJ4/0YF+hPaGHQS
gJpJ7QdhKu24JAkBbhIBSrIWULOvyQUfWhUdjC3HuidoMxfbDEYoG3SICcRaKo9e
wFbTUk+y5WUXCloKR4whRnsnqNeFxbPUwi4z+lgxLRfHc5QAEDD+KsBJdEV2Q/Rz
aFN+ASSGU5JIKJJXe58kk3neOG0EOk5z39Xw+6AJudjCgDnRa7cCTbtRwNVwgb+w
3T+xxMari2SfksRCJ1eSDw/VziqRSvKBw3Sbltfq6wdGMdZnnPZFafu7TQZmPH23
Q6eowZ2qNTZpL7Dd9cHiWMQribKTTynpaB1k5gE5iV6cN9oMMAEktvxJC+MzPMU5
1aKJWtlGc7mMPnvRCvVrHraeRWv18P2IT4Y23IGkTkIDUWKpgdTO8blwygmj+SU9
plEST8o2VyQWcjfok8MCEdFGNDEA1Q8rsmImUImYHIR25cedLsY=
=Xmw+
-----END PGP SIGNATURE-----

--BSFSRSoXpjCiBLZV--
