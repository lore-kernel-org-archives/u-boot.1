Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B47E4C44529
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 07:54:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 318B840878;
	Tue, 21 Jul 2026 07:54:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bbb5H_3Yh6qG; Tue, 21 Jul 2026 07:54:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0078040860
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784620443;
	bh=6mulna19PUXWlQOTkpZzdB3Li2V+f0/87PaNwpKJ1gM=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=HDOCv2+GfZHZj39sPw/XffPZZFsGMIj0kVubgjGcDzG8H7x0b+fhYiV9+A8H+TDL7
	 DknuVzMhN6nHwSXsIVMbJea7oEl99qoO+brvZud73Rg+gfZ64A6uRSUjxjsP4HMF90
	 gFk62Q3fSwm1NigZCNIeiC8fcz2wZpKGvjFMQsT1/DjEecTHliI6C0BxyFUJPixk1Z
	 YEJT0j/Cj07ZlMYO9/tEFQKJ4Dr9WdXTlnbYLW92igJtNqnYUP7wW6lAvoMGzKKbbt
	 k/IJoKkf6ItUL0DcYgxs/hDny6rclV35/J8jC9JlFveAEkCqvAxacDwSyGe3iwOoSy
	 0ewPpY3oLgS4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0078040860;
	Tue, 21 Jul 2026 07:54:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id EF4131093
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 07:54:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E0D14607FA
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 07:54:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1oE9P2D-tRxe for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 07:54:01 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 864B760808
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 864B760808
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 864B760808
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 07:53:59 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3438C846A4; Tue, 21 Jul 2026 09:53:58 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53E2E849EB
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 09:53:55 +0200 (CEST)
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MkYXm-1xQLD42rrK-00ihJU; Tue, 21
 Jul 2026 09:53:52 +0200
Message-ID: <ea7db0e4-d88a-4295-9a46-f2fdb114dbfd@gmx.de>
Date: Tue, 21 Jul 2026 09:53:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] tools: mkeficapsule: Rework pkcs11 support
To: Fabio Estevam <festevam@gmail.com>
Cc: Wojciech.Dubowik@mt.com, trini@konsulko.com, u-boot@lists.denx.de,
 marex@nabladev.com, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Franz Schnyder <fra.schnyder@gmail.com>,
 Fabio Estevam <festevam@nabladev.com>, ilias.apalodimas@linaro.org
References: <20260718105627.625235-1-festevam@gmail.com>
Content-Language: en-US
In-Reply-To: <20260718105627.625235-1-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yI2i5f1YlDwG03NIAUiOt6sR5cSjmWzDb1gSRJ6wxCzWRMYrkB2
 HMs+0j0D2ka/wqTRf0Ibg36ju6K6AeDUN+4e9QkXLhPkUuC3iNzm1sEkGa7UP/H8MKZR3rN
 dHXgkrxuLM/4YaBJr5EXiN8t3fzGP5H14LRksh+Ahq8TEZJG0nZLGL2JmC4dn8NdoX85mAK
 RGp/BwwVLv2ATb4K/B9EQ==
UI-OutboundReport: notjunk:1;M01:P0:HjaJobZ+UsA=;c2jyOs1FqHqEjLcpiS01txShD9a
 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
 Mo6ipWVAr40Q5gwv/as6f4J0nBsHC/65ug==
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmx.de; 
 s=s31663417; t=1784620432; x=1785225232; i=xypron.glpk@gmx.de;
 bh=6mulna19PUXWlQOTkpZzdB3Li2V+f0/87PaNwpKJ1gM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=siMIJq760twHEBdtwO8mhHHFkFzOi7VWcrqYcGr0QDSg47WYrf4uhPXQVCNqmzm7
 CLnt39sls79jkaJMZHjhW5hsR+k5V741GEVy4YX2ejXAeOpob6C4RSD+EhJ+7ZOlE
 ryzv9VD202agDvfLcQMNrJ2klLKEURlQ7FZEt4w1aybjIn3np9PaPvGSi7yqUL9tI
 jUFGb9wN6hED2myaLLJNmYkoIW93AVZiNjcvfMNavtuVAVc0oucGXzaTE0EPy0Su6
 7BzSaiqCek2iNID3LiLa4XmMAXPEXr/SA6RY8eQBcvATHLLKn1AvpABl9qcxK4bzU
 oCBSn3P2zEIRDlugjg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=gmx.de
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmx.de header.i=xypron.glpk@gmx.de
 header.a=rsa-sha256 header.s=s31663417 header.b=siMIJq76
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=gmx.de
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=xypron.glpk@gmx.de
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="siMIJq76"; 
 dkim-atps=neutral
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
From: Heinrich Schuchardt via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/18/26 12:56, Fabio Estevam wrote:
> From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
>=20
> Some distros like OpenEmbedded are using gnutls library
> without pkcs11 support and linking of mkeficapsule will fail.
> It would make maintenance of default configs a hurdle.
> Add detection of pkcs11 support in gnutls so it's enabled
> when available and doesn't need to be set explicitly.
>=20
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Acked-by: Quentin Schulz <quentin.schulz@cherry.de>
> Suggested-by: Tom Rini <trini@konsulko.com>
> Cc: Franz Schnyder <fra.schnyder@gmail.com>
> Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> Signed-off-by: Fabio Estevam <festevam@nabladev.com>
> ---
> Changes since v7:
> - Also handle gnutls_global_deinit() and gnutls_pkcs11_deinit() - Ilias.
>=20
>   tools/Makefile       |   5 ++
>   tools/mkeficapsule.c | 111 ++++++++++++++++++++++++++++++++-----------
>   2 files changed, 89 insertions(+), 27 deletions(-)
>=20
> diff --git a/tools/Makefile b/tools/Makefile
> index 1a5f425ecda..e85f5a354b8 100644
> --- a/tools/Makefile
> +++ b/tools/Makefile
> @@ -271,6 +271,11 @@ mkeficapsule-objs :=3D generated/lib/uuid.o \
>   	$(LIBFDT_OBJS) \
>   	mkeficapsule.o
>   hostprogs-always-$(CONFIG_TOOLS_MKEFICAPSULE) +=3D mkeficapsule
> +GNUTLS_SUPPORTS_P11KIT =3D $(shell pkg-config --libs gnutls --print-req=
uires-private \

Shouldn't we throw a build warning indicating that the created=20
mkeficapsule will be incomplete due to missing PKCS11 support?

> +			 2> /dev/null | grep p11-kit-1)
> +ifeq ($(GNUTLS_SUPPORTS_P11KIT),p11-kit-1)
> +HOSTCFLAGS_mkeficapsule.o +=3D -DMKEFICAPSULE_PKCS11
> +endif
>  =20
>   include tools/fwumdata_src/fwumdata.mk
>  =20
> diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
> index ec640c57e8a..df64e1b7497 100644
> --- a/tools/mkeficapsule.c
> +++ b/tools/mkeficapsule.c
> @@ -207,6 +207,81 @@ static int write_capsule_file(FILE *f, void *data, =
size_t size, const char *msg)
>   	return 0;
>   }
>  =20
> +#ifdef MKEFICAPSULE_PKCS11
> +static int pkcs11_init(void)
> +{
> +	const char *lib;
> +	int ret;
> +
> +	lib =3D getenv("PKCS11_MODULE_PATH");

Nowhere in our documentation we describe this environment variable. How=20
should a user know what value is expected?

I guess doc/mkeficapsule.1 and doc/develop/uefi/uefi.rst need an update.

> +	if (!lib) {
> +		fprintf(stdout,
> +			"PKCS11_MODULE_PATH not set in the environment\n");
> +		return -1;
> +	}
> +
> +	gnutls_pkcs11_init(GNUTLS_PKCS11_FLAG_MANUAL, NULL);
> +	gnutls_global_init();
> +
> +	ret =3D gnutls_pkcs11_add_provider(lib, "trusted");
> +	if (ret < 0) {
> +		fprintf(stdout, "Failed to add pkcs11 provider\n");
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int import_pkcs11_crt(gnutls_x509_crt_t *x509, struct auth_conte=
xt *ctx)
> +{
> +	gnutls_pkcs11_obj_t *obj_list;
> +	unsigned int obj_list_size =3D 0;
> +	int ret;
> +
> +	ret =3D gnutls_pkcs11_obj_list_import_url4(&obj_list, &obj_list_size,
> +						 ctx->cert_file, 0);
> +	if (ret < 0 || obj_list_size =3D=3D 0)
> +		return -1;
> +
> +	gnutls_x509_crt_import_pkcs11(*x509, obj_list[0]);
> +
> +	return 0;
> +}
> +
> +static int import_pkcs11_key(gnutls_privkey_t *pkey, struct auth_contex=
t *ctx)
> +{
> +	return gnutls_privkey_import_pkcs11_url(*pkey, ctx->key_file);
> +}
> +
> +static void pkcs11_deinit(void)
> +{
> +	gnutls_global_deinit();
> +	gnutls_pkcs11_deinit();
> +}
> +#else
> +static int pkcs11_init(void)
> +{
> +	fprintf(stderr, "Pkcs11 support is disabled\n");
> +	return -1;
> +}
> +
> +static int import_pkcs11_crt(gnutls_x509_crt_t *x509, struct auth_conte=
xt *ctx)
> +{
> +	fprintf(stderr, "Pkcs11 support is disabled\n");
> +	return -1;
> +}
> +
> +static int import_pkcs11_key(gnutls_privkey_t *pkey, struct auth_contex=
t *ctx)
> +{
> +	fprintf(stderr, "Pkcs11 support is disabled\n");
> +	return -1;
> +}
> +
> +static void pkcs11_deinit(void)
> +{
> +}
> +#endif
> +
>   /**
>    * create_auth_data - compose authentication data in capsule
>    * @auth_context:	Pointer to authentication context
> @@ -229,9 +304,6 @@ static int create_auth_data(struct auth_context *ctx=
)
>   	gnutls_pkcs7_t pkcs7;
>   	gnutls_datum_t data;
>   	gnutls_datum_t signature;
> -	gnutls_pkcs11_obj_t *obj_list;
> -	unsigned int obj_list_size =3D 0;
> -	const char *lib;
>   	int ret;
>   	bool pkcs11_cert =3D false;
>   	bool pkcs11_key =3D false;
> @@ -243,19 +315,8 @@ static int create_auth_data(struct auth_context *ct=
x)
>   		pkcs11_key =3D true;
>  =20
>   	if (pkcs11_cert || pkcs11_key) {
> -		lib =3D getenv("PKCS11_MODULE_PATH");
> -		if (!lib) {
> -			fprintf(stdout,
> -				"PKCS11_MODULE_PATH not set in the environment\n");
> -			return -1;
> -		}
> -
> -		gnutls_pkcs11_init(GNUTLS_PKCS11_FLAG_MANUAL, NULL);
> -		gnutls_global_init();
> -
> -		ret =3D gnutls_pkcs11_add_provider(lib, "trusted");
> +		ret =3D pkcs11_init();
>   		if (ret < 0) {
> -			fprintf(stdout, "Failed to add pkcs11 provider\n");
>   			return -1;
>   		}
>   	}
> @@ -301,14 +362,12 @@ static int create_auth_data(struct auth_context *c=
tx)
>  =20
>   	/* load x509 certificate */
>   	if (pkcs11_cert) {
> -		ret =3D gnutls_pkcs11_obj_list_import_url4(&obj_list, &obj_list_size,
> -							 ctx->cert_file, 0);
> -		if (ret < 0 || obj_list_size =3D=3D 0) {
> -			fprintf(stdout, "Failed to import crt_file URI objects\n");
> +		ret =3D  import_pkcs11_crt(&x509, ctx);
> +		if (ret < 0) {
> +			fprintf(stderr, "error in import_pkcs11_crt(): %s\n",
> +				gnutls_strerror(ret));

So here you are printing in sequence:

"Pkcs11 support is disabled\n"
"error in import_pkcs11_crt(): %s}\n"

This message would better be thrown in the functional version of=20
import_pkcs11_crt(). For a user of mkeficapsule the function name=20
import_pkcs11_crt() is irrelevant. Instead, please, describe that the=20
import of a PKCS11 certificate failed.

>   			return -1;
>   		}
> -
> -		gnutls_x509_crt_import_pkcs11(x509, obj_list[0]);
>   	} else {
>   		ret =3D gnutls_x509_crt_import(x509, &cert, GNUTLS_X509_FMT_PEM);
>   		if (ret < 0) {
> @@ -320,9 +379,9 @@ static int create_auth_data(struct auth_context *ctx=
)
>  =20
>   	/* load a private key */
>   	if (pkcs11_key) {
> -		ret =3D gnutls_privkey_import_pkcs11_url(pkey, ctx->key_file);
> +		ret =3D import_pkcs11_key(&pkey, ctx);
>   		if (ret < 0) {
> -			fprintf(stderr, "error in %d: %s\n", __LINE__,
> +			fprintf(stderr,	"error in import_pkcs11_key(): %s\n",
>   				gnutls_strerror(ret));

Same here.

Best regards

Heinrich

>   			return -1;
>   		}
> @@ -403,10 +462,8 @@ static int create_auth_data(struct auth_context *ct=
x)
>   	 *   gnutls_free(signature.data);
>   	 */
>  =20
> -	if (pkcs11_cert || pkcs11_key) {
> -		gnutls_global_deinit();
> -		gnutls_pkcs11_deinit();
> -	}
> +	if (pkcs11_cert || pkcs11_key)
> +		pkcs11_deinit();
>  =20
>   	return 0;
>   }

