Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF6C9C54E49
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 10:43:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3708D87E52;
	Mon, 26 Feb 2024 11:43:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZzcvU/yU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D47C687E1B; Mon, 26 Feb 2024 11:43:43 +0100 (CET)
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com
 [IPv6:2607:f8b0:4864:20::e2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3FE887EC4
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 11:43:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2d.google.com with SMTP id
 ada2fe7eead31-4704e6dd739so341171137.0
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 02:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708944216; x=1709549016; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=p7G7H/cg2WjFxYODfdM/L8kD+4I8rOM6yxyMBirHNww=;
 b=ZzcvU/yU96aLu/IFZ0eqbM/8GtGl+zzsDtPFB+z+pnshyjM3hAlbmz10Pb8JKMUa15
 WsSVr1bMCUerg4g2wck31/J89kHTrE2lap8iiArJsGuOMUTBW8o9HuSKQQcWTXRkaz29
 CNLkr8a5E6k6q3WF7h2CJxoZKfsFjORg2/sejhtczSUE5ME8YPmoLO8AAm8AdHvUUybE
 3XP7WDmYmm2qGE4niTwp4717JhcEvcYwN+X8g6Gutxgc5mLO2vE7O6vfl4Svlcm9JPsG
 NsnYY056ZROWshL6NFiXSP922e72+gn1m2LcpJm8c6yx1IGFaQgMAtsCBzxH9O02/sz7
 Nm4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708944216; x=1709549016;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p7G7H/cg2WjFxYODfdM/L8kD+4I8rOM6yxyMBirHNww=;
 b=uA70cys3nS/X1T0ydDEBwVtKrJFe/YpGEge4mAKHu7KcX59TRZIs2cMV2VxumdTwT2
 at/8dbNCv8IxHY+fPDHu2oklPX3ANJPSZaDlfvO/ra8aA9OJWTJisrxoobZLUVd1/L9l
 M6kAeeHDHKqnSfrxXHakQODfNBfTCkaC5cvWshCGfzJCsVo20xLBy8AnvX8HI5Y+ZD16
 0JjPJ48QgbV+4ZoMMBD8T6GC/LKzckh094RudhU/YJR+t31jcy3roSL6QrHffsiluzez
 TkgiMMXOsCcOx0Hj3gXKqKxjOrBtKXOqMlokwMsTaxGZj/JFBwgg1jX7AkhcInVl7kcv
 q5CQ==
X-Gm-Message-State: AOJu0Yw3kukuoYkUDKB0mH731RMh/rb9Y992DBCYR6cKMTwaEOGK0y8n
 Cim00o4A7QR0InahkVcV00gUG5Jjn/r9zFIAV2l+ujRxNWLe4pNC8sULB7MVYo4jzlZy+5F6TnD
 EiVzy890yyJmcQE93tgKfgZblAPX79V5oygWFaHiV5d/q+fiD
X-Google-Smtp-Source: AGHT+IHm3XsxYbLBYi8tI38c9l6wiv4Qa2aIKIGLl/Jyv7ojB4rQ1AlqoLz2623t6u7vpk+oRQDtbhZK4eY5FdLXUVg=
X-Received: by 2002:a05:6102:50aa:b0:471:e217:cf8 with SMTP id
 bl42-20020a05610250aa00b00471e2170cf8mr3261315vsb.9.1708944216394; Mon, 26
 Feb 2024 02:43:36 -0800 (PST)
MIME-Version: 1.0
References: <20240226080433.3307154-1-sumit.garg@linaro.org>
 <20240226080433.3307154-3-sumit.garg@linaro.org>
 <c8f5815a-bbec-4efe-95d0-77dec441a183@denx.de>
In-Reply-To: <c8f5815a-bbec-4efe-95d0-77dec441a183@denx.de>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 26 Feb 2024 16:13:25 +0530
Message-ID: <CAFA6WYOhyHzn+XOsUwrqs5kajHjSFhDcsHGu6=CAB9dT+VCV8Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] reset: imx: Add support for i.MX8MP reset
 controller
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, marcel.ziswiler@toradex.com, francesco@dolcini.it, 
 trini@konsulko.com, lukma@denx.de, seanga2@gmail.com,
 jh80.chung@samsung.com, 
 festevam@denx.de, andrejs.cainikovs@toradex.com, sjg@chromium.org, 
 peng.fan@nxp.com, aford173@gmail.com, ilias.apalodimas@linaro.org, 
 sahaj.sarup@linaro.org, fathi.boudra@linaro.org, remi.duraffort@linaro.org, 
 daniel.thompson@linaro.org
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

On Mon, 26 Feb 2024 at 14:24, Marek Vasut <marex@denx.de> wrote:
>
> On 2/26/24 9:04 AM, Sumit Garg wrote:
>
> [...]
>
> > +static int imx7_reset_assert_imx8mp(struct reset_ctl *rst)
>
> Linux calls those imx8mp_reset_set() can co. which is less confusing
> than imx7...imx8mp() , use it.
>

IMO, it would be more confusing if we choose two different naming
patterns for the same driver, see existing function names
imx7_reset_{deassert/assert}_imx* pattern.

> In fact, why not copy the code from Linux outright ?

I suppose the question here is to not convert the driver to use
regmap, right? If it is then that should be done as a separate cleanup
patch.

However, I can extract common bits as imx8mp_reset_set() for better
code reuse as the Linux kernel driver does.

-Sumit
