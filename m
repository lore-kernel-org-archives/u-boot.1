Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38EDBCD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 15:27:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDBE884CFD;
	Fri,  8 May 2026 17:27:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KdkS7Vkn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B4EE84D05; Fri,  8 May 2026 17:27:55 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C7FB84CEC
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 17:27:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-67be871ed3fso4126865a12.1
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 08:27:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778254073; cv=none;
 d=google.com; s=arc-20240605;
 b=fdZzInwxG0v9F5hqnr3Bja9UK8QTWsKhkZxecKlu0wf/flUwrmcdOPjeq2IbMdP3wd
 RxV0LhM0/JMYqNPgsgfW7G3ZEP969U8RobS96YtP236O42VeIJLChNYRqUitbATioUip
 J7vJZsa7XvFnGQe6OGyOFVA+k8GTJUsCxCnubs53rvJ66KSID80uu1nl9lk+EBjIXyne
 WdfCoVe5DIsGeotJpO6nLyCRI2Gw2qlUPAaTa7hxRwrHoUl9PUUFmc4L7ZdnsgZmr5Fc
 ie1s7MQzlTo4DGeC5t5WVG3m7JUGiTlFemsq3WRBo9qWhntje0Pp1K/L4rs8vjMe+o0Q
 d+tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7tPYT1HhyFPv9SWzQmk9c086Fym84suAOqsseI+2iUY=;
 fh=cXLM2xWHT98EMji+CvqvFHfrMeoAXhLsVQYbWE9nUP8=;
 b=g8aIE4h7r4U9SsH9u4VKEOjjrX6ax0XnAO6idbPpdT6qJ2tAPmrCHFQj87rzMv5ltV
 Y+gq/4b9dC/hC3vHRq2fnduKWGVdfP5QnQS/V6/pp1d5wFbZrfGW/f+wFlBGdZuJ7GFM
 LZ+AsmZ3YZCdyzvuDdxoZAng5TIdKQecjfiW9Fq0odV8Cs+lXNJhJMPG/qtVe5FcZ86C
 0Gq1tQEV9TOrYGkQQfhZ6LUGQfmDYKIcMaMkrLY0Aqvx8vQ8+s/wcvwxUbQVTBIlNoJ4
 GtsLD7F4mes2RhluxjaF4nm7PAKS4af7IbK/oKFKyIUnmVQfSB+TcmDeG8soYR8kC2us
 jECQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778254073; x=1778858873; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7tPYT1HhyFPv9SWzQmk9c086Fym84suAOqsseI+2iUY=;
 b=KdkS7VknDIQiabmutmQ735dPuwvin5bM1RRMoN3E9/hn2kGIejriAf7ttWEzjIS3sg
 H978tIZ7mM0o7AurRl6b1x6wVSPRlz51FFfY/dTbumUN+JlBWsn6vmY94j5ADtYYEkNW
 Et7tOm4ZTAQ6sC8SKf/3wVGUCNZsvG84Ok1GI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778254073; x=1778858873;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7tPYT1HhyFPv9SWzQmk9c086Fym84suAOqsseI+2iUY=;
 b=dUZYjXEYQpQ6j3cLZ3l/YSfIbsAxmm3xZMtqd/H7iRIpGi1obrSnomrtPxWnPwpFWK
 n45z+nooG2KfLoN4IR/vVXUcB/f5+5ZLTYnNZwAVod/nCd3joI3jXI5ZzsiRyktmijIF
 x25qLXXFs8Nn7CRa16/9L8OAwN6Ns6X4b7v6TfJFNLwT5fnZVlHIE94WtQ9lv4VMXHxT
 70OLOpFOoMnjXKX6zQEYQN6mYZmN8pkykZAqAyZHex+iZGtl8AhXVH4xMUklKym30WTU
 Bi4Oqu6O8JiF2SFcoEXOk0vaXjkgfMnus+uRB86vkBGQ98U9Ah4akitQIgJiBFV0psAm
 jyhw==
X-Gm-Message-State: AOJu0Yz7nRazoJwPVYsJeTOfx9F3s4dsCDjOx6186idTV57131rFeyzB
 2u1Di01SvrC0ya/HwjFe690nR2yEPApL+2wdHH0LNwN7/G5lb11yh+1t8UVEABYlL1BXq8Gn16P
 Y5924BbLInQHOzAFd3s7FvoeNyaQqxzYXavztGzhj
X-Gm-Gg: AeBDiesN536pqGdMcJuOwlZ2JUJCOu0Rpm3NhVPGJ+Ztt/cWZYEoNKF5Xjo20whpVRk
 4Glh1VzGvn1jcwF5uW8ygXk8WgMBamLDk4OeqBMZ/NpGRR9yG4nxmQ3OpoMH1hVpK4jI3sXxi3n
 ZGNXr4EeQp4lg9bo8OZoqj0U90mHAWo5lsS4XCNH5BtjI1mv2712ueKHQyK3x1t746tiWzp3VLq
 nxA0XX6RMRMN75595vjGUPimxGaHUHLBEAuNt5yof4NbwXvPh781q2Kjiw4RukUWr8iq68QWp4c
 wFYNbZkrHAKKuBwr
X-Received: by 2002:a17:906:9f88:b0:ba8:ca25:e6ab with SMTP id
 a640c23a62f3a-bc56b626a5dmr763626266b.11.1778254072950; Fri, 08 May 2026
 08:27:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260507092843.358908-1-jens.wiklander@linaro.org>
 <20260507092843.358908-14-jens.wiklander@linaro.org>
In-Reply-To: <20260507092843.358908-14-jens.wiklander@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 09:26:35 -0600
X-Gm-Features: AVHnY4JHYyBMIRpI2SIPQYopIi4q8d39ng6Za9D0k_IepimeIpgieya6CSNLU2Y
Message-ID: <CAFLszTgouezRRc=EPWYN-YLDFOh7N9tGrnFmFAjG5JxMz_1f7w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 13/64] usb: dwc3: import from kernel v4.10
To: jens.wiklander@linaro.org
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Anshul Dalal <anshuld@ti.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Eddie Cai <eddie.cai.linux@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ion Agorria <ion@agorria.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Kongyang Liu <seashell11234455@gmail.com>, 
 Lukasz Majewski <lukma@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Rasmus Villemoes <ravi@prevas.dk>, 
 Ryder Lee <ryder.lee@mediatek.com>, Simon Glass <sjg@chromium.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Varadarajan Narayanan <quic_varada@quicinc.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Zixun LI <admin@hifiphile.com>, 
 Jerome Forissier <jerome.forissier@arm.com>
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

Hi Jens,

On 2026-05-07T09:27:07, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> usb: dwc3: import from kernel v4.10

Reviewed-by: Simon Glass <sjg@chromium.org>
