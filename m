Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF77C61DD6
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 16:22:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8770E80EE6;
	Wed,  2 Sep 2026 16:22:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PwIMp16RI3NV; Wed,  2 Sep 2026 16:22:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788366163;
	bh=cF6x8p3P4xju9/1tW7Jwsx0AEYNw3F3eGKEqKeNashU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QeuKMggOm1+9/G2+4D81ZVjzNBkqadHtHkC/swgFjsxKV5ToKMCLie36o5SHyL/oc
	 68h0K1OuT5cnWC+/uPE0FEz2uQFz0IDl0VoRLcLTi4ERWyddgWEPCfxsEM6S2jox9P
	 9edo8fe6oK2b9lZLRtNuMRd7gWdZ+b0xZnt0k7cN1Mr4tA2YbuH3W1MNFf2mjiiMCu
	 TVvPxgQT4REZyXTFcS2DPY6hGOyQ3aAIlOJbqBFDl1y6bITGGmmEAYcPebjHGYGlvI
	 salDDN7/v1kzSZCvGQCwDtq5i4iqPtShZjSb1B4swgbOYlsbv8TimM7x+JCDlf6uh3
	 Ig5mVt2yc2xug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A5AB780D07;
	Wed,  2 Sep 2026 16:22:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 391D72FE
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 16:22:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1F656606E0
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 16:22:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M-ZSHOJ2qFvU for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 16:22:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2b; helo=mail-oo1-xc2b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=FsakOxnp
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EEEBB60726
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 16:22:37 +0000 (UTC)
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-6b0496f4bbcso826546eaf.0
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 09:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788366156; x=1788970956;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cF6x8p3P4xju9/1tW7Jwsx0AEYNw3F3eGKEqKeNashU=;
 b=FsakOxnppbMUXT+29MaLLd1FnSvb1iNQMn3KE3XEPfZHsIqyL3bawk87GBokLt8fd4
 rcfRiaJpRqY8YCcMSsZdJ2eRBzfpsArPjtClYx6qzOh5oQ5+YyrYOcVNQpxFOe9gr1V+
 j5ksSbMhC2HRfVC9n3L7lBY1ByLofOyDoCuZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788366156; x=1788970956;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cF6x8p3P4xju9/1tW7Jwsx0AEYNw3F3eGKEqKeNashU=;
 b=l4ZslJ+u9pClAED6K1YataFeapxoYtMhIiPfgUNziEZwvnrvdvWz9eiwerYBMccEyv
 iy38yMwGl5gJbOX7ioakeA/CJ5oM4GvS8bnNczNGfaTwj62ztg9d5YP7L+hCW+G9PAso
 UD0bl6l4WA528vH8fsj/mIE1YjAQ18KLhVzvU5PJ+FPO1kjJ3YLQkCH54L4WHZ8QrvqX
 J4ETuuWB66dbsCNagngse+lChRUEdp6YYzMIexx5gfIHCCWwZiWixjIm8GKrKr9ic3ic
 WVxKFB3ycWAh1pQe2eip0215UnV4cSuFUM3vwYYzzKKNAmwRHc5Czl6D1Ap7iVP5uR4+
 C//Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RqVOEJxCto8CgxKM25Q2MT8ZWIHbwsmSdL/Wj1YmpGcm0jircez903WxXrpbZN5jnbxLQZlz8g=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++n2AaL3kbatoHZHQ64GSaYCm/amVn4o4Ls/+tj/3qVZcIaq1vjV
 wuKCBc/YOt2xiLrnJNXR4NWhP5c8DZaB1NORZ0ptoUBbepU70tWKvN4WJLhxfTGgamw=
X-Gm-Gg: AR+sD10Plyz9Hj263Nm40s38yLHAar5MHuyavs7TF1fulEY1b2EPWo4ThqyBjSis2F3
 /zHpx8MhduvLsn1JgnMZVTgmUrqproN137R3tCsLU/D5iymNWJkqt1gzQl7Re+Axs5/rd4LcltU
 JW0b528Mq80OBLfF0KvSaBpCGtNf8SYHCZokA43gW8pM+Bd/upLoTf6n2S6lCYZIgNw3OEoHt1f
 uyGEVecG9tC+uNWDSzIf5itdm4GLqKSPVqfli1iH4QalpNt/JE+RWlgndXvLhQ4oqTXgZlsEyL+
 q+DX1aIFRr1fXxfuNeYfgXogcaSkTiiAiO6hVWsEvLiCsPJw1wPebGfFsBsJxTu8KFnwa1BSvns
 zNAw033dfXqRCWZwWzRrKJqXoatusRA6DJX2asSea2o1yig8h3PK6RBtD3ZLb/ovTdMjIn1APMs
 MYKYDS8aTLAFp0bvqTsiGQmkMPzKn1ppacFKxmZFSMGYcJJiErt3Z0AMjS+cP0mh8v+tsqcIuvD
 ButLSxzIMwSvw/VscUpF6tD50L2rHparOyCy9YUQZIqsS2QnzzCigw2U/PINw3U60a+NLlXDCzz
 5Zx5da7Oqw==
X-Received: by 2002:a05:6820:1c95:b0:6b3:6bc7:2ea7 with SMTP id
 006d021491bc7-6b47bcc345fmr3529464eaf.7.1788366156399; 
 Wed, 02 Sep 2026 09:22:36 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-46f30c9fed6sm4290924fac.7.2026.09.02.09.22.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 09:22:35 -0700 (PDT)
Date: Wed, 2 Sep 2026 10:22:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Sumit Garg <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>,
 Wayen Yan <win847@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, Julien Stephan <jstephan@baylibre.com>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2 03/16] dt-bindings: clock: airoha: Document support
 for AN7583 clock
Message-ID: <20260902162233.GA1764417@bill-the-cat>
References: <20260902085311.1550804-1-mikhail.kshevetskiy@iopsys.eu>
 <20260902085311.1550804-4-mikhail.kshevetskiy@iopsys.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="M194Bo5NofHUjugj"
Content-Disposition: inline
In-Reply-To: <20260902085311.1550804-4-mikhail.kshevetskiy@iopsys.eu>
X-Clacks-Overhead: GNU Terry Pratchett
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


--M194Bo5NofHUjugj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 02, 2026 at 11:52:58AM +0300, Mikhail Kshevetskiy wrote:

> From: Christian Marangi <ansuelsmth@gmail.com>
>=20
> Document support for Airoha AN7583 clock. This is based on the EN7523
> clock schema with the new requirement of the "airoha,chip-scu"
> (previously optional for EN7581).
>=20
> Add additional binding for additional clock and reset lines.
>=20
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  dts/upstream/include/dt-bindings/clock/en7523-clk.h | 3 +++
>  1 file changed, 3 insertions(+)

This does not follow the format of a tools/update-subtree.sh done
cherry-pick from upstream, which is the only way we allow changes to
dts/upstream/ to happen. Please re-do this and any other changes to
dts/upstream/, thanks.

--=20
Tom

--M194Bo5NofHUjugj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaphNRQAKCRAr4qD1Cr/k
CgkLAQDuedk/vb+rpErPY3J941f0apKdPWupATC6RkqaMzhLTgD5AX0uLICF4L3d
BdBIaTstHN0qjtsjbfW4NSmmz8bfSQg=
=ODY8
-----END PGP SIGNATURE-----

--M194Bo5NofHUjugj--
