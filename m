Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1624606A31D
	for <u-boot@archiver.kernel.org>; Sun, 22 Nov 2026 20:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Qg/hooqK;
	dkim=pass (2048-bit key, unprotected) header.d=freemyipod.org header.i=@freemyipod.org header.a=rsa-sha256 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=XL/fEIke;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh header.b=VMcfnSrG
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2B0E980D5A;
	Sun, 22 Nov 2026 20:47:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5Sg7ERC0HRkl; Sun, 22 Nov 2026 20:47:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 119BA80D29
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795380436;
	b=pArW4kS773hlcdCLN7xh59qPFfmhH+qGOxKJRwwdastEl/zDkmff0vvqCKpNNxF1KAGO
	 s/6jjZcae6fAk5XixodgM4M0SsTxKG9rq4oQF6Y9DXKyhUpPRhM/KIDbqXonGq0g6e9Y2
	 xQRJu7lzkdSmq/N9sN/bP4yEIFLEjNiuSfJaqdtGuNCScZWxPDvznKixxAvPEkBpbn/XS
	 JHbAxOEeMC1iiZmTHOZunGSWotEdcwzupM+yfvDgFrFdmnYSF1jEtEUKQSUX9qtdIm35a
	 Q+N+GLSmglCxEhDy0tRyW5aFbteXEy3RvHymr810BC+AbQAeAZ8tH1itHQldWMcMsTA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795380436;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:Message-ID:Content-Type:
	 Mime-Version:Subject:Date:In-Reply-To:Cc:To:References:X-Mailer:
	 Feedback-ID:X-SES-Outgoing:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=98yJNL30IwalXgkPwfiw0JUMaL0gFpceeyNQRbkxE/E=;
	b=mXKuLQWvRyFVN6MpY+8DstuCI63iAuBjEOc1qD1TmbuxAk5T/6O+9c08v2xkW/QUHos/
	 b8sU+ddZRdSVBO4BUsBNmTJ0tEl1IBghnTZRT5j8GLOMp8/Uhj0sY+ynNR95J7E2QKxJH
	 il16ZvWY2HjxVDvfAyFWVzgDtSpIl9hu0gFr/VvSOJkC4XKO1pS/x5JunZf91QDUHFxtj
	 xePZ+9LjJIhnG5Tvgx8meI8KZqtuf6p1an5Ur/Uq2Xppb+bX1rvyDGk8i07WWM7b359KT
	 WQyb8IBj+ejuCzSs4w8NDPJI/B+FJMUIs2FLInD+8CEXCm9WCYuZeS/FPEnEr80P8lw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=freemyipod.org;
	dkim=pass header.d=freemyipod.org header.i=@freemyipod.org header.a=rsa-sha256 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b="XL/fEIke";
	dkim=pass header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh header.b=VMcfnSrG;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795380436;
	bh=98yJNL30IwalXgkPwfiw0JUMaL0gFpceeyNQRbkxE/E=;
	h=From:Subject:Date:In-Reply-To:Cc:To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qg/hooqK0t/ChN/X2CFegxCYUA7I3QsTdRongElHiXkxcTwRP3cXK03deioCQkkll
	 eaCiL2unrM14JaaLCdXA84xc0qD1oB9T5xRhVNZz55E269we4gL0K6lue9szfqhgvu
	 WUc414GOrI8BuvEOemlpzu8priHAQkjdcWMWxqCpU3HOhWLzQPFnM9TTBo3jPwxzTU
	 JN+pJ7M1bBDyqn6X4CyeQeRK4Cpz/4nCJn7voT6lUaiyvknUPb99E3dOXAPzl3YC+k
	 GYMojq4z5/oOUPF4Zzj4T3+0cfJe4Xu7jKqq6kDtV85AGc7/qMLvTCSr8hDWGDhKny
	 dgb5z0R/J5RnQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 119BA80D29;
	Sun, 22 Nov 2026 20:47:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 83506310
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 20:47:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 741B880D29
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 20:47:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1oxxIbkyBPsF for <u-boot@lists.u-boot-project.org>;
 Sun, 22 Nov 2026 20:47:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8516E80BCE
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=69.169.224.7
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=69.169.224.7;
 helo=b224-7.smtp-out.eu-central-1.amazonses.com;
 envelope-from=010701a205034107-1fc5e0d5-2075-4e92-b339-d45cab7197b6-000000@ses.freemyipod.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=freemyipod.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=freemyipod.org
 header.i=@freemyipod.org header.a=rsa-sha256
 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=XL/fEIke; 
 dkim=pass (1024-bit key,
 unprotected) header.d=amazonses.com header.i=@amazonses.com
 header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh
 header.b=VMcfnSrG
Received: from b224-7.smtp-out.eu-central-1.amazonses.com
 (b224-7.smtp-out.eu-central-1.amazonses.com [69.169.224.7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8516E80BCE
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 20:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz; d=freemyipod.org; t=1795380429;
 h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:In-Reply-To:Cc:To:References;
 bh=iMhwVar2lwoB3jyriFo7mAyP116fOKWxKzBvg5nd0FQ=;
 b=XL/fEIkejJ2Gp/pwVns+z93eNc7Rtem03Ispu5zufJKWRu4W+3m0P2Q0dr4ofmHa
 8/S/TQjfIKONHcs2bHNcj6XdPq7TbRUYauEuOeRVjkfCnqVcdDnJG0S1gJZPcZlpZ+D
 UUgMGhaJnvDgpgBU4VTnEcT8+5GzawIOpOo03U9u4yA6TZD7zJ3QNJds6hMb2kfhC6H
 q9VygG+NNxE6B1e/8QZg3TFCPkwk8KQGrMJl3d5tJsCjfOb2OYDkxgKAFL2vro+Thl6
 Ij0LjVs5gsJdVMs4xmHbj+X/VO30BLwybZ8Cca1q/UcM0mUXJlCzufgBJBlFd2qFGf8
 oaATSzQmsg==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh; d=amazonses.com; t=1795380429;
 h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:In-Reply-To:Cc:To:References:Feedback-ID;
 bh=iMhwVar2lwoB3jyriFo7mAyP116fOKWxKzBvg5nd0FQ=;
 b=VMcfnSrGeJgrriV6NlnolGBpvPuO19QMZ+yz582qhnjup4Jhu665LGqRfqpoTh1p
 2mA/Gg3Xg8wCLo2D6ntFSGAofmpR0OIbmltG6q4SuNgB3sfipA0FBR5yVVLAqMC4teO
 3Mw1o4R1YfpGqnSWz0aD+v7K4GRamqpipyLO1OO8=
From: Vencislav Atanasov <user890104@freemyipod.org>
Message-ID: <010701a205034107-1fc5e0d5-2075-4e92-b339-d45cab7197b6-000000@eu-central-1.amazonses.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_CDEE2731-FC0B-40AF-885D-122896D5544E"
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH] doc: Add section about mail providers which modify
 Message-ID
Date: Sun, 22 Nov 2026 20:47:09 +0000
In-Reply-To: <e03a2d6d-0d62-4690-acde-ac4da73c2b13@cherry.de>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
To: Quentin Schulz <quentin.schulz@cherry.de>
References: <20261118-doc-msgid-v1-1-1088bf601fb7@freemyipod.org>
 <e03a2d6d-0d62-4690-acde-ac4da73c2b13@cherry.de>
X-Mailer: Apple Mail (2.3901.200.71.1.16)
Feedback-ID: ::1.eu-central-1.GZFSN+SpSZlcZgoCjFtpLsnhzRcxifcxl4uaxXIRIUo=:AmazonSES
X-SES-Outgoing: 2026.11.22-69.169.224.7
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--Apple-Mail=_CDEE2731-FC0B-40AF-885D-122896D5544E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi Quentin,

> On 18 Nov 2026, at 18:05, Quentin Schulz <quentin.schulz@cherry.de> =
wrote:
>=20
> Hi Vencislav,
>=20
> suggestion: reword so it's not that specific
>=20
> I've met people who struggle to use GMail, Proton or their corporate =
mail server, to contribute to mailing list-based projects. I think =
something more generic would maybe help them understand the web endpoint =
is the solution to their problems and that's accessible regardless of =
your mail server. I also don't think it matters much *how* it's broken =
(though indeed people may still be using AWS SES with broken cover =
letters unknowingly). I can suggest:
>=20
> """
> * If sending patches through your mail server is broken, doesn't work =
at all or is not possible, consider using b4's web endpoint[1]. It will =
allow you to send patches without using your mail server. GMail, Proton =
Mail, Amazon Web Services Simple E-mail Service (AWS SES)[2] and various =
corporate servers are known to be particularly broken.
> """
>=20
> What do you think?
>=20

I've tested sending an email with a specific Message-ID using GMail's =
SMTP service using cURL, and the Message ID was unchanged, unlike AWS =
SES. I also signed up for Proton Mail, but SMTP is a paid feature so I =
was unable to test it. If you have a complaint from someone who is using =
Proton Mail and their Message ID header gets replaced, please share a =
link to the message. Thanks.


> question: is the attestation necessary for sending over the web =
endpoint?
>=20
> If so, then we should point at =
https://b4.docs.kernel.org/en/latest/contributor/send.html#authenticating-=
with-the-web-submission-endpoint instead I think?

I've already done the attestation because the b4 setup instructions that =
I was following when I submitted my patches over SMTP already included =
patatt key generation. Later I found out that it wasn't required when =
submitting patches over SMTP. So I can't really tell, since I already =
validated my e-mail address at the b4 relay. The link you shared appears =
to imply that attestation is required for the web endpoint, so I'll =
include it instead.

Regards,
Vencislav=

--Apple-Mail=_CDEE2731-FC0B-40AF-885D-122896D5544E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dus-ascii"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;">Hi Quentin,<br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>On 18 Nov 2026, at 18:05, Quentin Schulz =
&lt;quentin.schulz@cherry.de&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><meta charset=3D"UTF-8"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">Hi Vencislav,</span><br style=3D"caret-color:=
 rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">suggestion: reword so it's not that =
specific</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">I've met people who struggle to use GMail, =
Proton or their corporate mail server, to contribute to mailing =
list-based projects. I think something more generic would maybe help =
them understand the web endpoint is the solution to their problems and =
that's accessible regardless of your mail server. I also don't think it =
matters much *how* it's broken (though indeed people may still be using =
AWS SES with broken cover letters unknowingly). I can suggest:</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">"""</span><br style=3D"caret-color: rgb(0, =
0, 0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">* If sending patches through your mail =
server is broken, doesn't work at all or is not possible, consider using =
b4's web endpoint[1]. It will allow you to send patches without using =
your mail server. GMail, Proton Mail, Amazon Web Services Simple E-mail =
Service (AWS SES)[2] and various corporate servers are known to be =
particularly broken.</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">"""</span><br style=3D"caret-color: rgb(0, =
0, 0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">What do you think?</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: =
none;"></div></blockquote><div><br></div><div>I've tested sending an =
email with a specific Message-ID using GMail's SMTP service using cURL, =
and the Message ID was unchanged, unlike AWS SES. I also signed up for =
Proton Mail, but SMTP is a paid feature so I was unable to test it. If =
you have a complaint from someone who is using Proton Mail and their =
Message ID header gets replaced, please share a link to the message. =
Thanks.</div><div><br></div><br><blockquote type=3D"cite"><div><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">question: is the attestation necessary for =
sending over the web endpoint?</span><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">If so, then we should point at<span =
class=3D"Apple-converted-space">&nbsp;</span></span><a =
href=3D"https://b4.docs.kernel.org/en/latest/contributor/send.html#authent=
icating-with-the-web-submission-endpoint" style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: =
0px;">https://b4.docs.kernel.org/en/latest/contributor/send.html#authentic=
ating-with-the-web-submission-endpoint</a><span style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;"><span =
class=3D"Apple-converted-space">&nbsp;</span>instead I think?</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: =
none;"></div></blockquote><div><br></div><div>I've already done the =
attestation because the b4 setup instructions that I was following when =
I submitted my patches over SMTP already included patatt key generation. =
Later I found out that it wasn't required when submitting patches over =
SMTP. So I can't really tell, since I already validated my e-mail =
address at the b4 relay. The link you shared appears to imply that =
attestation is required for the web endpoint, so I'll include it =
instead.</div></div><br><div>Regards,</div><div>Vencislav</div></body></ht=
ml>=

--Apple-Mail=_CDEE2731-FC0B-40AF-885D-122896D5544E--
