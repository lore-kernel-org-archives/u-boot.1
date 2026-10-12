Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3FB9CA9EC5
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 22:32:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8BD22403F0;
	Mon, 12 Oct 2026 22:32:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ynYXan_F_-Uy; Mon, 12 Oct 2026 22:32:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E256640556
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791844344;
	b=CENOImTFRl1fH6nUFxUgTxKs5lZr8v/5pxSBRs/xFTnw2YzOP3T5hiU6Es7RKY4LFAIC
	 V/i5AwDRRibYs3/vKLem+9diAjM+BNavZj8MlQaZfBv4xooqIjA/MM1lqOOtw0SEXWOiW
	 ukIC6aFwW4h/mOVgZy28K3JSmEGI9VZTrPJsHh6+iPCkXnOOd9+gXGr6+6svTfNYWQcsn
	 bNJX/CmC5ljUbShwSFoy4+tkacVjBZmipGTF5jznlnIghh4DPerfSggq4FRp3EzB+9YgY
	 K2xs4QOI8S8Db/+9KWlGoEkKrCqkNw22yRX58qQ7uE/ATBiwvr0Fe8+7+SXEea8u+3A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791844344;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=av3icJWMHG7nOgMUXfzoELfx9ICxqDmHRFdPStghBD0=;
	b=nYqJBuMjw3z9pm/Opc39v42/PUxSJWruyGj22E6bAYb3oEJlWwtfkjoKC1y4rwQjN9GL
	 mBo+FJCV1KHFYHPzZn3DscyTz5V+L4Se4LHJAZHKt74iPfQTulzhugr52mk0ZYLzIlLj9
	 /4+W0b504nEs1tAkwKPOhkwx4M4vVS34UAkBzES7q4KxKdVY7Ssq34KAJx0y+b88cDtXE
	 OGDbq7uUdis3eyohW2mhEO/tfPQWTqvVtyHsbwqFTzeV7jDJI4Bqm3RvxY7TleeYKN+g/
	 6JDxj48/6VXm2Lna7QOKfAql3F4rsTu3fEW9z7zqD0RnDMBuE/D+1puI32HXjc8DkHA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791844344;
	bh=av3icJWMHG7nOgMUXfzoELfx9ICxqDmHRFdPStghBD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CvitNIx59SYA9gzG1ghVyZOq1CNWw/kJS7ncxwyuvFC7F1AtbHcO+BsfGyMl6Fopt
	 VEdNdh2CjQdRSmQs++lJG/sHfSGPrVQYYh3jaGzZSOdRReUtdoprpzuMvKHKN34kf0
	 3MPpxsO6IB6ovX3Ms3AnXytqwWe0T0c38An8KiIfJ3slxj2GixopAW5G7ZMsGqavoI
	 3zL7EDQWpYfr+12w/vg49utNpPnGbMeKyfByEOsao8HRFfK0wnarHrvA0OdwHddFIp
	 LkbmjrCej+CXu5P5vCJIb5AU0YxTWoUDvZ/BOeO095PQhhTJEqd7gqwGEf0Igzi+1Y
	 VNwE1ONwtYd1Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E256640556;
	Mon, 12 Oct 2026 22:32:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D1F21788
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:32:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CFA818087E
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:32:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ziuG8_ja0v3r for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 22:32:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2EF1A8087B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791844342;
 b=X3avFKJrjRSkVOoFk9/yAbLdtKhglUe+rpptNAQwp/d0aw8aKPR+X/HMiIO41nE8eThM
 vIOTxEzn7P7EOxZ/bAMSAnjO+hxsHbyv/ybGzCYYWBo5kKUhFE5PuSpezonaid2dw/Fla
 tnjDdXO1ygWslsPAnjh7ERWt1B1rFxmRtBRcE4ztEpYDhCCIJfxiKuk0dITy5aRbKBK3e
 T4hBhscdgCa3ff0ENWLjiL7eyn3Frc7hbBjunYsLb5NBHYICLLoEoG2gDjFVHs2l+6iK1
 +7PBC+GTy4gPtxK5Iq42vBYwbmv9mBtlQL73m6tLiJyig2OeRn3qNzMDUUpV2uDK6xg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791844342;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=av3icJWMHG7nOgMUXfzoELfx9ICxqDmHRFdPStghBD0=;
 b=i13qPLUikzWsrnx2wjcsrHphqGrZ83w7vGYFkgU3fiPkhQ3pup70j+0+mrsiB/jLSSu7
 wt803wqKqC/Z/FtSuxK9b7R7kN0ohUtPJIzS0tozHJ33bE8rsUPMJC9IXmjyg1NUTbtcN
 9fEbuRgn/9HnhGxoUXimDTlivKAj+N35xr2fB3jFTIeVD71CzcK5heMNF9VDLPxIdTTMy
 j37FtfMCQ9j2S83U8jclYsCfDrWj7oEzGtXM80k5XX7v7/PftYmuIJIvQEGF9I8PJv6XI
 hsjUjzsoLV+s75ABFPZISgoZrqYK212cDiYfu9d91weZ5BUBO1ZAVT7LOcJZwLeiLzw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=bv2PrPMv; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2e; helo=mail-oo1-xc2e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=bv2PrPMv
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2EF1A8087B
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:32:21 +0000 (UTC)
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-6aa9606ddadso1662132eaf.0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 15:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791844341; x=1792449141;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=av3icJWMHG7nOgMUXfzoELfx9ICxqDmHRFdPStghBD0=;
 b=bv2PrPMv8dEds5FJAPE3ikGVLkTkO/qZVLJZ3vAWu7FjyQCY3XlCwgYKqq3Dk7IUeH
 0CKaavcjdDshLQTD7Slehg6qzcCO6+09X16+k+oqNYv629DCctNWoxeOxpo5fBPfJMQP
 JPvBIa2WB+ScvrjB6ytFVkBngSqZgAXHrp5oM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791844341; x=1792449141;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=av3icJWMHG7nOgMUXfzoELfx9ICxqDmHRFdPStghBD0=;
 b=JzA0+1C7XUvsUjiBfqMbuamfMTJpzXZ12Ui/cOhRzQJnRCFXb9SsmxTQASpYF2DwZX
 Nr7Zs+3rnFtcBzI4dDb3n5XplNjhcszCg9JgKj1q7m0EWUrMdvmnD989+zrGXPhXXMm4
 zy3AKQgwHTj/YaUBRsW1iugm8fQXbL+aZ1R29LNF6yLqq36oKpAnuk0piphiE+KmdY4K
 qI4onvHO2lill9tG2jfImvpD5/9mKiUzDT/R6uLwV9iZPbTmUcqvEqzsuE9SAMX8CAyv
 +zNFDDNrc5cxr8/qiNBb4dLIRImfs5oIDd8s+H0w+6bFNCwY2sn4wWaVYCuw+hbC9vpK
 5pqw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw0zSgdfWS+vfOR5F3p5q1nM4jFs934pAsAW/FALWQbUUG2qn9srO6RVF+vScXiPfjE/ltI2js=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ9aUR3rFheMlZJVP4AnNoofUG2dSUfZ6MsmuDIQbBB82QDR7I8
 EP24gwM+RAyVALObniUtCwDTXIeaH63zAQm46X5jgmXlSqVnpmzcPxBe1VVA8GFID1Q=
X-Gm-Gg: AYBFou1qF9OCQCGYqaJGGsOQuqkO8BkZphw8Xn9Ik3sBsqAQAKI3ZebPcqx/GuLGSJc
 6JAqva/P1+lO15gd6EqJuSTtRB02MPwFeyMCpjpYwiPYKP17uwzA2mMOhbgHK1+TrnPVRor724l
 qbMPQZauBn26WYk8UxDOnv8BLwD3Y58CZQ8Mf66lMaEWwQqHosqtG9kia9TLvoQZzs9jQCkTWJo
 SmsTM2spsBEldIl2P1JRRT2VIVdkV71e3MY+w6fGIWoIQKlbUFKvOupL35mGcRvIZsVvUNu8d0h
 vCsUJ2y+G5Tgn0KzsjOYc6ts/r67W5yQQN9QY1yNmK+cIwVCk1F3hmpkwpg/U8owzhxgQcQK1jr
 rvEUtzTvcTbAo1Amx/tTRi++fjd/Q38UgI90QGx7AEYCLBWqN6FKCNIwUCge0564SOnZQghuL88
 rR2CClYIn8RdqL+tvNX1zP5iK0Mt8jaB51DWyoRMueiaJLk1ZgcMykzQi+r6/L/v9scfCUzegxC
 LwUsIjz9IDCzb09HLYS5EFqh3y/mnunIgHFRRFQSax+INtCe1xLFh6Ie3KS0fbN6aI3KGHTQgzD
 Q0F3oBk94V3MjFXMIXA=
X-Received: by 2002:a05:6820:1992:b0:6e0:84b2:edb8 with SMTP id
 006d021491bc7-6ef08c7c614mr8570720eaf.1.1791844340892; 
 Mon, 12 Oct 2026 15:32:20 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a2a86317a5sm10523087fac.17.2026.10.12.15.32.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 15:32:20 -0700 (PDT)
Date: Mon, 12 Oct 2026 16:32:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Huang Jianan <jnhuang95@gmail.com>,
 Daniel Munic <v-dmunic@microsoft.com>,
 Tony Dinh <mibodhi@gmail.com>, Alexey Charkov <alchark@flipper.net>,
 Vincent Jardin <vjardin@free.fr>, joaomarcos.costa@bootlin.com,
 Aristo Chen <aristo.chen@canonical.com>,
 u-boot@lists.u-boot-project.org, linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH 4/9] fs: ext4: don't read time fields in XPL
Message-ID: <20261012223218.GM3722450@bill-the-cat>
References: <20261012140048.214059-1-heinrich.schuchardt@canonical.com>
 <20261012140048.214059-5-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2M7mKRdgJ7wnBF9B"
Content-Disposition: inline
In-Reply-To: <20261012140048.214059-5-heinrich.schuchardt@canonical.com>
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


--2M7mKRdgJ7wnBF9B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 04:00:43PM +0200, Heinrich Schuchardt wrote:

> The ext4 readdir implementation populates dent time fields in XML
> builds though that information is never used.

Typo, XPL, and should probably be xPL.

--=20
Tom

--2M7mKRdgJ7wnBF9B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCas1f8QAKCRAr4qD1Cr/k
Cp90AQDTqCEQHy+W+jAorhDb7O7dex0m4AOk1ivjTK0G0//q0gD+KwZRrLBIauh1
fpksNoTFvgtk0geoBQTBnjJlv4xPcgE=
=JeeW
-----END PGP SIGNATURE-----

--2M7mKRdgJ7wnBF9B--
