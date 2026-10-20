Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14AB606A319
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 22:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=iufVy0vS;
	dkim=pass (2048-bit key, unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=Ru/0PXQ0
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A56504062F;
	Tue, 20 Oct 2026 22:55:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EYOdMMc5dhJf; Tue, 20 Oct 2026 22:55:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DF6C140631
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792536900;
	b=UxLIdmq+LAEaBjT/Tyl0FA4rLBaZPOEu/1LuS31abQjKMupww1GNL2OWFylewUxfjc3T
	 JGnJlzal+aqKpi0jzkE3EvIZpYoolroyJ8ekKohRBuoBvF92K6cCKS+E5rnqFjIoVW2zP
	 HrpBfkUMwutx9Fu5cfXK2rIrmM7r+8uUhOMfosqCWw6Uw9R9RHDbntHYrGvOxWdraO6dC
	 fuG2JrECxIdvBAbQ5hyJbPKbv92ltxk75U9G5Ftbe8W6pGYOsCi8L3eDOCtrxy/NskqUL
	 nTZZaQtTBnzjd6bg3HuR8//VS08/0+8cY6LLOOQ78K/7N5tfs5mxkIVkhJAUGSg/4Ow==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792536900;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=IdidDX6ijEG2pixC+NbVForVDWqyeNIY8O8fAUPR1qs=;
	b=ALZw2NeF1Zcxa+F+W/PLTZEvFPXBi6kbpjO2kENScmYZ6pIWbMjUJPNVg3KVrjAzXKzW
	 VvL3gxJSPec10pBoSohr/3wdo2D9/ZVJCh/UYOjq2ctWjzWv+21jUf3D6j3RSWHKvRHrm
	 WaO4vASiC8ItyU7ur/ANWjllUOOXg7xFYmBVZSeGXZkJazsTs1PF5PFTFVQ+I948FquUC
	 gwvcBScURUgws0Bc1+mMQyfs2HhDX2OjRfXFr/Jua6dSlGn/jt+uCokvD2HGofYSqHx+t
	 57Q7vkY1UMr8ceBN+F5AeJHTtEd4uxuMxjUKk3ZodLG8VDXNeo8URk5FjLO1Hj13S4g==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792536900;
	bh=IdidDX6ijEG2pixC+NbVForVDWqyeNIY8O8fAUPR1qs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iufVy0vS5+XsuPzCE8JNAS9VOvPI+gWfrH1JPFw7JYqccpvd5jGyEMt+eClq9NpLv
	 ZiLKaGwdQlipmnx77Ci3aEBnR4aXzn6d0+4y1SbfuOh5/HyHc0aljmsEKtLuLW01Zk
	 HyvobOANpZ5+nCOgD5tVDmmdCC2Flvs0WfVAKRQ4/R2C69tir3ZgaDzBLelSx611Pa
	 vI9Y+cK75zeR45d/mZIwv2k18GJu+i7PnwfO1u/Zkqt2Yk0a9KXn/DhjWqQ/kPgTq+
	 owwqgEUQmTd8yCn21ufpElx/4gw3+lXYlZCoshgv2p5+bErqQT1FGQgDvUko6HwGsd
	 6lTlgBqWFwdaw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DF6C140631;
	Tue, 20 Oct 2026 22:54:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CC0711AB
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 22:54:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C93726071D
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 22:54:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ly6lECjSEtPf for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 22:54:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D58BF6071C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b130"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792536897;
 b=EOgJI61InED0mkm4aY8pEQz5kOaBh5Y0QBbuLyV9W2/cMrhx2c1MBEFTpkB4nLNdwDqs
 XbIQxWYtSHbxfZFd+jJU+CXcmspz3UUOwhUjhP/lNVlD/7h3Fw5BH8j2bJpvGiY1fA9Mk
 3Bk7KU7qVRXmH+kuxIHJsCPvuWt8mFSzDxQ+e+uh7ApbFM005l2erGd0L7T9jxVjaYyVW
 MFbAZPytlHDJfO1kUln+GGVp7EpQW3MQjHDs8W88XnBrmE8r+y8vk9Noq84xmLF17vn5K
 K50f4TB4oIf9Wpw2MX5R4ctgrjWpQfFY6xM/wkKNuS6yggSKnBUdWP+Au/78TkFceNw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792536897;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=IdidDX6ijEG2pixC+NbVForVDWqyeNIY8O8fAUPR1qs=;
 b=sSkHV6LrXX1xsxynuCr6UV3zEkoGEqIak+qLCwz5hijAgek6NmQ8cw5798ehvm2HsIl5
 9EbywA+buKgp+S742MeFbqlqgEo+beRgjg7ICC8WcQ1wN36YWN3hh6IuFFwt3Vb/4pIGp
 nR5Ktw6xYO0MDuvFCZKGoV6lxT1HCIPHYodBEsvpF/T4P7FLGb+ZRHYHM3Uq9qfGl18l+
 vlZPZcImmO7vIG3aubQOI23TV9pjzkFPhS31T6U7Vu6kui8j+3BloojMVxGdKpU1COIat
 HiUzGGnpTAPjVTu90iK17pQBZNhKzYCaAYQYRBb4SzY2qRMo311Bky9BnrPPekf9h/g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.tenstorrent.com;
 dkim=pass header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b="Ru/0PXQ0"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::b130"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b130; helo=mail-yx1-xb130.google.com;
 envelope-from=asrinivasan@tenstorrent.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.tenstorrent.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=Ru/0PXQ0
Received: from mail-yx1-xb130.google.com (mail-yx1-xb130.google.com
 [IPv6:2607:f8b0:4864:20::b130])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D58BF6071C
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 22:54:56 +0000 (UTC)
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-679aeeddc6bso124396d50.2
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 15:54:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792536895; cv=none;
 d=google.com; s=arc-20260327;
 b=Ew8oKx9LjNNvk77SlMFLdWF/PUYmOagpIaRfZzpmHhoOM7BIPfeUyOw9QhD0cKvQAG
 WK/HyyJg3pqBaSEaPUl+LydttQX5BNFy9tCqt0c1DIrhpdEeGEj0ZzLCERBZwJpgAHvK
 GzqX3++hJKpRmKd0FQ5Taz04v03rGhgeGRlnNLTHtVRyNlX2VyI/uxTbVAuKdRneeze2
 1MrKsIw3huygU67I3beW+6py06hlz96JQEVZZV/l6q9JeFtg2+cy6Px279T90cUk3wM+
 Mo3A7pdvD56v04zwM/JrTyr9+atEwX92zVMATTDgpanYA32GiFch1bV/jDnyUqhDpeHA
 jaPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IdidDX6ijEG2pixC+NbVForVDWqyeNIY8O8fAUPR1qs=;
 fh=KF1dIIwasIz9od2F5Z4SzqWjRsiTYSK2VrBx1x67gv0=;
 b=YQJYlDp/xOIYxNwnjPSfIi0Ja/e2fdpP+WD8vWDvq6H2o7qOkpXZnjSsEdgBgU2+1m
 90R/0Y5b6fFXvORuU59XWa9GRLQzbOlpeosgtrOay9fAC0hZsNYyUG05XR0DPprCT6Ew
 eukWkbckLBCec6fkjQ0vrE1JPS+OF1b8tDi8nKIy5XNY+o3apl7GhY34ybFtu7U/g7Eo
 KZ/2V/AOIUpIHup4LZXzi8IlldPs4sP0qQhifdHK/3WVH1/Qt7qT7fJJHbBaXuYolhNv
 cYjruGFzMmVoko37oqVFNXuyb8TfYJ6TO4n0ub1c/OykvxbIosW/UOkdk9EbJRt5fBlh
 wBqQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1792536895; x=1793141695;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IdidDX6ijEG2pixC+NbVForVDWqyeNIY8O8fAUPR1qs=;
 b=Ru/0PXQ0ga4/nAwr6AOwNy6I/I7bslWNXAQf9Vle8uNezCUCA/1jK8qlR3XImufsJN
 lM0VFhqpBGIJx6wpWI9YYTQDE2QFtM/xR3vcjs0lK3Bn725Qmx2Cg1VUjPKNBrlFR1bE
 gK+vsH7g2sLX/dDAQyoiOutFBOZVITtEg7Shm5HhD9azYkZxGevtT76eMqbTk6vvk9tW
 oLv5flwkxnbbOWe9IH0vEyb418pvIAyi9R2t9vi2bC30o+96KRissGmRk/lRFo0OK6+f
 RZJe/VmDLqHH4JhMco7F8O1pms6KXKmjWgIhxP0Y5lcEyoWD+StoyJZQkosbf4Tyz7jY
 s0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792536895; x=1793141695;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IdidDX6ijEG2pixC+NbVForVDWqyeNIY8O8fAUPR1qs=;
 b=RcmQtgpYpk9sG7F43sdYSL5FdoPJlruMWb1z+wHLL9s9+IedPRPUznNX/RRVLEssIg
 l3x7UC637By94NW75zuoXj5ZSln2fVTIjMTV4WJDQG0kToE1NLsPm6R49k8fCMw6duO6
 dXVb8lEvkPBXUXcFZvrh59atjmBs60kP93RCLy951cdCkYynjTsfw/h7qEGT2/FkDJg3
 tM7qI9KyN8Mo3acAFagBc9kh40IbXSzryUvODzmy6btTSE4Mz0mLZFiIimOp89etnexW
 iM7EB6kwhdIDFBJ7zt7gG0rtG6MznbN8ia/kejX6VwcGM6dNnAScweHNftW7Iz2vwcLN
 IkVQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx5krj9pnQ4+ZPyTEiZl5ksaIA88RwPX7kqTcrqxGIvfMEttTyYjkIkIgMeigVXezbtSVI0/0I=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLNm7c00bAigSS3bbPWtSgbTcVs7XP8+ZC9TIilksVIoSCi8XHt
 8gv5S78T/qfSOnVl7CNTPkaCzx2uUN7reLu8rfT84iS7JYmTnSGKezdbOVindSQsUDFzDe0SWpK
 Uymy5bYXccNSpUckktBizDro7JfKD8omx7FR5nqI0Xg==
X-Gm-Gg: AYBFou1aI3bodsZQpKfgEsyfFIUN9YvMd3/UP5sLWawKm798rDs3/JZ/fx/1B0H8BPl
 sYeOAB9AZZbcrwRpI5ue7hZriOw/BG03iXGAGEowQhFiMxB7thewAiHFkD8zXGllBuyCZUOzJMT
 InpYhaXOmr2tRFPO/3s5JuZKi9h5XOf6pX9P/UsE7W7TsgBKJvshbuebVXkkG4GUd8twtFrarvS
 rQAlLIf285UPSiKLZX11nXi3rnjvB2QP4Ddg/+G+LmyuO0YbSp8tHnr0DiZfl44OFAd9pISZZAl
 NI9Hwdc2WQrgaeVnBw+9zlqmTDCLyHOb1ZPq5JD2mN3FuixPrN3TT7Wn37jSqnbiSd+SUCKmg/k
 2Zxybn4f4PqfPtIvaE9DYoH6ZpgSUZpW0Cy2fmE5ofGVjrbP+Mpyl0zhA7XH85IdSyN42UiBDDI
 8MZ9svLoAa8iejm+zYLDbWjtcjOVIuEtT+niYjfsvstvdocA==
X-Received: by 2002:a05:690e:191c:b0:679:f895:4056 with SMTP id
 956f58d0204a3-67a0e45beffmr280230d50.37.1792536895213; Tue, 20 Oct 2026
 15:54:55 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260803-spi_fixes-v1-0-33f36e764104@oss.tenstorrent.com>
 <CAEev2e-vk1on05HHcdZhkukCEQ1C8knG1GAQcYjtwbrAuemrHw@mail.gmail.com>
In-Reply-To: <CAEev2e-vk1on05HHcdZhkukCEQ1C8knG1GAQcYjtwbrAuemrHw@mail.gmail.com>
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Tue, 20 Oct 2026 17:54:44 -0500
X-Gm-Features: AclHuK_O4YChkKVZY8zBhs-tW4vUmNL7fHZlyiYmO8cfjvOReUP2f_hhZYsOLwE
Message-ID: <CAEev2e-1LgyKC0Nd=8SUCfJ1r4h3KtuZeAgX9-_jwoFsw2ytUw@mail.gmail.com>
Subject: Re: [PATCH 0/2] SPI/NOR Flash Fixes
To: Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 u-boot@lists.u-boot-project.org
Cc: Vignesh R <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>,
 Ssunk <ssunkkan@gmail.com>, 
 Jeffrey Yu <jeyu@issi.com>, Shiji Yang <yangshiji66@outlook.com>, 
 Boon Khai Ng <boon.khai.ng@altera.com>, Flaviu Nistor <flaviu.nistor@gmail.com>
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi all,

On Tue, Sep 22, 2026 at 1:46=E2=80=AFPM Anirudh Srinivasan
<asrinivasan@tenstorrent.com> wrote:
>
> Hi all,
>
> On Mon, Aug 3, 2026 at 2:01=E2=80=AFPM Anirudh Srinivasan
> <asrinivasan@oss.tenstorrent.com> wrote:
> >
> > Adds a new Micron NOR Flash Device ID and a fix to the Designware SPI
> > driver to not try dual/quad/octal modes.
> >
> > Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
> > ---
> > Anirudh Srinivasan (2):
> >       mtd: spi-nor-ids: Add variant of mt25qu256a chip
> >       spi: dw: Add supports_op function to reject unsupported transfer =
modes
> >
> >  drivers/mtd/spi/spi-nor-ids.c |  2 ++
> >  drivers/spi/designware_spi.c  | 14 ++++++++++++++
> >  2 files changed, 16 insertions(+)
>
> Patch 1 in this series got an Rb (with a request for a minor wording
> change). Patch 2 hasn't received any replies. I'm sending a gentle
> reminder regarding Patch 2, in case anyone has comments.
>
> I can send another revision for Patch 1 if needed (or it can be fixed
> up while being applied).

Gentle ping on this series.
