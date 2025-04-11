Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE8C5C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 07:08:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD8CD83EC0;
	Fri, 11 Apr 2025 09:08:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="NHe6jxGq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7A4F83EC9; Fri, 11 Apr 2025 09:08:22 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFC4283EBA
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 09:08:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1744355293; x=1744960093; i=xypron.glpk@gmx.de;
 bh=jEg1Sh1Dhzcf7JU8hmBaynFI7ufzJpH1UIqCMLY1qRM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=NHe6jxGqAGX9pOK/Q/ToG7+as/WjmPkjduVN0t0L4KTz7AZ5N+dy6wUTDIFl6tSj
 GHopbko3tBDWjXnXmUZJZE/DdK1Etu9CUzEpXNuMY31h37FmtFHSeyaST/Gh/gczq
 f8BZdjCu6tovt3dDdzBszoj0wDR2l9j5kRXLKMUxLnJu8CUmpi9aCRVvJ0IJ32zJ+
 H23qJnYmk3vlMXfF4F4oY8ZFvZSTW6vUN94F4ERKmm8l6i5/dUY1atEd6Ytd2xVeZ
 VQ3bhLxf/GxrRchiKV3WR/Cm6Kdqay6Ra2opQUpyqeqlLsTLSvrj/bqoSJMV8wLL6
 RTACmH8xmLl1yZnO0A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.109.163]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mel7v-1tVAaW2Hx7-00m0fL; Fri, 11
 Apr 2025 09:08:13 +0200
Message-ID: <8ae5f2ce-06dd-45d6-9eca-dbae5c32d951@gmx.de>
Date: Fri, 11 Apr 2025 09:08:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: Print extra information from the bootmgr
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, u-boot@lists.denx.de
References: <20250328125819.1080935-1-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250328125819.1080935-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:co4LThKfDCXnfCSFHY0VI0mKUy/VC+ewGPD16N8pCvfM4/Xtm+t
 /O45U4IGnWxSk1Jst2lgQ4rPOTJ/m54Rxh5Jk/bPm8OMfYAE97hyqjvlRyODY2FE87+0bkQ
 2+z5gwvYPmJZs5XstC/LI5f1o1NJqn55gG16yUcSF8+XzRruHA9rVnrdJNrrVJsq1Rii07y
 OsJxbiuAzbbLy1oDOgetw==
UI-OutboundReport: notjunk:1;M01:P0:q6io+9SRp4E=;EOdyeqKka+P6t45flTrHy6LxlkW
 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
 0qSOEp/A41FqMMSsExZM+s=
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

On 3/28/25 13:58, Ilias Apalodimas wrote:
> Instead of just printing the label, add information for the Device
> path as well so it's easier to see if we are booting from disk, network
> etc
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>   lib/efi_loader/efi_bootmgr.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index f9534ef85edb..6b9d809ff618 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -690,7 +690,7 @@ static efi_status_t try_load_entry(u16 n, efi_handle=
_t *handle,
>   			goto error;
>   	}
>
> -	log_info("Booting: %ls\n", lo.label);
> +	log_info("Booting: Label: %ls Device path: %pD\n", lo.label, lo.file_p=
ath);

I think we can remove "Label:" and but "Device path:" on a new line.

The output is truncated according to CONFIG_SYS_PBSIZE=3D276:

Booting: Label: nvme 0 Device path:
/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/VenHw(e61d73=
b9-a384-4acc-aeab-82e828f3628b,6d00000000000000)/VenHw(e61d73b9-a384-4acc-=
aeab-82e828f3628b,5500000002000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3=
628b,550000000300

In this case the filename is not shown at all.

efi_dp_shorten() might help to provide a printable output.

But I don't believe that a non-developer would have a benefit from an
output like:

HD(2,GPT,54e58a03-c1db-4c6b-afda-24340c39cda5,0x109000,0x32000)\EFI\ubuntu=
\bootriscv64.efi)

I would not know the GUIDs for my partitions by heart.

Isn't log_debug() more adequate here?

Best regards

Heinrich

>
>   	/* Ignore the optional data in auto-generated boot options */
>   	if (size >=3D sizeof(efi_guid_t) &&

