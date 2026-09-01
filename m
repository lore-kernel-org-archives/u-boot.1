Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C78BC624D4
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 13:42:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B943C606BF;
	Tue,  1 Sep 2026 13:42:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m_GhCOS-YYD2; Tue,  1 Sep 2026 13:42:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788270130;
	bh=3eN83j95gQJnG3RyRY7tfhdrgfZhP3Dhd8iT1fvBr6s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=teKdadMJ7k2qCNqhVIiwuqeF7bbHutFrKHKyZoHzPH9Fad/fBNdFBLDYTNQoXRkO/
	 EpMCKNjfuWsgQtbfTdYkhUNVPZdVAyHZz6oUMFyzH90WU3kbqSl8lN6klAW+xFoyBc
	 /nhnnxmsMVhe6UnpTFTFS/JD9nvFojWN+5UxTEoNcfraPe8ZxFpfwetQTY7kzmDc6c
	 B2IV/Bzwh5DmOkc19uAuQzbRREGV9tggt1srq+uWOLUZMtOzNz/WiQeBwY53KQmbx0
	 lkpPGBLNa4eVteZW9yvnVBR/7phuS4exjeJdMS9PcmdlwLNOZwrVIBLCFixChhkyYH
	 EPfyytou9Nu+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B74F1605E8;
	Tue,  1 Sep 2026 13:42:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D09291D9
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 13:42:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B9A664053F
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 13:42:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 43Mp_nWCjMeL for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 13:42:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=NUs4m8/5
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0A8D64051D
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 13:42:06 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c252c7270faso798439966b.3
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 06:42:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788270124; cv=none;
 d=google.com; s=arc-20260327;
 b=OeY2WtgEx/9WFD7/VGC3jNrdcrb45fFa08Hwe4bHQBy3HwaueFcOuDnjDKGtngNd1l
 5qQXFkU09mWM1casLVZaFfwSfStLyidptDBDgCAvr5+q5X4+DdIV57UNRucNA0vbhuBC
 t20E7Sqr0FrxardGIccnGb60H+raS3fmdjNm0cZbpv1/WiwG+cypkpBTKT7Y8Khp/PIk
 4FrhpstLVViUnGxNrBcLHdlP78rgk4//b8YABGBuYoHDG3JmxjYfzu/R7EjSE6j9qwPf
 ERyhqrPqkmHxEj470lsegOFsULvovXteMqdrp0zb77Ri203JCxtAeQmh4EB0PjZmR7eg
 6Q0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3eN83j95gQJnG3RyRY7tfhdrgfZhP3Dhd8iT1fvBr6s=;
 fh=0CCE77DZyuM6JjHqSGHoJaJYbk+8o+a2eDTgF1/Lzls=;
 b=X3HsVbzMUcKtd9gjRfDVuyKOQnWuK3VONwaIh7rUeZmAwuduvqzNQC6beS7j4mBYtw
 krV4qQPx1dctMM0SCTUGZHzDMPXb0fal7oDsnBm4dcMRH7uMGl7JxAlAYtYQbMb/mdtC
 XjYWMd5M4a9lE/rZMMD8nt1a9lxiT4PSsXvfEbp5acnnXsjHqCVjBom7DVb+dS90tY2R
 naoP6e/PQriyJXI0cv+t+cDBJf0/HsbAp5Br3i5mOdv/tcx1X4AhhYyougx00pdhY5KD
 f0Kr+2DZ3n/BMOh8dxtx6TeNhVdETY6d4TZ/N2awrjixa+GANuwQGT6v2B78TLebX2Ak
 di7Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1788270124; x=1788874924;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3eN83j95gQJnG3RyRY7tfhdrgfZhP3Dhd8iT1fvBr6s=;
 b=NUs4m8/5BW1PY9PitXZjN0laQGUE1fy7FDGxBsyOTPqS9nM8eX4zskjZhXxT7fupwU
 e800Qx0o6i7GwpFK2xYQeHPQdlPAk4+I7zOkyemJgFjsmJtCJXxLcbQCy9ZshZlh+Bs4
 fOhfGQKsPjNwaVBGZO0xa0u6QcCWUQPauhCHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788270124; x=1788874924;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3eN83j95gQJnG3RyRY7tfhdrgfZhP3Dhd8iT1fvBr6s=;
 b=WBV9lLI3nNAXhQigtOs0BSOu4ACCRsaR8QzighMGzc0gwi73tMNgHWa5UMVHESsmOF
 8E65mcURdb73k7+/KDSRc1Pm0ioTsBoo4WzZtVnRIkANMkqnnH43tSiaasuAmBAscYZe
 9tt88kpsGj1IuFlgOt+v+S4D6v/xzMnWcJIIosiTeYNHYT2cXl8biHKh3A/KvgEpLlYB
 AikhLf8T8oZ2p9H5HirYeQOQuo9ebgTxBPUzyqcL6m03PwobrFnEBGpeq/E9lr7pqRrb
 wvi+x1e4s1a9NXR8465Jq57OeGuxuxwsrFZfUgEBN0B7R1vcGSs149LRcuaN1yB5/sOL
 dJqg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp3bLCGgFgJ1BPIHrabouER3hnXzyJ4ypUNXfHvSEHtT/DejY0WshPZW+o1FLDPhBTTa5zg93g=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nPnHjM3XX+WOYMqA/6lD0MVdgF5FLZ8pitnJrEW1UQqWVwSpmU
 xNMESxQp1DJbxGpN6Z5zdBjWczqwSe9/0kgjoppvfMc7CEm0RZysBadqx3hDrxsly6SDtyGFK4B
 Is1gYYVi9KKnPzFMtdmVfq/A0bbO1I2WCutrQTuku1EdA6n9Qs0WwcA==
X-Gm-Gg: AYBFou240jlPA+FezIaOSQugxAa3MgJGGYB50zGa8bAPDvk2FjPJ62vGedemU0AC+o0
 yjo7eQ7eMGLX/Xvgj78DVAk9rNBoXoNaat9HHu2iF1AliYxjfxgJnSOKifp0+Xzl7dJlpr2KVvB
 /Ksm6R2yaT33dKIbI5jnDRh0z+f+XqXng3OWKUY7YXnZSuqSOg/FjG34kvGpLJgw2dORdEHp58/
 FuB3eodaUSmLPjjkGD8pg7eLGP3gOoO/kI0iszDAoYC2eOkK+ynId5MIJWF6VbClxjXP/leuUvn
 wHro/NeKvPqEVFsdQLwutk7T1jf4/g4dWfylMp0ZtD4oOCIoAsei4g==
X-Received: by 2002:a17:906:2083:b0:c25:8eb7:f388 with SMTP id
 a640c23a62f3a-c25b3d13b43mr341240166b.17.1788270124556; Tue, 01 Sep 2026
 06:42:04 -0700 (PDT)
MIME-Version: 1.0
References: <mkv6dosnzm64fr7y57lhsynqhtiy5bhp2gawlk7vstfyjm37cm@tntjqgtdok7m>
In-Reply-To: <mkv6dosnzm64fr7y57lhsynqhtiy5bhp2gawlk7vstfyjm37cm@tntjqgtdok7m>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 1 Sep 2026 07:41:51 -0600
X-Gm-Features: AcwNN1UDBrAXT4msHNzJPYJYPGKfqPAn3rWxFr7et0gMnAAjQwyEL7J1bLRLonc
Message-ID: <CAFLszTgQysm+Ent1PZ1aZDdP021cLR+Qk5eXU=fcQ5Zycb-OwQ@mail.gmail.com>
Subject: Re: [PATCH] board_f: fix use of uninitialized variable in initf_upl()
To: naveen.osdev@gmail.com
Cc: trini@konsulko.com, sjg@chromium.org, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
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

On 2026-09-01T10:20:35, Naveen Kumar Chaudhary <naveen.osdev@gmail.com> wrote:
> board_f: fix use of uninitialized variable in initf_upl()
>
> If the malloc() for the UPL handoff structure failed, ret was checked
> while still uninitialized, leading to undefined behavior: either a bogus
> error code was returned or, if ret happened to be zero, gd_set_upl() was
> called with a NULL pointer. Bail out with -ENOMEM on allocation failure
> and only read ret after upl_read_handoff() has set it.
>
> Fixes: 0fc406ab20e ("upl: Plumb in universal payload to the init process")
> Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
>
> common/board_f.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
