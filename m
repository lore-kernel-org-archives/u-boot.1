Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7216DFF8867
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 03:10:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D098083BC4;
	Tue, 28 Apr 2026 05:10:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mCU+Qx4Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 183FA84099; Tue, 28 Apr 2026 05:10:50 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0CCC83693
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 05:10:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-baa8c78ac7fso1020396866b.0
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 20:10:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777345847; cv=none;
 d=google.com; s=arc-20240605;
 b=EgvUg8ndvCLtX5sbJDC8j9GvP/ZCDOvOQavvVbQEGj80tRZZ2PxB3z4sVDSnpaLziq
 JnatP7WAuFnBzT4NVJf2w8y/G/cP7wjIq0E783W1mZ5Z0XwL0G5w4q5W4t6npxgxtnqQ
 k3A5EzsdTrK9Nwbmq/50FVbdNSBXQlJcwe+bGFZuvLMGHyU0X+HIr5P74NaZgLDPagv3
 2SoDpUQecMj865p8Ioqfk3h6uEy45EWn73lAcoqpu3Xerev0eXKuEb7My2IBoTfUBxx4
 QpmYr8X4fSY3J8/kCeC3ZOP46xkVV5+Gp41SpGp3Uy6qWZQe2exi3H3NBRcfL3R+WJKG
 yGcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Os8ltA/2MY5HDo6RFb1mU9veYKrqWsTIWM9mlrYnMVU=;
 fh=WXe6DZf5BtAyNMJMA5zN1aIq60LfyWKNemHb+LeqHlY=;
 b=Ib36LSGdt0sbg0Vw2+rr5D0ozqAE6ZNA35knKe5A4Na/+aj6iM9cUK2qob3YopiOKB
 41jWq1lmXMvmowdYEgnrBBE95psX+dfxd1r62CKsgPPt0RoZLKA0tJ75V2TMb+mWQuL2
 WPgxH0eK8yKeaG0Jh5iU4ux/emE1oKxZ14p3+MSZTxf7RktP2k53MzQsPDOyeCMe6+pv
 uxowPmUyFTAbksg4ZBJcPQAwLqXZuLMstPzZV4j52aciKgbUEbiAPCm/CxGkYLXwohki
 oUN4YzMrJTY1PEDAgbtuU/WxpafLzZ/YrMzojXswPe/JlCKXYCjjzDfb7d4wgt7zUBAf
 V8Tw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777345847; x=1777950647; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Os8ltA/2MY5HDo6RFb1mU9veYKrqWsTIWM9mlrYnMVU=;
 b=mCU+Qx4ZvCm+rfoPyKGVcTUsRoih6ntUcAsYI9pvFgsTRqQNy+gadnvfwazIcdlRd8
 7eSdv9BX/I8M/V0s9MrMJ7YuOuj8nVIGuGJTxTF1Jt+ONVvlscGv3tWWWgIYHXHw+EXo
 yaPsoDRzitPaw08zyzvYHi+9KMMVlP6g8RFQgzCI7p3v7MTwtX2FRHNb5OcnZnKKgXKE
 Q5q3fzvQvTQByEZYYvD4b/ygaVMmE53DcItM+Gnx3Muu3S0gAN53aKK4TM0Cofb228qB
 GTpCaEsKN/lR0cD+5UiUxYJf/WVo7KQTswOsjwgg8QhdxcdlCenBonBzHRJUWinC2brn
 N7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777345847; x=1777950647;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Os8ltA/2MY5HDo6RFb1mU9veYKrqWsTIWM9mlrYnMVU=;
 b=AddqFK4IV1JbsymLFCRxEKIvIS+AysExn2gSgPpq+N7rpzPqHDedwCMGRHHqynKqSD
 x78PZ6IRoyq23mCkNQbiX6DQ/QgtdDSRGBAS0Z9MXE4WjUhP5iV8OI6MqZEayTGpVld3
 V7zvCWPNldzPlbITC9qhGDJrFnt+D27D3r3m4RJywITUVWM58ONRjsW+/Lt0A09NjWBN
 BMBZwiL4Ax4rJ8JPAu7fQfcxOn//UPVkLcaoahOo7U/EC6AAF/Aj8EPpwAJ1ItZ0TgbC
 kTJOIYp5faRHqK9x2xHvwHknXDW7U/zXBZDD0g0ReWzKm+5Y6bM/lK391cJGmpiyk63X
 6jMA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+oMv1TI00XwlIp7DrNl5LrjGDjTTIAMviS6Ayh1Swyy6HzhsQjZsBlGSv5zF0zbZvpi8fhUxQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yzyz32wU21Tw8yG2/3DFLvjK0PAQWZxpISN0kjMCvShdU0jXs4+
 BAlhYMBdfVZS+jMwxT9+ppWNzE3sX/r77BUVvorotbnRDFk3FTTVdccJJBctEVxlGsS/Qkob87Y
 RLDmcJLuZDHpz1v+eYJzzjAekdWvCAyEqGMyi
X-Gm-Gg: AeBDiev0ldUNZU0JIBQ5JigJ2Dstvh45Up4wjeyLkfx079xGBBK0Er2xuIp3dKfEs0x
 A2GkB4OZd9inOg/Q2Uw6I25yNEFIDGjG2EiYQeUFb3ijZlr+zFroXZsCirL0eRcUf14NtilRGrW
 /9smllfHz+/jddVaWb/BvbdILKQuca4WiFPTjx2Z9kwsAuBegi5gi23pupPKf3sxcAFqm7QvdJg
 /cnN75hmi4ay+Xwl1780+D58StjL6zVKAX4douPlhbwurb3G/IEVFnOLMZpM4OT8CDqYx8lj9zA
 oJ1C5Apk3diJArDaKCYuGFtoi+Awr/PtAtXp+vKs6vmM2tBWL3FGgOJsEiyGFkoqISM20MDN24v
 iywI7pg==
X-Received: by 2002:ac2:4c54:0:b0:5a4:1672:59d0 with SMTP id
 2adb3069b0e04-5a74660dbdemr204932e87.19.1777326491667; Mon, 27 Apr 2026
 14:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260422094649.57611-1-brian.ruley@gehealthcare.com>
 <20260422094649.57611-2-brian.ruley@gehealthcare.com>
In-Reply-To: <20260422094649.57611-2-brian.ruley@gehealthcare.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 27 Apr 2026 18:47:59 -0300
X-Gm-Features: AVHnY4JKFTr9Dl4WVrZABjQajdofHWqqed0YgAuzFl_ULINuB_zHuMgTLeG0q7Q
Message-ID: <CAOMZO5CF2Bt2+SzGWYOKwqFgEAVFe1PNEGM6DXaAqDm9xc8ikQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] clk: imx6q: add missing pll bypasses
To: Brian Ruley <brian.ruley@gehealthcare.com>
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Apr 22, 2026 at 9:42=E2=80=AFAM Brian Ruley
<brian.ruley@gehealthcare.com> wrote:

> +static const char *pll7_bypass_sels[] =3D {
> +       "pll7",
> +       "pll7_bypass_src",
> +};

This causes a warning that breaks CI:

arm: + kp_imx6q_tpc
+drivers/clk/imx/clk-imx6q.c:145:20: error: 'pll7_bypass_sels' defined
but not used [-Werror=3Dunused-variable]
+ 145 | static const char *pll7_bypass_sels[] =3D {
+ | ^~~~~~~~~~~~~~~~
+drivers/clk/imx/clk-imx6q.c:133:20: error: 'pll4_bypass_sels' defined
but not used [-Werror=3Dunused-variable]
+ 133 | static const char *pll4_bypass_sels[] =3D {
+drivers/clk/imx/clk-imx6q.c:121:20: error: 'pll1_bypass_sels' defined
but not used [-Werror=3Dunused-variable]
+ 121 | static const char *pll1_bypass_sels[] =3D {
+cc1: all warnings being treated as errors
+make[4]: *** [scripts/Makefile.build:272: drivers/clk/imx/clk-imx6q.o] Err=
or 1
+make[3]: *** [scripts/Makefile.build:497: drivers/clk/imx] Error 2
+make[2]: *** [scripts/Makefile.build:497: drivers/clk] Error 2
+make[1]: *** [Makefile:2206: drivers] Error 2
+make: *** [Makefile:189: __sub-make] Error 2
arm: w+ imx6qdl_icore_mmc

https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/1434015

Please fix it, run it through CI, and resubmit.
