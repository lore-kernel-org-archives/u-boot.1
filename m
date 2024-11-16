Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 962CCD68BE3
	for <u-boot@archiver.kernel.org>; Sat, 16 Nov 2024 07:22:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 123A4892AB;
	Sat, 16 Nov 2024 08:22:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="C0YYIyAH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBE0F896C9; Sat, 16 Nov 2024 08:22:48 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65325891B1
 for <u-boot@lists.denx.de>; Sat, 16 Nov 2024 08:22:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1731741764; x=1732346564; i=xypron.glpk@gmx.de;
 bh=/ddMVXFOvwU/3EEDGA2oElrs7u4SP9PuAXUWJayujqY=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=C0YYIyAH7YkMbHKIp8l1Tmmi3JEWZpedWNPMtoDqfwL0lb+MiWEHmEt/Eam7WEmG
 yeyqyHZuQMQNZd6hUq4TioO80vptaW0Ns+fZSljdqGlMp3aJixUlus1hsw1hMhsEV
 Ntjcgz2E6BEiS/tUKNAiPKhusxOxsWQkEyqspD69xqBeKZmO4JCwX8fZeeNrYFIXg
 VA/Za6Vttp70We3LvYbKC8RVsZWOGf5cQ47j/ekZIdYT2klekjBCTrJLeGYKy1iL/
 YBRnDVIUnYS3hxCCZKz9xZ/2gfXx18Xi/R0C0ZPCGYFlQpBw6NgZEEWDSJQpyM7pY
 LD9B+kevXX2HqhRMLQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPXhK-1tPuVd3kFG-00O2iF; Sat, 16
 Nov 2024 08:22:44 +0100
Date: Sat, 16 Nov 2024 08:22:44 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] doc: cmd: wget: document lwIP syntax
User-Agent: Thunderbird for Android
In-Reply-To: <20241114142004.2051240-1-jerome.forissier@linaro.org>
References: <20241114142004.2051240-1-jerome.forissier@linaro.org>
Message-ID: <55E2629A-B9C4-47FC-A7ED-D7FB8B75B0B3@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:auZCbTfPAIpjqS/NNR06zSPnd3DrSVAdMHByWHrTBZt4mLT/AIm
 Q2Prw1Ri9cmtbWKVUVwnVOslEMww8IMf2N+86VfAPUHMLjahUF/yk1l1IYlSXJIV27yYS6i
 y0aG+nwv8E1muTms0CgoxbpHqHlVc0nULs4z2IB14THKMERqBJhOWFsyb0exJjQDIxfMS53
 tLJ8arOVzWR6nvZcKUJRQ==
UI-OutboundReport: notjunk:1;M01:P0:b8jIH+bgrFo=;iqjd8AajoMZnmcn4NW4xh3tna5w
 aR0LM1G8qScgtT/6h4f6eUlN11AHbmcJy6EO86TLEr8sA8+tXE8tK5t4rG/Kwg1W9VjW23ctP
 6ors+Zc0zXT9dghnBwGWEL4xPQ991ZSWNpwaunMAHIpBh9i4Jk8YIpyqZRc8uGX6Jg1Rd36Iw
 0SdgLTBMvUxA0immfHOg5F/b3iy0TRn1brvOEOtowmnKLlT1VXgGfzHAXXVcbtAxtu8AvCybk
 Tbra01MmJfWesWxHfIi8J/yYOc7cjKpPR0a8Vp+RTiW3SsG4XLYTK3yb7vlrolhajV9PN2B2Q
 gnxJeyEVbT4n0zVXgB3WVGZq5E3KGqUs2V4rurFX1jSX5mfrSjeTlswF+o96bNfhgyrZGAFsR
 e1j0/pEhMd3XQ0Q30Sg6b/Uq5jG/a8Pn4HyYLwprGNZwarHiI+9lrwnsyBafwntCb+evuztca
 /vK68GnmEHS2I5OOAGydtYzWvVVpwolhTOXuXi5JwikhfnVcbyw+Om4D3pd8qe8C4ABjOa1Hq
 6Nt+tacyOm3dTT+msBu24hM/nPYwim8Mit4tL4eCvxg/e48tgXSpwKW/E24KHHk/fWLp+dQCP
 GK2zgZTH2ytmGPx7SfIG6gnBeo3nmPW8LCjOHNYgS7KP4ixv9Wtuy+/K/EDgm+BYSUJpFr91M
 R164c3AWG1cnjD0qNeoiekJabLgmsyYPhUdOpfsHEbNpS9/ijggHttKfWKttTNbvOjbWriZi7
 YoZkTPIPHMChT2JoMZS6sOG7JOYPZrqDEkKWu31NbMAl6cg8oRTkU1x3/3WvpUUAnKe5FeOr2
 WgtkMRelOzT0EubNFMPpRbBdkSQ9VXT/0l9oJtTNqdTVquvLVP++tBE2tK9HqfmIfcdcyLTaX
 Q18rjg4+AEEJ9JBJ3lwLDisezz6okBGNTGib9VWklvlLe7CBPEv8F5kK0
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

Am 14=2E November 2024 15:20:04 MEZ schrieb Jerome Forissier <jerome=2Efori=
ssier@linaro=2Eorg>:
>The lwIP version of wget supports a different syntax with a URL,
>in addition to the legacy syntax=2E Document that=2E
>
>While we're at it, fix a couple of minor issues in the legacy
>syntax:
>- hostIPaddr can be an IP address or a DNS name
>- path is mandatory
>
>Signed-off-by: Jerome Forissier <jerome=2Eforissier@linaro=2Eorg>
>---
> doc/usage/cmd/wget=2Erst | 71 +++++++++++++++++++++++++++++++++++-------
> 1 file changed, 60 insertions(+), 11 deletions(-)
>
>diff --git a/doc/usage/cmd/wget=2Erst b/doc/usage/cmd/wget=2Erst
>index b8ca35bb140=2E=2E5be01a22e47 100644
>--- a/doc/usage/cmd/wget=2Erst
>+++ b/doc/usage/cmd/wget=2Erst
>@@ -11,29 +11,51 @@ Synopsis
>=20
> ::
>=20
>-    wget address [[hostIPaddr:]path]
>+    wget [address] [host:]path
>+    wget [address] url          # lwIP only
>+
>=20
> Description
> -----------
>=20
>-The wget command is used to download a file from an HTTP server=2E
>+The wget command is used to download a file from an HTTP(S) server=2E
>+In order to use HTTPS you will need to compile wget with lwIP support=2E
>+
>+Legacy syntax
>+~~~~~~~~~~~~~
>+
>+The legacy syntax is supported with the legacy network stack as well as
>+lwIP=2E It allows only HTTP=2E
>=20
>-wget command will use HTTP over TCP to download files from an HTTP serve=
r=2E
> By default the destination port is 80 and the source port is pseudo-rand=
om=2E
>-The environment variable *httpdstp* can be used to set the destination p=
ort=2E
>+The environment variable *httpdstp* can be used to set the destination p=
ort
>+(legacy nework stack only)=2E
>=20
> address
>     memory address for the data downloaded
>=20
>-hostIPaddr
>-    IP address of the HTTP server, defaults to the value of environment
>-    variable *serverip*
>+host
>+    IP address or DNS name of the HTTP server, defaults to the value of
>+    environment variable *serverip*=2E
>=20
> path
>     path of the file to be downloaded=2E
>=20
>-Example
>--------
>+
>+New syntax (lwIP only)
>+~~~~~~~~~~~~~~~~~~~~~~
>+
>+In addition to the syntax described above, wget accepts URLs if the netw=
ork
>+stack is lwIP=2E
>+
>+address
>+    memory address for the data downloaded
>+
>+url
>+    HTTP or HTTPS URL, that is: http[s]://<host>[:<port>]/<path>=2E
>+
>+Example with the legacy network stack
>+-------------------------------------
>=20
> In the example the following steps are executed:
>=20
>@@ -52,13 +74,40 @@ In the example the following steps are executed:
>     HTTP/1=2E0 302 Found
>     Packets received 4, Transfer Successful
>=20
>+Example with lwIP
>+-----------------
>+
>+In the example the following steps are executed:
>+
>+* setup client network address
>+* download a file from the HTTPS server
>+
>+::
>+
>+   =3D> dhcp
>+   DHCP client bound to address 10=2E0=2E2=2E15 (3 ms)
>+   =3D> wget https://download=2Erockylinux=2Eorg/pub/rocky/9/isos/aarch6=
4/Rocky-9=2E4-aarch64-minimal=2Eiso
>+   #####################################################################=
#####
>+   #####################################################################=
#####
>+   #####################################################################=
#####
>+   [=2E=2E=2E]
>+   1694892032 bytes transferred in 492181 ms (3=2E3 MiB/s)
>+   Bytes transferred =3D 1694892032 (65060000 hex)
>+
> Configuration
> -------------
>=20
> The command is only available if CONFIG_CMD_WGET=3Dy=2E
>+To enable lwIP support set CONFIG_NET_LWIP=3Dy=2E

DNS support depends on configuration (currently CMD_DNS)=2E

Best regards

Heinrich


>=20
>-TCP Selective Acknowledgments can be enabled via CONFIG_PROT_TCP_SACK=3D=
y=2E
>-This will improve the download speed=2E
>+TCP Selective Acknowledgments in the legacy network stack can be enabled=
 via
>+CONFIG_PROT_TCP_SACK=3Dy=2E This will improve the download speed=2E Sele=
ctive
>+Acknowledgments are enabled by default with lwIP=2E
>+
>+**Note**: U-Boot currently has no way to verify certificates for HTTPS=
=2E
>+A place to store the root CA certificates is needed, and then MBed TLS w=
ould
>+need to walk the entire chain=2E Therefore, man-in-the middle attacks ar=
e
>+possible and HTTPS should not be relied upon for payload authentication=
=2E
>=20
> Return value
> ------------

