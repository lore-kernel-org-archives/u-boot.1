Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F53C54F4C
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 12:07:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D55D260887;
	Tue, 28 Jul 2026 12:07:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8dUR0yb2A5LS; Tue, 28 Jul 2026 12:07:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B3A6660817
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785240459;
	bh=80eC0GwSw9QHWUOlvM4aGWWJ2LbLnEmDxJvwS9ODHso=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X0JXVs3DR/Rh3RIIHfVoUl4jHXM3Sin1EE7VQimrjBDqa9fs3BAjRJAQqOrNGw3ns
	 mVJNt/TXWwotzRlO9mKZ7aeGVTazn4QmOkvxgy3Whtf4dCyz37qTqPRppM/rh4q9qA
	 K3kKOvgI3hBDL6c/PlWBW2qDOUNouQ7/0ptQzOLqG6Elsti0fvVCI6GM+ByHgO51M6
	 1zgP54lBF08PviVg8y0HW+AGs/MEBKj0i1Nu4uXpMnMazXQwtdWbE1ynaQZKTKhmZp
	 Br2+Gd7pMyaylWYHVBwuAfN73en/oAbTq8f9gt8yWAor52FJFsqSWXOHKM3BZ3NzEA
	 Amk99ATFOjwJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B3A6660817;
	Tue, 28 Jul 2026 12:07:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 64CDE490
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:07:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 627B660817
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:07:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tANoWUlBUQdI for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 12:07:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 3CCBD607ED
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3CCBD607ED
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3CCBD607ED
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:07:36 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-69f7af97316so6032976a12.0
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 05:07:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785240455; cv=none;
 d=google.com; s=arc-20260327;
 b=f+MqGT88mcf69JPRVfPKxM06aw83uM78HIgygWMCpsp4kdnV9Kb/2r+wsWl7dppoLG
 DEaLEiVnjaYbd3c9+LUkseXkHYMLOCr4HslTXon6o0rGHmZ/fs1D+EXizUag0QOImGfj
 Y1Sy1slSxPj5OPvMK85o0P3gGyXDYn6LfDa5p9w8CAxZUk0n8DJ3/V9dM8FlJfuICDd7
 JGDQ7br8aMupegNhRDCwBxcQ9cKUGqFv7b/KQ4RLvnVpvjNCg3VyQhGQz003p/B+ACNG
 H9VPkSbioeNTNWCsz6MJq97VOnE4T7DfHjpuu8DaPSSts2hKOOLH+bMHS1EyX84r2TcQ
 nfSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=80eC0GwSw9QHWUOlvM4aGWWJ2LbLnEmDxJvwS9ODHso=;
 fh=8c2+NIu9R/BcwmG53Md3ZtZYhq6QDDyKaebB6oY+AIs=;
 b=YJLboieBBufwSULmT/OyvEnZrXs5hpq3k/iQzBA6Ei1IqebzLLVV6gRj3SXomn9GU0
 zCd+Q0Rx/YNSRwnL8MhLLex/daoqnDGPJ2oprnpJnLTQRb/9U8hZKRKE1uQG8INdb3W3
 fQ07P3TfdaYkwQ3+eLrmuk393VZlF9GUBQIjfRfW8Lhz3HxNUq4gzhkwMTJOyz3jb9RQ
 PKqaF94sYA8qrKJdAY0jY8roO/SJYmfFYLDA+SxRUVCJRGpfYYw83K0tPb95eD+5EoQQ
 iK1lbbhCQjAHqeRWNlBZ72dYkoxu69VEgRUnwoRuRNcwlC07dCf4DO9pjHJGphCnzUyp
 e+EQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785240455; x=1785845255;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=80eC0GwSw9QHWUOlvM4aGWWJ2LbLnEmDxJvwS9ODHso=;
 b=i3EbahhN0yJnvFQGMdrutDARudgKUtAvU1GyXQhpD4G7IJf6CS2qr0QyfwYUXt6+DK
 zOSgD9/cXfwI268PgTtLUGiRjOFPNKDy9d86zh+IvCDl9TrP8erE0qLXprLXB2gk0Zbx
 fWHYI4jj7N+9BtqJ4AJ+Yb+p2RYWMrm1BnKAuiIPOWh5QGnPugc3AUZEk9gd9PAh2BoY
 k9qUWQe7CMT8UDPjiia2V8LSb02hlieJPKxDr0YxAIfdSL2MvPVkY+wg3hOhxwsz3TD5
 TsWcpmma+I8UMZNHdmHTmXam0ZQovUd49u8jcNeBvSBLAjk/0ulD2tpqkYfwNfRwhslO
 5GAg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rop2S2bze9Ki+qaN9NWPbT/4/QZofWvDM3P/60G4FVq4JSK4r6R6MuE13Ee8zKlwUtV/1Xqae4=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyBQ6LY6NmOi34O/ihUpYFZTbxY1ODZogFudlwcawz1R+qdSWds
 1+zJ+UpX8jim7e6mDFQrZwmb/eVA7Lagwy+Gi/ylDnJf0U8MPP0Ogd69GfmEusQKJM9hsVnZDTR
 Ng78/9TUXNOxpA6THciAFJLmzJ5GUpb7Ln2gsTMEw
X-Gm-Gg: AR+sD12sny8Kkb1mb/clJwkEr+nDAb17ivLthEcsdc4sXrI7lF9kK0hseuUmZaTd49I
 NvtuDH2OzXKNtz7yQ1jjpCoNxnD8GeFDnGIEnwnzpF8GcTp0B568MA2aOraptCqp6hnYFw2FcdM
 BmLLfGmQRX0xW3QJK0hLyskOcMVJuwjfYOF++Et89WF7AbxHh6Fw5v5P8MRD6lFR865cp+UAAB8
 OgwJaAWiifKNxuxIyE4Eu2VfWSuHpiCcFOZXd7OLoOz0+xQwG4RM9/IgFXQxEAdbgxAEmc=
X-Received: by 2002:a05:6402:1f02:b0:69a:2ee6:4c95 with SMTP id
 4fb4d7f45d1cf-6a034925818mr1010948a12.0.1785240455133; Tue, 28 Jul 2026
 05:07:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260727182649.7766-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260727182649.7766-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Jul 2026 06:07:23 -0600
X-Gm-Features: AUfX_mzaElZu7aUEmwfm8IprauURs7CMEdMeLWuHPILG40QOIYQTx14i5Q6yD00
Message-ID: <CAFLszTh1e438DPj+bHfaBgnBefoSw4idP+Pj6Rmbb-7g5As3gg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] sandbox: fix enum host_platform_flags description
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Denis Mukhin <dmukhin@ford.com>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785240455; x=1785845255;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=80eC0GwSw9QHWUOlvM4aGWWJ2LbLnEmDxJvwS9ODHso=;
 b=Gm46ZKbkPaDRCHP5hX9sZbw6L/nKrHCt05dNcljcrwq3C64hB7uAiRORXVuuP6HRFX
 D/aB4f728hOcAaejkOJ6l0W62Q3wbV8H91yjZX+bkiQ0pM6r2qq116Zb/z24cRDr4Kmg
 4mStZD5JHOaraiqFqK036ixDllY97W2TD4y/o=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Gm46ZKbk
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 2026-07-27T18:26:49, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> sandbox: fix enum host_platform_flags description
>
> `make htmldocs` reports
>
>     ./include/sandbox_host.h:14: warning:
>     cannot understand function prototype: 'enum host_platform_flags '
>
> Align the description with Sphinx style.
>
> Fixes: 93e9af685fef ("test: bootdev: scan with a broken high-priority device")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Reviewed-by: Denis Mukhin <dmukhin@ford.com>
>
> include/sandbox_host.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
