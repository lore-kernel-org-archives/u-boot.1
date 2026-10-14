Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B3DCC6B35
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 04:53:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3F012608CE;
	Thu, 15 Oct 2026 04:53:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mgb48yW6ImyP; Thu, 15 Oct 2026 04:53:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 37365608FC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792039982;
	b=tUAH1SwHJHRIq0tnf++Ckl/b7uSK6yA0rDpd6MsZEWg63ZGkqC3XGB/CE4hhoYX9RCXs
	 JqXkVQ9sy5cbPwpqGTfxd2c6twRVeZGndyh8yQafrgmPlTz1HI+SF/kupnX8//9/g8if8
	 kUVg0rpQPzRjqtGE0quWOKhSOItfd6Jwhy9tydCMNZMqmKJUIizdZobztsbfPhfKTODqo
	 yoVbYaxwwBREUJrW7iDEr3Mj5h17aW3gX/Apz7gGWlPtjjDleXrh/9ObgyabLihe8xtwP
	 viGq8azmpXdkBZHMVk50wMHEcl4OomJY6o4rYLvssY8RiswtzYKtAkg52Wd+XYhWezQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792039982;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Message-ID:To:Cc:From:Subject:MIME-Version:Date:
	 X-Gm-Features:Content-Type:X-Gm-Locker:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ozGDaBSaJQ/IuP+Mh2KvFZCAaWWMulhvoVjDC+LHCrU=;
	b=EusNko3KpbUTirm32+eh15Z5UQJnkNbFPrDymRgsljoYOhgTQr08w5LHR2P1saBREj1C
	 ufAavwCXgmCMPednecfMKw+u/GNgki9pW55t8Yd29bhRHMGBTS1qgltiRkA/Az3KT1MA0
	 1p+s436oASrU+/TFu87E2VnP3KvWlfGZkbTgTectTosZ6PGgZKXGOHiRY93kVKaUeasdJ
	 f7J7LJ+f1CpTIxwNIJiy5BHnVNdBlJSYQDKMh2i6k44a2X5gzPJ42pBUItcJj+CPyVTV7
	 0nFYg0rQ17y2+mEcdm2ipcExf+ha2jXlQjbeo5tCVWDmJIxaDvwnbg861sijzkz5Qug==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792039982;
	bh=ozGDaBSaJQ/IuP+Mh2KvFZCAaWWMulhvoVjDC+LHCrU=;
	h=To:Cc:From:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=LWzV3akY6x+unasya7SlnAwwBrvOGrGT3oVzj+M2/jXJiKBGBg70ucM2tdCoKawuB
	 kfVSJVIiIu3Xurq8zEHK3YJKJR/2c/NF58Pseqa+N6Y6djivoBRT/WiJcFc1ZrfZ4+
	 PK10o9vL9XJFfahfAZiIG4JFzLe4ODoNi1eCozkM9yPZtuk8gXCwDCwRKduUo7iOR8
	 9Sw/27y4/O2aE5dyDXi1Hqx1bz5eoQnxpZQmJx4nILdbBsuQV5cRbG8DrrzsmEHMfi
	 CQcOGWkpF4A8qDdb80uUc7wA/c6DgCxFVJU2XvjT7phVIzTGmRusIJXtSAoJ5V3d8o
	 yeqF/sg2uZ11g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 37365608FC;
	Thu, 15 Oct 2026 04:53:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4193C255
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 03:49:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 234DB40806
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 03:49:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kcvhEx2o6dXI for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 03:49:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 08819407E8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1334"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792036149;
 b=nhwz7SZ18Q4E3SFs6vhgfJE2cJEoUVxjsgVIzyPLGyDeV/ERdHUlz34Bb0W2O82229F8
 3locOnkFSUIII6kExpIIcdohFav96rKqlUnWzMeOviV5+zIJe/cnb9Iy3W8fYAHMciNSm
 Ai2CpFd9PJY4Jp5CDkd3HO9oHVyotnXXUVkF1RpS7b0gnpE6EwGNAulULuToERwTOUVRc
 EE9pi2ww4ZzLclZfrZSQUZMfiyVmwRW0vIlGM9ni161N3zQJGVqY9GRAUhUfTW0+7ffsT
 tuzQ6qStlS8nbleI44n5wJsnXK+L6Lx/EMEnjP2XIQN94Ti91WYn7LMEtArFmGYD7Mw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792036149;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Message-ID:To:Cc:From:Subject:
 MIME-Version:Date:X-Gm-Features:Content-Type:X-Gm-Locker;
 bh=ozGDaBSaJQ/IuP+Mh2KvFZCAaWWMulhvoVjDC+LHCrU=;
 b=IOFcb4ZSnw3l6UuFafxOolCkGCAiAw0RxefeqH0Vrwhopt0vPYILj8lrU0ebhPgcuSZo
 yT7uOdJkvx6UGtT4H11amFS6U5VRlesrTMBmPS4ouS4oPUv953zuwKs4/9vqlpuio3cSK
 KplrVlHiul+LkhesxujfgVMn4+InN+evjGgpSIphKKO30eoTq7m5llpllpkDw8SeAEqYW
 t3nZP9898V5Eg3+mDAnOCqP1KGg/rF53pCKtdcIw6YqKkAaCkF5vnySQ3ZcRdU+rAC9DY
 qfnHKUkyYv8Jo4PilLDfNVizGexuKsZL9RTMooTfoyj75A4RnoDkQvYoSISTcceekNg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=CtSZdcLt; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1334; helo=mail-dy1-x1334.google.com;
 envelope-from=coseamc@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=CtSZdcLt
Received: from mail-dy1-x1334.google.com (mail-dy1-x1334.google.com
 [IPv6:2607:f8b0:4864:20::1334])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 08819407E8
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 03:49:08 +0000 (UTC)
Received: by mail-dy1-x1334.google.com with SMTP id
 5a478bee46e88-35b2c599f43so42183eec.0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 20:49:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792036147; cv=none;
 d=google.com; s=arc-20260327;
 b=maki2MXctpobBHCUFuMq7dqhztFcZHNVYJ2CG24mH3/cxCUEf1abtPaygUNO1OXtnd
 q5vpiDFVrqbGz+V1EBRsXyBEa46uqZp8sUil4a8E6hAJD0zSzppVXRnc1TsbqEQzAFC7
 d0n/gh8TG+8gE6nrL7GECy7i2PhEZgcZL1+95zLCddxxOkFerqVzC6DHImoAcbHZFimo
 5zJyCE1wMjJi4BniAMJ+dNcfsN9t4r2ng1B7O79LRE3F6sgJ7WL4zREPGsxhLny/NkMw
 ArWCJlruaIu7n79Tg0g6PNGSFvvqf/qUdt9jtj2rVatlB9nuIJhC/1oiznDBVRE8kePs
 fLCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=date:mime-version:subject:from:cc:to:message-id:dkim-signature;
 bh=ozGDaBSaJQ/IuP+Mh2KvFZCAaWWMulhvoVjDC+LHCrU=;
 fh=2U73DS1naPhxny3eVs7n936lUmeg0iUJfGRIEPBdaWA=;
 b=LVu2kadTiMYjR4w7E0GTyKDPWk33jnG0rq3ym01nfvCvQHr2awvaoQB3T/2gjdjc3Z
 VRHltx1r/0djgWF+PyKIjnMqpPu++JVM7ZTj8Xaji8TTIUQne3VxxINCtgeU2JSY0oTf
 2MaUDHkJJ5a0DpDDPq0fq4v6U9jqOBTl40bmn6sj507iLyJjp3x6zN9HMTuWp0ne93ry
 l6kbbHQalOGbaTHvtor88h3EOz4/mP39rAwnCRfWZVvh9njGRXidkiAM5G6jr6ZIb+zq
 7ldyVoHoLf/RQpbyhjq1iS/ysY1G/9XUfgrZUa387t3voEgdZSXHWbT36u85ZH/fpuaX
 NsDg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792036147; x=1792640947;
 darn=lists.u-boot-project.org; 
 h=content-type:date:mime-version:subject:from:cc:to:message-id:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ozGDaBSaJQ/IuP+Mh2KvFZCAaWWMulhvoVjDC+LHCrU=;
 b=CtSZdcLtrckk0IKoE4n8S3gROLLhFmZVJUV1iY5o7Yktz+4AMVyB0yH0NrmKCu4Hmv
 yT22e6b2K6AwOzNpHpIYm+G73lcczRt4R6X6sjLxq1nRRz1wGsV1x2aWXHfvgqUYNLkt
 Jte0Ad2OlNv3kNKI87frrCbTov/7g+Ytymn/w6/w/rn3CcRUBF8DP3FVuZtIGzAjjDvY
 YS7z/WUz70U7zS49jnQeI0oVRAXIHMfPIr6IX61xHnH8OJcEP07uBfXU6SfDZKK/cByU
 WCGQzqiMx5u0uY376KxQKLeXW4XjrGEsmymJ+YSX9ZFdoy/bZygn/1gU7TKzP2LJnQZF
 yiFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792036147; x=1792640947;
 h=content-type:date:mime-version:subject:from:cc:to:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ozGDaBSaJQ/IuP+Mh2KvFZCAaWWMulhvoVjDC+LHCrU=;
 b=h7KuwxwB0owbMVMCDpnWrK4ZETV2M66gCfCMhBreuHZ6pvf0sz6OWYgMj7CXLEQXld
 HgSvHCsAhaHjfiusKuojpV5xFJaDa70okTAZOFSlq9/xRyDXnXUiD6h90p34aJpPPNs+
 uQsXLBYuD1W62bRTFK9h3wxVZ/HFvC4VmBqCtqJhMr7oiJ6jNsobyLg8FmpnWhyI49Fa
 t4EEiFEIErCBZxVrEuud0e1c2kJFNedu7t5katiKKMkiZTlrHIwchb9CYaToZSR3HDWG
 E9j/sAh+uTbS+QtxPXEYEXPSTqcWaAHiVlBnPk0M3OcGumftNk1vl729OQJUxlsSOY+m
 fuPg==
X-Gm-Message-State: AFq9FYJX4vcDxAlOszcPvODaoeXAmDxoo1WOZN/GQx8rxJK48jnjtfLn
 AgDlTStvium3gRB21K0dS9l5QDXajXciJCr3pJfj+LfrpE9+yImgXkRMx0ZD2yL5sdA0lP5tJrv
 z7hpoTn1EWcdq1o5VyMcZUaosnO2JA1JJlIQRDKZnj/QF
X-Gm-Gg: AYBFou1+E5it6QNplMfoW2inhqvDxsOhkHCZZyiwgr2gCZ7EUYHUCTfq5xoySgF4+cn
 g0kEn9+qM71DiCZlPUbTtJLzfBbQKAr9/ytC4BZ/j47vTU+wgHbuRo/xSrRSCvp8tboty5QNsKa
 BTQn9Tx5Gix+MNdyWwJasxLk0yLswkoIqvsDd/YplV5ksiPRj701f32hlTVL4N7flbKzI4bPhlb
 D/Z86xfdZwyBG38ZZqoenPQkUFAzfixGRv1z4CITgDaiKHJrNSb0zqUCnkTr1XSAvhBjv1JWd5b
 S6SNpM1nUsAekVHxcrbBzMmoP+11RMmxSps97ft2pjyjFV5voeNo8mobsAMMK2MDLKfGyj4XVCl
 q3yhDDTWFkemh
X-Received: by 2002:a05:7300:6a93:b0:35a:22a4:12b with SMTP id
 5a478bee46e88-35a22a421f0mr15908109eec.38.1792036147256; 
 Wed, 14 Oct 2026 20:49:07 -0700 (PDT)
Message-ID: <CAJDBx0iMbvdjAEiPkeYLWs8hd=iZvFkbOPKY2BmzOsAYWk72Uw@mail.gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: 
From: Steven Cortez <coseamc@gmail.com>
Subject: Re: Re: [PATCH v4 1/9] binman: add nxp_imxcst base etype for i.MX CST
 signing
MIME-Version: 1.0
Date: Wed, 14 Oct 2026 11:26:17 -0700
X-Gm-Features: AclHuK_8Ts4h3KDcVnDdeA3Tr9uphIPeXecBubZH-Or_JlX3DqD1sh-z4Amqkuc
Content-Type: multipart/alternative; boundary="pidq9r4b7sw1hw5n5eeh1ajc6c8h"
X-Gm-Locker: AG1QAN20MAfASJe8FY0tXDG1X6TIqSxyiWk3OnGv5oMqbtg0JoRV9xTFhB3FNxQ-T2wzG6GHIF87PSh7eQ0-PmcJ7j0-nyXUs9Z7lTADeBjwMcy1BW8VhdkA9RZ8OPVtXyyGcPnFihEROoksnKvZw0sQjKDvuA==
X-Mailman-Approved-At: Thu, 15 Oct 2026 04:53:01 +0000
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

--pidq9r4b7sw1hw5n5eeh1ajc6c8h
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

ClN0ZXZlbiBDb3J0ZXogaGFzIHNlbnQgeW91IGFuIGVtYWlsIHZpYSBHbWFpbCBjb25maWRlbnRp
YWwgbW9kZToKCltpbWFnZTogR21haWwgbG9nb11SZTogUmU6IFtQQVRDSCB2NCAxLzldIGJpbm1h
bjogYWRkIG54cF9pbXhjc3QgYmFzZSBldHlwZSBmb3IgaS5NWCBDU1Qgc2lnbmluZyA8aHR0cHM6
Ly9jb25maWRlbnRpYWwtbWFpbC5nb29nbGUuY29tL21zZy9BRzFRQU4yME1BZkFTSmU4RlkwdFhE
RzFYNlRJcVN4eWlXazNPbkd2NW9NcWJ0ZzBKb1JWOXhURmhCM0ZOeFEtVDJ3ekc2R0hJRjg3UFNo
N2VRMC1QbWNKN2owLW55WFVzOVo3bFRBRGVCandNY3kxQlc4Vmhka0E5Ulo4T1BWdFh5eUdjUG5G
aWhFUk9va3NuS3ZadzBzUWpLRHZ1QT09PgoKVGhpcyBtZXNzYWdlIHdhcyBzZW50IG9uIE9jdCAx
NCwgMjAyNiBhdCA4OjQ5OjA34oCvUE0gR01ULTcKWW91IGNhbiBvcGVuIGl0IGJ5IGNsaWNraW5n
IHRoZSBsaW5rIGJlbG93LiBUaGlzIGxpbmsgd2lsbCBvbmx5IHdvcmsgZm9yIHUtYm9vdEBsaXN0
cy51LWJvb3QtcHJvamVjdC5vcmcuCgpWaWV3IHRoZSBlbWFpbCA8aHR0cHM6Ly9jb25maWRlbnRp
YWwtbWFpbC5nb29nbGUuY29tL21zZy9BRzFRQU4yME1BZkFTSmU4RlkwdFhERzFYNlRJcVN4eWlX
azNPbkd2NW9NcWJ0ZzBKb1JWOXhURmhCM0ZOeFEtVDJ3ekc2R0hJRjg3UFNoN2VRMC1QbWNKN2ow
LW55WFVzOVo3bFRBRGVCandNY3kxQlc4Vmhka0E5Ulo4T1BWdFh5eUdjUG5GaWhFUk9va3NuS3Za
dzBzUWpLRHZ1QT09PgoKR21haWwgY29uZmlkZW50aWFsIG1vZGUgZ2l2ZXMgeW91IG1vcmUgY29u
dHJvbCBvdmVyIHRoZSBtZXNzYWdlcyB5b3Ugc2VuZC4gVGhlIHNlbmRlciBtYXkgaGF2ZSBjaG9z
ZW4gdG8gc2V0IGFuIGV4cGlyYXRpb24gdGltZSwgZGlzYWJsZSBwcmludGluZyBvciBmb3J3YXJk
aW5nLCBvciB0cmFjayBhY2Nlc3MgdG8gdGhpcyBtZXNzYWdlLiBMZWFybiBtb3JlIDxodHRwczov
L3N1cHBvcnQuZ29vZ2xlLmNvbS9tYWlsL2Fuc3dlci83Njc0MDU5PgpHbWFpbDogRW1haWwgYnkg
R29vZ2xlClVzZSBpcyBzdWJqZWN0IHRvIHRoZSBHb29nbGUgUHJpdmFjeSBQb2xpY3kgPGh0dHBz
Oi8vbXlhY2NvdW50Lmdvb2dsZS5jb20vcHJpdmFjeXBvbGljeT9obD1lbj4KR29vZ2xlIExMQywg
MTYwMCBBbXBoaXRoZWF0cmUgUGFya3dheSwgTW91bnRhaW4gVmlldywgQ0EgOTQwNDMsIFVTQQpZ
b3UgaGF2ZSByZWNlaXZlZCB0aGlzIG1lc3NhZ2UgYmVjYXVzZSBzb21lb25lIHNlbnQgeW91IGFu
IGVtYWlsIHZpYSBHbWFpbCBjb25maWRlbnRpYWwgbW9kZS4KW2ltYWdlOiBHb29nbGUgbG9nb10K
--pidq9r4b7sw1hw5n5eeh1ajc6c8h
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div style=3D"width: 100%; padding: 24px 0 16px 0;=
 background-color: #f5f5f5; text-align: center;"><div style=3D"display: inl=
ine-block; width: 90%; max-width: 680px; min-width: 280px; text-align: left=
; font-family: Roboto,Arial,Helvetica,sans-serif; font-size: 13px;" dir=3D"=
ltr"><div style=3D"display: block; padding: 0 2px;"><div style=3D"display: =
block; background: #fff; height: 2px;"></div></div><div style=3D"border-lef=
t: 1px solid f0f0f0; border-right: 1px solid #f0f0f0; border-bottom: 1px so=
lid #f0f0f0;"><div style=3D"padding: 24px 32px 24px 32px; background: #fff;=
 border-right: 1px solid #eaeaea; border-left: 1px solid #eaeaea; border-bo=
ttom: 1px solid #eaeaea;"><div>Steven Cortez has sent you an email via <spa=
n style=3D"font-weight: bold;">Gmail confidential mode:</span></div><br/><d=
iv style=3D"display: table-row;"><img src=3D"https://www.gstatic.com/images=
/branding/product/2x/gmail_16dp.png" border=3D"0" width=3D"32" style=3D"dis=
play: table-cell; vertical-align: middle;" alt=3D"Gmail logo"/><a href=3D"h=
ttps://confidential-mail.google.com/msg/AG1QAN20MAfASJe8FY0tXDG1X6TIqSxyiWk=
3OnGv5oMqbtg0JoRV9xTFhB3FNxQ-T2wzG6GHIF87PSh7eQ0-PmcJ7j0-nyXUs9Z7lTADeBjwMc=
y1BW8VhdkA9RZ8OPVtXyyGcPnFihEROoksnKvZw0sQjKDvuA=3D=3D" target=3D"_blank" s=
tyle=3D"display: table-cell; vertical-align: middle; padding-left: 12px; co=
lor: #3367d6; font-size: 18px; text-decoration: none;">Re: Re: [PATCH v4 1/=
9] binman: add nxp_imxcst base etype for i.MX CST signing</a></div><br/><di=
v>This message was sent on Oct 14, 2026 at 8:49:07=E2=80=AFPM GMT-7</div><d=
iv>You can open it by clicking the link below. This link will only work for=
 u-boot@lists.u-boot-project.org.</div><br/><a href=3D"https://confidential=
-mail.google.com/msg/AG1QAN20MAfASJe8FY0tXDG1X6TIqSxyiWk3OnGv5oMqbtg0JoRV9x=
TFhB3FNxQ-T2wzG6GHIF87PSh7eQ0-PmcJ7j0-nyXUs9Z7lTADeBjwMcy1BW8VhdkA9RZ8OPVtX=
yyGcPnFihEROoksnKvZw0sQjKDvuA=3D=3D" target=3D"_blank" style=3D"background-=
color: #4d90fe; border: 1px solid #3079ed; border-radius: 2px; color: white=
; display:inline-block; font-size: 11px; font-weight: bold; height: 29px; l=
ine-height: 29px; min-width: 54px; outline: 0; padding: 0 8px; text-align:c=
enter; text-decoration: none;">View the email</a><br/><br/><div>Gmail confi=
dential mode gives you more control over the messages you send. The sender =
may have chosen to set an expiration time, disable printing or forwarding, =
or track access to this message. <a href=3D"https://support.google.com/mail=
/answer/7674059" target=3D"_blank">Learn more</a></div></div></div><table s=
tyle=3D"padding: 14px 10px 0 10px;" role=3D"presentation"><tr><td style=3D"=
width: 100%; font-size: 11px; font-family: Roboto,Arial,Helvetica,sans-serf=
; color:#646464; line-height: 18px; min-height: 40px; vertical-align: middl=
e;"><div>Gmail: Email by Google</div><div>Use is subject to the <a href=3D"=
https://myaccount.google.com/privacypolicy?hl=3Den" target=3D"_blank">Googl=
e Privacy Policy</a></div><div>Google LLC, 1600 Amphitheatre Parkway, Mount=
ain View, CA 94043, USA</div><div>You have received this message because so=
meone sent you an email via Gmail confidential mode.</div></td><td><img src=
=3D"https://www.gstatic.com/images/branding/googlelogo/2x/googlelogo_tm_bla=
ck54_color_96x40dp.png" width=3D"96" border=3D"0" alt=3D"Google logo"/></td=
></tr></table></div></div></body></html>
--pidq9r4b7sw1hw5n5eeh1ajc6c8h--
