Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70B8606A5CA
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 18:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sH6w2+hF;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=n1e/hw66
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6BB15607F0;
	Mon,  9 Nov 2026 18:33:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ofrUzrkp2WIR; Mon,  9 Nov 2026 18:33:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 88A226070F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794249226;
	b=bCUtbdPgelLUyoOmEo3aUCKbnI1K9Oge0Ku8z7AGg3BOxBwoe39UrU/Vvekrvg7HgJat
	 nXhIQPmimVrRhzplWVZpoYvLNA+f4J2G/Cye0dTdqESci4Jgw5wounf1uui2QB5EHrZXH
	 0J+hxjdBQv9VUEO3BGzN7bYztjvrAywKVBZK0aRDoqMXVB39h2WB86KBmVN8yKWs+ssOn
	 BG8D9p28P20LdDwgAS/fXA5ChFFicdyQBODYkHFBAII5TVVhwRhDswYyQwP1lh/nuTU/Y
	 n2TM8aK/e/zFrMKQGyilCcYMNgQP/Ad8qpytGRtKBx/VWNxQs1Fpiu1i6EoYzNbVN0A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794249226;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=I8CBKlhJOvt9mir0UDmcHgOTixmqFLhExIVVIPc6U4o=;
	b=iCamCACP/Sx5WlsguFUwmcqUPjVY8/m4sR9UqDkFf0R0Ea9t1i+PF44FPEl1B67WkYxr
	 ksO1oNmxgz3P4F6vjv5WLx7YNcIpOkEKf0XC2CcEImjsR9YDBBJYBH73DKhiRtux7hnl4
	 8ZjCXUDcz0La9UKCGNbGxXFJzDD/C2B2Csh3FSdd1s404LLOzwa0r1V3mOBT0NWcUZPkQ
	 5AvaIiQUgXH2drrRv/kFalbno8cxT1pEckxNtHXj08JLfgTb0ED4g4bPg1zckMniJEcQu
	 reYfjYKlHdz/DLzGC6jrDbZv3quS4PyRHfcKmOGUbSEr73iZxh3KctI40qN6leYeUMA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794249226;
	bh=I8CBKlhJOvt9mir0UDmcHgOTixmqFLhExIVVIPc6U4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sH6w2+hFzjNtEQcWkNRw276ljqXHWxgBbmdBXhvEi7ErkGyzR4tVD/WZhqY+KqXs9
	 P4ebedwSLpbCVodFnwtACsaDd7jfACMfh9ODvQnwnnHDzP32sIXPGNABi1nMd8cB5N
	 T5EvqiAS0DfvsXW69pOjGkmIhVI0uXfzoQVFlDAVAcJjjCNFc2NBucgyvTyQdK2JIo
	 n5kKygVwZxiibcudWS2j368GNieJCZkhm5kiFC5+WJ5xtezA8/McCkKjCmCyemBhtG
	 a1QvKF6ySaIImMwyauwXS/shTHBOLo6IHCGVzolde+CVayR+mmmIqO5A3YTddkBs2G
	 TpErz6LjpoD8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 88A226070F;
	Mon,  9 Nov 2026 18:33:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2718F3AD
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 18:33:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 249A3402B7
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 18:33:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zb_qAmksAYlQ for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 18:33:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3F89C400D7
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::2;
 helo=mail-oo2-x02.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=n1e/hw66
Received: from mail-oo2-x02.google.com (mail-oo2-x02.google.com
 [IPv6:2607:f8b0:4864:31::2])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3F89C400D7
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 18:33:43 +0000 (UTC)
Received: by mail-oo2-x02.google.com with SMTP id
 46e09a7af769-824f3901d55so1585729a34.1
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 10:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794249223; x=1794854023;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=I8CBKlhJOvt9mir0UDmcHgOTixmqFLhExIVVIPc6U4o=;
 b=n1e/hw66ufSK7CN3kdDnQAhkslEaClAuXJIiklw/QYcfLBB8DjLAqGK7VFcpY3gLjb
 R+IIgPF9D3EFRaWdVks8sb4crnu1rYurxOfCZ6mpoujwwfu1g6wDufGs6GjNpSELkDcM
 c4NOSDNDuqD6ulfDG4r+/UAS+3qNDjLfi54zw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794249223; x=1794854023;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=I8CBKlhJOvt9mir0UDmcHgOTixmqFLhExIVVIPc6U4o=;
 b=qp4OWLQuGwTeUbAYcMCdKt7T4xe/MPKLYHZJc3CdmRclxj+gyzUQD+hEjBmXDH5RuH
 0IYAZSUeBb1eR/uPUVjeN+XHvbGGXCtd1fbkw9FTdaV9TDf8pXbsRySJP12Hg9e2jOCx
 f7/uFFngM3ZqXbLDqezSYjT9I63mfvgCX+Ow8IAhq/FjYRvGocDVsNmqwGT2xeJevUK0
 2Uc6D56kW0HnsaGeRQ8h6BE7PbtKplpbOzw1LADnybHK99LQvKLnt7QrS9DplyYXMPXx
 iXfCAeWdzeY9Wr8dpAa3xISFi0dKcKTjG8nQ+KbHnvel/FdyxCzeJXVFg2PKbeQKnE93
 MDLw==
X-Gm-Message-State: APuU4Z8wEm9O6JJSnZ7knujL2qDLFnetm14VW4VPLupsFR9fExqWtc8N
 Hhg/iF+apSq19w/n37FW8ozlE93ejXQg1+QAP5Ra4xqk9gcpbZ5cnpAfM/PLTtFqY3x/Y4cdvKF
 Qg4hSfLvfl+nxn3c=
X-Gm-Gg: AYBFou3loTE7JntOrwTydln8eBdv55tIeIoR649Y9ZHgwgALSw/0/0PbeNbxCa46QL3
 v+Yz6CTWeqyG972PZgFYD7TMlMhnCFUrHnwLEFXlfqXxTqHFv/3U2mTjgKaObgVHiVeItf6jiat
 3hKlaeop8v05eoqAVWCaHhwf1N1i1G0fx2wjELXa/vWIguHEph973rUGDXGIreEiMrRx4RSKjGC
 zR7FeJMZL9++ZKu8aSHKDZlktzEATJAREK2Wo5q1bRyUMqM599uwQAaEJcbpjRtCUbn9Ga3m4Qh
 xoFFdb5IHUra6t28AeW0SyiOv3N+5oY3+JAlFXNO2d/UTaTyz8vpBUoisz83a5fVgwdSsDiMLGP
 oISNXfFFRmz619dCgPfbyqhVzAuUqW6V9+1ufwyp+raEubKrxEY+0CKn8hVPWdOJT95Lof/qq6Z
 lghN/0iO8bm4ypcHzmiyDt+sziADwjhim/sDkvJptNnMxRClb7kQLNnYUgSjvVnx6BYnYA4qtNG
 j/2ljxirEF0pcD8ykN1MWMFrsfTfXtmdWgwp1AuwErf2MhoGGgrdAPbIybqa/cHVuLK1CA0k5+F
 oJ5pAaYujJ36zft1LOPTUpJNOwKIK0u7zpuDdKilW23zUXH/8/6yXb/jhfxkjlAoVDlXFBLmT/Y
 0A0qgtvetHkYpmXrU143Q7aVIOMVdmk2tf2r2SXoTt/OdGKLa3thWw8yhBaEVQUk56DF+jxUSZh
 n0Ouw7NZcPTJ/hcW5cPkUqOcPHL7KDxg==
X-Received: by 2002:a05:6830:410b:b0:817:fe44:989c with SMTP id
 46e09a7af769-860dc7db5bcmr123727a34.19.1794249222694; 
 Mon, 09 Nov 2026 10:33:42 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-860dcbc82b5sm12309a34.17.2026.11.09.10.33.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 10:33:42 -0800 (PST)
Date: Mon, 9 Nov 2026 12:33:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
Subject: Re: lwIP re-sync to v2.2.1?
Message-ID: <20261109183340.GV3741582@bill-the-cat>
References: <6f01e99a-8245-4027-8fa5-968e07bf2cab@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6B5N1Kiu+kfPVLlZ"
Content-Disposition: inline
In-Reply-To: <6f01e99a-8245-4027-8fa5-968e07bf2cab@arm.com>
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
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--6B5N1Kiu+kfPVLlZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 09, 2026 at 07:11:04PM +0100, Jerome Forissier wrote:
> Hi Tom,
>=20
> I'm thinking now may be a good time to re-sync the lwIP library with upst=
ream. The
> tag imported into u-boot is STABLE-2_2_0_RELEASE (published on 25-Sep-202=
3) while
> the most recent tag upstream is STABLE-2_2_1_RELEASE (published on 05-Feb=
-2025).
> That's 94 commits to import. We could also re-sync with master for more n=
ew stuff
> (162 commits) but I'm not sure about the policy on this matter. It seems =
safer to
> always use released versions, isn't it?
>=20
> I have pushed a branch in the net tree [1] for the v2.2.1 re-sync and CI =
is happy
> with it [2]. Would you like me to send a formal pull-request?
>=20
> [1] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/commits=
/lwip-resync
> [2] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/pipelin=
es/1938

Yes, please send a pull request for that. I was going to ask you to put
it through the sage lab too since there's HW with lwIP enabled but I see
you already did and I appreciate it.

--=20
Tom

--6B5N1Kiu+kfPVLlZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavISAwAKCRAr4qD1Cr/k
CjXaAQCQBqNnbcIi7DLz7mHih3EHnwovxFCkTUXHaHVeNJAAJgD/Tk/sAuqI4vvm
bqEIQFHPmGmTZ4UT2VOha5vWaww7nAU=
=REpt
-----END PGP SIGNATURE-----

--6B5N1Kiu+kfPVLlZ--
