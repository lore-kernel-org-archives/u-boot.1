Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF17606A329
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 20:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sUAJ3I4L;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=EIzdDA34
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8EFAC606BB;
	Fri,  6 Nov 2026 20:17:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M7ovZZ_6hmdj; Fri,  6 Nov 2026 20:17:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E882C60890
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793996236;
	b=BcsbI7O7tXxxljANZHpnUWU45xBoHyCqtYdZKeB+w6dTycGCKLA+EjOuJRPklfAAadGF
	 BZBVdul36/glJk3+KuoqX8cyAAJ462Scvpavo3ILrD27GUeOyfch4YTTE8J/9atCL+Cf/
	 7nOM7Q+hC4XOcdp7P1D4w1Nw55PNaD/7jJtt8IzNl56D9rCf7PyBY045C9XMAZFqLiR9V
	 GErW+Fwbcq4Ow0oibGRPCH6Xb3n85tBC/k4I22qqz/iBP6RWXSPWOf64dgL1g5Ui423+5
	 hOjIyOQbCb5SwX2NP72p6puijiqBAihuP8k4VmtOL92/yGfPQPuyjyuVMbG/lbCmqpg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793996236;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=t/LnSPC6fpnrEg+TCQQ4VnydgPC+z1Ub0P7Txn3YaKk=;
	b=O4qyJNXMdw04MhESCYHTrcsrZJRG0/EKpa7o1Txh9S1fD9tSeuoA8FVAmRd+5cayn58c
	 rxeeI4bsRXAb16p7HBBC5Nh2J7nn7zqukF/kqDWuP5qkIDQhnFNWLugCWbu7/hsuKCFpA
	 bajbqXzK6pNXQMl7m3HXeKXJJNbcfnDC36pTjN363ZChhoWMu1G/Su7opwBlu2USHiQ20
	 R06Fqs3mH0DhG/fzF79FU7LwMxeH+wkFs0Xtp9RQwfmSs45JqcCieBlB6Ajpw3QKsHRSS
	 AIux8iyimT7+Gi5XZxVNmSwYUaj4nBbsj6BEsl8iraHeX7kruDVqnqOkb66U34paNMQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=EIzdDA34;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793996236;
	bh=t/LnSPC6fpnrEg+TCQQ4VnydgPC+z1Ub0P7Txn3YaKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sUAJ3I4LD0VJsMVfyBABCdrXACyQkFT1sg06hBuP0yMt6fhqwQHSPYWQIsMG/Ng8K
	 C34VWLS7y8OE1K6oMH103UgM4sVa93OSfxhraIrA45JcWs15S0RKywB+cGT2+LVwO3
	 ttDi8Kzftceh8j0D+HmnQt23xBr9CdSLUOloycVMamQ/ExLuVWGyNx9fRxOP1+lwIl
	 jmpSOYX6/39Jl17aE+pWyB2yH2Rtu2gTknBstvYVHK0h4jP0nu3I2HA+b4FvZ/jIWi
	 +uij/e0arsadPotwqy1i9XfYFBGEuctTYFW8GnqDsg4WYCzNyWaiqJEhiZx7hnghML
	 4z4n4l13IcLqQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E882C60890;
	Fri,  6 Nov 2026 20:17:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B8E1831F
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 20:17:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A971660890
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 20:17:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z4CnFvh4x2yi for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 20:17:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 06BEB606BB
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=EIzdDA34
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 06BEB606BB
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 20:17:13 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-85a5455bd3cso604729a34.3
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 12:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793996232; x=1794601032;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=t/LnSPC6fpnrEg+TCQQ4VnydgPC+z1Ub0P7Txn3YaKk=;
 b=EIzdDA34YH2tKCe1NmovdCo79MTilUzRARJEZgpiCK/IdyuRl9kXizW06cq7sjpK7f
 SjBhEwm/MR4fwjBQ3mZW+58iK2lMD3Muoa0Q7BTOYwzJpU8teEitwZDhkJ+RMRWeDXoC
 esAZLg5E+8JOQlKfLE97kKtxAy8WFkFw3ERqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793996232; x=1794601032;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=t/LnSPC6fpnrEg+TCQQ4VnydgPC+z1Ub0P7Txn3YaKk=;
 b=wj+VZc3D49Q69jFNVgmkPRuF2g+0q43/piaWI9XZQKNI+6u9zfvpK3VLJWziW5rJfC
 tnIBe4C16Murncua0nOLXLpbsD5ECddeJv1tp+r6xp8PiC3QTqYn4giZMHx48M2uEGed
 ZokV8WSeTTcMp0StnuYrMKFeENtX7vJ7UQb6yvOTGWJDemwIYlzjeb/4JvGk9l8JHSad
 8IIuIe/8zE2Q+l32yxCH2LdLYEb52GxP/Myr/K282eIcQcATJAvIyILTjRZPEgDZM2kp
 VnEvZ5PnYsctYgrptXm3KzfzlaPiYFlwYpxu68KiBchjgBYIj7J5gRK2yBu/cfgCDJXu
 YC4Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBx0QXP4C8QWcS9x/8VN2Eu2soqw8Sq0SyqYh3Dw3bJXJoCCbhgWh1NTChQddZFSpLaiYBL6QBw=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/lZcY8BdcQOG3I3Jug2VTHGU7JuEbHBHYfnpquauStIB6m9Qw+
 rBXBwB2NMNm27V8OhjYfnqNpCZ2DGKmdEPYtXzO3Ep6VtRlXwp0GkM50vCw1UIEq0sI=
X-Gm-Gg: AYBFou0xRCQFe4eFhrDlF1R6DnFMksJZW34kU16BaAT7ZhWzOtw+2BzLGfWzBwF9K1L
 7RCQyHapX3rHrp+dhG2z9DVPod7ZafkZT09pGGOc2W9xNGZQOxVyCmr5xewyg3lTa+ro919A7Qn
 6KrTNs6SuEAa7H0rgyh74POHcqeyuF3jYkMCozasOJ6rKJ7XOl/DTQABLhvjLh7xOvBZBjWVaFm
 BpZcnaQTI46TTTn8Dm0ignxAruaNrF6mvwpC0XfFr/4tsNtaNk5O+kAYl7E0/lUxAT5usZ2JQXU
 NZM1clQOym0WtUcHrBvGDkBHFC6jA5KpDbjQDZhYwDkhKZhnEWHkJx6oMxoEDpLeoYUYC6hsvgl
 1OxklXs/1RMWXJeBs9hlCEGo2JW/mxGqdEtPIqk4Ebg5/mkrY7rzJ4envhkCdkAGpjzbw1uud4W
 5PSNJLem8AYDiHv0Kg9xjAoY7bHiMs3Hyo6gUlVAlWSevDtvfR7zrUd++q8xHu4bNLXBthUuyZD
 P6SwnQhTbkSUunQIQBpJd8PKlqi8vzep/VaiiEFcdE/gVm1s+ix5W00dnc805h0zTuR6jt6Thyb
 +/AoamKWb6a3EJR7Gy2pWd+jFdFP0KOMWkBKMxm5tQ4xWctCu7BL6ga7LJpdkyG+wVwHv6XJncB
 uG3q4+bG5TyS1h/Ww+cpS0G1ih2odYuW1PkRB3mmkZy/fJG4ktjtGt9uThEYgBuUX/d+GAaua0J
 EaFiQigt0B2vTKESwC4nMIlrRu1ONEIiBSUjctcbNYFeo2b7lEK1M=
X-Received: by 2002:a05:6830:310b:b0:85f:31f:7643 with SMTP id
 46e09a7af769-85f1cf3e2c4mr3899710a34.7.1793996232603; 
 Fri, 06 Nov 2026 12:17:12 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85f1dbef224sm2658574a34.12.2026.11.06.12.17.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 12:17:11 -0800 (PST)
Date: Fri, 6 Nov 2026 14:17:09 -0600
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Macpaul Lin <macpaul.lin@mediatek.com>,
 Raymond Mao <raymondmaoca@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 u-boot@lists.u-boot-project.org,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Carlo Caione <ccaione@baylibre.com>,
 Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
Subject: Re: [PATCH v2 1/8] bloblist: limit BLOBLIST_PASSAGE_MANDATORY to
 U-Boot proper
Message-ID: <20261106201709.GD3741582@bill-the-cat>
References: <20261105-mtk-mt8189-tfa-fdt-v2-0-c168a7b4041c@baylibre.com>
 <20261105-mtk-mt8189-tfa-fdt-v2-1-c168a7b4041c@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6HvQ3a6IsYOcqMNH"
Content-Disposition: inline
In-Reply-To: <20261105-mtk-mt8189-tfa-fdt-v2-1-c168a7b4041c@baylibre.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--6HvQ3a6IsYOcqMNH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 05, 2026 at 05:45:23PM -0600, David Lechner wrote:

> Check BLOBLIST_PASSAGE_MANDATORY with CONFIG_IS_ENABLED() so that it only
> applies to U-Boot proper. It is part of the bloblist location choice for
> U-Boot proper, which has no SPL counterpart, but IS_ENABLED() made SPL
> require a devicetree in the incoming bloblist too. SPL uses its own
> devicetree when the bloblist has none, even when U-Boot proper must get
> its devicetree from the bloblist.
>=20
> Without an incoming bloblist, SPL now tries to set up its own one, as it
> does without BLOBLIST_PASSAGE_MANDATORY. This still fails unless
> BLOBLIST_SIZE is set, which defaults to 0 with
> BLOBLIST_PASSAGE_MANDATORY.
>=20
> Fixes: 03a76b1a737f ("bloblist: kconfig for mandatory incoming standard p=
assage")
> Fixes: 179010694b30 ("lib/fdtdec.c: Disallow overriding BLOBLIST_PASSAGE_=
MANDATORY")
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--6HvQ3a6IsYOcqMNH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCau41xQAKCRAr4qD1Cr/k
ChF5AP47DBVoSTF4QgDLmukWWx818TqRtFSRkZ69OQ0nOP/h7wEA+KMpmGO6qgBS
5nxUDlX+iSVbVXS9WMKXGKb/HpOO8Qk=
=1MSq
-----END PGP SIGNATURE-----

--6HvQ3a6IsYOcqMNH--
