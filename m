Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D7A5E77188
	for <u-boot@archiver.kernel.org>; Sun, 22 Dec 2024 12:37:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1463280562;
	Sun, 22 Dec 2024 13:37:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Xx976wuT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 497128056A; Sun, 22 Dec 2024 13:37:21 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4336C80435
 for <u-boot@lists.denx.de>; Sun, 22 Dec 2024 13:37:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1734871035; x=1735475835; i=xypron.glpk@gmx.de;
 bh=2BPWvV4VxFK8Eeth/k2L8XxraFOKpLYWSSvjJX/q6ho=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Xx976wuTTyspceaWU9jG2wGXyE6PeOYZaTDZUWotPst9iBaU9g7Tbk80jOBdIZZI
 sXYMTiJxjCRAINfoPH4U4Pwr0Tr9wdegf39ngFgAMcLViF3f8xORGzix91MgmNIEO
 Fcxsj9xj/f16UOA32ZLzkKkV4ms+tdWifrg60QCVSK9X+8H0afyiBH4JAUWuTQHnV
 pxyRyycnLDQftA4LFIgYPVqQaqlBKPbRvYqVLsph46ngtohaobxYEb+ZHzj/jwH7m
 n9JhUuCA8VcSo6iu+F8Dj1IxOldAYceTTDz3bhg5cem/ObUSpK+EOpvs/23/w0U+d
 YLJDghhxdPP0sOBVyA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3KTy-1tYvaz2bMA-011l9c; Sun, 22
 Dec 2024 13:37:15 +0100
Message-ID: <542d1949-f327-4cb7-bfbf-294758b28121@gmx.de>
Date: Sun, 22 Dec 2024 13:37:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] efi_loader: Make efi_run_image() static
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List
 <u-boot@lists.denx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Adriano Cordova <adrianox@gmail.com>, Moritz Fischer <moritzf@google.com>
References: <20241219023832.1098689-1-sjg@chromium.org>
 <20241219023832.1098689-3-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241219023832.1098689-3-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:x7dhqsxemtw38dR0tZ3nWkyONvt0HYqh6ye97o8wiuo8YJYHop6
 JCQ5AZZ0yVMC8LNAFTRtS413X0Gp+8Oy77/6puWqFcGR7GrCrP1NttKxMUJXl3kdQhSrok8
 xFdhCvpnK/KwQz5h2jMH+HnDulvmCftKiiqdc4S3vKYkrcrIQpaOZ2CT0y7J1llargdUMz6
 GQ0yxxOyFkOdaYDw6vaHQ==
UI-OutboundReport: notjunk:1;M01:P0:Okffbc2Cto4=;TFIByLU/aMvGMilcCm/IweJLeHH
 OydZUZhH1XtB/x9KBl5m5TtbSEljBfjQdvVj+KLG/PDanRoxgNcAUyRaTH9atBZXBCwXcZkCm
 fFJy8lIHvzngfqRlaPOBf1mJl0qX/E4a4f7pkHLFydeoqLrlx5HwbhcbRSAyBInrhGXaQBpQb
 vvPVf/xqIPQwkSXxL+Uc0i0gRU8FzRyF+1haaidh5QmI7Z9WEfFEKb9gzoOeZ1pfr+dLGatRh
 aUYMo5e7eSF6LjeQqeW0AerW+ckTOum4zCbOUETT7+EPOv1HLAPISVmJgG8bUGtuwTj5BGflW
 inFpcfDQ7OlCc0YXlYar7ieze+lTeO3hOdz3LJVkQHKuppk0KFTwY4rLNDyOrNQvLashC+Xvr
 zpWLOGTZas24gQ2jB+U/3Z+qlMrPOr1cbSUN2kg8v32GaM4zacmCRlivUoTOAjDojHL0kRr+T
 s40QM4AWY+1UKLJHtERhq1eteJ1JaKLnBqa9vNFJNV2Dr7loQ1/Xg/pXJnHLbLseh7xsO6EM5
 /hlgfcZKkc5XqmNMgzx8iRlBFdudcJN9rq/0EHUow/4XOrbwIxjSgqRPjBcgW7McfKEFfxl3w
 HKUE52Hd0F+K35SAs99lOvVdKehO1kbAbVbRTyPphbSlkVJe2ctRQwzy3QvJhzVHOcpQCaRRQ
 e+hjIEo0SEG9YGGTW86JuYzHpw2d8E+6ImLPn3xB32yoqHk0om1ihRWsw4cZ5rtraq/D5gXle
 Cm7QdEw8jpiEtY1VSFnaVQgeG1QPGlPcz51SUH6R7obQpmuLE8nySKInBc2oWh0BRzwwdX/F7
 UQ0EfqdKdhpb16wQ9n94ICZZHE+mFCKkc6+Du8Nrw/whdYvrcmJNIAQJM7FcO2Qw9BmbmoNGW
 XoIvjsts8ct+pijm7edjuz8sn7nuxpvupjsm1a0e1ZdPqmbxiGaGq4nU6+R5impr9QpPNMaQA
 HmYXpN7+Ss6FD9kJvISa+JxP/WhoB1eStPdlW0PaKkOwP5QPHp96eGBsejxa8Hw23jtdXNDeZ
 W/nv/SL7Ojo8T5ZSj3JYbUGSRtm3DwL4fJmU58CRlE7ZBVeSYYG4umqJS0uuUZLXMnDu4YnRx
 +DrJkwlKn7pqWwGtVObvJynl6mVn85
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

On 12/19/24 03:38, Simon Glass wrote:
> This function is not called from outside this file and has no entry in
> the header file, so mark it static.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>
> (no changes since v1)
>
>   lib/efi_loader/efi_bootbin.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> index 5016ba7e225..051d86ef993 100644
> --- a/lib/efi_loader/efi_bootbin.c
> +++ b/lib/efi_loader/efi_bootbin.c
> @@ -159,7 +159,7 @@ void efi_set_bootdev(const char *dev, const char *de=
vnr, const char *path,
>    * @source_size:	size of the UEFI image
>    * Return:		status code
>    */
> -efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size=
)
> +static efi_status_t efi_run_image(void *source_buffer, efi_uintn_t sour=
ce_size)
>   {
>   	efi_handle_t mem_handle =3D NULL, handle;
>   	struct efi_device_path *file_path =3D NULL;

