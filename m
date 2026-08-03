Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89222C55182
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 20:59:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4B57380B0C;
	Mon,  3 Aug 2026 20:59:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KPHtdXikePFG; Mon,  3 Aug 2026 20:59:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A751C807E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785790770;
	bh=Fo8UWnNZsdmFvsAEkyXpDC8Gwgww2INLyVg8a990Dvw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rl4b5Q3uHD7hPiEn/3NPfAl4myuOKSuO3+1T4iUQ/vqmu4emKD0atFJONzVfT2wFU
	 bjnHyyOuWnXbOZpj9uYzs1V96G3zNyU7csP3YsxMMtJ8U+Ntda4f60sqSa54F0F7j3
	 7JXFBrextRZaW31rBdSy0Rp9vh1YYpxEhmxeU2XQCImui9Pd6y2cRWHuK2d+x0qzqr
	 JM1vmunzEtK0FiLVvR7TyxOmBi5j887X4L81tPSHDarVOnqStnHdsKIT1wI4tvjkC3
	 S9DsZZG1N/yVJiq2FSdbSPuQ4RvHH2TnuZbCkCKEdIBn6TciqEgv+X3EvPEpgKhbw+
	 MX2D4dajtjjew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A751C807E1;
	Mon,  3 Aug 2026 20:59:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C553B218
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 20:59:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AB7F960683
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 20:59:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1xI9ChdSSOrJ for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 20:59:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c32; helo=mail-oo1-xc32.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 034D26066F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 034D26066F
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 034D26066F
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 20:59:27 +0000 (UTC)
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-6ae4475c68aso644388eaf.2
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 13:59:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785790767; x=1786395567;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Fo8UWnNZsdmFvsAEkyXpDC8Gwgww2INLyVg8a990Dvw=;
 b=UG6LvoSLkTXzEvqwSWK7ouakQAqW4ab2bpcPsZz1heF0g/9hzsFOUMpPSlQrn7mMyJ
 VXQ1y5wNEnzsRiKldId5wionMmTVy3A8VnwuUwXVn+RIS7ktSxg6zH49frFpQOJIhC/p
 bfOauLUnSie3zKtZFxMlzrbCCQhoWAUxFN9UOGckmMhCQaBhEGvvh0K2P0UgoRT2Hgdy
 PDx7FaVYqzRLcrPYe41PgBCxpPBEAZ2MDlPtaE5R7jw1XaKytuf4WGVtxLhtRloh8WFJ
 ORG6pBnRZ4DWf4ggsACjvK5a7/uJnxYot7kSanNF0QZ20UuKKrGP+YvJUBSXxF+EVjoT
 C5mA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqdxA5nVSuy/ARz3xYDZG0JPUI4pnG477vCV3LEUm9jivHRZCYPQhKLj7tHejvLAtH1e7Jna7c=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yzi+S1y4S+W6YXQoFnFRWWIonxEvNguHA1lvv0b3lsFJZ60ZQan
 sEY7FXUxCBDqE/mHJWjJIF3M+GHSEglyYoG5VcdCz0XnI0PIZkJz2Mlx4fKRsFma2WM=
X-Gm-Gg: AR+sD10v5krm4xAag3VHw3jDldO9t68D5gF6b6O5Jondede4bkwGP/LOJbN4Y+aPrM4
 LFapBeJfxVMtcxapDPm+r6TPn/S04eVYd891do50MYAHhofLW59HTfPMoWvi8ix0/wou77cBCCV
 4a5Lin/+ofXlfx8ba/Gsjp/xVM5ulIN7tzCFFduoO6WktYld5mDBkxp8s9nYoDgRO0HktT2N99/
 gbGrKjVtzf+B+Z4G9pPD1ORpt8+/zJrcfIn1V4CDPBNmP8KTQ+w1D9xfL2qZgkC9NW/AcfzDxPv
 ybx3RGoPityq2RPy9oc/lP2fcRtBliCPjcrw4+ygD6DXzziUfg8C2jHPD3P0Kpt8XM+e7yn6d2y
 mcndhg/OJCnbbOEP+5EUuo3JlbWCW2/PewAh2aFzlPXYNRTD4Lxs63tY6VA5wsDr9WXGMCux1RE
 rh/tECnWyv6bSCzv2A2adZZv7EJOeYQGucuAp0sE6bbNBTQsfVH5m/xcmuEqGuTfYklmucPjBAy
 IUqaR5nTfLxRDv2YizB9wCm6Vz42yEGKQ==
X-Received: by 2002:a05:6820:4b15:b0:6a3:8303:bca4 with SMTP id
 006d021491bc7-6ae431ceec5mr18084870eaf.8.1785790766855; 
 Mon, 03 Aug 2026 13:59:26 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b8f7:1f5e:7c:a7d1?
 ([2600:8803:e7e4:500:b8f7:1f5e:7c:a7d1])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6ae39d297dcsm7482641eaf.1.2026.08.03.13.59.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2026 13:59:26 -0700 (PDT)
Message-ID: <4bd4731b-1c24-4055-9f2f-2851a3e2848a@baylibre.com>
Date: Mon, 3 Aug 2026 15:59:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: scsi: Drop duplicate leading scsi prefix
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
References: <20260802220904.168737-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260802220904.168737-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785790767; x=1786395567;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Fo8UWnNZsdmFvsAEkyXpDC8Gwgww2INLyVg8a990Dvw=;
 b=ce/Az/792Or5057zbax9LTUekeYinlQPVNRUi+RXBI857iG8IS6rNhVOWj1QMpHHNW
 rzmlQ6IBJKViCE3j1ygVigquSdW3eQ2R4q0qvoqVGIWJ/t/LG1mfJsXsClnm1oUczbsE
 PHCDxTRSHX2mrjviTksnJk2wAovwk4wYvDCE+6MaWcG1ePoVTTkg7slS6QBdfSpmzsPC
 WBag+aq26k2AyFDzjzPsJdZpCCTjpBzr2ZWvkk/rhmhuArbm8QS1/UhSFnrvoslB08t/
 gY4BAkQquQsoGf3LmcQW4D/Zxccfzh7pb4A/VpLT8D5pQfAt4b/biUFUk/Y0WYMR2JFh
 +5ag==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=ce/Az/79
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

On 8/2/26 5:08 PM, Marek Vasut wrote:
> The SCSI command currently prints the following duplicate prefix:
> 
> "
> => scsi
> scsi - SCSI sub-system
> 
> Usage:
> scsi scsi info  - show available SCSI devices
> ^^^^^^^^^
> scsi scan  - (re-)scan SCSI bus
> "
> 
> Drop one copy of the scsi prefix.
> 
> Fixes: 460c322f13ec ("(re)enabled scsi commands do_scsi() and do_scsiboot() Patch by Denis Peter, 06 Dec 2004")
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.u-boot-project.org
> ---
>  cmd/scsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/cmd/scsi.c b/cmd/scsi.c
> index ad7d8a4b664..5e732c1e50a 100644
> --- a/cmd/scsi.c
> +++ b/cmd/scsi.c
> @@ -45,7 +45,7 @@ static int do_scsi(struct cmd_tbl *cmdtp, int flag, int argc,
>  U_BOOT_CMD(
>  	scsi, 5, 1, do_scsi,
>  	"SCSI sub-system",
> -	"scsi info  - show available SCSI devices\n"
> +	"info  - show available SCSI devices\n"
>  	"scsi scan  - (re-)scan SCSI bus\n"
>  	"scsi device [dev] - show or set current device\n"
>  	"scsi part [dev] - print partition table of one or all SCSI devices\n"

Reviewed-by: David Lechner <dlechner@baylibre.com>

