Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C1AC98314
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 07:01:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E4FFA40DD5;
	Thu, 24 Sep 2026 07:01:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6n4h5ieOw1Fs; Thu, 24 Sep 2026 07:01:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B5B4A40DC8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790233295;
	b=R7rgmSfdAfFDvZcuavchJArz+lAX78Wc3alSlLTtUgkqOzss0AyOsPG0TD2crtFITkI0
	 2ut0rk1ZWaugxCiIcN3TZ7eMYm3O/PIFaRr6tgwPHEuWPSar0r0C4S4U1iAK26l3Cx9OU
	 nVduhJxWnDvC7/pYvGC4Ma/Db5MllBDfuGByp/iQBoVBqDbivfrngjGyD8d+USWms+0J1
	 vwFkJhc+S0IcRt17wel6OhYyr3IVW2ZC8UBgEiL7MtoVvkrMzmtprCPcM10HbSjYGMP6A
	 I7nzIf3IkHUkCundDAja1OPDMe5VgNkz81cm63Z+wOCnXHBKpbFCdxeS6K0M0oF2PNQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790233295;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Ac2FnP+3987Go9lli+yD2PNQkTak9019QQjG+60cC1w=;
	b=qcUbDYkphbdfD3rq/DTsi4qBrt8Fjvyq/PGuD4zrG1RZIthnqyEh+W7+MxwYWjhqMLyP
	 JTYEq1ewdMO+4mpKcA2/+rUILA0UJldaPqX+yQfe3gli/+/avv4TLy7nVUz5vQDVAFFw8
	 7kzFPqxZUDe23kc/LRJlnqXW+j9P5D5urJqeEw5IZY/vnPxlFP1yaE+6p6E8bM+9DYxqJ
	 GmisXWw4fpT3jR8LVb9weO86cvkdMI4em1XbZUkqAxs3SOUMrGIVaxEaVyGS/oV8r03Ug
	 rkrP03LkLlnfdNlAgAkh4LnLd/hZFFWF2u2rxi4c3Q9Segx/GMy88DLV7L4glnOnj/w==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ZNKwRXmy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790233295;
	bh=Ac2FnP+3987Go9lli+yD2PNQkTak9019QQjG+60cC1w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZWnP6HSwGxMu0HWeoYAayNqDz7M29GinNM44UWXx/4Q/vH1nWtjHJWQs1FiJQOsTO
	 X1DvcLmODjE17nudhKEMS4UTPFw8ubf3/RuWF2aPsA0IgFVvgRAzJn6YJiivZ3HNE/
	 NqXQVX86zqFAHvRyMq8gIcdHPct0Prg0lRKQhlONtVDpVWM8Blx3Vah8nJBht4WzAJ
	 nCAWYKuXLgppv1qB7BPRKSbfrHNUX+N/p9b1FuTIBrZh6AMTPIFOw3+FQ1cebrpm6J
	 MVSNawknwF5dtfY1PFKf5jIONcbh/PnJCA4PMdJTbF+T6oNkdYiCTU3nzdO3cipL8F
	 pqcA9gola1VVA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B5B4A40DC8;
	Thu, 24 Sep 2026 07:01:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id CBEF93B7
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 07:01:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B146840DC8
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 07:01:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WC-tdfHtUgR7 for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 07:01:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4CC9A40DC2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:41::e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790233293;
 b=JowYUzlysv4GIxf1rjVJ092eVeMXQCMn/9jS2gSjQ8Q3Ekur1tnr5NfcjZCps2uJCOx1
 MX+v61aF9Yn3RokZwStWCoJAZx6Xzecj13OS2gpuxzSopM3XoUxHeq0xkObAjuSfq94dr
 KPSwDRH3TgdH538wACZu70aFw0yEJA4sK1EYThYTCkkQk0laol3T+xjBtv7PddOKT5miN
 qSkPOVYI9tXpm6bTUdl5rQmi93qE68YvOGiLdcwQaW5zIR9KbL73cxGIZbWup9ohysisC
 QOaod4jyiDINQYLaviVkQBRZumGvgFWq+1UVQZwKFfeQ7px7Q3sebkSQI1S1HU3SdKA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790233293;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=Ac2FnP+3987Go9lli+yD2PNQkTak9019QQjG+60cC1w=;
 b=DFu9C6hpX0YlyluwYUTs3QjSWEqhXGh0lvD0AeVl2X0flMAv0BFou6VghA5h9tAuA1fw
 o9LOcXcP316h8L/9z6jYwA2sifLxTMO7sRftdyEo05VqJKgXxwcTduR/ovtwjS6eL43mc
 gOQ5HgAHCpSf3PfCwGDBdV3ZLXlk3lTnSqzxu/C+BOU2o/lgcT5pJZg9S335D/uV/Nyhf
 ZVh8a8Yy3UXeEkG/hP7pcq0mznY4fLRXPz3Wlbx0UTz5mtkiZx9odlBqO/brUQErIbi1d
 djqUSGe7GTi/yTfSzsAkVxZx/o3bz3L04OQ+ep4QAKpHu4lvgdckhUlb4WHrzIzscuA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=ZNKwRXmy; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:41::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:41::e;
 helo=mail-yx2-x0e.google.com; envelope-from=ilias.apalodimas@linaro.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=ZNKwRXmy
Received: from mail-yx2-x0e.google.com (mail-yx2-x0e.google.com
 [IPv6:2607:f8b0:4864:41::e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4CC9A40DC2
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 07:01:32 +0000 (UTC)
Received: by mail-yx2-x0e.google.com with SMTP id
 956f58d0204a3-672f516c271so112552d50.2
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 00:01:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790233292; cv=none;
 d=google.com; s=arc-20260327;
 b=ng5iHw4mUPUByIKJhAwhPGh6nOqOFxQrOC69SRS95Ds1qSuVRJN/NFPVWH+bfbSc0w
 XpbF2sDX6uM146yGgHcaZRCLxFPRCvKMCf6V9++e0z87KMW19NsdJXXKBKodZPhfL7VD
 mHkX57ujWA1bRBN/jqeieo3bpvcFVBKXJo9bnXFJ7Wu6rH1JwF5mKdLA713DAJiMr/FR
 DKHySvHbJrqIevRb8ss3KkVOni7Ogy5v9qJnzMSZmKj4Cp9g6KHoY4+LnY4yxzF8mV1d
 Au4HHL70RUj7IYTjhvbPnhJE68CMgOTJiVV272M27EWQgCwnhu2by2fBXbP196GzbGEf
 RAbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ac2FnP+3987Go9lli+yD2PNQkTak9019QQjG+60cC1w=;
 fh=giwE3N45UCC90Ka6EoAJ1fAkiaVHkDI7+iLgTALuSDw=;
 b=Hu9Rl6P6kfKe4D2SVsB0bRTurkRdLLxCwLJIi7uO5E8UrV3ODk5Ob/od4hpdRbEYKt
 k+e9XOOKQjUJw7rsFp5fxQ4ZqAm7+bZ4vIZPVcVJaulEcn5uHtqKgxn0e+SBsaA/nkMs
 tEZoKQDGQxHkUNphqEeGWC0dwpr3fKvCQmp9YHYreCTpTKbKb3lc0rss/BJGN/XhWXJc
 VYYjuadkZcHUR8yK3GL6ksRB4lOSvN+8WJJ41qFXSEYHCcU5fKDeHqqWikGjcRGqpiPW
 tLh/A1LtgV20J6Ypp8YBDNqcmS7AhxDBcjoS5VPkO9XeufrbSm0A/X9/iKLeR4n2E4mR
 6Hpg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790233292; x=1790838092;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ac2FnP+3987Go9lli+yD2PNQkTak9019QQjG+60cC1w=;
 b=ZNKwRXmy9xVRKSVptLcWeH2dlChFiKTcH2vn6/hcXoQplO8iIuy6LeICvcK+sSGb7G
 ZENB3IC9BJmn0DXQGCniAJFnHTECrm0oCASj3BGeQwh0JDyF08Tl/8Hw34chuEYJnh7P
 nZo6aRlCL9nhmkajgjmucnvdI/6Yu9BtAF83xOx+iHP/3WQkRonNacR81XOYo2iBkvN3
 JfnEnc4SylCH+nHwF+/xp+6QWTJfKhP3GvXZBlzVHRTlEOrCcKn+V/G6lFtEmbJ2BnJU
 F884DtXt1RCFIVyxTbWehQQWUZ9vD/bM5vo+fg3ilfYkW6v9rSrvxVD/x9/1iJHRWYfE
 N9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790233292; x=1790838092;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ac2FnP+3987Go9lli+yD2PNQkTak9019QQjG+60cC1w=;
 b=iCzisZ+sEcMrdaDvJlq2Pug1hDzrSLVbBlbgq03txintQeCn4tcjkqkhTkGN2OLP/Q
 HoeJUOPe+01uA/HOb4QxvFPhq86bVaiZ97CDKzJ5gOjWi/hdxXSKIZYkjkaF4mPz+uBQ
 CpbX6rrweYC+1WkbHRAgKpPok5If7H15Yri2sRyZWK90pXeWVlYH29onPbeZDcmtm2oU
 md2UePv7e3dDUDERja/g2f5Nu2IOwjTzxAJVOGu11r2elbuX6DKTHi2wm8lCM9/Z1xCC
 Yoz8CruobDl32xGgs1kkixjowHcFMSpAradG0mxFFV4aDdwJDadNyciwomlic/ZdeOO7
 heFw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxVYBKRxrRFv6DKp/IhC701ITj1JQABXw6fvN0lrMgRzf9XHFcSmWjaZSg9wSTcc9ZBqcwLX8A=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mIKSh0oN1kdq/2BB+B+sk54TfKLCmSnG2JByPNRK5cC/ltMhUr
 7sI9dQwz3l73DTUw+ioQ1AUgsg2PLBEpb1cJyvE+gEUytjU1UZSdU13u885a3s/HsNBB5Wu3qZg
 ndbiWCQE+j5oUoZwAT4sW8vOZ54n6LuL+CE5Llvqs/g==
X-Gm-Gg: AYBFou3K1gwoklVTREmkXc87xiOKVW9AL4fwY4P+yHeAO0U7N9/eKI1QLDUFOMpErAW
 6XlqPUWpVmUXWsctkma0IedsaZ7Q6LfTwv7JNrk/B9xUER1jSK/Wldd+iG+GaVqsKDEi4HXMU5c
 j8kt32/vnjHMPswkL0A5W15JRVEk7EhgJP1d2csrxOvhCj5e5ZLnDuvgaWj+BmTOByLGsWx10Uv
 htBmZqV8otCNzdTAtDTb6jwXZYbydyHwTtb1iBvnj5QcAlQkI6173Z+7+vO/HgHv9Eg4+tAnddE
 BP3E885rBYv/1ZCJxEVmbeQ+GpcDQVmOSprR/CY0CX159/vuAy6GCRCyx1A4EzIE+KJaOqdHCtf
 4SH9P0P61VPAal8CWIRaXzt8KCg6DKbui3wK9d2fee0VQ3576VmWxP5zzdF6XU4UuK5Mo5X4gwi
 dZ34k9ITa4dKED82z1CHUFcerhTi7+N9rfM9wape71f0veXMTdjOqGP+JLuAxGLk37XPjXe/3Qa
 WjQtp/bCFEVTsdqmUCt19JH9lkqidOHVWgiLkLxBB3jbvqkPa1eXMA33xFqX7SbaF4XqQ/j91pW
 VktrrW4XrMFgpGwoqHH95Sjv8sFJ5jy3TgEWOgYN4KRry1LOu+WZWWyJw9Hsl+YwtrT5jz4iSmg
 V+PNK8GbqLtVgUKuVMRQji6PeBh83PBQBzmgMSTZI+9ZhlU4pUGSPAnsPu+hL22wP
X-Received: by 2002:a05:690e:1181:b0:670:fe27:3413 with SMTP id
 956f58d0204a3-672ed57e2ebmr798528d50.95.1790233291633; Thu, 24 Sep 2026
 00:01:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260918172127.66014-1-ayoub.zaki@embetrix.com>
 <20260918175345.GT858934@bill-the-cat>
 <f550f27d-55ba-4d10-9b1f-d3712b6967ab@embetrix.com>
 <20260921202435.GC858934@bill-the-cat>
 <8953c3f1-929a-43ca-8708-712a45db9c77@embetrix.com>
In-Reply-To: <8953c3f1-929a-43ca-8708-712a45db9c77@embetrix.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 24 Sep 2026 10:00:55 +0300
X-Gm-Features: AclHuK842JzaYBkVdJret9l22Wvw-F9nZvN4fHQGiPPHlVKjtXeoMZY_TNGSoSQ
Message-ID: <CAC_iWjKDX2FdzrpW0JxJ-tpj2PksNY0gDyoXz3_T_QRrjaoyRQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] crypto: add FIPS 204 ML-DSA verification
To: Ayoub Zaki <ayoub.zaki@embetrix.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org, 
 mkorpershoek@kernel.org, sjg@chromium.org, marek.vasut+renesas@mailbox.org, 
 pbrobinson@gmail.com, dlechner@baylibre.com, hs@nabladev.com, 
 xypron.glpk@gmx.de, heiko@sntech.de, raymondmaoca@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi all,

First of all, Ayoub thanks for doing this. It's on my backlog for a
number of years :)

On Wed, 23 Sept 2026 at 22:58, Ayoub Zaki <ayoub.zaki@embetrix.com> wrote:
>
> Hi Tom,
>
> On 9/21/26 21:24, Tom Rini wrote:
> > On Fri, Sep 18, 2026 at 07:42:56PM +0100, Ayoub Zaki wrote:
> >>
> >>
> >> On 9/18/26 18:53, Tom Rini wrote:
> >>> This is interesting and something that does have to be on our radar. =
My
> >>> first question is, should we not just update to a newer mbedtls relea=
se
> >>> and enable their SHA3-{256,384,512} supports, and anything else we ne=
ed?
> >>> Then we tell people that need this that they need to move from legacy
> >>> crypto support to mbedtls (where we get to leverage a wider community
> >>> for security audit and response and so on). Thanks!
> >>
> >> Hi Tom,
> >> Thanks. I agree with the long-term maintenance benefits. ML-DSA
> >> requires SHAKE128 and SHAKE256 rather than just fixed-output SHA3.
> >> The TF-PSA-Crypto ML-DSA integration is marked experimental in the
> >> Mbed TLS 4.2 documentation.
> >> For this series I would prefer to retain the Linux kernel-based
> >> implementation with limited U-Boot adaptations. A migration to
> >> Mbed TLS could follow as its ML-DSA support matures.
> >> Would that be acceptable?
> >
> > Well, a problem I see is that this is something that needs active
> > maintenance to stay in sync as we don't want to miss important fixes
> > here. In theory, we get that with mbedtls (even if we're behind atm...)=
.
> >
>
> Agreed. Importing the Linux implementation means taking responsibility
> for tracking upstream fixes. I=E2=80=99m willing to maintain this code, t=
rack
> changes to the Linux implementations and bring relevant fixes into
> U-Boot. I can also add a MAINTAINERS entry to make that responsibility
> explicit.
> The goal is to prepare U-Boot for early adoption of post-quantum
> cryptography in secure boot, particularly FIT image signing and
> signature verification as some hardware already ships with PQC
> capabilities.

There are zero doubts that this is necessary; in fact we are already late.

> The intention is to switch to Mbed TLS as soon as it provides production
> ready ML-DSA support and the required SHAKE functionality. That timeline
> is not clear to me yet so I=E2=80=99d like to prepare U-Boot in the meant=
ime.
> Would this address your maintenance concern sufficiently to proceed with
> this approach?
>

I can try to find out more about the mbedTLS roadmap if you are still
interested in going down that path. Arguably most country legislation
is looking to enforce PQC by 2030 so a month or two won't kill us.
There's another benefit apart from the 'less maintenance' when using
the external library path. IIRC, there isn't a single algorithm
acceptable to all legislative bodies.E.g, CNSA 2.0 does not adopt
SLH-DSA while most of Europe does. It would be much easier to use a
library and select the desired implementation (even stateful vs
stateless) instead of importing and maintaining everything.

Thanks!
/Ilias

> Mit freundlichen Gr=C3=BC=C3=9Fen / Kind regards
>
> --
> Ayoub Zaki
> Embedded Systems Consultant
>
> Vaihinger Stra=C3=9Fe 2/1
> D-71634 Ludwigsburg
> Email    : ayoub.zaki@embetrix.com
> Homepage : https://embetrix.com
> VAT No.  : DE313902634
>
