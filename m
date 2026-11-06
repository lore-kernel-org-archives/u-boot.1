Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69466606A338
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 18:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gXE9CWRz;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=VRXJaWcQ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 40ED780BB6;
	Fri,  6 Nov 2026 18:12:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6p37JwT0W5ZZ; Fri,  6 Nov 2026 18:12:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 90ACD80ABB
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793988741;
	b=drIBnzJan38SYOvwQxhaEOJzwn1NpvYvwHwQtWMIzmuIq9bgVeY16lpRlBXOSIk/x2Yj
	 Le3xjjB3pV8N2KzaLvPGI76ezIW9hjjgCIebvpyw9tDXEByTw5HSrmaZyD50YhOJ3Xzfg
	 KFn0yxJ84sX/o1MMZPrzol9G3n98QDtoD1ljSfB/wPnG/T8OhjNsm9+LUBH92i5exvGeO
	 m43gD22vKKFmL3iBKvOXLQQK8k4pofmSvpFoYg5bERCvWrA8+ZBIAj0/Y4tjmT0EMyV42
	 e4XutIW8FkDIJPS+/FqfDLG/Qstcnxc1B1VRyLDku2tCJRfA15Uxkecfd45TfQA/0Pg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793988741;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=U93iM3/nKSc8slH7LQFDfoSnWC8TkoizKTGxQz58RtE=;
	b=rWmrFPYLgPoDvHP5RAzJ+E8RlfP/274wJBlUIcIb7obalbhFVix9y/LpAZ4jzo/pW0QG
	 HOmBF264F7NLiZzx5g09k7wnMlpGPorIpbj596JtMWfi26anC+PjfUivBpD5rAtVp05eI
	 d3dvXhH2A24iYfspC05JpDV4iAWDWlhuuq+P7wgJenNDmde5nDNidqeQrFKiZiBAJf7uY
	 6B7Ym5dnO/M3X9LseqW5cN//mH32QDkHBEyu94G+gpN5bL83ZTKybSUh6OKiVA/+NKMrp
	 3tqtvF57SX20v/DOr8EySGsq3HvHkcIhkELVAvnRSfcbbfVzXJBosexC72qvGHyhIIA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=VRXJaWcQ;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793988741;
	bh=U93iM3/nKSc8slH7LQFDfoSnWC8TkoizKTGxQz58RtE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gXE9CWRzbT3OZYdGUgVxhjQU6DVzut5Csseg4XmqhiCR77vJMFCrp2Gg97nLIJoK7
	 6EsJDkCp70nj7kTc0JvUjHTdDJ1BlgFe7XoGZCWOVNBa7mktAz9lGMhFzOa5HWU89Y
	 GmG7SIaoWIKHPup9cyyHYohw5+XcCLuDZsqE8GJgcKSFBP1FZOKuhRS36C/KxuQ7fh
	 S5n3XcMH+iaajS4Q2bL+Qbcvomlnc31y1hJysflbu4syTSvLx+AeXjgACo89jVUS5e
	 RNEtkfveGL4luzM4ZCD4eqXOUon+nMMyej4g91Tmw5pUFGPv2R+46sjC/Lr8XYl3Bv
	 AtA2ZmzkPeLAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 90ACD80ABB;
	Fri,  6 Nov 2026 18:12:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id ACE444B8
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:12:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9E1AA80ABB
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:12:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ynpJlwYlkmxo for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 18:12:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 02A6780A83
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::331; helo=mail-ot1-x331.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=VRXJaWcQ
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 02A6780A83
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:12:18 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7f84a55cc06so653574a34.2
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 10:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793988737; x=1794593537;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=U93iM3/nKSc8slH7LQFDfoSnWC8TkoizKTGxQz58RtE=;
 b=VRXJaWcQc0QyRszXRKk5rP4n8/xnBsC6DBIDvQZjTJYgBzi4lyQS66ChZsNn3q9xRj
 SxZ9OZQEfb2jqjQAGzpQ37sgJs3q9hSq3Qd1UmwUW6fmvjui/6RePpfU+FHGOpYTm+dw
 19Q2g+CTz2QwNUKxNnDnicgJL4GSXGxcbZVu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793988737; x=1794593537;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=U93iM3/nKSc8slH7LQFDfoSnWC8TkoizKTGxQz58RtE=;
 b=PB+/J/EEXwf3M0Z0sJYSX/jw59KO98+mR7sMuuek3CsRL1jlow7zZPt6BL6Q1ZsBII
 l6fb4qaBNOncQ3eLRaFE27LXb8hD+BUnCA8h+2gFC2JA9XhggBDf3d69ymxdrpTkCJIb
 8xLwzEoeMkCdKfRl927r7uatBEk6S+DcJSOJFzX4XYOnytU+zyopXpr4+yh9/cnQEtu5
 +2ONda6HxuQgLdBoLwWx5j0XGBQWmRqSlXfVtMSNaXpKFCO+0ZWK080WRFmesSkLRvQP
 t7gxsTF/SNJjFG2lRoiMBeqHBetowU92CDoQWTXTV5rMoxMVEGjfibYeBKFncASDzsoP
 2y6Q==
X-Gm-Message-State: APuU4Z8dH9PbMcM3LqWvZhx9Zz6ndX9Kh4O92ciMOVp+gbRkAEyDAJgL
 VlxgE6uhknaw64VEFJDqzbH4fAtu4x3rx6i3ZL7WFOMGKFsjIAk6xEa++y2sBwG1kJQ30ASReKe
 SU8eVF+eoB2UX
X-Gm-Gg: AYBFou3w0V6lZdZg8z6cX3ZttfLF9Jtw7tpTpGOonGocMMsR0B5awVLgMMFEGZaoxai
 KmNVT0aFKM16WnAcJ1mCbklLIV97PgjN5H2/uts+D/QuO/wmjfK5AekOkcCn92SER/sUEriycp6
 KvfSjQtvdBcOIVQTzES6Bl8dfMF3ZJp/YuovuAWisYC+fI7/AA2cFKFb0Ft+tnlemN4a92tow1W
 dnD2RlRRB/frU0x09VgpDV0fCAeD2wltB2xy1Y+UnVQy2bdDbKuZkcQ2ULZLAyQnMSHjp1a7KOR
 Nn6uRJf0X0+Mwek+MCUijIpVWu8MthaWkPp7GnfVP0FGT9A/R9aMCCNtq2surQOByPYB8JzBiWw
 esQnjpsD2d44cNlh4H2fPuLk9J+j2NtsdASC263YFvnlz/oxkgB7Li3IkYWhAOODj+KnLF0FJRn
 LunZehU83yLXXbjK7GcpRP1QnN5y94bhQZdSNuYhBling0PeuWBBFtJtSAsMwK6aBd7Cd58lQ2+
 qYcqXI7JyQ7h1VGSJrF81PsDpy3L3i1AhT7iKtWyVZZPHh1auyvkmSpmDj94LCuNjNGboovnV9n
 8S4+palQt2c/4mVr9BjSlSdyH0WBsA5DWUtiVaG5vdVZ4W7MuYEsT0xytKU/cVP4GkIn20ZVAQ0
 dSpkm1fbRaGAIvMRQYbBrj0M/tHxWtSQCVloA1Cbaz2MM+DJyQY7b+5CC6iUHCqAoo3flf05mNd
 YCjas3Qq4N0VZ4MwC2OXC27Rrylbqz8sSlnhE4uujymi7XTXdf98U=
X-Received: by 2002:a05:6830:2690:b0:81e:bb4b:2324 with SMTP id
 46e09a7af769-85f1d0e8df7mr2930360a34.26.1793988737613; 
 Fri, 06 Nov 2026 10:12:17 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85f1dd234edsm2429793a34.16.2026.11.06.10.12.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 10:12:17 -0800 (PST)
Date: Fri, 6 Nov 2026 12:12:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.u-boot-project.org, Michael Walle <mwalle@kernel.org>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Yuho Choi <oss.patchbox@gmail.com>, Vincent Jardin <vjardin@free.fr>
Subject: Re: [GIT PULL] Please pull fsl-qoriq-for-2027-01-rc2-1
Message-ID: <20261106181214.GD3669968@bill-the-cat>
References: <au0ldYATeuApmixE@nxa18884-linux-1.ap.freescale.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="It5n0dcA55UrnOEs"
Content-Disposition: inline
In-Reply-To: <au0ldYATeuApmixE@nxa18884-linux-1.ap.freescale.net>
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--It5n0dcA55UrnOEs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 06, 2026 at 08:55:17AM +0800, Peng Fan wrote:

> Hi Tom,
>=20
> Please pull the other round for 2027.01 rc2
>=20

Applied to u-boot/main, thanks!

--=20
Tom

--It5n0dcA55UrnOEs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCau4YcwAKCRAr4qD1Cr/k
CjOpAP9W102Gs3nX7nZd9NNufITbKeLVYE9X8Fnvj7AaHnYEoQD/X7mWMRgVi0N1
OmCTPbF4IcP4pv+UsgvePu5tfqMy2AM=
=BV2V
-----END PGP SIGNATURE-----

--It5n0dcA55UrnOEs--
