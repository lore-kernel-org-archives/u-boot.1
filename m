Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD07F606A882
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QyJATYkF;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Gippd722
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 99B9D81094;
	Mon, 16 Nov 2026 17:36:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id biYxkJXUufHI; Mon, 16 Nov 2026 17:36:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AF9CE81159
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794850614;
	b=CflWwnTYmjI3nNQDYZGyAf9OiVTup2o/fSCqKtUwg7VVJ0KhxIOEaU1gLzrmhjCMb0bx
	 rASMXbDPutO/AnMT/KQKzGTd9wh9TRwWytzwt/jGKvP6sBKBKykLXIoqBiZvK4QngYQFx
	 UquwAWajZeaF6g9Z/VgfTRIdH1wyUJahxj3KEgv1eZXEOfO0N6UQC1LQC2LWjWI36WG17
	 2rxhGCor7+aICeggsfZ10Gc+8wJk/r0QNJHMBHA/3NSnTxo8qFcpDufcLjioA97tEHSoZ
	 rvmSHDiOjfuxRdpbTXcQmwLs5hJLo/1p69mVq7Xsp0q9m+PDMf0nK8HC8z3xeG/z0ow==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794850614;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=rii5YQlUEja2vE2dtvwqkHXBkQt4GcUimlE1aRsiXUw=;
	b=giM5dyR0TAKtpbyCIMoVE1KFODi+zDEe2qWx8GjWqPIDlvbiwdOYydFszgG31nerlmr4
	 fZIddynDjPlRuDhZNSU6OX3IzSpb0hixwcEKStB9/JxyHxSE37i4Lt8JhfJ6tYkBt/+ej
	 PnZDsoLD4UdRgtT4P4kNLhhduAdQa1rXAK4JrOOmH5s3ZWtbk03Fng1S/hDUxVg17AYCI
	 r9z8W+FWOASawHVKD5a+d4KeDxdBrv5AiMoHIHw7z5qf3FQjTwr+Vjb4UWf7rybxGqPpM
	 eMIFZlk2HirBSmm0yHTHwW0m2sCSLzvouXhVj4UssGy0G3mHVK73Amk42j7tLuEfWDg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794850613;
	bh=rii5YQlUEja2vE2dtvwqkHXBkQt4GcUimlE1aRsiXUw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QyJATYkF4w4K5OBjHEQIeVvuad4IF7edowuxsRbn9l66TfxJF/bNrH2Au0BzMUk+y
	 VzkiFjKZLCUDMdlXe/as7WTjSJmRH8rmrgp5xuCwM6p4/mzeudemcCImZJYdcIhOQU
	 W+QMFPUVdI+hZhXkob2kUVM0WstTCfKg2+2suNp5mz27WHmqpYgo377t5vF6DmjG7N
	 9rSJSoWxMRjKWFGnSbIXEgUQzm4WNE1wiL2+wsaxOD3/YiKNKZ5cDadQLL5E+qFqao
	 1DADr7YPzgbAqYAREw5s+FXiOSb2vdfGUua2sDO99cfY/zIvPzNTrlaVTL7hhNhn/b
	 R5StqE7/Qzh/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF9CE81159;
	Mon, 16 Nov 2026 17:36:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CE9752FE
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:36:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CB72040282
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:36:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nBMmZjmz33UP for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:36:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 210884009E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::335; helo=mail-ot1-x335.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Gippd722
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 210884009E
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:36:51 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-844a8bf7e25so3318020a34.1
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 09:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794850610; x=1795455410;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rii5YQlUEja2vE2dtvwqkHXBkQt4GcUimlE1aRsiXUw=;
 b=Gippd722gb60SOipjIO4H/5/zpVPfBvgbddNg0CYo9astUdFF8mmvnTmZtv/FdnrhP
 sSichoXXRilVS1LN2IsyYrYZoT28fAAB3hwCOsCM0wuwpEl5kf1bfcDu8g5RSWT0X6In
 U2OXc7W3WcUgtos9dcGmolw42P9fcln/e9VivCq1sjZ/ksEXwLn0XKBCYLG+wv1YYAFz
 VPtoEj98Luc5uwAohrcdIzMlBt5taYn2uRjHaZPbdZ7qGes1csJcStDxjTpIh/XTakM5
 ixRCxvb8x2tACZnsNpEpSfqTOc+puD8Altrnl/IzGcBHPUO3K5y22YUxYay//gdmJE4v
 Qf1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794850610; x=1795455410;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rii5YQlUEja2vE2dtvwqkHXBkQt4GcUimlE1aRsiXUw=;
 b=d805Zcn0MNzKH0Ogqgtpm9Es9rjd3uJ0v9gqIPhsxuNlI6gGQiwFdzuWtDsxug9xSK
 2rUHUHx7zvsPb8a9NB3kXCu9u1GHQiZHW6IEIx7JLpObOOfVIvwAItKMovbu1FfyojU3
 hnogwqSEnz5oidjHkvYW35ihXkmyvdSk05IWCjjBzoWgZkruIJWMN/hroXVJ2Fg21LDu
 X6Kg+6v3ut5ZyzQPThh4ARrN2hGcgTLvSmJF7aLHxYrRuOSS4Vaq5ltNqSwVw0loQmmr
 IQnELAN6DAcc7v3agOvfH/V6i6WF8ifjLSD49vZQy9jgK3SHwbXXrTgUKEvb/4wttR+t
 /YgQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEuGbsVJHuI/Ov0sqV81lsur4yv6A7mNtDntZiRFdQhPpk3BJ9VqvW5UUiQftGky+o2I6WsKqc=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9//Ca13PFZs9K+fOKFXH73/TLFxMRc3HNRQ6RP0F7S3I8msPfF
 0jYtLVjNbDB7Ptt7adDBRKlN0AfTzJKXvV+GmTRGNt5eeiMBhP9JpsU6P2BR36F7Ve8=
X-Gm-Gg: AYBFou3v7rawdpVJz5YkOWyLm2O7qLn61xSVsgHC9lVT8lWEkUAPSckxBHI0ee+zurk
 OsXzDyfD0mY45uXoQMk5MFZU7OSgZrV9crTTKL/rTQazxJA5EyxV/iQf81uesL0DU04hIMTW1HU
 vdObCfd6w1vfmnHn5o2dQmntPKHc6cCnFfweJXmZxL9pQbTx8B1ShBIe6FWY1ZKB0yDe6xeP1bq
 kNy7Su4nN1J+OvNqVo7qHplwI43e7SI8cLk03eUvN3z9dqEHrZdrDfZEFLilfsxzbgbe0PFDn8K
 CddLxbnI/WW4DMdjIxRZVRqOEblnlK70P6dd6+LJBpi8SCHuM041MH1TwhBmMeos+QcwD2Sidpd
 lXryunF02TgmVfhEls3M27GnV/ejuqjs7rPLHy4cLw6At8zTrJGbMFK0Va84INfJo1tGnWmOoZ2
 QgrTTvUlBDZqmKhh2Jesa+OazymuV1tlO/+BuxIC1kf/NKdFEtCU1aAUgCATG1qarEGaOWd7kBA
 qe11OVOcyZxd/l7VSc8oc3Q+WCb9Mr/7KEgRWLY+J30yHTLPuf83Rl5MfwRMpUbA1FgeiCZTdeS
 WOKMG3BC+DrVrtoEl3VFFWUDKTk3zxLyo0mgaHZsAZGpz5ngUleJMcPcUH5LvkLUFkiREOO2LOv
 RSc0=
X-Received: by 2002:a05:6830:4429:b0:862:a48e:24df with SMTP id
 46e09a7af769-862a48e25d7mr6274081a34.15.1794850610312; 
 Mon, 16 Nov 2026 09:36:50 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:7056:3b5b:7d85:4921?
 ([2600:8803:e7e4:500:7056:3b5b:7d85:4921])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-862880e779dsm10630825a34.11.2026.11.16.09.36.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 09:36:49 -0800 (PST)
Message-ID: <49911348-de8b-4863-9f86-7f52089f2904@baylibre.com>
Date: Mon, 16 Nov 2026 11:36:48 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] usb: onboard-hub: fix the TUSB8020B speed comments
To: Carlo Caione <ccaione@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Alexey Charkov <alchark@flipper.net>, Macpaul Lin
 <Macpaul.Lin@mediatek.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>
References: <20261113-ccaione-upstream-mtk-g700-usb-v3-0-78b554604bbb@baylibre.com>
 <20261113-ccaione-upstream-mtk-g700-usb-v3-3-78b554604bbb@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20261113-ccaione-upstream-mtk-g700-usb-v3-3-78b554604bbb@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/13/26 9:25 AM, Carlo Caione wrote:
> The TUSB8020B exposes product ID 8025 for its SuperSpeed hub and
> product ID 8027 for its USB 2.0 hub. The comments in the match table
> have these speeds reversed.
> 
> Correct the comments without changing the compatible strings or the
> shared hub data. There is no functional change.
> 
> Fixes: 89aa34bf38f0 ("usb: onboard-hub: add TI TUSB8020B power and reset support")
> Reported-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
>  common/usb_onboard_hub.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
> index ead8bf44cd5..f0e84730482 100644
> --- a/common/usb_onboard_hub.c
> +++ b/common/usb_onboard_hub.c
> @@ -312,10 +312,10 @@ static const struct udevice_id usb_onboard_hub_ids[] = {
>  		.compatible = "usb424,5744",	/* USB5744 USB 3.0 */
>  		.data = (ulong)&usb5744_data,
>  	}, {
> -		.compatible = "usb451,8025",	/* TUSB8020B USB 2.0 */
> +		.compatible = "usb451,8025",	/* TUSB8020B USB 3.0 */
>  		.data = (ulong)&tusb8020b_data,
>  	}, {
> -		.compatible = "usb451,8027",	/* TUSB8020B USB 3.0 */
> +		.compatible = "usb451,8027",	/* TUSB8020B USB 2.0 */
>  		.data = (ulong)&tusb8020b_data,
>  	}, {
>  		.compatible = "usb4b4,6504",	/* Cypress HX3 USB 3.0 */
> 

This should just be squashed into the previous patch.
