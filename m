Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C82CCC282EC
	for <u-boot@archiver.kernel.org>; Sat,  8 Mar 2025 05:11:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DB8D80540;
	Sat,  8 Mar 2025 06:11:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="U8ZBaOF+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E242806FC; Sat,  8 Mar 2025 06:11:35 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1886D8003E
 for <u-boot@lists.denx.de>; Sat,  8 Mar 2025 06:11:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1741410691; x=1742015491; i=xypron.glpk@gmx.de;
 bh=tcv5S56Vu6d3/EDysLD6TUQEzjO5CS66bWAxomwnYNI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=U8ZBaOF+B3ng29uwIZ3XKvgqlEmDA9n6bEFJC9xCQkxLeJOJ+cTcBp7zNr3m4Suz
 GMRqJO+NKQX0vt4cJ+O/+GXig3zQ47DDax/aZrAQdgRncH5VuDE0D2/51NPGKj1wE
 26LiP3dcunz3ULdJa0JD0I3P1jBo9z6/p7HDqqbP+us4oKC0P/i54hu3+jY/4mImK
 pgqGA8xfv9bhAzeYwVoJ60NqLSJDkOO6S5Vt7f4xzJWP5i+qmDACaCgEUWRzAjYuY
 KtRPYQmDgW6uBXceN9xC2zgYI0O3JSF25CXaOM4uQ3iGxXX9C+MVN59rCYuFeN88H
 X21EsLA58juf9XN24w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.111.115]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8GQy-1tCzhb1a5o-00qrzP; Sat, 08
 Mar 2025 06:11:31 +0100
Message-ID: <c2ec9cf9-75fd-4f2e-9c0a-16269e42d148@gmx.de>
Date: Sat, 8 Mar 2025 06:11:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/29] bootstd: Correct display of kernel version
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20250306002533.2380866-1-sjg@chromium.org>
 <20250306002533.2380866-8-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250306002533.2380866-8-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Yg/txxjebRz2OKd3BRWWrTOZ0addsFw2wYjsxahy5IIJBsbr8tf
 BOo6gotoa2tw4PRgMFaMxvVLuaGgSvkNzi8VlqZ7L5fEryR4H41aMRrDeHE6OwyX+glsa0B
 gbvz1N0+KX2DxFbYDLagfqLozDTtA/jv8p6v/SesWHckUQLXsrUIy291QHLW+vNLh7XIdIU
 3yeh2qgWV+AUvIJ2F3SOA==
UI-OutboundReport: notjunk:1;M01:P0:p+/Au46unqg=;UGmpFU2gJzoVMJ0DOWK8vSqR8+5
 miUGbeTYMwlKc93/zFx3/VaH4IwXagPdEueYxEgzDZx/RnZBo/bt3mHb6ndREgH1nV12q0Ky/
 SKWcYUUPwVtDu+zAkZ+lkqNS/ne71bIQE065Wy82CNum8B54sehgcFCXk4eADRh5cNbgu1YXM
 0zbWJD9LIAahuZsLIsSDIglAn3H2oe1tZorwy1l+IveDDKrextZZOg6tUq8Wvum3kuOpuIhKC
 HFFhKGJroiufy6zpnRsVC40A8j8OJ7vxXLsT7fbON8d92g4Se2nFz2YKDvgXfVMj7VR1rwnIg
 YuqRWae2p7W+oacGKz3AFT0xaoZKhXlsJae4ilnl59Sc1tMuijGHGKR/s/rhVvSAjsmuzYWGX
 tkuzjwBukqy1e9iDGYPrN6mBuy2/PnYfMuEdrsoALaq/3rLG2SntNXnY7W22EVF5inyyua1ES
 arfob8yxm3uJcbBbMXkV31EOtQv/RNvgzIazRsVErByGZUGjiRrIx1IBIII59j9OZYLg/p2hc
 7rRMxRsAXm2DBIql0eailruEo/OlP6HCc0F+4fGyU8xHavQfvN2tWVGCZ5e43HeO76iQ1J0Op
 PsrIiD9JxWPElS/89fjjwuUQslhU7b224sAOfG7yymk7DPfkwKtRsIn20IWjr94o1RidKyJVh
 nFZs8yN612+FVSogwZC7w9nPGIvTOT8LO0YaqCMcJeJCT8N5xbv9rRwh1WvMYYxfF9dQmXYl+
 RhiUBKCEi5p5bmh8iX9LEJ+vevLHak/JNvFiFJpqeahuUfeAfXDSA1kKmJ24+7bfx7nBmt4qd
 Z0ObqCb51haS43pEy4Bl2BiaitHBdoeoB/BksNYuSM/adRZgVYd8bULvKRdE6tEV9xNX6xrKx
 G7EjYntgtWtDuDSgyOeKlMFh6TODy36D+qnYInVQAE+ajSc8j/az4DmDtXV3jxYNbbgmU7mX2
 Kx9z+CkXA4Sx3Jh7SsUpw5xiAUB+z1/W0Bz7XgWG3a2Ky2glasJmOkgsxp3neJQbhboix4awW
 EV5vrS3iDA01h53o67iqnUgPRE0hpV3MJVD1lfwrL2eKvjjOf//7rXtm2RvhQW1qswagHcAI2
 1sU22l2UjgNPrJUQKadeAi/JYRwdTD779rgOKglXCrs7luooeT+sZfWPGPGjuhlAD5vaoXJgm
 Wws/bQy7lJObWG4rxpXO3Ha+nhHCsSt8calFrDMm8WSRrX5v1iQwZ3tz0/JbAtdbG5pdwfgaf
 y0hBNhvIKyoK/En6DYkYJ5IhrMQuO3rRfIQDhju/6q9gkaaO0DlcZdTfio095hv/t3ciTKxic
 gfiEu4qGsxF2eT5QepxjJk4DA0G5CzIIMMWNRPVP/7OVGaHcg0P1cOq9ER9Or7XXoIfeQNzF0
 XrYZYj+W0EdImvXIAM+NMKLZaoUidbMxNc1pA19w1yOvprINDvLpeUBL/G7lHZzmbtTYV0CoZ
 luyozNw==
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

On 3/6/25 01:25, Simon Glass wrote:
> The address of the bzImage is not recorded in the bootflow, so we cannot
> actually locate the version at present. Handle this case, to avoid
> showing invalid data.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>   arch/x86/lib/zimage.c | 13 ++++++++-----
>   cmd/bootflow.c        |  2 ++
>   2 files changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/lib/zimage.c b/arch/x86/lib/zimage.c
> index 7f4b117b403..d71285e71d9 100644
> --- a/arch/x86/lib/zimage.c
> +++ b/arch/x86/lib/zimage.c
> @@ -558,7 +558,6 @@ void zimage_dump(struct bootm_info *bmi, struct boot=
_params *base_ptr,
>   		 bool show_cmdline)
>   {
>   	struct setup_header *hdr;
> -	const char *version;
>   	int i;
>
>   	printf("Setup located at %p:\n\n", base_ptr);
> @@ -595,10 +594,14 @@ void zimage_dump(struct bootm_info *bmi, struct bo=
ot_params *base_ptr,
>   	print_num("Real mode switch", hdr->realmode_swtch);
>   	print_num("Start sys seg", hdr->start_sys_seg);
>   	print_num("Kernel version", hdr->kernel_version);
> -	version =3D zimage_get_kernel_version(base_ptr,
> -					    (void *)bmi->bzimage_addr);
> -	if (version)
> -		printf("   @%p: %s\n", version, version);
> +	if (bmi->bzimage_addr) {
> +		const char *version;
> +
> +		version =3D zimage_get_kernel_version(base_ptr,
> +						    (void *)bmi->bzimage_addr);
> +		if (version)
> +			printf("   @%p: %s\n", version, version);

I cannot image that a user cares about the location of the version
string in memory.

If this is an information is really needed by developers, please, put it
into a log_debug() message.

Best regards

Heinrich

> +	}
>   	print_num("Type of loader", hdr->type_of_loader);
>   	show_loader(hdr);
>   	print_num("Load flags", hdr->loadflags);
> diff --git a/cmd/bootflow.c b/cmd/bootflow.c
> index 72b06a42e4d..da17fd93b8b 100644
> --- a/cmd/bootflow.c
> +++ b/cmd/bootflow.c
> @@ -383,6 +383,8 @@ static int do_bootflow_info(struct cmd_tbl *cmdtp, i=
nt flag, int argc,
>   		struct bootm_info bmi;
>
>   		bootm_init(&bmi);
> +		/* we don't know this at present */
> +		bootm_x86_set(&bmi, bzimage_addr, 0);
>   		zimage_dump(&bmi, bflow->x86_setup, false);
>
>   		return 0;

