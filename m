Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8EB0C71145
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 05:37:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7351586542;
	Thu, 24 Aug 2023 07:37:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="RAHcJBUp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF7DD8653D; Thu, 24 Aug 2023 07:37:22 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60DAD86547
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 07:37:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1692855439; x=1693460239; i=xypron.glpk@gmx.de;
 bh=ODeL03f7Cpnnr4T5vC6co3QpMFMMNTfmBaH2bS+dqos=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=RAHcJBUpVeYbWGGadnqJoB+/jjUj4i4f/7lxaQA3lxknAbadGY/KGXMTfJGMN13QbT0N1Ro
 FFDbBoQw629Vr89QPhgvAoGCvds80oJdKJIPn07QRd/djJHAmVZWz4/w0biZdDMxG8V7L8rdK
 4ONFZB9dtW5B9fxLEP/WN/KSSlemvnP61KWk3G9rG2Q1dyJzad+OguAlXvm8asSkkdUfyXoam
 EVSrJshUZQNbw4P+SKWivML1lbuVMMD/IvzVgnRkLaONTqll7zl1DJLsoIOzkl5uNlmdVpu6T
 GCP/1HZSsowLN/DIYezARAaZB5yl11Bbj4Ud10TyBvohZR+5+e9g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([62.143.244.162]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N95e9-1pcFgm14rP-0166wT; Thu, 24
 Aug 2023 07:37:19 +0200
Message-ID: <ff697396-ce30-e6c3-b7fa-5aac053dec4c@gmx.de>
Date: Thu, 24 Aug 2023 07:38:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] cmd: efidebug: add uri device path
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20230823083721.1318097-1-masahisa.kojima@linaro.org>
 <20230823083721.1318097-2-masahisa.kojima@linaro.org>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20230823083721.1318097-2-masahisa.kojima@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gFwTVcPWtQipUhys194vNX0bKDDvOZRdoEhEMa594NKvAcAQ3JG
 q396anhnuh0qVvpt6dqIFC4GI3IKL6pnLTxB5IHqKfGg5VjOkZyGaCk4H9YIN1LM8y8LkTi
 o6QswKlLLnug7W+VTp4UK/o3nTuf8/W0OKlAYuP+VpELTXkyjhRhdPP+2Y9muhp3dnnHewi
 2EknoOzrhnU00k9CTPhIA==
UI-OutboundReport: notjunk:1;M01:P0:pD2EzD+RQo8=;9u2/GqFhGyQ9hw46ShVFPeIzqIl
 4Pkd0LmiO1Bf6RBpfM5Q6bddnAo3+SsS2GCNDXuvVTcXZSTeZ6dk0a3QOEHaw1yBMc+Ibx6Z/
 mzWHgKLI30BtENnd2UDhxcMn1Sw/l+bCDpwXxeXAoi7WFLr2nrLiQV5I3Pu5yh0TUqVZRkPPX
 Efk3Ze6+K3ZWo8Cl3OyClsrCsDSfe/9/4P+LNsyWPWJ/DydnNB0UYj8auBIaaCW+2BDgb+O6I
 EeUgwZmaQyd46ZvTSGLvSnLASIPatGe97AW5lCwgc2jJSHFRlVMNNbeHjXsZ8JW5Xks663h0b
 oYF3C1CQjvjoQKy+8i+0Cpt8q9b7VOW4pjycTDl/9U0FmDtlgfYaWwa9fbN9LLASR890KrC7r
 XaBt2P9T0kJKIGF8hQ85mGAFqKANWbn9ld23iZXTRfJViP5oSxZpeARaxKULjadVMlwO1c1kD
 SBNOodOvHuejcSbrVobZ0xVauU8smVFcIG9O7cYgbQ7gy+cWMj0f+/I0khR/6V5sdPHCQ4Otl
 lkwqTh4Lgabhae9qJtWkZg6EFoicbaDla//e8KwhHYax2HL6AwrbDi4E58E+5Pl+3m+cmO8NH
 XP6iDKm0oBjnDcq1oTtj8I1FmHhuO99tgq6DyFmTL2bGBE6XbG4fMea13IUMGbkbi4J/su1E7
 avLd9kI4HhjFNy615aQSuTXpSWruHaN8J4uOPZoGTwqOCZhTZCH6vkUG2LYyN0xtWpO+zG4yb
 zYWo1bCeOx8YDEFHwfkKjkDTX8GIjiu+mJJ8Vw4R+O85X1ZrC8QS5IGL83JoA9TzMoNfYBuqo
 2+a8uOBBvuvBc5KkASlnSBumW2nzFNKA2KU3mToka30eKH8LMO2bKXbeavfCSI8JlvyHlzyY7
 2r4Rn5rZ2va3W//0XoJb33U8tM+ObrfoiGkIvnvZyihFR1liqfisdPuE2VvicnJl+Vvs70xEs
 aJ/OhEg6CVGL1vM1hWdtcHNzvkI=
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

On 8/23/23 10:37, Masahisa Kojima wrote:
> This adds the URI device path option for 'boot add' subcommand.
> User can add the URI load option for downloading ISO image file
> or EFI application through network(e.g. HTTP).
>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> ---
>   cmd/efidebug.c | 39 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 39 insertions(+)
>
> diff --git a/cmd/efidebug.c b/cmd/efidebug.c
> index 0be3af3e76..62f867df2a 100644
> --- a/cmd/efidebug.c
> +++ b/cmd/efidebug.c
> @@ -829,6 +829,44 @@ static int do_efi_boot_add(struct cmd_tbl *cmdtp, i=
nt flag,
>   			argc -=3D 1;
>   			argv +=3D 1;
>   			break;
> +		case 'u':
> +		{
> +			char *pos;
> +			int uridp_len;
> +			struct efi_device_path_uri *uridp;
> +
> +			if (argc <  3 || lo.label) {
> +				r =3D CMD_RET_USAGE;
> +				goto out;
> +			}
> +			id =3D (int)hextoul(argv[1], &endp);
> +			if (*endp !=3D '\0' || id > 0xffff)
> +				return CMD_RET_USAGE;
> +
> +			efi_create_indexed_name(var_name16, sizeof(var_name16),
> +						"Boot", id);
> +
> +			label =3D efi_convert_string(argv[2]);
> +			if (!label)
> +				return CMD_RET_FAILURE;
> +			lo.label =3D label;
> +
> +			uridp_len =3D sizeof(struct efi_device_path) + strlen(argv[3]) + 1; =
> +			fp_free =3D efi_alloc(uridp_len + sizeof(END));
> +			uridp =3D (struct efi_device_path_uri *)fp_free;
> +			uridp->dp.type =3D DEVICE_PATH_TYPE_MESSAGING_DEVICE;
> +			uridp->dp.sub_type =3D DEVICE_PATH_SUB_TYPE_MSG_URI;
> +			uridp->dp.length =3D uridp_len;
> +			strcpy(uridp->uri, argv[3]);

This assumes that argv[3] is a valid URI.

Would it be preferable to validate that the string is percent encoded,
conforms to RFC 3986, and contains a supported scheme, an authority, and
a path?

As a user I would like related errors to be caught at entry and not at
runtime.

Best regards

Heinrich

> +			pos =3D (char *)uridp + uridp_len;
> +			memcpy(pos, &END, sizeof(END));
> +			fp_size +=3D uridp_len + sizeof(END);
> +			file_path =3D (struct efi_device_path *)uridp;
> +			argc -=3D 3;
> +			argv +=3D 3;
> +			break;
> +		}
> +
>   		default:
>   			r =3D CMD_RET_USAGE;
>   			goto out;
> @@ -1492,6 +1530,7 @@ static char efidebug_help_text[] =3D
>   	"  -b|-B <bootid> <label> <interface> <devnum>[:<part>] <file path>\n=
"
>   	"  -i|-I <interface> <devnum>[:<part>] <initrd file path>\n"
>   	"  (-b, -i for short form device path)\n"
> +	"  -u <bootid> <label> <uri>\n"
>   	"  -s '<optional data>'\n"
>   	"efidebug boot rm <bootid#1> [<bootid#2> [<bootid#3> [...]]]\n"
>   	"  - delete UEFI BootXXXX variables\n"

