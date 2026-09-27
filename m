Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E06EC98332
	for <u-boot@archiver.kernel.org>; Sun, 27 Sep 2026 15:40:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E5C8B60621;
	Sun, 27 Sep 2026 15:40:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3uvXd-mpSoLu; Sun, 27 Sep 2026 15:40:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4152A605EE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790523648;
	b=Q50pf35KbJX/qWZ5f8fE4uj6tOb29uZyvTvLv/lT6pdaqdIA+5jcUsAstjtg7SyLVz1J
	 3vXNaAe8jbR7VSDwn1ndRsEDqMzAyse+i5vzpar7owjdarLp7rLPckXAiFm9pSp67tLF0
	 Z7rVuXFbkUkpvawaYFGkIMOhBUGac+M2zDpYyscu1N/FAsxjqrw1Z3cKcq+X3uUohPYuq
	 RlfhzLQXw61oC/BMRZt4/LK0g/+mcIdTYDKXGYjdZ60b8n0fFlv7FKJ0Tsms0BbU9kBX9
	 KJvzUGXdix4k5VxirR6nzY1FLRHyN7o1+7hJhbax6YccXBQahCGvsA7xV1VJnhHTLTw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790523648;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=0sQMSWfn5bH+OBVqolqwADi/Oi7J4CKYRSbF3eYf0Gs=;
	b=LlgNN36Bl0JiDNEa3vOkQLJ0TG5WLe8w44FEjDnkBJ2zFsEY6sJ8jOLII4DGvoMN/Ea/
	 n9zLEqs1+21/l1HZojLPcv7evwdA0YQqtXfGzMIGfIb8gyeIZcGVQ2LOptrJAJGCt2+Uu
	 1Abx0Pr0HLWzCdNCNxL6itouAO88nK315IJGb5zLBPwgqkgX9qi358k03c9dY86ereYkm
	 moCLQO82phIfqkGOH3yyrvmVFsz7Vd7TIs7gDEDo5I05AJiVdx6syMGDZs4GMJdV0oM/m
	 fQg5Hb4KbE5vdHevjLT2pI1oD5lQyI1fKJTDRmStltaYPe1goXziTflZIYhB9n6TBLQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790523648;
	bh=0sQMSWfn5bH+OBVqolqwADi/Oi7J4CKYRSbF3eYf0Gs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AFwFB/bppwD0eOkgWIaVpKKoRyyaJ3HSgu0lMstClL9uqG+sqHzc7ERANAm58lM4q
	 M59F3fOSwQ5CrcccPuiTxoYlpkb2nF97/2uesvdz1fsuO0Q0IkVJQZ3FFKaMpKcG1R
	 xt63PdYFcCScG1vfcswPIP5AWkuPz9JYJWGe/EQFrfk5HUprg7AXqWu/aqOx+cUNwQ
	 ZIRMVw7wHqVCrFZLcqVm7+ElB4VhV/WsNW/av7mnZ2yQMJKdThmGr3kPdUHLVI6A99
	 8tr9vw7YEkEP0HcyQDD/m/RKDp1ZzbJ/qM7lcCWVkx14Xa9KBEC5o9d63butVLZW4e
	 njXz9wio1ndsg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4152A605EE;
	Sun, 27 Sep 2026 15:40:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B4277194
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 15:40:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A5EE140759
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 15:40:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D2qAUkg-v20q for <u-boot@lists.u-boot-project.org>;
 Sun, 27 Sep 2026 15:40:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org BAE1C40757
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790523646;
 b=QIHT3YFfym+QeHHfJ8bfmcmOSEwDUWhIcvyO3wCXhb0Rdc2Q978n2lCRt/g/4iHXzDpr
 MpDWXYb4xGXyXXQM2mjRS9r0X3Kieyf/MsH+5YxSQtRsGYNtkPQjlbcsI8LqcHU8Q043J
 NJlwC+xSUkoWoyEiBMNI2hFzMhypr9DMfYRdSkbxmGoYKceV0plHS8D647xpWM5MHULLF
 4VNz41ZflFv24zDRKKtQGVtRtcS84+s1p0074ZkiG+66rwnsI/vwjeZOaK8NdM8ofRSxX
 Sv2z0kcXaaFe+N4lGHRDevMDPPpL1+FO5Zru8AfsOBn+D628pO/b5iPbsoy19JyNWUA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790523646;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=0sQMSWfn5bH+OBVqolqwADi/Oi7J4CKYRSbF3eYf0Gs=;
 b=D8XLmDf64lGE4f3U6g1bmldZm4lBN02YZKwa59lDTjyxiGBG4IzHNiHg65BWIF5F5LhM
 vjDQ8Inf+NdBMo7ufAG375zRcpBGM2SJuIoKP4gZ4QPtA87hngBbVfHBngsYcrWUeC4Ob
 czuZiw/JiAoRnJUjC8W5OPGxJNuJziIJvUXKviMeaXe9yJ1FGbirmXmVL+ODm0JI9s59S
 l2yQsQnbESIJmSnCj3P2WMtvcCmsNOphJppoytrEL8xFN4bP9IBfksAB3DsiYUy9LWNE2
 AeTuuAU1P2Rc1AlnbY7t1uHWQWSqATJvuYicebHoGG4qOF9IMbVuebOHfuimZLdqzGA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="n/9SdyaQ"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::e;
 helo=mail-ed2-x0e.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=n/9SdyaQ
Received: from mail-ed2-x0e.google.com (mail-ed2-x0e.google.com
 [IPv6:2a00:1450:4864:33::e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BAE1C40757
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 15:40:45 +0000 (UTC)
Received: by mail-ed2-x0e.google.com with SMTP id
 4fb4d7f45d1cf-6aaea178c96so2476924a12.3
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 08:40:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790523643; cv=none;
 d=google.com; s=arc-20260327;
 b=N3oJxgZKh59in9+yD3V/ReM1RrpzZC//060sz59/SJVgCgwR4DFdJdscjuAVCnH9Qh
 EvOPTMgdyShhi1EP6CuDxx4BcpdkxONhXldSdnjr2xF8YLpJcdQ6jEbACNaz0BShS9NN
 k54abC3EWowGXz4Dp6Lt4SSD4V0ZXZWb1KWPIR57IAMA+eHv3rhjKspCoDy+OY4QXEOD
 dw4H246dWam1j4NGNeX0YVjcYcdCoZHIBHWSjTNMSCm/EhD4qiV8a4cvkxkfP50K0MuK
 1awpMEFkKAxe4x+VquMaRGQQnVF/E5bjze7n2ZLa9XwiorvZLy7UgKK8H/FXo7pqRq0B
 8DOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0sQMSWfn5bH+OBVqolqwADi/Oi7J4CKYRSbF3eYf0Gs=;
 fh=jhYLnt/PJ2QuhNxV94xdAISUhFYZwaC4xX+bWUPEezQ=;
 b=i7RkmfXScRZ5HwA6NY8HdWU/ACjn/wg4gw8FFhOne9/+oQ/DW/34lYxbIVfBONfL4s
 5DOF5euFOrWxbXBdquQvQPgn4+uVK+hRiAUzFHPpn4U0G5+nukskwJolP8VNLe3xafgA
 h8MnTcEHE87YM3W2QduoOG5cJhxL66DkviF5rKKCjZEbLUT+o1TCZysspIfBlU34DyPw
 0WSV19Fap6gMelFsy7KLCR/UsWBnzT++t0jK4Bxw8Dvf0r4vKe8VLuFkg9GfpM6dbLGx
 vkkyYZSeYb2fWzbfJ/537otjM64SOO7GaCbBs+qy7C8YWW344SGuz/EIojYlbMPX5Ton
 fpdw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790523643; x=1791128443;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0sQMSWfn5bH+OBVqolqwADi/Oi7J4CKYRSbF3eYf0Gs=;
 b=n/9SdyaQKORtstcl0SCDwiVPvMx6iHTwXCTVT7ewum4MxZMi+4dZwVpEJdSct7BrYk
 2TumKyeK9IUknVfCKuq08P8ccD8lBFVvIjOIJZvSKl5JESF9t+cFM8cUtVHRmXGxS2ly
 Gcfhk3wDUSeiuD5fKUqkyvphc84XHvii2/Klw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790523643; x=1791128443;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0sQMSWfn5bH+OBVqolqwADi/Oi7J4CKYRSbF3eYf0Gs=;
 b=PZKxmZ8QWNoqDVWUzy54nvGLlFB+USaaOgsTi1PSd11TihfNzWMEP0gVf17xnTzF5t
 NlzQLVMagzHawxz9sbjjKORPaTYIe6L7YSh0gZCFI8MZHTQmYew3OgZVsU8XyETcTIRX
 S3AAJ5YMy5AO4Oc4AcFNITgWmx6zEenJoyCRR3ChkkPLX5wRoTH/DGSdIBvRBizak+X3
 reBiUhxEa6q2OvKRgdqw1Em9AYJ8ntVAKCuHvKRkBwmkrUbYM6XlAMXVQ4Mc3xO8pWUT
 FTkoDJ2LC+2ZY87KWo2in48iJ4igDwtNFqPyPhNXz08qXtQJEEvsyAQFHgHHMCTaU1O4
 oYGQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxaA+cT4fOigaSgfdSOLwOSttnguZnR5I8/xUlIEdtBdJST0xofVsGgBaLPzWEgXYc+w7NnfZA=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIfEa9g9zUCM9ibCkRg6RVmg1V7IJH6C63IRWjNKaNLBmorTYsh
 FyHgUfab6oFvh5+S3CwbOFYBAKfEihHs9Lvk+JcH0X1QL2yGzLCQwHzsZjaU4N4yv31QKlRqnkm
 Mba2si+kD4DBV54PO+XyZJ+yYTFehcdTPhy0NhCRF8F35Ijblyqk=
X-Gm-Gg: AYBFou3OyUZKydbJHcn/VEN4tUxpqzWQ0DFn3HWu7UUqY4+UwUhPK//wXQPrzLJpTWM
 4mCtN7M604EZyUAhGXtm+C1MVrX0NLh7by/ftkLmkherniaq8P7bvcbhOKRIU4A2BeOm6ftEvZT
 /rzqpSqG4xiT3nQNWzBCvG1yz9BVkK0UC0ODuTChtTOvNgE+zKJO0mkRS1EHxQgkKu7I1RFbb5/
 2xIqSVq/JTSbZ1Qp8fryl5Y/vDiJn8u7/xv8g5qoiRkjHBDLd9EKJg5/B526Lf891zwjLhNyANr
 4Aeat9k26WPdwYz/QE8xN5VM7Os3lE0h/nav3nP04+sIoqDrZJSq2A==
X-Received: by 2002:a05:6402:46c5:b0:6aa:13a8:bef8 with SMTP id
 4fb4d7f45d1cf-6aacc4e656cmr7188666a12.4.1790523643107; Sun, 27 Sep 2026
 08:40:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260923213002.1070404-1-visitorckw@gmail.com>
 <20260923213002.1070404-6-visitorckw@gmail.com>
In-Reply-To: <20260923213002.1070404-6-visitorckw@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 27 Sep 2026 09:40:24 -0600
X-Gm-Features: AclHuK8HUeKi2R5vm2PY6O4FE6Vorc32dY1PlmI9PWw_djC0CXMEXLk16f56rjY
Message-ID: <CAFLszTjFqMort2ASeA+4PLx7qMDCANR6irmd=O05cSP5oGo06Q@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] test: 9p: Add test for 9P filesystem
To: visitorckw@gmail.com
Cc: trini@konsulko.com, tuomas.tynkkynen@iki.fi, bmeng.cn@gmail.com, 
 sjg@chromium.org, jerome.forissier@arm.com, jserv@ccns.ncku.edu.tw, 
 eleanor15x@gmail.com, marscheng@google.com, u-boot@lists.u-boot-project.org
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

Hi Kuan-Wei,

On 2026-09-23T21:29:56, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> test: 9p: Add test for 9P filesystem
>
> Add automated pytest for the 9P filesystem testing directory listing
> (ls) and file loading (load) over virtio-9p in QEMU ARM64. Also enable
> the relevant configurations in qemu_arm64_defconfig.
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
>
> configs/qemu_arm64_defconfig   |  3 ++
>  doc/develop/pytest/test_9p.rst | 10 ++++++
>  test/py/tests/test_9p.py       | 82 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 95 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
