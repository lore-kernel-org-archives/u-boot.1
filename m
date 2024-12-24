Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25AE7E77188
	for <u-boot@archiver.kernel.org>; Tue, 24 Dec 2024 20:58:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DE228074B;
	Tue, 24 Dec 2024 21:58:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="eYH7+sOF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60BA0807A7; Tue, 24 Dec 2024 21:58:44 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D04480711
 for <u-boot@lists.denx.de>; Tue, 24 Dec 2024 21:58:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1735073905; x=1735678705; i=xypron.glpk@gmx.de;
 bh=ZAg5ju1Y/P6FdyfSGRu3ibCrNRreEzSlUeOYVjXaEuY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=eYH7+sOFMj+1387r3KH6FMwwn9DIHfy/U9391MpGw60jCrKK9ok1LoJ9yNEXj2iK
 /5mDkEgVN/QwFPtdt5Di/4eso+KCpmLMHQoyW6TXnVJf0GsZZqTgGAqzxu0Zjp41W
 wt1KQNmXSi0X9HnO4pt5EQcY0gTVdgrdYl0urc8iCo6YIRKCXp87MkiSHX7g0EUaL
 P+1xstSMBxjoDDKsXxFZlHnqn7iHikNnYofGJNrJRXEN0bSx68JlrhL+uIi1XQFr0
 iFjReuVj5QJ6KncRJUL416eZ0dP8eJEgxaV3hQmqcwHMzokLAEgL1vv44581IFD+B
 4+9QzWIKHPzNcoyMcQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5VHM-1taqEd0LNK-00t7Gb; Tue, 24
 Dec 2024 21:58:25 +0100
Message-ID: <867fd132-cb0a-42d0-b3af-6e70d9222bed@gmx.de>
Date: Tue, 24 Dec 2024 21:58:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/11] efi_loader: Don't warn if the TCG2 FinalEvents
 table is not installed
To: Raymond Mao <raymond.mao@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Tim Harvey <tharvey@gateworks.com>,
 Simon Glass <sjg@chromium.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Eddie James <eajames@linux.ibm.com>, u-boot@lists.denx.de
References: <20241224160118.675977-1-raymond.mao@linaro.org>
 <20241224160118.675977-2-raymond.mao@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241224160118.675977-2-raymond.mao@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XlBEkAzqT6SAX39HQieLPXfK94NbEMLnd6pYgXp44G7YHTdX1KW
 tOrmCMFgq0lqUQJgd+i01tkmNnMYYtpoIocNHkpcMht/shfmVk46uSlENVkSorYOE9g6iJ7
 r4gqwvTEys+dzlsRfIP401b5Zh8GmEn8rPtHFLYA2QABDT22w7m6Ee3oT/eYxg0o3tAkT+6
 dznJY286bzxkLDIvYj2mQ==
UI-OutboundReport: notjunk:1;M01:P0:wZJpkYo5eOw=;B9p7EFKBLkLon1ZrxiXgjDC131j
 rH+yO/Mt+bdsHZLMY+sFhQPP2hJlIUeyAbeWagPoppYeJmVKupnxdIKdYAccBTbtVrrOkwego
 POyXXjsGwaRoHHaqyMRb/Fvp3vIy9bvCF8XkJAVAJMYAnpdjRRINSwVoKQud2ztvDGt2WjSTk
 DOCQ4EpJEq3AoxNII1/opJRl60mA88ff4zKwZm3kRXQBtjJUVaUlKOIr65I5LJ2ZuhFsqPlgz
 9LyDD8q61RtH7Z2bVDbSpGHZlO1/14Muy/eVUkNTxp7dA/Uobc6HQ4I71n8BAx9B1r0OzEKua
 GITirXrp4TKVXkpmWnSRyO8b5lLp7OtfJTOTt3L9TTjayKvVwCmQ7hh4eSVSqQd01G/0STuXK
 07fsnfn+TuL4GJ7TaqC7bAvNvEk9vlvCtR8MbvnMXL07uE5HkW+8oJu+/7zlFM9mb1gHPxCjn
 F8N1aT18hrJb5srRHbKpgLHkITCNY6NtLwvquZTrVBGM7g+WqWuyp0K38/H0Z2G8ujN81qsU4
 hbt46F+pxBMABEUgNnliGiJxrE3kK8rbjG7YuZKBuORYzneUfI5DmE8RULKr2ZV0HEgmr8u//
 ZIhoDSz9rQn9E8cQeO3E9QVYjXoIv0TK6+VIUuoR+6sjKNKvsReLZNTX1znJuyK/66Hps+UKq
 Fa/9SavIdsS3yWzxpmJ7w5DePAwzWTVa69PRduFuBpip55XcvLoSEuvgMLpRQe8Rv6VINpTfb
 2jWpDbCtldV9Itmui7tDe1fJ6PzxpsVmXm4l+vVIdP14wR0luL/RbidJX8L/SnXu1sXqUkFRj
 kT68I9Uhx2gJ6XV71ha717I+Ug2rAbTQdQsSNB3bCj6kQaRA+IW/0Jcgj6+TKaTG+5GtaY0Ui
 TOaGjifpzMF19ncPwHhdZ1tkGyfMzU9L1fUmJ6O3FmIG2Vag9GZm5H8s8iCECPsZXzHJEN87f
 7Z9WO0KBvS3gcuxX8iS/xk1tQ5jXfsSJKAvUtBzxvXJklz2hcU05NCHyXWHO//G2z2H8H+Uft
 48Udi8cg6i5vBwT2+wffnQSo2pVjGuVVFzwhSG1BcLFuToAkay9CXtkkvF7kaMBAV8/zq+Bmw
 91KBLxEidJYxikXUP0vETJasxIeuMG
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

On 12/24/24 17:01, Raymond Mao wrote:
> From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> When the TCG2 protocol installation fails, we are trying to remove
> all the objects we created in tcg2_uninit().
>
> However, there are cases when this function runs before the config
> table was installed. So instead of printing an error unconditionally
> check against EFI_NOT_FOUND and don't print anything if the table wasn't
> installed to begin with.
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - None.
>
>   lib/efi_loader/efi_tcg2.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
> index 572c6b5bf6..a15c73162e 100644
> --- a/lib/efi_loader/efi_tcg2.c
> +++ b/lib/efi_loader/efi_tcg2.c
> @@ -791,7 +791,7 @@ static void tcg2_uninit(void)
>   	efi_status_t ret;
>
>   	ret =3D efi_install_configuration_table(&efi_guid_final_events, NULL)=
;
> -	if (ret !=3D EFI_SUCCESS)
> +	if (ret !=3D EFI_SUCCESS && ret !=3D EFI_NOT_FOUND)
>   		log_err("Failed to delete final events config table\n");

tcg2_uninit() is called after another problem has occurred.

The user probably is much more interested why efi_tcg2_register() failed
but and less why this secondary issue occurred.

We can drop this message completely.

@Ilias, Raymond

Beyond this patch the following needs to be fixed:

The TCG2 driver should open the TCG2 protocol with BY_DRIVER to ensure
that it cannot be uninstalled without taking down the driver.

Best regards

Heinrich

>
>   	efi_free_pool(event_log.buffer);

