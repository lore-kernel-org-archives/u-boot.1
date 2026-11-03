Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A898606A32C
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 17:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HxXhkmaB;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=EjF4lFjP
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4D88D606CE;
	Tue,  3 Nov 2026 17:20:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WXTSrBp2i7p9; Tue,  3 Nov 2026 17:20:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A0A1060611
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793726444;
	b=HWv2QHZHx7WJjtfPqzKCmVR9zWswSEHr7XXi0dg/C2tlfBWfwcd8jB3uVPiyltK9MKza
	 EewVNFGqm/wsQImoancCzF4qk61NZrPbt/rH3oyrWfQXb8YYvW6HfeY01zbAWOvznvXtJ
	 yW2KwcDDr/SspdviAEr+F0VNXIWRhT9NEu+W4U7F/e2xnd2o133vcWNIULnj6d6d8QdVx
	 g/9OCWWwGeKMkOs/Z2tHCmRQ96WNbDMFHS+ugQ+mD/N/FIF9V94VIXRWaUzLXBGNXPL9m
	 Io3mDHnjeRXONLUbnfhq4ViOTchtF4XgKN3CWgvTckYcyzbt5l1IIrWo08eq/BFj7cg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793726444;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Disposition:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=pt6rI8sRM8gk1+b1aMpkPiTBB9R/4dUndhERZ8M0jCE=;
	b=TU5P1mNJFYtHKxP2FSb2VTG4TrmnQTIQJyT59tYkBe2j/DtTMLzB6np5qj+mT920JA7A
	 5abmQlCyCMiTtEKtkSnIx5Weo7mizUr5sEI+/ak7BryDql1Y3/jUm2YKaeJCCr64YG57L
	 TtD7ZNjey78SGkriZUqQNzgmZx7h3NwYch2VWT9kam0pTm4CowJeZyL5qUTgE0enS/iDR
	 gHKAogk/78epJY4nXwl5FAL+OgVrOflz9aAHll+R88WLNGxcGe7v1a6AlatWsS90KhBI0
	 B6Jzzz6+WkMqmPW303sHe0h7teAPkO2ii1opolDTAfkFNAw/NO+h5/l9KY/JFPVogBw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793726444;
	bh=pt6rI8sRM8gk1+b1aMpkPiTBB9R/4dUndhERZ8M0jCE=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HxXhkmaBblBzjGBUzoR35ppP7uDq7NylUTlmJYufKu+QJTXWdYBiib05VMOgmUkXP
	 dQZeTgRDIo6wCLjwa148MZP8DwNi99UwP8cbQNIhoaIX7xCku/HSWGqhzpxjHK9wUI
	 vFBJ/anWlZ3gP0XyOf2LERqJBeNn4tCIOaAR18/gem73HT5sQRpwsK7Pjud0PEKD9i
	 BATz3FnktI3r/D5aXfZUUQ+dzBov4VdLV+6bIe/Q5ujrhj33h7NmSyBANhSVy6CudX
	 zgOfqdjGpveRzLEJbRrWWMp5M3zJ2+/1weTJkocr3elMKR1a32bST5ChkO7KKEv8rc
	 Y4VaSgOJVtHdA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A0A1060611;
	Tue,  3 Nov 2026 17:20:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id AE0DA2AC
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 17:20:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9E2D680CA6
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 17:20:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cMAY5wNE0vJr for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 17:20:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E0FA580C9C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::36"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793726443;
 b=tYtgRl5PT646yt9ql6PV+Isq2/R28iXH/o/FzYBH0ocpHSJnHX3ZLoXSd/hvuLEzqHG0
 Wmor46WREaWRf0fzEKmNK99O9MTWYdeq+55b/7SfJpNoXKmYOHbXNzBH9u8BCCuBOtzIf
 Ct1gn2SeQlb4feVgSXEEu6tKdQhZkNS10xJjs4kLBsriuF/fpnXOt4DeDa9nf16LASpVX
 YvPvnmImMOQVSrgD3JptBuJdBw+lNfYfG9Sqi1rvyvFrpDjHdw6dxBxlrXjcAA+gwsE0x
 B8PT80HkZcyifYOcCRU16hGPJYGtwj8RyS/Q0Vf9FiEu2U8RkjLTFQfUo2zmSRGmjNg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793726443;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Subject:
 Message-ID:MIME-Version:Content-Type:Content-Disposition:
 X-Clacks-Overhead;
 bh=pt6rI8sRM8gk1+b1aMpkPiTBB9R/4dUndhERZ8M0jCE=;
 b=aCyARfe0DhkqRyLDHL+JBFXYcxxMcL4He4nGfS1+0WxoMSYVw/2eVK4nS5V3ywny6v/u
 iqMSWgpyvwdkHkqyHhuaoeiBKm/QAbCdYKeQOT2WAALhY9KJxwvI1eDS7OteaMuRQZTa5
 qYur2I1kCeMPYe6hPG2cZWfrIRDT82R/RlsUZ7UBSeNSLLjkVz9kt/e7w99X7IV8hyHSv
 8CojYTjqpyMtF2RyyQkQapomsmg2lxX7d+HfYFGtY12HNUgqWis9ZYwVYsJSLvhGZtnL5
 MoXhbzfF8S4EIFdb1MptJcoDNqmK4IDlO4HwcLF+DDw7oDKBl1P1xbMAEzxZzMb75KA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=EjF4lFjP; 
 arc=none smtp.remote-ip="2001:4860:4864:20::36"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::36; helo=mail-oa1-x36.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=EjF4lFjP
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E0FA580C9C
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 17:20:40 +0000 (UTC)
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-48e94879f02so1309292fac.0
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 09:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793726439; x=1794331239;
 darn=lists.u-boot-project.org; 
 h=content-disposition:content-type:mime-version:message-id:subject:to
 :from:date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pt6rI8sRM8gk1+b1aMpkPiTBB9R/4dUndhERZ8M0jCE=;
 b=EjF4lFjPtoQJVF8ZDa0xj5RW4PqMVnC/K82nbta1gtHsme6hVttYOybM8iCu6qMw2m
 snsTn7XQa5K8e8mGjniTxCjZSk2228iUa8KZwD0ylpEM3K/xcUsuT7Eq74KclN56oKco
 eyaHAiIufOhL73JAMPXSjzBYZibGHRPCk3Wag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793726439; x=1794331239;
 h=content-disposition:content-type:mime-version:message-id:subject:to
 :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pt6rI8sRM8gk1+b1aMpkPiTBB9R/4dUndhERZ8M0jCE=;
 b=cHOzfxnXXEZKHiXKSB3INNuRd23tMahoR6qaYlnHFZKZQH9hptIGdr6rI9zyjR0LWp
 hmxBg+Axv9DEjh+5Ob/elOrCkp4f77KVAMGWx+KybsJPYyjMWq+xWhuZW5XRgVS3vdtP
 qZqWzG++btl5zXVexPjgUYrqNH1BP7k9hERyr6ZGtzM7Xcnez0v3GtszO0ABh6Jnkedz
 xweGPpDlZB5swGtmQddm1qU4iBwyNCxFbIP2ZzGnf6BoCKFiSo1WsT/9zeaVXQokwLs9
 lV+W3rH4XvUTLgtozKm/g07Dibjj5HnwlcyGUcoKT2fAYdP1DQK2oowRz9Jq+Fp5uzNT
 8yzg==
X-Gm-Message-State: APuU4Z/dVOYGMLYZTFcPKkNYxlJhC51EYhCdD7wXoN6CHRuJen3Br/1T
 yKyNmEFgDK2dE5yUC/q3UIX3Foh8SWbnD+WOWj949yhhGb6pKgRSrK4L4pBIPGkZFIK0O43kc1W
 WSfa3Y2eqeqaR
X-Gm-Gg: AYBFou3g9Q9bt2ZYPjQxRALRdxU/LOZ7iK+e2nLPYcF28m4outlCrHwUDJMqMYQ8F5p
 X/4uTmbLthwEsqyzZzV5ktmxThukcMzHyF+/JCyoEiRV/ggGjRYdv/s997sjGQhdqR5sutszTeD
 9F4R7fA89+E9hf401kjqQIzEynLM8ozRYJPBAswsJodmzz946bV9aPy+XbC3PlAENSey4VZr+5H
 K5KKOVnukb39bxryWp0UYNZJOPwqRTW+SCe5TFLRUOgmu1xfZZTZa4LEmVapOBjX/RAffux9s8F
 75vpgUCzJ8vbry35l3RPm+514moXTL3Kx4zvMUSIK3qRP7BzzoIVbLaGaJ2uK4Mnx6CpbNK/byJ
 BqqSXind9TigzU76vdaGxBjcjCtdAqEVHkulPR4VFIt46mr5lNm+j6AWtuRGgS0Uaqnw8wNjFAt
 UWx9cqKyFwGmFuOpJjtyJqkAXHquaBWfJTfeAE/X7q9XjB80/+lyewiTQHl6Y7vhY5VK+7c9rI6
 hGEvX/NPSqHGJJeBUvKlXb5DW5nAEvXIWMW9m+7Mkxp9r2bs2urBOCdYF3sK6iI2ud3IQA7Z4uR
 XaYdlxEpQIL9O1+oKQ/pLhhrhilYJxOcUAZs2o5ikInUDPnlDxFgryuT26L/viJ5jr73C+rKT0n
 3fJzHyDWQitmIA8pWgfTXqA2M1LjL3T08Z3RgQmQPogh0rs+C9wx3nFlntv46TclAYP+pbXo4vq
 CrJdadN0oM7hRJ5GPt2NSSJ82h9esiNms=
X-Received: by 2002:a05:6870:36cb:b0:45e:54a3:b8ca with SMTP id
 586e51a60fabf-4a907631834mr8060369fac.19.1793726439282; 
 Tue, 03 Nov 2026 09:20:39 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a921a7dc4bsm9477529fac.16.2026.11.03.09.20.38
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 09:20:38 -0800 (PST)
Date: Tue, 3 Nov 2026 11:20:36 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Subject: [RFH] Writing a project Code of Conduct
Message-ID: <20261103172036.GS3309461@bill-the-cat>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="L09pSkt83CJkDPaF"
Content-Disposition: inline
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--L09pSkt83CJkDPaF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

Getting back on track with project administrative tasks, one thing I
have talked about the project needing for some time is a code of
conduct. In my mind, the best starting point here is, are there code of
conducts in other projects that people use and they feel would be a good
example for us to adopt? Thanks!

--=20
Tom

--L09pSkt83CJkDPaF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauoX3AAKCRAr4qD1Cr/k
CgUsAP9EUbDFk5XyzP4BkeJxAODplvxU7SFzVqrAuOu4y17HQAEAxJD4cOzxJDxG
kbcKhX5B3gbGC4Itx0lruewc3xmtrwg=
=Bfpr
-----END PGP SIGNATURE-----

--L09pSkt83CJkDPaF--
