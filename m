Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0ED0C5DF81
	for <u-boot@archiver.kernel.org>; Sun, 23 Aug 2026 15:12:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 54FD2606B6;
	Sun, 23 Aug 2026 15:12:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yn_fgrFqlqbe; Sun, 23 Aug 2026 15:12:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787497937;
	bh=WBueyLMS70NsYDkZo+In390V5LmxczpV9W4mAJQOurY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YRZ7+QjV1vZqae+hz2szSTcbwoiXpWvSq2jPRkAEPWKHBqPbfOlbvlI2NCPmCgCD7
	 a/wzSY04fkUFNOXR99DOrAoacPs5J4whcI36kUvfzaeFH+h0fRSQIC2+3UY4X3Z3FL
	 GdwjqTzufQUpbcllE6DRzjMnrieQsJqkND/9FWN3Fs9CFdP434gYXj6e0sJlfyEyU4
	 l1ySdVvMN3iDoFmCIeSiwt9bwCzk3IgGscSlmzn1V25xw3x4IH/eDXzpQc/FrIgxkM
	 yY1KfmUVOHa/dU0451Q+QoPsgDpUN9/aIdfjGQvw1VqogPcE2MYWfA0IlJmzAboUO2
	 vl3ygldkMh7+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7ADCE6064C;
	Sun, 23 Aug 2026 15:12:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CDBCA2FD
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 15:12:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BFAA44055F
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 15:12:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DkYyZVoBylTC for <u-boot@lists.u-boot-project.org>;
 Sun, 23 Aug 2026 15:12:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32c; helo=mail-ot1-x32c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=oA4x8zSS
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 156184055E
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 15:12:14 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7ee125ec926so2861298a34.2
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 08:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787497933; x=1788102733;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WBueyLMS70NsYDkZo+In390V5LmxczpV9W4mAJQOurY=;
 b=oA4x8zSSugly7A78Q5kEkToNg0xKOxKCm3tbfVX0esyyI1Tc7Jg8Mo19bsYX+2gzM/
 vZyDeYcKJoN8YjPhM9PJ8yKzdJj4rLYaygqajMKQS3vreIcLO35PyG+u5E2wSbKOg7Zt
 Hu3F1irQLAa57A9NLHd/qrEDwTsbpDxSJAffY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787497933; x=1788102733;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WBueyLMS70NsYDkZo+In390V5LmxczpV9W4mAJQOurY=;
 b=rrnoxv3cY7Pb2PAa5g3WcfX+PwCcwmLGpIG5LbqaQC41skfAU3NlbmE1Pbs/ggs44A
 uvJmSJoJQXPZ68N8jUHmnYsDjmF7FYZs6sp798Twg/vAM07wiZZpYsSVelaVPPObkM17
 LdmmKi/acEeKTsgGs60MxgQsU2E80VDEA2uL8E5mhb3IZ+dCBPZqvHHQhD3R0IcEO/p+
 NbcJkA1vOco3Dtd+7+3KSGkQoRnn1sI9pPowOzS0R5s78i1bVAeuJeIvwNU/j2ZOaZlm
 DW9PHOfWpxCtNfKCu6d6+PJC2fzfg6F9TEhcMMTTnR4qmihljgqEM7VUUU0MpmfyJLY7
 FyPg==
X-Gm-Message-State: AFuF++lS3T+om8o+lEtMNv2X64cvaQQiJBy8x1yxK4fbkQ9okA9AC7hE
 V4oVtKohi/uLlxzNqozOYmq5aBwP6fM8TM2Wl1QeNR+fE64fQ/iQaCLRFrYX3Hr3AcU=
X-Gm-Gg: AR+sD134RLQnnj9mhGZqgRcFYU42rEJJ38Jnhvr+WxgMvBCA1+uWtq4uCdkGh/2yddX
 IlIRRsF32yEB+ZLwKMvYGPgw8NSbalhjh5n52ERcjVLr4wuXflxiDnqgxNMZFZo8158q6yHhNS6
 VLa0+rzpDpopiCWUZaFaQ1Vx9Ajons0Xq/Xxmri4EuPkjxo+Sollc/8LI+24Y4fXW/G0mUYH02J
 Ooo60CFGq5M6NKC+/YVmEpbFXRSLoyD+dbhq48nRspUxjrQ7ZAypm+0bx8iTPxS2QCJR1wFxs8s
 c0Z4hhD8nmNqlxQUIq58/b1jgaKeTf2xCJUMUW1YUZq36ZJ8dGcFGOa7qS6gHjrpd7ebvWbBR9f
 04Q9EyTNXsaJIk48E1jYsXt0d5lSitGjSwdmTgjjx9lSzf2hZqE6fEqMZpBu/SXg6rPq8P5cl3J
 wWU92jyu8L6z/Ls8L2SrQUGhjXL15EMMOidfkDBCL9vKEmJ5h77RI8ziarspUb5Ol23InQ/NCdw
 JK1PL+UBy7ThJiIYtI4J9UI7leCsOBTkMbMLBNKaqj+9O9k50AtoLxnC6hVz41IvROpVhDvn4++
 ylMXVgP43G4=
X-Received: by 2002:a05:6820:615:b0:6a1:80a7:2c8d with SMTP id
 006d021491bc7-6b15944db93mr19720016eaf.32.1787497933612; 
 Sun, 23 Aug 2026 08:12:13 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b17cc0c2f5sm1486441eaf.9.2026.08.23.08.12.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 08:12:12 -0700 (PDT)
Date: Sun, 23 Aug 2026 09:12:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] MAINTAINERS: mmc: Add myself as a reviewer
Message-ID: <20260823151210.GA523975@bill-the-cat>
References: <20260823102633.13128-1-tanmay.kathpalia@altera.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qVG2RAD++tMTDJ7w"
Content-Disposition: inline
In-Reply-To: <20260823102633.13128-1-tanmay.kathpalia@altera.com>
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


--qVG2RAD++tMTDJ7w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 23, 2026 at 03:26:33AM -0700, Tanmay Kathpalia wrote:

> I have been reviewing MMC subsystem patches for the last six months.
> Add myself as a designated reviewer so that I am CC'd on related
> contributions and bug reports, and so I can help improve the subsystem.
>=20
> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--qVG2RAD++tMTDJ7w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaosNygAKCRAr4qD1Cr/k
CmIIAP4lo0DgOnvPYTjUja/hijrtah5++WsyKYkJLN0cwb7RzwD7BVPYILBulvWa
n06duSO+WiZodQ2O4QRmtj4llKt4jws=
=HwAH
-----END PGP SIGNATURE-----

--qVG2RAD++tMTDJ7w--
