Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5FE8C98332
	for <u-boot@archiver.kernel.org>; Sun, 27 Sep 2026 15:07:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9752260687;
	Sun, 27 Sep 2026 15:07:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RXQVFjYWvLhX; Sun, 27 Sep 2026 15:07:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D7296606B9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790521654;
	b=IOcSra4VqPRm1ItWOCD35Kk24gVlYfmepmg+Y2A9+upL/Bt/K0+Ni/WGML41gxOO9bZf
	 5GSHu5wPcbrpa5RjNlJZsVZpI6Sgjv7BEZ1c/LLYggl1Af4DpXe76j7uMqNTbjUtmg6fP
	 tpHXBNpHMWTyflivGASI7G+xRCKyQt6w5qM5xtL4wx0+Q10f0oo84/Js6Wn6RZ18ZVvai
	 HR2lTpdCSZZbiSfNkVOW4vmdxIi/tV+NwGvH7nLrbeQEz1LfeqXte1DACw6Fg1oFOsQg6
	 HVpxZBs9vGdTd6Cmjmu6noH/59uCYkwGZDIJTGM/C8wLeCMPl01hB62mACos9kECdOQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790521654;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=KXzM0zm1Nn/WWcO7yS/yTCvaIKhokwf9GXMThjZh+Fo=;
	b=pks6QA/mKgXrrAoCOzMNzecJpnbPhAYjevlkahHQFetFdmd6qTiOkhDtFus9x3kRKu+F
	 ERUuQCcE3oRkMd/XPdm0Hf2UyiE5Np/rfuOTwryM8VNqeN4UkMWy1mevnAeWp3ih5fgXh
	 sCZJr/Ri1Z3Mx17p+SfpQmXEPkLS/uFWT0WT5TpO+P6qiUnp4lBDcgR4mN/Vq0LsDQu5h
	 tflByEOdSvgvH8nzBbOuhV+GmQzfZ6jcbYKcLXBjcPwIgOarbQ9JOX4nvsDu8bMZQZemG
	 zxKOUnA6EzmsXzgLcCILHzUsHPw8C3EIBMBTga/ZTR1xYQ5+0PRxl7LtJbMQ4ZQ1xCA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Jtxu4LCR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790521654;
	bh=KXzM0zm1Nn/WWcO7yS/yTCvaIKhokwf9GXMThjZh+Fo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pue1qa34TDVqSVV+1kIEWUdhdkbhVEjL3I4Ivj0ozkOHBoDOK9MEvZc91VsGZE7La
	 SY7eqIie2M4VXpwlPhdlijvjPqMsEi7nJcCq95Pt7DXV8dE68VJL/zWfbM4EfI6xF2
	 DiLZC726WvQ9QqFOTcqhTj/G3EKJO7WtuZMNiSBi3OOqWwCXux0IhzA4j0v06rKv17
	 B70HwDxEVrRYShQhG3homwUP6u6KtqdU4RlG/NfP/2LrQ9L0H2Wp9Hr2H0BTJuropP
	 l8eB9W6TztlVAc8yVC/Qhdrj4GD7/ita14ejogfjZb9dACp2tSqN2vaqvpMorzwa16
	 Arqgi3/1QpGNw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D7296606B9;
	Sun, 27 Sep 2026 15:07:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5D4FE334
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 15:07:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4389F606C0
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 15:07:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xfVmG6CIDVV5 for <u-boot@lists.u-boot-project.org>;
 Sun, 27 Sep 2026 15:07:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 63F5A60680
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790521651;
 b=iZzOpaY4QYoI2AxulN3wfotMX0E8ExJVPcPQ8XHT+TIL8MIQKuD1g9KzSMrlkeEbWNd9
 kCXLlv0xR1HWRjTAKHM1O9/r0MSgrrTZLKgIlUyGWXWGcUZpapmeFIh01cphXHoyvRLjt
 vUc3pcD4WGASy+XZYEtvlYgWa1rMwngNy8dA/sjdoPSsU67+4GbdnmmFLxVuzJ2HADOOk
 YBNnXBlwnwkt6H/PuryjUxKbyw5CpI2JheNim3VUn8nRq3PsJYj9rj1GTe7zPYKD4m1j/
 aNyXUs1GwkRyLpNwCZnnOnSX/bu9gDZ5gUjPYeiWC9OcvzsYgaDJeJCFuRJRAO7c8AQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790521651;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=KXzM0zm1Nn/WWcO7yS/yTCvaIKhokwf9GXMThjZh+Fo=;
 b=Xu/j51jqlz0f4DJDAoSNhXjodpEPaIJU68rQnW11tvilVHyDczDLOLqjTYuAiiwNgueQ
 nBIMwv/wwnF1HM68Bp1gpaBzwsw4Pgy27Kh8Cm2NXLnELbxFq35rSxOPt49BkH9IfZuKa
 Sffg5Wh4QiZGSMp1soVMKiLerZ2ZT2P3VI5Met4uV1cMYhGtbz76uWts35btdvBpNF3q/
 uL4oYZlD5ZkfwQq+8qKBNCia03EyEupZHaoD17yrsGgncb2wFo9YFFCrSbO7HZJMH91j7
 etDVe7zKrVbvGUit06VHKV1oWmPbq+L1r+jJ3b+MTalKdLnMhB6IPgxb8f7jbQNNquA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Jtxu4LCR; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::10; helo=mail-ed2-x10.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Jtxu4LCR
Received: from mail-ed2-x10.google.com (mail-ed2-x10.google.com
 [IPv6:2a00:1450:4864:33::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 63F5A60680
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 15:07:31 +0000 (UTC)
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a6063d7dc4so2660213a12.3
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 08:07:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790521649; cv=none;
 d=google.com; s=arc-20260327;
 b=qhul1oSszG2wZdHEzCY5dUTzZlsd2LpfK1UtxhO6FRdeCkSKw7joOrv+/ReydMnjM+
 2EnXyCGEMfx2RX/fXLvXiUkmU3jXblt97tyB75no7rN4UG7Is5lA7wtP+vL3c4cI0Y+H
 VO+bAZWUlS3eBOzDaH+rNgnYqTA5INLukX0TFa8ARnKKP7XSGy2H5x8u5UMXkIJXJnUq
 o5rpMhJUWUEyHa3OUeiX5KJePnR38Fmscf6E1Ba2nFxu0ff2pBQzNxgo1TZsapIOjNA3
 9QNXEyymDETx6shpJaXxVZ347d8SkGfuDn/iDzuvVFGqWV5M14UO+tnV6zT3j4wp+EUT
 NSyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=KXzM0zm1Nn/WWcO7yS/yTCvaIKhokwf9GXMThjZh+Fo=;
 fh=5jVohUtBtVyUXC7F5u9qSihAT3eMkiYI8Y3ldEk35+E=;
 b=ZfW5291EYngBu5Llf9nnvYzl3ngiFr6LWPA0fIQVdTzo4Rqm+O6gQ5VVl9DxKfQIeu
 xjftCdC1JKlTj7V02eQiGg9Nj2tvZ90DpZ6kYOLIsYky/zt4RPQmZX/92XIeuWa2/ltC
 MirDSdlkZLD2+R4cQU5A6MhdCbotyezIDt4UeK6FlbIEEFoZ7NHIwtxlQWn+kEHoPn5H
 SccKhKdIn4w2xDOvl6n37+AQKEIyLIPI2QcsskkxLSc9ZYN1rliCpU4z9IwKqVjcrdKV
 Efvy0TkDJHs0m5chaDM/3rrcJOp748zHlQS4oMDn3+SNd8ezdI3MRlcqsJGb0WF13XdQ
 CLeg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790521649; x=1791126449;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=KXzM0zm1Nn/WWcO7yS/yTCvaIKhokwf9GXMThjZh+Fo=;
 b=Jtxu4LCRmJHJuwE4DbOpqJ7OIGHYWf4mcgyaDHsylCD5stSZr0huYPaneeUwOPbsK/
 1VsvuFxO2UNCc6ZvypM90VQKyZGteVQb3BAJ1ltOni7YbB8JPHVDrVglBBxV4pcummWI
 ytGXTsOFoj03xjNcRJh2VXPJ7QxJGh0kHBX2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790521649; x=1791126449;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KXzM0zm1Nn/WWcO7yS/yTCvaIKhokwf9GXMThjZh+Fo=;
 b=tUqjnNbeOr7wA61gqU7wvT+Xr6MJo+V8kKOS59kuCDpxx2f4lgqjvV5M0BI0qCkEXT
 d7AWfmut3bIZcnQ5cL121eXWBJ9cLJp0gM0bwBtBCkO/8I8FzxJ+D3K0jSUDVXgsRgZw
 uNwBaK1TIOitLbcSQtovCJxHipLMK2PFsptu8UgdWJAYUg/846bq0R0+V+vVQS6gnQ4N
 316p7ptFUWmb37+iDsgeoVAH0h0/44QaJ4PuUNFxiPlD9bimlM03zpRccC7uPHuh7ghS
 eT/wygsl9AGew2yl6guG7otpK65UM6V0P5qaIm2mGQvOxoQf7/qxyEEpXbZJPZM+qA8E
 reDg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzfM2dQY7y+GGCLWBDouL0nTLRA4DnrW1ldbrLAESvmjj1bDk4tAkhKyENeTLtDWMniUk1okoo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIC5KX5NPHLKUElzG9mGv6G1nD77mgsO8m3tmFGL/YColMjp+HH
 L8J68vkClZxulzv3WZiOfthyY0bTitqKLqK90GEzBdOgUTC5WSRRP6HdvufHYjzFsxHHd6enJjW
 I9CnHuixj2bQgrN/WD9Mg+ZGxUVl1dmpa7biuH1l7
X-Gm-Gg: AYBFou2DLTC+u9NNxjuaNQBQwu3J1fK0Kr1/zd1Q+0vbwkkP6BIHfJkIwOezz2tZcWf
 7IwGaDWdlO2madL6mYhZ0fxUxkQiX8rInqDr0+u16TrfWblBuFRmvaQMDEktVvvCF85r2us4Eua
 ptIbvCHWfodaXyGGH+v9am1rI1/CbdqSvNy00RAXs6Xuyze3zZkbAGe9ATdpwM4P64qdiEBpyMq
 wjy5BK0y91/yWtB2Sl8ro0mhwLVXlujzgPz5PTfTM//dTooyDlUjV/M8cH5FnN4kpeX3HNRf50H
 tyOAiNvtoHJDCEWEPDAJnzkzGD3UuYHZDPe6Zbdwep0GcNB1Dg6ugPBURaNjV640
X-Received: by 2002:a05:6402:325c:b0:6a5:f4eb:df3 with SMTP id
 4fb4d7f45d1cf-6aac8ed4c51mr7148442a12.2.1790521649230; Sun, 27 Sep 2026
 08:07:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260925105432.0F27E68C4E@verein.lst.de>
 <20260925105633.90F6C68D05@verein.lst.de>
In-Reply-To: <20260925105633.90F6C68D05@verein.lst.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 27 Sep 2026 09:07:16 -0600
X-Gm-Features: AclHuK-r5Alie2lC3Q1wi31sOfARls7ndZEoVbL7CXoUuw8yXoTBlrVrLRtpWEM
Message-ID: <CAFLszTiRYYaJs78QeK4ucmYLdqEWveEpc9Asc01jbzdYJAicbw@mail.gmail.com>
Subject: Re: [PATCH 8/8] configs: enable DWC3 on RPi5
To: duwe@lst.de
Cc: Peter Robinson <pbrobinson@gmail.com>, Matthias Brugger <mbrugger@suse.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heiko Schocher <hs@nabladev.com>, "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Martin Schwan <m.schwan@phytec.de>, Rasmus Villemoes <ravi@prevas.dk>, 
 =?UTF-8?Q?Filip_Kokosi=C5=84ski?= <filip.kokosinski@gmail.com>, 
 Anders Roxell <anders.roxell@linaro.org>, Michal Simek <michal.simek@amd.com>, 
 Peter Korsgaard <peter@korsgaard.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, Peng Fan <peng.fan@nxp.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>,
 Volodymyr Babchuk <volodymyr_babchuk@epam.com>, 
 Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>, u-boot@lists.denx.de, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
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

On 2026-09-25T10:54:32, Torsten Duwe <duwe@lst.de> wrote:
> configs: enable DWC3 on RPi5
>
> The RP1 chip contains 2 DWC3 blocks. Now that we can access the RP1,
> enable the drivers. No further patches or glue code required.
>
> Signed-off-by: Torsten Duwe <duwe@suse.de>
>
> configs/rpi_arm64_defconfig | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
Tested-by: Simon Glass <sjg@chromium.org>  # rpi5
