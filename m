Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D47BCCF2DA
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 09:15:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 16D7980F80;
	Mon, 19 Oct 2026 09:15:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HTnz3fPBBTv6; Mon, 19 Oct 2026 09:15:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 58CDF80FF9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792401315;
	b=DhpyCWwfvT0lcz/tjWXWE3owrhtiLZ1HG/WJahTEACWRBX8KmLDShT9fQ7TJjCUKHeHV
	 D04bC86QAT8sdy1Az89+NDYTmn5uPH5St7Al4/Tya5u7qz/s4RWv5ZkufwMT6DdZ4pjjd
	 oCpso4IoQd2Fkeb9xoEJy8tlDkfaja+AdEY1YvNXG/Pw6NC9w75/s7FAMcDLnzCvxt0P1
	 MGbgVhUkIrOjwSO2mvslzLp0TXwdxRXhvNV3KvmfyM9G7NKLcY5fNlalQ2Stqhj0y6F2L
	 f8n4gPmPGYVuti+d+MnGF2EcOxLRsLNq01e4AFE2b6A9FHbAT25W4kfkSuxhuf50uyg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792401315;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=OMIFKvMSLePJGUJLf8vwhzjlPvtp9z7fA+B+vJwDrME=;
	b=R5uPM8Y4PwgI8AzPFSmBlBt5F4gTiz7bm3NebY5Ca6W3Y5v/Ga8iUn03snRnVPK1+fCp
	 uLXwcVAt1FeLdDAe6fSCuQxqLmbmNqAwpB63ferH8jTWPzQHBTjc1iRIi86GFQqwSf+BI
	 4WHufqytckWvyx86nU4LB4oTdM2FBO06tBadyl3c45jZwPTnoKcN6LEKYVSbI/5jFRaf4
	 CHfkdmOgDQB1LtkW3S4LyxjopZBzXFgF9WmOWuHyWgmfAfY2Ngy6UpQik4YwnPZ7yCT3P
	 B0rut/OmgaisW7VyHW1fSeIpPo2S5C6gi+nA5SYe4kL+mdgmsvpyHtF58Yu+lYIuTuQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792401315;
	bh=OMIFKvMSLePJGUJLf8vwhzjlPvtp9z7fA+B+vJwDrME=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WtcPfWEaitiFdc3E0JPt4dU8v8gg/NYyPCoimmdtA13EZoFfMjPqb9n/foF23JjNh
	 nJ/APItrj8kemgJ13vbJS44jcH8Dp9Zx8C9KSHe4E+R0yz4bPXk0ScbSdvkDNckE2c
	 0xx5PzPyuf7KLILL7nlBFV5fIHFC1nT56UmMYRfHo0g8mjyUpUwPie0uuV4lkq6dZY
	 jkqKDwAFqLEVo1jAi77rF2b+vO19Ek6XHd8izt++E+y5l+/aidXQwo77q3tBrcYaFF
	 QSHzYK0iNQy087yhVDKypwn2R0YqH4is7AWUnseeMg1qstFd/sW17LhwZ8VTxiZPUx
	 TtfSYixnC8dEw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 58CDF80FF9;
	Mon, 19 Oct 2026 09:15:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 458BF2A8
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:15:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 430FF406A8
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:15:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uM0ppAiQUpAQ for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 09:15:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 629B040623
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792401313;
 b=rhIJ9Axfg7NejgaqKls/XDTDSh+zOnmctC8hobyD+9pyGFNk48NaZSUtE5Z4dIX5Smy+
 6Uf0gZPuRo0ev7qqaA30msjumZwRemu2yLriNXy1YOBiR8xnLsClsYp107ST606AX/KHA
 JMtfYgmK4N/WJtqGHBm8183nMfWfQffHXhwKvNte8qXuwDq/Fq0Gq7GnFm0XsSYXnzu3H
 o9mHrL6tUSSkghS/qrFqRZW98mG7qunODidoWp2OqfDRP1LKbwUMabxqZTtuxpGQUD8V0
 MzHpB/6oEUKyVjbIq6T4EgKhp4ucEncpJLH1uYrwn9Keh7D9mJC7BY5u3naHqJ27yIQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792401313;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type:Content-Transfer-Encoding;
 bh=OMIFKvMSLePJGUJLf8vwhzjlPvtp9z7fA+B+vJwDrME=;
 b=iaXbHBSZ2l4GMtHe6Yv2jEUbse8VEnV/bjxL4rb9kJNy+lzsyCPs3m9EXT00d4e3xGgJ
 tgq2BGf4a9qVrpQJZgdvGXElsVKAW9pJnNnLNIQVemxAb2UjzFdc5p1Nds9SJknqPyce9
 XGLU66bWoSeksQ4vOM/Lts2Pi0MGkvV38tW063CQet8lhfzoulmzPrH1+4nD5yQPtgMkZ
 hKGCMpNNhAtgmtJVMfvT2EjPsVsDw0NlOY3eZ3zDxH1OmLL3vBMvbOgxGiVI8zDV0JHRj
 5hwGzQ5d1Y02WpY+p+UQo++1y5XPDkIltui+lYBgDC8KtvVon5EEkYMcG5jO4XLbzgw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="U/0SSk91"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=U/0SSk91
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 629B040623
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:15:12 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6b203527bceso2147585a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 02:15:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792401311; cv=none;
 d=google.com; s=arc-20260327;
 b=fJ+z3RUOaKWDWT4/U4NlOIoNYEA1M/iOa8ZJNrwZKr0149urITig4ayn0q7dicYqKs
 saL/IF0AHnII1DEu/mGOSM9SBhcev2xnYzlmhxYWv5psS7fudX+Npr843zvrilIhKLMw
 KmGMMtUtIWwbNE3BRV44j/glQH/a7iDKRANmyz+uGAOYDf3yGjVh4lwloTQdXLOd4GAm
 bbKt2TGhP8E7yERtewknUIGOpxm15zNHx8+XB/cuWbnOpoQ4UCPm2TEt0/ZvWFDul9Yh
 wvcATjpXMuj89HmV6azKGcEofsB+m3m7swJOzKeg4ggEqN+Lv4mGvE0KISMQQ+QZhF1g
 SgUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :references:in-reply-to:mime-version:dkim-signature;
 bh=OMIFKvMSLePJGUJLf8vwhzjlPvtp9z7fA+B+vJwDrME=;
 fh=W9limZYOATxEysRzoYuLOospUaufMivdRUWM0xek0BM=;
 b=DNO8y4JmqQTeecv/dmwCuo64Pe6tcjVA3rHVlMq+thedAix6VQKz9EIHDz+d0vwF49
 EyE33gbHajGICgn4935CfGLERuHsL0DeWKIXVIm6OfyppPdtrtgPoxpdy4b1B6uVpgdt
 Y6mALDn4KIa4d9rnr5i7Ws5Wu0dOvKN3BfqCyj/KIRd433mtJ4hV/EmOq2Wre6v7fff8
 lz/xBY5nCTGef3dVJkne+r73NGNcvLgXNT4MwI8Yd7NLufr7air+7p1NJ8AfV8X1t62S
 2re0UAhV2jghfRf8uudkLCuVI42N7IJdpw7Ng+teAbD4hBK+lyHM/sdI40KdDA8BcXup
 QVgQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792401311; x=1793006111;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:references:in-reply-to:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OMIFKvMSLePJGUJLf8vwhzjlPvtp9z7fA+B+vJwDrME=;
 b=U/0SSk916xYixftB65TWtHldbZsfmLCf/3OLZvKFxubwSazYP+8UZ2+bhnHew+ud++
 CFZBDw3jRNA0jUCJz4IhOAhLb6LlXUbtzdhCo5kThO95brSGhEmuhjexSybobUZTHini
 RbpZ3cnf6tU/lRI8Mf2hqsnXiIuLOGrEm7sxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792401311; x=1793006111;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:references:in-reply-to:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OMIFKvMSLePJGUJLf8vwhzjlPvtp9z7fA+B+vJwDrME=;
 b=OkFH3+k83QANAiWWLtX5F8bu12oLFpnbGJXPLBLJv/aXWSCnAPAtFWqVw40j8IfL66
 2WnwQpjLo9TOpqfsj2ztOjCTprmvsVbf/z9M46MzTDi0BhefmoauUGALgPXbRIsqL1LE
 zdA/zmV5OjDqZ3JYPE73kFUvsRuV7jASUe0esHEkbHJG69oOH3wTQo7X0kIZGY1DwQf+
 E8MYu5bZvG3ckXjKJPpcS9807O24qWOolnXT75V0LIEUrot5wtDIW7zOFQVsAByjz55W
 p5AgTY3aQtX1xSEQFVNFkWKj+WH6d2Ck22aCg4oeCtt2MQRal/+J3X9BsyTljD4jICO6
 Ym8w==
X-Gm-Message-State: AFq9FYI7z5nbyUzOqIsmhO1kUv/fZy1e2ptO2w6JHqm+BhevLL51DLS7
 lJfaq2dDGALdaIl0utJK4kdPNkkr24oc/IPpF1s9MtVZ2b2i4KrycxbF365uK7Kk/LL4nITYFyt
 BX7HbHuui3RYjkATrZV5eBkMimCoD4JoDd4cy/t1n
X-Gm-Gg: AYBFou1mPUmkehKktn0/g+4lMpnV90stWTbkHMTk3HMWBue9ZO3i4RlB7VXHh4CY9UR
 /7YERrExgSUVd5wh0YWU8gobili9lp/yy+vImf9rfISeink3zQ8Uks30qEUllYGoB6hQbwe+8nL
 PSpivsxCBCk/ycJRXdYGm7LQAYjJHJKA3LhPCW9aILDduffw6d7mODRo/aCuzaH9kZKaf0wg2FJ
 HD+BN0TwC8Qz2YMC2rFge9FPVNajJmhnNKlspq5BBzJDIe70Op91cYI8TcSdTybG9vqwyc3ehU1
 9C/PZ+D1UXQo169ej5hSl1tIqzwPMpOXLklHP28SubrEiFaDktmLlA==
X-Received: by 2002:a05:6402:401e:b0:6ac:8730:711 with SMTP id
 4fb4d7f45d1cf-6b3a8190805mr4577896a12.21.1792401310853; Mon, 19 Oct 2026
 02:15:10 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 11:15:09 +0200
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 17 Oct 2026 07:07:11 -0700
MIME-Version: 1.0
In-Reply-To: <20261017-b4-expo-colours-v1-14-479ac06e7642@protonmail.com>
References: <20261017-b4-expo-colours-v1-0-479ac06e7642@protonmail.com>
 <20261017-b4-expo-colours-v1-14-479ac06e7642@protonmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 11:15:08 +0200
X-Gm-Features: AclHuK96xwLn_m7fWmuyx_R5XZVwlkAKHtT5O--0Qvvp8-PsjDJtM_MYCseToTU
Message-ID: <CAFLszTg1cvh67iiWz07ccOw_-05TDGPk4Xc=pZ=cEdavxx4y7w@mail.gmail.com>
Subject: Re: [PATCH 14/14] test: expo: Test a text object with an RGB colour
To: petr.hodina@protonmail.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Alexander Martinz <amartinz@shiftphones.com>,
 =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 Petr Pavlata <petr@acrux.cz>, David Heidelberg <david@ixit.cz>
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

Hi Petr,

On 2026-10-17T09:10:23, Petr Hodina via B4 Relay
<devnull+petr.hodina.protonmail.com@kernel.org> wrote:
> test: expo: Test a text object with an RGB colour
>
> Add expo_txt_rgb() to check that scene_txt_set_rgb() records the colour o=
n
> a text object.
>
> Check it returns -ENOENT for an unknown ID and that rendering
> leaves the video device's own foreground colour as it was.
>
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
>
> test/boot/expo.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)

> +	/* only text objects have a colour */
> +	ut_asserteq(-ENOENT, scene_txt_set_rgb(scn, 9999, 0));

This checks an unknown ID, not a non-text object, so the comment is
misleading. The equivalent check for scene_txt_set_colour() uses
OBJ_MENU for this case =E2=80=94 please do the same here so the test actual=
ly
exercises the "not a text object" path.

Regards,
Simon
