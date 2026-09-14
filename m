Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE6DBC88E73
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 21:22:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6511480865;
	Mon, 14 Sep 2026 21:22:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ba96JlO2Ext8; Mon, 14 Sep 2026 21:22:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B462780879
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789420977;
	b=m9cik+4VcWdYLd6pz8rlh3vV22jiZGyNEUmIuzuGBUbVlOAvF9mGlnlqTvhCHdM6Vjgv
	 GzwUJJH3uTWyeZnO4lShHTNq7WDv0cyyXd9CpojiGHrNChmplkB1S19VIBUfJapNaAeZt
	 oSU2OKy3SmEjtBG6R9Ap0+yTba9vDywBHpVqzpm0z77+s3djBZai6SADLwm4vYdJ3YWaz
	 wINqIHJbRrvGtSjKXWHR0Au3kkC1Hzap8QDUwiq0nQjSk90H6gZS+m21lSVq5jsfLji0C
	 qnwHQOzLm82Wgh9shwn3vXaRJRCbt7ypRZNxUcQMIfTFjYKd9iTmFguPEVEsNvSNRsQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789420977;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=e9pELbAoBfYhHi6pqZU/1ZETpPmyu7+pygkittSlutA=;
	b=Q7fyGa/8Ti0dj98S8lQXM54AgDN+UZHmXxYmELVTDLixyngd+9bxYwTUzHnF+0hNf68X
	 xwh1gjq2jzBaNrNNoCsVblVZcsPflSCuudOuRkBEQuwR7yuwlMWR+IX8PTuYjGQZNuPHB
	 uTVYHZZmBxRWKKhCYpQ/ErQXLjyYvjZkFzcdLNLzKVs3Vj7MSriuzGL0boXH1y/2GPYhT
	 ut8Bw4oCOCsYoBHkq4ZKPCxua/HWb+rxQ0gKjyYtGNARF+KXCwHKslJ9FWGYMm9v6m/At
	 M2eK3w6TFLCr/O4iwuWS0ZREfauM6V6fRFAK6y3XCH1rLrCE+JPSt54/+xPsAn2wZAQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789420977;
	bh=e9pELbAoBfYhHi6pqZU/1ZETpPmyu7+pygkittSlutA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=y6ZcdCbfRgtUBxvNShztuXsExGwF9a9h7V36xZ6xOzJSRjq8nXxwhxy3eTbMs7y1x
	 LMGR+xIN0YwhHDkAzGF7n3Q4KioSaLxTi2c8jasaO4DCMr31TD0P856n4psUuLPppd
	 VY3jqGal7q1PypjD4xk7pi13XYnjy4A6PbEVijoWbJ864MkK3elZcJJt4Bf2h9gt7v
	 rblI51hMAlf47xRuMBaOGiWK2j7/DUSj8tUNYTw4TnUOjlYIJzl9uDOSdB5j0eCZty
	 atAr/EPDfP4wBazQs8TRLHLHo8IhduB3lemnZKyhzzLJmTQpgYACelXHvU+KLAG9Xx
	 8N5P4kVhaUzBg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B462780879;
	Mon, 14 Sep 2026 21:22:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 625B1493
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 21:22:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 541106060D
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 21:22:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PFye8HVgZdEW for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 21:22:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 45AEB605EE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::135"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789420975;
 b=LQSri12+KQwCTqvt6EJ2YYiHBEryr+9LOE/LyhLEWt/EcJQtRrhG8UFl2izzcTMmJMYS
 laVNowvMrFUrJYuNwdnX7m4kJUlIov4vnkrkOB3U6A2bfxbfelAu58tLsk4NgUIndKLlR
 gcuvBO1Gy5c0fChfV0+GLqWtvJInKxxB7+voM9789TSz8EetVFzgwEEhBJb4MvF449Kgq
 z3QMrTeW/vd598qqAMHP3FuKR+cJ+PPLKq7fz5FvXroZjdU433JbvOPhLanfa1hhMwCx9
 L3gsymlY7ckZOi60UIfLDHrobZNAhJbPJIhT7+o+udEzWK0+xyRo1qs7qCoe+OnsB+Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789420975;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=e9pELbAoBfYhHi6pqZU/1ZETpPmyu7+pygkittSlutA=;
 b=h20VGxF05UWBqKDLGxRUrOPXIfCWg5fgyc//YSXqxxLwp32XU93N/DscLYdiBpzERjYU
 Hfd91YS6+b9kdtBk9v/2goq4qgfDYdmjOT2BeiBigBtKoTb16m6kW2XHdWuk+u7SpBPMe
 uHYyr/77UMfdG4qVm2TYjWVIWO5ucx42IJLk6A56Td3Bya4FWj/N3z2CXqG2PzldwzjSX
 g9lNF3vunYTHnaXvBAVOuiN2t6L0EReQ3uTFPs4l1G37LBOhfZa8UuJrEXcI+lcLfIrIF
 dVWn0wfld/gWw7D6qfbOCdp3WFrowU/mIvTVH1JzcC9f/G0ZZCIxr1bl6KAIYoIwP/w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=jxcJaSFu; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::135"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::135; helo=mail-lf1-x135.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=jxcJaSFu
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 45AEB605EE
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 21:22:54 +0000 (UTC)
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5b4afc8465eso5368741e87.2
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 14:22:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789420972; cv=none;
 d=google.com; s=arc-20260327;
 b=ZrRRo7GQXoJ5gDqEG/0pT4WjM3tXYmI5OmgoOxF6eJNL2kE62DDcK5HH1wXDTOnYne
 GqT6VcpSXZM7o6sGAUYthlYCCju8XShghgoRarh29FUa4/0Dm2cl1YeW+mci0dxTiDwv
 0fMBjNJXtfjoFeGT+f8R5FIWaPq7rlcu5/biJrNTsLRYBG7o1RcX7fMBOCYqB1AoUZNE
 ubLAzQYimQhDclMlP/RoQ7oTc0XD0JCTcM5pTso0WhOKYFbwB49YjHkDPF1K4b/zn3BE
 zrq8so6zaD5qqXF8zsgMVYbOyQTVFgieXALpd17x+sRifGfcPJ1wK357z4qYr8Q6BSuR
 /atw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=e9pELbAoBfYhHi6pqZU/1ZETpPmyu7+pygkittSlutA=;
 fh=6HhR16pO+I56YnaUB+Ms2YspSga0KLBvgM4uFPpFNsA=;
 b=URzEHQOROTcMqSl+GLTFycB8SHu4G7+SroGwhpivzdzqDcjNGlMmOvnN3MbY3JOL0q
 lASIiOheL8ShqTeN3jeLemj5snU97ikknDy+0ij0ettcKH12JkzQC0xTtu2oUYPtHFNh
 ZFeDyE1hkzzSaM6A31/78Q15E0ekD2nodxD4sNEnF9xDkXb3CZh1zK1FFXTlCWcjcvBA
 Wm/yn7bahHgkzsSevlXcb8fn67pHh7gZtRulu+2xNoN8UEsaZRqCHZofk9KHhAtpFOof
 t1M35xX71yOad0zwnggAoC7Cg/g5OinRCD1czCOx9aNMlQ9615HsUMSUSs0H5FPmzf76
 y8nw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789420972; x=1790025772;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=e9pELbAoBfYhHi6pqZU/1ZETpPmyu7+pygkittSlutA=;
 b=jxcJaSFukBlEyLV8nkb5/Fj9UPtBS7VsDqAlBoUhLPAAWCafusP6mnt643wJMF/XzW
 9XIGwNG1npxVYYUK27XSp7+Mvz1U0Ui0ZuhNIZ5H4H4YnAKZ8Rw2cXhyojYusWVAnkWU
 VTQfKU8OCaZzUtweBtdJOFTeCOQBZnFeSqNuvLLpCCAL6L0hO33Ob+D2AgGy6iukK/u9
 Hh3XvcrkqD4mETGB0qON6eulI0lYgI2gpdDfmFMsD+TWdWHDYvKQ454gLh+uTV3kvVyA
 q9T8qO2+yj/DBS763yue+yEvIldmx2X+Uis0vhiyptla+kBoBUpK97cw5u72H2eg7c7J
 ZGjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789420972; x=1790025772;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=e9pELbAoBfYhHi6pqZU/1ZETpPmyu7+pygkittSlutA=;
 b=BhPFXLRBGmTm9GFjk70gh2mai0EfBRns2WoWMiMb9RtIujD00a97UTZrz6scuvboQ1
 qQOxilOe6bu/K+/tQWjy51ENFbyErpYMTSwMdlKTl4/NvVxxjdVeJrsE0NhRVQ3mTuVO
 96Cf4pHQll5Q5bDan80LDhN+n3l88hAyp08R9cZOgYCTr0Vggfaa6VdDfgb38ZObE0nH
 ZcF/xd2vo5A05BYwJZZ5f55dps4sfOyyfrT0CIFYRFdQ6rzasIziAzQ0DqsybFwjmLGx
 Gxio1nUZbfURqcAukJGXKBmt0esHyM7WpC033wb8HUO0ccaOcyTGnqGa279NHm2qe8pd
 zMHw==
X-Gm-Message-State: AFuF++kqLCqswhnTZYVSZ2WX9FBZxXh1MNU7erR9KiXuZNZAQosEDpgX
 9ScvlUa8dMm2qdYOhShm80FXnqFBEynwfwM46i3g6q2Jh7Di3VHCZi0Tj3ibrSP5CweB1IA73vw
 RmmpLGjAbqc5eaZ+fDJwBNp0FkdZH2yHtsA==
X-Gm-Gg: AYBFou273wnQ56QQ5hLeF66dcp1HCsGpApw9/rOBqma6G5z8X0AHocIaIBRn7cpsh+a
 KQlmqmie01wkYevl3Kkl3yxii7ne2DfBTvL6IbBg0A82wresr5lvZioABOpqM5lm6NSFFwE7qDS
 FlX1502ZzNqWAkUeV6s8U/eGmfYOwgMuEt+MjbNV1uRVbmwL1xa3QJ6EZPjFkgv/sx2A80IrF15
 TOfpqx2uDboLLo1UMANuJIjAhXTmFrJLNRzL5zjX8gfrJA5bagiuDwcucvtMpGmHVzrbdXfn6m7
 i8VuvYOMiIXdxjXN26MjFs3P+z9QmZ+fz7aX7/zQQvEwnOxvI3iNWHf2ZxPq9cBz60Dtt+Nkjs3
 kPsFECYfFaKtcHCLe5qXKJft9px06fnp0//yi/yJk46ZJ+gCWvrJjrOU=
X-Received: by 2002:a05:6512:2204:b0:5b7:a987:d048 with SMTP id
 2adb3069b0e04-5b8ae671f89mr1056294e87.24.1789420972014; Mon, 14 Sep 2026
 14:22:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260913202303.2583287-1-siddharth.menon@machinesoul.in>
In-Reply-To: <20260913202303.2583287-1-siddharth.menon@machinesoul.in>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 14 Sep 2026 18:22:40 -0300
X-Gm-Features: AcwNN1WikBvmjerz8wJjh4dBDtm_0HTOvECHj06P6_W73ZG1SEK0ANONAWzr_uI
Message-ID: <CAOMZO5CbKvEC6ywsaAx68DGd0=2wG+BaUPYcDUtN+XFmT7UcHg@mail.gmail.com>
Subject: Re: [PATCH] button: imx: add SNVS ON/OFF power key driver
To: Siddharth Menon <siddharth.menon@machinesoul.in>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
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

Hi Siddharth,

On Sun, Sep 13, 2026 at 8:21=E2=80=AFPM Siddharth Menon
<siddharth.menon@machinesoul.in> wrote:
>
> This is a port of linux/drivers/input/keyboard/snvs_pwrkey.c,
> adding SNVS power key support for imx chips after i.mx6sx
>
> ON/OFF key is used to power on/off whole system.
>
> Signed-off-by: Siddharth Menon <siddharth.menon@machinesoul.in>
> Cc: Tom Rini <trini@konsulko.com>

Could you please enable a user for this driver?

Otherwise, this will be just dead code.

Thanks
