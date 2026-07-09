Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 118ADC44508
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 09:22:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D4D384AFF;
	Thu,  9 Jul 2026 11:22:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sdwA3MrD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE4A484B01; Thu,  9 Jul 2026 11:22:50 +0200 (CEST)
Received: from mail-yx1-xb129.google.com (mail-yx1-xb129.google.com
 [IPv6:2607:f8b0:4864:20::b129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9673284AE7
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 11:22:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-664d78637f8so2392442d50.3
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 02:22:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783588967; cv=none;
 d=google.com; s=arc-20260327;
 b=MYW8VEz97u78pHnvtk6Hq/hzDk/Ux4p6u+i6meBt9IEf9eHblbd2/OaJ1Ec6Ta0ejM
 m1DZ79zo6MGP/HekZwGXXR3pOlP65WAS8TlRpJotiwJyqhDVygWryOVrw7Qb2EjlQ/8G
 7/Ne7xcYMD+1i3zGj29BsGRX+NEp9kE8V+/QKhzLD1AGJz+Pans770Vor5zp58+j4yYu
 OZWknlR3pQymgNlJDkbKJbtXNvCAdLrcQHL9PwpvqGmvZ2Pp7HBy1YhCiKS39RGAhzxc
 hjVsvdpApS/3DcU3nGv4FWShM+pMAgRU6ZiErlh38o0nNoPSwd1I4MeFe1/ephMm5SZk
 NuEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Bjfd+E0U2jdqOFWe58XuNwIRbzeZLwtmwssum9MIPU8=;
 fh=V38ZUJKxcdlJXqozTolwU01RKxD8Otqlj8bb6/l6OaE=;
 b=E1iVtJrluzIBOBG4RiWXWPj6YDK7OASp9oO0j8WgT8C5dyS+tyk/vR2wb4pzo/sKJ9
 CMfreeb+Kq+fz9TUziFLrnyRWO9Fz4AwxXAToZmOrNOmiC5R39OqUWJSbQWc0s/ptwRp
 Fm9K+EmOe23yTdHxXlEOhCXh44cLsbJQIZpvmfpLs8rTikaJyvSWLmn4l1TDWhz7o5Dd
 f/YV6KWKqIv/1jYaoG3mgF4dfT0+RxMAHZc3ken31csd4QL+ybv8PiPRZnND7ihK35Wd
 vDI76KUZTsSK5QkJ5TskqInV4S6pK2Egfj0ZxR4Zm9pjneUGYSwIsm4WfxRf3kl++3dW
 yauQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783588967; x=1784193767; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Bjfd+E0U2jdqOFWe58XuNwIRbzeZLwtmwssum9MIPU8=;
 b=sdwA3MrDevilHSwA6RS282UfhsMTtbPHC00iypOcT0Vrz30mHsQNtjy8BV7eK7YsMi
 KaMusTqZBrSm7Tshg0p0zWg/lH8SOI0Z+4PYhkAPnSJFsgzWBN9jsYYD3lSd2e0LGLTD
 pYN+fLyyKPbrZMjJPznWAEexkI0+J3w/sE7aRVo96wBmEwRnHstOJ0Cd+POUl9vlNH6u
 5hYQdI+bQa9EQCA08J38P9OyqoofCPikVH6CJvSGwGJCVQSm58Shb/QpFrZ+4gMN8GYN
 vugtU6QJ1mSpm/rQJlXdBSUO0aUseLwJwpupNw3247HZW3kOIHpwxFE/nCT9D4RibWAM
 ntTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783588967; x=1784193767;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Bjfd+E0U2jdqOFWe58XuNwIRbzeZLwtmwssum9MIPU8=;
 b=S9V6XjA3hLXsbhmSJu7II1DlTM4PBcmvhC/g191eQOceo8oMCNXYqGXLqa3k5V3PWy
 rssJWiejVNmeLakPm4LChrVYX+KHkVF5sVE9+nbz90JjHyiioKhzQqmxJfyNA73SVFDO
 RRnyShQriRY5TE71wjekx7IPWdn+wsub/PoLZfu1Lt6YSoHZd04IXg+JtE+dMNj+ClD6
 oSGi2hbrCHcw5/LWXYa3wvHXGi4WqWl9gsH8aWOuiwBSfuMsFya52YYKrp5k8V4LLpfu
 K0b5szglkYIQo62HfA4lU+1KnKHYRYLED225bFQh3MK/0GwdLSGIVWEzAMy2B6ACxpV1
 0PkQ==
X-Gm-Message-State: AOJu0YzH0KnFahz2EDTyNea4d7hSPKL119CThNEIr+NMMo5SMjcEjlnQ
 oocsL3MgWryUebbwtTvkdPeX/rFZl1jr/xwEW5ul3F8BfrtUXMMFuQ+p8rUVX/gEp9busOOoAPW
 QoZALUXoQwBAW5M08anY+njd1XjyK0+vJ4UjAYz4XNRa6Yq1h021kV2OdBw==
X-Gm-Gg: AfdE7cliEUphryBAhWzX1Pel0U9/khHlBOPelQeLIK7oxRUj0O/Q7fGclc+SsMF94f+
 TxEQTjO96osf8WzbU00Zyi1rgxgj2JOuVdFh/nVODDCACjGtSC3iyVZGaBEf+xc+7aQ5X5GtmVY
 zaZ9EjcE5wZ6Pb672fTf23yyUM1cMAc2pIB5C3FzQxy/vuK0zfqv5fnJIX2OZbeco4zkk4WGs1P
 2nB7YFsahOUe2b6YbpA6VZqsKWFPKNopSrPXPAoDtBtP6IIQNPwvcHKP9gQvaCCJn4d1Khog5js
 6HfJgtiLLWlHWilDs9/unGvvryH4P+kkfh/xB1saIg2jbpK9nBg/mMJhfUIv2lkG0HCaMADJw2v
 z0l1K1IGLSHNhB3CxAZ9KGZMQDzosurTIUQhzA/fyspWO25eveQksbiYbOeVcFBTpy/CoHM2U+G
 ee3nWI9IPFlxJ70dkj9hz9tF/lmSzBLHhYlguVuqlBptk3mt1L1exAXZAkvuXmZnMSU3iz4n1X2
 ziOf/LPPZsrRUpWV2gmqs9WIXSNOgcF18/XLYYE+4HoxXoptkrgRSZvPGyPbVj4I3COW1YpPwvF
 yivwGRm/rkCrS58XESv5lcTV5rQPxjYgwFyC+pGTOJ8NsYPDbOny1BddQ/mKxnSU5F8WDtM=
X-Received: by 2002:a05:690e:14c4:b0:667:aec2:a905 with SMTP id
 956f58d0204a3-667aec2b864mr3359939d50.53.1783588967347; Thu, 09 Jul 2026
 02:22:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260703-usb-prep-dwc3-sync-v1-0-1352bc238c9b@kernel.org>
 <20260703-usb-prep-dwc3-sync-v1-2-1352bc238c9b@kernel.org>
In-Reply-To: <20260703-usb-prep-dwc3-sync-v1-2-1352bc238c9b@kernel.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 9 Jul 2026 12:22:11 +0300
X-Gm-Features: AVVi8Cdu_bruuKzyvjWxwi-iJUUiKxVfSACBuB08k3WgmUBftY1EwzUcKvtEnjw
Message-ID: <CAC_iWj+RAohmH1hdbgwfT5X4Zdj801BjcjY9WXguADu=zuQVeg@mail.gmail.com>
Subject: Re: [PATCH 2/2] usb: gadget: dwc2: Set endpoint capabilities via
 .caps field
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@nabladev.com>, 
 Tom Rini <trini@konsulko.com>, Jonas Karlman <jonas@kwiboo.se>
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 3 Jul 2026 at 16:29, Mattijs Korpershoek
<mkorpershoek@kernel.org> wrote:
>
> Endpoint capabilities can be described via the .caps field of
> struct usb_ep since commit
> 77dcbdf3c1ce ("usb: gadget: Add match_ep() op to usb_gadget_ops")
>
> In linux, the following commit introduces it:
> b86f33a3a371 ("usb: gadget: epautoconf: add endpoint capabilities flags verification")
>
> Linux's change also reworks the ep matching function by relying on
> these new capabilities instead of guessing based on the endpoint name.
>
> Prepare the dwc2 UDC driver for capability-based matching by adding the
> required capabilities for each endpoint.
>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> ---

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  drivers/usb/gadget/dwc2_udc_otg.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/usb/gadget/dwc2_udc_otg.c b/drivers/usb/gadget/dwc2_udc_otg.c
> index 9c85383fd62a..570fed347c9e 100644
> --- a/drivers/usb/gadget/dwc2_udc_otg.c
> +++ b/drivers/usb/gadget/dwc2_udc_otg.c
> @@ -828,6 +828,11 @@ static struct dwc2_udc memory = {
>                 .ep = {
>                         .name = ep0name,
>                         .ops = &dwc2_ep_ops,
> +                       .caps = {
> +                               .type_control = 1,
> +                               .dir_in = 1,
> +                               .dir_out = 1,
> +                       },
>                 },
>                 .dev = &memory,
>
> @@ -842,6 +847,10 @@ static struct dwc2_udc memory = {
>                 .ep = {
>                         .name = "ep1in-bulk",
>                         .ops = &dwc2_ep_ops,
> +                       .caps = {
> +                               .type_bulk = 1,
> +                               .dir_in = 1,
> +                       },
>                 },
>                 .dev = &memory,
>
> @@ -856,6 +865,10 @@ static struct dwc2_udc memory = {
>                 .ep = {
>                         .name = "ep2out-bulk",
>                         .ops = &dwc2_ep_ops,
> +                       .caps = {
> +                               .type_bulk = 1,
> +                               .dir_out = 1,
> +                       },
>                 },
>                 .dev = &memory,
>
> @@ -870,6 +883,10 @@ static struct dwc2_udc memory = {
>                 .ep = {
>                         .name = "ep3in-int",
>                         .ops = &dwc2_ep_ops,
> +                       .caps = {
> +                               .type_int = 1,
> +                               .dir_in = 1,
> +                       },
>                 },
>                 .dev = &memory,
>
>
> --
> 2.54.0
>
