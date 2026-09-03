Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F19C61DD3
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 11:41:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B1E5F810D1;
	Thu,  3 Sep 2026 11:41:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OSUtcctgjBYN; Thu,  3 Sep 2026 11:41:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org F38DA810C1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788435681;
	b=ODPdSEDG5dZsUe37N+wu8c0d5eSpgww60tC6sjZMb6YmZSwKkFJpzhkv4ExtQ5lWqfSO
	 jxStSV9vA7Lou+c2Actf0k9rwQ03gL1HQO3U/CuZRWgIKGUf8NSUbNfX3KRCCo1Kei2gT
	 vDxskGltMNotAMpre/lB5pXpcY48UtPldZ69qQQIK48Sm1mweM4+VClFVyOslRx5yezO8
	 lMi2BSBF4siFYts1Ex5uofX+rSfLTYImwV2UZKBR0buN9S1XHDkRusNYQQyxsbegPbSF2
	 V/webI40F4zIzkn01EWqLC8BwzRaxwjVmfGMp4pSV2BachV0zXXrVlhoDmI69efburg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788435681;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=SAPYUqD5TAGmhHTazGO/PCZXITSy+E8wwJEDBEbFQa0=;
	b=h/ZJI8QyX0gXigBo9jHvOkJlUacDfh1JxbbLrqN31Omvqu+uNJstAdMkXQ84I5fEfr8G
	 JxixIiMUV0+z+sKgAgqSWLaTevNj6FNkhU/y7ru/mMOhfrW5iOVUeWpWL/aVdWT0tQOrQ
	 gZ/6dLhYGQu47P+Pjk7e3I7tuEs/cOHpnfqt7dQEnd1bysBuwKdMCIr/dY497FhyJUfn0
	 H/SsPFiUQl5PiXQODZ0++uKDp/9X4p/+LGyq553GX7QabO7eR6mOBgEMQQjcNGdRo44Hd
	 dUQMjB5fgGcQpqjMhC8VNaGl6NdLTccuKsyot1KgCs7jbPNAznAW034u1doAlL+lkmQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=mcEM7kFM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788435681;
	bh=SAPYUqD5TAGmhHTazGO/PCZXITSy+E8wwJEDBEbFQa0=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iXAF4iCfn2b6wKTk5Dj5Ru8TZMaaNk19l/PtqLpQpccm1EV9cBU8FNTU0GHW79HPH
	 CxhBvsT9YFjWpG4hiZtn7A2EEHfpMckDbbSToO4uuk9mqtJ3K7RCKlii+hz9+JB7qR
	 gVo4RtEfCzYS5K7Y8/HUlSpQTFaFcgsfXfOqj3DOfh6TarzKITytEiaA/ZOFODEwr7
	 QQnE9WJL1x8AAvflf3TDbdB6vId14BGJx4TgKP1478RHcHd8XFVD8pfUJ1FddtBGJl
	 at89J9jmDsRffjeszfMeSWKQxUOlqc+rYaB1oY9NJHgXj4fulet8dFtrQRQyX5piHc
	 XAt67RH9KzUgA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F38DA810C1;
	Thu,  3 Sep 2026 11:41:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 83DE8279
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 11:41:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 694BD810C1
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 11:41:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id INMD8djS0CQg for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 11:41:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6BC15810B7
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788435679;
 b=YafZDZ4Nc+EswSCmESn/qu2cvu75RD4lxZxLUwwoWNEH+x642aN/vcK6xmKtywxFhASz
 2xPmvTzOGa1uJqX2UG+kX9iJkuT3rw4wDuLwEtVmqcoZtGNRk+wD/p0IpUHyzTo2cV4jt
 xCEGPg4r5U7YMKmMbnGna3u2CIlTJ/PlD+8hSOFz1ekjMTW0HZTbIVOxMUD201OK6nVWv
 FGK73w8/PPh6x47GeHIy1tktB4esWR6dvOgVeka9uNna2ss+rA/vA2wAX8asKIntCBwwi
 HRjFOf1VViz8C5Hu3RFa4L2Pwacva9w/hIVQZiQVjFf2BALlIJwVracBr8PeX4Um4uw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788435679;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=SAPYUqD5TAGmhHTazGO/PCZXITSy+E8wwJEDBEbFQa0=;
 b=MCmJy0McHxFLaSY1e7inJbFmsttbdvED/N6LSLhmMDQVFcGog+dip4AnKgZGbYxRaay2
 IhsBCCh8UZgpzhkAdw4gqyN4uIR4VB1dYwSpDbDcJHjAZkdegvqQzAuows2CBT5XaOf+9
 HHijrubnYAYPaONfCUKCeRYxg185VNUggUK3nqPDocQxArxq6g++pr5xlmas4u0MTlKPx
 NkMG1lq/rC4AX0MHrcVG0V21pony7MFZvZH2SCxdZiGn+SlxUNGBus4HrGjqlmsjWRjB5
 n6CLIe1syLUD4sXz7wNCM+2i2IK8I8eOtAqfebfyKT3Ytq8vQGczDf/Ycn/nyxP+GVA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=mcEM7kFM; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=mcEM7kFM
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6BC15810B7
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 11:41:18 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so23930695e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 04:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788435677; x=1789040477;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SAPYUqD5TAGmhHTazGO/PCZXITSy+E8wwJEDBEbFQa0=;
 b=mcEM7kFMpyX0BFsbXZu84n3tmWv9cWZP1kiDK6t/9ko+OR/YRzTMmnNzsHjiEp8Jnq
 NYe7VoDYtpTQI3UdBQqseWwXJLeB+FeT8yJtn0FrbJ+ffKih0D2pdW/wai2Alp0cvaZO
 tiZyzZIn/c0mWV9vLR7SOHNmkvOLW5h1shOqOMP7mY7/O7DJlN4XeUpA2NnBZQBcQlyB
 ArfpkGp/acU2SHI7KCDbe+stW9j26Xv1YS2ur+3Rk7b3p4oUaklbMaAajiUOFc4WFT12
 SmGDigflMmLY0ZIzL+qxZ74Zmh2AuY9wj+LjzrLQbKUBIOsPvWx274DyE6a2efx4qIYw
 6Edg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788435677; x=1789040477;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SAPYUqD5TAGmhHTazGO/PCZXITSy+E8wwJEDBEbFQa0=;
 b=GuuU3cilx3vFlPULSsxfr09a5fwV7eAgM7qlFpBkhrWPQ4obeRoZXJQQiZbZWD9l84
 wo1BV4WhH8aSLQR/vGp/CW0Sc/AAQQcVh1seSqpf2IZXqZbRRt+jqUiQwctM4hzLZeeN
 jgcKUh0Rv+K9xPEC8hwoUMXsxRwmzvVIpxPtl3Q5SI1rkblwqmlSORXhvxBjmNJ6vluS
 ZnEH1hdxbSeEN3aj/cEfONCjFCMXpYUQuCdjCbM4jCtwVcz0jqd11ZexudmqbSa5WprT
 ZX6MC6fJtzMHvE7ML5GxbBipHSYcnEAy4Wfh7fkvmcf+y9WF0C5pwZ2QbcR0Rbt3LL8W
 UE+w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwOiZMhS2v0E3jGS/AKGyBzY7TBnOvcWcjNQ2LuH45db+3aY5Y6T86g9hJsozZ8oNBk2ilptLQ=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++m+GeGVYzHvU/PkLV57a8tpqZiGyUvkwx2adFH6EbApt+oRtnzH
 JOO8XIQmFl2jqxIRwm3QF7qUgxB2qsnjwlRacKIBZYZor1eQWJMIRiBGT/pBbsG7tAE=
X-Gm-Gg: AYBFou3vOBOJ729ZRel66LxHFJbQmN+Kr7PlsZ38dfU0DCnL3JDA/eB+iws/sMD57fQ
 zuhad0Nlf6w6mk1Eti7uMTjYXTgp2UfNu05l7JvLWyNQC2ik7aep2+iIEF968OvbkfEe3NVEmdv
 fIpli3flBKxNyHYe2DTzaWfg47T0vvQeS6fdb0YwmEWLLcykTg5G/6cPokRMF/WULuUaC1pueDF
 oiwlS5POI7vDH/N0OA/Mert2hqpsTLBr86SEe+cOOnyc7+IpaaLtozHD4Hcg1+1yqxIa3ZwDUo/
 VxLGk7qP8Fl/5sKdgiGm+SarZN9aRNOx/4SwvJ6iFdopw3MVzdmC6i5LPmIPl+c4VpJiVlOcGjb
 HkQbhJEZRg0unme5nwAJoy69oqHLYbeg0CnVWamEiUdjJPJLTYQoxQJpmMkeSE2ensTbsBLyWFV
 XwqrsY90Nvgj15aMIsfmtzfRQmT9ITGPSkDWpNyNLyOda1gvMcnWYQLF7s27KiESkQIVIn1ac7f
 95KvQ8/8DPvqcHmEmPAU2fKQt4SCB1lbTcX
X-Received: by 2002:a05:600c:8705:b0:49c:dca2:ac47 with SMTP id
 5b1f17b1804b1-49ce57ec7efmr213578835e9.2.1788435676684; 
 Thu, 03 Sep 2026 04:41:16 -0700 (PDT)
Received: from [192.168.1.37] (p549d4d01.dip0.t-ipconnect.de. [84.157.77.1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-484492cdc37sm13744448f8f.34.2026.09.03.04.41.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 04:41:15 -0700 (PDT)
Message-ID: <6a241ac2-5726-4f0f-894c-d75cbdcd0fe6@linaro.org>
Date: Thu, 3 Sep 2026 13:41:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] configs: disable CMD_POWEROFF in snagboot config
Content-Language: en-US
To: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>, trini@konsulko.com,
 ilias.apalodimas@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, aswin.murugan@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
References: <20260901195748.1192630-1-sumit.dhami@oss.qualcomm.com>
 <20260901195748.1192630-4-sumit.dhami@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260901195748.1192630-4-sumit.dhami@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 01/09/2026 21:57, Sumit Singh Dhami wrote:
> CMD_POWEROFF requires do_poweroff(), normally provided by psci.c,
> but PSCI_RESET is disabled in snagboot mode, causing a link
> failure. Poweroff isn't needed for snagboot recovery, so disable it.

do_poweroff is also provided by sysreset-uclass?

> 
> Signed-off-by: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
> ---
>  configs/qcom-snagboot.config | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/configs/qcom-snagboot.config b/configs/qcom-snagboot.config
> index d19ad453029..579bcc7732d 100644
> --- a/configs/qcom-snagboot.config
> +++ b/configs/qcom-snagboot.config
> @@ -8,6 +8,7 @@ CONFIG_QCOM_SNAGBOOT_MODE=y
>  # CONFIG_SAVE_PREV_BL_INITRAMFS_START_ADDR is not set
>  # CONFIG_IOMMU is not set
>  # CONFIG_REBOOT_MODE_ENV_UPDATE is not set
> +# CONFIG_CMD_POWEROFF is not set
>  
>  # Use default environment instead of loading from storage
>  # This ensures snagboot mode works even with corrupted environment

-- 
// Casey (she/her)

