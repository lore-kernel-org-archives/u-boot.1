Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89CF3C531CF
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 13:26:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8EDBF60A35;
	Thu, 23 Jul 2026 13:26:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vSeaEoQBXO6W; Thu, 23 Jul 2026 13:26:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A3E08608C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784813194;
	bh=S5Zu0NMTVDC+WqLR8OjsmaffWohk74vA8DZ9gvtUCPI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S1zf3P7MMDFJKkPy4ybUD1piPcB3yhnhPK1eKPyjLdAtFlsdXNMg0KO3LzMnThl+u
	 Ct4su+ruy3/ar3gqcdTjUM0Msn0XDNWQa8Hj3PIFkOwpWDiRzWwIpvGFj4IJY9EOF9
	 8pbMM/wr6mBcV+1xXl6nmMwT4Rv/k7S1gt3IPIExTbpmdFMgGO0TZPRSxw6q56h09m
	 hkcuaybdcavnChXcQBTLlbx4Gm7rtb7b7HfQXiLIybtiYxEBi+zDw4fqwhSV62x2tn
	 ftEAV9Sf1xGeKTQb3fQxGyWsQSzJjKsRdho5B1ZOw2QIls/iqqzhf4EDvddKVwOSx9
	 wV1ernOf5IhWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A3E08608C2;
	Thu, 23 Jul 2026 13:26:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9CF4C2E5
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 13:26:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 829FE80AF1
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 13:26:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m3lcHsiASa6E for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 13:26:31 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 4920B80AC8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4920B80AC8
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4920B80AC8
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 13:26:31 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0AD080287; Thu, 23 Jul 2026 15:26:29 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB14F80087
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 15:26:25 +0200 (CEST)
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-39c9107baa7so5019801fa.3
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 06:26:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784813185; cv=none;
 d=google.com; s=arc-20260327;
 b=FkF4l/B0FZNDRu1h70d9EyAQlPaQlbRHUSA2VrzhNfoRHQAiIBdxEVQqHobvrcfqHL
 HJYp+lq5rDEUIKdIFeAEBUEqHSN3UVeY1WfkD1I5npZUMhgVn28tRc7g0OMH8GI4u97z
 kVU4aXtUhGdP/vlh0LPpJuGrt+VKBAo7DbKUqzuJ6CFR4IwEj0XG2Wnv1kU1rLGFoXQC
 reNrB1i3/ho/23VrkoX6Eq59UHg4pcHeI/s0dsJimCJyAUZR9xEkDCI5hbLZ+PXwfl17
 +Hj+kuG48lfkiX2q0oEohcFjYGiDbZJvt9ZUVqhSj0AoZmJHh6L9mOFp+/rSUkUv779s
 xGRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=S5Zu0NMTVDC+WqLR8OjsmaffWohk74vA8DZ9gvtUCPI=;
 fh=NARnil5a4Dnsj6rkB5AxBBArxYSKGHYKHnQ65ONaXq4=;
 b=YuSTzCh0bv5lf/35FchYRVBw0GG5Cms6UamfdPp1R9TgQ7zZ9AhqJQjZRBZT+1jeEp
 x4HlumhAXvR1QaIAZfoQFD4QIRQ07FaCWYaaOj8hswDA9E4h0P932JBxKFkdVvGTWdAB
 QWp+sDdh7V2rQ4NNzd6EnpGasVhuLurQhPqi/cvXqyFNjmLL1AoC8ncRpqy0K3/VMEHa
 +wk34HhvFeoq8onnd3q2KTEPVwC0dhw7XGb2ZNzbEx5ZrTjH0jgQZ+yDut4CT6S8yYjb
 YIKiSFJpdvx5+Lik52mNOmMoLLxJ2yfJrEsJIrPMnIWHJFWyznwDo4HPaWJbu9J18Z0+
 SOsA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784813185; x=1785417985;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=S5Zu0NMTVDC+WqLR8OjsmaffWohk74vA8DZ9gvtUCPI=;
 b=jFOxprVDOQrN95+in00klBvi/QsrgVnljoJEB2k0uFlJoEqyDCoz0gucmu1+06G+PX
 8p3E4lCfE01fvWH4Wsxv5d3p4vG09cnATSWnYfM6O7H6wZKOqzN9MzJbtk3xoKQuVG6n
 WeUS1xV3b8+8g9GaykhIrSQkHHWjxFL4Dl5gdia0agy+VDDp26GXoPJiLyRKQe8rk2U1
 QMjphYCwV4blqXXtZei3f377XRQzEmkbDwRswTa+wBsDRfrD811n0fjQeJ0eTKYeM35B
 FhIkQDCIVevVHMheYSi0jdqb2EpsVxTVfwrGVNoYtcUqM9ihVs+2Feh3iuJ6BgRj/ql2
 b5WA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoGDNIK8F7RjprCNDM3wU1K6aUBFXwzgZvE9AuRAvDeH1SGnmjSNAhTSoGQhCpLAKiMgFuiKUg=@lists.denx.de
X-Gm-Message-State: AOJu0YynMvb9OzP7v11bNHDXNFz+TxPv0CJ2tgNM+1cxIuQMbSWKf0mZ
 Ff5DB12uhi8it5htWElAQGZyxiu/a/mePcrMTFhAc0+NFfcTNLxUDBjI0kvnzM+9J5j8uKSt8yn
 Btv1N8CasBD2movh6iwPuPdfe7CRmnh0=
X-Gm-Gg: AR+sD10+Viy48hTnLuCsK8OoANmS9McnXhnIQe55CYG34+dhN37ir+4R58QRjydkxbF
 DAIRt3+nnvkWxhbNYhP5xGwmsofGDMSHswzSkIDbo5UZPh9fJswtTItOajFKmiX4tTafYusmThp
 0uZtLZA3R/JHNaaLC7ksqSKXBP/x9cQ4IMZPu6YpsvmSDV0y3KLyhNNXruKYrDjAwaVZ+eCXMO4
 oyjy9fOn9Lnp1y21zDvws/p1ZXQfHhStFj0ry8G50dfI0oxgRF+vfpMeeGDRs4bp7XS7SXU+UmU
 mZF4GcMhzE/pNprmObCFC+W+0c/of/QfecfUwcynCjNIWkmAqw==
X-Received: by 2002:a05:651c:2c4:b0:39a:fec6:efd1 with SMTP id
 38308e7fff4ca-39f07c80b8cmr4987131fa.15.1784813184303; Thu, 23 Jul 2026
 06:26:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260723-sm8550-hdk-v2-0-78f0ce2adb3c@imd-tec.com>
 <20260723-sm8550-hdk-v2-1-78f0ce2adb3c@imd-tec.com>
In-Reply-To: <20260723-sm8550-hdk-v2-1-78f0ce2adb3c@imd-tec.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 23 Jul 2026 10:26:12 -0300
X-Gm-Features: AUfX_mzFIO_ZuXGXJHibjy44Y1BoSMdoHLsWnVQZUgCl06-BJtbDpTkZRoakkAY
Message-ID: <CAOMZO5BkNV1J=wEoj1kcD3g=WxJXgDkned0R3FBMkcRfu0jD2A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] doc: board: qualcomm: document SM8550/QCS8550
 building/flashing
To: William Bright <william.bright@imd-tec.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, 
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784813185; x=1785417985; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=S5Zu0NMTVDC+WqLR8OjsmaffWohk74vA8DZ9gvtUCPI=;
 b=kPJIejXE5jVSqUrIVlyakdHWODMxzdK/0kwKepDGSZHmk/iSof8jk9G9N6PSwYNRRm
 T90WzRZgrBeN9XvDgDlnBt3QSo8fvaZdwA/1iHaupyUUP52uCQcjVOUPhO5uUJTEV4au
 F0Dp2AnXPKNmSn3DfGMeW832pH4Pcm9V1qVb6Gu71d1ohj36o6BVVGc02YI4zq1q6C1G
 wdZ+awUo96LrhJT94kToAX16z3QtPxMWpM/mLMjYMUhYhoFTMWLlNRSLmRoxL6a9BFcL
 t/q0oNm4rQvNNPg0eC8iUZPxxVm0p1C6FODCPttVhRdISz1XPdKeHwXFlAhvZgbJ+iwa
 d0jg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=kPJIejXE
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=festevam@gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="kPJIejXE"; 
 dkim-atps=neutral
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Thu, Jul 23, 2026 at 10:23=E2=80=AFAM William Bright
<william.bright@imd-tec.com> wrote:
>
> Introducing documentation support for Qualcomm SnapDragon Gen 2 SM8550

Just a nitpick: commit logs should start with the imperative mood, so
in this case:

Introduce documentation...
