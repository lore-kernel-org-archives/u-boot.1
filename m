Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE36BC55ABF
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 21:48:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CFEA280E05;
	Wed,  5 Aug 2026 21:48:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hgeWwfleoHs8; Wed,  5 Aug 2026 21:48:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5E9EE80DF3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785966517;
	bh=lbXN6kQ6u5VEKBPt/HF4FSMbAFFnwdoiM9OixkwxJAM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HIR9DUYA5+e4FWlOXkTcv68eQVUlUZlPL51uqQZgpaaFIVf+FjMrUc3LtvMFoYBJv
	 7zxqfpXNCA8ub1CTRQE0BdtIyRi7h1bVWSAEWjswqbNDdy4/9HDEqgeE+tEIzRgCnq
	 ltmt+b2ZIF+QlLaLPZP+teohCmOAcAgSHjRvH0N2F31Y1yKsdj3CaHuY+6oQU0jIbO
	 5I9RPA2RxYl+tTn22ePh8mpjOPD88n8qfRjkSET46JuuOQLw8O9esx+/TeTtzoyikO
	 GYBBo68c8TcBbWZeKl953BzlLAzsyDawo/0j7okLAfUpKTo9e9e2QvAA3dfT7Sagcy
	 rtgcYrP3nyadA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5E9EE80DF3;
	Wed,  5 Aug 2026 21:48:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B978C3F9
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 21:48:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ABDB5607EC
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 21:48:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iSU8M8N9QPOL for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 21:48:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org BB2E9607E8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BB2E9607E8
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BB2E9607E8
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 21:48:34 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-69c108fee7fso2151367a12.3
 for <u-boot@lists.u-boot-project.org>; Wed, 05 Aug 2026 14:48:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785966512; cv=none;
 d=google.com; s=arc-20260327;
 b=rDqC4zQENF3Ivp4skEEegjA2Q8+KIoRukYMkSBj1hwoLVXo6qv5PXw29zzFC65qm5g
 SFE2cYtYhehj1MrKXpItKjytM9p7Ixv29Tg0eAOu68Hb2tc45fOhiMPbntk3L722Qwa4
 W8nSRCQHhcFvTmA+vf1zFbblfLWdiZ22dstmoX1/g9BWV3Pnmt6BP+hqc5un7YjzZzTf
 hQ3m5TiIRBbCJzmwB0sWrwwbrP2lIjlNnzA62Oz6m14XE9es/MIZMtRNx3IKwN32trQb
 riUwXdpH41O5oLWohdO/XotrCGE7OkLXoKIOJstSJZjv/pSugW9rSd1qOY2KHs1bntjF
 QzeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=lbXN6kQ6u5VEKBPt/HF4FSMbAFFnwdoiM9OixkwxJAM=;
 fh=eybldZBXeZ25kcSUWgn0EFj7euTPyUYAWUYWgJkJ5MY=;
 b=M/kGmmCAiG5IFkSsS43obZ0uKN4wr7NWVJiCA0n55IdtuMD1yqVIL26gJTPpzZHjoN
 uR125SjHnW/eJRh+QVKSn+5uDMh7Jhwd10oECinkcZLWKAL1+urHYnildDa/gq4pq3vL
 zHQ/k1EQgwCJoqpssLbEWBFcLVihVhyOx3zsIVXF4/n8CIOQez2TIwlRp/Q3mxtvr79k
 900UlYeUqpas33c++eku4pVucuqu/geGZJxZdx7F0S2AhyplJOXXZlmcBLGbFG9rXxSE
 U0wM+QyF3miVtQdCb0yEhh231P40/t3agT+b6smzAjnD8DTyWert03aunMN47NUW1qu2
 5zMg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785966512; x=1786571312;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=lbXN6kQ6u5VEKBPt/HF4FSMbAFFnwdoiM9OixkwxJAM=;
 b=bE+haxiHckDuO6rdke8QQV1b3XW4R+0dZhodpCRhnHXd2Jdbutpg5IxyjhjjntqZWq
 UPZJwurzQ1V+vu6KqGO8wcAb40lbAATP6fdnkHuRZG/nIXf+61ZCjwLY0YFd/JVTz1t4
 b41eDlGNftbZsZyly6NSssA5VUVhKo2JK8bC56NU7ziW2FFIm1XpCrOuPCfuA3AP24eq
 o2m6snlApJMa/TgqfUxS//VWX/wXfXW0mp7/ZShR2bRGhB/Zv/DvVdHCXXZ41MjfwRTj
 85Rs7i1L5pd28wSsoRxxFnXSPbc9UYobfF05Ve+scI/nMsREhXE1EP4zVmh55PZiI0rn
 9d2Q==
X-Gm-Message-State: AOJu0Yxl4gbo6QTN3iWN9qB4sbj8XcYPxwXxLmVn4k2hnw4CHgmNL9qb
 lnh6gNIfSn6Uw26v/ZlCUsNu6pT2az8Swm8l2DXPFylhKRYW53DCU2k6DjQyDMTPx7f1cdPbRaZ
 GOKj2+zjVRRI8nDG8MCBjC6zX8DOGca4MRfLJ/1de
X-Gm-Gg: AR+sD10W/0bnID0UA/9yt+/nnuGK8UIeObjtwZeOcjn78EYjUxDjGwNxuMHtu1A4d1v
 AdTuXJy/+UNjJpTm+j89rn9dt0VCb8vutTgIyC8ukGvRQj5Af4nhTZRLVdZr7MMEvQQbB69x79A
 82MToP10bObgH5oYc2HhGDbgctH05EsOzxF9YqegG3mR2j3PzkCHWn5JsLORX9aKhvAC24V855Z
 qzgmcOciCJTU95nAkjKEVbbgCv/W++fE8BHPvI6C4q/q5ysAbAgiT8vsaPSMeYIaG8fKBJo0vjH
 1cC/2B2pMMR2+t283TzmBNkShC45EXdnYrzUfsP08HM+roNXe2ADAw==
X-Received: by 2002:a17:907:9807:b0:c15:df42:952c with SMTP id
 a640c23a62f3a-c2039d19940mr566592366b.28.1785966512516; Wed, 05 Aug 2026
 14:48:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260730-b4-fit-ext-data-hardening-v1-0-4a6b91e37b51@binarly.io>
 <20260730-b4-fit-ext-data-hardening-v1-2-4a6b91e37b51@binarly.io>
In-Reply-To: <20260730-b4-fit-ext-data-hardening-v1-2-4a6b91e37b51@binarly.io>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 5 Aug 2026 15:48:17 -0600
X-Gm-Features: AUfX_mxBOnDeWgIXhZO064F2fEJXT5IeJsyxGoVpi3Pep378D_hpnFnKxcViQ2Q
Message-ID: <CAFLszTjsE5guqZQ2AjdejsN-mH=xZEb1Bghw7o4xzyVhD+RJyw@mail.gmail.com>
Subject: Re: [PATCH 2/4] test: spl: Factor out external-data FIT property
 checks
To: Anton Ivanov <anton@binarly.io>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>, 
 Daniel Golle <daniel@makrotopia.org>,
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, Francesco Valla <francesco@valla.it>, 
 Anshul Dalal <anshuld@ti.com>, Randolph Sapp <rs@ti.com>,
 Binarly Research <vr@binarly.io>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785966512; x=1786571312;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lbXN6kQ6u5VEKBPt/HF4FSMbAFFnwdoiM9OixkwxJAM=;
 b=Md2A6M+1exSagChR5hqk1vdI3v8++sdFxBVEoe0ZmR1gMeZHlu4bCGPSZDH/S5ripy
 Tm4Ouja7ORZiJ0RSZmzStyP+KfJy1WYULseFZnrcNQ0FtOcfTUZxsh9VtT9d82jCQq6q
 ok+N71lO4t2CGyzAgZRVLLuos6K7vg3b5sb7s=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Md2A6M+1
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

On 2026-07-30T15:03:40, Anton Ivanov <anton@binarly.io> wrote:
> test: spl: Factor out external-data FIT property checks
>
> Turn spl_test_fit_external_oversize() into a parameterized helper
> which builds a FIT with external data, overwrites one property of the
> image node with a hostile value and checks that spl_load_simple_fit()
> fails with the expected error.
>
> This is in preparation for adding tests for the remaining
> external-data properties.
>
> No functional change.
>
> Signed-off-by: Anton Ivanov <anton@binarly.io>
>
> test/image/spl_load.c | 48 +++++++++++++++++++++++++++++-------------------
>  1 file changed, 29 insertions(+), 19 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
