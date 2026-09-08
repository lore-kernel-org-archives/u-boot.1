Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 633B2C79F99
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 14:25:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1712A60717;
	Tue,  8 Sep 2026 14:25:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sXU2s6yG6aFu; Tue,  8 Sep 2026 14:25:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 487A960710
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788877553;
	b=EL9U1kayprk81A7JsjafWkifncoOd4D0o+0dTI/FoTkWZ7bevp1EP05+v1q0CQtbty8S
	 p4jsBHNCTj2jXSsvBTo/9gLq0OdF+anh4F9XbD6+F5dSNuSnmuxGO8JTZF7CZNbPfo2XD
	 WwqT2TLvwyqb7oXNK0B+aIaESG/CzZiwt2+Afk5y53zQz5K8aBtBhKnCydATIwIr20ecG
	 gJO9VqbU8ZK03T32l9WgSnp8u7DaZvTCwlhfYW+5nWpEqaRidE7Rbw3dV1t7V6oeABrbe
	 dU11GxhsM748SuKNudZQvUMBN4a/YK9QlYvTNS+cQiP/e0XrS7Y/zb3eIKzmWuuXeQg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788877553;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=xVCfRgY/NhmM2dm9ChFppxr+vQSjDm1xRpgrA9mCVAk=;
	b=p9A4Gmgg5E/wmJKVZH5Oci1clvoDknGs2c67ntQGv0NgTHr/O7fIc5sMNKta1K4rhEeC
	 UkLFEI+OjWBX4eugxmcx2T5Md1dQjubmsKwovV373DNc3xc2/JqmOOcGVIJdZVzeg47Np
	 ZJCzNBXIGsmWzCez7ffOV+vfGsKE5YmAaEzgd6WO8OP+sj8uKvUT2H1uWdJUQePT5VB8n
	 5KZsGY0LA08L9nZN3hlc78v/bOoiX7n+1nZBOwfQYsqLF8i4N4DkLP5fhKCnsK3Jd4l7q
	 kl05aYKh8+giAydCjZgL5hPEFPZEnN5SUnLey9/BVYOrKiqL1tA5DZV3oOX8Txtw2Sg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788877553;
	bh=xVCfRgY/NhmM2dm9ChFppxr+vQSjDm1xRpgrA9mCVAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ROrcXB0Igd9IODNf0Q3vLWS3ttkNSN71J909h9TbHrKnOtcyJMeYYkw7qrleVK4xz
	 OxsU5OhhATymoyGfiMoEUyTLIYRuN9StsUMyoulgM1WAS/8LOl8GCDMeHZwBQhDJzK
	 /UTEo6vommGB4bKb5ER5r695y44uQqniSD2D/NXSkgsW8nifHDmYOeefso2BWKxdFj
	 wiKRUtXHDMpQHBPRhgYQrk7nPo/rqBsI6hxy4S1HOpUoWTlTBoEzAT+wANHGP4bpwX
	 CZTNLvTA5drH1aoCfEy83xsfH2/iM3OTmARrvfRHHTChOm5Sn3QqOhYQxurE2LLwpX
	 J7jj9B0Ps8Srw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 487A960710;
	Tue,  8 Sep 2026 14:25:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id AD9C0230
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 14:25:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 92D3380A9A
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 14:25:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tga__ocgHz4W for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 14:25:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C1B9E80A92
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::333"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788877551;
 b=OU+7TUbyIO++vmGGHr25vN6QgC4xbJ83IvJd2kj2fXXMhE0WNPivqm42jf/5FhPez7zr
 +cdkorf5P1KaimFTuh0AOvaw0ODFRaQGLqNfjw1rt0BB35cP/MJ9WWyLEjuKlHQSQcxs8
 kPgi3CKSWfnM9/8X3+ElxVu0nTmHkzetMU+cbsQtp4qVn0keBDTkSQBDWhu8VcgsxC6qi
 5tAiMkU4jhtjrOUdHqbDre+tDjA0kMQpmzuqpH7sxjnbWHyq7UYruN/jHjza8eGORQ9O/
 t4xXeXgbIMSBItt74emUKR665PZ9bQcDFBAIaCRlkyqN3PHhm/iYpSr5g1L73Iw96Dg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788877551;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=xVCfRgY/NhmM2dm9ChFppxr+vQSjDm1xRpgrA9mCVAk=;
 b=UIzqZkJASaZfYBxN1VnNAf0jdA1i9HTypT8lmjxMp38mj640GwQHxMC55qsUVIENr1Wx
 EBZ8YOCfbVDnpl/mqkLby52Dcs0GxEGTgpgyVyQb/Vg/FlhZ2djNxYgZZyPrPRN+idhrM
 pxQ4iY62QA+bXAIxi5esgZgBCTP1g+aGJRimk0t0X9hi8QdJsCROkTGhwcMEz9hMAO2k9
 5sinf1eERVXRVDeB7fBgEZ8eQ5DJqPrqkU8QUIg4YIeBncDlcf50b+3+4fyio5xGRtN+3
 iA9YTEzGcon9twLqAoW97KvLVgOKw54qeAV0r1vKX783VyBPg7jXmscVgyFkbH5jzHg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=nEEBg+WZ; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::333; helo=mail-ot1-x333.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=nEEBg+WZ
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C1B9E80A92
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 14:25:50 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7eb5bdb50fcso3964067a34.1
 for <u-boot@lists.u-boot-project.org>; Tue, 08 Sep 2026 07:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788877549; x=1789482349;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xVCfRgY/NhmM2dm9ChFppxr+vQSjDm1xRpgrA9mCVAk=;
 b=nEEBg+WZDMYK3APl01agAI1bJVYOGJHxlx8qufnQMKoZKyEHotTfWo98iSBcSmD3Oq
 fI8ILUrwyq1V4u4i7Qy/7tCsG4lfcOG6lMj9qaM2yJqoNPv8YFBMlHAZx/DNy9iCS4uz
 Tp1nKexRet7YlgzI+2sHeX+AShvESBzey92RE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788877549; x=1789482349;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xVCfRgY/NhmM2dm9ChFppxr+vQSjDm1xRpgrA9mCVAk=;
 b=YW/h2LEQquO7dWV2tBTc4gECurNIX06JeGxMGc88XtTUy77uZ7l3rdIgjILKmwhw2c
 yLiU+9kRjPJHr5lbEz5u0Vyq030fNedQeVOVLvloR2uqgVXMA/Po30zdWnSTGTyEc8mS
 zor4BS4m3t445CZXYr/Q7AFGwd6IaxwGeIBPh8fTjjg8CEywkTVbQW0Qkf6ytrckPhgF
 adZ8bR9HjCwGH9lp5dPF8fiZXIySi679z1LdNd7dlgCXMrV+R1cqj2yOrCvAwSEpErap
 1geEbHF5reQZQpi5Gz9k4RbJtlJLfsDZr/hT+6K/DFRADQAMlZsiNpfef7p6iftdRfo6
 vEag==
X-Gm-Message-State: AFuF++k9VEpeAj6GPom85WCzpg0TMvWb8UA5U+ho2QI4l92fymBgMRxY
 AT4xfhN2jiNYdSPOS0Hxec9A6MF4/nMqZDc0dCGsLqygmTylFSEXqQMc2avGk97i9Cc=
X-Gm-Gg: AYBFou2tmUfplWLl6j1HQ/odn+rNtDxvfaP3s2RJYv7wgtzV6HT5bkDkPiys4SSnKTQ
 yiNDxutRmEB4CeNib4q+cHs1O0vKebzCwCgVzq2bs3te//YazSabeHFbLbq8OJaxMF+ptbDN80z
 O6AbKV9eSC4nhHQJ9CqI25jwxqlOD+Fxfe35W7Mi8OLCP6NgpN5+5ITnXeRqVJsPvIhAhlGb2BP
 LqGn1pYpM00WhJ9qp7Hfzuzmr76wqqS5qELT+mBD6++WiDTlhUD7nqS6fIGgclK3Se5ZXOgGyac
 vB8cM+AQT8WIEbybE2TfJ8heKniFWsxji2BfoKhEs+sy5KuO3bx6N5DYvX1No5o4ybMvUT+V1ie
 tNPGCXmUtz8Z8xjvKGa/xAPEPLb9xzXU1fH2jz+06nmJTuw8YqVOdBNkuLbmohmmxa+mGiZAjjl
 GhrVx6R4/BtThrnYtiQw7GBhPMGakRequi3w8oTS0GtSCE9haIrEhkPS4Jb6Xfhzl8i+hNhFc34
 b27DHUEVTaROI6AsfojhEJP7/yMRs5NhyCGTxeeCaYx2DQ5RHWX/zi8qnltRy6HFyPqNJWtQQ6X
 azvGPoSL2zZtI7K8HbuQ
X-Received: by 2002:a9d:65d7:0:b0:7fa:ac4f:77f with SMTP id
 46e09a7af769-7faac4f1770mr10347927a34.30.1788877549146; 
 Tue, 08 Sep 2026 07:25:49 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f9f72d3d3csm14785976a34.18.2026.09.08.07.24.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 07:25:47 -0700 (PDT)
Date: Tue, 8 Sep 2026 08:24:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Yixun Lan <dlan@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Yao Zi <me@ziyao.cc>, E Shattow <e@freeshell.de>,
 Eric Chung <eric.chung@riscstar.com>,
 Raymond Mao <raymond.mao@riscstar.com>
Subject: Re: [PATCH] MAINTAINERS: add new SpacemiT custodians
Message-ID: <20260908142406.GC1764417@bill-the-cat>
References: <20260908-00-add-spacemit-custodian-v1-1-7f9c8d8150ee@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dGo17uoZym+FLAGZ"
Content-Disposition: inline
In-Reply-To: <20260908-00-add-spacemit-custodian-v1-1-7f9c8d8150ee@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org


--dGo17uoZym+FLAGZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 08, 2026 at 08:46:13AM +0000, Yixun Lan wrote:

> Introduce SpacemiT custodians and document custodian's git
> repository and management information in the MAINTAINERS file.
>=20
> I will do some u-boot development for SpacemiT K3 SoC, and also
> help to review and test patches of K1 SoC. The idea of having
> a separate tree from RISC-V realm is to better handle SpacemiT's
> patches which not all RISC-V related, and have better dedicated
> CI testing, also off-load some burden from RISC-V maintainers.
>=20
> Signed-off-by: Yixun Lan <dlan@kernel.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--dGo17uoZym+FLAGZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaqAaggAKCRAr4qD1Cr/k
CrzKAQD5UywBeeaa6mIesqzQWfxecRoGuE0D61hHEOY+unlZDAEAqC1gVnNJvyfo
cnhxGFjvcOEeDf/btEvmKkpM4CPLiAQ=
=rETp
-----END PGP SIGNATURE-----

--dGo17uoZym+FLAGZ--
