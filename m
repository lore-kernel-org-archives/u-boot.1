Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384C0606A31E
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 02:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yRFC/RXA;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=pNF0Zksj;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=ZHNqcXpQ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C3B56810B1;
	Fri, 30 Oct 2026 02:00:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6pHx1S07ZAat; Fri, 30 Oct 2026 02:00:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0E70B81092
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793325631;
	b=kboKt8c2f6lYvPkvQJJKhYSJmtFtFpFWAtVhm/tJMTdn7XEOY2ESkmpN6hF5qykIDFS4
	 s34M+IWNm/szyryYRyP840GinBIUbYNXJ6rKcsNZ98ptNEw94wGLsazi0lywAs0pNsBXf
	 6uSSIvLZ7KY2CDGEgjPWztoZzJRelVvUDHIW63an6Uy2ovIbVggmCpYpiS4lD0kKtgiWi
	 cEWFXrUV2Ki+XmOaXO0ehvgeHMvWU3AkGsf/d0Y9kfiP7qe4ZThRZBnzdEzBAOXwBbsCm
	 suZRAVVbrA9wDkeG4CPXxYyiCHcu13GOM8VPFYQ42OP8Dj9zLtZLFqC8WWhptSeb1vQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793325631;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Fp+RlHjkTwQ+qjLroIw1kEFgigfVLKL5ESJEAATG++8=;
	b=E8v6widg8TANnyedsyT6TJNHSlz0s9GAQDIyyUfjvMGN9f9WtMSGYmiXCXMfekF1hHVY
	 jJdYtlX6r+l8jNTFRjdTTOLdjXGTaLqIulqajUf1oDDwuvjdaX7Gt+10Zr743JPShgH+e
	 aghNx0gnoA+3iho1OfPkLgrpKbvgsvnF1Vxngg+VJmmbINslN/N+fNWVMKBUmy/JrCOay
	 bMTslE3VGW0Sf4vn4Fr0vRB05eLLRuJUEn7kUW/iGf2LizDRakPmm6uhXHHmcn48M3/kj
	 8wC+tYQ3Yjhi+VyDtHeRVCPq7VJ5a8EoUha2YbGEK/tJCP67Hkl7Nk/eNUCGsGL2TtA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793325631;
	bh=Fp+RlHjkTwQ+qjLroIw1kEFgigfVLKL5ESJEAATG++8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yRFC/RXAFruo7jBor1N1cdnWIzOMDEao4cR6PETi5MEK7RHBO5KZmpIeFuqgjdA5w
	 LZCMl9dnc2mHiS70XLRZUjfNPqSQvFBMVC4bPT8NE5k0AhDYDd9fkkyVzcUOr8Vz2+
	 pZDL247m+97ne08s5QtYlRxXkue//H1OJsMTaCAUINoG/x1mwvG1DgWul+OAQ/1Odr
	 ercFdSDj0G0Z9ioKrlycDqsk8NTqPagoaMfIo8QrQyyJsDqg/IVXmmrtt2YnueoKZ7
	 Vz6pKnBJtkV8qhYCpeQdk2hw3cM1MQSMkgJrthQNskiUgPwnLCDq9ZsVWxw/4d0Jir
	 ac8LYUIz/mCSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0E70B81092;
	Fri, 30 Oct 2026 02:00:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 66FC7712
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 02:00:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4CA5540521
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 02:00:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jJOovTm-2xLS for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 02:00:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4CB1A4051D
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793325629;
 b=broFkvzig7mQ481J292ERYZPLMMBHf7b24aHQPvwJaD+ji0rt0hhE+AMYJJqMeaGN353
 MGPfpMJsSc5eTJb/apg/eIenC66HKqmfu7VtiBwp1/I9gk+aikjIEoqc3rYXJUdTBeov2
 jQJGic48IgOxDv1Z3zD5opAIlYyIl4OGj1HMN5UxXFUR6PLNFJXsdyO1onyy53mEhGG3J
 uLtAjC+ws4PnI+dh5+TAiaQNQxHjdCQpvpYuVybvQMWYfo7MeVd8+/YohMbngjpGHjqpQ
 skRsKwZBnJTbIFrYpGkKeIW+VxHumxtw+V+VlusAKivlh1dxMOvlPHuyKPksC3jg7ag==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793325629;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
 In-Reply-To:References:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=Fp+RlHjkTwQ+qjLroIw1kEFgigfVLKL5ESJEAATG++8=;
 b=FXYjbCe3x+u2BWjOvQCeR2llwWlTt+uOKCAC4+SCOEklen37BURGYivq9VGM8QNVh8F/
 wyijnOSI432pe25N4YbjkeITWY3f/RvC+gq90yqtRajptqVtxQxYVOB9vtBancLz4jqTy
 q8IpF2VtA71FdZ5/CUrq/AFtAsyIWKFVRgAFbp80fYwsvfA3RNSJN6aCM+Ila9hz3pR9K
 WLTyU77Ub210Y28GGCcXSkaNRw5NkGWr+By3RyXYrUYAY6pOOTLFOO6nzKWupu8xIIuay
 gyyIruu/bzX1orHcXzMoHE+bTsGWoWVBXk+lvPwG4a/+Y9pHc39qBBRXlbbt9+B953A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=pNF0Zksj; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=ZHNqcXpQ; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org
 header.a=rsa-sha256 header.s=202507r header.b=pNF0Zksj; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=ZHNqcXpQ
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4CB1A4051D
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 02:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1793325626; bh=Fp+RlHjkTwQ+qjLroIw1kEF
 gigfVLKL5ESJEAATG++8=; b=pNF0Zksjr92SEtB4uLtBTStfiW/QiuU8y5p1fy6vXDFpZvknTc
 9EdfIsMQ8AE8RQHSNuuj0eAoDaVBWUCIHT8f0xjKSkKKyEv49wK/oCT63HkXg+wf7wVVqWjfBUg
 UDTP89YIZUE1JfrF7q+HqUGhGXpB1e1QUd+hr15aAzdkt44g3igzC2HBo2755fcXCxpOA9PqQ2R
 NR/iBf4+kYHLxttvVnl236Q3X/8nkb+BZrjVVbpY1fhk8h2AvNE6YwbOX6PMGcoxqjROaYazvU4
 jhoMLZ135cIUycGfHSN5QdUFN3eOC3Z9qU3fNWlZZ7AdRl/A4dAP+uFAq+fl0tQxh1g==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1793325626; bh=Fp+RlHjkTwQ+qjLroIw1kEF
 gigfVLKL5ESJEAATG++8=; b=ZHNqcXpQRZt7qwW1IBma3cm3t8mtAhb4qFQnFgnvmZai9LZtA3
 AOUc47Jan94DYqV8kLWyWeAcvd2RMWjF6lAQ==;
Date: Fri, 30 Oct 2026 02:00:26 +0000
From: Bradley Morgan <brads@mainlining.org>
To: u-boot@lists.u-boot-project.org
CC: trini@konsulko.com
Subject: Re: [PATCH 0/3] doc: arch/powerpc: add architecture documentation
In-Reply-To: <20261030014925.32610-1-brads@mainlining.org>
References: <20261030014925.32610-1-brads@mainlining.org>
Message-ID: <9BDBD458-E78B-4C7A-A356-2558EE86E71A@mainlining.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 30 October 2026 01:49:22 GMT, Bradley Morgan <brads@mainlining.org>
wrote:
>There is no proper PowerPC page under doc/arch, everything is in the
>README files scattered around the boards. Add an overview, the mpc85xx
>boot image layouts and a PBL guide, with the PBL one covering the
>practical bits like building, flashing and not bricking the board.
>
>Bradley Morgan (3):
>  doc: arch/powerpc: add an overview
>  doc: arch/powerpc: document the mpc85xx boot images
>  doc: arch/powerpc: add a PBL guide
>
> doc/arch/index.rst           |   1 +
> doc/arch/powerpc/boot.rst    |  59 ++++++++++++
> doc/arch/powerpc/index.rst   |  12 +++
> doc/arch/powerpc/pbl.rst     | 144 +++++++++++++++++++++++++++++
> doc/arch/powerpc/powerpc.rst | 169 +++++++++++++++++++++++++++++++++++
> 5 files changed, 385 insertions(+)
> create mode 100644 doc/arch/powerpc/boot.rst
> create mode 100644 doc/arch/powerpc/index.rst
> create mode 100644 doc/arch/powerpc/pbl.rst
> create mode 100644 doc/arch/powerpc/powerpc.rst

Self-NAK, wing it and do a V2 and add a new doc with it to make life
betterin the future :)

>
>

--- Thanks!
