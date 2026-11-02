Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B1A606A326
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 08:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OfaQNRXP;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=EEP9nUva
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 27BF460762;
	Mon,  2 Nov 2026 08:46:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bt3dWt0OL649; Mon,  2 Nov 2026 08:46:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4B8EA60687
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793609167;
	b=lIEILgmIXM/xpkB370nvHtWTrqvil+agBF+taLEWpVZueuHXi3xlZUxgR5bDgMVxQVq+
	 JRFyk/yRW24SROz0BVpB5hDT/4NrxoLLY/tTAqDyVZ1ulHb/VTbnn9zEMjxTSNRt34BI8
	 ZVEK68BmGSqtW2WKtlPASDCgqdtMXIf/1EK3Pu12i38WGAG4ffp4rsB2aCpEE7Y1P3i1i
	 8vIx3fEkWGCotAktWZvQRbf8HuF1lT+jbfg7gIaQNUkHN/u5ELpbXdJ62dcM4K9UlQOGA
	 GCrNSpAaIS+hZpcfGfOFliotOtoOQOooApN0DZ4TzdTOewHAAdhzrlvPFrQX7nse10A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793609167;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Ip29tOAiFgTJgFgmp4KlBh5pRiIVOEcliv5ozP6PDxo=;
	b=SYl6KBkb//jSAobmEfDbzjHCqFkc8gT7uQ6PIfYE9gbq6TJFTpcEIfq0HwJRJMvp7CU/
	 OeX4Yd0veEuzi7aEUVBfL/2mRqB6U4UxY+7MgNegg0cOfzF1piURSjs0FBn7JMH2gokiM
	 MxH3eKA5/DmURvgdSwA9gWpp5M9RFulA8Fb7XPKtn5JPDMv7L31BW/bcXtL4vUIzy+ZX0
	 1F5XxeCsmTa77hgt1+q2L/fJ2KdyHo0Idy7gIGKlO+QV+EFcZJUQVP5DITMA0j3iLG3HE
	 543esG6iTS1AGDx2d9hwHh3y84g8JpwQxRHP6QIJJnEdl9QhIuhyNkD2H1oEPnGLOxw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793609167;
	bh=Ip29tOAiFgTJgFgmp4KlBh5pRiIVOEcliv5ozP6PDxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OfaQNRXPvV+hMyxZ9w/qKtpvrhqw9QS2rSWtR5Vc2AeJXwBpCovY0W+Yqp9s0++0H
	 1WsPsRO4/VgyX/3pAkmMLWlWyh4vcP9agaAcvA3J1NWe+52w61Ryh4zyxiv8Rvp4av
	 zQxVhp+sjzy5LKjVrNQjsOKiw5o2a8TCzvcQZHghn8JFUbgFzh9Sl8Z37Uzi/+m+6U
	 J2JiEC1wBSJJj9duc3VXpfOAtXpPkWNt6TwyTYRgwbS3sSJbjWFl8jKETLoWHFuLJO
	 lwNmgjFEZlz3/YmXtXWcS4nHai3cEeZ1OeF/U+42cVDMMh2Str54za1zqqhZRhcoUM
	 GcSwpOt04vpzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4B8EA60687;
	Mon,  2 Nov 2026 08:46:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A10DF356
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 08:46:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8675B401A1
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 08:46:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sj2WVW6cDlMO for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 08:46:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 75745400C8
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1333"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793609164;
 b=FC+HDU6iFWpVfNMnpVkprUYHM5ZrNw2/X49If7bNu05M4GTjP6e2UXtLonDXWpGXd0x1
 3DfcvkoYCOs6MqOvg3c3921e0q66w/vaal7pRosPBRDnkHmM68se6+CMy2e+lxBNy/2wt
 Qu7wfsn7n3J24lcERFPu1L8wCG+ly9eI/eoP/xXCAtCtg9LGGChP8M7ANDVxgCxwAGZUA
 f9oGl93XeMKuB2lvOzS1Vi9iVI4shIyoxHSOQMoj243K06KnWDKRZJumFn8SufrOW3k6i
 +m/TQIj5AtnxXrKN5hil2okbUmCrZUIEKeEuNTc0FxeHZVvUdAR+/GwbdwsiTUnSr/g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793609164;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=Ip29tOAiFgTJgFgmp4KlBh5pRiIVOEcliv5ozP6PDxo=;
 b=iKPY/5JFxvhnOI9Vg2xnzJfHa7XRN1Ni+Qrki6l3nyfS/13BDcdKeyU945MccgQcFdw6
 wKI1Bnv9XtPevoGHbxfm5JBy99TpegHWdWNKpqYpuSmBWy9Kdeak3n60/Cn2qWr9RklRi
 jzz1QgRj6JO5N4SEmxNBUliWZox4Jd9EffMJTy7j+9W9IJXzHAN0fYL+DIEVMa9rhrtY1
 IkOwf0TQYjChPXRFL/GbS4cD1IN6dyUwr+UpivWbVPFi5vRD8aFE3luqnKFX7mYZjMy+P
 3ZtV9I5P+DkW60j9UidZgDkC7uf814UdfayUHEE6X+BncV5il8rd49+DKDMhQ7nmyRA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=sifive.com;
 dkim=pass header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=EEP9nUva; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1333; helo=mail-dy1-x1333.google.com;
 envelope-from=leo.liang@sifive.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=EEP9nUva
Received: from mail-dy1-x1333.google.com (mail-dy1-x1333.google.com
 [IPv6:2607:f8b0:4864:20::1333])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 75745400C8
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 08:46:04 +0000 (UTC)
Received: by mail-dy1-x1333.google.com with SMTP id
 5a478bee46e88-35cd4e8bdbdso3566935eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 00:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1793609163; x=1794213963;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ip29tOAiFgTJgFgmp4KlBh5pRiIVOEcliv5ozP6PDxo=;
 b=EEP9nUvaY8J2DguOUQJ5lxB/OOCxu59l+/vlzbizoQSk8SuPpD3p46yV4AGWA/v4Lf
 OiBKCeFLJ4NJjTqaEQN3qH3zEq+LKbPBkHb7j08XFMu5m/NYhg0ePSwqzJtZ0V8UR8ii
 rtXj9+6APxgLiGQdcl9BjfNyEkMyEQNLrJb+A1VuiljRJR3qrrdh/ezRyUkeV4Yn24tI
 TZHEQXoFeZ7skw8YdjZa33obvetGcStxsygV/CUFdldxXjdPDfX5aAIrYqTp6GG9tccA
 rDSTiivtGijdymTgk137X80rnhq/auyVgYsNAjUwb+TslmRrWATu3e5Ix277i9HowPV2
 m7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793609163; x=1794213963;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ip29tOAiFgTJgFgmp4KlBh5pRiIVOEcliv5ozP6PDxo=;
 b=ndvC4QJmDQ5DVUWQr1rhWKCu1wov+qhp3B15wh1DyinRY3FK+mHjmr62ZYUu48cQNO
 JUBrmFd2o4OaxZ4ATNS5B39CjlqpBezX6ak9Ob74voJUalf/MQPHsFWrOdaUTXM4o1ui
 RcqG9Te7gVCRb3yMV+wHmnJ0zXart79M4xOdhpB1qoQFuoOsdUWSxKuQS8MrReoDsMRc
 Mz5aVoPNoeo5h48RP5nOvEqYom+F1cPErxMxbgXYZ7I5yB6U/eb4X1C1+Beh2O2dL80o
 h1gYjHYRdpdXAvcqzb/y2CAclOU9miKRp+md4ZTYuKlwU71k3FSh5iQWrFm1QEOZ4wfy
 8+jQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy8As5s0ya9NqA0G3H2NuiPYXtYywVNWVxYdFOjwX61MFaGdpDxU1g3NVgCffuGWeWqsGorZHI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLT42amCUH8oCydi3Kn79rW6U52Y+p4gUuVbr8pUj/0Q9OGilLi
 J+p7MR6WHJvVJlTXK4XFcYxgrBPT79cH1YYpCGgLzekYWeZXPdxaL6/vs68j3IKP1U89MLlwljq
 SQSgaCtS0eQ==
X-Gm-Gg: AYBFou3zziFO739YRftUe3sTBSAgfnBqBfwpIfUyTMIaCuTxFK+JrO6eu6DtzucDNo9
 LIQj94uQY9qDroFYDcrkl1Sv6wicSP4inHVZp4FkDihl/L+FKZ+cstT8M2a7smDBhEuycdCe/4J
 2mnZrhDFGcaRh5jUBro2096087foaO5XntXcF6E6wG0o7MhrjyZZRnIEPhJd0w1Iso/qYPa1UCj
 y8kSa7+cIdSAyWVijLBk9t7ivyhoF7MRIy21WrFIcb5D7xMBSCassjkIkiU9AzWwUl2L8d43Cce
 gTpMsO7YJpJIXBBPISeNt3xe2iwX1ctIkYoeNWPxpJpSo8CBcGwplOcohCkNfXY6AVda5XqHKBB
 /kzBRBH6aFAKePqidvVaUP7qAsLWLCtGIG0vbai6bFQ+ubSYQB2jDvtz4PCLEmSBvn23Xk0TYY+
 wwYRuS35iyItDjxKtixKcnS0VYexBHXCXBPcXzwLz/Na5i/1CoPNVnNX1ffZEIhH9peTYJFfRdH
 ZOhE+mmBY2bgahnZdCFYPQaS+2gRqcGLW2d+E9DjNImF3yKooYyGyhdGoNLRy6zd6QCNTz21EnA
 4RCV5k3vfw2gTcvUwdYU+S3a3yXQWar+JpLCuA0Tb6oJ3YmRCIOo9CSDWwKI+pa3zSg=
X-Received: by 2002:a05:7022:7e0c:b0:15c:1679:1cc7 with SMTP id
 a92af1059eb24-1ac5f181878mr13812324c88.37.1793609162865; 
 Mon, 02 Nov 2026 00:46:02 -0800 (PST)
Received: from lliang-1876.localdomain ([136.226.240.173])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac1a9e2ed3sm30695407c88.19.2026.11.02.00.46.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 00:46:02 -0800 (PST)
Date: Mon, 2 Nov 2026 16:46:00 +0800
From: Leo Liang <leo.liang@sifive.com>
To: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Cc: Yao Zi <me@ziyao.cc>, u-boot@lists.u-boot-project.org,
 Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v2] iommu: Add RISC-V IOMMU driver
Message-ID: <auhNyLI5Z0wD4A-n@lliang-1876.localdomain>
References: <20260825-riscv_iommu-v2-1-e0b816494b1a@oss.tenstorrent.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825-riscv_iommu-v2-1-e0b816494b1a@oss.tenstorrent.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Aug 25, 2026 at 11:42:46AM -0500, Anirudh Srinivasan wrote:
> Adds a basic driver for IOMMUs that conform to the RISC-V IOMMU
> specification. This driver sets up the IOMMU in bare mode so that
> peripherals requiring DMA in U-Boot can function.
> 
> Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
> ---
> Changes in v2:
> - Changed DDTP read timeout to 3s from 10s
> - Link to v1: https://patch.msgid.link/20260803-riscv_iommu-v1-1-793cfa421ab2@oss.tenstorrent.com
> ---
> Hi,
> 
> This is a pre-requisite for U-Boot on Tenstorrent Atlantis. On this
> platform, the IOMMU comes up in Off mode at boot, so this is needed for
> SD and NVME boot to work in U-Boot.
> ---
>  MAINTAINERS                 |  1 +
>  drivers/iommu/Kconfig       |  8 +++++
>  drivers/iommu/Makefile      |  1 +
>  drivers/iommu/riscv_iommu.c | 82 +++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 92 insertions(+)

Reviewed-by: Leo Yu-Chi Liang <leo.liang@sifive.com>
