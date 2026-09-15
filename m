Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A51C88E7D
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 18:30:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DCA4B6074C;
	Tue, 15 Sep 2026 18:30:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SJScwyF1aSwn; Tue, 15 Sep 2026 18:30:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0272F60717
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789497021;
	b=JJ31W9ZcuPAv59bNf89tJAQ3WMKUB/ER+hovWwf+gTm45Zl7xA2V3wBo6qWu4tpMXrBL
	 QlpIsuH6hk6hvyl4McTV3Q75rbL8wcLrMDTI5Byc1Sw7tSxADMmekzrNDm6xAJKK9J48Y
	 YlNCkeBQw6LjgR0oicpRcG3qlYv1n7XMx0afc3Fabbio6kFCIJxXBqNJ7Bclq5YNzflKZ
	 hODHiNc1NXjhZzF9u+fqEA3lHXLSk8fJhtYC2KMOQ9hXYuD5gxf49mDRhmpKz88WjyzMB
	 vswJBk9VfaLzLzyVmJcf5F+BnKhU/uRkDHfl3jrY0hUqcX4GF6rI/z+OqXhWDK2fnjA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789497021;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=L2FtWGZ9wULCssKfqmfse0+MPqnI8e4aElxNMGEwibY=;
	b=DomdSynvdAaWOBTdvumVQV0dC1noYl9/zK3koOayme5aR7YKeFxUMxJlg4/CG9eUjkpW
	 j3XeTmauLhXyf1ZHI8hYGBwuk9mHsr+cVyLcCSkoo2iGDFMWPw/agE3XhH8r1gx/bWnpB
	 X2sxIyWXQuqBzWMI/ZmCfIC1NmiMU7JiyihnSCwRE5DIdkqHi505/HzMlegWT3QSjjuM6
	 mZg+F9ocF2Gt5OjANlzXodLOFls5YIR/R9T420ii0HWscWVSzVzuUNhzZLO7Z0uFlsnxb
	 3RYDNrJpgRzma+Vzx/5yj3F0Dmogc1qvdiO6qXpvaSv8PYYq0liuMVfYIuKaYS66wDg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789497021;
	bh=L2FtWGZ9wULCssKfqmfse0+MPqnI8e4aElxNMGEwibY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tUjTPQFOiEhHA1bq06DRCCxmRY0+zDH9jPcLIuy5UZLs+dxi5SfY9yynvZDv2Lbqn
	 HCr9Rlncneg7MNZTz9aQ/dYNWYQhMsXpTDI8LZqrYuExYDPDYwwVVWEvdERY0ObIgE
	 zQ/4pBfwMoQXRWILGQbd7izbeVtedFKKHlXCnufKGP4kU47w3mOHb5NGYibevfmFYU
	 EGBIDyIAPuqOXpAUnKFSdyGSfON8V0GQe/iioeltNESU4jKUn6YpKrzbcDxuFcJecv
	 EO5oCY6iioGXYQWmUvO1PHgYthAzbKNHzT2nskP7GWDZvtBlelIagZd+9ZpgngRGpe
	 H7WV3ArX/IjnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0272F60717;
	Tue, 15 Sep 2026 18:30:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 58BA1EB
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 18:30:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3C26B4050E
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 18:30:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GITbQZTLDTqR for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 18:30:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 32A9A40506
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:41::11"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789497017;
 b=HohUBwa2coimFpKqB5pPjvz95bE7D0/3JGpzuHnDfmLZ9NiaAIDl0YPrKfU43GKWUqh0
 QjbSc3YVwvugkHsMAonN+1kzu3wlpsHuEmjN2Bf9ifME57GBH+N0o7iK6xc4/+bMMf5aB
 MyQPmtjKyDOIfimSxtt577y9OKhCux2gHO2SDPFvY+mJY/xpU+UTkzmoyDIh8vEbfxTeM
 uMGhaQ1DI9EFhdKai1NR7ZIVYuia4FdFIxhvEl9Yhbc/6oUsFtq/aE78GYZgCPwaYqDju
 Xf6n7I2/V4UFh5vO3H1Bt2rCzYU3JvrrQCm6N4ljlD7GCn+rMOx57RNjL+Kqr9hIQ7w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789497017;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=L2FtWGZ9wULCssKfqmfse0+MPqnI8e4aElxNMGEwibY=;
 b=RxZUbvmsc5zruYCnuNz1A4IgV6Aa4J51vsMo/locTCtPzKKBcTXD/KZjai6aEWBloG7J
 ZlklPEfEpm70Vz96fCH3gVzZpaDqDeBv0FZ0QQHypcSLagFPGbwTNpQdqH9yAvYDzA8vc
 Wr/q9ogmlNb/pHAt+M8y/KrI0uLZgIprAljR3gJGf5fGFpVf2C1/lZBrrIlxlxh0GVklb
 b9gIt7z8fPsAgdno7iU0Y8zQ9pdkw6guu/LbJqwUq6YQCzVVCsEFtrRc2STxDxKiMpTMc
 n2i6WXILQu9cIYNGZr5ApEICs1ZQjna0dki2jyzovOlRAlGtNds0F8G30BUNTlVQhsg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=m1zGS+tK; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:41::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:41::11; helo=mail-yx2-x11.google.com;
 envelope-from=0xiviel@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=m1zGS+tK
Received: from mail-yx2-x11.google.com (mail-yx2-x11.google.com
 [IPv6:2607:f8b0:4864:41::11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 32A9A40506
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 18:30:16 +0000 (UTC)
Received: by mail-yx2-x11.google.com with SMTP id
 00721157ae682-85d43db0c1cso1273267b3.0
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 11:30:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789497015; cv=none;
 d=google.com; s=arc-20260327;
 b=DudF7TLQJN+hlu7x1UU6PJ7+rYV/DBTLOVkMZ9HZdE+K6HVYTFzU5Y8e12lSCBch91
 tMAqANMHInpzhGSkDo0ufBsRRU4FG6zsluZWKfo0m8kqWOe5b9krkG1K9cMsOmfwAOo1
 z3P3iquiiWkpVCJif/82yf+C1udNirmTHSPCTrUHO5r3XaWnSldczD9K3rSQaF2JOsEu
 c4a24S33o5jHyQFWMjCE1h6IebXURKvXqC0qvGhTcetYc3+ayfe4JYgCPacfxJt6xCZR
 DXxtdKMk6uatqNWnuUTt5UqkcXDscb46c9ZtDkKf6p2X0YqKX84yqrdKKhfAHqWQ5iud
 BmZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=L2FtWGZ9wULCssKfqmfse0+MPqnI8e4aElxNMGEwibY=;
 fh=xxPU5xiymfjsTDtbYfXhnkL6H3rZuLUuPEGBLyJUPbg=;
 b=kD13hdK/miMOXNRE6YBoUz8qkgkJ8HaDj+6KwaFlobMAmrT44Wekje6P8oh+IHWGcj
 0MirWg/qUsXFnkU545+3+ypzf+LdEyas9jan+V4jxFFU+Mp1TEO+vkdFRePHEKk/Az7A
 NRHLJurh9Kou3oS2SV0DszXj60e/gvhKQ6sGJTNf6SFcsE/TH6/5Tun8oR3CEmRBzOdO
 3mG8DNGj0VCkm5CBu4hvgOS064Jhu+7xwLtKi47bNn2/H2Epe27DR3OIC10ejgbDyygL
 E91eU9HxeQxnOP1Va0mIINhfsWgIwlBcISB62tAX2oI2ilciirQdg8X2htQ7ZLcvkr86
 oUHQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789497015; x=1790101815;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=L2FtWGZ9wULCssKfqmfse0+MPqnI8e4aElxNMGEwibY=;
 b=m1zGS+tKKhVQsSK4tdrioIRvq5HWkrWkn020CdwJX9EF6XNcom7LCLsYB5Ugtl3TT+
 rsYottq6/NrOFGDXNSqqEjzymWhGRT6rUdAA1kV7NxtgGU77ITWu4tmLNPH6N8XFcpx7
 ZZQ2BehDwmZN+M1QnaMZCtjf9/3za9e9cFXHYgFwru54RSu+ysHL54r0FmMASjiwdQgY
 +TypMlCBhoasHOQAT6TXYrRizEd/Ge+Pm4n54V6FDIiXe3nsJD5POkB9NFoLWiJBqWuI
 P3ZO7OiCQvmzUQPp4qotUxw39HqzLHkcGo9ooEw8hDXmxEyGA5hcjSbCBnu+fM4ALFpK
 5aXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789497015; x=1790101815;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L2FtWGZ9wULCssKfqmfse0+MPqnI8e4aElxNMGEwibY=;
 b=Mm3L0GB4eewU0L1LGYDuq91dqxE1iIU3nOJC5hdQNX8PqN2aC23oi+UL0pPybHdeKb
 s5Zy/X62KkdHa1VmYmON2v/gh38avW3uIJSE7l0S0VHlumwWZy7O1fcLmZao7w7274lJ
 Njf+xwepR9Mw5gdidReSljuTmYEKaoV8Jj6OtRoiIcy+W2hoFfsR9rB+Uv/Lgmd37tTx
 N1Tm5MaENVZ0TH+oluNd0bVhefYOmhgqX+f/6Oz56wmXWGfc1abKJ0TUFUX4veSMl8qd
 ibH7V4XrI+W/Q4wtyDhS8RY6KEGt/wD3SLVWAuIPVw2l9WPPWdEPCqsibQpNMHNU27+y
 4nZQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwoQhxXUJ73WPlcfCcDEIeBIzvTp4f8Fpm9x+iOOWvRqmWOnBKAEJSKbsa+BfCR4WSRkTCfM7M=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++l+4Vkf9BWAOf/dJTg/lYsDvKAislgBqYelcZZQCJYJqHTBtP2j
 8M87KeVQi08m6MMj3MCw2tIG8lfN0Vj1W3LyERGpKyj//5q8ZE4aqvdCogfa0GFR25rVSTwuQNe
 n/GYeGwPtWZHpgivWTrRWl/5RC5XAfhg=
X-Gm-Gg: AYBFou0bcmd0gehNUZv1QBUiagd+i38PDYas1XWtSGUI5y3MNtTGR5B017qMugNXBim
 qmsyfb3Uk+QomuqKLwU3Cm5bAV8qwr1FCEbPjNf8ZHm6Yfi29wYqEKFIMoblIXiTXrcRlBLJd1I
 2TnuH6SXB3+wBgkAqqlQ/JhHHMZBAITyNBdgE09+Z3nEgQmyzALSFccHuJChDOd9dBfQU52CLth
 OAETGAQfsB/mSBAJXHlrAaY6mcHmWJDLiU5GPvLqp2UqSsTFwvIDc0gAebQJXOuMyG2IYELfWY0
 NX6SvO0Fk011u1l/3AFTbOtUT2L5IfZ46m4gHn/AMpgT0MpJwWwjQmlMAmj76pNYjkQfZey599Z
 NVQ8mKR0LD9e4BYuXElLUsRnb4W4xoaodS1jRnzpQQCpK/Jhfh9++uzhLL5n7gF+qcD25QZ8v
X-Received: by 2002:a05:690c:e14f:b0:87a:db19:aa86 with SMTP id
 00721157ae682-88d1e942583mr23210557b3.5.1789497015459; Tue, 15 Sep 2026
 11:30:15 -0700 (PDT)
MIME-Version: 1.0
References: <CA+pz=k+hAU5dqbO4GOLJ0fRMRdyrq=kTSnwUc0OcR3r9PotUgg@mail.gmail.com>
 <20260914173412.GD1764417@bill-the-cat>
 <1f194a25-f27f-459f-9b2b-8277457d56a8@siemens.com>
 <CA+pz=k+SnTLkKyj3uYy4L=wM93tSOD7q=Z_sFmdLQ9xScsGK9Q@mail.gmail.com>
 <20260915154140.GA858934@bill-the-cat>
 <0ec38395-d0a4-42d0-a3b0-0e98412c18eb@siemens.com>
In-Reply-To: <0ec38395-d0a4-42d0-a3b0-0e98412c18eb@siemens.com>
From: Eva Crystal <0xiviel@gmail.com>
Date: Wed, 16 Sep 2026 06:30:03 +1200
X-Gm-Features: AcwNN1W0mys8K0_pSuyEmuNAdF6QtNeSms_L4x5Tif05xnqG30G7Tvn_1NvTNWY
Message-ID: <CA+pz=kK=HiPtPOuyTwUyTDWoiQJMCXTL7th5NAaFqXqEjOD=jg@mail.gmail.com>
Subject: Re: [SECURITY] FIT signature enforcement fails open when the control
 DTB has no /signature node
To: Ludwig Nussel <ludwig.nussel@siemens.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
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

Subject: Re: [SECURITY] FIT signature enforcement fails open when the
control DTB has no /signature node

Thanks Ludwig, and thanks Tom.

Understood - I'll carry the image path as a separate series and keep
it out of yours.

Plan, so there are no surprises:
- Rename my Kconfig symbol to FIT_REQUIRE_IMAGE_SIGS (plus the SPL
variant), default off, so it does not collide with
FIT_REQUIRE_CONFIG_SIGS and does not disturb setups like Rockchip that
use FIT_SIGNATURE for image integrity only.
- Raise the visibility of the missing /signature node unconditionally,
so a build without it says so on the console rather than only under
debug().
- Add a test/py case covering the missing-node path.
- Rebase on top of your v8 and send once it lands. I will not post before t=
hen.

Shout if any of that should look different.

Regards,

Eva Crystal (0xiviel)
XSource Security

On Wed, Sep 16, 2026 at 5:18=E2=80=AFAM Ludwig Nussel <ludwig.nussel@siemen=
s.com> wrote:
>
> On 9/15/26 17:41, Tom Rini wrote:
> > On Tue, Sep 15, 2026 at 08:45:23PM +1200, Eva Crystal wrote:
> >> Thanks Ludwig - I hadn't referenced your series in my cover letter,
> >> and I should have.
> >>
> >> v8 4/8 does close the configuration side: fit_config_verify_required_k=
eys()
> >> gains FIT_REQUIRE_CONFIG_SIGS and fails closed when no keys with
> >> required=3D'conf' are present.
> >>
> >> The case I reported is the other gate. fit_image_verify_required_sigs(=
)
> >> looks up the /signature node in the control DTB and, when it is missin=
g,
> >> sets *no_sigsp =3D 1 and returns 0 with only a debug() message. Every =
caller
> >> then treats the image as not requiring signatures, so nothing downstre=
am
> >> can fail. As far as I can see from your v8 hunks that path is unchange=
d.
> >>
> >> Two things follow:
> >>
> >> - I picked FIT_REQUIRE_CONFIG_SIGS for my Kconfig symbol, which collid=
es
> >>    with yours. I'll rename mine to FIT_REQUIRE_IMAGE_SIGS (plus the SP=
L
> >>    variant), default off, since the two gates have different blast rad=
ius.
> >>
> >> - Jonas raised on 4/8 that Rockchip uses FIT_SIGNATURE for image integ=
rity
> >>    only, not signed configurations. An image-side required-signature g=
ate
> >>    hits that setup directly, which is the other reason to keep it a se=
parate
> >>    symbol that is off by default.
> >>
> >> I'll rebase on top of your series and resend once v8 lands, rather tha=
n
> >> adding a patch to a series that already carries review tags.
> >>
> >> Tom, shout if you'd rather see it folded in instead.
> >
> > Since Ludwig is already working in this area, I'd like his thoughts on
> > the issue / solution, and if it would make more sense to fold this in t=
o
> > his series or not. Thanks.
>
> I didn't touch the image path at all indeed. So perfect if Eva takes
> care of that. My series already contains too many things and had too
> many iterations. I fear that expanding the scope would delay acceptance
> further.
>
> cu
> Ludwig
>
> --
> Ludwig Nussel
> Siemens AG
> www.siemens.com
