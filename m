Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5751606A329
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 08:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vS3ASel/;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=R1P8Plgd
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A4B6780D6F;
	Mon, 16 Nov 2026 08:18:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mIiaiZvr8LXa; Mon, 16 Nov 2026 08:18:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C80B180D48
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794817098;
	b=psZ5j2z4925mrd0LyeDdzrrmBO6WiLWR4QihNkf6MllYgxJby5ka8CEDGURsB0J4FFHk
	 gPAkGdj5tksGY8ui5j2SjMWTeFldIxYG7Gn0WXBPygEl6TBG8p/mfB23ocXOMrLAEM4dH
	 Bfj4vZqyCe2IvUThH9mEs6wYhGaYs/dGeRRoQTtoR7Mg5ZvBQq1YXUy2yBkgxXCUeeC5H
	 xvL5HDvaBSdV8LcztGY4p7QNSNj41rd/I465cPewIuE1Vzw1nOJxFr9sJtGyr7wxkoavZ
	 YKny/+RrHyozJoa82uAK+2j/4NBFkMEHGJJLQ3v6I/XJQFEWK8hvswFbqQlxBmH9/jA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794817098;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM2-Signature:Message-Instance:DKIM-Signature:X-UI-Sender-Class:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:UI-OutboundReport:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=h0yz9gotEfy/q3sknhUBjgOe/5YJ01863frNCoPXD2g=;
	b=Mk6wpRqknYbwn7XPnAM64PPA7Ebyfaz0HRyPjR/xujRzg97XrmLCL3a6S6j0qCmYc0cg
	 8J2CYjU57e+oTTCDBC7kRs/rr9CBb2TJCC39E2li6wvNS0WfRIaDcKhHcopacR3mU4NA7
	 NHHav5+KMbJMTwTgcsGbizxIgn5+OSwht78I4EZd+xlWVOc/XTbUNie4w2RysLSRicafn
	 dNyuKNbUJDAFU/Wl2WHRA7cQQILNC0NIOVCmDbfmT9gwy1BkoXxVbPGYHKhTJ3W+Epvt6
	 Fnxd06kg4Key+Nk71ElmDWRUUTZCFb4sG6aOCjSyDlhIaDb5Nb+ksMScQtXUmQyst7A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794817098;
	bh=h0yz9gotEfy/q3sknhUBjgOe/5YJ01863frNCoPXD2g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vS3ASel/JEkCuFx0F7FKufgLe4oXjj+qWkHr7DKinEKLZRqWwwmnlicOS2IO5CLdJ
	 AbB3TURVCnS6j2PcJUVSj0HXiQIdwVYzcFDvWu/Wda6bVE8QI3Pr7f+dy2/qZFv0/H
	 V0liW6N4H1zCE1MDlONRFaTlFWntdHT6RPsWyRYKEUNs8biKffdyiShZ1RavDaP2Y2
	 YBFfiYA3LnfxlznRp5jHGHgj3zte+hWiLb3PmD4fYbOZKM7G4k0N1Dkv8ST81WyLLg
	 IfUek8mi3M7K5VhL4Zmtl+BRCNyzCtNHvX3oaSTC/qfU6VhWeCP0fR+JVvlrGBuegc
	 aDp4pu7SO208Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C80B180D48;
	Mon, 16 Nov 2026 08:18:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 602B31A6
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 08:18:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 54E20400F5
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 08:18:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vp7Z0Y7ZUJ-b for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 08:18:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org ECC8F400D6
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=212.227.15.18
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.15.18;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmx.de header.i=xypron.glpk@gmx.de
 header.a=rsa-sha256 header.s=s31663417 header.b=R1P8Plgd
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ECC8F400D6
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 08:18:15 +0000 (UTC)
DKIM2-Signature: i=1; m=1; t=1794817093; mf=PHh5cHJvbi5nbHBrQGdteC5kZT4=;
 rt=PHUtYm9vdEBsaXN0cy51LWJvb3QtcHJvamVjdC5vcmc+; d=gmx.de;
 s=s31663417:rsa-sha256:LMW5boEI9ZsHgZk5bLG+RZLMBSnS
 /QGOzIuI5fIXzsaJZNSZIJePPl3t4Rsj1up1JKC4ru9h09k+GIHQqLkLXGcpY+k7wSD0zlUMT9e
 qvt0sUnYYP1FQIbeqkNss6h0ZTT7YY3CJAF541LYARHJf2vcOUPivSpOO9YBoqUz2lNU4lhx79n
 ORxLaMn8/D0CAX9qwzL0m51SIFTSjfWtiCVM0SSAttoZEe2Fd/PRyC0Ili5Yqmh0DnC/KGi+qVm
 36MlMYxa4b7hxOQUNJdgQ45Wa16r5FdKi7gHBVCMLJ5cgY/b59nXL5XepN3JAD4TsdXw4vi0hcr
 JGE/6WGh22jdNg==;
Message-Instance: m=1; h=sha256: uqrXtI37KvAv630uskuoch3GsdnETfX1H2BFUhox7Pw=:
 cFWQQKiK9afDr4rhfML2xM36k+r2fNDEHs70SNjSKz0=, sha512:
 CuicVNfiS1tLbkAfIq5sU0YAd6AzWPXwjJnWVtQaS3AzIllNTTGih2S3n6kF1jD+RxoHtiQDL2h6WVAmaVYS+Q==:
 15ZCN9fgRgJ90chMxNail6zjTDQ5NOEBngoygaJveQ+CUdZjssRewMQ3KLMYplId8zimcIYZIMgChmqPSwZEag==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1794817092; x=1795421892; i=xypron.glpk@gmx.de;
 bh=h0yz9gotEfy/q3sknhUBjgOe/5YJ01863frNCoPXD2g=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=R1P8Plgdi228rkP7W3+FkXg6mxHrBCUxmei/0jlA2yp9NBkNidgfmC8uB9YfFQvC
 yO9shfgRkXHeLQt0eX83MZyK/uPIpZXtjpks8vuCeHNSNCiSi7jSsJiExtrZHJkxN
 TdM1yfP1oU3auFhe7P4mbPtASjzkU4dRoz/6r9zuxM9YCLuBMEO8qzinZ5CytD1+s
 EMXjd3WSd+RzOCTP1Mowe/dq9qaGQvWIHw25FrRoQdXgOSHwkDgKH57pWnIKDZQd+
 pQBxxYTs53Ouhr6cVlN7wR0G2C9xDj0cQ6cC3i/XL6mMRX5d8NoyPLn0D675+FSM/
 ULS1UnNRLBnieiacUQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6KYl-1wMowP0qsL-010KVf; Mon, 16
 Nov 2026 09:18:12 +0100
Message-ID: <b832921f-a366-4a35-b8f1-e43dd2d4f448@gmx.de>
Date: Mon, 16 Nov 2026 09:18:11 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts: checkpatch: prevent shell injection in SPDX check
To: George Kola <georgekola@google.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
References: <CAOTQ16Lwp8m_tDTbiuT_CAVj-YByNJ2o5g_XBHwBNke+tuGQZA@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAOTQ16Lwp8m_tDTbiuT_CAVj-YByNJ2o5g_XBHwBNke+tuGQZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Lm3ot90htO7a/B88HZbg/hwkqlWMtRE1LJy5jzwUiucDzCiUDWt
 TpFUcEJetkQMX2aE+9k0+YHfrr5OrdwJSXsBF1xulmi4C0wOHM52Rs2eDtOCsbNAmMJQNhn
 do0WyVhcJq/nPYKNBdVZmNAqvVQWFXEAu3j24ZrTWyXeKddqlm4tWcerXx/snzmVZa0L+mA
 Fo623MT40M3xUorfHjAVg==
UI-OutboundReport: notjunk:1;M01:P0:VCVHAbtr2is=;4B5L4DUXR7iW1rcYcf+5ygi+0pt
 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
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/15/26 18:12, George Kola wrote:
> is_SPDX_License_valid() interpolates the untrusted SPDX license line
> extracted from a patch directly into shell backticks, allowing crafted
> SPDX-License-Identifier lines containing shell metacharacters to run
> arbitrary commands when checkpatch.pl inspects a patch.
>=20
> Reject SPDX lines containing control characters or shell metacharacters
> up front (even when python3 or spdxcheck.py is unavailable), and
> replace the backtick shell pipeline with a direct fork/exec of python3
> scripts/spdxcheck.py over an anonymous pipe with SIGPIPE ignored so no
> shell is spawned and early child exits cannot terminate checkpatch.pl.
>=20
> Fixes: c261fef51ca0 ("checkpatch.pl: update from Linux kernel v5.4-rc3")
> Signed-off-by: George Kola <georgekola@google.com>
> ---
>   scripts/checkpatch.pl | 26 ++++++++++++++++++++++++--
>   1 file changed, 24 insertions(+), 2 deletions(-)
>=20
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 7e4d6cd227..d377c19a06 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1168,11 +1168,33 @@ sub is_maintained_obsolete {
>   sub is_SPDX_License_valid {
>   	my ($license) =3D @_;
>=20
> +	return 0 if ($license =3D~ /[\x00-\x1f;$|&\x60\\]/);

This allows

foo" <(touch /tmp/hacked) "

The correct way to avoid code execution is to pass the parameter in perl=
=20
with

system('/path/to/program/scripts/spdxcheck.py', '-', $license);


We have

.checkpatch.conf:2:--no-tree

Our checkpatch does not proceed beyond this point because of the !$tree=20
check.

top_of_kernel_tree() stops reaching this point if $tree is set.

If the code would proceed, spdxcheck.py would throw

FAIL: "Blob or Tree named 'LICENSES' not found"

and once we correct this

KeyError: "Blob or Tree named 'preferred' not found"

Your patch is valid for the Linux kernel and should submitted there.

For U-Boot the patch is correct but applies to currently dead code.

What we really need to do is think about what we want the SPDX check to=20
do once we enable it.

Best regards

Heinrich


>=20
>   	my $root_path =3D abs_path($root);
> -	my $status =3D `cd "$root_path"; echo "$license" | scripts/spdxcheck.p=
y -`;
> -	return 0 if ($status ne "");
> +	pipe(my $in_r, my $in_w) or return 1;
> +	my $pid =3D open(my $spdx_out, "-|");
> +	if (!defined($pid)) {
> +		close($in_r);
> +		close($in_w);
> +		return 1;
> +	}
> +	if ($pid =3D=3D 0) {
> +		close($in_w);
> +		open(STDIN, "<&", $in_r) or POSIX::_exit(1);
> +		close($in_r);
> +		chdir($root_path) or POSIX::_exit(1);
> +		exec("python3", "scripts/spdxcheck.py", "-") or POSIX::_exit(1);
> +	}
> +	close($in_r);
> +	{
> +		local $SIG{PIPE} =3D 'IGNORE';
> +		print $in_w "$license\n";
> +		close($in_w);
> +	}
> +	my $status =3D do { local $/; <$spdx_out> };
> +	close($spdx_out);
> +	return 0 if (defined($status) && $status ne "");
>   	return 1;
>   }
>=20

