Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91AFBCA9EC5
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 02:07:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EE0DB60727;
	Tue, 13 Oct 2026 02:07:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 052uSP6LQdCy; Tue, 13 Oct 2026 02:07:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 01933606EB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791857228;
	b=Uz6pwIhK8lQ+3jgeqKtAutgOYhgWJ4xtRxF2kH+G3ZGs0pjhaXY6kbe6FaF4Zd9WNI+v
	 ygF7xU8gdyvsgr2xSz6YuJcaVAR6sSH6B4H+Vu72yrnFzB/629QteclO/lxvYlr7xzzJl
	 dr71LyhZj0r68VTClO2zCAinGZDZt+n65JLXX3dk49G8SVBmBQvmpfmyQWaqmm+IOXAJN
	 KCVwAK843e0dqe+UoKLaKSeg11QRhek1L8Ln+S+AT6C1z5uNC3SYxU0s6XyKGQfpUo4l4
	 TB0lj1yfQXNGWtHgiM75OYqAgMzQgvjsHG+5ewqpbPBH76cftXyfj2pRxJEc9BNM11A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791857228;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=/NxGl2uMQaHKdyEy+R1HhxqZ7g7Mk0gq9Nwnqt/OOxE=;
	b=SqIC5GXKcey8YIF+0iAI42uN9sxCK0y+jvq5wCRZDYSj3A+R5NPWPQgic9zOJvWLhDYR
	 UmQz+zRJam8VnYVkIsOGUQ9QrIKRLxSRCk4ueP9WS7IsQ22TJw8Nd1o74hlLFX05O8n38
	 YyF+ubmfkTY5Vjczw8h9fieePwty/A8sMb9XqCEMkDtqRzFJvFFvz3gWim3ZZvSQ8fIrJ
	 E5hu2tWH9CO3Sk9vnDEgkvGRuXAoLUdcVHdo0Ma7kDi7YmfntS/aoZ+/KuFDH0slYutK8
	 E4stt4Cpu++kK2AqJPnhe5nVKHLIhsfEUz6T12meggCdT5iG+VYGQ9uuX5qxa7/jWGA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791857228;
	bh=/NxGl2uMQaHKdyEy+R1HhxqZ7g7Mk0gq9Nwnqt/OOxE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LjMzVwHTw4cXwrKHX2TFmOXH1tEWzyvz3KnVXrtHq1R3d1++RbERiMQc216lwjr5G
	 MJTFZPg7xHkMJVPxp/Z6+ZDMMpMSf2vWrV1tbC3Nb5cjGJ8WEROCMEp4ahyQo8FOdf
	 yDeIbKGLwfvfYaLVIDeyCDM9HwnmPo1KnZhUqb53WJLj/qNSfnarzbUQRtUSFhtrTN
	 tv1UltRhTJRdnuCh5uOeHSvJGsKSS8nnMr+aFClpseTVYXZM7ELWv7PCCa8aVWl0vy
	 Dq98quwdrrtWZljY1RlkppqGpPA68kw93fZdS2+LZXm8tFIye+kKlDfElo84jejuey
	 1/BN8+z/xUP5g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 01933606EB;
	Tue, 13 Oct 2026 02:07:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 559022A8
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 02:07:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 47D604051F
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 02:07:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id efVsF506h6-h for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 02:07:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3C58E40512
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b130"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791857225;
 b=VEIn5BJLkRtbCiqDeHSI4FEit0LZ7eKm0KIM5lH2MsB22qeDBPlUeGq0MoDl7dPfsWkE
 W92bbEgQxKCinlcDo9pV2EWC6Z9Oc6gJVu2jd/MozLvJB0esV1WSmd9n3p/gjgDW6/b7A
 w7zSCEyPjeD6bQYOFLm+lyKxG6La4FcNFU4mMtVswjwWJ08j0zToM2ixLwdAnvr2JVuQZ
 IIEwQA7ApXsVwT0bEdl454j1P+lZoFqbl7XZlc5/ugMg66D8zj63zPkzdX6SlPdw+ZJ+T
 0BoDGj6t2MlcKhKSjFAVOSsDBH77IVFq4pUIZ022VyDvtWgv5s7TCpCjcPRvpjJnplg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791857225;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=/NxGl2uMQaHKdyEy+R1HhxqZ7g7Mk0gq9Nwnqt/OOxE=;
 b=gjLA43NvJXDKxqMJcKGxDlQq11WN317xrOsOSoD4o5vy6Lb2pMy6hrB6sIYAh0dd/ISL
 1FP6ISPJMmXeljSp3t7prPamSVnuQ2XzIQu5zIT9nxL2oyT4M1p2X7dIy2ciM8OoCP4Fu
 HcaBUXka/G66yQH/FXL1TDWO2QPuCgFactSqqu8epW92gTDmnSzR1HCeOIU7vpdRiQqrG
 O2YrDy1hUKWJ3NT63YG2BQOecTf3tIOkxraf4w8tOUvLNp9GK2QB8o2ap5yCgwX37HBcT
 QUH1rVdomTmEliWRV/bNwHr0eiDi72ZBWMcGgohePrPuN/Wg1jZeCYjrFQTiXK+61yQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Vut5Kj15; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::b130"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b130; helo=mail-yx1-xb130.google.com;
 envelope-from=0xiviel@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Vut5Kj15
Received: from mail-yx1-xb130.google.com (mail-yx1-xb130.google.com
 [IPv6:2607:f8b0:4864:20::b130])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3C58E40512
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 02:07:04 +0000 (UTC)
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-6768403e9bbso1938599d50.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 19:07:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791857223; cv=none;
 d=google.com; s=arc-20260327;
 b=YOGsA1vi7dF7/sOSVIPgLM/Iqk4HD4kDER5xqhUHrHJwJ5xE5tBq2JWd5Bbzidk/hO
 Ac83jcsJNqI8REw8lNfGzdk6p4lD8bfLLmHKQ1gvg2eyObKRkNGC2SvqNyCw3oP/XnFS
 yD8yHnQeONixaynhQ9ty9m8awSdInae37InJfKSpZJNRNAf2WuP1GNUnwo4UKG5CzlAY
 /LsyKYgGGJxJHZhN2x64LopktCQsTDy9v8biybOOARPQCT3/X4LiE3O1AIxquBjLM+Ke
 0vOzR9m/GutgxCnzB4H9hD6B9EIUqlh7aPrTjeZGvXhundm1AQdNj6bVel63xrE6vgrQ
 2nRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/NxGl2uMQaHKdyEy+R1HhxqZ7g7Mk0gq9Nwnqt/OOxE=;
 fh=hrFPTrAq5cA8mNEmx5jEgTgHMhzFW2BQvejOrO84S/4=;
 b=Y0chbMjrUEZn+mY+WmTBUIE/1ai4u0wB4lYesPx4uOVb2bMkd9jIa3hSElqhqbO9O5
 lNhXSRmfeCXgY9kDTDexFSJvLz6UcM5DlJLp2Qfb3VE3Fa5DdMZ3aYto+Qn1AC8WNTut
 A4GynpU63ueSWRih6NNCs+ORx1YFWWOsmWy3XumNGqicLr8fFNcPtHY0nj8GoihlHv84
 uxG2TftLkv47kky4G9hEgMKcPZZHU6XjzncT6xhcS8+fTuVDY6z/NQNbeMFYyk/mlqqt
 g2ZM0d+qw+N1xhm89+JX+A4zU2s6xWuCSjoxs8lUWgWtYoe3K1dLBDF0qqpQCbBWLgvV
 rnTg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791857223; x=1792462023;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/NxGl2uMQaHKdyEy+R1HhxqZ7g7Mk0gq9Nwnqt/OOxE=;
 b=Vut5Kj15DNxcFrUl5gW4iutDk/DpjFYOJjt+CLbZDfmvR2X9Mc7jxqin3p7AFJe+oY
 9EmyAmTtP2i/1F1KW6ITOF10NOHv173reV3kXpSkGSmt6Rkglvb4oa5/PU/T8aoZqhLy
 s//IMz8gb+RvdPJiwTmUkdaHOqlcwaVMhFMQ1u3fdQPKPbvFi8Pk31c1LZ7rhLALlAZo
 keXHTrbHRP4N8QiScSB3SxZJ8qGja/h8EMG/I88NVDUWkVBSOk60CxKEAyLj5KvZEp0T
 /XAIeSZ9XvA/2cWe31QSNkrhP3izsRIke8CTghDTELO5yFCibduWnby0TPFjvlDv1OmP
 /TEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791857223; x=1792462023;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/NxGl2uMQaHKdyEy+R1HhxqZ7g7Mk0gq9Nwnqt/OOxE=;
 b=rykUvu+0+Uw5BO5zEA8Tqbp5Pe5Z6qF1xSOuczC41CAvAT+2Vp9ZvNLYnDniIOV3Y1
 q95N0M1OMDdQgYV07n9JHoK7nkhKCo3VxDlbCRswqCO3g6rm+2IYDgehHkxsbKoqpErc
 radPvjS7Wowdb1ofBUzFNlcMjkMnUW6aTuMmMVPhWcdJGXE9U62VsE6dQmJRnn/Sobfs
 EO/yuKuMZT8N6v4ceMSuw8lx+5Pm2MZiYdKqzEmZ6sOWudpAwNAMpVcHxQDG28yd+P/Z
 aQfsnXEgk2HDrJA4wcgR65xnG8tV8QQfofQjBT+hrmTDSY9vsjmSC1wDAU//nmB1sQRb
 PHvA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzGQGDmq4meFK9e7Z/EgUGqnj/e1uOMN8WWGewz/q4ENQnUV95UQO5KuBSwfxlFB5P8BXQ3uKY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIlf/JwCGf56wvq5oXPyhPMTjnRltnI0C8M4F9rxO6o5AJPiEPv
 LOMSFe/vobpKUHgLhdTDykO9waJ6YEegvHWsPXpNdMzr7SsMZYQi1r5V2G+VuzTMfqB8U5grox/
 f+81aBVFYBJ7rTAjZ9MeiLM0BstoK2LXGUFz83y4=
X-Gm-Gg: AYBFou1JFvMHwxY+KUkb65fzigkOmVNZAygrJRb/kXDsPGuOXEFwZClQrZbGEB7Fl/M
 /41SksoFKqBClbsVASol9JfbJIaDbCBCrs65LSj9WZSTJAMJMc8JCzN6UORK8P6etbxLUpoCX9u
 b4b3UV1LThKTLLGG35R83yNob4NUP1kFtQ4VriNFCo7GJvsQqjnvUdmnjoES6uwquMnI85G8wsW
 AzxHsLa40+1ALz99JHVGyqzh0R3Epji2capWeN8H9uqPYGwk1TqjjRDPfIyWyAD5GiJtkQJafll
 jCSTuNYNyPvEqGY2ZaBYPDreK5K1wzG+dAlZ5hM0RkRMfLq0FXiXg6EeqfLVc9rAgtmkVr/7Ti+
 vbmSyn3Z0jceXTHbpYjEcQT3KcTK39lH8Xdvq9CsYNflD44yZguvzaHCPG+pK82XSR1C9Gp7Y6j
 aITTH2SECG
X-Received: by 2002:a05:690e:4009:b0:677:d719:7baa with SMTP id
 956f58d0204a3-67936a29729mr4653822d50.60.1791857223433; Mon, 12 Oct 2026
 19:07:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260925072741.1966573-1-0xiviel@gmail.com>
 <CAFLszTiXz5V5HhH2eVEVLp_JSMUetcdhCpFD21=5rauV34w_Pg@mail.gmail.com>
 <0ef4b0d7-b436-4afc-926a-d7eb942a9edb@siemens.com>
In-Reply-To: <0ef4b0d7-b436-4afc-926a-d7eb942a9edb@siemens.com>
From: Eva Crystal <0xiviel@gmail.com>
Date: Tue, 13 Oct 2026 15:06:53 +1300
X-Gm-Features: AclHuK8XsgS9rK-eMynU363Rl95z73UyOpjLoTJtrEVjSVflsg1myhoNPt6mVd0
Message-ID: <CA+pz=kJ4zL-On_WBJanCLR98Jy_-0RP+Ni13921vHkJBEXMRgg@mail.gmail.com>
Subject: Re: [0/2] image-fit-sig: close the image-signature fail-open gate
To: Ludwig Nussel <ludwig.nussel@siemens.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
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

On Tue, Oct 13, 2026 at 2:29 AM Ludwig Nussel wrote:
> At this point I cannot put the effort to implement that extra logic
> though. I can remove the config sig enforcement stuff from my series if
> someone want's to do it though.

Thanks Ludwig, that makes sense. I can't take on the combined
config/image logic either, so please keep FIT_REQUIRE_CONFIG_SIGS in
your series as it is, since it already closes the common path.

I'm withdrawing my image-gate series. The image-signature fail-open
stays documented in this thread for whoever picks it up later,
possibly together with the whole-FIT signing work.

Eva Crystal (0xiviel)
XSource Security
https://xsourcesec.com
