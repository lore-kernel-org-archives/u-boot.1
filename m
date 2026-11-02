Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033EE606A327
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 22:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xFZhzRUA;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=uGtxL8ci
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BB51E404DE;
	Mon,  2 Nov 2026 22:12:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3X9Hl2er42E3; Mon,  2 Nov 2026 22:12:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0CBFF404E0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793657534;
	b=Cb9R6LGVC7cFLX2+VMfr5EPD8bDd7nX2+qBbUeZ/8mDK9O0puR/JsWnVHTnGtVVZFaPs
	 u+7a1TtOKdi2+wAj0Ormz1cLjCbutzhdEiDIIXyz+zpMZU4QDXffcuFEGb4O+OSih/Qkz
	 DVI0UBIrdhb2FrS6iVh8NJ1ais2vKHeJssZHhFkLYffuSoKCfqJrmIK7PAPpNEJdJ3aGs
	 /7/PmzxJZSkR1Q7kWDDCkiVaD9+/CR4TJP8ovUXqMBqOzLCQh29fB85t2/G9kbCrBjCSb
	 gNUoWM1pFeem2dJoXOH1lGbGn+KPSEQISqMiqQmx73p78LcSmLkQNAcywGloS8ZnYFA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793657534;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=nxzBWqAvKlzXBMJidqO+2fAyyoZPlzt4PVBojme539M=;
	b=R+yOkxB+/LDpllLNc+fSIr5NY1Do6nYb5ghivK3OTJqlAwxmBz01mxHULlgyIhtoAuM/
	 9fN6U3qx0ECb4DOUg5KeXEGdtDmYUEQhShCd/fXNNLp8/zPTYl7c8r9DlK1Udn192nwLw
	 33r09ambH8Q7qGd3+IiVuhPkvGBl4RSjKl7Z+nkZDINxyL4jmCb71YLtZ2QLdBMuGmnVq
	 TVRx5FCHZMojGH8EnWYB7RybskYHmh/fEfY9dmIh2LDZp12XLhxZQBBc8WiOepQM7sk1V
	 N2ePZiTFa+vtkZr07ZqJ9Zj4RaVoxXb9TonQxacotoLau996uuBaMUTYVcKv+eo47uw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793657534;
	bh=nxzBWqAvKlzXBMJidqO+2fAyyoZPlzt4PVBojme539M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xFZhzRUA1CnrS1gGefkmUjTu/WrO3MOBoeYFmrownRT/yHnplcLirISVdHFCrpYSJ
	 bmd7EfCf4P2ZxUtsohYXFGsrXQpkK0A7UXA4odDF+56zmPCuxy4vzLe84WTR+NZYUF
	 ykX/4uyaqZUCdrLpcotGycCgbCyudB5YfCS17T4sJXp/8xEpPzva8aTepJMcqnZK4p
	 CZAmnEKLr2CTf3msKLBHwhhw/ezd8NOYqC9KvkNKoTa+Io7+skjEU4jroS5N5oc20h
	 yXNg2EYU+sudEvatBCnbfyNaYPFaPGsoIZAVzCTusNi5UIql4skMmvAOL5n6LhErij
	 rlRMSA36ZlOpQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0CBFF404E0;
	Mon,  2 Nov 2026 22:12:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B58FC411
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 22:12:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9B5FB400BE
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 22:12:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aeWz4ZOfSPt7 for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 22:12:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E48D540098
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c30"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793657531;
 b=UcFpnyfCKdvaoz8o1reqSvQi00/fQP1R39Zqhx2S3ADezFw2wE+zp9OHhPElBlIdqQRD
 7SDaV1MCuAf5vQXNuq/8HyFsTtjrm21UsqLwnGdsun1uhFUy+FD39k7k7/+IMVEuGPmcG
 NMhuC7f4fi6UDseyvsb4TrrqFKocFBDGRV79oomk1ioZScO9STHHii+gKTJqXfmKKkhiI
 cc/tytV5r6Js1ff+VNccZpYiO9mGk5Tzdb5Zh9bC3pU0/6to/EikTr/x+tXOHqN9scOKh
 XNsGS6dF0wO5pW1G7Ph5nHr1curwWhOx8/ZslogsxyDy7z/dYFvxz2kUaqQLMq76Rtg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793657531;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=nxzBWqAvKlzXBMJidqO+2fAyyoZPlzt4PVBojme539M=;
 b=rdpRW8jY+/9DFZO6Lidkcj6tp0XlJYPu0Zo8lrvs9uYSoVsYjE0KPmldkLeobjFVFTdG
 0ePmrz/hoWlp/VmTpYsuDvMHujGyQIsXVb7TzTLZFEGqGo+iz+zOJObe14MNKWSsqoeFy
 lsKZddQ6pmQ+Vf0wX6qWJ903wm9lyrXrtPMjt30bk/VJbc6gvFPx9f8S9Pb97oByAE9M6
 Fea2fZoJoHEj+UuRMp11ZvCZXvos9mfu8hPcYVnb+XASMJXcMQkIPhef13zE0LFp0jayU
 /+2F6qUyVYy7tWw+inWlpIvye/xp9Qk/jIXjiivphD+pkDaUfGZj4TSwXKo9vy3RHQw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=uGtxL8ci; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c30"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c30; helo=mail-oo1-xc30.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=uGtxL8ci
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E48D540098
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 22:12:10 +0000 (UTC)
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-7037daaa820so1279351eaf.2
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 14:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793657530; x=1794262330;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nxzBWqAvKlzXBMJidqO+2fAyyoZPlzt4PVBojme539M=;
 b=uGtxL8ciwMGm0h5KmbmBlf8bq8QP8y6KyYUh3cB/L+6qsCrErMbwIwGY99XUr490BC
 urTL537cPxesO6ewNwfJM/PeZ2FxgJ+zJfNS/+mN3gI74jn0XGhBQm1btQlJjTYt+baF
 Ox7jfLYerL2AJPnTe5zdNw2h1yu3pasYvMbKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793657530; x=1794262330;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nxzBWqAvKlzXBMJidqO+2fAyyoZPlzt4PVBojme539M=;
 b=avnr6kDIWS2u0LqducB6QWocRVGzoDYpTqSs6BTq6GrVGbXwcNfbbqoYrX4GvIqhBj
 lQfEU/EW2xRr+xgfbyz2ssWKBHMX7YI1hMqIT045YuSW8U3T1zch6EcKlIOT9yiFHeSY
 7IXpEl23auRDGNKLpX7cvvhdvgXKpmOmb2egTR+iXqr2hy9xjpZwhZZdjf0cllPUeuM9
 vdWGOi3z6SJM6/P9uPwGaU+UIK10bZRlFm2Tg9IZxczfGnic2VzUSbVWr+W3k/d2aFDt
 waimBB0uaml5S+dN2j6m2kn5BCX6MrQjC2oKDn1pYva47a8eDm4lkmuxEkw29Hu6Q94q
 jbtg==
X-Gm-Message-State: AFq9FYK6VEST5cZUJO6PmbFvl1DvQOnwithl7MgjZohumwg9DlYMSopM
 czeMXjlRyum+5m+08CBbrcaKKOBYIlWJ+kwRXMOaN4dUd+iOjPXFkyQRLPAA2+mkiFRwEz8ew/V
 17FifaIJoZaeb
X-Gm-Gg: AYBFou2cHp3OZTRiKpGoGwhBAHjZwi5cXhzXxsAjimLGxuHU5Lmzg5GuH5Z1eUejsWM
 M0kBRxFyFqW45sRDL41mTcDjM2axf0JH2AUduOb5Gc+GKJS7cKrfmaciST53BBJGBv684S1alhq
 CglnDSFr8p7QdP2XdG+i//l6O8d6f0nt/eo/lC3bLAh9pRJSBCQ1AF2OthC3kUgQFiuG9qK2gul
 +Y14qK3JxFssLdJMQXbQdkI2COPTadQOOUfsuGCExYzoA+mWfL6wdrGv6/MbBEFO6r9fqoqbZ2p
 fSJiHCA2jTgR/gSn6cB9BpESwmCNIz4aGmG/TE4zPEmD2e54MR/1d/nCI5v5aOGUy18+ZsWYTRn
 4AyYNq0IO6rfwWuMsAR27ZycO68isd5lD5QTwzKgLxogqQuJ//Jx+Kq93AtZsDHLjyyy5WtQgdX
 kLiE3KfGpHivuS5oTApo/rPRzjZtuI0Hu1ITnwg9ITbY/LgH496UyDdU3HeCHNucNbilDy7ekId
 /0tpIhI3ApBLiB9PNrgMo6TZINAzaENvGLg5BO88BZ25gEEjYUhwMr4IeFQBgIHxsqxg05oCBHN
 L7UGbmb2P+ugnkLRkFBPh2kDkHOZxBAypi/FQZsqvY9fy/XIFkmlBXM2f44ik6Q3YJ1pbJvaZxp
 oQwf4MP8ZSeUh/suzaszFg/SSVPnfDay6358isnHMiYLxesSVZ95QUTOyDARBBljz+hSNiwVnh5
 FXgOWvQrVx4qS2z2IIuzDxUPaGMp8dVA==
X-Received: by 2002:a05:6820:c2c9:10b0:6d7:4142:8b8c with SMTP id
 006d021491bc7-714f2a515ffmr4259248eaf.64.1793657529668; 
 Mon, 02 Nov 2026 14:12:09 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d354d05e0sm9796351a34.15.2026.11.02.14.12.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 14:12:09 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Cc: Simon Glass <sjg@chromium.org>
In-Reply-To: <20261017-aspeed_vbios_fixes-v3-0-961124989594@oss.tenstorrent.com>
References: <20261017-aspeed_vbios_fixes-v3-0-961124989594@oss.tenstorrent.com>
Subject: Re: [PATCH v3 0/5] Misc Fixes for VGA BIOS Emulation
Message-Id: <179365752889.536289.1095144732188149152.b4-ty@konsulko.com>
Date: Mon, 02 Nov 2026 16:12:08 -0600
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 17 Oct 2026 23:23:45 -0500, Anirudh Srinivasan wrote:

> This series contains a bunch of mischallaneous fixes to the BIOSEMU
> codebase to get display output working in u-boot using an Aspeed AST2600
> PCIE VGA card on a RISC-V system that doesn't support I/O ports. This
> was tested by passing the card through to a qemu riscv64 VM, but should
> work on any board supporting PCIe in u-boot.
> 
> v2 of this series only contains the first 5 patches from v1, which are
> misc fixes to drivers/bios_emulator. Based on the feedback from v1, the
> last 3 patches implementing a aspeed_video driver/overriding the biosemu
> functionality in a hacky manner have been dropped. This will be
> implemented in a manner where the video driver can provide custom ops
> that override biosemu's read/write calls, and will be sent in the future.
> 
> [...]

Applied to u-boot/main, thanks!

[1/5] bios_emulator: select X86EMU_RAW_IO only on x86
      commit: 8a8703d44ca1ad661aa393216ff894ee4cc0545a
[2/5] bios_emulator: Don't free a caller's BIOS image
      commit: be7542a25da8e1fb78b278d71dcfda14ca79392a
[3/5] bios_emulator: use driver-model functions for PCI config acceses
      commit: 2323c29cc2abfc25a6e8daf9f998cea9a1ad7b5c
[4/5] bios_emulator: support 16-bit reads on VGA port
      commit: f9866a5c580c9ff81c2e22c429ecae1025ff9acf
[5/5] bios_emulator: extend VGA I/O ports to include ports 0x3B4-0x3DA
      commit: 4f8b6baeb06c5ecdc44fda2f555421101d83ce3b
-- 
Tom


