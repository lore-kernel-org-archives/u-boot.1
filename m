Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1664ACD4F3C
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 07:59:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BD6483AA9;
	Mon, 18 May 2026 09:59:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PRW9Nus7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF9D183EF9; Mon, 18 May 2026 09:59:15 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AECC6839D9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 09:59:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-43fe62837baso981487f8f.3
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 00:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779091152; x=1779695952; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T2wZT18MZKcekOVSbxxunZX/AoG1lf6U3ltlm73ykqQ=;
 b=PRW9Nus7TS5GAdACVywhmdmHinTNWyFugsCU4M5X0xstGRoMQ0UbQCdK83PhHOWLQ4
 0eI7cUqi7jYe57DMiy864hJevm0GhguyCr+5d8pMeIDKq31vApRCuDhtxbQuwykBDC0f
 4eiI165HZfLU+jdCDRdO4F2R7wJvhotGakpKF+iqNf8KDCm2qGZUUSTm53zrST82DWbz
 nM4R7/n/GAyzDrtAO1JBpdWcUHdnTRSPKkyoRpgd6bV2DeOS8FEAUmvY2uLLs3n5dI6J
 FwllIBl4J0WpxxyxxCiWtyRylczQBL9yK2rDwaFYg4NVQ5ydrJrLUnv3D5IVVggSHNN+
 7gKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779091152; x=1779695952;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T2wZT18MZKcekOVSbxxunZX/AoG1lf6U3ltlm73ykqQ=;
 b=Ez6osDCOeqFNxaF0E//Z/7SErNPKVX8OhlxTdRzv2+j8NbmODPiTPO4qG7XERI7zqv
 OWK0EaWtOwuEkXZsJVOw3zR0bvAXrTl1A2sBpvPrsK1SDS8/2lTwidTb7HtZj6vOPrQk
 kbF2KfMAJTwpbUVgnAWI+Z2moQqhq33vm7YuARHEwSiq4e86lwWddZ0kTo6/DF58DFxd
 fGgpw/teHfd3vFED84COr7m1TqI5knbr8iTaSl2YtAXGBbuvsKg5kqgfLKJSQXXqtNHs
 JJYTJjCAOnzTRyx0KDlGM6iXNqiQ7N4qpyePPaDiAuvzs3yqqq88tOv8iUZ/WIq9UeJf
 PJTQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/W8I++aFgGSV5it4Ht0SNkJciI1z2+M8dswLTCzXtisZ/ZBE4BBnSchxoLkT9+JDpd7X3mIOY=@lists.denx.de
X-Gm-Message-State: AOJu0YzTMoK/pQMhYs5QSqwRxwXzRnjd+ECH3nAAThF/3PSreAh4UPs4
 KYTlTltKFgM9fsPh87AliJI2+6XRsk7ikOBiwdyQAynSVlxtJqkw5w9xAerhUKXj5jg=
X-Gm-Gg: Acq92OFHxgXEkUDRGZg1TW56HfUCOXgybdU1nJEdj8kiuHqBCkIcbPIDtRQS4M77MOV
 NXYQAUFcrmGVGdqyvsemmgcjgKdGJVbqZPern0H8hpBMVig1kfDNBAveQKNd/oAnUPmRiSJflte
 ya/lSb7TBdbCeh8vGrRqM1VUaQAERHHSJScT3HigEYFjjNV42gRm6Ic+74Gw+9TiVEAXILX65Xv
 WSwmwfT3uiN3jLOkm10z68GmsLSO9trJQkcPrp0//TU0OHnVlK3BplJSD/lVeCxb6b5sJ1yZL9q
 MsrqAsHk4WEWo2eocYa0INdw8Qc1Bi8NKat2BPLe2QzNH13d1hqPqOHY4kLak0ucOiXcJcWlc7q
 JHoExgamG9L/w2yJph5g+K1lRjJsADjLL/K+cTIZPwlUqrG8nsiCJR4FT0YZPUJcegsmZKzXp9p
 oEFeWNAzfSCazbqCmR73FBsSu5eVXInbqMRKvXivnWNx3SggBNJSbydV0pzvJzTnwtHggj4xUMv
 jQH
X-Received: by 2002:a05:6000:2288:b0:43d:781d:37b9 with SMTP id
 ffacd0b85a97d-45e5c5ae8f2mr20541659f8f.42.1779091152156; 
 Mon, 18 May 2026 00:59:12 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3dd86.dip0.t-ipconnect.de. [79.195.221.134])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da15a666fsm33910412f8f.36.2026.05.18.00.59.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 00:59:11 -0700 (PDT)
Message-ID: <ae4eec1e-1c5b-42d3-a26f-3911b1a2839d@linaro.org>
Date: Mon, 18 May 2026 09:59:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board/qualcomm: use bootflow for default boot
Content-Language: en-US
To: Ricardo Salveti <ricardo.salveti@oss.qualcomm.com>, u-boot@lists.denx.de
Cc: u-boot-qcom@groups.io, sumit.garg@kernel.org
References: <20260514205759.3553253-1-ricardo.salveti@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260514205759.3553253-1-ricardo.salveti@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Ricardo,

On 14/05/2026 22:57, Ricardo Salveti wrote:
> The Qualcomm default environment currently boots only with
> 'bootefi bootmgr'. This bypasses the standard boot flow used to
> discover extlinux and script boot entries, which are commonly used
> for FIT-based Linux boots.

We intentionally don't support these alternative boot methods upstream
as they aren't standardised or supported by typical distros. There are
also plenty of inconsistencies in Linux userspace depending on if SMBIOS
(DMI data) is provide or not as well as EFI runtime services.

Could you explain a bit more why you want to support extlinux and custom
scripts?

> 
> Switch do_boot to 'bootflow scan -lb' so bootstd handles boot method
> selection. This keeps EFI support available through the EFI boot
> methods while also enabling extlinux/boot.scr based bootflows by
> default.
> 
> Signed-off-by: Ricardo Salveti <ricardo.salveti@oss.qualcomm.com>
> ---
>  board/qualcomm/default.env | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/board/qualcomm/default.env b/board/qualcomm/default.env
> index dbf6f4e7260..a47c289acce 100644
> --- a/board/qualcomm/default.env
> +++ b/board/qualcomm/default.env
> @@ -3,7 +3,7 @@ stdout=serial,vidconsole
>  stderr=serial,vidconsole
>  preboot=scsi scan; usb start
>  fastboot=fastboot -l $fastboot_addr_r usb 0
> -do_boot=bootefi bootmgr
> +do_boot=bootflow scan -lb
>  bootmenu_0=Boot first available device=run do_boot
>  bootmenu_1=Enable fastboot mode=run fastboot
>  bootmenu_2=Reset device=reset

-- 
// Casey (she/her)

