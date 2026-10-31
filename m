Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D001F606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 08:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JRZup+XY;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=gOrex8it
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AABE360AEF;
	Sat, 31 Oct 2026 08:43:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DZSYXQSu9kfl; Sat, 31 Oct 2026 08:43:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D1B8060ABD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793436205;
	b=hlyVIxOytW0lLmxJ0k7Wbp5OVPdOK47OU69u11vGRfJzP9ywhpuHsLJuXEcnu+AKhg07
	 ZC5b5LjSdG+Rdr+4ZkYcxReTBo+16TRLR07p6kgPPbG278nrVuSBOB85r0pwINOrwSMeG
	 bky/FHdOA52hdE2ghc45VMaFmucLOAnY1oGtWGV4GkOtWjA/pVZP2Lfk4+SlrUiWVQo59
	 dQrIkx14fCs5ncWAEWVuzrGGkWAo8zAh/vUajCxMzhrwD7oGq/5Mj69ucD1Pp1LNY+cjc
	 2xoDIsMj7qqSllmaIy930A76xP4B2gxwu8jELLwtJ3OmMgpgMWBuBahzcSjKwoJm5hw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793436205;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=3FoV7YdUAX+T8pufrF9mePH0BOBY16f1I+gHEIIEJb0=;
	b=Y7qEKyO53Yf7Xnz9PF1cwVhUYTuHM4b8nG+aKduecL9rp7COJDlRQyFXJ5n0a/KVAtn5
	 wv4HE+yMnc5Vozt21OYv0ObJ4ZZJWPMTvNH5QaWJFyTPjSpCIU1hYIbFYO0qXUa/y4V+w
	 G/GZo2ElQ8J1zM93v62TLJUgK+NiXnm8X0lFQmgMzI6H3A4+U1t7b9FXDPwp5O3Kq+8uF
	 iysEm3j2o9YdH7Z0h44GVR3LrEOGd+iiGpzl804XYSTuQPo0NDzmCo9BlIXuiqAlldv7u
	 6/hKq5XP71a9FJfW135jU6BaBvMMvY1zXYRLdJvk/cJdvH0jc00Y7bxELHajv5Gm4eg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793436205;
	bh=3FoV7YdUAX+T8pufrF9mePH0BOBY16f1I+gHEIIEJb0=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JRZup+XYOapm+XwtrnUMeSSYwgor+bFStCK7MfVcm/1jGrFjqbOR0EB3Q1LYEI6i6
	 NIZTElWPeSB+hV9T6aUpYd7jZLy+VpXRmkeJq3JrjTQobhU591HmuPUz0EryOBR1X/
	 S/WToqUGwsEW3fc29a2qFoQT6ELONXe94KGlgY/Ieb/vRDOb9fMni/uwW2DWi2gpaV
	 2LnszKGq13mSpGgvpSBKzpJzTuqW2PjjObtojxktKZNyPd+mF5YwY7aQhGim3f7r97
	 TIA0rWBmthVO2IGJH8kaDZX+qtwDWknE3LaN5J9ME7n+m8AA3z8qKo6Mzm0HjKXv+u
	 iSN7aiOZeJaYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D1B8060ABD;
	Sat, 31 Oct 2026 08:43:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A3BD94BC
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:43:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9181B810EA
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:43:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R_73Zbm6Xyci for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 08:43:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 00E0B810E6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::52a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793436203;
 b=r0Qy+KPCKOA8SSxWTQMOZKUhA40/lMzz24WTmAzu+FNIRKdl9TDRg4FanH2/mfX12KLr
 yI8mCgxSf99BzcMTjGYkpBf44eCS9Xobbq3O89PlBGTIlynEfzL/r/RVduHHAt/mFXkKm
 aSxXoqj4bapeTwpPPqZCfJN8iyoTFjy/JeTDkBhTDwaeOKAP5dsRYLUT9r+0GqF2OQs+5
 eL9rZwqdw2GV9bs04nx531GhFt+fLVWfFK/X0OWiavsVxyinc9dm/ckewYmOFL4gy+qQu
 sVzua7onkCOiSMNGJjPQLF/EgzWAMos3eBGewoelUBZxa+N8xTTRVYw9OT4Zkck6oLA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793436203;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=3FoV7YdUAX+T8pufrF9mePH0BOBY16f1I+gHEIIEJb0=;
 b=qCQpozai1ZgAfk3k1Y29gWGfkZPeBG/N6sQ4w3akYq5gi+FSgz4mp6jYMw55786RaO3j
 Mto4AN3S1MhbFBRI+VVjCH7wa7fvaQPyb87XlGoZM9dyzstytKAf/qGbZPD5UrYhvQmXa
 8MRnt+e/ncCrJTwJsjQAPW9NVuESuZ7/WyV+MYlfSEYKpghHFOESwl5bVxzIHXxzWDcft
 5FTsaFt+NHa07NpeQ/GoMzZz4ZZrluLYX0mNnhkYyLDlp8gFyZT1Mv0CPFOAcMHpq3c28
 pToWI2oPNQt43E7Ywdc3Um4gEyi83yxYQLfECQbntNtNy1WIKvM3HGBz9I9WosdZ9Bw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=gOrex8it; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::52a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=gOrex8it
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 00E0B810E6
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:43:22 +0000 (UTC)
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-cc4aa0246b7so761616a12.3
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 01:43:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793436202; cv=none;
 d=google.com; s=arc-20260327;
 b=URmqwhan90/xLSyxKYmmIIzjLhkaYtcShoJt6Bd3+0A+V2yDbJ55uR6ovzSluosWP8
 t0epezu6R/GdBkRzzflDFb4q7gREw9gNPnhqUKCMsVpUWJPEzbPTasU9Ph+jiZ8JT/f8
 AGrAMEXHgPp7BYI92MY1THE6ZkXdGoep2KNoKgAa37yHXtE4I9gL14OZh4qdfba1XD71
 +f6mG6MOKigrnbjGUnw7b6CeX8zGjO9CKySGHB2fnqAWynWWg751wJ6o1TKRGPD/3kar
 yuRDs2h/Piy+M2RMw7owtrs6OBQwHKjx6iCEkgfmxYQZcM1hKV1VuL2xFF5gE3NBVBML
 kwkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=3FoV7YdUAX+T8pufrF9mePH0BOBY16f1I+gHEIIEJb0=;
 fh=G4RX+isbJsXyTu8MRFzS5nb75z/zjAtaosIELnIJrgY=;
 b=DM8IEQcCHjSe36OE8X0a86pUT2u84yfuXH5lyDXs6wMx4hjJ3VjqsnrijrFm2Mo3V0
 KRDLLpVjqLeSw+XpoL0aCmqrk0Z/GPYo/Ly2w0GrRkzlIwZ1dsyfZ6M8kxrbz/sDgPwB
 QqUxdH48WfLWV494Z/IMnX4neUUSZ0y/MoGcbSjFyXI/DaQmUDMFrA9zNJcFvCqhOWr1
 1dJQcBPCxzek9tVRh09zprdDeBdyuisTYuFwPg4CvngyIUVnituJF5NjkagPyRdcyBIc
 phkPLFCVhVNMotgvPeYrN0RfmN4aMTeCEAz0cf+fN+s0HfZ1X4IDN0lc2TmYRexeNLIC
 MNrQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793436202; x=1794041002;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3FoV7YdUAX+T8pufrF9mePH0BOBY16f1I+gHEIIEJb0=;
 b=gOrex8itHCnwY+fudtNXvOcxhaiZ48tP1YvaOGohDJcrhEuDTNqkFnxc5LomxcEEkm
 7Kw2UWK/UeuUScW8h+WORaryf73o0KBrcNPJSJKSMQqDF0WHzdlQdh9eMgKgXtixrcdY
 EdWtOWOeS36cDHpZitWaEUdZgpBq3E2LbWh4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793436202; x=1794041002;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3FoV7YdUAX+T8pufrF9mePH0BOBY16f1I+gHEIIEJb0=;
 b=tToOMompZ/J4y4kQRtUFFv46+gu4c8iinT2aK3TFIwWZg+EJ1R9qLNpbobQ6rd9mmy
 Ygk3Wifa8u7WxVDr4l8j/XQKDQXprhFT2rVkITSmZHLSEfOAtkzXo8bevWj2nmAYckdT
 K8NYGJMizBHkbgj6RPLGnvGk8t6B6JIK+mWUCYJyW7h4jnYdad0Y3lcood7tHoBxUENO
 Hhsnqwtq2z0bRvajCNfP3gpzP/Y+68u2tXZsdk0ZySW17f38950BKVZf64HRS9Ux2j9z
 9tWG4uunjGsw+LGca4Y4vSSJuTiEMzwJdlVZcP6mmHKeDmAXElEaWxUuKZEwMrZifrGt
 xnoQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByXwApnHdxwyU2ocGNuVrAz5fCKEl2ZqN1ZmiXJlC7CuZmFcujaolE0Poa13H8e90nMDrE1ut0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKUWtfFfN7ui6spwc6rE9pAxCaufoVdR/WWh/xtRnOczLbsJVEK
 YkzLo+d465g6Rx9L1fmrXeVBDYo+30O3t2+OB1YaIY0Jx1qJKfQUNvN0UfLR3iqPwmeeemdXOZx
 +iOlBr0gfzB7Jzd2CKTyxQZ+UVFKovXWzCkeF68GD
X-Gm-Gg: AYBFou36c0osZ7v4QpTCJNXRBI30R5ryqwSwULyP2wIMX4MqS6pHsUmZ8L7AW2DJgmv
 6UPI/I22Gsy7jffaLch2Kk8VCFwcuhKYzmQDshZDXOyl/xqoabEVHW6I9l3B2wLBFZAIPICWt3D
 eFAmJKrxM+iZyKggmiKTh2E7BV0Gr2dknhgLFk4OZeyCCnH8oZ9R0P6aeOh7D+ZB6eyD8vGa+eR
 kN5n2Mbo276iYWv1I9gUwfC0+QUEOFmF5CPb3iPWtQp8AA2XzaR+oeBnn6hPvLJNaiHd7z9wP12
 vJFPHUfbo6gvRHLPp27H2JaBO6Q1u/ImdlZQo8OuRIQegtQTTulGZVWHSVOv/3DmcxXw8jRASl6
 gHRgYQIBagdOwJdmF3BlSIHF13sX+68jDwB2GAEDfOG0ZZg3FP962mFT2SX7G7PQsOu55Ni4qMu
 Khph+YUW8QdCRG2430mw==
X-Received: by 2002:a17:90b:518b:b0:3ac:ea3b:f28b with SMTP id
 98e67ed59e1d1-3ae897b6653mr3647375a91.24.1793436202083; Sat, 31 Oct 2026
 01:43:22 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 01:43:19 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 03:46:23 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261029050738.1107663-9-me@ziyao.cc>
References: <20261029050738.1107663-1-me@ziyao.cc>
 <20261029050738.1107663-9-me@ziyao.cc>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 01:43:19 -0700
X-Gm-Features: AclHuK9bdrhCBWePBhCYVohY6Bf2is3QDS1qYAtcZ5QnBw9U8_GjonMLRpaRZVo
Message-ID: <CAFLszThNdDQmMOoAae-NSyt4CaKvm0vMLLr11C2SQ_y4k4roxw@mail.gmail.com>
Subject: Re: [PATCH v6 08/20] LoongArch: CPU assembly routines
To: me@ziyao.cc
Cc: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-29T05:07:18+11:00, Yao Zi <me@ziyao.cc> wrote:
> LoongArch: CPU assembly routines
>
> start.S for initialisation, smp_secondary routine for
> a spin-table like interface for secondary cpus.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Yao Zi <me@ziyao.cc>
>
>  arch/loongarch/cpu/Makefile        |   4 +
>  arch/loongarch/cpu/cpu.c           |  17 ++++
>  arch/loongarch/cpu/smp_secondary.S |  55 ++++++++++++
>  arch/loongarch/cpu/start.S         | 168 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 244 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
