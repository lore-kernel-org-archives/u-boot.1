Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D7BC55184
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 09:33:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EC141405D7;
	Mon,  3 Aug 2026 09:33:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4pyzeRGrUjYs; Mon,  3 Aug 2026 09:33:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 095BD405B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785749585;
	bh=IjnPt5tLJMSt8fc0k+4Su+7MFU/oJ32slLWg+AEsVy4=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dnVSqgJctB14Zbj3v6bxe1lvgqJzTiMmyqFMHf9dVlhtfcNwyDl9X68lKzs6JiXZH
	 8deereBFDVWH7ifw6ga80IgGE64xBXArcQSOHroG79Bl6j2tneBsfQHkIymbCwEpyB
	 5viTxkU0JNylA5fNmWwfsYp0wii0t13PUy/Mdlc9REfefsNgv9PzRpUqXLpoVW7gK+
	 UqOK394vrvZithP0NqC5eAy7S35xXbvmCoUc+iIaoTiTMY9H/pbNQjy7rKKZ4U68Lv
	 hdvE1pTfzYyoKIlV9LvWW9cG2lcT1AKvHCMjzOoK23GDEVJ6T6xa7WPNRtYHSzEcSi
	 +DbvhQL6uBmkQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 095BD405B9;
	Mon,  3 Aug 2026 09:33:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0971C36E
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 09:33:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F016A405B9
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 09:33:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nKDfUfnxf9-2 for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 09:33:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org BE3FF40568
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BE3FF40568
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BE3FF40568
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 09:33:02 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4954afac04bso21976235e9.0
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 02:33:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785749581; x=1786354381;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IjnPt5tLJMSt8fc0k+4Su+7MFU/oJ32slLWg+AEsVy4=;
 b=iHOlL1PKJ8h9SEjnkgakDaax/9ykL28Tu+PQdNTLCWPAtaCS3EdpNj0bz63dmjzm5R
 QInGgHmQrQvNA2IdVZ+VADLcCvZE+HDHHZhhyiqfVBZvrJ6wQxVihBZcCTOSjk1q+mRY
 qGgLdP1mBw0Zcwj9Z0ibJOCEzdBmistA3mJY/dajHfKJq5Yim3faW3DrQnRaV2qqk7IB
 6XDsouMsklqQoeY+qGi5FIj5/lWeN09x2tqz+8LAhcYcOr18h/m0ivfkwLVJq4RdSgIE
 7iZe1oP4BYpllJdykpUwedx1ITF3ALrPsrxr0aBVg3sMwP+S4Dw0eZrBRGW+MvHI8qnT
 F0nA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoJlRrVORZa9d+V85UTBEjyJVsD2dSIyHQ43ar4b1XMkorFzoPUYrDab62rU4IC/ew20QNGFCs=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxARWU224ax5kF9EJmYI64qXEwmXjKlZCB85+TSW0P6geiWZZ8s
 3HBDB+e5phl6C/wzDkB7fT9oVBGPZOgb5YYtooZM1gROtjltWDgWFZG9tNQg7Lup2EY=
X-Gm-Gg: AR+sD13QiaHKqpMeLRbH3P1YDDsyY8P1v2nv7UtxLvpQCkpRlNWr1UjoQjtKg+QaHNY
 YFVbU1PAm1qUQme/1gHjjZc5HyX4fXT3t95xmROXteEYnwuF0nHSF1ixa9Df/FlrotVvqlah2ou
 Y7PtRnqbILFKVQOOyGBciuYo75x4kjhXa+6f/a8TzOM7J9B+lSUDV9b9nKCGhTtU1Nm+IHobL05
 b8hpnveIOveSEwwnT1hLs9FfGW04REc1xQyuyzXRgR1ETgGYcPph0jbOFHfeARw11IZhbBS+QEY
 gjVSPU0OmHPPeQkzgEkGb1l7GZCku4xFofIhwpwiaTzQ/bjUyDxXHiAqVm/QRSGbclErcrgOsux
 GlL0FpyuVKpfH5Fzb1UYjzRaI0v/aUWSv6/MyfiIOAmbbKvjKdbf7HlnosX5wM/I2OA1XbUtOi1
 yF7xFS2uHt/A/t5XTr9Mg0LGj1Xr6HJ05q7iS94IiBosx5D2EjjqP2LLzJYNNV4fR/J69smt1qg
 0llkdMRXqLo7mZWBvRgoHkC/Bo4uH1oMNsquZtWFHbNpsHRteHHvJrunevKQP2kPjbM/wubrbde
 B2hwnr1WmF+AVEqcCrBFCnu8LyHhqaKnDO1P0jVkOimv9vYoyMa1ANh+esrsoJ/aBR519/ETX6q
 k9pCCgaUGfJ9GKo6oFUmL2xmDszsTHXFV5admJTjdFCbtty6RAlW8TES0A1eu4DVTAkyX7i02Qo
 bAmy+eYKZvoJNRCFQ7Ai8f3rRQ7QUWIwQx0w5jvwm4u2g0DZV/CqvnXrsKab3ai2ft46dTj7QaM
 fW5ZxGtavBoiCJoEpXhVCoDg4GmhFv6lCTUOqM7hRGFcJbKozYn/1pdjWAeLZ21sD6ivDth5a0u
 7Efk
X-Received: by 2002:a05:600c:3b01:b0:493:f0f5:f2d7 with SMTP id
 5b1f17b1804b1-4980c66c90fmr166052115e9.7.1785749580382; 
 Mon, 03 Aug 2026 02:33:00 -0700 (PDT)
Received: from localhost ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49807b59a33sm216103715e9.1.2026.08.03.02.32.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2026 02:32:59 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Aug 2026 12:32:58 +0300
Message-Id: <DKF7E76IJ7F7.11I4JWAVP3Z4Q@linaro.org>
Cc: "Tom Rini" <trini@konsulko.com>, "Heinrich Schuchardt"
 <xypron.glpk@gmx.de>, "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
 "Kory Maincent" <kory.maincent@bootlin.com>, "Sughosh Ganu"
 <sughosh.ganu@arm.com>, "Wojciech Dubowik" <Wojciech.Dubowik@mt.com>,
 "Simon Glass" <sjg@chromium.org>, "Peng Fan" <peng.fan@nxp.com>
Subject: Re: [PATCH 3/8] tools: mkeficapsule: Enable multi-payload grouping
 in config parser
From: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
To: "Balaji Selvanathan" <balaji.selvanathan@oss.qualcomm.com>,
 <u-boot@lists.u-boot-project.org>
X-Mailer: aerc 0.21.0
References: <20260727-mkeficapsule-v1-0-5b162866b092@oss.qualcomm.com>
 <20260727-mkeficapsule-v1-3-5b162866b092@oss.qualcomm.com>
In-Reply-To: <20260727-mkeficapsule-v1-3-5b162866b092@oss.qualcomm.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785749580; x=1786354380;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=IjnPt5tLJMSt8fc0k+4Su+7MFU/oJ32slLWg+AEsVy4=;
 b=M0pBVQTKPCRObUxDofUpM/mDIfQWGYkYjy24RkgWICCw/ehdl0uGCQ2SQmGSbOuUIl
 Byf/8A6/QGj/3OuCgUxVtZF0uAJZktsGdcGdRC58yXAM8JTKvS87l66D8DNZvc85owvO
 ryRS5xBGcLytb6nAZPzxWmsbLWV3/yXbkH4Q8dTMbvjkwKkjhHyQjxQzhDHc5tvcWUip
 PU5YpD9SwSrIGgPNCztF7kBJOVsRmyP1tIyChUNlwo3Pf2iFEMCeYufLPQyF9/ek8Afe
 xZ0+qlWr+nveB6zp7TSyDTV9XDbZv29yQjI0clDfoRAGRAFGRPj8ZpOT6OjtwJO3etJw
 pgUQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=M0pBVQTK
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Mon Jul 27, 2026 at 6:56 PM EEST, Balaji Selvanathan wrote:
> Extend the config file parser to automatically group multiple payloads
> with the same capsule filename into a single multi-payload capsule.
>
> The parser now operates in two phases:
> 1. Parse all payload entries and group by capsule filename
> 2. Generate capsules based on grouping:
>    - Single payload: use existing generation path
>    - Multiple normal payloads: create multi-payload capsule
>    - Mixed/non-normal types: generate separate capsules with warning

I think we should just remote the third option and exit with an error. We c=
an't
predict all the mistakes users do and correct them

>
> This allows users to specify multiple firmware images for the same
> capsule file in the config, and the tool will automatically create
> an optimized multi-payload capsule when possible.
>
> Example config usage:
>   [capsule1]
>   image-guid: <guid1>
>   hardware-instance: 0
>   image-index: 1
>   payload: payload1.bin
>   capsule: update.capsule

Why is 'update.capsule' needed? This seems a command line option

>
>   [capsule1]
>   image-guid: <guid2>
>   hardware-instance: 0
>   image-index: 2
>   payload: payload2.bin
>   capsule: update.capsule
>
> This will generate a single update.capsule containing both payloads.
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  tools/mkeficapsule_parse.c | 115 +++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 113 insertions(+), 2 deletions(-)
>
> diff --git a/tools/mkeficapsule_parse.c b/tools/mkeficapsule_parse.c
> index 12f5f04b824..4a07006e2f8 100644
> --- a/tools/mkeficapsule_parse.c
> +++ b/tools/mkeficapsule_parse.c
> @@ -299,6 +299,63 @@ static void params_dependency_check(struct efi_capsu=
le_params *params)
>  	}
>  }
>
> +#define MAX_CAPSULE_GROUPS 32
> +
> +struct capsule_group {
> +	char *capsule_filename;
> +	struct efi_capsule_params_array params_array;
> +};
> +
> +static struct capsule_group groups[MAX_CAPSULE_GROUPS];
> +static int group_count;
> +
> +static struct capsule_group *find_or_create_group(const char *capsule_fi=
lename)
> +{
> +	int i;
> +
> +	/* Search for existing group */
> +	for (i =3D 0; i < group_count; i++) {
> +		if (groups[i].capsule_filename &&
> +		    !strcmp(groups[i].capsule_filename, capsule_filename)) {
> +			return &groups[i];
> +		}
> +	}
> +
> +	/* Create new group */
> +	if (group_count >=3D MAX_CAPSULE_GROUPS) {
> +		fprintf(stderr, "Too many capsule groups (max %d)\n",
> +			MAX_CAPSULE_GROUPS);
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	groups[group_count].capsule_filename =3D strdup(capsule_filename);
> +	if (!groups[group_count].capsule_filename)
> +		print_and_exit(MALLOC_FAIL_STR);
> +
> +	groups[group_count].params_array.count =3D 0;
> +	return &groups[group_count++];
> +}
> +
> +static void add_to_group(struct capsule_group *group,
> +			 struct efi_capsule_params *params)
> +{
> +	struct efi_capsule_params *new_params;
> +
> +	if (group->params_array.count >=3D MAX_PAYLOADS_PER_CAPSULE) {
> +		fprintf(stderr, "Too many payloads for capsule %s (max %d)\n",
> +			group->capsule_filename, MAX_PAYLOADS_PER_CAPSULE);
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	/* Allocate and copy params */
> +	new_params =3D malloc(sizeof(struct efi_capsule_params));
> +	if (!new_params)
> +		print_and_exit(MALLOC_FAIL_STR);
> +
> +	memcpy(new_params, params, sizeof(struct efi_capsule_params));
> +	group->params_array.params[group->params_array.count++] =3D new_params;
> +}
> +
>  static void generate_capsule(struct efi_capsule_params *params)
>  {
>  	if (params->capsule !=3D CAPSULE_NORMAL_BLOB) {
> @@ -324,7 +381,8 @@ static void generate_capsule(struct efi_capsule_param=
s *params)
>   * @cfg_file: Path to the config file
>   *
>   * Parse the capsule parameters from the config file and use the
> - * parameters for generating one or more capsules.
> + * parameters for generating one or more capsules. Payloads with the
> + * same capsule filename are grouped into a single multi-payload capsule=
.
>   *
>   * Return: None
>   *
> @@ -333,6 +391,8 @@ void capsule_with_cfg_file(const char *cfg_file)
>  {
>  	FILE *fp;
>  	struct efi_capsule_params params =3D { 0 };
> +	struct capsule_group *group;
> +	int i;
>
>  	fp =3D fopen(cfg_file, "r");
>  	if (!fp) {
> @@ -343,11 +403,62 @@ void capsule_with_cfg_file(const char *cfg_file)
>
>  	params_start =3D 0;
>  	params_end =3D 1;
> +	group_count =3D 0;
>
> +	/* Phase 1: Parse all payloads and group by capsule filename */
>  	while (parse_capsule_payload_params(fp, &params) !=3D -1) {
>  		params_dependency_check(&params);
> -		generate_capsule(&params);
> +
> +		/* Find or create group for this capsule */
> +		group =3D find_or_create_group(params.capsule_file);
> +		add_to_group(group, &params);
>
>  		memset(&params, 0, sizeof(struct efi_capsule_params));
>  	}
> +
> +	fclose(fp);
> +
> +	/* Phase 2: Generate capsules */
> +	for (i =3D 0; i < group_count; i++) {
> +		group =3D &groups[i];
> +
> +		/* Check if all payloads in group are normal blobs */
> +		int all_normal =3D 1;
> +		int j;
> +
> +		for (j =3D 0; j < group->params_array.count; j++) {
> +			if (group->params_array.params[j]->capsule !=3D CAPSULE_NORMAL_BLOB) =
{
> +				all_normal =3D 0;
> +				break;
> +			}
> +		}
> +
> +		if (group->params_array.count =3D=3D 1) {
> +			/* Single payload - use existing function */
> +			printf("Generating single-payload capsule: %s\n",
> +			       group->capsule_filename);
> +			generate_capsule(group->params_array.params[0]);
> +		} else if (all_normal) {
> +			/* Multiple normal payloads - use multi-payload function */
> +			printf("Generating multi-payload capsule: %s (%d payloads)\n",
> +			       group->capsule_filename, group->params_array.count);
> +			if (create_multi_payload_fwbin(group->capsule_filename,
> +						       &group->params_array) < 0) {
> +				print_and_exit("Creating multi-payload capsule failed\n");
> +			}
> +		} else {
> +			/* Mixed or non-normal capsules - generate separately */
> +			fprintf(stderr, "Warning: Cannot combine non-normal capsules. ");
> +			fprintf(stderr, "Generating separate capsules for %s\n",
> +				group->capsule_filename);
> +			for (j =3D 0; j < group->params_array.count; j++) {
> +				char temp_name[256];
> +
> +				snprintf(temp_name, sizeof(temp_name), "%s.%d",
> +					 group->capsule_filename, j);
> +				group->params_array.params[j]->capsule_file =3D temp_name;
> +				generate_capsule(group->params_array.params[j]);
> +			}
> +		}
> +	}
>  }

Thanks
/Ilias
