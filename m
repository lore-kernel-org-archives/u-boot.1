Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D56C55179
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 12:21:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 58D3E607B6;
	Mon,  3 Aug 2026 12:21:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hG9FU_B7ZTHU; Mon,  3 Aug 2026 12:21:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1885A60779
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785759695;
	bh=/AVbl7lEzGvQ2kSp7s4V2wL57pYJP7zRS5siI6JbYvc=;
	h=Date:From:Subject:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=zputpp7VgBQ6kwsXCjDNNZuICmbDub5RSanQpP75RdRITO92w15zASEOPZG3xRHIb
	 Tmff7WAGeV+mPiAs4Xo9a76xqVbqZUVVHTDy0VkXcvR2V1dA/h+yeyxyYtHXpts1k1
	 PqOA/zp118zTseJqLb8l2JpcaVwN/DEqVH6R/NlAYIxMlJ6o4vy8NEJjPsiONRKoJn
	 OCyt6Fyua0spyRerZ2Nc8L9Av9YuSJV884rBtgeJ/zFM+9QdGczdWT87YKg1kR0D9a
	 tJI5BiGODcWpo+vj1JkIbHIaZL3bFtV5qshK0yK7EQkK3acc+p5+gVu1rgfkZcGN0t
	 Xqwq/imE/quow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1885A60779;
	Mon,  3 Aug 2026 12:21:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8E6E1218
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 12:21:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8BCCA4055F
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 12:21:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4zbOic1mAAHI for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 12:21:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4DDC840521
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4DDC840521
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4DDC840521
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 12:21:32 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-495590dde14so20289115e9.0
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 05:21:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785759691; x=1786364491;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/AVbl7lEzGvQ2kSp7s4V2wL57pYJP7zRS5siI6JbYvc=;
 b=ffKu7fPXrapdIp3wvvb9ylmkUtnYURbuHYxVq7K1oYCacnYrCIxIizsFrUyh6UEUi5
 L2TJOjpYSCnLmgZzu7xgeq2PWORNxXq4F1SOEs/qtvOJCG+9hEAMyHYaLaRYRJCiaEf+
 /Uc6nGwTJPAdFZ/8aM/Z1qFeXqONTrj8G4+qYc1lqS20wBwoZQIZEaufNJFvhArvoXKo
 N0PPKz60tLTomdNq3orTOJABy5lW7jR/pXBVOOayLlwsz00KNdcwsv2DCgBsulJfCido
 l/JYW0dDs9WNYoXk6fiA4MbOe86BFfF5ivAGkEEm59wS3YkMkh5tnJFZ8cnW5ioKUTuc
 Tzcg==
X-Gm-Message-State: AOJu0YxAm7Uac6WgLRGokoD3XCGyNO0rkhAAtm3axv9YtwB4thmCC9lw
 ekuhgQ64MQq30+L7OI/W89z3h6hnn78Y7PumM3h1adrgHUUROpbqRayQQEIMdni2Yhoq58tvL55
 rbWQVDwI=
X-Gm-Gg: AR+sD12lcdIQrGhW408pmnqHNfgibzpQkJx2s4nIsizGvBuHeTyQne/NDwbweWvfFwv
 /ZUx1MKhR8aatXZVGViPLeCCLMvEqz69ZHFgDj4SCucT41szTm/rWoxVrAp00LsDR0wEnVRq2oA
 jDrDuoh3Hx2stJOxNMGuXFjOLVmokPXalCNAIBzMsH//75UmtLtLg01FH+Q2Ho84xWinu2FBSfG
 VOBPYc1QkRaSiBOlVWFM6JSkGUw6sp7kuP9940p/Fg8xSEjaTxlMavyOACd+BbP/aUL7eePXiYT
 o/tXlO71dKpBRqU8xRkVhdcGPEVyO605J5gOtcp4SnlZdik3HVcCr4zHEZC5M84Jjr3PkwfofbX
 VBFgK4ZnD2yyHoQR32kcoRC4GnP1PKm+EgoI64PFV9sfe8UisRp8F5xMTbLsKQfaFm9jWSfW0EX
 3+INW7WYGjHIbvPCf/fSePXQ3iR/yeil48iWGLp5jhmeOA8CB0T7CjWJm6GiamHEV43kdLHfAqa
 LudxhNyge8pen9VXmcgN4OOsEcTS44jFL1BE/fDQxcKAHyRtrBfftE=
X-Received: by 2002:a05:600c:350c:b0:495:4d00:2fda with SMTP id
 5b1f17b1804b1-4980f23180fmr164659275e9.2.1785759691028; 
 Mon, 03 Aug 2026 05:21:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:b4d1:1a13:61d0:b2be?
 ([2a01:e0a:106d:1080:b4d1:1a13:61d0:b2be])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49808a721d2sm208692095e9.15.2026.08.03.05.21.30
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2026 05:21:30 -0700 (PDT)
Message-ID: <842bd7e7-034e-4a2f-9cfa-4f9f65f4555b@linaro.org>
Date: Mon, 3 Aug 2026 14:21:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH] cmd: scsi: Drop duplicate leading scsi prefix
To: u-boot@lists.u-boot-project.org
References: <20260802220904.168737-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20260802220904.168737-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785759691; x=1786364491;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/AVbl7lEzGvQ2kSp7s4V2wL57pYJP7zRS5siI6JbYvc=;
 b=cjBiwAjiQ7j4EvfajVyqBnkXXPI9YCVsw+Hd6DoFG6oyAMEkiXi4zYWFFkfiSeeXOo
 E3hvHpcwqXtfOqHB4LZagtbWmZDvA2iYZjTArzi9j4tuY0AMBmXqxz5wVB/QxXXDm3xP
 77UdnPD6uiNzjP8/9b7qcIgBY2WQu9D2YnYsm4LK69CDEJPto3tjwP/gJI12QbDrgjUk
 1eRWRz1k8+xsw+IQPzbeJyNz5IeesMWLQCgg6je0Eykc8nZJf/Vb8GcdCByrYns7kOip
 ZMekdiGkidTb1fN1bqg7KiwxIsfEQQALZdpCSmXujq6pAurw9HYLQTPGBMT7m7ztWw3U
 dSmQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=cjBiwAji
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 8/3/26 00:08, Marek Vasut via U-Boot wrote:
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
>   cmd/scsi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/cmd/scsi.c b/cmd/scsi.c
> index ad7d8a4b664..5e732c1e50a 100644
> --- a/cmd/scsi.c
> +++ b/cmd/scsi.c
> @@ -45,7 +45,7 @@ static int do_scsi(struct cmd_tbl *cmdtp, int flag, int argc,
>   U_BOOT_CMD(
>   	scsi, 5, 1, do_scsi,
>   	"SCSI sub-system",
> -	"scsi info  - show available SCSI devices\n"
> +	"info  - show available SCSI devices\n"
>   	"scsi scan  - (re-)scan SCSI bus\n"
>   	"scsi device [dev] - show or set current device\n"
>   	"scsi part [dev] - print partition table of one or all SCSI devices\n"

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
