Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F06606A322
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 18:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=o5v9w/LB;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Rg7GD6ta
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C1A0E4072E;
	Mon, 16 Nov 2026 18:37:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pHpp-hH7y3Wj; Mon, 16 Nov 2026 18:37:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 143A6406C5
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794854240;
	b=c4YTAyX7a8DiETMtlmp0bybQV8TUWoD6cwVDIWJgY5M0WRyb7Z/vPPnfO9gb12I/E1QN
	 iLiJvWhKDhNYzLyhXBs619rd6KWdVpo9dztcHrdUE6R71ieIyuxUZjCtuYCzOvvk+OboY
	 bIKN5o8SCao2j7XqLQklobUFonU/h8PQUH+X+HU5Q+6X3TlQv2mGF0vY7sgSjWKL4o0Rt
	 HyrQwMPsXC0grQ3nyenNwNmZzQYOJsVN9ZHmpRvdTgrCvnk+1AqLAtWaHTAcsuIFxkyjs
	 TVVkMHr+9r7r9BN+6wAfET05tbLQFHW+mjmE/rTGOWtcDRfwR9XWw3DUWroXBjoIoAg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794854240;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=XD7ruWlsgqgfn/9JwhWDHGtOPo1sm5Tc0DBBVFAzELg=;
	b=rSdVp6JlbPkQ8yF4GpOfSeHX4foETn10BmYjdVwaYMBv29D3DB2VGs9O9c+5mosCz3JD
	 Yh38dYBh2dvy8EA6kAemLwWsFwDOmwuagA5h1SAORkjAc14d7s/Wr23k6qv7xLxU0wm71
	 PJsglxitjhtKafia7SAvht3NH0vlz3VJqtPlgHQ4r3mJieUh1u0jtebHEvXpQQiUvfN3P
	 kgDGdubc3mHpfdD7QKubfbYAJDQg5KuqoaUjWSNi2n6lVIqlroQ8tmTS38fEP/ILNcIIS
	 +1tWi+5K25Ku4NSvOKpiKVmVI6hfembwVnsoA04L9cTTJjWd/VgeMl1AOh2PR5VEBfA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Rg7GD6ta;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794854240;
	bh=XD7ruWlsgqgfn/9JwhWDHGtOPo1sm5Tc0DBBVFAzELg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o5v9w/LBbtY/foVnb6KKdr5LMltGj7JZxiRNlHoPT0jUu6lV6JZmiN3vTne7XuOmp
	 TfrkibUhSWcL3U9BVhRA2VekEDKu/fqZDOJ6d51Eo1csucCRO+2M3UnPr4g7uqNouR
	 0Zp8TxppcDJdKzxvjzEc15EzU/1uycSMQ80+W3q62BFoONsKYHjGCIGoONqeRa+jL7
	 d0quK2Wrm19aq1aiDHgW0Vmy6uDuY3QxW2fzeeHlR2ftGeM4Wtlh5LoEzqEDB33piS
	 IektLlibT/sMGfUiyZQc2La4pehCPrY6WOD+gjhDPn2fyVgBmXSBMmPqnzJ1wisx/t
	 Ht7c8ZDyBxGeA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 143A6406C5;
	Mon, 16 Nov 2026 18:37:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 767B313C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 18:37:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 67B06406C5
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 18:37:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HXmMjZWhanl9 for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 18:37:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 998D1406B9
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c31"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c31; helo=mail-oo1-xc31.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=Rg7GD6ta
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 998D1406B9
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 18:37:18 +0000 (UTC)
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-71ad1db7e31so85706eaf.1
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794854237; x=1795459037;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XD7ruWlsgqgfn/9JwhWDHGtOPo1sm5Tc0DBBVFAzELg=;
 b=Rg7GD6taE/NXkFUPNqKWd9hHL4WqNU4FynS4yTI5LulQ/GcbY7qr4F/qIXbfg34oVu
 6Fo42KYqP2zGfgNlpjDr1cViMNx1Yviyy6lZau7RL8zJWXEiLxKmJbMvwYzZRTDqDojs
 fTK01a9QBRUVumZuA8QiB6iEDNKKCXwWV14Pk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794854237; x=1795459037;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XD7ruWlsgqgfn/9JwhWDHGtOPo1sm5Tc0DBBVFAzELg=;
 b=o70bPwzuQ8k1PYRo6R7IGZHH/lT3EsZxoSuD41/n2k73PyfvMVYrCxNUvYZQ+LNUWF
 Kma3fwsXg8fWmXZNIOsdWsBrrGWNeBuj1RdxRb8usWkGKqUIN5SYD21ZVxHQKKdEsy9W
 NF91QVM63eXbgud93f0x7hIwEP68+Ngd+fJ9UHJ2WTQGQrQjet+KjoZRpnLQNiMdow2s
 Bnm3oHbt7i+/IVUj22Pd+Ajxd+PW0SlJnC8HQtLnrwjiN4I53KPYgjPFUxHU0yC8GeL8
 nI8UWQ4lyrhnAamD14nzaP6qzv//7zHEydXVUEjwBQ9EG4m3b5z1kczDwiliMqKLM+4D
 dY+Q==
X-Gm-Message-State: APuU4Z9TTH+kanUlRkp8Du1zcT7dQL6aPJmnh4Fwck8xcv4KRQA2lzds
 2yCW4LhYAHKp/GQXtwwt8QBP+nFaQm2JZ4Y/ZrG0FQ3iSMNscyRSugJeA3YbilYwdHk=
X-Gm-Gg: AYBFou2+iJEdvkV1ijZdv92uNDSKMmNy16jP7R2z/nHSVQT+F5IRUQGsxj2MUrhz/yj
 RnzmlUY4ukQgXV5q3M4/HX9AMVWTM/OCs4UMxhGPU+44dA4VO80fnVjZ3gJbx0/CtmwFIMfPuRo
 jp7fmIVeRoARCszlXLnMsaOtZbbX0Fywo4kKAD48ERMgdx+WRsQ3wZRzV3bZHQgNr+njkbc2qf0
 wH3GFej0a1ZKh5era5vX5XQjoNoIfSono1yg/j3D+sovLiWGIAqmbGuzCx7GOCXbTFSIdC8qH88
 B1jKZ4zphixL4zvuxQzHO5jJMTECHL/gl4bS/vnGWOrSr1Lg++tusI8HLTDBOznD4jTy3siqjW6
 k4n/BB5oK/ZuWKDR+Nw5C/zx1/XwnVNJfMULWriDCaKxYrXSvMCgB0o7IEMrToSlGNWkDu6utWQ
 IRU5W7qjNy1CqXOFeDS5/KD38GvTZ2F6lOSqnq4IsDCwnGtsMGZ9m7Jj0WOvhAf63ObwV8qf2pw
 Fe4rXQTa7gZFY+VA2miHU3ndjlBYYrUUWUqyM4FSq5XN+GEk/p+EtxpJnb6dwfzZkSXMDCQq0UY
 URai5kP6aF8SHezgGQtHXmVXMo93kZl/DC0bPqkx4cjE2XvbUjIbSUQydY+kWe//uXkhweZcHkF
 drTsfaPEhvj/8IWRv70VbLTBKC15o3Xzv8uMzby74P67kGg4xrcFt28rCSfsO3m0Q3ZAq1Ubn8d
 KKbWRGpX20UsogyF19/1w2ibEwdxF3S0f3YgnF5t2Toe4tVF2kd3aL
X-Received: by 2002:a05:6820:2226:b0:715:205e:4b72 with SMTP id
 006d021491bc7-71b024e012fmr269127eaf.24.1794854237080; 
 Mon, 16 Nov 2026 10:37:17 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-71acce1fe74sm7259468eaf.1.2026.11.16.10.37.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 10:37:16 -0800 (PST)
Date: Mon, 16 Nov 2026 12:37:13 -0600
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
Subject: Re: [PATCH v5 6/8] env: scsi: Implement partition type GUID lookup
Message-ID: <20261116183713.GE554944@bill-the-cat>
References: <20261115-type-v5-0-79e76209457b@oss.qualcomm.com>
 <20261115-type-v5-6-79e76209457b@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sMic/Rf1WNGV9wQN"
Content-Disposition: inline
In-Reply-To: <20261115-type-v5-6-79e76209457b@oss.qualcomm.com>
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--sMic/Rf1WNGV9wQN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 11:56:08AM +0530, Balaji Selvanathan wrote:

> Update env/scsi.c to support the new partition selection methods
> introduced in the Kconfig. Replace runtime string checks with
> compile-time preprocessor conditionals.
>=20
> Implement support for all three partition selection methods:
> - TYPE_GUID: Uses scsi_get_blk_by_type_guid()
> - UUID: Uses scsi_get_blk_by_uuid()
> - HW: Uses blk_get_device_part_str()
>=20
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

Following the feedback I just sent about the Kconfig part being split,
this should be redone to just handle the existing options, and then the
new option handled with the rest of the patch which introduces it.

--=20
Tom

--sMic/Rf1WNGV9wQN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavtNWQAKCRAr4qD1Cr/k
Cnw6APwPUHFE68dYzs1zG7Wr1rJwzhHV2ov0CllqtSpJJsrX1gD/QQ7RyddqtECj
JxAdRG3lvkmcYnSV505Jyjg5KialdQ8=
=daUc
-----END PGP SIGNATURE-----

--sMic/Rf1WNGV9wQN--
