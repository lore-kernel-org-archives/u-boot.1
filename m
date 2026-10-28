Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58820606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 15:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=g+j3BteU;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=mdJo9F5o
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2123081164;
	Wed, 28 Oct 2026 15:09:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5rl84Cm0HeNU; Wed, 28 Oct 2026 15:09:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0431881154
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793200151;
	b=YCJOQZzrGaCAC9bKFfgNTfBQoKaH87ennrdzavahymX7BJkeA6OleedQibjsrxu09Sb7
	 +xuoj7lHYKC0msxCSgHJBap5SAtflcjB7GdLWPlyt8oz/UNEo5F13DKqyYulZ7uyd9Zm8
	 SCDgMaT0B7tILJg5y0tOTtoEeim75kzXpcHHQ7WMTBY6+fKn5nU/3yYfDpdwAMllV0Rvv
	 r2Sq5UIv1Pj+ZEm3b1ahIZaPXnW/NyXCplDA1TBQQfYA7kg1vZ4EcC8GYi/toPYA1Mc7h
	 4y92m7Zu11uJ3ZuSB9WL1TMVRgt4sienv1D4EoL8Hh6GQge/gjlWBDUThLJKm5l46Kw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793200151;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=DHL/0CJRLrxxFB+RwyZnw1i5g4tFJBWFRuGtqKPWA3k=;
	b=fxY9t8RqZMvh4Q7NjoGz8qLedYwZhWWCa8UtpPVIINd3COsVFJ737ICGeb6AfbLx1mrx
	 jHxyzNYg9hsEWnz4u0wLutikPYGrZ4oXR7tVnWi/lgkkWzewode+B7EQYPTjb0A4kMQxt
	 rjw2d+CCzmpV/bN0xBEVYh8R8xoZGh6lf6u8Ml06VNlwWFjVbeRtF74Zv3DT5Damc4zvA
	 IVUrI+Au1zjo93hTGrDF/v4u7tqPYkdpYQl1H679szdJpAVXXnkWgqC5S63bYbjNi+cWv
	 8VG/7ENcfIGEroeqqJR2As325P3o+5nY9LenAV6qOdPviaqruLUfDuKOyBbzLMcxdPQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=mdJo9F5o;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793200151;
	bh=DHL/0CJRLrxxFB+RwyZnw1i5g4tFJBWFRuGtqKPWA3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g+j3BteUhPGcYySRgjpojXnAoW8kLjdVPGhmOlax0tUwYNwxk8Y+q1q5iu9z9MWnX
	 tkNmpnHZpWFQVTWuUbhsA1MyL1bUL+Cs1V+a2CO78UCMqJgQWJB3qc31tklQ5+ZnWC
	 Bd5Brqo4hDd+JTnKtLAkS+5CmkVh4n9oP7ZYB8NUU7Qm1sHC78ciWtcKG8GO9ACscd
	 WHBxJvtjrkMeuIiVs0aAD1oDI9LfW4UE6HtG9e6JsX1ZR88z1/3lNGT6ChW5UuRnk2
	 du57Y6xLzgr3P04t9T0ikKfDRRThlUHlMoXpVa4L2xps2Ya6EAKn9q5NWImCjcdG1g
	 9GeB3dhL2uSRA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0431881154;
	Wed, 28 Oct 2026 15:09:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 05D02356
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 15:09:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DF7A181154
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 15:09:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iWz4Ma5twk-s for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 15:09:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BE7CE8114B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793200148;
 b=T1GLyul4lx8pS1CfSfB4zn4QybiyIaKhApDK4jsxd1J+m8Y9loQu9l8F23wevWTePvRB
 bSc6LbKHRcjSBKhM/OXUTaoj6+/drsBXXR5fS2jno13ABatI3nhep9zMNSJQXN9GncWza
 LDt0JdkXz9RRRGfUvJDw9jUEOvU/AOuu1+5oH6cwnYXVEDwv/583Jt29oAbk8+3RP5G6p
 qHFt/JvBIzzkOqRPauHXsEopwb0+GY6n1IV987UYJVWjxyC9YZNS4HVJ7Jn5YqTjh6eiQ
 wprSf1dwQHng7B6/Ub/ClEXOsPwXtM3AhVGiJhUKQ+P2atT/sjdWV0yFhM2DV+FcRCg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793200148;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=DHL/0CJRLrxxFB+RwyZnw1i5g4tFJBWFRuGtqKPWA3k=;
 b=big/Z01V6rdw77nl0chMrunT66aqs5mKskqyFgbun/zy6jBCfJ92aw8+3F0cYplfyxXc
 1U3mS/PfLe3f+fR+18sIjH0vbOBdZ5pTwtEpP8tCCFcDJLY91xaZTUcz5DDmLJn9xtP0W
 g6lLcx9o7Bm8hIXOhbORVQqjJFYK6bxi9J4NJfp04soJzH3PqSr7fmJUhR3DGvNeO6B/W
 KT31IzGS0LGBgcK6Nyko9PPK/BmgxTnikiS4zP0bVdyOrph77Yt0a6u/v990xBrWVFwpv
 Qm6rtHsNztbIJsPsSAijwX8NC6Nsj4/ykhP8QSuusVlpkbfQ+LjqtFByxGYrtVWn7fA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=mdJo9F5o; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::b"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::b;
 helo=mail-oi2-x0b.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=mdJo9F5o
Received: from mail-oi2-x0b.google.com (mail-oi2-x0b.google.com
 [IPv6:2607:f8b0:4864:32::b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BE7CE8114B
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 15:09:07 +0000 (UTC)
Received: by mail-oi2-x0b.google.com with SMTP id
 5614622812f47-53c4858eb76so595965b6e.1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 08:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793200146; x=1793804946;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DHL/0CJRLrxxFB+RwyZnw1i5g4tFJBWFRuGtqKPWA3k=;
 b=mdJo9F5oYaZedRRpLWfwA3V6/5E8khcjeVDAcsFrPydWP4evIXY3AZVwW4i98Jm6Ra
 beqHy3O/hdfTxkhRASc5uAPJQsXX5fFBaNdt9oo2QFofLqaWgwK0bT/uY3gX1OmTUJ6C
 r5XyswgL/3HcsJms/l0TIs3TeOxqgvW4v84CI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793200146; x=1793804946;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DHL/0CJRLrxxFB+RwyZnw1i5g4tFJBWFRuGtqKPWA3k=;
 b=VCKm71chGGOz82sCKYvWGM1ejsd+EFTMfpSdfZNRxyfYjdQEr5GTCHL1d44NsxuaTt
 S+Chjkf38N5NixZljuKgT279JhPbilHd/gIztuRnzZscKc92xdgPBGciDQT1iDT0/zGR
 lPp1s30PRtvWt0uhatAB7du20TYioSmYXfHoQ0YIgGw68ENBgKEL7jjRoZbIlPJ0lDlV
 VsqMtR+gLLtevnnLkuyBQCscffh4XrwsQVEgUxrRs6ipL6EraK95qg95/CdFBpBZyiI2
 yZnPzelo9h29KqHtVMnpv9OgiNz232BaBkgjd0To9onuPj1+0zzrqLAkTqfybds+MZDr
 /Oqw==
X-Gm-Message-State: AFq9FYITH3lw96jnUxXg/ZnFhLO/nH4OSIY6T7lo2lZGKIyyWBJammYz
 NTMlCMbMtrhoQwcim/4hBgzI306r7c1cnuiKgiPcrJC/EHrTMcxHiGyhxC4OdS3QtOpOfGSAh27
 X0Ow0P/jQADuWjLI=
X-Gm-Gg: AYBFou09gHVsXRTF4zMOAAGmplEG0/PSTSokz3lgJBgy4ePlJW4c4Yx/TqDtil9lu9f
 INwwtw0NZre/MxFJg4SFW4bnuJaLSmZqrvMDiiVG4faIGr4wI/i5VW6Z23OnSuHbiRKAQhRFAy2
 3X7TLVLvP3rSSDH67R3/ziP1UNKP6Xc8WKA45J4RLc1asFAwhCbmxe3vlBfcBCzNktVyXzn8k/s
 1/HYUx5dRFAZcql8MujLZtpbp3QC21Vca544AsTXoNyDg1a7wv+xDg9QqYSJTtoX+X5HJrVpVzT
 UY8+ILULTb+xu6fF+fq8c6Z662Fq2YPs1tvaLLIvZsdaJoKpp0TA6VF12ExxofqGo7+lmiEs8JW
 CXtS+8EG5pE1tv7pPnuOGjXwdsO58yFJgXXzvkFk87rRYSwftwpouKJnzleuUbIQtim7xGTyfbx
 m8c8AOBkNPmTCsXneemsoJlIdCbW3JPFImWga8PVsCcR1cvQUr9A7EPl/OwOUdh2mSrzYCjsHAz
 q2vOgTXocquxEPNR0WBjUFKq1diE3UnG3Jt1yoeQRSarPkGB4XSD3XmnpE7quI5JBO7lRM1aixZ
 F4qlgjDGU2OLioMy1pkt8jE8a9rn5DfPM1SVuvJXYKisDCh2evqy/kRVjWDd26PL3MJ1wxXNzL4
 8r39YYGSIp76JV9H1hytOXYnjpdGzcNv0XPGbYwzTCdfhSAvhgiHstXzBSwY2q1bB12rzVZ236q
 XC7vnIFj3G598JVWCutj0Hx5rhQb9R1mQ=
X-Received: by 2002:a05:6808:c410:b0:4fb:a089:bf23 with SMTP id
 5614622812f47-56386e22618mr1719429b6e.49.1793200146103; 
 Wed, 28 Oct 2026 08:09:06 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a8b70b2e8bsm2780713fac.0.2026.10.28.08.09.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 08:09:05 -0700 (PDT)
Date: Wed, 28 Oct 2026 09:08:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 James Hilliard <james.hilliard1@gmail.com>, nd <nd@arm.com>
Subject: Re: [PATCH] test: Add helpers to preserve console silence state
Message-ID: <20261028150832.GA2677024@bill-the-cat>
References: <93e4e89a-6c3c-4a3b-aa90-bd9090a6daaf@arm.com>
 <20261027173348.GG2177077@bill-the-cat>
 <d5057c79-7e37-469c-a2e7-b14ec4f18f2f@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1CFCIzzFVZoNfOXW"
Content-Disposition: inline
In-Reply-To: <d5057c79-7e37-469c-a2e7-b14ec4f18f2f@arm.com>
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
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--1CFCIzzFVZoNfOXW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 10:01:10AM +0100, Jerome Forissier wrote:
> Hi Tom,
>=20
> On 27/10/2026 18:33, Tom Rini wrote:
> > On Tue, Oct 27, 2026 at 05:02:12PM +0100, Jerome Forissier wrote:
> >=20
> >> Some tests intentionally trigger diagnostics that the Python console
> >> parser treats as unexpected errors.
> >>
> >> Add helpers that silence these diagnostics while preserving the previo=
us
> >> console state, allowing tests to hide expected errors without accessing
> >> global data directly.
> >>
> >> Signed-off-by: Jerome Forissier <jerome.forissier@arm.com>
> >> ---
> >>  include/test/ut.h | 17 +++++++++++++++++
> >>  test/ut.c         | 15 +++++++++++++++
> >>  2 files changed, 32 insertions(+)
> >>
> >> I am proposing this patch as a prerequisite to merging the series "net:
> >> lwip: restore TFTP client and command parity" by James H. [1] which wo=
uld
> >> otherwise introduce a CI error [2]. The error is fixed in pipeline 1762
> >> [3].
> >>
> >> [1] https://lore.kernel.org/u-boot/20261024-submit-lwip-tftp-combined-=
v1-v2-0-0f663f735ee8@gmail.com/
> >> [2] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/jobs=
/128187#L3716
> >> [3] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/pipe=
lines/1762
> >=20
> > Sorry, what's the unexpected error line(s) in 2?
> >=20
>=20
> The failed test is tftp_test_protected_autostart(). The unexpected
> error is:
>=20
>   ## Error: !
>=20
> The test marks "autostart" read-only and then calls the TFTP download
> helpers, expecting them to fail [4]. The helpers reach netboot_run(),
> which tries to set "autostart" to "no" [5]. The environment code [6]
> consequently starts printing:
>=20
>   ## Error: Can't overwrite "autostart"
>=20
> The Python console parser defines "## Error: " as an error pattern [7].
> It registers that pattern in the list of bad console patterns [8].
> While waiting for the U-Boot prompt, run_command() matches the bad
> patterns and raises BootFail [9]. The match occurs as soon as the
> "## Error: " prefix is received, hence the truncated diagnostic followed
> by pytest's "!" failure marker.
>=20
> The amended test fixes this by silencing the console only around the
> calls expected to fail and restoring its previous state afterwards [10].

Ah. But looking at test/py/tests/test_env.py we have a test doing:
def test_env_printenv_non_existent(state_test_env):
    """Test printenv error message for non-existant variables."""

    var =3D state_test_env.set_var
    c =3D state_test_env.ubman
    with c.disable_check('error_notification'):
        response =3D c.run_command('printenv %s' % var)
    assert response =3D=3D '## Error: "%s" not defined' % var

So can we do something similar for this test?

--=20
Tom

--1CFCIzzFVZoNfOXW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauIP7QAKCRAr4qD1Cr/k
Cq20AP4s7ZqVH9z+1ZZpDAEjcFvSD1NylCP7GuaNPgEPjGIDGwD/YH68ZZpEQfop
7aunTpAc2YAwl3c0UlKM8HtBt7nkXA0=
=nMHE
-----END PGP SIGNATURE-----

--1CFCIzzFVZoNfOXW--
