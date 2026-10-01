Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3DBDCA5FA5
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 07:53:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4E1FD60BF0;
	Thu,  1 Oct 2026 07:53:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tk-yG0Opok7Y; Thu,  1 Oct 2026 07:53:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 965DD60BEA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790841234;
	b=jpS4SpsyvMkTPN5ClrnrgeC9cJrhd9lEYi2CexnpxU36qlrwubkBLKZFjVxZ3AVNiu6K
	 6GMm8qP6S5Pin8OuzlfaDzuuW5OfQ81wUJTNKnMcAXNY7cxXjDY6j+lhtcFD2n/Aj7B14
	 G0aRDu8G0qnWlzgFzNCWdTkEEiO1iFqZlydObDp1Sqc3a/aXeGEhtesTob8NctndGZBGJ
	 0kayJk4ANObOluvgpg5VaO8MTjJYR1vobMkR+6qtavRMdIKpsciDJrUf0fCwSD817JIh4
	 CYy0YCgYTP7/HG3rAowEgLDSlQKZfd4rKyzl30KtMm1XJD9j+Gc25csA6pI0plz7ASQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790841234;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=ssi+txQuIF+MQwQ8w9YUOnIOkItyNgoLjWkoSHZ5kPA=;
	b=L/7rOnHgvLkmOeTH1pZF9vNfz6MzbOzkmC9bHcRveYKNF0rMWRWgz30DTv7o43xClKy6
	 UTzXJO5Yu7cJ+HveIgTrhbpknerk6ZZIRlS3tr4k+bD2NVEcAxUnE/8E9KG6B2o5e0Fnt
	 WwLUvdqDeY7cMi3UQYBrHDX0tiJhGOVIinTal89k09aa5N1TkJKXU8Ca+AYXM7CJIVfGm
	 zM31nX1aKa568JHdJvxIsUIU5KsSD4By6tSN2rolloYBXPDOnOMBRVNloRK56ckkhwBPM
	 eNZ4GfWLuwjRPrGyiyQ4SeDxqtqlcbZW6EyEXbe9q/No4t2lg4zVtN5dkCr7HZ6jpmg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790841234;
	bh=ssi+txQuIF+MQwQ8w9YUOnIOkItyNgoLjWkoSHZ5kPA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XzgOIU5oqqigNrc9E0FE4LXXozZsXDa6+tnDyjMaA2PNFtsg0Dk0H2Pj8jlbMEzzf
	 tJWfTgFCBmt7GBNE+A1rc3RFjz2fHOwZ9Vr+UR5fPn9dFO6inA+cQpjWh2yUL29qod
	 CnAji5kgzQF2f6nnIY+dROJ0xH67iNuHMDbIFBwSM5u7JySKKt1AOSCJ4dHA0jAEXy
	 HzdQxkdAkmMpyPKowUCX3olH2enXF+1mjZ/SkicZYNgMWEWO0WwkMf7hqzdPOm3kwA
	 isZ+vJ66l41w0bnwDw7y7XDZviOx2mektFzv/WBuF6FMiX4zNhEQ8WwUoaGf58bXPa
	 847RxaIERuSKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 965DD60BEA;
	Thu,  1 Oct 2026 07:53:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2297C34E
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 07:53:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1487E40AA7
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 07:53:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fMyOaItY2qo3 for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 07:53:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1AEC740B5F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790841232;
 b=co+R2In8rGumq6E8qnc3o+Ptz3a8ZK2NP1VDdlRWanDZKBCtgrymgkaSdmIDu77biKiM
 tj9CCl/loec9+qgR6hhraJrlJAZifnPFl48W1m2anCfgpdzP98aER2Mi5VgJ+E8+sz1sZ
 n97sO5bhsj9xnP1QD0oBIBSEB0GKeTFA/nIygHibMKXcZY+rbfIzyB9pewLU0rtUSe9ps
 xvWy0igErklczP4Z7aLkcdJ7U2Xx7zJjFp0po6Jai2vomk+wjPtOFxVJfgB/QSEuoybgv
 4L2I+hrU/CS6NJs08it+VzLrSQhNI6ynFfRLzmzp4FN8Eph7CMaDrlZuLcftQK9mFQg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790841232;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=ssi+txQuIF+MQwQ8w9YUOnIOkItyNgoLjWkoSHZ5kPA=;
 b=HNNzqV1IM9VrxPMSdMEOzU0F2WQlZzi9aQFvnbuvombZq0YBnuUmXJNYSfNKCKWpiP4J
 mOHGLOR2+YXQJ23PfU86IBX6Gf2ZBASJ6n16MkX7qHzGo/+u/oiCHVbgAlZ8B1J+eGusv
 CeHebzoDUkMdIdivnnyeJQ9k6rAUftEsxF7eqVXnUoLu4MvkKJw+lKxdmm8CnjrqHciM7
 Sd+cQUHdknKHUIBT04JXyQOKy7BG2l3k515sQWymCQAS4SMUjFwxNiUI6hzIZ4zrk4VE6
 SJwcJBJEtnPTNRuHLICppijwILPx0tHkN4FwcZWwpiFQWB15NNXL+jrspzwlVuW4sqg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Y+exSbPv; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::f;
 helo=mail-ed2-x0f.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Y+exSbPv
Received: from mail-ed2-x0f.google.com (mail-ed2-x0f.google.com
 [IPv6:2a00:1450:4864:33::f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1AEC740B5F
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 07:53:51 +0000 (UTC)
Received: by mail-ed2-x0f.google.com with SMTP id
 4fb4d7f45d1cf-6a605c198fdso9831383a12.2
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 00:53:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790841230; cv=none;
 d=google.com; s=arc-20260327;
 b=d0ypohVWDa01A27MKkFPvGzehuXeAHTxmCbgf5c73wXE2K7U2bjM+l9j0MTUhJXdp4
 D+308pEXx1ukdQ1/CmQyRJ/BsTT5X3TTl1OrmJsJQl/PreWXEF4uAC0ZqvjoRMaO3Mxp
 Jqu8Q7bFSW8FgqLcaqJHtc8m10cY1TcZ+oiEQlWeF5UAvrVdtwbG1rG7fRPONw/IjX8T
 CoxnLhBldqSCJQbYpg6VUszOc0lUohqW9hwEcIVdHKTB+chumYvfwLYPShQTyZuXzNNJ
 giCDq5tYBWSYrKkycejRVzVwjZuvufRCbRdhVCoTwpaC/2NqISniQPgkK3+ZpY53RPG0
 9/Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ssi+txQuIF+MQwQ8w9YUOnIOkItyNgoLjWkoSHZ5kPA=;
 fh=mjPjWgM+qXz5fP9Lu7U/q/nM93gMw0V85CkezFbDps0=;
 b=Kc8m/AGe1ylosEweIIx2m9GEZiMSMBO8JNBzTR02zn/efuNZUhYC7mAEyORFiFO7vy
 BVGq2nnTBYzg8xtjcYr/p6HZ8rqVv7U2VVk7jzqAYXnSe8QBiNVVGirpM4U2KhoepQn3
 pivcgGcjc+omJOd523TcJn2kX2e35qgFTK34Pu5D8t61szO9368ZPuOW6/Mj14qWoY1I
 Se0/bGBjG8fB9PKwtEN+h7VNUH8/t+NLCQB9S3FMVs/97LUdpVKxfCydMLwaQHQQukIR
 N8vMM8j541KWolSMm7ACSsXrg1Rs62AaDoka00AeM048cKLNTFYDfVSyu44GuzanWAXu
 X9Hg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790841230; x=1791446030;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ssi+txQuIF+MQwQ8w9YUOnIOkItyNgoLjWkoSHZ5kPA=;
 b=Y+exSbPvcE8COiXEEEOqYyxhHwg/fFYuObCq+/tl9UFf0ecMD6+r0GQnhGaoshx9hF
 vfrnZDgtsSeE0uUvSGckcUG2/WZJMpwoAvPX5orfkF2GIZpLKozHAo0Sw4rv/XfPCl7t
 /bChtG/KR25Xv/82etewqen2zkjaiOVNi55VU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790841230; x=1791446030;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ssi+txQuIF+MQwQ8w9YUOnIOkItyNgoLjWkoSHZ5kPA=;
 b=IzyfMBqCyRFyQXfhle5VcoZgV5q2WmODbgfpATNIZLkSH/yLqObekzaSLMSXHfdd/b
 E19quTYr9ca36Bav8L5FUB1m7RWXqzJ+q+aZnvahgAzG/0ZnHS+lxbkBhxEJNMmEU6xx
 5f5oWGGDHwOBM392OEio8jFlAJUO6bMPTzLVlq+EKJdaqqTqNPvGVe+X30DvNTt1n07Z
 EME2Rhb7KY6ZzcrTVbDl36iR+SOefpqziPLtdIdtxDBUIDkr+Ke32ZZvaQh+ZN7b5llT
 j97ZlUHDfUcs/sl7cw27m0gfjSMCCFqx/3xz+s9U9QdREIkwmbsuDmeIjjo8tpDsOa4a
 wQ8w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxa8Ugh9mpb1a1K/srvAt4Z32RsovFihMp9n4UBd17TSu6+FlMvDUSfoEV4D0xTBc4lRb0y+8w=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLXehK2xqwZu17PrP02j78tUoSZ/SLW49S/P5o/hxgS0FAXKeRJ
 BAoMDHj1/cr7z8Nyb35QHqbQYtl0QGvcS+p8WUrKgiwKpP0J/Gv/+mSinaymZHDH4BYIt4GcKqS
 P86mFIJbQDbt1HRu8pSaoZfE5HGU2GN9GRp752b9F
X-Gm-Gg: AYBFou3H4wEhdQaex8UmS7eXwNNq9vSOX583XSTGmsV7T2Q09rAIYkEM4El0LdMo4AR
 OA0MxEjKJlvLkDG3G+lXpDZlpH0q3LWh7sIMzigdTBqreKNEdNYySdNBLJ07VfUxQlcxTEbfp/I
 ZXfK5DHs5n9J+nr7az1op71I7bU5S216MFmEJVmA6tGfdwRDchrjCzhlNrqZLagubBPHUvuTtb+
 DlFgdxhX2hL6vqKpk/L9t9fdUvORRxuIorT7940pawi4J/fIvDS7DvKSTk7E3s2kbk+kQzcGR3u
 t6tXowwWZ30nFypBgP6kjKoJbdDxDYkfarpvP1dgG3uEKlNtIEWY6mjD
X-Received: by 2002:a05:6402:52d0:b0:6ac:ae5a:a9cf with SMTP id
 4fb4d7f45d1cf-6ae19959b46mr3021027a12.34.1790841229698; Thu, 01 Oct 2026
 00:53:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260929125203.592014-1-mwalle@kernel.org>
In-Reply-To: <20260929125203.592014-1-mwalle@kernel.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Oct 2026 08:53:37 +0100
X-Gm-Features: AclHuK8Xu12PinBmkAF6jw2MDUMPNJx6oUGoDBU6_beTT-731GROQvePW25XOvY
Message-ID: <CAFLszThpim0jwUN=29v2Ltom3z79OWVgvDrcSnFDYS6vUsysLQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v4] binman: imx9image: respect BINMAN_INDIRS for
 external files
To: mwalle@kernel.org
Cc: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Tom Rini <trini@konsulko.com>, Alice Guo <alice.guo@nxp.com>,
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Michael,

On 2026-09-29T12:51:05, Michael Walle <mwalle@kernel.org> wrote:
> binman: imx9image: respect BINMAN_INDIRS for external files
>
> We have the BINMAN_INDIRS for any external binaries, so they don't have
> to be copied into the source/build directory of u-boot. This is
> especially important for image builders like buildroot.
>
> Use the get_input_filename() helper which will also look up the paths in
> BINMAN_INDIRS. The append case only handle external files, thus we can
> use that helper unconditionally.
>
> While at it, update and extend the test case for this image format.
> That is, first create the image in the input directory and then check if
> there is actually an append comand with that image name in the resulting
> .cfgout file.
>
> Signed-off-by: Michael Walle <mwalle@kernel.org>
>
> tools/binman/etype/nxp_imx9image.py | 22 ++++++++++++----------
>  tools/binman/ftest.py               |  9 ++++++---
>  2 files changed, 18 insertions(+), 13 deletions(-)

Test looks good. Two small typos if you respin for other reasons:
'only handle' should be 'only handles' and 'comand' should be
'command'.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
