Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D61A8EE57DF
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 10:06:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6005C86D84;
	Mon, 11 Sep 2023 12:06:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=short.pl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F40C86D88; Mon, 11 Sep 2023 12:06:05 +0200 (CEST)
Received: from mx01.ayax.eu (mx01.ayax.eu [188.137.98.110])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D64B886D6B
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 12:06:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=short.pl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gszymaszek@short.pl
Received: from [192.168.192.146] (port=39656 helo=nx64de-df6d00)
 by mx01.ayax.eu with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gszymaszek@short.pl>)
 id 1qfdno-0002o7-Jh; Mon, 11 Sep 2023 12:05:56 +0200
Date: Mon, 11 Sep 2023 12:05:55 +0200
From: Grzegorz Szymaszek <gszymaszek@short.pl>
To: Gatien Chevallier <gatien.chevallier@foss.st.com>
Cc: Grzegorz Szymaszek <gszymaszek@short.pl>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 1/7] rng: stm32: rename STM32 RNG driver
Message-ID: <ZP7mg3BKzzLf1MI9@nx64de-df6d00>
Mail-Followup-To: Gatien Chevallier <gatien.chevallier@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 uboot-stm32@st-md-mailman.stormreply.com
References: <20230907162200.205602-1-gatien.chevallier@foss.st.com>
 <ZP7PeFpJzneU2h9k@nx64de-df6d00>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XPZou0uhzQwwXo+q"
Content-Disposition: inline
In-Reply-To: <ZP7PeFpJzneU2h9k@nx64de-df6d00>
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


--XPZou0uhzQwwXo+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 11, 2023 at 10:27:38AM +0200, Grzegorz Szymaszek wrote:
> [...] Shouldn't the "depends on" be updated as well?
> ("depends on ARCH_STM32 || ARCH_STM32MP", like in STM32_RESET.)

Forgot to add:

Reviewed-by: Grzegorz Szymaszek <gszymaszek@short.pl>

--XPZou0uhzQwwXo+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEZT55kPBhnB69hD4ZeE9lGUIcpz4FAmT+5oIACgkQeE9lGUIc
pz52hw//cy7gRdhcBKImyfMrdoOLYIdYSAkRlQXaU7tQOvmLHX4uRJ8a4K40I4Ex
KyLScCwigP3Y0qjuw3o+3aREDaCNM+4sVpPB7yHnC4PoMNSAMQpjVc1HtELV4d1v
z3wZXg3kJYeSa5TEjGmLK5zHK2xxhDOCtCCPRYImlV+Kv1MkWOZrUzjeYtgGufky
lTw23wuXz+S5A8FnR992Y1C35HL2dZpMhRdTQAz2LMDQH2zHCRo3+63DLHKZqg5a
efqGF2BYByHU/mct6bby0y79lyWFykCqKV/cD++YXTVuhJb75CMSdf1yTfjs2n3n
9q/35/Yr7bEWkxfnLngz4dlzVVyXB5G1T7QhejQFsC2DBTPG6+MltTe0G2nEoi2i
1HMJfGfUMhXaaep0LiqjtyJ/44Nj3ExH0dGD+gZONeKGlvwB/fbPNSsopu6H3gAJ
m2axlEUR+JBtgoAOv3OGfb7gddCypq0bx2UVdsyYhDF9qvVb5qxFRYNmlfVhTkZW
zPqWmFGpDzgbzMQL+HIUT0d5owERDR1UrzKEIH1pTuOqYk8o/Z934W1uepQtvWZh
1xDts8vq2+21sKvpHJcL2plzHd4Os9heNpu3vZetA/gNYW4dDHiyi596NkrNCdP/
c5l9l23CwrvhmjKOtctYEfYz3qTkolJEk+Q655C+lqCkDalqAOo=
=VbqD
-----END PGP SIGNATURE-----

--XPZou0uhzQwwXo+q--
