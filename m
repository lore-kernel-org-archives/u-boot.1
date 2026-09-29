Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52095CA5FA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 12:53:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 28CB780F04;
	Tue, 29 Sep 2026 12:53:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TXZxMqSJE9Rm; Tue, 29 Sep 2026 12:53:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C49D680ECF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790686386;
	b=nfelJTqqnqzGTJMS1txGz+aa9aw4REy4RvJsW9YpYCcBw/++Tu00IzOApuHO+uC/WlW9
	 xIb9Iv+oVfQgfueh282kKuQamsgq05N4BJE/4DoekIhEHtXAWsW7piaZHlDlMVFMAXOKf
	 2cd78LBIUtfker1XhxWOfm1sPGyTjXZF2teZKBRYkG2sfolhPK/y7Va4FFkd+W+EJlJhi
	 clilYiF+6KbtTsRlTdVL4Ja/vot5jSFKClNluLv37F23y/jk34YOcImm5E4bXkyFJKhI4
	 6xkOlrf4KYpYYAm7ibME1lHKeHmX5FnfvSiOVaJoSYe7s0k57Du1Kl6xnsK0UQG7PdA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790686386;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=rsi5q5qRm7budvkB+ieqVuP7uU0ls7JY08xUBiL5I7k=;
	b=ewwLf/vKc2jJOX8s1JIEBLA2Typ2AC8vhJ9URGXjIUe108ACRlkHEO553pV+UNJhVTag
	 T5SHY982kPWB/QuClaAU37lhYRIPIwXFmPjwlGbu5NxNoAFmeJvqubdp5zsGy+Jc9rpAE
	 +6M+DWKFHD+wILhJIrk7TVDbPhsq7MV3n4F6olIhTv/7MlMs5V5hxvHlaUrTXBxCW/M+b
	 9vieeI9m/ISokaEtCPKok+9NnhZ3tB4ZeuNIjU3vBrt+79HgfbLR2YeNc4g2nE3WZQyxl
	 qYdvZ40Al55sb36QyBSf7h0/ndbmKOOHIb0tCTBqsytGv+0M+SaT/bmM1IIEwCTtiOQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790686386;
	bh=rsi5q5qRm7budvkB+ieqVuP7uU0ls7JY08xUBiL5I7k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Rmu5lZ5gIUaN5is2U1Y8uyuAfVvUsNVeqoSAxJuIO0+JJeJgSWnvAOnysWdSA5pVP
	 86HxmUH8+EBqD7f6ATjF27w9K2khke7+wlqXuSqA2D8SlSs9nZhVcYtpfLyHH+Dpco
	 2sbIleorMNXBbblj14Qf1+dGxOq5PE1aFzNfK++O+oNQkuNW0BGl2EMV6sLDekV1Yf
	 Xx6SdABkTcL7hgmdTFBY54KpSLHMuSXWVxeUYLp1qlyFWwevqTGLqQaliT79cD4EW/
	 Oje/f6T74S02ojm8WFgDphBUrGFlpFQnErp6qZn5hW9Q9+eHAXzS+D5fl0RC5RlHc+
	 fN2fIQo5IT9QQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C49D680ECF;
	Tue, 29 Sep 2026 12:53:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BFC5B417
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 11:03:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B1744402B4
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 11:03:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wEuw2GdehfqF for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 11:03:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 44D754027A
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:34::e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790679820;
 b=RttuE/rKN6EtukR2uknDHT1SzgGeXqqOCwBk3rPKVGsE6N2g0z+30wtkGrJkqOxbSO/m
 2BV5oeSYjFethNN7zC6asQ8VVf+JoRxyXZXcFCozSU9lkE9TAejDso3WV2K/LPZAjqOpv
 5OMMeP8E7bcNgiKOblsFbo4dal5G4Pz450AW1+gfNOdTkxE/01ISnMvDlYMdQ3O8symyC
 1O803Nf9hMp8zFawp380Htx7s/HWHILDRdUQU+qRmYSSTKMY+OxP2McAS8ogVEkx/AShq
 01AtotJA/XepcntfstZRq+d13j7l5FZmiErH5frgQ6M8j8k46knCAu0snwTui7NjTjQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790679820;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=rsi5q5qRm7budvkB+ieqVuP7uU0ls7JY08xUBiL5I7k=;
 b=joluyMZ7OqYHYEsd4o5UxZT6D7dx+5XOKKCVCidvpIKkSYK+YLvFmi33xan8ESp4w2jR
 KQ5akrdwgkKLVafrdwkAYC46biM0+3VPSnz5cLUcJdxUd5+ah9qZyI3221WPdgQuB4rP4
 8wurhapnqesxfk9zhTQvojhjG1qxRMllpj9XqnJ7/qVIeGILUpkAbTu+dE2TSrtLRCVD+
 NCsvNhW6H6vz5lPEu/B5hJP9dLGrgSA10y52FY8qjbnRuA3beIGTSCR4YR5y0IDK8OsKN
 CSp/bakVCbO9r5xuTkkHLiTc8YyaXVn9vBHc0n2VfgJH0DPh54HFuA9ZOl/Yud1Pwxg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=Q00OAjuu; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:34::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:34::e;
 helo=mail-ej2-x0e.google.com; envelope-from=alchark@flipper.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=Q00OAjuu
Received: from mail-ej2-x0e.google.com (mail-ej2-x0e.google.com
 [IPv6:2a00:1450:4864:34::e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 44D754027A
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 11:03:39 +0000 (UTC)
Received: by mail-ej2-x0e.google.com with SMTP id
 a640c23a62f3a-c2aff2c45efso362630866b.3
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 04:03:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790679818; cv=none;
 d=google.com; s=arc-20260327;
 b=f/bKIqPAF9ZqmbOR3caGfvUqqnGow98Vxld7alYS6g50OTh40eDy+6L8gEaFS46SKv
 Yb6efZ8n5q2DgYGS7f6p5a3ahsySct6Ol1O1oxr/DZTlW4M6n38fzs9KzGhhWRevburA
 iiREcA65FGwstg7VLhspO/9UI+1yl9TmmLAoa0oVHQVvdZvdnD7vArF1YX+RWmet6ZWy
 8MKfncVPMj8k6Ow2WYV3l6s7YBVvcVeeFVMRUyGPAnFKdG53mjSI8E/xkFugBUEqSdQ+
 JJepqC09tedJN2wv95EOVh3oJ7UDaTCK3h24IhT5Ux3PmxnD6ycyTdzdpndNKdrULoa0
 ZnmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rsi5q5qRm7budvkB+ieqVuP7uU0ls7JY08xUBiL5I7k=;
 fh=X0PN9lBUC28xruMLlb/E9GWPFyBweSpvg8ZgHdQS2Mc=;
 b=WyZx8PIkFE9dudVghoWN6q+M9rPEi7sNu+pbWUS6XMbKrfeml18m5iyceD5Ygs/Qed
 RHP0tlMbQ1XjVh8A7krMpc5hkrIv5HeQbTa+snXROsD9e0eh0AcbQRIkXPAQHN5yg5/m
 fixWh37PokhWNY7Rf9hPbVTs9GWH2pa2AtL57jLjc5LMAmhKcjUqyBMnR3euFObhPl0V
 RtHJNTxUSMmfSaQtkhdaYd5Lz9GKDf14GwO5Xeo9ysiBvyXkH3wLdG5dWjjIJ5sa2LBV
 bMddivjgKH3g+5HGaYwGMAXWK6lyx41OyrAN8MNsQfc09xuL4iSkVsm8cOOlj737kG3c
 gqTQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1790679818; x=1791284618;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rsi5q5qRm7budvkB+ieqVuP7uU0ls7JY08xUBiL5I7k=;
 b=Q00OAjuuDrOriwHXBEnEZ9tqGt4nK6Mcnj9qRZf+JXrOvJFxNoe/9vDv9stcNF6B/0
 6VrZ78tGehCvxT7dh79uTZYxUGBJXRCD3BJqhnKzTIsL6eaLeU7ndSzETdF+cXtOiZYC
 SODMSJTzc250wfsnj8zgaKUOefspuJ88LW9NAz/eot7zLXssZJpIySJsPwZIew/yW1bw
 jyMMkiHpYMwf/RN8mXY5L+AHM8UcjEAsTK9J9euXMpaY0sxAGWQgwTPJ4HJzUAavX+11
 dTbgl0myIdyNLnBHUZJtjknjb0FNAKvESBP2BJ4fP+uHOssL3PPnjGx2hpujyQXH0RHR
 wBlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790679818; x=1791284618;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rsi5q5qRm7budvkB+ieqVuP7uU0ls7JY08xUBiL5I7k=;
 b=fX/vtAdRGwxcF4WTtp/dCk9pE5djGs7atp/c8rAOsQmtFV46Cu8Y5MJb0Bbn0dDH1X
 g1Z0sNuKS05bncH+DT14VPvD25F/l/oKUGnzQGUZqgYJqHSRdQOih1dtzMd8qNepU2E3
 ml34qUmZ9fBoFYUPTemtjNY9rdsHrNdQQZNvtXJd6gBZ1lhJNv/Vvg05yRA3So9DYiKV
 qVeyUbKNN463WuClwYfQdik0KoOr6Uqrug7+lIq0P8jcbGFkuvc8cR7QNLdMdqYqcSAB
 QQTnMplhzhFcrTRTVMtXQEUcHL7X1dG0jz943JqJTKMQJY+Iw36zik+i/Ia1bnk5MdGe
 TWnw==
X-Gm-Message-State: AFuF++mXkznEpKtKtzv0ElNiv1+yIipG7d0+vH5vSo9RfWtrHRo2yrn5
 srFENrrprLi3ttJCiNj0FhQXkFxjw6DRQ5eB99FbIH3zLeWtZ2CSSn507U4EK4UH4X+ODyox1g7
 znOgpnlqB4AncnjKOlfAGUz/7w21o+u3tXfe/T83rWA==
X-Gm-Gg: AYBFou3zK44QCB9C7iOVR1TWjre8WSOkdyzy/ev/t1SI3Iy+dl7UG5tpl2ehLYUkDOq
 qsbXf7DSAvkZeaYN8pIWr1LLCMRZwwTwF1zg9DibiHzRVYA6AUGbkzwBHDC6MBakYq1ql1lupAl
 BFifIbY3Li0R4jFYw3tl/OlXboVKHANkswMeSUkp7okg/nkrEP4NivmhYkUmazfmuaZKz3uh+TL
 lYI75Y9ooAvoSwOLmU7qEzQgqU2+QsD4OcfM9aTK/hPPGMvDIJ9mfovZtbTaBBEhLNmGpMLfDiJ
 CogF9muZqpDxCal9hxL3ECSmgUNKwjCB535CqRjd3uC4EV2SfifBJ2vtbnqmJovoWe0dAH/JGue
 6pwtm9Z91QPYo
X-Received: by 2002:a17:907:97c3:b0:c20:21be:ea75 with SMTP id
 a640c23a62f3a-c2ac2314317mr1284887366b.8.1790679817564; Tue, 29 Sep 2026
 04:03:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
 <20260731-atf-falcon-v2-6-acb97c172993@flipper.net>
 <00e2291d-7fc5-4ea1-abb2-9b9100a2b680@cherry.de>
 <CAKTNdwFMCK2frVyrmYWe67k6WgjA7pmJn-SbU+_9NtceHqHERw@mail.gmail.com>
 <6ea99943-eb9d-43a8-a238-edbc1b9c767d@cherry.de>
 <CAKTNdwELO46dZ1Cy+-wpBbQNsP9XJyTgCjBYLQpE39YJ3XP0wg@mail.gmail.com>
 <e7235ec1-dff2-44fa-8c02-9b6a1012bba6@cherry.de>
In-Reply-To: <e7235ec1-dff2-44fa-8c02-9b6a1012bba6@cherry.de>
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 29 Sep 2026 15:03:28 +0400
X-Gm-Features: AclHuK9Otar5scl3rCs1r979V-vl__kSpQHhUCPxHIpAxfKyOKIKxEa80wW0oss
Message-ID: <CAKTNdwEgVRZVFr+V8jCwQmJES7PO3WgdBa5es4EkkOy50xdkiw@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] binman: Add support for pre-patching FDTs in a
 FIT with a /chosen node
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Andre Przywara <andre.przywara@arm.com>, 
 Andrew Davis <afd@ti.com>, Hrushikesh Salunke <h-salunke@ti.com>,
 Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Ronald Wahl <ronald.wahl@legrand.com>,
 Richard Genoud <richard.genoud@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Johan Jonker <jbx6244@gmail.com>, Daniel Golle <daniel@makrotopia.org>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tony Dinh <mibodhi@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 29 Sep 2026 12:52:04 +0000
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

On Tue, Sep 29, 2026 at 2:29=E2=80=AFPM Quentin Schulz <quentin.schulz@cher=
ry.de> wrote:
>
> Hi Alexey,
>
> On 9/28/26 6:44 PM, Alexey Charkov wrote:
> > On Mon, Sep 28, 2026 at 7:53=E2=80=AFPM Quentin Schulz <quentin.schulz@=
cherry.de> wrote:
> >>
> >>
> >>
> >> On 9/28/26 4:03 PM, Alexey Charkov wrote:
> >>> Hi Quentin,
> >>>
> >>> On Mon, Sep 28, 2026 at 5:26=E2=80=AFPM Quentin Schulz <quentin.schul=
z@cherry.de> wrote:
> >>>>
> >>>> Hi Alexey,
> >>>>
> >>>> On 7/31/26 7:10 PM, Alexey Charkov wrote:
> >>>>> When a generated FIT is used to boot Linux directly, bypassing U-Bo=
ot
> >>>>> proper (Falcon mode), there is no runtime code to discover the kern=
el
> >>>>> command line and (optional) initrd location and include them in a F=
DT.
> >>>>>
> >>>>> To facilitate easier preparation of a ready-to-boot FIT, add suppor=
t for
> >>>>> pre-patching the FDTs in a FIT with a preconfigured /chosen node in=
cluding
> >>>>> the bootargs and initrd location.
> >>>>>
> >>>>
> >>>> This sounds wrong to me. Why should we hardcode those at build time?=
 We
> >>>> already do DT fixups in U-Boot proper *at runtime*, so we should
> >>>> probably do the same in xPL when booting in Falcon mode instead of
> >>>> hardcoding stuff. Since you're aware of this, I'm guessing you decid=
ed
> >>>> against, but you don't tell us why. I'm a bit worried going with the
> >>>> suggested implementation means we'll eventually have a binman node
> >>>> property for each DT node/property we want to write/override.
> >>>
> >>> The "regular" Falcon way of doing things (i.e. the one not involving
> >>> TF-A) has so far been: "capture what U-Boot patches into the args to
> >>> be passed to the kernel, package it into a fixed binary, and boot onl=
y
> >>> that". No runtime fixups. So I more or less followed that pattern, bu=
t
> >>> tried to make it a bit more accessible by eliminating the "capture
> >>> something at runtime and save it somehow somewhere" step, which I fin=
d
> >>> unnecessarily painful.
> >>>
> >>> Maybe runtime fixups could be brought into xPL, but they are
> >>> excruciatingly slow, whereas speed is the main reason for wanting
> >>> Falcon mode boot in the first place. Right now with Falcon mode on
> >>> RK3576 I'm getting 2.5 seconds from applying power to _userspace_
> >>> (i.e. full graphical UI drawn on the screen), whereas the best I coul=
d
> >>> get with U-Boot is just over 3s to its boot menu, much of that time
> >>> spent going over the flat devicetree before relocation in O(n^2)
> >>> passes. And those 3s are after stripping the massive pinctrl node wit=
h
> >>> hundreds of its always-present children from the pre-relocation DT,
> >>> which alone saves ~0.4s.
> >>>
> >>
> >> Are they always present, even with /omit-if-no-ref/ instruction? Or
> >> maybe you're building the device trees with -@? Trying to figure out i=
f
> >> somehow we have a bug in dtc (or in our scripts making use of it).
> >
> > The problem is that there are a lot of `status =3D "disabled";` device
> > nodes referencing pinctrl nodes, which keep dtc from dropping them
> > altogether, so a lot of unused pin configs end up in the binary -
> > enough to be noticeable in boot time.
> >
>
> And we cannot really get rid of the status =3D "disabled" nodes as they
> may be switched to "enabled" for some reason at runtime by e.g. U-Boot I
> guess? I'm wondering if this (stripping all nodes which are disabled) is
> something we could still allow (e.g. gated by a Kconfig symbol).

Yes, stripping those entirely would break DT overlays and runtime
board fixups (e.g. what I do for the Flipper One to switch between
SATA/PCIe pin modes based on the M.2 key B config pins strapping).

From what I understood while investigating those boot delays, it's the
linear FDT representation in (uncached) pre-relocation memory what
kills performance when the count of nodes grows to real-world numbers.
Having a more efficient data structure to hold the tree
pre-relocation, or enabling D-cache pre-relocation, would both speed
it up considerably - perhaps more so than trimming the tree itself.
But going down that road sounds a bit scary.

> >> Don't we have FDT and DM in SPL anyway as that's how we probe drivers =
in
> >> that stage (not counting the few SPL-only boards we have)?
> >
> > SPL's DTB is tiny due to bootph-* markup (it was just 27 nodes last
> > time I counted for my RK3576 use case). Making SPL parse the whole
> > OS-oriented device tree, along with all the relocations required to
> > insert stuff at runtime, will hurt.
> >
>
> Ah yes, missed that.
>
> >> I don't have anything better to suggest, I'm just really worried about
> >> the potential ballooning of properties we need to mirror in binman.
> >>
> >>>>> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> >>>>> ---
> >>>>>     tools/binman/entry.py     |   8 ++++
> >>>>>     tools/binman/etype/fit.py | 103 +++++++++++++++++++++++++++++++=
+++++++++++++++
> >>>>>     2 files changed, 111 insertions(+)
> >>>>>
> >>>>> diff --git a/tools/binman/entry.py b/tools/binman/entry.py
> >>>>> index ce7ef28e94b1..e0dea8bf3a49 100644
> >>>>> --- a/tools/binman/entry.py
> >>>>> +++ b/tools/binman/entry.py
> >>>>> @@ -636,6 +636,14 @@ class Entry(object):
> >>>>>             self.Detail('GetData: size %s' % to_hex_size(self.data)=
)
> >>>>>             return self.data
> >>>>>
> >>>>> +    def GetNode(self):
> >>>>> +        """Get the devicetree node which describes this entry
> >>>>> +
> >>>>> +        Returns:
> >>>>> +            Node: Node for this entry
> >>>>> +        """
> >>>>> +        return self._node
> >>>>> +
> >>>>>         def GetPaddedData(self, data=3DNone):
> >>>>>             """Get the data for an entry including any padding
> >>>>>
> >>>>> diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
> >>>>> index 32caa03a7e16..750ff5b47ed5 100644
> >>>>> --- a/tools/binman/etype/fit.py
> >>>>> +++ b/tools/binman/etype/fit.py
> >>>>> @@ -304,6 +304,40 @@ class Entry_fit(Entry_section):
> >>>>>
> >>>>>         See :ref:`fdtgrep_filter` for more information.
> >>>>>
> >>>>> +    Patching /chosen into the generated device trees
> >>>>> +    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>>>> +
> >>>>> +    When the OS is booted directly from this FIT (e.g. Falcon mode=
) U-Boot
> >>>>> +    proper never runs, so its usual runtime /chosen fixups do not =
happen. Two
> >>>>> +    optional properties on the `@fdt-SEQ` node make binman patch e=
ach generated
> >>>>> +    device tree at build time:
> >>>>> +
> >>>>> +    fit,bootargs
> >>>>> +        A string written to /chosen/bootargs of every generated de=
vice tree
> >>>>> +        (any existing value is overwritten). Typically set to `CON=
FIG_BOOTARGS`
> >>>>> +        via the preprocessed devicetree source.
> >>>>> +
> >>>>> +    fit,initrd
> >>>>> +        The image name of a loadable (e.g. "ramdisk") to use as th=
e initramfs.
> >>>>> +        Its `load` address and packed size are written to
> >>>>> +        /chosen/linux,initrd-start and /chosen/linux,initrd-end (a=
t the width of
> >>>>> +        the device tree's root #address-cells) and reserved in the=
 FDT
> >>>>> +        memory-reservation map, mirroring fdt_initrd(). If the ref=
erenced image
> >>>>> +        is absent or empty (e.g. an optional initramfs that was no=
t supplied)
> >>>>> +        the initrd properties are omitted.
> >>>>> +
> >>>>
> >>>> This sounds wrong, why would the FDT image node need to know about w=
hich
> >>>> ramdisk may be used? Shouldn't we rather have a ramdisk property in =
a
> >>>> configuration node, and then patch the FDT based on that information=
?
> >>>
> >>> Falcon mode boot where these are useful is for a fixed-configuration
> >>> boot flow anyway, where one wouldn't have a way to select among
> >>
> >> How do you plan on doing A/B with Falcon boot? How do you know from
> >> which partition the kernel you booted originated so you don't upgrade =
on
> >> the currently booted partition? There must be some way for U-Boot SPL =
to
> >> tell the kernel at runtime where it came from?
> >
> > I don't currently do A/B with Falcon; instead, I rely on the fallback
> > to U-Boot, and U-Boot in turn loads from a UFS boot W-LU (which is A/B
> > native). Making A/B work with Falcon would be a nice follow-up, but I
>
> This means supporting two completely different boot flows with potential
> side effects (U-Boot proper probing/breaking stuff while Falcon mode
> doesn't).

Yep, not ideal. It's all heavy work in progress, so I might still
rethink the whole approach more than once :)

> > believe it will require some external metadata to choose the active
> > boot source anyway - and then the same external metadata can be used
> > for the upgrade. Such as the UFS device attributes, or whatever people
> > use for RAUC and such.
> >
>
> I guess you could use a U-Boot environment for that or some more secure
> location (via OP-TEE/TPM, etc...).

RPMB with the key managed via OP-TEE backed by hardware secure OTP and
on-chip crypto would have been great, but it's a mighty detour from
where we currently stand, so I'm leaving that for desserts :)

> >>> several ramdisks to go with the kernel image. So putting this
> >>> information directly where the user (i.e. the kernel) will find it
> >>> cuts out intermediate steps, which in turn improves speed and reduces
> >>> complexity.
> >>
> >> You already have:
> >>
> >> fit,firmware =3D "atf-1", "kernel", "ramdisk";
> >> fdt =3D "fdt-SEQ";
> >>
> >> in the configuration node. So simply have binman derive from
> >> fit,firmware which node is included of type "ramdisk" and fixup the
> >> device trees in fdt-SEQ based on that info? Less user-prone IMO.
> >
> > Ah, I thought you were referring to runtime FDT fixups based on the
> > selected configuration. Patching it in using binman based on the
> > configuration node contents should work, too, but what's the practical
> > benefit? It would still use the same ramdisk node, just written in a
> > different place - or am I missing something?
> >
>
> Not written in a different place, written in the only place it already
> is, removing the need for duplicating the info which the user shouldn't
> have to do.

I think I start getting what you mean, let me see if I can indeed make
binman infer which "ramdisk" should go for "ramdisk" and write the
attributes based on that :)

> Re: fit,bootargs, can't you simply have the property included in your
> -u-boot.dtsi directly, so we don't have to have yet another binman
> option? I understand this won't work well if we separate binman from
> U-Boot like talked in a different thread, but we are not there yet.

That would mean rewriting the .dtsi every time the bootargs need to
change, which in this setup is just an (already existing) Kconfig
option. The property is also not useful for U-Boot proper, which would
inherit it via -u-boot.dtsi. Plus, I'd rather not make the whole
Falcon thing too board-specific, as then it makes trying it out on a
different board way more pain than strictly necessary.

Best regards,
Alexey
