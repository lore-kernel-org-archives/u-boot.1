Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF5F606A321
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 16:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PzlVjgGI;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=WrPRzeUH
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D84574072E;
	Thu, 22 Oct 2026 16:50:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ayU4SUG0Q5ck; Thu, 22 Oct 2026 16:50:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3154A406E7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792687809;
	b=E04c5NhlMwkwPj46fNzNRmCUDHxQBUpJBDrgfiJ/rzCNYmKkGGpuqO37gv9XMajstA5s
	 xwQBXYOFPK/W+QBrcNJOO2751GUTBu+wejNLzr3ZxmwGw7XhLGzJIv7q7kYqzbauuhD1T
	 wd5ArtPpcevXEibMVCPDr7ilcg3MAqP3cWqTMgvYyYqdem371XGsox3Lr4XrDvPH/OotA
	 SZIdO3RcopLXxWR6lQ4hTQ5K9/N+kxq/vi33Dj3V9Z20CKvZ/HSP3cteq5iYCjHtXBeuW
	 vN1f0pJvdi/sPEFL9YQHERab+krPvxk8F4pYIL/5YKJVsGE6/w65kdR6A0x6Ke9oMig==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792687809;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Vw3OjzvBXoICbtoMsA6LHLzMC1o2yflUeGVFZWiJ4N4=;
	b=UVK1ky2V+2lluOLN6BC2vKOxNcxq+irbYvzc8oWNACual29Des1hFnpeALLk0YxnH6yg
	 VNuMy8QZgBvbtwwhwf4ecyIqKhXiVkwqXwWG/MnoPCSbA6NnOO0v+EaGnk5qmgRkWFdNu
	 7jamRR5876eQQ478C8prjnXQz/0dy645k7UoVAJgredtQZ1US7hz32DfbttGvpdDQCNK0
	 1QtJc1Br8z4RW2pSj2PlFt6tz3IvpzP8GXEMvdlQuDyY1FN6i4uOcXiZT6EER+OOn6yEh
	 Re4MoMuj+TG8ZQqzBENjwLpszrnR7dfaXb+JEITTUlqV3ZxhWTvLICMugO+wuPmR2og==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=WrPRzeUH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792687809;
	bh=Vw3OjzvBXoICbtoMsA6LHLzMC1o2yflUeGVFZWiJ4N4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PzlVjgGIpdLnrSIFHuDfesWkWPccvce9t2eB58r9mB/Rrh6JihKjZ64IzGtLqFFIG
	 iRzgK1uCEHdiNSPHRimIyeW7UBtgPjtlxWpVIEY0RoiSqZW+ZVZH9p1QS0VgQYh1FK
	 efcLpmkJbII4pBD+oIKP1FjK3VV6dEvFWVUnMHeXKJLOGxKc3PdOqSlBjiDeNu7AH9
	 jvTXcdOV2512owuV05aJu1N2xi2lZRt0Vjlc/teIMpKZZK4o4VsCRUumyeKvrXINXb
	 2n4qjkJe113Y/PDOdeu3tZwi2ykXsmaxwJ6w6WYut6eTMPN3AQDlQXGhS9OVizkN65
	 ZbkiWkZY68/+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3154A406E7;
	Thu, 22 Oct 2026 16:50:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E92C2769
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:50:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CEDC5406E7
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:50:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K7GeI1ENw_Oh for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 16:50:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 22FC6406D8
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792687807;
 b=Mi3mMPRh0Eox+AokqE+oTNA/6bcTxL/FUdaQRYndyMa33ELeYMgN1aHKyssl0mn1HYu0
 kuPpXp/LxqLWcQN4vmtCVseFx6pw7kjP51oxfGiM5GpWi+7l9FpKb16S7Iy1RoNM4s5Ws
 u87/W5+EJnmSHO/taaXrL+ce7pmiK6dpiyndCjn5DM/RBqkxYYFudnBOFnGLhr89X5VTm
 1PdlRGKPs/gVgOd7Tv30zaBz8NcCp3RoDvRCJ496Nah2L3d9Ndnz61FeC9JkX3H+9Syls
 8W3wcyxD837tb36FHN3hFjvRnpIeFCV1RnmGDvnZPusvYDIzzY0eGJT1X9foLE0ucnA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792687807;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=Vw3OjzvBXoICbtoMsA6LHLzMC1o2yflUeGVFZWiJ4N4=;
 b=NrzrCQvepXnICbIT9YKTHWM8gT4ipkhsJWl1LaH3jqnVJW+ijSo9FjPaHFg0whkNYwSn
 x3sRPJcQdjLIj+W2DG6vlNLMzwY8t0uDS3xlTnOe5VW5TmgzZCgL/P/s4LDiODLW5qXcR
 PsN7psxeZKH6xiKc1VzJ21v4Gc6Q/MgqbjmivueSXeSZvLE2Eyfi6y5P7H5lIOhNiJwHe
 Fh+iAw+ELJ/MKtKaB0ifkYewcGZrCzu9ME2iNoGr81xSDa4h+vWnaVVNrr18G6F2U4hXK
 P+YLW1vZzAn7XS+7FwHPVRnIWo+DWoK2qME+dBA5PmyR3csGRMC0tYPuytqcAinWRJQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=WrPRzeUH; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=WrPRzeUH
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 22FC6406D8
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:50:06 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-823e4047037so1610300a34.2
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 09:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792687806; x=1793292606;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Vw3OjzvBXoICbtoMsA6LHLzMC1o2yflUeGVFZWiJ4N4=;
 b=WrPRzeUHdaoTVxJZeDrsm4xBUcIJ72m0z2Olg1aDpHLltbQ8LhdEKicumrecgBRwBm
 GV8I6YblV7v7PTOLXo4lDI1SIoaqg0OK6NklPhYGtub9XK2K+LNd/XPqZSCAFzN0fZ7T
 35IwmKoVwVOEP5dmu7eaWIpFf33zhaKuN9N78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792687806; x=1793292606;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Vw3OjzvBXoICbtoMsA6LHLzMC1o2yflUeGVFZWiJ4N4=;
 b=jMEIHKRdZ00VSb0nFqpAAmFQxvg4UnKrm7wQBBuF0LkleBI+HfaGaXiNO+JGw+diXT
 O1VLfSrOlFQKB4Lp4NazVr1ztB3PSHWC47/VnXXLVNoHNWt6SGJuHfQZ1WSfNKqYdODr
 BYP0cW36LJ2zWy0Qj/PVnZQqzpbBZWulE2m2hyPgtEtRkLLKXrHbj0hgKxFKlqtOYFnV
 suODZQT4t4yrtrk6ldaKBR6I7eXWd5xkP0PpONCOCqVYLSQp2F4qKgI9tNlExF8RB4dz
 h8LGSpPDLTFPb1EhYuvDPzG9EkQmaVlfh9kfmpYxRp1Uc4paZzriWVAjsYul/Qe500Cb
 6QqA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwJ0RR3YRK6Zu8s8DzyfMg0hfWzOR2y84zlLBugAaAuIfmRciCVuQesquPm5Z8LRukE87OwVKI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ1eGR4grUDHtLbQJHd9lLkn+wA6wNMTTV3WcW9ELF0rBe5M2G/
 szoCr74DMntCv/N3HGtB1Hml7VAa4cSCrJMSkoenHq0ggdwVnbGwvg9nRtC4WiiRe1c=
X-Gm-Gg: AYBFou0u1GgF9M9ZmcPyV6xWBtV06iVyYfue1GH6YIctzNjYkD2FwGi9RV2pJJ8pd9X
 TtlMteHqQSG+BZjaIKofOHuW5SjPnn/FraqoA3aMi+LEvrcVnMd5+V3UuZ3PvRd6kI5pbdEDk4w
 Y3ZdczsuCr8vvXB7m+2KNvP9MzUlodswOfhBN0eixscV1rNrkCgghGHWniROJGtF+eO+uVs1wd6
 Vk1ClQFwb7LhMqga683sEVJdZvsSsMYl4ZRlkColT/fksuSlb6KQNCMRlRUzBp8l3roUk1siL/9
 eMUg/C9i2ogdSatOU/1kMjOR2AbETfKSjMUSlwviKHLSUfhfPxoS2/+NLcjkEhHyBo1XbtSN6T+
 fhh8od7qixNIyB/+qGXEPeYwrjCe9U5tlf/mvtzMZhdVkolwqFKnOdxMSIRdXz9QFr8Bq6dxFvZ
 ftsR0PkuLRIng1IpLsXGlldygQ8iZQaAJsOUSLDCP0kVwWjhtLCb5X+i61a2TZc+pYF69WLtIaB
 PHjkAC+nRb7ydAy+2asTMCuPjwpA1ER+cVWfbBox01GpwZRySgG2qE0Ffi2jyzNmR0TZpfxfo8z
 LNGgdkSJWtGzqykxTBNZDHfcXgcWKsbWq18OJAb5EeqhqZmLq5lwlcsJNZ/2vgTeOaHoVksFbRa
 5sA==
X-Received: by 2002:a05:6808:670d:b0:4f5:ebfe:4157 with SMTP id
 5614622812f47-5535e554661mr3850406b6e.44.1792687805200; 
 Thu, 22 Oct 2026 09:50:05 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-552b7176907sm4974066b6e.12.2026.10.22.09.50.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 09:50:04 -0700 (PDT)
Date: Thu, 22 Oct 2026 10:50:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@nabladev.com,
 marek.vasut+usb@mailbox.org, Michael.Srba@seznam.cz,
 william.bright@imd-tec.com, luca.weiss@fairphone.com,
 nikroks@mainlining.org, nathbappai@gmail.com,
 macpaul.lin@mediatek.com, jbx6244@gmail.com, dlechner@baylibre.com,
 balaji.selvanathan@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v4 11/12] board: qualcomm: add MAINTAINERS entries for
 Shikra platforms
Message-ID: <20261022165001.GA3621697@bill-the-cat>
References: <20261021160916.3894471-1-aswin.murugan@oss.qualcomm.com>
 <20261021160916.3894471-12-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FGrsf+XDsPL7r1a/"
Content-Disposition: inline
In-Reply-To: <20261021160916.3894471-12-aswin.murugan@oss.qualcomm.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--FGrsf+XDsPL7r1a/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 09:39:15PM +0530, Aswin Murugan wrote:

> Add MAINTAINERS entries for the Qualcomm Shikra platform
>=20
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
>  board/qualcomm/MAINTAINERS | 5 +++++
>  1 file changed, 5 insertions(+)

This shouldn't be its own patch, it should be in the patch which adds
the board.

--=20
Tom

--FGrsf+XDsPL7r1a/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCato+sgAKCRAr4qD1Cr/k
CneJAP9pf14gEO9Aox9PV2TUekMPjEtnb1f1UFKdjH3LrzjdSgEA9q2HX/iT5QK+
IhNpB2NgCgFP/jBBnOSi/EXhnE766A8=
=L4Q9
-----END PGP SIGNATURE-----

--FGrsf+XDsPL7r1a/--
