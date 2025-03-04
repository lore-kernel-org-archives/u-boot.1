Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02EEBC282D2
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 14:51:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 775438006D;
	Tue,  4 Mar 2025 15:51:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="adqgRJjd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57E64807D9; Tue,  4 Mar 2025 15:51:13 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E460280017
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 15:51:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aaeec07b705so898499666b.2
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 06:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741099870; x=1741704670; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HfuXJUazsfYtRMcZrnCcdLelzGbDn1i4Eq7eHhVcmT0=;
 b=adqgRJjdiqQsyUwL651aw9wPpVn31HfFRuCYwngj2koGnxTre+UWRz5fFvMnOJ4wIV
 rtd8ip0e8Tzb3mC9Tk/jt+ZnFZMQcrdxgdaW2lCO8+i+xfK+0Z9NyTGdzTJJG0veBRdB
 qPKV6GcsOMmvD14O+rdOHSkZ/7uJ2/9FY3zY3pww5IZzYsWu1/kB7hoSDb4cE7jYoC5b
 YdqZUPxyHeq8Wj50S7HgSQz9C1bio32aGhodc9fvBRO9wxo5L9OmmGyr/usnULg/NIpP
 UP8NVrNQs9Wt1DS4gdzSkJUzCryrPO+IDEAK8df9fvbQR64zngPWQphjxjFkAOwPgmJk
 Upvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741099870; x=1741704670;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HfuXJUazsfYtRMcZrnCcdLelzGbDn1i4Eq7eHhVcmT0=;
 b=FrbWJiKMcWz2qISbhxvnFR3CdiVDGZ+/FXZdXYdgZr+IJjIDaTx5Dx9Y2mY4+6UwAd
 cm2QYEU4Rywo2TVPWt2s7nGTYoxj3XjT8QPwcBY0RF8nmEfNdrb1hCs2ktyabz2HCEzi
 OneJHgZxGSjrFfDJI2ChJzXDvwf28/p5lU3IR7EBHzpy9k7L2u6m+DGKBALlJUJjfxG5
 54qJH/TiLRSOjUI0B9d5i5ZTpjF17yllcn3x97zUkLzEMYhUeECU/37ZhpAGEhu6UOZy
 VY28SMtEzaxUE7Oh0zVLxK++l+FpQwaRoAmKaO2BsXZYLRSJi+hj110lfM6nzD12ZK2q
 pDPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXS+sfmeqQQsQ/4LOsiPYmQmERrHys4YpHsEQtqcwbzr7/QXwA/w/M9bbrnuRaNH+rE9ndF2Q=@lists.denx.de
X-Gm-Message-State: AOJu0Yw4ukvRg9LTi/qHkvTWdp98M6UT49lknowrisfvOgJe1mQOEHO+
 4930d58S3LrhlreNxhBNvNcta7KjkBehizQLMK5Qq6MPswwCKkwPE7Uj1lbzj1l4fZpewwrCYBS
 H/PfYqfan4jTy2SvZkafNcxl3H08=
X-Gm-Gg: ASbGncvUvhkoJmuFHh5S7TlsqGpbYAOfUm1+SvIBtR9V0dgasEVEMSXPX0NS0G17mPW
 +nSm/BmuerRlHpsoiDNpgxvtZQrXjBuZdBFgVka8QFtStVRswYNFCrjLkTwk7gdETMYHHmA+vAD
 iD7Nq7DX0AsozsFs1e3nhztbaVSw==
X-Google-Smtp-Source: AGHT+IHylg1+0fFehtC2V843pogNGhtMtoE7qKvBVt6T6VWnMPhbQFmGkWbot6mrT6INOV5n9Vlug056sFqF/3ktwgo=
X-Received: by 2002:a17:906:fe44:b0:ab7:cfe7:116f with SMTP id
 a640c23a62f3a-abf2684a9ecmr2268412166b.46.1741099870006; Tue, 04 Mar 2025
 06:51:10 -0800 (PST)
MIME-Version: 1.0
References: <20250226184506.64114-1-sebastian.reichel@collabora.com>
 <CANAwSgSur2VawHniSEZBD3AO63YnvUGf9m1_8p-XMNxQF+yziQ@mail.gmail.com>
 <CALeDE9Nq_xbOc3W8hefPQuVBi_Xc_2r18cw6+jeEHeGKyHEa-g@mail.gmail.com>
 <CANAwSgTu3ixjQRLZRqx_+nHNinDJSdphHHELtiHLANs+LF9YCw@mail.gmail.com>
 <fbzod24w4kjhntzcnt36znqtyfykoao7u6g37wvzejtxxyljm4@w44tbipyhfkr>
 <CANAwSgTcDL8o_t90+aL0g0FnvoiJE-risKCJBFrYrp9DukmtVg@mail.gmail.com>
 <oxb7v5iwqjgyhsk2tc76oybmnmfvvnen67g32vpht3fgnagvif@t4enpaooabmv>
In-Reply-To: <oxb7v5iwqjgyhsk2tc76oybmnmfvvnen67g32vpht3fgnagvif@t4enpaooabmv>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 4 Mar 2025 20:20:51 +0530
X-Gm-Features: AQ5f1JoNFKn2Mx3-A29z44iscw-hepyK3_Y_n5hL8nfbPJKWhXSsxX9lD5hh_GM
Message-ID: <CANAwSgRL2fMzGWdywdzp2BrkYWE0bw3RHa6K-Xf7ByFgjY=a5g@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] USB-PD TCPM improvements
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, 
 Jonas Karlman <jonas@kwiboo.se>, Soeren Moch <smoch@web.de>,
 Tim Harvey <tharvey@gateworks.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Maxim Kiselev <bigunclemax@gmail.com>
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

Hi Sebastian,

On Tue, 4 Mar 2025 at 18:12, Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Hi,
>
> On Tue, Mar 04, 2025 at 10:35:03AM +0530, Anand Moon wrote:
> > However, I have a question regarding the Type-C controller's
> > connection to the PMIC via I2C. I didn't see a corresponding
> > controller node in the device tree source (dts) file that would
> > support this function.
> >
> > I feel this might be causing issues in maintaining the power state?
> >
> > [1] https://github.com/u-boot/u-boot/blob/master/drivers/usb/tcpm/fusb302.c#L1285-L1316
>
> There is no direct connection between the PMIC and the fusb302. Not
> in the driver, not in DT and not on the hardware. The fusb302_get_connector_node()
> function you are referencing is for the USB-C connector devicetree node.
> You can find it here:
>
> https://github.com/u-boot/u-boot/blob/master/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi#L35
>
Thanks, I completely missed this part. sorry for the noise.
I was checking the upstream dts dir.
> Greetings,
>
> -- Sebastian
Thanks
-Anand
