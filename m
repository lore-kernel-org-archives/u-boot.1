Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F24606A31E
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 22:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=y6LeV13n;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=m4jSIcse
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A6F9940AF1;
	Wed, 21 Oct 2026 22:15:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IgZZ5X79ZO9Y; Wed, 21 Oct 2026 22:15:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 10A3B40AE0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792620904;
	b=NI68LNDfUAZGoKba7K9j4HEUhmTMmbpnhcBrZ7ejWauO5lNkQ92IgQZxIwZTE14gZhGH
	 WGbItSNnM0eWWRPSgWAEBIYq0w9TG+auDTQT26wgnsV7EkaTYwm5iaMm8cFLvMLKt+RGU
	 gfIMXAe0oP6jIKoddKIkAYPSwM0+PECMvOK+xhlLx5M6VnzaUEOPaSs7dnvcakDYHMerv
	 5h+C8FBqtiUgAOLJLQrhsM9SvuwTaU5fAjyaoe6Ft7nz+/BRgnbR7mAtkDzV2kmew7rR4
	 uNgqb1da/hZg4xnX3abF9IdCMcvpUCA2Gwz1lA6ZWarokT2VGkFTLmjtfd32URfhaNw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792620904;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=31DNjznEGs4rn4Sbr5/wqtn5RsJ/rplDjDWh6ScQsNc=;
	b=BHvxGn10TjGt303oEbaX0a7vZkFIcOUS344uzoawOWiahlw30YU8VvcW/Fo8BAHlk7X6
	 0M9u9Ok2yMnqjYCHwAAASkI4a2FmKvRAwWebW1j9JK3mep3XYaqxCbXoFv7mSQTXyxjad
	 pQp28+p9fNYim6UgmT+Y453CUkf8kJqaPb2e7QsfReFZYzkq2Ues7PD8/nWkVjJHS550J
	 ghz2t752/6Peq0dBlyfuQhje+s+VYO6DuGigx0oL1q2ZomShP9bzbNwBxrBQsLrOdu3BZ
	 s+nDKLL5JPj5IVrkjTqUF613Qw1Yu2CMhCpun+WoRNkhKQRt9zjAaoxXjGEzvmZclDg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792620904;
	bh=31DNjznEGs4rn4Sbr5/wqtn5RsJ/rplDjDWh6ScQsNc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=y6LeV13n9ZaEuv5CGW9St3rbXJS690RoCvcOvYkC7Z2z19jvBwwLbJ7C5s3kcdT+L
	 Qei5NPSNsHe5FeHeSmGj8mzHvDHr3EwbFvamurcXx07w+c7k+I9X1gjuBk6wWAYRnQ
	 MrK+uSTSv1i2JK7/AwFzbWu7znDpOZOeFUoJ35bXdXEsRxV7OvzajEk9oEpkyUcJG1
	 zURyN2Mz+I9YyGZpSbgDsnvb6R53MLNgqaYElUFGi53Lp1sRj+l1bNKawHptsq07xC
	 H522lUbxFFvlhlLIaO5TzeD/TA/mle8FfUWu9I+FbtK2gvhwpRIUegmdzz2hyz39t9
	 I+3z0SfW67DEg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 10A3B40AE0;
	Wed, 21 Oct 2026 22:15:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 09DDB95C
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 22:15:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E4683816D6
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 22:15:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I1Bqu53OaGz4 for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 22:15:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3DFF581699
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c31"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792620902;
 b=SMP6+/qhi44PV4xEItdkc6iZjmheVLD306AdhcXKxyMxIArwHPAvv+sC2dC5a/dwOmEw
 5Rn6T5juoNs6a5GLLPTU20kOscO3DU51/o5d25Yd7KkHEZ0Qbq4FWB3/f4tOwnvJmtri6
 +8vo4HqL0slTsYEzyrgVklc7lW1bIZOqklt0lsZaBLIp3AIcghxf01mBAyEd0TRJnz9kU
 5k7G2RfOF2rr+4Yy6q0IwSB8EGP7gKjhotkfkFcv9dBomm7YGKlqo6heBrW9iooID/C51
 VLdagrdD14OnRYi4FtTJcFQ/kKyvoQTCeSV2e/dyS0Vqu2hvmnS5vsAVt4wibL9ctqA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792620902;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=31DNjznEGs4rn4Sbr5/wqtn5RsJ/rplDjDWh6ScQsNc=;
 b=AUvWTBG7i4gKGCBmquHHG09nV4JvawDow0kBDW43tVsLo2wyJqt2QubXaSFa+OaYu6Ml
 GzCoJUbRwyMrioai8z7FK6SSFd/wYkdR+U7MenwLvb3x+h8x+cMpbXp5BLWiAtn2KDm0Z
 8EOWcP/YRUe0IIXlIOgwc5xOiFCgE7hUmmIrl2O1MN296iFvGVHiA3cE9mbCXXlvi5QW5
 r7GCVZz9kP90My6FP84qNSG5InwQzCMYcQCKHfwgrBuIgJ5ckdJfPaMtdsTbmHVNAXkH+
 5IxdpECBUhx+ufbwnwYUBvkZGCJtNRTCC0zYmINfJnmVGLDO/H6fF/Do79g5+7bAPGQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=m4jSIcse; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c31"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c31; helo=mail-oo1-xc31.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=m4jSIcse
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3DFF581699
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 22:15:01 +0000 (UTC)
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-702dedeb70dso734669eaf.1
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 15:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792620901; x=1793225701;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=31DNjznEGs4rn4Sbr5/wqtn5RsJ/rplDjDWh6ScQsNc=;
 b=m4jSIcse8BPqsYyG2/vPUD81WbC1LnLu7pBCgn+M7T7O6XiirqGHT6nlRah4kBEvaw
 5Q/zZuO9p80By5kQzVAJpLKswqItcFvQj8VIlWXL6w2T5+icaN6v5JbKt7+7T3M7+b4J
 pZsL/9Fk6zPJ5dV8pJFcBgI2AQmOY9EZKp+XE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792620901; x=1793225701;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=31DNjznEGs4rn4Sbr5/wqtn5RsJ/rplDjDWh6ScQsNc=;
 b=Bm7MCtHyhiqKSmnO1TovT5oq6+7Ndnp4VxfVE83S0w4Y/iSCEiPgrJjTkB41LHmszI
 vbX/qvnUucHb3lHt3w5a+cPXa2dw+htXiouJsEalduOM3kcTjADSLJSVg+qnjVmA+Sd0
 GbwScAp4LYDTk0tPpBDz2wcwpUe5qJxQGxqeYtgCyj6qPpDSPwFkdLZ0aVQXn9MBwEL8
 P7VRdBRs0zNN4ac83FDc7P7H8oEuhBPceTZDnkP7VjOMAZcBWEw7iP1fk8JLsJVPOgKc
 AHztSqeGPG6yqmCGbA03qONxv/Ap6Ad/mz4Hwl2ceaj4fIJIhDtNP34+qp+ziUwXqj6C
 HiPw==
X-Gm-Message-State: AFq9FYLgwbEgEX7E00OlOtPFVwfR3KdwH5bpGtyUzhSykRUOwGkXSb7R
 LSoB0LZHK1ySO8A7Y64TFbJEuQXo3kCZ8Fpkf0EOsxmqCoqjzzKeDxvvoUQAXeuUq2oLFQwCPrN
 GzG7iPKJc/HMy
X-Gm-Gg: AYBFou3gTM3pyosGh7QoTD60/HshZvN8DdvKjhOL+rICwzYxM6XdKK34AZB6FsXGAS8
 +mKVoP+Z5VbRVL5/hQcGqrgKTGgLHgcBFnZSx6THoAMGkCGCxWT02dwKWLnFj8Nh5Vm699SoiED
 GMA9ODnDS/qvhaeMzwOUcvRDR1CQWCRIDkxtOmdmlgnHX3GyNbvxWiGp1n5IqPnVfl0kVilvnTL
 2veTYcEZEAebUKo0yswgvcdcLb6xZT1c309O0/QnFRX9tAXhKbgJ+6Y+2LnJjRTohjfreMhFguQ
 rYjDtW7ZG+Ei2Fr10/b1Zu/6za/qnIFW0XOvbBXssv2KqeQzE3pVK8mQILEg8OZ96JGO4faoHOP
 MXPwkneuaFnkHeYjIcm+jnDUy8x6vhRN2kxaBnqmUDy8es4MlsPMrqhKbXBKk3HrOMKf8s6FqRQ
 O00NRD5YnT8MFSphCix9V7NfJlxP+N9EeV5ZyIlSkbB0gEVtm0zXVRMBh7ZAUVw7Bw+buknZrfu
 TdWVfjxzw2e3Q5Rd7U62TnaPdbWbc3fG83aJu1SW3fXjSFRWW1sD9EE3tLl6qkk9nR2Bz56zJqH
 47ojRVXw+7zSpvPqBcv8po+QlJdeaUMPs81OhNiNFmM0qK+qKOr9co8TY/9u71CWvE22uyfLAuI
 =
X-Received: by 2002:a05:6820:221a:b0:703:a9bc:b80c with SMTP id
 006d021491bc7-7093fdc15cemr2385500eaf.36.1792620900826; 
 Wed, 21 Oct 2026 15:15:00 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a7d5ebc240sm2956084fac.2.2026.10.21.15.15.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 15:15:00 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Vincent Jardin <vjardin@free.fr>
Cc: Vignesh R <vigneshr@ti.com>, 
 Takahiro Kuwano <takahiro.kuwano@infineon.com>
In-Reply-To: <20261002075854.1828080-1-vjardin@free.fr>
References: <20261002075854.1828080-1-vjardin@free.fr>
Subject: Re: [PATCH v2] mtd: spi-nor-ids: gd55lb02gf: add SPI_NOR_DUAL_READ
Message-Id: <179262090003.3382776.14814573014934282199.b4-ty@konsulko.com>
Date: Wed, 21 Oct 2026 16:15:00 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 02 Oct 2026 09:58:54 +0200, Vincent Jardin wrote:

> The GD55LB02GF supports Dual Output Fast Read and Dual IO Fast Read
> according to its datasheet, but its entry only declares the single
> and quad reads.
> 
> >From the datasheet below, see:
> - section 4.1 "SPI Mode": Dual SPI cmd are 3Bh, 3Ch, BBh and BCh
> - section 8.16 "Dual Output Fast Read (3Bh/3Ch)"
> - section 8.18 "Dual I/O Fast Read (BBh/BCh)"
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] mtd: spi-nor-ids: gd55lb02gf: add SPI_NOR_DUAL_READ
      commit: 8cba6092c8e64fc736e852e039fb27559968638d
-- 
Tom


