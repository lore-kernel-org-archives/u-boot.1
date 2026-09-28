Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE090CA5FA5
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 15:19:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C025380ED0;
	Mon, 28 Sep 2026 15:19:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jLmb0AtpN5cY; Mon, 28 Sep 2026 15:19:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 07F4D80EBF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608751;
	b=Y/Gk9XW0NR5VQJ4LkVPFyLCn6pKY+7qdA/qiY1Hzxg98czzQXdI88sKnmEJ/8Tb6nCmo
	 PJMgtWdIKyTv1VuEf7YHq6HK3lF4M6vix0YDSA7sD0Ofw88qQJl5OIKFQgzigV9YJx3XV
	 Ksa+Xo/2JahdM4M4WqhmPpkPoFVfJE8yErgyoEG61Bgzrmkx+vpZefX/l2VvaC/uEzv1s
	 wPx7z7jpfpmNuhqlkJaHdGq58Fl0F1LmMs3VC0KMrWco0c+C84eg5xrOrCsTfoz84wspW
	 UdNyqVoQ06KOfzkVWT1eunJ9pnHCfdkWhdvZkXIPTjjFRhJ8A8AvkVVeaBLaS6/Ldyg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790608751;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jPK+1ptE/X6iDYjfi4RjI+7id8wtUe73fJsR/Jma8G0=;
	b=h5gjekV8FrGnSRVsCF8RBaInX7mIy+yhTGQuPpS60CsVIp+cEaYowqf8GZqJdBoUEfVD
	 ESBJnaci1w2YJIHd/E6dGC1og90+XfT0IDpRqQ35Jh4hd+WP/jYhviDRvuJ1PvMEBhHwb
	 Iu5s3PXjZg/iwx1smHYeLUNFgxH4YQj6YiDqElMRjdmPwM4uqZikMDESmhFLhiBisjbl5
	 ayoL9GAMnJoPSXz3I1wXiX3Q4qXK3ItGF16AY9VAOGRaDgJRJBHDlCP9S3x0Sl5nObX7K
	 +Qp/f9Z76mpjDkb2k4VbIrxPdz2NpZm85ZlWE+GU1gTI+QQWIZteB7sL6DDlqmQqgUg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790608751;
	bh=jPK+1ptE/X6iDYjfi4RjI+7id8wtUe73fJsR/Jma8G0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tQDKeOOs9GQXFLH9IJOMqW664XGQwUUOzk6BgQN6Lu+BdlyCK3f+5L93bpXL/2zxj
	 JjxPEHhp3gpkYNZOBNjvPQtQJS/6001RWkvageRy9TGZGJRzcifQdgYBfh+g+3DAmj
	 N6RyVr+58GLDFYtE5YLhPIdO8xBqdbybMgJLp8kgWHCioJiPoKeWL/oSzFtjMA2TDl
	 5NxdD9MYz7DDX5BWRv7NJFQzo+vkZFpUuNKyfkmQAV3AstCG1sfX/hW+R1CY/JRk+d
	 eZtxzQis1TrhO9u2ErfU7xDq99EoyQRFJ7Tlc/R4AwWmi0WKtlxUG77looh+oweLRr
	 aEI0cJoCiXi9w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 07F4D80EBF;
	Mon, 28 Sep 2026 15:19:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0CD2232F
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:19:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F26DA406E7
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:19:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hIcxPXV_MZZ5 for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 15:19:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org EA4C1405DF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::13"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608749;
 b=pcJBw6uoQUhZIYQXBqZbD6NF8mAZhhbOaha2JQs5EMUvNV3QUFZD1R2PAzmBKi1yWiif
 NuXyrVzW2pU8pH0rONmu368zo4+iL9zGktKQbUmtPEjxzY0IQU8wrepmj3jQYtNqWOnPP
 opcXM41oC8YKfFyxljvioKWoT+HQs2uHd8CYJmc0HIIZOtWW8RQix9rd6Gk6iI+oOpWiF
 ylth9Yd8PQcBS7XBaY8chr0Nrk2kUkibRbJH37Jwecy74vRVsNrOvTxkhe2wOjIIGSGhY
 kFCcaL3p8u1GblZOD1U79BrrIuaCJLfbS0BVyDg4Yt/nLHlRqOI4wLxkAcM3nn3zPow==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790608749;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=jPK+1ptE/X6iDYjfi4RjI+7id8wtUe73fJsR/Jma8G0=;
 b=JiWJqD2+tFIQo8JuHA/Bv0iYEMuRxKqX4iZTPMszZbmbWVMnv2rXyZJXOHwcjxQVJ42x
 3v0+I42HSXxrGNnS10TPdfEfKEciEJRXIPXgCedJVr5afTs4TpfX28YC/TKr+s2O+7Id2
 UI6izzRD42qffa+aBLOJv/2cXaPqUJQ+24OFm1TWJ3YKA79CNMOWAhiEp0jgM0Upk+4/w
 7sDTqcMf1yS5s4wtcdZnmJ3gTliN9uD8aopYn4Kexfby/xGaU0icFG6pIG3M6u806+wHU
 6hxc8AhdheMo3reZccwSFXEG6sTrOnkN5FlzXFZa95TcDfGygiyKe3Uh34B9Yw4ktUg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=RzY5mmD+; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::13"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::13; helo=mail-ed2-x13.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=RzY5mmD+
Received: from mail-ed2-x13.google.com (mail-ed2-x13.google.com
 [IPv6:2a00:1450:4864:33::13])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EA4C1405DF
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:19:08 +0000 (UTC)
Received: by mail-ed2-x13.google.com with SMTP id
 4fb4d7f45d1cf-6aaeeacce15so4500072a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 08:19:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790608746; cv=none;
 d=google.com; s=arc-20260327;
 b=R5mneLHdcMlsoKlq8f/rO3dRQWG1xedu6Mc6hKpmG3+LpbtnSCzehwclUj6MXdT6HG
 Ksfl2aMWClbls7tUHwBn1BvxCJEf+IMF41w21pARb6OdBQV0QPNQMv1XTJ/EWAapZXuz
 iScUTXF+HuwM/x+dRCYoVh6k7VC0PIa9zrJIBViXVDRXspoIaM0ui7HgEfAGVVoXFphE
 O3kW3ORUOwUzvgp/mJH/u+9EDK7tv/KWDbcG7F7+bvaTA9xcpGz1zW8I4wmN/jz2xTY0
 qsHgxKqLF0D0q2ADnEYegAkut9FtjH8S7JVI81N4+E4s3CkhCTwOTOnOKWpBQTNBD72O
 +bGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jPK+1ptE/X6iDYjfi4RjI+7id8wtUe73fJsR/Jma8G0=;
 fh=8DuR7XNy5AEjb4gBS1/LVK9PjPsoKjz3k9sgz9THXC0=;
 b=YTk8G/wktCAhGNabK6kyJCOQo9VqRGFAoEbm7DDfOgIoxwARELJZogON204WU3lwkQ
 Ihojglj2SzUJtJb9i/3F+tY6A2S/TqSGV4SHeuqbuzJeyWwVz9nwqfNZE1m8/3JI8e1i
 oBI7NfhCKEN2ZuCwQEjbWNRkziKemQYku/2vvyWwn3QQT1dVRsRa+aCLDXdu58gRVIkY
 fv7eeshSUEqKL8Y0gXAGnKhCrjnW0jVbAsDgocZseIcKTpw5caddVRdbne/D+LK3Qlst
 OaZ4eulVmG6tSAeKasJnFIQ0cagSng8TvJ3zb3PXTlO+DpZIL7X9y0PT6Iu7z7wymrBa
 eDMA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790608746; x=1791213546;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jPK+1ptE/X6iDYjfi4RjI+7id8wtUe73fJsR/Jma8G0=;
 b=RzY5mmD+r1FzSlP8skuW5IBv6nq9I2CTISTU4gUULgVs3jCTv/QhlPG/9BjWC0ZcU1
 d4uSf3hnOMpjn04JbOJJWQ8v3JVQ9oU9R7XFkeq6/AgnEjeX86gCOE97AyhoLz817jKj
 0gjxGm+rxMRC8VcXsv+6d5dH4n18AVefAump8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790608746; x=1791213546;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jPK+1ptE/X6iDYjfi4RjI+7id8wtUe73fJsR/Jma8G0=;
 b=1vhrSzaLPgRQJa8aL89ylMgdQcxFce9UDMNq7LrmNrU+mN5eMTI09FBG45hfF8utX3
 42HKIFWBgK/6uopznOHhfdJBJkALCw2GTCEZvhVPaF6nded0VhI9RSf86ut/FtzH7ng+
 mxj+Ijk1ZgHCm329aPBMvJVNTfroKaECGXaviOtBF6N8pA2eeR0M6ZAPeEq5zz4zCtHZ
 DrkmVn2ThitqO6GhlgGelYXUueekQnj71Skd+nSLa/Cf5JNSa1Eohu29pp1GTyE1aDx9
 xrHZzl36wKkJGpA4rHlCFywdCkouELsK3q1UyyqnFGVaz5/a66/uUpBmcTTVoZQV0etT
 t6jg==
X-Gm-Message-State: AFq9FYIolzZPZb0UfEuLxj9PmKRhOXHE64zs8cUJ/xgg5CnQWUbSSmtr
 Wr7QFsk+DzljXf41VSolHbokByQXeA7GIVsftkIZmRIzL173L0nS3VjnUypDFx/OC1xBCq5ryvV
 2v9xVd+LosR4KJsrcg9Xudtz7Qdr73myXjjhxpVhj
X-Gm-Gg: AYBFou2nK1A8T9zbzj27QihST063+/2DDaAmjvcHdf2mqMV5KJIgDGQ3JWINqVbnLAh
 Y3PG8DY6aCgDfuF4kx5Wnbcg1e39gGaVOeJ/DjzxDD2f6PnDiCf6UWmnkF9YQhQe57vv6b+3CJz
 4i4kJNBRudwmlL5cvEJZ2Xif/2UFlIES8+CQQTdrRwhLh0+GXfMqKnXx2PR8n2vqYqXRRA1+c/n
 1uDMiOLR8v2bYGBHNx3OJAqfzBV23I8bBPhVZT3Vez0UXlY4Tc7TpNc7BmCyLiHTd7NWVtKDgLA
 xMb6Qp2+ers0QAWZEVMFuYw+oS2UESTOnWqRAqvzWWTf5fDgiiYPbd4=
X-Received: by 2002:a05:6402:1d4d:b0:6a9:bb40:6de7 with SMTP id
 4fb4d7f45d1cf-6aac90a0e8emr11360037a12.23.1790608746346; Mon, 28 Sep 2026
 08:19:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260912124454.13578-1-aristo.chen@canonical.com>
 <20260922123630.608961-1-aristo.chen@canonical.com>
 <20260922123630.608961-8-aristo.chen@canonical.com>
In-Reply-To: <20260922123630.608961-8-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Sep 2026 09:18:52 -0600
X-Gm-Features: AclHuK-fAmpjS2DQ-YLhw-KiYdux-YahSnxWYH_lo6mw9Eau8TyQ2GTTFQ3Upak
Message-ID: <CAFLszThXvhk84Wz6_3xSjkGnnr9Nvn84Da_-ZE2TKE=3wyw9hA@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] test: py: add tests for the FIT image-data property
To: aristo.chen@canonical.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Anton Ivanov <anton@binarly.io>
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

On 2026-09-22T12:36:21, Aristo Chen <aristo.chen@canonical.com> wrote:
> test: py: add tests for the FIT image-data property
>
> Cover mkimage's resolution of image-data references between images. The
> positive tests check that an inline FIT carries identical data and hash
> values on the sharer and the target while their own properties remain
> independent, that external data mode points both nodes at a single copy
> of the payload, that a resolved FIT can be re-processed with -F
> including conversion to external data, and that two nodes with
> identical cipher settings share the same ciphertext both inline and
> external, whether the IV comes from an iv-name-hint or from an explicit
> iv that is honored and retained in the FIT.
>
> The negative tests check that mkimage rejects references to undefined
> images, chained references, data that disagrees with the target,
> image-data combined with external data properties in partial and in
> complete form, a configuration whose image-data sharers have
> overlapping load regions, sharing where only one node is encrypted, and
> encrypted sharing where the nodes disagree on the IV, through different
> iv-name-hints, different explicit ivs or no shared IV source at all.
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
>
> test/py/tests/test_fit_image_data.py | 391 +++++++++++++++++++++++++++++++++++
>  1 file changed, 391 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
