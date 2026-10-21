Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B307606A320
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 09:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qsWidkF6;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=tNlVGz9C
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6EE9E80F75;
	Wed, 21 Oct 2026 09:11:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ITWjyP6eNmIl; Wed, 21 Oct 2026 09:11:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A6E3680FB7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792573918;
	b=JsU4XMUPaFHJ+w8pVeHE9cFiBQzG+HS7arfz/0Pp0CEmpLLPRLf7OzrznPeA5xzb6ri2
	 y2Y1HiX4dpwEMIaFzZBEohQAn1TkmQmBN5JcaYI9Xitm4NUuqbq8+h67EOIB3tdpxFfIU
	 4jGaBzzHUeJHZY/3Ag5yk8qXVxCdM4welKibStkfCOhzqAxsC2z+8mM3fl25iRdfuIT13
	 Vek7YPqyc2vx66Y+PrJX+hBH1BD6kJgRUl8Q+P1Te+SOzxc2cmvvY35w4PeIXSC6nfOdv
	 5eP7tamCEscPZ9xRwV+YbR4MpKLYYsUBO7OcSMfSEkX6VEj8UNp4QFtrFAzVkZy9i1Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792573918;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=WV46wec3F+HddQVF70IVdOGy19pCG5QWkx6FZUmUT30=;
	b=TK/3CLNzY3jcUc7RFYMnCT5jrGOwSJmxcZxRmI4s2x/87YopHmwHwKQxJ412srEqzdJh
	 jG0pk68tmTPuF4/ei3mKBkWQm+ugr/k9cxCbLszM/861UzmT8sRXvp5hPpsSWqMDSeHLZ
	 f+YmvgwWAAOiYyS9vxgV9fxIyBmyUJPcM48FUukctVtvNoqrRjDgbwihPjwvgG2SJDiUx
	 qAtghEWDxi9nIceH3ZhehWXdeCPoyFd3KCSaRA364uMYpicDeizccsKao+CQJXdijOH3K
	 G1eUcHvxAx/fr8uWZty2kf7YBKud2iARwb/DAqL6qOZpcxhk+oYXKYgAV95K9PLzxYA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792573918;
	bh=WV46wec3F+HddQVF70IVdOGy19pCG5QWkx6FZUmUT30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qsWidkF6ae/xGVgDz4CaSTGf2e/1YvfcDfENOaB5J2V0nfrKsFZvulyI06eRs+pd6
	 8cCQWq+zQUtcfPxs45QVQy7Yw9takAAwFo9CBlHoL3/53h6oE1Uh748qn576q87FxM
	 9SbrbBSJc/fj2NF/IbyTOg0QEbrBOtMXeEXZXzOcqck3IeKj0gvNgvblSt5aMLYNy9
	 +TtlFIxc5cdV8RYWeePW1OC360qDLqC5Yy8GhyYu1O7zluqUlp16x7cAIKSqBC36sg
	 t8HJwObLpLmXCfBRJTozZBCVdzcf+poCb1CrOogMxlEFYrCT7wD9F88vZOyBzTb5ld
	 mx3mrZUHvpYFA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A6E3680FB7;
	Wed, 21 Oct 2026 09:11:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 921123A4
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:11:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 77EB740077
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:11:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3y1L8QfXTbR4 for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 09:11:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B35DF40050
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::62a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792573916;
 b=VsY8yeuIdFFJa2u4cz0cVuSwb9umSFfk/FDMRrfVUggnp6hNOrlFV8iBzB7QOahnvLNx
 amS1LW5PClMvbZNIRzBjXh+s0OTqynaxp14T37jgRrwTQ45b7OMXmQ3Yp7PV5Bs006h85
 5+IMB3FSNqg8NS40VmgM1CFw67QxXvtjQGK1N0w1LvTDCrDhvBQdI/zyxLKpYT0LbRPl7
 XMjYENBOlt4nJHKveIL5XP4Rj2hlj5WPtE7XJyw5wHu+lm4nbKN5GW3KnPvB9ToVzQpzx
 JYRWGliDY+8q3HV++WlZBjk4Jcw6lqPHtxf0t5mQiFGiU9HcoOqAf4PUgls+5RqVj4Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792573916;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=WV46wec3F+HddQVF70IVdOGy19pCG5QWkx6FZUmUT30=;
 b=QstlP7h/x4LNNzrQ2k9m6RherQrS3Xp1BWw3hsF/abHYdhNqz/Rm4UjS3OWniVbO8PgS
 AAip2OStGZr+bhDrQAgXsTt6QuTY9tVh68cBGc9/Wyam7LnKJHe5uNGmywySWKCJGaqys
 3S1fYbLT5xhfOA4hz1swIRdvKCa5fMEYyRzU24a60uZP7F6uYzdXii99Vl5UZBlcifd5f
 xTic3LPNX0vEgflSMULYPrNW78M7uUGRG53X91rY/O4FObztfG0Qe7PN5v210NCjFs5uw
 9yk4qkHlRPxi86V47QYM/0nbRanbRLGNQ/CXrc82uMvZctV9H53kfXpIoKpGyUp9B5A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=tNlVGz9C; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::62a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com;
 envelope-from=visitorckw@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=tNlVGz9C
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B35DF40050
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:11:56 +0000 (UTC)
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2e977109392so3252155ad.0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792573916; x=1793178716;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WV46wec3F+HddQVF70IVdOGy19pCG5QWkx6FZUmUT30=;
 b=tNlVGz9CI2iSpa8uaSPL4o5GkaJX0VvllM/aiL1rkiwbEBqG+6GG9Xx0VYlkL4hMBp
 aDKP18j8gILmLe2TGnwtiRxpsLwmU9S4VZttM5oXl3BlbGBbclcvBujhZZ+vfKTSN4Y1
 z7+P3uXwVdTuWj9kQU8rv0jbKC++b7Jb6gesFxtkBhwCCJYSravuAsR2vYb7IEtKgLxX
 hTXZni86WgPvzD8WddkConzlOICqc77UsuJfEDhro8D9dHtfKV8tyHg4SnWgZn/zsgAe
 EoW+b3PgfYUJV7aHmFfGChxCKDkWVoYj0awCkjhRPcQlSTzF0t4/fsV0gXlNCNNMabKY
 /oZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792573916; x=1793178716;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WV46wec3F+HddQVF70IVdOGy19pCG5QWkx6FZUmUT30=;
 b=XbIjAJG41JajiKlYbpjB/BG7QsH1oQ1KDFKfg3fcU0JVic3lbxrnDZKyytD/2YzEos
 9SyKwMUxhwitVXBJfD9hirXiUMPvfhvtA+1i6a1sF5j+8WcpmhIAgPI0vydSacbQnMYw
 Topp7q/pLrEZDxlmSkjncksZvHh92yL1sVtp3CMeTYGbqokabj9bMdWSV61HNPNYIzGo
 lFTbLY/9NkRbvpDMOrAabpPMFq5uaTKfN6zUYvKgFgwIOjkj3T6HZ/ElU1uBhIC47D1J
 IelGw20ewZXdjDvRhctRek6wBuftCaPTKRiVPmgkkCV3BztLu1meg5gQ+rbIdI6/fYZG
 Pypg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzc5rdeVTCalkbSu6R0GTCo4lIOmQ+XVTBrKJqXo5F82YuKBEV54fV751PohnoaUxDGmpfOcUE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYL6zhoCQey2yRnLdeHxD2bM/k/m3bk2FWcqJI9x6RIX0M09YLNV
 R6fetxaEiz+yMItL1BT0pOzNnBNJnhKMqOiB0+m2j+RJeU4981xiCOJ3
X-Gm-Gg: AYBFou0evQ4FI+71lWUYA+ZsXpSESg6kJSSYP5iTJi4Sg4qSTbrkaFg78deUm/NPM4G
 95kNSTJIgfUJfOlYsOQiITxcWthbP01FLIZ7ZV0DQJHCnzcIV5tRSGRQi+3oqKRCS5L+wV+o9Fh
 q851USrn9RF3PYNrcC39aMP/E0/na7hEPcPsFGeTZPnoiE9Ym1Y8csNzg2dVDSMo/zaSFDU4o2a
 Oy2Lp04ddIUVWieRMuY5xibX6DFAzx8+GBlf/mCnv2at8Lng3dHJs2Dx15VlHZJBv/jZFXs3Np8
 +P9G9tudDXMso1zx/VKZr67CxpuXY2/k7FxnAyLqzPQRRspEdRLTmxBGWSfNPiLSvj7pEe038aa
 DJd+ON9Pv0Xbio7Z9zdradSIL8nqoRBnqg27EkEkEs/xHRecGkoqZhREZ6tjqijFSeuYcxe2wmF
 40OYTEooQooYp1zQ6aY8ukKyZDVgIt6qY36ESAGawwzMRtKaGCUPEVUlDTUB7TyYB54GkmkVBWL
 QOsBffyaWvPLGMWjA6uJ2muWjN574BmJPqpq3DJAwR8Vj81TE1AqZd9sOpIBgnxR3rv1TV3Nb2t
 WX2IupghUQH6Xko=
X-Received: by 2002:a17:903:2311:b0:2e9:79db:449c with SMTP id
 d9443c01a7336-2ea44022b8amr11310675ad.47.1792573915642; 
 Wed, 21 Oct 2026 02:11:55 -0700 (PDT)
Received: from google.com ([2a00:79e0:2039:4:4ebd:3f41:2c23:6d5a])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ea3b486718sm8389285ad.60.2026.10.21.02.11.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 02:11:54 -0700 (PDT)
Date: Wed, 21 Oct 2026 17:11:51 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Simon Glass <sjg@chromium.org>
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org, marscheng@google.com,
 eleanor15x@gmail.com, jserv@ccns.ncku.edu.tw,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 0/4] arm: google: Add initial support for Google Tensor G5
Message-ID: <atiB14EfQYSo2g5o@google.com>
References: <20261016040216.3636305-1-visitorckw@gmail.com>
 <CAFLszTgb+w2mbsw-h0fHmqoVztS5ZNx2ZCM+R-V3gaJONBAOKQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTgb+w2mbsw-h0fHmqoVztS5ZNx2ZCM+R-V3gaJONBAOKQ@mail.gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Simon,

On Mon, Oct 19, 2026 at 06:27:31AM -0700, Simon Glass wrote:
> Hi Kuan-Wei,
> 
> On 2026-10-16T04:02:12, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> 
> > This series adds initial architecture and board support for the Google
> > Tensor G5 SoC, referred to in code as LGA, and the Pixel 10 series
> > boards based on it.
> 
> Thanks for sending this.
> 
> Please can you add a doc/board/google/lga.rst (linked from
> doc/board/google/index.rst) covering how to build this, the BL33 load
> address, the DT prerequisite below, and what currently works.

Ah, I always forget to add doc in my first version.
I'll add the doc in v2.

> 
> > The device trees for LGA are queued in the Samsung and Google SoC tree
> > for Linux v7.4 [1] and have not yet been synced into dts/upstream, so
> > cherry-picking those commits locally is required to build this series
> > until the next dts/upstream subtree update.
> 
> One thing I'd like to check before this series goes in.. as it stands
> google_lga_defconfig cannot be built from a clean tree, which breaks
> bisection and CI. It would be worth holding the defconfig patch (and
> perhaps the -u-boot.dtsi) until the dts/upstream subtree has picked up
> lga, so the series lands atomically. What do you think?
> 
I'm not sure what the usual process is in U-Boot for this situation. I
originally expected the maintainers to wait until the device tree is
synced into dts/upstream before applying the series. Do you mean that
in v2 I should only send the first two patches, and resend the last two
patches after the device tree sync?

Regards,
Kuan-Wei
