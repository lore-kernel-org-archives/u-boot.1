Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A3D606A319
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 04:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MbkolLV3;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Bkj9m72n
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D87F18125F;
	Fri, 23 Oct 2026 04:59:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xiWyzW8ajtNm; Fri, 23 Oct 2026 04:59:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1B65080E2D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792731556;
	b=PByVFPS7AORVLD/VHzAET+lSEQ0B1mVe5oc2CaJwOtszODnU55fRPXPQr6CtDAB9z3Vl
	 NxSo9VtmwBqEVp5Y0B5eqJiN4dx+BNPrr02nkNePeQdAjnb05EqgVwOuzk6XDK/ChnKcv
	 Dxucc59k3o0dyse6x9EsA4NUqjSW+tYFZWnO7jisT9Gc7heg+K3dUucRUeudvx/Gzj0II
	 HxuCeBVyZ7pFEwaqT7q1X8s6Pju2hBiNcpLTSAn7ab8YxWltim8FeOtb1rasTM9EKII+K
	 r1rY4WW0bryB4Xc6wruRE0/Np9ELwkAG+qIlUCE7BgTJXqu3Id52SyVJ9MooI27xoZA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792731556;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:
	 In-Reply-To:References:MIME-Version:Date:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=MnV2xSXtm/+uLGBuQcVieBHD2OR1b78Ie5GQcBBHmlM=;
	b=R1lAE71cg7KfEVWsyrbX0G84OG1/gYr5pWUAcMzKtdbMsK4bE7YOsT+ffIzyocn7Puyz
	 Fjm70j0c1n2aKOJVHrHAuym/ZeEXUbGvOB48rBvvp4S4uW82DF32j1GEvYEbxjZsdtidX
	 /R4EvYqbPjZtvFINcm4rpqzHkc/3+iHQPFe4p0I/N/gARvSglZ6H7pMd/FlFwrNK1BVuU
	 gE2SvwxGyvs8GLas3aMyKGDHTFBHG1Nz1kn8IBviuBvAZNf9RfVT7TuK/w1pRFUQYy6zx
	 uFOhJeRabfy6h3lgmBvAYsws7K86U6WfhjbFpn6igmCHXMsp/KBXbTmp0oNVarSV/dw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792731556;
	bh=MnV2xSXtm/+uLGBuQcVieBHD2OR1b78Ie5GQcBBHmlM=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MbkolLV3Ufaig7HB2UANHqYTnfJJeKrnrP3mBegGJcrIS25ke8Jb1PmCUn2Y1THn1
	 LxCjxiuAOYjJubea+IkQKz1oRaCzJAse96lMx5pxCPGSA91QGuWYd8kRFDMm2Ty5eS
	 RUuCm6Yr2o93OKXx7VbhbUrHmDGqPFZNvwqiB0c6CGZDS8XoSHrUKX8TR1zYHEzVvh
	 8vJP0+KcLEfYItPSRD5f2Nogpao8huxngJvOj9V41hF58PxEU3ngMyHHgic7hYrsTi
	 SW3p6tNM9c1DhvGemyTX0OovQmTiGaBAgC3P1oyM/FrC2Hu/rbjKp4u7tTw0PokTC4
	 dsPDwRb5f5ovg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1B65080E2D;
	Fri, 23 Oct 2026 04:59:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0253C3C1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 00:43:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DC814409A1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 00:43:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IzZrJY2t8T9L for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 00:43:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1A1A4409A5
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::229"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792716182;
 b=J3oC3Fj6WJdzx8icsxXJbnZ44PEAPVEuJjqXpMBKhHhppY5/wkuCSHUWDtMunxVvzNFE
 2w++Ax/Wn3nFmAAhtBV8OKTmfqil9ljZXiXdEW5q1w7wKAfmDcjR4TGcW4RxHfTmPDmyo
 DXQ7y18kxPGAQdW+vs9GMkj9/1TQ/5dsX5M5WQnF6mzlsxTQpNEsY0kNFMo21EFKWI+9X
 zBjYyp3RLX7mNiBchf+OCtVQCgnQhEhz5pLlC9O0EMUMFw+erOgRrDqHxRhQpUxPHmGlh
 9PDInwZPDZ2VrEWIHz6ze7b6vFGL2SMUjIJkomjT8CPiwpTSl1v7YVRhMfxUfKndXkA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792716182;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=MnV2xSXtm/+uLGBuQcVieBHD2OR1b78Ie5GQcBBHmlM=;
 b=Qq5mSY8MsAnbMr24bMMgGwGncB5N+HYu+BvRJUbUhb0gdV01tmvYaXBdtLZ6eUUe578j
 GNn68wK8BL5tDokKyLg6qSg+b2qhKAXNDOZrrDQPSUQqtmJjMuLN0SNgIfWYupxdYiD6h
 A4VYn0jbMrgSTbERW2nk17md1IrJd4mY83efLjoDKWxV6soDgiNaynPXBAkgUq3YIe92Q
 IgAqDTsdDkGe7C+sc5f6UyKe6tdSyr18MP2kMmAkHqfhHAlIpkv0gKzgO1L0rwtnHE8JR
 He0FQDF7RQvcGL7TK5I10yYRCLmPG3OpF67P2R9synzc35cp0yQthqtjfaOL0fcdKag==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Bkj9m72n; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::229"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::229; helo=mail-oi1-x229.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Bkj9m72n
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1A1A4409A5
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 00:43:01 +0000 (UTC)
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-53c156ba662so252385b6e.1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 17:43:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792716180; cv=none;
 d=google.com; s=arc-20260327;
 b=EDisI+YB9mvop38IpGnxkW8zkwv0qNr+IvaUBgWkjqE5uaS+xLM3kOz1mdypnPqIDF
 AA2/xGdYVzUr8uIxNXaxq2Q+o3CG+G6W07JfUTbFFTdNPUwBDTZ0zhBgU+mbOstY70gO
 cbpH5YYXnalLsovCJ6m2TwAFdfvogIoO6poxWCfP4M99ZRCz7gI2mA42ldla1h/ynU/V
 vv9V9ZIQ4WG/ZMhgwjeWwpdSiMWCLcXHfrmy+MJ8M+VfevtBkOzrgziZvNoo637Bae5p
 qFRdqTehiwh2LjVaP3nUSDmFdan2rNP6rLT2nv1UNdS+KJ01+NMoNxnmtXnTzeaYrIax
 Kcnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=MnV2xSXtm/+uLGBuQcVieBHD2OR1b78Ie5GQcBBHmlM=;
 fh=PcmB4j5x0wiSUV7ifyrGERuvkr4nnrfaFaHaIwRAt0s=;
 b=lKmrXgfOqUWHZTpOlHxmN97B5Advk54VmE02xpgp1mj+p69ObycUgucZhkYkyIdvCH
 eRFN1pIRTn/5TdfWCUmjM9g3L49HfDfzRMAgTFH6HSlCltfXXwZmnhXDo24PrQgtN5go
 aG69BpH8cTFuu4fjzitGt4BQTkPKvrzsc0+k4NYcZorOM2/TKYmPgbQbEJac6qLVLFkj
 hCKbnLzJXwfp5KMlKCVyE63BovvfOXHOVcvKKtpNJf1szNLC4Bl6qBmUR6nd49WXJi/X
 jCIIxBP2pAVWuTIofw+Z7MPms7uQzPe/+2iwGm1w1H5Ejwrg7T3zSRg1YvGcE68zBWOx
 gs9Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792716180; x=1793320980;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MnV2xSXtm/+uLGBuQcVieBHD2OR1b78Ie5GQcBBHmlM=;
 b=Bkj9m72n9K8QTaen+y67YY1SAncKGDg9nyTSb700VZLH7A1FIy8ywtM/LE+Ih+9XIn
 strZADWhcjXmWmGrDSpf61FJSHLL/8LduEeV6yoYDu5tmQ9OEIvuj34Qb7mDxdabjrCV
 oL9wPmn9TGIMUhoRdxF67KdA5a0EgXOtfxUqyRcdHvRRzjZY8ejybn8VpS6vIW9vtSs+
 DzPI4MePXRxf8ZKde62zw5q+OxzTHMazgG0gsnBV+h+Ce6aa+xQxuqo9cWnBvclIpZW3
 SaFcV7Ujpp3nYb7o0//8fTApiWBoes8OO+Um9a3IpFvRM4fSkFWqoswfNexR0pBu5Ouj
 PDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792716180; x=1793320980;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MnV2xSXtm/+uLGBuQcVieBHD2OR1b78Ie5GQcBBHmlM=;
 b=0AKKgX0+UbJiqn25H0zhjKrLRiEX+3kkCmZFQ7+TU6g+SGSLkGnaJEFGpspWX4Dssa
 ssRRK4aPYGvPu2kwE04iwVzUwzNZ1A4jWLUju023dJC6Dw8Ty1UIlVt3Sf9pByWgdOPl
 O+OckwN11t2t5Lc2erHjWZFQLhaYogJ69FDNuliVpr3GzAoPF7f1fNvVf0fs/tnxATDF
 j1y+/5PGYl037h7xUDnIO3BGd6XICaxZUy/B1SvMS05ItLoyalvFioJauG2jlkeEkQF6
 Ny0wL9ENaeDKhy841Wlg9CS1SeGZcGn4/PqPI+mSAns6Xhq7ML0/1+LR4UMIa8JRVkKd
 eKfA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwy2O1qcSjw9bEF1K/zYqduHyUuhFYKEqEtddKbkTyS88JGJoygYcvZa6hvswAipUbRPGlgx2Y=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ9W6aVJhbdlyia6FkYw+o7LdTs2A95i75mHEjrzATqAR6rltev
 Wv/Ew+mY1zYE1aG1OvH22MWO/8Gr1W186MKIDoi4986Q5qPgLO45Nso7SLuvdfTMYabGnTc+W+e
 3EXNmYR4aZlK/Fq19k4qSCQDDv/VMo4EtcGQ2
X-Gm-Gg: AYBFou1DG73pklM5hdVO5upxLr41ueijjmqXJWOKbqWbgk+PHCVfQ+e/E+M65jIZhnS
 SKg78Q2XJJDdqvnsJ+pC5gfhq3KDLDreLI+IYLrFyWXE4zxcAXoodkOtOK9+enJlp9gLS1iVmmO
 1e4WOddBL4/BBX+EEhWincAsedp4XyMncVvRN+Wqb8OCxuLM/UNO2lbxFMQtTXDqNZSgCdkifae
 inMw5FN1m+/KyHtJE6S5Oo7/3c/agCr22A2MZsNtyK3RlVcIoWWj5HsyYGeBJIgdk0XVMCN7o8Y
 mwBYFIloIB9h+lH1dPr2TBtMyoxoHZxzDVgoj/uiyJlF27yhSPN/td9D5iKlGYX82Xn7Ntjclld
 LRADkcr2x/FWO9IKQu/IktRk=
X-Received: by 2002:a05:6808:4fd4:b0:4a3:fefb:899b with SMTP id
 5614622812f47-55be7deb759mr532373b6e.7.1792716180611; Thu, 22 Oct 2026
 17:43:00 -0700 (PDT)
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Oct 2026 17:43:00 -0700
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Oct 2026 17:43:00 -0700
From: Ana Bobillo <anabobillo3@gmail.com>
In-Reply-To: <CAJnxHsh9KDHJJFK5Pf3A0JUaNb0bK-hDZxzGpx89xMJ5FiKBLg@mail.gmail.com>
References: <CAJnxHsh9KDHJJFK5Pf3A0JUaNb0bK-hDZxzGpx89xMJ5FiKBLg@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Thu, 22 Oct 2026 17:43:00 -0700
X-Gm-Features: AclHuK90s4MGRiABk35v1RDuQx1keRKD7sksWtIL0t4ELd_l7Y56NUWWrKoskS4
Message-ID: <CAJnxHsjLOrpU3baxdCWYNnJ-3Rz0iLSpnCG8ij92C2eCPaS1dQ@mail.gmail.com>
Subject: [PATCH 1/4] usb: eth: r8152: Check the rx descriptor fits in the
 transfer
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.u-boot-project.org
Content-Type: multipart/mixed; boundary="00000000000020ff7a065e77438f"
X-Mailman-Approved-At: Fri, 23 Oct 2026 04:59:12 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--00000000000020ff7a065e77438f
Content-Type: text/plain; charset="UTF-8"

From: Ana Bobillo <anabobillo3@gmail.com>

--00000000000020ff7a065e77438f
Content-Type: text/plain; charset="utf-8"; name="1.patch"
Content-Disposition: attachment; filename="1.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1c725eead7db3cdb_0.1

cjgxNTJfZXRoX3JlY3YoKSByZWFkcyB0aGUgcnggZGVzY3JpcHRvciBhdCB0aGUgc3RhcnQgb2Yg
d2hhdCBpcyBsZWZ0IG9mCnRoZSB0cmFuc2ZlciB3aXRob3V0IGNoZWNraW5nIHRoYXQgYSB3aG9s
ZSBkZXNjcmlwdG9yIGlzIHRoZXJlLCBhbmQgdGhlbgpib3VuZHMgdGhlIHBhY2tldCBsZW5ndGgg
d2l0aAoKCWlmIChwYWNrZXRfbGVuID4gbGVuIC0gKHNpemVvZihzdHJ1Y3QgcnhfZGVzYykgKyBD
UkNfU0laRSkpCgp3aGljaCBpcyBldmFsdWF0ZWQgaW4gc2l6ZV90OiB3aGVuIGZld2VyIHRoYW4g
MjggYnl0ZXMgYXJlIGxlZnQgaXQgd3JhcHMKYW5kIGxldHMgYW55IHBhY2tldCBsZW5ndGggdGhy
b3VnaCwgaW5jbHVkaW5nIG9uZSB0aGF0IHdyYXBwZWQgaW4gaXRzCnUxNiBiZWNhdXNlIHRoZSBk
ZXNjcmlwdG9yIGdhdmUgYSBsZW5ndGggYmVsb3cgQ1JDX1NJWkUuIEEgc2hvcnQKdHJhbnNmZXIg
ZnJvbSB0aGUgYWRhcHRlciB0aGVuIGhhbmRzIHRoZSBuZXR3b3JrIHN0YWNrIGEgcGFja2V0IHdo
b3NlCnN0YXJ0IGFuZCBsZW5ndGggcnVuIHBhc3QgdGhlIHJlY2VpdmVkIGRhdGEsIGFuZCBwYXN0
IHRoZSBlbmQgb2YgdGhlCjIgS2lCIHJlY2VpdmUgYnVmZmVyLgoKUmVxdWlyZSBhIHdob2xlIGRl
c2NyaXB0b3IgYW5kIENSQyBiZWZvcmUgcmVhZGluZyB0aGUgZGVzY3JpcHRvciwgYW5kCndvcmsg
aW4gaW50IHNvIHRoYXQgbmVpdGhlciBsZW5ndGggY2FuIHdyYXAuCgpTaWduZWQtb2ZmLWJ5OiBB
bmEgQm9iaWxsbyA8YW5hYm9iaWxsbzNAZ21haWwuY29tPgotLS0KIGRyaXZlcnMvdXNiL2V0aC9y
ODE1Mi5jIHwgMTMgKysrKysrKysrLS0tLQogMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygr
KSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9ldGgvcjgxNTIuYyBi
L2RyaXZlcnMvdXNiL2V0aC9yODE1Mi5jCmluZGV4IGUzZjIwZTA4YzMzLi4xOWIzZjBiYzIyYSAx
MDA2NDQKLS0tIGEvZHJpdmVycy91c2IvZXRoL3I4MTUyLmMKKysrIGIvZHJpdmVycy91c2IvZXRo
L3I4MTUyLmMKQEAgLTE0NzEsOSArMTQ3MSw4IEBAIGludCByODE1Ml9ldGhfcmVjdihzdHJ1Y3Qg
dWRldmljZSAqZGV2LCBpbnQgZmxhZ3MsIHVjaGFyICoqcGFja2V0cCkKIAlzdHJ1Y3QgcjgxNTIg
KnRwID0gZGV2X2dldF9wcml2KGRldik7CiAJc3RydWN0IHVldGhfZGF0YSAqdWV0aCA9ICZ0cC0+
dWV0aDsKIAl1aW50OF90ICpwdHI7Ci0JaW50IHJldCwgbGVuOworCWludCByZXQsIGxlbiwgcGFj
a2V0X2xlbjsKIAlzdHJ1Y3QgcnhfZGVzYyAqcnhfZGVzYzsKLQl1MTYgcGFja2V0X2xlbjsKIAog
CWxlbiA9IHVzYl9ldGhlcl9nZXRfcnhfYnl0ZXModWV0aCwgJnB0cik7CiAJZGVidWcoIiVzOiBm
aXJzdCB0cnksIGxlbj0lZFxuIiwgX19mdW5jX18sIGxlbik7CkBAIC0xNDg4LDEyICsxNDg3LDE4
IEBAIGludCByODE1Ml9ldGhfcmVjdihzdHJ1Y3QgdWRldmljZSAqZGV2LCBpbnQgZmxhZ3MsIHVj
aGFyICoqcGFja2V0cCkKIAkJZGVidWcoIiVzOiBzZWNvbmQgdHJ5LCBsZW49JWRcbiIsIF9fZnVu
Y19fLCBsZW4pOwogCX0KIAorCWlmIChsZW4gPCAoaW50KShzaXplb2Yoc3RydWN0IHJ4X2Rlc2Mp
ICsgQ1JDX1NJWkUpKSB7CisJCWRlYnVnKCJSeDogaW5jb21wbGV0ZSBwYWNrZXQ6ICVkXG4iLCBs
ZW4pOworCQlnb3RvIGVycjsKKwl9CisKIAlyeF9kZXNjID0gKHN0cnVjdCByeF9kZXNjICopcHRy
OwogCXBhY2tldF9sZW4gPSBsZTMyX3RvX2NwdShyeF9kZXNjLT5vcHRzMSkgJiBSWF9MRU5fTUFT
SzsKIAlwYWNrZXRfbGVuIC09IENSQ19TSVpFOwogCi0JaWYgKHBhY2tldF9sZW4gPiBsZW4gLSAo
c2l6ZW9mKHN0cnVjdCByeF9kZXNjKSArIENSQ19TSVpFKSkgewotCQlkZWJ1ZygiUng6IHRvbyBs
YXJnZSBwYWNrZXQ6ICVkXG4iLCBwYWNrZXRfbGVuKTsKKwlpZiAocGFja2V0X2xlbiA8IDAgfHwK
KwkgICAgcGFja2V0X2xlbiA+IGxlbiAtIChpbnQpKHNpemVvZihzdHJ1Y3QgcnhfZGVzYykgKyBD
UkNfU0laRSkpIHsKKwkJZGVidWcoIlJ4OiBiYWQgcGFja2V0IGxlbmd0aDogJWRcbiIsIHBhY2tl
dF9sZW4pOwogCQlnb3RvIGVycjsKIAl9CiAK
--00000000000020ff7a065e77438f--
