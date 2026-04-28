Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AFF0FF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 16:42:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1417D845D8;
	Tue, 28 Apr 2026 18:42:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="cuKFAkh3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D159C845E3; Tue, 28 Apr 2026 18:42:16 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCAA3842D7
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 18:42:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1777394532; x=1777999332; i=xypron.glpk@gmx.de;
 bh=cmoT65K3oh4M1ijp/4HGrsfPrwzWE7o4OxoaY8cizr4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=cuKFAkh3rMsjF7d7d/1PN4zl06hUKSITQlLH/qFtkq1BxhNks0KdHYLP0p0OABDW
 QUU608xfKVaQA+aHN4VXRiBvXxYGIUKeueO2+Q9xLfbFhU1C5QmVl4xg5YY/mBvOA
 uH73TNd1aoBocqpAMGaySlkLavjlJO5SOc9ULFztkQvWycZ936AvB2x8Xf1U2fCC6
 cMMnXHTA7U2QkeXT+tQ3EOrN0V92ko36E0J6FySRUT3PW2THLQKP2VaPMgDgiXNRN
 Ki9wgRdD3n/4cOR45TQq1s5xMmlzyjNHZiKjUjK5D5kxBXiEe7nOomhxATgJHDBC9
 QIUvuanS/QlCET6yzw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIx3C-1w2qze2UrC-00VDVZ; Tue, 28
 Apr 2026 18:42:12 +0200
Message-ID: <0581216f-2e6c-4924-b7ee-058d892e5b2f@gmx.de>
Date: Tue, 28 Apr 2026 18:42:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] test: wget: validate URI for lwIP
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
References: <20260428-wget-test-lwip-v1-1-f611cea0c5ee@cherry.de>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260428-wget-test-lwip-v1-1-f611cea0c5ee@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5ESKO0OPixEEQc3EywTczx3TyFqLHbzT7MhsnwGDLj0g8wA39iI
 MvJjc0ZygnJrzPDDaFMTr7jV5MHaT4tYpN/DAhYuW++kV8xJIu9tQaNaq9Wx6yStMTqKoHU
 Fk0OAOvx7FfWambvxamupn0WuHH3tdzs1qebXS4N9JsYvju7a651xCM1H1Psn2BnEhEOz9M
 zJ+m4q1T24lRRnOpSWeQw==
UI-OutboundReport: notjunk:1;M01:P0:kthIHnec1Ig=;jrOZcd4sm0PNx7wrQpC+BVcpgCN
 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
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

On 4/28/26 17:55, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>=20
> We've had wget support in lwIP for almost a year now, so let's do *some*
> checks in the form of validating URIs.
>=20
> The other test in test/cmd/wget.c currently requires structures only
> defined for CONFIG_NET_LEGACY so it's left out for now until someone
> ports the test to lwIP.
>=20
> This was tested with:
>=20
> ./test/py/test.py --bd sandbox64_lwip --build -k net_test_wget

In the CI we already run a HTTP server:
python3 -m http.server 80 --directory "${UBOOT_TRAVIS_BUILD_DIR}" >=20
/dev/null 2>&1 &

In the test we should load a page from there.

Let's use the sandbox host network interface and remove all sandbox code=
=20
that is emulating a HTTP server.

This allows to make the net_test_wget() executable on non-sandbox platform=
s.

Best regards

Heinrich


>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>   test/cmd/Makefile | 2 --
>   test/cmd/wget.c   | 2 ++
>   2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/test/cmd/Makefile b/test/cmd/Makefile
> index 5f2815b1bb6..28bb8a82ca4 100644
> --- a/test/cmd/Makefile
> +++ b/test/cmd/Makefile
> @@ -39,9 +39,7 @@ obj-$(CONFIG_CMD_PWM) +=3D pwm.o
>   obj-$(CONFIG_CMD_READ) +=3D rw.o
>   obj-$(CONFIG_CMD_SETEXPR) +=3D setexpr.o
>   obj-$(CONFIG_CMD_TEMPERATURE) +=3D temperature.o
> -ifdef CONFIG_NET_LEGACY
>   obj-$(CONFIG_CMD_WGET) +=3D wget.o
> -endif
>   obj-$(CONFIG_ARM_FFA_TRANSPORT) +=3D armffa.o
>   endif
>   obj-$(CONFIG_CMD_SPAWN) +=3D spawn.o
> diff --git a/test/cmd/wget.c b/test/cmd/wget.c
> index 1005392b952..15c2a854e09 100644
> --- a/test/cmd/wget.c
> +++ b/test/cmd/wget.c
> @@ -23,6 +23,7 @@
>   #include <test/test.h>
>   #include <test/ut.h>
>  =20
> +#if CONFIG_IS_ENABLED(NET_LEGACY)
>   #define SHIFT_TO_TCPHDRLEN_FIELD(x) ((x) << 4)
>   #define LEN_B_TO_DW(x) ((x) >> 2)
>   #define GET_TCP_HDR_LEN_IN_BYTES(x) ((x) >> 2)
> @@ -241,6 +242,7 @@ static int net_test_wget(struct unit_test_state *uts=
)
>   	return 0;
>   }
>   CMD_TEST(net_test_wget, UTF_CONSOLE);
> +#endif
>  =20
>   static int net_test_wget_uri_validate(struct unit_test_state *uts)
>   {
>=20
> ---
> base-commit: 4433253ecf2041f9362a763bb6cb79960921ac7e
> change-id: 20260428-wget-test-lwip-9e18a85cb2f9
>=20
> Best regards,
> --
> Quentin Schulz <quentin.schulz@cherry.de>
>=20

