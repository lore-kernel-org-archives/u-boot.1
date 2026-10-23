Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99ED606A327
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 16:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GkjFln3T;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BFqI9Qrs
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BA442608C0;
	Fri, 23 Oct 2026 16:23:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5GqpVuhRt6MU; Fri, 23 Oct 2026 16:23:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E51E360809
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792772586;
	b=HjbCioWfvbScfC0/7qvuPylS9EkREJHj7TUvF55xw6UHroFfTzNa1FE7vpn9o8ab+lEj
	 e4Ge9oJ2YDgoOyL7V9RlyCW1oDXMPkENuKTmKAMx4bSm2YyUwLQ25JDZzDH4voYnsffID
	 EV9AGluu+DlWqY0CRr0AG/2cyUpUZaXumOPSMzEOFuJfwkyRwN+bW7d/lgNLORzjoCLkd
	 6ZbIkKV81kYkUZxBdpQlf08BhTgUTIqZod5l52SD5thBqB9a3hojVdFOHi9/3zxcmxP6a
	 cuk5ecNbMnFkVTf/IKuKkPO20dQHm4SymHSRjUb7fBU2DwiREw1lkBl4hEsq51Kt7gA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792772586;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:
	 X-Google-Original-Message-ID:Date:From:To:Cc:Subject:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=v7DAlzOAumbJJPMJ17zykhwlB3DUxxKuy4CDZb6sT5I=;
	b=h/1WV/dm2nS600mmZWoLkFe5Zs5N77b01vlpgi1Che0eftHi4lAJIAhcXfHp8wSol0tm
	 4Uz9bDWRntEvMN6fqwXthRmkD6ILdnTTuAUHPv+q9qeXuKCM5mUIDbhx0rhfNvxISYIf/
	 BLDawFtba0lV3+9jh+ezLiOn7y9FD35mC14xtLCTtDwIQa4mmV3dJrFIxnHGKVFx7PU4z
	 ooyYPEszi+DQO3Mmr+OeHvgSToz0OQwXdsZRNid9505CKE5yi/e4GIA26ZrxFqIYc8AMh
	 upwsAVI5shdt0eHQlsNLcZVEKpFTd3mSwrzi8Jt/oI+uDN/yXdqhIwgDZZxVL7rkGtg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BFqI9Qrs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792772586;
	bh=v7DAlzOAumbJJPMJ17zykhwlB3DUxxKuy4CDZb6sT5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GkjFln3TvGxULKLeUgMgCAydtYQplUsfUbf70YCqYRGEVMl8mlnmPKECfdZB7hLsE
	 NqzDpglY7MiM5BNNB3s0VSqTQQymNyi7XgAZKgB9LhL6bcOh8s0r18RHWYMcF6jRgA
	 bsRsX4rZEfHgXNnF7gmZWiChBjSxqjEB7ZArwUPQNai3fJJwwNgS9fxvVwTL1P9ASm
	 hALtXaixM+KKnUDjYsRMddrF/FFDCNiOoGkSgOP1if6KkXbOeJnxjZeKqR1UwxoP7h
	 tcrq8jQwfM8c905OJBEeU04XzN37x3Plg4WbIEZMz6Uby/BvuErlN5DFDz4OwTz9Mh
	 C7GPwQ770gqOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E51E360809;
	Fri, 23 Oct 2026 16:23:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D624649D
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 16:23:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C7D0E60809
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 16:23:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m8UjcNg7Trmp for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 16:23:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C1B766074A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792772584;
 b=ITz9lwQ9qpGmlw6nPIqsyNJOh5av1Mm+t9gEMV2SHoFDzSK6+E9p6EHnmf1qeomz3pCJ
 rThTy0TS9Kjr1WPpY+7YJ+MbUGMdrFxLA/IezZbs07K2IKaR9iKIno8/NLzPzJ7V/YjmV
 89jLZJerJ6qqWCOj3kYBiNC3GYGAkTYtaA8SZMh6eXjwW9VvWm1uLs9UPjUne8RUBLHiW
 iOsmwuUGp2ZgGEAR6JqkcN/50Xw7nNWY22GfJrJVkzV8pp09FSoSqOKFTzI+1MbaPJJG0
 W/CQDtPfUGE8w1gHp35wGUBOWKuHfy17aNBwWgg0RRo6RYUQhd6CAv24X2wR7cTYVBA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792772584;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:X-Google-Original-Message-ID:Date:From:To:Cc:Subject:
 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=v7DAlzOAumbJJPMJ17zykhwlB3DUxxKuy4CDZb6sT5I=;
 b=FNneUI3G3HGfcSBQWRVONVSbBceXDM9z+j/PWXw+sGbxapShPjKOX8PYZeBufD8TDrfY
 El/1Lk0nbwse6sxdIv7LSgQWmhpXuoWrx9kGRUN14QAUd6uRzTA7cNN+ZIIG6dc0tRzxn
 Feikiy4Y/AbFJ+1uUxGU9I5i6x1MEmCFlGSo+/k1QKNeD32K30mYC47ynGk8Qdgq8wSLL
 AO2ISvzB8arkM9LjqMXfV0iLOSgAlF2SMEre0IiMgw1P+pjISxMU3v/TdKWR6J4E0Gz16
 8dDpzlA8umiht3ApNPOkewg5qEY3WcBBZxnLn2N3P7ZiRVw0q0amAyYG4FXpJTXM+wQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=BFqI9Qrs; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=BFqI9Qrs
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C1B766074A
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 16:23:03 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a215e64962so5725555e9.1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 09:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792772581; x=1793377381;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:subject:cc:to:from:date:message-id:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=v7DAlzOAumbJJPMJ17zykhwlB3DUxxKuy4CDZb6sT5I=;
 b=BFqI9Qrs50Mnjb7FjnoHJDHVoXvWfjoL0866sZu2b7InVjt+JjPtJDhKGSHQM1cb+Y
 SWEyWpErDVhugjAGYh6qNeWRxIQg/o2tBFyh7v9Wu788zNlbUcgTgXcBHubfLgZredho
 5gJrKITrrwSf3Pq8yd4iR+CkFcdq4dRc7wdNUFHsN7Qo+FO6D5J61LF2opAXWyF9OVi4
 jaaKRmWBxdlLl6JInbF+UUsa5niy8h23OlRDjEdouveehJJNA1T+Ukmf5EVQdcsq3aLb
 eiV86eVMZUn90AAwGWk+LXJMTXWbj+MXOCe98IxeOHGeo7wLLXmIdIWUXQVdu8n011Ts
 GRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772581; x=1793377381;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:subject:cc:to:from:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=v7DAlzOAumbJJPMJ17zykhwlB3DUxxKuy4CDZb6sT5I=;
 b=ld7R74scelNVZJjv0Nqle9YB8pMk5xTYOqs6GvZ5U6pKJctH/rSgxL1r6RDypqGx8l
 Dgi3ah1klrkeLSGWoTBRXFE7MNV4Iu9nthXEV/lpVwKBppHjbqqo3huYNHV8feIDIO2I
 DYi1tX1Oq0XhLslQJ4c8tIzs3tKgCXrnUxb2VU+nNeC5edCNUPGEYv866UQNTMLfhZc2
 hq0/yp0Fc/vAJD1DHJBHEtIR7Ue1/tXpni3Z6mYBAzVViunAiiMNewRcQhrQ4SVBKO6L
 +ZA6tsESw7y5AXCKGzuuQvTxPUNH5Zkkem7mT+cGrzwDAzoD7oHkU0/pXUmqsqm5U0NC
 YJLg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwZaqnzql6IutcPySmGtxKrPT+aXvM3Jbgdyawovqxz4npN0RpAazcZkM6xxCcy3kO3TrXNYuE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ/dOa2atPgloslw8FxPL956T/277dWtXPpk7LGUVvfJUP1vD8Z
 5isJVn7i1etO8uKdsr2PowIZvVU1Pd3q8olVZlLcCsEErDrtLoZOFEF/
X-Gm-Gg: AYBFou057w1KewavIXFK85pjskaSGguODxDp69a0e6cEhFN1OkaPiRgL2VPbglTq+bS
 qJUvqppLEzFhs94UiHwEHlerark6rfvnn+/Qbww7UGhqtqb6gLksPv1nMFJs5a6g7ok0MNZgiqS
 exCS3MwTB9X7r4alWjQTsmFNvc4FzYzcHDEpxrTlQuhe6HgaHK1JSTY4Kfl05g5Q1sDTajDeVdY
 eeY0Yd3MMLi05pKcxcIVUpa/oF1qgk/J5RFm/Dl/GnuC+xEl1MDkbR67gnvrozzM76JQcFPCrcE
 vxWUA+usqcu/9teuNYtBfY9MtPIohllGk7bcYKxkNIyzkMus0JCjXH7OiPTYt47aWIU0G2HWGPx
 Ld9bw5wpGqbB90mVq+xNsPzeRuSoCGgzpKmJUsHQPWKR8TKC50niY4/hkiPYMDe0VxZsDc6RW/4
 tYOsDQwbxx6smiz/Yjo5wLF8ia5NbvvIllWITRXx/OHXRWGLGxcAMu3DJ3QZ8Lr0EY7Zge8hN5O
 tQHENvwjLOowzyBmEbC80rfdeKbvow0TF6IU3VsEbY3VeQvQrQlOi61TCde7vTHs2NwLyTj/VVb
 pcBYvLsw2J4te7BqzHgBHmzc+y8S58N65VsCAi+X4PFf
X-Received: by 2002:a05:600c:314f:b0:4a1:f7f4:7ced with SMTP id
 5b1f17b1804b1-4a211ee0412mr51030095e9.17.1792772581382; 
 Fri, 23 Oct 2026 09:23:01 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-92-187.ip49.fastwebnet.it. [93.34.92.187])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a29cd9d09csm15943625e9.5.2026.10.23.09.22.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 09:23:00 -0700 (PDT)
Message-ID: <6adb89e4.df6a01f8.17b6a2.0e82@mx.google.com>
X-Google-Original-Message-ID: <atuJ4EY0dQi2ezn8@Ansuel-XPS.>
Date: Fri, 23 Oct 2026 18:22:56 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>,
 Aristo Chen <aristo.chen@canonical.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, Anshul Dalal <anshuld@ti.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
 Tan Siewert <tan.siewert@9elements.com>, Peng Fan <peng.fan@nxp.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v8 5/7] misc: fw_loader: introduce FIP loader driver
References: <20261022194049.670889-1-ansuelsmth@gmail.com>
 <20261022194049.670889-6-ansuelsmth@gmail.com>
 <CAFLszThunA9w1o0+7qT+5j_jvbZ23bt2wukSyjF5-Xf3qUyF6A@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszThunA9w1o0+7qT+5j_jvbZ23bt2wukSyjF5-Xf3qUyF6A@mail.gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 23, 2026 at 09:12:32AM -0400, Simon Glass wrote:
> Hi Christian,
> 
> On 2026-10-22T19:40:35, Christian Marangi (Ansuel) <ansuelsmth@gmail.com> wrote:
> > misc: fw_loader: introduce FIP loader driver
> >
> > Introduce a variant of the FS loader driver to extract images from FIP
> > image. These image can contain additional binary used to init Network
> > accelerator or PHY firmware blob.
> >
> > The way FIP handle image type is with the usage of UUID.
> >
> > This FIP loader driver implement a simple FIP image parser that check
> > every entry for a matching UUID.
> >
> > Similar to FS loader, this driver also support both UBI and Block
> > devices.
> >
> > Also an additional property is added to handle special case with eMMC
> > that doesn't have a GPT partition and require a global offset to
> > reference the FIP partition.
> >
> > An example usage of this driver is the following:
> >
> > [...]
> >
> >  drivers/misc/Kconfig                |  23 ++
> >  drivers/misc/fw_loader/Makefile     |   1 +
> >  drivers/misc/fw_loader/fip_loader.c | 556 ++++++++++++++++++++++++++++++++++++
> >  drivers/misc/fw_loader/internal.h   |   2 +
> >  4 files changed, 582 insertions(+)
> 
> > diff --git a/drivers/misc/fw_loader/fip_loader.c b/drivers/misc/fw_loader/fip_loader.c
> > @@ -0,0 +1,556 @@
> > +static int blk_read_fip_firmware(struct firmware *firmwarep,
> > +				 struct blk_desc *desc,
> > +				 struct disk_partition *part_info,
> > +				 unsigned int part_offset,
> > +				 const struct fip_toc_entry *ent)
> > +{
> > +	unsigned int offset = part_info->start + part_offset;
> 
> The parse path now uses lbaint_t, but this read path still truncates
> part_info->start to unsigned int, so on a large device the header is
> found but the data is read from the wrong block. Please can you use
> lbaint_t here too (and for blkcnt/blkstart, to match
> blk_parse_fip_firmware())?
> 
> > diff --git a/drivers/misc/fw_loader/fip_loader.c b/drivers/misc/fw_loader/fip_loader.c
> > @@ -0,0 +1,556 @@
> > +	size = min(firmwarep->size, (size_t)ent->size - offset);
> > +	ret = ubi_volume_read(ubi_vol,
> > +			      (u8 *)firmwarep->data,
> > +			      ent->offset_address + offset,
> > +			      size);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return size - firmwarep->offset;
> 
> 'size' already has the offset taken off, so this subtracts it twice.
> With a non-zero offset the UBI path returns less than it actually
> read, whereas the block path returns the full 'read' count. I think
> this should just be 'return size;'
> 
> Also, ubi_volume_read() treats size == 0 as 'read the whole volume',
> which overruns the buffer. That happens if offset == ent->size (which
> the check in fw_get_fip_firmware() allows) or if the caller passes a
> zero-sized buffer. Please can you return early when size is 0?
> 

!!! No idea ubi_volume_read() 0 is read all. Thanks a lot for noticing
this.

-- 
	Ansuel
