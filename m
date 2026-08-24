Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87469C5DF9C
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 20:31:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2A26D405CE;
	Mon, 24 Aug 2026 20:31:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U-08j13EoTSD; Mon, 24 Aug 2026 20:31:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787603485;
	bh=sGm/a78syQOUz4HW0xn6LcRATkQZFpMDeUN7nmDA+zI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d2VKxlPSKi0OKx71+uNk3Il0qXws44YNoJAuik6vS4ganIYU6a/FG0LviILvHGHlo
	 FqbsW08NcyW8MRdc3b26szfoMqavaiBsKjR4eLnVNm9efxLmirbrFHy8JLACJFmkMJ
	 8GISSKxQ5uKj2BK1jtFXRibQOEao76y9ExSPwtZQ4/ZRZ260VKwzYkkxMa4x1OJUUr
	 FyFiH1hSWQTfenYFnY5RlM4wNUnOsdWN51CDaLBfDzBQ83aip90ZQ3wYORmFKmXoRp
	 Wwkjc8h666ybelo+Kw8UzsUH/rq6/cnJVVT7Yc1RRW3VMrocwxv65Fp2V5a277m+aU
	 hKzm0gAI//K3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 668C640557;
	Mon, 24 Aug 2026 20:31:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1ED0D29B
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 20:31:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 106CD40557
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 20:31:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QZ4UAfdE8ffq for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 20:31:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=aGqEvmKj
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7597540553
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 20:31:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 84FEA4018F
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 20:31:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6945E1F00A3D
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 20:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787603481;
 bh=sGm/a78syQOUz4HW0xn6LcRATkQZFpMDeUN7nmDA+zI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=aGqEvmKjTbemlWETEapWgfoMq6SQ4nqyEGDdXCghJhBR8epxAYQu5mbDR+sUUae3d
 4Xq/4zX6jF+JukNOorpNc1hXqIToNRZiCLdVz/KUVAhvi5pSjQOd/VsN5weFa79Tfs
 Ehxl0+YRVQd+Vat4TEQcZg9OatS+BN3OeYDRSehuGudWCWLhg04omMJMtWkpTlX/Jl
 9ajFB3PPrmZ1SKNGy1l2xNqyh2xgooV9RvumzzkuqFJrfkZPqA/T+BTdzdWc2gspNI
 PqfL4WX7b2/O7esC/BBcQxxWgcrM/c7qS8jdnnpkVUctKN9NVe0UR53TT3m42LM3SO
 uP5BV3yaoDi3w==
Received: by mail-oa1-f54.google.com with SMTP id
 586e51a60fabf-448b0ff4a57so5437775fac.2
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:31:21 -0700 (PDT)
X-Gm-Message-State: AFuF++l1lGcEMBai/Wsmfmw/AfmgwxFJdcaZMwFGudUMXMM7tOPj76UN
 AFThAjTEy8BPRLrPIWcWqi36lo+XK1ijEz6cQpb9xztpMDHAioGa0nG/pVg3FLfrpg8FSUZohVn
 cvZxCgd70XxzL3Dn71wVWvx2ANlXOpg4=
X-Received: by 2002:a05:6870:1436:b0:45e:2de4:95f1 with SMTP id
 586e51a60fabf-464485329c3mr1836832fac.2.1787603480792; Mon, 24 Aug 2026
 13:31:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260708013019.288985-1-trini@konsulko.com>
 <20260824194814.555634-1-trini@konsulko.com>
 <20260824194814.555634-3-trini@konsulko.com>
In-Reply-To: <20260824194814.555634-3-trini@konsulko.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 24 Aug 2026 22:31:04 +0200
X-Gmail-Original-Message-ID: <CAD++jLmoThTn4M5FD4_tBPZBs53NCMg2gjhzamMRvaH4bo5wzg@mail.gmail.com>
X-Gm-Features: AcwNN1X7CG2bFdFqHaIjsiIa54GydZUlNtm1iBV4KLsXXg1fd4j45lSFffBz2HE
Message-ID: <CAD++jLmoThTn4M5FD4_tBPZBs53NCMg2gjhzamMRvaH4bo5wzg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] vexpress64: Correct CONFIG symbol logic around
 device tree passage
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Raymond Mao <raymondmaoca@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 David Feng <fenghua@phytium.com.cn>, Peter Hoyes <Peter.Hoyes@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Aug 24, 2026 at 9:48=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:

> When we don't have BLOBLIST_PASSAGE_MANDATORY enabled, then we're being
> passed the device tree in some other manner, via OF_HAS_PRIOR_STAGE.
> Correct our logic around which symbols are used to guard what is
> generated / used and when.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Acked-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
