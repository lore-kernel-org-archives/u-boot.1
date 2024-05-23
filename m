Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 946A2C25B75
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 16:29:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 051FE87E50;
	Thu, 23 May 2024 18:29:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hhHuGTAp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECBD0885A4; Thu, 23 May 2024 17:02:36 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D389D87F24
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 17:02:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-792bcfde2baso190663785a.3
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 08:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716476553; x=1717081353; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YqSywSN1tt+sPbH0JEOtpVySDW9+t71FWo7iN1SyHRY=;
 b=hhHuGTApy59DXtmHfnZ7VaxGux4/3fiftZT2XHuucRUJRH8nyTPKLnkj5BhEbAY2jq
 hxb0FBr9y+lkBTU77tX/je15BBlb8vnoPiMf9i7E1YXcTk4y0eL5gn5lSMgtT4LemQdG
 VwS1JCoGs8SBSsDQnjffhHHx3JnbxzdglQFck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716476553; x=1717081353;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YqSywSN1tt+sPbH0JEOtpVySDW9+t71FWo7iN1SyHRY=;
 b=kACaF5y3lkyKKl9SCMdbYhVev9R9ODCIAGi+d4nLMSi5RsO3+8hDnyS6EJmS2uM6Ex
 VNanYaRBnc7KeO+dFSFTjVOzwvK/pWt7ZgZb/BnsT7BIP6rFibEPOEq3wjk5ogsRJE1K
 WUgeSNRRwHOt+jsI8PNPjdnFv5r8jV4aqqbOaCRx8aX5mXOBzWGnbyBr4tiM+YI9EJNW
 13XKTYC/y+9Opjkc4TynGNzKfXcr9ztGlfkNBs2Xy3mNj+5OejQk8FTUaQ7/CJU/mZbJ
 dZ6KjXlC60gbfjBI23EfFQzJm5NdwPKK8wexXaDIjMgP75sozVQ8/9A2dTxAAMXCe7gz
 Gl6w==
X-Gm-Message-State: AOJu0YzxK6UGzcJoI1smTiCc4rXwx7XElkj/xPbuIF6IjCfgVpw20cDN
 ZjXoIaashauly6ZATpkVjRM8o+VGqLhwr00m2UHRin6J3m9af/f/yh9WzPA3+cw=
X-Google-Smtp-Source: AGHT+IFj4HwQKhr0AEp79sEBU9Gy43boIaW007ii/RFQmcFC3hBejXQ9/bMB5SYLBTlP4H5nxykckQ==
X-Received: by 2002:a05:6214:2b9d:b0:6a9:944b:8fdb with SMTP id
 6a1803df08f44-6ab7f332cd8mr54876806d6.9.1716476553446; 
 Thu, 23 May 2024 08:02:33 -0700 (PDT)
Received: from bill-the-cat ([189.178.170.52])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ab8bacd8a7sm11528356d6.81.2024.05.23.08.02.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 08:02:32 -0700 (PDT)
Date: Thu, 23 May 2024 09:02:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Andrew Davis <afd@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bryan Brattlof <bb@ti.com>, Jesse Taube <mr.bossman075@gmail.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Eddie James <eajames@linux.ibm.com>,
 Shantur Rathore <i@shantur.com>, Bin Meng <bmeng.cn@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Artur Rojek <artur@conclusive.pl>, Shiji Yang <yangshiji66@outlook.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>,
 Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH 03/15] net-lwip: add DHCP support and dhcp commmand
Message-ID: <20240523150227.GM2568172@bill-the-cat>
References: <cover.1716393035.git.jerome.forissier@linaro.org>
 <3a25276d4ca12b29c3ad9e7132d9a3960fffeb52.1716393035.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JDkaMoBN0jWdQMb3"
Content-Disposition: inline
In-Reply-To: <3a25276d4ca12b29c3ad9e7132d9a3960fffeb52.1716393035.git.jerome.forissier@linaro.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Thu, 23 May 2024 18:29:41 +0200
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


--JDkaMoBN0jWdQMb3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 06:00:03PM +0200, Jerome Forissier wrote:

> Add what it takes to enable CONFIG_NETDEVICES with CONFIG_NET_LWIP and
> enable DHCP as well as the dhcp command (CONFIG_CMD_DHCP_LWIP).
> - net-lwip/net-lwip.c is mostly empty for now. It will provide functions
> similar to net/net.c except based on the lwIP stack
> - include/net-lwip.h is a replacement for include/net.h which is unused
> when CONFIG_NET_LWIP is enabled. Declarations from the latter will be
> transferred to the former as needed when new network commands are ported
> on top of lwIP.
> - CONFIG_CMD_TFTPBOOT_LWIP is introduced due to CONFIG_BOOTMETH_EFI having
> an implicit dependency on do_tftpb().
>=20
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>

I don't like a new symbol for re-implementing each command. To me, the
user should pick lwIP or traditional stack, and CMD_DHCP gives the DHCP
command and so forth, and so the Makefile gets reworked as needed.

--=20
Tom

--JDkaMoBN0jWdQMb3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZPWn8ACgkQFHw5/5Y0
tywKKQwAiWI/ZKM9m1177THtznNQ5KHWUmTq0J6M46LBGSgsBY5aVu0sgvPnCPxx
VgywuYXhYJmzAkgOPFeyb6H9bzgduhtUaYOkjaDxweYDEPuVTyuewfp8kcLF9B1p
dT/wTHjygQSqPNZEtooRO9AEF0jHpehWVzvOlfhk7lhVjxwphPZMdkPsoB+B5UJw
wqxM4cJd+WO+Iejnp2xHQHdPnLNZM1tPVI6kf9CoTSGczzuXWef4JWovYcvhg31K
m1WDn7gSK2N2HcdjdpGOtB+YL0mkFteoxRSipYqirwluEbj6cswxBMb60vcOcUes
FMYhe17/NFMZF2IdFBZj1bMnTl0hwlnbE64kWKpOc9fhbpw/RNrq/fSFDohS8QoA
ocvIDbybR+cbMhIIZOtGNPcwdDFFsrubbnQQS0Ne/+ygLswu7jcDazxx0JWbG4sV
880tq0CrIPgaJ6IQ4NLkZwC8br2KdImLGJpaMUsar18ee1myqfXO24MvfmIwtxk6
qwKHNqe4
=j/j/
-----END PGP SIGNATURE-----

--JDkaMoBN0jWdQMb3--
