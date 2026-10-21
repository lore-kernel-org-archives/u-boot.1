Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBEC606A31B
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 13:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TMnZuuTb;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=LmIp7M8N
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 22B2760844;
	Wed, 21 Oct 2026 13:07:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1zRgGAeCBb_I; Wed, 21 Oct 2026 13:07:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2FC64605F1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792588022;
	b=UPddcNBL/YPXYf5y7yR4VAvTpPKx/8s7PPZcPDxazohdSP8ZmKbv2nmIHPEyLHO6422/
	 yLUU8ng4u/QY9R/YaQkOGeKWwWjNHU2jue6tCASVOSgqs8tEeENwm/9TsIZwmGgRNKKoY
	 1prmm0iUIcIl2gpREuwHrPUTJAOAg8eGelBDlA856SiUg9o6plaLt4ahjxlbCrrVlaPor
	 ID9h0zfH/2yy39BIw8nH/8eXnVEIZwQvzWgTIT8sYeU7pduMnkiJQwxb7cmAvBU5mnccP
	 juuLRmhgoBXgjvg5kUlZkmewXCqc/ZrWCjNM5j/OsHoCD46TXc/1hVI3EVwOv5TW2XA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792588022;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mp3xycaZflZdgBpDVeOFSlsonqsxmMVxgiR25askWl0=;
	b=L7OtE3tFp2q9F9+YF6B6ObFI5708IIFmhIddFZifyy6oJe7HYkLskIVpd9Db5O2JMrDg
	 a57yIjgEBaLjC+O8r2/9nlStlkSp3xalBKV49XiAiZqdXzAe/CI4Zil5UdpdQhll1BCjI
	 TrDovOImKHdwA42SqVGSS3HOKIxiymzO9iWbrbKdxHObd9XdLtHM8IhiFG8EMwL6YHELS
	 eKRr2KtMv6+iqEs0OwhyH5ie5U2GBo4/Rprwu2fkFAQEBz0M7IF0hLzBXZzKvtoWT64c8
	 2aEstY5ipcYJ8J3irV2RdS8S2O4m1aKplWZnABMUf13rZVe/bCpB9zsWFlVRN2Ed2OA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792588022;
	bh=mp3xycaZflZdgBpDVeOFSlsonqsxmMVxgiR25askWl0=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TMnZuuTbF/8AqNcNMoeabogooYUNH0KZ8CuQVSFEHIHt01tcKcO+YZnYPAlQGanVw
	 rUAevcDbuhgQaMZGln+uMKyL/lG1AfuTnOMIRbZFyExH+LVlvDrxEmFVHE9aw1ZstV
	 5N+okC/d7LeeBFCn3M3HI2f0xtBUVqYDr3BnRZnpYD3TC08dVgSKMHpf85AFJQpKpV
	 eB6A61nx9oxGGT46tAGxHNEd9pXUC73hunx/VhdotDMxXBOG9OJpyN8zdyBh4xXdiX
	 clHHf+Y8Yy7ydX9jRzyzYcbGYVC4OPP/q/RmNUVIVV9qpmbfsD//Q446a8la/b8TOP
	 jOKlqZ2gYzB7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2FC64605F1;
	Wed, 21 Oct 2026 13:07:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 440B5930
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:07:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 29CE9403AF
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:07:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uM7sbymBph-g for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 13:07:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org EB5C4403AD
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::633"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792588020;
 b=HcVRu3abMOiTZNRrpafOr45bFd99UxLwmDDiUlswIm3RShBzmQ3nA2wrIOIYi5RKWS0W
 fbCpKbmT0tf+OMw1drTuCyUrdwOia8/uV+Ln1zDTERZq4y/0Hg8PIVQk+PmWUbGanUFyp
 11G8p1kNUQnHnq80sOH514rCLhItcin+zIE4jdXCeNN3YUaZ/PvvFx9gF4OO7nM5mqHqH
 uSAAUZckjWI0MXOeIoxybMqWJYnRyX3IzGxLIFOgdZWxPXb547uhmwttaSluiEvo1U9N9
 EtV7P/X5TAD1Jv7xHyCgYqc4towqq9anSj/1Vu+8n4Y8se+L1vSu6cJCjYl2QhLycLQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792588020;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=mp3xycaZflZdgBpDVeOFSlsonqsxmMVxgiR25askWl0=;
 b=f+UWDNndo6cpmQBOpJ3xsiWJnBouxmiP3C9lVrhQUM0NGoICkHgbW7vAjbq6kS2O1IMJ
 /lhOIJwDNwkG7crq7kEEZCGRuwPD7gFl6zQnsHdmjPA4GT4uHE693M6HW1wNbCNl9ZcNz
 dLlQLCtJKwp1LBqTgOjuND2ODECOIkfD+kONWF5/2FzPYDyC8rJasVeF68uvP1snN2OZz
 uSkiZsnlmTusqnc96RmHjU5CQ75BOSKOSrNIM6d0wBw8SmOIHYo3rBER1vxfcaKbiaKAw
 IXyfpLuN4D3CiexPNbDHZHiMIU5cOr4SmbGfmR2t0xcSTyIcVtiwwixYnIeJr01Ggrg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=LmIp7M8N; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::633"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::633; helo=mail-ej1-x633.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=LmIp7M8N
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EB5C4403AD
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:06:59 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c4677aad67bso72862266b.0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:06:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792588017; cv=none;
 d=google.com; s=arc-20260327;
 b=CIVL/NGJsAfjIingHPC5IfCj2QomTvjmGcIrLm+mQ4B3/mBBb3OSY7hvES5bWY3HLq
 KvMqptJWTwMuXUmVeqvrWKozxr5CTiVAy4NJdh6PmFc3+ipYGfKlXzmJB09G+xGnXM/O
 TIGi81FsObl3DwOvr/KRSqkLVz2Yx1hkOu0+rlMIRENgxcqDknpD/40bybjOMhOCNLv7
 d5sZPJhgmVu0vAE8NAnC7luDreqd+09se/2GEPBfydGQfmcVNz3Svthd64lsfK3y3Awc
 WIg9JPTL+y3soBUFPtf0WlBpTrGN6weF09vsYDlGIODi7o5wRYHU6bkYLR3wmRHQhhm0
 kwbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=mp3xycaZflZdgBpDVeOFSlsonqsxmMVxgiR25askWl0=;
 fh=QSz2LWxXxIlE5sVY3cc6rCrz5I3EPoPd6wg5hM7ii44=;
 b=p5hiPZJDNX7TNPe94Jn9DyxnSvdGXNAPxBLjTz+6fBC6kK/tLkPgz7gtkNbjhKe62D
 6s/nE2ZpoaYE4gDXZ1IJ7bL5uNX5lOP37MvAWsJ0gujeLfS0XoX2dG5OKi2x+Kxx4u6J
 E1F843jMyF/j7H9KtteGeWad8+9rFbf1XzVZJoBD4L5f43slaF4xbBMN15dhv9tSz3iW
 zjYkJ4jGm/M8yyyW/GK6ejaj8GCkWXw+JcYswLyIBKEHVleyM4uB9S1r5Jb5VNsQHirv
 75pxlaY8dbPr9W5Z43uXc3J8Pru9wF27dpeLtu2RCRpD+fmxtYHTALPx+FaHqWzv4TJN
 bo2Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792588017; x=1793192817;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mp3xycaZflZdgBpDVeOFSlsonqsxmMVxgiR25askWl0=;
 b=LmIp7M8NoVMxxuxiL7xzNeSX9LzqKuTpi5zjrLLelOkSv0geeecfXluB8ZZzuvf+/d
 fS+5SJE8ZYF59ncUpt6HlAumG2wtGwaZSTIjg+s7kaMuE8Qu+sYR47gyN0G2j/2LII5E
 AECl9hurIGduzTWr9Q6tBrs5rFrWnYVoTxrnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792588017; x=1793192817;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mp3xycaZflZdgBpDVeOFSlsonqsxmMVxgiR25askWl0=;
 b=qiiBMwto+hkbZinKADjHy01xXB1VXBgTyV7vq0ktIbvpiNXZpr+EEWthQiAf03dG1/
 O5V8AgphxWPRx7GseA2L1S2e2GKdiu9FvEfG/ZnT+k8sUvKE0462zc/crlDRITlVJQIL
 CUGXxrKx+WQTu1/u1IDlJJP7mhyYRNfwbOekltM9lQuf5sMNObI+zA3fV6mxVwefk7NI
 uox2umApIkFchy9TYs/P1dj2WdEIv1Qacc/Ml+KSxYBpnY+8rwxQSLWWk8Czw9hPYbhf
 xHqw+hBcmR4ThuyT6v+KSk3Mvl+MbkXKVqGeppCvqH0Q5c4pr0odR9QKjK14FARdSblf
 cW0A==
X-Gm-Message-State: AFq9FYJS3jAUeBWupPTn5RK11tTHFbGYbRyTa+qGt5Qcxczuu7EOG0ab
 wPVcqbgKpvy9XJMRFF3yZeElkTFDu+BTz8E2m+PaKzPG6sjUAdRp7+GL9BcOJVvhC3ntCChrYzG
 A2lTh6ijijHiSTi5ek3IPANT9YrNxNSF8uLL2++jYjk3TqZ4aYj18WA==
X-Gm-Gg: AYBFou1oyDou5CZWwD3SdTqaqlldogvvS2oNWHCgBNsI1t1ClpB3YDsFcMdR6sXk/vd
 6Ui/IlNPAUNut4fPHk4x0Wn2vNS1LzcrGl2Iu+yGWJRXZYl7r9VV+nqlNpmr6EYnmsTzXBLxd6J
 LbyqMeRUU/IsK4ZWG1NTl5wWzFY+iIcgDRk+gsKD/A9WFwwuoojQO7wHa1VxC5LI7zA8bWtjnWo
 SSKd6bZ3YRoKgBJIqXyM5YXO/zY1ZOG4RmgBZxNzD1t6RS70gZnCq7UJh21q9f0lzkQ5MbNuzFS
 JD74N48L7aiZTYmwrRhX7peP3ejcgKdl3X6mSishF+VclyE5KwxN7GF9Arzch5kjzddGXwIyT5w
 t5T9Ub2NUlINZZBEQ5fxIXxlxee/krSMzGtEgglMtj77BAOuKRtgBNys0
X-Received: by 2002:a17:907:3d88:b0:c29:f5d8:9c75 with SMTP id
 a640c23a62f3a-c46797aef75mr180386866b.36.1792588017402; Wed, 21 Oct 2026
 06:06:57 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 13:06:56 +0000
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 07:53:06 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261013130235.3172204-1-hyyoxhk@163.com>
References: <20261013130235.3172204-1-hyyoxhk@163.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 21 Oct 2026 13:06:56 +0000
X-Gm-Features: AclHuK_XDCKh46U5ItaCxY83oIj9XIJJ7cJQKYEYDN_VcIPYwTh1aJo5Lf51fvQ
Message-ID: <CAFLszTiDZK2PymbTTfNoRPtDRnxXq=-aYFKFiOBgEWTV2OJ3ew@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] bootstd: Support scripts in raw partitions
To: hyyoxhk@163.com
Cc: u-boot@lists.u-boot-project.org, sjg@chromium.org, trini@konsulko.com, 
 alchark@flipper.net, daniel@makrotopia.org, jbx6244@gmail.com, 
 quentin.schulz@cherry.de
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
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi He Yong,

On 2026-10-13T13:02:35, He Yong <hyyoxhk@163.com> wrote:

> This series adds a bootmeth for U-Boot script images stored directly in a
> named partition, without a filesystem. It first adds bounds checks to the
> shared legacy script parser, so the existing script bootmeth and source
> command benefit from the same protection.

This is true for legacy images, but the FIT checks (fdt_check_full()
against the known size, and rejecting external data) are only in the
new raw bootmeth, in script_raw_validate(). The existing script
bootmeth also knows the size of the file it has read, so a FIT script
with a bad structure, or with external-data offsets pointing past the
end of the buffer, is still a problem there. Please can you move the
FIT checks into image_locate_script() for the case where the size is
known, as patch 1 does for legacy images? Then the raw bootmeth only
has to work out the size and read the image, and both methods get the
same protection.

> Changes since v1:
> - Split the shared legacy parser bounds checks into patch 1.

Patch 2 still does several separate things: it exports script_boot()
as bootmeth_script_boot(), adds the new bootmeth with its Kconfig and
docs, and enables it for sandbox along with the test.dts node, the
image generator, the new tests and the changes to existing tests. It
would be worth splitting it into a small preparatory patch to export
script_boot(), then the bootmeth and docs, then a final patch that
enables it on sandbox and adds the tests. The changes to the existing
bootflow/bootmeth tests need to stay in that final patch with the
defconfig and test.dts changes, so each commit still passes the tests.

BTW, 'test/py/img/' is a new directory in mainline. At present the
image setup for the C tests lives in 'test_ut.py', so please can
mention this in the commit message.

Regards,
Simon
