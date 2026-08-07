Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6EF4C2A09B
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 20:44:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4726F812FC;
	Fri,  7 Aug 2026 20:44:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P9gexgtg_u35; Fri,  7 Aug 2026 20:44:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8E3C8812E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786135487;
	bh=5nq4a7zysaXzvxVmRyUriC18HNL3j2sab3u2QsUkugs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZklTtglyveN1k4cI0C7cSsMUgrRGVOBQDUf1yXm7rvVtOjL9EyYmykxBUh97irsDr
	 Mz0vddaU8uPRVn3f5g1qr1gqOERD8zNEG127Fi+LPKXTI5ULAuFAqBjKjHtjImg8ta
	 KgQKpsUjuX0v7neZFN5ax4qy0FQa57HJkf2ju5g68NlWPJxWS3HgMEG1F5TIlvbkqb
	 Ja7mq4AHFDxuedzNbA5RsIUqwVBHcjE9wZWy6DS2Llr+WaWXJ4UJnFBXhX391nAe+E
	 jv+rMTO2tTlbGVGuKjpjjKInVkcSE802yQD2oWNWYRlEMjJDGMUB083MutHGUn4z3c
	 Fr0uGRlNdwekA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8E3C8812E0;
	Fri,  7 Aug 2026 20:44:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 33FCC2F5
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 20:44:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1A4244099D
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 20:44:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YaIIAJnGVCb9 for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 20:44:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 3F06B4098B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3F06B4098B
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3F06B4098B
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 20:44:45 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6a10b20634fso6719895a12.3
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 13:44:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786135483; cv=none;
 d=google.com; s=arc-20260327;
 b=GS3kh9XihDXAqFuw4AUVtoDINvA3MEP1FM17jIEUy2wAfc2byzPhCs5WUOc1ko6Dqt
 iEVTQLzZd1CvzM46/UbUAhAdh2dNLwjaTZW2tIf4bgxm41MOea6rQPDZcCpLqiM8xAYW
 nlXxHYXco8aph3YRiZDFNgzGqClaet9hoaW9v0XLaxLwXECZooMrewvdLQk8ZTiD3Ot4
 I4zvKSNlQmEfDD0Ynh4XU0dENFT1NhjEG0dkpURHHz6ZMnkqtK2TQ8tbz+zR3z4dx3Uz
 zzNFFkgMNajF1IoX5cpdZa7Tgt3/4DxCmP+TUl2ZX7cHKP427ObnmtxHtNXXuoCX8or/
 ekHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5nq4a7zysaXzvxVmRyUriC18HNL3j2sab3u2QsUkugs=;
 fh=ijpGqnd/DhBct2Cw5aDmEJPs+G5NkZyVrRaaBz7981M=;
 b=KZBxnrNPctiCrz/n0XKmSQVMinUOFLLRq9yDepktHbaOAMpSD/CaRWQA9G0v+fyoif
 ifOnNwHJWvfCieBPFwBZdhktRLN+cTNlXYQgeCiJ5eovmZhAChtvY/XCnmoB11qFOigg
 pDqSN4FovDq3GzXp76psKOAyGNQFxNJMZQFipPtQ753LBKqiWIfGimWnMy0ZCMU+zk9x
 BXs+wc2OU/sJF/sqge1Lyx7G9rClagKQrnybyovB7RnaxkI/RYMgyL5XTpu5+pD+4x0O
 sm7DFG5/ZCLnQbSSuIRxPmgwjgm7jYol4jR2DciVer7jonJLMkWNORm6Gol/KAgf5h/f
 FUXg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786135483; x=1786740283;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=5nq4a7zysaXzvxVmRyUriC18HNL3j2sab3u2QsUkugs=;
 b=cbfQ6pEUFNU4qdXwcYeK0hcYj4cKBsoNIJ4T4pryVZ+mhIgpP549nlka13Ucn4tQsm
 Nd8n1008BxeDECEJrl0eNqcPA7SRqvuTCB8tCgDGCkug+Ees7y4sM+CBZO7Y9VWrCYex
 7NsYT/fLPqrXqwiKM5GnVM55jXWIGxpJ6TWTvO2xWdj3kqS5UDWDrffugtYo0E+Zlkmm
 zyEDoJboqLPAJyDFfHlEO6SiXeP9UkUHYokFElllKSywOoF3laDAPQIbkx/kJTyptFoG
 Ay2YVX4t/5kSHnzni+6A7m6Y74786yOb2Xhn/dHjFxa/pWFgtNAOvSUoU+mC1yaJJhXS
 bUsQ==
X-Gm-Message-State: AOJu0YyWz0KkTH1nAFBVtSzUlugGkcosNQdD3nJglecWpE3lT49Y0IPa
 MWY386CVurstMmdED5yW8tDv9fGyFL9yZgvBKhsyICUqHwQpcHXhAnnfB3taVv2p+figYR/YbzV
 fmz9KQruDjTCQXd2vKYDTRNjWndwzxgSnrV/681fq
X-Gm-Gg: AR+sD12TillEQ+zVi/NTjCGfjnTIuk1bpFFJ+/WR90ELmCrKuDwPah3Bd1nBoeM3Dj0
 8YTptwDnO/W+bU6KUEg0Cz1xc8iImHJC+IS22kz7SUWaiPnfdDJJQ9z84gPbdlCzHtctYOU59Wl
 EewE6JjHzQo5oe93KtHtzXqMRDlXMce4omQMmnuRWV32w6xth7NdbcvH6sSzrvw0dJKVWteSogn
 EKC7xQohZbkrST0DHKnok92wk+b6Wd81OMbOs2akv254B6bIZ/5aIsKdd/W3r4IyonFcQHupGdp
 sk7UeGJFBTGxUo58dX83ivt+mjjyxx8ql3PKepHWNzQ=
X-Received: by 2002:a17:907:1b13:b0:c1c:4fce:6518 with SMTP id
 a640c23a62f3a-c2039e0b575mr1251388466b.24.1786135483130; Fri, 07 Aug 2026
 13:44:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260807-riscv-full-fit-support-v1-0-21a34f79c350@maquefel.me>
 <20260807-riscv-full-fit-support-v1-1-21a34f79c350@maquefel.me>
In-Reply-To: <20260807-riscv-full-fit-support-v1-1-21a34f79c350@maquefel.me>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 7 Aug 2026 14:44:29 -0600
X-Gm-Features: AUfX_mxnvpSCDWr03QzHgJSxoE_Yyh8SFDzPB0-6TVFlwOCNOmaNOzU89L75Z5Y
Message-ID: <CAFLszTgfOqJs279mnPNN8xUBwxs3Qy39NHzbpe1ajEEsB9rMng@mail.gmail.com>
Subject: Re: [PATCH 1/5] image: fit: allow IH_OS_OPENSBI in fit_image_load()
To: nikita.shubin@maquefel.me
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>, 
 Francesco Valla <francesco@valla.it>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786135483; x=1786740283;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5nq4a7zysaXzvxVmRyUriC18HNL3j2sab3u2QsUkugs=;
 b=XXEffh/q/6i5JpCk4wsU8bSduMgq1oOfj1HXI93KkQ7G3+x8XVaOfI6pF68xFkmVnr
 aorzMMWaWrtO9n6nOekPsC8gi9O5vBSiH9jozJyR4e5ss8CaNOFoiCfwiy4WvHDTv1VX
 tM38cxykGHVNOebgZQVfsPph6TjSDbaeH/dq0=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=XXEffh/q
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

On 2026-08-07T08:06:41, Nikita Shubin <nikita.shubin@maquefel.me> wrote:
> image: fit: allow IH_OS_OPENSBI in fit_image_load()
>
> Add IH_OS_OPENSBI to the list of supported OS types in the os_ok check
> so that FIT images containing an OpenSBI firmware can be loaded without
> error. Otherwise loading OpenSBI in full FIT Image is not possible.
>
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
>
> boot/image-fit.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
