Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63DF1CA5FA5
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 15:12:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 26E1780EBA;
	Mon, 28 Sep 2026 15:12:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7d-9UUrCZMwR; Mon, 28 Sep 2026 15:12:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 68DD38091C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608352;
	b=j5V8ZuufFOsXceXF0inwz7epzpmXVMfBdJdis9wPBaIVyWfrC2Br42vWnT61v4MSL/zf
	 gsXK+ncTq7EQBxhVMH/qaVmpAxY9ckMxz4Mr6GunvLriSyFEkYqpTKa+QvfldA36dp44a
	 OhIeu+0IowXiVPzqNj35b6XIomzHn0i79xz3omJ9NNNwlxtyV0aLfYDaIAsz7c7ArdiAn
	 aVL2IKHda8Qotr9rdOLAR7RaBCET1fFidlYFbOan6tAe1i848fP2Wf+fZaejlvVw7yiDo
	 gE44IW3oq9osn5FwAuQjAnU410xE4FWw7IuZ2k9kTULpPj5/ndOR9tzCMA/4aCWk9+g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790608352;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=pBTn9gf84+G2rlwmRL9HJhodowfpLXw3fJTxndaLBdk=;
	b=PFfH5mYWu6OiPwoMfldWxBOLEK3ZXmEtcUKfqqkrFqgkYVKspoSwhes7Mbq7rwFRq1oy
	 v5dVMVLpKzS88KyrLaOLyzDORQo6NPLfsOD0AwglxKYETo0jdkSLXPNi63b2S81PWlr83
	 O4fZJWDlSEKG6STDtXT0iWrqBwB8+XoEw1Qyw324s6N5bbEB+/NT8DEd285h58Go2eSF1
	 Bt1uRPrSOPuXPZRvrJGScogCOu49lMCPoxRccDUwPrLSqXshRL1LvCIoe1XLDHDHv2BQV
	 EZYyXU9qB/kt/7eBszHERHYFMlVi4qpqpfQq2akRpL+50v4FWAwZV7RFvzAtlOF6vIQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790608352;
	bh=pBTn9gf84+G2rlwmRL9HJhodowfpLXw3fJTxndaLBdk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W9wUs2IVlv8HuryYf4oV5y73WFmV6dsSo3KszkWEMCMyWRa7S21mOealHPVRoZrQP
	 gUdCq3MfK9A43wL/PV5BDYHJ0llWrZNWYoc8vAY8q83mnL2iDATt4cdpRZKfu74jvX
	 CcPSBZ0g1aDXT7DiGs40uBi7xvtGOuTGSpOKrHTDh1ru1g9knJJcVbq99bbOYrSQKb
	 7lmvL9E/v9yhHiln3dZ2dst+/yVZ37M3Na/xHK3OFzgQpPjIfV0y4FrSW2SPmojOdS
	 F+Kl5ryU6j/sifNxZGBnVStsZ2skO6YblinfVN2rdbnO7exG7GsTKjARF6DB+nIY6U
	 /Gw605zYt8R6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 68DD38091C;
	Mon, 28 Sep 2026 15:12:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 522EB3A0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:12:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 437C2606CC
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:12:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5qwCY9CTs_4m for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 15:12:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 39E4D606B0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608349;
 b=GK2CqvNL0b2AFVwm8aa0kZY9xhX0NiKUqV+/xQUOeRmcZQ8or6WHpIJW7wSBpjUXGyMW
 hZpzp5iUuIT3gJ1r43z4EY3OhexbVM16dxudVXSDf+4BXytbOCKbXeaJ4GlvAWWoiGiK2
 rVS6qo1oafu8zwXAS3YDH7rzaFXBOI84x5zaIcC4/2iKuqfrIErYp79YNQlOxNZDsWtzu
 SgnZCWmIsK3w0Xo4gps//+fFMzIaGxFtHQVqmYsOUKUwhRcRbsrAYZt0eJTM2+GKs05to
 jaFcKfiduzysel2SCMK+imQQZXGyUs3DeQgT+/ccRwMhKCtk6x/8kV+kupXs6OYaz3g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790608349;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=pBTn9gf84+G2rlwmRL9HJhodowfpLXw3fJTxndaLBdk=;
 b=Hqwq+p6peCyNOGGM9RN/gbp9gvclDhKqohmQ+7ckBE9+PDf4hzZcQXGPi7wH7DIaOzOR
 f/mGLawp6QCz1hlW1NvBEZMQ4WcKGg2ndfnbVRTmRuGVoMFWcF7X+8IlabvPXPylw46xG
 TjMLyHCXURxIbREOFx3HnXz8mmbPn8ZqSkzRwlHiDvQCaX6x4IQ8rkqM+cNKMD/osSuKl
 9T9OH7DwQpLro5hbHc+FWqkvvTiqrFEHOvvuyyqWCgavT0zeO9Qe33kDQX3aqdxuMx/Xy
 yrhe2gmnsiPRzLr7jFT139Rgde+yrim/LuOMDck1XUVNwOmGT0zedUC+vO6dnGD/Xsw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=WSwy5GDY; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::e;
 helo=mail-ed2-x0e.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=WSwy5GDY
Received: from mail-ed2-x0e.google.com (mail-ed2-x0e.google.com
 [IPv6:2a00:1450:4864:33::e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 39E4D606B0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:12:28 +0000 (UTC)
Received: by mail-ed2-x0e.google.com with SMTP id
 4fb4d7f45d1cf-6aaea1cb2e4so3778977a12.2
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 08:12:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790608347; cv=none;
 d=google.com; s=arc-20260327;
 b=egwgVMzsSYs6/Ytcb5jimImUVlgNbvvRdNJjeaQUM3vvc/u84pCIaP2BVwAAU+sE1e
 naMvNPjYobjFLXnD77JyMW+h5kHqMNzqeLleyQ0VVoF4aV1CUbp0XqlHfRemI/bXJ70L
 gmXOjurXbZoFBTat19okHJrqDVowXhAAVTwlxe5y3NkU60cnG0+ggxPunvNNGftzbWEn
 zNejoyr05Ufm6UzxZl9gibyuOTo6I0En57Fj/8jisTESZzOc1gz/ZiA+dzbFMuq/Mwj/
 +u/qxMWwkTi/MeWVqZ+VKPMjVbrnnNzwh4oj+JyZ7dI6eqbS/ShWiTvs4QFdL/tL2x91
 8x8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=pBTn9gf84+G2rlwmRL9HJhodowfpLXw3fJTxndaLBdk=;
 fh=NcTHeUpO14R4OMyqqQ7NzJAgA5ydOsvGqQiIOlGPzKU=;
 b=LHfSc0WdN7sfDyzKCIiae7dyTgasvMoqlZdHljFEWpmv48yEupbnWXRZMnmGrxKeNT
 SKgbdWzwZOOXl92uIDcDhzUGombgdwGxk81N1JtmKylS4dUvceYh6Sa/rVMg1NaPeIBR
 eT4piE2Qz31aHN8oB40EWIqu4NnSURFYhSzS4Gl3gZSU9m2tJUHci3cKcHFIIHgmmoY3
 94BcLeesRItnd6emaCA9oSUS0goTHSCLZosTOCxopLyjH2gX0Zc+ARI89SXn4MhJJFTG
 RyiZkWQfU9in+WLWcLmI7fxeIIJbWiKTia1IcBzIMADaIYBf3jhl7BK4lVkS+FgDX7SQ
 C1OQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790608347; x=1791213147;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pBTn9gf84+G2rlwmRL9HJhodowfpLXw3fJTxndaLBdk=;
 b=WSwy5GDYxoiyX0yCG4/YCVS86NNzZCOfYlp3VocPnBLr3GF2+F6qupEI0Gp3hMyEHf
 ac7lt9yoKKTtD352shQvJ3m10y4DjgTAybGASbwdpcHz6yAevSsYdYJpvW76Ngy9101O
 eULJveb3m30vJKtSscMWr5aHr0Aoo82ANYFoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790608347; x=1791213147;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pBTn9gf84+G2rlwmRL9HJhodowfpLXw3fJTxndaLBdk=;
 b=Z6T9BmI1aScMxsLKJzz2gU0gFrQRbo+jzFkdl6o97eivnYhxhLI4hzP0UCxmS/QZcL
 kAT1AjaAT4W+nr1V65k45gu7EjnSDeRvtqYJaG4qkm+wDUdLsaACKtbNwskmO79QTcLV
 3S/hg/pm+vMIi9uKiLBCsFxq6U2R6oj3ueNiXeYbuJuLvqRCjWtfyvojpO+x9U1PB75w
 NnHgj+sxGrlhP8/2iQZihs+A9rzBVnKUJlg7j1tSAevc67P0M8TKercPLY3+rY32yh3K
 b/j8cphD517fM81UZeBidOyDKc3upOHA2Wlo/elNwql6SSDl0gXv15yvFyOCiUNDgvsI
 o7RQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz9NgC5PjCMe+G7UNi37dF4WvWOqr0T8zaWj8nBYM0MbCjNWOzwnO1XXvI381Iw8Jl4HRjAaPY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJOaQK4lE2n6xirxXRj4kRrqXam3W8kGHcH8ZFX7kNlf1w9TwzX
 7L9atmAzMt/7/vq2YctifYRoxme8hc2FrlyW1OtOi06XSGH3MfNG0eZyKv1l3/WvAsO5VQwRMva
 gZV9ZzumxmzBr6nZviSWcCOV5V6p0xQ0YCbuV9DJv
X-Gm-Gg: AYBFou2iBi/87wIhc6Had82jZol/7QwPzKARtHjdiWPCkFxfRTK1/986LZfXCt/WubV
 g8adMtLVJAlA5e8ZxwYFy//QD0bfDsmCxJ5vde6oSpTkXcUvvKWnLZdE9BkAUG2NZYykLsJj93j
 94XMKosgC0BInZAtrjHr1PgpONJ/eg6zJBrvzXzqmTWCAcQ3FEHGH9KIuNbgHr8edqvdjW+DMwD
 2/uXawehMqLMER9KwZQKAzCyzc7Xz2IJRRlryMNqamNGp0FvhrUr6x5g3ZdwQ++UZcqpBCXcCR5
 sliek/Lo20sVsf6a7EF7ct8uq/6Bn0E1yx6Gd9xH5YOFvUQec/q12Q==
X-Received: by 2002:a05:6402:2082:20b0:6aa:e263:54f with SMTP id
 4fb4d7f45d1cf-6aae2724a48mr5899053a12.18.1790608346660; Mon, 28 Sep 2026
 08:12:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1787272661.git.daniel@makrotopia.org>
 <99a003542ea5ba616bcaf7b60136be6943079f89.1787272661.git.daniel@makrotopia.org>
In-Reply-To: <99a003542ea5ba616bcaf7b60136be6943079f89.1787272661.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Sep 2026 09:12:13 -0600
X-Gm-Features: AclHuK95CFwEP1LMaRTZHrj8SLm4IpKd_-ohNdrgLzkpEQZAyvB9TJC9FdKGDIw
Message-ID: <CAFLszTjNHuQYTcN70CxZD5zrv_x-YgcEFSrtX-qNEJ9GwE0AqQ@mail.gmail.com>
Subject: Re: [PATCH 2/9] mtd: nand: sandbox: forbid sub-page writes
To: daniel@makrotopia.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Michal Simek <michal.simek@amd.com>,
 Johan Jonker <jbx6244@gmail.com>, Aristo Chen <aristo.chen@canonical.com>, 
 Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Weijie Gao <weijie.gao@mediatek.com>, Peng Fan <peng.fan@nxp.com>, 
 Vincent Jardin <vjardin@free.fr>, Neil Armstrong <neil.armstrong@linaro.org>,
 Randolph Sapp <rs@ti.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>, 
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
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

Hi Daniel,

On 2026-08-23T19:12:43, Daniel Golle <daniel@makrotopia.org> wrote:
> mtd: nand: sandbox: forbid sub-page writes
>
> The sandbox NAND model programs each page in a single operation and
> rejects a second write to an already-programmed page. UBI writes the
> EC and VID headers into the first page in two separate sub-page
> operations, which the model fails with -EIO, so UBI cannot attach to a
> sandbox NAND.
>
> Advertise NAND_NO_SUBPAGE_WRITE so callers place each header in its
> own page, matching what the model can actually do. This lets the
> imagemap UBI-volume unit test attach UBI on the sandbox NAND.
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>
> drivers/mtd/nand/raw/sand_nand.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

BTW, longer term it would be nicer for the sandbox model to actually
support sub-page writes so we can exercise the code path UBI uses on
real hardware, but that's a separate improvement.

Regards,
Simon
