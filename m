Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92A1606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 14:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WeG/qm2m;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=kWtYmvJD
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B609D80FEF;
	Sat, 31 Oct 2026 14:06:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aE-vi2daT9tK; Sat, 31 Oct 2026 14:06:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F0AA28108B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793455576;
	b=ha9NdyOmqxRX6PQYj+u85sJsU/1wdUjOSqvLCmFFOH7IF/lvBLhrzVggETicG7I0xw2Y
	 dn9koSGQCInnwtu88MMCOBLJloznaKCVpDlEn8rckg0nuXn7qBWV/UItEhOdGhAln9YnS
	 YlnNFH1UvWbZdHvNf41sJ0VD2gXrv7ZDr8f3dzSTghOMqGvGFZp25ggDkJES2mSIcFL5j
	 1LGrFCh4PWUfBhNn9sHNXkaJwWcWUlYQ7IPdPR/kV+yiWYIjqmYHiQ/jqjsHBoDLcpujJ
	 A1lzV9o419Qp5GJvu+FLcqy7W6Jx92h+CMHcz0YPuApIxZaXalZXDlSu9+5GD/NU/Bw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793455576;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=T6OPblXkpJ8YggeDjb1pBVOu0BQjzgEVy5PMJovdvbQ=;
	b=PSxaAHOpuw44H7ehh0dbgzsOqnvjY5IEncfzuV6TKXpCkIRLhRxNQK30Vpqdpyc2j54b
	 02SUzdsDHNZ1EsI/ruYB8f94t3I3N+SCE7UDwfwEitF/4+st5OR4YjIBohAPELtSUcqza
	 E4F42E27qgGI6vtiVMRuroBYyvekE65N32Njl3clu86/VicqUDNbgC6WsrmFePOFqEEVw
	 qxv6GyEbxlzD5y2fjrpAnxfEqBiuP58uIyy60dqoQFOlMFlwd7REkNmoT44+mKyICCbR/
	 BiSZGyhx5Kbw7SUrIsFxPFv8F/CY17DcL/4SPBWqzlQDD6Mv1zerKkM42vUjRdM88CQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793455576;
	bh=T6OPblXkpJ8YggeDjb1pBVOu0BQjzgEVy5PMJovdvbQ=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WeG/qm2mN8ADQl7wrYsCwJeDxwbG+0FAt/LsdZ22gsYHpsp+4La+lWroqAaudWa7R
	 5NL7jMZ+TcmjNJa6DLNLX2ioflIkTaHIubNGSc+wTuz88vyFDH8kKmjFRmkVcK3h7u
	 LGIsOIqileVv/2DBfMwp/5zpxZHwsGMP5ZLqL0zrItDI32htrnY8dvyc5AWqeio0sW
	 kdAbd8jj/7zpLzAUXS2FoUvWY6arf8QfWcmJSuyIRiMKmiipv7R0YRZ4G3qW+Pz1Tc
	 2n4vbYxzIyn89YWbinre87cgSFxrpRPCy0dHyTSy5U3s7H5FyIU+JSq2cA5O7lnWWH
	 u7v/n9/GBtL2A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F0AA28108B;
	Sat, 31 Oct 2026 14:06:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7C199523
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:06:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 61DBE40060
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:06:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2eDExI7OEeTw for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 14:06:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6A12040049
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::533"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793455573;
 b=CtZ1MvksdRyNrBrvEValcDG2xGYCvwNjACP7qw5CCrmkl7iqWQdpaZqNPuBSmuA9DAKS
 IUarNYZBxOOwJqidW5rSrZeSX6HZdZxWZs/JBFKI7UkNUoVCTa6UQiIaYUbSh0EddXSEj
 r4kO0b4HYyb5oDiKAiKRd16CLa+RERkH16gkSPCjt1xdpZjwZ8wW0Y+c6XOebb2q9aL5z
 6rlYY6Ph/J9a+0gJPG9fCB78CPzkb5YlsFKUs4sh81YgvnZJ4ANcaS49QD876SgGjCxLC
 5jnG/UnwGlBytGWRhdNrXfjWivhgK+WgzWbcongbSYzMPcww0Hz6jiTXi2vRreDAxIg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793455573;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=T6OPblXkpJ8YggeDjb1pBVOu0BQjzgEVy5PMJovdvbQ=;
 b=VKI9xMaIO5S+jwLiQVP/isA2y+i5tvNhbwBCn/rgr0O1ccizCloCuBrXYwzE6Nx6ij1b
 jc4WMRfWUAl5AV0KsOCVDXnxUXBjJMC7s8h897Hu/dsuRAuw880+qc0fl6GUh0Nr0vVGn
 8dDkBst01gd9wNas6BjkfOR7r4mVqIgLzKSW8nrLAxatPKxlp6Ao+t0mlUQ1psYMaF/4I
 pp7XjvHrdoGY5r4cSOLTbBAbZXvwC6bFhmA6H+WvjjuqDu61NiMNDZcGM1bp06UoJ7I+q
 rdaEvLYkKpLtCrBE9grSMO383QPfYrCXBrcfmNUGSBkJQExwC56eGAazW18AMqu/pTw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=kWtYmvJD; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::533"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=kWtYmvJD
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6A12040049
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:06:12 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6a642495d81so2426567a12.2
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 07:06:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793455571; cv=none;
 d=google.com; s=arc-20260327;
 b=BqaorolXSxw2GZJ31ll5OODxKD/qnSoVEKj/hBHWec0mKxi//4prqKY4w+mfgQ/8ZO
 bT5CPVlDvSpgk8xIAENupHenXvzCNrajw0fXbhLLXfYMNNxnDQp1TaAbZTrZVrbiCLh0
 2fBcRiQ+K6LQlk00d2h8lPZkDcd/qJacC0EzlxC7xyLaj5TJyKQ/D2Xj1Rz34uj6h+Fo
 Pg/0iyb5K2Afcgb5vOnoftQEbxB+eK2kXyzcUU736dxcpCotJb62S148LMElnjoXH2sv
 yzHBArwyen0zGbBsl+0VGJlDdxJBFPm/Fc+C3erqRb/VO2IB6PKATiKua9HEhkFQHKXN
 331g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=T6OPblXkpJ8YggeDjb1pBVOu0BQjzgEVy5PMJovdvbQ=;
 fh=R+u548O5RMhPkSB94xsYxVd8Ln5f8fiQ47kcXSwRtSc=;
 b=QMTKbwNx3k30U9UiTYslJpGMSzNaETolXV33XFlWcZyqboza9AwxTOumwWyxxzJOFc
 8OnAr2jtkx7n9f2PX5t46kCDMYn8hkVpsfBIdQC9Xuc1UF2azkJSdyiCnge7l3xK0w2n
 6KorroPMVINpxAGhotsRdfG+W/nyYKipFVlUyPBZzBZko+XG9htQ+hPb0UO4QtUC21uF
 bN+GJi5kkx6QUfNqW6ai7pIX2vqENIDvoX97Up+TtifBvmWSrOOl8VA7uC0LpEItFWH3
 QS33OkHip5SmEj/iFsqlxygl01gb6NKEIyUJc3npPBRbvtyK0mAOd2fYXyuyyRbD9Pzd
 76Bg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793455571; x=1794060371;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=T6OPblXkpJ8YggeDjb1pBVOu0BQjzgEVy5PMJovdvbQ=;
 b=kWtYmvJDuwGYTx0SRUvlOFSLCBmM6ygSGE2Kz7BonvDasO/+P+OO46AHkDLfBk2WO7
 lDAIFh7cW5ZA/ohZiTlzBuQh6Y+RxcCEhq1CVSew77u5nP3OfKqojox6b2PZnOTVdaU/
 Lw82Td5PUSwshrmbKhDfVxiAMu4oK/Xi5F/V8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793455571; x=1794060371;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=T6OPblXkpJ8YggeDjb1pBVOu0BQjzgEVy5PMJovdvbQ=;
 b=G9L7ltAVx5N5Ao1U8GZ9OZbbhEeNFSQeLawrSLSTjurNZYzGbyvdGoELNgx0sGYb6V
 3WnTq4+NCjl6D3hfem6XIQXS/s7zBkY/HE7GQ+X/RgfnfBNEtjTdz8xKKTlp4fa5lT65
 BInPUSwDtMZ0YgjEUNyXpKrflMcIKjsO5midHD1OuGOtLH/vW+K1yJ2ok2N4YLPOw8L1
 kEVL5uiMMlwv2SxrX8+NBV5nq5OJhmIzDCHbiRXGNVjNRLG+mFyJpGUIywtyPHjPl04U
 xOchnZAhPNOqFP+sjXJeaUQrtQ0Nf73nOhVK4PMrWRFeOoy14BPCHVX2qiyewS8j5A+J
 g0YQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx+fN0HZdsjQanJtVWX5NhiHUjKv04x4RyKAuAwBPmcK+WYkOL1lr6EVq1J3f5jj4u7qSTBfto=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLQpQOxLl9sEHE2FYWC6rEYapaobV7ODkZnu3JEnS60LMcmi1eC
 R5XnDz0O+qQWxT52TVrX81jwmaBxCHM5CcbDC4NURbSjJCvDs9kgGlD7ft1fsGv1rvt01hSbglh
 5ioaIQ2TIY+3RpIj0E83EtuhigowgJZPM3KeYSqoH
X-Gm-Gg: AYBFou2FYIUJkIQN7Nywhm2NTlOUY8otdYJyHRYyG4VaGFE0870357qptkh17PSyEke
 ezo8ENh+zc/Vytlv5HhhngHuXDGLGjNB6OTEtIhmiCOBxADRu/vlBt+7p2yvCiNyXFvBGyOmVbT
 aO0JNV0rJF4owMUL/xuWpe/kT6ej92mdFBx4Zx2I9GNgCSJU34yZyexeqQKs8PdeYQ3yqqMkbNB
 QyOPbWDYo3Rz0nxPo5zuIwcHK9gAKjMwkCbjeNvFGKfmnCOCzYIC3WIde+O5XVC105LNQkyCiX+
 nCfaukMyQb8nlawdUDiIP70Leq5vuaS2rd2Ppmj9CWarQ/+v01eFfWv+FYhISOH/jgDg2Y6sRdD
 TZxWsUt7xKR520bC4xnuo/vYMT47SaFFECcOx++UjEvDJnIk23saA8+aPuyzaBYNal6gKLl4=
X-Received: by 2002:a05:6402:a513:10b0:6ac:9a44:d3ed with SMTP id
 4fb4d7f45d1cf-6b4d33aba41mr2693646a12.5.1793455570907; Sat, 31 Oct 2026
 07:06:10 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 07:06:08 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 05:14:37 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261029-main-v1-7-b5a878627107@kontron.de>
References: <20261029-main-v1-0-b5a878627107@kontron.de>
 <20261029-main-v1-7-b5a878627107@kontron.de>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 07:06:08 -0700
X-Gm-Features: AclHuK_Sx6S2dMYRiLKx_ifgXdkbd6kvjABA08VY-UwATHVkW4N06hmMMSbg-2Q
Message-ID: <CAFLszThSJRh_z=0mjBsMHDVgfeqZKNq8i9jU1=2O7KGstR=u0g@mail.gmail.com>
Subject: Re: [PATCH 07/10] bootstd: rauc: Optionally boot with a built-in
 command
To: frieder@fris.de
Cc: Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Aristo Chen <aristo.chen@canonical.com>, Alexey Charkov <alchark@flipper.net>, 
 Daniel Golle <daniel@makrotopia.org>, Johan Jonker <jbx6244@gmail.com>, 
 Francesco Valla <francesco@valla.it>, "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Michal Simek <michal.simek@amd.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Frieder Schrempf <frieder.schrempf@kontron.de>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-29T16:23:07+11:00, Frieder Schrempf <frieder@fris.de> wrote:
> bootstd: rauc: Optionally boot with a built-in command
>
> The RAUC bootmeth boots a slot by running boot.scr or boot.scr.uimg
> from its boot partition. Nothing authenticates this partition, so with
> verified boot, whoever can write it can run any U-Boot command, for
> example booting an unsigned kernel or changing the kernel command line.
> Signing the script does not close this reliably as source skips all
> checks if the environment sets verify=no, which RAUC systems must keep
> writable for BOOT_ORDER and BOOT_x_LEFT, and it accepts a FIT script
> without configurations, whose signature is then only checked against
> keys required for images, not configurations.
>
> Add CONFIG_BOOTMETH_RAUC_BOOTCMD to set a command built into U-Boot
> that boots the slot instead. It sees the same environment variables as
> the boot script. The boot partition then contains nothing that U-Boot
> executes, and the code that loads the script is left out of the build.
>
> The option is empty by default, which keeps loading the boot script.
>
> Assisted-by: LLM
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>
>  boot/Kconfig                 | 16 ++++++++++++++++
>  boot/bootmeth_rauc.c         | 21 ++++++++++++++-------
>  doc/develop/bootstd/rauc.rst |  8 ++++++++
>  3 files changed, 38 insertions(+), 7 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
