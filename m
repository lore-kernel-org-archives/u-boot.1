Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62AE9EDF159
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 12:41:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3C1A83CB5;
	Fri, 13 Feb 2026 13:41:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zLwCLE2r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C24C83CBD; Fri, 13 Feb 2026 13:41:38 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E15883C4B
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 13:41:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4806f3fc50bso10574675e9.0
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 04:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770986495; x=1771591295; darn=lists.denx.de;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8jrZNRqYHh7yePWWjIbyFTDhzZZHMLWFNHaYgoZn5Rk=;
 b=zLwCLE2rOGPmTamd4EPp1vTUYFDTdUAURXqP1y5kINK6XtVc/rFB8TplrK6/8PmrtJ
 /Br9uTgrru8qKiAKf8qEey6f0SXOnIvr1azvYGx6sZDcC9Mw5SHNI3hddbEZv9yf4g8u
 dKa7O03GmIU6ecTD15CRNuAwrInWB0zNSxEjm+VoLbIeflJP+5E2chJzDrRSy12S8DZx
 baQuVm744Bz3yReqz32aY2qxQuMh99gC4YLYl7+WLY1gU6DWyWU28u1h0kHnVst7+nDj
 EgaWXDaVroMUOaOmCfb930qzeg5gWMkW9eAmGnPHrd5nCESBJ1bAGgj5NsCCl0/BHasD
 t1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770986495; x=1771591295;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8jrZNRqYHh7yePWWjIbyFTDhzZZHMLWFNHaYgoZn5Rk=;
 b=B3rxuznGR3pIoTZsCkfX1nBedIxLxbQ3KrCXOAilmowaAEp+/Wnnt1vRSt4qzNy0hX
 QRg1aETIogjnNecgETm1K+L8A5J1xiDtWNl7BlCb9xlLcr154OIy1RFSCuctDuA2QL+F
 Zs2tpk+n4K0Q4edRet2LIckfjFdxIGCCVQxCzu5h3EACAUw4aq5GKQAYZbz2ksDZD5oC
 EilEcPNkhLbm7BERpfn3lbhOSRtlYu7qBPDtJ2ksjkQSot6BqV9rZT1+skewWG2gaxz/
 FZjcOMbLolB5ElH2FqCr8/dkzf97f5Q5onXnNi+b0ahOkxSSO4D3SDB/72uMQVm3yn1Z
 xKxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZNxf/HtviQUDkwtChsrVNwo0lRMLfU3tVCfGkomS+08ROqBiHu/jHnIPbT3N1gLuDuGqiT18=@lists.denx.de
X-Gm-Message-State: AOJu0YwkeE4NGpMoB8XZLNonZpBDnqERpnbi4MSsYHl2g98JX/dHcomy
 WWlwmK1P1jsohept7Dv+gsrSrKaSkqSsKuP5MWSDRcu14FNkFt1xybZ+jijYA+hKZ+I=
X-Gm-Gg: AZuq6aID/8c6BUOHyvPXp1Dy+FyUAxIaUO6hM2eO5972rdQE83A+RxtBZFMCjLLwDJ7
 Hrn1DSj90hzBnAHU+tIGAtQLQyyJLgNtFXmR/DRAdgW7BrIpjQuOBOS3KMVh+Byp6iRz+FqF48D
 mm26u2X9CzYzDKvuLIpv6C/tySTounRTJZ+5DgP82l1qLfEGaoxwTWWUWlVbVc6gpk2Zck6Lw1+
 jErZ0FlyfyUmE55jDqnVkeLasK71FhGekYlVr4aSWIQ9J4aE5BIJya8DD0Jc/LhRdi1XHphX91H
 nhh/9YZ/hX8yleCUH/Alf+j34VKwy+iyP4+my7CvM5crgDuu21V5YMimtpcA+Js9dq36qrkAMNY
 F8WQUnGSzn4Snjv6L9V+tPFUQzoQbdB+eZ9fc+58iMbIstLuOEJN4MYLnPb+LnPxGV/olkur93I
 2lH5r25mRQ0RMe4J6oxBokQzjqeA9Leka8sdEf/4hYN7U0InCfz1CRgArsNJ6FbrlYJty1cSj9v
 3LiNHpZc4yx/M1YPrbJ++dmv9nYh1OJYgwDXeth2YRJRhlV8eYlFAOBnSSuLLvNWol9LB99ithC
 cpxIPTVfbkW37aR7D1uZCMYl+hpa0QX7vE2ArRSkK5y05ScdX5Zm9BEEpWXIzo3aVZ3jwLG4M89
 rIgkrPe6dL/IjKDHKpnsg6J4X9DIpRKOQgDZPwIn0u6TsKnknM/j6runoQ4ogcwUXJL41u1Qcqz
 TzjehGb8bYZr53/Cwkps6GZ+SnDkTQ6mpYElqRr1boHjVvb+JQzRXk9ILk8bk3eYUkcIE=
X-Received: by 2002:a05:600c:3f0b:b0:46e:4b79:551 with SMTP id
 5b1f17b1804b1-48373a74705mr31541835e9.31.1770986494556; 
 Fri, 13 Feb 2026 04:41:34 -0800 (PST)
Received: from localhost ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48371a420b1sm15477465e9.28.2026.02.13.04.41.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Feb 2026 04:41:34 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Feb 2026 14:41:33 +0200
Message-Id: <DGDUBFBIMGND.1KJ36N75D9HOD@linaro.org>
From: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
To: "Wojciech Dubowik" <Wojciech.Dubowik@mt.com>, <u-boot@lists.denx.de>
Cc: <trini@konsulko.com>, <simon.glass@canonical.com>,
 <quentin.schulz@cherry.de>
Subject: Re: [PATCH v5 3/6] tools: mkeficapsule: Fix dump signature long option
X-Mailer: aerc 0.21.0
References: <20260128080515.1275941-1-Wojciech.Dubowik@mt.com>
 <20260128080515.1275941-4-Wojciech.Dubowik@mt.com>
In-Reply-To: <20260128080515.1275941-4-Wojciech.Dubowik@mt.com>
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

On Wed Jan 28, 2026 at 10:05 AM EET, Wojciech Dubowik wrote:
> Only short option has been present. Also rename dump_sig
> to dump-sig to match with other parameter names.
>
> Fixes: 16abff246b40 ("tools: mkeficapsule: add firmware image signing")
>
> Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  doc/mkeficapsule.1                 | 4 ++--
>  tools/binman/btool/mkeficapsule.py | 2 +-
>  tools/mkeficapsule.c               | 3 ++-
>  3 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/doc/mkeficapsule.1 b/doc/mkeficapsule.1
> index a726149ba2ce..d6653ec42472 100644
> --- a/doc/mkeficapsule.1
> +++ b/doc/mkeficapsule.1
> @@ -121,8 +121,8 @@ Specify a monotonic count which is set to be monotoni=
cally incremented
>  at every firmware update.
>
>  .TP
> -.B "-d\fR,\fB --dump_sig"
> -Dump signature data into *.p7 file
> +.B "-d\fR,\fB --dump-sig"
> +Dump signature data into <capsule-file-name>.p7 file
>
>  .SH "GUIDGEN OPTIONS"
>
> diff --git a/tools/binman/btool/mkeficapsule.py b/tools/binman/btool/mkef=
icapsule.py
> index f7e5a8868495..f2ac654db81e 100644
> --- a/tools/binman/btool/mkeficapsule.py
> +++ b/tools/binman/btool/mkeficapsule.py
> @@ -16,7 +16,7 @@ Options:
>  	-p, --private-key <privkey file>  private key file
>  	-c, --certificate <cert file>     signer's certificate file
>  	-m, --monotonic-count <count>     monotonic count
> -	-d, --dump_sig              dump signature (*.p7)
> +	-d, --dump-sig              dump signature to <output file>.p7
>  	-A, --fw-accept  firmware accept capsule, requires GUID, no image blob
>  	-R, --fw-revert  firmware revert capsule, takes no GUID, no image blob
>  	-o, --capoemflag Capsule OEM Flag, an integer between 0x0000 and 0xffff
> diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
> index a61557b73bef..e9b9ffe9b774 100644
> --- a/tools/mkeficapsule.c
> +++ b/tools/mkeficapsule.c
> @@ -56,6 +56,7 @@ static struct option options[] =3D {
>  	{"fw-revert", no_argument, NULL, 'R'},
>  	{"capoemflag", required_argument, NULL, 'o'},
>  	{"dump-capsule", no_argument, NULL, 'D'},
> +	{"dump-sig", no_argument, NULL, 'd'},
>  	{"help", no_argument, NULL, 'h'},
>  	{NULL, 0, NULL, 0},
>  };
> @@ -83,7 +84,7 @@ static void print_usage_mkeficapsule(void)
>  		"\t-p, --private-key <privkey file>  private key file\n"
>  		"\t-c, --certificate <cert file>     signer's certificate file\n"
>  		"\t-m, --monotonic-count <count>     monotonic count\n"
> -		"\t-d, --dump_sig              dump signature (*.p7)\n"
> +		"\t-d, --dump-sig              dump signature to <output file>.p7\n"
>  		"\t-A, --fw-accept  firmware accept capsule, requires GUID, no image b=
lob\n"
>  		"\t-R, --fw-revert  firmware revert capsule, takes no GUID, no image b=
lob\n"
>  		"\t-o, --capoemflag Capsule OEM Flag, an integer between 0x0000 and 0x=
ffff\n"

