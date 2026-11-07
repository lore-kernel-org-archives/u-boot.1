Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDC8606A32D
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 23:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=AvOfIwUN;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EWXAc5qw
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9AE4E80F81;
	Sat,  7 Nov 2026 23:03:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rnxSZjxoxTOl; Sat,  7 Nov 2026 23:03:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EC37880F7A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794092605;
	b=P8LyoZeKo2LH0+rJSPd8PSwkYPZeLzSCpkjoiP+HCIMynYUsLUBV11QjEAkgX58/qhty
	 nK2YpvIEw38IcWM5W/W6xqC2yheN2ZIeWNFqz/B5TmceYaBm56NBFRewqYD+J8znC+SSa
	 en/eC+MM55yhDrzqKRdW9geQIUR7vXAnTRI51ZptlofE32v7DsU/04Pr2cMuJSbnAff0G
	 6zk0sIYT5gQXaJFSu/PhoX5Cod/dC9Q400bIpywLRAcxcrXiK6Cf8U2Fde8LaSBBCIpPT
	 aZY86t6du8/Vsc9+3BYw4nbVxaG3ke+mxBXSQ+thXR97yCVxgTds0NQJnDZGSVYLgkQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794092605;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=nNC4ERvwGTBYoyj1GWtgHHBwRr+tdD+Q9FeaRy86gMo=;
	b=Q2vkzXzwd16LkpDcY67FWP6f863K9kU+VbovOJJo/ZsrnnSSokj9DcDl0cwNAdc5ADcS
	 vjzT8yIBVbCCRQREeMmxm5VeFKhc1pk/W+9aJye6KgiEn8Mp4iY7hXtzQorkXCtTcyGAv
	 LYSZuqE7H3fsQA55eJn07Gn2WPWYFhiVt9UmKemPL97elMzlpEngbPovlcsEu/XpPnEYb
	 v9Jzx4DbCQjdZrIZBIh/YdC3EQ8+NQgMSzaTEoc7FulDEqfiprwnA2en9X3IVKHxpBS2B
	 gpNkSGehBHuIncWLFems7gyiY1vyNL9Q6oIarqH6gxGooZ3uDn3dTGzj77bZ6CfNm3A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EWXAc5qw;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794092605;
	bh=nNC4ERvwGTBYoyj1GWtgHHBwRr+tdD+Q9FeaRy86gMo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AvOfIwUNerzwrlN+3W96Un4XMz23KSTu7ABtLk0po8LgV6AyiaO9X7nzE9oAdT0zg
	 qSySZUQcKATMv2uVKQHNul90fjw8QivIxXSEeX7unqfFjhh0eEwvT7gbDEzSuUdaMj
	 JAb1Fd3w5nEO+SPvugzdxucjlwLosB90954eacXnxNCZDkEw/0ptfBbNmLwWDT+YFt
	 p0sEdB49aLNQem1MQWCU5Nx/yXnnRSisdYJ7Lg2bhGMk0LloNIxZb7HalSuEBYRgQg
	 m428AO+8LEM4j8clThFUA0MbZMVoQPlj2IIxiy/OMlmrpzdIWdJk71C9dDpIIYpI50
	 GUXGmYakWYtNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EC37880F7A;
	Sat,  7 Nov 2026 23:03:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6CBBB1E3
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 23:03:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 30EE080F7A
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 23:03:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TNOjbdOcojTh for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 23:03:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3DB1E80F6E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1332; helo=mail-dy1-x1332.google.com;
 envelope-from=malysagreg@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=EWXAc5qw
Received: from mail-dy1-x1332.google.com (mail-dy1-x1332.google.com
 [IPv6:2607:f8b0:4864:20::1332])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3DB1E80F6E
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 23:03:21 +0000 (UTC)
Received: by mail-dy1-x1332.google.com with SMTP id
 5a478bee46e88-37071c0f42aso199325eec.0
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 15:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794092601; x=1794697401;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nNC4ERvwGTBYoyj1GWtgHHBwRr+tdD+Q9FeaRy86gMo=;
 b=EWXAc5qwJ9yV9dMyg7A2esG/lwJ21P0VSIc1xsy3HtI4y64IumsXWH/0tlH3xaqbvs
 vXrc8QdIXhQeMjxWBD7B4ZH8kcGnFreNTKMryuQVnBzUPLGjW20SlyHW12Em6/MJjSMD
 MSARhtpPkPZMncrTlQz2+fHy5Nt0s+DOZNWtlcWkZKs63U1bas7vAqUhFoZhcSn3lvHk
 uwlAauOnBc/zSAlgqSxFo0hpHKh2j6++hx9cRZVlUp6GYD0qjUrsSzyekMjwi3s/Jfuy
 Y5JvKIOcTPwaFjDGLOPmIotEmTXMKj1rjv919PV2nT1cWaT3DZVwYh4mZWMheSoe+IDl
 V2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794092601; x=1794697401;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nNC4ERvwGTBYoyj1GWtgHHBwRr+tdD+Q9FeaRy86gMo=;
 b=gNF9I7+2IX8BkBTLuzgE1/+AeKmp4WHaYqzNM5CI9f1oOJ+oKPHH+BgJe6UL8Rp7IJ
 jqxGuVFoiJFzQ1gtcTg8vs5/padiDlZ8JXTBTbWYYzjOgSyV75YOZFpQIiPfSn0Idl9g
 jUh1pfZwhks4CPBFqe0WrTOomlluLfWPrjHTOr6kMkA+UHvnXuakxkgVNMu2bMeSDV2U
 nLsjb3oa3d+iicUX51WLNpvkvOALzryuAIoKQ8BUzIW8zFC1GCRvbI8Ti5WK3vvzYQiA
 fyqzHL6l69nWedk6jnJ+Ym7mgUJ7zWz9LIofAZT46ZlZCcxKpSFQKHByqIUlJEY8MazO
 7b8Q==
X-Gm-Message-State: APuU4Z9A8yvzUSnBVeDNMSDVurSMWEErDqLABIbCPb4OzEdipswE7gcJ
 zqo8k5T6gvVSkckAiKn/flQdKTlgvA5t7yD1fi3DDEmfpxyfUlqHKYsgo7aMWpWp8WdDL0tESFx
 H967byn+i7ToB4medwrqDx+m3ujrqJw==
X-Gm-Gg: AYBFou3kDzr4FbDX157IdpCu7wIRveZXv24c6zlXOVeJxaaAg2/y0JdWSELnAk1duJg
 lxBAakUjOrxo4LUM/Jy1V3uu42p9iya/8iaTtcVMgdNrWK1FKqWGso/g/gKG3eDh13yMqHDePiC
 creAhkLJcRZvQRoMXJ+9ZHcMrNqaSBpd638ablGO85LJVyakbxNrIoxKNVAhdSiAZnrOcZBsoZ6
 p+MLSr0qCmBirR8VBNYe6VBFmQJyP1muGzYLuqbV9h/wosEAWknUXdMjVk3whiTdOGiL0YfVsRH
 wt23f8q3CDrVXjojpBAlF+27g+o/AqyYrKD7zkpEzvrW59qU+CGTHAsq7IZQV7+K3eKzceECd8F
 KcwF/XgHRWevBP4AhiOpHFNfHOIyCFDIUP9XjDrnQSTw4O8nBfwM9DgWpXMd+Zy8EdpHGpg==
X-Received: by 2002:a05:701b:250f:b0:1b2:32e1:3bb4 with SMTP id
 a92af1059eb24-1b25d334fbdmr7812998c88.18.1794092600705; Sat, 07 Nov 2026
 15:03:20 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1793368074.git.caleb.ethridge@analog.com>
In-Reply-To: <cover.1793368074.git.caleb.ethridge@analog.com>
From: Greg Malysa <malysagreg@gmail.com>
Date: Sat, 7 Nov 2026 18:02:58 -0500
X-Gm-Features: AclHuK_rdHDQsr6C_w4jYeZNt5E3496P8TeXPHgxix0Ve3eBk-3USby_zYyEvII
Message-ID: <CABdDSeVSerkz0trs-=ajdN5YMUY7V6Ub8vexgQUwaFmPqaKSLQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] SC5xx Carrier Board Kconfig Cleanup
To: Caleb Ethridge <Caleb.Ethridge@analog.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 linux@analog.com, philip@philipmolloy.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Caleb,

On Fri, Oct 30, 2026 at 10:01=E2=80=AFAM Caleb Ethridge
<Caleb.Ethridge@analog.com> wrote:
>
> From: Caleb Ethridge <caleb.ethridge@analog.com>
>
> This patch series does some small cleanup of the Kconfig options for the
> sc5xx boards. Common code for the SOMCRR carrier boards is now only built
> when one of the carrier boards is selected. Previously, it was built
> unconditionally which resulted in dead code.
>
> The series also fixes a bug with the sc594 EZLITE where it was being buil=
t
> with the EZKIT carrier code, resulting in the Ethernet not being set up
> properly. As the carrier board Kconfig option was a choice, the select fr=
om
> the TARGET was being ignored and the fallback was the default EZKIT code.
> Carrier board options have been changed from choices to bools so that the
> board targets can select the carrier board properly.
>
> Also, removing the explicit carrier board option from the sc598 EZLITE, s=
ince
> with the change to the bool options for the carrier boards it is no longe=
r
> needed.
>
> Caleb Ethridge (3):
>   board: adi: Build SOMCRR common code only with a carrier board
>   arm: mach-sc5xx: Make the SC5xx board target select the carrier board
>   configs: sc598-som-ezlite: drop explicit carrier board option
>
>  arch/arm/mach-sc5xx/Kconfig            | 26 ++++++++++++--------------
>  board/adi/carriers/Makefile            |  2 +-
>  board/adi/common-sc594-som/sc594-som.c |  4 +---
>  board/adi/common-sc598-som/sc598-som.c |  4 +---
>  configs/sc598-som-ezlite-spl_defconfig |  1 -
>  5 files changed, 15 insertions(+), 22 deletions(-)
>
> --
> 2.43.0
>

Good catch. This looks pretty good to me and everything works on my
end, so for the whole series,

Reviewed-by: Greg Malysa <malysagreg@gmail.com>

Thanks,
Greg
