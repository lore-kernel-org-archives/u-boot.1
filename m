Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3AFBCA5FA1
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 23:00:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9B6F580BD3;
	Mon, 28 Sep 2026 23:00:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cHhVbkVpo1Ln; Mon, 28 Sep 2026 23:00:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org DAB1C80B49
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790636415;
	b=W0YSR8Oe1V8/LLVezjuZCHSfUXp5mjv4tnh50ByrIaZpx8/caRnuxl7zby4FSPSA1DUd
	 OamQGuwEbJVWt2SRqNrYAZ1yrL1Zr8LoXJppBKDUDDyEmiAS9g60mTupKmw1XW9t6Fvkc
	 MxewUALWYESkapMzgLbqAWT8FpPI8pLWhVO36D6DXxxSwfjJ5P0i5POQfOUCF2+dFjp20
	 Bto9x65FthwpTHif9dNjF11nGguNnZplpI4mDxITL/iGgYdQip2qPlQliwMO57FRXYfVS
	 g+TSVgGr+0XW6izjtTSmY1qqWA/AD8shpafFZuphPPuH400UPfKzWepBQ31vOQwilgA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790636415;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=+NfSrK0wok+JTmdQKzJVB9TBuH+vdzyZOdbhHDLVIus=;
	b=nnuWqYi/a7uHxJHDswsyQxC8c1wveXR2LAf2vnA5S3mmXhahVjwM/V6rHtaHsLPFkFNe
	 3HCmE1ysVB988pQKXCiVcIerp3S2fNbp9BOukmkf1vVPmL546FDnVhyExpqqY1I+f7ksJ
	 Q1rlyEIKaEIP9bWIVV6vQT5Wl6j4BxS5ZWhHcZfiaEUz62bpVCbDY2Yl3O7eYGoDpLyVK
	 IJbthw04LnUX0CD6a425Br46B1qx6XZ5gztaPsz96LiJSMVwS6cMznq+gE+twUNf1HPZm
	 GefZyMvXUEx9NDrMlAm6C+n6L+RRlF6yxvrcDPfZmqDN45JJ/PfLh2yBQdywXWz68Eg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790636415;
	bh=+NfSrK0wok+JTmdQKzJVB9TBuH+vdzyZOdbhHDLVIus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ePN/dYjiAqWfTSu55OU12n6b4cz7kBPYzbSoZXXoshmv5IG8LeG91avF7WEffPGOh
	 FyO7Kx5Nkf4inpCCdyOjZ8CoiXDVb1LQzdHZOdR0hCuY2wG2Hp9Gz1ThlgirHgLtmF
	 RlkbohKVd6glaDXd9pUopsU9lfUQHiYUH8UhmtWkyT0BXAHUYy+OKU8+Lq1jJqcOCw
	 dlPUng9k++eN4gm9Cxgc1soybTshUwdGA7zENTGzWXgfLESnRTUFLxxPDJDTzybeLS
	 PI0yOF/+/8T7krr2RlBlODDfxYRY00CVQcpOluYkeXdajBseY6p8arXr1H8sIt6Htp
	 5uCSThZmJZXhQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DAB1C80B49;
	Mon, 28 Sep 2026 23:00:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5705361
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 23:00:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3DF0640508
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 23:00:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZFg4nSAUTSuU for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 23:00:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5EE3F4050C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790636412;
 b=lOQ4/whZcSRFMK7SCfqgqP07YHK49ZHOcTEDiNns0za7sWQaPPZuIG88lZclYp6Sm8iO
 4sNaeKQCr01x930UaFYyj+tYdeCCbyiDw08R/r1bz3Z90oZt14ujouVkKHE5cfaFyRVRH
 z7qLqdCk98WmS/c+oYCec1eedNq58OdgHU4qNJU1C9WMHeFUU2AKXBgbDmO7u508ZrDlu
 3MltbAfbCGJxF5NvPSY2cXEwYP3x3BTKFOymptYUGX0PeiVXcRwk/lfUYgA7x6yAPU9dY
 7tJbmnhypbVkf6cbSP14sZbCMnRtwIVk++S276gq0NrU7ax3FzLslkvuzKkjh/A/Eow==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790636412;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=+NfSrK0wok+JTmdQKzJVB9TBuH+vdzyZOdbhHDLVIus=;
 b=LbGv85ICIL1ay8WI0/rlaRBtQfzGh39I0FhA3UQTz2ejRnwfckrXUTCeXhRIjpwFzm5Y
 4xrGmtGAToT3jAM76Iajh7LjHkISGM7wfl2OCCM05Vim4yZ6HB1HK4VYlKV93vWIDaktq
 RBmSYhUXF1pnpYCdiTaaccscAUUsZB7do7nuZ2Q+Zgvskin0xln0fX0AZhaCA4yw3W1aB
 ObdEaXWxXADyJUH2R/GY0h20S5dIzqcoZMA3jfr79dL0gSgZoDZot61QBZywCZiSVBFyF
 1WeilJzDDi32IzFGWM8BWvNGddmmUZ8kPD2iP2R3L4xXnt8hJbsvydb7gTCjRDmId9w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=VXrtLVtK; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::e;
 helo=mail-oo2-x0e.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=VXrtLVtK
Received: from mail-oo2-x0e.google.com (mail-oo2-x0e.google.com
 [IPv6:2607:f8b0:4864:31::e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5EE3F4050C
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 23:00:08 +0000 (UTC)
Received: by mail-oo2-x0e.google.com with SMTP id
 46e09a7af769-81be5042c51so1837773a34.1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 16:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790636408; x=1791241208;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+NfSrK0wok+JTmdQKzJVB9TBuH+vdzyZOdbhHDLVIus=;
 b=VXrtLVtKGvH/URijwIpe5bhQj57V9TSAM5TZI9vEIYNI0gvU9GsI1fzTFESKQrSZa9
 9QfcHztVRKwx5qUF8PWQ4x2MhpCELmhKSc9jfi0HjU+HzsH8tEYVuij91LOPRRz45X1t
 9jHG+kI+aPpzLyZXLWajyWYF5vgGslnPaVU8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790636408; x=1791241208;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+NfSrK0wok+JTmdQKzJVB9TBuH+vdzyZOdbhHDLVIus=;
 b=bDQNQ+HuF/bqM79DAX6LGlNv/OaTYOaqQgKlNTBROPfd6Zt3ZcTO7t2FuHw2L0udjs
 RxHdPUk/JQqRnVzyycqJQfnHa8d4237u+LRAGQ+GZZynv5VWO8ddC+dEbXVWe7iGUS3w
 9IKjT4tkib/kdqS4YyViTTjmGASqouwuwGZGgODyBgTrEswvDfUDD1L/dusMa0GiHi3E
 GY5kJuRNkD0AuOeTcl8XBdAkn2Y0MemUUpauEIfOcLV/KaLMHGSCdwN3PSydMld/SLC6
 YEpx7z6CC3WXc6RaHaeO/kbYNcrW9SvICaanp93V7/nVJJu87iIyDrqUCHMh9zIy+pFl
 yJzA==
X-Gm-Message-State: AFuF++lPW9Imca/IN/CzNipetT5UFqCKJmtOKbsWymmPvqJ50IbExI7a
 5BksW0eisgqrjEi7CM+6mtfX5TqXHw+DN5DsMaR5pvwM9IciPlBAxSlbNdbP+HG7ed0=
X-Gm-Gg: AYBFou3geBP76lvyjcVuCYa0Ei2PCXLmHU9Apgyc4DnfdVKJDGLntkJTsJN3g/SVxZq
 OrO6cAERtJ8/TmTqWTNX3dgYmZ0E5iWEv2XOh7637AmMM8lXKGv3W5FIkb5AET8hwb/J3KdYhGx
 SiGPVZP49QJSIGxM2AaPB61yxajmi1cTstHh1UUPfMwePghMixbxqOMIROcGjOOBba10GdcpzmP
 6Q3QJ3LXU2QcadnXxzkkmpZvpWrxmeDOR/yVuz+FxCn68xIiSHauPt2cgqP4oP1IC0tiJcYhhyj
 qGtEVHQOXeqQcSiOQsZrrjDJf+3tqdkmGzGX7DzUu+2ul4bsOrFlnoufJq0N/rCXfWNPkKJqRjS
 7bXru0tP7T76Fm/3qGs9mS0wlaNLNwqACyqt4zfEFOjsvljmtvrYLtI631Q009dXnhcYJvYip7o
 nYihZLnH61AgKPpA5Mqznfs7/r7xHGaZQaKZIUE/pQpvoc6Vfmrv6uNKWmO/aXLiAKXUlGu9Jwu
 kxZx1eKiYkjvzyadwpo4sDvPFt9q+2UMp1CQFw3ZLVMwl0htBGUQoj1jtI7KZzNFjzz7AYOIR/f
 QLK6WoT9cqIgRSxlKrXIYFlDFtnmXQ==
X-Received: by 2002:a05:6820:2915:b0:6d7:a13d:fd80 with SMTP id
 006d021491bc7-6d7a13e003emr5440945eaf.46.1790636407941; 
 Mon, 28 Sep 2026 16:00:07 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-81d55dbf7bfsm2762840a34.2.2026.09.28.16.00.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 16:00:07 -0700 (PDT)
Date: Mon, 28 Sep 2026 17:00:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Vitaliy Sochnev <sochnev.v.74@gmail.com>
Cc: u-boot@lists.u-boot-project.org,
 Jerome Forissier <jerome.forissier@arm.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: Re: [RFC PATCH 1/4] net: lwip: add an httpd stop operation
Message-ID: <20260928230004.GY858934@bill-the-cat>
References: <20260928223532.482192-1-sochnev.v.74@gmail.com>
 <20260928223532.482192-2-sochnev.v.74@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+XD61LRdRod76s9e"
Content-Disposition: inline
In-Reply-To: <20260928223532.482192-2-sochnev.v.74@gmail.com>
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


--+XD61LRdRod76s9e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 01:35:29AM +0300, Vitaliy Sochnev wrote:
> The lwIP httpd has no way to stop: its listening PCB and callbacks
> outlive the caller. With the shared lwIP runtime the server would keep
> accepting connections while any other client polls the network.
>=20
> Add httpd_deinit(), which aborts the open connections and closes the
> listening PCB. Open connections are only tracked with
> LWIP_HTTPD_KILL_OLD_ON_CONNECTIONS_EXCEEDED.
>=20
> With SO_REUSE, set SOF_REUSEADDR on the listening PCB: connections
> closed by the server stay in TIME-WAIT and would make the next bind
> fail.
>=20
> Signed-off-by: Vitaliy Sochnev <sochnev.v.74@gmail.com>
> ---
>  lib/lwip/lwip/src/apps/http/httpd.c         | 51 ++++++++++++++++++++-
>  lib/lwip/lwip/src/include/lwip/apps/httpd.h |  1 +
>  2 files changed, 50 insertions(+), 2 deletions(-)

I'm a little wary of adding code to upstream lwIP here. Have you
submitted this there as well?

--=20
Tom

--+XD61LRdRod76s9e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCarrxdAAKCRAr4qD1Cr/k
Csw3AQDeT1HD/8LZKQ3lc4Ey9/FONJbb8aQofKOmak51GT7qwgD/bAqmURhCB0z4
S3X7JFma2lKP2eJaHEsV4AQhzVbO7gE=
=0+As
-----END PGP SIGNATURE-----

--+XD61LRdRod76s9e--
