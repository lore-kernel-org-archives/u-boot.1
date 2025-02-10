Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A68C02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 14:04:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C5E1803D2;
	Mon, 10 Feb 2025 15:04:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="CSrHIo9T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 765F8809A4; Mon, 10 Feb 2025 15:04:21 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FFF4803CF
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 15:04:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1739196258; x=1739801058; i=xypron.glpk@gmx.de;
 bh=NaK4MrE0iWbKZkRjg+G/LcKKHar7wh+D1iYmhjfkXBM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=CSrHIo9T1Xx5gJ/kNA+oYQse69hPzGKcS2CeWplp8uwPbx8uHKRKOtK53VNbPCdD
 +ooOaCK0KcsO2nRYNq9fbEaCUaFb7AgWGkqz9hFGQPP6dMdVcBQa8gSbD06VXtdGB
 pUwY/1+xUJOs0u4l93cFOWUmbOMkN57c/tG7hfVPlhkhmnigSZY+RjKyq8UTSFWAB
 gnteXcNIqgXjjuw9h48t6UyLkhZ/U1akAW/A6afVNKLip8P9Vz0LljAT5A7PcUm7K
 trA9Lo+c2acRWeD6drslcPXYTx2OexIu0N6VaBYR4/rd44nczpKjH++Q9Uhnsryti
 Aoif9zNbwT0pFJDQiQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4s4r-1tiJ4n1dQd-005B7o; Mon, 10
 Feb 2025 15:04:18 +0100
Message-ID: <39d08725-833c-4ac1-805c-2402a20039aa@gmx.de>
Date: Mon, 10 Feb 2025 15:04:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: efi_var_file: specify absolute path
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
References: <20250210131045.13905-1-caleb.connolly@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250210131045.13905-1-caleb.connolly@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:w0o1KnV0+E0yWpkN3PcR5AvhCRZRj7v/nswU4VcMEQ1SurAlkkn
 k9S7ujt2vQSv0RzE9h1DTWEO5a98MbTGOUIY/kGdHZMypmMUfjNPExdX9CTVBmf2EQdhDcv
 W/vogyCZa3BZFtv8r2eje0xhOdA5P1YURlUhSl4lQGKVRoQMMpruW2g7sx0OfFac4+NQjcq
 BHG0405D2sMW8h/hupwWw==
UI-OutboundReport: notjunk:1;M01:P0:ZTG1dUxRdso=;Ezs8lYaouduWDwq79FOlBPTceV9
 hc6IQnIChdohR3Tbu2tCf2KIR5xlWA19eGZOM9NM65aWdceKGakqNgfREl5hLkPGi4qzTfO9H
 4M6TQzMWhAsbQ+PrtrdjyKCkpbnF3zhGYWTTTag6GzL7GAS9cF7+tf4nGX8wKaT2mgI7omXD6
 Zg55slrlSVb96zVu26XcOSjPf1zHsd76ihZD8RY7lwYK39IGVuhcjjAHV+ckJaSiJSnTKjLH2
 1pX/fhO9LlXYUU7VTAqPd4NMnWQ6lMhT7j7iZ14ZTveRptdTRpMXvanoLccgd77+V9zyPVe3y
 LMwWM9NdnPG9QRTA3BLnO8tvUGLZ257DVLs48DTeivmtD+mnimAjHjnnCDKr4gPwLUHjwVz3U
 nR91MP4tXXuKYXI4OImktGglUD37b1tarCBqi5IjL/pNEBLI6ds9ZHgrkDjoPUd1H/9XVVKX0
 40MeV/WXHs+xH225mbFO136fSOtrYxOoBCQFeA5KH3tn3phl+8EeAXZofmEBbLxcPokHR734k
 bnYWnWJ+6fcz71VfvKcf1YrfYBmZIqRGTIoRcWA1UDPYE3xTYj58aAlv0IOQv0CBf/NiSBQDI
 aHN/STVf8dusiHKcZUQsdeUVtd4HKHHczpfyMJHX9deoMeFcgzuj1E1I6UJtAPQp4dwTjR9Ri
 RYMBZ/Fvm7BbFeGD6Q+2IOGa1+lUv+udwzPa9ifUfsZHE3p3ZLBv7UrKDrB/4TJGy/FEFhy3v
 +ysEFbXFGOGPa0nyzFU0DTo7PRDPMchZRZdE178vIwBJS8X/9k7YhnlsH0s2n858VF9Tpw6hl
 dkb3Z8gVd6Blxx0SqtMey1FzeVVfcFl4ay9CkAwsGx1t/uMeuSOpUHelPfLOMEu/uVsJPGpwt
 r2Sr+huZYmXYidw1hgOpEscj5LsMA/PZXc78oXnk7OcaLTho+B+Ir+hPz8kn1Ew2/YhSUAdOC
 jy07mOnFF86qJKtGK0+G91aU2r+UpWRmM893DhVkc+ym1z5oMpTGm9seUuVRG0r25tx74iH6Z
 R9Hm08xvavdHqvF7COk7lbmfFp37oV/Me6kp53XawoW2a0Y/rJkYhvOKqxnrQtYYUa93+X/ny
 cLYUaNssYSC/J67R3WQ9PZGc1fDNtH0h4ECrdbMamslP9Qo/iGh/zHfPK6fTJUc57goRJ5u+n
 GxJUV71Ndy3tcXpj5dvP8Xf/ITtz11qMG2QJZI6ABEiIkIbQiUzuSPiD+Zm6YT17H8Xq2ij+1
 OTom4rvZevt00czvwoXi8wtDrsspdW7FtT4qcmudssP7TSpFnqb7+sthKzyFB5K7k3ayJZc+Q
 pIMkfQpsC3t7ghO+5g5AD0IlPXJKCdTy9ZUqnAj2K+3qAdl0uzhHvlochmNKwhAa7WFzPPfFm
 HSwO31oR/2QdQiK9ums7avztCCkTNjsIEGO68XFhTcn1Pst9lxFCguJcz/st+pUo5j/CYwVDU
 GhGOPhe4sP/ieBcJNqO6lVhGyDlI=
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

On 10.02.25 14:10, Caleb Connolly wrote:
> The EXT4 FS driver gets unhappy if you attempt to write a file without a
> '/' prefix. Adjust the EFI_VAR_FILE_NAME string to be the full path to
> the file.

Thank you for reporting the issue.

Our FS systems should all behave the same. U-Boot file paths are always
absolute. We should identify the problem in the ext4 driver.

I thought I fixed this in
4ed2b1af4599 ("fs: ext4: all file paths are absolute")

Best regards

Heinrich

>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   include/efi_variable.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/efi_variable.h b/include/efi_variable.h
> index 4065cf45ecaf..83fbca93b6bd 100644
> --- a/include/efi_variable.h
> +++ b/include/efi_variable.h
> @@ -91,9 +91,9 @@ efi_status_t efi_query_variable_info_int(u32 attribute=
s,
>   					 u64 *maximum_variable_storage_size,
>   					 u64 *remaining_variable_storage_size,
>   					 u64 *maximum_variable_size);
>
> -#define EFI_VAR_FILE_NAME "ubootefi.var"
> +#define EFI_VAR_FILE_NAME "/ubootefi.var"
>
>   #define EFI_VAR_BUF_SIZE CONFIG_EFI_VAR_BUF_SIZE
>
>   /*

