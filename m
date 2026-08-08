Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A469C55174
	for <u-boot@archiver.kernel.org>; Sat,  8 Aug 2026 17:29:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 03749606AF;
	Sat,  8 Aug 2026 17:29:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 349P6QUXiG5s; Sat,  8 Aug 2026 17:29:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7E7FC6065E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786210159;
	bh=cjuXbs/IQsPBM+WWpiueC1LSyTDZk5NqpU6QRO3uglU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e4Wja0uuDVwCGt0rsVmmc1d4rAAqTp3jOmm69U9T4i0d0R5CjxE6CSm2d5o2rU6Dv
	 zR+5q7wO+AwPtm/DUngHv5wgDKSw3Rd70kzEsZHiNxuEMQ2FoPuugFwhboewyB5yTk
	 /0EzBzq58n8fjJ7rpfAj/bNUWLCfaLl7QX2n60ouD78aOOzXKWjsDdeyxPI6B5AOSY
	 adqGzB3U5lM6bA+LouiitlDR5zzDBt9MWO82v1qJ9zIAJhl+sTvbY4vIbJ+5w6QHps
	 VcxVxvlO1egFbz2J+kiHRhJstW8SJcZVmShjySi4nTmk4efOt2gfYf50M+rCd8AszV
	 n0lAXoFPPE0iA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7E7FC6065E;
	Sat,  8 Aug 2026 17:29:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A2857282
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:29:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8884E405DA
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:29:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uEfXmXZGIuR9 for <u-boot@lists.u-boot-project.org>;
 Sat,  8 Aug 2026 17:29:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9559C405D6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9559C405D6
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9559C405D6
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:29:16 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6a144c8eea2so815221a12.0
 for <u-boot@lists.u-boot-project.org>; Sat, 08 Aug 2026 10:29:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786210154; cv=none;
 d=google.com; s=arc-20260327;
 b=FrV898aA6jAzgnid7HW4lO/omLoUxB74+SHz8jD5iyv4Mb1slbncR+FnfeHWjBXed1
 dbHQmTClYLofup+PyPBWtT7SL3wxXxJCXMbmtiEdZfG3C5HWeD58cGcbKcfujoBe8k1f
 4HST2rZUf2KiIbTe+gmbXmbiQP/bakK9LEIZz+44F2i4dPrSU7DC1RFANMo0WOKf7eB2
 l4iTBMh1cn/0nVGgkDKSlavsZJTG/vxnkCIRI3DYjFjzQDOGmG4GFZfncDYJRA8E7Tm5
 os8Q1SFr6WXh11PJvkN94oi0X9/M9uwfkZlXtXPKe1k3KnoujdhUnYwGq2ClysfZbzlU
 Dgxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=cjuXbs/IQsPBM+WWpiueC1LSyTDZk5NqpU6QRO3uglU=;
 fh=foPbH3x0w74/3x1U7VJMkU+r5BZ2Y403ovdSQ17Bb54=;
 b=XuQx3ejRjA1WaNF0MBn0rKteCD/WUcVSyJpSukXtOJSSd0jZ/lGq6NUDnJuy6K1RTB
 df7XmxD8iMrJWoVvqQcfOpWrFLsAnwhxifbDViRuFk3jVvDXlwFO3GO1kOPr64Q5FG57
 M3wA/Bss/aGiJHf5QTjShcAKk6p2Wfx1790+j627UPfm0OiKzCDW9EgSN7SuNCSMRmpj
 nDf6lqAMmbYiM0iHDWmSNbR7KbPUMd1Nm/ifaWhPu7Tb+VIrANxRGvzEF7f+8jIgdDRf
 p6yPzBUd8wq8DFzViBIAXFnvGNf9MC6H5j62keUqFcCMCs0poL8QfSsCAzxVfgPcra1T
 06Ew==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786210154; x=1786814954;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cjuXbs/IQsPBM+WWpiueC1LSyTDZk5NqpU6QRO3uglU=;
 b=crIoL8IFLqJMZ4FgnbluZ2oD6UZt7efq1RJsUb+/WV2FEPh8/GPHeH8VZSc3nA6g8W
 Nv8VBeXCP9m5x23BDWNqzW0CXn1vrMvB8l74+r2pU7ktLwCbzve0b1zmkJPf6iU+MIc5
 TJKqJTTGSHZVhI20b+Wn1iBfwD58QH82UlBmxpN4Y1IthJ8plQyYz0SHMYgQ9oh8kG2b
 gzMEODoGnebOPvfEM29Wh0rs1iHeMNnHS4mimkStI99NnTWAblt3iUiNGyXJ1eyHO3PK
 g9GNZyOS58Tgn8IjR+fVi1eHpuBwZDUQmctPZ9ISkZBA4E1ehbYCOsZyz7M06dQEVa16
 IPeA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro96Ch6ooBfByF+Bt4P078M+YlTeQf7eJN34i85B+KzkQdDNoTBddGd/ZZvi828/ihiFIfo3ps=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxYGWRLfjYfCe36zox9EMGhV81ckCuFsRhBNuQylq4hcGmG/Vd0
 w6YF0CdTzNMt3+KQGJgA+0eI4MsRuk0HgGQDbOHQlnXQAs2QMlEfgvR2kkNiNpOls5aFkEvnh9M
 lVliaut80rFfHEB1MROkdTdOBg38cP1x1B2wShNnL
X-Gm-Gg: AR+sD10MHYO5xwexrcawGxGldePFWRROuwjpm3vdL9i/LHkIcU1A0MlIvfyNb7J95fZ
 Xe8o0NyLBmmu8+7S/6GAzkCAuKwcxJBTXQh26AqKAvFtt3DPenEwJBKpR0TJcvyRBy1gAYg6Z5R
 upGwrE6xcvZdC1TTzac40E9n+qTnOg0JlJU0CR7RI1tR6U0XS8pX77Wq9nmKf34c/lbGzrhxRSt
 deH4OO+uUYp4zpARdRoI16f4Xf5TZ6RNm0NPf8ZjWVPtppINMFMTYnpYlx/T1wy0MMo7Rljl/S3
 ZSXrm+82zBezp1OJCeKYFIQDwZrPtYQFtSRcR7DT5W8=
X-Received: by 2002:a05:6402:4608:b0:698:3469:fa99 with SMTP id
 4fb4d7f45d1cf-6a1f230b7bbmr3420687a12.0.1786210154223; Sat, 08 Aug 2026
 10:29:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260730-b4-spl-fit-clear-loadable-v1-1-6f10c724f2b5@flipper.net>
In-Reply-To: <20260730-b4-spl-fit-clear-loadable-v1-1-6f10c724f2b5@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 8 Aug 2026 11:29:01 -0600
X-Gm-Features: AUfX_mwLmjc_ZS5BN3r7ACD5tPtQj95O8UdJ6pX_2CApmh-L_DvvdA2MPNOf5H0
Message-ID: <CAFLszTgPRdhOhWx_R5FGKLcdGroj8txsw0WESoW1VFx-6Z+Q6g@mail.gmail.com>
Subject: Re: [PATCH] spl: fit: Fill in the image descriptor when skipping a
 zero-size image
To: alchark@flipper.net
Cc: Nishanth Menon <nm@ti.com>, Aswath Govindraju <a-govindraju@ti.com>,
 u-boot@lists.u-boot-project.org, 
 Tom Rini <trini@konsulko.com>, Francesco Valla <francesco@valla.it>, 
 Aristo Chen <aristo.chen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786210154; x=1786814954;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cjuXbs/IQsPBM+WWpiueC1LSyTDZk5NqpU6QRO3uglU=;
 b=Ec2vDVAPf5+sw/c5Att3MiO17VpbOtdVUFz3c3w3XUik1pjMhBogvFZy3pG01XnacF
 xjBpIJHqlh6gycgS6xuGyoibfoK/ENhfu8CAviWkgzdY/GgmVXZtH2AWkc13lEXILWlu
 VQtj0ntv7wfnwAdKMkn9h/bTuG81qaVJ7a/3w=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Ec2vDVAP
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

On 2026-07-30T13:24:10, Alexey Charkov <alchark@flipper.net> wrote:
> spl: fit: Fill in the image descriptor when skipping a zero-size image
>
> load_simple_fit() is expected to fill in the image_info structure it
> receives upon successful return, but the path which skips a zero-sized
> image returns success without touching it. The result is that
> spl_fit_record_loadable() then publishes whatever else the descriptor
> happened to hold in /fit-images under the skipped image's name: the size
> and entry point of the previous loadable, or - for the first one, since
> image_info is declared without an initialiser - uninitialised stack.
>
> This is reachable whenever a FIT carries an image node with no content,
> which binman produces for an optional blob that was not supplied, such as
> an OP-TEE which the build did not provide.
>
> Ensure that the image_info structure is filled in with a size and entry
> point before returning, same way as other successful paths do (but
> skipping the actual load).
>
> Fixes: 6d99f866952b ("spl: fit: Skip attempting to load 0 length image")
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
> common/spl/spl_fit.c | 40 +++++++++++++++++++++++++++++-----------
>  1 file changed, 29 insertions(+), 11 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
