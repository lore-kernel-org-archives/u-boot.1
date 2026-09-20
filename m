Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B337C982D8
	for <u-boot@archiver.kernel.org>; Sun, 20 Sep 2026 22:35:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 89F4C80C55;
	Sun, 20 Sep 2026 22:35:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UjcwVsYbxFSO; Sun, 20 Sep 2026 22:35:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B3D7780C4E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789943756;
	b=BDY7cixzV19Vcu58+cMM1t9f6W2mGMnSo3/yUfOC/axDWdfS95dgEYMYVFz3I9CYjDME
	 C2U2urEPtcsOGCvvM+B9rRUqRfQ1YTjPjp2tA1iPLBXoYKBi2JJ9Xm9c3rMGlGFXJv8TI
	 etdRG8jenR6sTp2dVZXwXC7shnrLFvZ1kOKiPWwR7MGorjWnvwoCkkTAdXVwBTaB54ikO
	 kVL3JbIbjt25g507XXwTK9oSJuH4Hwpnj+MfQpx/6/n487+5jE7/k7kadP8udnPgkTw7q
	 TYJVrNuJNABpPCNSUqtY+EI9IyxBV4GfSKOO3yF1N3MwVB/viUKyq8cWGOr1L7F9HBw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789943756;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=iC537JoEPaV3bTDtX/vqjFoBpXbpYSXAQKP2rItXPek=;
	b=iGaVKHr2lk0Md93l1d0nbRmMR3/dgGe+hVaetCQKclzGRPfhAcBR2pGGHl3tmqrEPeJm
	 tUIquH14tsFn8tkfBnKZWexHUE8hARZsAG6sRNYL6yQeqC7KHlnZlhd7MaojVadOqILfr
	 XOG5CB8BFZf6a4fe3l97TJ/TnbRhoCH5K+2A6yFMJoPu5Ck8vlsmK89WcPb8t2CjGJrZ4
	 rn2LMrJqXtTcmyXJuBD81BYy8T0gXgBuY0X669DU9zKsZzEc8EQGQ4/wVclSlGPhuyIYo
	 YgjiLlbGdVANVMi/U2n8pHke3R2srzTkEF8Jw+xi1YJ6KaMDlCyPkXinxs7NYb6w7mg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789943756;
	bh=iC537JoEPaV3bTDtX/vqjFoBpXbpYSXAQKP2rItXPek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p0hJR6+DMe4QebMenObc9nEGIghQ4S8Gk8T3oFT2gkV/iS8VQgCLiPK3iyVVBJXW5
	 NLn2mtBlywhEarN23Ymau6GGBWxVwxL3pPDRHy1K0+0kX2qmJbImyrGOKnAGo+Hz5i
	 QQDGQaAPnttukEAOOIWYOa5EI40KYwD6rIto1hdQZoGa7k9cdNKyrkpXHwXiZ3jImy
	 uljKP8Msn3bsnm1aaYoezwS5fJxzXbgyQVC/s0Hv9fO+7W+L/leLTKAgs87Cnxhf7d
	 c0wDVsPXFa3PUtP2gz4WLqKPQvqj4NHockiDViTDu8ZsejgMS7uvo1e2aopLCDzTSM
	 dq0f5TJOjY7uA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B3D7780C4E;
	Sun, 20 Sep 2026 22:35:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id F3FE1380
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 22:35:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DA8F54007B
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 22:35:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RjJAF6PLrU7S for <u-boot@lists.u-boot-project.org>;
 Sun, 20 Sep 2026 22:35:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org EA24C40024
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789943754;
 b=E8HAoVpxYh75WlRNzqZ2H+qAzMV8DbRmiiNqOlEhatr0CeTvfu4JvWw296xE34BR76X1
 iseyK6FX7acWTbjNozsZisr13/A43G3Qha6QyxRxWHRLMqvVcHjb8yYmEvDBQD2YJTszX
 8jMJtWjliwwt7EeVEMQ5F4RIqOOVtqYG/hEF8qJvyJas6w48t9VRQ9rM2t4mh7lh4V/T+
 xbDzdbBwLtvih0V68TCKl/fDOIlUlISRlog4nPsyeMVZuVWvYcaFhnBFRzHzBnrSBlIIu
 bmUZPy0Worfc3pSdv4bSJJEAoiJVpPqn0NAQWk4SAcrJuKpydIfQTiLxTCtU9EXoPCw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789943754;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=iC537JoEPaV3bTDtX/vqjFoBpXbpYSXAQKP2rItXPek=;
 b=Sjqt4mxvEtKEy3l5y1mFAxPZW9LTd3AhsvAGP1HqakW3zVcWdI8BpzFOEGRH1u8AQXzv
 fkB3R55i8n20kP9VREx8Iu0kqTFO44AOeknxysvrXXGs0PTEIwqf/Hp17WcpMxKA/wVTe
 eW4i7aQhf10Ed37oo256vI/CME8Ow73uiEch8kE0iD2yAsGjRWcoduYtrS7DVGSTqI6UC
 tzMj+liLE8azscUmrvJK2vR35A1yPFWLintpYhcBSPNeDmIkOCbhKl/5jGzBM9K4V8pV3
 w6GsI3lYCQ94cX4i88JVx4utEo2+DFRePhAHOI+gtpHgNpTMVEFrfII19BYj26/KdCA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=lex.la; 
 dkim=pass header.d=lex.la header.i=@lex.la header.a=rsa-sha256 header.s=google
 header.b=AdZszgLq; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:30::f;
 helo=mail-wr2-x0f.google.com; envelope-from=f@lex.la; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=lex.la header.i=@lex.la header.a=rsa-sha256
 header.s=google header.b=AdZszgLq
Received: from mail-wr2-x0f.google.com (mail-wr2-x0f.google.com
 [IPv6:2a00:1450:4864:30::f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EA24C40024
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 22:35:53 +0000 (UTC)
Received: by mail-wr2-x0f.google.com with SMTP id
 ffacd0b85a97d-4885a1480a2so212819f8f.3
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 15:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lex.la; s=google; t=1789943751; x=1790548551; darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iC537JoEPaV3bTDtX/vqjFoBpXbpYSXAQKP2rItXPek=;
 b=AdZszgLq86Ckxbc1YODeYUd2lftiFOrgSW8pXwnvDg5ET65WEIEdJd2jU4eK0tCtg6
 J7GTuRwvrFB/zwkJB3p6980EHjk5/OLWlFrccXiYlhHG546U5D69aJGvmvcvVUyziAaQ
 vLYTGbG1K4CmN8CsUltkNH0YOdCD7FdAjikmyArqWFF9bl1Xsae5d+4FB/+6xe7dFD3r
 Z1L0la8fV+ELmbLQa6qVXifElr3T2A4AewbUZyF+m01mmwHn03DZRUIR320GQSzAkYTv
 MIJjc4uukpMHrXpjg/6BArv1qZWSwcnsDx0AjP4SojX4iXyUaR2gPdBmIuTVa+gYxMC1
 3XzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789943751; x=1790548551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iC537JoEPaV3bTDtX/vqjFoBpXbpYSXAQKP2rItXPek=;
 b=MEzI9BJMxiTmPhsumhLpOrBC8Tk16Ezis2yrY6ScMsvxwb9eLwK86h3+Ratisfucr4
 rkwwfRF3CXS0jAIQlND0K3Fs05TEZHMBgU6sj6g3b6/DaV0+46H1W9EL9UJQuwQCFTYF
 8Bm8ODeyREP67EFKdPloudyAExDiLxnUlH/ro5cxRwol0n0C0ga8riSGN2ErG2uUh3vC
 2SmOQDwuKAvzmwh5fe75bqnBsHbBx1+/pVKRJt9iT4cTC7r1pxM/tf+vjGSSx1xa09g1
 5nVLiCwzSJLHwD6m203tfaNHxu8NkQDekE5v/EItcI3lH69t2Jj3qTcw4GL1RVbsXjb3
 Qm6w==
X-Gm-Message-State: AFuF++n2YK+HVsNI5+UPGe4tFiNuGfwM25LP5Wub1mJPqOccNPe0xZwW
 msLXdHIFjI7H7ilLKMkU68w94uFBhmx8lOd7ZYYAI5qlzDAT73mgKGrwRjsqhigOdhLLfJ5ZUcx
 PyDmfeBmZNA==
X-Gm-Gg: AYBFou3I8zp7umqsAyUFiC+myEq7XnJL6Np0QdJc5EhGrI/m1teM1YeeYL8G6rwbRNW
 CK9E1+9ajWXnrlJ5toQTYbBka8paUQ7r7+zjhHMKTb4HRqlFFAmupo768VWe1HwlRJIcGEmDulf
 rdlKD12gmuH4a1TG831LZ55xbsEVrZdYU0U7uLNW7iuqCAT1w0WBLSf4L/a8mORUAXYMMdWsvUG
 ngDAHLIO7X5pV7SsdWzjOuInaTPZjS3q5VuxZUROSYNnvEZexpmsf35OSHSZu4loODQeKfTzcjy
 +AoK5a+SftDj64mBv0FnxsD/URxFqcs9w3skvEYBrLF2fLE4wc2NFxt/MiQb/1w0UTdpqEBz4DC
 KmrQR/gkHNw+juvsXTF0Kdx1Iktsz7yQSQtR6Fuwv9Nq/uJwjjFw8setiDI+md11fb6Rs6KUrpC
 QRkHzRHG7oS6SPjXeAtRyYjH+XQtAfKMl8DiJUqXcrUV0EPIcYsQ==
X-Received: by 2002:a05:6000:1861:b0:488:5852:6ee3 with SMTP id
 ffacd0b85a97d-48858527005mr3103949f8f.34.1789943751309; 
 Sun, 20 Sep 2026 15:35:51 -0700 (PDT)
Received: from remote-01 ([84.17.55.230]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48724589c02sm17315698f8f.24.2026.09.20.15.35.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 15:35:50 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: u-boot@lists.u-boot-project.org
Cc: Aleksei Sviridkin <f@lex.la>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>, Tianling Shen <cnsztl@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH] mtd: spinand: fmsh: add support for FM25G01B and FM25G02B
Date: Mon, 21 Sep 2026 01:35:49 +0300
Message-ID: <20260920223549.1837396-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260822205540.1223-1-f@lex.la>
References: <20260822205540.1223-1-f@lex.la>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This has been sitting for four weeks without a reply, so I want to
check it is not stuck on my side.

The port covers FM25G01B and FM25G02B and follows Linux, where both
landed in d5a5c9eb2ee9 and the Quad I/O dummy count was corrected in
8211f2d74b35. FM25G02B is the part on a board I run, an MT7981
Keenetic KN-1012 whose U-Boot drives that SPI-NAND. FM25G01B is taken
over from the Linux table and I have no way to test it.

It still applies to next unchanged, checked against 951132236b.

Should I resend it against a different branch, or is it simply waiting
in the queue? Adding Dario and Michael, who I missed on the first send.
