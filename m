Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B413F606A32A
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 18:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uEQVtLu+;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=rAzBJ/Dj
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 88480407AF;
	Mon, 16 Nov 2026 18:33:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b2siU9YK87VF; Mon, 16 Nov 2026 18:33:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DBA8B40792
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794854006;
	b=qDg7o8+DA1VZem3AOiixRLXaZGCMJwTzJa3QvWAUEPAUzfWZLFO7EPcMWX2BxbUnZ9cL
	 5zXIGsZjwkrPjRIxooUk4xYgGNw3HrtTH7JmMK4utPzii30EStxOsD6kpNzexZk0K9tGY
	 BO1kZmjWtv/838DBnoYD1YVgiDwGL6yCOm4G8QaiLF/GEpDfOcYxQbk+5eGF0l/v5HIVc
	 iwxEK9Vx79jCBlw2PKVIyWvsONl2UIaQZJiRTaunfv70st8RSwhhdRHTbUztibI26SSHy
	 ENckM7ZdaQu8gdJF3Soomk4Gq/3wR9CVPSQjyCZerKzCRxyUaW60O5BK9ZGNxOo1Vig==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794854006;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=FjffQ9VrgwNE9U+b2dAKqD8mes2NZyaMbE94PWCu7gM=;
	b=SybXELpvU1VnR3p+/5Ty+x0xyvfszQ50NnPmc3zi8WE478UWhTve2X1nOukbVFrskUD8
	 stCeBX0+1+oqnCMChkigSikCA31rCDZcqQrrox4nTmnTOVqTsOSWQNRrWM50eytsQuKHk
	 cn+xuWC0/QtAXoCUaqP1BSYCjXa9XGkaCgsbGuPL0/ln+pcDcNh+k+Im5p3v6v09/s9C4
	 XG5IT8AGNjURZJ/BGhQO/GNQRjmEjQOmMsrShrbUfD3ORJlzn6aYDZZ0kTMVRdRq2Wdg8
	 XO2AZ6FljeDDLxu1wPwdlvIL4T1dEceKUH7HsqSN5eMS+ScnCIYXjhN4drvw//XyX5w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b="rAzBJ/Dj";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794854006;
	bh=FjffQ9VrgwNE9U+b2dAKqD8mes2NZyaMbE94PWCu7gM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uEQVtLu+yvmMFLwZmxDD2jciMC9I+rrok3HPN9iT/C+CLYBHVoVW8PP+YJDImE0r2
	 FlY6roCo8aIdgHGcrF3UKr29AalZ7/X49h9kUlrWwzOriaoQXjSmWsokAR/H4Idvot
	 Fhmu6waRgQ50Olzc22/jknc/FNKJWt20L7SJB8mcagrxjK4tBXyB1ah4EbW9L8J3b2
	 AGOwaglR1wHxK56Xt8CPtniWENNo6NRYvb1XaLX5LJvwk5RA8qL+AyVbkMxEg34w29
	 36q+JAHqIkr4aGURVIcCsiWr9vHQr9iEfsJ1yJ/NPOY29dhVVO5BQiR7ksFGT2tINM
	 F5XcXKZzg0YkQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DBA8B40792;
	Mon, 16 Nov 2026 18:33:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 43AB2176
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 18:33:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 29ABC4078E
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 18:33:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X8DtmdtRBxaN for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 18:33:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 62B8840785
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c34"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c34; helo=mail-oo1-xc34.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=rAzBJ/Dj
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 62B8840785
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 18:33:23 +0000 (UTC)
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-6ddef424972so4133679eaf.3
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794854002; x=1795458802;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FjffQ9VrgwNE9U+b2dAKqD8mes2NZyaMbE94PWCu7gM=;
 b=rAzBJ/DjsaQCpAYci7bsUcDo0ziSl4oftuFfftpBc0VWOEN7iZwFX8oxFOmBYU7dbW
 1HO+6PEyTvR1nqOSA+6b2Y9yo9Y3L/cWM4Rm3PpLE1QVsX5SvmiXT88LSecQ7/jh6IT1
 x5f+tMVKqdKbl+O6y0KxQ+TseZoO29FB+hQ8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794854002; x=1795458802;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FjffQ9VrgwNE9U+b2dAKqD8mes2NZyaMbE94PWCu7gM=;
 b=KVNRwajZYPnnfMC8FC1NkMLbvA5Cm1yw4DHyXtrvXffZQDvsTAl6qpRJNbtyghMrkt
 KRQBwz1ZdKS4OHEgd9Wl3TqSwZPSPFf6Zfc9YPfSZSxvN2RObc9i0hw+3sw/iF9y15iy
 Fqgp8LNw1AnoGwC65nWaPbvoNH56l51uGdPXJUZzxltCJ38p9YieV7HCbOWnuBUMu2HU
 /aav5i9AU///eLVvDIpbII/DFCQS80IG54yj1Xm6p1ODSb1tOfjOVmGZhKensH/7A9+G
 2GU1o6LdBuUt7+yTuf2GggfK2b4xDqyHERjuQQLTheHOK7nQcY9sv6XsYtZSNpsKz19J
 p31A==
X-Gm-Message-State: APuU4Z93YXnAXF+yckdmp+FFZxIF0RFGjer8LqeUe63/6fKy6CMa1hFT
 sqhPTUnEEu1sl4rNhxYiyWxNtIpBozQ7Wc/uS4BgGOTAwUb8kq2obseQlJVqFfXKrY4=
X-Gm-Gg: AYBFou3faiUPClgutv6RDLLeof/mFryQqOuQJUAoiGrJygAFdYuiauJkf7qu0RypfwU
 smeZoCVT9EkHzzN70qKQ+aVW+ubfzTDaozg7TlI1/ldlEEIIY5Mu6gpb7uEiaqO6gRCIAFxDK3Q
 NEzwof+rdkUz9zjCiPBa7Rpq9nozpIt+DwIjkdRkmp1Ber3fL/E9nobjgepalSK5C1n+cbZwDcm
 H8X6p5gZRX+jyMQSAs4rNKKpSlUGVabxUB4IepTVm1Vw5L56zkrmUpRIwKJE+yBBPzxAwR3fyBN
 jjISf9Y7X4+RkdC1Sfihvm2PjelyT3q9KoaRAdk78++7hlgK3to2GRU7EuYcmk2Mf+tvoAAIAAJ
 b05en7MpAiBVY3lls0NcrIfDPu+7Ci+yr5bFrLl1mtH40Wu+QL/wJaoZCYc447CxoitjdCFY7pq
 iaPwSucDHutPjzyBkmTuMh6oh0gdq9egErreCt9bAZnVZ81TOb4dOtMdtWIjfe64dBxuDig6Pwn
 uMZikP889XGay64lUYkOW4cWz7yTr8L17MBCyST/OVbmOpmJD+sHHKscAD7FD72TGHBu042aXC9
 5t1oHaLEAGzQ0H0+9DwhUtmzvb/pA2fklfACwTdSMmdbypmaH7h8nMjh8fMa47DSLR3LQRMHoG2
 Z8Ej8qrt2N9yy4NQ/pT0GCJiNJqzqw2KLilBrff3lxsB+50cc+CfCh/lTxpxWSK8yuOG0BhSWIk
 y4Kf4AgW8SAzQjCEwSy8KxClkBj/1xsuw=
X-Received: by 2002:a05:6820:350c:20b0:71a:eef9:f9d2 with SMTP id
 006d021491bc7-71aeef9fa86mr2177829eaf.31.1794854002041; 
 Mon, 16 Nov 2026 10:33:22 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-86287f0e257sm11137478a34.1.2026.11.16.10.33.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 10:33:21 -0800 (PST)
Date: Mon, 16 Nov 2026 12:33:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Denis Mukhin <dmukhin@ford.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Alexey Charkov <alchark@flipper.net>,
 Carlo Caione <ccaione@baylibre.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 Fiona Klute <fiona.klute@gmx.de>
Subject: Re: [PATCH v5 4/8] env: scsi: Fix ENV_SCSI_HW_PARTITION default
 value type
Message-ID: <20261116183318.GC554944@bill-the-cat>
References: <20261115-type-v5-0-79e76209457b@oss.qualcomm.com>
 <20261115-type-v5-4-79e76209457b@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6zlVpOHZP6965yVg"
Content-Disposition: inline
In-Reply-To: <20261115-type-v5-4-79e76209457b@oss.qualcomm.com>
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


--6zlVpOHZP6965yVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 11:56:06AM +0530, Balaji Selvanathan wrote:

> Change the default value from integer 0 to string "0" to match
> the string type of the configuration option.
>=20
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--6zlVpOHZP6965yVg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavtMbgAKCRAr4qD1Cr/k
CqRlAQDNz3YB7MnJPVNiBMrF8EGhrvqKosleDh/HASlJ/ym85wD/XNL3WoqjECAi
/kmWDL+sJo+SPVvLDg17FOKPbhQiYwM=
=Q+K5
-----END PGP SIGNATURE-----

--6zlVpOHZP6965yVg--
