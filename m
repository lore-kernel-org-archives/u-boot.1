Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DED4606A321
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 19:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eDf75jS1;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=P/r7n4wl
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1226380D82;
	Tue, 24 Nov 2026 19:09:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aCMGZgIAcnzd; Tue, 24 Nov 2026 19:09:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5E97C80C9C
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795547378;
	b=Q3FA5O1UcgC4Tm4Jebdi7g8pqrHhv/65RWLMmW1jUXHtS5IYD23qQFjM9bwOhsjRC6H7
	 LnaIgWKR6NuE175e8f6cTOzcPnIcABp/2sgOjmK2VrpeNzPRuH4b8G3i1uWXZSXB6wefM
	 7FNfzaZC9F+3yceqORuBqch+OUj2qzJl+jdYv8l1eXFNpJRIx9xmSAUKoV+LPedVaBSrA
	 oKDWshQOhQTwUzFsUzM2vo6xE4fGqOjeGy/ywWv1LiZLuwS9JRVXt1+lJBXDYkWiv/Z+T
	 b9E4LVdwnvUOQUrhN7ECQ/WCrfEHg2lcu3i1kQGiKsgmue84HIVzovk9HeSLJc7imHw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795547378;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=WmixL69MzYXDC/yA6txiKVIM/oaqzh/MEf1yrf34MjM=;
	b=LoBvapnz8YnEeoLfMjm6pzYtHKFrxQGNGlJwRr051ilbd1cEwJkIhqfM23gT/vPutY0q
	 rkHtnP061vcO2ds1g4r0bn3mIEMODAQeU94I1lSkqyyHp2g7QU8fQJBxLy15ERHGtIKJo
	 igNpBsicKYqNR+z6pPTTsn6eiebnODYz82/xq5LyQ05PERh3tazGuEP4A4IKRtLdwBZWO
	 yY7u2LokbHHDcN2QX8XvSHSkhLGjJfDG3oGk1ejyrkxY1pQ5Uq5WFPqO8vOve0wZvCcZM
	 lnL1AHp/aS5FIWQ+gxhyo8HhNNJWDvrso71KaqjfHwSUBMWNjmoZkuaOGJ0tq1lefzA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b="P/r7n4wl";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795547378;
	bh=WmixL69MzYXDC/yA6txiKVIM/oaqzh/MEf1yrf34MjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eDf75jS1wk9WRu09A8sowdeuz9lj2boxtQgP46gE7zKWCodMQZ/seQftx8rtx5eZF
	 a92z5hw7jdBsUMTLv0fiBJLhz1C69olyPZKehSzBXq7R4HPEL6TZSCyAdwogiYfAwB
	 OyJ0KzZ/2u+vSEU5+5ZfGFwLxlYxylWT/rc7SlqUGzb0LOtRD0KZD68twBsYhm0ONH
	 fRdBp1o5fNio7yLQVZvRNLCgDNyF+By8sAarrpRQ1gtx0YTJ2QyG6oQns7I36VvySI
	 ORMKmoKbGAv71kpG0lP3zLdhtKeEm9H7cs+WHOKLGEmjy7d/7awI56YdyyvRyhymHA
	 nHs12U+UtPjPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5E97C80C9C;
	Tue, 24 Nov 2026 19:09:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 821851C9
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 19:09:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7379580C9C
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 19:09:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ol5oX9mU9si2 for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 19:09:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AF21180BF7
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::236"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::236; helo=mail-oi1-x236.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=P/r7n4wl
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AF21180BF7
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 19:09:35 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-571888655f1so1634511b6e.0
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 11:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795547374; x=1796152174;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WmixL69MzYXDC/yA6txiKVIM/oaqzh/MEf1yrf34MjM=;
 b=P/r7n4wlaQiA62+YDhMGUQRaCS8q1C/Ua7dQb7mwzU8FZN/Lj8gy3Z3aoJas82OFi3
 zqcKy6Xdu4cDwv5Zl8Rgoj0myRlPHmfhcclAIdlM/PGHlWiqk+GVvYvPCh2FhmqwJU1+
 3kC8R1OSt/bFgrcJvZJJYPiA6SURq+O5Tzxvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795547374; x=1796152174;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WmixL69MzYXDC/yA6txiKVIM/oaqzh/MEf1yrf34MjM=;
 b=d7hkrjGZcsmWuwRqUmvEwz8WEj4m29nApLjMdB7/Yb/t7EF+avWgs3WAue8UXbUjr1
 ki8S053955m+C0ZZ7bXg6+vNINolkpyB0XjbHbwxqbNKW1199fpYNs0/hlwMUrEgOofD
 Je+61ufqBERqs5ASsoYM5JvSKP5JNQkVEV2IbM51j5hrhHO0b2O4zf9Ru068FnDdc5dc
 I2Q9RbVJ6YrLUWSkPdtbTHK+TdR0pJ+wKasOGTMQ/IUahhvzavowPY3HzerfuI2tCgnL
 2/d66/tmZZw68JPFpqlgwv/rnau2t74OSH7fM2Xur+j5b9e3afcfnHAVZHeGxI59m+U3
 cKUA==
X-Gm-Message-State: APuU4Z+06sFMNDJ6RWoUnNC7bF7a6oeW1vv281Z+hxO7qkCsJoaQCyBC
 QhyVGQLSaRBYCsj+KgNJ6TI7UCSO8Ab6ph6XZ+xlOSi2mgfzTK1rXf+Uk04UC/yDDSs=
X-Gm-Gg: AZFdTZcZpQ7LS5l7joFh+J0f/q/PtdccN0PzPH8JfaRySCQ6/VUDXkp9VSGAbgZ1g/Q
 CYE7Es8givycJYDveqQTrZ5/bxprZyPAd6tMJx4k76xfqdXv8TSmzIWN9Re2cl0mum+aAJekxMv
 uT+kd0eacnOqHd6MKkrBRfRLNVdH6p+jTmtqYFgaO2wM6fw6GpsGoFPRjNO7/g0nos24lQ9s0Vl
 erQ8c0bRqNX4gBNy5c7ioAK5lWE+Y21duPzYbq/T4KCefBQ6nE8CrHdjL/byrLJV2ZsCWDFHPRb
 0lWjD54hBnpeqiXi+mwItzT+X4n94O9ZBJlh73S/zPJh2Zb3H/5xrnWIp/ijDT/i+XYqrx0VlHV
 TgI8SWgNc7sCWph9ICwnyAr27HmSkQVKxVf8nkaSld1lYM70coanlOR50hNDd0rFudboyYBtqFy
 qZgb4MhAsEuXgk/tb3XA8y3djt3QJAdsPp/W59CvejtjWbQfBucukcHnEtyrJjaB50IoKnxS2Ak
 ij+rs6S6G9EkeQZQoljoXkqi6NUfhPPgabBaz0/mZauskWuUaTRpO3+ItmcYiYBP2V2Cms/ECF8
 XVt7EI5nWL27LL21z3RPEb/dM3/iMUVXnzjF3ri7C9WKT8ReEXJNMH6CeWdC4iNXRpxgQbVl1fx
 yOPvDPKEz6elH1DPUXZa4G9FTMqawl5FhysNsnLK8x3I44QBwpo9iAM76WiI0IxY40mJmrk9iYp
 +3KIxFM9v/vxWj/amlguLyng7yxssTxpVKwO/9oxh5rzVBez4XZrQL
X-Received: by 2002:a05:6808:f13:b0:4e9:df3c:c45c with SMTP id
 5614622812f47-57a09c0f808mr15615787b6e.19.1795547374216; 
 Tue, 24 Nov 2026 11:09:34 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-57a35e5ab03sm12100279b6e.16.2026.11.24.11.09.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 11:09:33 -0800 (PST)
Date: Tue, 24 Nov 2026 13:09:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH RFC] test: Add more tools tests to CI
Message-ID: <20261124190931.GA3176972@bill-the-cat>
References: <20261123-ci_more_tests-v1-1-52e9984f42cb@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mz37gFuiRuTu2+aL"
Content-Disposition: inline
In-Reply-To: <20261123-ci_more_tests-v1-1-52e9984f42cb@linaro.org>
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


--mz37gFuiRuTu2+aL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 03:19:18PM +0000, Andrew Goodbody wrote:

> 'make check' runs various tools tests that were not being run by the CI
> scripts. Add the missing tests to the CI scripts so that CI will be a
> complete super set of the local test runs such as by 'make check'.
>=20
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
> This patch is in response to Tom asking what is tested by 'make check'
> that is not tested by CI. This is the simple answer that shows what
> tests are not being run by CI. This does not claim to say whether these
> tests are actually useful or not.

Thanks for doing this. Were you able to push this through one of the CI
pipelines as well?

--=20
Tom

--mz37gFuiRuTu2+aL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCawXg6wAKCRAr4qD1Cr/k
ClIvAQDP1y3uk44+vpViSUDFQPXYsAu6yIfCL9ZN7GwHBf9yOwD/bqnAQVRY5kvz
i8EHmWk09SN1L9lw1zlzL9ogg8VlFww=
=obT5
-----END PGP SIGNATURE-----

--mz37gFuiRuTu2+aL--
