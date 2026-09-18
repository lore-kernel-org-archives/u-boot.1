Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A82AAC982DD
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 20:37:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2D2B7812CA;
	Fri, 18 Sep 2026 20:37:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7t6nozyLDH8y; Fri, 18 Sep 2026 20:37:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6281F8121E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789763873;
	b=qD7/r1o25ZB0MklodgDGDROaCf/cVyD9UFfSG0zksNxj5H+2n7B53/yjzoluqC08brmW
	 W1s3I9IYCy6knndfe1jzNPYsTZ4RCeyGccjPzg/DdrUBl21Z0ISqsaJJJ+ybEoPuAzb1P
	 rLbDNvefxS9ptuIXZXDmOjxsY0IcDPpo7D2jgiljeG+Pv/owgMOxjLMk3HTnd/yDE/moy
	 nfJCKwdPXpqTcAvOPxB2HwQ7Y5k7UB7nfM9sr/SU5we3DDEbHaUcqeuGlQfBKeXEgsigf
	 Dm3jbuA5aPi904IzD/Evr2Mq4862FantEhtQjMUU0KQbWGfYoyYu8MoP3Y8lf5XdSgQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789763873;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=eRlKo+pFzYzCrSowZlb1ydFydpg87ju6j0wXqhv8uVo=;
	b=PQm4yINGV7ea4eiV/pVAgFk8Oc9c/btfFg9vgPW07c/q2EAGYGjZKmePFSrvVHX6TNdT
	 Y+SsPaNOAY0+Rw9lfHZc1pzrBmAbNwXIf3+O3St6vfIfId4ykWFWUe7NwGPygX3fw/lBA
	 hwP6ml0RoNEIZso/dc8gpRgNhJs1g1/d0vUDDy3tslIV+DuWzbTfR/TlVGiMFZCEwJqGK
	 HuymTgReBesBRFT7SMGLyvQu5DyXDYJUQBPYWiFGYboTnWm9Lvx09+p24hLqSdrgegGeI
	 X/Uhjq272ZZ+QSm3foqXTQZtgmm8V7o+Z0tmYO5F+GamZLbRlY1hQPY8VwC+SVkg1Bw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789763873;
	bh=eRlKo+pFzYzCrSowZlb1ydFydpg87ju6j0wXqhv8uVo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bNC+dBfmN0Pq/1wHzAbSBfoWHKJIcoKE8bRaWaYfwacTnDS8uuD7ijHEav6PJVYEr
	 ptWsE99OalXDaq73RCBO3qFRW3L23OBwSpCiXSb55iTbByaxdIN4kdQunqfS+OQ2Ei
	 zO12Yt7fvk2XPeZ+UsCXrtwjeM4YYbRYhp1fYT5XsfR5ueDVEZLXnkdEHKFYp24HZv
	 i7ma0Uw7zy7I/SiaGJy+VIosOyMUmRreuHCxaVgJ/h8VegbLAARwPmAKHX/kdCkmBp
	 6gxGt6karAUADvlceG28W269UtR4VSruIivCbrhEtJrHwtJ0H4OVonyuvogQtcsrQE
	 guENDi67Vz2ig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6281F8121E;
	Fri, 18 Sep 2026 20:37:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BE36A3B9
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:37:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A40F14006F
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:37:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 13VILxRF1b-m for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 20:37:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 88DBD40022
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789763872;
 b=H4xmqbpJubtLIeiIYmtaaI9nbRBI3Fou4O0ISERscdCJdxIcdsuUFIvONnSeoBUufHFy
 z6yx+89HVmcCuE3a1bFYzu5wxkIlEz461vlDPk3SIJtdsfrs3al5WiihVXtd6qdhp0gSA
 6Wieyzrx4ZtO9QdZXvo21uoDvSh4gJuy6hvVmRJM7wDl7/bBNnOBAfybiZzJx336Cz14l
 i5uHTHWdZROqR4ktXLIlNN8Ap0OXYMQu1FuhOvEGhDrCNfcVIKCVlu6KcwiBOkDQPd6NZ
 JsqjTlHVqM6hx0hZpdDwlvs0Ly+vWw2Bn2qHmcYOB10xPDPAoNk9caGUCxgp6P/a0fw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789763872;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=eRlKo+pFzYzCrSowZlb1ydFydpg87ju6j0wXqhv8uVo=;
 b=Vv1XQ5lgj0Ne56Tu01QTM2FET9kcCVC+3J5lSvceFvIl9ukrJmVKIROQNTGWVxC61j8e
 yrmjxtHgD03QgdytmACGa007YTBFl1kgIkH7c+OEHM/pNgXrSSNrsR3vYNieNTDGi+BWg
 stTx4uRyvAIUN84Fs5P5/H6WHZczEEAcGSKISzBFUddXHlqCO0iT8bVSUCPYTbqLhiZgk
 pbhY5DhGu7yj7F/O2GkBNNYzrmCFTiDHbAOIWfJenKZGdsk4UHwCAAl90Pi+GJjyCdZJr
 prnbzPN8NIJAq4Kyv5ab84PnTXVpqM49lYJDDRyMpCbXb25/IqJ9h7HAUg3ygn6kw0A==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Eu2+Yw3T; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::f;
 helo=mail-ed2-x0f.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Eu2+Yw3T
Received: from mail-ed2-x0f.google.com (mail-ed2-x0f.google.com
 [IPv6:2a00:1450:4864:33::f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 88DBD40022
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:37:51 +0000 (UTC)
Received: by mail-ed2-x0f.google.com with SMTP id
 4fb4d7f45d1cf-6a996c8adf3so1804564a12.1
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 13:37:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789763869; cv=none;
 d=google.com; s=arc-20260327;
 b=DXmXCB61ntPU9sDkbzsJCi7+CCE2qYuWLglb0G4beLXlhPBpRvpqkhGQQXPRfzPirv
 2YyJV8J+sLLSbxsT7Kz8lxKR2nzg2q9Z+3cAD2YCuODsWZRx4nPy/4+vrMBUiji+ORy4
 3Vt5x0FKHocmiJUFtkO8dXcQVLMxwaouUEOn9cXdE7TVhLZ5jbnHAOvU9wcymAWCCpWH
 oKX2nJYTqpfxWRJGQ3Kpq7qGTVnOzxP99kQwy6035zEKCzqYXuEeU4Rk6OCbSGscsoPE
 jbehAIilqAIIdytvupBbLUIF7gck6jFQtmD+N9cYGgZER+tZr2IcLntrXD1L+rZ4VbxG
 8D8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=eRlKo+pFzYzCrSowZlb1ydFydpg87ju6j0wXqhv8uVo=;
 fh=hMnzCCESv5iutVaH6AX1PrbYoVsPb+wpOEI00M227js=;
 b=g1emVrapkoZ2XOe6LthcCcX3cMcU6USqsRR/be1HhRPVBc7ydXTWRBRA7ij+piCjra
 qe07g453O58InY9QBDQXUi4J7Xp6N62hLn+GVmzxX8AmYftoDqFr2M1VT4FMudYHbQZi
 81E4KoqulkSGi/gDZhKGfFeGK8ouhSteH++jx1TmSRkEakO/s30P9kLfVHA8Y4NbqJx8
 IbjUo54Re/JP0amL5j5hAul13llyGa0So7bCmJa3YGcmFPNhRbEJG9jtXuxf6O9vLoXM
 2FhukAaHqEvNEb6Q+ORsYztXVizOLTJJy6HdhiwIVPhqKDuVXPoQqsdtHbQw9WfgLxRt
 KXqA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1789763869; x=1790368669;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=eRlKo+pFzYzCrSowZlb1ydFydpg87ju6j0wXqhv8uVo=;
 b=Eu2+Yw3TBFsSnmfnLhgKNDDSdPXTon4chZQUQS4VOBGB+wfs61Pp0kQ4APf2e98K+k
 mkGdyoiBFYYxr3E8aEdjrFi8AAYGkUzP0UH45/UakIn0HwjZt2E8KpnonDlu3Rp3Q7jl
 aZPowb1ABLu7KRtUxed33xSYdfMli8TJa9D90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789763869; x=1790368669;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eRlKo+pFzYzCrSowZlb1ydFydpg87ju6j0wXqhv8uVo=;
 b=gJk72KPruK8mJ8h0ifJWEIGtYriOvgwxoyUSXIOW6eEgMnRAh+osBIiEr26mBkHIcv
 M7ow5wDdY/hIHi+5QNdA3F0t8KCxismAyoTsiRrglHSiDm/J8DlOrYHckT/FFfCtVdzm
 k1z2HTQuA/LW/6CTOzB90XeCbVlpn8QGNenbMHQgcYinMdGQMjmdvK3twdZgVlJGLqn3
 I+BfAcN2AehrV6oGsXhVqssWGK5/7idVpqHT5wlbxlq/KFOBRtTjLM0NdQ7iavKkbH+O
 RSMKVCTFU9R2+U8l63/cKS1AeX+nwewF64jDNTsKFpFODzADV0NjZ6tm21beJDz9YM9S
 cTcQ==
X-Gm-Message-State: AFuF++mWDp4ymBocIob2aaOq0NU1dLXweq8VkAlP6sl4G+i1iKS9kIGB
 7S3cr7l1ESrDBvlEvRTeQr2AvGcxG38ZZaCMoFvP9Vc9nkjV60YnJZxosnZ0f6QdDfgbzclaR1e
 BvgbdqI4v+DtuNcdHP2ZlPUrgYdbj5UckjwZrRHqC
X-Gm-Gg: AYBFou2e56bNTt14flUJCadFLnmF/1bHGpTVocjkPZ1jS0UzlJLWSTYvZrnJLv1sWTJ
 O8ja1GvoD9NpEuu4p8KBVGfjV8w6D2zeuzNNSRri/hbgDzTnGCu+KjRbsNLTc/d5ESnO03oj5jh
 J1bclVTKQtRAdKOYpj+Bs27TzNKm3260HOWsDywgA4O97EOMaS4CPyl0/QLJkDqRtXMiX2FBWj7
 5/Ewb4MrsI/ONFvzSxdTBJaiWZxVGxnyeWkVNGTwmffsQFOvusq9RfmjRcQxZTEU6XQVNxhyuTF
 Q8RzoQ0aAGagEfQjun1SaBLn++4VGx+R0x3I8EhVPBuUxbiHL4A6NlA2xipIj/kSsY8=
X-Received: by 2002:a05:6402:320b:b0:6a9:ce42:e684 with SMTP id
 4fb4d7f45d1cf-6aa52650e3cmr2347289a12.4.1789763869156; Fri, 18 Sep 2026
 13:37:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260912124454.13578-1-aristo.chen@canonical.com>
 <20260912124454.13578-2-aristo.chen@canonical.com>
In-Reply-To: <20260912124454.13578-2-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 18 Sep 2026 15:37:35 -0500
X-Gm-Features: AcwNN1UXx_L95r1uG2lz-gSxAftqu9T2rkygfZksVcY3KMSgpBiYCqGGw9r5pzM
Message-ID: <CAFLszTiDPdvo0vZpJatLCGPA6Z+5XWcWyqN15tOy-_h4TC-zoQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] tools: mkimage: use an explicit iv from the cipher
 node when encrypting
To: aristo.chen@canonical.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>
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

On 2026-09-12T12:44:46, Aristo Chen <aristo.chen@canonical.com> wrote:
> tools: mkimage: use an explicit iv from the cipher node when encrypting
>
> fit_image_setup_cipher() only consumes iv-name-hint: without the hint a
> fresh random IV is generated for every image, and any iv property the
> cipher node already carries is ignored and later overwritten. The FIT
> specification defines iv as the raw initialisation vector carried in
> the FIT and requires at least one of iv-name-hint or iv to be present,
> so an .its author who supplies an explicit iv reasonably expects it to
> be used.
>
> Use the iv property when no iv-name-hint is given, after checking that
> its length matches the cipher's IV length, and only fall back to a
> random IV when the node provides neither. Besides matching the
> specification this makes encryption reproducible, since the same
> source, key and IV now produce the same ciphertext on every run. It
> also allows images that share data through the image-data property,
> added later in this series, to be encrypted consistently without
> relying on an IV file in the key directory.
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
>
> tools/image-host.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
