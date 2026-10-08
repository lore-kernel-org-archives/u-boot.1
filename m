Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEDF6CA6007
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 10:51:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7ED0340A65;
	Thu,  8 Oct 2026 10:51:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ns5HSWknAX8c; Thu,  8 Oct 2026 10:51:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org DC6B540A6A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791456717;
	b=gWo2ZrtlEuaIJ2zCxszVPu1kFQ8VD2eT38z8kSpsUcVA1fW2f+qUAfY+IrfOu/yijt3p
	 9ZHUxefzvndMkGccrNu5lsgZF98mmktstAkKrarG2MCsq2bUO5Lo20s4w9X1+3ZJwPnfX
	 a7OQjbq3BZh5Y2God7/tt8rfc8VK54ocPdKhq9aPPK5XRh8VWrzjkz1aw0Qsz9tbt3L+X
	 uzkxMg8fBnZPnUQUtHaBZMiBt8GqlI6cgZIR8zxhgy9bBzB5tOH70lI2aUk9yLUp70idZ
	 qUbSFzFqJ7ytQxbHPPm80otdznfR05EjFTQTYNUegTqVoE+Fve2qC/uIYlHeM0YdT0A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791456717;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:X-KAS-Sym:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:Organization:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Spamd-Bar:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/sS9hjtvA1uim+Kr0uRcwwWbdCNxNwffFO1CM6z5XYA=;
	b=M8DDa4qWXSlZwm3FfZAL2tTZy8dRfyfbJcRX/+FmlrOq+klhlP5fK/mCBjK41ofKoWWX
	 ry+nvcw/BTe9NhSPY/Gjasv+W1jbWwWF7XLE8UGLQ7bBj5SHp0IYQXinrVqyD47LcTQUm
	 FoLMZdbb+UNdtJFVBeyRpFRyylcl7bKvo9mkF0X1wP1Gg7g9PTNxynmZr1CcVGQJPFFAz
	 oRs/tD+o6lsLqEGLHnHJ9fsqBChFUKqLi3h3Zb8pvJCSSWAj1ca68WFLdX5nygTIZ2lOP
	 +56oKOPp0U0ZKLmvpNvXjSeFHj0TU+2fbnT5HRigc/JRkttFRaxGzV8Wf+N8GiTxo+A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=KARO-electronics.de;
	dkim=pass header.d=karo-electronics.de header.i=@karo-electronics.de header.a=rsa-sha256 header.s=kas202608290156 header.b=ul9pIHBR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791456717;
	bh=/sS9hjtvA1uim+Kr0uRcwwWbdCNxNwffFO1CM6z5XYA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z3ycx/bWWZboAJmsYG5HIpb9AtgF17MOMNBCqpXL3FIoMjJgXAMDkQ5X9T33HadB/
	 YFoaSxhqcNGwVDla83PJRUgGt/SZ3muRiLe/fVseLvKch64Svi91T1Mo5Yc2JdINLx
	 ZrAorBx/W0DtGceftMIsZRMBs4n+U/9UXeHVKq219bVuYrLugBMHzrKX2MqqY1mwBb
	 43bihAuFRBcukYwV8gwZjbq1xybciY6FnkiPCeBSGB6cXQrYqYFOt0MfPcqPs6e27s
	 I8KEdZiTPlgW1lmakXU9+A94w9vZhZVc8UjL5u8JLKWUxwPDH3XzR9NTIzgraoNvr3
	 IxzPK3IwWngZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DC6B540A6A;
	Thu,  8 Oct 2026 10:51:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5AA342AA
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 10:51:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4C4A540A6A
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 10:51:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HABTx4lWJ4Y4 for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 10:51:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 34C7E40A65
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=85.13.167.58
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791456714;
 b=hLb3ix9Cx3SmW2qXtcDFRgcuXNl4Db3VKAJbDyWchZUAdcrna+xL6NXgbWDq3yfS4gJZ
 61NZk6XQ2cbVeqNiGR/bSE1/Rp8wJezLk5IRMl/RvGPKigws6NgjwfcZCTQ28DHaeJNrB
 +wopCburwIuYsACMyt2uVaiGch1uy2DvG/XksGk7/ZoPXdox96OKIAW7TyBbBfDUod6b3
 kheh0Fk8AToBKynKaycd3bCJK1cHBtdD2d/kV3gA4nBAK57T/ZsisxGlewjqvLeiYGAje
 32kNw3nKv4oEpSM4eI/pyxheop7wF0mUUktJlv96fNUaxGuB3mntb8+5gTEaFfkwkbg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791456714;
 h=X-Greylist:Received-SPF:DKIM-Signature:X-KAS-Sym:Received:Date:From:
 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Spamd-Bar;
 bh=/sS9hjtvA1uim+Kr0uRcwwWbdCNxNwffFO1CM6z5XYA=;
 b=KoMwKVMysDGaaHimIsF2Tr2jCG63k47Fgufroi+2/Mt5lgfuRRyH6LGdslLvHZOhfZnm
 Jr8F45f1CxKljUoJCDSNCXHjI7xAKsFyhxWnk1Ka9KxnSczBNurqQ4jj4uSEgmHmxbceQ
 UFXkuM0UyRl0sCSJKrPrXWLbRAr2TZht7LBDGS7EVKkhRx6+ar1oqoupIr1g5NaKEFMxb
 HVCnmM5iMVinY4R9YkSMnzaID1aHW260gbmVW4Ry73i6Axf62/a+GFlSzuzOuJnkvSzQA
 3iKTgRcPxEWmrlexwFVa4satJZH57ejw/UGc/cSni+GcsxgsvDwZbXV/+WBi3ZjTRyw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=KARO-electronics.de; 
 dkim=pass header.d=karo-electronics.de header.i=@karo-electronics.de
 header.a=rsa-sha256 header.s=kas202608290156 header.b=ul9pIHBR; 
 arc=none smtp.remote-ip=85.13.167.58
X-Greylist: delayed 407 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 08 Oct 2026 10:51:53 UTC
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=KARO-electronics.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=karo-electronics.de header.i=@karo-electronics.de
 header.a=rsa-sha256 header.s=kas202608290156 header.b=ul9pIHBR
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=85.13.167.58;
 helo=dd54918.kasserver.com; envelope-from=lw@karo-electronics.de;
 receiver=<UNKNOWN> 
Received: from dd54918.kasserver.com (dd54918.kasserver.com [85.13.167.58])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 34C7E40A65
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 10:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=karo-electronics.de;
 s=kas202608290156; t=1791456303;
 bh=/sS9hjtvA1uim+Kr0uRcwwWbdCNxNwffFO1CM6z5XYA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=ul9pIHBR3ULdgp6fRch+/2V69k5+/RKr15yBEuNeNubdvaPOsmc9BUArr2oV6ZpG4
 hc3Eh05QgaoRC6zwrAqb2u7AFs/83u4COI+w9MaxgZ3C9SDi1IpYuhmveS3mQvtkcY
 9tXEasT2BXzhiXKiEdnRxbq7GIwqaDUJ66rcDHciNxzNldCkr8Z1AauyKbVTi7kpNy
 F/6bggs0j3KZe5QcHweWbcKGN239aKaZrwFvUKGABqJ6/0p7iLahXyBtS1GtJpxImg
 GvCrSmlEkB3a/BGr9BZrKA/9fVWH+7WwNzclit+Mwp+mhtqDmHPt4Mc3bvLQMS30j1
 QLQqX4E3za4og==
X-KAS-Sym: v3:f51bdf72230551df:d7+sbqmD4MCeWPP+aEdzdx8kKTb5nhWGfxaZupYbun5FX
 vutR1xnux+9fQZifRF6pCx2pgd8yD+XGESwfVee1IBOVpCzehJCSbYIAH+m6t2j6N3IHek0txXO
 8ajKajHAnKeJhHyDzLzLQJwStvBUWq8MaRkNiYhngAlpXAIx8n7PeQSBYYYFtWHD9ihNCTv2kt7
 Nk+8jP0i+wAjeJvG0ZukYUJ4PA8uQk/8CJ8Rwd3j7Fb4WBBTligItGXFV7tglSCsZgSZN8nPz9b
 JzRcY52w20hUpsvM+vxPBf70qdnXQNuR79fQpZ5czrFC8zRsxPbmSOIlvCSEnlMCzyNxMgpg==:
 tovOP8LBwItnMH+JF9U1Wy83vyVJW6CsivYEX8RChlmw49oz3QfbRaroaEhJfOOrQcWVHG8hBha
 P523OdJcC2/W9ODiyFj17pp8JGzOyxRDJsvPCyVsJZvdo+K6nydxETHjhofjQmDaHbh+uaQCJN+
 QcreAPGlGRK/RnOKVLTMa85qUkXTkX5NuHOUEgPn48rA80lBY7nMM14wxLJ4GACfp8HXzVoZSoV
 Apyoq68JU8FyJeOggipxySGsQVoOdNnmNe2X3+fNP0lZDjI0758r7dSEZ5pv5M+KM4Gv5shL5Gf
 RObe4obsWVp9Nq0NnBfaHvW5831Va39t2meCmVBRZS9yxUA5BIYmBWT1fuRZAZFAxEfrJw+BD+a
 JbsJG95q2WyBO+5jUMnJXmgiHRbycpYWO2I8dhE/zEI6h3tLF3uAwMVZOc9Oav202r4N/yivZW2
 Pb/xn0292kHxvlKth3QbjRzyWpJLxgH+SKIWdJDfH9AIx4GN8mxsYcxBadzJYkUrkEzYppE3c0U
 DcliJQFthPo81ij68uvoGBY8Oh4H2K1rerib/RQwIoU20tpe1JSPByXKLqgV4Y91buihOUmsDqJ
 Jcfyeq2ddivVZRA+OKkTCYHQ63rbSsAjyy1zx1X2VP41
Received: from karo-electronics.de (unknown [89.1.81.74])
 by dd54918.kasserver.com (Postfix) with ESMTPSA id EB8C17729C95;
 Thu,  8 Oct 2026 12:45:02 +0200 (CEST)
Date: Thu, 8 Oct 2026 12:44:57 +0200
From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
To: Abhilash V <abhilash.v@oss.qualcomm.com>
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 sjg@chromium.org, Michael.Srba@seznam.cz,
 varadarajan.narayanan@oss.qualcomm.com, luca.weiss@fairphone.com,
 nikroks@mainlining.org, balaji.selvanathan@oss.qualcomm.com,
 jbx6244@gmail.com, u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: Re: [PATCH v4 05/13] arm: dts: shikra: retain QUP SPL dependencies
Message-ID: <20261008124457.2d266c58@karo-electronics.de>
In-Reply-To: <20261008094912.419090-6-abhilash.v@oss.qualcomm.com>
References: <20261008094912.419090-1-abhilash.v@oss.qualcomm.com>
 <20261008094912.419090-6-abhilash.v@oss.qualcomm.com>
Organization: Ka-Ro electronics GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Bar: /
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

Hi,

On Thu,  8 Oct 2026 02:49:04 -0700 Abhilash V wrote:
> Retain QUP, console, pinctrl, clock, power-domain, RPM,
> and MMC dependencies in the SPL device tree so the firmware
> loader can use the boot medium once probed in SPL.
>=20
> Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
> ---
>  arch/arm/dts/shikra-cqs-evk-u-boot.dtsi | 44 +++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>=20
> diff --git a/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi b/arch/arm/dts/shikr=
a-cqs-evk-u-boot.dtsi
> index e807b91ef1f..e8831da6aa7 100644
> --- a/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi
> +++ b/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi
> @@ -20,3 +20,47 @@
>  &usb_qmpphy {
>  	status =3D "okay";
>  };
> +
> +/*
> + * Keep SPL console and QUP dependencies.
> + */
[...]
> +&rpmpd {
> +	bootph-all;
> +};
> \ No newline at end of file
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


Lothar Wa=C3=9Fmann
