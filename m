Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA3C6076B47
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 17:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qYvmjbn8;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=PICrNOrs
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 61F72407C5;
	Mon,  2 Nov 2026 17:46:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ca4yuP-EUBDx; Mon,  2 Nov 2026 17:45:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 71974407B9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793641559;
	b=Mf8Rf639TsyjlUAWIV1zXOD7YPXRUTfbZy2o3fpgkflXKPl8ViYF7Fdndfj2q+ffzFlV
	 XfFoFyUWaA1zoTAXmVT2vS0N6VCWPoJAlNUjEh+mJgyr5TVXm5N9JrmYYjcBnVZVl9RAC
	 SZKafm3TEz5rOE0jzgbMfPOM10y/rXC5P3Z+QMZY3xykEv0gu0ZF2PA2+9OIZZPGQlOzm
	 HHb2Ytj+CQ4RZ3JJX+O85E7aAnHHmx7vbTZ/ZAzxFlDlhR4WbemN1uTGMfJVsQFzuKoxC
	 lj6xnsfzXfvWCbvHHb3j3pMM/ZzE3R+3NoAsH/vig39/5/EVZVo/GhDREnoycUWZprw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793641559;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=yocxjE9gfeDhVpboPn8wLVnWcp36XuAmsQFifrQuyyk=;
	b=W8tXJBZ8+d6oLtt0YjzEt89UkxWNzKlh+pimtGHMFGYvakfQO7HJ0Zs0HNIzNuSyMCpX
	 rAU0r4v1FEJG4mG7iRnlfRN/dqysX1nj3hE/wxHyd6aEhvY1M/T3OBTcgiuIrlunfYNBo
	 0Q9Mcif/GsjrFdn5tHD77pzmcyD8WkvwdmaW1NLUIXQlJaYoTkRWoND9TYgqbmcC3avda
	 j+UNL7Pw6l8zXBtH6DYoC89HVmlwVLrV34vuyHCb47enfFjlUzzC/M6K78V9YvwUqkELS
	 3L3WwbuCp17pP1GyNw33SHjMEzfsJuHDP8NXGdsOcHhKDVFyfaBa9th91Gh3qjaFx3g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793641559;
	bh=yocxjE9gfeDhVpboPn8wLVnWcp36XuAmsQFifrQuyyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qYvmjbn8qztwj3u/quiPwZ1aulfEPdwyELAUwzbWVLNbarF0E/6qZJKyItidzhLRU
	 p41YhG2HoJFTK/g3NGRyrpIAb//l1JOoWG0Gtf4vHvLMVk83wWFuU2PW3fwR65ty7f
	 MBNX2YJGA2wVajwHPlTFp2MACpWR2gbn7tbllniCN2g4zoJJHl+KGlK7djRmqlrxnd
	 NhGGZUJ2pBP9FxJEF+w5dxKLLYfsbLd/Xm+2xz+g2GXZO+NOED4IUNgD8F99xVqB7A
	 ixUPfeBNys8Wi7XOOI95RY95ugfBVJDklFawFRM3qo8ynpXSOl36ttzd1nniI6rsrY
	 QutchuFhyrrHQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 71974407B9;
	Mon,  2 Nov 2026 17:45:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 63064235
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 17:45:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5477380FFF
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 17:45:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id efLLNXFx8mhw for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 17:45:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8C6EC80C26
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793641557;
 b=Cu69kbBCNCW0QWc/LS7fcP4weADhvhnd2s9b1YVOloOTRpaNpAW65jr0S8ZL5ltukPV5
 sFP2cQ1TVyTo5kcdu1mfITNqyuZ3VivLPqBVEmTyKQAN7SHorTlMpVre5Krosa0A9SXfi
 3h0VIJv5mgAEPtPbcU7+Sp3RS/1+zlsqPin0Uz6fxemxRB4UxDVhXnjWCwtm5iFCt8Wb3
 YYnxuKPMhZgS6BAr2DqJh6feB120jFQ6PLOsJO0cd0k1ZaAFqpHVPeIfJJC81DcYBTFI2
 gz4bRHY8sfk1f9GiPHRh+SoKOl6ndQKB5nVLltqIiiDVKdk+HQVldcdofRD3LGApQnA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793641557;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=yocxjE9gfeDhVpboPn8wLVnWcp36XuAmsQFifrQuyyk=;
 b=XoXWKreQToexURM5tEUCco0M/Kte/1+kkOuL5JYXdegG1Stau1Nr9gcDDxH6VSVOisfa
 QKkRRYUH+te3M1WgOFD25/PLxzqrwgK4+YfV1PZQniuQXFeimS1rEdBfevQLs+4KKMbFW
 S+py/0kwIgMwuqKGYprQuFFPgMK3uZ9ZQXMX2Y6NFrAKycgb9Gb95PdirlwVlvnFDm0KF
 3McSFMPLd3O0RUjl0HLyjMDozlaRbc95Ol7qvGTd8PLdn8OQXqAWAgCagl5mBlfatP7D1
 dTJVpcyR5oMzIdfVkCW4S+tmNTAHMTj0KPLQTFQztMLABflDk0cHb+I1aSGYfGI2lYQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=PICrNOrs; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::335; helo=mail-ot1-x335.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=PICrNOrs
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8C6EC80C26
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 17:45:57 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-8446af403b5so2189738a34.2
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 09:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793641556; x=1794246356;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yocxjE9gfeDhVpboPn8wLVnWcp36XuAmsQFifrQuyyk=;
 b=PICrNOrsj2Tx7y1o29K4udCmfL8X6eIcCJxxjCEEtTanJOQ8/8gFHezCg+HoWHOxrL
 HT0VD2sPdNX2Tigt/1uuEY5PrAJPSes3E5M0RIVHhLaxEDqhEic8Vtua9jhk9Qk5pLYl
 MZIjiPzFhkL7zN9ltEpTioUlVHxE4pBDprbNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793641556; x=1794246356;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yocxjE9gfeDhVpboPn8wLVnWcp36XuAmsQFifrQuyyk=;
 b=Uj2tAKNpzSXxVSI4M6jnsIsxSfXWzD8qD+X2uQYGuzgYysbDUiDqmCMKnDysnjO3cN
 YwKpeS6cd7gYo59P/q+IbXo2elNQorr14ru9TtFxyZmQG7JyJ/gj1hpTNfIwFoxQOCC1
 RPHhGubE3zJoePA6ReQb5KeVfCenRwbSMm5F9PeC0GsYq16B41LfuHOshNspt1+s48zA
 xbauvxhUnk4GLVXJVUnA5BQ/PeNy9PWjCL0P8KXxjyFsAcQi1VUuckBBmO1Lmpcr900V
 JBBK6Wd6GLkg3Y84oOwhJUbldfLf8fHA6UC9biiBnOtQCPnGzD7UHhWjhgehLn+js5AQ
 wJ6Q==
X-Gm-Message-State: AFq9FYItfn6wg4IYLqzLinFVe5zBOtQhgQCSrUdWZD4zxuTqOomkduOo
 07AzMu3nBTvsDxfLCITakrR6NcXjhZpu/oQCAp946fGv8q6zVSLS4FYkUnPS/BZibN0=
X-Gm-Gg: AYBFou0nsO2RadNjooDcPyjIXgL5ccFU0rq73/HJOlsgvlIZhNdMGc3gnCDUAQnTVfJ
 OLPWYrrrc6TVwLg0gpC6YRYiMpX7ZGu5OsEAaCiuOc5Ztb1Jw3dB3wz3JnQdWUED5ClaQe0M9by
 UU7r9uZzpcmmj4SP9bdFzViATKPnVJtVXi782oRa/hAOijz+Cc2Qpbv9ag8bqKmt0k4XEVPpV6r
 MgjPpSL5ZZUcTtr8KpHWdLOZ5LFhlTx/kRuBM7yphPoS++KloiWlm4IkYbitXBlZvahiU14FS56
 YsVwiTP+WuXHstywUCs94tEX0t1ljmF52nbVhRlDMqVrEUFNsspzIvUX4BMTsMMUgq4sblPeNYw
 0K3PZMrjGz1cxH5I0yrydPBGPFTArgOS5RUfx3GdiodMfApSgFYiTng5UCLPdt67pF1ZBRRcf+j
 bo2WNrGoSrRoWkthFioLu/p7dsB3fbmt98+Au2tfgKbLB0bfx+pqLd/9pPwzPSkID1PCkHUL7bu
 QS4n8vnAKkG068k3XN24vNZ2wNtehRk7OvosHNFwtRwPca3pPdBlF1h9Gl8+O2vItdPIW4p5+M+
 qAZT33DfgHjy3bukJJ4Ul4IuUEGmiOhRPzgkLQfFujEV3wapFJ2zamSie2Wr3mBqpAtlY+C9y5M
 4s5cctRpcFkW3HtxCuoJTeVduLvHpvQo5wtfrnP5Yv7ym9ZkZwjTpitL1uSsaSe14x+m5AcKmJj
 Mc524bMvOgRqX9XZFD2ojz2Yyr4xOwjA==
X-Received: by 2002:a05:6820:561c:b0:70d:cb53:ee92 with SMTP id
 006d021491bc7-714f23f8977mr3259764eaf.14.1793641555971; 
 Mon, 02 Nov 2026 09:45:55 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-714f2a84854sm9505002eaf.2.2026.11.02.09.45.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 09:45:55 -0800 (PST)
Date: Mon, 2 Nov 2026 11:45:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Ana Bobillo <anabobillo3@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH 1/4] boot: pxe: Refuse 'include' in a config file read by
 a bootmeth
Message-ID: <20261102174553.GH3309461@bill-the-cat>
References: <a601d668-436a-4aa7-bb10-950a89d324ed@gmail.com>
 <d405c1cb-83e6-410b-82c7-b6696ac25348@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="B/LmdLsH9L97OGFn"
Content-Disposition: inline
In-Reply-To: <d405c1cb-83e6-410b-82c7-b6696ac25348@gmail.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--B/LmdLsH9L97OGFn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 02, 2026 at 07:03:48AM +0000, Ana Bobillo wrote:

[snip]
> diff --git a/include/pxe_utils.h b/include/pxe_utils.h
> index 817305dfd28..95b306c5f10 100644
> --- a/include/pxe_utils.h
> +++ b/include/pxe_utils.h
> @@ -107,6 +107,8 @@ typedef int (*pxe_getfile_func)(struct pxe_context *c=
tx, const char *file_path,
>   * @bootdir: Directory that files are loaded from ("" if no directory). =
This is
>   *	allocated
>   * @pxe_file_size: Size of the PXE file
> + * @no_include: true to refuse 'include' and 'menu include', since the P=
XE
> + *	file is in a buffer with no room after it for an included file
>   * @use_ipv6: TRUE : use IPv6 addressing, FALSE : use IPv4 addressing
>   * @use_fallback: TRUE : use "fallback" option as default, FALSE : use
>   *	"default" option as default

The rest of the comment block here has a specific format for documenting
bools, as we see in context. Adding 'no_include' must follow this style.
Otherwise seems reasonable, thanks.

--=20
Tom

--B/LmdLsH9L97OGFn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaujMUAAKCRAr4qD1Cr/k
CnecAP9l2mlHNLWtjbPl/40FmX+uT/kPevF7HU2BBKHB7BiYiQD9GuVU8x/WBLIp
fXmSzXv/J0R8tU19TnFOTy2fdWJuqAA=
=isAM
-----END PGP SIGNATURE-----

--B/LmdLsH9L97OGFn--
